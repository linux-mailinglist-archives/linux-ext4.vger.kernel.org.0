Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4E2C63FA
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgK0LeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:51640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgK0LeL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E96AAE12;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D07791E132A; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 10/12] ext4: Protect superblock modifications with a buffer lock
Date:   Fri, 27 Nov 2020 12:34:03 +0100
Message-Id: <20201127113405.26867-11-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Protect all superblock modifications (including checksum computation)
with a superblock buffer lock. That way we are sure computed checksum
matches current superblock contents (a mismatch could cause checksum
failures in nojournal mode or if an unjournalled superblock update races
with a journalled one). Also we avoid modifying superblock contents
while it is being written out (which can cause DIF/DIX failures if we
are running in nojournal mode).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c |  1 -
 fs/ext4/file.c      |  3 +++
 fs/ext4/inode.c     |  3 +++
 fs/ext4/namei.c     |  6 ++++++
 fs/ext4/resize.c    | 12 ++++++++++++
 fs/ext4/super.c     |  2 +-
 fs/ext4/xattr.c     |  3 +++
 7 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 1a0a827a7f34..c7e410c4ab7d 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -379,7 +379,6 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 	struct buffer_head *bh = EXT4_SB(sb)->s_sbh;
 	int err = 0;
 
-	ext4_superblock_csum_set(sb);
 	if (ext4_handle_valid(handle)) {
 		err = jbd2_journal_dirty_metadata(handle, bh);
 		if (err)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 3ed8c048fb12..26907d5835d0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -809,8 +809,11 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
 	if (err)
 		goto out_journal;
+	lock_buffer(sbi->s_sbh);
 	strlcpy(sbi->s_es->s_last_mounted, cp,
 		sizeof(sbi->s_es->s_last_mounted));
+	ext4_superblock_csum_set(sb);
+	unlock_buffer(sbi->s_sbh);
 	ext4_handle_dirty_super(handle, sb);
 out_journal:
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3a39fa0d6a3a..72534319fae5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5141,7 +5141,10 @@ static int ext4_do_update_inode(handle_t *handle,
 		err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
 		if (err)
 			goto out_brelse;
+		lock_buffer(EXT4_SB(sb)->s_sbh);
 		ext4_set_feature_large_file(sb);
+		ext4_superblock_csum_set(sb);
+		unlock_buffer(EXT4_SB(sb)->s_sbh);
 		ext4_handle_sync(handle);
 		err = ext4_handle_dirty_super(handle, sb);
 	}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 33509266f5a0..d804505e1a32 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2982,7 +2982,10 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	    (le32_to_cpu(sbi->s_es->s_inodes_count))) {
 		/* Insert this inode at the head of the on-disk orphan list */
 		NEXT_ORPHAN(inode) = le32_to_cpu(sbi->s_es->s_last_orphan);
+		lock_buffer(sbi->s_sbh);
 		sbi->s_es->s_last_orphan = cpu_to_le32(inode->i_ino);
+		ext4_superblock_csum_set(sb);
+		unlock_buffer(sbi->s_sbh);
 		dirty = true;
 	}
 	list_add(&EXT4_I(inode)->i_orphan, &sbi->s_orphan);
@@ -3065,7 +3068,10 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 			mutex_unlock(&sbi->s_orphan_lock);
 			goto out_brelse;
 		}
+		lock_buffer(sbi->s_sbh);
 		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
+		ext4_superblock_csum_set(inode->i_sb);
+		unlock_buffer(sbi->s_sbh);
 		mutex_unlock(&sbi->s_orphan_lock);
 		err = ext4_handle_dirty_super(handle, inode->i_sb);
 	} else {
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 928700d57eb6..6155f2b9538c 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -899,7 +899,10 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	EXT4_SB(sb)->s_gdb_count++;
 	ext4_kvfree_array_rcu(o_group_desc);
 
+	lock_buffer(EXT4_SB(sb)->s_sbh);
 	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
+	ext4_superblock_csum_set(sb);
+	unlock_buffer(EXT4_SB(sb)->s_sbh);
 	err = ext4_handle_dirty_super(handle, sb);
 	if (err)
 		ext4_std_error(sb, err);
@@ -1384,6 +1387,7 @@ static void ext4_update_super(struct super_block *sb,
 	reserved_blocks *= blocks_count;
 	do_div(reserved_blocks, 100);
 
+	lock_buffer(sbi->s_sbh);
 	ext4_blocks_count_set(es, ext4_blocks_count(es) + blocks_count);
 	ext4_free_blocks_count_set(es, ext4_free_blocks_count(es) + free_blocks);
 	le32_add_cpu(&es->s_inodes_count, EXT4_INODES_PER_GROUP(sb) *
@@ -1421,6 +1425,8 @@ static void ext4_update_super(struct super_block *sb,
 	 * active. */
 	ext4_r_blocks_count_set(es, ext4_r_blocks_count(es) +
 				reserved_blocks);
+	ext4_superblock_csum_set(sb);
+	unlock_buffer(sbi->s_sbh);
 
 	/* Update the free space counts */
 	percpu_counter_add(&sbi->s_freeclusters_counter,
@@ -1717,8 +1723,11 @@ static int ext4_group_extend_no_check(struct super_block *sb,
 		goto errout;
 	}
 
+	lock_buffer(EXT4_SB(sb)->s_sbh);
 	ext4_blocks_count_set(es, o_blocks_count + add);
 	ext4_free_blocks_count_set(es, ext4_free_blocks_count(es) + add);
+	ext4_superblock_csum_set(sb);
+	unlock_buffer(EXT4_SB(sb)->s_sbh);
 	ext4_debug("freeing blocks %llu through %llu\n", o_blocks_count,
 		   o_blocks_count + add);
 	/* We add the blocks to the bitmap and set the group need init bit */
@@ -1874,10 +1883,13 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
 	if (err)
 		goto errout;
 
+	lock_buffer(sbi->s_sbh);
 	ext4_clear_feature_resize_inode(sb);
 	ext4_set_feature_meta_bg(sb);
 	sbi->s_es->s_first_meta_bg =
 		cpu_to_le32(num_desc_blocks(sb, sbi->s_groups_count));
+	ext4_superblock_csum_set(sb);
+	unlock_buffer(sbi->s_sbh);
 
 	err = ext4_handle_dirty_super(handle, sb);
 	if (err) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index aae12ea1466a..fb1d61ed7dff 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5435,6 +5435,7 @@ static int ext4_commit_super(struct super_block *sb)
 	if (!sbh || block_device_ejected(sb))
 		return error;
 
+	lock_buffer(sbh);
 	/*
 	 * If the file system is mounted read-only, don't update the
 	 * superblock write time.  This avoids updating the superblock
@@ -5502,7 +5503,6 @@ static int ext4_commit_super(struct super_block *sb)
 
 	BUFFER_TRACE(sbh, "marking dirty");
 	ext4_superblock_csum_set(sb);
-	lock_buffer(sbh);
 	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6127e94ea4f5..ab46aa447baa 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -792,7 +792,10 @@ static void ext4_xattr_update_super_block(handle_t *handle,
 
 	BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get_write_access");
 	if (ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh) == 0) {
+		lock_buffer(EXT4_SB(sb)->s_sbh);
 		ext4_set_feature_xattr(sb);
+		ext4_superblock_csum_set(sb);
+		unlock_buffer(EXT4_SB(sb)->s_sbh);
 		ext4_handle_dirty_super(handle, sb);
 	}
 }
-- 
2.16.4

