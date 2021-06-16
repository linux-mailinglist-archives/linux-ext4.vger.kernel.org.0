Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C241F3A8D4B
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 02:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFPAUE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Jun 2021 20:20:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40328 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFPAUE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Jun 2021 20:20:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 497F91F43305
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     kernel@collabora.com, linux-ext4@vger.kernel.org
Subject: Re: Potential regression with iomap DIO for 4k writes
Organization: Collabora
References: <87lf7rkffv.fsf@collabora.com>
Date:   Tue, 15 Jun 2021 20:17:55 -0400
In-Reply-To: <87lf7rkffv.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Wed, 02 Jun 2021 19:35:48 -0400")
Message-ID: <87zgvq7jd8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Hi,
>
> While I've been exploring the performance of different DIO
> implementations, I've come across what seems a noticeable regression
> (22% slowdown) in 4k writes in Ext4 when comparing the original
> direct-io with the current iomap dio implementation, as existing on
> linus/master.  Perhaps you already know about this, but I'm having a
> hard time understanding the root cause, in order to attempt to improve
> the situation.

Hi Ted,

Sorry for the ping, but do you have any ideas of what we are seeing
here?

Thank you,

> * Benchmark
>
> For starter, I'm comparing three kernels, built with same config and
> compiler (gcc-8.4.0 (locally built)).  My DUT is a Samsung SSD 970 EVO
> Plus 250GB dedicated to this test (no concurrent IO).
>
>   - Kernel 1: Commit immediately before iomap for ext4 is merged
>     ("f112a2fd1f59").  On the data below, this kernel is identified as
>     5.4.0-original-dio. Available in a public branch at:
>
>     <gitlab.collabora.com:krisman/linux.git -b dio/original-dio>
>
>   - Kernel 2: tag 5.5 (first release with dio-iomap).  In the data
>     below, identified as 5.5.0-old-iomap.  For completeness, it is
>     available at:
>
>     <gitlab.collabora.com:krisman/linux.git -b dio/old-dio>
>
>   - Kernel 3: Kernel tag 5.13-rc3. In the data below, identified as
>     5.13-rc3-iomap.  For completeness, it is available at:
>
>     <gitlab.collabora.com:krisman/linux.git -b dio/iomap>
>
> I ran the fio job below with the combinations: BS=4k,16k and RW=read,write
>
>   fio --ioengine libaio --size=2G --direct=1 --iodepth=64 --time_based=1 \
>       --thread=1 --overwrite=1 --runtime=100 --output-format=terse
>
> For every kernel test, the file system was recreated, and the 2GB file
> was pre-allocated.
>
> In an attempt to further isolate the problem, I tested both xfs and ext4
> in the same condition.
>
> The script I used is available at:
>
>   <https://people.collabora.com/~krisman/dio/bench.sh>
>
> * Results
>
>  I obtained the following performance results, relative to the baseline
> 5.4.0-original-dio.
>
> |                                                  IOPS                                                 |
> |    kernel              |          read-4k |          read-16k |          write-4k |         write-16k |
> |------------------------+------------------+-------------------+-------------------+-------------------+
> | 5.13.0-rc3-iomap-ext4  | 1.01192950082305 |  1.00026413252562 | 0.806377013901006 |  1.00020735846057 |
> | 5.5.0-old-iomap-ext4   | 1.01154156662508 | 0.998753983520427 | 0.777051125458035 | 0.999937792461829 |
> | 5.13.0-rc3-iomap-xfs   | 1.00234888443008 |  1.00027645151444 |  1.00996172750095 |  1.00156349447934 |
> | 5.5.0-old-iomap-xfs    | 1.00010412786902 |  1.00202731110586 |  1.01502846821264 |  1.00149431330769 |
>
>
> Total IO is the amount of data copied (relative to baseline).
>
> | 						TOTAL_IO
> | kernel                 |          read-4k |          read-16k |          write-4k |         write-16k |
> |------------------------+------------------+-------------------+-------------------+-------------------|
> | 5.13.0-rc3-iomap-ext4  | 1.01193023173156 |  1.00026332569559 | 0.806377530301477 |  1.00014686835205 |
> | 5.5.0-old-iomap-ext4   | 1.01154196621591 | 0.998758131673757 | 0.777050753425118 | 0.999902824986834 |
> | 5.13.0-rc3-iomap-xfs   | 1.00234893734134 |  1.00027535318322 |  1.00996437458991 |  1.00156305646789 |
> | 5.5.0-old-iomap-xfs    | 1.00010328564078 |  1.00202831801018 |  1.01503060595258 |  1.00149069402364 |
>
> With a visualization of the above data here:
>
>   <https://people.collabora.com/~krisman/dio/bench.png>
>
> The only out of the ordinary result seems to be in write-4k for Ext4,
> which suggests around 20% less IOPS (and total IO) for iomap in
> comparison to the original DIO.  This is not a one-off run, as it seems
> to be consistently reproducible with more test runs in my environment.
> The performance reduction also doesn't reproduce on XFS.
>
> I tried to limit the influence of other parts of the kernel that could
> affect the behavior by comparing the kernel immediately before the
> introduction of dio-iomap for ext4 with the first version with that
> feature.  By also observing that xfs doesn't change, I believe it to be
> ext4 specific.
>
> I'm also publishing raw data and all related material to the link below,
> in case anyone wants to tinker with my data:
>
>  https://people.collabora.com/~krisman/dio/
>
> Perhaps I'm missing something obvious.  But I can't pinpoint a specific
> problem with my analysis.  Is this expected, given the way ext4 iomap
> work?  Do you have any idea of the root cause or how it can be improved?
>
> I will keep looking to this issue, but I'd like to share this partial
> result, in case there is a problem with my analysis, or if you have any
> suggestion.
>
> Thanks,

-- 
Gabriel Krisman Bertazi
