Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E775215BC83
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 11:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgBMKQJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 05:16:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgBMKQI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 05:16:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C16B8AC52;
        Thu, 13 Feb 2020 10:16:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3869D1E0E53; Thu, 13 Feb 2020 11:16:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/7] tests: Modify f_large_dir test to excercise indexed dir handling
Date:   Thu, 13 Feb 2020 11:16:00 +0100
Message-Id: <20200213101602.29096-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213101602.29096-1-jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Modify f_large_dir test to create indexed directory and create entries
in it. That way the new code in ext2fs_link() for addition of entries
into indexed directories gets executed including various special cases
when growing htree.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/f_large_dir/expect | 10 ++++++++++
 tests/f_large_dir/script | 27 ++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/tests/f_large_dir/expect b/tests/f_large_dir/expect
index 8f7d99dc1ee7..028234cc6bb5 100644
--- a/tests/f_large_dir/expect
+++ b/tests/f_large_dir/expect
@@ -6,6 +6,16 @@ Allocating group tables:      done
 Writing inode tables:      done                            
 Writing superblocks and filesystem accounting information:      done
 
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 3A: Optimizing directories
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+
+test.img: ***** FILE SYSTEM WAS MODIFIED *****
+test.img: 17/65072 files (5.9% non-contiguous), 9732/108341 blocks
+Exit status is 0
 Pass 1: Checking inodes, blocks, and sizes
 Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
diff --git a/tests/f_large_dir/script b/tests/f_large_dir/script
index 9af042ca6ca8..e3235836f997 100644
--- a/tests/f_large_dir/script
+++ b/tests/f_large_dir/script
@@ -26,17 +26,33 @@ $MKE2FS -b 1024 -O large_dir,uninit_bg -N $((ENTRIES + 50)) \
 RC=$?
 if [ $RC -eq 0 ]; then
 {
-	START=$SECONDS
+	# First some initial fs setup to create indexed dir
 	echo "mkdir /foo"
 	echo "cd /foo"
 	touch $TMPFILE.tmp
 	echo "write $TMPFILE.tmp foofile"
 	i=0
-	last=0
+	while test $i -lt $DIRENT_PER_LEAF ; do
+		printf "mkdir d%0254u\n" $i
+		i=$((i + 1));
+	done
+	echo "expand ./"
+	printf "mkdir d%0254u\n" $i
+} | $DEBUGFS -w $TMPFILE > /dev/null 2>> $OUT.new
+	RC=$?
+	# e2fsck should optimize the dir to become indexed
+	$E2FSCK -yfD $TMPFILE >> $OUT.new 2>&1
+	status=$?
+	echo Exit status is $status >> $OUT.new
+fi
+
+if [ $RC -eq 0 ]; then
+{
+	START=$SECONDS
+	i=$(($DIRENT_PER_LEAF+1))
+	last=$i
+	echo "cd /foo"
 	while test $i -lt $ENTRIES ; do
-	    if test $((i % DIRENT_PER_LEAF)) -eq 0; then
-	    	echo "expand ./"
-	    fi
 	    ELAPSED=$((SECONDS - START))
 	    if test $((i % 5000)) -eq 0 -a $ELAPSED -gt 10; then
 		RATE=$(((i - last) / ELAPSED))
@@ -54,6 +70,7 @@ if [ $RC -eq 0 ]; then
 } | $DEBUGFS -w $TMPFILE > /dev/null 2>> $OUT.new
 	RC=$?
 fi
+
 if [ $RC -eq 0 ]; then
 	$E2FSCK -yfD $TMPFILE >> $OUT.new 2>&1
 	status=$?
-- 
2.16.4

