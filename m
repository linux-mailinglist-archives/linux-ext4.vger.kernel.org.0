Return-Path: <linux-ext4+bounces-12271-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2CCB3E5A
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBDE63011186
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38931B823;
	Wed, 10 Dec 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aV4loHvY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC3254AE1;
	Wed, 10 Dec 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396342; cv=none; b=OoCwpn9N9o9ZHhuhZSgK7b7GFxfaZ5WbGzOE5A83BDbIXGeH4Uq09TuB/oH80+vjRywzCz8hmj4O+pGf9eLS5DsymyFauEGrJiNksuvKfHLMYEqdusVjsbRIqGuGSgTqpf+BUdNCeK4S9pDR/dhBN/eRjXJgwWXYS7XUtn3gQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396342; c=relaxed/simple;
	bh=+fC2nq4n2OSw8RFY8jBE9Uw3cgMdagWyVC6oouAY0kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbrlk+eHirdy1Xezl20E1dn3SQ64+z0h9NaWSiJUp2t7FGZxOHodXLggah6V1MWe+uHmoDQBX+WLn/0gttHBqud2ePHu5Y+J+ZuK2ORa58TdIJ3N8sGuyjIDSSsuxdr7Vmpvb6uawbPuoaLChJX5ceUNg90ujYbox5CO/cdVI4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aV4loHvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD6DC4CEF1;
	Wed, 10 Dec 2025 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765396340;
	bh=+fC2nq4n2OSw8RFY8jBE9Uw3cgMdagWyVC6oouAY0kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aV4loHvYfe2Mb75E1axBMxhoiC2SBIOMW5wVPAGlRspVq7/O6h8rUjsccnXqAWwYv
	 LEa07VaYGV1CG4N2kgALJbx/EJKp6/OmWEzWn/P2SOKto4BkhFGPwusbALRyahiXMc
	 werW5kRovk+AOpXbfSm867P8QNsmWQ90DTEdSxYU4cokXMGU0BT/SERg134rofiB9C
	 OLqbJwAdEkTPDuKStO1G9rI1qN4ivM0flC1efzfVo2Ju6yg203vtjF7Ot/VQILzttm
	 fIqovQDSjlpWpOQx6ja8rihf5Hax2ZMg9T+uGg2wJubM44O61OY68Dic1x4rEcLcDA
	 CiWuI1YxOUMBw==
Date: Wed, 10 Dec 2025 11:52:20 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 10/12] xfs/528: require a real SCRATCH_RTDEV
Message-ID: <20251210195220.GD94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-11-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:56AM +0100, Christoph Hellwig wrote:
> Require a real SCRATCH_RTDEV instead of faking one up using a loop
> device, as otherwise the options specified in MKFS_OPTIONS might
> not actually work the configuration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/528     | 34 ++++------------------------------
>  tests/xfs/528.out |  2 --
>  2 files changed, 4 insertions(+), 32 deletions(-)
> 
> diff --git a/tests/xfs/528 b/tests/xfs/528
> index a1efbbd27b96..c83545e959dc 100755
> --- a/tests/xfs/528
> +++ b/tests/xfs/528
> @@ -10,27 +10,16 @@
>  . ./common/preamble
>  _begin_fstest auto quick insert zero collapse punch rw realtime
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
>  
> -_require_loop
>  _require_command "$FILEFRAG_PROG" filefrag
>  _require_xfs_io_command "fpunch"
>  _require_xfs_io_command "fzero"
>  _require_xfs_io_command "fcollapse"
>  _require_xfs_io_command "finsert"
> -# Note that we don't _require_realtime because we synthesize a rt volume
> -# below.  This also means we cannot run the post-test check.
> -_require_scratch_nocheck
> +
> +_require_realtime
> +_require_scratch
>  
>  log() {
>  	echo "$@" | tee -a $seqres.full
> @@ -63,7 +52,6 @@ test_ops() {
>  	local lunaligned_off=$unaligned_sz
>  
>  	log "Format rtextsize=$rextsize"
> -	_scratch_unmount
>  	_scratch_mkfs -r extsize=$rextsize >> $seqres.full
>  	_try_scratch_mount || \
>  		_notrun "Could not mount rextsize=$rextsize with synthetic rt volume"
> @@ -150,30 +138,16 @@ test_ops() {
>  	check_file $SCRATCH_MNT/lpunch
>  
>  	log "Check everything, rextsize=$rextsize"
> +	_scratch_unmount
>  	_check_scratch_fs

Why does _scratch_unmount move to this part of the loop?  Unmounting the
filesystem means that _check_xfs_filesystem won't run xfs_scrub on it.

(Everything else looks ok.)

--D

>  }
>  
> -echo "Create fake rt volume"
> -$XFS_IO_PROG -f -c "truncate 400m" $TEST_DIR/$seq.rtvol
> -rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
> -
> -echo "Make sure synth rt volume works"
> -export USE_EXTERNAL=yes
> -export SCRATCH_RTDEV=$rt_loop_dev
> -_scratch_mkfs > $seqres.full
> -_try_scratch_mount || \
> -	_notrun "Could not mount with synthetic rt volume"
> -
>  # power of two
>  test_ops 262144
>  
>  # not a power of two
>  test_ops 327680
>  
> -_scratch_unmount
> -_destroy_loop_device $rt_loop_dev
> -unset rt_loop_dev
> -
>  # success, all done
>  status=0
>  exit
> diff --git a/tests/xfs/528.out b/tests/xfs/528.out
> index 0e081706618c..08de4c28b16c 100644
> --- a/tests/xfs/528.out
> +++ b/tests/xfs/528.out
> @@ -1,6 +1,4 @@
>  QA output created by 528
> -Create fake rt volume
> -Make sure synth rt volume works
>  Format rtextsize=262144
>  Test regular write, rextsize=262144
>  2dce060217cb2293dde96f7fdb3b9232  SCRATCH_MNT/write
> -- 
> 2.47.3
> 
> 

