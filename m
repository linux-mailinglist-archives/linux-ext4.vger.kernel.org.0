Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1640718C3C9
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 00:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCSXe6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 19:34:58 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51625 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgCSXe5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 19:34:57 -0400
Received: by mail-pj1-f68.google.com with SMTP id hg10so1688321pjb.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hvFkMnsXYhS15KX00fVpaOqQeZYNUROcpehAXFWUt4=;
        b=rODqddux0w5cNm70QFdpDual3+37u8PTH+Q23y1cuqgNf2i7Q992F11B05K+GWlErH
         amnLHOoBcrrSFIrt3AZ+13GGsfL49yqI6KgF63KH4b8Ggqx90fmrpBJX820g7u7piIcl
         y4n8SNj86U004xkGtrBcvOFYgnTXrv4k92L8FR0s+lf+PlpDFZpTfUI57aj4g1dTdK2Q
         YE8itZ3ukpyGsa0mRyIVtY3Nz9fDFMBZF4mznJ+BO2d0JP1xj1WSIq/kJbEHXqI06m2D
         GbBqZOvnyXhYJFSZ6UHBj+PTPAJQMFlPtzIE+Yk/vi0i/uqoKWDCknTuqxWDUJTANm74
         UyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hvFkMnsXYhS15KX00fVpaOqQeZYNUROcpehAXFWUt4=;
        b=nF5SG3ZqqMYlG99l55WRSxHWphT9+dK8EXarjkbIr8cOnlNYm8Mlny7uJlehXP5raN
         4UeRQ36D+uCyoIG/Al6I6y4QpcPq09QMBSbQW0H4WJFyxn9dIK3af/mpd0OxsAdAIoTI
         CHIwafIkhpHVHK+Mz6D4q0v6SuWQ17+ybs8x2Sz9MGk4zGzu6kfD1zg1urDygSoj2O2/
         mw9TMVoEmSKLSmCtunTzpXTPNEtnGYAFEpr2BwtCpKJDELBhT3OWBCEH4mdb00QohKY0
         OrFgxxEqQCoDzqoivuV2KoDZxif9qETgBXYAcF+qJyQfDn4gDPm7ogfshpd8KEkfpViM
         OVDw==
X-Gm-Message-State: ANhLgQ0mBWMXjXCQv36zm77o8uX9VWRhNxJjAcGtAXdS7ECLFP9iBTKr
        AtS1ZahLb1UW6CTSXbHup9U3nRY7
X-Google-Smtp-Source: ADFU+vudlLHmPv5PAOiM17JCAXf2ly2Ypa1BFeq9sKW+mCziGGVNjDTdEnFEXw7bKDbYJFrzwpeewg==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id d21mr6376523pjw.27.1584660895262;
        Thu, 19 Mar 2020 16:34:55 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id j17sm204353pga.18.2020.03.19.16.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:34:54 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 6/7] e2fsck: main fast commit replay handler
Date:   Thu, 19 Mar 2020 16:34:32 -0700
Message-Id: <20200319233433.117144-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
References: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add main ext4 fast commit replay handler that handles replayed fast
commit blocks.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/e2fsck.h      |   9 +
 e2fsck/journal.c     | 491 ++++++++++++++++++++++++++++++++++++++++++-
 lib/ext2fs/ext2_fs.h |  46 ++++
 3 files changed, 545 insertions(+), 1 deletion(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 68f7a249..8ea87ac5 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -226,6 +226,12 @@ typedef struct e2fsck_struct *e2fsck_t;
 
 #define MAX_EXTENT_DEPTH_COUNT 5
 
+struct e2fsck_fc_replay_state {
+	int fc_replay_error;
+	int fc_replay_expected_off;
+	int fc_num_blks;
+};
+
 struct e2fsck_struct {
 	ext2_filsys fs;
 	const char *program_name;
@@ -418,6 +424,9 @@ struct e2fsck_struct {
 
 	/* Undo file */
 	char *undo_file;
+
+	/* Fast commit replay stuff */
+	struct e2fsck_fc_replay_state fc_replay_state;
 };
 
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 7d9f1b40..97fb3c24 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -278,6 +278,485 @@ static int process_journal_block(ext2_filsys fs,
 	return 0;
 }
 
+static int ext4_journal_fc_replay_scan(journal_t *j, struct buffer_head *bh,
+				       int off)
+{
+	e2fsck_t ctx = j->j_fs_dev->k_ctx;
+	struct e2fsck_fc_replay_state *state;
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_fc_tl *tl;
+	__u32 csum, old_csum;
+	__u8 *start, *end;
+
+	state = &ctx->fc_replay_state;
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+
+	start = (__u8 *)fc_hdr;
+	end = (__u8 *)bh->b_data + j->j_blocksize;
+
+	/* Check if we already concluded that this fast commit is not useful */
+	if (state->fc_replay_expected_off && state->fc_replay_error)
+		goto out_err;
+
+	if (le32_to_cpu(fc_hdr->fc_magic) != EXT4_FC_MAGIC) {
+		state->fc_replay_error = -EXT2_ET_BAD_MAGIC;
+		goto out_err;
+	}
+
+	if (off != state->fc_replay_expected_off) {
+		state->fc_replay_error = -EXT2_ET_CORRUPT_JOURNAL_SB;
+		goto out_err;
+	}
+
+	state->fc_replay_expected_off++;
+
+	if (le16_to_cpu(fc_hdr->fc_features)) {
+		state->fc_replay_error = -EXT2_ET_OP_NOT_SUPPORTED;
+		goto out_err;
+	}
+
+	old_csum = fc_hdr->fc_csum;
+	fc_hdr->fc_csum = 0;
+	csum = jbd2_chksum(j, 0, start, end - start);
+	fc_hdr->fc_csum = old_csum;
+
+	if (csum != le32_to_cpu(fc_hdr->fc_csum)) {
+		state->fc_replay_error = -EXT2_ET_BAD_CRC;
+		goto out_err;
+	}
+	state->fc_num_blks++;
+	return 0;
+
+out_err:
+	return state->fc_replay_error;
+}
+
+/* Get length of a particular tlv */
+static int fc_tag_len(struct ext4_fc_tl *tl)
+{
+	return le16_to_cpu(tl->fc_len);
+}
+
+/* Get a pointer to "value" of a tlv */
+static __u8 *fc_tag_val(struct ext4_fc_tl *tl)
+{
+	return (__u8 *)tl + sizeof(*tl);
+}
+
+static int ext4_fc_handle_unlink(ext2_filsys fs, int parent_ino,
+				 const char *dname, int ino)
+{
+	struct ext2_inode inode;
+	int ret;
+
+	ret = ext2fs_unlink(fs, parent_ino, dname, ino, 0);
+	if (ret)
+		return ret;
+
+	ret = ext2fs_read_inode(fs, ino, &inode);
+	if (ret)
+		return ret;
+
+	if (inode.i_links_count > 1) {
+		inode.i_links_count--;
+		ret = ext2fs_write_inode(fs, ino, &inode);
+		if (ret)
+			return ret;
+	} else {
+		memset(&inode, 0, sizeof(inode));
+		ext2fs_write_inode(fs, ino, &inode);
+		ext2fs_unmark_inode_bitmap2(fs->inode_map, ino);
+		ext2fs_mark_ib_dirty(fs);
+	}
+
+	return 0;
+}
+
+static inline int get_fc_hdr_inode_len(ext2_filsys fs,
+				       struct ext4_fc_commit_hdr *fc_hdr)
+{
+	int inode_len = EXT2_GOOD_OLD_INODE_SIZE;
+
+	if (EXT2_INODE_SIZE(fs->super)
+			> EXT2_GOOD_OLD_INODE_SIZE)
+		inode_len +=
+			ext2fs_le16_to_cpu(((struct ext2_inode_large *)
+				(fc_hdr + 1))->i_extra_isize);
+	return inode_len;
+}
+
+static inline struct ext4_fc_tl *get_first_tl(ext2_filsys fs,
+					      struct ext4_fc_commit_hdr *fc_hdr)
+{
+	return (struct ext4_fc_tl *)((__u8 *)fc_hdr +
+				   sizeof(struct ext4_fc_commit_hdr) +
+				   get_fc_hdr_inode_len(fs, fc_hdr));
+}
+
+static inline struct ext4_fc_tl *get_next_tl(struct ext4_fc_tl *tl)
+{
+	return (struct ext4_fc_tl *)((__u8 *)tl +
+					le16_to_cpu(tl->fc_len) +
+					sizeof(*tl));
+}
+
+static inline int num_tls(struct ext4_fc_commit_hdr *fc_hdr)
+{
+	return le16_to_cpu(fc_hdr->fc_num_tlvs);
+}
+
+static int fc_replay_dentries(journal_t *j,
+			struct ext4_fc_commit_hdr *fc_hdr)
+{
+	int inode_len, ret, i;
+	struct ext4_fc_dentry_info *fcd;
+	ext2_filsys fs = j->j_fs_dev->k_ctx->fs;
+	struct ext2_inode *inode;
+	struct ext4_fc_tl *tl;
+	int parent_ino, ino;
+	char *dname;
+
+	inode_len = get_fc_hdr_inode_len(fs, fc_hdr);
+	tl = get_first_tl(fs, fc_hdr);
+	for (i = 0; i < le16_to_cpu(fc_hdr->fc_num_tlvs); i++) {
+		fcd = (struct ext4_fc_dentry_info *)fc_tag_val(tl);
+
+		parent_ino = le32_to_cpu(fcd->fc_parent_ino);
+		ino = le32_to_cpu(fcd->fc_ino);
+		dname = strndup(fcd->fc_dname, fc_tag_len(tl) -
+				sizeof(struct ext4_fc_dentry_info));
+		if (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_ADD_DENTRY) {
+			ret = ext2fs_link(fs, parent_ino, dname, ino,
+					  EXT2_FT_REG_FILE);
+			ext2fs_free_mem(&dname);
+			if (ret)
+				return ret;
+			ext2fs_mark_inode_bitmap2(
+				fs->inode_map, ino);
+			ext2fs_mark_ib_dirty(fs);
+		} else if (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_DEL_DENTRY) {
+			ret = ext4_fc_handle_unlink(fs, parent_ino, dname, ino);
+			ext2fs_free_mem(&dname);
+			if (ret)
+				return ret;
+		} else if (le16_to_cpu(tl->fc_tag) ==
+				EXT4_FC_TAG_CREAT_DENTRY) {
+			ext2fs_mark_inode_bitmap2(fs->inode_map, ino);
+			ret = ext2fs_link(fs, parent_ino, dname, ino,
+					  EXT2_FT_REG_FILE);
+			if (ret) {
+				ext2fs_free_mem(&dname);
+				return ret;
+			}
+			ext2fs_free_mem(&dname);
+
+			ret = ext2fs_get_mem(inode_len, &inode);
+			if (ret)
+				return ret;
+			ret = ext2fs_read_inode_full(fs, ino, inode, inode_len);
+			if (ret) {
+				ext2fs_free_mem(&inode);
+				return ret;
+			}
+			memcpy(inode, (struct ext2_inode *)(fc_hdr + 1),
+				inode_len);
+			ret = ext2fs_write_inode_full(fs, ino, inode,
+						      inode_len);
+			if (ret) {
+				ext2fs_free_mem(&inode);
+				return ret;
+			}
+			ext2fs_free_mem(&inode);
+			ext2fs_mark_ib_dirty(fs);
+		}
+		tl = get_next_tl(tl);
+	}
+	return 0;
+}
+
+static int ext2fs_add_extent_to_list(struct extent_list *list,
+					struct ext2fs_extent *ex)
+{
+	int ret;
+
+	if (list->count == list->size) {
+		unsigned int new_size = (list->size + NUM_EXTENTS) *
+					sizeof(struct ext2fs_extent);
+		ret = ext2fs_resize_mem(0, new_size, &list->extents);
+		if (ret)
+			return ret;
+		list->size += NUM_EXTENTS;
+	}
+
+	memcpy(list->extents + list->count, ex, sizeof(*ex));
+	list->count++;
+	return 0;
+}
+
+static int ext2fs_del_extent_from_list(struct extent_list *list,
+				       struct ext2fs_extent *del)
+{
+	struct ext2fs_extent extent;
+	int ret, i, j, del_start, del_end, iter_start, iter_end;
+
+	i = 0;
+	del_start = del->e_lblk;
+	del_end = del->e_lblk + del->e_len - 1;
+
+	while (i < list->count) {
+		iter_start = list->extents[i].e_lblk;
+		iter_end = list->extents[i].e_lblk + list->extents[i].e_len - 1;
+
+		if (del_start > iter_end || del_end < iter_start) {
+			i++;
+			continue;
+		} else if (del_start <= iter_start && del_end >= iter_end) {
+			iter_start = iter_end + 1;
+		} else if (iter_start <= del_start && del_end <= iter_end) {
+			extent.e_lblk = del_end + 1;
+			extent.e_len = iter_end - del_end;
+			extent.e_pblk = list->extents[i].e_pblk +
+					extent.e_lblk - iter_start;
+			extent.e_flags =  list->extents[i].e_flags;
+			ret = ext2fs_add_extent_to_list(list, &extent);
+			if (ret)
+				return ret;
+			iter_end = del_start - 1;
+		} else if (del_start >= iter_start && del_start <= iter_end) {
+			iter_end = del_start - 1;
+		} else if (del_end >= iter_start && del_end <= iter_end) {
+			iter_start = del_end + 1;
+		} else {
+			/* Should not come here */
+			exit(FSCK_ERROR);
+		}
+
+		if (iter_start > iter_end) {
+			/*
+			 * If this removal resulted in iter being of zero
+			 * length, remove it right away, and start the next
+			 * iteration at current index.
+			 */
+			for (j = i; j < list->count - 1; j++)
+				list->extents[j] = list->extents[j + 1];
+			list->count--;
+		} else {
+			list->extents[i].e_lblk = iter_start;
+			list->extents[i].e_len = iter_end - iter_start + 1;
+			i++;
+		}
+	}
+
+	return 0;
+}
+
+static void ext3_to_ext2fs_extent(struct ext2fs_extent *to,
+				  struct ext3_extent *from)
+{
+	to->e_pblk = ext2fs_le32_to_cpu(from->ee_start) +
+		((__u64) ext2fs_le16_to_cpu(from->ee_start_hi)
+			<< 32);
+	to->e_lblk = ext2fs_le32_to_cpu(from->ee_block);
+	to->e_len = ext2fs_le16_to_cpu(from->ee_len);
+	to->e_flags |= EXT2_EXTENT_FLAGS_LEAF;
+	if (to->e_len > EXT_INIT_MAX_LEN) {
+		to->e_len -= EXT_INIT_MAX_LEN;
+		to->e_flags |= EXT2_EXTENT_FLAGS_UNINIT;
+	}
+}
+
+static int ex_compar(const void *arg1, const void *arg2)
+{
+	struct ext2fs_extent *ex1 = (struct ext2fs_extent *)arg1;
+	struct ext2fs_extent *ex2 = (struct ext2fs_extent *)arg2;
+
+	if (ex1->e_lblk < ex2->e_lblk)
+		return -1;
+	if (ex1->e_lblk > ex2->e_lblk)
+		return 1;
+	return ex1->e_len - ex2->e_len;
+}
+
+static void sort_and_merge_extents(struct extent_list *list)
+{
+	struct ext2fs_extent *iter;
+	blk64_t ex_end;
+	int i, j;
+
+	if (list->count < 2)
+		return;
+
+	qsort(list->extents, list->count, sizeof(list->extents[0]),
+		ex_compar);
+
+	i = 0;
+	while (i < list->count - 1) {
+		if (list->extents[i].e_lblk + list->extents[i].e_len - 1 <
+			list->extents[i + 1].e_lblk) {
+			i++;
+			continue;
+		}
+		ex_end = MAX(list->extents[i].e_lblk + list->extents[i].e_len,
+			     list->extents[i + 1].e_lblk +
+			     list->extents[i + 1].e_len) - 1;
+		list->extents[i].e_len = ex_end - list->extents[i].e_lblk + 1;
+		for (j = i + 1; j < list->count - 1; j++)
+			list->extents[j] = list->extents[j + 1];
+		list->count--;
+	}
+}
+
+static void mark_blocks_used(ext2_filsys fs, blk64_t pblk, int count)
+{
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		if (ext2fs_test_block_bitmap2(fs->block_map, pblk + i))
+			continue;
+		ext2fs_mark_block_bitmap2(fs->block_map, pblk + i);
+	}
+}
+
+static void mark_blocks_free(ext2_filsys fs, blk64_t pblk, int count)
+{
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		if (!ext2fs_test_block_bitmap2(fs->block_map, pblk + i))
+			continue;
+		ext2fs_unmark_block_bitmap2(fs->block_map, pblk + i);
+	}
+}
+
+static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
+				     enum passtype pass, int off)
+{
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_fc_tl *tl;
+	struct ext3_extent *ex;
+	ext2_extent_handle_t handle = 0;
+	int i, j, ret, ino, num_extents;
+	struct ext2_inode *inode;
+	e2fsck_t ctx = journal->j_fs_dev->k_ctx;
+	struct ext2fs_extent extent;
+	struct extent_list extent_list = {0};
+	struct ext4_fc_lrange *lrange;
+	int inode_len;
+	blk64_t pblk;
+
+	if (pass == PASS_SCAN)
+		return ext4_journal_fc_replay_scan(journal, bh, off);
+	else if (pass != PASS_REPLAY)
+		return 0;
+	ctx->fc_replay_state.fc_num_blks--;
+
+	if (ctx->fc_replay_state.fc_replay_error) {
+		jfs_debug("Scan phase detected error. Aborting replay..\n");
+		return ctx->fc_replay_state.fc_replay_error;
+	}
+
+	ret = ext2fs_read_bitmaps(ctx->fs);
+	if (ret)
+		return ret;
+
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+	inode_len = get_fc_hdr_inode_len(ctx->fs, fc_hdr);
+	ret = fc_replay_dentries(journal, fc_hdr);
+	if (ret)
+		return ret;
+
+	ino = le32_to_cpu(fc_hdr->fc_ino);
+	extent_list.ino = ino;
+	ret = e2fsck_read_extents(ctx, &extent_list);
+	if (ret)
+		return ret;
+
+	tl = get_first_tl(ctx->fs, fc_hdr);
+	for (i = 0; i < num_tls(fc_hdr); i++) {
+		switch (le16_to_cpu(tl->fc_tag)) {
+		case EXT4_FC_TAG_ADD_RANGE:
+			ext3_to_ext2fs_extent(&extent,
+					      (struct ext3_extent *)(tl + 1));
+			ret = ext2fs_add_extent_to_list(&extent_list, &extent);
+			if (ret)
+				goto out;
+			mark_blocks_used(ctx->fs, extent.e_pblk,  extent.e_len);
+			break;
+		case EXT4_FC_TAG_DEL_RANGE:
+			lrange = (struct ext4_fc_lrange *)(tl + 1);
+			extent.e_lblk = ext2fs_le32_to_cpu(lrange->fc_lblk);
+			extent.e_len = ext2fs_le16_to_cpu(lrange->fc_len);
+
+			pblk = 0;
+			for (j = 0; j < extent_list.count; j++) {
+				if (extent.e_lblk >=
+				    extent_list.extents[j].e_lblk &&
+				    extent.e_lblk <
+				    extent_list.extents[j].e_lblk +
+				    extent_list.extents[j].e_len) {
+					pblk = extent_list.extents[j].e_pblk +
+						extent.e_lblk -
+						extent_list.extents[j].e_lblk;
+					break;
+				}
+			}
+			ret = ext2fs_del_extent_from_list(&extent_list,
+							  &extent);
+			if (ret)
+				goto out;
+
+			if (pblk != 0)
+				mark_blocks_free(ctx->fs, pblk, extent.e_len);
+			break;
+		default:
+			break;
+		}
+		tl = get_next_tl(tl);
+	}
+	ext2fs_mark_bb_dirty(ctx->fs);
+	sort_and_merge_extents(&extent_list);
+
+	ret = e2fsck_rewrite_extent_tree(ctx, &extent_list);
+	if (ret)
+		goto out;
+
+	ret = ext2fs_get_mem(inode_len, &inode);
+	if (ret)
+		goto out;
+	ret = ext2fs_read_inode_full(ctx->fs, ino, inode, inode_len);
+	if (ret)
+		goto out;
+
+	if (inode->i_flags & EXT4_INLINE_DATA_FL) {
+		memcpy(inode, fc_hdr + 1, inode_len);
+	} else {
+		memcpy(inode, fc_hdr + 1,
+			offsetof(struct ext2_inode_large, i_block));
+		memcpy(&inode->i_generation,
+		       &((struct ext2_inode_large *)(fc_hdr + 1))->i_generation,
+		       inode_len -
+		       offsetof(struct ext2_inode_large, i_generation));
+	}
+
+	ret = ext2fs_write_inode_full(ctx->fs, ino, inode, inode_len);
+	if (ret)
+		goto out;
+
+	if (ctx->fc_replay_state.fc_num_blks == 0) {
+		ext2fs_mark_super_dirty(ctx->fs);
+		ext2fs_write_block_bitmap(ctx->fs);
+		ext2fs_write_inode_bitmap(ctx->fs);
+		ext2fs_calculate_summary_stats(ctx->fs);
+		ext2fs_set_gdt_csum(ctx->fs);
+		ext2fs_flush(ctx->fs);
+	}
+out:
+	ext2fs_free_mem(&extent_list.extents);
+	return ret;
+}
+
 static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 {
 	struct process_block_struct pb;
@@ -514,6 +993,10 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
+	if (ext2fs_has_feature_fast_commit(ctx->fs->super))
+		journal->j_fc_replay_callback = ext4_journal_fc_replay_cb;
+	else
+		journal->j_fc_replay_callback = NULL;
 
 #ifdef USE_INODE_IO
 	if (j_inode)
@@ -688,7 +1171,13 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 	journal->j_transaction_sequence = journal->j_tail_sequence;
 	journal->j_tail = ntohl(jsb->s_start);
 	journal->j_first = ntohl(jsb->s_first);
-	journal->j_last = ntohl(jsb->s_maxlen);
+	if (jbd2_has_feature_fast_commit(journal)) {
+		journal->j_last_fc = ntohl(jsb->s_maxlen);
+		journal->j_last = journal->j_last_fc - JBD2_FAST_COMMIT_BLOCKS;
+		journal->j_first_fc = journal->j_last + 1;
+	} else {
+		journal->j_last = ntohl(jsb->s_maxlen);
+	}
 
 	return 0;
 }
diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 6c20ea77..410db16a 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -490,6 +490,52 @@ struct ext2_inode_large {
 /*9c*/	__u32   i_projid;       /* Project ID */
 };
 
+/* Fast commit stuff */
+/* Ext4 fast commit related info */
+
+/* Magic of fast commit header */
+#define EXT4_FC_MAGIC			0xE2540090
+
+struct ext4_fc_commit_hdr {
+	/* Fast commit magic, should be EXT4_FC_MAGIC */
+	__u32 fc_magic;
+	/* Features used by this fast commit block */
+	__u8 fc_features;
+	/* Number of TLVs in this fast commmit block */
+	__u16 fc_num_tlvs;
+	/* Inode number */
+	__u32 fc_ino;
+	/* Csum(hdr+contents) */
+	__u32 fc_csum;
+};
+
+struct ext4_fc_lrange {
+	__le32 fc_lblk;
+	__le32 fc_len;
+};
+
+#define EXT4_FC_TAG_ADD_RANGE		0x1
+#define EXT4_FC_TAG_DEL_RANGE		0x2
+#define EXT4_FC_TAG_CREAT_DENTRY	0x3
+#define EXT4_FC_TAG_ADD_DENTRY		0x4
+#define EXT4_FC_TAG_DEL_DENTRY		0x5
+
+struct ext4_fc_tl {
+	__le16 fc_tag;
+	__le16 fc_len;
+};
+
+/* On disk fast commit tlv value structure for dirent tags:
+ *  - EXT4_FC_TAG_CREATE_DENTRY
+ *  - EXT4_FC_TAG_ADD_DENTRY
+ *  - EXT4_FC_TAG_DEL_DENTRY
+ */
+struct ext4_fc_dentry_info {
+	__le32 fc_parent_ino;
+	__le32 fc_ino;
+	__u8 fc_dname[0];
+};
+
 #define EXT4_INODE_CSUM_HI_EXTRA_END	\
 	(offsetof(struct ext2_inode_large, i_checksum_hi) + sizeof(__u16) - \
 	 EXT2_GOOD_OLD_INODE_SIZE)
-- 
2.25.1.696.g5e7596f4ac-goog

