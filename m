Return-Path: <linux-ext4+bounces-12277-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB5CB42E6
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 23:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DACB300E3ED
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 22:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E262DC767;
	Wed, 10 Dec 2025 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcL6AisX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4326B2AD;
	Wed, 10 Dec 2025 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765407101; cv=none; b=MxKDk5yqB1pAOv5z+HCPHNkegVJvDzV6sR0H8+4LUtu7Z/K2PeGRYmTctiziwwSMnxkZU4UN2BWtw0ZlxfsMmN25D2Xr78xouY0eNTb4Cur4MpViJANtXfnQ3qs3DsV8u1ryGSqHabhaOSJuWPqOl3A5s/ltBncHstmlRCsZmdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765407101; c=relaxed/simple;
	bh=6+OTmDA56r3rOvPdzz6DwIpQPdzycSjWoPU2qFHwzm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn1G0ogxJWbOoLUgBuJYHV3/VpHISkwjg7fvKILIIlojQuhkNLEdeNA2W8OXN6fcqlpOv/APCOHt2SHGQIYXWayPm1LyopGWn177H7A26lXB71nLQYpkmh/YJk5NW+O2jNlhe7PZntKaS5EPb8nt6dFgvIjNJM+l7anGw7zE6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcL6AisX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E2BC4CEF1;
	Wed, 10 Dec 2025 22:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407100;
	bh=6+OTmDA56r3rOvPdzz6DwIpQPdzycSjWoPU2qFHwzm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcL6AisX1nfLdjmBXsiFhauCPqw7IP/l+Wno+opOqhHWrkIC0/lcJAlplh1ohpS9m
	 LFKHOFN6PwMgSmdWOlYfTv8899U2SeWyVE7Y1GIqv/ghiqVWI67F9BUX0VrQpK97Io
	 JKa3khXJ26z1BiR6DEiXGV0r5aP5hhCDERXqVV6ho/qX97vml/j9LN5gAsjYxEyZpd
	 6dFVMXCNq03e73jbCSWpUrIJKYG21PvMVnTcXcGsqxPm5W+q2bU6QqaWoUFSAR34Uz
	 Bg3vmAFUuuSeX65VyT7k1EWpSjoBNxwrP6bUcgbhgDhvRZoH0WQHQEJgN88HGOcskH
	 VYijlLtWZYZRA==
Date: Wed, 10 Dec 2025 14:51:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 05/12] generic/590: split XFS RT specific bits out
Message-ID: <20251210225139.GJ94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-6-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:51AM +0100, Christoph Hellwig wrote:
> Currently generic/590 runs a very different test on XFS that creates
> a lot device and so on.  Split that out into a new XFS-specific test,
> and let generic/590 always run using the file system parameter specified
> in the config even for XFS.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, that sounds like a good idea.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/590 |  68 ++-------------------------
>  tests/xfs/650     | 117 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/650.out |   2 +
>  3 files changed, 123 insertions(+), 64 deletions(-)
>  create mode 100755 tests/xfs/650
>  create mode 100644 tests/xfs/650.out
> 
> diff --git a/tests/generic/590 b/tests/generic/590
> index ba1337a856f1..54c26f2ae5ed 100755
> --- a/tests/generic/590
> +++ b/tests/generic/590
> @@ -4,27 +4,15 @@
>  #
>  # FS QA Test 590
>  #
> -# Test commit 0c4da70c83d4 ("xfs: fix realtime file data space leak") and
> -# 69ffe5960df1 ("xfs: don't check for AG deadlock for realtime files in
> -# bunmapi"). On XFS without the fixes, truncate will hang forever. On other
> -# filesystems, this just tests writing into big fallocates.
> +# Tests writing into big fallocates.
> +#
> +# Based on an XFS RT subvolume specific test now split into xfs/650.
>  #
>  . ./common/preamble
>  _begin_fstest auto prealloc preallocrw
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	_scratch_unmount &>/dev/null
> -	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
> -	cd /
> -	rm -f $tmp.*
> -	rm -f "$TEST_DIR/$seq"
> -}
> -
>  . ./common/filter
>  
> -_require_scratch_nocheck
>  _require_xfs_io_command "falloc"
>  
>  maxextlen=$((0x1fffff))
> @@ -32,54 +20,7 @@ bs=4096
>  rextsize=4
>  filesz=$(((maxextlen + 1) * bs))
>  
> -must_disable_feature() {
> -	local feat="$1"
> -
> -	# If mkfs doesn't know about the feature, we don't need to disable it
> -	$MKFS_XFS_PROG --help 2>&1 | grep -q "${feat}=0" || return 1
> -
> -	# If turning the feature on works, we don't need to disable it
> -	_scratch_mkfs_xfs_supported -m "${feat}=1" "${disabled_features[@]}" \
> -		> /dev/null 2>&1 && return 1
> -
> -	# Otherwise mkfs knows of the feature and formatting with it failed,
> -	# so we do need to mask it.
> -	return 0
> -}
> -
> -extra_options=""
> -# If we're testing XFS, set up the realtime device to reproduce the bug.
> -if [[ $FSTYP = xfs ]]; then
> -	# If we don't have a realtime device, set up a loop device on the test
> -	# filesystem.
> -	if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
> -		_require_test
> -		loopsz="$((filesz + (1 << 26)))"
> -		_require_fs_space "$TEST_DIR" $((loopsz / 1024))
> -		$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
> -		loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
> -		USE_EXTERNAL=yes
> -		SCRATCH_RTDEV="$loop_dev"
> -		disabled_features=()
> -
> -		# disable reflink if not supported by realtime devices
> -		must_disable_feature reflink &&
> -			disabled_features=(-m reflink=0)
> -
> -		# disable rmap if not supported by realtime devices
> -		must_disable_feature rmapbt &&
> -			disabled_features+=(-m rmapbt=0)
> -	fi
> -	extra_options="$extra_options -r extsize=$((bs * rextsize))"
> -	extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
> -
> -	_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
> -	_try_scratch_mount >>$seqres.full 2>&1 || \
> -		_notrun "mount failed, kernel doesn't support realtime?"
> -	_scratch_unmount
> -else
> -	_scratch_mkfs $extra_options >>$seqres.full 2>&1
> -fi
> +_scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
>  _require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
>  
> @@ -112,7 +53,6 @@ $XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
>  # Truncate the extents.
>  $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
>  
> -# We need to do this before the loop device gets torn down.
>  _scratch_unmount
>  _check_scratch_fs
>  
> diff --git a/tests/xfs/650 b/tests/xfs/650
> new file mode 100755
> index 000000000000..d8f70539665f
> --- /dev/null
> +++ b/tests/xfs/650
> @@ -0,0 +1,117 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 650
> +#
> +# Test commit 0c4da70c83d4 ("xfs: fix realtime file data space leak") and
> +# 69ffe5960df1 ("xfs: don't check for AG deadlock for realtime files in
> +# bunmapi"). On XFS without the fixes, truncate will hang forever.
> +#
> +. ./common/preamble
> +_begin_fstest auto prealloc preallocrw
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_scratch_unmount &>/dev/null
> +	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
> +	cd /
> +	rm -f $tmp.*
> +	rm -f "$TEST_DIR/$seq"
> +}
> +
> +. ./common/filter
> +
> +_require_scratch_nocheck
> +_require_xfs_io_command "falloc"
> +
> +maxextlen=$((0x1fffff))
> +bs=4096
> +rextsize=4
> +filesz=$(((maxextlen + 1) * bs))
> +
> +must_disable_feature() {
> +	local feat="$1"
> +
> +	# If mkfs doesn't know about the feature, we don't need to disable it
> +	$MKFS_XFS_PROG --help 2>&1 | grep -q "${feat}=0" || return 1
> +
> +	# If turning the feature on works, we don't need to disable it
> +	_scratch_mkfs_xfs_supported -m "${feat}=1" "${disabled_features[@]}" \
> +		> /dev/null 2>&1 && return 1
> +
> +	# Otherwise mkfs knows of the feature and formatting with it failed,
> +	# so we do need to mask it.
> +	return 0
> +}
> +
> +extra_options=""
> +# Set up the realtime device to reproduce the bug.
> +
> +# If we don't have a realtime device, set up a loop device on the test
> +# filesystem.
> +if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
> +	_require_test
> +	loopsz="$((filesz + (1 << 26)))"
> +	_require_fs_space "$TEST_DIR" $((loopsz / 1024))
> +	$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
> +	loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
> +	USE_EXTERNAL=yes
> +	SCRATCH_RTDEV="$loop_dev"
> +	disabled_features=()
> +
> +	# disable reflink if not supported by realtime devices
> +	must_disable_feature reflink &&
> +		disabled_features=(-m reflink=0)
> +
> +	# disable rmap if not supported by realtime devices
> +	must_disable_feature rmapbt &&
> +		disabled_features+=(-m rmapbt=0)
> +fi
> +extra_options="$extra_options -r extsize=$((bs * rextsize))"
> +extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
> +
> +_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
> +_try_scratch_mount >>$seqres.full 2>&1 || \
> +	_notrun "mount failed, kernel doesn't support realtime?"
> +_scratch_unmount
> +_scratch_mount
> +_require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
> +
> +# Allocate maxextlen + 1 blocks. As long as the allocator does something sane,
> +# we should end up with two extents that look something like:
> +#
> +# u3.bmx[0-1] = [startoff,startblock,blockcount,extentflag]
> +# 0:[0,0,2097148,1]
> +# 1:[2097148,2097148,4,1]
> +#
> +# Extent 0 has blockcount = ALIGN_DOWN(maxextlen, rextsize). Extent 1 is
> +# adjacent and has blockcount = rextsize. Both are unwritten.
> +$XFS_IO_PROG -c "falloc 0 $filesz" -c fsync -f "$SCRATCH_MNT/file"
> +
> +# Write extent 0 + one block of extent 1. Our extents should end up like so:
> +#
> +# u3.bmx[0-1] = [startoff,startblock,blockcount,extentflag]
> +# 0:[0,0,2097149,0]
> +# 1:[2097149,2097149,3,1]
> +#
> +# Extent 0 is written and has blockcount = ALIGN_DOWN(maxextlen, rextsize) + 1,
> +# Extent 1 is adjacent, unwritten, and has blockcount = rextsize - 1 and
> +# startblock % rextsize = 1.
> +#
> +# The -b is just to speed things up (doing GBs of I/O in 4k chunks kind of
> +# sucks).
> +$XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
> +	"$SCRATCH_MNT/file" >> "$seqres.full"
> +
> +# Truncate the extents.
> +$XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
> +
> +# We need to do this before the loop device gets torn down.
> +_scratch_unmount
> +_check_scratch_fs
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/xfs/650.out b/tests/xfs/650.out
> new file mode 100644
> index 000000000000..d7a3e4b63483
> --- /dev/null
> +++ b/tests/xfs/650.out
> @@ -0,0 +1,2 @@
> +QA output created by 650
> +Silence is golden
> -- 
> 2.47.3
> 
> 

