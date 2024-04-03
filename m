Return-Path: <linux-ext4+bounces-1843-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7A5896394
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 06:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCDC1C22981
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 04:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A94120B;
	Wed,  3 Apr 2024 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bahQupel"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7B6AD7
	for <linux-ext4@vger.kernel.org>; Wed,  3 Apr 2024 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119014; cv=none; b=Sjy2p8ZQG6r3T7fd32OSX8FbmIbv/3P5xfRoiBB5IBrwGOS+TXM0FmqiI+dbgVdSJWVZfYbvHsIF2jnCsU8eaxjqM85gtvM4xDkh/AjG8N1+w3JNAT54osxGGGaN6Qr4twbwYju870PpQ1S7UK4gi8SCTtRHazzLuUEoxWblAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119014; c=relaxed/simple;
	bh=Bme9+MVTo0NuvDXiSrgzMRpIClxkPo4LPLpiR8dJ49g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFWSk/oVk6RvVGRAFxkKYiTo4Q9JdXtydi3+mg9Zemu781gN9er3pp4bNR9kQ3FOZhmMZiVerMj/IdAH0p3e+1p2CqEYYHn/szJjiHGCAuhLTqVIo6yPu3LvcUhFltOPTgGBQskGuVDhEEBgzun9+C9uoHEsIFDdZXfzH7URmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bahQupel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101AFC433F1;
	Wed,  3 Apr 2024 04:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712119014;
	bh=Bme9+MVTo0NuvDXiSrgzMRpIClxkPo4LPLpiR8dJ49g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bahQupelI51HFfEGsF9ApNDB0bp+Wm7VHUOqi7tK/2UD54NK8GE327HVV4afHKktz
	 4xv8kgSa0gowHlfotHp1F7Xn2u1lPVgQ7C2MGHMoywQHKNgyD/i/BwDWYrMHQfBDdj
	 R3SlB4nQ/LWiza1HYxvE2Kzgex+kt6nNmwlndOESW4ArEsxUf0w6p9gycAvejUnEnN
	 ThNdynOOucik2EF4xMDUkMJ6NJ6wCvQAIMlqlRE5zaULcBMIZXX9GmDYdIcduka939
	 jQp5R9K/4fKCXU54XbGWsSfXm083GNT24dqvQW5mKDkmOldGYLQBT67lHbRYOkDmS5
	 0kxWN6G9MC2hw==
Date: Tue, 2 Apr 2024 21:36:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger@dilger.ca,
	rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH v3] e2fsprogs: misc/mke2fs.8.in: Correct valid
 cluster-size values
Message-ID: <20240403043653.GB739535@frogsfrogsfrogs>
References: <20240403043037.3992724-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403043037.3992724-1-srivathsa.d.dara@oracle.com>

On Wed, Apr 03, 2024 at 04:30:37AM +0000, Srivathsa Dara wrote:
> According to the mke2fs man page, the supported cluster-size values
> for an ext4 filesystem are 2048 to 256M bytes. However, this is not
> the case.
> 
> When mkfs is run to create a filesystem with following specifications:
> * 1k blocksize and cluster-size greater than 32M
> * 2k blocksize and cluster-size greater than 64M
> * 4k blocksize and cluster-size greater than 128M
> mkfs fails with "Invalid argument passed to ext2 library while trying
> to create journal" error. In general, when the cluster-size to blocksize
> ratio is greater than 32k, mkfs fails with this error.
> 
> Went through the code and found out that the function
> `ext2fs_new_range()` is the source of this error. This is because when
> the cluster-size to blocksize ratio exceeds 32k, the length argument
> to the function `ext2fs_new_range()` results in 0. Hence, the error.
> 
> This patch corrects the valid cluster-size values.
> 
> v2->v3:
> Remove redundant words and add info about how cluster-sizes that are
> not powers of 2 are rounded.
> ---
>  misc/mke2fs.8.in | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index 30f97bb5..c7b21f9d 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -232,9 +232,13 @@ test is used instead of a fast read-only test.
>  .TP
>  .B \-C " cluster-size"
>  Specify the size of cluster in bytes for file systems using the bigalloc
> -feature.  Valid cluster-size values are from 2048 to 256M bytes per
> -cluster.  This can only be specified if the bigalloc feature is
> -enabled.  (See the
> +feature. Valid cluster-size values range from 2 to 32768 times the
> +filesystem blocksize and must be a power of 2. If a cluster-size that is
> +not a power of 2 is provided, it will be rounded down to the nearest
> +power of 2 that is less than the given cluster-size. For example,
> +specifying '-C 20k', '-C 30k', or '-C 17k' will result in a cluster-size
> +of 16k. The cluster-size can only be specified if the
> +bigalloc feature is enabled.  (See the

Thanks for updating the documentation,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  .B ext4 (5)
>  man page for more details about bigalloc.)   The default cluster size if
>  bigalloc is enabled is 16 times the block size.
> -- 
> 2.39.3
> 
> 

