Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A287CAA0BD
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Sep 2019 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfIELB1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Sep 2019 07:01:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34497 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfIELB1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Sep 2019 07:01:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id r12so1530088pfh.1
        for <linux-ext4@vger.kernel.org>; Thu, 05 Sep 2019 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JDgg8KBOxvXDHJNAWkPu62lUH+4hfzE7VSC0izh4Ku0=;
        b=fGsELJH4TMwHdRC/5cKYQybY4P31+zg7c7hb/IC6taNXrPvkNfj8pOIUZwao5A+Obr
         EQTBndMWd9xUga/D6tH2majv5WS70t9FFG2PwXHebUwGONqySVu4VTKNmTdJqZVQhJbp
         Fun4uqGn3s0LffZ7Q1Oa+IbbvYbuOhos1skqf9tfLzvWfeosiEHoPS8cAxwBLeqC3YpV
         8/3wMLnBXn5W6Z+EMwdiLhY+LzqKbTiNnxc5Xj7C35ohW1Mauj6D6aQ5/62SelAqICWc
         T3T+jiwjFBEf4OivL6oKt+QLZ4EnXRkyeUpuaJmSPNILudr+8d6Dts0lQzNjF4ZVeV7z
         Snig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JDgg8KBOxvXDHJNAWkPu62lUH+4hfzE7VSC0izh4Ku0=;
        b=atbhCRemRsPJ8lVu3qKHFhKNnIrWox9VVij3AHD4bXsnTEbpmke9gPgD4XaLugYEJu
         73QR0H01S5tPPpUFLY3RGbpBfQyG94cQWAybWuIhH3wWaJM3Arv+80sNfReS+eg7OjzS
         zzalJQTrORxakHDBtQ8uKxI1voFLcHaN4jAG9xnoY64mFcog4Rom0vBobiu6dp3kD6Jo
         yP9uK7gUkRH1nb5YG3ybG+g0hDMKFaYm2W0Er/BNA2qWx7sWcQht+krNutKXtkrJNjMy
         1kx0HFjqwTFIN7mGph+6Yc4NgyK3NrIBWP19i90xvfmcT2pMSyO+Bi7Cirw91OzF8rZ2
         A5Ng==
X-Gm-Message-State: APjAAAUQ3owBZvJlic5mRrA7RlpeLi3eK6HlZdG/86QVmslN6lJt9rIf
        CtQee7DmFQ5Lj0SixeocK4DCEoXtGWNsvA==
X-Google-Smtp-Source: APXvYqyqLH4KBn7TKmFPS9y1nnYPXRGMi8/30l3XLgr7r1jbItePh++eaOzwog5YbC3jo3YYQajC1g==
X-Received: by 2002:a62:e318:: with SMTP id g24mr3043209pfh.53.1567681286593;
        Thu, 05 Sep 2019 04:01:26 -0700 (PDT)
Received: from C02TN4C6HTD6.us.cray.com (seattle-nat.cray.com. [136.162.66.1])
        by smtp.gmail.com with ESMTPSA id v22sm1505648pgk.69.2019.09.05.04.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 04:01:17 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <c17828@cray.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca
Subject: [PATCH] ext2fs: add ext2fs_read_sb that returns superblock
Date:   Thu,  5 Sep 2019 14:01:10 +0300
Message-Id: <20190905110110.32627-1-c17828@cray.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tune2fs is used to make e2label duties.  ext2fs_open2() reads group
descriptors which are not used during disk label obtaining, but takes
a lot of time on large partitions.

This patch adds ext2fs_read_sb(), there only initialized superblock
is returned This saves time dramatically.

Signed-off-by: Artem Blagodarenko <c17828@cray.com>
Cray-bug-id: LUS-5777
---
 lib/ext2fs/ext2fs.h |  2 ++
 lib/ext2fs/openfs.c | 16 ++++++++++++++++
 misc/tune2fs.c      | 23 +++++++++++++++--------
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 59fd9742..3a63b74d 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1630,6 +1630,8 @@ extern int ext2fs_journal_sb_start(int blocksize);
 extern errcode_t ext2fs_open(const char *name, int flags, int superblock,
 			     unsigned int block_size, io_manager manager,
 			     ext2_filsys *ret_fs);
+extern errcode_t ext2fs_read_sb(const char *name, io_manager manager,
+				struct ext2_super_block * super);
 extern errcode_t ext2fs_open2(const char *name, const char *io_options,
 			      int flags, int superblock,
 			      unsigned int block_size, io_manager manager,
diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
index 51b54a44..95f45d84 100644
--- a/lib/ext2fs/openfs.c
+++ b/lib/ext2fs/openfs.c
@@ -99,6 +99,22 @@ static void block_sha_map_free_entry(void *data)
 	return;
 }
 
+errcode_t ext2fs_read_sb(const char *name, io_manager manager,
+			 struct ext2_super_block * super)
+{
+	io_channel	io;
+	errcode_t	retval = 0;
+
+	retval = manager->open(name, 0, &io);
+	if (!retval) {
+		retval = io_channel_read_blk(io, 1, -SUPERBLOCK_SIZE,
+				     super);
+		io_channel_close(io);
+	}
+
+	return retval;
+}
+
 /*
  *  Note: if superblock is non-zero, block-size must also be non-zero.
  * 	Superblock and block_size can be zero to use the default size.
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 7d2d38d7..fea607e1 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -2879,6 +2879,21 @@ int tune2fs_main(int argc, char **argv)
 #endif
 		io_ptr = unix_io_manager;
 
+	if (print_label) {
+		/* For e2label emulation */
+		struct ext2_super_block sb;
+
+		/* Read only superblock. Nothing else metters.*/
+		retval = ext2fs_read_sb(device_name, io_ptr, &sb);
+		if (!retval) {
+			printf("%.*s\n", (int) sizeof(sb.s_volume_name),
+			       sb.s_volume_name);
+		}
+
+		remove_error_table(&et_ext2_error_table);
+		return retval;
+	}
+
 retry_open:
 	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
 		open_flag |= EXT2_FLAG_SKIP_MMP;
@@ -2972,14 +2987,6 @@ retry_open:
 	sb = fs->super;
 	fs->flags &= ~EXT2_FLAG_MASTER_SB_ONLY;
 
-	if (print_label) {
-		/* For e2label emulation */
-		printf("%.*s\n", (int) sizeof(sb->s_volume_name),
-		       sb->s_volume_name);
-		remove_error_table(&et_ext2_error_table);
-		goto closefs;
-	}
-
 	retval = ext2fs_check_if_mounted(device_name, &mount_flags);
 	if (retval) {
 		com_err("ext2fs_check_if_mount", retval,
-- 
2.14.3

