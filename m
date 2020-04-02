Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4515419CCFA
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Apr 2020 00:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbgDBWli (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 18:41:38 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48371 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729549AbgDBWlh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Apr 2020 18:41:37 -0400
Received: from dread.disaster.area (pa49-180-164-3.pa.nsw.optusnet.com.au [49.180.164.3])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9CF567EA663;
        Fri,  3 Apr 2020 09:41:25 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jK8Wa-0005P5-UW; Fri, 03 Apr 2020 09:41:24 +1100
Date:   Fri, 3 Apr 2020 09:41:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     hch@lst.de, martin.petersen@oracle.com, darrick.wong@oracle.com,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, jthumshirn@suse.de, minwoo.im.dev@gmail.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
Message-ID: <20200402224124.GK10737@dread.disaster.area>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=K0+o7W9luyMo1Ua2eXjR1w==:117 a=K0+o7W9luyMo1Ua2eXjR1w==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=OLL_FvSJAAAA:8 a=7-415B0cAAAA:8 a=djW_VkzYRv8b6pmHjpMA:9
        a=83XbmwxN0B6MQfg-:21 a=82aPxsCgDOgqXjAm:21 a=CjuIK1q_8ugA:10
        a=Q6O7Wtph5A0A:10 a=bGb42cQ31NwA:10 a=oIrB72frpwYPwTMnlWqB:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Mar 29, 2020 at 10:47:10AM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> This patch-series is based on the original RFC patch series:-
> https://www.spinics.net/lists/linux-block/msg47933.html.
> 
> I've designed a rough testcase based on the information present
> in the mailing list archive for original RFC, it may need
> some corrections from the author.
> 
> If anyone is interested, test results are at the end of this patch.
> 
> Following is the original cover-letter :-
> 
> Information about continuous extent placement may be useful
> for some block devices. Say, distributed network filesystems,
> which provide block device interface, may use this information
> for better blocks placement over the nodes in their cluster,
> and for better performance. Block devices, which map a file
> on another filesystem (loop), may request the same length extent
> on underlining filesystem for less fragmentation and for batching
> allocation requests. Also, hypervisors like QEMU may use this
> information for optimization of cluster allocations.
> 
> This patchset introduces REQ_OP_ASSIGN_RANGE, which is going
> to be used for forwarding user's fallocate(0) requests into
> block device internals. It rather similar to existing
> REQ_OP_DISCARD, REQ_OP_WRITE_ZEROES, etc. The corresponding
> exported primitive is called blkdev_issue_assign_range().
> See [1/3] for the details.
> 
> Patch [2/3] teaches loop driver to handle REQ_OP_ASSIGN_RANGE
> requests by calling fallocate(0).
> 
> Patch [3/3] makes ext4 to notify a block device about fallocate(0).

Ok, so ext4 has a very limited max allocation size for an extent, so
I expect this won't cause huge latency problems. However, what
happens when we use XFS, have a 64kB block size, and fallocate() is
allocating disk space in continguous 100GB extents and passing those
down to the block device?

How does this get split by dm devices? Are raid stripes going to
dice this into separate stripe unit sized bios, so instead of single
large requests we end up with hundreds or thousands or tiny
allocation requests being issued?

I know that for the loop device, it is going to serialise all IO to
the backing file while fallocate is run on it. Hence if you have
concurrent IO running, any REQ_OP_ASSIGN_RANGE is going to cause an
significant, measurable latency hit to all those IOs in flight.

How are we expecting hardware to behave here? Is this a queued
command in the scsi/nvme/sata protocols? Or is this, for the moment,
just a special snowflake that we can't actually use in production
because the hardware just can't handle what we throw at it?

IOWs, what sort of latency issues is this operation going to cause
on real hardware? Is this going to be like discard? i.e. where we
end up not using it at all because so few devices actually handle
the massive stream of operations the filesystem will end up sending
the device(s) in the course of normal operations?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
