Return-Path: <linux-ext4+bounces-2605-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241D8C9FF5
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CEBB21ECD
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EA13776A;
	Mon, 20 May 2024 15:44:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF3137771;
	Mon, 20 May 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219871; cv=none; b=lNa+nrlu9ZyqNGCPQL6fT28hmu5UR5yPCMQ8H+u8TpyeOCnB+1OOqaZgXygihVC3n5ZvpykRLa8WZjPv5y5pdeGKlKmNm9SvSNmv2ZzrDkN1F3+75xOH8aLpE/lCoQd26Ue2cSs3gw21HZAM+Sj6TwOBtVeiPBnUi99xfDHoQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219871; c=relaxed/simple;
	bh=uQYwQrhNr1tapWzD5SFii2r2ol4zhyU12nt7DLCJlRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4X44Ed4YVnrpATFvT5Oz8tOY9N+rtrvp/e+BBZ6UkR9NQVlYDDIS9LRzmdSGqBBvW8DkfKVKFBGoBNGHx8xQmc7XxL+P8bQa4cdKbRoMv08W6CR0eYoBJ+1NpVS+bI0Ztb5ZcjSsWKyHKzxEg2z48THJZWJNXRSV7TuAJY+5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9FBC68AFE; Mon, 20 May 2024 17:44:25 +0200 (CEST)
Date: Mon, 20 May 2024 17:44:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
	dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <20240520154425.GB1104@lst.de>
References: <20240518022646.GA450709@mit.edu> <ZkmIpCRaZE0237OH@kernel.org> <ZkmRKPfPeX3c138f@kernel.org> <20240520150653.GA32461@lst.de> <ZktuojMrQWH9MQJO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktuojMrQWH9MQJO@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 20, 2024 at 11:39:14AM -0400, Mike Snitzer wrote:
> That's fair.  My criticism was more about having to fix up DM targets
> to cope with the new normal of max_discard_sectors being set as a
> function of max_hw_discard_sectors and max_user_discard_sectors.
> 
> With stacked devices in particular it is _very_ hard for the user to
> know their exerting control over a max discard limit is correct.

The user forcing a limit is always very sketchy, which is why I'm
not a fan of it.

> Yeah, but my concern is that if a user sets a value that is too low
> it'll break targets like DM thinp (which Ted reported).  So forcibly
> setting both to indirectly set the required max_discard_sectors seems
> necessary.

Dm-think requiring a minimum discard size is a rather odd requirement.
Is this just a debug asswert, or is there a real technical reason
for it?  If so we can introduce a now to force a minimum size or
disable user setting the value entirely. 

> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 4793ad2aa1f7..c196f39579af 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -4497,7 +4499,8 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  
>  	if (pool->pf.discard_enabled) {
>  		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
> -		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
> +		limits->max_hw_discard_sectors = limits->max_user_discard_sectors =
> +			pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
>  	}

Drivers really have no business setting max_user_discard_sector,
the whole point of the field is to separate device/driver capabilities
from user policy.  So if dm-think really has no way of handling
smaller discards, we need to ensure they can't be set.

I'm also kinda curious what actually sets a user limit in Ted's case
as that feels weird.

