Return-Path: <linux-ext4+bounces-10456-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6FFBA5859
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 05:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24EB47AD296
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 02:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F0F21B9F1;
	Sat, 27 Sep 2025 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Q3gfDCKq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E12149E17
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758942089; cv=none; b=Dtm9bd96H/nSaXR3JSk8u7f6tOia9Mt7Fsa1QE+436A0PTYXXlSNMnd25B/riM06Y97n2qjfciOONcot6jhnU1o3zabIi3g71Bvcw4haOnoMunrlQQ6T8wP7g9uazPAGWiWjrIkuPIGTBDqfBnDuWfN4ZbQXmBI2I1QpB6W7pgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758942089; c=relaxed/simple;
	bh=iqEzu6MSOCS+4xe5CLs8SDXx79JrEPYtjCeDbWq9KhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO+KE+96AdBtnwekzQjZA5CT7n+z6k9uP9XUzThaVeJyBBggyoSBcGrrzaKLuaD4Iy0bNC6i0LQhggOEAdkSkteNz13RHxefRODIE2DcwNsiHj3pZl24RwDxaHrUy75VAUFQZJFRf/zcfXsR+6GNHvaCulIfAs4FMNV74B2zMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Q3gfDCKq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58R31D43016618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 23:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758942075; bh=7f/gHNEv1YusOJ53J0jDbxjcFQ7pwqP5o4dTkzgBhDk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Q3gfDCKqpmAlNw0hO1Q7K84mYKfb8+F7BQoGq8cwfoxwwnFc8b10ktK0jRhSHhja9
	 9EvFF0RDkmwc/EkAyxQT/swoZlQTrGb5ELM9i2mKF4IZFfdIJ5ZmJBF6daK4zS8DD+
	 qA0VC6L92w6dVHKFFPfP58atVBaw2Nqns/G3tk4Gwm6EAOMfEThoT94xStMUtd38TR
	 47i8mDPzecucrsw3+Iiuyd6o9qJWthBSAGAh66Fxx+cNsb7R9VwjQebkIGZVcYCTXS
	 DfN/x/OuXU0a6iP1ZlAFB6kJtH3Okw/eGzKd9Dp8SNIEwi2zR5XaaGtzflfJ3YtOFB
	 I4lTltXnMJCDQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 781462E00D9; Fri, 26 Sep 2025 23:01:13 -0400 (EDT)
Date: Fri, 26 Sep 2025 23:01:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Message-ID: <20250927030113.GD118657@mit.edu>
References: <20250927001815.16635-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927001815.16635-1-kartikey406@gmail.com>

On Sat, Sep 27, 2025 at 05:48:15AM +0530, Deepanshu Kartikey wrote:
> 
> Your -EAGAIN suggestion makes sense. The approach would be:
> 1. During memory reclaim, use GFP_NOFS without __GFP_NOFAIL
> 2. If allocation fails, return -EAGAIN to let reclaim skip this inode
> 3. Preallocation cleanup happens later when memory is available
> 
> I understand this requires modifying the function signature and updating all call 
> sites. I'm willing to do this work and properly test each caller's error handling. 
> 
> Questions on implementation:
> - Should callers like ext4_clear_inode() ignore -EAGAIN (leave cleanup for later)?

It's not so simple.  The call path that involes ext4_clear_inode() is
part of evict() which is called when the inode is evicted, and this is
called from prune_icache_sb():

   https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d

The problem is that none of the code paths allow for the inode
eviction to be delayed.  And once the inode is evicted, it's *gone*
from memory, so there's no place to store the information needed so we
can "clean up the inode later".

The inode eviction might *take* a while, since there might be pages
that need to be written back first.  And in order to do the writeback,
the flusher thread might need to do some block allocations, and that
might require some memory allocations.  But since that's happening on
another thread, it doesn't cause any warnings.

This is why in some sense the warning in __alloc_pages_slowpaths() is
a little silly, and it's not really all that bad in practice:

		/*
		 * PF_MEMALLOC request from this context is rather bizarre
		 * because we cannot reclaim anything and only can loop waiting
		 * for somebody to do a work for us.
		 */

Sure, we might need to loop waiting for someone to work to release
pages.  But in the inode eviction path, we are doing that *anyway*:

	/*
	 * Wait for flusher thread to be done with the inode so that filesystem
	 * does not start destroying it while writeback is still running. Since
	 * the inode has I_FREEING set, flusher thread won't start new work on
	 * the inode.  We just have to wait for running writeback to finish.
	 */
	inode_wait_for_writeback(inode);

(And writeback can require memory allocations. Oh, noos!)

In actual practice, it's not that bad, since looping until te memory
can be released is just *fine*.  The OOM killer might news to whack
some processes to free memory, but if you're running so close to the
memory exhaustion, it's generally acceptable to have lower priority
jobs get nuked in order to keep the system.  And if that's not
acceptable, then don't run the system that close to the edge!  :-)

So the only reason why this is a problem is if someone is silly enough
to run with panic on warn enabled.  (Don't do that.)  Or if you've
gotten sucked int the gamification of syzbot.  Personally, if the mm
folks want to insist on putting that WARN_ON_ONCE() there, I'm not
going to worry about the syzbot complaint.  :-)


If you *really* want to solve the problem, we probably need to have
some way to that file system set a flag indicating that if you are
trying to prunce the inode cache, and you're in a memory reclaim
context, skip trying to evict this inode.  For that matter, if we're
in a memory reclaim context, and the inode has dirty pages which are
being written back --- maybe we should just skip that inode since
there are probably easier and faster inodes to eject if we are so
desperate that we're in memory reclaim mode.

Another potential solution might be to pin the buddy bitmap and bitmap
blocks in meory and don't let them to get evicted if we know that
there might be preallocations pending for that partcular block group.
This will prevent the need to do the memory allocation, and also
avoids needing to do I/O to bring in the bitmap metadata.  The
downside is this increases memory usage, all in the name of trying to
avoid that silly mm warning.

Yet another possibility is to have a pool of spare pages *just* for
ext4, and in the case where we are in memory reclaim --- drop the
__GFP_NOFAIL, and use the pool of spare pagese --- and if the pool of
spare pages is exhausted, just wait and do a retry loop on the allocation.

Or we could just drop the __GFP_NOFAIL and just add hard-coded retry
loop.  It's what we used to do when the mm people tried to deprecate
__GFP_NOFAIL, and issued a warning whenever someone trid to use
__GFP_NOFAIL --- and so we said, "OK, if you really hate the
GFP_NOFAIL, we'll just open code the retry in the file system, since
data loss is unacceptable, and if that means the system might become
unresponsive for a bit when the system is under heavy memory pressure,
that's an acceptable tradeoff."  But then the mm folks said, no wait,
if you do the retry loop in the caller we won't know that the memory
allocation Really Really Needs to Suceed.  And so they dropped the
__GFP_NOFAIL warning, and we dropped the hard-coded retry loop.

> I'd like to implement this fix properly rather than leaving the WARNING unaddressed. 
> Could you provide guidance on the preferred error handling for the different caller 
> contexts?

Quite frankly, I'mm not sure any of these choices are worth it
compared to just leaving the WARNING unaddressed.

If it were up to me, I'd have a WARN_DONT_PANIC() message which
doesn't actually print the word "WARNING" so it doesn't trigger
syzbot, and which does't force a panic on warn.  That it satisfies the
mm folks who have never liked __GFP_NOFAIL, since they can let the
kernel whine; it satifies the people who think this is a "securty
problem" because there are people who are silly enough to do panic on
warn; it satisfies the people who buy into the syzbot gamification;
and it avoids file system corruption, which keeps the file system
people happy.

Or we could just drop this particular warning altogether.  Silly
warning.  :-)

Cheers,

						- Ted

