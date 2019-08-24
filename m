Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABF39BADB
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2019 04:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfHXCTw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Aug 2019 22:19:52 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60138 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbfHXCTw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 23 Aug 2019 22:19:52 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 99FCA36140C;
        Sat, 24 Aug 2019 12:19:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i1LdY-0008Ny-8O; Sat, 24 Aug 2019 12:18:40 +1000
Date:   Sat, 24 Aug 2019 12:18:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Joseph Qi <jiangqi903@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
Message-ID: <20190824021840.GW7777@dread.disaster.area>
References: <20190815151336.GO14313@quack2.suse.cz>
 <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
 <20190816145719.GA3041@quack2.suse.cz>
 <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
 <20190820160805.GB10232@mit.edu>
 <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
 <20190822054001.GT7777@dread.disaster.area>
 <f0eb766f-3c04-2a53-1669-4088e09d8f73@linux.alibaba.com>
 <20190823101623.GV7777@dread.disaster.area>
 <707b1a60-00f0-847e-02f9-e63d20eab47e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <707b1a60-00f0-847e-02f9-e63d20eab47e@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=mCdJKzTsXoswTGrCkX0A:9 a=QEXdDO2ut3YA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 23, 2019 at 09:08:53PM +0800, Joseph Qi wrote:
> 
> 
> On 19/8/23 18:16, Dave Chinner wrote:
> > On Fri, Aug 23, 2019 at 03:57:02PM +0800, Joseph Qi wrote:
> >> Hi Dave,
> >>
> >> On 19/8/22 13:40, Dave Chinner wrote:
> >>> On Wed, Aug 21, 2019 at 09:04:57AM +0800, Joseph Qi wrote:
> >>>> Hi Ted，
> >>>>
> >>>> On 19/8/21 00:08, Theodore Y. Ts'o wrote:
> >>>>> On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
> >>>>>>
> >>>>>> I've tested parallel dio reads with dioread_nolock, it
> >>>>>> doesn't have significant performance improvement and still
> >>>>>> poor compared with reverting parallel dio reads. IMO, this
> >>>>>> is because with parallel dio reads, it take inode shared
> >>>>>> lock at the very beginning in ext4_direct_IO_read().
> >>>>>
> >>>>> Why is that a problem?  It's a shared lock, so parallel
> >>>>> threads should be able to issue reads without getting
> >>>>> serialized?
> >>>>>
> >>>> The above just tells the result that even mounting with
> >>>> dioread_nolock, parallel dio reads still has poor performance
> >>>> than before (w/o parallel dio reads).
> >>>>
> >>>>> Are you using sufficiently fast storage devices that you're
> >>>>> worried about cache line bouncing of the shared lock?  Or do
> >>>>> you have some other concern, such as some other thread
> >>>>> taking an exclusive lock?
> >>>>>
> >>>> The test case is random read/write described in my first
> >>>> mail. And
> >>>
> >>> Regardless of dioread_nolock, ext4_direct_IO_read() is taking
> >>> inode_lock_shared() across the direct IO call.  And writes in
> >>> ext4 _always_ take the inode_lock() in ext4_file_write_iter(),
> >>> even though it gets dropped quite early when overwrite &&
> >>> dioread_nolock is set.  But just taking the lock exclusively
> >>> in write fro a short while is enough to kill all shared
> >>> locking concurrency...
> >>>
> >>>> from my preliminary investigation, shared lock consumes more
> >>>> in such scenario.
> >>>
> >>> If the write lock is also shared, then there should not be a
> >>> scalability issue. The shared dio locking is only half-done in
> >>> ext4, so perhaps comparing your workload against XFS would be
> >>> an informative exercise... 
> >>
> >> I've done the same test workload on xfs, it behaves the same as
> >> ext4 after reverting parallel dio reads and mounting with
> >> dioread_lock.
> > 
> > Ok, so the problem is not shared locking scalability ('cause
> > that's what XFS does and it scaled fine), the problem is almost
> > certainly that ext4 is using exclusive locking during
> > writes...
> > 
> 
> Agree. Maybe I've misled you in my previous mails.I meant shared
> lock makes worse in case of mixed random read/write, since we
> would always take inode lock during write.  And it also conflicts
> with dioread_nolock. It won't take any inode lock before with
> dioread_nolock during read, but now it always takes a shared
> lock.

No, you didn't mislead me. IIUC, the shared locking was added to the
direct IO read path so that it can't run concurrently with
operations like hole punch that free the blocks the dio read might
currently be operating on (use after free).

i.e. the shared locking fixes an actual bug, but the performance
regression is a result of only partially converting the direct IO
path to use shared locking. Only half the job was done from a
performance perspective. Seems to me that the two options here to
fix the performance regression are to either finish the shared
locking conversion, or remove the shared locking on read and re-open
a potential data exposure issue...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
