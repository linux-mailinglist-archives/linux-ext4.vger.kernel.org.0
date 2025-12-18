Return-Path: <linux-ext4+bounces-12423-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10ECCAABA
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB75C3074CC6
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA62DA76F;
	Thu, 18 Dec 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PoOIZ/Vm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3842DF14C;
	Thu, 18 Dec 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043042; cv=none; b=APgFGWeee8ue2uQ8MGmsUgiQngqolxuA67AvSbomNktIdq5l0BYRFzO3ejkgkolNzPa9RLnA/2Zbm2IJSiQW3SuOpPLcvJFm4K5vin02kHl3Y1DAklLBdQvh1nuYTuYU5Elds9QGRA9rGmah0zuTrxJ5ZEmsS2Y06/8cQAf9aCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043042; c=relaxed/simple;
	bh=mFRHoIdiZzl73dKwuI9GWOGFLPGd8b729xwXGX1A5qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OASpoa4RZDrBT7IvqPgm2RU93+OguXwvqao4SCMPOESUelRa7A9s2xoVSY3Y/ggUCifzIta7YXeuUccBG9+ZK1j/2lYZjNma/o5cHcbowqsTvSaq22umWkUBQZKPEEYOZbLRZSojLUzVXxytOg/rWIj3n0TfHTCsQwOCiLS0WAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PoOIZ/Vm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=E0k7YpKofQ1Thh43MYjbNuPIoBMAlRLwtokCrX5QasA=; b=PoOIZ/VmsVM7C5hSjMsUGCVw+Q
	/ksbtK/Jz7rSQTcy9H8159/YPK+HrbZiJHUgg5t58XN/+vW9d6uEkEDu7DDp3VEvQ9pNmGkb4FLBQ
	AsvN5+eVzQdF2kfZleuCcETXOQ8fdtYNXd8v9plA1lSvfhIai5oY7lBYZELed/8LnWGNiF1RaruGP
	6diWBg/vChWeectpInie5Ryg1ZxeKL82zcaT0C8Dmzu2tcAI+9uCyVp9Wy0vJsqAoIS7I1G/pPa8T
	uPtbDpJNvGPEUDuVrAWTxgpz/Lp/AU3MiJxN1iBeFvbuAogXE0SoZYpCjpLPRSM5MwyCc/R92U0P3
	itualx3w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8T9-00000007xZ8-084j;
	Thu, 18 Dec 2025 07:30:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 03/13] common: add a _check_dev_fs helper
Date: Thu, 18 Dec 2025 08:30:01 +0100
Message-ID: <20251218073023.1547648-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218073023.1547648-1-hch@lst.de>
References: <20251218073023.1547648-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to run the file system checker for a given device, and stop
overloading _check_scratch_fs with the optional device argument that
creates complication around scratch RT and log devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/dmthin     |  6 +++++-
 common/rc         | 21 +++++++++++++++++----
 tests/btrfs/176   |  4 ++--
 tests/generic/648 |  2 +-
 tests/xfs/601     |  2 +-
 5 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/common/dmthin b/common/dmthin
index a1e1fb8763c0..3bea828d0375 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -33,7 +33,11 @@ _dmthin_cleanup()
 _dmthin_check_fs()
 {
 	_unmount $SCRATCH_MNT > /dev/null 2>&1
-	_check_scratch_fs $DMTHIN_VOL_DEV
+	OLD_SCRATCH_DEV=$SCRATCH_DEV
+	SCRATCH_DEV=$DMTHIN_VOL_DEV
+	_check_scratch_fs
+	SCRATCH_DEV=$OLD_SCRATCH_DEV
+	unset OLD_SCRATCH_DEV
 }
 
 # Set up a dm-thin device on $SCRATCH_DEV
diff --git a/common/rc b/common/rc
index c3cdc220a29b..8618f77a00b5 100644
--- a/common/rc
+++ b/common/rc
@@ -3692,14 +3692,14 @@ _check_test_fs()
     esac
 }
 
-_check_scratch_fs()
+# check the file system passed in as $1
+_check_dev_fs()
 {
-    local device=$SCRATCH_DEV
-    [ $# -eq 1 ] && device=$1
+    local device=$1
 
     case $FSTYP in
     xfs)
-	_check_xfs_scratch_fs $device
+	_check_xfs_filesystem $device "none" "none"
 	;;
     udf)
 	_check_udf_filesystem $device $udf_fsize
@@ -3751,6 +3751,19 @@ _check_scratch_fs()
     esac
 }
 
+# check the scratch file system
+_check_scratch_fs()
+{
+	case $FSTYP in
+	xfs)
+		_check_xfs_scratch_fs $SCRATCH_DEV
+		;;
+	*)
+		_check_dev_fs $SCRATCH_DEV
+		;;
+	esac
+}
+
 _full_fstyp_details()
 {
      [ -z "$FSTYP" ] && FSTYP=xfs
diff --git a/tests/btrfs/176 b/tests/btrfs/176
index 86796c8814a0..f2619bdd8e44 100755
--- a/tests/btrfs/176
+++ b/tests/btrfs/176
@@ -37,7 +37,7 @@ swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
 # Deleting device 1 should work again after swapoff.
 $BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT"
 _scratch_unmount
-_check_scratch_fs "$scratch_dev2"
+_check_dev_fs "$scratch_dev2"
 
 echo "Replace device"
 _scratch_mkfs >> $seqres.full 2>&1
@@ -55,7 +55,7 @@ swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
 $BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT" \
 	>> $seqres.full
 _scratch_unmount
-_check_scratch_fs "$scratch_dev2"
+_check_dev_fs "$scratch_dev2"
 
 # success, all done
 status=0
diff --git a/tests/generic/648 b/tests/generic/648
index 7473c9d33746..1bba78f062cf 100755
--- a/tests/generic/648
+++ b/tests/generic/648
@@ -133,7 +133,7 @@ if [ -f "$loopimg" ]; then
 		_metadump_dev $DMERROR_DEV $seqres.scratch.final.md
 		echo "final scratch mount failed"
 	fi
-	SCRATCH_RTDEV= SCRATCH_LOGDEV= _check_scratch_fs $loopimg
+	_check_dev_fs $loopimg
 fi
 
 # success, all done; let the test harness check the scratch fs
diff --git a/tests/xfs/601 b/tests/xfs/601
index df382402b958..44911ea389a7 100755
--- a/tests/xfs/601
+++ b/tests/xfs/601
@@ -39,7 +39,7 @@ copy_file=$testdir/copy.img
 
 echo copy
 $XFS_COPY_PROG $SCRATCH_DEV $copy_file >> $seqres.full
-_check_scratch_fs $copy_file
+_check_dev_fs $copy_file
 
 echo recopy
 $XFS_COPY_PROG $copy_file $SCRATCH_DEV >> $seqres.full
-- 
2.47.3


