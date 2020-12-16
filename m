Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D32DBE80
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLPKTc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:19:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:48356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgLPKTc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:19:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 572CFAF22;
        Wed, 16 Dec 2020 10:18:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D28601E135C; Wed, 16 Dec 2020 11:18:49 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/8] ext4: Combine ext4_handle_error() and save_error_info()
Date:   Wed, 16 Dec 2020 11:18:37 +0100
Message-Id: <20201216101844.22917-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201216101844.22917-1-jack@suse.cz>
References: <20201216101844.22917-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

save_error_info() is always called together with ext4_handle_error().
Combine them into a single call and move unconditional bits out of
save_error_info() into ext4_handle_error().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2d7dc0908cdd..72a21f0abe87 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -592,9 +592,6 @@ static void __save_error_info(struct super_block *sb, int error,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
-	if (bdev_read_only(sb->s_bdev))
-		return;
 	/* We default to EFSCORRUPTED error... */
 	if (error == 0)
 		error = EFSCORRUPTED;
@@ -647,13 +644,19 @@ static void save_error_info(struct super_block *sb, int error,
  * used to deal with unrecoverable failures such as journal IO errors or ENOMEM
  * at a critical moment in log management.
  */
-static void ext4_handle_error(struct super_block *sb, bool force_ro)
+static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
+			      __u32 ino, __u64 block,
+			      const char *func, unsigned int line)
 {
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 
+	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
 
+	if (!bdev_read_only(sb->s_bdev))
+		save_error_info(sb, error, ino, block, func, line);
+
 	if (sb_rdonly(sb) || (!force_ro && test_opt(sb, ERRORS_CONT)))
 		return;
 
@@ -710,8 +713,7 @@ void __ext4_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, current->comm, &vaf);
 		va_end(args);
 	}
-	save_error_info(sb, error, 0, block, function, line);
-	ext4_handle_error(sb, force_ro);
+	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
 }
 
 void __ext4_error_inode(struct inode *inode, const char *function,
@@ -741,9 +743,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       current->comm, &vaf);
 		va_end(args);
 	}
-	save_error_info(inode->i_sb, error, inode->i_ino, block,
-			function, line);
-	ext4_handle_error(inode->i_sb, false);
+	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
+			  function, line);
 }
 
 void __ext4_error_file(struct file *file, const char *function,
@@ -780,9 +781,8 @@ void __ext4_error_file(struct file *file, const char *function,
 			       current->comm, path, &vaf);
 		va_end(args);
 	}
-	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
-			function, line);
-	ext4_handle_error(inode->i_sb, false);
+	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
+			  function, line);
 }
 
 const char *ext4_decode_error(struct super_block *sb, int errno,
@@ -849,8 +849,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, errstr);
 	}
 
-	save_error_info(sb, -errno, 0, 0, function, line);
-	ext4_handle_error(sb, false);
+	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
 }
 
 void __ext4_msg(struct super_block *sb,
@@ -944,13 +943,14 @@ __acquires(bitlock)
 	if (test_opt(sb, ERRORS_CONT)) {
 		if (test_opt(sb, WARN_ON_ERROR))
 			WARN_ON_ONCE(1);
+		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 		__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
-		schedule_work(&EXT4_SB(sb)->s_error_work);
+		if (!bdev_read_only(sb->s_bdev))
+			schedule_work(&EXT4_SB(sb)->s_error_work);
 		return;
 	}
 	ext4_unlock_group(sb, grp);
-	save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
-	ext4_handle_error(sb, false);
+	ext4_handle_error(sb, false, EFSCORRUPTED, ino, block, function, line);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
 	 * may be dangerous, but nothing bad will happen since the
-- 
2.16.4

