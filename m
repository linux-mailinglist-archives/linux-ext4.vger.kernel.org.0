Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC0232316
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 19:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2REH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 13:04:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:46322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2REH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Jul 2020 13:04:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65469B645;
        Wed, 29 Jul 2020 17:04:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F8D21E12C7; Wed, 29 Jul 2020 19:04:05 +0200 (CEST)
Date:   Wed, 29 Jul 2020 19:04:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Changing a workload results in performance drop
Message-ID: <20200729170405.GC16052@quack2.suse.cz>
References: <73a3416a-67d2-c494-1f3f-7d7789bdf61d@yandex.ru>
 <0c296eebe57543724ada627f396385601495baf2.camel@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c296eebe57543724ada627f396385601495baf2.camel@yandex.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 02-06-20 17:22:39, Konstantin Kharlamov wrote:
> So, FTR, I found on kernelnewbies that in linux 5.7 ext4 migrated to
> iomap. Out of curiousity I rerun the tests on 5.7. The problem is still
> reproducible.
> 
> On Fri, 2020-04-24 at 17:56 +0300, Konstantin Kharlamov wrote:
> > * SSDs are used in testing, so random access is not a concern. But I
> > tried the
> >    "steps to reproduce" with raw block device, and IOPS always holds
> > 9k for me.
> > * "Direct" IO is used to bypass file-system cache.
> > * The issue is way less visible on XFS, so it looks specific to file
> > systems.
> > * The biggest difference I've seen is on 70% reads/30% writes
> > workload. But for
> >    simplicity in "steps to reproduce" I'm using 100% write.
> > * it seems over time (perhaps a day) performance gets improved, so
> > for best
> >    results when testing that you need to re-create ext4 anew.
> > * in "steps to reproduce" I grep fio stdout. That suppresses
> > interactive
> >    output. Interactive output may be interesting though, I've often
> > seen workload
> >    drops to 600-700 IOPS while average was 5-6k
> > * Original problem I worked with 
> > https://github.com/openzfs/zfs/issues/10231
> > 
> > # Steps to reproduce (in terms of terminal commands)
> > 
> >      $ cat fio_jobfile
> >      [job-section]
> >      name=temp-fio
> >      bs=8k
> >      ioengine=libaio
> >      rw=randrw
> >      rwmixread=0
> >      rwmixwrite=100
> >      filename=/mnt/test/file1
> >      iodepth=1
> >      numjobs=1
> >      group_reporting
> >      time_based
> >      runtime=1m
> >      direct=1
> >      filesize=4G
> >      $ mkfs.ext4 /dev/sdw1
> >      $ mount /dev/sdw1 /mnt/test
> >      $ truncate -s 100G /mnt/test/file1
> >      $ fio fio_jobfile | grep -i IOPS
> >        write: IOPS=12.5k, BW=97.0MiB/s (103MB/s)(5879MiB/60001msec)
> >         iops        : min=10966, max=14730, avg=12524.20,
> > stdev=1240.27, samples=119
> >      $ sed -i 's/4G/100G/' fio_jobfile
> >      $ fio fio_jobfile | grep -i IOPS
> >        write: IOPS=5880, BW=45.9MiB/s (48.2MB/s)(2756MiB/60001msec)
> >         iops        : min= 4084, max= 6976, avg=5879.31,
> > stdev=567.58, samples=119
> > 
> > ## Expected
> > 
> > Performance should be more or less the same
> > 
> > ## Actual
> > 
> > The second test is twice as slow
> > 
> > # Versions
> > 
> > * Kernel version: 5.6.2-050602-generic
> > 
> > It seems however that the problem is present at least in 4.19 and
> > 5.4. as well, so not a regression.

Thanks for report!  I've found this when going through some old email...
I'm not quite sure what the problem is - do you expect that random writes
in 4G file will be as fast as random writes to 100G file?

Note that the way you setup the file, fio will not actually preallocate
space for the file so fio will end up allocating blocks for the file in
random order during benchmarking. Which is stress-testing the block
allocator and extent tree manipulation. Furthermore doing this on 4G range
is certainly cheaper than on 100G range (since once the block is allocated,
the second write to that block is cheap) so I'm not surprised by the
results much...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
