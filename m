Return-Path: <linux-ext4+bounces-12278-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0A2CB43DE
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 00:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C61C3000951
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 23:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388F02E7F21;
	Wed, 10 Dec 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoYOeOEK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468D238C33;
	Wed, 10 Dec 2025 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765409052; cv=none; b=D+Tkd1k4JjyAGRSAtmaTAxUjej236wIkX7vXG3WZbkDPD1SKr/pGLAr6ra9vjzJRv7YKnf2DXN5yhChiwTqeGnSukWK5c245EkOsgFJLQXM0DFN0N7oMs05wkQYONkIadTTiXNSuDOCcwUKN2yWHjdq3ENmuxCHFH0soU02iUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765409052; c=relaxed/simple;
	bh=IRzzA5g4UURwGrGH+9JVT0ib9uHmYuk4MBIx88nWgss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjrpK0jk8FHKuuBgWXQJU9+09FaqobrUxI8lCdWZ91Ppblu9Zsifdg+GXpnpOrI4U4AVCGnO4380b3PrSjUdy/9cBiSpqwvtXdvst+7s+Z+PVYjfCzN/3T7E2L1BejURT9r1EV5BeZVOdGpf1KdcAdq4yqI28oobnWIjZ9SGx7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoYOeOEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555D6C4CEF1;
	Wed, 10 Dec 2025 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765409051;
	bh=IRzzA5g4UURwGrGH+9JVT0ib9uHmYuk4MBIx88nWgss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoYOeOEKzLJAdZACanlCEFGW1nn3QzMUIoxju82ZHMp/GeLRFnyO0ZORnfMfrzr2q
	 a/62S1hV4gM9JOLxq/+on6RgiESD9Eo5QtpcQ36jQSEUMWmUO/gtxk2Qex3DFp7jUu
	 7sx7fSzkcFy5CwONbavBD03jCmhgjXfMbO8tqRRKDPyiGJFIIE90GhGDQaZVaXAAbz
	 yTJd+MaSRCzF2P1kHd7lt5es6oAa+QzMyF0fv/X3uC/lkCEdShgZcVyZdeXxPuaXPA
	 DjdBAKuyamQCjmx/I8Wr3IAGbZUpdZ58/tynznvHoSj+3Q3T8ZvImTbTaj28QYa/cc
	 vD27EHtCFi99A==
Date: Wed, 10 Dec 2025 15:24:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/12] common: add a _check_dev_fs helper
Message-ID: <20251210232410.GK94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-4-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:49AM +0100, Christoph Hellwig wrote:
> Add a helper to run the file system checker for a given device, and stop
> overloading _check_scratch_fs with the optional device argument that
> creates complication around scratch RT and log devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Note: dmthin should probably do the same as dmflakey does, but all
> my attempts never got the new SCRATCH_DEV value propagated out of
> _dmthin_init.  Maybe someone smarted than me wants to give it another
> try.

One of those dm wrappers has that weird behavior that it has to be
`source'able from a shell invoked by a subprocess.  That's caused me
headaches in the past.

Nevertheless, these changes look ok so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


>  common/dmthin     |  6 +++++-
>  common/rc         | 21 +++++++++++++++++----
>  tests/btrfs/176   |  4 ++--
>  tests/generic/648 |  2 +-
>  tests/xfs/601     |  2 +-
>  5 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/common/dmthin b/common/dmthin
> index a1e1fb8763c0..3bea828d0375 100644
> --- a/common/dmthin
> +++ b/common/dmthin
> @@ -33,7 +33,11 @@ _dmthin_cleanup()
>  _dmthin_check_fs()
>  {
>  	_unmount $SCRATCH_MNT > /dev/null 2>&1
> -	_check_scratch_fs $DMTHIN_VOL_DEV
> +	OLD_SCRATCH_DEV=$SCRATCH_DEV
> +	SCRATCH_DEV=$DMTHIN_VOL_DEV
> +	_check_scratch_fs
> +	SCRATCH_DEV=$OLD_SCRATCH_DEV
> +	unset OLD_SCRATCH_DEV
>  }
>  
>  # Set up a dm-thin device on $SCRATCH_DEV
> diff --git a/common/rc b/common/rc
> index c3cdc220a29b..8618f77a00b5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3692,14 +3692,14 @@ _check_test_fs()
>      esac
>  }
>  
> -_check_scratch_fs()
> +# check the file system passed in as $1
> +_check_dev_fs()
>  {
> -    local device=$SCRATCH_DEV
> -    [ $# -eq 1 ] && device=$1
> +    local device=$1
>  
>      case $FSTYP in
>      xfs)
> -	_check_xfs_scratch_fs $device
> +	_check_xfs_filesystem $device "none" "none"
>  	;;
>      udf)
>  	_check_udf_filesystem $device $udf_fsize
> @@ -3751,6 +3751,19 @@ _check_scratch_fs()
>      esac
>  }
>  
> +# check the scratch file system
> +_check_scratch_fs()
> +{
> +	case $FSTYP in
> +	xfs)
> +		_check_xfs_scratch_fs $SCRATCH_DEV
> +		;;
> +	*)
> +		_check_dev_fs $SCRATCH_DEV
> +		;;
> +	esac
> +}
> +
>  _full_fstyp_details()
>  {
>       [ -z "$FSTYP" ] && FSTYP=xfs
> diff --git a/tests/btrfs/176 b/tests/btrfs/176
> index 86796c8814a0..f2619bdd8e44 100755
> --- a/tests/btrfs/176
> +++ b/tests/btrfs/176
> @@ -37,7 +37,7 @@ swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
>  # Deleting device 1 should work again after swapoff.
>  $BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT"
>  _scratch_unmount
> -_check_scratch_fs "$scratch_dev2"
> +_check_dev_fs "$scratch_dev2"
>  
>  echo "Replace device"
>  _scratch_mkfs >> $seqres.full 2>&1
> @@ -55,7 +55,7 @@ swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
>  $BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev2" "$SCRATCH_MNT" \
>  	>> $seqres.full
>  _scratch_unmount
> -_check_scratch_fs "$scratch_dev2"
> +_check_dev_fs "$scratch_dev2"
>  
>  # success, all done
>  status=0
> diff --git a/tests/generic/648 b/tests/generic/648
> index 7473c9d33746..1bba78f062cf 100755
> --- a/tests/generic/648
> +++ b/tests/generic/648
> @@ -133,7 +133,7 @@ if [ -f "$loopimg" ]; then
>  		_metadump_dev $DMERROR_DEV $seqres.scratch.final.md
>  		echo "final scratch mount failed"
>  	fi
> -	SCRATCH_RTDEV= SCRATCH_LOGDEV= _check_scratch_fs $loopimg
> +	_check_dev_fs $loopimg
>  fi
>  
>  # success, all done; let the test harness check the scratch fs
> diff --git a/tests/xfs/601 b/tests/xfs/601
> index df382402b958..44911ea389a7 100755
> --- a/tests/xfs/601
> +++ b/tests/xfs/601
> @@ -39,7 +39,7 @@ copy_file=$testdir/copy.img
>  
>  echo copy
>  $XFS_COPY_PROG $SCRATCH_DEV $copy_file >> $seqres.full
> -_check_scratch_fs $copy_file
> +_check_dev_fs $copy_file
>  
>  echo recopy
>  $XFS_COPY_PROG $copy_file $SCRATCH_DEV >> $seqres.full
> -- 
> 2.47.3
> 
> 

