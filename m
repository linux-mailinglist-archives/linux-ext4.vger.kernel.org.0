Return-Path: <linux-ext4+bounces-12274-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BFECB3E8F
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 21:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F3730557B3
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605B329E54;
	Wed, 10 Dec 2025 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDySE8UZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC721E7C2E;
	Wed, 10 Dec 2025 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396970; cv=none; b=SYusbt0y2HqPg6Cswn/u69s30BxQHRTzqyPuswYcgVynjNU78o34X3ABpsxa/vetSv07IlGZwlz3GlRjVgi8BCNGanhq8oA9QEnRMK1n6Es2iLcEtIVv4WL3rqKfC0wHMHRbI/GuLnuOMSdnPgGraw0bvUK57TuQZOhOxHFpSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396970; c=relaxed/simple;
	bh=SY6pxtUiM6zwGV0ynZWRuq1yFtYpDpwBFhlaEWZGaEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1yN7ElfT/kVmTh3mJlaLI9+2ESRDDsmuQ4b6DJLnJzyQUTVgPUHQ1LlII0ONn7EnX3JWzHO/yBlZ+G/brpIWcV5G7IKOJVE4xG9VvOGBDDteMuyvkdnFMCp3DOjG+w1cnnYSXRghPHe56+MkS31avSBP7VtoyoEI+iu5we4AOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDySE8UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603E6C4CEF1;
	Wed, 10 Dec 2025 20:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765396969;
	bh=SY6pxtUiM6zwGV0ynZWRuq1yFtYpDpwBFhlaEWZGaEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDySE8UZhmYv7/pkV6Ngzs9LLxDUvlk0WKhGM7K+zmHSIHeProVO5grsu5B+Und3B
	 M2a/5haNzMj1yGy39acqPODT1/oBmv2DQREg1g64dyDauxMZf8bQdZ/bGlPhSlcXo9
	 Wr+S5FfOPtOM2wTKFJFLK2Rm0XEHfegzLF6XzfhHeTxdS22wfUquI8D62AGyXctwVs
	 sLxdtxrwOiL2cTT0YJp3N0b3eXc53TXq5hPKOMzaZrvGzPxb1gJIs3lN1VlLvmZbQn
	 TjxljZYqlZl7P6bKuOLpE8Rf/UQKIjRt2b6jEiwDpNEsWaUs56zsZ3XUrsOJQx+bjR
	 GxJLIjm8oh9oA==
Date: Wed, 10 Dec 2025 12:02:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs/185: don't use SCRATCH_{,RT}DEV helpers
Message-ID: <20251210200248.GG94594@frogsfrogsfrogs>
References: <20251210054831.3469261-1-hch@lst.de>
 <20251210054831.3469261-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210054831.3469261-8-hch@lst.de>

On Wed, Dec 10, 2025 at 06:46:53AM +0100, Christoph Hellwig wrote:
> This tests creates loop-based data and rt devices for testing.  Don't
> override SCRATCH_{,RT}DEV and don't use the helpers based on it because
> the options specified in MKFS_OPTIONS might not work for this
> configuration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/185 | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/xfs/185 b/tests/xfs/185
> index 7aceb383ce46..84139be8e66e 100755
> --- a/tests/xfs/185
> +++ b/tests/xfs/185
<snip>
> @@ -64,16 +63,8 @@ rtminor=$(stat -c '%T' "$rtloop")
>  test $ddmajor -le $rtmajor || \
>  	_notrun "Data loopdev minor $ddminor larger than rt minor $rtminor"
>  
> -# Inject our custom-built devices as an rt-capable scratch device.
> -# We avoid touching "require_scratch" so that post-test fsck will not try to
> -# run on our synthesized scratch device.
> -old_use_external="$USE_EXTERNAL"
> -USE_EXTERNAL=yes
> -SCRATCH_RTDEV="$rtloop"
> -SCRATCH_DEV="$ddloop"
> -
> -_scratch_mkfs >> $seqres.full
> -_try_scratch_mount >> $seqres.full || \
> +$MKFS_XFS_PROG -r rtdev=$rtloop $ddloop  >> $seqres.full
> +mount -o rtdev=$rtloop $ddloop $SCRATCH_MNT >> $seqres.full || \
>  	_notrun "mount with injected rt device failed"

What happens if SCRATCH_LOGDEV is set?  I guess we ignore it, and
everything is good?  I suppose the logdev configuration isn't really
relevant here anyway.

If the answers are 'nothing' and 'yes' then
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  # Create a file that we'll use to seed fsmap entries for the rt device,
> -- 
> 2.47.3
> 
> 

