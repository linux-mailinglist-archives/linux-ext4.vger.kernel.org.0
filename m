Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296E3C28A0
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfI3VT3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 17:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731206AbfI3VT1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 17:19:27 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AA9C215EA;
        Mon, 30 Sep 2019 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569878366;
        bh=OMTHCwqwJ1GzMSx0iOVcEh3EWgyzdmHyM9IeuQTR06A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+C0V9AgkHApWBc7Zd0/S46nAK+WxBm3gSSITjDRw+pfsdfk+9nrcTF9qPv8OjYO9
         mLTmssgk/z4fcHbKiMsY4vHhZ0b3xn5hynPLOOIgT0QfEQETyl8V9YhIWa29EthIO7
         VbNABAzQ6njz0tOTng2dZQzRNbGVcri/sp6Y7n1o=
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Subject: [PATCH v4 3/8] generic: test general behavior of verity files
Date:   Mon, 30 Sep 2019 14:15:48 -0700
Message-Id: <20190930211553.64208-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930211553.64208-1-ebiggers@kernel.org>
References: <20190930211553.64208-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

This is a basic fs-verity test which verifies:

- conditions for enabling verity
- verity files have expected contents and size
- can't change contents of verity files, but can change metadata
- can retrieve a verity file's measurement via FS_IOC_MEASURE_VERITY

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/900     | 199 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out |  74 ++++++++++++++++
 tests/generic/group   |   1 +
 3 files changed, 274 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..04cbcfdf
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,199 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2018 Google LLC
+#
+# FS QA Test generic/900
+#
+# This is a basic fs-verity test which verifies:
+#
+# - conditions for enabling verity
+# - verity files have correct contents and size
+# - can't change contents of verity files, but can change metadata
+# - can retrieve a verity file's measurement via FS_IOC_MEASURE_VERITY
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/verity
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_verity
+
+_scratch_mkfs_verity &>> $seqres.full
+_scratch_mount
+fsv_orig_file=$SCRATCH_MNT/file
+fsv_file=$SCRATCH_MNT/file.fsv
+
+verify_data_readable()
+{
+	local file=$1
+
+	md5sum $file > /dev/null
+}
+
+verify_data_unreadable()
+{
+	local file=$1
+
+	# try both reading just the first data block, and reading until EOF
+	head -c $FSV_BLOCK_SIZE $file 2>&1 >/dev/null | _filter_scratch
+	md5sum $file |& _filter_scratch
+}
+
+_fsv_scratch_begin_subtest "Enabling verity on file with verity already enabled fails with EEXIST"
+_fsv_create_enable_file $fsv_file
+echo "(trying again)"
+_fsv_enable $fsv_file |& _filter_scratch
+
+_fsv_scratch_begin_subtest "Enabling verity with invalid hash algorithm fails with EINVAL"
+_fsv_create_enable_file $fsv_file --hash-alg=257 |& _filter_scratch
+verify_data_readable $fsv_file
+
+_fsv_scratch_begin_subtest "Enabling verity with invalid block size fails with EINVAL"
+_fsv_create_enable_file $fsv_file --block-size=1 |& _filter_scratch
+verify_data_readable $fsv_file
+
+_fsv_scratch_begin_subtest "Enabling verity on directory fails with EISDIR"
+mkdir $SCRATCH_MNT/dir
+_fsv_enable $SCRATCH_MNT/dir |& _filter_scratch
+
+_fsv_scratch_begin_subtest "Enabling verity with too-long salt fails with EMSGSIZE"
+_fsv_create_enable_file $fsv_file --salt=$(perl -e 'print "A" x 1000') |& _filter_scratch
+verify_data_readable $fsv_file
+
+_fsv_scratch_begin_subtest "Enabling verity on file on read-only filesystem fails with EROFS"
+echo foo > $fsv_file
+_scratch_remount ro
+_fsv_enable $fsv_file |& _filter_scratch
+_scratch_remount rw
+
+_fsv_scratch_begin_subtest "Enabling verity on file open for writing fails with ETXTBSY"
+echo foo > $fsv_file
+exec 3<> $fsv_file
+_fsv_enable $fsv_file |& _filter_scratch
+exec 3<&-
+verify_data_readable $fsv_file
+
+_fsv_scratch_begin_subtest "Enabling verity can be interrupted"
+dd if=/dev/zero of=$fsv_file bs=1 count=0 seek=$((1 << 34)) status=none
+start_time=$(date +%s)
+$FSVERITY_PROG enable $fsv_file &
+sleep 0.5
+kill %1
+wait
+elapsed=$(( $(date +%s) - start_time ))
+if (( elapsed > 5 )); then
+	echo "Failed to interrupt FS_IOC_ENABLE_VERITY ($elapsed seconds elapsed)"
+fi
+
+_fsv_scratch_begin_subtest "Enabling verity on file with verity already being enabled fails with EBUSY"
+dd if=/dev/zero of=$fsv_file bs=1 count=0 seek=$((1 << 34)) status=none
+start_time=$(date +%s)
+$FSVERITY_PROG enable $fsv_file &
+sleep 0.5
+_fsv_enable $fsv_file |& _filter_scratch
+kill %1
+wait
+
+_fsv_scratch_begin_subtest "verity file can't be opened for writing"
+_fsv_create_enable_file $fsv_file >> $seqres.full
+echo "* reading"
+$XFS_IO_PROG -r $fsv_file -c ''
+echo "* xfs_io writing, should be O_RDWR"
+$XFS_IO_PROG $fsv_file -c '' |& _filter_scratch
+echo "* bash >>, should be O_APPEND"
+bash -c "echo >> $fsv_file" |& _filter_scratch
+echo "* bash >, should be O_WRONLY|O_CREAT|O_TRUNC"
+bash -c "echo > $fsv_file" |& _filter_scratch
+
+_fsv_scratch_begin_subtest "verity file can be read"
+_fsv_create_enable_file $fsv_file >> $seqres.full
+verify_data_readable $fsv_file
+
+_fsv_scratch_begin_subtest "verity file can be measured"
+_fsv_create_enable_file $fsv_file >> $seqres.full
+_fsv_measure $fsv_file
+
+_fsv_scratch_begin_subtest "verity file can be renamed"
+_fsv_create_enable_file $fsv_file
+mv $fsv_file $fsv_file.newname
+
+_fsv_scratch_begin_subtest "verity file can be unlinked"
+_fsv_create_enable_file $fsv_file
+rm $fsv_file
+
+_fsv_scratch_begin_subtest "verity file can be linked to"
+_fsv_create_enable_file $fsv_file
+ln $fsv_file $fsv_file.newname
+
+_fsv_scratch_begin_subtest "verity file can be chmodded"
+_fsv_create_enable_file $fsv_file
+chmod 777 $fsv_file
+chmod 444 $fsv_file
+
+_fsv_scratch_begin_subtest "verity file can be chowned"
+_fsv_create_enable_file $fsv_file
+chown 1:1 $fsv_file
+chown 0:0 $fsv_file
+
+_fsv_scratch_begin_subtest "verity file has correct contents and size"
+head -c 100000 /dev/urandom > $fsv_orig_file
+cp $fsv_orig_file $fsv_file
+_fsv_enable $fsv_file >> $seqres.full
+cmp $fsv_file $fsv_orig_file
+stat -c %s $fsv_file
+_scratch_cycle_mount
+cmp $fsv_file $fsv_orig_file
+stat -c %s $fsv_file
+
+_fsv_scratch_begin_subtest "Trying to measure non-verity file fails with ENODATA"
+echo foo > $fsv_file
+_fsv_measure $fsv_file |& _filter_scratch
+verify_data_readable $fsv_file
+
+# Test files <= 1 block in size.  These are a bit of a special case since there
+# are no hash blocks; the root hash is calculated directly over the data block.
+for size in 1 $((FSV_BLOCK_SIZE - 1)) $FSV_BLOCK_SIZE; do
+	_fsv_scratch_begin_subtest "verity on $size-byte file"
+	head -c $size /dev/urandom > $fsv_orig_file
+	cp $fsv_orig_file $fsv_file
+	_fsv_enable $fsv_file
+	cmp $fsv_orig_file $fsv_file && echo "Files matched"
+	rm -f $fsv_file
+done
+
+_fsv_scratch_begin_subtest "verity on 100M file (multiple levels in hash tree)"
+head -c 100000000 /dev/urandom > $fsv_orig_file
+cp $fsv_orig_file $fsv_file
+_fsv_enable $fsv_file
+cmp $fsv_orig_file $fsv_file && echo "Files matched"
+
+_fsv_scratch_begin_subtest "verity on sparse file"
+dd if=/dev/zero of=$fsv_orig_file bs=1 count=1 seek=1000000 status=none
+cp $fsv_orig_file $fsv_file
+_fsv_enable $fsv_file
+cmp $fsv_orig_file $fsv_file && echo "Files matched"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..93f91f27
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,74 @@
+QA output created by 900
+
+# Enabling verity on file with verity already enabled fails with EEXIST
+(trying again)
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/file.fsv': File exists
+
+# Enabling verity with invalid hash algorithm fails with EINVAL
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/file.fsv': Invalid argument
+
+# Enabling verity with invalid block size fails with EINVAL
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/file.fsv': Invalid argument
+
+# Enabling verity on directory fails with EISDIR
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/dir': Is a directory
+
+# Enabling verity with too-long salt fails with EMSGSIZE
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/file.fsv': Message too long
+
+# Enabling verity on file on read-only filesystem fails with EROFS
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/file.fsv': Read-only file system
+
+# Enabling verity on file open for writing fails with ETXTBSY
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/file.fsv': Text file busy
+
+# Enabling verity can be interrupted
+
+# Enabling verity on file with verity already being enabled fails with EBUSY
+ERROR: FS_IOC_ENABLE_VERITY failed on 'SCRATCH_MNT/file.fsv': Device or resource busy
+
+# verity file can't be opened for writing
+* reading
+* xfs_io writing, should be O_RDWR
+SCRATCH_MNT/file.fsv: Operation not permitted
+* bash >>, should be O_APPEND
+bash: SCRATCH_MNT/file.fsv: Operation not permitted
+* bash >, should be O_WRONLY|O_CREAT|O_TRUNC
+bash: SCRATCH_MNT/file.fsv: Operation not permitted
+
+# verity file can be read
+
+# verity file can be measured
+sha256:be54121da3877f8852c65136d731784f134c4dd9d95071502e80d7be9f99b263
+
+# verity file can be renamed
+
+# verity file can be unlinked
+
+# verity file can be linked to
+
+# verity file can be chmodded
+
+# verity file can be chowned
+
+# verity file has correct contents and size
+100000
+100000
+
+# Trying to measure non-verity file fails with ENODATA
+ERROR: FS_IOC_MEASURE_VERITY failed on 'SCRATCH_MNT/file.fsv': No data available
+
+# verity on 1-byte file
+Files matched
+
+# verity on 4095-byte file
+Files matched
+
+# verity on 4096-byte file
+Files matched
+
+# verity on 100M file (multiple levels in hash tree)
+Files matched
+
+# verity on sparse file
+Files matched
diff --git a/tests/generic/group b/tests/generic/group
index 7cf4f6c4..8c5212a1 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -570,3 +570,4 @@
 565 auto quick copy_range
 566 auto quick quota metadata
 567 auto quick rw punch
+900 auto quick verity
-- 
2.23.0.444.g18eeb5a265-goog

