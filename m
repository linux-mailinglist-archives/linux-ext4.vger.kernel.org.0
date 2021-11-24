Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5035945C4A2
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 14:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354399AbhKXNuc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Nov 2021 08:50:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354196AbhKXNs7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 24 Nov 2021 08:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637761549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b7QI1o7Ls2gj25N/ROr0r6RbdOdefxtgwwcPRc5r7HE=;
        b=EneOxPuEfgXA63E5Qxv+gzii8kmd/vQhf+2ZPmn5IrV8XR/OOGzlPq65vt5/XyQAvbc+Lq
        eJmCUwC8I2GhhlimgEVxSnxoPp5vRR1nbn3EORrNdVW8Vv9k/61i9OD8BNw0t31DFp56GZ
        Qul08z5/dBAz1pl63M0WoGV+FOzNR9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-8orvxn5TNUSmFp1B1VRS-Q-1; Wed, 24 Nov 2021 08:45:47 -0500
X-MC-Unique: 8orvxn5TNUSmFp1B1VRS-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E25E315720;
        Wed, 24 Nov 2021 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 219E11972E;
        Wed, 24 Nov 2021 13:45:45 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: [PATCH] tune2fs: implement support for set/get label iocts
Date:   Wed, 24 Nov 2021 14:45:42 +0100
Message-Id: <20211124134542.22270-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Implement support for FS_IOC_SETFSLABEL and FS_IOC_GETFSLABEL ioctls.
Try to use the ioctls if possible even before we open the file system
since we don't need it. Only fall back to the old method in the case the
file system is not mounted, is mounted read only in the set label case,
or the ioctls are not suppported by the kernel.

The new ioctls can also be supported by file system drivers other than
ext4. As a result tune2fs and e2label will work for those file systems
as well as long as the file system is mounted. Note that we still truncate
the label exceeds the supported lenghth on extN file system family, while
we keep the label intact for others.

Update tune2fs and e2label as well.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 lib/ext2fs/ext2fs.h    |  1 +
 lib/ext2fs/ismounted.c |  5 +++
 misc/e2label.8.in      |  7 ++-
 misc/tune2fs.8.in      |  8 +++-
 misc/tune2fs.c         | 96 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 0ee0e7d0..68f9c1fe 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -531,6 +531,7 @@ typedef struct ext2_struct_inode_scan *ext2_inode_scan;
 #define EXT2_MF_READONLY	4
 #define EXT2_MF_SWAP		8
 #define EXT2_MF_BUSY		16
+#define EXT2_MF_EXTFS		32
 
 /*
  * Ext2/linux mode flags.  We define them here so that we don't need
diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
index aee7d726..c73273b8 100644
--- a/lib/ext2fs/ismounted.c
+++ b/lib/ext2fs/ismounted.c
@@ -207,6 +207,11 @@ is_root:
 			close(fd);
 		(void) unlink(TEST_FILE);
 	}
+
+	if (!strcmp(mnt->mnt_type, "ext4") ||
+	    !strcmp(mnt->mnt_type, "ext3") ||
+	    !strcmp(mnt->mnt_type, "ext2"))
+		*mount_flags |= EXT2_MF_EXTFS;
 	retval = 0;
 errout:
 	endmntent (f);
diff --git a/misc/e2label.8.in b/misc/e2label.8.in
index 1dc96199..fa5294c4 100644
--- a/misc/e2label.8.in
+++ b/misc/e2label.8.in
@@ -33,7 +33,12 @@ Ext2 volume labels can be at most 16 characters long; if
 .I volume-label
 is longer than 16 characters,
 .B e2label
-will truncate it and print a warning message.
+will truncate it and print a warning message.  For other file systems that
+support online label manipulation and are mounted
+.B e2label
+will work as well, but it will not attempt to truncate the
+.I volume-label
+at all.
 .PP
 It is also possible to set the volume label using the
 .B \-L
diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index 1e026e5f..628dcdc0 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -457,8 +457,12 @@ Ext2 file system labels can be at most 16 characters long; if
 .I volume-label
 is longer than 16 characters,
 .B tune2fs
-will truncate it and print a warning.  The volume label can be used
-by
+will truncate it and print a warning.  For other file systems that
+support online label manipulation and are mounted
+.B tune2fs
+will work as well, but it will not attempt to truncate the
+.I volume-label
+at all.  The volume label can be used by
 .BR mount (8),
 .BR fsck (8),
 and
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 71a8e99b..6c162ba5 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -52,6 +52,9 @@ extern int optind;
 #include <sys/types.h>
 #include <libgen.h>
 #include <limits.h>
+#ifdef HAVE_SYS_IOCTL_H
+#include <sys/ioctl.h>
+#endif
 
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
@@ -70,6 +73,15 @@ extern int optind;
 #define QOPT_ENABLE	(1)
 #define QOPT_DISABLE	(-1)
 
+#ifndef FS_IOC_SETFSLABEL
+#define FSLABEL_MAX 256
+#define FS_IOC_SETFSLABEL	_IOW(0x94, 50, char[FSLABEL_MAX])
+#endif
+
+#ifndef FS_IOC_GETFSLABEL
+#define FS_IOC_GETFSLABEL	_IOR(0x94, 49, char[FSLABEL_MAX])
+#endif
+
 extern int ask_yn(const char *string, int def);
 
 const char *program_name = "tune2fs";
@@ -2997,6 +3009,75 @@ fs_update_journal_user(struct ext2_super_block *sb, __u8 old_uuid[UUID_SIZE])
 	return 0;
 }
 
+/*
+ * Use FS_IOC_SETFSLABEL or FS_IOC_GETFSLABEL to set/get file system label
+ * Return:	0 on success
+ *		1 on error
+ *		-1 when the old method should be used
+ */
+int handle_fslabel(int setlabel) {
+	errcode_t ret;
+	int mnt_flags, fd;
+	char label[FSLABEL_MAX];
+	int maxlen = FSLABEL_MAX - 1;
+	char mntpt[PATH_MAX + 1];
+
+	ret = ext2fs_check_mount_point(device_name, &mnt_flags,
+					  mntpt, sizeof(mntpt));
+	if (ret) {
+		com_err(device_name, ret, _("while checking mount status"));
+		return 1;
+	}
+	if (!(mnt_flags & EXT2_MF_MOUNTED) ||
+	    (setlabel && (mnt_flags & EXT2_MF_READONLY)))
+		return -1;
+
+	if (!mntpt[0]) {
+		fprintf(stderr,_("Unknown mount point for %s\n"), device_name);
+		return 1;
+	}
+
+	fd = open(mntpt, O_RDONLY);
+	if (fd < 0) {
+		com_err(mntpt, errno, _("while opening mount point"));
+		return 1;
+	}
+
+	/* Get fs label */
+	if (!setlabel) {
+		if (ioctl(fd, FS_IOC_GETFSLABEL, &label)) {
+			close(fd);
+			if (errno == ENOTTY)
+				return -1;
+			com_err(mntpt, errno, _("while trying to get fs label"));
+			return 1;
+		}
+		close(fd);
+		printf("%.*s\n", EXT2_LEN_STR(label));
+		return 0;
+	}
+
+	/* If it's extN file system, truncate the label to appropriate size */
+	if (mnt_flags & EXT2_MF_EXTFS)
+		maxlen = EXT2_LABEL_LEN;
+	if (strlen(new_label) > maxlen) {
+		fputs(_("Warning: label too long, truncating.\n"),
+		      stderr);
+		new_label[maxlen] = '\0';
+	}
+
+	/* Set fs label */
+	if (ioctl(fd, FS_IOC_SETFSLABEL, new_label)) {
+		close(fd);
+		if (errno == ENOTTY)
+			return -1;
+		com_err(mntpt, errno, _("while trying to set fs label"));
+		return 1;
+	}
+	close(fd);
+	return 0;
+}
+
 #ifndef BUILD_AS_LIB
 int main(int argc, char **argv)
 #else
@@ -3038,6 +3119,21 @@ int tune2fs_main(int argc, char **argv)
 #endif
 		io_ptr = unix_io_manager;
 
+	/*
+	 * Try the get/set fs label using ioctls before we even attempt
+	 * to open the file system.
+	 */
+	if (L_flag || print_label) {
+		rc = handle_fslabel(L_flag);
+		if (rc != -1) {
+#ifndef BUILD_AS_LIB
+			exit(rc);
+#endif
+			return rc;
+		}
+		rc = 0;
+	}
+
 retry_open:
 	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
 		open_flag |= EXT2_FLAG_SKIP_MMP;
-- 
2.31.1

