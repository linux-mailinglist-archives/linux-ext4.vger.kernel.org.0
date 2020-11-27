Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B542C63F6
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgK0LeL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:51626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729330AbgK0LeK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5BF32ADD5;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BAE2B1E1321; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/12] ext4: Move functions in super.c
Date:   Fri, 27 Nov 2020 12:33:58 +0100
Message-Id: <20201127113405.26867-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Just move error info related functions in super.c close to
ext4_handle_error(). We'll want to combine save_error_info() with
ext4_handle_error() and this makes change more obvious and saves a
forward declaration as well. No functional change.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 196 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 98 insertions(+), 98 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dddaadc55475..7948c07d0a90 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -423,104 +423,6 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
 #define ext4_get_tstamp(es, tstamp) \
 	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
 
-static void __save_error_info(struct super_block *sb, int error,
-			      __u32 ino, __u64 block,
-			      const char *func, unsigned int line)
-{
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
-	int err;
-
-	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
-	if (bdev_read_only(sb->s_bdev))
-		return;
-	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
-	ext4_update_tstamp(es, s_last_error_time);
-	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
-	es->s_last_error_line = cpu_to_le32(line);
-	es->s_last_error_ino = cpu_to_le32(ino);
-	es->s_last_error_block = cpu_to_le64(block);
-	switch (error) {
-	case EIO:
-		err = EXT4_ERR_EIO;
-		break;
-	case ENOMEM:
-		err = EXT4_ERR_ENOMEM;
-		break;
-	case EFSBADCRC:
-		err = EXT4_ERR_EFSBADCRC;
-		break;
-	case 0:
-	case EFSCORRUPTED:
-		err = EXT4_ERR_EFSCORRUPTED;
-		break;
-	case ENOSPC:
-		err = EXT4_ERR_ENOSPC;
-		break;
-	case ENOKEY:
-		err = EXT4_ERR_ENOKEY;
-		break;
-	case EROFS:
-		err = EXT4_ERR_EROFS;
-		break;
-	case EFBIG:
-		err = EXT4_ERR_EFBIG;
-		break;
-	case EEXIST:
-		err = EXT4_ERR_EEXIST;
-		break;
-	case ERANGE:
-		err = EXT4_ERR_ERANGE;
-		break;
-	case EOVERFLOW:
-		err = EXT4_ERR_EOVERFLOW;
-		break;
-	case EBUSY:
-		err = EXT4_ERR_EBUSY;
-		break;
-	case ENOTDIR:
-		err = EXT4_ERR_ENOTDIR;
-		break;
-	case ENOTEMPTY:
-		err = EXT4_ERR_ENOTEMPTY;
-		break;
-	case ESHUTDOWN:
-		err = EXT4_ERR_ESHUTDOWN;
-		break;
-	case EFAULT:
-		err = EXT4_ERR_EFAULT;
-		break;
-	default:
-		err = EXT4_ERR_UNKNOWN;
-	}
-	es->s_last_error_errcode = err;
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
-}
-
-static void save_error_info(struct super_block *sb, int error,
-			    __u32 ino, __u64 block,
-			    const char *func, unsigned int line)
-{
-	__save_error_info(sb, error, ino, block, func, line);
-	if (!bdev_read_only(sb->s_bdev))
-		ext4_commit_super(sb, 1);
-}
-
 /*
  * The del_gendisk() function uninitializes the disk-specific data
  * structures, including the bdi structure, without telling anyone
@@ -649,6 +551,104 @@ static bool system_going_down(void)
 		|| system_state == SYSTEM_RESTART;
 }
 
+static void __save_error_info(struct super_block *sb, int error,
+			      __u32 ino, __u64 block,
+			      const char *func, unsigned int line)
+{
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	int err;
+
+	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
+	if (bdev_read_only(sb->s_bdev))
+		return;
+	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
+	ext4_update_tstamp(es, s_last_error_time);
+	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
+	es->s_last_error_line = cpu_to_le32(line);
+	es->s_last_error_ino = cpu_to_le32(ino);
+	es->s_last_error_block = cpu_to_le64(block);
+	switch (error) {
+	case EIO:
+		err = EXT4_ERR_EIO;
+		break;
+	case ENOMEM:
+		err = EXT4_ERR_ENOMEM;
+		break;
+	case EFSBADCRC:
+		err = EXT4_ERR_EFSBADCRC;
+		break;
+	case 0:
+	case EFSCORRUPTED:
+		err = EXT4_ERR_EFSCORRUPTED;
+		break;
+	case ENOSPC:
+		err = EXT4_ERR_ENOSPC;
+		break;
+	case ENOKEY:
+		err = EXT4_ERR_ENOKEY;
+		break;
+	case EROFS:
+		err = EXT4_ERR_EROFS;
+		break;
+	case EFBIG:
+		err = EXT4_ERR_EFBIG;
+		break;
+	case EEXIST:
+		err = EXT4_ERR_EEXIST;
+		break;
+	case ERANGE:
+		err = EXT4_ERR_ERANGE;
+		break;
+	case EOVERFLOW:
+		err = EXT4_ERR_EOVERFLOW;
+		break;
+	case EBUSY:
+		err = EXT4_ERR_EBUSY;
+		break;
+	case ENOTDIR:
+		err = EXT4_ERR_ENOTDIR;
+		break;
+	case ENOTEMPTY:
+		err = EXT4_ERR_ENOTEMPTY;
+		break;
+	case ESHUTDOWN:
+		err = EXT4_ERR_ESHUTDOWN;
+		break;
+	case EFAULT:
+		err = EXT4_ERR_EFAULT;
+		break;
+	default:
+		err = EXT4_ERR_UNKNOWN;
+	}
+	es->s_last_error_errcode = err;
+	if (!es->s_first_error_time) {
+		es->s_first_error_time = es->s_last_error_time;
+		es->s_first_error_time_hi = es->s_last_error_time_hi;
+		strncpy(es->s_first_error_func, func,
+			sizeof(es->s_first_error_func));
+		es->s_first_error_line = cpu_to_le32(line);
+		es->s_first_error_ino = es->s_last_error_ino;
+		es->s_first_error_block = es->s_last_error_block;
+		es->s_first_error_errcode = es->s_last_error_errcode;
+	}
+	/*
+	 * Start the daily error reporting function if it hasn't been
+	 * started already
+	 */
+	if (!es->s_error_count)
+		mod_timer(&EXT4_SB(sb)->s_err_report, jiffies + 24*60*60*HZ);
+	le32_add_cpu(&es->s_error_count, 1);
+}
+
+static void save_error_info(struct super_block *sb, int error,
+			    __u32 ino, __u64 block,
+			    const char *func, unsigned int line)
+{
+	__save_error_info(sb, error, ino, block, func, line);
+	if (!bdev_read_only(sb->s_bdev))
+		ext4_commit_super(sb, 1);
+}
+
 /* Deal with the reporting of failure conditions on a filesystem such as
  * inconsistencies detected or read IO failures.
  *
-- 
2.16.4

