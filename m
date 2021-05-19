Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5F3898FE
	for <lists+linux-ext4@lfdr.de>; Wed, 19 May 2021 23:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhESWAr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 May 2021 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESWAq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 May 2021 18:00:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A8C061574
        for <linux-ext4@vger.kernel.org>; Wed, 19 May 2021 14:59:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso3535536pjq.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 May 2021 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoV86t0GewfJK2tovaq5UdOE0ya/oWbGVFgsGaluL/0=;
        b=Z19fLLqt2pL+RpNmAABMRin+Fd3wdKdyRT47iAUbwv/cCb2uJO/XjxASHFsG5XvzsO
         ghXgzk1ETjYBgB5sShxT60hbTeNqFXShtvfvY+ZZPoQnZhzPVNY9FdrWWZ/SH8Fi5q70
         2YnsOxwVHyEiJd9f5RS66flT5dRjY5GtZt6bbEMF1U9XXck/Q8/8XYpaHwwgsruuc3s8
         j/Cd5GtYlD5W27MMWUYxJ25tDE2cEL0XevUp5bBH6jZOjXZc+Z+4tt4LqKpnQyr7ZEF+
         7FGQ55qy/Sqj7qNvwjkKyvH2xuCpjww0jeweMHib7E7r02wGUBcRoZryL4mq857EdtqK
         8UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XoV86t0GewfJK2tovaq5UdOE0ya/oWbGVFgsGaluL/0=;
        b=COmksujsbeMcMtUCNqFeNsGA7g804DMEV9H5NLH5kY0A77LS++oYliekPuDVeEL2zs
         x0uOQpHVSYRWbSIVcTba5ID46APuWZON2qyHydiFuDOA/yAqI9rCOqBWKHY7FNvjp4Pc
         cwi0JJRKFI9AiMIJ5y2zVcL0lXjmiRZhHsxgnqZ087wH1OLkexyJfHTBNCVpsvIef+1b
         ZiCFrni6LAT5nm5dXGXcwDd4ASux+F1tWgrSgGKrXrDZEUqm4tEqspkNfA8InDq7iZq8
         49OUjTmNWgSdte/ZcM8JjuJ4lx/LUj0wr9CkI8OUZ7qwP8U+/Tij1MvwFvAz9YDP8Yb1
         I/BA==
X-Gm-Message-State: AOAM532Ilp0mWP4IJyia1j5i2UzBYtQi8T6JTU7BRJXq5asB7U1bIAtp
        qMIJqbN8jzXZ6IAPdNVGIOMP/ywUTZI=
X-Google-Smtp-Source: ABdhPJwEsTLbc7diTguL2ZsFIb3sFzJ9CEYHN6ckkwmBEyBA1d/1pJV68gXfHl3NOd5M74bGQo3aKw==
X-Received: by 2002:a17:90a:62c1:: with SMTP id k1mr1506345pjs.151.1621461565345;
        Wed, 19 May 2021 14:59:25 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6bfc:c6ae:27b3:bf3a])
        by smtp.googlemail.com with ESMTPSA id p17sm68546pjg.54.2021.05.19.14.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:59:24 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: fix fast commit alignment issues
Date:   Wed, 19 May 2021 14:59:20 -0700
Message-Id: <20210519215920.2037527-1-harshads@google.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Fast commit recovery data on disk may not be aligned. So, when the
recovery code reads it, this patch makes sure that fast commit info
found on-disk is first memcpy-ed into an aligned variable before
accessing it. As a consequence of it, we also remove some macros that
could resulted in unaligned accesses.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 170 ++++++++++++++++++++++--------------------
 fs/ext4/fast_commit.h |  19 -----
 2 files changed, 90 insertions(+), 99 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f98ca4f37ef6..e8195229c252 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1288,28 +1288,29 @@ struct dentry_info_args {
 };
 
 static inline void tl_to_darg(struct dentry_info_args *darg,
-				struct  ext4_fc_tl *tl)
+			      struct  ext4_fc_tl *tl, u8 *val)
 {
-	struct ext4_fc_dentry_info *fcd;
+	struct ext4_fc_dentry_info fcd;
 
-	fcd = (struct ext4_fc_dentry_info *)ext4_fc_tag_val(tl);
+	memcpy(&fcd, val, sizeof(fcd));
 
-	darg->parent_ino = le32_to_cpu(fcd->fc_parent_ino);
-	darg->ino = le32_to_cpu(fcd->fc_ino);
-	darg->dname = fcd->fc_dname;
-	darg->dname_len = ext4_fc_tag_len(tl) -
-			sizeof(struct ext4_fc_dentry_info);
+	darg->parent_ino = le32_to_cpu(fcd.fc_parent_ino);
+	darg->ino = le32_to_cpu(fcd.fc_ino);
+	darg->dname = val + offsetof(struct ext4_fc_dentry_info, fc_dname);
+	darg->dname_len = le16_to_cpu(tl->fc_len) -
+		sizeof(struct ext4_fc_dentry_info);
 }
 
 /* Unlink replay function */
-static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl,
+				 u8 *val)
 {
 	struct inode *inode, *old_parent;
 	struct qstr entry;
 	struct dentry_info_args darg;
 	int ret = 0;
 
-	tl_to_darg(&darg, tl);
+	tl_to_darg(&darg, tl, val);
 
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_UNLINK, darg.ino,
 			darg.parent_ino, darg.dname_len);
@@ -1399,13 +1400,14 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 }
 
 /* Link replay function */
-static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl,
+			       u8 *val)
 {
 	struct inode *inode;
 	struct dentry_info_args darg;
 	int ret = 0;
 
-	tl_to_darg(&darg, tl);
+	tl_to_darg(&darg, tl, val);
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_LINK, darg.ino,
 			darg.parent_ino, darg.dname_len);
 
@@ -1450,9 +1452,10 @@ static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
 /*
  * Inode replay function
  */
-static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl,
+				u8 *val)
 {
-	struct ext4_fc_inode *fc_inode;
+	struct ext4_fc_inode fc_inode;
 	struct ext4_inode *raw_inode;
 	struct ext4_inode *raw_fc_inode;
 	struct inode *inode = NULL;
@@ -1460,9 +1463,9 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
 	int inode_len, ino, ret, tag = le16_to_cpu(tl->fc_tag);
 	struct ext4_extent_header *eh;
 
-	fc_inode = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
+	memcpy(&fc_inode, val, sizeof(fc_inode));
 
-	ino = le32_to_cpu(fc_inode->fc_ino);
+	ino = le32_to_cpu(fc_inode.fc_ino);
 	trace_ext4_fc_replay(sb, tag, ino, 0, 0);
 
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
@@ -1474,12 +1477,13 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	ext4_fc_record_modified_inode(sb, ino);
 
-	raw_fc_inode = (struct ext4_inode *)fc_inode->fc_raw_inode;
+	raw_fc_inode = (struct ext4_inode *)
+		(val + offsetof(struct ext4_fc_inode, fc_raw_inode));
 	ret = ext4_get_fc_inode_loc(sb, ino, &iloc);
 	if (ret)
 		goto out;
 
-	inode_len = ext4_fc_tag_len(tl) - sizeof(struct ext4_fc_inode);
+	inode_len = le16_to_cpu(tl->fc_len) - sizeof(struct ext4_fc_inode);
 	raw_inode = ext4_raw_inode(&iloc);
 
 	memcpy(raw_inode, raw_fc_inode, offsetof(struct ext4_inode, i_block));
@@ -1547,14 +1551,15 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
  * inode for which we are trying to create a dentry here, should already have
  * been replayed before we start here.
  */
-static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
+				 u8 *val)
 {
 	int ret = 0;
 	struct inode *inode = NULL;
 	struct inode *dir = NULL;
 	struct dentry_info_args darg;
 
-	tl_to_darg(&darg, tl);
+	tl_to_darg(&darg, tl, val);
 
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_CREAT, darg.ino,
 			darg.parent_ino, darg.dname_len);
@@ -1633,9 +1638,9 @@ static int ext4_fc_record_regions(struct super_block *sb, int ino,
 
 /* Replay add range tag */
 static int ext4_fc_replay_add_range(struct super_block *sb,
-				struct ext4_fc_tl *tl)
+				    struct ext4_fc_tl *tl, u8 *val)
 {
-	struct ext4_fc_add_range *fc_add_ex;
+	struct ext4_fc_add_range fc_add_ex;
 	struct ext4_extent newex, *ex;
 	struct inode *inode;
 	ext4_lblk_t start, cur;
@@ -1645,15 +1650,14 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	struct ext4_ext_path *path = NULL;
 	int ret;
 
-	fc_add_ex = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
-	ex = (struct ext4_extent *)&fc_add_ex->fc_ex;
+	memcpy(&fc_add_ex, val, sizeof(fc_add_ex));
+	ex = (struct ext4_extent *)&fc_add_ex.fc_ex;
 
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_ADD_RANGE,
-		le32_to_cpu(fc_add_ex->fc_ino), le32_to_cpu(ex->ee_block),
+		le32_to_cpu(fc_add_ex.fc_ino), le32_to_cpu(ex->ee_block),
 		ext4_ext_get_actual_len(ex));
 
-	inode = ext4_iget(sb, le32_to_cpu(fc_add_ex->fc_ino),
-				EXT4_IGET_NORMAL);
+	inode = ext4_iget(sb, le32_to_cpu(fc_add_ex.fc_ino), EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		jbd_debug(1, "Inode not found.");
 		return 0;
@@ -1762,32 +1766,33 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 /* Replay DEL_RANGE tag */
 static int
-ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
+ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
+			 u8 *val)
 {
 	struct inode *inode;
-	struct ext4_fc_del_range *lrange;
+	struct ext4_fc_del_range lrange;
 	struct ext4_map_blocks map;
 	ext4_lblk_t cur, remaining;
 	int ret;
 
-	lrange = (struct ext4_fc_del_range *)ext4_fc_tag_val(tl);
-	cur = le32_to_cpu(lrange->fc_lblk);
-	remaining = le32_to_cpu(lrange->fc_len);
+	memcpy(&lrange, val, sizeof(lrange));
+	cur = le32_to_cpu(lrange.fc_lblk);
+	remaining = le32_to_cpu(lrange.fc_len);
 
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_DEL_RANGE,
-		le32_to_cpu(lrange->fc_ino), cur, remaining);
+		le32_to_cpu(lrange.fc_ino), cur, remaining);
 
-	inode = ext4_iget(sb, le32_to_cpu(lrange->fc_ino), EXT4_IGET_NORMAL);
+	inode = ext4_iget(sb, le32_to_cpu(lrange.fc_ino), EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode %d not found", le32_to_cpu(lrange->fc_ino));
+		jbd_debug(1, "Inode %d not found", le32_to_cpu(lrange.fc_ino));
 		return 0;
 	}
 
 	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
 
 	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
-			inode->i_ino, le32_to_cpu(lrange->fc_lblk),
-			le32_to_cpu(lrange->fc_len));
+			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
+			le32_to_cpu(lrange.fc_len));
 	while (remaining > 0) {
 		map.m_lblk = cur;
 		map.m_len = remaining;
@@ -1808,8 +1813,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
 	}
 
 	ret = ext4_punch_hole(inode,
-		le32_to_cpu(lrange->fc_lblk) << sb->s_blocksize_bits,
-		le32_to_cpu(lrange->fc_len) <<  sb->s_blocksize_bits);
+		le32_to_cpu(lrange.fc_lblk) << sb->s_blocksize_bits,
+		le32_to_cpu(lrange.fc_len) <<  sb->s_blocksize_bits);
 	if (ret)
 		jbd_debug(1, "ext4_punch_hole returned %d", ret);
 	ext4_ext_replay_shrink_inode(inode,
@@ -1925,11 +1930,11 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_fc_replay_state *state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
-	struct ext4_fc_add_range *ext;
-	struct ext4_fc_tl *tl;
-	struct ext4_fc_tail *tail;
-	__u8 *start, *end;
-	struct ext4_fc_head *head;
+	struct ext4_fc_add_range ext;
+	struct ext4_fc_tl tl;
+	struct ext4_fc_tail tail;
+	__u8 *start, *end, *cur, *val;
+	struct ext4_fc_head head;
 	struct ext4_extent *ex;
 
 	state = &sbi->s_fc_replay_state;
@@ -1956,15 +1961,17 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	}
 
 	state->fc_replay_expected_off++;
-	fc_for_each_tl(start, end, tl) {
+	for (cur = start; cur < end; cur = cur + sizeof(tl) + le16_to_cpu(tl.fc_len)) {
+		memcpy(&tl, cur, sizeof(tl));
+		val = cur + sizeof(tl);
 		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
-			  tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
-		switch (le16_to_cpu(tl->fc_tag)) {
+			  tag2str(le16_to_cpu(tl.fc_tag)), bh->b_blocknr);
+		switch (le16_to_cpu(tl.fc_tag)) {
 		case EXT4_FC_TAG_ADD_RANGE:
-			ext = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
-			ex = (struct ext4_extent *)&ext->fc_ex;
+			memcpy(&ext, val, sizeof(ext));
+			ex = (struct ext4_extent *)&ext.fc_ex;
 			ret = ext4_fc_record_regions(sb,
-				le32_to_cpu(ext->fc_ino),
+				le32_to_cpu(ext.fc_ino),
 				le32_to_cpu(ex->ee_block), ext4_ext_pblock(ex),
 				ext4_ext_get_actual_len(ex));
 			if (ret < 0)
@@ -1978,18 +1985,18 @@ static int ext4_fc_replay_scan(journal_t *journal,
 		case EXT4_FC_TAG_INODE:
 		case EXT4_FC_TAG_PAD:
 			state->fc_cur_tag++;
-			state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
-					sizeof(*tl) + ext4_fc_tag_len(tl));
+			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
+					sizeof(tl) + le16_to_cpu(tl.fc_len));
 			break;
 		case EXT4_FC_TAG_TAIL:
 			state->fc_cur_tag++;
-			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
-			state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
-						sizeof(*tl) +
+			memcpy(&tail, val, sizeof(tail));
+			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
+						sizeof(tl) +
 						offsetof(struct ext4_fc_tail,
 						fc_crc));
-			if (le32_to_cpu(tail->fc_tid) == expected_tid &&
-				le32_to_cpu(tail->fc_crc) == state->fc_crc) {
+			if (le32_to_cpu(tail.fc_tid) == expected_tid &&
+				le32_to_cpu(tail.fc_crc) == state->fc_crc) {
 				state->fc_replay_num_tags = state->fc_cur_tag;
 				state->fc_regions_valid =
 					state->fc_regions_used;
@@ -2000,19 +2007,19 @@ static int ext4_fc_replay_scan(journal_t *journal,
 			state->fc_crc = 0;
 			break;
 		case EXT4_FC_TAG_HEAD:
-			head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
-			if (le32_to_cpu(head->fc_features) &
+			memcpy(&head, val, sizeof(head));
+			if (le32_to_cpu(head.fc_features) &
 				~EXT4_FC_SUPPORTED_FEATURES) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
-			if (le32_to_cpu(head->fc_tid) != expected_tid) {
+			if (le32_to_cpu(head.fc_tid) != expected_tid) {
 				ret = JBD2_FC_REPLAY_STOP;
 				break;
 			}
 			state->fc_cur_tag++;
-			state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
-					sizeof(*tl) + ext4_fc_tag_len(tl));
+			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
+					    sizeof(tl) + le16_to_cpu(tl.fc_len));
 			break;
 		default:
 			ret = state->fc_replay_num_tags ?
@@ -2036,11 +2043,11 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_fc_tl *tl;
-	__u8 *start, *end;
+	struct ext4_fc_tl tl;
+	__u8 *start, *end, *cur, *val;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_replay_state *state = &sbi->s_fc_replay_state;
-	struct ext4_fc_tail *tail;
+	struct ext4_fc_tail tail;
 
 	if (pass == PASS_SCAN) {
 		state->fc_current_pass = PASS_SCAN;
@@ -2067,49 +2074,52 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	start = (u8 *)bh->b_data;
 	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
 
-	fc_for_each_tl(start, end, tl) {
+	for (cur = start; cur < end; cur = cur + sizeof(tl) + le16_to_cpu(tl.fc_len)) {
+		memcpy(&tl, cur, sizeof(tl));
+		val = cur + sizeof(tl);
+
 		if (state->fc_replay_num_tags == 0) {
 			ret = JBD2_FC_REPLAY_STOP;
 			ext4_fc_set_bitmaps_and_counters(sb);
 			break;
 		}
 		jbd_debug(3, "Replay phase, tag:%s\n",
-				tag2str(le16_to_cpu(tl->fc_tag)));
+				tag2str(le16_to_cpu(tl.fc_tag)));
 		state->fc_replay_num_tags--;
-		switch (le16_to_cpu(tl->fc_tag)) {
+		switch (le16_to_cpu(tl.fc_tag)) {
 		case EXT4_FC_TAG_LINK:
-			ret = ext4_fc_replay_link(sb, tl);
+			ret = ext4_fc_replay_link(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_UNLINK:
-			ret = ext4_fc_replay_unlink(sb, tl);
+			ret = ext4_fc_replay_unlink(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_ADD_RANGE:
-			ret = ext4_fc_replay_add_range(sb, tl);
+			ret = ext4_fc_replay_add_range(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_CREAT:
-			ret = ext4_fc_replay_create(sb, tl);
+			ret = ext4_fc_replay_create(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_DEL_RANGE:
-			ret = ext4_fc_replay_del_range(sb, tl);
+			ret = ext4_fc_replay_del_range(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_INODE:
-			ret = ext4_fc_replay_inode(sb, tl);
+			ret = ext4_fc_replay_inode(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_PAD:
 			trace_ext4_fc_replay(sb, EXT4_FC_TAG_PAD, 0,
-				ext4_fc_tag_len(tl), 0);
+					     le16_to_cpu(tl.fc_len), 0);
 			break;
 		case EXT4_FC_TAG_TAIL:
 			trace_ext4_fc_replay(sb, EXT4_FC_TAG_TAIL, 0,
-				ext4_fc_tag_len(tl), 0);
-			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
-			WARN_ON(le32_to_cpu(tail->fc_tid) != expected_tid);
+					     le16_to_cpu(tl.fc_len), 0);
+			memcpy(&tail, val, sizeof(tail));
+			WARN_ON(le32_to_cpu(tail.fc_tid) != expected_tid);
 			break;
 		case EXT4_FC_TAG_HEAD:
 			break;
 		default:
-			trace_ext4_fc_replay(sb, le16_to_cpu(tl->fc_tag), 0,
-				ext4_fc_tag_len(tl), 0);
+			trace_ext4_fc_replay(sb, le16_to_cpu(tl.fc_tag), 0,
+					     le16_to_cpu(tl.fc_len), 0);
 			ret = -ECANCELED;
 			break;
 		}
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index b77f70f55a62..937c381b4c85 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -153,13 +153,6 @@ struct ext4_fc_replay_state {
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
@@ -186,16 +179,4 @@ static inline const char *tag2str(__u16 tag)
 	}
 }
 
-/* Get length of a particular tlv */
-static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
-{
-	return le16_to_cpu(tl->fc_len);
-}
-
-/* Get a pointer to "value" of a tlv */
-static inline __u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
-{
-	return (__u8 *)tl + sizeof(*tl);
-}
-
 #endif /* __FAST_COMMIT_H__ */
-- 
2.31.1.751.gd2f1c929bd-goog

