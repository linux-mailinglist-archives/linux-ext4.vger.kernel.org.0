Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1F3E9A64
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 23:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhHKVZS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 17:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhHKVZR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 17:25:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0036CC061765
        for <linux-ext4@vger.kernel.org>; Wed, 11 Aug 2021 14:24:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bo18so5771242pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 11 Aug 2021 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7g21TIXEKyiF1IG2fepkmw6v+MpHLuW1kGGDGsiWpc=;
        b=i+cObjxo8NM79uT5L/EGxquyQg/3LWbW1hd3nwiwoLAKaVsYOnizhC/OvvR+dLpZpu
         +Ma8XvhnJe+g/zX9g7dsgA5DcwH7dwqu3/vXGRh9FrpFnd7D46F8SlqJ4IldIXCoBjfE
         UL7YV8Lwon0lDP8/kamC2tfZNtG62k1W7311JV9pC0pcR/MsWktgi1qUy3Hd57K38W01
         dThbTJrpZLtRXdXVVqqq429sFBI0w5hScijRU/oWU/+qm7M73Po+AnMhjmjyM1L15xpE
         ySz+iQjmcDk51xq03IjfUpXkhLfOlNR3FG2153O7kIOHhv3xKprbdJ3iKzmjM9UWZCV6
         +xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R7g21TIXEKyiF1IG2fepkmw6v+MpHLuW1kGGDGsiWpc=;
        b=HycKoMhytUCVX9Iu65x5RDQFpfnv5vIT+7baRy6pOOvg6kDg4V/G2lEu+yECYjr8sN
         Br7CGwEdhRuGz2ktqqh4AFpKs+h9wNux+bCORO7biubXpmDWs+NjrvjQ3+LdnrX+VPIz
         Ie7UTJGPh2ipxjO2M0qcHJ+LZLBIoiGjOw+RIuQ26Yrav63W0A520TWgIOUaqAGOeS7I
         TNqRFYv6ZH/BP0v+Dlys9KqeglhXD8HR63hR9jq2PhauWpHrZLJt/j6jpfRSa7mCINxY
         RNIYF3QCfunowY/gBUL6sYIm6s96V/DO8V7A7Wv7q9F2GfVINKjxf3/8UZYB+cQRfSAq
         chzw==
X-Gm-Message-State: AOAM53081ePAfqK7BsNaanMMODAe44rjR3OaThI3vWNbri1MomgNRdEP
        1mrljbidh0f4eGcxcnz1VQtDpccvgk8=
X-Google-Smtp-Source: ABdhPJy700YevqC0TGWtpJmqjPtj3Yp/enX8kI/i/DjAfiN3fGKBG69qTOGG5ffpHb7MkmkSTvxWnQ==
X-Received: by 2002:a17:90a:af8f:: with SMTP id w15mr3050815pjq.90.1628717092020;
        Wed, 11 Aug 2021 14:24:52 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:af9b:9549:f65d:ae85])
        by smtp.googlemail.com with ESMTPSA id ns4sm7593205pjb.51.2021.08.11.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:24:51 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: fix fast commit alignment issues
Date:   Wed, 11 Aug 2021 14:24:14 -0700
Message-Id: <20210811212414.14468-1-harshads@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch ports following fast commit alignment issues merged in
e2fsprogs to ext4 in kernel:

https://patchwork.ozlabs.org/project/linux-ext4/list/?series=242554&state=*

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 172 ++++++++++++++++++++++--------------------
 fs/ext4/fast_commit.h |   8 --
 2 files changed, 91 insertions(+), 89 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 447c8d93f480..15217c4ef1ff 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1208,41 +1208,48 @@ static inline int ext4_fc_tag_len(struct ext4_fc_tl *tl)
 	return le16_to_cpu(tl->fc_len);
 }
 
-/* Get a pointer to "value" of a tlv */
-static inline u8 *ext4_fc_tag_val(struct ext4_fc_tl *tl)
-{
-	return (u8 *)tl + sizeof(*tl);
-}
-
 /* Helper struct for dentry replay routines */
 struct dentry_info_args {
 	int parent_ino, dname_len, ino, inode_len;
 	char *dname;
 };
 
-static inline void tl_to_darg(struct dentry_info_args *darg,
-				struct  ext4_fc_tl *tl)
+static inline int tl_to_darg(struct dentry_info_args *darg,
+			     struct  ext4_fc_tl *tl, __u8 *val)
 {
-	struct ext4_fc_dentry_info *fcd;
+	struct ext4_fc_dentry_info fcd;
+	int tag = le16_to_cpu(tl->fc_tag);
 
-	fcd = (struct ext4_fc_dentry_info *)ext4_fc_tag_val(tl);
+	memcpy(&fcd, val, sizeof(fcd));
 
-	darg->parent_ino = le32_to_cpu(fcd->fc_parent_ino);
-	darg->ino = le32_to_cpu(fcd->fc_ino);
-	darg->dname = fcd->fc_dname;
+	darg->parent_ino = le32_to_cpu(fcd.fc_parent_ino);
+	darg->ino = le32_to_cpu(fcd.fc_ino);
 	darg->dname_len = ext4_fc_tag_len(tl) -
 			sizeof(struct ext4_fc_dentry_info);
+	darg->dname = kmalloc(darg->dname_len + 1, GFP_KERNEL);
+	if (!darg->dname)
+		return -ENOMEM;
+	memcpy(darg->dname,
+	       val + sizeof(struct ext4_fc_dentry_info),
+	       darg->dname_len);
+	darg->dname[darg->dname_len] = 0;
+	jbd_debug(1, "%s: %s, ino %lu, parent %lu\n",
+		tag == EXT4_FC_TAG_CREAT ? "create" :
+		(tag == EXT4_FC_TAG_LINK ? "link" :
+		(tag == EXT4_FC_TAG_UNLINK ? "unlink" : "error")),
+		darg->dname, darg->ino, darg->parent_ino);
+	return 0;
 }
 
 /* Unlink replay function */
-static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl, __u8 *val)
 {
 	struct inode *inode, *old_parent;
 	struct qstr entry;
 	struct dentry_info_args darg;
 	int ret = 0;
 
-	tl_to_darg(&darg, tl);
+	tl_to_darg(&darg, tl, val);
 
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_UNLINK, darg.ino,
 			darg.parent_ino, darg.dname_len);
@@ -1332,13 +1339,13 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 }
 
 /* Link replay function */
-static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl, __u8 *val)
 {
 	struct inode *inode;
 	struct dentry_info_args darg;
 	int ret = 0;
 
-	tl_to_darg(&darg, tl);
+	tl_to_darg(&darg, tl, val);
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_LINK, darg.ino,
 			darg.parent_ino, darg.dname_len);
 
@@ -1383,19 +1390,20 @@ static int ext4_fc_record_modified_inode(struct super_block *sb, int ino)
 /*
  * Inode replay function
  */
-static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl, __u8 *val)
 {
-	struct ext4_fc_inode *fc_inode;
 	struct ext4_inode *raw_inode;
 	struct ext4_inode *raw_fc_inode;
 	struct inode *inode = NULL;
 	struct ext4_iloc iloc;
 	int inode_len, ino, ret, tag = le16_to_cpu(tl->fc_tag);
+	__u32 fc_ino;
 	struct ext4_extent_header *eh;
 
-	fc_inode = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
+	memcpy(&fc_ino, val, sizeof(fc_ino));
+	raw_fc_inode = (struct ext4_inode *)(val + sizeof(fc_ino));
 
-	ino = le32_to_cpu(fc_inode->fc_ino);
+	ino = le32_to_cpu(fc_ino);
 	trace_ext4_fc_replay(sb, tag, ino, 0, 0);
 
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
@@ -1406,7 +1414,6 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	ext4_fc_record_modified_inode(sb, ino);
 
-	raw_fc_inode = (struct ext4_inode *)fc_inode->fc_raw_inode;
 	ret = ext4_get_fc_inode_loc(sb, ino, &iloc);
 	if (ret)
 		goto out;
@@ -1479,14 +1486,14 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
  * inode for which we are trying to create a dentry here, should already have
  * been replayed before we start here.
  */
-static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
+static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl, __u8 *val)
 {
 	int ret = 0;
 	struct inode *inode = NULL;
 	struct inode *dir = NULL;
 	struct dentry_info_args darg;
 
-	tl_to_darg(&darg, tl);
+	tl_to_darg(&darg, tl, val);
 
 	trace_ext4_fc_replay(sb, EXT4_FC_TAG_CREAT, darg.ino,
 			darg.parent_ino, darg.dname_len);
@@ -1564,10 +1571,9 @@ static int ext4_fc_record_regions(struct super_block *sb, int ino,
 }
 
 /* Replay add range tag */
-static int ext4_fc_replay_add_range(struct super_block *sb,
-				struct ext4_fc_tl *tl)
+static int ext4_fc_replay_add_range(struct super_block *sb, __u8 *val)
 {
-	struct ext4_fc_add_range *fc_add_ex;
+	struct ext4_fc_add_range fc_add_ex;
 	struct ext4_extent newex, *ex;
 	struct inode *inode;
 	ext4_lblk_t start, cur;
@@ -1577,14 +1583,14 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
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
+	inode = ext4_iget(sb, le32_to_cpu(fc_add_ex.fc_ino),
 				EXT4_IGET_NORMAL);
 	if (IS_ERR_OR_NULL(inode)) {
 		jbd_debug(1, "Inode not found.");
@@ -1692,32 +1698,32 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 /* Replay DEL_RANGE tag */
 static int
-ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
+ext4_fc_replay_del_range(struct super_block *sb, __u8 *val)
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
 	if (IS_ERR_OR_NULL(inode)) {
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
@@ -1738,8 +1744,8 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
 	}
 
 	ret = ext4_punch_hole(inode,
-		le32_to_cpu(lrange->fc_lblk) << sb->s_blocksize_bits,
-		le32_to_cpu(lrange->fc_len) <<  sb->s_blocksize_bits);
+		le32_to_cpu(lrange.fc_lblk) << sb->s_blocksize_bits,
+		le32_to_cpu(lrange.fc_len) <<  sb->s_blocksize_bits);
 	if (ret)
 		jbd_debug(1, "ext4_punch_hole returned %d", ret);
 	ext4_ext_replay_shrink_inode(inode,
@@ -1882,10 +1888,10 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	struct ext4_fc_replay_state *state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_add_range *ext;
-	struct ext4_fc_tl *tl;
-	struct ext4_fc_tail *tail;
-	__u8 *start, *end;
-	struct ext4_fc_head *head;
+	struct ext4_fc_tl tl;
+	struct ext4_fc_tail tail;
+	__u8 *start, *cur, *end, *val;
+	struct ext4_fc_head head;
 	struct ext4_extent *ex;
 
 	state = &sbi->s_fc_replay_state;
@@ -1912,12 +1918,14 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	}
 
 	state->fc_replay_expected_off++;
-	fc_for_each_tl(start, end, tl) {
+	for (cur = start; cur < end; cur = cur + le16_to_cpu(tl.fc_len) + sizeof(tl)) {
+		memcpy(&tl, cur, sizeof(tl));
+		val = cur + sizeof(tl);
 		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
-			  tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
-		switch (le16_to_cpu(tl->fc_tag)) {
+			  tag2str(le16_to_cpu(tl.fc_tag)), bh->b_blocknr);
+		switch (le16_to_cpu(tl.fc_tag)) {
 		case EXT4_FC_TAG_ADD_RANGE:
-			ext = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
+			ext = (struct ext4_fc_add_range *)val;
 			ex = (struct ext4_extent *)&ext->fc_ex;
 			ret = ext4_fc_record_regions(sb,
 				le32_to_cpu(ext->fc_ino),
@@ -1934,18 +1942,18 @@ static int ext4_fc_replay_scan(journal_t *journal,
 		case EXT4_FC_TAG_INODE:
 		case EXT4_FC_TAG_PAD:
 			state->fc_cur_tag++;
-			state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
-					sizeof(*tl) + ext4_fc_tag_len(tl));
+			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
+					sizeof(tl) + ext4_fc_tag_len(&tl));
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
@@ -1956,19 +1964,19 @@ static int ext4_fc_replay_scan(journal_t *journal,
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
+					sizeof(tl) + ext4_fc_tag_len(&tl));
 			break;
 		default:
 			ret = state->fc_replay_num_tags ?
@@ -1992,11 +2000,11 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
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
@@ -2023,49 +2031,51 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	start = (u8 *)bh->b_data;
 	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
 
-	fc_for_each_tl(start, end, tl) {
+	for (cur = start; cur < end; cur = cur + le16_to_cpu(tl.fc_len) + sizeof(tl)) {
+		memcpy(&tl, cur, sizeof(tl));
+		val = cur + sizeof(tl);
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
+			ret = ext4_fc_replay_add_range(sb, val);
 			break;
 		case EXT4_FC_TAG_CREAT:
-			ret = ext4_fc_replay_create(sb, tl);
+			ret = ext4_fc_replay_create(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_DEL_RANGE:
-			ret = ext4_fc_replay_del_range(sb, tl);
+			ret = ext4_fc_replay_del_range(sb, val);
 			break;
 		case EXT4_FC_TAG_INODE:
-			ret = ext4_fc_replay_inode(sb, tl);
+			ret = ext4_fc_replay_inode(sb, &tl, val);
 			break;
 		case EXT4_FC_TAG_PAD:
 			trace_ext4_fc_replay(sb, EXT4_FC_TAG_PAD, 0,
-				ext4_fc_tag_len(tl), 0);
+				ext4_fc_tag_len(&tl), 0);
 			break;
 		case EXT4_FC_TAG_TAIL:
 			trace_ext4_fc_replay(sb, EXT4_FC_TAG_TAIL, 0,
-				ext4_fc_tag_len(tl), 0);
-			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
-			WARN_ON(le32_to_cpu(tail->fc_tid) != expected_tid);
+				ext4_fc_tag_len(&tl), 0);
+			memcpy(&tail, val, sizeof(tail));
+			WARN_ON(le32_to_cpu(tail.fc_tid) != expected_tid);
 			break;
 		case EXT4_FC_TAG_HEAD:
 			break;
 		default:
-			trace_ext4_fc_replay(sb, le16_to_cpu(tl->fc_tag), 0,
-				ext4_fc_tag_len(tl), 0);
+			trace_ext4_fc_replay(sb, le16_to_cpu(tl.fc_tag), 0,
+				ext4_fc_tag_len(&tl), 0);
 			ret = -ECANCELED;
 			break;
 		}
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 06907d485989..894ce22857e2 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -148,12 +148,4 @@ struct ext4_fc_replay_state {
 
 #define region_last(__region) (((__region)->lblk) + ((__region)->len) - 1)
 
-#define fc_for_each_tl(__start, __end, __tl)				\
-	for (tl = (struct ext4_fc_tl *)start;				\
-		(u8 *)tl < (u8 *)end;					\
-		tl = (struct ext4_fc_tl *)((u8 *)tl +			\
-					sizeof(struct ext4_fc_tl) +	\
-					+ le16_to_cpu(tl->fc_len)))
-
-
 #endif /* __FAST_COMMIT_H__ */
-- 
2.32.0.605.g8dce9f2422-goog

