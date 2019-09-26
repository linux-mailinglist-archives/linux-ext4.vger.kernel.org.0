Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4704DBF454
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfIZNrN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Sep 2019 09:47:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:32786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfIZNrN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 26 Sep 2019 09:47:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84587AE2A;
        Thu, 26 Sep 2019 13:47:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 205B71E481F; Thu, 26 Sep 2019 15:47:26 +0200 (CEST)
Date:   Thu, 26 Sep 2019 15:47:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Joseph Qi <joseph.qi@linux.alibaba.com>,
        tytso@mit.edu, linux-ext4@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, adilger@dilger.ca, mbobrowski@mbobrowski.org,
        rgoldwyn@suse.de
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
Message-ID: <20190926134726.GA28555@quack2.suse.cz>
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
 <d1f3b048-d21c-67f1-09a3-dd2abf7c156d@linux.alibaba.com>
 <20190924151025.GD11819@quack2.suse.cz>
 <20190924194804.ED164A4040@d06av23.portsmouth.uk.ibm.com>
 <20190925092339.GB23277@quack2.suse.cz>
 <20190926123456.9B2984C044@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926123456.9B2984C044@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Thu 26-09-19 18:04:55, Ritesh Harjani wrote:
> On 9/25/19 2:53 PM, Jan Kara wrote:
> > On Wed 25-09-19 01:18:04, Ritesh Harjani wrote:
> > > > read takes i_rwsem exclusive lock instead of shared, it is a win for your
> > > > workload... Argh, now checking code in fs/direct-io.c I think I can see the
> > > > difference. The trick in do_blockdev_direct_IO() is:
> > > > 
> > > >           if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
> > > >                   inode_unlock(dio->inode);
> > > >           if (dio->is_async && retval == 0 && dio->result &&
> > > >               (iov_iter_rw(iter) == READ || dio->result == count))
> > > >                   retval = -EIOCBQUEUED;
> > > >           else
> > > >                   dio_await_completion(dio);
> > > > 
> > > > So actually only direct IO read submission is protected by i_rwsem with
> > > > DIO_LOCKING. Actual waiting for sync DIO read happens with i_rwsem dropped.
> > > > 
> > > > After some thought I think the best solution for this is to just finally
> > > > finish the conversion of ext4 so that dioread_nolock is the only DIO path.
> > > 
> > > Sorry, I still didn't get this completely. Could you please explain a bit
> > > more?
> > 
> > Well, currently we have two different locking schemes for DIO - the
> > "normal" case and the "dioread_nolock" case. And the "normal" case really
> > only exists because buffered writeback needed to be more careful (so that
> > nolock DIO cannot expose stale data) and nobody did the effort to make that
> > work when blocksize < pagesize. But having two different locking schemes
> > for DIO is really confusing to users and a maintenance burden so we want to
> > get rid of the old scheme once the "dioread_nolock" scheme works for all
> > the configurations.
> 
> Agreed.
> 
> > > > With i_rwsem held in shared mode even for "unlocked" DIO, it should be
> > > > actually relatively simple and most of the dances with unwritten extents
> > > > shouldn't be needed anymore.
> > > 
> > > Again, maybe it's related to above comment. Could you please give some
> > > insights?
> > 
> > Now that we hold i_rwsem in shared mode for all of DIO, it isn't really
> > "unlocked" anymore. Which actually very much limits the races with buffered
> > writes and thus page writeback (because we flush page cache before doing
> > DIO).
> 
> So looking at the code again based on your inputs from above, we should
> be able to remove this condition <snip below> in ext4_dio_write_checks.
> 
> What I meant is, in DIO writes path we can start with shared lock
> (which the current patch is doing), and only check for below conditions
> <snip below> for it to continue using shared lock.
> (i.e. we need not check for ext4_should_dioread_nolock(inode) anymore).
> 
> That means there should not be any race for non-extent based mode
> too right?

Yes, that is correct. But please do this as a separate change with good
explanation of why this is OK.

> Because for overwrites in DIO (for both extents & non-extents)-
> (just reiterating)
> 
> 1. Race against bufferedIO writes and DIO overwrites will be protected
> via SHARED inode lock in DIO overwrites & EXCL lock in bufferedIO
> writes. Plus we flush page cache before doing DIO.
> 
> 2. Race against bufferedIO reads & DIO overwrites will be anyway protected
> since we don't do any block allocations during DIO overwrite.
> 
> 3. Again race against DIO reads & DIO overwrites is not be a problem,
> since no block allocation is done anyway. So no stale data will be
> exposed.
> 
> 
> <snip of change we should do in ext4_dio_write_checks>
> 
>         if (*iolock == EXT4_IOLOCK_SHARED &&
>             (!IS_NOSEC(inode) || *unaligned_io || *extend ||
> -            !ext4_should_dioread_nolock(inode) ||
>              !ext4_overwrite_io(inode, offset, count))) {
>                 ext4_iunlock(inode, *iolock);
>                 *iolock = EXT4_IOLOCK_EXCL;
>                 ext4_ilock(inode, *iolock);
>                 goto restart;
>         }
> 
> > 
> > > Or do you mean that we should do it like this-
> > > So as of now in dioread_nolock, we allocate blocks, mark the entry into
> > > extents as unwritten, then do the data IO, and then finally do the
> > > conversion of unwritten to written extents.
> > 
> > So this allocation of extents as unwritten in dioread_nolock mode is now
> > mostly unnecessary. We hold i_rwsem for reading (or even for writing) while
> > submitting any DIO. Because we flush page cache before starting DIO and new
> > pages cannot be dirtied by buffered writes (i_rwsem), DIO cannot be racing
> > with page writeback and thus cannot expose stale block contents. There is
> > one exception though - which is why I wrote "mostly" above - pages can
> > still be dirtied through memory mappings (there's no i_rwsem protection for
> > mmap writes) and thus races with page writeback exposing stale data are still
> > theoretically possible. In fact the "normal" DIO mode has this kind of race
> > all the time ext4 exists.
> 
> Yes, now that you said I could see this below race even with current
> code. Any other race too?
> 
> i.e.
> ext4_dio_read			ext4_page_mkwrite()
> 
>     filemap_write_and_wait_range()
> 				     ext4_get_blocks()
> 
>     submit_bio
>     // this could expose the stale data.
> 		
> 				     mark_buffer_dirty()

Yes, this is what I meant. Although note that in most cases
ext4_get_blocks() from ext4_page_mkwrite() will just reserve delalloc
blocks so you additionally need writeback to happen on that inode to
allocate delalloc block and only after that call of ext4_iomap_begin() +
submit_bio() from iomap_dio_rw() will be able to expose stale data. So I
don't think the race is very easy to trigger.

> Ok. I guess we cannot use any exclusive inode lock in ext4_page_mkwrite,
> because then we loose the parallelism that it offers right now.
> Wonder how other FS protect this race (like XFS?)

You cannot get i_rwsem at all in ext4_page_mkwrite() because mm code
holds mmap_sem when calling into ext4_page_mkwrite(). And mmap_sem ranks
below i_rwsem. And the deadlock is actually real because e.g. direct IO
code holds i_rwsem and then grabs mmap_sem as part of
bio_iov_iter_get_pages().

XFS always uses unwritten extents when writing out pages which prevents
this race.

> > I guess we could fix this by falling back to page writeback using unwritten
> > extents when we have dirty pages locked for writeback and see there's any
> > DIO in flight for the inode. Sadly that means we we cannot get rid of
> > writeback code using unwritten extents but at least it won't be hurting
> > performance in the common case.
> 
> 1. So why to check for dirty pages locked for writeback (in
> ext4_page_mkwrite)? we anyway lock the page which we modify or
> allocate block for. So race against bufferedRead should not happen.
> 
> 2. And even if we check for inode_dio_wait(), we still can't gurantee
> that the next DIO may not snoopin while we are in ext4_page_mkwrite?
> 
> I am definitely missing something here.

I was speaking about code in ext4_writepages(). The block mapping in
ext4_page_mkwrite() can always use unwritten extents - that is just a
fallback path in case delayed allocation is disabled or we are running out
of disk space. The code in ext4_writepages() needs to decide whether to
writeback using unwritten extents or we can use normal ones. And in that
place I suggest replacing current "ext4_should_dioread_nolock()" check with
"is there any dio in flight against the inode?". And to make the check
reliable (without holding i_rwsem), you need to do it only after you have
all pages locked for writeback.

> > > So instead of that we first only reserve the disk blocks, (without
> > > making any on-disk changes in extent tree), do the data IO and then
> > > finally make an entry into extent tree on disk. And going
> > > forward only keep this as the default path.
> > > 
> > > The above is something I have been looking into for enabling
> > > dioread_nolock for powerpc platforms where blocksize < page_size.
> > > This is based upon an upstream discussion between Ted and you :)
> > 
> > Yes, this is even better solution to dioread_nolock "problem" but it is
> > also more work
> 
> Yes, I agree that we should do this incrementally.
> 
> > then just dropping the old DIO locking mode and
> > fix writeback using unwritten extents for blocksize < pagesize.
> 
> 
> So, I was looking into this (to support dioread_nolock for
> blocksize < pagesize) but I could not find any history in git,
> nor any thread which explains the problem.

Yeah, part of the problem is that we have only a rough understanding of
what actually the problem is :)

> I got below understanding while going over code -
> 
> 1. This problem may be somehow related to bufferheads in the
> extent conversion from unwritten to written in writeback path.
> But I couldn't see what exactly is the issue there?
> 
> I see that the completion path happens via
> ext4_end_io
>    |- ext4_convert_unwritten_extents() // offset & size is properly taken
> care.
>    |- ext4_release_io_end() (which is same in both DIO & writeback).
> 
> 
> 2. One thing which I noticed is the FIXME in
> mpage_map_and_submit_buffers(). Where we
> io->io_end->size we add the whole PAGE_SIZE.
> I guess we should update the size here carefully
> based on buffer_heads.
> 
> Could you please give some pointers as to what
> is the limitation. Or some hint which I can go
> and check by myself.

You are correct that the problem is in ext4_writepages() (and functions
called from there). Essentially the whole code there needs verification
whether unwritten extent handling works correctly when blocksize <
pagesize. As you noted, there are couple of FIXMEs there where I was aware
that things would break but there may be other problems I've missed.
I remember things can get really complex there when there are multiple
unwritten extents underlying the page and we need to write them out.

> > > But even with above, in case of extending writes, we still
> > > will have to zero out those extending blocks no? Which
> > > will require an exclusive inode lock anyways for zeroing.
> > > (same which has been done in XFS too).
> > 
> > Yes, extending writes are a different matter.
> > 
> > > So going with current discussed solution of mounting with
> > > dioread_nolock to provide performance scalability in mixed read/write
> > > workload should be also the right approach, no?
> > > Also looking at the numbers here [3] & [4], this patch also seems
> > > to improve the performance with dioread_nolock mount option.
> > > Please help me understand your thoughts on this.
> > 
> > Yes, your patches are definitely going in the right direction. What I'm
> > discussing is mostly how to make ext4 perform well for mixed read/write
> > workload by default without user having to use magic mount option.
> 
> Really thanks for your support here.
> 
> So can we get these patches upstream incrementally?
> i.e.
> 1. As a first step, we can remove this condition
> ext4_should_dioread_nolock from the current patchset
> (as mentioned above too) &  get this patch rebased
> on top of iomap pathset. We should be good to merge
> this patchset then, right? Since this should be able
> to improve the performance even without dioread_nolock
> mount option.

Yes, correct.

> 2. Meanwhile I will continue to check for blocksize < pagesize
> requirement for dioread_nolock. We can follow the plan
> as you mentioned above then.

Good.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
