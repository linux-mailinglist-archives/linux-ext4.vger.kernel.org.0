Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D6C218C8E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgGHQJU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 12:09:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:40340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgGHQJU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Jul 2020 12:09:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BAA9ACC6;
        Wed,  8 Jul 2020 16:09:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED86D1E12BF; Wed,  8 Jul 2020 18:09:17 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:09:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/1] ext4: fix potential negative array index in
 do_split()
Message-ID: <20200708160917.GC5288@quack2.suse.cz>
References: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
 <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
 <20200619064122.vj346xptid5viogv@work>
 <04a5b98c-4bb7-4861-76c3-dd0b0c6a6610@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04a5b98c-4bb7-4861-76c3-dd0b0c6a6610@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 19-06-20 08:39:53, Eric Sandeen wrote:
> On 6/19/20 1:41 AM, Lukas Czerner wrote:
> > On Wed, Jun 17, 2020 at 02:19:04PM -0500, Eric Sandeen wrote:
> >> If for any reason a directory passed to do_split() does not have enough
> >> active entries to exceed half the size of the block, we can end up
> >> iterating over all "count" entries without finding a split point.
> >>
> >> In this case, count == move, and split will be zero, and we will
> >> attempt a negative index into map[].
> >>
> >> Guard against this by detecting this case, and falling back to
> >> split-to-half-of-count instead; in this case we will still have
> >> plenty of space (> half blocksize) in each split block.
> 
> ...
> 
> >> +	/*
> >> +	 * map index at which we will split
> >> +	 *
> >> +	 * If the sum of active entries didn't exceed half the block size, just
> >> +	 * split it in half by count; each resulting block will have at least
> >> +	 * half the space free.
> >> +	 */
> >> +	if (i > 0)
> >> +		split = count - move;
> >> +	else
> >> +		split = count/2;
> > 
> > Won't we have exactly the same problem as we did before your commit
> > ef2b02d3e617cb0400eedf2668f86215e1b0e6af ? Since we do not know how much
> > space we actually moved we might have not made enough space for the new
> > entry ?
> 
> I don't think so - while we don't have the original reproducer, I assume that
> it was the case where the block was very full, and splitting by count left us
> with one of the split blocks still over half full (because ensuring that we
> split in half by size seemed to fix it)
> 
> In this case, the sum of the active entries was <= half the block size.
> So if we split by count, we're guaranteed to have >= half the block size free
> in each side of the split.
>  
> > Also since we have the move == count when the problem appears then it's
> > clear that we never hit the condition
> > 
> > 1865 →       →       /* is more than half of this entry in 2nd half of the block? */
> > 1866 →       →       if (size + map[i].size/2 > blocksize/2)
> > 1867 →       →       →       break;
> > 
> > in the loop. This is surprising but it means the the entries must have
> > gaps between them that are small enough that we can't fit the entry
> > right in ? Should not we try to compact it before splitting, or is it
> > the case that this should have been done somewhere else ?
> 
> Yes, that's exactly what happened - see my 0/1 cover letter.  Maybe that should
> be in the patch description itself.  ALso, yes compaction would help but I was
> unclear as to whether that should be done here, is the side effect of some other
> bug, etc.  In general, we do seem to do compaction elsewhere and I don't know
> how we got to this point.
> 
> > If we really want ot be fair and we want to split it right in the middle
> > of the entries size-wise then we need to keep track of of sum of the
> > entries and decide based on that, not blocksize/2. But maybe the problem
> > could be solved by compacting the entries together because the condition
> > seems to rely on that.
> 
> I thought about that as well, but it took a bit more code to do; we could make
> make_map() return both count and total size, for example.  But based on my
> theory above that both sides of the split will have >= half block free, it
> didn't seem necessary, particularly since this seems like an edge case?

This didn't seem to conclude in any way? The patch looks good to me FWIW so
feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Ted, can you please pick this patch up? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
