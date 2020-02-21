Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32C216896D
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 22:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBUVlM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 16:41:12 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:42470 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVlM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 16:41:12 -0500
Received: from webber.adilger.ext ([70.77.216.213])
        by shaw.ca with ESMTP
        id 5G2mjUn0KkqGX5G2ojYHGS; Fri, 21 Feb 2020 14:41:10 -0700
X-Authority-Analysis: v=2.3 cv=c/jVvi1l c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17 a=ySfo2T4IAAAA:8
 a=78llN0OG3FWJ5FQ7z0cA:9 a=zph2JHZm_e-AFvCm:21 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] libext2fs: don't use O_DIRECT for files on tmpfs
Date:   Fri, 21 Feb 2020 14:40:56 -0700
Message-Id: <20200221214056.39993-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLi7fgAed2uH4keEVyn3ccRZqHbH6JSakuVdNHHtigp683LkyWyB+oSolxcIMwe4zsZJlcbDZiRfibMpRej2pbS983omt+LGcj/Y18lYcHRMwpT5AqMT
 YrPLHtP7LUnnJ91+3MyKuIwFXJSvxhoRdp27JZCXNf6S5I7h+sDxkV3pI5kEcQocFuR3kmtlpbASvWtpUg94ChDIkMxPg6e2L2h1eBlS8v4SJsrijOZ/JF2X
 6XayPsJHDnr4YAbZl4pfhg==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If a filesystem image is on tmpfs, opening it with O_DIRECT for
reading the MMP will fail.  This is unnecessary, since the image
file can't really be open on another node at this point.  If the
open with O_DIRECT fails, retry without it when plausible.

Remove the special-casing of tmpfs from the mmp test cases.

Change-Id: I41f4b31657b06f62f10be8d6e524d303dd36a321
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
---
 lib/ext2fs/mmp.c             | 15 ++++++++++++++-
 tests/f_mmp/script           | 11 -----------
 tests/f_mmp_garbage/script   | 11 -----------
 tests/m_image_mmp/script     | 11 -----------
 tests/m_mmp/script           | 10 ----------
 tests/m_mmp_bad_csum/script  | 10 ----------
 tests/m_mmp_bad_magic/script | 10 ----------
 tests/t_mmp_1on/script       | 11 -----------
 tests/t_mmp_2off/script      | 11 -----------
 9 files changed, 14 insertions(+), 86 deletions(-)

diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index 2da935e0..e96a2273 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -57,8 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 	 * regardless of how the io_manager is doing reads, to avoid caching of
 	 * the MMP block by the io_manager or the VM.  It needs to be fresh. */
 	if (fs->mmp_fd <= 0) {
-		fs->mmp_fd = open(fs->device_name, O_RDWR | O_DIRECT);
+		int flags = O_RDWR | O_DIRECT;
+
+retry:
+		fs->mmp_fd = open(fs->device_name, flags);
 		if (fs->mmp_fd < 0) {
+			struct stat st;
+
+			/* Avoid O_DIRECT for filesystem image files if open
+			 * fails, since it breaks when running on tmpfs. */
+			if (errno == EINVAL && (flags & O_DIRECT) &&
+			    stat(fs->device_name, &st) == 0 &&
+			    S_ISREG(st.st_mode)) {
+				flags &= ~O_DIRECT;
+				goto retry;
+			}
 			retval = EXT2_ET_MMP_OPEN_DIRECT;
 			goto out;
 		}
diff --git a/tests/f_mmp/script b/tests/f_mmp/script
index 07ae2321..f433bd5f 100644
--- a/tests/f_mmp/script
+++ b/tests/f_mmp/script
@@ -1,16 +1,5 @@
 FSCK_OPT=-yf
 
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ]; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
-
 echo "make the test image ..." > $test_name.log
 $MKE2FS -q -F -o Linux -b 4096 -O mmp -E mmp_update_interval=1 $TMPFILE 100 >> $test_name.log 2>&1
 status=$?
diff --git a/tests/f_mmp_garbage/script b/tests/f_mmp_garbage/script
index 6d451a67..69be3387 100644
--- a/tests/f_mmp_garbage/script
+++ b/tests/f_mmp_garbage/script
@@ -1,16 +1,5 @@
 FSCK_OPT=-yf
 
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ] ; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
-
 echo "make the test image ..." > $test_name.log
 $MKE2FS -q -F -o Linux -b 4096 -O mmp -E mmp_update_interval=1 $TMPFILE 100 >> $test_name.log 2>&1
 status=$?
diff --git a/tests/m_image_mmp/script b/tests/m_image_mmp/script
index bc6f320b..5af6f552 100644
--- a/tests/m_image_mmp/script
+++ b/tests/m_image_mmp/script
@@ -1,14 +1,3 @@
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ]; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
-
 $MKE2FS -q -F -o Linux -b 4096 -O mmp -E mmp_update_interval=1 $TMPFILE 100 >> $test_name.log 2>&1
 status=$?
 if [ "$status" != 0 ] ; then
diff --git a/tests/m_mmp/script b/tests/m_mmp/script
index 6a9394de..e456183c 100644
--- a/tests/m_mmp/script
+++ b/tests/m_mmp/script
@@ -3,16 +3,6 @@ FS_SIZE=65536
 MKE2FS_DEVICE_SECTSIZE=2048
 export MKE2FS_DEVICE_SECTSIZE
 
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ]; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
 MKE2FS_OPTS="-b 4096 -O mmp"
 . $cmd_dir/run_mke2fs
 unset MKE2FS_DEVICE_SECTSIZE
diff --git a/tests/m_mmp_bad_csum/script b/tests/m_mmp_bad_csum/script
index 4c8fe165..a5e222eb 100644
--- a/tests/m_mmp_bad_csum/script
+++ b/tests/m_mmp_bad_csum/script
@@ -1,13 +1,3 @@
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ]; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
 gzip -dc < $test_dir/image.gz > $TMPFILE
 
 OUT=$test_name.log
diff --git a/tests/m_mmp_bad_magic/script b/tests/m_mmp_bad_magic/script
index 4c8fe165..a5e222eb 100644
--- a/tests/m_mmp_bad_magic/script
+++ b/tests/m_mmp_bad_magic/script
@@ -1,13 +1,3 @@
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ]; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
 gzip -dc < $test_dir/image.gz > $TMPFILE
 
 OUT=$test_name.log
diff --git a/tests/t_mmp_1on/script b/tests/t_mmp_1on/script
index cfed2ca8..733395ef 100644
--- a/tests/t_mmp_1on/script
+++ b/tests/t_mmp_1on/script
@@ -1,16 +1,5 @@
 FSCK_OPT=-yf
 
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ] ; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
-
 $MKE2FS -q -F -o Linux -b 4096 $TMPFILE 100 > $test_name.log 2>&1
 status=$?
 if [ "$status" != 0 ] ; then
diff --git a/tests/t_mmp_2off/script b/tests/t_mmp_2off/script
index 6556201f..ccd859b2 100644
--- a/tests/t_mmp_2off/script
+++ b/tests/t_mmp_2off/script
@@ -1,16 +1,5 @@
 FSCK_OPT=-yf
 
-# use current directory instead of /tmp becase tmpfs doesn't support DIO
-rm -f $TMPFILE
-TMPFILE=$(mktemp ./tmp-$test_name.XXXXXX)
-
-stat -f $TMPFILE | grep -q "Type: tmpfs"
-if [ $? = 0 ]; then
-	rm -f $TMPFILE
-	echo "$test_name: $test_description: skipped for tmpfs (no O_DIRECT)"
-	return 0
-fi
-
 $MKE2FS -q -F -o Linux -b 4096 -O mmp $TMPFILE 100 > $test_name.log 2>&1
 status=$?
 if [ "$status" != 0 ] ; then
-- 
2.21.0 (Apple Git-122)

