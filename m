Return-Path: <linux-ext4+bounces-10691-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6FBC604C
	for <lists+linux-ext4@lfdr.de>; Wed, 08 Oct 2025 18:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57A019E2995
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Oct 2025 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55542291C1E;
	Wed,  8 Oct 2025 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="lQj3x4mp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DE2BDC02
	for <linux-ext4@vger.kernel.org>; Wed,  8 Oct 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940848; cv=none; b=uaB3bQ+AGmgTvfwgeCJ9v9Q9GZ9zVkwQh4w0Q1siRw8JQICV9NgyDGiAual0kl/h8fwGHScuk2uXj4vM7nsId6TJ/A7WtUrMrOGRJNheJO0EvOxM1CZlH8NmNRTvkQJKSPonr7p0ucj332DUZloWHx6NMBnQaHsQXv6jIYHwzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940848; c=relaxed/simple;
	bh=Zq1tEArlsEXQW5eo5xbpfqLn2xRxba9VuPsiYdeTKqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ0rDhKTYw4tgRs3srT2/n/a/VAOln6AYL3KkBza3+TTakXFxpm/pTiBGk3EVIh/3t2C/eC99rmzBHJ28RFET32kUSraAWBNjKFWG6Npxfb6j75PdfVX0E1NPj6SYNER7JYyN2bUzJRTihshiOlygYIEtt9i8WFNnAhIoFvsm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=lQj3x4mp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-192.bstnma.fios.verizon.net [173.48.102.192])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 598GQtnk004046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 12:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759940818; bh=FCNB/7DTe1EWiGD4bUa1fSOu0PJxVjz3p4YNDqmutQ4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=lQj3x4mpTVV71WA8iDQZOiOEa6huH2ThKIeMXaudULqBtg6mqTk5n71201FyQAeXH
	 0Vsikq7SkfBAbrQ9qpIUyjvOLpydg+J75aWzwEQN0cBZzFaTn8Mmeoa8s9q/k6X5m1
	 a1vy8pdFmIyTzlRW5reka5bZPh0PgKtZyvyGJxWPtO0+cSYhdlq7TGsPer3slMAa/k
	 79c7nzeDgmrvYWuqCobc7oPfMhiagxXESQesTkxGBxbgP9t0BBUolQmgof+34Lr24p
	 lgIJipNbOtBWT8KRo+NRX29UU7AzPyvn/TvpOCTGMXtV9PL/fjrcPIfoZvrovSmbUT
	 kNtf3JSr3FGiw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 576402E00D9; Wed, 08 Oct 2025 12:26:55 -0400 (EDT)
Date: Wed, 8 Oct 2025 12:26:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Fleming <matt@readmodwrite.com>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251008162655.GB502448@mit.edu>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008150705.4090434-1-matt@readmodwrite.com>

On Wed, Oct 08, 2025 at 04:07:05PM +0100, Matt Fleming wrote:
> > 
> > These machines are striped and are using noatime:
> > 
> > $ grep ext4 /proc/mounts
> > /dev/md127 /state ext4 rw,noatime,stripe=1280 0 0
> > 
> > Is there some tunable or configuration option that I'm missing that
> > could help here to avoid wasting time in
> > ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
> > fail an order 9 allocation anyway?

Can you try disabling stripe parameter?  If you are willing to try the
latest mainline kernel, there are some changes that *might* make a
different, but RAID stripe alignment has been causing problems.

In fact, in the latest e2fsprogs release, we have added this change:

commit b61f182b2de1ea75cff935037883ba1a8c7db623
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sun May 4 14:07:14 2025 -0400

    mke2fs: don't set the raid stripe for non-rotational devices by default
    
    The ext4 block allocator is not at all efficient when it is asked to
    enforce RAID alignment.  It is especially bad for flash-based devices,
    or when the file system is highly fragmented.  For non-rotational
    devices, it's fine to set the stride parameter (which controls
    spreading the allocation bitmaps across the RAID component devices,
    which always makessense); but for the stripe parameter (which asks the
    ext4 block alocator to try _very_ hard to find RAID stripe aligned
    devices) it's probably not a good idea.
    
    Add new mke2fs.conf parameters with the defaults:
    
    [defaults]
       set_raid_stride = always
       set_raid_stripe = disk
    
    Even for RAID arrays based on HDD's, we can still have problems for
    highly fragmented file systems.  This will need to solved in the
    kernel, probably by having some kind of wall clock or CPU time
    limitation for each block allocation or adding some kind of
    optimization which is faster than using our current buddy bitmap
    implementation, especially if the stripe size is not multiple of a
    power of two.  But for SSD's, it's much less likely to make sense even
    if we have an optimized block allocator, because if you've paid $$$
    for a flash-based RAID array, the cost/benefit tradeoffs of doing less
    optimized stripe RMW cycles versus the block allocator time and CPU
    overhead is harder to justify without a lot of optimization effort.
    
    If and when we can improve the ext4 kernel implementation (and it gets
    rolled out to users using LTS kernels), we can change the defaults.
    And of course, system administrators can always change
    /etc/mke2fs.conf settings.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

							- Ted

