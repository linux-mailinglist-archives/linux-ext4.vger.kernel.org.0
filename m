Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09265FF92B
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Oct 2022 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJOIfn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 15 Oct 2022 04:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiJOIfm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 15 Oct 2022 04:35:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3843E75C
        for <linux-ext4@vger.kernel.org>; Sat, 15 Oct 2022 01:35:38 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MqGg53K6SzmVMX;
        Sat, 15 Oct 2022 16:30:57 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 15 Oct 2022 16:35:36 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 15 Oct 2022 16:35:35 +0800
Message-ID: <115aa2d8-0c05-df99-518c-99211762b6c8@huawei.com>
Date:   Sat, 15 Oct 2022 16:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] lib/ext2fs/unix_io.c: add flock operation to
 struct_unix_manager in e2fsprogs
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100010.china.huawei.com (7.185.36.14) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We noticed that systemd has an issue about symlink unreliable caused by
formatting filesystem and systemd operating on same device.
Issue Link: https://github.com/systemd/systemd/issues/23746

According to systemd doc, a BSD flock needs to be acquired before
formatting the device.
Related Link: https://systemd.io/BLOCK_DEVICE_LOCKING/

So we acquire flock after opening the device but before
writing superblock.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  lib/ext2fs/unix_io.c  | 90 +++++++++++++++++++++++++++++++++++++++++--
  util/android_config.h |  1 +
  2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index e53db333..a0ca8b37 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -61,6 +61,9 @@
  #if HAVE_SYS_STAT_H
  #include <sys/stat.h>
  #endif
+#if HAVE_SYS_FILE_H
+#include <sys/file.h>
+#endif
  #if HAVE_SYS_RESOURCE_H
  #include <sys/resource.h>
  #endif
@@ -634,18 +637,93 @@ static errcode_t flush_cached_blocks(io_channel 
channel,
  #endif
  #endif

+/* return 0 on success */
+int blkdev_lock(int fd, const char *devname)
+{
+	int oper, rc;
+	char *lock_mode = NULL;
+
+	lock_mode = getenv("LOCK_BLOCK_DEVICE");
+	if (!lock_mode)
+		lock_mode = "1";
+
+	if (strcasecmp(lock_mode, "yes") == 0 ||
+	    strcmp(lock_mode, "1") == 0)
+		oper = LOCK_EX;
+
+	else if (strcasecmp(lock_mode, "nonblock") == 0)
+		oper = LOCK_EX | LOCK_NB;
+
+	else if (strcasecmp(lock_mode, "no") == 0 ||
+		 strcmp(lock_mode, "0") == 0)
+		return 0;
+	else {
+		printf("unsupported lock mode: %s", lock_mode);
+		return -EINVAL;
+	}
+
+	if (!(oper & LOCK_NB)) {
+		/* Try non-block first to provide message */
+		rc = flock(fd, oper | LOCK_NB);
+		if (rc == 0)
+			return 0;
+		if (rc != 0 && errno == EWOULDBLOCK) {
+			fprintf(stderr, "%s: device already locked, waiting to get lock ... ",
+					devname);
+		}
+	}
+	rc = flock(fd, oper);
+	if (rc != 0) {
+		switch (errno) {
+		case EWOULDBLOCK: /* LOCK_NB */
+			printf("%s: device already locked", devname);
+			break;
+		default:
+			printf("%s: failed to get lock", devname);
+		}
+	}
+	return rc;
+}
+
+/* return 0 on success */
+int blkdev_unlock(int fd)
+{
+	int oper, rc;
+	char *lock_mode = NULL;
+
+	lock_mode = getenv("LOCK_BLOCK_DEVICE");
+	if (!lock_mode)
+		lock_mode = "1";
+
+	if (strcasecmp(lock_mode, "no") == 0 ||
+		 strcmp(lock_mode, "0") == 0)
+		return 0;
+	else
+		oper = LOCK_UN;
+
+	rc = flock(fd, oper);
+	return rc;
+}
+
  int ext2fs_open_file(const char *pathname, int flags, mode_t mode)
  {
+	int fd = -1;
  	if (mode)
  #if defined(HAVE_OPEN64) && !defined(__OSX_AVAILABLE_BUT_DEPRECATED)
-		return open64(pathname, flags, mode);
+		fd = open64(pathname, flags, mode);
  	else
-		return open64(pathname, flags);
+		fd = open64(pathname, flags);
  #else
-		return open(pathname, flags, mode);
+		fd = open(pathname, flags, mode);
  	else
-		return open(pathname, flags);
+		fd = open(pathname, flags);
  #endif
+	if (blkdev_lock(fd, pathname) != 0) {
+		printf("File %s is locked\n", pathname);
+		exit(-1);
+	}
+
+	return fd;
  }

  int ext2fs_stat(const char *path, ext2fs_struct_stat *buf)
@@ -926,6 +1004,10 @@ static errcode_t unix_close(io_channel channel)
  	retval = flush_cached_blocks(channel, data, 0);
  #endif

+	if(blkdev_unlock(data->dev) != 0){
+		printf("blkdev unlock error\n");
+		retval = errno;
+        }
  	if (close(data->dev) < 0)
  		retval = errno;
  	free_cache(data);
diff --git a/util/android_config.h b/util/android_config.h
index 6ac16fec..4dd3b69f 100644
--- a/util/android_config.h
+++ b/util/android_config.h
@@ -28,6 +28,7 @@
  #define HAVE_UTIME_H 1

  #define HAVE_SYS_STAT_H 1
+#define HAVE_SYS_FILE_H 1
  #if !defined(__APPLE__)
  # define HAVE_SYS_SYSMACROS_H 1
  #endif
-- 
2.33.0


