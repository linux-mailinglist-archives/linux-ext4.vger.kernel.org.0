Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9F15E5C1
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393943AbgBNQnC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 11:43:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34025 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390639AbgBNQm5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Feb 2020 11:42:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id c20so9813167qkm.1;
        Fri, 14 Feb 2020 08:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YP3vB4FLSiYMsD12Fzk8Kpsrn3n01N+ovOb8Y+f5N7k=;
        b=JRyTpzkeVJSFy4ZhayN6IxOVMP6ORQNxLhPqdik/ir2YP2NK8PFd/HfkDgiASvLkCR
         BmIkHpioToy6VkO2gqyfOg7IB/2syJXHlpMvLKHz3KOzDLJ7ciajBUgswF44TQjLPOme
         +Lp9lQ48zAotu7ebx/NVnS2d9KaSqvt7oQkSAk6OXrSIA1dSz08eRjLg0Q3S918pZX7H
         9sQCjR9nY93bh2mDm6Zoj6F2FrD/zKz4VDuRMsUTJb1jC4BtiTDOA/jf2i/bChguS5uB
         SArJf7SW1zwscmpb2fN9ewUNi5yolmGJUi3QE8e8NpWJTbX3ufGuJTA0OpAPOAuqR8rV
         c2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YP3vB4FLSiYMsD12Fzk8Kpsrn3n01N+ovOb8Y+f5N7k=;
        b=bWgBFymLaYtabhsWLmt+ndtrrAcwrZOxN8WIjilSgHAW2JuX+wr1KDYVt1n/4DR1Ih
         T6FsSsXKDk6XaadYH5ejnsoYf/sPvV+AO2Kxq0KGESQv3zrip+GAZiOMwW8FI2AmqPw+
         TnzRK6rHLs+dqXBbaTupVpMlzN0ydt7+ULiJ1zl9Ec+Qxq6JUI2LLd1RNF20KYYKgFL9
         yHO6n1MBZaWOUGy/pWjOeZz6zsThxHc8MDbxHD7aODfc2d78YVRJUOGz1LwK8E3XnVBV
         a+l0/HXFI5E5D31qtooHbdVeHWxJnk54k+ukllUyHefZNjkGDr+Q2iGGJT+U4QTUlz8F
         pXIg==
X-Gm-Message-State: APjAAAVNdXh9CnmNKPVn4YLBgZQESEJaj+pHCbcZSL75wrX/NRtzXwTr
        +xvJ1Ex1qN+Bhdr02sr0cJYK6Xo0
X-Google-Smtp-Source: APXvYqzON6xyXBDb16rz+jonD/UZ+Y3iAYAaPLL4yhRhF5HseqoPh4wwhw+QzaHnaBpHXq/hxSprtg==
X-Received: by 2002:a37:887:: with SMTP id 129mr3534994qki.250.1581698575727;
        Fri, 14 Feb 2020 08:42:55 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id h8sm3453936qtm.51.2020.02.14.08.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 08:42:54 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4/002: remove EXT4_EOFBLOCKS_FL test
Date:   Fri, 14 Feb 2020 11:42:49 -0500
Message-Id: <20200214164249.21868-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test exercises obsolete ext4-specific functionality that will be
removed in the kernel's 5.7 release.  Once that happens, ext4/002 will
always fail, so remove the test to avoid the noise.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 tests/ext4/002     | 168 -----------------------------------------------------
 tests/ext4/002.out |   7 ---
 tests/ext4/group   |   1 -
 3 files changed, 176 deletions(-)
 delete mode 100755 tests/ext4/002
 delete mode 100644 tests/ext4/002.out

diff --git a/tests/ext4/002 b/tests/ext4/002
deleted file mode 100755
index 986834bb..00000000
--- a/tests/ext4/002
+++ /dev/null
@@ -1,168 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2010 Google, Inc.  All Rights Reserved.
-#
-# FS QA Test No. ext4/002
-#
-# Test to ensure that the EOFBLOCK_FL gets set/unset correctly.
-#
-# As found by Theodore Ts'o:
-# If a 128K file is falloc'ed using the KEEP_SIZE flag, and then
-# write exactly 128K, the EOFBLOCK_FL doesn't get cleared correctly.
-# This is bad since it forces e2fsck to complain about that inode.
-# If you have a large number of inodes that are written with fallocate
-# using KEEP_SIZE, and then fill them up to their expected size,
-# e2fsck will potentially complain about a _huge_ number of inodes.
-# This would also cause a huge increase in the time taken by e2fsck
-# to complete its check.
-#
-# Test scenarios covered:
-# 1. Fallocating X bytes and writing Y (Y<X) (buffered and direct io)
-# 2. Fallocating X bytes and writing Y (Y=X) (buffered and direct io)
-# 3. Fallocating X bytes and writing Y (Y>X) (buffered and direct io)
-#
-# These test cases exercise the normal and edge case conditions using
-# falloc (and KEEP_SIZE).
-#
-# Ref: http://thread.gmane.org/gmane.comp.file-systems.ext4/20682
-#
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1        # failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# Test specific macros.
-BIT_NOT_SET=0   # inode flag - 0x400000 bit is not set.
-BIT_SET=1       # inode flag - 0x400000 bit is set.
-
-# Generic test cleanup function.
-_cleanup()
-{
-  cd /
-  rm -f $tmp.*
-}
-
-# Ext4 uses the EOFBLOCKS_FL bit when fallocating blocks with KEEP_SIZE
-# enabled. The only time this bit should be set is when extending the allocated
-# blocks further than what the i_size represents. In the situations wherein the
-# i_size covers all allocated blocks, this bit should be cleared.
-
-# Checks the state of the sample file in the filesystem and returns whether
-# the inode flag 0x400000 is set or not.
-_check_ext4_eof_flag()
-{
-  # Check whether EOFBLOCK_FL is set.
-  # For ext4 filesystems: use debugfs to check if EOFBLOCKS_FL is set.
-  # Other filesystems: do nothing. The default fsck at the end of the test
-  # should catch any potential errors.
-  if [ "${FSTYP}" == "ext4" ]; then
-    bit_set=1
-
-    # Unmount the ${SCRATCH_DEV}
-    _scratch_unmount
-
-    # Run debugfs to gather file_parameters - specifically iflags.
-    file_params=`debugfs ${SCRATCH_DEV} -R "stat ${1}" 2>&1 | grep -e Flags:`
-    iflags=${file_params#*Flags: }
-
-    # Ensure that the iflags value was parsed correctly.
-    if [ -z ${iflags} ]; then
-      echo "iFlags value was not parsed successfully." >> $seqres.full
-      status=1
-      exit ${status}
-    fi
-
-    # Check if EOFBLOCKS_FL is set.
-    if ((${iflags} & 0x400000)); then
-      echo "EOFBLOCK_FL bit is set." >> $seqres.full
-      bit_set=1
-    else
-      echo "EOFBLOCK_FL bit is not set." >> $seqres.full
-      bit_set=0
-    fi
-
-    # Check current bit state to expected value.
-    if [ ${bit_set} -ne ${2} ]; then
-      echo "Error: Current bit state incorrect." >> $seqres.full
-      status=1
-      exit ${status}
-    fi
-
-    # Mount the ${SCRATCH_DEV}
-    _scratch_mount
-  fi
-}
-
-# Get standard environment, filters and checks.
-. ./common/rc
-. ./common/filter
-
-# Prerequisites for the test run.
-_supported_fs ext4
-_supported_os Linux
-_require_xfs_io_command "falloc"
-_require_scratch
-
-# Real QA test starts here.
-rm -f $seqres.full
-
-_scratch_mkfs >> $seqres.full 2>&1
-_scratch_mount
-
-BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
-
-# Begin test cases.
-echo "Test 1: Fallocate 10 blocks and write 1 block (buffered io)." \
-    >> $seqres.full
-${XFS_IO_PROG} -f				\
-    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
-    -c "pwrite 0 $BLOCK_SIZE"			\
-    ${SCRATCH_MNT}/test_1 | _filter_xfs_io_blocks_modified
-_check_ext4_eof_flag test_1 ${BIT_SET}
-
-echo "Test 2: Fallocate 10 blocks and write 1 block (direct io)." \
-    >> $seqres.full
-${XFS_IO_PROG} -f -d				\
-    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
-    -c "pwrite 0 $BLOCK_SIZE"			\
-    ${SCRATCH_MNT}/test_2 | _filter_xfs_io_blocks_modified
-_check_ext4_eof_flag test_2 ${BIT_SET}
-
-echo "Test 3: Fallocate 10 blocks and write 10 blocks (buffered io)." \
-    >> $seqres.full
-${XFS_IO_PROG} -f				\
-    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
-    -c "pwrite 0 $((10 * $BLOCK_SIZE))"		\
-    ${SCRATCH_MNT}/test_3 | _filter_xfs_io_blocks_modified
-_check_ext4_eof_flag test_3 ${BIT_NOT_SET}
-
-echo "Test 4: Fallocate 10 blocks and write 10 blocks (direct io)." \
-    >> $seqres.full
-${XFS_IO_PROG} -f -d				\
-    -c "falloc -k 0 $((10 * $BLOCK_SIZE))"	\
-    -c "pwrite 0 $((10 * $BLOCK_SIZE))"		\
-    ${SCRATCH_MNT}/test_4 | _filter_xfs_io_blocks_modified
-_check_ext4_eof_flag test_4 ${BIT_NOT_SET}
-
-echo "Test 5: Fallocate 32 blocks, seek 64 blocks and write 1 block (buffered io)." \
-    >> $seqres.full
-${XFS_IO_PROG} -f					\
-    -c "falloc -k 0 $((32 * $BLOCK_SIZE))"		\
-    -c "pwrite $((64 * $BLOCK_SIZE)) $BLOCK_SIZE"	\
-    ${SCRATCH_MNT}/test_5 | _filter_xfs_io_blocks_modified
-_check_ext4_eof_flag test_5 ${BIT_NOT_SET}
-
-echo "Test 6: Fallocate 32 blocks, seek to 64 blocks and write 1 block (direct io)." \
-    >> $seqres.full
-${XFS_IO_PROG} -f -d					\
-    -c "falloc -k 0 $((32 * $BLOCK_SIZE))"		\
-    -c "pwrite $((64 * $BLOCK_SIZE)) $BLOCK_SIZE"	\
-    ${SCRATCH_MNT}/test_6 | _filter_xfs_io_blocks_modified
-_check_ext4_eof_flag test_6 ${BIT_NOT_SET}
-
-status=0
-exit ${status}
diff --git a/tests/ext4/002.out b/tests/ext4/002.out
deleted file mode 100644
index 1605a115..00000000
--- a/tests/ext4/002.out
+++ /dev/null
@@ -1,7 +0,0 @@
-QA output created by 002
-Blocks modified: [0 - 0]
-Blocks modified: [0 - 0]
-Blocks modified: [0 - 9]
-Blocks modified: [0 - 9]
-Blocks modified: [64 - 64]
-Blocks modified: [64 - 64]
diff --git a/tests/ext4/group b/tests/ext4/group
index 9dfc0d35..62483c3f 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -4,7 +4,6 @@
 # - comment line before each group is "new" description
 #
 001 auto prealloc quick zero
-002 auto quick prealloc
 003 auto quick
 004 auto dump
 005 auto quick metadata ioctl rw
-- 
2.11.0

