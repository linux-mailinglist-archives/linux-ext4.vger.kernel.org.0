Return-Path: <linux-ext4+bounces-12317-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 96306CB83CC
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 231A1300A6C8
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAD30FC10;
	Fri, 12 Dec 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvXlflmI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE130FC1A;
	Fri, 12 Dec 2025 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527745; cv=none; b=Uvx8nYLzsQkA2vNlW0OR7AWAEmsskl1QqKuen1HbaadiAUKkZ5SWWyreVmO+XedcwepxOwnfzaQ7ax+G5burDM92e9TFL+ml7dh/L5mGuqOJ9xzNdDT9I6eDEVPDIBFdCD4kIizn9gBLHVxt3zZPFA3DBHrzyS5EUCpt9Zw2NBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527745; c=relaxed/simple;
	bh=hTIE1aOoCnEknFMekuA7RPALsiXpDTJI2z67zyHL0dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBgkIwpn+l2rUY0v49BL2CZzKnVD2aG2aWdj5Or7BuDdY/0JUDYU3xbn36Zv8gOI0kVxuMWNpp5keOJ8xbGF3QfsohmmkLCabIKZcT83h4C0WueTlNnO3rejA4e/p3JJPOF1jwvKDCHOFcF2yfXd3GObp3ijnHFJ2plEZYBxE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nvXlflmI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lx28oPvfAjNrIcsSgZnr7Fn3kRkrQpZ8ksczJbtZHtg=; b=nvXlflmI4YktdN1LpOmzAROFio
	DleLWizMF/OPiWkG2Xuh6kXuhCPUMhpvZdJ20omkX/2ow6Ip/KN+3oQXqt/az1AmPOsDdEj+uF2sS
	Dd5g6lTME4L27/s0VRYNJGoIL+yZPUxiYRW5bFm330EIuz75WzccmXmFeNZzr/3HKO7lVFK0zACO7
	GhsWsWfHymS+50wnqO1EqGocVVUG/LKNrlBsRJKwos6VilE/tv7C0VkerJsjW1pUNN5aivYkRRLF1
	CL7kl4I/Ir8dLaYq0/txFi5EzBIM1VjuHs+hSv8HgNz9h3FQ4sfjPnaauswVONO0RdX+Lvqae0f05
	zsnZ/TXw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyPr-00000000G57-1mhD;
	Fri, 12 Dec 2025 08:22:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 01/13] dmflakey: override SCRATCH_DEV in _init_flakey
Date: Fri, 12 Dec 2025 09:21:49 +0100
Message-ID: <20251212082210.23401-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212082210.23401-1-hch@lst.de>
References: <20251212082210.23401-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

_init_flakey already overrides SCRATCH_LOGDEV and SCRATCH_RTDEV so that
the XFS-specific helpers work fine with external devices.  Do the same
for SCRATCH_DEV itself, so that _scratch_mount and _scratch_unmount just
work, and so that _check_scratch_fs does not need to override the main
device.

This requires some small adjustments in how generic/741 checks that
mounting the underlying device fails, but the new version actually is
simpler than the old one, and in xfs/438 where we need to be careful
where to create the custome dm table.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/dmflakey       | 47 +++++++++++++++++++++----------------------
 tests/btrfs/056       |  6 +++---
 tests/btrfs/085       | 14 ++++++-------
 tests/btrfs/095       |  4 ++--
 tests/btrfs/098       |  4 ++--
 tests/btrfs/118       |  4 ++--
 tests/btrfs/119       |  4 ++--
 tests/btrfs/120       |  4 ++--
 tests/btrfs/159       |  4 ++--
 tests/btrfs/166       |  4 ++--
 tests/btrfs/201       |  8 ++++----
 tests/btrfs/209       |  4 ++--
 tests/btrfs/211       | 14 ++++++-------
 tests/btrfs/231       |  4 ++--
 tests/btrfs/233       | 20 +++++++++---------
 tests/btrfs/236       |  8 ++++----
 tests/btrfs/239       |  4 ++--
 tests/btrfs/240       |  4 ++--
 tests/btrfs/243       |  4 ++--
 tests/generic/034     |  4 ++--
 tests/generic/039     |  2 +-
 tests/generic/040     |  2 +-
 tests/generic/041     |  2 +-
 tests/generic/056     |  2 +-
 tests/generic/057     |  2 +-
 tests/generic/059     |  2 +-
 tests/generic/065     |  2 +-
 tests/generic/066     |  4 ++--
 tests/generic/073     |  2 +-
 tests/generic/090     |  2 +-
 tests/generic/101     |  2 +-
 tests/generic/104     |  4 ++--
 tests/generic/106     |  4 ++--
 tests/generic/107     |  4 ++--
 tests/generic/177     |  4 ++--
 tests/generic/311     | 12 +++++------
 tests/generic/321     | 20 +++++++++---------
 tests/generic/322     | 14 ++++++-------
 tests/generic/325     |  4 ++--
 tests/generic/335     |  4 ++--
 tests/generic/336     |  4 ++--
 tests/generic/341     |  4 ++--
 tests/generic/342     |  4 ++--
 tests/generic/343     |  4 ++--
 tests/generic/348     |  4 ++--
 tests/generic/376     |  4 ++--
 tests/generic/456     |  4 ++--
 tests/generic/479     |  4 ++--
 tests/generic/480     |  4 ++--
 tests/generic/481     |  4 ++--
 tests/generic/483     |  4 ++--
 tests/generic/489     |  4 ++--
 tests/generic/498     |  4 ++--
 tests/generic/501     |  4 ++--
 tests/generic/502     |  4 ++--
 tests/generic/509     |  4 ++--
 tests/generic/510     |  4 ++--
 tests/generic/512     |  4 ++--
 tests/generic/520     | 12 +++++------
 tests/generic/526     |  4 ++--
 tests/generic/527     |  4 ++--
 tests/generic/534     |  4 ++--
 tests/generic/535     |  4 ++--
 tests/generic/546     |  2 +-
 tests/generic/547     |  4 ++--
 tests/generic/552     |  4 ++--
 tests/generic/557     |  4 ++--
 tests/generic/588     |  4 ++--
 tests/generic/640     |  4 ++--
 tests/generic/677     |  4 ++--
 tests/generic/690     |  4 ++--
 tests/generic/695     |  4 ++--
 tests/generic/703     |  4 ++--
 tests/generic/741     | 16 +++++++--------
 tests/generic/741.out |  2 --
 tests/generic/745     |  2 +-
 tests/generic/764     |  4 ++--
 tests/generic/771     |  2 +-
 tests/generic/779     |  4 ++--
 tests/generic/782     |  4 ++--
 tests/generic/784     |  4 ++--
 tests/generic/785     |  4 ++--
 tests/xfs/051         |  4 ++--
 tests/xfs/438         | 10 +++++----
 tests/xfs/542         |  4 ++--
 tests/xfs/605         | 10 ++++-----
 86 files changed, 235 insertions(+), 236 deletions(-)

diff --git a/common/dmflakey b/common/dmflakey
index 7368a3e5b324..cb0359901c16 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -15,11 +15,19 @@ export FLAKEY_LOGNAME="flakey-logtest.$seq"
 _init_flakey()
 {
 	# Scratch device
-	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
-	export FLAKEY_DEV="/dev/mapper/$FLAKEY_NAME"
-	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 180 0"
-	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
-	FLAKEY_TABLE_ERROR="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 error_writes"
+	if [ -z "$NON_FLAKEY_DEV" ]; then
+		# Set up the device switch
+		local backing_dev="$SCRATCH_DEV"
+		export NON_FLAKEY_DEV="$SCRATCH_DEV"
+		SCRATCH_DEV=/dev/mapper/$FLAKEY_NAME
+	else
+		# Already set up; recreate tables
+		local backing_dev="$NON_FLAKEY_DEV"
+	fi
+	local BLK_DEV_SIZE=`blockdev --getsz $backing_dev`
+	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $backing_dev 0 180 0"
+	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 drop_writes"
+	FLAKEY_TABLE_ERROR="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 error_writes"
 	_dmsetup_create $FLAKEY_NAME --table "$FLAKEY_TABLE" || \
 		_fatal "failed to create flakey device"
 
@@ -62,32 +70,23 @@ _init_flakey()
 	fi
 }
 
-_mount_flakey()
-{
-	_scratch_options mount
-
-	mount -t $FSTYP $SCRATCH_OPTIONS $MOUNT_OPTIONS $FLAKEY_DEV $SCRATCH_MNT
-}
-
-_unmount_flakey()
-{
-	_unmount $SCRATCH_MNT
-}
-
 _cleanup_flakey()
 {
 	# If dmsetup load fails then we need to make sure to do resume here
 	# otherwise the umount will hang
 	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume $FLAKEY_LOGNAME &> /dev/null
 	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null
-	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
+	test -n "$NON_FLAKEY_DEV" && $DMSETUP_PROG resume flakey-test > /dev/null 2>&1
 
 	_unmount $SCRATCH_MNT > /dev/null 2>&1
 
-	_dmsetup_remove $FLAKEY_NAME
+	test -n "$NON_FLAKEY_DEV" && _dmsetup_remove $FLAKEY_NAME
 	test -n "$NON_FLAKEY_LOGDEV" && _dmsetup_remove $FLAKEY_LOGNAME
 	test -n "$NON_FLAKEY_RTDEV" && _dmsetup_remove $FLAKEY_RTNAME
 
+	SCRATCH_DEV="$NON_FLAKEY_DEV"
+	unset NON_FLAKEY_DEV
+
 	if [ -n "$NON_FLAKEY_LOGDEV" ]; then
 		SCRATCH_LOGDEV="$NON_FLAKEY_LOGDEV"
 		unset NON_FLAKEY_LOGDEV
@@ -179,17 +178,17 @@ _flakey_drop_and_remount()
 {
 	# If the full environment is set up, configure ourselves for shutdown
 	type _prepare_for_eio_shutdown &>/dev/null && \
-		_prepare_for_eio_shutdown $FLAKEY_DEV
+		_prepare_for_eio_shutdown $SCRATCH_DEV
 
 	_load_flakey_table $FLAKEY_DROP_WRITES
-	_unmount_flakey
+	_scratch_unmount
 
 	if [ "x$1" = "xyes" ]; then
-		_check_scratch_fs $FLAKEY_DEV
+		_check_scratch_fs
 	fi
 
 	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_scratch_mount
 }
 
 _require_flakey_with_error_writes()
@@ -206,5 +205,5 @@ _require_flakey_with_error_writes()
 	_dmsetup_create $NAME --table "$TABLE" || \
 		_notrun "This test requires error_writes feature in dm-flakey"
 
-	_cleanup_flakey
+	_dmsetup_remove $FLAKEY_NAME
 }
diff --git a/tests/btrfs/056 b/tests/btrfs/056
index f7557f4a41a6..08f9aac66789 100755
--- a/tests/btrfs/056
+++ b/tests/btrfs/056
@@ -39,7 +39,7 @@ test_btrfs_clone_fsync_log_recover()
 	_init_flakey
 	SAVE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
 	MOUNT_OPTIONS="$MOUNT_OPTIONS $2"
-	_mount_flakey
+	_scratch_mount
 
 	BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
 
@@ -89,10 +89,10 @@ test_btrfs_clone_fsync_log_recover()
 	echo "Verifying file bar2 content"
 	od -t x1 $SCRATCH_MNT/bar2 | _filter_od
 
-	_unmount_flakey
+	_scratch_unmount
 
 	# Verify that there are no consistency errors.
-	_check_scratch_fs $FLAKEY_DEV
+	_check_scratch_fs
 
 	_cleanup_flakey
 	MOUNT_OPTIONS="$SAVE_MOUNT_OPTIONS"
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index 291bb8af0423..8076329c4a59 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -33,7 +33,7 @@ _require_btrfs_command inspect-internal dump-tree
 has_orphan_item()
 {
 	INO=$1
-	if $BTRFS_UTIL_PROG inspect-internal dump-tree $FLAKEY_DEV | \
+	if $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV | \
 		grep -q "key (ORPHAN ORPHAN_ITEM $INO)"; then
 		return 0
 	fi
@@ -48,7 +48,7 @@ test_orphan()
 	_scratch_mkfs >> $seqres.full 2>&1
 	_init_flakey
 
-	_mount_flakey
+	_scratch_mount
 
 	$PRECMD
 
@@ -79,13 +79,13 @@ test_orphan()
 	exec 27>&-
 
 	# Orphan item should be on disk if operating correctly
-	_unmount_flakey
+	_scratch_unmount
 	_load_flakey_table $FLAKEY_ALLOW_WRITES
 	if ! has_orphan_item $INO; then
 		echo "ERROR: No orphan item found after umount."
 		return
 	fi
-	_mount_flakey
+	_scratch_mount
 
 	# If $DIR is a subvolume, this will cause a lookup and orphan cleanup
 	(cd $DIR; true)
@@ -94,7 +94,7 @@ test_orphan()
 	# disk until there's a sync.
 	sync
 
-	_unmount_flakey
+	_scratch_unmount
 	if has_orphan_item $INO; then
 		echo "ERROR: Orphan item found after successful mount/sync."
 	fi
@@ -112,8 +112,8 @@ new_default()
 	SUB=$($BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT | $AWK_PROG '{print $2}')
 	_btrfs subvolume set-default $SUB $SCRATCH_MNT
 
-	_unmount_flakey
-	_mount_flakey
+	_scratch_unmount
+	_scratch_mount
 }
 
 echo "Testing with fs root as default subvolume"
diff --git a/tests/btrfs/095 b/tests/btrfs/095
index de34d64b7b92..6ded7380b912 100755
--- a/tests/btrfs/095
+++ b/tests/btrfs/095
@@ -33,7 +33,7 @@ _require_xfs_io_command "falloc"
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
 
@@ -127,7 +127,7 @@ _flakey_drop_and_remount
 echo "File contents after log replay:"
 od -t x1 $SCRATCH_MNT/foo | _filter_od
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/btrfs/098 b/tests/btrfs/098
index 6ee0b9101d0f..a8b5cca8b582 100755
--- a/tests/btrfs/098
+++ b/tests/btrfs/098
@@ -28,7 +28,7 @@ _require_cloner
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
 
@@ -89,7 +89,7 @@ echo "File contents after log replay:"
 # the power failure happened.
 od -t x1 $SCRATCH_MNT/foo | _filter_od
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/btrfs/118 b/tests/btrfs/118
index d65398379295..ec6fef2e7922 100755
--- a/tests/btrfs/118
+++ b/tests/btrfs/118
@@ -28,7 +28,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create a snapshot at the root of our filesystem (mount point path), delete it,
 # fsync the mount point path, crash and mount to replay the log. This should
@@ -50,7 +50,7 @@ _flakey_drop_and_remount
 [ -e $SCRATCH_MNT/testdir/snap2 ] && \
 	echo "Snapshot snap2 still exists after log replay"
 
-_unmount_flakey
+_scratch_unmount
 
 echo "Silence is golden"
 
diff --git a/tests/btrfs/119 b/tests/btrfs/119
index a934ad634bf8..1982ae33970e 100755
--- a/tests/btrfs/119
+++ b/tests/btrfs/119
@@ -27,7 +27,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 _btrfs quota enable $SCRATCH_MNT
 
@@ -83,7 +83,7 @@ echo "File digest before after failure:"
 # Must match what he got before the power failure.
 md5sum $SCRATCH_MNT/foobar | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/btrfs/120 b/tests/btrfs/120
index a9b8adecfc9d..efbac5883e10 100755
--- a/tests/btrfs/120
+++ b/tests/btrfs/120
@@ -38,7 +38,7 @@ populate_testdir()
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/testdir
 populate_testdir
@@ -59,6 +59,6 @@ _flakey_drop_and_remount
 echo "Filesystem contents after the second log replay:"
 ls -R $SCRATCH_MNT | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/btrfs/159 b/tests/btrfs/159
index 577652380327..3a9051b1f439 100755
--- a/tests/btrfs/159
+++ b/tests/btrfs/159
@@ -40,7 +40,7 @@ run_test()
 	_scratch_mkfs -O no-holes -n $((64 * 1024)) >>$seqres.full 2>&1
 	_require_metadata_journaling $SCRATCH_DEV
 	_init_flakey
-	_mount_flakey
+	_scratch_mount
 
 	# Create our test file with 832 extents of 256Kb each. Before each
 	# extent, there is a 256Kb hole (except for the first extent, which
@@ -77,7 +77,7 @@ run_test()
 	echo "File digest after power failure and log replay:"
 	md5sum $SCRATCH_MNT/foobar | _filter_scratch
 
-	_unmount_flakey
+	_scratch_unmount
 	_cleanup_flakey
 }
 
diff --git a/tests/btrfs/166 b/tests/btrfs/166
index 719e2a3b6b92..79b8ea0d84c8 100755
--- a/tests/btrfs/166
+++ b/tests/btrfs/166
@@ -28,7 +28,7 @@ _require_dm_target flakey
 _scratch_mkfs  >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Enable qgroups on the filesystem. This will start the qgroup rescan kernel
 # thread.
@@ -39,7 +39,7 @@ _btrfs quota enable $SCRATCH_MNT
 # fail.
 _flakey_drop_and_remount
 
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 
 echo "Silence is golden"
diff --git a/tests/btrfs/201 b/tests/btrfs/201
index eb727cd23cd6..50262086fbbe 100755
--- a/tests/btrfs/201
+++ b/tests/btrfs/201
@@ -43,7 +43,7 @@ run_test_leading_hole()
     _scratch_mkfs -O no-holes -n $((64 * 1024)) >>$seqres.full 2>&1
     _require_metadata_journaling $SCRATCH_DEV
     _init_flakey
-    _mount_flakey
+    _scratch_mount
 
     # Create our first file, which is used just to fill space in a leaf. Its
     # items ocuppy most of the first leaf. We use a large xattr since it's an
@@ -86,7 +86,7 @@ run_test_leading_hole()
    echo "File digest after power failure and log replay:"
    md5sum $SCRATCH_MNT/bar | _filter_scratch
 
-   _unmount_flakey
+   _scratch_unmount
    _cleanup_flakey
 }
 
@@ -105,7 +105,7 @@ run_test_middle_hole()
     _scratch_mkfs -O no-holes -n $((64 * 1024)) >>$seqres.full 2>&1
     _require_metadata_journaling $SCRATCH_DEV
     _init_flakey
-    _mount_flakey
+    _scratch_mount
 
     # Create our first file, which is used just to fill space in a leaf. Its
     # items ocuppy most of the first leaf. We use a large xattr since it's an
@@ -150,7 +150,7 @@ run_test_middle_hole()
     echo "File digest after power failure and log replay:"
     md5sum $SCRATCH_MNT/bar | _filter_scratch
 
-    _unmount_flakey
+    _scratch_unmount
     _cleanup_flakey
 }
 
diff --git a/tests/btrfs/209 b/tests/btrfs/209
index 7318f8ae8bcc..bd98b6350159 100755
--- a/tests/btrfs/209
+++ b/tests/btrfs/209
@@ -33,7 +33,7 @@ _require_xfs_io_command "sync_range"
 _scratch_mkfs -O ^no-holes >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create a 256K file with a single extent and fsync it to clear the full sync
 # bit from the inode - we want the msync below to trigger a fast fsync.
@@ -71,7 +71,7 @@ echo "File digest after power failure: $(_md5_checksum $SCRATCH_MNT/foo)"
 # We also want to check that fsck doesn't fail due to an error of a missing
 # file extent item that represents a hole for the range 256K to 512K. The
 # fstests framework does the fsck once the test exits.
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/btrfs/211 b/tests/btrfs/211
index 0127149109c4..38dbadf9f0f3 100755
--- a/tests/btrfs/211
+++ b/tests/btrfs/211
@@ -64,10 +64,10 @@ run_test()
 
     # Unmount the filesystem and run 'btrfs check'/fsck to verify that we don't
     # have a missing hole for the file range from 64K to 128K.
-    _unmount_flakey
-    _check_scratch_fs $FLAKEY_DEV
+    _scratch_unmount
+    _check_scratch_fs
 
-    _mount_flakey
+    _scratch_mount
 
     # Now write to the file range from 0 to 128K. After this we should still have
     # rwo extents in our file, corresponding to the 2 extents we allocated before
@@ -80,23 +80,23 @@ run_test()
 _scratch_mkfs -O ^no-holes >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 echo "Testing without NO_HOLES feature"
 run_test
 
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 
 _scratch_mkfs -O no-holes >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 echo
 echo "Testing with the NO_HOLES feature"
 run_test
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/btrfs/231 b/tests/btrfs/231
index d9d0115000e4..5ebb2fdd753d 100755
--- a/tests/btrfs/231
+++ b/tests/btrfs/231
@@ -32,7 +32,7 @@ _require_dm_target flakey
 _scratch_mkfs -O no-holes >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file with 3 extents of 256K and a 256K hole at offset 256K.
 # The file has a size of 1280K.
@@ -73,6 +73,6 @@ _flakey_drop_and_remount
 echo "File data after power failure:"
 od -A d -t x1 $SCRATCH_MNT/foobar
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/btrfs/233 b/tests/btrfs/233
index 6c7cdc9a7040..2966566242e1 100755
--- a/tests/btrfs/233
+++ b/tests/btrfs/233
@@ -30,7 +30,7 @@ _require_btrfs_command inspect-internal dump-tree
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 check_subvol_orphan_item_exists()
 {
@@ -84,7 +84,7 @@ create_subvol_with_orphan()
 	# RW mount.
 	_load_flakey_table $FLAKEY_DROP_WRITES
 	exec 73>&-
-	_unmount_flakey
+	_scratch_unmount
 
 	check_subvol_orphan_item_exists
 	check_subvol_btree_exists
@@ -99,9 +99,9 @@ create_subvol_with_orphan
 # Use a commit interval lower than the default (30 seconds) so that the test
 # is faster and we spend less time waiting for transaction commits.
 MOUNT_OPTIONS="-o commit=1"
-_mount_flakey
+_scratch_mount
 $BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >>$seqres.full
-_unmount_flakey
+_scratch_unmount
 
 check_subvol_orphan_item_not_exists
 check_subvol_btree_not_exists
@@ -110,15 +110,15 @@ check_subvol_btree_not_exists
 _cleanup_flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 create_subvol_with_orphan
 MOUNT_OPTIONS="-o ro,commit=1"
-_mount_flakey
+_scratch_mount
 # The subvolume path should not be accessible anymore, even if deletion of the
 # subvolume btree did not happen yet.
 [ -e $SCRATCH_MNT/testsv ] && echo "subvolume path still exists"
-_unmount_flakey
+_scratch_unmount
 
 # The subvolume btree should still exist, even though the path is not accessible.
 check_subvol_btree_exists
@@ -127,15 +127,15 @@ check_subvol_btree_exists
 check_subvol_orphan_item_exists
 
 # Mount the filesystem RO again.
-_mount_flakey
+_scratch_mount
 
 # Now remount RW, then unmount and then check the subvolume's orphan item, btree
 # and path don't exist anymore.
 MOUNT_OPTIONS="-o remount,rw"
-_mount_flakey
+_scratch_mount
 $BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >>$seqres.full
 [ -e $SCRATCH_MNT/testsv ] && echo "subvolume path still exists"
-_unmount_flakey
+_scratch_unmount
 
 check_subvol_orphan_item_not_exists
 check_subvol_btree_not_exists
diff --git a/tests/btrfs/236 b/tests/btrfs/236
index a3b58f0cd636..fd2fea85df44 100755
--- a/tests/btrfs/236
+++ b/tests/btrfs/236
@@ -157,7 +157,7 @@ _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 MOUNT_OPTIONS="-o datacow"
-_mount_flakey
+_scratch_mount
 
 # Test a few times each scenario because this test was motivated by a race
 # condition.
@@ -170,12 +170,12 @@ for ((i = 1; i <= 3; i++)); do
 	test_fsync "link_cow_$i" "link"
 done
 
-_unmount_flakey
+_scratch_unmount
 
 # Now lets test with nodatacow.
 if ! _scratch_btrfs_is_zoned; then
 	MOUNT_OPTIONS="-o nodatacow"
-	_mount_flakey
+	_scratch_mount
 
 	echo "Testing fsync after rename with NOCOW writes"
 	for ((i = 1; i <= 3; i++)); do
@@ -186,7 +186,7 @@ if ! _scratch_btrfs_is_zoned; then
 		test_fsync "link_nocow_$i" "link"
 	done
 
-	_unmount_flakey
+	_scratch_unmount
 else
 	# Fake result. Zoned btrfs does not support NOCOW
 	echo "Testing fsync after rename with NOCOW writes"
diff --git a/tests/btrfs/239 b/tests/btrfs/239
index 3ac490273e66..834785fa980f 100755
--- a/tests/btrfs/239
+++ b/tests/btrfs/239
@@ -38,7 +38,7 @@ _require_dm_target flakey
 _scratch_mkfs "-n 65536" >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # "testdir" is inode 257.
 mkdir $SCRATCH_MNT/testdir
@@ -195,7 +195,7 @@ _flakey_drop_and_remount
 echo "File $SCRATCH_MNT/testdir/file1 data:" | _filter_scratch
 od -A d -t x1 $SCRATCH_MNT/testdir/file1
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/btrfs/240 b/tests/btrfs/240
index 6ad7adc11f1e..c9d7cbb35405 100755
--- a/tests/btrfs/240
+++ b/tests/btrfs/240
@@ -31,7 +31,7 @@ _require_xfs_io_command "falloc"
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file with 2 preallocated extents. Leave a 1M hole between them
 # to ensure that we get two file extent items that will never be merged into a
@@ -157,7 +157,7 @@ _flakey_drop_and_remount
 echo "File content before after failure:"
 od -A d -t x1 $SCRATCH_MNT/foobar
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/btrfs/243 b/tests/btrfs/243
index 6e0649fbcf2c..46f3066ef34b 100755
--- a/tests/btrfs/243
+++ b/tests/btrfs/243
@@ -31,7 +31,7 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test files.
 touch $SCRATCH_MNT/foo
@@ -82,7 +82,7 @@ od -A d -t x1 $SCRATCH_MNT/bar2
 [ -f $SCRATCH_MNT/foo2 ] || echo "File name foo2 does not exists"
 [ -f $SCRATCH_MNT/foo ] && echo "File name foo still exists"
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/generic/034 b/tests/generic/034
index cd22f330d77c..45fd234487a1 100755
--- a/tests/generic/034
+++ b/tests/generic/034
@@ -32,7 +32,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/test_dir
 touch $SCRATCH_MNT/test_dir/foo
@@ -66,7 +66,7 @@ rm -f $SCRATCH_MNT/test_dir/bar
 rmdir $SCRATCH_MNT/test_dir
 [ -d $SCRATCH_MNT/test_dir ] && echo "rmdir didn't succeed"
 
-_unmount_flakey
+_scratch_unmount
 
 echo "Silence is golden"
 
diff --git a/tests/generic/039 b/tests/generic/039
index 00d4e4afb5fc..264708543197 100755
--- a/tests/generic/039
+++ b/tests/generic/039
@@ -36,7 +36,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create a test file with 2 hard links in the same directory.
 mkdir -p $SCRATCH_MNT/a/b
diff --git a/tests/generic/040 b/tests/generic/040
index 8b4e3b703a4e..acc3689aa697 100755
--- a/tests/generic/040
+++ b/tests/generic/040
@@ -49,7 +49,7 @@ fi
 
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create a test file with 3001 hard links. This number is large enough to
 # make btrfs start using extrefs at some point even if the fs has the maximum
diff --git a/tests/generic/041 b/tests/generic/041
index 6d42d1a28310..79612397e590 100755
--- a/tests/generic/041
+++ b/tests/generic/041
@@ -53,7 +53,7 @@ fi
 
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create a test file with 3001 hard links. This number is large enough to
 # make btrfs start using extrefs at some point even if the fs has the maximum
diff --git a/tests/generic/056 b/tests/generic/056
index 3e139e1ea48c..20302622dc05 100755
--- a/tests/generic/056
+++ b/tests/generic/056
@@ -34,7 +34,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create one file with data and fsync it.
 # This made the btrfs fsync log persist the data and the inode metadata with
diff --git a/tests/generic/057 b/tests/generic/057
index c5db80977b4d..302231793674 100755
--- a/tests/generic/057
+++ b/tests/generic/057
@@ -34,7 +34,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file with some data.
 $XFS_IO_PROG -f -c "pwrite -S 0xaa -b 8K 0 8K" \
diff --git a/tests/generic/059 b/tests/generic/059
index db48de378600..6420915789f1 100755
--- a/tests/generic/059
+++ b/tests/generic/059
@@ -42,7 +42,7 @@ _require_xfs_io_command "fpunch"
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file.
 $XFS_IO_PROG -f -c "pwrite -S 0x22 -b 16K 0 16K" \
diff --git a/tests/generic/065 b/tests/generic/065
index f7e1e276f5a4..62fd96282b40 100755
--- a/tests/generic/065
+++ b/tests/generic/065
@@ -35,7 +35,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our main test file and directory.
 $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 8K" $SCRATCH_MNT/foo | _filter_xfs_io
diff --git a/tests/generic/066 b/tests/generic/066
index 9e4047a11680..98674cdff854 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -40,7 +40,7 @@ _require_attrs
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create out test file and add 3 xattrs to it.
 touch $SCRATCH_MNT/foobar
@@ -89,7 +89,7 @@ _flakey_drop_and_remount
 echo "xattr names and values after second fsync log replay:"
 _getfattr --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/073 b/tests/generic/073
index 05df1ea87dce..3e31a0284aa2 100755
--- a/tests/generic/073
+++ b/tests/generic/073
@@ -34,7 +34,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our main test file 'foo', the one we check for data loss.
 # By doing an fsync against our file, it makes btrfs clear the 'needs_full_sync'
diff --git a/tests/generic/090 b/tests/generic/090
index b1ea27bbd287..00cc38fab7d6 100755
--- a/tests/generic/090
+++ b/tests/generic/090
@@ -33,7 +33,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create the test file with some initial data and then fsync it.
 # The fsync here is only needed to trigger the issue in btrfs, as it causes the
diff --git a/tests/generic/101 b/tests/generic/101
index 4295f080130d..316602777eb0 100755
--- a/tests/generic/101
+++ b/tests/generic/101
@@ -40,7 +40,7 @@ fi
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test files and make sure everything is durably persisted.
 $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 64K"         \
diff --git a/tests/generic/104 b/tests/generic/104
index 9af3b5582e96..f515e74ecad8 100755
--- a/tests/generic/104
+++ b/tests/generic/104
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directory and files.
 mkdir $SCRATCH_MNT/testdir
@@ -58,7 +58,7 @@ echo "Link count for file bar: $(stat -c %h $SCRATCH_MNT/testdir/bar)"
 rm -f $SCRATCH_MNT/testdir/*
 rmdir $SCRATCH_MNT/testdir
 
-_unmount_flakey
+_scratch_unmount
 
 # The fstests framework will call fsck against our filesystem which will verify
 # that all metadata is in a consistent state.
diff --git a/tests/generic/106 b/tests/generic/106
index 8bcc7575e1f6..5705787c05af 100755
--- a/tests/generic/106
+++ b/tests/generic/106
@@ -29,7 +29,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file with 2 hard links.
 mkdir $SCRATCH_MNT/testdir
@@ -56,7 +56,7 @@ ls -1 $SCRATCH_MNT/testdir
 rm -f $SCRATCH_MNT/testdir/*
 rmdir $SCRATCH_MNT/testdir
 
-_unmount_flakey
+_scratch_unmount
 
 # The fstests framework will call fsck against our filesystem which will verify
 # that all metadata is in a consistent state.
diff --git a/tests/generic/107 b/tests/generic/107
index 8a82d146880d..79f95f9aa533 100755
--- a/tests/generic/107
+++ b/tests/generic/107
@@ -32,7 +32,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directory and file.
 mkdir $SCRATCH_MNT/testdir
@@ -61,7 +61,7 @@ ls -1 $SCRATCH_MNT/testdir
 rm -f $SCRATCH_MNT/testdir/*
 rmdir $SCRATCH_MNT/testdir
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/177 b/tests/generic/177
index 7a4fc77627e8..c4cde443d676 100755
--- a/tests/generic/177
+++ b/tests/generic/177
@@ -34,7 +34,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
 
@@ -77,7 +77,7 @@ echo "Fiemap after log replay:"
 # Must match the same extent listing we got before the power failure.
 $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar | _filter_fiemap $BLOCK_SIZE
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/311 b/tests/generic/311
index 5d21752fe864..a946b96bd77c 100755
--- a/tests/generic/311
+++ b/tests/generic/311
@@ -56,19 +56,19 @@ _run_test()
 
 	_md5_checksum $testfile
 	_load_flakey_table $FLAKEY_DROP_WRITES $lockfs
-	_unmount_flakey
+	_scratch_unmount
 
 	#Ok mount so that any recovery that needs to happen is done
 	_load_flakey_table $FLAKEY_ALLOW_WRITES
-	_mount_flakey
+	_scratch_mount
 	_md5_checksum $testfile
 
 	#Unmount and fsck to make sure we got a valid fs after replay
-	_unmount_flakey
-	_check_scratch_fs $FLAKEY_DEV
+	_scratch_unmount
+	_check_scratch_fs
 	[ $? -ne 0 ] && _fatal "fsck failed"
 
-	_mount_flakey
+	_scratch_mount
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
@@ -76,7 +76,7 @@ _require_metadata_journaling $SCRATCH_DEV
 
 # Create a basic flakey device that will never error out
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 buffered=0
 direct=1
diff --git a/tests/generic/321 b/tests/generic/321
index df8f13597702..51f509e5aa88 100755
--- a/tests/generic/321
+++ b/tests/generic/321
@@ -26,24 +26,24 @@ _require_dm_target flakey
 
 _clean_working_dir()
 {
-	_mount_flakey
+	_scratch_mount
 	rm -rf $SCRATCH_MNT/foo $SCRATCH_MNT/bar
-	_unmount_flakey
+	_scratch_unmount
 }
 
 # Btrfs wasn't making sure the directory survived fsync
 _directory_test()
 {
 	echo "fsync new directory"
-	_mount_flakey
+	_scratch_mount
 	mkdir $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
 
 	_flakey_drop_and_remount
 
 	_ls_l $SCRATCH_MNT | tail -n +2 | awk '{ print $1, $9 }'
-	_unmount_flakey
-	_check_scratch_fs $FLAKEY_DEV
+	_scratch_unmount
+	_check_scratch_fs
 	[ $? -ne 0 ] && _fatal "fsck failed"
 }
 
@@ -51,7 +51,7 @@ _directory_test()
 _rename_test()
 {
 	echo "rename fsync test"
-	_mount_flakey
+	_scratch_mount
 	touch $SCRATCH_MNT/foo
 	mkdir $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
@@ -63,8 +63,8 @@ _rename_test()
 
 	_ls_l $SCRATCH_MNT | tail -n +2 | awk '{ print $1, $9 }'
 	_ls_l $SCRATCH_MNT/bar | tail -n +2 | awk '{ print $1, $9 }'
-	_unmount_flakey
-	_check_scratch_fs $FLAKEY_DEV
+	_scratch_unmount
+	_check_scratch_fs
 	[ $? -ne 0 ] && _fatal "fsck failed"
 }
 
@@ -73,7 +73,7 @@ _rename_test()
 _replay_rename_test()
 {
 	echo "replay rename fsync test"
-	_mount_flakey
+	_scratch_mount
 	touch $SCRATCH_MNT/foo
 	mkdir $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
@@ -90,7 +90,7 @@ _replay_rename_test()
 
 	_ls_l $SCRATCH_MNT | tail -n +2 | awk '{ print $1, $9 }'
 	_ls_l $SCRATCH_MNT/bar | tail -n +2 | awk '{ print $1, $9 }'
-	_unmount_flakey
+	_scratch_unmount
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/generic/322 b/tests/generic/322
index 5cb77cbfab12..d66a30ffafdc 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -24,16 +24,16 @@ _require_dm_target flakey
 
 _clean_working_dir()
 {
-	_mount_flakey
+	_scratch_mount
 	rm -rf $SCRATCH_MNT/foo $SCRATCH_MNT/bar
-	_unmount_flakey
+	_scratch_unmount
 }
 
 # Btrfs wasn't making sure the new file after rename survived the fsync
 _rename_test()
 {
 	echo "fsync rename test"
-	_mount_flakey
+	_scratch_mount
 	$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $SCRATCH_MNT/foo \
 		>> $seqres.full 2>&1
 	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
@@ -43,8 +43,8 @@ _rename_test()
 	_flakey_drop_and_remount
 
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
-	_unmount_flakey
-	_check_scratch_fs $FLAKEY_DEV
+	_scratch_unmount
+	_check_scratch_fs
 	[ $? -ne 0 ] && _fatal "fsck failed"
 }
 
@@ -53,7 +53,7 @@ _rename_test()
 _write_after_fsync_rename_test()
 {
 	echo "fsync rename test"
-	_mount_flakey
+	_scratch_mount
 	$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" -c "pwrite 2M 1M" \
 		-c "sync_range -b 2M 1M" $SCRATCH_MNT/foo >> $seqres.full 2>&1
 	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
@@ -63,7 +63,7 @@ _write_after_fsync_rename_test()
 	_flakey_drop_and_remount
 
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
-	_unmount_flakey
+	_scratch_unmount
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/generic/325 b/tests/generic/325
index 932c18f17ef4..7c055b6fdb07 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -34,7 +34,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create the file first.
 $XFS_IO_PROG -f -c "pwrite -S 0xff 0 256K" $SCRATCH_MNT/foo | _filter_xfs_io
@@ -69,7 +69,7 @@ _flakey_drop_and_remount
 echo "File content after crash/reboot and fs mount:"
 od -t x1 $SCRATCH_MNT/foo
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/335 b/tests/generic/335
index f287b5150a39..19c8fe3b6a1a 100755
--- a/tests/generic/335
+++ b/tests/generic/335
@@ -29,7 +29,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directories and the file we will later check if it has
 # disappeared.
@@ -73,7 +73,7 @@ echo "Filesystem content after power failure:"
 # Must match what we had before the power failure.
 ls -R $SCRATCH_MNT/a $SCRATCH_MNT/c | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/336 b/tests/generic/336
index c874997e420b..304ff574440c 100755
--- a/tests/generic/336
+++ b/tests/generic/336
@@ -36,7 +36,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directories and the file we will later check if it has
 # disappeared (file bar).
@@ -70,7 +70,7 @@ echo "Filesystem content after power failure:"
 # Must match what we had before the power failure.
 ls -R $SCRATCH_MNT/a $SCRATCH_MNT/b $SCRATCH_MNT/c | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/341 b/tests/generic/341
index 80fdcbac7a43..aa41dbac5292 100755
--- a/tests/generic/341
+++ b/tests/generic/341
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir -p $SCRATCH_MNT/a/x
 $XFS_IO_PROG -f -c "pwrite -S 0xaf 0 32K" $SCRATCH_MNT/a/x/foo | _filter_xfs_io
@@ -62,6 +62,6 @@ echo "File digests after log replay:"
 md5sum $SCRATCH_MNT/a/y/foo | _filter_scratch
 md5sum $SCRATCH_MNT/a/y/bar | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/342 b/tests/generic/342
index a7aca860b9a8..01d01226d1dc 100755
--- a/tests/generic/342
+++ b/tests/generic/342
@@ -35,7 +35,7 @@ if [ $FSTYP = "f2fs" ]; then
 fi
 
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/a
 $XFS_IO_PROG -f -c "pwrite -S 0xf1 0 16K" $SCRATCH_MNT/a/foo | _filter_xfs_io
@@ -64,6 +64,6 @@ echo "File digests after log replay:"
 md5sum $SCRATCH_MNT/a/foo | _filter_scratch
 md5sum $SCRATCH_MNT/a/bar | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/343 b/tests/generic/343
index 97ff4f984258..5fff62895089 100755
--- a/tests/generic/343
+++ b/tests/generic/343
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directories and files.
 mkdir $SCRATCH_MNT/x
@@ -56,6 +56,6 @@ _flakey_drop_and_remount
 echo "Filesystem contents after log replay:"
 ls -R $SCRATCH_MNT/x $SCRATCH_MNT/y | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/348 b/tests/generic/348
index 1905a6e6a7ea..52404b4df556 100755
--- a/tests/generic/348
+++ b/tests/generic/348
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/testdir1
 # Make sure it's durably persisted.
@@ -54,6 +54,6 @@ echo "Symlink contents after log replay:"
 readlink $SCRATCH_MNT/testdir1/bar1 | _filter_scratch
 readlink $SCRATCH_MNT/testdir2/bar2 | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/376 b/tests/generic/376
index 17a5f290bed6..390a07dddbbf 100755
--- a/tests/generic/376
+++ b/tests/generic/376
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directories and files.
 mkdir $SCRATCH_MNT/dir
@@ -46,6 +46,6 @@ _flakey_drop_and_remount
 echo "Filesystem contents after log replay:"
 ls -R $SCRATCH_MNT/dir | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/456 b/tests/generic/456
index 32afa398f11c..0f0830d2a296 100755
--- a/tests/generic/456
+++ b/tests/generic/456
@@ -40,7 +40,7 @@ _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # See this post for reverse engineering of this auto generated test:
 # https://marc.info/?l=linux-ext4&m=151137380830381&w=2
@@ -56,7 +56,7 @@ EOF
 run_check $FSX_PROG -d --replay-ops $fsxops $SCRATCH_MNT/testfile
 
 _flakey_drop_and_remount
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 _check_scratch_fs
 
diff --git a/tests/generic/479 b/tests/generic/479
index 650c921b8fdc..f966100124dd 100755
--- a/tests/generic/479
+++ b/tests/generic/479
@@ -36,7 +36,7 @@ run_test()
 	_scratch_mkfs >>$seqres.full 2>&1
 	_require_metadata_journaling $SCRATCH_DEV
 	_init_flakey
-	_mount_flakey
+	_scratch_mount
 
 	mkdir $SCRATCH_MNT/testdir
 	case $file_type in
@@ -75,7 +75,7 @@ run_test()
 	# replaying the fsync log/journal succeeds, that is the mount operation
 	# does not fail.
 	_flakey_drop_and_remount
-	_unmount_flakey
+	_scratch_unmount
 	_cleanup_flakey
 }
 
diff --git a/tests/generic/480 b/tests/generic/480
index 6c599446b5e5..1ed3b21a657f 100755
--- a/tests/generic/480
+++ b/tests/generic/480
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/testdir
 touch $SCRATCH_MNT/testdir/foo
@@ -50,7 +50,7 @@ $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/bar
 # the fsync log/journal succeeds, that is the mount operation does not fail.
 _flakey_drop_and_remount
 
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 
 echo "Silence is golden"
diff --git a/tests/generic/481 b/tests/generic/481
index 5c980cf01d60..ecc1705bbe60 100755
--- a/tests/generic/481
+++ b/tests/generic/481
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # create a file and keep it in write ahead log
 $XFS_IO_PROG -f -c "fsync" $SCRATCH_MNT/foo
@@ -42,7 +42,7 @@ _flakey_drop_and_remount
 # see if we can create a new file successfully
 touch $SCRATCH_MNT/bar
 
-_unmount_flakey
+_scratch_unmount
 
 echo "Silence is golden"
 
diff --git a/tests/generic/483 b/tests/generic/483
index a71f96ad0dc1..01871d63a43e 100755
--- a/tests/generic/483
+++ b/tests/generic/483
@@ -31,7 +31,7 @@ _require_xfs_io_command "fiemap"
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # The fiemap results in the golden output requires file allocations to align to
 # 256K boundaries.
@@ -95,7 +95,7 @@ $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/baz | _filter_hole_fiemap
 echo "File baz size:"
 stat --format %s $SCRATCH_MNT/baz
 
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 
 status=0
diff --git a/tests/generic/489 b/tests/generic/489
index e76055fa4436..05e69897e2b6 100755
--- a/tests/generic/489
+++ b/tests/generic/489
@@ -30,7 +30,7 @@ _require_attrs
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 touch $SCRATCH_MNT/foobar
 $SETFATTR_PROG -n user.xa1 -v qwerty $SCRATCH_MNT/foobar
@@ -53,7 +53,7 @@ _getfattr --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
 echo "File data after power failure:"
 od -t x1 $SCRATCH_MNT/foobar
 
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 
 status=0
diff --git a/tests/generic/498 b/tests/generic/498
index f58c9ed510e8..b0bf403add15 100755
--- a/tests/generic/498
+++ b/tests/generic/498
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/A
 mkdir $SCRATCH_MNT/B
@@ -49,7 +49,7 @@ _flakey_drop_and_remount
 [ -d $SCRATCH_MNT/A ] || echo "directory A missing"
 [ -f $SCRATCH_MNT/B/foo ] || echo "file B/foo is missing"
 
-_unmount_flakey
+_scratch_unmount
 
 echo "Silence is golden"
 status=0
diff --git a/tests/generic/501 b/tests/generic/501
index 4444016bc2a6..1cf54fc04e70 100755
--- a/tests/generic/501
+++ b/tests/generic/501
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 _require_congruent_file_oplen $SCRATCH_MNT 2097152
 
 # Use file sizes and offsets/lengths for the clone operation that are multiples
@@ -57,7 +57,7 @@ _flakey_drop_and_remount
 echo "File bar digest after power failure:"
 md5sum $SCRATCH_MNT/bar | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 
 status=0
diff --git a/tests/generic/502 b/tests/generic/502
index f488bd06c7a8..553b186e5e46 100755
--- a/tests/generic/502
+++ b/tests/generic/502
@@ -38,7 +38,7 @@ if [ $FSTYP = "f2fs" ]; then
 fi
 
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file with 2 hard links in the same parent directory.
 mkdir $SCRATCH_MNT/testdir
@@ -69,7 +69,7 @@ _flakey_drop_and_remount
 echo "Contents of test directory after the power failure:"
 ls -R $SCRATCH_MNT/testdir | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 _cleanup_flakey
 
 status=0
diff --git a/tests/generic/509 b/tests/generic/509
index 5025c0d74164..f38e4503857b 100755
--- a/tests/generic/509
+++ b/tests/generic/509
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our tmpfile, write some data to it and fsync it. We want a power
 # failure to happen after the fsync, so that we have an inode with a link
@@ -43,7 +43,7 @@ $XFS_IO_PROG -T \
 # Simulate a power failure and mount the filesystem to check that it succeeds.
 _flakey_drop_and_remount
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/510 b/tests/generic/510
index abf18f1bfee4..0c3f81f5bf70 100755
--- a/tests/generic/510
+++ b/tests/generic/510
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directories and file.
 mkdir $SCRATCH_MNT/testdir
@@ -56,7 +56,7 @@ _flakey_drop_and_remount
 echo "Filesystem content after power failure:"
 ls -R $SCRATCH_MNT/testdir | _filter_scratch
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/512 b/tests/generic/512
index 8965d9d639fa..f6ed90b70c62 100755
--- a/tests/generic/512
+++ b/tests/generic/512
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 $XFS_IO_PROG -f \
 	     -c "pwrite -S 0xb6 0 21" \
@@ -46,7 +46,7 @@ _flakey_drop_and_remount
 echo "File content after power failure:"
 od -t x1 -A d $SCRATCH_MNT/foobar
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/520 b/tests/generic/520
index f2523fca27f2..3c7ae615affc 100755
--- a/tests/generic/520
+++ b/tests/generic/520
@@ -43,9 +43,9 @@ after=""
 # adds about 10 seconds of delay in total for the 37 tests.
 clean_dir()
 {
-	_mount_flakey
+	_scratch_mount
 	rm -rf $(find $SCRATCH_MNT/* | grep -v "lost+found")
-	_unmount_flakey
+	_scratch_unmount
 }
 
 check_consistency()
@@ -61,8 +61,8 @@ check_consistency()
 		echo "After: $after"
 	fi
 
-	_unmount_flakey
-	_check_scratch_fs $FLAKEY_DEV
+	_scratch_unmount
+	_check_scratch_fs
 }
 
 # create a hard link $2 to file $1, and fsync $3, followed by power-cut
@@ -82,7 +82,7 @@ test_link_fsync()
 
 	echo -ne "\n=== link $src $dest  with fsync $fsync ===\n" | \
 		_filter_scratch
-	_mount_flakey
+	_scratch_mount
 
 	# Now execute the workload
 	# Create the directory in which the source and destination files
@@ -116,7 +116,7 @@ test_link_sync()
 	before=""
 	after=""
 	echo -ne "\n=== link $src $dest  with sync ===\n" | _filter_scratch
-	_mount_flakey
+	_scratch_mount
 
 	# now execute the workload
 	# Create the directory in which the source and destination files
diff --git a/tests/generic/526 b/tests/generic/526
index af77ccaff32b..b820dda3a43c 100755
--- a/tests/generic/526
+++ b/tests/generic/526
@@ -36,7 +36,7 @@ if [ $FSTYP = "f2fs" ]; then
 fi
 
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/testdir
 echo -n "foo" > $SCRATCH_MNT/testdir/fname1
@@ -63,7 +63,7 @@ echo "File fname2 data after power failure: $(cat $SCRATCH_MNT/testdir/fname2)"
 echo "File fname3 data after power failure: $(cat $SCRATCH_MNT/testdir/fname3)"
 echo "File fname4 data after power failure: $(cat $SCRATCH_MNT/testdir/fname4)"
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/527 b/tests/generic/527
index 90555077f007..e09efff9e2f1 100755
--- a/tests/generic/527
+++ b/tests/generic/527
@@ -36,7 +36,7 @@ if [ $FSTYP = "f2fs" ]; then
 fi
 
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/testdir
 echo -n "foo" > $SCRATCH_MNT/testdir/fname1
@@ -88,7 +88,7 @@ echo "File a2 data after power failure: $(cat $SCRATCH_MNT/testdir2/a2)"
 echo "File zz data after power failure: $(cat $SCRATCH_MNT/testdir2/zz)"
 echo "File zz_link data after power failure: $(cat $SCRATCH_MNT/testdir2/zz_link)"
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/534 b/tests/generic/534
index f1cd90c0ec75..5c68ebde4c2b 100755
--- a/tests/generic/534
+++ b/tests/generic/534
@@ -28,7 +28,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file with an initial size of 8000 bytes, then fsync it,
 # followed by a truncate that reduces its size down to 3000 bytes.
@@ -51,7 +51,7 @@ _flakey_drop_and_remount
 echo "File content after power failure:"
 od -A d -t x1 $SCRATCH_MNT/bar
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/535 b/tests/generic/535
index 98e2f2384a64..9f552ee8a7c7 100755
--- a/tests/generic/535
+++ b/tests/generic/535
@@ -48,7 +48,7 @@ do_check()
 	local target=$1
 	local is_dir=$2
 
-	_mount_flakey
+	_scratch_mount
 
 	if [ $is_dir = 1 ]; then
 		mkdir $target
@@ -81,7 +81,7 @@ do_check()
 	else
 		rm -f $target
 	fi
-	_unmount_flakey
+	_scratch_unmount
 }
 
 echo "Silence is golden"
diff --git a/tests/generic/546 b/tests/generic/546
index ab4ea657ee00..3fb705c0226f 100755
--- a/tests/generic/546
+++ b/tests/generic/546
@@ -36,7 +36,7 @@ _require_dm_target flakey
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 _require_congruent_file_oplen $SCRATCH_MNT 4096
 
 # Create preallocated extent where we can write into
diff --git a/tests/generic/547 b/tests/generic/547
index 14d02b4fdc8e..880dfecb64b4 100755
--- a/tests/generic/547
+++ b/tests/generic/547
@@ -36,7 +36,7 @@ mkdir $fssum_files_dir
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/test
 args=`_scale_fsstress_args -p 4 -n 100 -d $SCRATCH_MNT/test`
@@ -59,7 +59,7 @@ _flakey_drop_and_remount
 # must match.
 $FSSUM_PROG -r $fssum_files_dir/fs_digest $SCRATCH_MNT/test
 
-_unmount_flakey
+_scratch_unmount
 
 status=0
 exit
diff --git a/tests/generic/552 b/tests/generic/552
index 9f3d7fdebddc..2f38141686cd 100755
--- a/tests/generic/552
+++ b/tests/generic/552
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directory with two files in it.
 mkdir $SCRATCH_MNT/dir
@@ -84,6 +84,6 @@ _flakey_drop_and_remount
 echo "File data after power failure:"
 od -t x1 -A d $SCRATCH_MNT/dir/baz
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/557 b/tests/generic/557
index 742180e2b7ea..00a4c2525035 100755
--- a/tests/generic/557
+++ b/tests/generic/557
@@ -28,7 +28,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directory with one file in it and fsync the file.
 mkdir $SCRATCH_MNT/dir
@@ -64,7 +64,7 @@ _flakey_drop_and_remount
 
 [ -f $SCRATCH_MNT/dir/foo ] && echo "File foo still exists"
 
-_unmount_flakey
+_scratch_unmount
 echo "Silence is golden"
 status=0
 exit
diff --git a/tests/generic/588 b/tests/generic/588
index 0ee9f001c959..90491bde2c26 100755
--- a/tests/generic/588
+++ b/tests/generic/588
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 _require_congruent_file_oplen $SCRATCH_MNT 65536
 
@@ -65,6 +65,6 @@ _flakey_drop_and_remount
 echo "File digest after mount:"
 _md5_checksum $SCRATCH_MNT/foobar
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/640 b/tests/generic/640
index c3b33746e669..2aa859060ed7 100755
--- a/tests/generic/640
+++ b/tests/generic/640
@@ -30,7 +30,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create two test directories, one with a file we will rename later.
 mkdir $SCRATCH_MNT/A
@@ -94,6 +94,6 @@ fi
 [ -f $SCRATCH_MNT/A/bar ] || echo "File A/bar is missing"
 [ -f $SCRATCH_MNT/baz ] || echo "File baz is missing"
 
-_unmount_flakey
+_scratch_unmount
 status=0
 exit
diff --git a/tests/generic/677 b/tests/generic/677
index 86099454ff39..176c56c0e5b0 100755
--- a/tests/generic/677
+++ b/tests/generic/677
@@ -34,7 +34,7 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # The fiemap results in the golden output requires file allocations to align to
 # 1MB boundaries.
@@ -80,7 +80,7 @@ _flakey_drop_and_remount
 echo "List of extents after power failure:"
 $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/generic/690 b/tests/generic/690
index ef5bd1983cef..8e01411bc0c3 100755
--- a/tests/generic/690
+++ b/tests/generic/690
@@ -46,7 +46,7 @@ fi
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test directory.
 mkdir "$SCRATCH_MNT"/testdir
@@ -80,7 +80,7 @@ _flakey_drop_and_remount
 symlink_content=$(readlink "$SCRATCH_MNT"/testdir/baz | _filter_scratch)
 echo "symlink content: ${symlink_content}"
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/generic/695 b/tests/generic/695
index 694f42454511..78271e7b0970 100755
--- a/tests/generic/695
+++ b/tests/generic/695
@@ -35,7 +35,7 @@ _require_xfs_io_command "fiemap"
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # We punch 2M holes and require extent allocations to align to 2M in fiemap
 # results.
@@ -83,7 +83,7 @@ $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar | _filter_fiemap
 echo "File content after power failure:"
 _hexdump $SCRATCH_MNT/foobar
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/generic/703 b/tests/generic/703
index 2bace19d6f06..30afe6da711a 100755
--- a/tests/generic/703
+++ b/tests/generic/703
@@ -53,7 +53,7 @@ _require_fio $fio_config
 _scratch_mkfs >>$seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # We do 64K writes in the fio job.
 _require_congruent_file_oplen $SCRATCH_MNT $((64 * 1024))
@@ -94,7 +94,7 @@ if [ "$digest_after" != "$digest_before" ]; then
 	echo "Digest after power failure:  $digest_after"
 fi
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 echo "Silence is golden"
diff --git a/tests/generic/741 b/tests/generic/741
index c15dc4345b7a..9bde8cbdd9b1 100755
--- a/tests/generic/741
+++ b/tests/generic/741
@@ -19,7 +19,7 @@ _cleanup()
 	_unmount $extra_mnt &> /dev/null
 	_unmount $extra_mnt &> /dev/null
 	rm -rf $extra_mnt
-	_unmount_flakey
+	_scratch_unmount
 	_cleanup_flakey
 	cd /
 	rm -r -f $tmp.*
@@ -38,7 +38,7 @@ _require_dm_target flakey
 
 _scratch_mkfs >> $seqres.full
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 extra_mnt=$TEST_DIR/extra_mnt
 rm -rf $extra_mnt
@@ -46,13 +46,13 @@ mkdir -p $extra_mnt
 
 # Mount must fail because the physical device has a dm created on it.
 # Filters alter the return code of the mount.
-_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
-			_filter_testdir_and_scratch | _filter_error_mount
+_mount $NON_FLAKEY_DEV $extra_mnt 2>/dev/null && \
+	_fail "mount of busy device succeeded"
 
-# Try again with flakey unmounted, must fail.
-_unmount_flakey
-_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
-			_filter_testdir_and_scratch | _filter_error_mount
+# Try again with flakey unmounted, must also fail.
+_scratch_unmount
+_mount $NON_FLAKEY_DEV $extra_mnt 2>/dev/null && \
+	_fail "mount of busy device succeeded"
 
 # Removing dm should make mount successful.
 _cleanup_flakey
diff --git a/tests/generic/741.out b/tests/generic/741.out
index b694f5fad6b8..9a6fc96d1c88 100644
--- a/tests/generic/741.out
+++ b/tests/generic/741.out
@@ -1,3 +1 @@
 QA output created by 741
-mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
-mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
diff --git a/tests/generic/745 b/tests/generic/745
index 62624b15bc65..09a1860302d2 100755
--- a/tests/generic/745
+++ b/tests/generic/745
@@ -46,7 +46,7 @@ esac
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create the test file with some initial data and make sure everything is
 # durably persisted.
diff --git a/tests/generic/764 b/tests/generic/764
index 55937fc0c988..b23f86e501f7 100755
--- a/tests/generic/764
+++ b/tests/generic/764
@@ -30,7 +30,7 @@ _require_test_program "multi_open_unlink"
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 mkdir $SCRATCH_MNT/testdir
 $here/src/multi_open_unlink -f $SCRATCH_MNT/testdir/foo -F -S -n 1 -s 0
@@ -43,7 +43,7 @@ _flakey_drop_and_remount
 # more hard links.
 ls $SCRATCH_MNT/testdir
 
-_unmount_flakey
+_scratch_unmount
 
 echo "Silence is golden"
 status=0
diff --git a/tests/generic/771 b/tests/generic/771
index ea3e4ffa13da..1028c6d8c7e1 100755
--- a/tests/generic/771
+++ b/tests/generic/771
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our first test file with some data.
 mkdir $SCRATCH_MNT/testdir
diff --git a/tests/generic/779 b/tests/generic/779
index 842472aedc18..770a2e00b97c 100755
--- a/tests/generic/779
+++ b/tests/generic/779
@@ -32,7 +32,7 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test dir and add a symlink inside it.
 mkdir $SCRATCH_MNT/dir
@@ -54,7 +54,7 @@ _flakey_drop_and_remount
 [ -L $SCRATCH_MNT/dir/new-slink ] || echo "symlink dir/new-slink not found"
 echo "symlink content: $(readlink $SCRATCH_MNT/dir/new-slink)"
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 _exit 0
diff --git a/tests/generic/782 b/tests/generic/782
index 13c729d29bc4..710fca701cbd 100755
--- a/tests/generic/782
+++ b/tests/generic/782
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our test file.
 touch $SCRATCH_MNT/foo
@@ -68,6 +68,6 @@ ls -1 $SCRATCH_MNT | grep -v 'lost+found'
 echo "File data:"
 _hexdump $SCRATCH_MNT/foo
 
-_unmount_flakey
+_scratch_unmount
 
 _exit 0
diff --git a/tests/generic/784 b/tests/generic/784
index 8e01dff05957..5d972ccef178 100755
--- a/tests/generic/784
+++ b/tests/generic/784
@@ -31,7 +31,7 @@ _require_dm_target flakey
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 list_fs_contents()
 {
@@ -70,7 +70,7 @@ _flakey_drop_and_remount
 echo -e "\nfs contents after power failure:\n"
 list_fs_contents
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 _exit 0
diff --git a/tests/generic/785 b/tests/generic/785
index a6cfdd87f31b..d918de4fcda9 100755
--- a/tests/generic/785
+++ b/tests/generic/785
@@ -33,7 +33,7 @@ _require_fssum
 _scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 # Create our first test file.
 echo -n > $SCRATCH_MNT/file1
@@ -67,7 +67,7 @@ _flakey_drop_and_remount
 # failure and after the last fsync.
 $FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT/
 
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 _exit 0
diff --git a/tests/xfs/051 b/tests/xfs/051
index ddc28ac9719f..95c89bbab47e 100755
--- a/tests/xfs/051
+++ b/tests/xfs/051
@@ -41,9 +41,9 @@ _kill_fsstress
 _scratch_unmount
 
 # Initialize a dm-flakey device that will pass I/Os for 5s and fail thereafter.
-_init_flakey
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 5 180"
+_init_flakey
 _load_flakey_table $FLAKEY_ALLOW_WRITES
 
 # Set a 10s log recovery delay and mount the flakey device. This should allow
@@ -54,7 +54,7 @@ echo 10 > /sys/fs/xfs/debug/log_recovery_delay
 
 # The mount should fail due to dm-flakey. Note that this is dangerous on kernels
 # without the xfs_buf log recovery race fixes.
-_mount_flakey > /dev/null 2>&1
+_scratch_mount > /dev/null 2>&1
 
 echo 0 > /sys/fs/xfs/debug/log_recovery_delay
 
diff --git a/tests/xfs/438 b/tests/xfs/438
index 6d1988c8b9b8..4ff249df6967 100755
--- a/tests/xfs/438
+++ b/tests/xfs/438
@@ -32,7 +32,7 @@ _cleanup()
 		sysctl -w fs.xfs.xfssyncd_centisecs=${interval} >/dev/null 2>&1
 	cd /
 	rm -f $tmp.*
-	_unmount_flakey >/dev/null 2>&1
+	_scratch_unmount >/dev/null 2>&1
 	_cleanup_flakey > /dev/null 2>&1
 }
 
@@ -100,6 +100,9 @@ echo "Silence is golden"
 
 _scratch_mkfs > $seqres.full 2>&1
 
+# this needs to happen after mkfs, but before _init_flakey overrides SCRATCH_DEV
+FLAKEY_TABLE_ERROR=$(make_xfs_scratch_flakey_table)
+
 # no error will be injected
 _init_flakey
 $DMSETUP_PROG info >> $seqres.full
@@ -111,7 +114,7 @@ interval=$(sysctl -n fs.xfs.xfssyncd_centisecs 2>/dev/null)
 sysctl -w fs.xfs.xfssyncd_centisecs=100 >> $seqres.full 2>&1
 
 _qmount_option "usrquota"
-_mount_flakey
+_scratch_mount
 
 # We need to set the quota limitation twice, and inject the write error
 # after the second setting. If we try to inject the write error after
@@ -127,7 +130,6 @@ xfs_freeze -f $SCRATCH_MNT
 xfs_freeze -u $SCRATCH_MNT
 
 # inject write IO error
-FLAKEY_TABLE_ERROR=$(make_xfs_scratch_flakey_table)
 _load_flakey_table ${FLAKEY_ERROR_WRITES}
 $DMSETUP_PROG info >> $seqres.full
 $DMSETUP_PROG table >> $seqres.full
@@ -142,7 +144,7 @@ _scratch_sync
 # the completion of the retried write of dquota buffer
 sleep 2
 
-_unmount_flakey
+_scratch_unmount
 
 _cleanup_flakey
 
diff --git a/tests/xfs/542 b/tests/xfs/542
index 09200c00501a..565dc450a3b7 100755
--- a/tests/xfs/542
+++ b/tests/xfs/542
@@ -34,7 +34,7 @@ _require_flakey_with_error_writes
 
 _scratch_mkfs >> $seqres.full
 _init_flakey
-_mount_flakey
+_scratch_mount
 
 blksz=$(_get_file_block_size $SCRATCH_MNT)
 
@@ -61,7 +61,7 @@ _load_flakey_table $FLAKEY_ALLOW_WRITES
 # Try a post-fail reflink and then unmount. Both of these are known to produce
 # errors and/or assert failures on XFS if we trip over a stale delalloc block.
 _cp_reflink $SCRATCH_MNT/file2 $SCRATCH_MNT/file3
-_unmount_flakey
+_scratch_unmount
 
 # success, all done
 status=0
diff --git a/tests/xfs/605 b/tests/xfs/605
index b31fe6b0a316..576cee4035ab 100755
--- a/tests/xfs/605
+++ b/tests/xfs/605
@@ -41,7 +41,7 @@ _scratch_mkfs >> $seqres.full 2>&1
 echo "Initialize and mount filesystem on flakey device"
 _init_flakey
 _load_flakey_table $FLAKEY_ALLOW_WRITES
-_mount_flakey
+_scratch_mount
 
 echo "Create test file"
 $XFS_IO_PROG -s -f -c "pwrite 0 5M" $testfile >> $seqres.full
@@ -50,10 +50,10 @@ echo "Punch alternative blocks of test file"
 $here/src/punch-alternating $testfile
 
 echo "Mount cycle the filesystem on flakey device"
-_unmount_flakey
-_mount_flakey
+_scratch_unmount
+_scratch_mount
 
-device=$(readlink -f $FLAKEY_DEV)
+device=$(readlink -f $SCRATCH_DEV)
 device=$(_short_dev $device)
 
 echo "Pin log items in the AIL"
@@ -73,7 +73,7 @@ echo "Unpin log items in AIL"
 echo 0 > /sys/fs/xfs/${device}/errortag/log_item_pin
 
 echo "Unmount filesystem on flakey device"
-_unmount_flakey
+_scratch_unmount
 
 echo "Clean up flakey device"
 _cleanup_flakey
-- 
2.47.3


