Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B786F833
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfGVECZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45853 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfGVECX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so18540544plr.12
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1QoUqVlZU/bxuKf+44CzvtKebs7BSZ0CwKZgL0BSTg=;
        b=XZo5Acs5IiFdBDef9IhWAPP0QrkKONBDQ9gG562fcpQmFpFkTIcB8rymc341YkhUzl
         PXDqJu7eei62qXWmwbR2DNr9nzR7Lw4+5XRp1PMxBGCEGKARFKbO/i2YkeB5NfOpORCd
         Z9dqFFBZxTQ3qTL2Cr/PnIUrGnfVOzorY15nSjamoe4obyx5BDrKpFpeb87g7PUmCywr
         5kS5mLKPrd52Y6EbVX0PkFzrQwy/Z9jqtjgpqNsNFt4obXGbO1l+69sP2wM8vUG8gKDx
         9hE3nE/3R94oNoC/6qIdVuQ7Xvc3WYvMuFxT6WOkd0rVlozcf6tSWFCVP81MQMAVGKJK
         ogIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1QoUqVlZU/bxuKf+44CzvtKebs7BSZ0CwKZgL0BSTg=;
        b=XpOrtKvUu49FNOpjR9zujdI0QYh/cRdPfGmfp8tAKcG2ea/LLdPYQWQ1Hi63Wlzx+E
         X6jN6gkYqTyCMuIRDhNqrykEQA0RUPrJg9UeZKQPezrph9SzCAXq2UTC0gyRBHQTUwpw
         DYsUZ7hczji+DsnLoOmzSvurKbS3IZ3eHvWE9TkTVBMtvV73MzpM/EjTzwBLx6oFqoTT
         8bJ/1IzIDbjreKt6WY5rK8KhFffeMmEaialIlJGZbsPccmG7OCpSU/zQLBRV+ayrozw4
         4ciy9RoFTsuu7l/cByd+nntGzSlCa5Xqiu6x4oIZMnFXMsYrGdnwhxbPYhKapgBMsqol
         2S9w==
X-Gm-Message-State: APjAAAX02WQx+kVTCwygRgmIF7XbKjdYMnes1ZAb4IQom/QQhbZRIoIJ
        TdBgOmz+2YNXVfVVl64DAKv8hsGF
X-Google-Smtp-Source: APXvYqyxsUqhQYEPm/vwi+Mx2IM2545OlRci0x2xNc51wXzAE5xjXPZZprIZGacBpbvw/ROg9ufvOA==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6mr73122809plm.199.1563768142745;
        Sun, 21 Jul 2019 21:02:22 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:22 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 11/11] ext4: fast-commit recovery path changes
Date:   Sun, 21 Jul 2019 21:00:11 -0700
Message-Id: <20190722040011.18892-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds core fast-commit recovery path changes. Each fast
commit block stores modified extents for a particular file. Replay
code maps blocks in each such extent to the actual file one-by-one. We
also update corresponding file system metadata to account for newly
mapped blocks. In order to achieve all of these,
ext4_inode_csum_set(), ext4_inode_blocks() which were earlier static
are now made visible.

I updated e2fsprogs to set fast commit feature flag and to ignore fast
commit blocks during e2fsck. After applying all the patches in this
series, following runs of xfstests were performed:

- kvm-xfstest.sh -g log -c 4k
- kvm-xfstests.sh smoke

All the log tests were successful and smoke tests didn't introduce any
additional failures.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/balloc.c  |   7 ++-
 fs/ext4/ext4.h    |   4 ++
 fs/ext4/extents.c |  19 +++++---
 fs/ext4/inode.c   |   8 ++--
 fs/ext4/mballoc.c |  83 ++++++++++++++++++++++++++++++++
 fs/ext4/mballoc.h |   2 +
 fs/ext4/super.c   | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 230 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 0b202e00d93f..75c3025c7089 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -360,7 +360,12 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 				      struct buffer_head *bh)
 {
 	ext4_fsblk_t	blk;
-	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
+	struct ext4_group_info *grp;
+
+	if (EXT4_SB(sb)->fc_replay)
+		return 0;
+
+	grp = ext4_get_group_info(sb, block_group);
 
 	if (buffer_verified(bh))
 		return 0;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5d92a2e4f0af..44a4d16c241c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2577,6 +2577,10 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 
 /* inode.c */
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei);
+blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
+			   struct ext4_inode_info *ei);
 int ext4_inode_is_fast_symlink(struct inode *inode);
 struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 66f7f4fb1612..59fe596ce97d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2894,7 +2894,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	int depth = ext_depth(inode);
 	struct ext4_ext_path *path = NULL;
 	struct partial_cluster partial;
-	handle_t *handle;
+	handle_t *handle = NULL;
 	int i = 0, err = 0;
 
 	partial.pclu = 0;
@@ -2904,9 +2904,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	ext_debug("truncate since %u to %u\n", start, end);
 
 	/* probably first extent we're gonna free will be last in block */
-	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+	if (!sbi->fc_replay) {
+		handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
+		if (IS_ERR(handle))
+			return PTR_ERR(handle);
+	}
 
 again:
 	trace_ext4_ext_remove_space(inode, start, end, depth);
@@ -2926,7 +2928,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		/* find extent for or closest extent to this block */
 		path = ext4_find_extent(inode, end, NULL, EXT4_EX_NOCACHE);
 		if (IS_ERR(path)) {
-			ext4_journal_stop(handle);
+			if (!sbi->fc_replay)
+				ext4_journal_stop(handle);
 			return PTR_ERR(path);
 		}
 		depth = ext_depth(inode);
@@ -3012,7 +3015,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
 			       GFP_NOFS);
 		if (path == NULL) {
-			ext4_journal_stop(handle);
+			if (!sbi->fc_replay)
+				ext4_journal_stop(handle);
 			return -ENOMEM;
 		}
 		path[0].p_maxdepth = path[0].p_depth = depth;
@@ -3142,7 +3146,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	path = NULL;
 	if (err == -EAGAIN)
 		goto again;
-	ext4_journal_stop(handle);
+	if (!sbi->fc_replay)
+		ext4_journal_stop(handle);
 
 	return err;
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index dd5d39a48363..21c9b5197c72 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -103,8 +103,8 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
 	return provided == calculated;
 }
 
-static void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
-				struct ext4_inode_info *ei)
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei)
 {
 	__u32 csum;
 
@@ -4801,8 +4801,8 @@ void ext4_set_inode_flags(struct inode *inode)
 			S_ENCRYPTED|S_CASEFOLD);
 }
 
-static blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
-				  struct ext4_inode_info *ei)
+blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
+			   struct ext4_inode_info *ei)
 {
 	blkcnt_t i_blocks ;
 	struct inode *inode = &(ei->vfs_inode);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a3e2767bdf2f..70551fa91237 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2915,6 +2915,89 @@ void ext4_exit_mballoc(void)
 }
 
 
+void ext4_mb_mark_used(struct super_block *sb, ext4_fsblk_t block,
+		       int len)
+{
+	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gdp_bh;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_group_t group;
+	ext4_fsblk_t cluster;
+	ext4_grpblk_t blkoff;
+	int i, clen, err;
+	int already_allocated_count;
+
+	cluster = EXT4_B2C(sbi, block);
+	clen = EXT4_B2C(sbi, len);
+
+	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
+	bitmap_bh = ext4_read_block_bitmap(sb, group);
+	if (IS_ERR(bitmap_bh)) {
+		err = PTR_ERR(bitmap_bh);
+		bitmap_bh = NULL;
+		goto out_err;
+	}
+
+	err = -EIO;
+	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+	if (!gdp)
+		goto out_err;
+
+	if (!ext4_data_block_valid(sbi, block, len)) {
+		ext4_error(sb, "Allocating blks %llu-%llu which overlap mdata",
+			   cluster, cluster+clen);
+		/* File system mounted not to panic on error
+		 * Fix the bitmap and return EFSCORRUPTED
+		 * We leak some of the blocks here.
+		 */
+		ext4_lock_group(sb, group);
+		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
+		ext4_unlock_group(sb, group);
+		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+		if (!err)
+			err = -EFSCORRUPTED;
+		goto out_err;
+	}
+
+	ext4_lock_group(sb, group);
+	already_allocated_count = 0;
+	for (i = 0; i < clen; i++)
+		if (mb_test_bit(blkoff + i, bitmap_bh->b_data))
+			already_allocated_count++;
+
+	ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+		ext4_free_group_clusters_set(sb, gdp,
+					     ext4_free_clusters_after_init(sb,
+						group, gdp));
+	}
+	clen = ext4_free_group_clusters(sb, gdp) - clen +
+	       already_allocated_count;
+	ext4_free_group_clusters_set(sb, gdp, clen);
+	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
+	ext4_group_desc_csum_set(sb, group, gdp);
+
+	ext4_unlock_group(sb, group);
+
+	if (sbi->s_log_groups_per_flex) {
+		ext4_group_t flex_group = ext4_flex_group(sbi, group);
+
+		atomic64_sub(len,
+			     &sbi->s_flex_groups[flex_group].free_clusters);
+	}
+
+	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	if (err)
+		goto out_err;
+	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+
+out_err:
+	brelse(bitmap_bh);
+}
+
 /*
  * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
  * Returns 0 if success or error code
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..1881710041b6 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -215,4 +215,6 @@ ext4_mballoc_query_range(
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 
+void ext4_mb_mark_used(struct super_block *sb, ext4_fsblk_t block,
+		       int len);
 #endif
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a291d41b91de..f38ff2089389 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -408,6 +408,118 @@ static int block_device_ejected(struct super_block *sb)
 	return bdi->dev == NULL;
 }
 
+static void ext4_fc_add_block(struct inode *inode, ext4_lblk_t lblk,
+			      ext4_fsblk_t pblk, int unwritten)
+{
+	struct ext4_extent ex;
+	struct ext4_ext_path *path = NULL;
+	struct ext4_map_blocks map;
+	int ret;
+
+	map.m_lblk = lblk;
+	map.m_len = 0x1;
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret > 0) {
+		if (pblk != map.m_pblk)
+			jbd_debug(1, "Bad mapping found while replaying fc\n");
+		return;
+	}
+
+	ex.ee_block = cpu_to_le32(lblk);
+	ext4_ext_store_pblock(&ex, pblk);
+	ex.ee_len = cpu_to_le32(0x1);
+	if (unwritten)
+		ext4_ext_mark_unwritten(&ex);
+
+	path = ext4_find_extent(inode, lblk, NULL, 0);
+	if (path) {
+		down_write(&EXT4_I(inode)->i_data_sem);
+		ret = ext4_ext_insert_extent(NULL, inode, &path, &ex, 0);
+		ext4_mb_mark_used(inode->i_sb, ext4_ext_pblock(&ex), 0x1);
+		up_write((&EXT4_I(inode)->i_data_sem));
+		kfree(path);
+	}
+}
+
+static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_fc_tl *tl;
+	struct ext4_iloc iloc;
+	struct ext4_extent *ex;
+	struct inode *inode;
+	int ret;
+
+	sbi->fc_replay = true;
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+
+	jbd_debug(3, "%s: Got FC block for inode %d at [%d,%d]", __func__,
+	       le32_to_cpu(fc_hdr->fc_ino), le32_to_cpu(fc_hdr->fc_tid),
+	       le32_to_cpu(fc_hdr->fc_subtid));
+
+	inode = ext4_iget(sb, le32_to_cpu(fc_hdr->fc_ino), EXT4_IGET_NORMAL);
+	if (IS_ERR(inode))
+		return 0;
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+	tl = (struct ext4_fc_tl *)(fc_hdr + 1);
+	while (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_EXT) {
+		int i;
+
+		ex = (struct ext4_extent *)(tl + 1);
+		tl = (struct ext4_fc_tl *)((__u8 *)tl +
+					   le16_to_cpu(tl->fc_len) +
+					   sizeof(*tl));
+		/*
+		 * We add block by block because part of extent may already have
+		 * been added by a previous fast commit replay.
+		 */
+		for (i = 0; i < ext4_ext_get_actual_len(ex); i++)
+			ext4_fc_add_block(inode, le32_to_cpu(ex->ee_block) + i,
+					  ext4_ext_pblock(ex) + i,
+					  ext4_ext_is_unwritten(ex));
+	}
+
+	/*
+	 * Unless inode contains inline data, copy everything except
+	 * i_blocks. i_blocks would have been set alright by ext4_fc_add_block
+	 * call above.
+	 */
+	if (ext4_has_inline_data(inode)) {
+		memcpy(ext4_raw_inode(&iloc), &fc_hdr->inode,
+		       sizeof(struct ext4_inode));
+	} else {
+		memcpy(ext4_raw_inode(&iloc), &fc_hdr->inode,
+		       offsetof(struct ext4_inode, i_block));
+		memcpy(&ext4_raw_inode(&iloc)->i_generation,
+		       &fc_hdr->inode.i_generation,
+		       sizeof(struct ext4_inode) -
+		       offsetof(struct ext4_inode, i_generation));
+	}
+
+	ext4_reserve_inode_write(NULL, inode, &iloc);
+	inode_unlock(inode);
+	sbi->fc_replay = false;
+
+	ext4_inode_csum_set(inode, ext4_raw_inode(&iloc), EXT4_I(inode));
+	ret = ext4_handle_dirty_metadata(NULL, inode, iloc.bh);
+	iput(inode);
+	if (!ret)
+		ret = blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
+
+	brelse(iloc.bh);
+
+	return ret;
+}
+
+
 static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 {
 	struct super_block		*sb = journal->j_private;
@@ -4935,6 +5047,13 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 		journal->j_fc_commit_callback = ext4_journal_fc_commit_cb;
 		journal->j_fc_cleanup_callback = ext4_journal_fc_cleanup_cb;
 	}
+
+	/*
+	 * We set replay callback even if fast commit disabled because we may
+	 * could still have fast commit blocks that need to be replayed even if
+	 * fast commit has now been turned off.
+	 */
+	journal->j_fc_replay_callback = ext4_journal_fc_replay_cb;
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
 		journal->j_flags |= JBD2_BARRIER;
-- 
2.22.0.657.g960e92d24f-goog

