Return-Path: <linux-ext4+bounces-12270-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F442CB3E50
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E608308279F
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629D32693E;
	Wed, 10 Dec 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYa0sdfc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C12EBBA4;
	Wed, 10 Dec 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396190; cv=none; b=EagP+NmY+bGCwHTjUEAW0ymOXeAhdMjTW2mZ4yx3CnRHn5j/HZ0IAGeHC80HHpZONjUZMoW7OQ/3puP79dppShiLLZz3X9PKUATcOBHnS+9YxlX9pjuGjrbvB2F2KiGg+OHND3tEHMeK8TRI2TlTtluo9BRc4iB0KtmzTL4OWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396190; c=relaxed/simple;
	bh=3J5tHNc4atLX0imRlL5dW4N+zi/+hEYpiK04ue4nx3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coPn4v5aCDiHSzD6z+GN0k9EgCcLLcZ6SXbwctRQlgc9saXYVXAMj2Tn1C7Hsl4UEOA+QAi0d+6LAxCowUY7vdU5hPemvK6CxkjAndXZsBTMx5ZxqH+jW1e8X5+m+zw82s4ulUEu4Iv4+05yHYo4FgYMECAh+u4Q9Qg++6MXm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYa0sdfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7612FC4CEF1;
	Wed, 10 Dec 2025 19:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765396189;
	bh=3J5tHNc4atLX0imRlL5dW4N+zi/+hEYpiK04ue4nx3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYa0sdfcv8a1lmxPgprEsSYpr2MP7+MKz8/6EN+eLZDxi6UlKXhkbOqX1jV4gvYZZ
	 dJsG7UGOw/IkKkdFb9TMktTUcPynDWMA8wMnYlR3tNEpNdgJfrfbWwCvy614C1jFWQ
	 lLbx1Le9SxE/V7QiQ64H/Pm8W8k5XkgekxVChpkyuIeY0l9B8p3OffFmNoL/AKz20q
	 Cbuyu8E2IAHM7gOnFODLy9J+en2EaumkdHop7XJpcRHvXBSWfxrHbnnLZxTkE+Snjn
	 OKMEULtmgcAXPqLAtlYsZcn6ApnCl1PZn2/wH7R3SQMpx70xpx0wR/gXOnV2F6pt1h
	 mSOCsDMKen1vA==
Date: Wed, 10 Dec 2025 11:49:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/12] xfs/530: require a real SCRATCH_RTDEV
Message-ID: <20251210194948.GC94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-12-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:57AM +0100, Christoph Hellwig wrote:
> Require a real SCRATCH_RTDEV instead of faking one up using a loop
> device, as otherwise the options specified in MKFS_OPTIONS might
> not actually work the configuration.
> 
> Note that specifying a rtextsize doesn't work for zoned file systems,
> so _notrun when mkfs fails.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/530     | 42 +++++++++++++-----------------------------
>  tests/xfs/530.out |  1 -
>  2 files changed, 13 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/xfs/530 b/tests/xfs/530
> index 4a41127e3b82..ffc9e902e1b7 100755
> --- a/tests/xfs/530
> +++ b/tests/xfs/530
> @@ -10,36 +10,22 @@
>  . ./common/preamble
>  _begin_fstest auto quick realtime growfs
>  
> -# Override the default cleanup function.
> -_cleanup()
> -{
> -	cd /
> -	_scratch_unmount >> $seqres.full 2>&1
> -	[ -n "$rt_loop_dev" ] && _destroy_loop_device $rt_loop_dev
> -	rm -f $tmp.* $TEST_DIR/$seq.rtvol
> -}
> -
> -# Import common functions.
>  . ./common/filter
>  . ./common/inject
>  . ./common/populate
>  
> -
> -# Note that we don't _require_realtime because we synthesize a rt volume
> -# below.
> -_require_test
> +_require_scratch
> +_require_realtime
>  _require_xfs_debug
>  _require_test_program "punch-alternating"
>  _require_xfs_io_error_injection "reduce_max_iextents"
>  _require_xfs_io_error_injection "bmap_alloc_minlen_extent"
> -_require_scratch_nocheck
>  
>  echo "* Test extending rt inodes"
>  
>  _scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
>  . $tmp.mkfs
>  
> -echo "Create fake rt volume"
>  nr_bitmap_blks=25
>  nr_bits=$((nr_bitmap_blks * dbsize * 8))
>  
> @@ -50,17 +36,12 @@ else
>  	rtextsz=$dbsize
>  fi
>  
> -rtdevsz=$((nr_bits * rtextsz))
> -truncate -s $rtdevsz $TEST_DIR/$seq.rtvol
> -rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
> -
>  echo "Format and mount rt volume"
> -
> -export USE_EXTERNAL=yes
> -export SCRATCH_RTDEV=$rt_loop_dev
> -_scratch_mkfs -d size=$((1024 * 1024 * 1024)) \
> -	      -r size=${rtextsz},extsize=${rtextsz} >> $seqres.full
> -_try_scratch_mount || _notrun "Couldn't mount fs with synthetic rt volume"
> +_try_scratch_mkfs_xfs \
> +	-d size=$((1024 * 1024 * 1024)) \
> +	-r size=${rtextsz},extsize=${rtextsz} >> $seqres.full 2>&1 || \
> +	_notrun "Couldn't created crafted fs (zoned?)"
> +_try_scratch_mount || _notrun "Couldn't mount crafted fs"
>  
>  # If we didn't get the desired realtime volume and the same blocksize as the
>  # first format (which we used to compute a specific rt geometry), skip the
> @@ -92,7 +73,12 @@ echo "Inject bmap_alloc_minlen_extent error tag"
>  _scratch_inject_error bmap_alloc_minlen_extent 1
>  
>  echo "Grow realtime volume"
> -$XFS_GROWFS_PROG -r $SCRATCH_MNT >> $seqres.full 2>&1
> +# growfs expects sizes in FSB units
> +fsbsize=$(_get_block_size $SCRATCH_MNT)
> +rtdevsz=$((nr_bits * rtextsz))
> +
> +$XFS_GROWFS_PROG -R $((rtdevsize / fsbsize)) $SCRATCH_MNT \

Why doesn't growfs -r still work here?

--D

> +	>> $seqres.full 2>&1
>  if [[ $? == 0 ]]; then
>  	echo "Growfs succeeded; should have failed."
>  	exit 1
> @@ -115,8 +101,6 @@ echo "Check filesystem"
>  _check_scratch_fs
>  
>  _scratch_unmount &> /dev/null
> -_destroy_loop_device $rt_loop_dev
> -unset rt_loop_dev
>  
>  # success, all done
>  status=0
> diff --git a/tests/xfs/530.out b/tests/xfs/530.out
> index 6ddb572f9435..3c508b4564f7 100644
> --- a/tests/xfs/530.out
> +++ b/tests/xfs/530.out
> @@ -1,6 +1,5 @@
>  QA output created by 530
>  * Test extending rt inodes
> -Create fake rt volume
>  Format and mount rt volume
>  Consume free space
>  Create fragmented filesystem
> -- 
> 2.47.3
> 
> 

