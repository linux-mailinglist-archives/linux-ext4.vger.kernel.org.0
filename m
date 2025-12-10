Return-Path: <linux-ext4+bounces-12269-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C26CB3E41
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 645203040678
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD1281368;
	Wed, 10 Dec 2025 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X81pDzPi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5DA2820A0;
	Wed, 10 Dec 2025 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395951; cv=none; b=LFiO7MZBK/p3YIYo/LsN6uHZbcHi5axrQ6rOyYgeTuhqe0CGmh2PTnRlxElkPh3fv5eljHNjKlbEt9DwY0MCGWsH/ZFJmcYAq5D9tao9AbQFKbRL3Fre6axGt15ZG+4658h4xCeUUT7gtzebpzi/tPhwMafrebFdLHX/ZzJoHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395951; c=relaxed/simple;
	bh=HMrWyN5j3KqCl/wYQe6z1NNzYL/tUB9E0B4j2iRh44E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoaClmfcJwgfqzmiAtWNS02mD8C5m3Fn0q4v6cof1oTvJ/mGY+MS3w5CK7Oc0w7dlACSqNos4xo0oHiOBa750v7UbnM7Xu2FhVkTc30CvapxXLH2RUIPRvnMStyAmRwfAQbfaPof+IjXNYQhOVU2C7croT2oq3dD+67DvdXrSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X81pDzPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879D8C4CEF1;
	Wed, 10 Dec 2025 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765395950;
	bh=HMrWyN5j3KqCl/wYQe6z1NNzYL/tUB9E0B4j2iRh44E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X81pDzPiAnhHi2wGHSDAoTF4NnbDDsK6hx6iJtfy++vcVLzq+gEpf8jFoWA7sc6S/
	 0WmG7Tx1oZ6XMNcCy+91rz2vqPgQL+MzeHx5/1bSUtxKiDGwORrY0SwFPcbGYa2ZSl
	 g6YyDUdX915LuSDc9uI61kj4Y6vMh7prT1tYbtWfN1O1mEQFcgBrQqDPjNbPF4bH7O
	 rC7shc2i2s2UzcZ+aZiOHSrbQTM1HBLCLayRCRI7lgwhkmPpoLJR6Pkz6w7Phoy1kE
	 aDq7sz+QfSmeFYF0qfbQLHWdyQwT/qg/YT7u7IitkMcqm8rzRcBVyByFpGTsXmx//N
	 GKErNBMmkQQeA==
Date: Wed, 10 Dec 2025 11:45:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/12] xfs/650:  require a real SCRATCH_RTDEV
Message-ID: <20251210194549.GB94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-13-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:58AM +0100, Christoph Hellwig wrote:
> Require a real SCRATCH_RTDEV instead of faking one up using a loop
> device, as otherwise the options specified in MKFS_OPTIONS might
> not actually work the configuration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/650 | 63 +++++----------------------------------------------

Er... what test is xfs/650?  There isn't one in for-next.

--D

>  1 file changed, 6 insertions(+), 57 deletions(-)
> 
> diff --git a/tests/xfs/650 b/tests/xfs/650
> index d8f70539665f..418a1e7aae7c 100755
> --- a/tests/xfs/650
> +++ b/tests/xfs/650
> @@ -9,21 +9,11 @@
>  # bunmapi"). On XFS without the fixes, truncate will hang forever.
>  #
>  . ./common/preamble
> -_begin_fstest auto prealloc preallocrw
> -
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	_scratch_unmount &>/dev/null
> -	[ -n "$loop_dev" ] && _destroy_loop_device $loop_dev
> -	cd /
> -	rm -f $tmp.*
> -	rm -f "$TEST_DIR/$seq"
> -}
> +_begin_fstest auto prealloc preallocrw realtime
>  
>  . ./common/filter
>  
> -_require_scratch_nocheck
> +_require_realtime
>  _require_xfs_io_command "falloc"
>  
>  maxextlen=$((0x1fffff))
> @@ -31,51 +21,11 @@ bs=4096
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
> -# Set up the realtime device to reproduce the bug.
> +_scratch_mkfs \
> +	-d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1 \
> +	-r extsize=$((bs * rextsize)) \
> +	>>$seqres.full 2>&1
>  
> -# If we don't have a realtime device, set up a loop device on the test
> -# filesystem.
> -if [[ $USE_EXTERNAL != yes || -z $SCRATCH_RTDEV ]]; then
> -	_require_test
> -	loopsz="$((filesz + (1 << 26)))"
> -	_require_fs_space "$TEST_DIR" $((loopsz / 1024))
> -	$XFS_IO_PROG -c "truncate $loopsz" -f "$TEST_DIR/$seq"
> -	loop_dev="$(_create_loop_device "$TEST_DIR/$seq")"
> -	USE_EXTERNAL=yes
> -	SCRATCH_RTDEV="$loop_dev"
> -	disabled_features=()
> -
> -	# disable reflink if not supported by realtime devices
> -	must_disable_feature reflink &&
> -		disabled_features=(-m reflink=0)
> -
> -	# disable rmap if not supported by realtime devices
> -	must_disable_feature rmapbt &&
> -		disabled_features+=(-m rmapbt=0)
> -fi
> -extra_options="$extra_options -r extsize=$((bs * rextsize))"
> -extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
> -
> -_scratch_mkfs $extra_options "${disabled_features[@]}" >>$seqres.full 2>&1
> -_try_scratch_mount >>$seqres.full 2>&1 || \
> -	_notrun "mount failed, kernel doesn't support realtime?"
> -_scratch_unmount
>  _scratch_mount
>  _require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
>  
> @@ -108,7 +58,6 @@ $XFS_IO_PROG -c "pwrite -b 1M -W 0 $(((maxextlen + 2 - rextsize) * bs))" \
>  # Truncate the extents.
>  $XFS_IO_PROG -c "truncate 0" -c fsync "$SCRATCH_MNT/file"
>  
> -# We need to do this before the loop device gets torn down.
>  _scratch_unmount
>  _check_scratch_fs
>  
> -- 
> 2.47.3
> 
> 

