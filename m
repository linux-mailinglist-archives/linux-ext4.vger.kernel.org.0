Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B742C63F8
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgK0LeM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:51628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbgK0LeL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E889ADD9;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D55E21E132C; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 11/12] ext4: Save error info to sb through journal if available
Date:   Fri, 27 Nov 2020 12:34:04 +0100
Message-Id: <20201127113405.26867-12-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If journalling is still working at the moment we get to writing error
information to the superblock we cannot write directly to the superblock
as such write could race with journalled update of the superblock and
cause journal checksum failures, writing inconsistent information to the
journal or other problems. We cannot journal the superblock directly
from the error handling functions as we are running in uncertain context
and could deadlock so just punt journalled superblock update to a
workqueue.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 97 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fb1d61ed7dff..51670258ef84 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -65,6 +65,7 @@ static struct ratelimit_state ext4_mount_msg_ratelimit;
 static int ext4_load_journal(struct super_block *, struct ext4_super_block *,
 			     unsigned long journal_devnum);
 static int ext4_show_options(struct seq_file *seq, struct dentry *root);
+static void ext4_update_super(struct super_block *sb);
 static int ext4_commit_super(struct super_block *sb);
 static int ext4_mark_recovery_complete(struct super_block *sb,
 					struct ext4_super_block *es);
@@ -586,9 +587,9 @@ static int ext4_errno_to_code(int errno)
 	return EXT4_ERR_UNKNOWN;
 }
 
-static void __save_error_info(struct super_block *sb, int error,
-			      __u32 ino, __u64 block,
-			      const char *func, unsigned int line)
+static void save_error_info(struct super_block *sb, int error,
+			    __u32 ino, __u64 block,
+			    const char *func, unsigned int line)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
@@ -615,15 +616,6 @@ static void __save_error_info(struct super_block *sb, int error,
 	spin_unlock(&sbi->s_error_lock);
 }
 
-static void save_error_info(struct super_block *sb, int error,
-			    __u32 ino, __u64 block,
-			    const char *func, unsigned int line)
-{
-	__save_error_info(sb, error, ino, block, func, line);
-	if (!bdev_read_only(sb->s_bdev))
-		ext4_commit_super(sb);
-}
-
 /* Deal with the reporting of failure conditions on a filesystem such as
  * inconsistencies detected or read IO failures.
  *
@@ -649,20 +641,35 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 			      const char *func, unsigned int line)
 {
 	journal_t *journal = EXT4_SB(sb)->s_journal;
+	bool continue_fs = !force_ro && test_opt(sb, ERRORS_CONT);
 
 	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
 
-	if (!bdev_read_only(sb->s_bdev))
+	if (!continue_fs && !sb_rdonly(sb)) {
+		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
+		if (journal)
+			jbd2_journal_abort(journal, -EIO);
+	}
+
+	if (!bdev_read_only(sb->s_bdev)) {
 		save_error_info(sb, error, ino, block, func, line);
+		/*
+		 * In case the fs should keep running, we need to writeout
+		 * superblock through the journal. Due to lock ordering
+		 * constraints, it may not be safe to do it right here so we
+		 * defer superblock flushing to a workqueue.
+		 */
+		if (continue_fs)
+			schedule_work(&EXT4_SB(sb)->s_error_work);
+		else
+			ext4_commit_super(sb);
+	}
 
-	if (sb_rdonly(sb) || (!force_ro && test_opt(sb, ERRORS_CONT)))
+	if (sb_rdonly(sb) || continue_fs)
 		return;
 
-	ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
-	if (journal)
-		jbd2_journal_abort(journal, -EIO);
 	/*
 	 * We force ERRORS_RO behavior when system is rebooting. Otherwise we
 	 * could panic during 'reboot -f' as the underlying device got already
@@ -685,7 +692,38 @@ static void flush_stashed_error_work(struct work_struct *work)
 {
 	struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
 						s_error_work);
+	journal_t *journal = sbi->s_journal;
+	handle_t *handle;
 
+	/*
+	 * If the journal is still running, we have to write out superblock
+	 * through the journal to avoid collisions of other journalled sb
+	 * updates.
+	 *
+	 * We use directly jbd2 functions here to avoid recursing back into
+	 * ext4 error handling code during handling of previous errors.
+	 */
+	if (!sb_rdonly(sbi->s_sb) && journal) {
+		handle = jbd2_journal_start(journal, 1);
+		if (IS_ERR(handle))
+			goto write_directly;
+		if (jbd2_journal_get_write_access(handle, sbi->s_sbh)) {
+			jbd2_journal_stop(handle);
+			goto write_directly;
+		}
+		ext4_update_super(sbi->s_sb);
+		if (jbd2_journal_dirty_metadata(handle, sbi->s_sbh)) {
+			jbd2_journal_stop(handle);
+			goto write_directly;
+		}
+		jbd2_journal_stop(handle);
+		return;
+	}
+write_directly:
+	/*
+	 * Write through journal failed. Write sb directly to get error info
+	 * out and hope for the best.
+	 */
 	ext4_commit_super(sbi->s_sb);
 }
 
@@ -944,7 +982,7 @@ __acquires(bitlock)
 		if (test_opt(sb, WARN_ON_ERROR))
 			WARN_ON_ONCE(1);
 		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
-		__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
+		save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
 		schedule_work(&EXT4_SB(sb)->s_error_work);
 		return;
 	}
@@ -5425,15 +5463,12 @@ static int ext4_load_journal(struct super_block *sb,
 	return err;
 }
 
-static int ext4_commit_super(struct super_block *sb)
+/* Copy state of EXT4_SB(sb) into buffer for on-disk superblock */
+static void ext4_update_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
-	int error = 0;
-
-	if (!sbh || block_device_ejected(sb))
-		return error;
 
 	lock_buffer(sbh);
 	/*
@@ -5501,8 +5536,20 @@ static int ext4_commit_super(struct super_block *sb)
 	}
 	spin_unlock(&sbi->s_error_lock);
 
-	BUFFER_TRACE(sbh, "marking dirty");
 	ext4_superblock_csum_set(sb);
+	unlock_buffer(sbh);
+}
+
+static int ext4_commit_super(struct super_block *sb)
+{
+	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
+	int error = 0;
+
+	if (!sbh || block_device_ejected(sb))
+		return error;
+
+	ext4_update_super(sb);
+
 	if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
@@ -5517,8 +5564,8 @@ static int ext4_commit_super(struct super_block *sb)
 		clear_buffer_write_io_error(sbh);
 		set_buffer_uptodate(sbh);
 	}
+	BUFFER_TRACE(sbh, "marking dirty");
 	mark_buffer_dirty(sbh);
-	unlock_buffer(sbh);
 	error = __sync_dirty_buffer(sbh,
 		REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
 	if (buffer_write_io_error(sbh)) {
-- 
2.16.4

