Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18BEFC1D9
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 09:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfKNIuA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 03:50:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:33160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfKNIuA (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Nov 2019 03:50:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0602BADCB;
        Thu, 14 Nov 2019 08:49:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9EA121E4AD2; Thu, 14 Nov 2019 09:49:57 +0100 (CET)
Date:   Thu, 14 Nov 2019 09:49:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/19 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191114084957.GA28486@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191112220614.GA11089@mit.edu>
 <20191113094545.GC6367@quack2.suse.cz>
 <20191114052652.GB11994@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114052652.GB11994@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 14-11-19 00:26:52, Theodore Y. Ts'o wrote:
> On Wed, Nov 13, 2019 at 10:45:45AM +0100, Jan Kara wrote:
> > Thanks for the heads up! I didn't do any performance testing with the jbd2
> > changes specifically and our internal performance testing grid only checks
> > Linus' kernel so it didn't yet even try to run that code. I'll queue some
> > sqlite insert tests internally with my changes to see whether I'm able to
> > reproduce. I don't have NVME disks available quickly but I guess SATA SSD
> > could do the job as well...
> 
> Sorry, false alarm.  What Phoronix was testing was 5.3 versus 5.4-rcX,
> using Ubuntu's bleeding-edge kernels.  It wouldn't have any of the
> ext4 patches we have queued for the *next* merge window.

OK, thanks for looking! I've run some tests on my test setup anyway...

> That being said, I wasn't able to reproduce performance delta using
> upstream kernels, running on a Google Compute Engine VM, machtype
> n1-highcpu-8, using a GCE Local SSD (SCSI-attached) for the first
> benchmark, which I believe was the pts/sqlite benchmark using a thread
> count of 1:
> 
>      Phoronix Test Suite 9.0.1
>      SQLite 3.30.1
>      Threads / Copies: 1
>      Seconds < Lower Is Better
>      5.3.0 ..................... 225 |===========================================
>      5.4.0-rc3 ................. 224 |==========================================
>      5.4-rc3-80-gafb2442fa429 .. 227 |===========================================
>      5.4.0-rc7 ................. 223 |==========================================
> 
>      Processor: Intel Xeon (4 Cores / 8 Threads), Chipset: Intel 440FX
>      82441FX PMC, Memory: 1 x 7373 MB RAM, Disk: 11GB PersistentDisk +
>      403GB EphemeralDisk, Network: Red Hat Virtio device
> 
>      OS: Debian 10, Kernel: 5.4.0-rc3-xfstests (x86_64) 20191113, Compiler:
>      GCC 8.3.0, File-System: ext4, System Layer: KVM
> 
> This was done using an extension to a gce-xfstests test appliance, to
> which I hope to be adding an automation engine where it will kexec
> into a series of kernels, run the benchmarks and then spit out the
> report somewhere.  For now, the benchmarks are run manually.
> 
> (Adding commentary and click-baity titles is left as an exercise to
> the reader.  :-)
> 
> 						- Ted
> 						
> P.S.  For all that I like to make snarky comments about Phoronix.com,
> I have to admit Michael Larabel has done a pretty good job with his
> performance test engine.  I probably would have choosen a different
> implementation than PHP, and I'd have added an explicit way to specify
> the file system to be tested other than mounting it on top of
> /var/lib/phoronix-test-suite, and at least have the option of placing
> the benchmarks' build trees and binaries in a different location than
> the file system under test.
> 
> But that being said, he's collecting a decent set of benchmark tools,
> and it is pretty cool that it has an automated way of collecting the
> benchmark results, including the pretty graphs suitable for web
> articles and conference slide decks ("and now, we turn to the rigged
> benchmarks section of the presentation designed to show my new feature
> in the best possible light...").

Let me make a small marketing pitch mmtest [1] :) For me running the test is
just:
  * Boot the right kernel on the machine
  * Run:
   ./run-mmtests.sh -c configs/config-db-sqlite-insert-medium-ext4 \
      --no-monitor Whatever_run_name_1

Now the config file already has proper partition, fstype, mkfs opts etc.
configured so it's a bit of cheating but still :). And when I have data for
both kernels, I do:
  cd work/log
  ../../compare_kernels.sh

and get a table with the comparison of the two benchmarking runs with
averages, standard deviations, percentiles, and other more advanced
statistical stuff to distinguish signal from noise. We also have support
for gathering various monitoring while the test is running (turbostat,
iostat, vmstat, ...) and graphing all the results (although the graphs are
more aimed at quick analysis of what's going on rather than at presenting
results to a public).

So for this campaign I've compared "5.3+some SUSE patches" to "5.4-rc7+your
'dev' branch". And the results look like:

sqlite
                              5.3-SUSE                5.4-rc7
                                                     ext4-dev
Min       Trans     2181.67 (   0.00%)     2412.72 (  10.59%)
Hmean     Trans     2399.39 (   0.00%)     2602.73 *   8.47%*
Stddev    Trans      172.15 (   0.00%)      141.61 (  17.74%)
CoeffVar  Trans        7.14 (   0.00%)        5.43 (  24.00%)
Max       Trans     2671.84 (   0.00%)     3027.81 (  13.32%)
...

These are Trans/Sec values so there's actually a small improvement on this
machine. But it's somwhat difficult to tell because the benchmark variation
is rather high (likely due to powersafe cpufreq governor if I should guess).

								Honza

[1] git://github.com/gormanm/mmtests
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
