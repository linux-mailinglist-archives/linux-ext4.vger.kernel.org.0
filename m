Return-Path: <linux-ext4+bounces-2606-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC58CA008
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FF8281A82
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C22137C23;
	Mon, 20 May 2024 15:47:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA743137935
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220078; cv=none; b=JAhpVj7Tg8y/JEjyXXScyzvsmG6XXDs41vS6OhAoSHi4+PpsRIws5UINq5SyOFNIQTRT7RM2aURgRzHibCsB/tj2ogeaIzIsI/RAL4FtS1RYvCnaBwVdETQEmEknEszl/7rvj56pPFdH4bONE35bEYrgKRI4frQYe3hR/E0pBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220078; c=relaxed/simple;
	bh=ZuCCG0Eh8Xgw2NOuuyCpM66KlU8bbuYCifixtDNZtcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckRZpxn2zETwNC2a4vG3l7UwFLZG4Ab6wBzGC13plQhHY6btxafiQDVL3KDQoVkBqJHDBNBMgIuFCDWA4v39Z5T0SbJoHS8oZD4+wQs3JoIK4jV+0ZK+EWDcm2/y+QBju6+VU/5WDxusx1DcUtLb6quIC2w7EGtU8A9U35Sib3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792b8d989e4so229269885a.2
        for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 08:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220076; x=1716824876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+Wt8B7c6VGTELIjpW5Obe1Jy6ixX5wSQstTQRsPbNk=;
        b=ErtIwcQTyK9kr0iMim9WKy65g8zXY8Ic8tZxgLYcjhwwe08qSmyBqKWp5dprM4sz45
         LKzs93TK9++OAixKR5bQrdgxuUbkdu3SaZG/7mVXd8Pt6QiWjMZAJ8gzVpAieNhHC0zn
         pUVWMDG0eBI+dyPn8qAsdXzLyTCUItUkEQB+Ceaeqsf4YI+Rkxvgq799HUn2mfGbL94V
         M3bA6Iw4kqES102dk3drZT0LAFTBh2/gtRTdh9OxSvr3/6XlFKYyu9h2uP/RMY6ig9Kk
         sh7TK2e/otRtqmgjq8V9g85V6s2X6bkr+DRM60nd2r8TB078uRl2HGAzXeDGI66ugfqv
         Z8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7AE2Vg/72CRV8NZ3Ijza1Aa9FwLIY1du15JXUPeb0cTHlUFA2ndU8wRtTAvX8ZQGdQDZL+5CpGkFE6JYxp6uqQ05YPQGwP7rpBQ==
X-Gm-Message-State: AOJu0YwS4SGTRi5n69EIWYo1oGWpSlEVCI7fPPdWFMoBu6pifFq74zmf
	MOrs6XnJmB/5b8LMblTWX0SJpCXvS+AufptlHeEyeGUtuori+RYeUpTF1nrfVh8=
X-Google-Smtp-Source: AGHT+IHIHKE9GFBMokfiBwe5Y1Cs6m7LOg6UKKNinEya5SdkKaCvkyLpek0VNjsmYX1Ubnk/wyse3g==
X-Received: by 2002:a05:620a:7284:b0:78d:5065:c5df with SMTP id af79cd13be357-792c7598d0cmr2889300585a.18.1716220075963;
        Mon, 20 May 2024 08:47:55 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275b12sm1201023885a.22.2024.05.20.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:47:55 -0700 (PDT)
Date: Mon, 20 May 2024 11:47:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, dm-devel@lists.linux.dev,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	regressions@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <Zktwqu-N0E1miesx@kernel.org>
References: <20240518022646.GA450709@mit.edu>
 <ZkmIpCRaZE0237OH@kernel.org>
 <ZkmRKPfPeX3c138f@kernel.org>
 <20240520150653.GA32461@lst.de>
 <ZktuojMrQWH9MQJO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktuojMrQWH9MQJO@kernel.org>

On Mon, May 20, 2024 at 11:39:14AM -0400, Mike Snitzer wrote:
> On Mon, May 20, 2024 at 05:06:53PM +0200, Christoph Hellwig wrote:
> 
> > This is probably my fault, I actually found this right at the time
> > of the original revert of switching dm to the limits API, and then
> > let it slip as the patch was reverted.  That fact that you readded
> > the commit somehow went past my attention window.
> 
> It's fine, all we can do now is work through how best to fix it.  Open
> to suggestions.  But this next hunk, which you trimmed in your reply,
> _seems_ needed to actually fix the issue Ted reported -- given the
> current validate method in blk-settings.c (resharing here to just
> continue this thread in a natural way):
> 
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
>  }
>  
> 

Maybe update blk_validate_limits() to ensure max_discard_sectors is a
factor of discard_granularity?

That way thin_io_hints() (and equivalent functions in other DM
targets) just need to be audited/updated to ensure they are setting
both discard_granularity and max_hw_discard_sectors?

Mike

