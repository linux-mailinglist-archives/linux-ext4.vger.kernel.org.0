Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39CA3E1718
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbhHEOkR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 10:40:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60170 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241648AbhHEOjw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 10:39:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 175EdNkW003321
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Aug 2021 10:39:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 61FC715C3DD2; Thu,  5 Aug 2021 10:39:23 -0400 (EDT)
Date:   Thu, 5 Aug 2021 10:39:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     Carlos Carvalho <carlos@fisica.ufpr.br>,
        linux-ext4@vger.kernel.org, Theodore Tso <tytso@google.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: bug with large_dir in 5.12.17
Message-ID: <YQv4G+lenN+3G723@mit.edu>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
 <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com>
 <YQrpmUq/y3T/L2E6@mit.edu>
 <B24E01FD-F436-4BA5-BDB3-E1CDB2E07EF3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B24E01FD-F436-4BA5-BDB3-E1CDB2E07EF3@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 05, 2021 at 12:15:41AM +0300, Благодаренко Артём wrote:
> Hello Teodore,
> 
> Your one-line fix looks good.
> 
> I have tested it. 1560000 names created successfully.
> 
> But the patch with refactoring doesn’t work.

Thanks for testing both patches.  I was more intersted in the one-line
fix so I hadn't tried testing the refactoring patch.  That's for a
later cleanup.

In any case, I've come up with a test to automate testing and to make
sure we don't regress in the future.  It runs pretty quickly, for
either failure or success, so it's good as a smoke test.  We may want
to consider a longer stress test as well.  Artem, do you have any
suggestions?

					- Ted

commit 5c156367952b22431850dfad8b2b2c8b753a3e91
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Aug 5 09:49:40 2021 -0400

    ext4: add test to validate the large_dir feature
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

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
