Return-Path: <linux-ext4+bounces-4011-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7C969D03
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 14:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FF01C23B1F
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2024 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA8A1C9853;
	Tue,  3 Sep 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PsMcUtNh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1119F42F
	for <linux-ext4@vger.kernel.org>; Tue,  3 Sep 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365353; cv=none; b=sFgvPD1sj7zMbX4N/L/wVs4E31B8t+uT/o3XjjmUsTMvCUcnEyaX/8+VwR8otMfX3V15JJ2YR6TJVTLJXGwAvAgKzc9g0Z/9xbWRVGRg3C/KUj46hOlZ+wBBVEXaUWD7xiUhizCie/WNCCf7Q5m8oiGj23y1nIX3L/W8Fzkl7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365353; c=relaxed/simple;
	bh=FuldmmtFdPC+wAYHdv/1mRuo2K3eRTALSRwCK32AJ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghzO5m2K1QnvuoW/5vqdYJNTGwJjykE5DFsF06De5x3LZ0wfBkzu0xbWYG3wfSuCmJxmgln7tVfZkXtIJG7JGv6l9etDeSMhQp5RM4P0LE+beABB7YqyruxPD55f2DxHXgZQDSnAx7x4q8Y49OEjtsmJ7xNwqW/LhFyvHYIED1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PsMcUtNh; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 483C8eJg010291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 08:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725365324; bh=wvFsCU0TSej2kLdx1KJ3MyVCSDOw5N9vk9JSJj72amI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PsMcUtNhHJdT1ZIcuDY36+q+TRDoNJYV78+ps5hfNiXONgLYuWJOkNOPvgf35wZsc
	 c85V7ZQR74NYWPf2Rfo2Cy2OqEZw0QxFKs3sUXMju6idz+eEt+s2BOgHRzelrndypR
	 l56J/8Q68uvE0ayMT8pLnp21py8P/RaIx31PZ9NuP9LsdbdmXmTjYVU4B4U4R5Z9c+
	 vw8l8rm5eEGfaZmd8dLc4buAw14uLMCtNxgLOtAGcCbwhyzrvw9d35LzaE/l3b+dZd
	 S9q1iR+Guqv3te4pJG+jCwWtF+smy/Ujj4gk5vyw6hwNg2Wuy91KgG8dukz/z/rsFq
	 PbAHuGq64kmrA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5CD2215C02C4; Tue, 03 Sep 2024 08:08:40 -0400 (EDT)
Date: Tue, 3 Sep 2024 08:08:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        steve.kang@unisoc.com
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
Message-ID: <20240903120840.GD424729@mit.edu>
References: <20240823082237.713543-1-zhaoyang.huang@unisoc.com>
 <20240903022902.GP9627@mit.edu>
 <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>

On Tue, Sep 03, 2024 at 04:50:46PM +0800, Zhaoyang Huang wrote:
> > I'd also sugest only trying to use this is the file system has
> > journaling enabled.  If the file system is an ext2 file system without
> > a journal, there's no reason avoid using the CMA region
> agree.
> > assume the reason why the buffer cache is trying to use the moveable
> > flag is because the amount of non-CMA memory might be a precious
> > resource in some systems.
>  
> I don't think so. All migrate type page blocks possess the same
> position as each other as they could fallback to all migrate types
> when current fails. I guess the purpose could be to enlarge the scope
> of available memory as __GFP_MOVEABLE has the capability of recruiting
> CMA.

Well, I guess I'm a bit confused why the buffer cache is trying to use
__GFP_MOVEABLE in the first place.  In general CMA is to allow systems
to be able to allocate big chunks of memory which have to be
physically contiguous because the I/O device(s) are too primitive to
be able to do scatter-gather, right?  So why are we trying to use CMA
eligible memory for 4k buffer cache pages?  Presumably, because
there's not enough non-CMA eligible memory?

After all, using GFP_MOVEABLE memory seems to mean that the buffer
cache might get thrashed a lot by having a lot of cached disk buffers
getting ejected from memory to try to make room for some contiguous
frame buffer memory, which means extra I/O overhead.  So what's the
upside of using GFP_MOVEABLE for the buffer cache?

Just curious, because in general I'm blessed by not having to use CMA
in the first place (not having I/O devices too primitive so they can't
do scatter-gather :-).  So I don't tend to use CMA, and obviously I'm
missing some of the design considerations behind CMA.  I thought in
general CMA tends to used in early boot to allocate things like frame
buffers, and after that CMA doesn't tend to get used at all?  That's
clearly not the case for you, apparently?

Cheers,

							- Ted

