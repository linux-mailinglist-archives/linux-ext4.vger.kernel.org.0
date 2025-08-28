Return-Path: <linux-ext4+bounces-9737-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAEFB39BEC
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC06A7AA38A
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E530EF7E;
	Thu, 28 Aug 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="gTt3uz5e"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FA27A13D
	for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381577; cv=none; b=eOYBSTzdZe/3PPqIIbBRC6iP4XIfMnaNuDuIn8ovJQ6OayCiyMXtHdzMH0kYQUQRpSXDW3PwakeRi10wiUD8/OGaWyAB6kHRTUe0H4KzptEUczphrCLtwlMPCTw/kQI8J1A1H58rgFhr/d+pZ7fLFdpiapjHbgcKE112B7Hk/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381577; c=relaxed/simple;
	bh=uAGCJDmp6cJsS5qz70KZAgSZxtvKiuj4rYNnVtudL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9dMJZVNHks6OZrGWIJKunaOfQr2MDorR16hLt1UNcPbt/Lhc08QqFWGned+Wm8+41zgWiZ565utJho/7MeYmleLSJvpXt+nskTKxWVdstZrE4c+l3ksH080+3i2D9nfS/fk0RzWYiPAdBtMn1U3RzF1duBCJQ+ojaYJnmKGd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=gTt3uz5e; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d608e34b4so6628627b3.3
        for <linux-ext4@vger.kernel.org>; Thu, 28 Aug 2025 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1756381575; x=1756986375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkW7vRfw5fmjfl6Szg391djOpIwzx0Kzah7uxGUnsRM=;
        b=gTt3uz5eNf7X1OGusQGWx08Zvs0tFg98T5qv2dZ47hhRP0P/X6u8zsQK2zlACUSOPn
         1s1SM/GARczGBQ1vOsAPsjHiqTAKVQ5W06vwjcF9uSD55UalFkoxuH7wC9Tkxw2VQ2N4
         ejTi6hDn9z8jrJk4LTSMo4O+2YQk9aYzF0qhDm+YtNm9Q/kHGhTQ6Nz0zvQEL9eraP/i
         0DhrVioaLr3HuQ6prYs6YB4RFLkNjVoXUaoOM+8eoMITial9OUF2I0UAY3F5CFBPsSfk
         wuXK1REf3xGn5U3f7+Pyrzye+yX4P9JmupIsHwb2hnkCITlXdLA990qHCl34ZYK/fPHP
         p1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381575; x=1756986375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkW7vRfw5fmjfl6Szg391djOpIwzx0Kzah7uxGUnsRM=;
        b=U2ovGlHeXUH/R90GmgQMB/tbw56tSx/sSwlG8/NwAWJ0NZItrexRt0vj1+bDfDQXIU
         ocy7kO6XbXThQjuABSXA9GM7mqJgGLrVibQxdvDGCol0Y660nvCoMrWo+wnigkI+aHUd
         Htnl1RG3vhXc0Xaip6B0RcqM+GvibVAv846xPK84Edb8IXQZ5303JkHMuos9AuJUeSDl
         rgGWJfNCXHS5F5vFmN1EKQgZznufrTdn/wyHvZHEzuzZcq1TL5+gjVPlkSy2GI90WLn9
         /pOePATuS5Vmv9URAg8Pneqcy2uvxHB9HzGeBE+gWtlYro5bjRv4xSpwANERZSLGFhBw
         r9rw==
X-Forwarded-Encrypted: i=1; AJvYcCWmcMzHtF5azBNgljR/ZfbE8FEHAHMzIFVmoop3FzHM7qJRQ++QHIOYLmxTf3Z8LjKjL3pH4h7snjTa@vger.kernel.org
X-Gm-Message-State: AOJu0YwakQcLCU7sjuNAiuZKUugHmsEavjF+Vu0MAXgLR5an9BKkHf0x
	fCh22lcHg5BF4zh+j+FmAHTgMOw5erkTMwM3cP78eb/Tsw2QJCXbzzRDDsrfCwH08jY=
X-Gm-Gg: ASbGnctJRLXtmUEQPV3UIsgRGS8pxwfCq6zl5vjleEl5Sb54VIfpFlMaFDB/VAKfgNc
	LVjBtzgskXQHManCPyoT/FTBTDXaYiCRRMJXYMQIvXX3yoZUYcZ5LOPxuwtdhSJWQwX8rDisAv6
	SKgdGbNiDs1lQf/d03WcW0trrR5mRMROk58qiYft64ngZ4aYUtycFzk40k05u5ZXGDI/jl3hi32
	P9FFbC2b+V2BI86e4CKgOEJY24SBgy4j5sgpkvqun83ZD1ARDUfn4fKVZqK264+DEMy2wWxkwJH
	ILnHK4DRm0aCx1decG4Ic9U1/+L1xz3HrfJFZyfc4CFJUelY9yI/mbyZSUP77J6gH8LHtRknajV
	5I/j+kme14YuoYLuWd51YgYj/eFm3tDmCrg2E50AfTYED0xflSo81PtiZwl+EeuPM2UfikA==
X-Google-Smtp-Source: AGHT+IEg0qq6vVFcC8HtHbolYGh9JI2dm7wBds4DDkIYpwL5F/tmw9T7MssYibXngJRFYi8Fu+PtoA==
X-Received: by 2002:a05:690c:c14:b0:721:6b2e:a07f with SMTP id 00721157ae682-7216b2ea4cfmr2820057b3.24.1756381574661;
        Thu, 28 Aug 2025 04:46:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17354cdsm38508237b3.20.2025.08.28.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:46:13 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:46:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <20250828114613.GC2848932@perftesting>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
 <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>
 <aK-AQ6Xzkmz7zQ6X@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK-AQ6Xzkmz7zQ6X@dread.disaster.area>

On Thu, Aug 28, 2025 at 08:01:39AM +1000, Dave Chinner wrote:
> On Wed, Aug 27, 2025 at 02:32:49PM +0200, Christian Brauner wrote:
> > On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> > > We can end up with an inode on the LRU list or the cached list, then at
> > > some point in the future go to unlink that inode and then still have an
> > > elevated i_count reference for that inode because it is on one of these
> > > lists.
> > > 
> > > The more common case is the cached list. We open a file, write to it,
> > > truncate some of it which triggers the inode_add_lru code in the
> > > pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> > > it exists until writeback or reclaim kicks in and removes the inode.
> > > 
> > > To handle this case, delete the inode from the LRU list when it is
> > > unlinked, so we have the best case scenario for immediately freeing the
> > > inode.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > 
> > I'm not too fond of this particular change I think it's really misplaced
> > and the correct place is indeed drop_nlink() and clear_nlink().
> 
> I don't really like putting it in drop_nlink because that then puts
> the inode LRU in the middle of filesystem transactions when lots of
> different filesystem locks are held.
> 
> IF the LRU operations are in the VFS, then we know exactly what
> locks are held when it is performed (current behaviour). However,
> when done from the filesystem transaction context running
> drop_nlink, we'll have different sets of locks and/or execution
> contexts held for each different fs type.
> 
> > I'm pretty sure that the number of callers that hold i_lock around
> > drop_nlink() and clear_nlink() is relatively small.
> 
> I think the calling context problem is wider than the obvious issue
> with i_lock....

This is an internal LRU, so yes potentially we could have locking issues, but
right now all LRU operations are nested inside of the i_lock, and this is purely
about object lifetime. I'm not concerned about this being in the bowls of any
filesystem because it's purely list manipulation.

And if it makes you feel better, the next patchset queued up for after the next
merge window is deleting the LRU, so you won't have to worry about it for long
:).  Thanks,

Josef

