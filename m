Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D053163CBE
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 06:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgBSFgO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 00:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgBSFgO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Feb 2020 00:36:14 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47BD208E4;
        Wed, 19 Feb 2020 05:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582090572;
        bh=e0Cbx4Y/0HF9Ys6mGp50PBENB4CAkfGTgfPH+PphYTI=;
        h=From:To:Cc:Subject:Date:From;
        b=B9ad5jWPtJDRc0ApX8snPQCZueliKnC/UeZbLggKxXno38/bKgGwfSj9X3tHKSABw
         MFmF7JYw6tSVffrXcVytOf6QalKqpTjyz9rk59QJj6M3NsUTcmifEOSL0Mp4f8tG//
         T9ztvyqJv5vTAad9FaH8ipFPNa0IKZILmgWIsLUs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH v2] ext4: fix race between writepages and enabling EXT4_EXTENTS_FL
Date:   Tue, 18 Feb 2020 21:35:23 -0800
Message-Id: <20200219053523.87474-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If EXT4_EXTENTS_FL is set on an inode while ext4_writepages() is running
on it, the following warning in ext4_add_complete_io() can be hit:

WARNING: CPU: 1 PID: 0 at fs/ext4/page-io.c:234 ext4_put_io_end_defer+0xf0/0x120

Here's a minimal reproducer (not 100% reliable) (root isn't required):

        while true; do
                sync
        done &
        while true; do
                rm -f file
                touch file
                chattr -e file
                echo X >> file
                chattr +e file
        done

The problem is that in ext4_writepages(), ext4_should_dioread_nolock()
(which only returns true on extent-based files) is checked once to set
the number of reserved journal credits, and also again later to select
the flags for ext4_map_blocks() and copy the reserved journal handle to
ext4_io_end::handle.  But if EXT4_EXTENTS_FL is being concurrently set,
the first check can see dioread_nolock disabled while the later one can
see it enabled, causing the reserved handle to unexpectedly be NULL.

Since changing EXT4_EXTENTS_FL is uncommon, and there may be other races
related to doing so as well, fix this by synchronizing changing
EXT4_EXTENTS_FL with ext4_writepages() via the existing
s_journal_flag_rwsem -- renamed to s_writepages_rwsem.

This was originally reported by syzbot without a reproducer at
https://syzkaller.appspot.com/bug?extid=2202a584a00fffd19fbf,
but now that dioread_nolock is the default I also started seeing this
when running syzkaller locally.

Reported-by: syzbot+2202a584a00fffd19fbf@syzkaller.appspotmail.com
Fixes: 6b523df4fb5a ("ext4: use transaction reservation for extent conversion in ext4_end_io")
Cc: stable@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: Instead of making ext4_writepages() read EXT4_EXTENTS_FL only once,
    make it so that EXT4_EXTENTS_FL can't be changed while
    ext4_writepages() is running.

 fs/ext4/ext4.h    |  7 +++++--
 fs/ext4/inode.c   | 14 +++++++-------
 fs/ext4/migrate.c | 27 +++++++++++++++++++--------
 fs/ext4/super.c   |  6 +++---
 4 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4441331d06cc4..0a59006c621a0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1552,8 +1552,11 @@ struct ext4_sb_info {
 	struct ratelimit_state s_warning_ratelimit_state;
 	struct ratelimit_state s_msg_ratelimit_state;
 
-	/* Barrier between changing inodes' journal flags and writepages ops. */
-	struct percpu_rw_semaphore s_journal_flag_rwsem;
+	/*
+	 * Barrier between writepages ops and changing any inode's JOURNAL_DATA
+	 * or EXTENTS flag.
+	 */
+	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
 #ifdef CONFIG_EXT4_DEBUG
 	unsigned long s_simulate_fail;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e60aca791d3f1..3b782eecf6563 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2628,7 +2628,7 @@ static int ext4_writepages(struct address_space *mapping,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_journal_flag_rwsem);
+	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	/*
@@ -2849,7 +2849,7 @@ static int ext4_writepages(struct address_space *mapping,
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_journal_flag_rwsem);
+	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
@@ -2864,13 +2864,13 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
-	percpu_down_read(&sbi->s_journal_flag_rwsem);
+	percpu_down_read(&sbi->s_writepages_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
-	percpu_up_read(&sbi->s_journal_flag_rwsem);
+	percpu_up_read(&sbi->s_writepages_rwsem);
 	return ret;
 }
 
@@ -5861,7 +5861,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		}
 	}
 
-	percpu_down_write(&sbi->s_journal_flag_rwsem);
+	percpu_down_write(&sbi->s_writepages_rwsem);
 	jbd2_journal_lock_updates(journal);
 
 	/*
@@ -5878,7 +5878,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 		err = jbd2_journal_flush(journal);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
-			percpu_up_write(&sbi->s_journal_flag_rwsem);
+			percpu_up_write(&sbi->s_writepages_rwsem);
 			return err;
 		}
 		ext4_clear_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
@@ -5886,7 +5886,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	ext4_set_aops(inode);
 
 	jbd2_journal_unlock_updates(journal);
-	percpu_up_write(&sbi->s_journal_flag_rwsem);
+	percpu_up_write(&sbi->s_writepages_rwsem);
 
 	if (val)
 		up_write(&EXT4_I(inode)->i_mmap_sem);
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 89725fa425732..fb6520f371355 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -407,6 +407,7 @@ static int free_ext_block(handle_t *handle, struct inode *inode)
 
 int ext4_ext_migrate(struct inode *inode)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	handle_t *handle;
 	int retval = 0, i;
 	__le32 *i_data;
@@ -431,6 +432,8 @@ int ext4_ext_migrate(struct inode *inode)
 		 */
 		return retval;
 
+	percpu_down_write(&sbi->s_writepages_rwsem);
+
 	/*
 	 * Worst case we can touch the allocation bitmaps, a bgd
 	 * block, and a block to link in the orphan list.  We do need
@@ -441,7 +444,7 @@ int ext4_ext_migrate(struct inode *inode)
 
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
-		return retval;
+		goto out_unlock;
 	}
 	goal = (((inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode->i_sb)) *
 		EXT4_INODES_PER_GROUP(inode->i_sb)) + 1;
@@ -452,7 +455,7 @@ int ext4_ext_migrate(struct inode *inode)
 	if (IS_ERR(tmp_inode)) {
 		retval = PTR_ERR(tmp_inode);
 		ext4_journal_stop(handle);
-		return retval;
+		goto out_unlock;
 	}
 	i_size_write(tmp_inode, i_size_read(inode));
 	/*
@@ -494,7 +497,7 @@ int ext4_ext_migrate(struct inode *inode)
 		 */
 		ext4_orphan_del(NULL, tmp_inode);
 		retval = PTR_ERR(handle);
-		goto out;
+		goto out_tmp_inode;
 	}
 
 	ei = EXT4_I(inode);
@@ -576,10 +579,11 @@ int ext4_ext_migrate(struct inode *inode)
 	ext4_ext_tree_init(handle, tmp_inode);
 out_stop:
 	ext4_journal_stop(handle);
-out:
+out_tmp_inode:
 	unlock_new_inode(tmp_inode);
 	iput(tmp_inode);
-
+out_unlock:
+	percpu_up_write(&sbi->s_writepages_rwsem);
 	return retval;
 }
 
@@ -589,7 +593,8 @@ int ext4_ext_migrate(struct inode *inode)
 int ext4_ind_migrate(struct inode *inode)
 {
 	struct ext4_extent_header	*eh;
-	struct ext4_super_block		*es = EXT4_SB(inode->i_sb)->s_es;
+	struct ext4_sb_info		*sbi = EXT4_SB(inode->i_sb);
+	struct ext4_super_block		*es = sbi->s_es;
 	struct ext4_inode_info		*ei = EXT4_I(inode);
 	struct ext4_extent		*ex;
 	unsigned int			i, len;
@@ -613,9 +618,13 @@ int ext4_ind_migrate(struct inode *inode)
 	if (test_opt(inode->i_sb, DELALLOC))
 		ext4_alloc_da_blocks(inode);
 
+	percpu_down_write(&sbi->s_writepages_rwsem);
+
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto out_unlock;
+	}
 
 	down_write(&EXT4_I(inode)->i_data_sem);
 	ret = ext4_ext_check_inode(inode);
@@ -650,5 +659,7 @@ int ext4_ind_migrate(struct inode *inode)
 errout:
 	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+out_unlock:
+	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f464dff097748..f504c30170233 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1054,7 +1054,7 @@ static void ext4_put_super(struct super_block *sb)
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(get_qf_name(sb, sbi, i));
@@ -4594,7 +4594,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
 					  GFP_KERNEL);
 	if (!err)
-		err = percpu_init_rwsem(&sbi->s_journal_flag_rwsem);
+		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
 
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "insufficient memory");
@@ -4688,7 +4688,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
-	percpu_free_rwsem(&sbi->s_journal_flag_rwsem);
+	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 failed_mount5:
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);
-- 
2.25.0

