Return-Path: <linux-ext4+bounces-2603-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB788C9F4D
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7FD1F21CEF
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B589136E10;
	Mon, 20 May 2024 15:07:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D74D9FE;
	Mon, 20 May 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217626; cv=none; b=AKev2y48uLW1ARfU6NwgZvPBubE1A28reExGwBpK26N4QmP3NoQZGpzr3G8iIQqpBI0biJSfMBWXn65Wa3AjwcRt5g0M5CRFItuu9id5LjWD5wf8v1Lm/Xp9hXtIRjoaU155LoHoT8BK4rBQetvHZXfWap2B/E374Kz9Oixpa4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217626; c=relaxed/simple;
	bh=ZAmlkD2H/yb/d8FBbvu5IRs6uaEE11WCWhPfXq3NnuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdNOfiV76mn5Mpi6+ojdDraQgYrRve+bX5X/rv6uAURVCDsTDj2FcGR4VBR/KCVUh+ztV4iVs7TLbVpcaEI2Qa2jiZ/fuSoEwG4YyxdVi6XKAAVI2nERMXkmbSqLjTvgeo+msjsblAIiGsrg5DBPGj7np/rCLepovOyF+B7D96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F90E68AFE; Mon, 20 May 2024 17:06:54 +0200 (CEST)
Date: Mon, 20 May 2024 17:06:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, dm-devel@lists.linux.dev,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	regressions@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <20240520150653.GA32461@lst.de>
References: <20240518022646.GA450709@mit.edu> <ZkmIpCRaZE0237OH@kernel.org> <ZkmRKPfPeX3c138f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkmRKPfPeX3c138f@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, May 19, 2024 at 01:42:00AM -0400, Mike Snitzer wrote:
> > This being one potential fix from code inspection I've done to this
> > point, please see if it resolves your fstests failures (but I haven't
> > actually looked at those fstests yet _and_ I still need to review
> > commits d690cb8ae14bd and 4f563a64732da further -- will do on Monday,
> > sorry for the trouble):
> 
> I looked early, this is needed (max_user_discard_sectors makes discard
> limits stacking suck more than it already did -- imho 4f563a64732da is
> worthy of revert.

Can you explain why?  This actually makes the original addition of the
user-space controlled max discard limit work.  No I'm a bit doubful
that allowing this control was a good idea, but that ship unfortunately
has sailed.

Short of that, dm-cache-target.c and possibly other
> DM targets will need fixes too -- I'll go over it all Monday):
> 
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 4793ad2aa1f7..c196f39579af 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -4099,8 +4099,10 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  	if (pt->adjusted_pf.discard_enabled) {
>  		disable_discard_passdown_if_not_supported(pt);
> -		if (!pt->adjusted_pf.discard_passdown)
> -			limits->max_discard_sectors = 0;
> +		if (!pt->adjusted_pf.discard_passdown) {
> +			limits->max_hw_discard_sectors = 0;
> +			limits->max_user_discard_sectors = 0;
> +		}

I think the main problem here is that dm targets adjust
max_discard_sectors diretly instead of adjusting max_hw_discard_sectors.
Im other words we need to switch all places dm targets set
max_discard_sectors to use max_hw_discard_sectors instead.  They should
not touch max_user_discard_sectors ever.

This is probably my fault, I actually found this right at the time
of the original revert of switching dm to the limits API, and then
let it slip as the patch was reverted.  That fact that you readded
the commit somehow went past my attention window.


