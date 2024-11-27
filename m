Return-Path: <linux-ext4+bounces-5419-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE059DA020
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 01:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09E8168E2A
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACB1156CF;
	Wed, 27 Nov 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twYjERU6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AB14F90;
	Wed, 27 Nov 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668844; cv=none; b=TBuQ1SBqM9cSO4A0+mjaqzV9RF/OywN7GTulmisKRM7vbpm7XRmOotI/zS8OYzAnPeJ7HINF4PnUAbFZEdpXDpBrYWtrdtwlHp9BvQLL1lfYwyrVmOtPynq6fFICX0h60x633ADo8yOneduP49dc7KregAE4dXI+sh1Do23gOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668844; c=relaxed/simple;
	bh=7J1IGdkpsJjzOqhOcq+Mx/GI7zhDkfFsMESoeATfORA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDHHlt0ywqYroUeq0y+rymm2BbZAFm4JIMmGGRQpdw+LMBj/ocb/Zl1CGguCyY6fj+UQto7+mUYx1NOgi3j+z7049BVi2MQRvnfyoe5o+OGOmETZJ/k4H9c2ip8glhOuDx/Jf2WlW+ufScflflKZY42bZhz3PV4mpEq2dfT3+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twYjERU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FBDC4CED2;
	Wed, 27 Nov 2024 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732668844;
	bh=7J1IGdkpsJjzOqhOcq+Mx/GI7zhDkfFsMESoeATfORA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twYjERU6v5zgziUNfQ3tCTs3r4VZUBFefVhLGPOfHW4+o8BdzGy6dkOy6bud6FNW8
	 rSf54yvHeYdNHidCwUS7CubS61/b7mT5yJrMaGH/RKe4aUDiww8EY9he+bWKtwEWpL
	 59bUH6f1EELQbJ+GPQFhEK4aZX5tt3oBBoQZCy0VI6i6yS+cQU1wWs8LtHYGODNXJS
	 vvnrJivxHBg7GnDXCu7ezVllFpp0xOmYesoTu46KhbjnqkuECIhQO2MNV6gXU/7aYD
	 NR5EVq6K5r647Bz8SVW1T7xBiO2sctIVhsC5dRgR9yWY+cbBBlzpQBlb2KWi75XlU0
	 5ilkpR6apSO5w==
Date: Tue, 26 Nov 2024 16:54:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v4 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Message-ID: <20241127005403.GS9438@frogsfrogsfrogs>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <3e0f7be0799a990e2f6856f884e527a92585bf56.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e0f7be0799a990e2f6856f884e527a92585bf56.1732599868.git.nirjhar@linux.ibm.com>

On Tue, Nov 26, 2024 at 11:24:07AM +0530, Nirjhar Roy wrote:
> _require_scratch_extsize helper function will be used in the
> the next patch to make the test run only on filesystems with
> extsize support.
> 
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index f94bee5e..e6c6047d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -48,6 +48,23 @@ _test_fsxattr_xflag()
>  	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>  }
>  
> +# This test requires extsize support on the  filesystem
> +_require_scratch_extsize()
> +{
> +	_require_scratch
> +	_require_xfs_io_command "extsize"
> +	_scratch_mkfs > /dev/null
> +	_scratch_mount
> +	local filename=$SCRATCH_MNT/$RANDOM
> +	local blksz=$(_get_block_size $SCRATCH_MNT)
> +	local extsz=$(( blksz*2 ))
> +	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
> +		-c "extsize")
> +	_scratch_unmount
> +	grep -q "\[$extsz\] $filename" <(echo $res) || \
> +		_notrun "this test requires extsize support on the filesystem"
> +}
> +
>  # Write a byte into a range of a file
>  _pwrite_byte() {
>  	local pattern="$1"
> -- 
> 2.43.5
> 
> 

