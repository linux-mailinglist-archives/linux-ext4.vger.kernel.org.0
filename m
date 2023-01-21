Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C929D67695F
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjAUUhN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DB529159
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4539A60B6C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D56DC433A0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333404;
        bh=8LlzNr1p4aIHut3osN9IQPBEXbEaaKXew3NWPyMdKLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SElDR4tz/GFSd+m+EflkfxpIPk813f0fLyp7PmUaFCtmgR7G7fIKfJYflQuaLgpYY
         iooUWnjboewpUnWrSjD7xLoeVYfMHOPLjLEu5+aX1lvU6IjOxgWtW0E76W9TNHeTHD
         ObpH4CJV+j25RORMeMqJS7XD10J9jwmT8UUdsmzsr2TlVrz2gxKL8o71UugEqMWsqQ
         ieVYmV9ME6hFytcYHKlzHnzrH4MQZJJLQZ4cDXEFBt8i1mE6pv5UdwE5CE781Z48iM
         GDtRw4bGyHl1Eupa61Ofb2hIMsrExe4DJDtbB5gL72UZuBrqY6MFs0q0aSFU86Vbyp
         TREQmo+8nXtpw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 31/38] misc/mk_hugefiles: simplify get_partition_start()
Date:   Sat, 21 Jan 2023 12:32:23 -0800
Message-Id: <20230121203230.27624-32-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

search_sysfs_block() is causing -Wformat-truncation warnings.  These
could be fixed by checking the return value of snprintf(), instead of
doing buggy checks like 'strlen(p_de->d_name) > SYSFS_PATH_LEN -
strlen(path) - 32', which has an integer underflow bug.

However, the only purpose of search_sysfs_block() is to find the sysfs
directory for a block device by device number.  That can trivially be
done using /sys/dev/block/$major:$minor.  So just do that instead.  Also
make get_partition_start() explicitly Linux-only, as it has never worked
anywhere else.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/mingw/sys/sysmacros.h |   8 +-
 misc/mk_hugefiles.c           | 134 +++-------------------------------
 2 files changed, 10 insertions(+), 132 deletions(-)

diff --git a/include/mingw/sys/sysmacros.h b/include/mingw/sys/sysmacros.h
index 18fcaaa34..a790cb2f6 100644
--- a/include/mingw/sys/sysmacros.h
+++ b/include/mingw/sys/sysmacros.h
@@ -1,11 +1,5 @@
-
 #pragma once
 
-/*
- * Fall back to Linux's definitions of makedev and major are needed.
- * The search_sysfs_block() function is highly unlikely to work on
- * non-Linux systems anyway.
- */
 #ifndef makedev
 #define makedev(maj, min) (((maj) << 8) + (min))
-#endif
\ No newline at end of file
+#endif
diff --git a/misc/mk_hugefiles.c b/misc/mk_hugefiles.c
index 0280b41e7..3caaf1b68 100644
--- a/misc/mk_hugefiles.c
+++ b/misc/mk_hugefiles.c
@@ -2,13 +2,8 @@
  * mk_hugefiles.c -- create huge files
  */
 
-#define _XOPEN_SOURCE 600 /* for inclusion of PATH_MAX in Solaris */
-#define _BSD_SOURCE	  /* for makedev() and major() */
-#define _DEFAULT_SOURCE	  /* since glibc 2.20 _BSD_SOURCE is deprecated */
-
 #include "config.h"
 #include <stdio.h>
-#include <stdarg.h>
 #include <string.h>
 #include <strings.h>
 #include <fcntl.h>
@@ -68,141 +63,30 @@ static char *fn_buf;
 static char *fn_numbuf;
 int zero_hugefile = 1;
 
-#define SYSFS_PATH_LEN 300
-typedef char sysfs_path_t[SYSFS_PATH_LEN];
-
-#ifndef HAVE_SNPRINTF
-/*
- * We are very careful to avoid needing to worry about buffer
- * overflows, so we don't really need to use snprintf() except as an
- * additional safety check.  So if snprintf() is not present, it's
- * safe to fall back to vsprintf().  This provides portability since
- * vsprintf() is guaranteed by C89, while snprintf() is only
- * guaranteed by C99 --- which for example, Microsoft Visual Studio
- * has *still* not bothered to implement.  :-/  (Not that I expect
- * mke2fs to be ported to MS Visual Studio any time soon, but
- * libext2fs *does* get built on Microsoft platforms, and we might
- * want to move this into libext2fs some day.)
- */
-static int my_snprintf(char *str, size_t size, const char *format, ...)
-{
-	va_list	ap;
-	int ret;
-
-	va_start(ap, format);
-	ret = vsprintf(str, format, ap);
-	va_end(ap);
-	return ret;
-}
-
-#define snprintf my_snprintf
-#endif
-
-/*
- * Fall back to Linux's definitions of makedev and major are needed.
- * The search_sysfs_block() function is highly unlikely to work on
- * non-Linux systems anyway.
- */
-#ifndef makedev
-#define makedev(maj, min) (((maj) << 8) + (min))
-#endif
-
-static char *search_sysfs_block(dev_t devno, sysfs_path_t ret_path)
-{
-	struct dirent	*de, *p_de;
-	DIR		*dir = NULL, *p_dir = NULL;
-	FILE		*f;
-	sysfs_path_t	path, p_path;
-	unsigned int	major, minor;
-	char		*ret = ret_path;
-
-	ret_path[0] = 0;
-	if ((dir = opendir("/sys/block")) == NULL)
-		return NULL;
-	while ((de = readdir(dir)) != NULL) {
-		if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, "..") ||
-		    strlen(de->d_name) > sizeof(path)-32)
-			continue;
-		snprintf(path, SYSFS_PATH_LEN,
-			 "/sys/block/%s/dev", de->d_name);
-		f = fopen(path, "r");
-		if (f &&
-		    (fscanf(f, "%u:%u", &major, &minor) == 2)) {
-			fclose(f); f = NULL;
-			if (makedev(major, minor) == devno) {
-				snprintf(ret_path, SYSFS_PATH_LEN,
-					 "/sys/block/%s", de->d_name);
-				goto success;
-			}
-#ifdef major
-			if (major(devno) != major)
-				continue;
-#endif
-		}
-		if (f)
-			fclose(f);
-
-		snprintf(path, SYSFS_PATH_LEN, "/sys/block/%s", de->d_name);
-
-		if (p_dir)
-			closedir(p_dir);
-		if ((p_dir = opendir(path)) == NULL)
-			continue;
-		while ((p_de = readdir(p_dir)) != NULL) {
-			if (!strcmp(p_de->d_name, ".") ||
-			    !strcmp(p_de->d_name, "..") ||
-			    (strlen(p_de->d_name) >
-			     SYSFS_PATH_LEN - strlen(path) - 32))
-				continue;
-			snprintf(p_path, SYSFS_PATH_LEN, "%s/%s/dev",
-				 path, p_de->d_name);
-
-			f = fopen(p_path, "r");
-			if (f &&
-			    (fscanf(f, "%u:%u", &major, &minor) == 2) &&
-			    (((major << 8) + minor) == devno)) {
-				fclose(f);
-				snprintf(ret_path, SYSFS_PATH_LEN, "%s/%s",
-					 path, p_de->d_name);
-				goto success;
-			}
-			if (f)
-				fclose(f);
-		}
-	}
-	ret = NULL;
-success:
-	if (dir)
-		closedir(dir);
-	if (p_dir)
-		closedir(p_dir);
-	return ret;
-}
-
-static blk64_t get_partition_start(const char *device_name)
+static blk64_t
+get_partition_start(const char *device_name EXT2FS_ATTR((unused)))
 {
+#ifdef __linux__
 	unsigned long long start;
-	sysfs_path_t	path;
+	char		path[128];
 	struct stat	st;
 	FILE		*f;
-	char		*cp;
 	int		n;
 
 	if ((stat(device_name, &st) < 0) || !S_ISBLK(st.st_mode))
 		return 0;
 
-	cp = search_sysfs_block(st.st_rdev, path);
-	if (!cp)
-		return 0;
-	if (strlen(path) > SYSFS_PATH_LEN - sizeof("/start"))
-		return 0;
-	strcat(path, "/start");
+	sprintf(path, "/sys/dev/block/%d:%d/start",
+		major(st.st_rdev), minor(st.st_rdev));
 	f = fopen(path, "r");
 	if (!f)
 		return 0;
 	n = fscanf(f, "%llu", &start);
 	fclose(f);
 	return (n == 1) ? start : 0;
+#else
+	return 0;
+#endif
 }
 
 static errcode_t create_directory(ext2_filsys fs, char *dir,
-- 
2.39.0

