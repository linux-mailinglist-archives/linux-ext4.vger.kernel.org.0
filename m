Return-Path: <linux-ext4+bounces-12253-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E4CB205B
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 06:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F3830EFEB7
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0B92F5491;
	Wed, 10 Dec 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/LAmgAK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC70277C8D;
	Wed, 10 Dec 2025 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345750; cv=none; b=kOVR14psTTVlFJK59FHo3wIADY8SeZWI0w2l1j4ziiM89K7UF+ojpwufnibCMFmxOUqahyZgCapI3MvEBG6oGkjkMj4j/IeAnKlbPHnQXqNqIPAbgjml3YtmXoMD0pdATQ0VAa6HyBwJ6ydbAnNYVcUJUjZBRRaKHmCjWEP4jQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345750; c=relaxed/simple;
	bh=PE/sW1rpPhSdVEE8gnhhfSN8WuztpnZV81GQkhUhwYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6cohwuK02BinEVYRYl0LXfdwsP5UhwDiFoWqORLcZLiPdOoKFA0yMFnr6rFhOXQMvzj6o1Vm/xynu+hTvvk5Byl0el6gJ5L/BgjiF2Qu2W3+ur1YxFaxpTMzwz+sUMmE00Ib2zNzrdHYYg/5rVNRb5a9wZym9nFdbFhnitD4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t/LAmgAK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=T8R7RJdBukOCRlSvmntzVQD3tScENB5DrH93glxG6UY=; b=t/LAmgAKIWBLtvOuPsxWYB9aDJ
	K3Q951tsERV43NgGgSm2oYExl4s4lmdozMmVWuBWGQC4Xugbt9ABHklTWGbmU/RPLGsr7qodjA0Vf
	HtSJ+bJuX9QEZZZ5Z8LCVBDiAOcMMm2jNcTny8S3g3zRDrr8JvPYyW468ebFdh/CSL2zn7YdVECwW
	mTrwwZ9ieN2dDCBw8cKpZxyznYFeMO5tBQ/IMZK1uH60jbKO/VZTSRTwjK+fKaX9jHluGqLK2kifL
	c5lf2FWCweQ+zNXdraiWuJqcgEJ8Mv9AZs3sCh4iGZmY5E6oGzixZYb5VSf+/YHRZ1nDE/hsR+7ww
	iawl3YsA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD4S-0000000F95j-3VCY;
	Wed, 10 Dec 2025 05:49:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 05/12] generic/590: split XFS RT specific bits out
Date: Wed, 10 Dec 2025 06:46:51 +0100
Message-ID: <20251210054831.3469261-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210054831.3469261-1-hch@lst.de>
References: <20251210054831.3469261-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently generic/590 runs a very different test on XFS that creates
a lot device and so on.  Split that out into a new XFS-specific test,
and let generic/590 always run using the file system parameter specified
in the config even for XFS.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/590 |  68 ++-------------------------
 tests/xfs/650     | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/650.out |   2 +
 3 files changed, 123 insertions(+), 64 deletions(-)
 create mode 100755 tests/xfs/650
 create mode 100644 tests/xfs/650.out

diff --git a/tests/generic/590 b/tests/generic/590
index ba1337a856f1..54c26f2ae5ed 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -4,27 +4,15 @@
 #
 # FS QA Test 590
 #
-# Test commit 0c4da70c83d4 ("xfs: fix realtime file data space leak") and
-# 69ffe5960df1 ("xfs: don't check for AG deadlock for realtime files in
-# bunmapi"). On XFS without the fixes, truncate will hang forever. On other
-# filesystems, this just tests writing into big fallocates.
+# Tests writing into big fallocates.
+#
+# Based on an XFS RT subvolume specific test now split into xfs/650.
 #
 . ./common/preamble
 _begin_fstest auto prealloc preallocrw
 
-# Override the default cleanup function.
-_cleanup()
-{
-	_scratch_unmount &>/dev/null
-	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
-	cd /
-	rm -f $tmp.*
-	rm -f "$TEST_DIR/$seq"
-}
-
 . ./common/filter
 
-_require_scratch_nocheck
 _require_xfs_io_command "falloc"
 
 maxextlen=$((0x1fffff))
@@ -32,54 +20,7 @@ bs=4096
 rextsize=4
 filesz=$(((maxextlen + 1) * bs))
 
-must_disable_feature() {
-	local feat="$1"
-
-	# If mkfs doesn't know about the feature, we don't need to disable it
-	$MKFS_XFS_PROG --help 2>&1 | grep -q "${feat}=0" || return 1
-
-	# If turning the feature on works, we don't need to disable it
-	_scratch_mkfs_xfs_supported -m "${feat}=1" "${disabled_features[@]}" \
-		> /dev/null 2>&1 && return 1
-
-	# Otherwise mkfs knows of the feature and formatting with it failed,
-	# so we do need to mask it.
-	return 0
-}
-
-extra_options=""
-# If we're testing XFS, set up the realtime device to reproduce the bug.
-if [[ $FSTYP = xfs ]]; then
-	# If we don't have a realtime device, set up a loop device on the test
-	# filesystem.
-	if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
-		_require_test
-		loopsz="$((filesz + (1 << 26)))"
-		_require_fs_space "$TEST_DIR" $((loopsz / 1024))
-		$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
-		loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
-		USE_EXTERNAL=yes
-		SCRATCH_RTDEV="$loop_dev"
-		disabled_features=()
-
-		# disable reflink if not supported by realtime devices
-		must_disable_feature reflink &&
-			disabled_features=(-m reflink=0)
-
-		# disable rmap if not supported by realtime devices
-		must_disable_feature rmapbt &&
-			disabled_features+=(-m rmapbt=0)
-	fi
-	extra_options="$extra_options -r extsize=$((bs * rextsize))"
-	extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
-
-	_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
-	_try_scratch_mount >>$seqres.full 2>&1 || \
-		_notrun "mount failed, kernel doesn't support realtime?"
-	_scratch_unmount
-else
-	_scratch_mkfs $extra_options >>$seqres.full 2>&1
-fi
+_scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 _require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
 
@@ -112,7 +53,6 @@ $XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
 # Truncate the extents.
 $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
 
-# We need to do this before the loop device gets torn down.
 _scratch_unmount
 _check_scratch_fs
 
diff --git a/tests/xfs/650 b/tests/xfs/650
new file mode 100755
index 000000000000..d8f70539665f
--- /dev/null
+++ b/tests/xfs/650
@@ -0,0 +1,117 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Facebook.  All Rights Reserved.
+#
+# FS QA Test 650
+#
+# Test commit 0c4da70c83d4 ("xfs: fix realtime file data space leak") and
+# 69ffe5960df1 ("xfs: don't check for AG deadlock for realtime files in
+# bunmapi"). On XFS without the fixes, truncate will hang forever.
+#
+. ./common/preamble
+_begin_fstest auto prealloc preallocrw
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_scratch_unmount &>/dev/null
+	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
+	cd /
+	rm -f $tmp.*
+	rm -f "$TEST_DIR/$seq"
+}
+
+. ./common/filter
+
+_require_scratch_nocheck
+_require_xfs_io_command "falloc"
+
+maxextlen=$((0x1fffff))
+bs=4096
+rextsize=4
+filesz=$(((maxextlen + 1) * bs))
+
+must_disable_feature() {
+	local feat="$1"
+
+	# If mkfs doesn't know about the feature, we don't need to disable it
+	$MKFS_XFS_PROG --help 2>&1 | grep -q "${feat}=0" || return 1
+
+	# If turning the feature on works, we don't need to disable it
+	_scratch_mkfs_xfs_supported -m "${feat}=1" "${disabled_features[@]}" \
+		> /dev/null 2>&1 && return 1
+
+	# Otherwise mkfs knows of the feature and formatting with it failed,
+	# so we do need to mask it.
+	return 0
+}
+
+extra_options=""
+# Set up the realtime device to reproduce the bug.
+
+# If we don't have a realtime device, set up a loop device on the test
+# filesystem.
+if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
+	_require_test
+	loopsz="$((filesz + (1 << 26)))"
+	_require_fs_space "$TEST_DIR" $((loopsz / 1024))
+	$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
+	loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
+	USE_EXTERNAL=yes
+	SCRATCH_RTDEV="$loop_dev"
+	disabled_features=()
+
+	# disable reflink if not supported by realtime devices
+	must_disable_feature reflink &&
+		disabled_features=(-m reflink=0)
+
+	# disable rmap if not supported by realtime devices
+	must_disable_feature rmapbt &&
+		disabled_features+=(-m rmapbt=0)
+fi
+extra_options="$extra_options -r extsize=$((bs * rextsize))"
+extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
+
+_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
+_try_scratch_mount >>$seqres.full 2>&1 || \
+	_notrun "mount failed, kernel doesn't support realtime?"
+_scratch_unmount
+_scratch_mount
+_require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
+
+# Allocate maxextlen + 1 blocks. As long as the allocator does something sane,
+# we should end up with two extents that look something like:
+#
+# u3.bmx[0-1] = [startoff,startblock,blockcount,extentflag]
+# 0:[0,0,2097148,1]
+# 1:[2097148,2097148,4,1]
+#
+# Extent 0 has blockcount = ALIGN_DOWN(maxextlen, rextsize). Extent 1 is
+# adjacent and has blockcount = rextsize. Both are unwritten.
+$XFS_IO_PROG -c "falloc 0 $filesz" -c fsync -f "$SCRATCH_MNT/file"
+
+# Write extent 0 + one block of extent 1. Our extents should end up like so:
+#
+# u3.bmx[0-1] = [startoff,startblock,blockcount,extentflag]
+# 0:[0,0,2097149,0]
+# 1:[2097149,2097149,3,1]
+#
+# Extent 0 is written and has blockcount = ALIGN_DOWN(maxextlen, rextsize) + 1,
+# Extent 1 is adjacent, unwritten, and has blockcount = rextsize - 1 and
+# startblock % rextsize = 1.
+#
+# The -b is just to speed things up (doing GBs of I/O in 4k chunks kind of
+# sucks).
+$XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
+	"$SCRATCH_MNT/file" >> "$seqres.full"
+
+# Truncate the extents.
+$XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
+
+# We need to do this before the loop device gets torn down.
+_scratch_unmount
+_check_scratch_fs
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/xfs/650.out b/tests/xfs/650.out
new file mode 100644
index 000000000000..d7a3e4b63483
--- /dev/null
+++ b/tests/xfs/650.out
@@ -0,0 +1,2 @@
+QA output created by 650
+Silence is golden
-- 
2.47.3


