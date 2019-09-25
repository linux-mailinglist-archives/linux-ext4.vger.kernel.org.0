Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000B4BDADB
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2019 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfIYJX0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Sep 2019 05:23:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:43536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbfIYJXZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Sep 2019 05:23:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A163BB893;
        Wed, 25 Sep 2019 09:23:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 53FF31E481F; Wed, 25 Sep 2019 11:23:39 +0200 (CEST)
Date:   Wed, 25 Sep 2019 11:23:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Joseph Qi <joseph.qi@linux.alibaba.com>,
        tytso@mit.edu, linux-ext4@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org, adilger@dilger.ca, mbobrowski@mbobrowski.org,
        rgoldwyn@suse.de
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
Message-ID: <20190925092339.GB23277@quack2.suse.cz>
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
 <d1f3b048-d21c-67f1-09a3-dd2abf7c156d@linux.alibaba.com>
 <20190924151025.GD11819@quack2.suse.cz>
 <20190924194804.ED164A4040@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924194804.ED164A4040@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 25-09-19 01:18:04, Ritesh Harjani wrote:
> > read takes i_rwsem exclusive lock instead of shared, it is a win for your
> > workload... Argh, now checking code in fs/direct-io.c I think I can see the
> > difference. The trick in do_blockdev_direct_IO() is:
> > 
> >          if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
> >                  inode_unlock(dio->inode);
> >          if (dio->is_async && retval == 0 && dio->result &&
> >              (iov_iter_rw(iter) == READ || dio->result == count))
> >                  retval = -EIOCBQUEUED;
> >          else
> >                  dio_await_completion(dio);
> > 
> > So actually only direct IO read submission is protected by i_rwsem with
> > DIO_LOCKING. Actual waiting for sync DIO read happens with i_rwsem dropped.
> > 
> > After some thought I think the best solution for this is to just finally
> > finish the conversion of ext4 so that dioread_nolock is the only DIO path.
> 
> Sorry, I still didn't get this completely. Could you please explain a bit
> more?

Well, currently we have two different locking schemes for DIO - the
"normal" case and the "dioread_nolock" case. And the "normal" case really
only exists because buffered writeback needed to be more careful (so that
nolock DIO cannot expose stale data) and nobody did the effort to make that
work when blocksize < pagesize. But having two different locking schemes
for DIO is really confusing to users and a maintenance burden so we want to
get rid of the old scheme once the "dioread_nolock" scheme works for all
the configurations.
 
> > With i_rwsem held in shared mode even for "unlocked" DIO, it should be
> > actually relatively simple and most of the dances with unwritten extents
> > shouldn't be needed anymore.
> 
> Again, maybe it's related to above comment. Could you please give some
> insights?

Now that we hold i_rwsem in shared mode for all of DIO, it isn't really
"unlocked" anymore. Which actually very much limits the races with buffered
writes and thus page writeback (because we flush page cache before doing
DIO).

> Or do you mean that we should do it like this-
> So as of now in dioread_nolock, we allocate blocks, mark the entry into
> extents as unwritten, then do the data IO, and then finally do the
> conversion of unwritten to written extents.

So this allocation of extents as unwritten in dioread_nolock mode is now
mostly unnecessary. We hold i_rwsem for reading (or even for writing) while
submitting any DIO. Because we flush page cache before starting DIO and new
pages cannot be dirtied by buffered writes (i_rwsem), DIO cannot be racing
with page writeback and thus cannot expose stale block contents. There is
one exception though - which is why I wrote "mostly" above - pages can
still be dirtied through memory mappings (there's no i_rwsem protection for
mmap writes) and thus races with page writeback exposing stale data are still
theoretically possible. In fact the "normal" DIO mode has this kind of race
all the time ext4 exists.

I guess we could fix this by falling back to page writeback using unwritten
extents when we have dirty pages locked for writeback and see there's any
DIO in flight for the inode. Sadly that means we we cannot get rid of
writeback code using unwritten extents but at least it won't be hurting
performance in the common case.

> So instead of that we first only reserve the disk blocks, (without
> making any on-disk changes in extent tree), do the data IO and then
> finally make an entry into extent tree on disk. And going
> forward only keep this as the default path.
> 
> The above is something I have been looking into for enabling
> dioread_nolock for powerpc platforms where blocksize < page_size.
> This is based upon an upstream discussion between Ted and you :)

Yes, this is even better solution to dioread_nolock "problem" but it is
also more work then just dropping the old DIO locking mode and fix
writeback using unwritten extents for blocksize < pagesize.
 
> But even with above, in case of extending writes, we still
> will have to zero out those extending blocks no? Which
> will require an exclusive inode lock anyways for zeroing.
> (same which has been done in XFS too).

Yes, extending writes are a different matter.

> So going with current discussed solution of mounting with
> dioread_nolock to provide performance scalability in mixed read/write
> workload should be also the right approach, no?
> Also looking at the numbers here [3] & [4], this patch also seems
> to improve the performance with dioread_nolock mount option.
> Please help me understand your thoughts on this.

Yes, your patches are definitely going in the right direction. What I'm
discussing is mostly how to make ext4 perform well for mixed read/write
workload by default without user having to use magic mount option.

> [3] - https://marc.info/?l=linux-ext4&m=156921748126221&w=2
> [4] - https://raw.githubusercontent.com/riteshharjani/LinuxStudy/master/ext4/fio-output/vanilla-vs-ilocknew-randrw-dioread-nolock-4K.png


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
