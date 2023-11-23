Return-Path: <linux-ext4+bounces-97-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0497F56B3
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 04:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AD4B20D64
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 03:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1D53B7;
	Thu, 23 Nov 2023 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 19:05:30 PST
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECE6CB
	for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 19:05:30 -0800 (PST)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTPS
	id 5x6TrDugwB0n0600Vr3LCN; Thu, 23 Nov 2023 03:03:59 +0000
Received: from webber.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id 600Ur9wgmU5YW600UrCKcO; Thu, 23 Nov 2023 03:03:59 +0000
X-Authority-Analysis: v=2.4 cv=CZQbWZnl c=1 sm=1 tr=0 ts=655ec11f
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=RPJ6JBhKAAAA:8
 a=QcTkzZF95xFP97UDVdkA:9 a=fa_un-3J20JGBB2Tu-mn:22
From: Andreas Dilger <adilger@dilger.ca>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] tests: make m_assume_storage_prezeroed more robust
Date: Wed, 22 Nov 2023 20:03:50 -0700
Message-Id: <20231123030350.7418-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD4NC4b1n/cMTx87TaoM5AD/BelHKFRMqlDIQG6XRAxzhbalsMORp2FGjSgKgNun3wWqrNb0Lf6UfEEgjxvv76oDFH6onIwkFUBBtF2vUWXC02KXit0S
 X46qtnsPmIzEjq6UTfDvp1Y63xiFsWfTQEKCVDP8Y7BRX9LzjI1HYRGSDJE57AcHL/LZEVtnSg4s40u72grZUu+xJP5PfsLK7OmPXD3/MHCm6XMh3btA4YB8
 eMpEZIwId8ByFUlFT0WFFw==

Don't assume that mke2fs is going to zero out an exact number
of blocks when run with/without "-E assume_storage_prezeroed",
since this depends on a number of different options that are
not specified in the test script.

Instead, check that the number of blocks zeroed in the image is
a small fraction (1/40th) of the number of blocks zeroed when
"-E assume_sotrage_prezeroed" is not given, which makes it more
robust when running in different environments.  This varies from
1/47 in the original test to 1/91 in my local test environment.

Avoid "losetup --sector-size 4096", use "mke2fs -b 4096" instead.
Clean up the loop device before checking "stat" so that all
blocks are flushed to the backing storage before calling sync.
Only one loop device and test file is needed for the test.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 tests/m_assume_storage_prezeroed/expect |  2 -
 tests/m_assume_storage_prezeroed/script | 64 ++++++++++++-------------
 2 files changed, 30 insertions(+), 36 deletions(-)
 delete mode 100644 tests/m_assume_storage_prezeroed/expect

diff --git a/tests/m_assume_storage_prezeroed/expect b/tests/m_assume_storage_prezeroed/expect
deleted file mode 100644
index b735e2425..000000000
--- a/tests/m_assume_storage_prezeroed/expect
+++ /dev/null
@@ -1,2 +0,0 @@
-> 10000
-224
diff --git a/tests/m_assume_storage_prezeroed/script b/tests/m_assume_storage_prezeroed/script
index 1a8d84635..eea881428 100644
--- a/tests/m_assume_storage_prezeroed/script
+++ b/tests/m_assume_storage_prezeroed/script
@@ -10,48 +10,44 @@ if test "$(id -u)" -ne 0 ; then
 elif ! command -v losetup >/dev/null ; then
     echo "$test_name: $test_description: skipped (no losetup)"
 else
-    dd if=/dev/zero of=$TMPFILE.1 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
-    dd if=/dev/zero of=$TMPFILE.2 bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
+    dd if=/dev/zero of=$TMPFILE bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
 
-    LOOP1=$(losetup --show --sector-size 4096 -f $TMPFILE.1)
-    if [ ! -b "$LOOP1" ]; then
-        echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
-        rm -f $TMPFILE.1 $TMPFILE.2
-        exit 0
-    fi
-    LOOP2=$(losetup --show --sector-size 4096 -f $TMPFILE.2)
-    if [ ! -b "$LOOP2" ]; then
-        echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
-        rm -f $TMPFILE.1 $TMPFILE.2
-	losetup -d $LOOP1
-        exit 0
+    LOOP=$(losetup --show -f $TMPFILE)
+    if [ ! -b "$LOOP" ]; then
+         echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
+         rm -f $TMPFILE
+         exit 0
     fi
 
-    echo $MKE2FS -o Linux -t ext4 $LOOP1 >> $LOG 2>&1
-    $MKE2FS -o Linux -t ext4 $LOOP1 >> $LOG 2>&1
+    cmd="$MKE2FS -o Linux -t ext4 -b 4096"
+    echo "$cmd $LOOP" >> $LOG
+    $cmd $LOOP >> $LOG 2>&1
+    losetup -d $LOOP
     sync
-    stat $TMPFILE.1 >> $LOG 2>&1
-    SZ=$(stat -c "%b" $TMPFILE.1)
-    if test $SZ -gt 10000 ; then
-	echo "> 10000" > $OUT
-    else
-	echo "$SZ" > $OUT
+    stat $TMPFILE >> $LOG 2>&1
+    BLOCKS_DEF=$(stat -c "%b" $TMPFILE)
+
+    > $TMPFILE
+    dd if=/dev/zero of=$TMPFILE bs=1 count=0 seek=$FILE_SIZE >> $LOG 2>&1
+    LOOP=$(losetup --show -f $TMPFILE)
+    if [ ! -b "$LOOP" ]; then
+         echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
+         rm -f $TMPFILE
+         exit 0
     fi
 
-    echo $MKE2FS -o Linux -t ext4 -E assume_storage_prezeroed=1 $LOOP2 >> $LOG 2>&1
-    $MKE2FS -o Linux -t ext4 -E assume_storage_prezeroed=1 $LOOP2 >> $LOG 2>&1
+    cmd+=" -E assume_storage_prezeroed=1"
+    echo "$cmd $LOOP" >> $LOG
+    $cmd $TMPFILE >> $LOG 2>&1
+    losetup -d $LOOP
     sync
-    stat $TMPFILE.2 >> $LOG 2>&1
-    stat -c "%b" $TMPFILE.2 >> $OUT
-
-    losetup -d $LOOP1
-    losetup -d $LOOP2
-    rm -f $TMPFILE.1 $TMPFILE.2
+    stat $TMPFILE >> $LOG 2>&1
+    BLOCKS_ASP=$(stat -c "%b" $TMPFILE)
 
-    cmp -s $OUT $EXP
-    status=$?
+    echo "blocks_dev: $BLOCKS_DEF blocks_asp: ${BLOCKS_ASP}" >> $LOG
 
-    if [ "$status" = 0 ] ; then
+    # should use less than 1/20 of the blocks with assume_storage_prezeroed
+    if (( $BLOCKS_DEF > $BLOCKS_ASP * 40 )) ; then
 	echo "$test_name: $test_description: ok"
 	touch $test_name.ok
     else
@@ -60,4 +56,4 @@ else
 	diff $EXP $OUT >> $test_name.failed
     fi
 fi
-unset LOG OUT EXP FILE_SIZE LOOP1 LOOP2
+unset LOG OUT EXP FILE_SIZE LOOP
-- 
2.25.1


