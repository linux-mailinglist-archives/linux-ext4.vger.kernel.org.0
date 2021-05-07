Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A9375F0B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 05:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhEGDON (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 23:14:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53421 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229942AbhEGDOM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 23:14:12 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1473D9r7014763
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 May 2021 23:13:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B99DE15C39BD; Thu,  6 May 2021 23:13:09 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     harshadshirwadkar@gmail.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] e2fsck: fix unaligned accesses to ext4_fc_add_range and fc_raw_inode
Date:   Thu,  6 May 2021 23:13:06 -0400
Message-Id: <20210507031306.294753-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <YJSvw6oy1Rg6eIrJ@mit.edu>
References: <YJSvw6oy1Rg6eIrJ@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These fast commit related structures can be unaligned on disk.  So we
need to avoid accessing these structures directly, and first copy
them to memory which we know is appropriately aligned.

This fixes an e2fsck crash while running the j_recovery_fast_commit
regression test on a sparc64 system.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/journal.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index ae3df800..0128fbd3 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -284,7 +284,7 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 	e2fsck_t ctx = j->j_fs_dev->k_ctx;
 	struct e2fsck_fc_replay_state *state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
-	struct ext4_fc_add_range *ext;
+	struct ext4_fc_add_range ext;
 	struct ext4_fc_tl tl;
 	struct ext4_fc_tail tail;
 	__u8 *start, *cur, *end, *val;
@@ -321,9 +321,10 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 			  tag2str(le16_to_cpu(tl.fc_tag)), bh->b_blocknr);
 		switch (le16_to_cpu(tl.fc_tag)) {
 		case EXT4_FC_TAG_ADD_RANGE:
-			ext = (struct ext4_fc_add_range *)val;
-			ret = ext2fs_decode_extent(&ext2fs_ex, (void *)&ext->fc_ex,
-						   sizeof(ext->fc_ex));
+			memcpy(&ext, val, sizeof(ext));
+			ret = ext2fs_decode_extent(&ext2fs_ex,
+						   (void *)&ext.fc_ex,
+						   sizeof(ext.fc_ex));
 			if (ret)
 				ret = JBD2_FC_REPLAY_STOP;
 			else
@@ -764,12 +765,9 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, __u8 *val)
 					inode_len);
 	if (err)
 		goto out;
-#ifdef WORDS_BIGENDIAN
-	ext2fs_swap_inode_full(ctx->fs, fc_inode,
-			       (struct ext2_inode_large *)fc_raw_inode,
-			       0, sizeof(*inode));
-#else
 	memcpy(fc_inode, fc_raw_inode, inode_len);
+#ifdef WORDS_BIGENDIAN
+	ext2fs_swap_inode_full(ctx->fs, fc_inode, fc_inode, 0, inode_len);
 #endif
 	memcpy(inode, fc_inode, offsetof(struct ext2_inode_large, i_block));
 	memcpy(&inode->i_generation, &fc_inode->i_generation,
-- 
2.31.0

