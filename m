Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB736A66C6
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 04:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCADrH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 22:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCADqo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 22:46:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F0392BE
        for <linux-ext4@vger.kernel.org>; Tue, 28 Feb 2023 19:46:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FA1861181
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 03:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84C8C433EF;
        Wed,  1 Mar 2023 03:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677642358;
        bh=k0ZDfImZvANgmQuVCrUoljTSsbYcsYeeCWlXQiUkdA4=;
        h=From:To:Cc:Subject:Date:From;
        b=TLOnTbeoKmec1Rq2g1sjwKe2zrhFL8GkrJIsC3FjKpxCDf5XiXZvRTcvDKcmIZKDN
         PCYAMYGB3irezhPd6L91z593rWCxLY5K5QXzjP0/9aSHl/SNMdiZOUT7hA1p38muBg
         DyeMaWrAKiKx6ZIdIxdaHbiLCJrwbW+A7KdpNhvjBkLe9LKCkM8Xb177KtvLklnlop
         V6LFE7xGcMywY7Ae80Yf53JjFFe24/0r0FeV2T9ff+cWAOJge51GsoMEQAipYe/hni
         YsBkmprUL1Ml85/06YGipc0rcPimBzTjbJ6bQkf3ztp+I5Q2MBKQ8aXB5wnZ/6wYGv
         xMwjfgEAHOjqw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: [e2fsprogs PATCH] libext2fs: fix ext2fs_get_device_size2() return value on Windows
Date:   Tue, 28 Feb 2023 19:45:18 -0800
Message-Id: <20230301034518.373859-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Creating a file system on Windows without a pre-existing file stopped
working because the Windows version of ext2fs_get_device_size2() doesn't
return ENOENT if the file doesn't exist.  Fix this.

Fixes: 53464654bd33 ("mke2fs: fix creating a file system image w/o a pre-existing file")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .github/workflows/ci.yml |  1 -
 lib/ext2fs/getsize.c     | 31 +++++++++++--------------------
 lib/ext2fs/windows_io.c  | 11 -----------
 3 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 51b27c88d..35496c573 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -112,5 +112,4 @@ jobs:
     - run: make -j8 -C lib/support/ all V=1 CFLAGS_WARN="-Werror"
     - run: make -j8 -C lib/e2p/ all V=1 CFLAGS_WARN="-Werror"
     - run: make -j8 -C misc/ mke2fs V=1 CFLAGS_WARN="-Werror"
-    - run: touch image.ext4
     - run: misc/mke2fs.exe -T ext4 image.ext4 128M
diff --git a/lib/ext2fs/getsize.c b/lib/ext2fs/getsize.c
index bcf30208e..a02863443 100644
--- a/lib/ext2fs/getsize.c
+++ b/lib/ext2fs/getsize.c
@@ -71,12 +71,11 @@
 #define HAVE_GET_FILE_SIZE_EX 1
 #endif
 
-HANDLE windows_get_handle(io_channel channel);
-
 errcode_t ext2fs_get_device_size2(const char *file, int blocksize,
 				  blk64_t *retblocks)
 {
-	HANDLE dev;
+	int fd;
+	HANDLE h;
 	PARTITION_INFORMATION pi;
 	DISK_GEOMETRY gi;
 	DWORD retbytes;
@@ -86,25 +85,18 @@ errcode_t ext2fs_get_device_size2(const char *file, int blocksize,
 	DWORD filesize;
 #endif /* HAVE_GET_FILE_SIZE_EX */
 
-	io_channel data_io = 0;
-	int retval;
-
-	retval = windows_io_manager->open(file, 0, &data_io);
-	if (retval)
-		return retval;
-
-	dev = windows_get_handle(data_io);
-	if (dev == INVALID_HANDLE_VALUE)
-		return EBADF;
-
-	if (DeviceIoControl(dev, IOCTL_DISK_GET_PARTITION_INFO,
+	fd = ext2fs_open_file(file, O_RDONLY, 0);
+	if (fd < 0)
+		return errno;
+	h = (HANDLE)_get_osfhandle(fd);
+	if (DeviceIoControl(h, IOCTL_DISK_GET_PARTITION_INFO,
 			    &pi, sizeof(PARTITION_INFORMATION),
 			    &pi, sizeof(PARTITION_INFORMATION),
 			    &retbytes, NULL)) {
 
 		*retblocks = pi.PartitionLength.QuadPart / blocksize;
 
-	} else if (DeviceIoControl(dev, IOCTL_DISK_GET_DRIVE_GEOMETRY,
+	} else if (DeviceIoControl(h, IOCTL_DISK_GET_DRIVE_GEOMETRY,
 				&gi, sizeof(DISK_GEOMETRY),
 				&gi, sizeof(DISK_GEOMETRY),
 				&retbytes, NULL)) {
@@ -115,20 +107,19 @@ errcode_t ext2fs_get_device_size2(const char *file, int blocksize,
 			     gi.Cylinders.QuadPart / blocksize;
 
 #ifdef HAVE_GET_FILE_SIZE_EX
-	} else if (GetFileSizeEx(dev, &filesize)) {
+	} else if (GetFileSizeEx(h, &filesize)) {
 		*retblocks = filesize.QuadPart / blocksize;
 	}
 #else
 	} else {
-		filesize = GetFileSize(dev, NULL);
+		filesize = GetFileSize(h, NULL);
 		if (INVALID_FILE_SIZE != filesize) {
 			*retblocks = filesize / blocksize;
 		}
 	}
 #endif /* HAVE_GET_FILE_SIZE_EX */
 
-	windows_io_manager->close(data_io);
-
+	close(fd);
 	return 0;
 }
 
diff --git a/lib/ext2fs/windows_io.c b/lib/ext2fs/windows_io.c
index 83aea68b6..f01bbb6ad 100644
--- a/lib/ext2fs/windows_io.c
+++ b/lib/ext2fs/windows_io.c
@@ -857,17 +857,6 @@ static errcode_t windows_write_byte(io_channel channel, unsigned long offset,
 	return EXT2_ET_UNIMPLEMENTED;
 }
 
-HANDLE windows_get_handle(io_channel channel)
-{
-	struct windows_private_data *data;
-
-	EXT2_CHECK_MAGIC_RETURN(channel, EXT2_ET_MAGIC_IO_CHANNEL, INVALID_HANDLE_VALUE);
-	data = (struct windows_private_data *) channel->private_data;
-	EXT2_CHECK_MAGIC_RETURN(data, EXT2_ET_MAGIC_WINDOWS_IO_CHANNEL, INVALID_HANDLE_VALUE);
-
-	return data->handle;
-}
-
 /*
  * Flush data buffers to disk.
  */

base-commit: 25ad8a431331b4d1d444a70b6079456cc612ac40
-- 
2.39.2

