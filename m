Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA4319CEC3
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Apr 2020 04:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390082AbgDCC6P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 22:58:15 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:53742 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731842AbgDCC6P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Apr 2020 22:58:15 -0400
Received: from dread.disaster.area (pa49-180-164-3.pa.nsw.optusnet.com.au [49.180.164.3])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id E564F7EB1AF;
        Fri,  3 Apr 2020 13:57:58 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jKCWr-0006vS-Q6; Fri, 03 Apr 2020 13:57:57 +1100
Date:   Fri, 3 Apr 2020 13:57:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        hannes@cmpxchg.org, khlebnikov@yandex-team.ru, ajay.joshi@wdc.com,
        bvanassche@acm.org, arnd@arndb.de, houtao1@huawei.com,
        asml.silence@gmail.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
Message-ID: <20200403025757.GL10737@dread.disaster.area>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
 <20200402224124.GK10737@dread.disaster.area>
 <yq1imih4aj0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1imih4aj0.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=K0+o7W9luyMo1Ua2eXjR1w==:117 a=K0+o7W9luyMo1Ua2eXjR1w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=7-415B0cAAAA:8 a=dJU7itvOatQ9UriB79sA:9 a=0yzU55aZds_2P9em:21
        a=YcOsKN3MPVCGN0Z9:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 02, 2020 at 09:34:43PM -0400, Martin K. Petersen wrote:
> 
> Hi Dave!
> 
> > Ok, so ext4 has a very limited max allocation size for an extent, so
> > I expect this won't cause huge latency problems. However, what
> > happens when we use XFS, have a 64kB block size, and fallocate() is
> > allocating disk space in continguous 100GB extents and passing those
> > down to the block device?
> 
> Depends on the device.

Great. :(

> > How does this get split by dm devices? Are raid stripes going to dice
> > this into separate stripe unit sized bios, so instead of single large
> > requests we end up with hundreds or thousands or tiny allocation
> > requests being issued?
> 
> There is nothing special about this operation. It needs to be handled
> the same way as all other splits. I.e. ideally coalesced at the bottom
> of the stack so we can issue larger, contiguous commands to the
> hardware.
> 
> > How are we expecting hardware to behave here? Is this a queued
> > command in the scsi/nvme/sata protocols? Or is this, for the moment,
> > just a special snowflake that we can't actually use in production
> > because the hardware just can't handle what we throw at it?
> 
> For now it's SCSI and queued. Only found in high-end thinly provisioned
> storage arrays and not in your average SSD.

So it's a special snowflake :)

> The performance expectation for REQ_OP_ALLOCATE is that it is faster
> than a write to the same block range since the device potentially needs
> to do less work. I.e. the device simply needs to decrement the free
> space and mark the LBAs reserved in a map. It doesn't need to write all
> the blocks to zero them. If you want zeroed blocks, use
> REQ_OP_WRITE_ZEROES.

I suspect that the implications of wiring filesystems directly up to
this hasn't been thought through entirely....

> > IOWs, what sort of latency issues is this operation going to cause
> > on real hardware? Is this going to be like discard? i.e. where we
> > end up not using it at all because so few devices actually handle
> > the massive stream of operations the filesystem will end up sending
> > the device(s) in the course of normal operations?
> 
> The intended use case, from a SCSI perspective, is that on a thinly
> provisioned device you can use this operation to preallocate blocks so
> that future writes to the LBAs in question will not fail due to the
> device being out of space. I.e. you would use this to pin down block
> ranges where you can not tolerate write failures. The advantage over
> writing the blocks individually is that dedup won't apply and that the
> device doesn't actually have to go write all the individual blocks.

.... because when backed by thinp storage, plumbing user level
fallocate() straight through from the filesystem introduces a
trivial, user level storage DOS vector....

i.e. a user can just fallocate a bunch of files and, because the
filesystem can do that instantly, can also run the back end array
out of space almost instantly. Storage admins are going to love
this!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
