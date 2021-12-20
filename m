Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA847B478
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhLTUlH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Dec 2021 15:41:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55501 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229436AbhLTUlH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Dec 2021 15:41:07 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BKKf1SZ024569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 15:41:01 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DB36815C33A4; Mon, 20 Dec 2021 15:41:00 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     guan@eryu.me
Cc:     fstests@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl directly
Date:   Mon, 20 Dec 2021 15:40:59 -0500
Message-Id: <20211220204059.2248577-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <Yb9M3aIb9cJGIJaB@desktop>
References: <Yb9M3aIb9cJGIJaB@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

E2fsprogs commits 4ea80d031c7e ("resize2fs: adjust new size of the
file system to allow a successful resize") and 50088b1996cc
("resize2fs: attempt to keep the # of inodes valid by removing the
last bg") will automatically reduce the requested new size of the file
system by up to a single block group to avoid overflowing the 32-bit
inode count.   This interferes with ext4/033's test of kernel commit
4f2f76f75143 ("ext4: Forbid overflowing inode count when # resizing".)

Address this by creating a new test program, ext4_resize which calls
the EXT4_IOC_RESIZE_FS ioctl directly so we can correctly test the
kernel's online resize code.

Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 .gitignore        |  1 +
 src/Makefile      |  2 +-
 src/ext4_resize.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/033    | 16 ++++++++++-----
 4 files changed, 63 insertions(+), 6 deletions(-)
 create mode 100644 src/ext4_resize.c

diff --git a/.gitignore b/.gitignore
index 9e6d2fd5..65b93307 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@ tags
 /src/dirperf
 /src/dirstress
 /src/e4compact
+/src/ext4_resize
 /src/fault
 /src/feature
 /src/fiemap-tester
diff --git a/src/Makefile b/src/Makefile
index 25ab061d..1737ed0e 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
-	detached_mounts_propagation
+	detached_mounts_propagation ext4_resize
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py
diff --git a/src/ext4_resize.c b/src/ext4_resize.c
new file mode 100644
index 00000000..1ac51e6f
--- /dev/null
+++ b/src/ext4_resize.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Test program which uses the raw ext4 resize_fs ioctl directly.
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+
+typedef unsigned long long __u64;
+
+#ifndef EXT4_IOC_RESIZE_FS
+#define EXT4_IOC_RESIZE_FS		_IOW('f', 16, __u64)
+#endif
+
+int main(int argc, char **argv)
+{
+	__u64	new_size;
+	int	error, fd;
+	char	*tmp = NULL;
+
+	if (argc != 3) {
+		fputs("insufficient arguments\n", stderr);
+		return 1;
+	}
+	fd = open(argv[1], O_RDONLY);
+	if (!fd) {
+		perror(argv[1]);
+		return 1;
+	}
+
+	new_size = strtoull(argv[2], &tmp, 10);
+	if ((errno) || (*tmp != '\0')) {
+		fprintf(stderr, "%s: invalid new size\n", argv[0]);
+		return 1;
+	}
+
+	error = ioctl(fd, EXT4_IOC_RESIZE_FS, &new_size);
+	if (error < 0) {
+		perror("EXT4_IOC_RESIZE_FS");
+		return 1;
+	}
+	return 0;
+}
diff --git a/tests/ext4/033 b/tests/ext4/033
index 1bc14c03..22041a17 100755
--- a/tests/ext4/033
+++ b/tests/ext4/033
@@ -5,7 +5,8 @@
 # FS QA Test 033
 #
 # Test s_inodes_count overflow for huge filesystems. This bug was fixed
-# by commit "ext4: Forbid overflowing inode count when resizing".
+# by commit 4f2f76f75143 ("ext4: Forbid overflowing inode count when
+# resizing".)
 #
 . ./common/preamble
 _begin_fstest auto ioctl resize
@@ -28,7 +29,9 @@ _supported_fs ext4
 _require_scratch_nocheck
 _require_dmhugedisk
 _require_dumpe2fs
-_require_command "$RESIZE2FS_PROG" resize2fs
+_require_test_program ext4_resize
+
+EXT4_RESIZE=$here/src/ext4_resize
 
 # Figure out whether device is large enough
 devsize=$(blockdev --getsize64 $SCRATCH_DEV)
@@ -68,7 +71,8 @@ $DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
 
 # This should fail, s_inodes_count would just overflow!
 echo "Resizing to inode limit + 1..."
-$RESIZE2FS_PROG $DMHUGEDISK_DEV $((limit_groups*group_blocks)) >> $seqres.full 2>&1
+echo $EXT4_RESIZE $SCRATCH_MNT $((limit_groups*group_blocks)) >> $seqres.full 2>&1
+$EXT4_RESIZE $SCRATCH_MNT $((limit_groups*group_blocks)) >> $seqres.full 2>&1
 if [ $? -eq 0 ]; then
 	echo "Resizing succeeded but it should fail!"
 	exit
@@ -76,7 +80,8 @@ fi
 
 # This should succeed, we are maxing out inodes
 echo "Resizing to max group count..."
-$RESIZE2FS_PROG $DMHUGEDISK_DEV $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
+echo $EXT4_RESIZE $SCRATCH_MNT $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
+$EXT4_RESIZE $SCRATCH_MNT $(((limit_groups-1)*group_blocks)) >> $seqres.full 2>&1
 if [ $? -ne 0 ]; then
 	echo "Resizing failed!"
 	exit
@@ -87,7 +92,8 @@ $DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
 
 # This should fail, s_inodes_count would overflow by quite a bit!
 echo "Resizing to device size..."
-$RESIZE2FS_PROG $DMHUGEDISK_DEV >> $seqres.full 2>&1
+echo $EXT4_RESIZE $SCRATCH_MNT $(((limit_groups + 16)*group_blocks)) >> $seqres.full 2>&1
+$EXT4_RESIZE $SCRATCH_MNT $(((limit_groups + 16)*group_blocks)) >> $seqres.full 2>&1
 if [ $? -eq 0 ]; then
 	echo "Resizing succeeded but it should fail!"
 	exit
-- 
2.31.0

