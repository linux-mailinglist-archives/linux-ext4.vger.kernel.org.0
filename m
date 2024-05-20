Return-Path: <linux-ext4+bounces-2608-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0498CA051
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01EB1C213FD
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43459137902;
	Mon, 20 May 2024 15:54:57 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389F4C66
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220497; cv=none; b=Of41FwWKX+PhJAeRsTjJPB1Dhqy8urt6aJcuhLCHz2Xhf/2k0G4VOwQYec9Gq/EdYWXdqIWqlpDuKQrSh7VG3SL07DWxTN9FlNHM86KeyUJqJDV3dmr039MkJqcl7M2vO0IQzR5P4zN5Wf1sHPEHI+WrXfhO4Nav1NZEnYjGizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220497; c=relaxed/simple;
	bh=Homzp/63aiX0b0frqJlJfO8Q6OA7Jf4akX4P+wX3COw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INS8rNcqxcjS8a9verFMSn54qyZzi3K7xVEk/krPWPrIh/CgEOOCw0NQZujaJBfa3kWiAcgEVrerNZPXx/m6148p295YiSGkjDKmugD1XQJwx2pG7dDAQdfxwwoyH3z5RLrMrSriBar3QkTlDpGUH2WF73n0sIwN040Hm9qGF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43e415ae282so17609161cf.1
        for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 08:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716220494; x=1716825294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaIyNEamC/GOVmXOOEefzqW6FyJnCYusfseZnVHqXxo=;
        b=SY3Fk64Y9+gaK3msneY3D8MhtKKfXUy2FNL8J5I/RzZ8qcvABWIlPfc493caBexDZG
         KFzTG4FHY1y8RuBWwbO7zjMyK1KmcTA21RU+0KmtHLSuoivxeuVhdVQJgDvQvfrLZ0z7
         oZWm9mXAohN+dN5RUTtav6LyLaX2dVX12bdxDJIeIVo7q1HcV6bvFTSfG3H8sRh4hcLv
         qX4YWE+nrBwIdruNmC43YWzDKYpyl0vzBcZB9OlqkWvstqpXztGWv/dmzUce6lXMZAk8
         W0gzcQyNorgBTfkE1CJJbIvNSu8v3TcKWr0YT88snnL816RDy8Ut4nzu/f8emjWZW7zi
         7fIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+9dxE6sG0nonUoL8sN4aj4jrHdfQC+9kmjGV9UjTUKNMMisbVymJS7hP5GShZcdrtKHdPt+DwfriUuIfPQN1XHt2iuSq5QgOfGw==
X-Gm-Message-State: AOJu0YyKcOFRMYE1zZRwyy8ajWakSrXbIkZrWztNzzMy9qTmEMG/Mp3n
	XozEH8+7BI6pkKPs6Sk6f76g3gOZCzFowt/H1sYyANW7TZS49+RVbt9ZAVKfuYw=
X-Google-Smtp-Source: AGHT+IFEI2WIsnG6E5eeNjkDC8pyDKtauCuIbSxAV0M2We8mLigkzXUeIcnUOFltjNKjK00xd2PSYQ==
X-Received: by 2002:ac8:5d49:0:b0:43a:a82d:4fa with SMTP id d75a77b69052e-43dfdaa9ab4mr263199961cf.15.1716220494481;
        Mon, 20 May 2024 08:54:54 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43dfa0fc2e1sm142427401cf.56.2024.05.20.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:54:54 -0700 (PDT)
Date: Mon, 20 May 2024 11:54:53 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, dm-devel@lists.linux.dev,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	regressions@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZktyTYKySaauFcQT@kernel.org>
References: <20240518022646.GA450709@mit.edu>
 <ZkmIpCRaZE0237OH@kernel.org>
 <ZkmRKPfPeX3c138f@kernel.org>
 <20240520150653.GA32461@lst.de>
 <ZktuojMrQWH9MQJO@kernel.org>
 <20240520154425.GB1104@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520154425.GB1104@lst.de>

On Mon, May 20, 2024 at 05:44:25PM +0200, Christoph Hellwig wrote:
> On Mon, May 20, 2024 at 11:39:14AM -0400, Mike Snitzer wrote:
> > That's fair.  My criticism was more about having to fix up DM targets
> > to cope with the new normal of max_discard_sectors being set as a
> > function of max_hw_discard_sectors and max_user_discard_sectors.
> > 
> > With stacked devices in particular it is _very_ hard for the user to
> > know their exerting control over a max discard limit is correct.
> 
> The user forcing a limit is always very sketchy, which is why I'm
> not a fan of it.
> 
> > Yeah, but my concern is that if a user sets a value that is too low
> > it'll break targets like DM thinp (which Ted reported).  So forcibly
> > setting both to indirectly set the required max_discard_sectors seems
> > necessary.
> 
> Dm-think requiring a minimum discard size is a rather odd requirement.
> Is this just a debug asswert, or is there a real technical reason
> for it?  If so we can introduce a now to force a minimum size or
> disable user setting the value entirely. 

thinp's discard implementation is constrained by the dm-bio-prison's
constraints.  One of the requirements of dm-bio-prison is that a
discard not exceed BIO_PRISON_MAX_RANGE.

My previous reply is a reasonible way to ensure best effort to respect
a users request but that takes into account the driver provided
discard_granularity.  It'll force suboptimal (too small) discards be
issued but at least they'll cover a full thinp block.
 
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 4793ad2aa1f7..c196f39579af 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> > @@ -4497,7 +4499,8 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
> >  
> >  	if (pool->pf.discard_enabled) {
> >  		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
> > -		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
> > +		limits->max_hw_discard_sectors = limits->max_user_discard_sectors =
> > +			pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
> >  	}
> 
> Drivers really have no business setting max_user_discard_sector,
> the whole point of the field is to separate device/driver capabilities
> from user policy.  So if dm-think really has no way of handling
> smaller discards, we need to ensure they can't be set.

It can handle smaller so long as they respect discard_granularity.

> I'm also kinda curious what actually sets a user limit in Ted's case
> as that feels weird.

I agree, not sure... maybe the fstests is using the knob?

