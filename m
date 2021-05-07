Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D11375DE0
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 02:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhEGAWW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 20:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhEGAWW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 20:22:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E46FC061574
        for <linux-ext4@vger.kernel.org>; Thu,  6 May 2021 17:21:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h127so6366984pfe.9
        for <linux-ext4@vger.kernel.org>; Thu, 06 May 2021 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQMNW5nj4kKTkGGxs7fDjWTGEh+zMmonObIKqM54lWs=;
        b=IFMz7Kka5zDtrMZHi8N0i33MSsa9C8IVFgOFYV4qM8NEAtzQC1dEiHoTPsSgg2FbJh
         atOxivEfvKx4BvuTbPYmh+WurwwqzX83lbIAjf1sqTaGx63ZfBdF2nlf9l8wIDWyevQM
         f6Y14jXOpTJ+rMdCfl2X8H2KrsDlrPZe4mu/Qjp7qmanijNPYJs07UVfqiqH4Towy3l6
         +BefJE2s57VVi20Vr2+y4qYe0IrSZZrkiHQfCJ5WVbFUMCHBGhy3Nobq1Syug8zKkNVo
         UZt0/C8O+LKLyRcMxBH2qtcVrS5HPP3GWHQtiQnBxU3umBskQx9dMw49fEv6EDqrPBv1
         vhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQMNW5nj4kKTkGGxs7fDjWTGEh+zMmonObIKqM54lWs=;
        b=XTiczbt2NBcvyjjoEAl9m95/inSNOLtFFRfRByHPvhu/Ii7gAO/cWFYZBJaH7lwHUF
         m9XxStuNRPzBHGBBO0B6iHaULa7hYuUDSMLcbQDxOMUDt/8x3BehZ/JRqnN7LSt2oMvt
         GwOpf4FU/tW7yhYV2xOmHpPa8D93r8xsijUHCk5SwqWBLi5wAI1N8bEMQPk+p1t5oQVT
         iz1RBWbYmhtBI2mI4WU/2Ec9RCa60DUpLVWrPf+XiICfjB7oYvxWH0M8etc8s+tL9oJf
         Ir0h5QAeDY+nsllnG1VVTemLheO3Tf4gzfFrFP8vbokczEVWMVeeoJFE/HzgDqjY6Eok
         cR2Q==
X-Gm-Message-State: AOAM530ahsmKorKND7mP1L/9SbzfKsh7NWsy5OVT5t8b26ETIuKX51dQ
        GnbmZ7QeHQyFVZ985HAbIedTN1rLXQ8=
X-Google-Smtp-Source: ABdhPJyGPOQNJVy1Goi0zZUpyTjGECFf33V2hlBsaO1nVdd7biJHAebgfNPxokxxAIwiKe+5Ftjhkg==
X-Received: by 2002:a63:40c1:: with SMTP id n184mr6866729pga.219.1620346881127;
        Thu, 06 May 2021 17:21:21 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:18ef:ca69:5a81:5bdd])
        by smtp.googlemail.com with ESMTPSA id b7sm2824002pjq.36.2021.05.06.17.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 17:21:20 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Subject: [PATCH 1/2] e2fsck: fix portability problems caused by unaligned accesses
Date:   Thu,  6 May 2021 17:21:09 -0700
Message-Id: <20210507002110.3933387-1-harshads@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

The on-disk format for the ext4 journal can have unaigned 32-bit
integers.  This can happen when replaying a journal using a obsolete
checksum format (which was never popularly used, since the v3 format
replaced v2 while the metadata checksum feature was being stablized),
and in the fast commit feature (which landed in the 5.10 kernel,
although it is not enabled by default).

This commit fixes the following regression tests on some platforms
(such as running 32-bit arm architectures on a 64-bit arm kernel):
j_recover_csum2_32bit, j_recover_csum2_64bit, j_recover_fast_commit.

https://github.com/tytso/e2fsprogs/issues/65

Addresses-Debian-Bug: #987641
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/journal.c                   | 83 ++++++++++++++++--------------
 e2fsck/recovery.c                  | 22 ++++----
 tests/j_recover_fast_commit/script |  1 -
 3 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a425bbd1..bd0e4f31 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -286,9 +286,9 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_add_range *ext;
 	struct ext4_fc_tl *tl;
-	struct ext4_fc_tail *tail;
+	struct ext4_fc_tail tail;
 	__u8 *start, *end;
-	struct ext4_fc_head *head;
+	struct ext4_fc_head head;
 	struct ext2fs_extent ext2fs_ex = {0};
 
 	state = &ctx->fc_replay_state;
@@ -338,16 +338,15 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 			break;
 		case EXT4_FC_TAG_TAIL:
 			state->fc_cur_tag++;
-			tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
+			memcpy(&tail, ext4_fc_tag_val(tl), sizeof(tail));
 			state->fc_crc = jbd2_chksum(j, state->fc_crc, tl,
 						sizeof(*tl) +
 						offsetof(struct ext4_fc_tail,
 						fc_crc));
 			jbd_debug(1, "tail tid %d, expected %d\n",
-					le32_to_cpu(tail->fc_tid),
-					expected_tid);
-			if (le32_to_cpu(tail->fc_tid) == expected_tid &&
-				le32_to_cpu(tail->fc_crc) == state->fc_crc) {
+				  le32_to_cpu(tail.fc_tid), expected_tid);
+			if (le32_to_cpu(tail.fc_tid) == expected_tid &&
+			    le32_to_cpu(tail.fc_crc) == state->fc_crc) {
 				state->fc_replay_num_tags = state->fc_cur_tag;
 			} else {
 				ret = state->fc_replay_num_tags ?
@@ -356,13 +355,13 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 			state->fc_crc = 0;
 			break;
 		case EXT4_FC_TAG_HEAD:
-			head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
-			if (le32_to_cpu(head->fc_features) &
-				~EXT4_FC_SUPPORTED_FEATURES) {
+			memcpy(&head, ext4_fc_tag_val(tl), sizeof(head));
+			if (le32_to_cpu(head.fc_features) &
+			    ~EXT4_FC_SUPPORTED_FEATURES) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
-			if (le32_to_cpu(head->fc_tid) != expected_tid) {
+			if (le32_to_cpu(head.fc_tid) != expected_tid) {
 				ret = -EINVAL;
 				break;
 			}
@@ -612,27 +611,31 @@ struct dentry_info_args {
 	char *dname;
 };
 
-static inline void tl_to_darg(struct dentry_info_args *darg,
+static inline int tl_to_darg(struct dentry_info_args *darg,
 				struct  ext4_fc_tl *tl)
 {
-	struct ext4_fc_dentry_info *fcd;
+	struct ext4_fc_dentry_info fcd;
 	int tag = le16_to_cpu(tl->fc_tag);
 
-	fcd = (struct ext4_fc_dentry_info *)ext4_fc_tag_val(tl);
+	memcpy(&fcd, ext4_fc_tag_val(tl), sizeof(fcd));
 
-	darg->parent_ino = le32_to_cpu(fcd->fc_parent_ino);
-	darg->ino = le32_to_cpu(fcd->fc_ino);
-	darg->dname = (char *) fcd->fc_dname;
+	darg->parent_ino = le32_to_cpu(fcd.fc_parent_ino);
+	darg->ino = le32_to_cpu(fcd.fc_ino);
 	darg->dname_len = ext4_fc_tag_len(tl) -
 			sizeof(struct ext4_fc_dentry_info);
 	darg->dname = malloc(darg->dname_len + 1);
-	memcpy(darg->dname, fcd->fc_dname, darg->dname_len);
+	if (!darg->dname)
+		return -ENOMEM;
+	memcpy(darg->dname,
+	       ext4_fc_tag_val(tl) + sizeof(struct ext4_fc_dentry_info),
+	       darg->dname_len);
 	darg->dname[darg->dname_len] = 0;
 	jbd_debug(1, "%s: %s, ino %d, parent %d\n",
 		tag == EXT4_FC_TAG_CREAT ? "create" :
 		(tag == EXT4_FC_TAG_LINK ? "link" :
 		(tag == EXT4_FC_TAG_UNLINK ? "unlink" : "error")),
 		darg->dname, darg->ino, darg->parent_ino);
+	return 0;
 }
 
 static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl)
@@ -642,7 +645,9 @@ static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	ext2_filsys fs = ctx->fs;
 	int ret;
 
-	tl_to_darg(&darg, tl);
+	ret = tl_to_darg(&darg, tl);
+	if (ret)
+		return ret;
 	ext4_fc_flush_extents(ctx, darg.ino);
 	ret = errcode_to_errno(
 		       ext2fs_unlink(ctx->fs, darg.parent_ino,
@@ -659,7 +664,9 @@ static int ext4_fc_handle_link_and_create(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	struct ext2_inode_large inode_large;
 	int ret, filetype, mode;
 
-	tl_to_darg(&darg, tl);
+	ret = tl_to_darg(&darg, tl);
+	if (ret)
+		return ret;
 	ext4_fc_flush_extents(ctx, 0);
 	ret = errcode_to_errno(ext2fs_read_inode(fs, darg.ino,
 						 (struct ext2_inode *)&inode_large));
@@ -730,17 +737,18 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ino, inode_len = EXT2_GOOD_OLD_INODE_SIZE;
 	struct ext2_inode_large *inode = NULL, *fc_inode = NULL;
-	struct ext4_fc_inode *fc_inode_val;
+	__le32 fc_ino;
+	__u8 *fc_raw_inode;
 	errcode_t err;
 	blk64_t blks;
 
-	fc_inode_val = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
-	ino = le32_to_cpu(fc_inode_val->fc_ino);
+	memcpy(&fc_ino, ext4_fc_tag_val(tl), sizeof(fc_ino));
+	fc_raw_inode = ext4_fc_tag_val(tl) + sizeof(fc_ino);
+	ino = le32_to_cpu(fc_ino);
 
 	if (EXT2_INODE_SIZE(ctx->fs->super) > EXT2_GOOD_OLD_INODE_SIZE)
 		inode_len += ext2fs_le16_to_cpu(
-			((struct ext2_inode_large *)fc_inode_val->fc_raw_inode)
-				->i_extra_isize);
+			((struct ext2_inode_large *)fc_raw_inode)->i_extra_isize);
 	err = ext2fs_get_mem(inode_len, &inode);
 	if (err)
 		goto out;
@@ -755,10 +763,10 @@ static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
 		goto out;
 #ifdef WORDS_BIGENDIAN
 	ext2fs_swap_inode_full(ctx->fs, fc_inode,
-			       (struct ext2_inode_large *)fc_inode_val->fc_raw_inode,
+			       (struct ext2_inode_large *)fc_raw_inode,
 			       0, sizeof(*inode));
 #else
-	memcpy(fc_inode, fc_inode_val->fc_raw_inode, inode_len);
+	memcpy(fc_inode, fc_raw_inode, inode_len);
 #endif
 	memcpy(inode, fc_inode, offsetof(struct ext2_inode_large, i_block));
 	memcpy(&inode->i_generation, &fc_inode->i_generation,
@@ -792,12 +800,11 @@ out:
 static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
 {
 	struct ext2fs_extent extent;
-	struct ext4_fc_add_range *add_range;
-	struct ext4_fc_del_range *del_range;
+	struct ext4_fc_add_range add_range;
 	int ret = 0, ino;
 
-	add_range = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
-	ino = le32_to_cpu(add_range->fc_ino);
+	memcpy(&add_range, ext4_fc_tag_val(tl), sizeof(add_range));
+	ino = le32_to_cpu(add_range.fc_ino);
 	ext4_fc_flush_extents(ctx, ino);
 
 	ret = ext4_fc_read_extents(ctx, ino);
@@ -805,8 +812,8 @@ static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
 		return ret;
 	memset(&extent, 0, sizeof(extent));
 	ret = errcode_to_errno(ext2fs_decode_extent(
-			&extent, (void *)(add_range->fc_ex),
-			sizeof(add_range->fc_ex)));
+			&extent, (void *)add_range.fc_ex,
+			sizeof(add_range.fc_ex)));
 	if (ret)
 		return ret;
 	return ext4_add_extent_to_list(ctx,
@@ -819,16 +826,16 @@ static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
 static int ext4_fc_handle_del_range(e2fsck_t ctx, struct ext4_fc_tl *tl)
 {
 	struct ext2fs_extent extent;
-	struct ext4_fc_del_range *del_range;
+	struct ext4_fc_del_range del_range;
 	int ret, ino;
 
-	del_range = (struct ext4_fc_del_range *)ext4_fc_tag_val(tl);
-	ino = le32_to_cpu(del_range->fc_ino);
+	memcpy(&del_range, ext4_fc_tag_val(tl), sizeof(del_range));
+	ino = le32_to_cpu(del_range.fc_ino);
 	ext4_fc_flush_extents(ctx, ino);
 
 	memset(&extent, 0, sizeof(extent));
-	extent.e_lblk = ext2fs_le32_to_cpu(del_range->fc_lblk);
-	extent.e_len = ext2fs_le32_to_cpu(del_range->fc_len);
+	extent.e_lblk = le32_to_cpu(del_range.fc_lblk);
+	extent.e_len = le32_to_cpu(del_range.fc_len);
 	ret = ext4_fc_read_extents(ctx, ino);
 	if (ret)
 		return ret;
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index dc0694fc..02694d2c 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -196,7 +196,7 @@ static int jbd2_descriptor_block_csum_verify(journal_t *j, void *buf)
 static int count_tags(journal_t *journal, struct buffer_head *bh)
 {
 	char *			tagp;
-	journal_block_tag_t *	tag;
+	journal_block_tag_t	tag;
 	int			nr = 0, size = journal->j_blocksize;
 	int			tag_bytes = journal_tag_bytes(journal);
 
@@ -206,14 +206,14 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 	tagp = &bh->b_data[sizeof(journal_header_t)];
 
 	while ((tagp - bh->b_data + tag_bytes) <= size) {
-		tag = (journal_block_tag_t *) tagp;
+		memcpy(&tag, tagp, sizeof(tag));
 
 		nr++;
 		tagp += tag_bytes;
-		if (!(tag->t_flags & cpu_to_be16(JBD2_FLAG_SAME_UUID)))
+		if (!(tag.t_flags & cpu_to_be16(JBD2_FLAG_SAME_UUID)))
 			tagp += 16;
 
-		if (tag->t_flags & cpu_to_be16(JBD2_FLAG_LAST_TAG))
+		if (tag.t_flags & cpu_to_be16(JBD2_FLAG_LAST_TAG))
 			break;
 	}
 
@@ -434,9 +434,9 @@ static int jbd2_commit_block_csum_verify(journal_t *j, void *buf)
 }
 
 static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
+				      journal_block_tag3_t *tag3,
 				      void *buf, __u32 sequence)
 {
-	journal_block_tag3_t *tag3 = (journal_block_tag3_t *)tag;
 	__u32 csum32;
 	__be32 seq;
 
@@ -497,7 +497,7 @@ static int do_one_pass(journal_t *journal,
 	while (1) {
 		int			flags;
 		char *			tagp;
-		journal_block_tag_t *	tag;
+		journal_block_tag_t	tag;
 		struct buffer_head *	obh;
 		struct buffer_head *	nbh;
 
@@ -614,8 +614,8 @@ static int do_one_pass(journal_t *journal,
 			       <= journal->j_blocksize - descr_csum_size) {
 				unsigned long io_block;
 
-				tag = (journal_block_tag_t *) tagp;
-				flags = be16_to_cpu(tag->t_flags);
+				memcpy(&tag, tagp, sizeof(tag));
+				flags = be16_to_cpu(tag.t_flags);
 
 				io_block = next_log_block++;
 				wrap(journal, next_log_block);
@@ -633,7 +633,7 @@ static int do_one_pass(journal_t *journal,
 
 					J_ASSERT(obh != NULL);
 					blocknr = read_tag_block(journal,
-								 tag);
+								 &tag);
 
 					/* If the block has been
 					 * revoked, then we're all done
@@ -648,8 +648,8 @@ static int do_one_pass(journal_t *journal,
 
 					/* Look for block corruption */
 					if (!jbd2_block_tag_csum_verify(
-						journal, tag, obh->b_data,
-						be32_to_cpu(tmp->h_sequence))) {
+			journal, &tag, (journal_block_tag3_t *)tagp,
+			obh->b_data, be32_to_cpu(tmp->h_sequence))) {
 						brelse(obh);
 						success = -EFSBADCRC;
 						printk(KERN_ERR "JBD2: Invalid "
diff --git a/tests/j_recover_fast_commit/script b/tests/j_recover_fast_commit/script
index 22ef6325..05c40cc5 100755
--- a/tests/j_recover_fast_commit/script
+++ b/tests/j_recover_fast_commit/script
@@ -10,7 +10,6 @@ gunzip < $IMAGE > $TMPFILE
 EXP=$test_dir/expect
 OUT=$test_name.log
 
-cp $TMPFILE /tmp/debugthis
 $FSCK $FSCK_OPT -E journal_only -N test_filesys $TMPFILE 2>/dev/null | head -n 1000 | tail -n +2 > $OUT
 echo "Exit status is $?" >> $OUT
 
-- 
2.31.1.607.g51e8a6a459-goog

