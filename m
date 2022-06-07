Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDD053F51A
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiFGEZp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiFGEZn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB83B82C8
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PR2e005546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575929; bh=qDIKYBOA1iGCBdTK+JPA+trewXn30jhxeIAxfiC9Un4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VVL38l9OBdPi/Wjd4KBRbN+wMcjxNS3D7l1BJ5Sq98k5/Q5oTvivhTNmDvDgZenmo
         0OkQbshslPyq2wUpxaBR9n4P5dR0zgIykZy9mg7QR6RYq+d1JO1HGNSwoKMcFdAnAp
         flvYiMj/4dmdBQmPFBJaWQ/qS6uvh4Lq9H4UDFWTBnjvfgzw2SLRQVjSkMcNEPZmii
         O648e22GbhsD4eTXFFG4a7GlTJryb6zQI/GcwkAQF8dn1vCXjMKDZvVPqw4ZYw4QQI
         PyFATLuJhJkm1m7Zwjanrw36CKr80P3d728zPAzF1jZGtAMJmVoDO86VqhPIyG24ha
         bnIhbFkG2uqmw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BE57515C3E21; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/7] e2fsck: sanity check the journal inode number
Date:   Tue,  7 Jun 2022 00:24:38 -0400
Message-Id: <20220607042444.1798015-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220607042444.1798015-1-tytso@mit.edu>
References: <20220607042444.1798015-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

E2fsck replays the journal before sanity checking the full superblock.
So it's possible that the journal inode number is not valid relative
to the number of block groups.  So to avoid potentially an array
bounds overrun, sanity check this before trying to find the journal
inode.

Reported-by: Nils Bars <nils.bars@rub.de>
Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
Reported-by: Nico Schiller <nico.schiller@rub.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/journal.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 2e867234..12487e3d 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -989,7 +989,14 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 	journal->j_blocksize = ctx->fs->blocksize;
 
 	if (uuid_is_null(sb->s_journal_uuid)) {
-		if (!sb->s_journal_inum) {
+		/*
+		 * The full set of superblock sanity checks haven't
+		 * been performed yet, so we need to do some basic
+		 * checks here to avoid potential array overruns.
+		 */
+		if (!sb->s_journal_inum ||
+		    (sb->s_journal_inum >
+		     (ctx->fs->group_desc_count * sb->s_inodes_per_group))) {
 			retval = EXT2_ET_BAD_INODE_NUM;
 			goto errout;
 		}
-- 
2.31.0

