Return-Path: <linux-ext4+bounces-12272-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F53CB3E71
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6273E304C5D9
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5964E329C5D;
	Wed, 10 Dec 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgDPAhNd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD22275AFB;
	Wed, 10 Dec 2025 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396469; cv=none; b=OlD7b+jmj2w1e1IXDiwf7FsH93bj02VsFGMk8Qb19QBVnYM1f0NQFzFwPZsyYS4p1IIb+ibrWQYUaRdw6MOC7WaBU9HjX6KeZ3HyHe0BzARQf3uisjyaAmEKSoGPN/YpZTKClyCWDTnDMR+q+sX20z7KbqY2zwXlFZs9XeN4TyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396469; c=relaxed/simple;
	bh=auDZTBcsmk+Sn1FadEIz7fAM6JUqI0MAckr9h/f8UY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trY0vzUbMXnbjjIzrNvd0gorSA6NePx5cXFI2XQB8TKZIzy3dwBGT1EQ3YWhv7ecrbUpF4RU+PkIa2h1soEZt4paIBmz4zsTW8h5wvtFbWKTrwWotkpgDbHViAlksGcxaYCidVvihARbcrTrhFrsllvClTDEnWiXEGhT+6rembw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgDPAhNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611EBC4CEF1;
	Wed, 10 Dec 2025 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765396468;
	bh=auDZTBcsmk+Sn1FadEIz7fAM6JUqI0MAckr9h/f8UY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgDPAhNdRWe30D0g4oXGRlXJvFJKZHUDdZeTuxpasKHRok0tUwaqEJrKrZflohh4C
	 s1t0BeBM4/WdVwj+RtAQ2ACZGJIQ0hE6qIjNgHPE7uMNj2u6EVciHoMCh58xzgUmk4
	 rDoDjpv5c8BmyDQ1j42+xUGGI/DjWZIfArCsmbxpTLgz30vFDPJ8eeHTQrKSau299Y
	 0tE2NBIUXsAvwyaDet9sbsrrjGEj0p4guSh6ntODf2wKyq/y6lNeAPGU0q7dJxTFhC
	 QTlEAzfcrp9dbDxvlnuMS1l5wDKHH6OokRmFxI3aQCMb7HQNU4FAOATpWzHPkCx5iK
	 7PEQT53bCjAAQ==
Date: Wed, 10 Dec 2025 11:54:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/12] xfs/521: require a real SCRATCH_RTDEV
Message-ID: <20251210195427.GE94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-10-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:55AM +0100, Christoph Hellwig wrote:
> Require a real SCRATCH_RTDEV instead of faking one up using a loop
> device, as otherwise the options specified in MKFS_OPTIONS might
> not actually work the configuration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/521     | 33 ++++++++-------------------------
>  tests/xfs/521.out |  1 -
>  2 files changed, 8 insertions(+), 26 deletions(-)
> 
> diff --git a/tests/xfs/521 b/tests/xfs/521
> index 0da05a55a276..5cd6649c50c7 100755
> --- a/tests/xfs/521
> +++ b/tests/xfs/521
> @@ -16,34 +16,16 @@
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
>  
> -# Note that we don't _require_realtime because we synthesize a rt volume
> -# below.
> -_require_scratch_nocheck
> -_require_no_large_scratch_dev
> -
> -echo "Create fake rt volume"
> -truncate -s 400m $TEST_DIR/$seq.rtvol
> -rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
> +_require_realtime
> +_require_scratch
>  
>  echo "Format and mount 100m rt volume"
> -export USE_EXTERNAL=yes
> -export SCRATCH_RTDEV=$rtdev
>  _scratch_mkfs -r size=100m > $seqres.full
> -_try_scratch_mount || _notrun "Could not mount scratch with synthetic rt volume"
> +_scratch_mount
>  
> -# zoned file systems only support zoned size-rounded RT device sizes
> +# zoned file systems only support zone-size aligned RT device sizes
>  _require_xfs_scratch_non_zoned
>  
>  testdir=$SCRATCH_MNT/test-$seq
> @@ -58,7 +40,10 @@ echo "Create some files"
>  _pwrite_byte 0x61 0 1m $testdir/original >> $seqres.full
>  
>  echo "Grow fs"
> -$XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
> +# growfs expects sizes in FSB units
> +fsbsize=$(_get_block_size $SCRATCH_MNT)
> +$XFS_GROWFS_PROG -R $((400 * 1024 * 1024 / fsbsize)) $SCRATCH_MNT 2>&1 | \

Hrmm, I wonder if this test should check that SCRATCH_RTDEV is at least
400m?  But I guess the old code didn't check that the loop file doesn't
ENOSPC (which is another good reason to get rid of the fakery) so...

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	  _filter_growfs >> $seqres.full
>  _scratch_cycle_mount
>  
>  echo "Recheck 400m rt volume stats"
> @@ -73,8 +58,6 @@ echo "Check filesystem"
>  _check_scratch_fs
>  
>  _scratch_unmount
> -_destroy_loop_device $rt_loop_dev
> -unset rt_loop_dev
>  
>  # success, all done
>  status=0
> diff --git a/tests/xfs/521.out b/tests/xfs/521.out
> index 007ab92c6db2..afd18bb0dc99 100644
> --- a/tests/xfs/521.out
> +++ b/tests/xfs/521.out
> @@ -1,5 +1,4 @@
>  QA output created by 521
> -Create fake rt volume
>  Format and mount 100m rt volume
>  Check rt volume stats
>  Create some files
> -- 
> 2.47.3
> 
> 

