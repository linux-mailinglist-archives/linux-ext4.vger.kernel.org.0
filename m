Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7744D037
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Nov 2021 04:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKKDPj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Nov 2021 22:15:39 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:35849 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229699AbhKKDPi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Nov 2021 22:15:38 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 27FBB865D1E;
        Thu, 11 Nov 2021 14:12:47 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ml0W6-007Nzy-P7; Thu, 11 Nov 2021 14:12:46 +1100
Date:   Thu, 11 Nov 2021 14:12:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingkaidong@gmail.com
Subject: Re: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in
 read path
Message-ID: <20211111031246.GH418105@dread.disaster.area>
References: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
 <20211103002843.GC418105@dread.disaster.area>
 <ffb199dc-f7ae-ba03-db57-bf7acc3d0636@sjtu.edu.cn>
 <20211104232226.GD418105@dread.disaster.area>
 <01e6abf4-3ae5-ecab-3b7f-876c8a3fcbb4@sjtu.edu.cn>
 <20211109045010.GG418105@dread.disaster.area>
 <4f00db60-478b-698c-fc5b-874d8255af57@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f00db60-478b-698c-fc5b-874d8255af57@sjtu.edu.cn>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=618c8a30
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=4D2tzkiLJbWFb9yM_lEA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 10, 2021 at 04:07:57PM +0800, Zhongwei Cai wrote:
> On 11/9/21 12:50 PM, Dave Chinner wrote:
> > > 
> > > Could we add IOMAP_REPORT_DIRTY flag in the flags field of
> > > struct iomap_iter to indicate whether the IOMAP_F_DIRTY flag
> > > needs to be set or not?
> > 
> > You can try. It might turn out OK, but you're also going to have to
> > modify all the iomap code that current needs IOMAP_F_DIRTY to first
> > set that flag, then change all the code that currently sets
> > IOMAP_F_DIRTY to look at IOMAP_REPORT_DIRTY. i.e you now have to
> > change iomap, ext4 and XFS to do this.
> > 
> I will make a v2 patch with this implementation.
> 
> > > Currently the IOMAP_F_DIRTY flag is only checked in
> > > iomap_swapfile_activate(), dax_iomap_fault() and iomap_dio_rw()
> > > (To be more specific, only the write path in dax_iomap_fault() and
> > > iomap_dio_rw()). So it would be unnecessary to set the IOMAP_F_DIRTY
> > > flag in dax_iomap_rw() called in the previous tests.
> > 
> > I think you're trying to optimise the wrong thing - the API is not
> > the problem, the problem is that the journal->j_state_lock is
> > contended and the ext4 dirty inode check needs to take it. Fix the
> > dirty check not to need the journal state lock and the ext4 problem
> > goes away and there is no need to change the iomap infrastructure.
> 
> I'll try to fix it inside ext4, although it seems difficult to do dirty
> check without journal->j_state_lock.
> 
> > > Other file systems that set the IOMAP_F_DIRTY flag efficiently
> > > could ignore the IOMAP_REPORT_DIRTY flag.
> > 
> > No, that's just bad API design. If we are adding IOMAP_REPORT_DIRTY
> > then the iomap infrastructure should only use that control flag when
> > it needs to know if the inode is dirty. At this point, it really
> > becomes mandatory for all filesystems using iomap to support it
> > because the absence of IOMAP_F_DIRTY because a filesystem doesn't
> > support it is not the same as "filesystem didn't set it because the
> > inode is clean".
> > 
> Perhaps I have not made it clear that by "ignore" I mean other file
> systems can set IOMAP_F_DIRTY regardless of whether the
> IOMAP_REPORT_DIRTY flag is set or not, just like what they are doing
> now. So we might not need to modify XFS.

I assumed that was exactly what you meant. That's just bad/lazy API
design. We need to be explicit in the way behaviours are defined,
not create APIs where callees can set random flags whenever they
like.

> I think even without the modification I made, the ambiguity that
> the absence of IOMAP_F_DIRTY can either be file systems not supporting
> it or be actually "clean inode" may exist since we do not have a flag
> to indicate whether the file system supports setting IOMAP_F_DIRTY.

Exactly my point - the current behaviour it's not clearly defined
(just set it always if you can!) but ext4 needs it to be much more
explicitly constrained to avoid internal overhead.

Hence we need to constrain the IOMAP_F_DIRTY flag behaviour to just
the iomap operations that need to know if the inode is dirty (i.e.
filesystems should set IOMAP_F_DIRTY if and only if
IOMAP_REPORT_DIRTY is passed as a control flag from the iomap core
and the inode is dirty) and then ensure that *every filesystem
implements it correctly*.

There are no shortcuts here - the cost of changing generic
infrastructure is that you have to ensure that all users of
interface use it properly. That includes filesystems that don't
currently set IOMAP_F_DIRTY but use iomap interfaces that will now
set IOMAP_REPORT_DIRTY....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
