Return-Path: <linux-ext4+bounces-647-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5487822791
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 04:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102A81F2390F
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 03:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922BC1095B;
	Wed,  3 Jan 2024 03:32:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300224A26;
	Wed,  3 Jan 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T4ZxB2rcSzvTpM;
	Wed,  3 Jan 2024 11:30:38 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B9A9140499;
	Wed,  3 Jan 2024 11:31:47 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 11:31:39 +0800
Subject: Re: [linus:master] [jbd2] 6a3afb6ac6: fileio.latency_95th_ms 92.5%
 regression
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	<linux-ext4@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <yukuai3@huawei.com>
References: <202401021525.a27b9444-oliver.sang@intel.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <dcc72d34-89e1-6181-3556-a1a981256cc6@huawei.com>
Date: Wed, 3 Jan 2024 11:31:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202401021525.a27b9444-oliver.sang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/2 15:31, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 92.5% regression of fileio.latency_95th_ms on:

Hello,

This seems a little weird, the tests doesn't use blk-cgroup, and the patch
increase IO priority in WBT, so there shouldn't be any negative influence in
theory. I've tested sysbench on my machine with Intel Xeon Gold 6240 CPU,
400GB memory with HDD disk, and couldn't reproduce this regression.

==
Without 6a3afb6ac6 ("jbd2: increase the journal IO's priority")
==

 $ sysbench fileio --events=0 --threads=128 --time=600 --file-test-mode=seqwr --file-total-size=68719476736 --file-io-mode=sync --file-num=1024 run

  sysbench 1.1.0-df89d34 (using bundled LuaJIT 2.1.0-beta3)

  Running the test with following options:
  Number of threads: 128
  Initializing random number generator from current time


  Extra file open flags: (none)
  1024 files, 64MiB each
  64GiB total file size
  Block size 16KiB
  Periodic FSYNC enabled, calling fsync() each 100 requests.
  Calling fsync() at the end of test, Enabled.
  Using synchronous I/O mode
  Doing sequential write (creation) test
  Initializing worker threads...

  Threads started!


  Throughput:
           read:  IOPS=0.00 0.00 MiB/s (0.00 MB/s)
           write: IOPS=31961.19 499.39 MiB/s (523.65 MB/s)
           fsync: IOPS=327500.24

  Latency (ms):
           min:                                  0.00
           avg:                                  0.33
           max:                                920.89
           95th percentile:                      0.33
           sum:                            71212319.19

==
With 6a3afb6ac6 ("jbd2: increase the journal IO's priority")
==

 $ sysbench fileio --events=0 --threads=128 --time=600 --file-test-mode=seqwr --file-total-size=68719476736 --file-io-mode=sync --file-num=1024 run

  sysbench 1.1.0-df89d34 (using bundled LuaJIT 2.1.0-beta3)

  Running the test with following options:
  Number of threads: 128
  Initializing random number generator from current time


  Extra file open flags: (none)
  1024 files, 64MiB each
  64GiB total file size
  Block size 16KiB
  Periodic FSYNC enabled, calling fsync() each 100 requests.
  Calling fsync() at the end of test, Enabled.
  Using synchronous I/O mode
  Doing sequential write (creation) test
  Initializing worker threads...

  Threads started!


  Throughput:
           read:  IOPS=0.00 0.00 MiB/s (0.00 MB/s)
           write: IOPS=31710.38 495.47 MiB/s (519.54 MB/s)
           fsync: IOPS=324931.88

  Latency (ms):
           min:                                  0.00
           avg:                                  0.33
           max:                               1051.69
           95th percentile:                      0.32
           sum:                            71309894.62

Thanks,
Yi.

> 
> 
> commit: 6a3afb6ac6dfab158ebdd4b87941178f58c8939f ("jbd2: increase the journal IO's priority")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> testcase: fileio
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> parameters:
> 
> 	period: 600s
> 	nr_threads: 100%
> 	disk: 1HDD
> 	fs: ext4
> 	size: 64G
> 	filenum: 1024f
> 	rwmode: seqwr
> 	iomode: sync
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202401021525.a27b9444-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240102/202401021525.a27b9444-oliver.sang@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/filenum/fs/iomode/kconfig/nr_threads/period/rootfs/rwmode/size/tbox_group/testcase:
>   gcc-12/performance/1HDD/1024f/ext4/sync/x86_64-rhel-8.3/100%/600s/debian-11.1-x86_64-20220510.cgz/seqwr/64G/lkp-icl-2sp5/fileio
> 
> commit: 
>   8555922721 ("jbd2: correct the printing of write_flags in jbd2_write_superblock()")
>   6a3afb6ac6 ("jbd2: increase the journal IO's priority")
> 
> 85559227211020b2 6a3afb6ac6dfab158ebdd4b8794 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>      37.99 ±  9%     +92.5%      73.13        fileio.latency_95th_ms
>      19872 ± 16%     -24.1%      15078 ± 21%  numa-meminfo.node1.Active(file)
>      24.74 ±  6%     +97.3%      48.81 ±  2%  perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
>    8157448            -5.7%    7691858 ±  2%  proc-vmstat.pgpgout
>      13464            -5.7%      12700 ±  2%  vmstat.io.bo
>       4968 ± 16%     -24.1%       3768 ± 21%  numa-vmstat.node1.nr_active_file
>       4968 ± 16%     -24.1%       3768 ± 21%  numa-vmstat.node1.nr_zone_active_file
>       1413            +2.8%       1452 ±  2%  perf-stat.i.cycles-between-cache-misses
>       1.59            -2.9%       1.54        perf-stat.overall.MPKI
>       1368            +2.5%       1402        perf-stat.overall.cycles-between-cache-misses
>     161.13 ±  9%     +17.4%     189.23 ± 10%  sched_debug.cpu.curr->pid.avg
>      25531 ±  6%     -12.4%      22376 ±  8%  sched_debug.cpu.nr_switches.stddev
>     -93.66           +38.8%    -130.00        sched_debug.cpu.nr_uninterruptible.min
> 
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 

