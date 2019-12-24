Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC8129EE3
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfLXIPH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38586 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfLXIPC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:15:02 -0500
Received: by mail-pj1-f66.google.com with SMTP id l35so906961pje.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbOlDnxV+GK1aaD0Bt/PhJHkCAy3ZyRqlyL+k1KTE1U=;
        b=iPR8OYGXoQBWQ01vLlCdoIpypDwiQbRbgHdSfunL3TSDKUy8/bUaoWlHSQYcnH8KfS
         SSbJ+H4w+6sENjaeQEfCgI5Cf5mbm+qoP1Q+leEnrzdA6vu6RarHVvg6JFDxMJwzPE2n
         atUfNPDS7h8NRlifsDLz2pc3kBuDkzJDhmMfMiUb0aPlkDJMj+IX5dwKioMpUbOmn9aF
         63o1CLaI1oGGhxUCnl8HptE8T+5U6PH+EnNYFIM8SH/6FGGLq3M0YAH9Fn9vGgoYDuPJ
         8IvKkQ0CURBo6oUuNbW10vIBPTWG5Scmh7/Xn2zsWuIQNzpIwwnvqXqGSfFHw4x76oow
         uhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbOlDnxV+GK1aaD0Bt/PhJHkCAy3ZyRqlyL+k1KTE1U=;
        b=V+4seGnWVpxsKlQrXUEfo+b2QCiwK7xOk/a8cxFeHGMHaqTuCarQbVzMrhROEURzUN
         gPXBSWXyyr2a6yd5VwZPZ44OpkVSrLAT0cfX4Reqev94z6/SNVhgJ6PhB1UbgHfanJ+/
         VcjhW/qF5WROrZtLnmGEYuxnI3adNN7J8x9NQeDAwqk0Cmjuq/68DM7xnbyPTz8GcAdG
         ehscosVJQW9iJQA2b32dMa89znKNOUC4cSBcZdGPCXWb/9xD20cekw9vPrC120baCJrZ
         av9A5Dy3Hu2LjkzDiFdaEKIPn7Vdii4Qkg+CYRnRh1p2TYVSBubbbMsK0n0nMvr5Zpls
         6POw==
X-Gm-Message-State: APjAAAVVyzALxxUIwzz6XiaLrerJLGLKHUqQsnAxTRdYcseg1pvPF3CX
        2FSILLsl8/c5l5vE/KOHQZzmKSJU
X-Google-Smtp-Source: APXvYqyW+JlJTvVCI9FN4exa3X+oORSQS8vI5QIYp38MC3zdylZrFZSRTmXGo5nFtnaVw3zG+YwxKA==
X-Received: by 2002:a17:90a:3243:: with SMTP id k61mr4427257pjb.46.1577175301676;
        Tue, 24 Dec 2019 00:15:01 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:15:01 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 17/20] ext4: add idempotent helpers to manipulate bitmaps
Date:   Tue, 24 Dec 2019 00:13:21 -0800
Message-Id: <20191224081324.95807-17-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
---
 fs/ext4/ext4.h    |   1 +
 fs/ext4/ialloc.c  | 113 ++++++++++++++++++++++++++++++++++++++
 fs/ext4/mballoc.c | 135 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.h |   2 +
 4 files changed, 250 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f2603deefe51..1957f30a7f2e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2601,6 +2601,7 @@ extern int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 			  struct dx_hash_info *hinfo);
 
 /* ialloc.c */
+extern int ext4_mark_inode_used(struct super_block *sb, int ino);
 extern struct inode *__ext4_new_inode(handle_t *, struct inode *, umode_t,
 				      const struct qstr *qstr, __u32 goal,
 				      uid_t *owner, __u32 i_flags,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 764ff4c56233..f1a1432f9ffa 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -729,6 +729,119 @@ static int find_inode_bit(struct super_block *sb, ext4_group_t group,
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
index a3e2767bdf2f..05ca9001f8fa 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3033,6 +3033,92 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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
+			     &sbi->s_flex_groups[flex_group].free_clusters);
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
@@ -4692,6 +4778,47 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
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
@@ -4718,6 +4845,13 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
@@ -4726,7 +4860,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
2.24.1.735.g03f4e72817-goog

