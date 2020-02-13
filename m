Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9615BC86
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 11:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgBMKQK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 05:16:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:51246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbgBMKQI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 05:16:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C41C6AFA9;
        Thu, 13 Feb 2020 10:16:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3DD111E0E55; Thu, 13 Feb 2020 11:16:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6/7] tests: Add test to excercise indexed directories with metadata_csum
Date:   Thu, 13 Feb 2020 11:16:01 +0100
Message-Id: <20200213101602.29096-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213101602.29096-1-jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Indexed directories have somewhat different format when metadata_csum is
enabled. Add test to excercise linking in indexed directories and e2fsck
rehash code in this case.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/f_large_dir_csum/expect       | 32 ++++++++++++++
 tests/f_large_dir_csum/is_slow_test |  0
 tests/f_large_dir_csum/name         |  1 +
 tests/f_large_dir_csum/script       | 84 +++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 tests/f_large_dir_csum/expect
 create mode 100644 tests/f_large_dir_csum/is_slow_test
 create mode 100644 tests/f_large_dir_csum/name
 create mode 100644 tests/f_large_dir_csum/script

diff --git a/tests/f_large_dir_csum/expect b/tests/f_large_dir_csum/expect
new file mode 100644
index 000000000000..aa9f33f1d25d
--- /dev/null
+++ b/tests/f_large_dir_csum/expect
@@ -0,0 +1,32 @@
+Creating filesystem with 31002 1k blocks and 64 inodes
+Superblock backups stored on blocks: 
+	8193, 24577
+
+Allocating group tables:    done                            
+Writing inode tables:    done                            
+Writing superblocks and filesystem accounting information:    done
+
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 3A: Optimizing directories
+Pass 4: Checking reference counts
+Inode 13 ref count is 1, should be 5.  Fix? yes
+
+Pass 5: Checking group summary information
+
+test.img: ***** FILE SYSTEM WAS MODIFIED *****
+test.img: 13/64 files (0.0% non-contiguous), 766/31002 blocks
+Exit status is 1
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 3A: Optimizing directories
+Pass 4: Checking reference counts
+Inode 13 ref count is 5, should be 46504.  Fix? yes
+
+Pass 5: Checking group summary information
+
+test.img: ***** FILE SYSTEM WAS MODIFIED *****
+test.img: 13/64 files (0.0% non-contiguous), 16390/31002 blocks
+Exit status is 1
diff --git a/tests/f_large_dir_csum/is_slow_test b/tests/f_large_dir_csum/is_slow_test
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/f_large_dir_csum/name b/tests/f_large_dir_csum/name
new file mode 100644
index 000000000000..2b37c8c21f79
--- /dev/null
+++ b/tests/f_large_dir_csum/name
@@ -0,0 +1 @@
+optimize 3 level htree directories with metadata checksums
diff --git a/tests/f_large_dir_csum/script b/tests/f_large_dir_csum/script
new file mode 100644
index 000000000000..286a965d5e6a
--- /dev/null
+++ b/tests/f_large_dir_csum/script
@@ -0,0 +1,84 @@
+OUT=$test_name.log
+EXP=$test_dir/expect
+E2FSCK=../e2fsck/e2fsck
+
+NAMELEN=255
+DIRENT_SZ=8
+BLOCKSZ=1024
+INODESZ=128
+CSUM_SZ=8
+CSUM_TAIL_SZ=12
+DIRENT_PER_LEAF=$(((BLOCKSZ - CSUM_TAIL_SZ) / (NAMELEN + DIRENT_SZ)))
+HEADER=32
+INDEX_SZ=8
+INDEX_L1=$(((BLOCKSZ - HEADER - CSUM_SZ) / INDEX_SZ))
+INDEX_L2=$(((BLOCKSZ - DIRENT_SZ - CSUM_SZ) / INDEX_SZ))
+DIRBLK=$((3 + INDEX_L1 * INDEX_L2))
+ENTRIES=$((DIRBLK * DIRENT_PER_LEAF))
+# directory leaf blocks - get twice as much because the leaves won't be full
+# and there are also other filesystem blocks.
+FSIZE=$((DIRBLK * 2))
+
+$MKE2FS -b 1024 -O extents,64bit,large_dir,uninit_bg,metadata_csum -N 50 \
+	-I $INODESZ -F $TMPFILE $FSIZE > $OUT.new 2>&1
+RC=$?
+if [ $RC -eq 0 ]; then
+{
+	# First some initial fs setup to create indexed dir
+	echo "mkdir /foo"
+	echo "cd /foo"
+	touch $TMPFILE.tmp
+	echo "write $TMPFILE.tmp foofile"
+	i=0
+	while test $i -lt $DIRENT_PER_LEAF ; do
+		printf "ln foofile f%0254u\n" $i
+		i=$((i + 1));
+	done
+	echo "expand ./"
+	printf "ln foofile f%0254u\n" $i
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
+	while test $i -lt $ENTRIES ; do
+	    ELAPSED=$((SECONDS - START))
+	    if test $((i % 5000)) -eq 0 -a $ELAPSED -gt 10; then
+		RATE=$(((i - last) / ELAPSED))
+		echo "$test_name: $i/$ENTRIES links, ${ELAPSED}s @ $RATE/s" >&2
+		START=$SECONDS
+		last=$i
+	    fi
+	    printf "ln foofile f%0254u\n" $i
+	    i=$((i + 1))
+	done
+} | $DEBUGFS -w $TMPFILE > /dev/null 2>> $OUT.new
+	RC=$?
+fi
+
+if [ $RC -eq 0 ]; then
+	$E2FSCK -yfD $TMPFILE >> $OUT.new 2>&1
+	status=$?
+	echo Exit status is $status >> $OUT.new
+	sed -f $cmd_dir/filter.sed -e "s;$TMPFILE;test.img;" $OUT.new > $OUT
+	rm -f $OUT.new
+
+	cmp -s $OUT $EXP
+	RC=$?
+fi
+if [ $RC -eq 0 ]; then
+	echo "$test_name: $test_description: ok"
+	touch $test_name.ok
+else
+	echo "$test_name: $test_description: failed"
+	diff -u $EXP $OUT > $test_name.failed
+fi
-- 
2.16.4

