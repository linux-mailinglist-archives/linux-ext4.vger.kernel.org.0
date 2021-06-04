Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD839AEFF
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jun 2021 02:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFDAPr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Jun 2021 20:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAPr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Jun 2021 20:15:47 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFAFC06174A;
        Thu,  3 Jun 2021 17:13:45 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id s22so3955226vsl.10;
        Thu, 03 Jun 2021 17:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAKms2kmbabTK2fqj+FDj2u0N9CW88Nbssa/F23fhtk=;
        b=fMxKi3ghqGCUwP/skFDx4XHuUeSuqdjfG7OEFQI/j3UgJlGpCAly5mP1LPoS1rtHH1
         M8pK6W0FB7yDnDGML9eBXnIV0Qr2LoGHfQtQ0nrnU/HbbDILKup34miSUAdqY7LNU97c
         AJo6RWN3zv5Y2TTLiLhHHndlOEJrspheo1IWlep3+CJLBhEV9lCjUgViuZcZrFWL0aeP
         kVB/Yw6cp/WXYN2KIRjLaNmGmxE+8nVGIHW9YiiXOMyZNFdXiLW9JSfvpbbkSHJCLg2e
         WZO3pxAMFjJgWLx2ZUUURdQKcf2FRvQZT6eYAxXfkTkzVg/tO97F6FMRgE6nOmw2h71B
         ERtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAKms2kmbabTK2fqj+FDj2u0N9CW88Nbssa/F23fhtk=;
        b=f8z0Iwe6Re0yGImgL+UgqYU4y401t2SZ13vK7ldbqsPlo5SfiohYWrC5iH+V5XsMA9
         4HlSkpvCzy/8sEa8hiiL19bM5xOoa/M32diwj/CHDZcVHro1BTxF+WSdo8ikhBvIIwOb
         2yfPhSeRwcOJIrEAGvOqToinrCBCcjIpWBIKk7KF/3G4y496YNEjptmogTe3E6aYTphD
         /WS+NeCfg85bj99zsIUHq+ezZokfvCQpMDJkifispcH8V+OqFYNQc84NhclrNLhkjdI8
         ixkVVIupSSTINCowDOjCkj7Rd9RTRqxN+39KdFhsEUDfkvUBTssFAlMRxVu3q3YWlrzH
         oOoA==
X-Gm-Message-State: AOAM533Nbf7203S17bPzg/fpSfZvtXgmAvkmc1LrmpkSSVhNzXdCr3sV
        JCajXgi3ij0fN52ZGrNfDfcEPkCX8zQ=
X-Google-Smtp-Source: ABdhPJz/xlRsG2CE/DEB926WcpA0fc6N4+bFk67Drbk8V1coo3VZqXDDigInOdiRU18DI29lT8CUfQ==
X-Received: by 2002:a67:d11d:: with SMTP id u29mr915594vsi.53.1622765624633;
        Thu, 03 Jun 2021 17:13:44 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id j20sm608882vsm.20.2021.06.03.17.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 17:13:44 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Cc:     Leah Rumancik <lrumancik@google.com>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v3] ext4/309: add test for ext4_dir_entry2 wipe
Date:   Fri,  4 Jun 2021 00:13:41 +0000
Message-Id: <20210604001341.2700927-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Leah Rumancik <lrumancik@google.com>

Check wiping of dir entry data upon removing a file, converting to an
htree, and splitting htree nodes.

Tests commit 6c0912739699d8e4b6a87086401bf3ad3c59502d ("ext4: wipe
ext4_dir_entry2 upon file deletion").

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Changes in v2:
- fix formatting
- use _get_block_size instead of manually finding blocksize
- change scratch_dir to testdir to avoid confusion

Changes in v3:
- add _require_od_endian_flag function
- skip test 309 if od does not support endian flag
---
 common/rc          |   9 +++
 tests/ext4/309     | 192 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/309.out |   5 ++
 tests/ext4/group   |   1 +
 4 files changed, 207 insertions(+)
 create mode 100755 tests/ext4/309
 create mode 100644 tests/ext4/309.out

diff --git a/common/rc b/common/rc
index 2cf550ec..8b8807d5 100644
--- a/common/rc
+++ b/common/rc
@@ -4513,6 +4513,15 @@ _getcap()
 	return ${PIPESTATUS[0]}
 }
 
+#od only supports --endian flag in versions 8.23 and later
+_require_od_endian_flag()
+{
+	version="$(od --version | grep -m 1 -o -E '[0-9.]+')"
+	[[ "${version%%.*}" -lt "8" ]] || \
+		[[ "${version%%.*}" -eq "8" && "${version##*.}" -lt "23" ]] && \
+		_notrun "od does not support endian flag"
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/ext4/309 b/tests/ext4/309
new file mode 100755
index 00000000..e0497e1a
--- /dev/null
+++ b/tests/ext4/309
@@ -0,0 +1,192 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Google, Inc. All Rights Reserved.
+#
+# FS QA Test No. 309
+#
+# Test wiping of ext4_dir_entry2 data upon file removal, conversion
+# to htree, and splitting of htree nodes
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+status=1       # failure is the default!
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs ext4
+
+_require_scratch
+_require_command "$DEBUGFS_PROG" debugfs
+_require_od_endian_flag
+
+testdir="${SCRATCH_MNT}/testdir"
+
+# get block number filename's dir ent
+# argument 1: filename
+get_block() {
+	echo $($DEBUGFS_PROG $SCRATCH_DEV -R "dirsearch /testdir $1" 2>> $seqres.full | grep -o -m 1 "phys [0-9]\+" | cut -c 6-)
+}
+
+# get offset of filename's dirent within the block
+# argument 1: filename
+get_offset() {
+	echo $($DEBUGFS_PROG $SCRATCH_DEV -R "dirsearch /testdir $1" 2>> $seqres.full | grep -o -m 1 "offset [0-9]\+" | cut -c 8-)
+}
+
+# get record length of dir ent at specified block and offset
+# argument 1: block
+# argument 2: offset
+get_reclen() {
+	echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 4)) --read-bytes=2  -d -An  --endian=little | tr -d ' \t\n\r')
+}
+
+# reads portion of dirent that should be zero'd out (starting at offset of name_len = 6)
+# and trims 0s and whitespace
+# argument 1: block num containing dir ent
+# argument 2: offset of dir ent within block
+# argument 3: rec len of dir ent
+read_dir_ent() {
+	echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 6)) --read-bytes=$(($3 - 6)) -d -An -v | sed -e 's/[0 \t\n\r]//g')
+}
+
+# forces node split on test directory
+# can be used to convert to htree and to split node on existing htree
+# looks for jump in directory size as indicator of node split
+induce_node_split() {
+	_scratch_mount >> $seqres.full 2>&1
+	dir_size="$(stat --printf="%s" $testdir)"
+	while [[ "$(stat --printf="%s" $testdir)" == "$dir_size" ]]; do
+		file_num=$(($file_num + 1))
+		touch $testdir/test"$(printf "%04d" $file_num)"
+	done
+	_scratch_unmount >> $seqres.full 2>&1
+}
+
+#
+# TEST 1: dir entry fields wiped upon file removal
+#
+
+test_file1="test0001"
+test_file2="test0002"
+test_file3="test0003"
+
+_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
+
+# create scratch dir for testing
+# create some files with no name a substr of another name so we can grep later
+_scratch_mount >> $seqres.full 2>&1
+blocksize="$(_get_block_size $SCRATCH_MNT)"
+mkdir $testdir
+file_num=1
+for file_num in {1..10}; do
+	touch $testdir/test"$(printf "%04d" $file_num)"
+done
+_scratch_unmount >> $seqres.full 2>&1
+
+# get block, offset, and rec_len of two test files
+block1=$(get_block $test_file1)
+offset1=$(get_offset $test_file1)
+rec_len1=$(get_reclen $block1 $offset1)
+
+block2=$(get_block $test_file2)
+offset2=$(get_offset $test_file2)
+rec_len2=$(get_reclen $block2 $offset2)
+
+_scratch_mount >> $seqres.full 2>&1
+rm $testdir/$test_file1
+_scratch_unmount >> $seqres.full 2>&1
+
+# read name_len field to end of dir entry
+check1=$(read_dir_ent $block1 $offset1 $rec_len1)
+check2=$(read_dir_ent $block2 $offset2 $rec_len2)
+
+# if check is empty, bytes read was all 0's, file data wiped
+# at this point, check1 should be empty, but check 2 should not be
+if [ -z "$check1" ] && [ ! -z "$check2" ]; then
+	echo "Test 1 part 1 passed."
+else
+	_fail "ERROR (test 1 part 1): metadata not wiped upon removing test file 1"
+fi
+
+_scratch_mount >> $seqres.full 2>&1
+rm $testdir/$test_file2
+_scratch_unmount >> $seqres.full 2>&1
+
+check2=$(read_dir_ent $block2 $offset2 $rec_len2)
+
+# at this point, both should be wiped
+[ -z "$check2" ] && echo "Test 1 part 2 passed." || _fail "ERROR (test 1 part 2): metadata not wiped upon removing test file 2"
+
+#
+# TEST 2: old dir entry fields wiped when directory converted to htree
+#
+
+# get original location
+block1=$(get_block $test_file3)
+offset1=$(get_offset $test_file3)
+rec_len1=$(get_reclen $block1 $offset1)
+
+# sanity check, ensures not an htree yet
+check_htree=$($DEBUGFS_PROG $SCRATCH_DEV -R "htree_dump /testdir" 2>&1)
+if [[ "$check_htree" != *"htree_dump: Not a hash-indexed directory"* ]]; then
+	_fail "ERROR (test 2): already an htree"
+fi
+
+# force conversion to htree
+induce_node_split
+
+# ensure it is now an htree
+check_htree=$($DEBUGFS_PROG $SCRATCH_DEV -R "htree_dump /testdir" 2>&1)
+if [[ "$check_htree" == *"htree_dump: Not a hash-indexed directory"* ]]; then
+	_fail "ERROR (test 2): directory was not converted to an htree after creation of many files"
+fi
+
+# check that old data was wiped
+# (this location is not immediately reused by ext4)
+check1=$(read_dir_ent $block1 $offset1 $rec_len1)
+
+# at this point, check1 should be empty meaning data was wiped
+[ -z "$check1" ] &&  echo "Test 2 passed." || _fail "ERROR (test 2): file metadata not wiped during conversion to htree"
+
+#
+# TEST 3: old dir entries wiped when moved to another block during split_node
+#
+
+# force splitting of a node
+induce_node_split
+# use debugfs to get names of two files from block 3
+hdump=$($DEBUGFS_PROG $SCRATCH_DEV -R "htree_dump /testdir" 2>> $seqres.full)
+
+# get line number of "Reading directory block 3"
+block3_line=$(echo "$hdump" | awk '/Reading directory block 3/{ print NR; exit }')
+
+[ -z "$block3_line" ] && echo "ERROR (test 3): could not find block number 3 after node split"
+
+test_file1=$(echo "$hdump" | sed -n "$(($block3_line + 1))"p | cut -d ' ' -f4)
+test_file2=$(echo "$hdump" | sed -n "$(($block3_line + 2))"p | cut -d ' ' -f4)
+
+# check these filenames don't exist in block 1 or 2
+# get block numbers of first two blocks
+block1=$(echo "$hdump" | grep -o -m 1 "Reading directory block 1, phys [0-9]\+" | cut -c 33-)
+block2=$(echo "$hdump" | grep -o -m 1 "Reading directory block 2, phys [0-9]\+" | cut -c 33-)
+
+# search all of both these blocks for these file names
+check1=$(od $SCRATCH_DEV --skip-bytes=$(($block1 * $blocksize)) --read-bytes=$blocksize -c -An -v | tr -d '\\ \t\n\r\v' | grep -e $test_file1 -e $test_file2)
+check2=$(od $SCRATCH_DEV --skip-bytes=$(($block2 * $blocksize)) --read-bytes=$blocksize -c -An -v | tr -d '\\ \t\n\r\v' | grep -e $test_file1 -e $test_file2)
+
+if [ -z "$check1" ] && [ -z "$check2" ]; then
+	echo "Test 3 passed."
+else
+	_fail "ERROR (test 3): file name not wiped during node split"
+fi
+
+status=0
+exit
diff --git a/tests/ext4/309.out b/tests/ext4/309.out
new file mode 100644
index 00000000..e5febaac
--- /dev/null
+++ b/tests/ext4/309.out
@@ -0,0 +1,5 @@
+QA output created by 309
+Test 1 part 1 passed.
+Test 1 part 2 passed.
+Test 2 passed.
+Test 3 passed.
diff --git a/tests/ext4/group b/tests/ext4/group
index ceda2ba6..e7ad3c24 100644
--- a/tests/ext4/group
+++ b/tests/ext4/group
@@ -59,3 +59,4 @@
 306 auto rw resize quick
 307 auto ioctl rw defrag
 308 auto ioctl rw prealloc quick defrag
+309 auto quick dir
-- 
2.32.0.rc1.229.g3e70b5a671-goog

