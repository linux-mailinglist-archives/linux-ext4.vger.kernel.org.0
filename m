Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7728C17D992
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgCIHGL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36829 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgCIHGK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id d9so4289733pgu.3
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sT9qOZMPivbwjeGNZnOmZDUKD6s5HxJugF+PIa37wek=;
        b=PCAM+eS74js9QxyB3SqEJU4cGFkgBbfpUm+M4a3VzwcpeTmkTWtFb1FlLlOa9yd/kf
         DRkLmdMDdoA+gWeTPtE87cOzEPaqc1m2gjU+QU9+OO0omekw7fO+DC3M84s9x23U5fHx
         /sDSo00b1Na9qkZ4VNYf/zemI7r6pCajprkLu0H0kwsxVm0+cEwQ/RAw2jU+V3ESKEBl
         MSbkLEHMnZXqHUnQjs9zJqyJVPkkqseAUM6bOz+dIC21+dT4avb9PU/arefxH+BtbnNW
         //aD18ZRFQW7W9KbcFsbEwR1Ioor1NOeRny7qtZp6EG1xho2DQOA8QVrt+Fwitt5zX7p
         rI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sT9qOZMPivbwjeGNZnOmZDUKD6s5HxJugF+PIa37wek=;
        b=FZs1rMqKiJCZmUbMTAUJgxYqF2IIloyrAVfGRcjw34ojYB3aTKPEA0PnQn7of2dd0H
         2EkQD2ViSSN+B1BmYOsfMrnPLmakVY/UOsm8EiQgeQv4eBxw6nNg8hVEjCjsv4oIrRbL
         Xti9zG/xXuHeoEDbNlSvy0mnSHKQDn6KfNKZ8e6Exm419UlqtT5CMFWwtyVcxnrjwhp0
         rPreRpL61dute1C2WhXeCr1+V5OGczFVPImfqt459LCE+BreG6FWZRxGa1iHYGb5LQ67
         BQ2ebu38D7cXzjwDiU7tA0E7JILq01JdV2qx0FJks34Xt+L6KPRTm+RmzOBJKx7pOiu6
         P0Dw==
X-Gm-Message-State: ANhLgQ1jgENZYRpqpGAFSktny8BBa97kCpp50CmdjKyBSTrt4zo5zvJh
        9bbpMGi345Sxau8pOFflUdP+fFma
X-Google-Smtp-Source: ADFU+vtLrYxWDjZJBX7WyF82hZvT8D7hvNCqDJSV1P3UCkIxoaYAK57crOcfhDJ4CZc7fFE1hKd1mQ==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr15405419pfb.118.1583737568230;
        Mon, 09 Mar 2020 00:06:08 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:07 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v5 17/20] ext4: add idempotent helpers to manipulate bitmaps
Date:   Mon,  9 Mar 2020 00:05:23 -0700
Message-Id: <20200309070526.218202-17-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For fast commit replay path, we need idempotent helpers that mark
inodes used, data blocks as used or free. It's important these are
idempotent and that's because we can crash while we are replaying.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 fs/ext4/ext4.h    |   1 +
 fs/ext4/ialloc.c  | 113 ++++++++++++++++++++++++++++++++++++++
 fs/ext4/mballoc.c | 136 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.h |   2 +
 4 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6dacbb95cc52..ca1e7f100bc3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2691,6 +2691,7 @@ extern int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 			  struct dx_hash_info *hinfo);
 
 /* ialloc.c */
+extern int ext4_mark_inode_used(struct super_block *sb, int ino);
 extern struct inode *__ext4_new_inode(handle_t *, struct inode *, umode_t,
 				      const struct qstr *qstr, __u32 goal,
 				      uid_t *owner, __u32 i_flags,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f95ee99091e4..f3c5b86c6a06 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -730,6 +730,119 @@ static int find_inode_bit(struct super_block *sb, ext4_group_t group,
 	return 1;
 }
 
+int ext4_mark_inode_used(struct super_block *sb, int ino)
+{
+	unsigned long max_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count);
+	struct buffer_head *inode_bitmap_bh = NULL, *group_desc_bh = NULL;
+	struct ext4_group_desc *gdp;
+	ext4_group_t group;
+	int bit;
+	int err = -EFSCORRUPTED;
+
+	if (ino < EXT4_FIRST_INO(sb) || ino > max_ino)
+		goto out;
+
+	group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
+	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
+	inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
+	if (IS_ERR(inode_bitmap_bh))
+		return PTR_ERR(inode_bitmap_bh);
+
+	if (ext4_test_bit(bit, inode_bitmap_bh->b_data)) {
+		err = -EEXIST;
+		goto out;
+	}
+
+	gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
+	if (!gdp || !group_desc_bh) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	ext4_set_bit(bit, inode_bitmap_bh->b_data);
+
+	BUFFER_TRACE(inode_bitmap_bh, "call ext4_handle_dirty_metadata");
+	err = ext4_handle_dirty_metadata(NULL, NULL, inode_bitmap_bh);
+	if (err) {
+		ext4_std_error(sb, err);
+		goto out;
+	}
+	sync_dirty_buffer(inode_bitmap_bh);
+	BUFFER_TRACE(group_desc_bh, "get_write_access");
+
+	/* We may have to initialize the block bitmap if it isn't already */
+	if (ext4_has_group_desc_csum(sb) &&
+	    gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+		struct buffer_head *block_bitmap_bh;
+
+		block_bitmap_bh = ext4_read_block_bitmap(sb, group);
+		if (IS_ERR(block_bitmap_bh)) {
+			err = PTR_ERR(block_bitmap_bh);
+			goto out;
+		}
+
+		BUFFER_TRACE(block_bitmap_bh, "dirty block bitmap");
+		err = ext4_handle_dirty_metadata(NULL, NULL, block_bitmap_bh);
+		sync_dirty_buffer(block_bitmap_bh);
+
+		/* recheck and clear flag under lock if we still need to */
+		ext4_lock_group(sb, group);
+		if (ext4_has_group_desc_csum(sb) &&
+		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+			ext4_free_group_clusters_set(sb, gdp,
+				ext4_free_clusters_after_init(sb, group, gdp));
+			ext4_block_bitmap_csum_set(sb, group, gdp,
+						   block_bitmap_bh);
+			ext4_group_desc_csum_set(sb, group, gdp);
+		}
+		ext4_unlock_group(sb, group);
+		brelse(block_bitmap_bh);
+
+		if (err) {
+			ext4_std_error(sb, err);
+			goto out;
+		}
+	}
+
+	/* Update the relevant bg descriptor fields */
+	if (ext4_has_group_desc_csum(sb)) {
+		int free;
+
+		ext4_lock_group(sb, group); /* while we modify the bg desc */
+		free = EXT4_INODES_PER_GROUP(sb) -
+			ext4_itable_unused_count(sb, gdp);
+		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)) {
+			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_INODE_UNINIT);
+			free = 0;
+		}
+
+		/*
+		 * Check the relative inode number against the last used
+		 * relative inode number in this group. if it is greater
+		 * we need to update the bg_itable_unused count
+		 */
+		if (bit >= free)
+			ext4_itable_unused_set(sb, gdp,
+					(EXT4_INODES_PER_GROUP(sb) - bit - 1));
+	} else {
+		ext4_lock_group(sb, group);
+	}
+
+	ext4_free_inodes_set(sb, gdp, ext4_free_inodes_count(sb, gdp) - 1);
+	if (ext4_has_group_desc_csum(sb)) {
+		ext4_inode_bitmap_csum_set(sb, group, gdp, inode_bitmap_bh,
+					   EXT4_INODES_PER_GROUP(sb) / 8);
+		ext4_group_desc_csum_set(sb, group, gdp);
+	}
+
+	ext4_unlock_group(sb, group);
+	err = ext4_handle_dirty_metadata(NULL, NULL, group_desc_bh);
+	sync_dirty_buffer(group_desc_bh);
+out:
+	return err;
+}
+
 /*
  * There are two policies for allocating an inode.  If the new inode is
  * a directory, then a forward search is made for a block group with both
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 51a78eb65f3c..96be991718f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3052,6 +3052,93 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 	return err;
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
+		sync_dirty_buffer(bitmap_bh);
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
+			     &sbi_array_rcu_deref(sbi, s_flex_groups,
+						  flex_group)->free_clusters);
+	}
+
+	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	if (err)
+		goto out_err;
+	sync_dirty_buffer(bitmap_bh);
+	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	sync_dirty_buffer(gdp_bh);
+
+out_err:
+	brelse(bitmap_bh);
+}
+
 /*
  * here we normalize request for locality group
  * Group request are normalized to s_mb_group_prealloc, which goes to
@@ -4715,6 +4802,47 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	return 0;
 }
 
+void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
+			     unsigned long count)
+{
+	struct buffer_head *bitmap_bh;
+	struct super_block *sb = inode->i_sb;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gdp_bh;
+	ext4_group_t group;
+	ext4_grpblk_t blkoff;
+	int already_freed = 0, err, i;
+
+	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
+	bitmap_bh = ext4_read_block_bitmap(sb, group);
+	if (IS_ERR(bitmap_bh)) {
+		err = PTR_ERR(bitmap_bh);
+		pr_warn("Failed to read block bitmap\n");
+		return;
+	}
+	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+	if (!gdp)
+		return;
+
+	for (i = 0; i < count; i++) {
+		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data))
+			already_freed++;
+	}
+	mb_clear_bits(bitmap_bh->b_data, blkoff, count);
+	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	if (err)
+		return;
+	ext4_free_group_clusters_set(
+		sb, gdp, ext4_free_group_clusters(sb, gdp) +
+		count - already_freed);
+	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
+	ext4_group_desc_csum_set(sb, group, gdp);
+	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	sync_dirty_buffer(bitmap_bh);
+	sync_dirty_buffer(gdp_bh);
+	brelse(bitmap_bh);
+}
+
 /**
  * ext4_free_blocks() -- Free given blocks and update quota
  * @handle:		handle for this transaction
@@ -4741,6 +4869,13 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	int err = 0;
 	int ret;
 
+	sbi = EXT4_SB(sb);
+
+	if (sbi->s_mount_state & EXT4_FC_REPLAY) {
+		ext4_free_blocks_simple(inode, block, count);
+		return;
+	}
+
 	might_sleep();
 	if (bh) {
 		if (block)
@@ -4749,7 +4884,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 			block = bh->b_blocknr;
 	}
 
-	sbi = EXT4_SB(sb);
 	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
 	    !ext4_data_block_valid(sbi, block, count)) {
 		ext4_error(sb, "Freeing blocks not in datazone - "
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
-- 
2.25.1.481.gfbce0eb801-goog

