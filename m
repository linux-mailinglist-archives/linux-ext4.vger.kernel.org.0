Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C042DDE203
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 04:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfJUCRr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 20 Oct 2019 22:17:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfJUCRr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 20 Oct 2019 22:17:47 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id A81AD2A1E4C99EBB77D6;
        Mon, 21 Oct 2019 10:17:43 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 10:17:43 +0800
Received: from DGGEMM532-MBX.china.huawei.com ([169.254.7.168]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0439.000;
 Mon, 21 Oct 2019 10:17:33 +0800
From:   Guiyao <guiyao@huawei.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
CC:     Mingfangsen <mingfangsen@huawei.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "aceballos@gmail.com" <aceballos@gmail.com>,
        "vertaling@coevern.nl" <vertaling@coevern.nl>
Subject: [PATCH] e2fsprogs: Check device id in advance to skip fake device
 name
Thread-Topic: [PATCH] e2fsprogs: Check device id in advance to skip fake
 device name
Thread-Index: AdV9ilnP4am9Fx3mSHqwErCX4XHRfQKKqPOQ
Date:   Mon, 21 Oct 2019 02:17:33 +0000
Message-ID: <005F77DB9A260B4E91664DDF22573C66E9D1651B@DGGEMM532-MBX.china.huawei.com>
References: <005F77DB9A260B4E91664DDF22573C66E9CFF3AA@DGGEMM532-MBX.china.huawei.com>
In-Reply-To: <005F77DB9A260B4E91664DDF22573C66E9CFF3AA@DGGEMM532-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Theodore and All,

It's a friendly reminder, maybe you are too busy to missed this email. :-)

In some cases, using resize2fs to resize one fs will return "fail".
Reproduce steps are as follows,
1. create 2 folders, for example "mnt" and "tmp"
2. mount /dev/sdb onto tmp as tmpfs
3. mount /dev/sdb onto mnt as ext4 or other normal file system 4. try to resize /dev/sdb, it FAILED! -> "Couldn't find valid filesystem superblock."
5. if mount mnt firstly, resize2fs command will succeed.

In check_mntent_file func, firstly try to find out the input device name in mtab_file line by line, and it will leave from loop once one item matched.
Then, check the mount point's st_dev of matched item, if it is not same with the input device's st_dev, it will return fail.
In this case, the first matched item in mtab_file is "tmp" mount point, it is only named as "/dev/sdb", which actually is not sdb's real mount point.
Finally, the name is matched, but st_dev is not matched, and then resize command fails.

Here, we check the st_dev immediately once the name is matched.
If st_dev not same, continue to next loop.


Signed-off-by: GuiYao <guiyao@huawei.com>
---
 lib/ext2fs/ismounted.c | 49 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c index 6cd497dc..265d27f7 100644
--- a/lib/ext2fs/ismounted.c
+++ b/lib/ext2fs/ismounted.c
@@ -98,6 +98,9 @@ static errcode_t check_mntent_file(const char *mtab_file, const char *file,  {
 	struct mntent 	*mnt;
 	struct stat	st_buf;
+#ifndef __GNU__
+	struct stat	dir_st_buf;
+#endif  /* __GNU__ */
 	errcode_t	retval = 0;
 	dev_t		file_dev=0, file_rdev=0;
 	ino_t		file_ino=0;
@@ -128,13 +131,26 @@ static errcode_t check_mntent_file(const char *mtab_file, const char *file,
 	while ((mnt = getmntent (f)) != NULL) {
 		if (mnt->mnt_fsname[0] != '/')
 			continue;
-		if (strcmp(file, mnt->mnt_fsname) == 0)
+#ifndef __GNU__
+		if (stat(mnt->mnt_dir, &dir_st_buf) != 0)
+			continue;
+#endif  /* __GNU__ */
+		if (strcmp(file, mnt->mnt_fsname) == 0) { #ifndef __GNU__
+			if (file_rdev && (file_rdev == dir_st_buf.st_dev))
+				break;
+			continue;
+#else
 			break;
+#endif  /* __GNU__ */
+		}
 		if (stat(mnt->mnt_fsname, &st_buf) == 0) {
 			if (ext2fsP_is_disk_device(st_buf.st_mode)) {  #ifndef __GNU__
-				if (file_rdev && (file_rdev == st_buf.st_rdev))
-					break;
+				if (file_rdev && (file_rdev == st_buf.st_rdev)) {
+					if (file_rdev == dir_st_buf.st_dev)
+						break;
+				}
 				if (check_loop_mounted(mnt->mnt_fsname,
 						st_buf.st_rdev, file_dev,
 						file_ino) == 1)
@@ -168,32 +184,7 @@ static errcode_t check_mntent_file(const char *mtab_file, const char *file,
 #endif	/* __GNU__ */
 		goto errout;
 	}
-#ifndef __GNU__ /* The GNU hurd is deficient; what else is new? */
-	/* Validate the entry in case /etc/mtab is out of date */
-	/*
-	 * We need to be paranoid, because some broken distributions
-	 * (read: Slackware) don't initialize /etc/mtab before checking
-	 * all of the non-root filesystems on the disk.
-	 */
-	if (stat(mnt->mnt_dir, &st_buf) < 0) {
-		retval = errno;
-		if (retval == ENOENT) {
-#ifdef DEBUG
-			printf("Bogus entry in %s!  (%s does not exist)\n",
-			       mtab_file, mnt->mnt_dir);
-#endif /* DEBUG */
-			retval = 0;
-		}
-		goto errout;
-	}
-	if (file_rdev && (st_buf.st_dev != file_rdev)) {
-#ifdef DEBUG
-		printf("Bogus entry in %s!  (%s not mounted on %s)\n",
-		       mtab_file, file, mnt->mnt_dir);
-#endif /* DEBUG */
-		goto errout;
-	}
-#endif /* __GNU__ */
+
 	*mount_flags = EXT2_MF_MOUNTED;
 
 #ifdef MNTOPT_RO
--
1.8.3.1
