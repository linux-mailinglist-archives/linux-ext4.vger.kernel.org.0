Return-Path: <linux-ext4+bounces-12338-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820DBCB9BBD
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 21:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1FD7304A8C5
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C44309F1C;
	Fri, 12 Dec 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwVIIMy8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC074265CA6;
	Fri, 12 Dec 2025 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570303; cv=none; b=k4R+wlqbOHlgSWP2L8lgMZU/rhutzKcj+Ebtq4AGkRtU3gbWWXtJKx1NlWNBMe2Yvv0FQXmIiwHcsuHIb0IvD8/r7QS6QNHQZOHJ8wfaQn4PVUK40o3oFTQ/Zbvl5JAC3EibLKbbYYVyrU0AXDz5LMk7il9ohBsKYD2fG3ZWUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570303; c=relaxed/simple;
	bh=+JT48ozqF9ScLI1VbymQxnIPRD2JGzx1/CpA8qAJI0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1tQgWNKWOYE85OuKlKbUnCvimKxgBVACBgBFqJXMxEw33gxkjla/oaxwHtoDCU5aGPBwu0+gbYiiZAd419DFH5xYCnFmr5T9QWJX4E8Svba4BQ0OsObOJlIk13EdVX5eXjAP9G/me0ht/rtvMF85+Hk3NAj2eAJTcmawyEi1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwVIIMy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51136C4CEF1;
	Fri, 12 Dec 2025 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765570303;
	bh=+JT48ozqF9ScLI1VbymQxnIPRD2JGzx1/CpA8qAJI0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwVIIMy87PsdU5v3I0uztKEU5kuPf/b56TJoH5yDQevpPHzi7qbWet4SwIZXzg6Xz
	 FxH0bg2XQ7bwhaxosevHVri0iCQNAchdgf8ZGgEHhLHiibUXlQUvSHnGiwWgOjor7R
	 dN/AEARpzZIhLr95A/i0hm8Y8WD23G5VVfdMFHA28n3yRbZFkELmWX6m3YSgnjU2HY
	 PC8swRNN5OJQbbMlmoCjqTBRAlWPXK76rnlIiUqDyC0dqZ078I+u9ujI7XZZb28Qmc
	 13puJVL6yfifSwdx9oqGR638YxuUGJ3GHS17Poi3C+wfLXrCmCE/p7ZcLH5zY9ZE/9
	 iceiwbBdCWU4w==
Date: Fri, 12 Dec 2025 12:11:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/13] dmflakey: override SCRATCH_DEV in _init_flakey
Message-ID: <20251212201142.GF7716@frogsfrogsfrogs>
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212082210.23401-2-hch@lst.de>

On Fri, Dec 12, 2025 at 09:21:49AM +0100, Christoph Hellwig wrote:
> _init_flakey already overrides SCRATCH_LOGDEV and SCRATCH_RTDEV so that
> the XFS-specific helpers work fine with external devices.  Do the same
> for SCRATCH_DEV itself, so that _scratch_mount and _scratch_unmount just
> work, and so that _check_scratch_fs does not need to override the main
> device.
> 
> This requires some small adjustments in how generic/741 checks that
> mounting the underlying device fails, but the new version actually is
> simpler than the old one, and in xfs/438 where we need to be careful
> where to create the custome dm table.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
<snip>
> diff --git a/common/dmflakey b/common/dmflakey
> index 7368a3e5b324..cb0359901c16 100644
> --- a/common/dmflakey
> +++ b/common/dmflakey
> @@ -15,11 +15,19 @@ export FLAKEY_LOGNAME="flakey-logtest.$seq"
>  _init_flakey()
>  {
>  	# Scratch device
> -	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> -	export FLAKEY_DEV="/dev/mapper/$FLAKEY_NAME"
> -	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 180 0"
> -	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
> -	FLAKEY_TABLE_ERROR="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 error_writes"
> +	if [ -z "$NON_FLAKEY_DEV" ]; then
> +		# Set up the device switch
> +		local backing_dev="$SCRATCH_DEV"
> +		export NON_FLAKEY_DEV="$SCRATCH_DEV"
> +		SCRATCH_DEV=/dev/mapper/$FLAKEY_NAME
> +	else
> +		# Already set up; recreate tables
> +		local backing_dev="$NON_FLAKEY_DEV"
> +	fi
> +	local BLK_DEV_SIZE=`blockdev --getsz $backing_dev`
> +	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $backing_dev 0 180 0"
> +	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 drop_writes"
> +	FLAKEY_TABLE_ERROR="0 $BLK_DEV_SIZE flakey $backing_dev 0 0 180 1 error_writes"

Ok, so _init_flakey still sets FLAKEY_TABLE_ERROR...

>  	_dmsetup_create $FLAKEY_NAME --table "$FLAKEY_TABLE" || \
>  		_fatal "failed to create flakey device"
>  
<snip>
> diff --git a/tests/xfs/438 b/tests/xfs/438
> index 6d1988c8b9b8..4ff249df6967 100755
> --- a/tests/xfs/438
> +++ b/tests/xfs/438
> @@ -32,7 +32,7 @@ _cleanup()
>  		sysctl -w fs.xfs.xfssyncd_centisecs=${interval} >/dev/null 2>&1
>  	cd /
>  	rm -f $tmp.*
> -	_unmount_flakey >/dev/null 2>&1
> +	_scratch_unmount >/dev/null 2>&1
>  	_cleanup_flakey > /dev/null 2>&1
>  }
>  
> @@ -100,6 +100,9 @@ echo "Silence is golden"
>  
>  _scratch_mkfs > $seqres.full 2>&1
>  
> +# this needs to happen after mkfs, but before _init_flakey overrides SCRATCH_DEV
> +FLAKEY_TABLE_ERROR=$(make_xfs_scratch_flakey_table)
> +
>  # no error will be injected
>  _init_flakey

...but won't _init_flakey clobber the value of FLAKEY_TABLE_ERROR set
by make_xfs_scratch_flakey_table?

--D

>  $DMSETUP_PROG info >> $seqres.full
> @@ -111,7 +114,7 @@ interval=$(sysctl -n fs.xfs.xfssyncd_centisecs 2>/dev/null)
>  sysctl -w fs.xfs.xfssyncd_centisecs=100 >> $seqres.full 2>&1
>  
>  _qmount_option "usrquota"
> -_mount_flakey
> +_scratch_mount
>  
>  # We need to set the quota limitation twice, and inject the write error
>  # after the second setting. If we try to inject the write error after
> @@ -127,7 +130,6 @@ xfs_freeze -f $SCRATCH_MNT
>  xfs_freeze -u $SCRATCH_MNT
>  
>  # inject write IO error
> -FLAKEY_TABLE_ERROR=$(make_xfs_scratch_flakey_table)
>  _load_flakey_table ${FLAKEY_ERROR_WRITES}
>  $DMSETUP_PROG info >> $seqres.full
>  $DMSETUP_PROG table >> $seqres.full
> @@ -142,7 +144,7 @@ _scratch_sync
>  # the completion of the retried write of dquota buffer
>  sleep 2
>  
> -_unmount_flakey
> +_scratch_unmount
>  
>  _cleanup_flakey
>  

