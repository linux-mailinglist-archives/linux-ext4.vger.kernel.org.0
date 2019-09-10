Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E14AF2BB
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 23:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfIJV5X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 17:57:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbfIJV5X (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Sep 2019 17:57:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82253ABB2;
        Tue, 10 Sep 2019 21:57:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA5781E43AC; Tue, 10 Sep 2019 23:57:20 +0200 (CEST)
Date:   Tue, 10 Sep 2019 23:57:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, hch@infradead.org,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3] Revert parallel dio reads
Message-ID: <20190910215720.GA7561@quack2.suse.cz>
References: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
 <20190827115118.GY7777@dread.disaster.area>
 <20190829105858.GA22939@quack2.suse.cz>
 <20190910141041.134674C072@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910141041.134674C072@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Tue 10-09-19 19:40:40, Ritesh Harjani wrote:
> > > Before doing this, you might want to have a chat and co-ordinate
> > > with the folks that are currently trying to port the ext4 direct IO
> > > code to use the iomap infrastructure:
> > > 
> > > https://lore.kernel.org/linux-ext4/20190827095221.GA1568@poseidon.bobrowski.net/T/#t
> > > 
> > > That is going to need the shared locking on read and will work just
> > > fine with shared locking on write, too (it's the code that XFS uses
> > > for direct IO). So it might be best here if you work towards shared
> > > locking on the write side rather than just revert the shared locking
> > > on the read side....
> > 
> > Yeah, after converting ext4 DIO path to iomap infrastructure, using shared
> > inode lock for all aligned non-extending DIO writes will be easy so I'd
> > prefer if we didn't have to redo the iomap conversion patches due to these
> > reverts.
> 
> I was looking into this to see what is required to convert this into
> shared locking for DIO write side.
> Why do you say shared inode lock only for *aligned non-extending DIO
> writes*?
> non-extending means overwrite case only, which still in today's code is
> not under any exclusive inode_lock (except the orphan handling and truncate
> handling in case of error after IO is completed). But even with
> current code the perf problem is reported right?

Yes, the problem is even with current code. It is that we first acquire
inode_rwsem in exclusive mode in ext4_file_write_iter() and only later
relax that to no lock later. And this is what is causing low performance
for mixed read-write workload because the exclusive lock has to wait for
all shared holders and vice versa...

> If we see in today's code (including in iomap new code for overwrite case
> where we downgrade the lock).
> We call for inode_unlock in case of overwrite and then do the IO, since we
> don't have to allocate any blocks in this case.
> 
> 
> 	/*
> 	 * Make all waiters for direct IO properly wait also for extent
> 	 * conversion. This also disallows race between truncate() and
> 	 * overwrite DIO as i_dio_count needs to be incremented under
>  	 * i_mutex.
> 	 */
> 	inode_dio_begin(inode);
> 	/* If we do a overwrite dio, i_mutex locking can be released */
> 	overwrite = *((int *)iocb->private);
> 	if (overwrite)
> 		inode_unlock(inode);
> 	
> 	write data (via __blockdev_direct_IO)
> 
> 	inode_dio_end(inode);
> 	/* take i_mutex locking again if we do a ovewrite dio */
> 	if (overwrite)
> 		inode_lock(inode);
> 
> 
> 
> What can we do next:-
> 
> Earlier the DIO reads was not having any inode_locking.
> IIUC, the inode_lock_shared() in the DIO reads case was added to
> protect the race against reading back uninitialized/stale data for e.g.
> in case of truncate or writeback etc.

Not quite. Places that are prone to exposing stale block content (such as
truncate) wait for running DIO (inode_dio_wait()). Just with unlocked read
DIO we had to have special wait mechanisms to disable unlocked DIO for a
while so that we can actually safely drain all running DIOs without new
ones being submitted and then perform e.g. truncate. So it was more a
complexity of the locking mechanism.

> So as Dave suggested, shouldn't we add the complete shared locking in DIO
> writes cases as well (except for unaligned writes, since it may required
> zeroing of partial blocks).
> 
> 
> Could you please help me understand how we can go about it?
> I was thinking if we can create uninitialized blocks beyond EOF, so that
> any parallel read should only read 0 from that area and we may not require
> exclusive inode_lock. The block creation is anyway protected
> with i_data_sem in ext4_map_blocks.

So doing file size changes (i.e., file expansion) without exclusive
inode_lock would be tricky. I wouldn't really like to go there at least
initially. My plan would be to do it similarly to XFS like:

Do a quick check whether IO is going to grow inode size or is unaligned. If
yes, mode = exclusive, else mode = shared. Then lock inode rwsem is
appropriate mode, do ext4_write_checks() (which may find out exclusive lock
is actually needed so in that case mode = exclusive and restart). Then call
iomap code to do direct IO.

> I do see that in case of bufferedIO writes, we use ext4_get_block_unwritten
> for dioread_nolock case. Which should
> be true for even writes extending beyond EOF. This will
> create uninitialized and mapped blocks only (even beyond EOF).
> But all of this happen under exclusive inode_lock() in ext4_file_write_iter.

I guess this is mostly because we don't bother to check in
ext4_write_begin() whether we are extending the file or not and filling
holes needs unwritten extents. Also before DIO reads got changed to be
under shared inode rwsem, the following was possible:

CPU1					CPU2
DIO read from file f offset 4096
  flush cache
					grow 'f' from 4096 to 8192 by write
					  blocks get allocated, page cache
					  dirtied
  map blocks, submit IO
    - reads stale contents

> Whereas in case of DIO writes extending beyond EOF, we pass
> EXT4_GET_BLOCKS_CREATE in ext4_map_blocks which may allocate
> initialized & mapped blocks.
> Do you know why so?

Not using unwritten extents is faster if that is safe. So that's why DIO
code uses them if possible.

> Do you think we can create uninit. blocks in dioread_nolock AIO/non-AIO DIO
> writes cases as well with only shared inode lock mode?
> Do you see any problems with this?
> Or do you have any other suggestion?

Not uninit but unwritten. Yes, we can do that. After all e.g. page writeback
creates extents like this without any inode rwsem protection.

> In case of XFS -
> I do see it promotes the demotes the shared lock (IOLOCK_XXX) in
> xfs_file_aio_write_checks. But I don't know if after that, whether
> it only holds the shared lock while doing the DIO IO?
> And how does it protects against the parallel DIO reads which can
> potentially expose any stale data?

XFS protects DIO submission with shared IOLOCK. Stale data exposure is
solved by using unwritten extents similarly to what ext4 does.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
