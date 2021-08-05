Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6F3E1719
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbhHEOkm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 10:40:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60365 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234937AbhHEOkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 10:40:41 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 175EeM24003803
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Aug 2021 10:40:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3E00415C3DD2; Thu,  5 Aug 2021 10:40:22 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     artem.blagodarenko@gmail.com, denis@voxelsoft.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: add test to validate the large_dir feature
Date:   Thu,  5 Aug 2021 10:40:16 -0400
Message-Id: <20210805144016.3556979-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/dirstress.c    |  7 +++++-
 tests/ext4/051     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/051.out |  2 ++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100755 tests/ext4/051
 create mode 100644 tests/ext4/051.out

diff --git a/src/dirstress.c b/src/dirstress.c
index 615cb6e3..ec28d643 100644
--- a/src/dirstress.c
+++ b/src/dirstress.c
@@ -16,6 +16,7 @@ int verbose;
 int pid;
 
 int checkflag=0;
+int create_only=0;
 
 #define MKNOD_DEV 0
 
@@ -51,7 +52,7 @@ main(
 	nprocs_per_dir = 1;
 	keep = 0;
         verbose = 0;
-	while ((c = getopt(argc, argv, "d:p:f:s:n:kvc")) != EOF) {
+	while ((c = getopt(argc, argv, "d:p:f:s:n:kvcC")) != EOF) {
 		switch(c) {
 			case 'p':
 				nprocs = atoi(optarg);
@@ -80,6 +81,9 @@ main(
 			case 'c':
                                 checkflag++;
                                 break;
+			case 'C':
+				create_only++;
+				break;
 		}
 	}
 	if (errflg || (dirname == NULL)) {
@@ -170,6 +174,7 @@ dirstress(
 	if (create_entries(nfiles)) {
             printf("!! [%d] create failed\n", pid);
         } else {
+	    if (create_only) return 0;
             if (verbose) fprintf(stderr,"** [%d] scramble entries\n", pid);
 	    if (scramble_entries(nfiles)) {
                 printf("!! [%d] scramble failed\n", pid);
diff --git a/tests/ext4/051 b/tests/ext4/051
new file mode 100755
index 00000000..387e2518
--- /dev/null
+++ b/tests/ext4/051
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test 051
+#
+# Test ext4's large_dir feature
+#
+. ./common/preamble
+_begin_fstest auto quick dir
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	if [ ! -z "$loop_mnt" ]; then
+		$UMOUNT_PROG $loop_mnt
+		rm -rf $loop_mnt
+	fi
+	[ ! -z "$fs_img" ] && rm -rf $fs_img
+}
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_test
+_require_loop
+_require_scratch_ext4_feature "large_dir"
+
+echo "Silence is golden"
+
+loop_mnt=$TEST_DIR/$seq.mnt
+fs_img=$TEST_DIR/$seq.img
+status=0
+
+cp /dev/null $fs_img
+${MKFS_PROG} -t ${FSTYP} -b 1024 -N 600020 -O large_dir,^has_journal \
+	     $fs_img 40G >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+mkdir -p $loop_mnt
+_mount -o loop $fs_img $loop_mnt > /dev/null  2>&1 || \
+	_fail "Couldn't do initial mount"
+
+/root/xfstests/src/dirstress -c -d /tmpmnt -p 1 -f 400000 -C \
+	>> $seqres.full 2>&1
+
+if ! $here/src/dirstress -c -d $loop_mnt -p 1 -f 400000 -C >$tmp.out 2>&1
+then
+    echo "    dirstress failed"
+    cat $tmp.out >> $seqres.full
+    echo "    dirstress failed" >> $seqres.full
+    status=1
+fi
+
+$UMOUNT_PROG $loop_mnt || _fail "umount failed"
+loop_mnt=
+
+$E2FSCK_PROG -fn $fs_img >> $seqres.full 2>&1 || _fail "file system corrupted"
diff --git a/tests/ext4/051.out b/tests/ext4/051.out
new file mode 100644
index 00000000..32f74d89
--- /dev/null
+++ b/tests/ext4/051.out
@@ -0,0 +1,2 @@
+QA output created by 051
+Silence is golden
-- 
2.31.0

