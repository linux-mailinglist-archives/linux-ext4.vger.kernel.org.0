Return-Path: <linux-ext4+bounces-2604-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A708C9FD3
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0260C1F21BC6
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4A4137759;
	Mon, 20 May 2024 15:39:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B4FC01
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219559; cv=none; b=JIo9rbLsdgXhSgBPuLiwTv26t+WGFr8T6ltj5oHmtIZ0730xzYkkk72a9IZTPwyrMiB7Ocv/zd4d6hqt4SeBotYH71JeAJqQ9Cuij17obMkoGm01w4f81XDoPIFWt7Gp3jJcJ/ZtyKhalwG+stog0DjcUHNpsx22SAC7PN+K5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219559; c=relaxed/simple;
	bh=0ifuD6C1Ultrufai42ZbuWkP4Y2UGqM45yev2rRHqMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txsL/SaYH3zg5vh4nVoBPpE6MQtHLbItLL3UT9ui6fzHjGZOcjhEGyWZ2yTVtUD5LUByDjEmSFcRE/zb+5khr11dNEGWtwh6nwCeLoVMvn8UsmKLN1Lkf6UxusWInMkq1vA5RqN/+2/rZQh+bnnuPas+E+Ck2AqT6tM3RcgdJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9c41cdd32so1435785b6e.0
        for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 08:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219556; x=1716824356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBcJrLEWNBl1O8nscyyQswrK8131ixxbt9bv821Iwzo=;
        b=mVGDg06xJsKd/s30whPZGml1X9bBTQt4qE4xWvDGK84bmPCG5pujUVDOYhVQ/ZCIhp
         1P16TtWYBQVQg8YeI4aw/RssRA+j6jG6SOSvZR+4mWn6xdalOz+oqFpXAeLgp6IUkESn
         jr8PYjuK7pdqWzWR3otVClzSTeUdwPKVkQYw0iY3GpHARWdpHl56bhHuLc7aTAkG00Qd
         43p5m5uh2TMxOErdwooTJF94mOw5wFat5AAsciVfPjRXOKj7WnsFKCvJijEhFVYZBx4H
         uN0m3h0UDmSfFLNRf8p7J+vxAyKadOI1cHpLcpcVs6FhnCEUbZ7KjCr4/Xwp9b9ntRIy
         JlSw==
X-Forwarded-Encrypted: i=1; AJvYcCXPpWsICSdpSQlZ8kwSc+l8gmeReiFNgRrMsS3zHUHWvBQznoXiL/9R2ZdQbG+5r9Zsi5+y7PwrjTsvFW007pQ2vZ9HG0svFuSnOA==
X-Gm-Message-State: AOJu0Ywh6P6BPtf5//Kwte92idVghow4meyBiCm40Ug5ZWnyxa6nbtwR
	6z/i/CyGoDu+6b8PFku2vyKb+i10HyCljCLJTervp2GZh7uEr6f8GuTEWkRfaN1TZr4fAvqhFlR
	4b/U=
X-Google-Smtp-Source: AGHT+IHM9cCXZBZETgCuIRfBwYWQQ0oe/v9QEzIq+dX3iC2IbbS5PJ/va2YqsjaKenTdukx8rxipkA==
X-Received: by 2002:a05:6808:144b:b0:3c9:d067:1de9 with SMTP id 5614622812f47-3c9d0671e8cmr10179395b6e.34.1716219556593;
        Mon, 20 May 2024 08:39:16 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fca1dsm1194750485a.92.2024.05.20.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:39:15 -0700 (PDT)
Date: Mon, 20 May 2024 11:39:14 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Theodore Ts'o <tytso@mit.edu>, dm-devel@lists.linux.dev,
	fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	regressions@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <ZktuojMrQWH9MQJO@kernel.org>
References: <20240518022646.GA450709@mit.edu>
 <ZkmIpCRaZE0237OH@kernel.org>
 <ZkmRKPfPeX3c138f@kernel.org>
 <20240520150653.GA32461@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520150653.GA32461@lst.de>

On Mon, May 20, 2024 at 05:06:53PM +0200, Christoph Hellwig wrote:
> On Sun, May 19, 2024 at 01:42:00AM -0400, Mike Snitzer wrote:
> > > This being one potential fix from code inspection I've done to this
> > > point, please see if it resolves your fstests failures (but I haven't
> > > actually looked at those fstests yet _and_ I still need to review
> > > commits d690cb8ae14bd and 4f563a64732da further -- will do on Monday,
> > > sorry for the trouble):
> > 
> > I looked early, this is needed (max_user_discard_sectors makes discard
> > limits stacking suck more than it already did -- imho 4f563a64732da is
> > worthy of revert.
> 
> Can you explain why?  This actually makes the original addition of the
> user-space controlled max discard limit work.  No I'm a bit doubful
> that allowing this control was a good idea, but that ship unfortunately
> has sailed.

That's fair.  My criticism was more about having to fix up DM targets
to cope with the new normal of max_discard_sectors being set as a
function of max_hw_discard_sectors and max_user_discard_sectors.

With stacked devices in particular it is _very_ hard for the user to
know their exerting control over a max discard limit is correct.

> Short of that, dm-cache-target.c and possibly other
> > DM targets will need fixes too -- I'll go over it all Monday):
> > 
> > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > index 4793ad2aa1f7..c196f39579af 100644
> > --- a/drivers/md/dm-thin.c
> > +++ b/drivers/md/dm-thin.c
> > @@ -4099,8 +4099,10 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
> >  
> >  	if (pt->adjusted_pf.discard_enabled) {
> >  		disable_discard_passdown_if_not_supported(pt);
> > -		if (!pt->adjusted_pf.discard_passdown)
> > -			limits->max_discard_sectors = 0;
> > +		if (!pt->adjusted_pf.discard_passdown) {
> > +			limits->max_hw_discard_sectors = 0;
> > +			limits->max_user_discard_sectors = 0;
> > +		}
> 
> I think the main problem here is that dm targets adjust
> max_discard_sectors diretly instead of adjusting max_hw_discard_sectors.
> Im other words we need to switch all places dm targets set
> max_discard_sectors to use max_hw_discard_sectors instead.  They should
> not touch max_user_discard_sectors ever.

Yeah, but my concern is that if a user sets a value that is too low
it'll break targets like DM thinp (which Ted reported).  So forcibly
setting both to indirectly set the required max_discard_sectors seems
necessary.

> This is probably my fault, I actually found this right at the time
> of the original revert of switching dm to the limits API, and then
> let it slip as the patch was reverted.  That fact that you readded
> the commit somehow went past my attention window.

It's fine, all we can do now is work through how best to fix it.  Open
to suggestions.  But this next hunk, which you trimmed in your reply,
_seems_ needed to actually fix the issue Ted reported -- given the
current validate method in blk-settings.c (resharing here to just
continue this thread in a natural way):

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 4793ad2aa1f7..c196f39579af 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -4497,7 +4499,8 @@ static void thin_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 	if (pool->pf.discard_enabled) {
 		limits->discard_granularity = pool->sectors_per_block << SECTOR_SHIFT;
-		limits->max_discard_sectors = pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
+		limits->max_hw_discard_sectors = limits->max_user_discard_sectors =
+			pool->sectors_per_block * BIO_PRISON_MAX_RANGE;
 	}
 }
 


