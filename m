Return-Path: <linux-ext4+bounces-12329-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB2CB842F
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47B7030974B9
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421130FC15;
	Fri, 12 Dec 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VFdkGOqW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DD30F7E3;
	Fri, 12 Dec 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527805; cv=none; b=oOVHPv8UkS4kK03xMO5t8I5LoQY7Ay7AsLcX0Rs6pyU4oz8X6IpKb/iMCQkl9MEjErCU7JauC+oTNv2DVEC87unVTQ/4IAeYYU6iOQOrLk9u8833Wg9h/R1OEW0SZ3UcBi6unL37a718fsRCLEZMZflXJHXl2ZWsvkSOuvuy8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527805; c=relaxed/simple;
	bh=aGiamXkn1VF0z2lGTZ3ubs0hl83g4dJpt6xBwhMGWW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt8t4YVH0TzcySKhy5gy5v6ao7Kqr2YOrqxiWOeav4jKNZow6Q+Nsu5FtdDTG3tcFzxwW7kCukV4bDwYZurkYnZ01PDGtlkWMny+mANn0R9PbpmY/liY8IMKFP12lVUTzFplY+Rblt9KXeP+btLmAu9PNb+33V441SX4DC6gzJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VFdkGOqW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=elD0+ujFEGaCtAGB28tzo6uCe9uXllSkts/kMeVnkX0=; b=VFdkGOqWCQZ2itXGtmhsgJaQrg
	GUBahu7wmxG/XrAyRkhRoB/Gkim1WsWPsxOSmwPWEa7EOe8+RfNhKkFk69wi+SHrcA+0uyza1HYUN
	1ob0sfjsxaTVcwqfxBTf58y7fEFsHzT3o+2AFhXGAC3DXBO3jYFoNxgcd9DYKh8mB0ohrZWsFM2sw
	hoYCyXxqX1KYDC337YO7y73bM7IQb/jpAuI1By/FOhdl9hEEDwambwOWXWcUw9wDIVmEh5+pCDgWj
	zf7Q6XN/8FTHonW2w8SNDGJnn5neQQKiR4vo/CYDydJ5Y8X+/kpJdRJT94N2jHgQm9pCoEPA0FPdb
	49a4MD2w==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyQs-00000000GGL-46NW;
	Fri, 12 Dec 2025 08:23:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 13/13] xfs/650: require a real SCRATCH_RTDEV
Date: Fri, 12 Dec 2025 09:22:01 +0100
Message-ID: <20251212082210.23401-14-hch@lst.de>
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

Require a real SCRATCH_RTDEV instead of faking one up using a loop
device, as otherwise the options specified in MKFS_OPTIONS might
not actually work the configuration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/xfs/650 | 63 +++++----------------------------------------------
 1 file changed, 6 insertions(+), 57 deletions(-)

diff --git a/tests/xfs/650 b/tests/xfs/650
index d8f70539665f..418a1e7aae7c 100755
--- a/tests/xfs/650
+++ b/tests/xfs/650
@@ -9,21 +9,11 @@
 # bunmapi"). On XFS without the fixes, truncate will hang forever.
 #
 . ./common/preamble
-_begin_fstest auto prealloc preallocrw
-
-# Override the default cleanup function.
-_cleanup()
-{
-	_scratch_unmount &>/dev/null
-	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
-	cd /
-	rm -f $tmp.*
-	rm -f "$TEST_DIR/$seq"
-}
+_begin_fstest auto prealloc preallocrw realtime
 
 . ./common/filter
 
-_require_scratch_nocheck
+_require_realtime
 _require_xfs_io_command "falloc"
 
 maxextlen=$((0x1fffff))
@@ -31,51 +21,11 @@ bs=4096
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
-# Set up the realtime device to reproduce the bug.
+_scratch_mkfs \
+	-d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1 \
+	-r extsize=$((bs * rextsize)) \
+	>>$seqres.full 2>&1
 
-# If we don't have a realtime device, set up a loop device on the test
-# filesystem.
-if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
-	_require_test
-	loopsz="$((filesz + (1 << 26)))"
-	_require_fs_space "$TEST_DIR" $((loopsz / 1024))
-	$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
-	loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
-	USE_EXTERNAL=yes
-	SCRATCH_RTDEV="$loop_dev"
-	disabled_features=()
-
-	# disable reflink if not supported by realtime devices
-	must_disable_feature reflink &&
-		disabled_features=(-m reflink=0)
-
-	# disable rmap if not supported by realtime devices
-	must_disable_feature rmapbt &&
-		disabled_features+=(-m rmapbt=0)
-fi
-extra_options="$extra_options -r extsize=$((bs * rextsize))"
-extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
-
-_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
-_try_scratch_mount >>$seqres.full 2>&1 || \
-	_notrun "mount failed, kernel doesn't support realtime?"
-_scratch_unmount
 _scratch_mount
 _require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
 
@@ -108,7 +58,6 @@ $XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
 # Truncate the extents.
 $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
 
-# We need to do this before the loop device gets torn down.
 _scratch_unmount
 _check_scratch_fs
 
-- 
2.47.3


