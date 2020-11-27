Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E82C63F9
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgK0LeM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:51622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbgK0LeL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56662ADCA;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C46581E1325; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/12] ext4: Defer saving error info from atomic context
Date:   Fri, 27 Nov 2020 12:34:00 +0100
Message-Id: <20201127113405.26867-8-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When filesystem inconsistency is detected with group locked, we
currently try to modify superblock to store error there without
blocking. However this can cause superblock checksum failures (or
DIF/DIX failure) when the superblock is just being written out.

Make error handling code just store error information in ext4_sb_info
structure and copy it to on-disk superblock only in ext4_commit_super().
In case of error happening with group locked, we just postpone the
superblock flushing to a workqueue.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  21 +++++++++++
 fs/ext4/super.c | 115 ++++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 99 insertions(+), 37 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e67291c4a10b..09959ee0c9e2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1619,6 +1619,27 @@ struct ext4_sb_info {
 	errseq_t s_bdev_wb_err;
 	spinlock_t s_bdev_wb_lock;
 
+	/* Information about errors that happened during this mount */
+	spinlock_t s_error_lock;
+	int s_add_error_count;
+	int s_first_error_code;
+	__u32 s_first_error_line;
+	__u32 s_first_error_ino;
+	__u64 s_first_error_block;
+	const char *s_first_error_func;
+	time64_t s_first_error_time;
+	int s_last_error_code;
+	__u32 s_last_error_line;
+	__u32 s_last_error_ino;
+	__u64 s_last_error_block;
+	const char *s_last_error_func;
+	time64_t s_last_error_time;
+	/*
+	 * If we are in a context where we cannot update error information in
+	 * the on-disk superblock, we queue this work to do it.
+	 */
+	struct work_struct s_error_work;
+
 	/* Ext4 fast commit stuff */
 	atomic_t s_fc_subtid;
 	atomic_t s_fc_ineligible_updates;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8add06d08495..2d7dc0908cdd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -404,10 +404,8 @@ void ext4_itable_unused_set(struct super_block *sb,
 		bg->bg_itable_unused_hi = cpu_to_le16(count >> 16);
 }
 
-static void __ext4_update_tstamp(__le32 *lo, __u8 *hi)
+static void __ext4_update_tstamp(__le32 *lo, __u8 *hi, time64_t now)
 {
-	time64_t now = ktime_get_real_seconds();
-
 	now = clamp_val(now, 0, (1ull << 40) - 1);
 
 	*lo = cpu_to_le32(lower_32_bits(now));
@@ -419,7 +417,8 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
 	return ((time64_t)(*hi) << 32) + le32_to_cpu(*lo);
 }
 #define ext4_update_tstamp(es, tstamp) \
-	__ext4_update_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
+	__ext4_update_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi, \
+			     ktime_get_real_seconds())
 #define ext4_get_tstamp(es, tstamp) \
 	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
 
@@ -591,7 +590,7 @@ static void __save_error_info(struct super_block *sb, int error,
 			      __u32 ino, __u64 block,
 			      const char *func, unsigned int line)
 {
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 	if (bdev_read_only(sb->s_bdev))
@@ -599,30 +598,24 @@ static void __save_error_info(struct super_block *sb, int error,
 	/* We default to EFSCORRUPTED error... */
 	if (error == 0)
 		error = EFSCORRUPTED;
-	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
-	ext4_update_tstamp(es, s_last_error_time);
-	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
-	es->s_last_error_line = cpu_to_le32(line);
-	es->s_last_error_ino = cpu_to_le32(ino);
-	es->s_last_error_block = cpu_to_le64(block);
-	es->s_last_error_errcode = ext4_errno_to_code(error);
-	if (!es->s_first_error_time) {
-		es->s_first_error_time = es->s_last_error_time;
-		es->s_first_error_time_hi = es->s_last_error_time_hi;
-		strncpy(es->s_first_error_func, func,
-			sizeof(es->s_first_error_func));
-		es->s_first_error_line = cpu_to_le32(line);
-		es->s_first_error_ino = es->s_last_error_ino;
-		es->s_first_error_block = es->s_last_error_block;
-		es->s_first_error_errcode = es->s_last_error_errcode;
-	}
-	/*
-	 * Start the daily error reporting function if it hasn't been
-	 * started already
-	 */
-	if (!es->s_error_count)
-		mod_timer(&EXT4_SB(sb)->s_err_report, jiffies + 24*60*60*HZ);
-	le32_add_cpu(&es->s_error_count, 1);
+
+	spin_lock(&sbi->s_error_lock);
+	sbi->s_add_error_count++;
+	sbi->s_last_error_code = error;
+	sbi->s_last_error_line = line;
+	sbi->s_last_error_ino = ino;
+	sbi->s_last_error_block = block;
+	sbi->s_last_error_func = func;
+	sbi->s_last_error_time = ktime_get_real_seconds();
+	if (!sbi->s_first_error_time) {
+		sbi->s_first_error_code = error;
+		sbi->s_first_error_line = line;
+		sbi->s_first_error_ino = ino;
+		sbi->s_first_error_block = block;
+		sbi->s_first_error_func = func;
+		sbi->s_first_error_time = sbi->s_last_error_time;
+	}
+	spin_unlock(&sbi->s_error_lock);
 }
 
 static void save_error_info(struct super_block *sb, int error,
@@ -685,6 +678,14 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro)
 	sb->s_flags |= SB_RDONLY;
 }
 
+static void flush_stashed_error_work(struct work_struct *work)
+{
+	struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
+						s_error_work);
+
+	ext4_commit_super(sbi->s_sb, 1);
+}
+
 #define ext4_error_ratelimit(sb)					\
 		___ratelimit(&(EXT4_SB(sb)->s_err_ratelimit_state),	\
 			     "EXT4-fs error")
@@ -925,8 +926,6 @@ __acquires(bitlock)
 		return;
 
 	trace_ext4_error(sb, function, line);
-	__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
-
 	if (ext4_error_ratelimit(sb)) {
 		va_start(args, fmt);
 		vaf.fmt = fmt;
@@ -942,16 +941,15 @@ __acquires(bitlock)
 		va_end(args);
 	}
 
-	if (test_opt(sb, WARN_ON_ERROR))
-		WARN_ON_ONCE(1);
-
 	if (test_opt(sb, ERRORS_CONT)) {
-		ext4_commit_super(sb, 0);
+		if (test_opt(sb, WARN_ON_ERROR))
+			WARN_ON_ONCE(1);
+		__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
+		schedule_work(&EXT4_SB(sb)->s_error_work);
 		return;
 	}
-
 	ext4_unlock_group(sb, grp);
-	ext4_commit_super(sb, 1);
+	save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
 	ext4_handle_error(sb, false);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
@@ -1124,6 +1122,7 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_unregister_li_request(sb);
 	ext4_quota_off_umount(sb);
 
+	flush_work(&sbi->s_error_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
 
 	/*
@@ -4661,6 +4660,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
+	spin_lock_init(&sbi->s_error_lock);
+	INIT_WORK(&sbi->s_error_work, flush_stashed_error_work);
 
 	/* Register extent status tree shrinker */
 	if (ext4_es_register_shrinker(sbi))
@@ -5427,6 +5428,7 @@ static int ext4_load_journal(struct super_block *sb,
 
 static int ext4_commit_super(struct super_block *sb, int sync)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct buffer_head *sbh = EXT4_SB(sb)->s_sbh;
 	int error = 0;
@@ -5463,6 +5465,42 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 		es->s_free_inodes_count =
 			cpu_to_le32(percpu_counter_sum_positive(
 				&EXT4_SB(sb)->s_freeinodes_counter));
+	/* Copy error information to the on-disk superblock */
+	spin_lock(&sbi->s_error_lock);
+	if (sbi->s_add_error_count > 0) {
+		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
+		__ext4_update_tstamp(&es->s_first_error_time,
+				     &es->s_first_error_time_hi,
+				     sbi->s_first_error_time);
+		strncpy(es->s_first_error_func, sbi->s_first_error_func,
+			sizeof(es->s_first_error_func));
+		es->s_first_error_line = cpu_to_le32(sbi->s_first_error_line);
+		es->s_first_error_ino = cpu_to_le32(sbi->s_first_error_ino);
+		es->s_first_error_block = cpu_to_le64(sbi->s_first_error_block);
+		es->s_first_error_errcode =
+				ext4_errno_to_code(sbi->s_first_error_code);
+
+		__ext4_update_tstamp(&es->s_last_error_time,
+				     &es->s_last_error_time_hi,
+				     sbi->s_last_error_time);
+		strncpy(es->s_last_error_func, sbi->s_last_error_func,
+			sizeof(es->s_last_error_func));
+		es->s_last_error_line = cpu_to_le32(sbi->s_last_error_line);
+		es->s_last_error_ino = cpu_to_le32(sbi->s_last_error_ino);
+		es->s_last_error_block = cpu_to_le64(sbi->s_last_error_block);
+		es->s_last_error_errcode =
+				ext4_errno_to_code(sbi->s_last_error_code);
+		/*
+		 * Start the daily error reporting function if it hasn't been
+		 * started already
+		 */
+		if (!es->s_error_count)
+			mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);
+		le32_add_cpu(&es->s_error_count, sbi->s_add_error_count);
+		sbi->s_add_error_count = 0;
+	}
+	spin_unlock(&sbi->s_error_lock);
+
 	BUFFER_TRACE(sbh, "marking dirty");
 	ext4_superblock_csum_set(sb);
 	if (sync)
@@ -5816,6 +5854,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		set_task_ioprio(sbi->s_journal->j_task, journal_ioprio);
 	}
 
+	/* Flush outstanding errors before changing fs state */
+	flush_work(&sbi->s_error_work);
+
 	if ((bool)(*flags & SB_RDONLY) != sb_rdonly(sb)) {
 		if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED)) {
 			err = -EROFS;
-- 
2.16.4

