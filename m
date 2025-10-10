Return-Path: <linux-ext4+bounces-10773-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF6BBCDC40
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8F904FECD6
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Oct 2025 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A5D2F9C2D;
	Fri, 10 Oct 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhm3y8gU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340042F9C23
	for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109426; cv=none; b=tqxzrh5MIhvSLQI43vBC4GWj3q/44SDCXi0MNPY0ECZNBhXEAArZWSj1pHM/gAxn6RE4XR8/Wtg2L7NPboF4AHar8uYVJnHhVpEnmoj8K+J06wMpu0EurAdEf8SyuqgGGMJHxw1Cvd6GApzGbLUyU9h7LUKpotVmBMk1wcCoxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109426; c=relaxed/simple;
	bh=gAE4QBzVgSH/TFVEXsH9rJgyuCMx9gJb0VzSWWUqeNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyTfcfCvQ2mPff5vw4SLLN0hFpQlYp/rmlsA+823PU+lI2neqJ9vscWiPc7l/L8EEYlfbQKpzDud1mmXRFqlys+w3cj4wE2mwMrYgjVSkxKAnN7weqZEt2p+dRV2uajFGfLfoKcurB+dyD7QnU+tLj2NWcXgrRy6BtcxhoEwypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lhm3y8gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F1AC4CEF1;
	Fri, 10 Oct 2025 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760109424;
	bh=gAE4QBzVgSH/TFVEXsH9rJgyuCMx9gJb0VzSWWUqeNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lhm3y8gUegt96ZufJe3Uuq/XgbIUhuwSaXZWEB2ipDnPf/Q+tNP7M4q26vBoMkhv9
	 aEoKeenIsX6fM7LAVoRdN6lA3kGRnqJ7o9lNnwR/BfgXFIp90KIEmKhzLhMnmsyWBT
	 sPK7+ml6Jbf+CxG6tbs49OMWXHFvrdT3rT4SSFB9diQ6kYI9VwjHzdVD0HTeOFw9Ov
	 348PSZ/dwxSQ05VqVdy2NAifpxSwfUlxU92M4H5l2wCbr9c+NXi8jIFM2asGBINvpx
	 o1gr+k4T6n/8/rIruyGVrLGW+kaiC9OIqORdalM2pHKOssyISJjtYNGb+vaTK2oryZ
	 pLdQNtKQQigJw==
Date: Fri, 10 Oct 2025 08:17:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dave.dykstra@cern.ch>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: revert change of storing boolean options in
 bytes instead of ints
Message-ID: <20251010151704.GC6170@frogsfrogsfrogs>
References: <20251010144758.11944-1-dave.dykstra@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010144758.11944-1-dave.dykstra@cern.ch>

On Fri, Oct 10, 2025 at 09:47:58AM -0500, Dave Dykstra wrote:
> This reverts commit c7f2688540d95e7f2cbcd178f8ff62ebe079faf7
> which turned the ints into uint8_t but didn't realize that
> fuse_opt_parse() assumes they are ints.
> 
> Fixes https://github.com/tytso/e2fsprogs/issues/245
> 
> Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>

Thanks for the patch, but I already sent this a month ago:
https://lore.kernel.org/linux-ext4/175797569727.245695.9292992844444922508.stgit@frogsfrogsfrogs/

Could you reply to that patch with a review, please?

(also the libfuse code that does this is f*cking evil...)

--D

> ---
>  misc/fuse2fs.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index cb5620c7..f565dbe7 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -217,17 +217,17 @@ struct fuse2fs {
>  	pthread_mutex_t bfl;
>  	char *device;
>  	char *shortdev;
> -	uint8_t ro;
> -	uint8_t debug;
> -	uint8_t no_default_opts;
> -	uint8_t panic_on_error;
> -	uint8_t minixdf;
> -	uint8_t fakeroot;
> -	uint8_t alloc_all_blocks;
> -	uint8_t norecovery;
> -	uint8_t kernel;
> -	uint8_t directio;
> -	uint8_t acl;
> +	int ro;
> +	int debug;
> +	int no_default_opts;
> +	int panic_on_error;
> +	int minixdf;
> +	int fakeroot;
> +	int alloc_all_blocks;
> +	int norecovery;
> +	int kernel;
> +	int directio;
> +	int acl;
>  
>  	int logfd;
>  	int blocklog;
> -- 
> 2.43.5
> 
> 

