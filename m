Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540A5F6BC5
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2019 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfKJWeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Nov 2019 17:34:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53169 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726650AbfKJWeN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Nov 2019 17:34:13 -0500
Received: from callcc.thunk.org ([12.90.237.218])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAAMXvqP019671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Nov 2019 17:33:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0FD6D4202FD; Sun, 10 Nov 2019 17:33:57 -0500 (EST)
Date:   Sun, 10 Nov 2019 17:33:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Guiyao <guiyao@huawei.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "aceballos@gmail.com" <aceballos@gmail.com>,
        "vertaling@coevern.nl" <vertaling@coevern.nl>
Subject: Re: [PATCH] e2fsprogs: Check device id in advance to skip fake
 device name
Message-ID: <20191110223357.GA20859@mit.edu>
References: <005F77DB9A260B4E91664DDF22573C66E9CFF3AA@DGGEMM532-MBX.china.huawei.com>
 <005F77DB9A260B4E91664DDF22573C66E9D1651B@DGGEMM532-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005F77DB9A260B4E91664DDF22573C66E9D1651B@DGGEMM532-MBX.china.huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Guiyao,

My apologies for the delay in responding to your patch.  The situation
didn't seem to be something that would happen in real life.  (What
insane system administrator would do something like "mount -t tmpfs
/dev/sdb /tmp"?)

Also, your patch was damaged; when applied, it would result in file
that would not compile:

> +		if (strcmp(file, mnt->mnt_fsname) == 0) { #ifndef __GNU__

It was also quite a bit more complex than it needed to be, and this is
code that requires careful auditing since it has to work in a large
number of operating systems and distribution set ups.

As a result, I didn't give analyzing this patch high priority; but
I've finally got around to rewriting it.

This is the patch which I've come up.

						- Ted

From ea4d53b7b9079fd6e2cc34cf569a993a183bfbd2 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Sun, 10 Nov 2019 12:11:49 -0500
Subject: [PATCH] libext2fs/ismounted.c: check device id in advance to skip
 false device names

If there is a trickster which tries to use device names as the mount
device for pseudo-file systems, the resulting /proc/mounts can confuse
ext2fs_check_mount_point().  (So far as I can tell, there's no good
reason to do this, but sysadmins do the darnest things.)

An example of this might be the following /proc/mounts excerpt:

/dev/sdb /mnt2 tmpfs rw,relatime 0 0
/dev/sdb /mnt ext4 rw,relatime 0 0

This is created via "mount -t tmpfs /dev/sdb /mnt2" followed via
"mount -t ext4 /dev/sdb /mnt".  (Normally, a sane mount of tmpfs would
use something like "mount -t tmpfs tmpfs /mnt2".)

Fix this by double checking the st_rdev of the claimed mountpoint and
match it with the dev_t of the device.  (Note that the GNU HURD
doesn't support st_rdev, so we can't solve this problem for the HURD.)

Reported-by: GuiYao <guiyao@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ismounted.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
index 6cd497dc..dc37cce4 100644
--- a/lib/ext2fs/ismounted.c
+++ b/lib/ext2fs/ismounted.c
@@ -128,8 +128,19 @@ static errcode_t check_mntent_file(const char *mtab_file, const char *file,
 	while ((mnt = getmntent (f)) != NULL) {
 		if (mnt->mnt_fsname[0] != '/')
 			continue;
-		if (strcmp(file, mnt->mnt_fsname) == 0)
+		if (stat(mnt->mnt_dir, &st_buf) != 0)
+			continue;
+		if (strcmp(file, mnt->mnt_fsname) == 0) {
+			if (file_rdev && (file_rdev != st_buf.st_dev)) {
+#ifdef DEBUG
+				printf("Bogus entry in %s!  "
+				       "(%s does not exist)\n",
+				       mtab_file, mnt->mnt_dir);
+#endif /* DEBUG */
+				continue;
+			}
 			break;
+		}
 		if (stat(mnt->mnt_fsname, &st_buf) == 0) {
 			if (ext2fsP_is_disk_device(st_buf.st_mode)) {
 #ifndef __GNU__
@@ -168,32 +179,6 @@ static errcode_t check_mntent_file(const char *mtab_file, const char *file,
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
 	*mount_flags = EXT2_MF_MOUNTED;
 
 #ifdef MNTOPT_RO
-- 
2.23.0

