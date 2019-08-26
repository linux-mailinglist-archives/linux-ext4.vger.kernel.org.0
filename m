Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF9F9CBCA
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 10:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfHZIkB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 04:40:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729523AbfHZIkB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 04:40:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42279B011;
        Mon, 26 Aug 2019 08:39:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C5ECB1E3FE3; Mon, 26 Aug 2019 10:39:58 +0200 (CEST)
Date:   Mon, 26 Aug 2019 10:39:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Joseph Qi <jiangqi903@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
Message-ID: <20190826083958.GA10614@quack2.suse.cz>
References: <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
 <20190816145719.GA3041@quack2.suse.cz>
 <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
 <20190820160805.GB10232@mit.edu>
 <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
 <20190822054001.GT7777@dread.disaster.area>
 <f0eb766f-3c04-2a53-1669-4088e09d8f73@linux.alibaba.com>
 <20190823101623.GV7777@dread.disaster.area>
 <707b1a60-00f0-847e-02f9-e63d20eab47e@linux.alibaba.com>
 <20190824021840.GW7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190824021840.GW7777@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 24-08-19 12:18:40, Dave Chinner wrote:
> On Fri, Aug 23, 2019 at 09:08:53PM +0800, Joseph Qi wrote:
> > 
> > 
> > On 19/8/23 18:16, Dave Chinner wrote:
> > > On Fri, Aug 23, 2019 at 03:57:02PM +0800, Joseph Qi wrote:
> > >> Hi Dave,
> > >>
> > >> On 19/8/22 13:40, Dave Chinner wrote:
> > >>> On Wed, Aug 21, 2019 at 09:04:57AM +0800, Joseph Qi wrote:
> > >>>> Hi Ted，
> > >>>>
> > >>>> On 19/8/21 00:08, Theodore Y. Ts'o wrote:
> > >>>>> On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
> > >>>>>>
> > >>>>>> I've tested parallel dio reads with dioread_nolock, it
> > >>>>>> doesn't have significant performance improvement and still
> > >>>>>> poor compared with reverting parallel dio reads. IMO, this
> > >>>>>> is because with parallel dio reads, it take inode shared
> > >>>>>> lock at the very beginning in ext4_direct_IO_read().
> > >>>>>
> > >>>>> Why is that a problem?  It's a shared lock, so parallel
> > >>>>> threads should be able to issue reads without getting
> > >>>>> serialized?
> > >>>>>
> > >>>> The above just tells the result that even mounting with
> > >>>> dioread_nolock, parallel dio reads still has poor performance
> > >>>> than before (w/o parallel dio reads).
> > >>>>
> > >>>>> Are you using sufficiently fast storage devices that you're
> > >>>>> worried about cache line bouncing of the shared lock?  Or do
> > >>>>> you have some other concern, such as some other thread
> > >>>>> taking an exclusive lock?
> > >>>>>
> > >>>> The test case is random read/write described in my first
> > >>>> mail. And
> > >>>
> > >>> Regardless of dioread_nolock, ext4_direct_IO_read() is taking
> > >>> inode_lock_shared() across the direct IO call.  And writes in
> > >>> ext4 _always_ take the inode_lock() in ext4_file_write_iter(),
> > >>> even though it gets dropped quite early when overwrite &&
> > >>> dioread_nolock is set.  But just taking the lock exclusively
> > >>> in write fro a short while is enough to kill all shared
> > >>> locking concurrency...
> > >>>
> > >>>> from my preliminary investigation, shared lock consumes more
> > >>>> in such scenario.
> > >>>
> > >>> If the write lock is also shared, then there should not be a
> > >>> scalability issue. The shared dio locking is only half-done in
> > >>> ext4, so perhaps comparing your workload against XFS would be
> > >>> an informative exercise... 
> > >>
> > >> I've done the same test workload on xfs, it behaves the same as
> > >> ext4 after reverting parallel dio reads and mounting with
> > >> dioread_lock.
> > > 
> > > Ok, so the problem is not shared locking scalability ('cause
> > > that's what XFS does and it scaled fine), the problem is almost
> > > certainly that ext4 is using exclusive locking during
> > > writes...
> > > 
> > 
> > Agree. Maybe I've misled you in my previous mails.I meant shared
> > lock makes worse in case of mixed random read/write, since we
> > would always take inode lock during write.  And it also conflicts
> > with dioread_nolock. It won't take any inode lock before with
> > dioread_nolock during read, but now it always takes a shared
> > lock.
> 
> No, you didn't mislead me. IIUC, the shared locking was added to the
> direct IO read path so that it can't run concurrently with
> operations like hole punch that free the blocks the dio read might
> currently be operating on (use after free).
> 
> i.e. the shared locking fixes an actual bug, but the performance
> regression is a result of only partially converting the direct IO
> path to use shared locking. Only half the job was done from a
> performance perspective. Seems to me that the two options here to
> fix the performance regression are to either finish the shared
> locking conversion, or remove the shared locking on read and re-open
> a potential data exposure issue...

We actually had a separate locking mechanism in ext4 code to avoid stale
data exposure during hole punch when unlocked DIO reads were running. But
it was kind of ugly and making things complex. I agree we need to move ext4
DIO path conversion further to avoid taking exclusive lock when we won't
actually need it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
