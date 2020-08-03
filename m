Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41223AFD2
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Aug 2020 23:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHCVvu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Aug 2020 17:51:50 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:44670 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgHCVvu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Aug 2020 17:51:50 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 3B98B1A8F2C;
        Tue,  4 Aug 2020 07:51:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k2iMy-0008H2-Kw; Tue, 04 Aug 2020 07:51:44 +1000
Date:   Tue, 4 Aug 2020 07:51:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC 1/1] pmem: Add cond_resched() in bio_for_each_segment loop
 in pmem_make_request
Message-ID: <20200803215144.GB2114@dread.disaster.area>
References: <0d96e2481f292de2cda8828b03d5121004308759.1596011292.git.riteshh@linux.ibm.com>
 <20200802230148.GA2114@dread.disaster.area>
 <20200803071405.64C0711C058@d06av25.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803071405.64C0711C058@d06av25.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=VnNF1IyMAAAA:8 a=7-415B0cAAAA:8
        a=O2OWZLGCkADlNaEqX4IA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 03, 2020 at 12:44:04PM +0530, Ritesh Harjani wrote:
> 
> 
> On 8/3/20 4:31 AM, Dave Chinner wrote:
> > On Wed, Jul 29, 2020 at 02:15:18PM +0530, Ritesh Harjani wrote:
> > > For systems which do not have CONFIG_PREEMPT set and
> > > if there is a heavy multi-threaded load/store operation happening
> > > on pmem + sometimes along with device latencies, softlockup warnings like
> > > this could trigger. This was seen on Power where pagesize is 64K.
> > > 
> > > To avoid softlockup, this patch adds a cond_resched() in this path.
> > > 
> > > <...>
> > > watchdog: BUG: soft lockup - CPU#31 stuck for 22s!
> > > <...>
> > > CPU: 31 PID: 15627 <..> 5.3.18-20
> > > <...>
> > > NIP memcpy_power7+0x43c/0x7e0
> > > LR memcpy_flushcache+0x28/0xa0
> > > 
> > > Call Trace:
> > > memcpy_power7+0x274/0x7e0 (unreliable)
> > > memcpy_flushcache+0x28/0xa0
> > > write_pmem+0xa0/0x100 [nd_pmem]
> > > pmem_do_bvec+0x1f0/0x420 [nd_pmem]
> > > pmem_make_request+0x14c/0x370 [nd_pmem]
> > > generic_make_request+0x164/0x400
> > > submit_bio+0x134/0x2e0
> > > submit_bio_wait+0x70/0xc0
> > > blkdev_issue_zeroout+0xf4/0x2a0
> > > xfs_zero_extent+0x90/0xc0 [xfs]
> > > xfs_bmapi_convert_unwritten+0x198/0x230 [xfs]
> > > xfs_bmapi_write+0x284/0x630 [xfs]
> > > xfs_iomap_write_direct+0x1f0/0x3e0 [xfs]
> > > xfs_file_iomap_begin+0x344/0x690 [xfs]
> > > dax_iomap_pmd_fault+0x488/0xc10
> > > __xfs_filemap_fault+0x26c/0x2b0 [xfs]
> > > __handle_mm_fault+0x794/0x1af0
> > > handle_mm_fault+0x12c/0x220
> > > __do_page_fault+0x290/0xe40
> > > do_page_fault+0x38/0xc0
> > > handle_page_fault+0x10/0x30
> > > 
> > > Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >   drivers/nvdimm/pmem.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > > index 2df6994acf83..fcf7af13897e 100644
> > > --- a/drivers/nvdimm/pmem.c
> > > +++ b/drivers/nvdimm/pmem.c
> > > @@ -214,6 +214,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
> > >   			bio->bi_status = rc;
> > >   			break;
> > >   		}
> > > +		cond_resched();
> > 
> > There are already cond_resched() calls between submitted bios in
> > blkdev_issue_zeroout() via both __blkdev_issue_zero_pages() and
> > __blkdev_issue_write_zeroes(), so I'm kinda wondering where the
> > problem is coming from here.
> 
> This problem is coming from that bio call- submit_bio()
> 
> > 
> > Just how big is the bio being issued here that it spins for 22s
> > trying to copy it?
> 
> It's 256 (due to BIO_MAX_PAGES) * 64KB (pagesize) = 16MB.
> So this is definitely not an easy trigger as per tester was mainly seen
> on a VM.

Right, so a memcpy() of 16MB of data in a single bio is taking >22s?

If so, then you can't solve this problem with cond_resched() - if
something that should only take half a millisecond to run is taking
22s of CPU time, there are bigger problems occurring that need
fixing.

i.e. if someone is running a workload that has effectively
livelocked the hardware cache coherency protocol across the entire
machine, then changing kernel code that requires memory bandwidth to
be available is not going to fix the problem. All is does is shoot
the messenger that tells you there is something going wrong.

> Looking at the cond_resched() inside dax_writeback_mapping_range()
> in xas_for_each_marked() loop, I thought it should be good to have a
> cond_resched() in the above path as well.

That's not done on every page/bio - that'd done every 4096 pages, or
every 256MB of memory written back on 64k page machines. IOWs, using
cond_resched() here is a sensible thing to do if you have a locked
loop that might run for seconds.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
