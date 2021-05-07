Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430B9375DE1
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 02:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhEGAWW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 20:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhEGAWW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 20:22:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CDC061761
        for <linux-ext4@vger.kernel.org>; Thu,  6 May 2021 17:21:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v191so6368228pfc.8
        for <linux-ext4@vger.kernel.org>; Thu, 06 May 2021 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=odcUoF/kiromeCEBJAxyK4OVZvg0DwBjySkifBf+Jjo=;
        b=ezGzdflcq2g9/3Q5OamV/oycYKaBdAB+KxIf65lSj73+thwGnUoWVdrpRGAX4DhuE1
         IOUdZaaNvzXk0SzOdpUxG4FF9Vvv549GKqLVwuYRnBQEyq+pudGKW+qEpsAy3QzDmZYC
         m3E6+uj1JZHCk7Ynm45gSDDtG5UKwDhQFSG1S6FFgqOmh4adxiAZY2B8TGPtjm4JtPng
         wussvJZ0feswcaq7rYRQftY8udBOsnkoY9AvhtKylgpD2HWCXikE4eh4dJE4uFaH2Q88
         lCewCmdaUCWCw/9ER9m/1QhR+Irl0Q5WsW78UpiCDJJ/1/JcQUFj5q5/5axJ59P7kYgv
         NUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=odcUoF/kiromeCEBJAxyK4OVZvg0DwBjySkifBf+Jjo=;
        b=Df4STTHDLlKC5VcQsIUi5orb38DNVCMXYlQOd3eujyXrP+Hm252m+9dzyGNdDUaS72
         c8f9ubTpGFSOW+XXlxz651oLoGGt3chCnBE7+rAoarTgXAikVx+LMdAyttsKcx3OmFT/
         4Tu6Jmyj2LsLKZOIEWLGiX+FAwd+FSu7ft5l8FrlnPEBVqwdE91GIkxMbTuiilni36VH
         q3IYHxqQ3TToxdbm7fv1GZAlHMQoM2Kd0uAgAAXk50SkZ80LxHui8zGzmPbOlg7yTS8A
         v7yWas0kCgOgzTDGCsPvgnBoEYxsG+uH+8bLsXDD5cF7BNUPBhsXEn2Ut1wMIdLn56jb
         dGvQ==
X-Gm-Message-State: AOAM532aUNq3AoIJH+tebSfRYkANE2z5iR7doffkeNlYhv66IaznkfyG
        OJN2dVwZNgexJJtRZL0YhXFBSguqiQg=
X-Google-Smtp-Source: ABdhPJyFJWPmNFGKsS02t+CFY4ngUgb/mk0yAD53AceOJgcnxVpX4Qz5KvGjFiytXJwq7Bqf89khCA==
X-Received: by 2002:a65:6a50:: with SMTP id o16mr7137915pgu.6.1620346881952;
        Thu, 06 May 2021 17:21:21 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:18ef:ca69:5a81:5bdd])
        by smtp.googlemail.com with ESMTPSA id b7sm2824002pjq.36.2021.05.06.17.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 17:21:21 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/2] e2fsck: fix unaligned accesses to ext4_fc_tl struct
Date:   Thu,  6 May 2021 17:21:10 -0700
Message-Id: <20210507002110.3933387-2-harshads@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507002110.3933387-1-harshads@google.com>
References: <20210507002110.3933387-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Fast commit related struct ext4_fc_tl can be unaligned on disk. So,
while accessing that we should ensure that the pointers are
aligned. This patch fixes unaligned accesses to ext4_fc_tl and also
gets rid of macros fc_for_each_tl and ext4_fc_tag_val that may result
in unaligned accesses to struct ext4_fc_tl.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 debugfs/logdump.c        | 42 ++++++++++----------
 e2fsck/journal.c         | 82 +++++++++++++++++++++-------------------
 lib/ext2fs/fast_commit.h | 13 -------
 3 files changed, 65 insertions(+), 72 deletions(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 27e2e72d..6aee1a12 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -551,24 +551,28 @@ static inline size_t journal_super_tag_bytes(journal_superblock_t *jsb)
 static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
 	int transaction, int *fc_done, int dump_old)
 {
-	struct ext4_fc_tl	*tl;
+	struct ext4_fc_tl	tl;
 	struct ext4_fc_head	*head;
 	struct ext4_fc_add_range	*add_range;
 	struct ext4_fc_del_range	*del_range;
 	struct ext4_fc_dentry_info	*dentry_info;
 	struct ext4_fc_tail		*tail;
 	struct ext3_extent	*ex;
+	__u8			*cur, *val;
 
 	*fc_done = 0;
-	fc_for_each_tl(buf, buf + blocksize, tl) {
-		switch (le16_to_cpu(tl->fc_tag)) {
+	for (cur = (__u8 *)buf; cur < (__u8 *)buf + blocksize;
+	     cur = cur + sizeof(tl) + le16_to_cpu(tl.fc_len)) {
+		memcpy(&tl, cur, sizeof(tl));
+		val = cur + sizeof(tl);
+
+		switch (le16_to_cpu(tl.fc_tag)) {
 		case EXT4_FC_TAG_ADD_RANGE:
-			add_range =
-				(struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
+			add_range = (struct ext4_fc_add_range *)val;
 			ex = (struct ext3_extent *)add_range->fc_ex;
 			fprintf(out_file,
 				"tag %s, inode %d, lblk %u, pblk %llu, len %lu\n",
-				tag2str(tl->fc_tag),
+				tag2str(tl.fc_tag),
 				le32_to_cpu(add_range->fc_ino),
 				le32_to_cpu(ex->ee_block),
 				le32_to_cpu(ex->ee_start) +
@@ -578,10 +582,9 @@ static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
 				le16_to_cpu(ex->ee_len));
 			break;
 		case EXT4_FC_TAG_DEL_RANGE:
-			del_range =
-				(struct ext4_fc_del_range *)ext4_fc_tag_val(tl);
+			del_range = (struct ext4_fc_del_range *)val;
 			fprintf(out_file, "tag %s, inode %d, lblk %d, len %d\n",
-				tag2str(tl->fc_tag),
+				tag2str(tl.fc_tag),
 				le32_to_cpu(del_range->fc_ino),
 				le32_to_cpu(del_range->fc_lblk),
 				le32_to_cpu(del_range->fc_len));
@@ -589,29 +592,26 @@ static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
 		case EXT4_FC_TAG_LINK:
 		case EXT4_FC_TAG_UNLINK:
 		case EXT4_FC_TAG_CREAT:
-			dentry_info =
-				(struct ext4_fc_dentry_info *)
-					ext4_fc_tag_val(tl);
+			dentry_info = (struct ext4_fc_dentry_info *)val;
 			fprintf(out_file,
 				"tag %s, parent %d, ino %d, name \"%s\"\n",
-				tag2str(tl->fc_tag),
+				tag2str(tl.fc_tag),
 				le32_to_cpu(dentry_info->fc_parent_ino),
 				le32_to_cpu(dentry_info->fc_ino),
 				dentry_info->fc_dname);
 			break;
 		case EXT4_FC_TAG_INODE:
 			fprintf(out_file, "tag %s, inode %d\n",
-				tag2str(tl->fc_tag),
-				le32_to_cpu(((struct ext4_fc_inode *)
-					ext4_fc_tag_val(tl))->fc_ino));
+				tag2str(tl.fc_tag),
+				le32_to_cpu(((struct ext4_fc_inode *)val)->fc_ino));
 			break;
 		case EXT4_FC_TAG_PAD:
-			fprintf(out_file, "tag %s\n", tag2str(tl->fc_tag));
+			fprintf(out_file, "tag %s\n", tag2str(tl.fc_tag));
 			break;
 		case EXT4_FC_TAG_TAIL:
-			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
+			tail = (struct ext4_fc_tail *)val;
 			fprintf(out_file, "tag %s, tid %d\n",
-				tag2str(tl->fc_tag),
+				tag2str(tl.fc_tag),
 				le32_to_cpu(tail->fc_tid));
 			if (!dump_old &&
 				le32_to_cpu(tail->fc_tid) < transaction) {
@@ -621,9 +621,9 @@ static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
 			break;
 		case EXT4_FC_TAG_HEAD:
 			fprintf(out_file, "\n*** Fast Commit Area ***\n");
-			head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
+			head = (struct ext4_fc_head *)val;
 			fprintf(out_file, "tag %s, features 0x%x, tid %d\n",
-				tag2str(tl->fc_tag),
+				tag2str(tl.fc_tag),
 				le32_to_cpu(head->fc_features),
 				le32_to_cpu(head->fc_tid));
 			if (!dump_old &&
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index bd0e4f31..ae3df800 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -285,9 +285,9 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 	struct e2fsck_fc_replay_state *state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_add_range *ext;
-	struct ext4_fc_tl *tl;
+	struct ext4_fc_tl tl;
 	struct ext4_fc_tail tail;
-	__u8 *start, *end;
+	__u8 *start, *cur, *end, *val;
 	struct ext4_fc_head head;
 	struct ext2fs_extent ext2fs_ex = {0};
 
@@ -313,12 +313,15 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 	}
 
 	state->fc_replay_expected_off++;
-	fc_for_each_tl(start, end, tl) {
+	for (cur = start; cur < end; cur = cur + le16_to_cpu(tl.fc_len) + sizeof(tl)) {
+		memcpy(&tl, cur, sizeof(tl));
+		val = cur + sizeof(tl);
+
 		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
-			  tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
-		switch (le16_to_cpu(tl->fc_tag)) {
+			  tag2str(le16_to_cpu(tl.fc_tag)), bh->b_blocknr);
+		switch (le16_to_cpu(tl.fc_tag)) {
 		case EXT4_FC_TAG_ADD_RANGE:
-			ext = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
+			ext = (struct ext4_fc_add_range *)val;
 			ret = ext2fs_decode_extent(&ext2fs_ex, (void *)&ext->fc_ex,
 						   sizeof(ext->fc_ex));
 			if (ret)
@@ -333,14 +336,14 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 		case EXT4_FC_TAG_INODE:
 		case EXT4_FC_TAG_PAD:
 			state->fc_cur_tag++;
-			state->fc_crc = jbd2_chksum(j, state->fc_crc, tl,
-					sizeof(*tl) + ext4_fc_tag_len(tl));
+			state->fc_crc = jbd2_chksum(j, state->fc_crc, cur,
+					sizeof(tl) + ext4_fc_tag_len(&tl));
 			break;
 		case EXT4_FC_TAG_TAIL:
 			state->fc_cur_tag++;
-			memcpy(&tail, ext4_fc_tag_val(tl), sizeof(tail));
-			state->fc_crc = jbd2_chksum(j, state->fc_crc, tl,
-						sizeof(*tl) +
+			memcpy(&tail, val, sizeof(tail));
+			state->fc_crc = jbd2_chksum(j, state->fc_crc, cur,
+						sizeof(tl) +
 						offsetof(struct ext4_fc_tail,
 						fc_crc));
 			jbd_debug(1, "tail tid %d, expected %d\n",
@@ -355,7 +358,7 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 			state->fc_crc = 0;
 			break;
 		case EXT4_FC_TAG_HEAD:
-			memcpy(&head, ext4_fc_tag_val(tl), sizeof(head));
+			memcpy(&head, val, sizeof(head));
 			if (le32_to_cpu(head.fc_features) &
 			    ~EXT4_FC_SUPPORTED_FEATURES) {
 				ret = -EOPNOTSUPP;
@@ -366,8 +369,8 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 				break;
 			}
 			state->fc_cur_tag++;
-			state->fc_crc = jbd2_chksum(j, state->fc_crc, tl,
-					sizeof(*tl) + ext4_fc_tag_len(tl));
+			state->fc_crc = jbd2_chksum(j, state->fc_crc, cur,
+					sizeof(tl) + ext4_fc_tag_len(&tl));
 			break;
 		default:
 			ret = state->fc_replay_num_tags ?
@@ -612,12 +615,12 @@ struct dentry_info_args {
 };
 
 static inline int tl_to_darg(struct dentry_info_args *darg,
-				struct  ext4_fc_tl *tl)
+			     struct  ext4_fc_tl *tl, __u8 *val)
 {
 	struct ext4_fc_dentry_info fcd;
 	int tag = le16_to_cpu(tl->fc_tag);
 
-	memcpy(&fcd, ext4_fc_tag_val(tl), sizeof(fcd));
+	memcpy(&fcd, val, sizeof(fcd));
 
 	darg->parent_ino = le32_to_cpu(fcd.fc_parent_ino);
 	darg->ino = le32_to_cpu(fcd.fc_ino);
@@ -627,7 +630,7 @@ static inline int tl_to_darg(struct dentry_info_args *darg,
 	if (!darg->dname)
 		return -ENOMEM;
 	memcpy(darg->dname,
-	       ext4_fc_tag_val(tl) + sizeof(struct ext4_fc_dentry_info),
+	       val + sizeof(struct ext4_fc_dentry_info),
 	       darg->dname_len);
 	darg->dname[darg->dname_len] = 0;
 	jbd_debug(1, "%s: %s, ino %d, parent %d\n",
@@ -638,14 +641,14 @@ static inline int tl_to_darg(struct dentry_info_args *darg,
 	return 0;
 }
 
-static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl)
+static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl, __u8 *val)
 {
 	struct ext2_inode inode;
 	struct dentry_info_args darg;
 	ext2_filsys fs = ctx->fs;
 	int ret;
 
-	ret = tl_to_darg(&darg, tl);
+	ret = tl_to_darg(&darg, tl, val);
 	if (ret)
 		return ret;
 	ext4_fc_flush_extents(ctx, darg.ino);
@@ -657,14 +660,14 @@ static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	return ret;
 }
 
-static int ext4_fc_handle_link_and_create(e2fsck_t ctx, struct ext4_fc_tl *tl)
+static int ext4_fc_handle_link_and_create(e2fsck_t ctx, struct ext4_fc_tl *tl, __u8 *val)
 {
 	struct dentry_info_args darg;
 	ext2_filsys fs = ctx->fs;
 	struct ext2_inode_large inode_large;
 	int ret, filetype, mode;
 
-	ret = tl_to_darg(&darg, tl);
+	ret = tl_to_darg(&darg, tl, val);
 	if (ret)
 		return ret;
 	ext4_fc_flush_extents(ctx, 0);
@@ -732,7 +735,7 @@ static void ext4_fc_replay_fixup_iblocks(struct ext2_inode_large *ondisk_inode,
 	}
 }
 
-static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
+static int ext4_fc_handle_inode(e2fsck_t ctx, __u8 *val)
 {
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ino, inode_len = EXT2_GOOD_OLD_INODE_SIZE;
@@ -742,8 +745,8 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	errcode_t err;
 	blk64_t blks;
 
-	memcpy(&fc_ino, ext4_fc_tag_val(tl), sizeof(fc_ino));
-	fc_raw_inode = ext4_fc_tag_val(tl) + sizeof(fc_ino);
+	memcpy(&fc_ino, val, sizeof(fc_ino));
+	fc_raw_inode = val + sizeof(fc_ino);
 	ino = le32_to_cpu(fc_ino);
 
 	if (EXT2_INODE_SIZE(ctx->fs->super) > EXT2_GOOD_OLD_INODE_SIZE)
@@ -797,13 +800,13 @@ out:
 /*
  * Handle add extent replay tag.
  */
-static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
+static int ext4_fc_handle_add_extent(e2fsck_t ctx, __u8 *val)
 {
 	struct ext2fs_extent extent;
 	struct ext4_fc_add_range add_range;
 	int ret = 0, ino;
 
-	memcpy(&add_range, ext4_fc_tag_val(tl), sizeof(add_range));
+	memcpy(&add_range, val, sizeof(add_range));
 	ino = le32_to_cpu(add_range.fc_ino);
 	ext4_fc_flush_extents(ctx, ino);
 
@@ -823,13 +826,13 @@ static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
 /*
  * Handle delete logical range replay tag.
  */
-static int ext4_fc_handle_del_range(e2fsck_t ctx, struct ext4_fc_tl *tl)
+static int ext4_fc_handle_del_range(e2fsck_t ctx, __u8 *val)
 {
 	struct ext2fs_extent extent;
 	struct ext4_fc_del_range del_range;
 	int ret, ino;
 
-	memcpy(&del_range, ext4_fc_tag_val(tl), sizeof(del_range));
+	memcpy(&del_range, val, sizeof(del_range));
 	ino = le32_to_cpu(del_range.fc_ino);
 	ext4_fc_flush_extents(ctx, ino);
 
@@ -854,8 +857,8 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	e2fsck_t ctx = journal->j_fs_dev->k_ctx;
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
-	struct ext4_fc_tl *tl;
-	__u8 *start, *end;
+	struct ext4_fc_tl tl;
+	__u8 *start, *end, *cur, *val;
 
 	if (pass == PASS_SCAN) {
 		state->fc_current_pass = PASS_SCAN;
@@ -891,28 +894,31 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	start = (__u8 *)bh->b_data;
 	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
 
-	fc_for_each_tl(start, end, tl) {
+	for (cur = start; cur < end; cur = cur + le16_to_cpu(tl.fc_len) + sizeof(tl)) {
+		memcpy(&tl, cur, sizeof(tl));
+		val = cur + sizeof(tl);
+
 		if (state->fc_replay_num_tags == 0)
 			goto replay_done;
 		jbd_debug(3, "Replay phase processing %s tag\n",
-				tag2str(le16_to_cpu(tl->fc_tag)));
+				tag2str(le16_to_cpu(tl.fc_tag)));
 		state->fc_replay_num_tags--;
-		switch (le16_to_cpu(tl->fc_tag)) {
+		switch (le16_to_cpu(tl.fc_tag)) {
 		case EXT4_FC_TAG_CREAT:
 		case EXT4_FC_TAG_LINK:
-			ret = ext4_fc_handle_link_and_create(ctx, tl);
+			ret = ext4_fc_handle_link_and_create(ctx, &tl, val);
 			break;
 		case EXT4_FC_TAG_UNLINK:
-			ret = ext4_fc_handle_unlink(ctx, tl);
+			ret = ext4_fc_handle_unlink(ctx, &tl, val);
 			break;
 		case EXT4_FC_TAG_ADD_RANGE:
-			ret = ext4_fc_handle_add_extent(ctx, tl);
+			ret = ext4_fc_handle_add_extent(ctx, val);
 			break;
 		case EXT4_FC_TAG_DEL_RANGE:
-			ret = ext4_fc_handle_del_range(ctx, tl);
+			ret = ext4_fc_handle_del_range(ctx, val);
 			break;
 		case EXT4_FC_TAG_INODE:
-			ret = ext4_fc_handle_inode(ctx, tl);
+			ret = ext4_fc_handle_inode(ctx, val);
 			break;
 		case EXT4_FC_TAG_TAIL:
 			ext4_fc_flush_extents(ctx, 0);
diff --git a/lib/ext2fs/fast_commit.h b/lib/ext2fs/fast_commit.h
index b83e1810..4ad38f12 100644
--- a/lib/ext2fs/fast_commit.h
+++ b/lib/ext2fs/fast_commit.h
@@ -155,13 +155,6 @@ struct ext4_fc_replay_state {
 #define region_last(__region) (((__region)->lblk) + ((__region)->len) - 1)
 #endif
 
-#define fc_for_each_tl(__start, __end, __tl)				\
-	for (tl = (struct ext4_fc_tl *)(__start);			\
-	     (__u8 *)tl < (__u8 *)(__end);				\
-		tl = (struct ext4_fc_tl *)((__u8 *)tl +			\
-					sizeof(struct ext4_fc_tl) +	\
-					+ le16_to_cpu(tl->fc_len)))
-
 static inline const char *tag2str(__u16 tag)
 {
 	switch (tag) {
@@ -194,10 +187,4 @@ static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
 	return le16_to_cpu(tl->fc_len);
 }
 
-/* Get a pointer to "value" of a tlv */
-static inline __u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
-{
-	return (__u8 *)tl + sizeof(*tl);
-}
-
 #endif /* __FAST_COMMIT_H__ */
-- 
2.31.1.607.g51e8a6a459-goog

