Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466012C63F3
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgK0LeK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:51582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgK0LeJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 375B1ADAA;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B61551E131F; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/12] ext4: Make ext4_abort() use __ext4_error()
Date:   Fri, 27 Nov 2020 12:33:57 +0100
Message-Id: <20201127113405.26867-5-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The only difference between __ext4_abort() and __ext4_error() is that
the former one ignores errors=continue mount option. Unify the code to
reduce duplication.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h      | 29 ++++++++----------
 fs/ext4/ext4_jbd2.c |  4 +--
 fs/ext4/inode.c     |  2 +-
 fs/ext4/super.c     | 84 ++++++++++++++---------------------------------------
 4 files changed, 37 insertions(+), 82 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 65ecaf96d0a4..e67291c4a10b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2952,9 +2952,9 @@ extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     ext4_group_t block_group,
 					     unsigned int flags);
 
-extern __printf(6, 7)
-void __ext4_error(struct super_block *, const char *, unsigned int, int, __u64,
-		  const char *, ...);
+extern __printf(7, 8)
+void __ext4_error(struct super_block *, const char *, unsigned int, bool,
+		  int, __u64, const char *, ...);
 extern __printf(6, 7)
 void __ext4_error_inode(struct inode *, const char *, unsigned int,
 			ext4_fsblk_t, int, const char *, ...);
@@ -2963,9 +2963,6 @@ void __ext4_error_file(struct file *, const char *, unsigned int, ext4_fsblk_t,
 		     const char *, ...);
 extern void __ext4_std_error(struct super_block *, const char *,
 			     unsigned int, int);
-extern __printf(5, 6)
-void __ext4_abort(struct super_block *, const char *, unsigned int, int,
-		  const char *, ...);
 extern __printf(4, 5)
 void __ext4_warning(struct super_block *, const char *, unsigned int,
 		    const char *, ...);
@@ -2995,6 +2992,9 @@ void __ext4_grp_locked_error(const char *, unsigned int,
 #define EXT4_ERROR_FILE(file, block, fmt, a...)				\
 	ext4_error_file((file), __func__, __LINE__, (block), (fmt), ## a)
 
+#define ext4_abort(sb, err, fmt, a...)					\
+	__ext4_error((sb), __func__, __LINE__, true, (err), 0, (fmt), ## a)
+
 #ifdef CONFIG_PRINTK
 
 #define ext4_error_inode(inode, func, line, block, fmt, ...)		\
@@ -3005,11 +3005,11 @@ void __ext4_grp_locked_error(const char *, unsigned int,
 #define ext4_error_file(file, func, line, block, fmt, ...)		\
 	__ext4_error_file(file, func, line, block, fmt, ##__VA_ARGS__)
 #define ext4_error(sb, fmt, ...)					\
-	__ext4_error((sb), __func__, __LINE__, 0, 0, (fmt), ##__VA_ARGS__)
+	__ext4_error((sb), __func__, __LINE__, false, 0, 0, (fmt),	\
+		##__VA_ARGS__)
 #define ext4_error_err(sb, err, fmt, ...)				\
-	__ext4_error((sb), __func__, __LINE__, (err), 0, (fmt), ##__VA_ARGS__)
-#define ext4_abort(sb, err, fmt, ...)					\
-	__ext4_abort((sb), __func__, __LINE__, (err), (fmt), ##__VA_ARGS__)
+	__ext4_error((sb), __func__, __LINE__, false, (err), 0, (fmt),	\
+		##__VA_ARGS__)
 #define ext4_warning(sb, fmt, ...)					\
 	__ext4_warning(sb, __func__, __LINE__, fmt, ##__VA_ARGS__)
 #define ext4_warning_inode(inode, fmt, ...)				\
@@ -3042,17 +3042,12 @@ do {									\
 #define ext4_error(sb, fmt, ...)					\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
-	__ext4_error(sb, "", 0, 0, 0, " ");				\
+	__ext4_error(sb, "", 0, false, 0, 0, " ");			\
 } while (0)
 #define ext4_error_err(sb, err, fmt, ...)				\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
-	__ext4_error(sb, "", 0, err, 0, " ");				\
-} while (0)
-#define ext4_abort(sb, err, fmt, ...)					\
-do {									\
-	no_printk(fmt, ##__VA_ARGS__);					\
-	__ext4_abort(sb, "", 0, err, " ");				\
+	__ext4_error(sb, "", 0, false, err, 0, " ");			\
 } while (0)
 #define ext4_warning(sb, fmt, ...)					\
 do {									\
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0fd0c42a4f7d..1a0a827a7f34 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -296,8 +296,8 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	if (err) {
 		ext4_journal_abort_handle(where, line, __func__,
 					  bh, handle, err);
-		__ext4_abort(inode->i_sb, where, line, -err,
-			   "error %d when attempting revoke", err);
+		__ext4_error(inode->i_sb, where, line, true, -err, 0,
+			     "error %d when attempting revoke", err);
 	}
 	BUFFER_TRACE(bh, "exit");
 	return err;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0d8385aea898..3a39fa0d6a3a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4610,7 +4610,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
 		if (flags & EXT4_IGET_HANDLE)
 			return ERR_PTR(-ESTALE);
-		__ext4_error(sb, function, line, EFSCORRUPTED, 0,
+		__ext4_error(sb, function, line, false, EFSCORRUPTED, 0,
 			     "inode #%lu: comm %s: iget: illegal inode #",
 			     ino, current->comm);
 		return ERR_PTR(-EFSCORRUPTED);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 61e6e5f156f3..dddaadc55475 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -662,16 +662,21 @@ static bool system_going_down(void)
  * We'll just use the jbd2_journal_abort() error code to record an error in
  * the journal instead.  On recovery, the journal will complain about
  * that error until we've noted it down and cleared it.
+ *
+ * If force_ro is set, we unconditionally force the filesystem into an
+ * ABORT|READONLY state, unless the error response on the fs has been set to
+ * panic in which case we take the easy way out and panic immediately. This is
+ * used to deal with unrecoverable failures such as journal IO errors or ENOMEM
+ * at a critical moment in log management.
  */
-
-static void ext4_handle_error(struct super_block *sb)
+static void ext4_handle_error(struct super_block *sb, bool force_ro)
 {
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
 
-	if (sb_rdonly(sb) || test_opt(sb, ERRORS_CONT))
+	if (sb_rdonly(sb) || (!force_ro && test_opt(sb, ERRORS_CONT)))
 		return;
 
 	ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
@@ -682,18 +687,17 @@ static void ext4_handle_error(struct super_block *sb)
 	 * could panic during 'reboot -f' as the underlying device got already
 	 * disabled.
 	 */
-	if (test_opt(sb, ERRORS_RO) || system_going_down()) {
-		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
-		/*
-		 * Make sure updated value of ->s_mount_flags will be visible
-		 * before ->s_flags update
-		 */
-		smp_wmb();
-		sb->s_flags |= SB_RDONLY;
-	} else if (test_opt(sb, ERRORS_PANIC)) {
+	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
 		panic("EXT4-fs (device %s): panic forced after error\n",
 			sb->s_id);
 	}
+	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
+	/*
+	 * Make sure updated value of ->s_mount_flags will be visible before
+	 * ->s_flags update
+	 */
+	smp_wmb();
+	sb->s_flags |= SB_RDONLY;
 }
 
 #define ext4_error_ratelimit(sb)					\
@@ -701,7 +705,7 @@ static void ext4_handle_error(struct super_block *sb)
 			     "EXT4-fs error")
 
 void __ext4_error(struct super_block *sb, const char *function,
-		  unsigned int line, int error, __u64 block,
+		  unsigned int line, bool force_ro, int error, __u64 block,
 		  const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -721,7 +725,7 @@ void __ext4_error(struct super_block *sb, const char *function,
 		va_end(args);
 	}
 	save_error_info(sb, error, 0, block, function, line);
-	ext4_handle_error(sb);
+	ext4_handle_error(sb, force_ro);
 }
 
 void __ext4_error_inode(struct inode *inode, const char *function,
@@ -753,7 +757,7 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 	}
 	save_error_info(inode->i_sb, error, inode->i_ino, block,
 			function, line);
-	ext4_handle_error(inode->i_sb);
+	ext4_handle_error(inode->i_sb, false);
 }
 
 void __ext4_error_file(struct file *file, const char *function,
@@ -792,7 +796,7 @@ void __ext4_error_file(struct file *file, const char *function,
 	}
 	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
 			function, line);
-	ext4_handle_error(inode->i_sb);
+	ext4_handle_error(inode->i_sb, false);
 }
 
 const char *ext4_decode_error(struct super_block *sb, int errno,
@@ -860,51 +864,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 	}
 
 	save_error_info(sb, -errno, 0, 0, function, line);
-	ext4_handle_error(sb);
-}
-
-/*
- * ext4_abort is a much stronger failure handler than ext4_error.  The
- * abort function may be used to deal with unrecoverable failures such
- * as journal IO errors or ENOMEM at a critical moment in log management.
- *
- * We unconditionally force the filesystem into an ABORT|READONLY state,
- * unless the error response on the fs has been set to panic in which
- * case we take the easy way out and panic immediately.
- */
-
-void __ext4_abort(struct super_block *sb, const char *function,
-		  unsigned int line, int error, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
-		return;
-
-	save_error_info(sb, error, 0, 0, function, line);
-	va_start(args, fmt);
-	vaf.fmt = fmt;
-	vaf.va = &args;
-	printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: %pV\n",
-	       sb->s_id, function, line, &vaf);
-	va_end(args);
-
-	if (sb_rdonly(sb) == 0) {
-		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
-		if (EXT4_SB(sb)->s_journal)
-			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
-
-		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
-		/*
-		 * Make sure updated value of ->s_mount_flags will be visible
-		 * before ->s_flags update
-		 */
-		smp_wmb();
-		sb->s_flags |= SB_RDONLY;
-	}
-	if (test_opt(sb, ERRORS_PANIC) && !system_going_down())
-		panic("EXT4-fs panic from previous error\n");
+	ext4_handle_error(sb, false);
 }
 
 void __ext4_msg(struct super_block *sb,
@@ -1007,7 +967,7 @@ __acquires(bitlock)
 
 	ext4_unlock_group(sb, grp);
 	ext4_commit_super(sb, 1);
-	ext4_handle_error(sb);
+	ext4_handle_error(sb, false);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
 	 * may be dangerous, but nothing bad will happen since the
-- 
2.16.4

