Return-Path: <linux-ext4+bounces-12160-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD5ACA6041
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 04:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0BD431A1F96
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BCD224AEF;
	Fri,  5 Dec 2025 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PcIWg4aH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711A1E8337;
	Fri,  5 Dec 2025 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905618; cv=none; b=SJ+/DLcvUgyXiQk68Gb3YBidp2F3ER5sycpB8q6tmXNkO5wkicIdIy0XSEdPJ1F2YL+Xf0d1bpD/ONA0/v7327BPu6kK7RNbdLsxWy7jRtsaUc4KV45XwuHKJVaLYtVoTmeHXBeUxR9XZnh8URRnz+g1zoxcSaOIihDnN01MPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905618; c=relaxed/simple;
	bh=2ewsx66uenujfSIiO9Kdqb/OhgK41F8wU+iGd8Kd5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJDFK1kDCfrwqI39y0GUj7HtQNFjOH6mz3lb0Eia4+gm+XjkplZbEzR3e4tQS3AUrLnxc4P/PYdygAkeFyn71GX/Cx6CcnuuvhdUzmpCX0zuK/IGcpPnH1lj/GKm3gH6ykb2YzoFLjxI5KRkOD1MpyU2na4nRaCRORFzIFNcVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PcIWg4aH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eueYsZMEHlubpG8iyWTLw6s+BjJJ1J10gahIW6LgMEE=; b=PcIWg4aHlE9YQI7kYYEs2P3tk/
	7Et2rtd3mKyw9QQGvgHH+tnxdrO/MaHfjXBbfAA6sxD8uTKY+o1GzLHVRk2VUcC0kW2iy0Kd9SvMt
	QAybghnVL3cQxGidvcoHQXiW3lNaPhJwSyu1fx7GPSaZo+onxTVt/8cZxaYZNzazSm3lGFYmsosaS
	vaJGaKBVjBsC+GOK57JROirUM2ZcC3PJNVRLFrnVhq1yR/c9tNOGFGP8ty8RHRYULIENSpLuZPSvx
	geIULCbiZUHZevvfCR4Km9nY+NSHzqjvHF4cXYfpV0kTyPTuRsb3hrewtl+nycGnfGpBKshyjlqXO
	XO9JucyA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRMZO-000000056eD-17bQ;
	Fri, 05 Dec 2025 03:33:22 +0000
Date: Fri, 5 Dec 2025 03:33:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, djwong@kernel.org
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <aTJSglQznqeph5lM@casper.infradead.org>
References: <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
 <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan>
 <aTCtITpW9yLNm2hz@casper.infradead.org>
 <20251203223300.GB71988@macsyma.lan>
 <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>
 <20251205021818.GF71988@macsyma.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205021818.GF71988@macsyma.lan>

On Thu, Dec 04, 2025 at 09:18:18PM -0500, Theodore Tso wrote:
> On Thu, Dec 04, 2025 at 03:24:50PM +0530, Deepanshu Kartikey wrote:
> > Based on Matthew's earlier feedback that we need to "prevent !uptodate
> > folios from being referenced by the page tables," I believe the
> > correct fix is not in ext4_page_mkwrite() at all, but rather in
> > mpage_release_unused_pages().
> > 
> > When we invalidate folios due to writeback failure, we should also
> > unmap them from page tables....
> 
> Hmm.... if the page is mmap'ed into the user process, on a writeback
> failure, the page contents will suddenly and without any warning,
> *disappear*.

It sounds like I was confused -- I thought the folios being invalidated 
in mpage_release_unused_pages() belonged to the block device, but from 
what you're saying, they belong to a user-visible file?

Once we hit a writeback error (whether we're in a "device gave EIO" or
"filesystem is corrupted" situation), we're firmly outside what POSIX 
speaks to, and so all that matters is quality of implementation.

Now, is the folio necessarily dirty at this point?  I guess so if we're
in the writeback path.  Darrick got rid of similar code in iomap a few 
years ago; see commit e9c3a8e820ed.  So it'd probably be good to have
ext4 behave the same way.

> So the other option is we could simply *not* invalidate the folio, but
> instead leave the folio dirty.  In some cases, where a particular
> block group is corrupted, if we retry the block allocation, the
> corrupted block group will be busied out, and so when the write back
> is retried, it's possible that the data will be actually be persisted.
> 
> We do need to make sure the right thing we unmount the filesystem,
> since at that point, we have no choice but the invalidate the page and
> the data will get lost when the file system is unmounted.  So it's a
> more complicated approach.  But if this is happening when the file
> system is corrupted, especially if it was maliciously corrupted, all
> bets are off anyway, so maybe it's not worth the complexity.

I'm generally in favour of doing anything we can to write dirty user
data back to storage ;-)  Of course if the storage is throwing a wobbly,
that's beyond our abilities.

