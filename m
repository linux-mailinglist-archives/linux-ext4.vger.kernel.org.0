Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA97890AE
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Aug 2023 23:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHYVqW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Aug 2023 17:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjHYVqM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Aug 2023 17:46:12 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548726AF
        for <linux-ext4@vger.kernel.org>; Fri, 25 Aug 2023 14:46:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37PLjwrq017179
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 17:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692999959; bh=bZiww4kl8IgM3OVMGYjgZQjIxV+4b/vS7E3XpxFMD14=;
        h=From:Subject:Date:Message-Id:MIME-Version;
        b=PFhoCN1PKjXftK0ht4eqSDPxslyajJ9aEFzfdKDg6QJ7jkwLxzYMZHEdHqaXLJsk0
         cALd3m3E4i0bQpMvfe6B8uYguvPWRzzD7mMQQPtFmNcVp/gPQDgN2gMbV+5RBnag7R
         xCY0NRulVPjwNUdMATOP9KzAiE4v+yu6je3dDxVsx4NfqQnLKWkGlUwplcF0MraXyp
         RTjjuL3/5UkZAe5JDnzE9FuescXMEEJRWzG74zjEN8TVTJonf+c9jZHuOpnytOfV12
         q+1M69O3ikqbZmoxzpAdPmQzZpxSTGNAn6/hmn3QHg99OWetWCspWwYTMIWRPtc98d
         aT8bd5HpPVyJg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1C05915C027F; Fri, 25 Aug 2023 17:45:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Eric Whitney <enwlinux@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] libext2fs: don't truncate the orphan file inode if it is newly allocated
Date:   Fri, 25 Aug 2023 17:45:51 -0400
Message-Id: <20230825214551.136149-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext2fs_create_orphan_file(), don't try truncating inode for the
orphan file if ext2fs_create_orphan_file() allocated the inode.  This
avoids problems where the newly allocated inode in the inode table
might contain garbage; if the metadata checksum feature is enabled,
this will generally result in the function failing with a checksum
invalid error, but this can cause mke2fs (which calls
ext2fs_create_orphan_file) to fail.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/orphan.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
index e25f20ca2..c2f83567f 100644
--- a/lib/ext2fs/orphan.c
+++ b/lib/ext2fs/orphan.c
@@ -127,22 +127,21 @@ errcode_t ext2fs_create_orphan_file(ext2_filsys fs, blk_t num_blocks)
 	struct mkorphan_info oi;
 	struct ext4_orphan_block_tail *ob_tail;
 
-	if (!ino) {
+	if (ino) {
+		err = ext2fs_read_inode(fs, ino, &inode);
+		if (err)
+			return err;
+		if (EXT2_I_SIZE(&inode)) {
+			err = ext2fs_truncate_orphan_file(fs);
+			if (err)
+				return err;
+		}
+	} else {
 		err = ext2fs_new_inode(fs, EXT2_ROOT_INO, LINUX_S_IFREG | 0600,
 				       0, &ino);
 		if (err)
 			return err;
 		ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
-		ext2fs_mark_ib_dirty(fs);
-	}
-
-	err = ext2fs_read_inode(fs, ino, &inode);
-	if (err)
-		return err;
-	if (EXT2_I_SIZE(&inode)) {
-		err = ext2fs_truncate_orphan_file(fs);
-		if (err)
-			return err;
 	}
 
 	memset(&inode, 0, sizeof(struct ext2_inode));
-- 
2.31.0

