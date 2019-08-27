Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944F09DB82
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 04:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfH0CGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 22:06:06 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60831 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728457AbfH0CGG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 22:06:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TaZ3A8h_1566871552;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TaZ3A8h_1566871552)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 10:05:52 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
        Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/3] Revert "ext4: remove EXT4_STATE_DIOREAD_LOCK flag"
Date:   Tue, 27 Aug 2019 10:05:50 +0800
Message-Id: <1566871552-60946-2-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
References: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This reverts commit 1d39834fba99 ("ext4: remove EXT4_STATE_DIOREAD_LOCK
flag").
It is related to the following revert 16c54688592c ("ext4: Allow
parallel DIO reads") which causes significant performance regression in
mixed random read/write scenario.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ext4/ext4.h        | 17 +++++++++++++++++
 fs/ext4/extents.c     | 19 ++++++++++++++-----
 fs/ext4/inode.c       |  8 ++++++++
 fs/ext4/ioctl.c       |  4 ++++
 fs/ext4/move_extent.c |  4 ++++
 fs/ext4/super.c       | 12 +++++++-----
 6 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa..1d616d4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1557,6 +1557,8 @@ enum {
 	EXT4_STATE_EXT_MIGRATE,		/* Inode is migrating */
 	EXT4_STATE_DIO_UNWRITTEN,	/* need convert on dio done*/
 	EXT4_STATE_NEWENTRY,		/* File just added to dir */
+	EXT4_STATE_DIOREAD_LOCK,	/* Disable support for dio read
+					   nolocking */
 	EXT4_STATE_MAY_INLINE_DATA,	/* may have in-inode data */
 	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
@@ -3300,6 +3302,21 @@ static inline void set_bitmap_uptodate(struct buffer_head *bh)
 	set_bit(BH_BITMAP_UPTODATE, &(bh)->b_state);
 }
 
+/*
+ * Disable DIO read nolock optimization, so new dioreaders will be forced
+ * to grab i_mutex
+ */
+static inline void ext4_inode_block_unlocked_dio(struct inode *inode)
+{
+	ext4_set_inode_state(inode, EXT4_STATE_DIOREAD_LOCK);
+	smp_mb();
+}
+static inline void ext4_inode_resume_unlocked_dio(struct inode *inode)
+{
+	smp_mb();
+	ext4_clear_inode_state(inode, EXT4_STATE_DIOREAD_LOCK);
+}
+
 #define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
 
 /* For ioend & aio unwritten conversion wait queues */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92266a2..ded1334 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4711,6 +4711,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
 
 	/* Wait all existing dio workers, newcomers will block on i_mutex */
+	ext4_inode_block_unlocked_dio(inode);
 	inode_dio_wait(inode);
 
 	/* Preallocate the range including the unaligned edges */
@@ -4721,7 +4722,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 				 round_down(offset, 1 << blkbits)) >> blkbits,
 				new_size, flags);
 		if (ret)
-			goto out_mutex;
+			goto out_dio;
 
 	}
 
@@ -4745,7 +4746,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		ret = ext4_update_disksize_before_punch(inode, offset, len);
 		if (ret) {
 			up_write(&EXT4_I(inode)->i_mmap_sem);
-			goto out_mutex;
+			goto out_dio;
 		}
 		/* Now release the pages and zero block aligned part of pages */
 		truncate_pagecache_range(inode, start, end - 1);
@@ -4755,10 +4756,10 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 					     flags);
 		up_write(&EXT4_I(inode)->i_mmap_sem);
 		if (ret)
-			goto out_mutex;
+			goto out_dio;
 	}
 	if (!partial_begin && !partial_end)
-		goto out_mutex;
+		goto out_dio;
 
 	/*
 	 * In worst case we have to writeout two nonadjacent unwritten
@@ -4771,7 +4772,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		ext4_std_error(inode->i_sb, ret);
-		goto out_mutex;
+		goto out_dio;
 	}
 
 	inode->i_mtime = inode->i_ctime = current_time(inode);
@@ -4796,6 +4797,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		ext4_handle_sync(handle);
 
 	ext4_journal_stop(handle);
+out_dio:
+	ext4_inode_resume_unlocked_dio(inode);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -4883,9 +4886,11 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_mutex */
+	ext4_inode_block_unlocked_dio(inode);
 	inode_dio_wait(inode);
 
 	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
+	ext4_inode_resume_unlocked_dio(inode);
 	if (ret)
 		goto out;
 
@@ -5411,6 +5416,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	}
 
 	/* Wait for existing dio to complete */
+	ext4_inode_block_unlocked_dio(inode);
 	inode_dio_wait(inode);
 
 	/*
@@ -5492,6 +5498,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_mmap:
 	up_write(&EXT4_I(inode)->i_mmap_sem);
+	ext4_inode_resume_unlocked_dio(inode);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5564,6 +5571,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	}
 
 	/* Wait for existing dio to complete */
+	ext4_inode_block_unlocked_dio(inode);
 	inode_dio_wait(inode);
 
 	/*
@@ -5670,6 +5678,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_mmap:
 	up_write(&EXT4_I(inode)->i_mmap_sem);
+	ext4_inode_resume_unlocked_dio(inode);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3d..0f505f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4337,6 +4337,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_mutex */
+	ext4_inode_block_unlocked_dio(inode);
 	inode_dio_wait(inode);
 
 	/*
@@ -4414,6 +4415,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	ext4_journal_stop(handle);
 out_dio:
 	up_write(&EXT4_I(inode)->i_mmap_sem);
+	ext4_inode_resume_unlocked_dio(inode);
 out_mutex:
 	inode_unlock(inode);
 	return ret;
@@ -5623,7 +5625,9 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			 * Blocks are going to be removed from the inode. Wait
 			 * for dio in flight.
 			 */
+			ext4_inode_block_unlocked_dio(inode);
 			inode_dio_wait(inode);
+			ext4_inode_resume_unlocked_dio(inode);
 		}
 
 		down_write(&EXT4_I(inode)->i_mmap_sem);
@@ -6138,6 +6142,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		return -EROFS;
 
 	/* Wait for all existing dio workers */
+	ext4_inode_block_unlocked_dio(inode);
 	inode_dio_wait(inode);
 
 	/*
@@ -6153,6 +6158,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		err = filemap_write_and_wait(inode->i_mapping);
 		if (err < 0) {
 			up_write(&EXT4_I(inode)->i_mmap_sem);
+			ext4_inode_resume_unlocked_dio(inode);
 			return err;
 		}
 	}
@@ -6175,6 +6181,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
 			percpu_up_write(&sbi->s_journal_flag_rwsem);
+			ext4_inode_resume_unlocked_dio(inode);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -6186,6 +6193,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 
 	if (val)
 		up_write(&EXT4_I(inode)->i_mmap_sem);
+	ext4_inode_resume_unlocked_dio(inode);
 
 	/* Finally we can mark the inode as dirty. */
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 442f7ef..bce15d8 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -154,6 +154,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 		goto err_out;
 
 	/* Wait for all existing dio workers */
+	ext4_inode_block_unlocked_dio(inode);
+	ext4_inode_block_unlocked_dio(inode_bl);
 	inode_dio_wait(inode);
 	inode_dio_wait(inode_bl);
 
@@ -252,6 +254,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 err_out:
 	up_write(&EXT4_I(inode)->i_mmap_sem);
 journal_err_out:
+	ext4_inode_resume_unlocked_dio(inode);
+	ext4_inode_resume_unlocked_dio(inode_bl);
 	unlock_two_nondirectories(inode, inode_bl);
 	iput(inode_bl);
 	return err;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 30ce3dc..47f5cd0 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -603,6 +603,8 @@
 	lock_two_nondirectories(orig_inode, donor_inode);
 
 	/* Wait for all existing dio workers */
+	ext4_inode_block_unlocked_dio(orig_inode);
+	ext4_inode_block_unlocked_dio(donor_inode);
 	inode_dio_wait(orig_inode);
 	inode_dio_wait(donor_inode);
 
@@ -693,6 +695,8 @@
 	ext4_ext_drop_refs(path);
 	kfree(path);
 	ext4_double_up_write_data_sem(orig_inode, donor_inode);
+	ext4_inode_resume_unlocked_dio(orig_inode);
+	ext4_inode_resume_unlocked_dio(donor_inode);
 	unlock_two_nondirectories(orig_inode, donor_inode);
 
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605..2768a2a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -102,13 +102,15 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
  *   i_data_sem (rw)
  *
  * truncate:
- * sb_start_write -> i_mutex -> i_mmap_sem (w) -> i_mmap_rwsem (w) -> page lock
- * sb_start_write -> i_mutex -> i_mmap_sem (w) -> transaction start ->
- *   i_data_sem (rw)
+ * sb_start_write -> i_mutex -> EXT4_STATE_DIOREAD_LOCK (w) -> i_mmap_sem (w) ->
+ *   i_mmap_rwsem (w) -> page lock
+ * sb_start_write -> i_mutex -> EXT4_STATE_DIOREAD_LOCK (w) -> i_mmap_sem (w) ->
+ *   transaction start -> i_data_sem (rw)
  *
  * direct IO:
- * sb_start_write -> i_mutex -> mmap_sem
- * sb_start_write -> i_mutex -> transaction start -> i_data_sem (rw)
+ * sb_start_write -> i_mutex -> EXT4_STATE_DIOREAD_LOCK (r) -> mmap_sem
+ * sb_start_write -> i_mutex -> EXT4_STATE_DIOREAD_LOCK (r) ->
+ *   transaction start -> i_data_sem (rw)
  *
  * writepages:
  * transaction start -> page lock(s) -> i_data_sem (rw)
-- 
1.8.3.1

