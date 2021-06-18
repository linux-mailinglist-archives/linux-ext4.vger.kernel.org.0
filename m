Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7053AD113
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhFRRXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 13:23:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38019 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235807AbhFRRXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Jun 2021 13:23:39 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15IHLNpS008651
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 13:21:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CA39B15C3CBA; Fri, 18 Jun 2021 13:21:23 -0400 (EDT)
Date:   Fri, 18 Jun 2021 13:21:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, linux-ext4@vger.kernel.org
Subject: Re: Potential regression with iomap DIO for 4k writes
Message-ID: <YMzWE5sJeuIeOv1q@mit.edu>
References: <87lf7rkffv.fsf@collabora.com>
 <87zgvq7jd8.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgvq7jd8.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 15, 2021 at 08:17:55PM -0400, Gabriel Krisman Bertazi wrote:
> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
> 
> > While I've been exploring the performance of different DIO
> > implementations, I've come across what seems a noticeable regression
> > (22% slowdown) in 4k writes in Ext4 when comparing the original
> > direct-io with the current iomap dio implementation, as existing on
> > linus/master.  Perhaps you already know about this, but I'm having a
> > hard time understanding the root cause, in order to attempt to improve
> > the situation.
> 
> Sorry for the ping, but do you have any ideas of what we are seeing
> here?

Apologies for the delay in responding; somehow I missed your initial
e-mail on the subject on June 2nd, although I haven't found it in the
mailing list archives[1].  I don't know if it got caught in a spam
trap, or was accidentally deleted from my inbox.

[1] https://lore.kernel.org/linux-ext4/87lf7rkffv.fsf@collabora.com/

I didn't do any bs=4k benchmarks before we landed the DIO iomap
changes, and it's interesting that it largely goes away with a 16k
block size[2]

[2] https://people.collabora.com/~krisman/dio/week21/bench.png

Looking at your flame graphs[3][4]

[3] https://people.collabora.com/~krisman/dio/week23/clean_flames/5.4.0-dio_original-dio-ext4-write-4k.svg
[4] https://people.collabora.com/~krisman/dio/week23/clean_flames/5.5.0-dio_old-iomap-ext4-write-4k.svg

... nothing immediately jumps out at me.

Have you compared the output of /proc/lock_stat for the two kernels?
And is there anything obvious in the blktrace of the two kernels?

Cheers,

						- Ted

> > * Benchmark
> >
> > For starter, I'm comparing three kernels, built with same config and
> > compiler (gcc-8.4.0 (locally built)).  My DUT is a Samsung SSD 970 EVO
> > Plus 250GB dedicated to this test (no concurrent IO).
> >
> >   - Kernel 1: Commit immediately before iomap for ext4 is merged
> >     ("f112a2fd1f59").  On the data below, this kernel is identified as
> >     5.4.0-original-dio. Available in a public branch at:
> >
> >     <gitlab.collabora.com:krisman/linux.git -b dio/original-dio>
> >
> >   - Kernel 2: tag 5.5 (first release with dio-iomap).  In the data
> >     below, identified as 5.5.0-old-iomap.  For completeness, it is
> >     available at:
> >
> >     <gitlab.collabora.com:krisman/linux.git -b dio/old-dio>
> >
> >   - Kernel 3: Kernel tag 5.13-rc3. In the data below, identified as
> >     5.13-rc3-iomap.  For completeness, it is available at:
> >
> >     <gitlab.collabora.com:krisman/linux.git -b dio/iomap>
> >
> > I ran the fio job below with the combinations: BS=4k,16k and RW=read,write
> >
> >   fio --ioengine libaio --size=2G --direct=1 --iodepth=64 --time_based=1 \
> >       --thread=1 --overwrite=1 --runtime=100 --output-format=terse
> >
> > For every kernel test, the file system was recreated, and the 2GB file
> > was pre-allocated.
> >
> > In an attempt to further isolate the problem, I tested both xfs and ext4
> > in the same condition.
> >
> > The script I used is available at:
> >
> >   <https://people.collabora.com/~krisman/dio/bench.sh>
> >
> > * Results
> >
> >  I obtained the following performance results, relative to the baseline
> > 5.4.0-original-dio.
> >
> > |                                                  IOPS                                                 |
> > |    kernel              |          read-4k |          read-16k |          write-4k |         write-16k |
> > |------------------------+------------------+-------------------+-------------------+-------------------+
> > | 5.13.0-rc3-iomap-ext4  | 1.01192950082305 |  1.00026413252562 | 0.806377013901006 |  1.00020735846057 |
> > | 5.5.0-old-iomap-ext4   | 1.01154156662508 | 0.998753983520427 | 0.777051125458035 | 0.999937792461829 |
> > | 5.13.0-rc3-iomap-xfs   | 1.00234888443008 |  1.00027645151444 |  1.00996172750095 |  1.00156349447934 |
> > | 5.5.0-old-iomap-xfs    | 1.00010412786902 |  1.00202731110586 |  1.01502846821264 |  1.00149431330769 |
> >
> >
> > Total IO is the amount of data copied (relative to baseline).
> >
> > | 						TOTAL_IO
> > | kernel                 |          read-4k |          read-16k |          write-4k |         write-16k |
> > |------------------------+------------------+-------------------+-------------------+-------------------|
> > | 5.13.0-rc3-iomap-ext4  | 1.01193023173156 |  1.00026332569559 | 0.806377530301477 |  1.00014686835205 |
> > | 5.5.0-old-iomap-ext4   | 1.01154196621591 | 0.998758131673757 | 0.777050753425118 | 0.999902824986834 |
> > | 5.13.0-rc3-iomap-xfs   | 1.00234893734134 |  1.00027535318322 |  1.00996437458991 |  1.00156305646789 |
> > | 5.5.0-old-iomap-xfs    | 1.00010328564078 |  1.00202831801018 |  1.01503060595258 |  1.00149069402364 |
> >
> > With a visualization of the above data here:
> >
> >   <https://people.collabora.com/~krisman/dio/bench.png>
> >
> > The only out of the ordinary result seems to be in write-4k for Ext4,
> > which suggests around 20% less IOPS (and total IO) for iomap in
> > comparison to the original DIO.  This is not a one-off run, as it seems
> > to be consistently reproducible with more test runs in my environment.
> > The performance reduction also doesn't reproduce on XFS.
> >
> > I tried to limit the influence of other parts of the kernel that could
> > affect the behavior by comparing the kernel immediately before the
> > introduction of dio-iomap for ext4 with the first version with that
> > feature.  By also observing that xfs doesn't change, I believe it to be
> > ext4 specific.
> >
> > I'm also publishing raw data and all related material to the link below,
> > in case anyone wants to tinker with my data:
> >
> >  https://people.collabora.com/~krisman/dio/
> >
> > Perhaps I'm missing something obvious.  But I can't pinpoint a specific
> > problem with my analysis.  Is this expected, given the way ext4 iomap
> > work?  Do you have any idea of the root cause or how it can be improved?
> >
> > I will keep looking to this issue, but I'd like to share this partial
> > result, in case there is a problem with my analysis, or if you have any
> > suggestion.
> >
> > Thanks,
> 
> -- 
> Gabriel Krisman Bertazi
