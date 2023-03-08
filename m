Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12546AFDC6
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCHEQ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHEQ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:16:28 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C916AFC
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:16:25 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284GKfn014398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678248982; bh=QetiSwVZpn4hAlZkMMs7/f6Eq5AobWlShaVPBkNSG8A=;
        h=From:To:Cc:Subject:Date;
        b=O/aMpdpK8CUZHEXFkjU7iL81YZJDxfmJZbNASMvwU4s/AiVvJ2u2MbDz8ItFU0sSU
         VDeFynFKjdBV4qv1v8bIPCUCEmqGsk1kt1HCfCqQDhoDjCZ72aClp3GDMorAdYjNxE
         oKIeINKewLhRJuRvMslZWUVws2eKe1dbCdguCQSAd2J+lyKU3udr6pVog0z/xfvtPr
         QKP8cm6c0o1XV6Q9Gop3W1OEnsBFoL7/Tknolrau+WRVkKsNbeh3ACnZvezFKBTo7Y
         8LC+ug3VITC23ZKl4xIq3E/x81166graqZQwVIs6gpTEIrzO8j2NJDhZLIUgo7LAeX
         mF/UfgDfpbjvg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A2E5315C3441; Tue,  7 Mar 2023 23:16:20 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4, jbd2: add an optimized bmap for the journal inode
Date:   Tue,  7 Mar 2023 23:16:15 -0500
Message-Id: <20230308041615.2121699-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The generic bmap() function exported by the VFS takes locks and does
checks that are not necessary for the journal inode.  So allow the
file system to set a journal-optimized bmap function in
journal->j_bmap.

The also has the benefit of avoiding some false positives by DEPT.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c      | 23 +++++++++++++++++++++++
 fs/jbd2/journal.c    |  9 ++++++---
 include/linux/jbd2.h |  8 ++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2192b4111442..46b7345d2b6a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5742,6 +5742,28 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 	return journal_inode;
 }
 
+static int ext4_journal_bmap(journal_t *journal, sector_t *block)
+{
+	struct ext4_map_blocks map;
+	int ret;
+
+	if (journal->j_inode == NULL)
+		return 0;
+
+	map.m_lblk = *block;
+	map.m_len = 1;
+	ret = ext4_map_blocks(NULL, journal->j_inode, &map, 0);
+	if (ret <= 0) {
+		ext4_msg(journal->j_inode->i_sb, KERN_CRIT,
+			 "journal bmap failed: block %llu ret %d\n",
+			 *block, ret);
+		jbd2_journal_abort(journal, ret ? ret : -EIO);
+		return ret;
+	}
+	*block = map.m_pblk;
+	return 0;
+}
+
 static journal_t *ext4_get_journal(struct super_block *sb,
 				   unsigned int journal_inum)
 {
@@ -5762,6 +5784,7 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 		return NULL;
 	}
 	journal->j_private = sb;
+	journal->j_bmap = ext4_journal_bmap;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 }
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2696f43e7239..c84f588fdcd0 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -970,10 +970,13 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
 {
 	int err = 0;
 	unsigned long long ret;
-	sector_t block = 0;
+	sector_t block = blocknr;
 
-	if (journal->j_inode) {
-		block = blocknr;
+	if (journal->j_bmap) {
+		err = journal->j_bmap(journal, &block);
+		if (err == 0)
+			*retp = block;
+	} else if (journal->j_inode) {
 		ret = bmap(journal->j_inode, &block);
 
 		if (ret || !block) {
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 2170e0cc279d..6ffa34c51a11 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1308,6 +1308,14 @@ struct journal_s
 				    struct buffer_head *bh,
 				    enum passtype pass, int off,
 				    tid_t expected_commit_id);
+
+	/**
+	 * @j_bmap:
+	 *
+	 * Bmap function that should be used instead of the generic
+	 * VFS bmap function.
+	 */
+	int (*j_bmap)(struct journal_s *journal, sector_t *block);
 };
 
 #define jbd2_might_wait_for_commit(j) \
-- 
2.31.0

