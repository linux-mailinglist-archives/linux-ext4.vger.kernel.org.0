Return-Path: <linux-ext4+bounces-12333-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB2CB9B78
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 21:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71FE5308972C
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 20:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74430C366;
	Fri, 12 Dec 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raeKppk0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6096293C4E;
	Fri, 12 Dec 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569610; cv=none; b=fmhhWzJZTTJYglq84onKmwpfZZ3aYL3ik8oNtBs7ZBhjkG/gCjCx1X9WqmOff2My+DiUiBEFbbFWVU3KK+LvjCM2SpUXwbJ5qdCQ1HUHuheOynrBhTbvbrwXT4SQm5c5jfqyQgDRm0y50GWDzvM4zTEWFH/7wT/WkSAVxXd488M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569610; c=relaxed/simple;
	bh=vpnA1gSsoj+G4KLc7+57NwAKvZHybgpXipbyBmf0ItE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxQuv8b6eff6jn5s0VtEHivaNjpw7f7cyfGIf1u15vEc72PB/gBax7ButfPo0DypjH//fg09QlS67Pvlsi6qxNlbH41THj3+AI/zE8I7C+oAMzoYj2Mt1c1iEB4bhgL/dx9r81CMMJ/+3Ee8s1VsLiLbLsFVi1pEo3OEh9wULK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raeKppk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2CFC16AAE;
	Fri, 12 Dec 2025 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765569610;
	bh=vpnA1gSsoj+G4KLc7+57NwAKvZHybgpXipbyBmf0ItE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=raeKppk06bGapbg/REAo1hWv43PCh7R955FhQYybwGrP2e2nMox/XhVFo6E4MSAV0
	 1RNzc/2PL3cNX0p87sdOuzLqyjPYlpDUDSL9dwc4vYvWg0E450RXTI6fszjc3aFx6R
	 0TvRfeZSk27ZFnZ2wjluG4YjcQTP/Ef45Tol6QbZ66EMhdq2eOPS62JQN/dSfSj4As
	 FtKlb/Cx9PhBYyvL7p4GQUMVhW/hlMp4O+4Kencfxwqx+DZRxvYYjPd0A44ffnEoYl
	 mWyXHACz2Ky0q31BoX7dXOfcBp/x3Q2k9B3/iNTbAYO4b2sxFuhzFiO0bXcvcxJRDw
	 5AbJWvPSttf6A==
Date: Fri, 12 Dec 2025 12:00:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/13] xfs/530: require a real SCRATCH_RTDEV
Message-ID: <20251212200009.GB7716@frogsfrogsfrogs>
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212082210.23401-13-hch@lst.de>

On Fri, Dec 12, 2025 at 09:22:00AM +0100, Christoph Hellwig wrote:
> Require a real SCRATCH_RTDEV instead of faking one up using a loop
> device, as otherwise the options specified in MKFS_OPTIONS might
> not actually work the configuration.
> 
> Note that specifying a rtextsize doesn't work for zoned file systems,
> so _notrun when mkfs fails.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine to me, thanks for answering questions
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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

