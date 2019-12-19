Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8255C126DF4
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2019 20:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLST2a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 14:28:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:36958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfLST2a (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Dec 2019 14:28:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4415AEFD;
        Thu, 19 Dec 2019 19:28:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4964E1E0B44; Thu, 19 Dec 2019 20:28:23 +0100 (CET)
Date:   Thu, 19 Dec 2019 20:28:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
Subject: Re: [PATCH] ext4: Optimize ext4 DIO overwrites
Message-ID: <20191219192823.GA5389@quack2.suse.cz>
References: <20191218174433.19380-1-jack@suse.cz>
 <20191219135329.529E3A404D@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219135329.529E3A404D@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-12-19 19:23:28, Ritesh Harjani wrote:
> On 12/18/19 11:14 PM, Jan Kara wrote:
> > Currently we start transaction for mapping every extent for writing
> > using direct IO. This is unnecessary when we know we are overwriting
> > already allocated blocks and the overhead of starting a transaction can
> > be significant especially for multithreaded workloads doing small writes.
> > Use iomap operations that avoid starting a transaction for direct IO
> > overwrites.
> > 
> > This improves throughput of 4k random writes - fio jobfile:
> > [global]
> > rw=randrw
> > norandommap=1
> > invalidate=0
> > bs=4k
> > numjobs=16
> > time_based=1
> > ramp_time=30
> > runtime=120
> > group_reporting=1
> > ioengine=psync
> > direct=1
> > size=16G
> > filename=file1.0.0:file1.0.1:file1.0.2:file1.0.3:file1.0.4:file1.0.5:file1.0.6:file1.0.7:file1.0.8:file1.0.9:file1.0.10:file1.0.11:file1.0.12:file1.0.13:file1.0.14:file1.0.15:file1.0.16:file1.0.17:file1.0.18:file1.0.19:file1.0.20:file1.0.21:file1.0.22:file1.0.23:file1.0.24:file1.0.25:file1.0.26:file1.0.27:file1.0.28:file1.0.29:file1.0.30:file1.0.31
> > file_service_type=random
> > nrfiles=32
> > 
> > from 3018MB/s to 4059MB/s in my test VM running test against simulated
> > pmem device (note that before iomap conversion, this workload was able
> > to achieve 3708MB/s because old direct IO path avoided transaction start
> > for overwrites as well). For dax, the win is even larger improving
> > throughput from 3042MB/s to 4311MB/s.
> 
> However for dax via ext4_dax_write_iter() path, we still need a way to
> detect if it's overwrite and that path can be optimized too right?
> I see, that this path could use both `shared inode locking` and
> `no journal transaction` optimizations in case of overwrites. Correct?

I don't think we can really afford the shared locking in
ext4_dax_write_iter() as POSIX requires overlapping writes to be
serialized. But we could still optimize-away the transaction starts.

> > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> This was one of the next AI I too wanted to do. I guess since everyone
> loves performance improvements. :)
> 
> No problem with current patch. Looks good. Gave it a run too on my
> system.
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks!

> However depending on which patch lands first one may need a
> re-basing. Will conflict with this-
> https://marc.info/?l=linux-ext4&m=157613016931238&w=2

Yes, but the conflict is minor and trivial to resolve.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
