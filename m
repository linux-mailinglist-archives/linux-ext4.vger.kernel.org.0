Return-Path: <linux-ext4+bounces-12335-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE0CB9B87
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 21:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39E8930329F1
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5C12F5468;
	Fri, 12 Dec 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgH8Yuao"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD727B34D;
	Fri, 12 Dec 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569660; cv=none; b=YsDLjMOX660Qw1VM9kxbHEcDNrKGLQSFlO011fbhAvxoAreNoqQRIe81TyCNSRQiGFfA10TeoOhPjVoWJo8IMLH38MNsWfqK7Em/OCNtpscTf3IGrUHNCH8UT9Lw1XMUUh1sOIP6A3say3eYN69HgEcbyQu3J0GNk/rPv5gxX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569660; c=relaxed/simple;
	bh=qm+qA2MvFTEm7oF8I+6PYamK1wvlhyodfAldshhkydE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEhytt8DMw92PR6adA02q9gARF5w2n+SvgxDE1yX9XwJlhyC+Pkn4ofDHt65bIZin+dedNwiW67W1NCBf6k4Yn0sFvoMXY1epFEC6sMyYeAKWJTaTaVvQP64jJYSrzFwn64FWqN8Y8NX56RXslf9ybWkOvfywolDryjS2l8nCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgH8Yuao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF3EC4CEF1;
	Fri, 12 Dec 2025 20:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765569659;
	bh=qm+qA2MvFTEm7oF8I+6PYamK1wvlhyodfAldshhkydE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgH8YuaoGYlJD+Uu7DwGyyTVe3H6mKlYfptF8fD4lXbUKTv0wOeunTllo0G1aKnZh
	 5Pi9lQSkuu/JdMIdSGoC9cF0YNh0ny89N9EQYYH9f/2g8d5LVsgDPw3nr8UBP4kr4W
	 i0VVBX2hszVEfXVnaZN6ovwU2u62b+GO1Qe44Us0AtpjfUG5NinvChviZsoKX6hq7x
	 3l66RvMQ3xvu8Fb1RtYQ9WVQjhVkOT+8x7LDke85sHct8Td53zkAt0fXhyYbfOKMta
	 YbekgjbjGmb7TrHw9OqiYx1MVNha81NlvcyOtb4PY9QOhV0/5RtZbij2NLLcO5btx2
	 YNSKQvbfy0Nrg==
Date: Fri, 12 Dec 2025 12:00:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/13] xfs/528: require a real SCRATCH_RTDEV
Message-ID: <20251212200059.GC7716@frogsfrogsfrogs>
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212082210.23401-12-hch@lst.de>

On Fri, Dec 12, 2025 at 09:21:59AM +0100, Christoph Hellwig wrote:
> Require a real SCRATCH_RTDEV instead of faking one up using a loop
> device, as otherwise the options specified in MKFS_OPTIONS might
> not actually work the configuration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for moving the scratch unmount!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/xfs/528     | 34 ++++------------------------------
>  tests/xfs/528.out |  2 --
>  2 files changed, 4 insertions(+), 32 deletions(-)
> 
> diff --git a/tests/xfs/528 b/tests/xfs/528
> index a1efbbd27b96..c0db3028b24a 100755
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
> @@ -151,29 +139,15 @@ test_ops() {
>  
>  	log "Check everything, rextsize=$rextsize"
>  	_check_scratch_fs
> +	_scratch_unmount
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

