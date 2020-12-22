Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE152E0E30
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgLVSYe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 13:24:34 -0500
Received: from tina.tse.jus.br ([187.4.152.236]:39736 "EHLO tse.jus.br"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgLVSYd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Dec 2020 13:24:33 -0500
Received: from EXCH01.tse.gov.br (unknown [10.30.1.221])
        by Forcepoint Email with ESMTP id E1F2D352D248FFFEC397;
        Tue, 22 Dec 2020 15:16:24 -0300 (-03)
Received: from tsesevinl73.tse.jus.br (10.30.32.51) by EXCH01.tse.gov.br
 (10.30.1.221) with Microsoft SMTP Server (TLS) id 14.2.347.0; Tue, 22 Dec
 2020 15:16:24 -0300
From:   <paulo.alvarez@tse.jus.br>
To:     <linux-ext4@vger.kernel.org>
CC:     Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: [PATCH 2/3] Code adaptation to use the Windows IO manager
Date:   Tue, 22 Dec 2020 15:15:51 -0300
Message-ID: <20201222181552.11267-3-paulo.alvarez@tse.jus.br>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222181552.11267-1-paulo.alvarez@tse.jus.br>
References: <20201222181552.11267-1-paulo.alvarez@tse.jus.br>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.30.32.51]
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Paulo Antonio Alvarez <pauloaalvarez@gmail.com>

---
 include/mingw/unistd.h   | 51 ++++++++++++++++++++++++++++++++++++----
 lib/ext2fs/ext2_io.h     |  5 ++++
 lib/ext2fs/getsectsize.c | 15 ++++++++++++
 lib/ext2fs/getsize.c     | 16 +++++++++----
 lib/support/plausible.c  |  7 +++++-
 util/subst.c             |  4 ++++
 6 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/mingw/unistd.h b/include/mingw/unistd.h
index 9c0dc81a..b2018584 100644
--- a/include/mingw/unistd.h
+++ b/include/mingw/unistd.h
@@ -1,13 +1,54 @@
-
 #pragma once
 
+// Copyright transferred from Raider Solutions, Inc to
+//   Kern Sibbald and John Walker by express permission.
+//
+// Copyright (C) 2004-2006 Kern Sibbald
+// Copyright (C) 2014 Adam Kropelin
+//
+//   This program is free software; you can redistribute it and/or
+//   modify it under the terms of the GNU General Public License as
+//   published by the Free Software Foundation; either version 2 of
+//   the License, or (at your option) any later version.
+//
+//   This program is distributed in the hope that it will be useful,
+//   but WITHOUT ANY WARRANTY; without even the implied warranty of
+//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+//   General Public License for more details.
+//
+//   You should have received a copy of the GNU General Public
+//   License along with this program; if not, write to the Free
+//   Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
+//   MA 02111-1307, USA.
+
+#ifndef __COMPAT_UNISTD_H_
+#define __COMPAT_UNISTD_H_
+
 #include_next <unistd.h>
 
-__inline __uid_t getuid(void){return 0;}
-__inline int geteuid(void){return 1;}
+#define _PC_PATH_MAX 1
+#define _PC_NAME_MAX 2
+
+#ifdef __cplusplus
+extern "C" {
+#endif
 
-__inline __gid_t getgid(void){return 0;}
-__inline __gid_t getegid(void){return 0;}
+long pathconf(const char *, int);
+#define getpid _getpid
+#define getppid() 0
+
+unsigned int sleep(unsigned int seconds);
+
+#define getuid() 0
+#define getgid() 0
+#define geteuid() 1
+#define getegid() 0
 
 // no-oped sync
 __inline void sync(void){};
+
+#ifdef __cplusplus
+};
+#endif
+
+#endif /* __COMPAT_UNISTD_H_ */
\ No newline at end of file
diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 5540900a..f605f901 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -139,9 +139,14 @@ extern errcode_t io_channel_cache_readahead(io_channel io,
 					    unsigned long long block,
 					    unsigned long long count);
 
+#ifdef _WIN32
+/* windows_io.c */
+extern io_manager windows_io_manager;
+#else
 /* unix_io.c */
 extern io_manager unix_io_manager;
 extern io_manager unixfd_io_manager;
+#endif
 
 /* sparse_io.c */
 extern io_manager sparse_io_manager;
diff --git a/lib/ext2fs/getsectsize.c b/lib/ext2fs/getsectsize.c
index d6bc3767..3a461eb9 100644
--- a/lib/ext2fs/getsectsize.c
+++ b/lib/ext2fs/getsectsize.c
@@ -51,6 +51,11 @@
  */
 errcode_t ext2fs_get_device_sectsize(const char *file, int *sectsize)
 {
+#ifdef _WIN64
+	*sectsize = 512; // just guessing
+	return 0;
+#else // not _WIN64
+
 	int	fd;
 
 	fd = ext2fs_open_file(file, O_RDONLY, 0);
@@ -72,6 +77,8 @@ errcode_t ext2fs_get_device_sectsize(const char *file, int *sectsize)
 	*sectsize = 0;
 	close(fd);
 	return 0;
+
+#endif // ifdef _WIN64
 }
 
 /*
@@ -110,6 +117,12 @@ int ext2fs_get_dio_alignment(int fd)
  */
 errcode_t ext2fs_get_device_phys_sectsize(const char *file, int *sectsize)
 {
+#ifdef _WIN64
+
+	return ext2fs_get_device_sectsize(file, sectsize);
+
+#else // not _WIN64
+
 	int	fd;
 
 	fd = ext2fs_open_file(file, O_RDONLY, 0);
@@ -133,4 +146,6 @@ errcode_t ext2fs_get_device_phys_sectsize(const char *file, int *sectsize)
 	*sectsize = 0;
 	close(fd);
 	return 0;
+
+#endif // ifdef _WIN64
 }
diff --git a/lib/ext2fs/getsize.c b/lib/ext2fs/getsize.c
index be067755..72656821 100644
--- a/lib/ext2fs/getsize.c
+++ b/lib/ext2fs/getsize.c
@@ -71,6 +71,8 @@
 #define HAVE_GET_FILE_SIZE_EX 1
 #endif
 
+HANDLE windows_get_handle(io_channel channel);
+
 errcode_t ext2fs_get_device_size2(const char *file, int blocksize,
 				  blk64_t *retblocks)
 {
@@ -84,12 +86,17 @@ errcode_t ext2fs_get_device_size2(const char *file, int blocksize,
 	DWORD filesize;
 #endif /* HAVE_GET_FILE_SIZE_EX */
 
-	dev = CreateFile(file, GENERIC_READ,
-			 FILE_SHARE_READ | FILE_SHARE_WRITE ,
-                	 NULL,  OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL,  NULL);
+	io_channel data_io = 0;
+	int retval;
+
+	retval = windows_io_manager->open(file, 0, &data_io);
+	if (retval)
+		return retval;
 
+	dev = windows_get_handle(data_io);
 	if (dev == INVALID_HANDLE_VALUE)
 		return EBADF;
+
 	if (DeviceIoControl(dev, IOCTL_DISK_GET_PARTITION_INFO,
 			    &pi, sizeof(PARTITION_INFORMATION),
 			    &pi, sizeof(PARTITION_INFORMATION),
@@ -120,7 +127,8 @@ errcode_t ext2fs_get_device_size2(const char *file, int blocksize,
 	}
 #endif /* HAVE_GET_FILE_SIZE_EX */
 
-	CloseHandle(dev);
+	windows_io_manager->close(data_io);
+
 	return 0;
 }
 
diff --git a/lib/support/plausible.c b/lib/support/plausible.c
index 024f205e..2a3ae140 100644
--- a/lib/support/plausible.c
+++ b/lib/support/plausible.c
@@ -103,7 +103,12 @@ static void print_ext2_info(const char *device)
 	time_t			tm;
 
 	retval = ext2fs_open2(device, 0, EXT2_FLAG_64BITS, 0, 0,
-			      unix_io_manager, &fs);
+#ifdef _WIN64
+			      windows_io_manager,
+#else
+			      unix_io_manager,
+#endif
+                  &fs);
 	if (retval)
 		return;
 	sb = fs->super;
diff --git a/util/subst.c b/util/subst.c
index 66d7d9a9..c0eda5cf 100644
--- a/util/subst.c
+++ b/util/subst.c
@@ -434,16 +434,20 @@ int main(int argc, char **argv)
 					printf("Using original atime\n");
 				set_utimes(outfn, fileno(old), tv);
 			}
+#ifndef _WIN64
 			if (ofd >= 0)
 				(void) fchmod(ofd, 0444);
+#endif
 			fclose(out);
 			if (unlink(newfn) < 0)
 				perror("unlink");
 		} else {
 			if (verbose)
 				printf("Creating or replacing %s.\n", outfn);
+#ifndef _WIN64
 			if (ofd >= 0)
 				(void) fchmod(ofd, 0444);
+#endif
 			fclose(out);
 			if (old)
 				fclose(old);
-- 
2.17.1

