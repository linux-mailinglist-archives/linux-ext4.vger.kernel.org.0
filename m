Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256F663802
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 05:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjAJEGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 23:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjAJEFu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 23:05:50 -0500
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A44321B2
        for <linux-ext4@vger.kernel.org>; Mon,  9 Jan 2023 20:05:48 -0800 (PST)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id F1OEpw0HBl2xSF5tTpzuCk; Tue, 10 Jan 2023 04:05:47 +0000
Received: from centos7.dilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id F5tTpTtgQHFsOF5tTp3sNA; Tue, 10 Jan 2023 04:05:47 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=63bce41b
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=USMdwZXE_HJfLks3l7QA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] tests: fix u_direct_io to work with older losetup
Date:   Mon,  9 Jan 2023 21:05:35 -0700
Message-Id: <1673323535-14317-1-git-send-email-adilger@dilger.ca>
X-Mailer: git-send-email 1.8.3.1
X-CMAE-Envelope: MS4xfJQoH7odYORrg1V94Hdf/FUcPelDCeOUo6q4X8X4gDVroaqFAezadGtgNaXNKFbKFoZdiih6rAIu40S2yoIs8eLvq5uVqkL4FdIHSBc6ZPAnWdL0a9Oy
 A1s2sP2dOUDLoCNqP253rf76gW8b76wr2GX/LuDngJKGv+z/D9jOj7OqCur70iwPO/D6FQYqjEP1yttPJl9Efj2ztETTLrTvbVDjRsb9EOR3Uu47gyKOHSRA
 u3ZTd8yZ/OO0EFNJ66bQkA==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Older losetup does not have --sector-size, but this isn't really
needed for the test to work.  Instead specify the filesystem block
size directly to mke2fs, so that it works on all distros instead
of being skipped.

Change-Id: I5a0c82a9efdefd1b48f4d4288998c7725c9ae71e
Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 tests/u_direct_io/expect | 2 +-
 tests/u_direct_io/script | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/u_direct_io/expect b/tests/u_direct_io/expect
index 830cbd752652..b1511ef10aa9 100644
--- a/tests/u_direct_io/expect
+++ b/tests/u_direct_io/expect
@@ -1,4 +1,4 @@
-mke2fs -F -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D $LOOP
+mke2fs -F -b 4096 -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D $LOOP
 Creating filesystem with 32768 4k blocks and 32768 inodes
 
 Allocating group tables:    done                            
diff --git a/tests/u_direct_io/script b/tests/u_direct_io/script
index b4f07752c89f..2f80e640293f 100644
--- a/tests/u_direct_io/script
+++ b/tests/u_direct_io/script
@@ -8,14 +8,14 @@ elif test ! -x $DEBUGFS_EXE; then
     echo "$test_name: $DESCRIPTION: skipped (no debugfs)"
 else
     dd if=/dev/zero of=$TMPFILE bs=1M count=128 > /dev/null 2>&1
-    LOOP=$(losetup --show --sector-size 4096 -f $TMPFILE)
+    LOOP=$(losetup --show -f $TMPFILE 2>&1)
     if [ ! -b "$LOOP" ]; then
         echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
         rm -f $TMPFILE
         exit 0
     fi
-    echo mke2fs -F -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D \$LOOP > $OUT
-    $MKE2FS -F -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D $LOOP 2>&1 | \
+    echo mke2fs -F -b 4096 -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D \$LOOP > $OUT
+    $MKE2FS -F -b 4096 -o Linux -t ext4 -O ^metadata_csum,^uninit_bg -D $LOOP 2>&1 | \
 	sed -f $cmd_dir/filter.sed >> $OUT
 
     echo debugfs -D -R stats \$LOOP >> $OUT
-- 
1.8.3.1

