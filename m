Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4D2C63F5
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgK0LeL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:51618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgK0LeL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54FD4ADB3;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C06701E1323; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 06/12] ext4: Simplify ext4 error translation
Date:   Fri, 27 Nov 2020 12:33:59 +0100
Message-Id: <20201127113405.26867-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We convert errno's to ext4 on-disk format error codes in
save_error_info(). Add a function and a bit of macro magic to make this
simpler.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 95 ++++++++++++++++++++++++---------------------------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7948c07d0a90..8add06d08495 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -551,76 +551,61 @@ static bool system_going_down(void)
 		|| system_state == SYSTEM_RESTART;
 }
 
+struct ext4_err_translation {
+	int code;
+	int errno;
+};
+
+#define EXT4_ERR_TRANSLATE(err) { .code = EXT4_ERR_##err, .errno = err }
+
+static struct ext4_err_translation err_translation[] = {
+	EXT4_ERR_TRANSLATE(EIO),
+	EXT4_ERR_TRANSLATE(ENOMEM),
+	EXT4_ERR_TRANSLATE(EFSBADCRC),
+	EXT4_ERR_TRANSLATE(EFSCORRUPTED),
+	EXT4_ERR_TRANSLATE(ENOSPC),
+	EXT4_ERR_TRANSLATE(ENOKEY),
+	EXT4_ERR_TRANSLATE(EROFS),
+	EXT4_ERR_TRANSLATE(EFBIG),
+	EXT4_ERR_TRANSLATE(EEXIST),
+	EXT4_ERR_TRANSLATE(ERANGE),
+	EXT4_ERR_TRANSLATE(EOVERFLOW),
+	EXT4_ERR_TRANSLATE(EBUSY),
+	EXT4_ERR_TRANSLATE(ENOTDIR),
+	EXT4_ERR_TRANSLATE(ENOTEMPTY),
+	EXT4_ERR_TRANSLATE(ESHUTDOWN),
+	EXT4_ERR_TRANSLATE(EFAULT),
+};
+
+static int ext4_errno_to_code(int errno)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(err_translation); i++)
+		if (err_translation[i].errno == errno)
+			return err_translation[i].code;
+	return EXT4_ERR_UNKNOWN;
+}
+
 static void __save_error_info(struct super_block *sb, int error,
 			      __u32 ino, __u64 block,
 			      const char *func, unsigned int line)
 {
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
-	int err;
 
 	EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
 	if (bdev_read_only(sb->s_bdev))
 		return;
+	/* We default to EFSCORRUPTED error... */
+	if (error == 0)
+		error = EFSCORRUPTED;
 	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
 	ext4_update_tstamp(es, s_last_error_time);
 	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
 	es->s_last_error_line = cpu_to_le32(line);
 	es->s_last_error_ino = cpu_to_le32(ino);
 	es->s_last_error_block = cpu_to_le64(block);
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
+	es->s_last_error_errcode = ext4_errno_to_code(error);
 	if (!es->s_first_error_time) {
 		es->s_first_error_time = es->s_last_error_time;
 		es->s_first_error_time_hi = es->s_last_error_time_hi;
-- 
2.16.4

