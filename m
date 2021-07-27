Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4583D6DB5
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 06:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhG0EsY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 00:48:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:17025 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234904AbhG0EsQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 27 Jul 2021 00:48:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="209256253"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="yaml'?scan'208";a="209256253"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 21:48:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="yaml'?scan'208";a="505334132"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 21:48:10 -0700
Date:   Tue, 27 Jul 2021 13:06:26 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     0day robot <lkp@intel.com>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: [ext4]  57e8668f62:  aim7.jobs-per-min 60.2% improvement
Message-ID: <20210727050626.GA16459@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210716122024.1105856-5-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Greeting,

FYI, we noticed a 60.2% improvement of aim7.jobs-per-min due to commit:


commit: 57e8668f62e2f2fb09bc459d660f2af04aad9255 ("[PATCH v3 4/4] ext4: drop unnecessary journal handle in delalloc write")
url: https://github.com/0day-ci/linux/commits/Zhang-Yi/ext4-improve-delalloc-buffer-write-performance/20210718-105534
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev

in testcase: aim7
on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
with following parameters:

	disk: 4BRD_12G
	md: RAID1
	fs: ext4
	test: disk_rw
	load: 3000
	cpufreq_governor: performance
	ucode: 0x5003006

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 60.6% improvement                                       |
| test machine     | 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory |
| test parameters  | cpufreq_governor=performance                                                    |
|                  | disk=4BRD_12G                                                                   |
|                  | fs=ext4                                                                         |
|                  | load=3000                                                                       |
|                  | md=RAID0                                                                        |
|                  | test=disk_rw                                                                    |
|                  | ucode=0x5003006                                                                 |
+------------------+---------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
        bin/lkp run                    generated-yaml-file

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/ext4/x86_64-rhel-8.3/3000/RAID1/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rw/aim7/0x5003006

commit: 
  45f1df8c51 ("ext4: factor out write end code of inline file")
  57e8668f62 ("ext4: drop unnecessary journal handle in delalloc write")

45f1df8c51768910 57e8668f62e2f2fb09bc459d660 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     90668           +60.2%     145273        aim7.jobs-per-min
    199.85           -37.3%     125.24        aim7.time.elapsed_time
    199.85           -37.3%     125.24        aim7.time.elapsed_time.max
   1322263           -51.8%     637493        aim7.time.involuntary_context_switches
    225811 ±  2%      -9.8%     203703 ±  2%  aim7.time.minor_page_faults
     15643           -40.3%       9340        aim7.time.system_time
    257.97            -6.4%     241.57        aim7.time.user_time
    179568           -32.9%     120556        aim7.time.voluntary_context_switches
     43.66            +1.8%      44.42        boot-time.boot
    248.41           -29.5%     175.08        uptime.boot
      7.15 ±  2%     +56.0%      11.14 ±  5%  iostat.cpu.idle
     91.32            -5.2%      86.59        iostat.cpu.system
      1.52           +48.0%       2.25        iostat.cpu.user
    918.67 ± 12%     -17.8%     755.57        vmstat.memory.buff
    195.67 ±  5%     -21.1%     154.43 ±  2%  vmstat.procs.r
      9188           -15.0%       7812        vmstat.system.cs
      6.25 ±  2%      +3.6        9.81 ±  5%  mpstat.cpu.all.idle%
      3.28            +0.3        3.61        mpstat.cpu.all.irq%
      0.13            +0.0        0.17 ±  2%  mpstat.cpu.all.soft%
      1.53            +0.7        2.28        mpstat.cpu.all.usr%
      2792            -1.1%       2762        turbostat.Bzy_MHz
      6.21           +46.7%       9.11 ± 13%  turbostat.CPU%c1
      0.07 ±  6%   +1045.5%       0.84 ± 98%  turbostat.CPU%c6
  36901039           -36.2%   23553568        turbostat.IRQ
    212633 ± 17%     -53.6%      98580 ±  6%  numa-meminfo.node1.Active
    212185 ± 17%     -53.6%      98413 ±  6%  numa-meminfo.node1.Active(anon)
    712775 ±  2%      -8.2%     654441 ±  2%  numa-meminfo.node1.Dirty
    922105 ±  6%     -11.7%     814457 ±  7%  numa-meminfo.node1.Inactive
    712749 ±  2%      -8.2%     654062 ±  2%  numa-meminfo.node1.Inactive(file)
    248023 ± 18%     -45.6%     134986 ± 15%  numa-meminfo.node1.Shmem
     17503           -10.0%      15745        slabinfo.Acpi-State.active_objs
     17504           -10.0%      15747        slabinfo.Acpi-State.num_objs
      9171 ±  7%     -13.1%       7970 ±  3%  slabinfo.kmalloc-192.active_objs
      9247 ±  7%     -12.9%       8058 ±  3%  slabinfo.kmalloc-192.num_objs
      9970 ± 23%     -25.1%       7467 ±  8%  slabinfo.skbuff_ext_cache.active_objs
     10082 ± 22%     -25.1%       7552 ±  8%  slabinfo.skbuff_ext_cache.num_objs
    246278           -55.9%     108689 ±  4%  meminfo.Active
    245097           -56.1%     107692 ±  4%  meminfo.Active(anon)
      1180 ± 10%     -15.6%     996.43 ±  3%  meminfo.Active(file)
    164596           -15.8%     138561        meminfo.AnonHugePages
    914.67 ± 12%     -17.9%     751.00        meminfo.Buffers
     78427 ±  5%     +26.9%      99488 ±  5%  meminfo.Mapped
    289109 ±  2%     -42.5%     166378 ±  2%  meminfo.Shmem
     52968 ± 17%     -53.8%      24496 ±  5%  numa-vmstat.node1.nr_active_anon
    177997 ±  2%      -8.2%     163447        numa-vmstat.node1.nr_dirty
    178023 ±  2%      -8.2%     163352        numa-vmstat.node1.nr_inactive_file
     62044 ± 18%     -45.6%      33723 ± 15%  numa-vmstat.node1.nr_shmem
     52968 ± 17%     -53.8%      24496 ±  5%  numa-vmstat.node1.nr_zone_active_anon
    178026 ±  2%      -8.2%     163355        numa-vmstat.node1.nr_zone_inactive_file
    178763 ±  2%      -8.1%     164234        numa-vmstat.node1.nr_zone_write_pending
     61216           -56.2%      26806 ±  4%  proc-vmstat.nr_active_anon
    345382            -6.6%     322434        proc-vmstat.nr_dirty
   1010144            -5.4%     956008        proc-vmstat.nr_file_pages
    102844            +2.9%     105873        proc-vmstat.nr_inactive_anon
    345467            -6.6%     322532        proc-vmstat.nr_inactive_file
     60214            -2.2%      58901        proc-vmstat.nr_kernel_stack
     19668 ±  6%     +27.0%      24969 ±  5%  proc-vmstat.nr_mapped
     72191 ±  2%     -42.5%      41528 ±  2%  proc-vmstat.nr_shmem
     72062            -3.1%      69862        proc-vmstat.nr_slab_reclaimable
     83276            -1.5%      81989        proc-vmstat.nr_slab_unreclaimable
     61216           -56.2%      26806 ±  4%  proc-vmstat.nr_zone_active_anon
    102844            +2.9%     105873        proc-vmstat.nr_zone_inactive_anon
    345467            -6.6%     322532        proc-vmstat.nr_zone_inactive_file
    346851            -6.6%     323972        proc-vmstat.nr_zone_write_pending
     75551 ±  4%     -26.1%      55808 ±  9%  proc-vmstat.numa_hint_faults
     43171 ±  6%     -31.9%      29420 ± 10%  proc-vmstat.numa_hint_faults_local
     45315 ± 11%     -32.2%      30714 ± 25%  proc-vmstat.numa_pages_migrated
    223574 ±  3%     -11.8%     197184 ±  7%  proc-vmstat.numa_pte_updates
    976856           -19.1%     790307        proc-vmstat.pgfault
     45315 ± 11%     -32.2%      30714 ± 25%  proc-vmstat.pgmigrate_success
     49949           -31.1%      34427        proc-vmstat.pgreuse
      1708 ±  2%      -3.7%       1646        proc-vmstat.unevictable_pgs_culled
 2.863e+10           +37.2%  3.928e+10        perf-stat.i.branch-instructions
  58194922           +18.0%   68646396        perf-stat.i.branch-misses
     32.71            -1.0       31.70        perf-stat.i.cache-miss-rate%
  97395396           -10.5%   87157164 ±  2%  perf-stat.i.cache-misses
 2.874e+08           -10.1%  2.585e+08        perf-stat.i.cache-references
      9191           -15.1%       7805        perf-stat.i.context-switches
      1.70           -29.3%       1.20        perf-stat.i.cpi
 2.259e+11            -4.9%  2.148e+11        perf-stat.i.cpu-cycles
 3.901e+10           +37.8%  5.377e+10        perf-stat.i.dTLB-loads
 2.147e+10           +38.5%  2.973e+10        perf-stat.i.dTLB-stores
  21936223 ±  3%     +12.2%   24603783        perf-stat.i.iTLB-load-misses
 1.297e+11           +37.6%  1.785e+11        perf-stat.i.instructions
      5923 ±  3%     +21.9%       7218        perf-stat.i.instructions-per-iTLB-miss
      0.60           +39.7%       0.84        perf-stat.i.ipc
      2.57            -4.9%       2.44        perf-stat.i.metric.GHz
    279.64           +10.0%     307.73 ±  8%  perf-stat.i.metric.K/sec
      1015           +37.6%       1397        perf-stat.i.metric.M/sec
      4642           +27.5%       5920        perf-stat.i.minor-faults
     76.21            -2.5       73.66        perf-stat.i.node-load-miss-rate%
  11033575            -9.2%   10023610        perf-stat.i.node-load-misses
   3389631            +6.8%    3620610 ±  2%  perf-stat.i.node-loads
     61.27            -5.3       55.97        perf-stat.i.node-store-miss-rate%
   5328168            +4.5%    5568818        perf-stat.i.node-store-misses
   3205270           +27.0%    4071063        perf-stat.i.node-stores
      4649           +27.6%       5931        perf-stat.i.page-faults
      2.21           -34.7%       1.45        perf-stat.overall.MPKI
      0.20            -0.0        0.17        perf-stat.overall.branch-miss-rate%
      1.74           -30.9%       1.20        perf-stat.overall.cpi
      2321            +6.2%       2465 ±  2%  perf-stat.overall.cycles-between-cache-misses
      5920 ±  3%     +22.6%       7257        perf-stat.overall.instructions-per-iTLB-miss
      0.57           +44.8%       0.83        perf-stat.overall.ipc
     76.50            -3.1       73.44        perf-stat.overall.node-load-miss-rate%
     62.44            -4.7       57.75        perf-stat.overall.node-store-miss-rate%
 2.863e+10           +37.3%  3.931e+10        perf-stat.ps.branch-instructions
  58113275           +17.9%   68518841        perf-stat.ps.branch-misses
  97303334           -10.4%   87224204 ±  2%  perf-stat.ps.cache-misses
 2.871e+08           -10.0%  2.585e+08        perf-stat.ps.cache-references
      9168           -15.1%       7780        perf-stat.ps.context-switches
 2.259e+11            -4.8%   2.15e+11        perf-stat.ps.cpu-cycles
   3.9e+10           +38.0%  5.381e+10        perf-stat.ps.dTLB-loads
 2.146e+10           +38.6%  2.976e+10        perf-stat.ps.dTLB-stores
  21931530 ±  3%     +12.3%   24622094        perf-stat.ps.iTLB-load-misses
 1.297e+11           +37.8%  1.787e+11        perf-stat.ps.instructions
      4537           +26.5%       5741        perf-stat.ps.minor-faults
  11023788            -9.1%   10021712        perf-stat.ps.node-load-misses
   3385728            +7.0%    3624356 ±  2%  perf-stat.ps.node-loads
   5330547            +4.5%    5572866        perf-stat.ps.node-store-misses
   3205864           +27.2%    4077407        perf-stat.ps.node-stores
      4543           +26.6%       5752        perf-stat.ps.page-faults
 2.601e+13           -13.3%  2.254e+13        perf-stat.total.instructions
     22627 ±  4%     -23.2%      17379 ± 11%  softirqs.CPU0.RCU
     17988 ±  5%     -33.0%      12044 ± 10%  softirqs.CPU10.RCU
     17467 ±  4%     -31.8%      11915 ±  7%  softirqs.CPU11.RCU
     17388 ±  5%     -28.7%      12393 ± 14%  softirqs.CPU12.RCU
     17482 ±  5%     -32.4%      11826 ±  7%  softirqs.CPU13.RCU
     16961 ±  9%     -29.2%      12010 ±  9%  softirqs.CPU14.RCU
     17309 ±  2%     -31.3%      11890 ±  5%  softirqs.CPU15.RCU
     17392 ±  3%     -34.4%      11413 ±  4%  softirqs.CPU16.RCU
     17367 ±  5%     -33.7%      11517 ±  4%  softirqs.CPU18.RCU
     17147 ±  5%     -32.5%      11581 ± 10%  softirqs.CPU19.RCU
     18411 ±  7%     -27.6%      13334 ± 15%  softirqs.CPU2.RCU
     16815           -29.0%      11941 ±  7%  softirqs.CPU20.RCU
     16883 ±  2%     -31.0%      11641 ±  5%  softirqs.CPU21.RCU
     17509 ±  4%     -30.1%      12239 ±  9%  softirqs.CPU22.RCU
     18150 ±  5%     -32.8%      12196 ±  7%  softirqs.CPU23.RCU
     17569 ±  6%     -28.6%      12548 ±  7%  softirqs.CPU24.RCU
     17494 ±  4%     -31.0%      12063 ±  5%  softirqs.CPU25.RCU
     17798 ±  4%     -31.9%      12128 ±  3%  softirqs.CPU26.RCU
     17527 ±  4%     -32.1%      11897 ±  5%  softirqs.CPU27.RCU
     17335 ±  4%     -32.2%      11752 ± 12%  softirqs.CPU28.RCU
     17323 ±  4%     -31.6%      11842 ±  8%  softirqs.CPU29.RCU
     17306 ±  2%     -26.5%      12717 ± 10%  softirqs.CPU3.RCU
     17334 ±  5%     -31.2%      11933 ±  6%  softirqs.CPU30.RCU
     17430 ±  4%     -31.2%      11992 ±  5%  softirqs.CPU31.RCU
     17837 ±  6%     -31.9%      12142 ±  4%  softirqs.CPU32.RCU
     17283 ±  4%     -33.1%      11556 ±  4%  softirqs.CPU34.RCU
     16867 ±  6%     -28.2%      12117 ±  7%  softirqs.CPU35.RCU
     17241 ±  4%     -31.3%      11836 ±  4%  softirqs.CPU36.RCU
     17353 ±  4%     -31.2%      11937 ±  4%  softirqs.CPU38.RCU
     17236 ±  4%     -30.9%      11908 ±  5%  softirqs.CPU39.RCU
     18184 ±  6%     -29.3%      12852 ± 10%  softirqs.CPU4.RCU
     17218 ±  3%     -31.8%      11748 ±  4%  softirqs.CPU40.RCU
     17386 ±  2%     -31.7%      11879 ±  7%  softirqs.CPU41.RCU
     17975 ±  6%     -32.7%      12091 ±  5%  softirqs.CPU42.RCU
     17593 ±  8%     -30.9%      12149 ±  6%  softirqs.CPU43.RCU
     17759 ±  5%     -35.3%      11494 ± 16%  softirqs.CPU45.RCU
     16957 ±  3%     -27.4%      12305 ± 10%  softirqs.CPU46.RCU
     17368 ±  2%     -32.4%      11740 ±  6%  softirqs.CPU47.RCU
     17599 ±  3%     -31.3%      12097 ±  5%  softirqs.CPU48.RCU
     17634 ±  4%     -29.5%      12431 ±  7%  softirqs.CPU49.RCU
     18443 ± 12%     -31.5%      12627 ±  4%  softirqs.CPU5.RCU
     17104 ±  4%     -27.0%      12478 ±  6%  softirqs.CPU50.RCU
     17825 ±  5%     -32.6%      12017 ±  8%  softirqs.CPU51.RCU
     17420 ±  2%     -30.2%      12154 ±  7%  softirqs.CPU52.RCU
     17589 ±  3%     -31.8%      11996 ±  8%  softirqs.CPU53.RCU
     17800 ±  5%     -31.3%      12227 ±  7%  softirqs.CPU54.RCU
     17818 ±  3%     -28.8%      12684 ± 13%  softirqs.CPU55.RCU
     17889 ±  5%     -32.6%      12063 ±  6%  softirqs.CPU56.RCU
     17339 ±  4%     -28.0%      12490 ±  8%  softirqs.CPU57.RCU
     17415 ±  3%     -29.2%      12333 ± 12%  softirqs.CPU59.RCU
     17548 ±  3%     -31.6%      11998 ±  4%  softirqs.CPU6.RCU
     17745 ±  6%     -32.7%      11947 ±  6%  softirqs.CPU60.RCU
     17663 ±  4%     -32.6%      11901 ± 12%  softirqs.CPU61.RCU
     18337 ± 10%     -36.8%      11581 ±  5%  softirqs.CPU62.RCU
     17425 ±  3%     -32.9%      11691 ±  6%  softirqs.CPU63.RCU
     17321 ±  3%     -31.9%      11799 ±  7%  softirqs.CPU64.RCU
     17170 ±  5%     -30.2%      11978 ±  4%  softirqs.CPU65.RCU
     15852 ± 14%     -26.3%      11684 ±  5%  softirqs.CPU66.RCU
     17611 ±  5%     -31.6%      12040 ±  8%  softirqs.CPU67.RCU
     17539 ±  2%     -30.7%      12153 ±  4%  softirqs.CPU68.RCU
     17603 ±  2%     -32.1%      11946 ±  4%  softirqs.CPU69.RCU
     17269 ±  3%     -33.1%      11556 ± 11%  softirqs.CPU7.RCU
     17805 ±  5%     -31.6%      12170 ± 12%  softirqs.CPU70.RCU
     18568 ± 11%     -32.1%      12606 ±  6%  softirqs.CPU71.RCU
     17500 ±  3%     -32.5%      11816 ± 11%  softirqs.CPU72.RCU
     17499 ±  4%     -31.4%      12005 ±  8%  softirqs.CPU73.RCU
     17354 ±  2%     -25.3%      12971 ± 13%  softirqs.CPU74.RCU
     16304 ±  4%     -30.1%      11400 ±  7%  softirqs.CPU75.RCU
     16150 ±  3%     -27.3%      11745 ±  9%  softirqs.CPU76.RCU
     15797 ±  5%     -30.2%      11021 ±  6%  softirqs.CPU77.RCU
     15948 ±  3%     -27.1%      11632 ±  8%  softirqs.CPU78.RCU
     17233 ±  3%     -30.6%      11956 ±  9%  softirqs.CPU8.RCU
     16088 ±  3%     -28.3%      11537 ±  9%  softirqs.CPU80.RCU
     16098 ±  5%     -29.3%      11380 ±  3%  softirqs.CPU81.RCU
     16499 ±  6%     -31.0%      11388 ±  7%  softirqs.CPU82.RCU
     16145 ±  5%     -30.6%      11202 ±  6%  softirqs.CPU83.RCU
     16119 ±  4%     -29.7%      11333 ±  7%  softirqs.CPU84.RCU
     16640 ±  9%     -30.6%      11545 ±  4%  softirqs.CPU85.RCU
     16527 ±  5%     -32.4%      11164 ±  4%  softirqs.CPU86.RCU
     17396 ±  7%     -34.9%      11327 ± 10%  softirqs.CPU87.RCU
     17432 ±  4%     -30.5%      12117 ± 10%  softirqs.CPU9.RCU
   1524142 ±  2%     -30.5%    1058751 ±  4%  softirqs.RCU
    469127           -16.1%     393426 ±  2%  softirqs.SCHED
     44548           -27.8%      32184        softirqs.TIMER
    189560           -14.1%     162909        interrupts.CAL:Function_call_interrupts
      2395 ±  6%     -17.3%       1981 ±  6%  interrupts.CPU0.CAL:Function_call_interrupts
    402068           -37.5%     251336        interrupts.CPU0.LOC:Local_timer_interrupts
      1194 ± 13%     -35.9%     765.43 ± 15%  interrupts.CPU0.RES:Rescheduling_interrupts
      2573 ± 18%     -23.3%       1974 ±  8%  interrupts.CPU1.CAL:Function_call_interrupts
    402114           -37.5%     251316        interrupts.CPU1.LOC:Local_timer_interrupts
      1122 ± 12%     -38.8%     687.14 ±  3%  interrupts.CPU1.RES:Rescheduling_interrupts
      2213 ±  9%     -18.0%       1815 ±  2%  interrupts.CPU10.CAL:Function_call_interrupts
    402099           -37.5%     251269        interrupts.CPU10.LOC:Local_timer_interrupts
      1202 ± 25%     -36.2%     766.43 ± 12%  interrupts.CPU10.RES:Rescheduling_interrupts
    402034           -37.5%     251116        interrupts.CPU11.LOC:Local_timer_interrupts
      1021 ±  7%     -32.6%     688.00 ±  5%  interrupts.CPU11.RES:Rescheduling_interrupts
      2057           -13.8%       1774 ±  3%  interrupts.CPU12.CAL:Function_call_interrupts
    402051           -37.5%     251238        interrupts.CPU12.LOC:Local_timer_interrupts
      1063 ± 12%     -34.8%     693.57 ±  6%  interrupts.CPU12.RES:Rescheduling_interrupts
      2145 ±  8%     -16.3%       1796 ±  3%  interrupts.CPU13.CAL:Function_call_interrupts
    401885           -37.5%     251206        interrupts.CPU13.LOC:Local_timer_interrupts
      1052 ±  8%     -33.1%     704.71 ±  4%  interrupts.CPU13.RES:Rescheduling_interrupts
      2247 ± 10%     -19.6%       1807 ±  3%  interrupts.CPU14.CAL:Function_call_interrupts
    402014           -37.5%     251208        interrupts.CPU14.LOC:Local_timer_interrupts
      1118 ± 25%     -39.0%     682.43 ±  6%  interrupts.CPU14.RES:Rescheduling_interrupts
      2163 ± 10%     -16.6%       1804 ±  2%  interrupts.CPU15.CAL:Function_call_interrupts
    401988           -37.5%     251267        interrupts.CPU15.LOC:Local_timer_interrupts
    402156           -37.6%     250978        interrupts.CPU16.LOC:Local_timer_interrupts
      1027 ±  8%     -31.8%     701.14 ±  4%  interrupts.CPU16.RES:Rescheduling_interrupts
      2103 ±  3%     -14.7%       1793 ±  2%  interrupts.CPU17.CAL:Function_call_interrupts
    402161           -37.5%     251173        interrupts.CPU17.LOC:Local_timer_interrupts
      1168 ± 28%     -38.6%     717.00 ±  7%  interrupts.CPU17.RES:Rescheduling_interrupts
      2066 ±  3%     -10.2%       1855 ±  6%  interrupts.CPU18.CAL:Function_call_interrupts
    402025           -37.5%     251137        interrupts.CPU18.LOC:Local_timer_interrupts
      2062 ±  2%     -12.1%       1812 ±  4%  interrupts.CPU19.CAL:Function_call_interrupts
    402099           -37.5%     251228        interrupts.CPU19.LOC:Local_timer_interrupts
    402091           -37.5%     251174        interrupts.CPU2.LOC:Local_timer_interrupts
      1026 ±  7%     -30.0%     718.57 ±  4%  interrupts.CPU2.RES:Rescheduling_interrupts
      2030 ±  3%     -10.5%       1816 ±  2%  interrupts.CPU20.CAL:Function_call_interrupts
    402015           -37.5%     251263        interrupts.CPU20.LOC:Local_timer_interrupts
    986.50 ±  4%     -28.0%     709.86 ±  6%  interrupts.CPU20.RES:Rescheduling_interrupts
    402043           -37.5%     251208        interrupts.CPU21.LOC:Local_timer_interrupts
      1096 ± 16%     -33.1%     733.71 ± 14%  interrupts.CPU21.RES:Rescheduling_interrupts
    402119           -37.7%     250465 ±  2%  interrupts.CPU22.LOC:Local_timer_interrupts
      1325 ± 12%     -36.5%     841.71 ±  5%  interrupts.CPU22.RES:Rescheduling_interrupts
      2148 ±  2%     -10.5%       1922        interrupts.CPU23.CAL:Function_call_interrupts
    402064           -37.7%     250449 ±  2%  interrupts.CPU23.LOC:Local_timer_interrupts
      1088 ±  4%     -39.5%     658.43 ±  2%  interrupts.CPU23.RES:Rescheduling_interrupts
    402279           -37.8%     250236 ±  2%  interrupts.CPU24.LOC:Local_timer_interrupts
      2138 ±  2%     -11.1%       1901 ±  2%  interrupts.CPU25.CAL:Function_call_interrupts
    401916           -37.7%     250578 ±  2%  interrupts.CPU25.LOC:Local_timer_interrupts
      1077 ±  8%     -35.3%     697.43 ±  7%  interrupts.CPU25.RES:Rescheduling_interrupts
    401887           -37.7%     250536 ±  2%  interrupts.CPU26.LOC:Local_timer_interrupts
      1067 ±  7%     -37.8%     664.14 ±  2%  interrupts.CPU26.RES:Rescheduling_interrupts
    401898           -37.7%     250417 ±  2%  interrupts.CPU27.LOC:Local_timer_interrupts
      1054 ±  5%     -35.3%     682.57 ±  2%  interrupts.CPU27.RES:Rescheduling_interrupts
      2255 ±  5%     -22.8%       1741 ± 17%  interrupts.CPU28.CAL:Function_call_interrupts
    402037           -37.7%     250444 ±  2%  interrupts.CPU28.LOC:Local_timer_interrupts
      1165 ± 29%     -43.6%     657.57 ±  6%  interrupts.CPU28.RES:Rescheduling_interrupts
    402085           -37.7%     250380 ±  2%  interrupts.CPU29.LOC:Local_timer_interrupts
      1057 ±  5%     -38.0%     655.86 ±  2%  interrupts.CPU29.RES:Rescheduling_interrupts
      2332 ± 13%     -19.7%       1873 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
    401973           -37.6%     251021        interrupts.CPU3.LOC:Local_timer_interrupts
      2178 ±  5%     -14.9%       1852        interrupts.CPU30.CAL:Function_call_interrupts
    402006           -37.7%     250355 ±  2%  interrupts.CPU30.LOC:Local_timer_interrupts
      1069 ±  6%     -39.4%     648.43 ±  5%  interrupts.CPU30.RES:Rescheduling_interrupts
      2334 ±  9%     -21.7%       1828        interrupts.CPU31.CAL:Function_call_interrupts
    401980           -37.7%     250310 ±  2%  interrupts.CPU31.LOC:Local_timer_interrupts
      1186 ± 23%     -45.8%     642.71 ±  3%  interrupts.CPU31.RES:Rescheduling_interrupts
      2189 ±  7%     -15.7%       1845 ±  2%  interrupts.CPU32.CAL:Function_call_interrupts
    402129           -37.8%     250307 ±  2%  interrupts.CPU32.LOC:Local_timer_interrupts
      1056 ±  7%     -35.2%     685.14 ±  8%  interrupts.CPU32.RES:Rescheduling_interrupts
    402034           -37.7%     250382 ±  2%  interrupts.CPU33.LOC:Local_timer_interrupts
      1050 ±  6%     -36.7%     664.43 ±  5%  interrupts.CPU33.RES:Rescheduling_interrupts
      2208 ±  5%     -16.5%       1844        interrupts.CPU34.CAL:Function_call_interrupts
    401997           -37.7%     250407 ±  2%  interrupts.CPU34.LOC:Local_timer_interrupts
      1162 ± 25%     -42.3%     671.00 ±  4%  interrupts.CPU34.RES:Rescheduling_interrupts
      2177 ±  3%     -16.2%       1824        interrupts.CPU35.CAL:Function_call_interrupts
    402028           -37.7%     250437 ±  2%  interrupts.CPU35.LOC:Local_timer_interrupts
      1021 ±  6%     -33.6%     678.43 ±  6%  interrupts.CPU35.RES:Rescheduling_interrupts
    402001           -37.7%     250357 ±  2%  interrupts.CPU36.LOC:Local_timer_interrupts
      1068 ±  6%     -37.2%     670.71 ±  6%  interrupts.CPU36.RES:Rescheduling_interrupts
      2200 ±  5%     -22.8%       1699 ± 19%  interrupts.CPU37.CAL:Function_call_interrupts
    401997           -37.7%     250356 ±  2%  interrupts.CPU37.LOC:Local_timer_interrupts
      1278 ± 42%     -48.5%     658.71 ±  7%  interrupts.CPU37.RES:Rescheduling_interrupts
    401956           -37.7%     250331 ±  2%  interrupts.CPU38.LOC:Local_timer_interrupts
      1015 ±  3%     -34.3%     667.43 ±  4%  interrupts.CPU38.RES:Rescheduling_interrupts
      2071           -12.0%       1822        interrupts.CPU39.CAL:Function_call_interrupts
    402120           -37.8%     250188 ±  2%  interrupts.CPU39.LOC:Local_timer_interrupts
      1049 ±  6%     -38.3%     648.00 ±  4%  interrupts.CPU39.RES:Rescheduling_interrupts
      2308 ± 10%     -19.9%       1847 ±  5%  interrupts.CPU4.CAL:Function_call_interrupts
    402110           -37.5%     251138        interrupts.CPU4.LOC:Local_timer_interrupts
      1026 ±  6%     -33.4%     683.43 ±  3%  interrupts.CPU4.RES:Rescheduling_interrupts
      2122 ±  4%     -14.3%       1819        interrupts.CPU40.CAL:Function_call_interrupts
    402099           -37.7%     250347 ±  2%  interrupts.CPU40.LOC:Local_timer_interrupts
      1146 ± 21%     -41.4%     671.29 ±  5%  interrupts.CPU40.RES:Rescheduling_interrupts
      2104 ±  3%     -14.2%       1806 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
    401910           -37.7%     250359 ±  2%  interrupts.CPU41.LOC:Local_timer_interrupts
      1150 ± 17%     -42.0%     667.29 ±  4%  interrupts.CPU41.RES:Rescheduling_interrupts
      2120 ±  2%     -15.7%       1787 ±  2%  interrupts.CPU42.CAL:Function_call_interrupts
    402006           -37.7%     250369 ±  2%  interrupts.CPU42.LOC:Local_timer_interrupts
      1118 ±  8%     -41.6%     652.86 ±  4%  interrupts.CPU42.RES:Rescheduling_interrupts
      3526 ±  3%     -18.6%       2869 ±  3%  interrupts.CPU43.CAL:Function_call_interrupts
    402052           -37.7%     250389 ±  2%  interrupts.CPU43.LOC:Local_timer_interrupts
      1811 ±  6%     -39.4%       1097 ±  8%  interrupts.CPU43.RES:Rescheduling_interrupts
      2058 ±  5%     -13.0%       1791 ±  2%  interrupts.CPU44.CAL:Function_call_interrupts
    402028           -37.5%     251076        interrupts.CPU44.LOC:Local_timer_interrupts
      1030 ± 12%     -33.0%     690.14 ±  8%  interrupts.CPU44.RES:Rescheduling_interrupts
      2047 ±  3%     -12.3%       1795 ±  4%  interrupts.CPU45.CAL:Function_call_interrupts
    402039           -37.5%     251320        interrupts.CPU45.LOC:Local_timer_interrupts
    402084           -37.5%     251241        interrupts.CPU46.LOC:Local_timer_interrupts
      1008 ± 10%     -29.0%     716.00 ±  7%  interrupts.CPU46.RES:Rescheduling_interrupts
    402045           -37.5%     251166        interrupts.CPU47.LOC:Local_timer_interrupts
      2141 ±  8%     -16.9%       1778 ±  2%  interrupts.CPU48.CAL:Function_call_interrupts
    402119           -37.5%     251178        interrupts.CPU48.LOC:Local_timer_interrupts
      1118 ± 21%     -37.8%     695.86 ±  6%  interrupts.CPU48.RES:Rescheduling_interrupts
      2187 ± 11%     -16.7%       1821 ±  5%  interrupts.CPU49.CAL:Function_call_interrupts
    402002           -37.6%     251036        interrupts.CPU49.LOC:Local_timer_interrupts
      1039 ±  7%     -30.0%     728.00 ± 11%  interrupts.CPU49.RES:Rescheduling_interrupts
    402112           -37.5%     251293        interrupts.CPU5.LOC:Local_timer_interrupts
      1026 ±  7%     -33.6%     682.14 ±  6%  interrupts.CPU5.RES:Rescheduling_interrupts
      2042 ±  2%     -12.2%       1792 ±  4%  interrupts.CPU50.CAL:Function_call_interrupts
    402041           -37.5%     251204        interrupts.CPU50.LOC:Local_timer_interrupts
      1047 ±  8%     -30.6%     726.86 ±  9%  interrupts.CPU50.RES:Rescheduling_interrupts
      2061 ±  2%     -15.2%       1747        interrupts.CPU51.CAL:Function_call_interrupts
    402005           -37.5%     251267        interrupts.CPU51.LOC:Local_timer_interrupts
      1069 ± 10%     -34.1%     704.71 ±  4%  interrupts.CPU51.RES:Rescheduling_interrupts
      2062 ±  2%     -13.4%       1787        interrupts.CPU52.CAL:Function_call_interrupts
    402039           -37.5%     251164        interrupts.CPU52.LOC:Local_timer_interrupts
      1052 ± 12%     -29.9%     737.43 ± 15%  interrupts.CPU52.RES:Rescheduling_interrupts
      2105 ±  4%     -13.7%       1817 ±  4%  interrupts.CPU53.CAL:Function_call_interrupts
    402057           -37.5%     251150        interrupts.CPU53.LOC:Local_timer_interrupts
      2084 ±  2%     -16.5%       1740 ±  4%  interrupts.CPU54.CAL:Function_call_interrupts
    402080           -37.5%     251222        interrupts.CPU54.LOC:Local_timer_interrupts
      1014 ±  5%     -31.8%     691.86 ±  6%  interrupts.CPU54.RES:Rescheduling_interrupts
    402067           -37.5%     251202        interrupts.CPU55.LOC:Local_timer_interrupts
    402099           -37.5%     251218        interrupts.CPU56.LOC:Local_timer_interrupts
    402025           -37.5%     251325        interrupts.CPU57.LOC:Local_timer_interrupts
    402232           -37.5%     251339        interrupts.CPU58.LOC:Local_timer_interrupts
    402107           -37.5%     251174        interrupts.CPU59.LOC:Local_timer_interrupts
      2217 ±  7%     -17.9%       1821 ±  2%  interrupts.CPU6.CAL:Function_call_interrupts
    402089           -37.5%     251279        interrupts.CPU6.LOC:Local_timer_interrupts
      1010 ±  7%     -30.4%     702.71 ±  4%  interrupts.CPU6.RES:Rescheduling_interrupts
    402070           -37.5%     251165        interrupts.CPU60.LOC:Local_timer_interrupts
      1021 ± 11%     -31.3%     701.86 ±  4%  interrupts.CPU60.RES:Rescheduling_interrupts
      2069 ±  3%     -13.3%       1793 ±  3%  interrupts.CPU61.CAL:Function_call_interrupts
    402212           -37.5%     251190        interrupts.CPU61.LOC:Local_timer_interrupts
    402078           -37.5%     251171        interrupts.CPU62.LOC:Local_timer_interrupts
      1084 ± 25%     -36.3%     690.86 ±  3%  interrupts.CPU62.RES:Rescheduling_interrupts
      2162 ±  9%     -17.8%       1777 ±  2%  interrupts.CPU63.CAL:Function_call_interrupts
    402009           -37.5%     251215        interrupts.CPU63.LOC:Local_timer_interrupts
    967.33 ±  6%     -26.7%     709.43 ±  9%  interrupts.CPU63.RES:Rescheduling_interrupts
    402076           -37.5%     251213        interrupts.CPU64.LOC:Local_timer_interrupts
    981.33 ± 15%     -29.5%     691.57 ±  6%  interrupts.CPU64.RES:Rescheduling_interrupts
    402010           -37.5%     251176        interrupts.CPU65.LOC:Local_timer_interrupts
      1090 ± 29%     -36.4%     693.86 ±  5%  interrupts.CPU65.RES:Rescheduling_interrupts
      2186 ±  7%     -17.1%       1812 ±  2%  interrupts.CPU66.CAL:Function_call_interrupts
    402129           -37.8%     250246 ±  2%  interrupts.CPU66.LOC:Local_timer_interrupts
    957.83 ±  9%     -35.0%     622.14 ±  3%  interrupts.CPU66.RES:Rescheduling_interrupts
      2110           -10.0%       1898 ±  5%  interrupts.CPU67.CAL:Function_call_interrupts
    402017           -37.7%     250389 ±  2%  interrupts.CPU67.LOC:Local_timer_interrupts
    938.33 ±  6%     -35.1%     608.86 ±  7%  interrupts.CPU67.RES:Rescheduling_interrupts
      2066 ±  2%     -11.3%       1832 ±  5%  interrupts.CPU68.CAL:Function_call_interrupts
    402059           -37.7%     250458 ±  2%  interrupts.CPU68.LOC:Local_timer_interrupts
      1006 ±  6%     -41.3%     590.43 ±  5%  interrupts.CPU68.RES:Rescheduling_interrupts
      2134 ±  3%     -15.5%       1804        interrupts.CPU69.CAL:Function_call_interrupts
    401896           -37.7%     250392 ±  2%  interrupts.CPU69.LOC:Local_timer_interrupts
    998.00 ± 18%     -40.3%     595.57 ±  6%  interrupts.CPU69.RES:Rescheduling_interrupts
      2144 ±  5%     -14.2%       1839 ±  2%  interrupts.CPU7.CAL:Function_call_interrupts
    402133           -37.6%     251090        interrupts.CPU7.LOC:Local_timer_interrupts
      1036 ±  6%     -24.2%     785.29 ±  9%  interrupts.CPU7.RES:Rescheduling_interrupts
      2252 ±  8%     -21.6%       1766 ±  4%  interrupts.CPU70.CAL:Function_call_interrupts
    402058           -37.7%     250410 ±  2%  interrupts.CPU70.LOC:Local_timer_interrupts
      1000 ± 12%     -41.1%     589.14 ±  4%  interrupts.CPU70.RES:Rescheduling_interrupts
      2049           -14.0%       1763 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
    402151           -37.7%     250505 ±  2%  interrupts.CPU71.LOC:Local_timer_interrupts
    935.50 ±  5%     -34.3%     614.57 ±  5%  interrupts.CPU71.RES:Rescheduling_interrupts
      2087 ±  2%     -18.2%       1706 ± 16%  interrupts.CPU72.CAL:Function_call_interrupts
    402111           -37.7%     250479 ±  2%  interrupts.CPU72.LOC:Local_timer_interrupts
    934.33 ±  8%     -35.9%     598.86 ±  4%  interrupts.CPU72.RES:Rescheduling_interrupts
    402033           -37.7%     250439 ±  2%  interrupts.CPU73.LOC:Local_timer_interrupts
      1077 ± 32%     -44.1%     602.71 ±  9%  interrupts.CPU73.RES:Rescheduling_interrupts
      2156 ± 10%     -20.9%       1705 ± 16%  interrupts.CPU74.CAL:Function_call_interrupts
    402108           -37.7%     250520 ±  2%  interrupts.CPU74.LOC:Local_timer_interrupts
    968.50 ±  6%     -37.8%     602.43 ±  7%  interrupts.CPU74.RES:Rescheduling_interrupts
      2102 ±  2%     -15.0%       1786        interrupts.CPU75.CAL:Function_call_interrupts
    402031           -37.7%     250505 ±  2%  interrupts.CPU75.LOC:Local_timer_interrupts
    955.17 ± 12%     -40.8%     565.71 ±  3%  interrupts.CPU75.RES:Rescheduling_interrupts
      2085           -13.8%       1798        interrupts.CPU76.CAL:Function_call_interrupts
    402068           -37.7%     250544 ±  2%  interrupts.CPU76.LOC:Local_timer_interrupts
    925.17 ±  9%     -37.7%     576.29 ±  7%  interrupts.CPU76.RES:Rescheduling_interrupts
      2308 ± 20%     -21.9%       1803        interrupts.CPU77.CAL:Function_call_interrupts
    402095           -37.7%     250564 ±  2%  interrupts.CPU77.LOC:Local_timer_interrupts
    956.17 ±  5%     -39.4%     579.14 ±  8%  interrupts.CPU77.RES:Rescheduling_interrupts
    402029           -37.7%     250417 ±  2%  interrupts.CPU78.LOC:Local_timer_interrupts
    921.83 ±  8%     -36.1%     589.14 ±  5%  interrupts.CPU78.RES:Rescheduling_interrupts
    402170           -37.8%     250306 ±  2%  interrupts.CPU79.LOC:Local_timer_interrupts
      2299 ± 13%     -21.7%       1801 ±  2%  interrupts.CPU8.CAL:Function_call_interrupts
    401979           -37.5%     251275        interrupts.CPU8.LOC:Local_timer_interrupts
      1066 ±  6%     -34.3%     700.14 ±  3%  interrupts.CPU8.RES:Rescheduling_interrupts
      2107 ±  3%     -14.6%       1800        interrupts.CPU80.CAL:Function_call_interrupts
    402079           -37.7%     250511 ±  2%  interrupts.CPU80.LOC:Local_timer_interrupts
      1052 ± 28%     -43.5%     594.86 ±  6%  interrupts.CPU80.RES:Rescheduling_interrupts
    402214           -37.7%     250465 ±  2%  interrupts.CPU81.LOC:Local_timer_interrupts
    979.50 ± 16%     -37.7%     610.14 ±  4%  interrupts.CPU81.RES:Rescheduling_interrupts
    402026           -37.7%     250465 ±  2%  interrupts.CPU82.LOC:Local_timer_interrupts
    958.17 ± 16%     -38.8%     586.00 ±  6%  interrupts.CPU82.RES:Rescheduling_interrupts
    402070           -37.7%     250486 ±  2%  interrupts.CPU83.LOC:Local_timer_interrupts
    904.17 ±  6%     -35.6%     582.57 ±  4%  interrupts.CPU83.RES:Rescheduling_interrupts
      2156 ±  5%     -16.9%       1792 ±  3%  interrupts.CPU84.CAL:Function_call_interrupts
    401949           -37.7%     250498 ±  2%  interrupts.CPU84.LOC:Local_timer_interrupts
      1195 ± 42%     -52.2%     571.29 ±  7%  interrupts.CPU84.RES:Rescheduling_interrupts
      2084 ±  2%     -19.3%       1682 ± 18%  interrupts.CPU85.CAL:Function_call_interrupts
    402066           -37.7%     250455 ±  2%  interrupts.CPU85.LOC:Local_timer_interrupts
    975.83 ± 16%     -42.1%     564.57 ±  4%  interrupts.CPU85.RES:Rescheduling_interrupts
      2185 ±  9%     -15.4%       1848 ±  5%  interrupts.CPU86.CAL:Function_call_interrupts
    402149           -37.7%     250482 ±  2%  interrupts.CPU86.LOC:Local_timer_interrupts
      1032 ± 26%     -39.0%     629.43 ± 13%  interrupts.CPU86.RES:Rescheduling_interrupts
      1997 ±  5%     -13.1%       1734 ±  2%  interrupts.CPU87.CAL:Function_call_interrupts
    402079           -37.7%     250418 ±  2%  interrupts.CPU87.LOC:Local_timer_interrupts
    878.83 ±  7%     -36.2%     561.00 ±  7%  interrupts.CPU87.RES:Rescheduling_interrupts
      2083 ±  2%     -12.8%       1817 ±  3%  interrupts.CPU9.CAL:Function_call_interrupts
    402140           -37.5%     251174        interrupts.CPU9.LOC:Local_timer_interrupts
      1005 ±  4%     -32.8%     675.86 ±  3%  interrupts.CPU9.RES:Rescheduling_interrupts
  35381125           -37.6%   22071192 ±  2%  interrupts.LOC:Local_timer_interrupts
     93079           -34.6%      60918        interrupts.RES:Rescheduling_interrupts
     35.57           -35.6        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     34.64           -34.6        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     31.86           -31.9        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
     50.18           -29.6       20.60        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     27.73           -26.8        0.91 ±  3%  perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     16.01           -16.0        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     15.85           -15.8        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     11.06           -11.1        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     79.67            -9.6       70.08        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      8.99 ±  2%      -9.0        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write
      8.09            -8.1        0.00        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      7.42            -7.4        0.00        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write
     86.60            -7.4       79.22        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     86.18            -7.3       78.91        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      7.15            -7.1        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      6.90            -6.9        0.00        perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end
      6.09 ±  4%      -6.1        0.00        perf-profile.calltrace.cycles-pp.do_raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
     83.77            -4.3       79.46 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     83.95            -4.2       79.70 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     85.30            -3.4       81.88 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     85.36            -3.4       81.96 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     85.72            -3.3       82.45 ±  2%  perf-profile.calltrace.cycles-pp.write
      0.58 ±  2%      -0.3        0.29 ± 86%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb
      1.76            -0.2        1.54 ±  2%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter
      1.76            -0.2        1.54 ±  2%  perf-profile.calltrace.cycles-pp.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write
      0.75            -0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.lock_acquire.fs_reclaim_acquire.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      1.29            -0.1        1.19 ±  2%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_update_time.file_update_time.ext4_write_checks
      0.58 ±  2%      +0.3        0.86 ±  3%  perf-profile.calltrace.cycles-pp.ext4_da_reserve_space.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.79 ±  4%      +0.3        1.13 ±  3%  perf-profile.calltrace.cycles-pp.lock_acquire.aa_file_perm.common_file_perm.security_file_permission.vfs_write
      0.56            +0.3        0.90 ±  2%  perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.58            +0.4        0.93 ±  2%  perf-profile.calltrace.cycles-pp.lock_is_held_type.rcu_read_lock_any_held.vfs_write.ksys_write.do_syscall_64
      0.51            +0.4        0.87        perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.71            +0.4        1.08 ±  3%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.65 ±  2%      +0.4        1.03 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.66            +0.4        1.05 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.60            +0.4        0.99 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.free_buffer_head.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range
      0.89            +0.4        1.29 ±  2%  perf-profile.calltrace.cycles-pp.jbd2_write_access_granted.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      0.70            +0.4        1.10 ±  2%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.62            +0.4        1.03 ±  2%  perf-profile.calltrace.cycles-pp.free_buffer_head.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode
      0.74            +0.4        1.16 ±  2%  perf-profile.calltrace.cycles-pp.__set_page_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end
      0.72            +0.4        1.16 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.73            +0.5        1.19 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      0.68            +0.5        1.15 ±  3%  perf-profile.calltrace.cycles-pp.lock_acquire.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks
      0.97            +0.5        1.44 ±  2%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.75            +0.5        1.25 ±  2%  perf-profile.calltrace.cycles-pp.lock_acquire.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93            +0.5        1.44 ±  2%  perf-profile.calltrace.cycles-pp.xas_descend.xas_load.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.___might_sleep.down_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.72            +0.5        1.24 ±  2%  perf-profile.calltrace.cycles-pp.lock_acquire.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +0.5        0.52 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.ext4_es_insert_delayed_block.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86            +0.5        1.39 ±  3%  perf-profile.calltrace.cycles-pp.llseek
      0.74 ±  2%      +0.5        1.27 ±  2%  perf-profile.calltrace.cycles-pp.__find_get_block.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.00            +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.76            +0.5        1.30 ±  2%  perf-profile.calltrace.cycles-pp.__cancel_dirty_page.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.creat64
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.ext4_es_lookup_extent.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.___might_sleep.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.25 ±100%      +0.6        0.82 ±  2%  perf-profile.calltrace.cycles-pp.xas_start.xas_load.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.80            +0.6        1.37 ±  3%  perf-profile.calltrace.cycles-pp.lock_acquire.down_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.00            +0.6        0.57 ±  2%  perf-profile.calltrace.cycles-pp.trace_hardirqs_on.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.85            +0.6        1.42 ±  2%  perf-profile.calltrace.cycles-pp.rcu_read_lock_any_held.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.rcu_read_lock_sched_held.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.00            +0.6        0.60 ±  4%  perf-profile.calltrace.cycles-pp.lock_page_memcg.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end
      0.00            +0.6        0.63 ±  2%  perf-profile.calltrace.cycles-pp.account_page_dirtied.__set_page_dirty.mark_buffer_dirty.__block_commit_write.block_write_end
      0.00            +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.00            +0.6        0.65 ±  3%  perf-profile.calltrace.cycles-pp.lock_acquire.jbd2_write_access_granted.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write
      0.00            +0.6        0.65 ±  2%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.6        0.65 ±  3%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.vfs_write.ksys_write.do_syscall_64
      0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.rcu_read_lock_sched_held.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      1.23            +0.7        1.89 ±  2%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.lock_release.aa_file_perm.common_file_perm.security_file_permission.vfs_write
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.fs_reclaim_acquire.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +0.7        0.66 ±  2%  perf-profile.calltrace.cycles-pp.lock_release.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82            +0.7        1.49 ±  2%  perf-profile.calltrace.cycles-pp.ext4_get_group_desc.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers.create_empty_buffers
      0.00            +0.7        0.68 ±  2%  perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.17 ±141%      +0.7        0.85 ±  2%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.ext4_evict_inode.evict
      1.77            +0.7        2.45        perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.95 ±  2%      +0.7        1.63 ±  2%  perf-profile.calltrace.cycles-pp.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      1.78            +0.7        2.47 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.lock_acquire.ext4_get_group_desc.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.lock_release.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks
      0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.lock_release.up_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.00            +0.7        0.72 ±  2%  perf-profile.calltrace.cycles-pp.lock_release.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +0.7        0.73 ±  2%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      0.95            +0.7        1.68 ±  3%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      0.00            +0.7        0.74 ±  2%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.down_write.ext4_buffered_write_iter.new_sync_write
      0.00            +0.8        0.77 ±  2%  perf-profile.calltrace.cycles-pp.lock_acquire._raw_spin_lock.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      0.00            +0.8        0.77 ±  3%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.00            +0.8        0.79 ±  3%  perf-profile.calltrace.cycles-pp.rcu_read_lock_held.xas_descend.xas_load.pagecache_get_page.grab_cache_page_write_begin
      0.00            +0.8        0.81 ±  2%  perf-profile.calltrace.cycles-pp.memcg_slab_free_hook.kmem_cache_free.free_buffer_head.try_to_free_buffers.truncate_cleanup_page
      0.00            +0.8        0.83 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.00            +0.8        0.84 ±  3%  perf-profile.calltrace.cycles-pp.lock_acquire.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      1.51            +0.8        2.35 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers.create_empty_buffers.ext4_block_write_begin
      1.47            +0.8        2.32 ±  2%  perf-profile.calltrace.cycles-pp.xas_load.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      1.27            +0.9        2.13 ±  2%  perf-profile.calltrace.cycles-pp.down_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      2.26            +0.9        3.11 ±  2%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      0.00            +0.9        0.88 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      1.57            +0.9        2.46 ±  2%  perf-profile.calltrace.cycles-pp.alloc_buffer_head.alloc_page_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin
      1.58            +0.9        2.49 ±  2%  perf-profile.calltrace.cycles-pp.alloc_page_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.67 ±  2%      +0.9        2.61 ±  2%  perf-profile.calltrace.cycles-pp.aa_file_perm.common_file_perm.security_file_permission.vfs_write.ksys_write
      1.93            +1.0        2.88 ±  2%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      1.86            +1.0        2.82 ±  2%  perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2.80            +1.0        3.80 ±  4%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1.98            +1.0        2.99 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.11            +1.1        3.21 ±  2%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      1.71            +1.1        2.81 ±  2%  perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode.evict
      1.68            +1.2        2.86 ±  2%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter
      1.73            +1.2        2.94 ±  3%  perf-profile.calltrace.cycles-pp.current_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write
      3.53            +1.3        4.81 ±  4%  perf-profile.calltrace.cycles-pp.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write.vfs_write
      2.05            +1.4        3.40 ±  3%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      1.89            +1.4        3.31 ±  2%  perf-profile.calltrace.cycles-pp.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.87            +1.4        3.30 ±  2%  perf-profile.calltrace.cycles-pp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      3.68            +1.5        5.15 ±  4%  perf-profile.calltrace.cycles-pp.ext4_write_checks.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      0.00            +1.7        1.73 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      3.36            +1.9        5.21 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.36            +1.9        5.21 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.36            +1.9        5.22 ±  2%  perf-profile.calltrace.cycles-pp.__close
      3.36            +1.9        5.22 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      3.36            +1.9        5.22 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.78            +2.0        4.73 ±  3%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      3.20            +2.1        5.32 ±  4%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
      3.31            +2.2        5.48 ±  4%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
      3.32            +2.2        5.50 ±  4%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      3.33            +2.2        5.52 ±  4%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      3.34            +2.2        5.54 ±  4%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.35            +2.2        5.55 ±  4%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.35            +2.2        5.56 ±  4%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.3        2.29 ±  7%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      4.01            +2.4        6.45 ±  2%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      3.14            +2.5        5.66 ±  3%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00            +2.9        2.86 ±  2%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +2.9        2.89 ±  2%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end.generic_perform_write
      0.00            +3.2        3.22 ±  8%  perf-profile.calltrace.cycles-pp._raw_read_unlock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +3.4        3.38 ±  6%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      0.00            +3.4        3.40        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +3.4        3.42        perf-profile.calltrace.cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +4.2        4.22 ±  8%  perf-profile.calltrace.cycles-pp.do_raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      8.47            +4.7       13.20        perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      8.55            +4.8       13.31        perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +7.3        7.32 ±  4%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00            +7.4        7.43 ±  4%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +10.6       10.59        perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.84 ±  2%     +19.4       20.22 ±  2%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      0.00           +21.8       21.79 ±  2%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00           +22.6       22.58 ±  2%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +33.2       33.20        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +41.6       41.63        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00           +45.7       45.73        perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     50.20           -29.6       20.62        perf-profile.children.cycles-pp.ext4_da_write_begin
     27.74           -26.7        1.01        perf-profile.children.cycles-pp.ext4_da_write_end
     37.17           -13.6       23.61 ±  2%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
     35.72           -12.9       22.80 ±  2%  perf-profile.children.cycles-pp.jbd2__journal_start
     32.84           -12.5       20.37 ±  2%  perf-profile.children.cycles-pp.start_this_handle
     79.74            -9.6       70.17        perf-profile.children.cycles-pp.generic_perform_write
     16.61            -8.7        7.87 ±  3%  perf-profile.children.cycles-pp.__ext4_journal_stop
     16.37            -8.6        7.75 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_stop
     86.66            -7.4       79.28        perf-profile.children.cycles-pp.new_sync_write
     86.18            -7.3       78.93        perf-profile.children.cycles-pp.ext4_buffered_write_iter
      9.27 ±  2%      -5.4        3.84 ±  3%  perf-profile.children.cycles-pp.stop_this_handle
     92.08            -4.3       87.78        perf-profile.children.cycles-pp.vfs_write
     92.25            -4.2       88.00        perf-profile.children.cycles-pp.ksys_write
      7.36            -4.0        3.33 ±  3%  perf-profile.children.cycles-pp.add_transaction_credits
     85.80            -3.2       82.57 ±  2%  perf-profile.children.cycles-pp.write
      6.40 ±  2%      -1.7        4.73 ±  5%  perf-profile.children.cycles-pp.do_raw_read_lock
      0.93 ±  3%      -0.4        0.53 ±  2%  perf-profile.children.cycles-pp.ext4_journal_check_start
     99.04            -0.4       98.69        perf-profile.children.cycles-pp.do_syscall_64
      0.52            -0.3        0.19 ±  5%  perf-profile.children.cycles-pp.unlock_page
     99.12            -0.3       98.80        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.93            -0.2        1.71 ±  2%  perf-profile.children.cycles-pp.generic_update_time
      0.15 ±  7%      -0.1        0.10 ± 26%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.21 ±  3%      -0.0        0.17 ±  6%  perf-profile.children.cycles-pp.__brelse
      0.07 ±  7%      -0.0        0.05 ±  6%  perf-profile.children.cycles-pp.__slab_free
      0.12            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.up_read
      0.05            +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.07 ± 10%      +0.0        0.09 ±  6%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.07            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      0.04 ± 44%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.ext4_invalidatepage
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.97 ±  2%      +0.0        1.00        perf-profile.children.cycles-pp.up_write
      0.07            +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.06            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.crypto_shash_update
      0.05 ±  8%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.trace_preempt_off
      0.12 ±  5%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__ext4_unlink
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.iov_iter_advance
      0.06            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.drain_obj_stock
      0.03 ± 70%      +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.09 ±  6%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.ext4_unlink
      0.12 ±  4%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.disk_rw
      0.10 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.vfs_unlink
      0.08 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__ext4_new_inode
      0.09 ±  8%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.rcu_core
      0.06 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.12 ±  3%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.07            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.xas_create
      0.06 ±  8%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.12 ±  6%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.07 ±  5%      +0.0        0.12 ±  2%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.19            +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__might_sleep
      0.12 ±  3%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.tracer_hardirqs_off
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.tracer_preempt_off
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ext4_lookup
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rw_verify_area
      0.09 ±  7%      +0.1        0.14 ±  6%  perf-profile.children.cycles-pp._raw_write_unlock
      0.15 ±  5%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.02 ±141%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__ext4_read_dirblock
      0.18 ±  6%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.09 ±  5%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.ksys_lseek
      0.07 ±  9%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.__x64_sys_write
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.do_sys_times
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.map_id_up
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.ext4_add_entry
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.mark_page_accessed
      0.08            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.tracer_preempt_on
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.update_rq_clock
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_bread
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_getblk
      0.08 ±  6%      +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.generic_write_checks
      0.07 ±  5%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.xas_find_conflict
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ext4_free_inode
      0.14 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__fdget_pos
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.__es_insert_extent
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.do_raw_spin_unlock
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.xas_alloc
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.memcg_check_events
      0.01 ±223%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.times
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__x64_sys_times
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.open64
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xas_set_mark
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.16 ±  3%      +0.1        0.22        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.11 ±  3%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.__rcu_read_lock
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.11 ±  5%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.trace_preempt_on
      0.13 ±  3%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.ext4_create
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.get_mem_cgroup_from_objcg
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.xas_find
      0.10 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.06 ±  7%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.cpuacct_charge
      0.12 ±  4%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.__xa_set_mark
      0.13            +0.1        0.21        perf-profile.children.cycles-pp.free_unref_page_list
      0.22 ±  3%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.memset_erms
      0.18 ±  4%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.11 ±  4%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.try_charge
      0.23 ±  2%      +0.1        0.31        perf-profile.children.cycles-pp.find_lock_entries
      0.09 ±  5%      +0.1        0.17 ±  3%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.13 ±  2%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
      0.15 ±  5%      +0.1        0.23        perf-profile.children.cycles-pp._raw_spin_unlock_irq
      0.13 ±  3%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.in_lock_functions
      0.12 ±  4%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.uncharge_page
      0.12 ±  6%      +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.14 ±  5%      +0.1        0.24        perf-profile.children.cycles-pp._raw_write_lock
      0.25 ±  3%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.19            +0.1        0.29 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.18 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.lookup_open
      0.08 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.23 ±  3%      +0.1        0.33        perf-profile.children.cycles-pp.down_read
      0.18 ±  4%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__entry_text_start
      0.17 ±  4%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.33 ±  9%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.ext4_inode_csum
      0.16 ±  2%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.17 ±  6%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__rcu_read_unlock
      0.24 ±  3%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.debug_smp_processor_id
      0.23 ± 20%      +0.1        0.35 ±  9%  perf-profile.children.cycles-pp.unlink
      0.13 ±  2%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.tracer_hardirqs_on
      1.24            +0.1        1.36        perf-profile.children.cycles-pp.fs_reclaim_acquire
      0.28 ±  5%      +0.1        0.40 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.36 ±  8%      +0.1        0.49 ±  4%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.24 ± 21%      +0.1        0.38 ±  9%  perf-profile.children.cycles-pp.do_unlinkat
      0.20 ±  3%      +0.1        0.34 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.29 ±  2%      +0.1        0.43 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.24 ±  2%      +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.24            +0.2        0.39 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.23 ±  2%      +0.2        0.38        perf-profile.children.cycles-pp.ext4_fc_track_inode
      0.29            +0.2        0.45 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.24 ±  3%      +0.2        0.39 ±  3%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.21 ±  2%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.39 ±  4%      +0.2        0.56 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      0.32 ±  2%      +0.2        0.49 ±  2%  perf-profile.children.cycles-pp.find_held_lock
      0.40            +0.2        0.58        perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.42            +0.2        0.61        perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.15 ±  4%      +0.2        0.35 ±  2%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      0.38            +0.2        0.58 ±  2%  perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.33 ±  8%      +0.2        0.54 ±  3%  perf-profile.children.cycles-pp.creat64
      0.43 ±  2%      +0.2        0.65        perf-profile.children.cycles-pp.lockdep_hardirqs_on
      0.50 ±  3%      +0.2        0.73 ±  8%  perf-profile.children.cycles-pp.scheduler_tick
      0.32 ±  2%      +0.2        0.55        perf-profile.children.cycles-pp.preempt_count_add
      0.31 ±  2%      +0.2        0.55 ±  2%  perf-profile.children.cycles-pp.account_page_cleaned
      0.49            +0.2        0.73        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      0.35 ±  2%      +0.2        0.59 ±  2%  perf-profile.children.cycles-pp.xa_get_order
      0.40 ±  7%      +0.2        0.65 ±  2%  perf-profile.children.cycles-pp.path_openat
      0.40 ±  7%      +0.2        0.65 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      0.50            +0.3        0.75        perf-profile.children.cycles-pp.copyin
      0.42 ±  7%      +0.3        0.67 ±  2%  perf-profile.children.cycles-pp.do_sys_open
      0.42 ±  7%      +0.3        0.67 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      0.39            +0.3        0.65        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.75 ±  3%      +0.3        1.02 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.43            +0.3        0.70        perf-profile.children.cycles-pp.account_page_dirtied
      0.75 ±  4%      +0.3        1.02 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      0.81 ±  3%      +0.3        1.09 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.38 ±  2%      +0.3        0.66 ±  2%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      1.18 ±  3%      +0.3        1.47 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.46            +0.3        0.75        perf-profile.children.cycles-pp.trace_hardirqs_off_finish
      0.67            +0.3        0.96        perf-profile.children.cycles-pp.lockdep_hardirqs_off
      0.49            +0.3        0.78        perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.46 ±  3%      +0.3        0.76 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.45            +0.3        0.74 ±  2%  perf-profile.children.cycles-pp.trace_hardirqs_on_prepare
      1.58 ±  3%      +0.3        1.88 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.40            +0.3        0.70        perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.52 ±  2%      +0.3        1.82 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.90            +0.3        2.21        perf-profile.children.cycles-pp.kmem_cache_free
      0.45 ±  2%      +0.3        0.76        perf-profile.children.cycles-pp.preempt_count_sub
      0.52            +0.3        0.83        perf-profile.children.cycles-pp.__pagevec_lru_add
      0.64 ±  2%      +0.3        0.95        perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.75            +0.3        1.07        perf-profile.children.cycles-pp.trace_hardirqs_off
      1.92 ±  2%      +0.3        2.26 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.71            +0.3        1.05 ±  2%  perf-profile.children.cycles-pp.validate_chain
      1.80 ±  2%      +0.3        2.14 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.49            +0.4        0.86        perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.57            +0.4        0.97        perf-profile.children.cycles-pp.release_pages
      0.56            +0.4        0.96        perf-profile.children.cycles-pp.__pagevec_release
      0.60 ±  2%      +0.4        1.01        perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.79            +0.4        1.20        perf-profile.children.cycles-pp.lru_cache_add
      0.74            +0.4        1.17 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.72            +0.4        1.16        perf-profile.children.cycles-pp._raw_spin_unlock
      0.77            +0.5        1.22        perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.70            +0.5        1.16        perf-profile.children.cycles-pp.xas_start
      0.68 ±  2%      +0.5        1.14        perf-profile.children.cycles-pp.free_buffer_head
      1.06            +0.5        1.52        perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.81            +0.5        1.28        perf-profile.children.cycles-pp.__set_page_dirty
      0.70            +0.5        1.18        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      1.01 ±  2%      +0.5        1.50        perf-profile.children.cycles-pp.mark_held_locks
      0.76            +0.5        1.25        perf-profile.children.cycles-pp.lock_page_memcg
      1.14            +0.5        1.67        perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      1.14            +0.5        1.67        perf-profile.children.cycles-pp.__this_cpu_preempt_check
      0.90            +0.6        1.45 ±  3%  perf-profile.children.cycles-pp.llseek
      0.94            +0.6        1.52        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.84            +0.6        1.44        perf-profile.children.cycles-pp.__cancel_dirty_page
      0.94 ±  2%      +0.6        1.56        perf-profile.children.cycles-pp.__find_get_block
      0.98 ±  2%      +0.6        1.61        perf-profile.children.cycles-pp.rcu_read_lock_any_held
      4.11            +0.7        4.76        perf-profile.children.cycles-pp.kmem_cache_alloc
      2.02            +0.7        2.71        perf-profile.children.cycles-pp.match_held_lock
      1.24            +0.7        1.96        perf-profile.children.cycles-pp.xas_descend
      1.46            +0.7        2.20        perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      1.95            +0.8        2.71        perf-profile.children.cycles-pp.ext4_da_map_blocks
      1.96            +0.8        2.72        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.97            +0.8        1.73        perf-profile.children.cycles-pp.ext4_get_group_desc
      1.18            +0.8        1.96        perf-profile.children.cycles-pp.__getblk_gfp
      1.06            +0.8        1.87        perf-profile.children.cycles-pp.mem_cgroup_charge
      2.47            +0.8        3.27        perf-profile.children.cycles-pp.debug_lockdep_rcu_enabled
      1.20            +0.8        2.02        perf-profile.children.cycles-pp._raw_spin_lock
      1.76            +0.8        2.60        perf-profile.children.cycles-pp.mark_lock
      1.77            +0.9        2.67        perf-profile.children.cycles-pp.lockdep_hardirqs_on_prepare
      3.92            +0.9        4.84        perf-profile.children.cycles-pp.___might_sleep
      1.83            +1.0        2.79        perf-profile.children.cycles-pp.trace_hardirqs_on
      1.41            +1.0        2.37        perf-profile.children.cycles-pp.down_write
      2.65            +1.0        3.61        perf-profile.children.cycles-pp.ext4_do_update_inode
      1.96 ±  2%      +1.0        2.93        perf-profile.children.cycles-pp.aa_file_perm
      1.73            +1.0        2.72        perf-profile.children.cycles-pp.alloc_buffer_head
      1.74            +1.0        2.75        perf-profile.children.cycles-pp.alloc_page_buffers
      3.28            +1.0        4.30        perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      2.73            +1.0        3.76        perf-profile.children.cycles-pp.__block_commit_write
      2.75            +1.0        3.78        perf-profile.children.cycles-pp.block_write_end
      2.13            +1.1        3.18        perf-profile.children.cycles-pp.common_file_perm
      2.04            +1.1        3.11        perf-profile.children.cycles-pp.create_empty_buffers
      2.14            +1.1        3.22        perf-profile.children.cycles-pp.mark_buffer_dirty
      2.17            +1.1        3.30        perf-profile.children.cycles-pp.security_file_permission
      1.92            +1.1        3.07        perf-profile.children.cycles-pp.xas_load
      3.89            +1.2        5.05        perf-profile.children.cycles-pp.file_update_time
      2.32            +1.2        3.55        perf-profile.children.cycles-pp.truncate_cleanup_page
      1.88            +1.2        3.12        perf-profile.children.cycles-pp.try_to_free_buffers
      1.81            +1.2        3.05        perf-profile.children.cycles-pp.rcu_read_lock_held
      4.05            +1.3        5.33        perf-profile.children.cycles-pp.ext4_write_checks
      2.34            +1.3        3.62        perf-profile.children.cycles-pp.rcu_is_watching
      1.86            +1.3        3.18        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      2.63            +1.3        3.96        perf-profile.children.cycles-pp.rcu_lockdep_current_cpu_online
      1.91            +1.4        3.27        perf-profile.children.cycles-pp.current_time
      2.26            +1.5        3.76        perf-profile.children.cycles-pp.__add_to_page_cache_locked
      2.23            +1.6        3.83        perf-profile.children.cycles-pp.__ext4_get_inode_loc
      2.24            +1.6        3.85        perf-profile.children.cycles-pp.ext4_get_inode_loc
      3.36            +1.9        5.22 ±  2%  perf-profile.children.cycles-pp.__close
      3.05            +1.9        4.96        perf-profile.children.cycles-pp.add_to_page_cache_lru
      3.52            +2.0        5.50        perf-profile.children.cycles-pp.truncate_inode_pages_range
      3.63            +2.0        5.66        perf-profile.children.cycles-pp.ext4_evict_inode
      3.64            +2.0        5.68        perf-profile.children.cycles-pp.evict
      3.66            +2.0        5.70        perf-profile.children.cycles-pp.__dentry_kill
      3.67            +2.1        5.73        perf-profile.children.cycles-pp.__fput
      3.69            +2.1        5.75        perf-profile.children.cycles-pp.dput
      3.68            +2.1        5.74        perf-profile.children.cycles-pp.task_work_run
      4.41            +2.1        6.51        perf-profile.children.cycles-pp.ext4_block_write_begin
      3.85            +2.1        5.97        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.71            +2.4        6.07        perf-profile.children.cycles-pp.ext4_reserve_inode_write
      4.74            +2.7        7.45        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      8.40            +3.0       11.40        perf-profile.children.cycles-pp.__lock_acquire
      5.91            +3.0        8.93        perf-profile.children.cycles-pp.rcu_read_lock_held_common
      7.00            +3.4       10.41        perf-profile.children.cycles-pp.lock_release
      7.00            +3.5       10.51        perf-profile.children.cycles-pp.check_preemption_disabled
      7.37            +3.7       11.07        perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      8.54            +4.8       13.30        perf-profile.children.cycles-pp.pagecache_get_page
      8.56            +4.8       13.32        perf-profile.children.cycles-pp.grab_cache_page_write_begin
     12.58            +5.4       17.94        perf-profile.children.cycles-pp.lock_is_held_type
     12.69            +5.6       18.34        perf-profile.children.cycles-pp.rcu_read_lock_sched_held
     14.85            +6.2       21.01        perf-profile.children.cycles-pp.lock_acquire
      8.85           +25.7       34.52        perf-profile.children.cycles-pp.ext4_dirty_inode
     10.13           +33.3       43.45        perf-profile.children.cycles-pp.__mark_inode_dirty
     11.06           +34.7       45.74        perf-profile.children.cycles-pp.generic_write_end
     10.70            -5.9        4.83 ±  4%  perf-profile.self.cycles-pp.start_this_handle
      8.64 ±  2%      -5.2        3.41 ±  4%  perf-profile.self.cycles-pp.stop_this_handle
      7.23            -4.0        3.25 ±  4%  perf-profile.self.cycles-pp.add_transaction_credits
      5.53            -2.9        2.60 ±  4%  perf-profile.self.cycles-pp.jbd2_journal_stop
      6.28 ±  2%      -1.6        4.63 ±  5%  perf-profile.self.cycles-pp.do_raw_read_lock
      0.51            -0.3        0.18 ±  6%  perf-profile.self.cycles-pp.unlock_page
      0.48 ±  4%      -0.3        0.21 ±  2%  perf-profile.self.cycles-pp.up_write
      0.48 ±  3%      -0.2        0.25 ±  3%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.31 ±  7%      -0.2        0.16 ±  4%  perf-profile.self.cycles-pp.new_sync_write
      0.56 ±  2%      -0.2        0.41 ±  3%  perf-profile.self.cycles-pp.do_raw_spin_lock
      0.23 ±  9%      -0.1        0.11 ± 21%  perf-profile.self.cycles-pp.__ext4_journal_stop
      0.29 ±  6%      -0.1        0.17 ±  5%  perf-profile.self.cycles-pp.ext4_journal_check_start
      0.29 ±  3%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.40 ±  2%      -0.1        0.31 ±  4%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.48 ±  3%      -0.1        0.41 ±  4%  perf-profile.self.cycles-pp.__block_commit_write
      0.23 ±  3%      -0.1        0.17 ± 13%  perf-profile.self.cycles-pp.jbd2__journal_start
      0.15 ±  4%      -0.1        0.10 ±  7%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.89            -0.1        0.84        perf-profile.self.cycles-pp.pagecache_get_page
      0.21 ±  3%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.__brelse
      0.11 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.14 ±  5%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.block_invalidatepage
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__ext4_journal_start_sb
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.create_empty_buffers
      0.11 ±  4%      -0.0        0.09 ±  6%  perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.07 ±  7%      -0.0        0.05 ±  6%  perf-profile.self.cycles-pp.__slab_free
      0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.find_lock_entries
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.lru_cache_add
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.ksys_write
      0.06 ±  8%      +0.0        0.08        perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.07 ±  7%      +0.0        0.09 ±  3%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.06 ±  9%      +0.0        0.08 ± 11%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.05 ±  8%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.crypto_shash_update
      0.10 ±  9%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.memcg_slab_free_hook
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.trace_preempt_off
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.05 ±  7%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.xas_load
      0.05 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.iov_iter_advance
      0.09 ±  5%      +0.0        0.13 ±  5%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.10 ±  3%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.disk_rw
      0.06 ±  8%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.06 ±  8%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.03 ± 70%      +0.0        0.07 ±  4%  perf-profile.self.cycles-pp.llseek
      0.11 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.05 ±  7%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.07 ±  9%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.15 ±  2%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.__might_sleep
      0.10 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.09 ± 10%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.25            +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.02 ±141%      +0.0        0.06        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tracer_hardirqs_off
      0.07 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.11 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.trace_hardirqs_off
      0.08 ±  6%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.trace_preempt_on
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.current_time
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ext4_inode_csum_set
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ext4_fc_track_inode
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_write
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.map_id_up
      0.00            +0.1        0.05 ±  6%  perf-profile.self.cycles-pp.mark_page_accessed
      0.02 ± 99%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.file_update_time
      0.09 ±  4%      +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.generic_write_end
      0.02 ±141%      +0.1        0.07        perf-profile.self.cycles-pp.__mod_node_page_state
      0.08            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.trace_hardirqs_on_prepare
      0.00            +0.1        0.05 ±  9%  perf-profile.self.cycles-pp.xas_store
      0.15 ±  6%      +0.1        0.20 ±  3%  perf-profile.self.cycles-pp.down_write
      0.09 ±  4%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.in_lock_functions
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.08            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.trace_hardirqs_off_finish
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.08 ±  8%      +0.1        0.14 ± 14%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      0.00            +0.1        0.06 ±  5%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.12 ±  4%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.10 ±  4%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.__rcu_read_lock
      0.02 ±141%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.generic_write_checks
      0.11 ±  6%      +0.1        0.17 ±  5%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.13 ±  5%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.common_file_perm
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.01 ±223%      +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.ext4_get_group_desc
      0.14 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.generic_perform_write
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.10 ±  7%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.security_file_permission
      0.20 ±  2%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.memset_erms
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__ext4_mark_inode_dirty
      0.17 ±  3%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.32            +0.1        0.40        perf-profile.self.cycles-pp.lockdep_hardirqs_off
      0.14 ±  2%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.trace_hardirqs_on
      0.12 ±  6%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.21 ±  3%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.12 ±  6%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.rcu_read_lock_held
      0.20 ±  2%      +0.1        0.30 ±  2%  perf-profile.self.cycles-pp.debug_smp_processor_id
      0.08 ±  7%      +0.1        0.18        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.17 ±  4%      +0.1        0.28 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.15 ±  6%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__rcu_read_unlock
      0.11 ±  3%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.tracer_hardirqs_on
      0.16 ±  3%      +0.1        0.26        perf-profile.self.cycles-pp.ext4_block_write_begin
      0.14 ±  4%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.21 ±  3%      +0.1        0.32 ±  2%  perf-profile.self.cycles-pp.find_held_lock
      0.28            +0.1        0.39 ±  2%  perf-profile.self.cycles-pp.lockdep_hardirqs_on
      0.28 ±  5%      +0.1        0.40 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.60 ±  2%      +0.2        0.76        perf-profile.self.cycles-pp.___might_sleep
      0.26 ±  2%      +0.2        0.44        perf-profile.self.cycles-pp.preempt_count_add
      0.36 ±  2%      +0.2        0.55        perf-profile.self.cycles-pp.mark_held_locks
      0.28 ±  3%      +0.2        0.48 ±  2%  perf-profile.self.cycles-pp.preempt_count_sub
      0.35 ±  5%      +0.2        0.56 ±  3%  perf-profile.self.cycles-pp.__find_get_block
      0.48            +0.2        0.71        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.45            +0.2        0.68        perf-profile.self.cycles-pp.__this_cpu_preempt_check
      0.39 ±  2%      +0.2        0.63        perf-profile.self.cycles-pp.lockdep_hardirqs_on_prepare
      0.69            +0.3        1.01 ±  2%  perf-profile.self.cycles-pp.validate_chain
      1.06            +0.4        1.49        perf-profile.self.cycles-pp.rcu_read_lock_sched_held
      0.68            +0.4        1.11        perf-profile.self.cycles-pp.rcu_read_lock_held_common
      1.60            +0.5        2.12        perf-profile.self.cycles-pp.match_held_lock
      2.18 ±  2%      +0.6        2.82        perf-profile.self.cycles-pp.debug_lockdep_rcu_enabled
      1.61            +0.8        2.36        perf-profile.self.cycles-pp.lock_acquire
      1.40            +0.8        2.18        perf-profile.self.cycles-pp.rcu_is_watching
      1.70            +0.8        2.50        perf-profile.self.cycles-pp.mark_lock
      1.60            +0.8        2.40        perf-profile.self.cycles-pp.lock_release
      1.87            +0.9        2.81        perf-profile.self.cycles-pp.rcu_lockdep_current_cpu_online
      6.63 ±  2%      +2.1        8.77        perf-profile.self.cycles-pp.__lock_acquire
      7.51            +3.3       10.78        perf-profile.self.cycles-pp.lock_is_held_type
      6.56            +3.3        9.84        perf-profile.self.cycles-pp.check_preemption_disabled
      0.08 ± 30%    +506.5%       0.46 ±101%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      6.63 ± 15%     -37.5%       4.14 ± 28%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.00 ±223%    +2e+05%       0.33 ±117%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__find_get_block.__getblk_gfp
      0.05 ± 74%   +1524.1%       0.73 ±124%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      0.07 ±125%    +575.2%       0.44 ± 82%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.delete_from_page_cache_batch.truncate_inode_pages_range
      0.14 ± 75%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
      0.08 ±135%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_start_sb.ext4_da_write_begin
      0.16 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
      0.02 ±198%   +1752.5%       0.36 ± 54%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__rcu_read_lock.pagecache_get_page
      0.04 ±222%   +1234.3%       0.50 ± 75%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__slab_free.kmem_cache_free
      0.00 ± 63%   +7124.5%       0.25 ± 53%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_buffered_write_iter.new_sync_write
      0.00 ±145%   +5694.3%       0.05 ±202%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_get_inode_loc.ext4_reserve_inode_write
      0.02 ±221%   +1750.3%       0.34 ± 86%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.find_lock_entries.truncate_inode_pages_range
      0.20 ± 76%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
      0.14 ±  7%    +661.8%       1.08 ±202%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
      0.05 ±217%    +386.6%       0.25 ± 59%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.free_buffer_head
      0.00 ±223%  +1.8e+05%       0.31 ± 60%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.uncharge_page
      0.06 ±120%    +534.3%       0.41 ± 26%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memcg_slab_free_hook.kmem_cache_free
      0.12 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
      0.06 ± 33%     -82.2%       0.01 ±157%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_descend.xas_load
      0.01 ± 65%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.unlock_page.ext4_da_write_begin
      0.00 ± 62%   +5596.7%       0.12 ±137%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_acquire.start_this_handle
      0.08 ± 81%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
      0.07 ± 99%    +125.6%       0.15 ± 25%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      0.13 ± 42%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
      0.32 ±128%     -71.8%       0.09 ± 40%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00 ±223%  +1.6e+05%       0.26 ± 73%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_releasepage.truncate_cleanup_page.truncate_inode_pages_range
      0.33 ± 81%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      0.17 ± 49%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
      0.01 ±114%   +1998.8%       0.13 ± 76%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.__mem_cgroup_charge.mem_cgroup_charge
      0.00 ±223%  +1.8e+05%       0.30 ±167%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.mem_cgroup_uncharge_list.release_pages
      0.06 ±114%    +215.7%       0.20 ± 65%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.pagecache_get_page.grab_cache_page_write_begin
      0.46 ± 62%     -56.6%       0.20 ± 37%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.ext4_orphan_del.ext4_evict_inode
      0.07 ± 35%     -46.3%       0.04 ± 26%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      7.03 ± 34%   +2537.9%     185.53 ±182%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±223%  +1.1e+05%       3.75 ±124%  perf-sched.sch_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__find_get_block.__getblk_gfp
     13.62 ± 39%    +223.2%      44.00 ± 48%  perf-sched.sch_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.sched_move_task.do_exit
      4.26 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
      4.94 ± 73%     -76.5%       1.16 ±152%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.generic_perform_write
      5.37 ± 70%     -99.3%       0.04 ±  5%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.pagecache_get_page
      2.62 ±140%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_start_sb.ext4_da_write_begin
     14.82 ± 94%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
      0.32 ±203%   +1750.4%       5.95 ± 48%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__rcu_read_lock.pagecache_get_page
      0.01 ±141%  +77551.9%       8.41 ± 38%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.block_invalidatepage.truncate_cleanup_page
     14.07 ± 85%     -75.6%       3.44 ±116%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.aa_file_perm
      0.03 ± 47%  +19550.3%       6.84 ± 37%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_buffered_write_iter.new_sync_write
    655.93 ±208%     -99.3%       4.65 ± 97%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_da_write_begin.generic_perform_write
      0.01 ±141%   +3862.3%       0.35 ±218%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_get_inode_loc.ext4_reserve_inode_write
      0.01 ±141%  +10302.7%       1.28 ±237%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_inode_table.__ext4_get_inode_loc
      3.56 ± 90%     -86.4%       0.48 ±244%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_llseek.ksys_lseek
      1.07 ±221%    +420.5%       5.58 ± 67%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.find_lock_entries.truncate_inode_pages_range
      0.00 ±223%  +2.3e+05%       7.66 ± 40%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.free_unref_page_list.release_pages
      5.56 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
      0.00 ±223%  +5.1e+05%       8.45 ± 20%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.memcg_slab_free_hook
      9.55 ± 15%     +65.7%      15.82 ± 56%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.pagecache_get_page
      0.01 ±176%  +65590.8%       6.13 ± 47%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.uncharge_page
     10.98 ± 19%     -58.5%       4.55 ± 78%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
      0.00 ±223%  +21592.1%       0.98 ±235%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.get_mem_cgroup_from_mm
     13.65 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
    633.73 ±216%     -99.4%       4.02 ± 79%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.up_write.ext4_buffered_write_iter
      6.39 ± 29%     -93.2%       0.44 ±221%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_descend.xas_load
      1.45 ±216%    +479.3%       8.38 ± 60%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_is_held_type.___might_sleep
      0.04 ± 10%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.unlock_page.ext4_da_write_begin
      0.10 ±155%  +24810.8%      24.41 ±191%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_acquire.fs_reclaim_acquire
      0.01 ±142%  +16908.2%       1.98 ±236%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_is_held_type.xas_descend
      7.33 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
      4.05 ± 99%    +145.5%       9.94 ± 18%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
     11.79 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
      0.01 ±223%  +76535.9%       4.47 ± 63%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_releasepage.truncate_cleanup_page.truncate_inode_pages_range
     54.52 ± 96%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
     11.69 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
     10.48 ± 45%     -52.9%       4.94 ± 50%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_mem_cgroup_from_mm.mem_cgroup_charge
      0.00 ±223%  +1.8e+05%       5.94 ±165%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.mem_cgroup_uncharge_list.release_pages
     96.98 ± 59%     -83.7%      15.78 ±149%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_kthread.kthread.ret_from_fork
      3666 ±  4%     -15.1%       3113 ±  4%  perf-sched.total_sch_delay.max.ms
     98050 ±  4%     -17.2%      81184 ±  4%  perf-sched.total_wait_and_delay.count.ms
    296.66 ±  3%     -21.5%     232.83 ± 13%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    322.51 ±  7%     -35.5%     208.00 ±  4%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    101.52 ±141%    +249.0%     354.33 ± 16%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.ext4_es_lookup_extent.ext4_da_map_blocks
    293.83 ±  7%     +13.1%     332.32 ±  4%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
     87.29 ±141%    +287.0%     337.82 ± 13%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__dquot_alloc_space.ext4_da_reserve_space
    145.08 ±100%    +130.2%     334.03 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_da_reserve_space.ext4_da_map_blocks
    242.07 ± 13%     +38.1%     334.28 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
     29.57 ± 21%    +850.3%     281.04 ± 12%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
    228.04 ± 12%     +47.6%     336.52 ± 10%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
    243.34 ±  5%     +31.3%     319.39 ±  8%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
     52.40 ±223%    +656.5%     396.42 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_delayed_block.ext4_da_map_blocks
    993.98 ± 26%     -41.0%     586.76 ± 19%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
    311.02 ± 16%     -33.8%     206.01 ± 13%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
    237.21 ± 15%     +51.3%     358.80 ±  4%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
    439.46 ± 23%     -47.2%     232.05 ± 64%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
    343.88 ± 11%     -31.7%     234.96 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
     84.91 ±141%    +402.1%     426.33 ± 20%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__brelse.ext4_do_update_inode
    289.11 ±  7%     +30.3%     376.82 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
    128.88 ±142%    +335.8%     561.68 ± 46%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_get_inode_loc.ext4_reserve_inode_write
    203.58 ± 71%    +110.1%     427.69 ± 16%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2__journal_start.__ext4_journal_start_sb
    151.36 ±103%    +193.3%     443.95 ± 14%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata
    294.05 ±  5%     +20.8%     355.06 ±  5%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
    310.87 ± 10%     -17.7%     255.82 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
    323.39 ±  6%     -19.5%     260.18 ± 12%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
     41.68 ±223%    +841.0%     392.24 ± 19%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
    273.74 ± 16%     +42.0%     388.62 ±  9%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
    132.70 ±100%    +156.5%     340.39 ± 15%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_obj_cgroup_from_current
    387.14 ± 25%     -66.7%     129.00 ±116%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.pagecache_get_page
    338.58 ± 11%     -75.2%      83.88 ±158%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_descend
    194.09 ± 71%    +127.9%     442.28 ± 19%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.ext4_get_group_desc
    294.85 ± 10%     +36.0%     401.02 ± 11%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.kmem_cache_alloc
    315.32 ± 17%     -87.0%      40.89 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.mark_buffer_dirty.__block_commit_write
    293.61 ± 16%     -85.8%      41.84 ±244%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
    296.05 ±  7%     +22.7%     363.19 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
    342.16 ± 14%     -43.3%     193.91 ±  8%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
    307.88 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
    311.79 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
    333.68 ± 16%     -74.4%      85.33 ±158%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
     51.56 ±223%    +578.8%     349.95 ± 17%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.ext4_get_group_desc.__ext4_get_inode_loc
    383.10 ± 19%     -67.5%     124.50 ±115%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.pagecache_get_page.grab_cache_page_write_begin
    316.08 ±  9%     -73.9%      82.36 ±158%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.up_write.ext4_buffered_write_iter
    343.89 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.mark_buffer_dirty.__block_commit_write.isra
     93.48 ± 11%    +243.1%     320.74 ±  7%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    732.46           -30.7%     507.46 ±  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    245.00 ±  6%    +197.0%     727.71 ±  6%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     73.83 ±142%    +252.5%     260.29 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.ext4_es_lookup_extent.ext4_da_map_blocks
     23508 ±  3%     -53.1%      11034 ±  2%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
     71.00 ±143%    +240.4%     241.71 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__dquot_alloc_space.ext4_da_reserve_space
    118.83 ±100%    +152.5%     300.00 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_da_reserve_space.ext4_da_map_blocks
      1315 ±  5%     +13.9%       1497 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
    925.17 ±  4%     +12.4%       1039 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
    544.83 ±  5%     +28.0%     697.57 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
    726.67 ±  2%     +22.7%     891.57 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
     43.83 ±223%    +561.9%     290.14 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_delayed_block.ext4_da_map_blocks
    117.00 ± 25%     +39.7%     163.43 ± 14%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
    107.00 ± 71%     +95.3%     209.00 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
    473.83 ±  4%     +16.2%     550.71 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
    521.67 ±  5%     +27.1%     663.14 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
    903.17 ±  5%     +20.9%       1091 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
      3.50 ±223%    +606.1%      24.71 ± 19%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.__ext4_journal_get_write_access
      2.17 ±223%    +645.1%      16.14 ± 28%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_handle_dirty_metadata.ext4_do_update_inode
     14.50 ± 76%    +149.3%      36.14 ± 15%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_mark_inode_dirty.ext4_dirty_inode
    390.83 ±  4%     +34.0%     523.71 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
     38.00 ±103%    +207.5%     116.86 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mark_inode_dirty.generic_write_end
     38.33 ±102%    +174.3%     105.14 ± 10%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mem_cgroup_charge.mem_cgroup_charge
     14.33 ± 26%     -78.1%       3.14 ±158%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_fc_start_update.ext4_buffered_write_iter
     37.00 ±101%    +173.0%     101.00 ± 12%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata
      3831 ±  4%     -65.6%       1318 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
    514.50 ±  4%     -35.5%     331.86 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.jbd2_journal_stop
      1191 ±  6%     +16.5%       1388 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
    408.00 ±  8%     +17.6%     479.71 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
     25.33 ±223%    +862.6%     243.86 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
    517.50 ±  6%     -17.1%     428.86 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
     48.67 ±100%    +148.9%     121.14 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_obj_cgroup_from_current
     85.67 ± 70%     +87.4%     160.57 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.kmem_cache_alloc
     12.33 ±141%    +354.1%      56.00 ± 10%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.mem_cgroup_charge
    564.33 ±  6%     -34.8%     368.00 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.start_this_handle
     22.00 ±100%    +150.0%      55.00 ± 12%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.xa_get_order
    625.33 ±  6%     +18.3%     739.57 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.rcu_read_lock_held
     38.50 ± 77%     +98.5%      76.43 ±  8%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.ext4_get_group_desc
    167.83 ±  8%     -14.7%     143.14 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.kmem_cache_alloc
    237.67 ±  7%     -91.6%      20.00 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.mark_buffer_dirty.__block_commit_write
    209.50 ±  6%     -79.3%      43.29 ± 87%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
    578.33 ±  6%     -91.1%      51.71 ±244%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
    431.50 ±  5%     -30.4%     300.29 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.start_this_handle.jbd2__journal_start
      5988 ±  5%     -71.1%       1730 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
      3.17 ±141%    +278.9%      12.00 ± 28%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.memcg_slab_free_hook.kmem_cache_free
    212.67 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
    225.00 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
    206.83 ±  9%     -42.9%     118.14 ± 44%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop
     18.83 ±223%    +809.5%     171.29 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.ext4_get_group_desc.__ext4_get_inode_loc
     22.33 ±141%    +241.6%      76.29 ±  8%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_obj_cgroup_from_current.kmem_cache_alloc
     73.33 ± 71%    +120.1%     161.43 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.jbd2_write_access_granted.part
    223.83 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.mark_buffer_dirty.__block_commit_write.isra
      1204 ±  5%     +39.2%       1677 ±  6%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      1129 ± 15%    +171.7%       3068 ±  2%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3999 ±  3%     -23.0%       3078 ±  2%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      4101 ±  2%     -23.4%       3140 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
      3983 ±  2%     -21.9%       3109 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
      3845 ±  3%     -19.0%       3116 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      3943 ±  3%     -21.1%       3111 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
      3984 ±  3%     -21.8%       3116 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
      3960 ±  3%     -21.7%       3100 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
      3951 ±  3%     -22.4%       3065 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
      3949 ±  3%     -21.6%       3096 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      3940 ±  3%     -42.9%       2250 ± 63%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
      3951 ±  3%     -21.5%       3101 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
      3921 ±  3%     -21.2%       3091 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
      3774 ±  2%     -77.4%     853.34 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_fc_start_update.ext4_buffered_write_iter
      4003 ±  3%     -22.4%       3107 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
      3939 ±  3%     -21.7%       3083 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.jbd2_journal_stop
      3971 ±  3%     -22.2%       3090 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
      3939 ±  3%     -22.0%       3073 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
      3936 ±  2%     -21.0%       3111 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
      3806 ±  4%     -41.8%       2214 ± 63%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_mem_cgroup_from_mm
      3983 ±  4%     -22.4%       3093 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.start_this_handle
      4006 ±  3%     -21.7%       3137 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.___might_sleep
      3871 ±  2%     -66.2%       1307 ±115%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.pagecache_get_page
      3952 ±  3%     -22.4%       3067 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.rcu_read_lock_held
      3921 ±  4%     -77.7%     874.93 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_descend
      3921 ±  3%     -22.0%       3060 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.kmem_cache_alloc
      3933 ±  2%     -89.5%     414.01 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.mark_buffer_dirty.__block_commit_write
      3974 ±  3%     -56.2%       1741 ± 86%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
      3932 ±  3%     -88.8%     442.19 ±244%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
      3631 ±  4%     -55.6%       1612 ± 86%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.pagecache_get_page
      3861 ±  5%     -32.0%       2625 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rmqueue.get_page_from_freelist
      3909 ±  3%     -21.5%       3068 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.start_this_handle.jbd2__journal_start
      4008 ±  3%     -22.0%       3125 ±  3%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
      3958 ±  4%     -22.7%       3061 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
      3898 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
      3889 ±  3%     -66.3%       1311 ±115%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3785 ±  2%     -30.1%       2646 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_es_lookup_extent.ext4_da_map_blocks.constprop
      3956          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      3921 ±  4%     -33.0%       2626 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop
      3916 ±  3%     -77.3%     890.41 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
      3937 ±  4%     -66.8%       1308 ±115%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.pagecache_get_page.grab_cache_page_write_begin
      3907 ±  4%     -77.4%     883.15 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.up_write.ext4_buffered_write_iter
      3944 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.mark_buffer_dirty.__block_commit_write.isra
      4475 ± 23%     -30.6%       3106 ±  2%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4067           -22.6%       3147 ±  3%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    296.59 ±  3%     -21.7%     232.37 ± 13%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    321.79 ±  7%     -35.4%     207.85 ±  4%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    255.33 ± 14%     +38.7%     354.19 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.ext4_es_lookup_extent.ext4_da_map_blocks
    293.24 ±  7%     +13.2%     331.92 ±  4%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
    215.31 ± 21%     +56.8%     337.58 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__dquot_alloc_space.ext4_da_reserve_space
    244.79 ± 21%     +36.4%     333.87 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_da_reserve_space.ext4_da_map_blocks
    241.93 ± 13%     +37.8%     333.48 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
     29.53 ± 21%    +849.3%     280.31 ± 12%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      0.72 ±155%  +52567.6%     380.35 ± 65%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.zap_pte_range.unmap_page_range
    227.88 ± 12%     +47.6%     336.37 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
     25.64 ± 22%   +1047.9%     294.35 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.delete_from_page_cache_batch.truncate_inode_pages_range
    243.18 ±  5%     +31.3%     319.21 ±  8%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
     25.73 ± 47%   +1213.2%     337.92 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.release_pages.__pagevec_release
      4.06 ± 14%    +287.4%      15.71 ± 32%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.sched_move_task.do_exit
    206.29 ± 31%     +92.1%     396.28 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_delayed_block.ext4_da_map_blocks
    992.91 ± 26%     -41.0%     586.02 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
    310.85 ± 16%     -33.8%     205.90 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
    237.06 ± 15%     +51.3%     358.61 ±  4%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
     15.86 ±  7%   +3186.1%     521.18 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.rwsem_down_write_slowpath.path_openat.do_filp_open
    438.69 ± 23%     -37.4%     274.60 ± 30%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
    343.71 ± 11%     -31.7%     234.82 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
    482.69 ± 34%     -55.9%     212.80 ± 70%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.down_write
    371.41 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
    320.86 ± 29%     -40.0%     192.52 ± 41%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.vfs_write
    208.57 ± 21%    +104.3%     426.19 ± 20%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__brelse.ext4_do_update_inode
    297.29 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_start_sb.ext4_da_write_begin
    301.46 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
    287.27 ±  7%     +30.8%     375.86 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
    278.53 ±103%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__might_sleep.ext4_da_write_begin
      9.91 ± 75%   +5974.2%     602.17 ± 51%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__rcu_read_lock.xa_get_order
     46.68 ± 90%    +559.3%     307.76 ± 33%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__slab_free.kmem_cache_free
     24.52 ± 61%   +1046.2%     281.00 ± 53%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.block_invalidatepage.truncate_cleanup_page
    267.44 ± 20%     -33.2%     178.52 ± 28%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.down_write.ext4_buffered_write_iter
    142.39 ±122%    +294.4%     561.63 ± 46%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_get_inode_loc.ext4_reserve_inode_write
    603.72 ± 35%     -83.9%      97.32 ±204%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_llseek.ksys_lseek
     37.88 ± 81%    +693.3%     300.48 ± 57%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.find_lock_entries.truncate_inode_pages_range
     27.69 ± 92%   +1295.8%     386.43 ± 27%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.free_unref_page_list.release_pages
    336.38 ± 37%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
    339.07 ± 78%     -76.9%      78.29 ±131%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.iov_iter_init.new_sync_write
    271.85 ± 18%     +57.3%     427.55 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2__journal_start.__ext4_journal_start_sb
    232.44 ± 41%     +90.9%     443.80 ± 14%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata
    293.90 ±  5%     +20.4%     353.98 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
     32.23 ±106%    +772.3%     281.18 ± 44%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.free_buffer_head
    310.70 ± 10%     -17.7%     255.64 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
    323.26 ±  6%     -19.6%     260.04 ± 12%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
    216.30 ± 17%     +81.2%     392.04 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
    273.59 ± 16%     +41.6%     387.42 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
    228.86 ± 18%     +47.2%     336.97 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_obj_cgroup_from_current
    208.20 ± 36%     +68.6%     351.13 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.jbd2_write_access_granted
     27.31 ± 85%    +941.9%     284.55 ± 27%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.memcg_slab_free_hook
     32.33 ± 99%    +700.7%     258.87 ± 38%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.uncharge_page
    386.94 ± 25%     -41.8%     225.11 ± 36%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.pagecache_get_page
    338.44 ± 12%     -28.5%     242.04 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_descend
     16.47 ± 15%   +2352.4%     403.82 ± 64%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_find
    261.18 ± 18%     +69.3%     442.12 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.ext4_get_group_desc
    159.85 ± 44%    +140.9%     385.14 ± 28%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.jbd2_write_access_granted
    294.75 ± 10%     +36.0%     400.76 ± 11%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.kmem_cache_alloc
    302.94 ± 17%     -26.9%     221.46 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.vfs_write
    111.25 ± 45%    +191.1%     323.88 ± 26%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memcg_slab_free_hook.kmem_cache_free
    292.29 ± 16%     -25.9%     216.60 ± 18%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
     15.44 ± 16%   +2347.0%     377.88 ± 49%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_is_watching.jbd2_write_access_granted
     29.86 ± 59%    +770.3%     259.85 ± 39%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.refill_obj_stock.memcg_slab_free_hook
     23.48 ± 39%     -48.4%      12.11 ± 50%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.set_root.nd_jump_root
    295.81 ±  7%     +22.6%     362.77 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
    342.03 ± 14%     -43.5%     193.24 ±  9%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
    285.03 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
     14.29 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.___might_sleep.ext4_da_write_begin
    303.19 ± 99%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.__ext4_journal_stop.ext4_da_write_end
     16.38 ± 54%     -68.8%       5.10 ±118%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.debug_lockdep_rcu_enabled.jbd2_write_access_granted
     19.51 ± 28%     -53.6%       9.05 ± 37%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.debug_lockdep_rcu_enabled.pagecache_get_page
    372.36 ±135%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.generic_write_end.ext4_da_write_end
      6.49 ±106%   +9798.5%     642.03 ±112%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.get_obj_cgroup_from_current.kmem_cache_alloc
      5.28 ±130%   +5362.1%     288.57 ±123%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_release.__alloc_pages
    472.88 ± 72%     -90.8%      43.71 ±192%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.new_sync_write.vfs_write
    291.83 ± 34%     -65.9%      99.52 ± 99%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.pagecache_get_page.grab_cache_page_write_begin
     15.79 ± 18%     -37.8%       9.82 ± 35%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.rcu_read_lock_held_common.rcu_read_lock_held
    234.75 ± 11%     -38.6%     144.08 ± 34%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.stop_this_handle.jbd2_journal_stop
    434.99 ±101%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.unlock_page.ext4_da_write_begin
     12.49 ± 23%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.__ext4_journal_stop.ext4_da_write_end
      1051 ±127%     -99.2%       8.65 ± 74%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.debug_lockdep_rcu_enabled.common_file_perm
      1.27 ±179%  +32468.8%     413.95 ±133%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.ext4_fc_track_inode.ext4_mark_iloc_dirty
    311.00 ±213%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.generic_write_end.ext4_da_write_end
    362.71 ± 51%     -70.4%     107.45 ± 87%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.pagecache_get_page.grab_cache_page_write_begin
    102.78 ±192%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.unlock_page.ext4_da_write_begin
    307.81 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
    237.25 ± 28%     +49.7%     355.12 ± 23%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
    205.20 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
     19.27 ± 36%     -66.3%       6.50 ± 79%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__perf_sw_event.handle_mm_fault.do_user_addr_fault
    316.93 ± 15%     -35.4%     204.73 ± 20%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     16.23 ±  4%   +1621.6%     279.38 ± 58%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
     42.98 ±141%    +503.4%     259.32 ± 37%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_releasepage.truncate_cleanup_page.truncate_inode_pages_range
     16.33 ± 10%   +2025.9%     347.21 ± 49%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.free_pcp_prepare.free_unref_page_list.release_pages
    311.45 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      6.31 ±168%   +4888.6%     314.91 ± 15%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      3.01 ±222%  +11250.9%     342.12 ± 23%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty
    281.17 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
     44.41 ±138%    +388.4%     216.91 ± 39%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_free.free_buffer_head.try_to_free_buffers
    333.54 ± 16%     -31.4%     228.85 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
     17.34 ± 10%   +1741.9%     319.43 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.memcg_slab_free_hook.kmem_cache_free
    362.12 ± 20%     -30.9%     250.14 ± 20%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.aa_file_perm.common_file_perm
    194.29 ± 41%     +78.9%     347.51 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.ext4_get_group_desc.__ext4_get_inode_loc
    136.62 ± 50%    +128.4%     312.01 ± 25%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_mem_cgroup_from_mm.mem_cgroup_charge
     44.88 ±146%    +473.6%     257.45 ± 53%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.mem_cgroup_uncharge_list.release_pages
     57.40 ± 74%    +441.1%     310.61 ± 41%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.memcg_slab_free_hook.kmem_cache_free
    383.04 ± 19%     -35.9%     245.40 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.pagecache_get_page.grab_cache_page_write_begin
    315.96 ±  9%     -29.5%     222.90 ± 22%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.up_write.ext4_buffered_write_iter
    340.94 ± 17%     -35.8%     218.77 ± 14%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.mark_buffer_dirty.__block_commit_write.isra
    136.25 ±124%    +248.1%     474.32 ± 46%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_is_watching.jbd2_write_access_granted.part
     93.10 ± 11%    +243.4%     319.70 ±  7%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
     70.95 ± 76%    +343.6%     314.71 ± 27%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.__fdget_pos.ksys_write
     63.44 ±111%    +287.2%     245.62 ± 36%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.ext4_orphan_del.ext4_evict_inode
    732.42           -30.7%     507.43 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      1127 ± 15%    +172.2%       3068 ±  2%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3997 ±  3%     -23.0%       3077 ±  2%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3876 ±  2%     -20.9%       3065 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.ext4_es_lookup_extent.ext4_da_map_blocks
      4035 ±  2%     -22.2%       3140 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
      3861 ±  5%     -20.0%       3088 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__dquot_alloc_space.ext4_da_reserve_space
      3911 ±  2%     -21.1%       3085 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_block_write_begin.ext4_da_write_begin
      3897 ±  3%     -21.1%       3076 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_da_reserve_space.ext4_da_map_blocks
      3973 ±  2%     -21.8%       3106 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
      3845 ±  3%     -19.1%       3111 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      1.98 ±168%  +1.3e+05%       2575 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.zap_pte_range.unmap_page_range
      3934 ±  3%     -20.9%       3111 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
      3962 ±  3%     -21.3%       3116 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
      3912 ±  4%     -21.0%       3092 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_delayed_block.ext4_da_map_blocks
      3912 ±  5%     -21.9%       3055 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.balance_dirty_pages_ratelimited.generic_perform_write.ext4_buffered_write_iter
      3959 ±  3%     -21.8%       3097 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
      3880 ±  3%     -20.6%       3080 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      3951 ±  3%     -22.4%       3064 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
      3949 ±  3%     -21.6%       3096 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
     52.32 ± 35%   +5716.5%       3042 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.rwsem_down_write_slowpath.path_openat.do_filp_open
      3935 ±  3%     -21.2%       3102 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
      3851 ±  4%     -22.5%       2984 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.try_to_wake_up.wake_up_q.rwsem_wake
      3949 ±  3%     -21.5%       3099 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
      3723 ±  6%     -21.2%       2933 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.__getblk_gfp
      3787 ±  3%     -24.2%       2871 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.down_write
      3799 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
      3819 ±  3%     -23.9%       2907 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_journal_check_start
      3715 ±  2%     -30.9%       2568 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.generic_perform_write
      3780 ±  4%     -21.0%       2985 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.kmem_cache_alloc
      3756 ±  3%     -33.5%       2499 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.vfs_write
      3734 ±  5%     -20.2%       2980 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__add_to_page_cache_locked.add_to_page_cache_lru
      3695 ±  6%     -32.7%       2486 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__alloc_pages.pagecache_get_page
      3881 ±  3%     -21.4%       3052 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__block_commit_write.isra
      3809 ±  4%     -20.2%       3040 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__brelse.ext4_do_update_inode
      3844 ±  5%     -22.1%       2994        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_get_inode_loc.ext4_get_inode_loc
      3746 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_start_sb.ext4_da_write_begin
      3853 ±  4%     -21.1%       3041 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.__mark_inode_dirty
      3873 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
      1816 ± 98%     -98.8%      21.46 ± 31%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__fdget_pos.ksys_lseek
      3794 ±  3%     -24.2%       2877 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__fget_light.__fdget_pos
      3918 ±  3%     -21.1%       3090 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
      3804 ±  3%     -21.7%       2977 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__fsnotify_parent.vfs_write
      3818 ±  4%     -21.6%       2994 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__get_user_nocheck_1.iov_iter_fault_in_readable
      3765 ±  5%     -32.7%       2534 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mark_inode_dirty.__block_commit_write
      3783 ±  3%     -19.2%       3055 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mark_inode_dirty.generic_write_end
      3856 ±  2%     -20.8%       3055 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mem_cgroup_charge.mem_cgroup_charge
      1931 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__might_sleep.ext4_da_write_begin
      3718 ±  5%     -54.6%       1688 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__might_sleep.ext4_journal_check_start
     11.84 ± 77%  +20749.3%       2468 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__rcu_read_lock.xa_get_order
      3708 ±  4%     -20.1%       2961 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__rcu_read_unlock.aa_file_perm
      2482 ± 69%     -47.4%       1306 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__x64_sys_lseek.do_syscall_64
      3669 ±  6%     -21.8%       2868 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__x64_sys_write.do_syscall_64
      3843 ±  4%     -23.0%       2959 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.balance_dirty_pages_ratelimited.generic_perform_write
      3853 ±  5%     -32.6%       2598 ± 39%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.common_file_perm.security_file_permission
      3693 ±  3%     -44.3%       2056 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.current_time.file_update_time
      3876 ±  4%     -20.6%       3077 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.___might_sleep
      3883 ±  4%     -22.8%       2996 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.aa_file_perm
      3655 ±  3%     -19.8%       2930 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.common_file_perm
      3873 ±  4%     -24.7%       2916        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.rcu_read_lock_held_common
      3864 ±  3%     -21.7%       3024 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.down_write.ext4_buffered_write_iter
      3814 ±  3%     -20.4%       3036 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_block_write_begin.ext4_da_write_begin
      3823 ±  3%     -22.8%       2951 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_da_map_blocks.constprop
      3937 ±  3%     -23.6%       3008 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_da_write_begin.generic_perform_write
      3851 ±  4%     -21.7%       3014 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_da_write_end.generic_perform_write
      3874 ±  4%     -22.6%       2997 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_do_update_inode.ext4_mark_iloc_dirty
      3773 ±  2%     -65.6%       1298 ±103%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_fc_start_update.ext4_buffered_write_iter
      3811 ±  5%     -25.4%       2843 ±  8%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_file_write_iter.new_sync_write
      3913 ±  3%     -23.3%       3001 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_journal_check_start.__ext4_journal_start_sb
      3686 ±  5%     -87.8%     449.48 ±225%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_llseek.ksys_lseek
      3903 ±  3%     -21.7%       3056 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      3631 ±  6%     -29.4%       2564 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.file_update_time.ext4_write_checks
      3812 ±  4%     -37.3%       2391 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.fs_reclaim_release.kmem_cache_alloc
      3854 ±  4%     -22.3%       2995 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_perform_write.ext4_buffered_write_iter
      3774 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
      3761 ±  4%     -19.5%       3028 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.get_obj_cgroup_from_current.kmem_cache_alloc
      3736 ±  2%     -21.6%       2929        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.iov_iter_advance.generic_perform_write
      3851 ±  4%     -20.5%       3063 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2__journal_start.__ext4_journal_start_sb
      3728 ±  4%     -18.3%       3046 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata
      3759 ±  4%     -20.0%       3007 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_get_write_access.__ext4_journal_get_write_access
      3999 ±  3%     -22.3%       3106 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
      3919 ±  3%     -22.2%       3050 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_write_access_granted.part
      3847 ±  2%     -20.6%       3053 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_alloc.alloc_buffer_head
      3860 ±  3%     -22.3%       2998 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_alloc.jbd2__journal_start
      3939 ±  3%     -21.7%       3083 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.jbd2_journal_stop
      3971 ±  3%     -22.2%       3088 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
      3751 ±  3%     -20.4%       2986 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.__mem_cgroup_charge
      3968 ±  3%     -22.7%       3069 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.aa_file_perm
      3814 ±  5%     -20.2%       3044 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_read
      3938 ±  3%     -22.0%       3071 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
      3874 ±  4%     -20.1%       3094 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
      3934 ±  2%     -20.9%       3111 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
      3805 ±  4%     -19.4%       3067 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_mem_cgroup_from_mm
      3849 ±  4%     -21.0%       3039 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_obj_cgroup_from_current
      3872 ±  4%     -20.8%       3066 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.jbd2_write_access_granted
      3894 ±  4%     -20.9%       3080 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.kmem_cache_alloc
      3736 ±  5%     -20.4%       2975 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.lock_page_memcg
      3695 ±  2%     -19.1%       2990 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.mem_cgroup_charge
      3895 ±  3%     -21.8%       3046 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.pagecache_get_page
      3983 ±  4%     -22.4%       3090 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.start_this_handle
      3923 ±  4%     -21.2%       3090 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.vfs_write
      3771 ±  5%     -19.9%       3021 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.xa_get_order
      4006 ±  3%     -22.1%       3120 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.___might_sleep
      3870 ±  3%     -22.7%       2993 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.pagecache_get_page
      3951 ±  3%     -22.4%       3067 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.rcu_read_lock_held
      3920 ±  4%     -22.1%       3054 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_descend
      3879 ±  3%     -22.1%       3022 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_start
      3897           -20.9%       3082 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_page_memcg.mark_buffer_dirty
      3878 ±  3%     -22.3%       3014 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.aa_file_perm
      3824 ±  6%     -20.4%       3044 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.ext4_get_group_desc
      3921 ±  3%     -22.1%       3056 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.kmem_cache_alloc
      3910 ±  2%     -22.5%       3030 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.pagecache_get_page
      3840 ±  3%     -21.3%       3021 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.stop_this_handle
      3864 ±  4%     -22.2%       3008        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.up_write
      3873 ±  4%     -21.5%       3040 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.vfs_write
      3787 ±  4%     -24.5%       2858 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lru_cache_add.add_to_page_cache_lru
      3932 ±  2%     -23.2%       3020 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.mark_buffer_dirty.__block_commit_write
      3813 ±  3%     -20.9%       3017 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memcg_slab_free_hook.kmem_cache_free
      3696 ±  3%     -20.5%       2939 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memset_erms.kmem_cache_alloc
      3974 ±  3%     -24.9%       2985 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
      3858 ±  4%     -22.1%       3006        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.obj_cgroup_charge.kmem_cache_alloc
     46.09 ± 20%   +5238.6%       2460 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.page_counter_cancel.page_counter_uncharge
      3930 ±  3%     -22.7%       3039 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
      3807 ±  5%     -23.7%       2903 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_is_watching.aa_file_perm
     18.67 ± 28%  +11402.3%       2147 ± 55%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_is_watching.jbd2_write_access_granted
      3700 ±  4%     -23.6%       2827 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.aa_file_perm
     22.66 ± 27%   +7222.4%       1659 ± 84%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.get_mem_cgroup_from_mm
      3629 ±  4%     -44.4%       2017 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.pagecache_get_page
      3724 ±  3%     -42.3%       2151 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.xas_descend
      3793 ±  3%     -22.8%       2929 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held_common.rcu_read_lock_held
      3861 ±  5%     -20.3%       3076 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rmqueue.get_page_from_freelist
      3909 ±  3%     -21.5%       3067 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.start_this_handle.jbd2__journal_start
      4003 ±  3%     -21.9%       3125 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
      3958 ±  4%     -22.8%       3057 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
      3680 ±  5%     -18.1%       3013 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3758 ±  3%     -19.2%       3035 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.try_charge.__mem_cgroup_charge
      3903 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
      3848 ±  5%     -22.4%       2985 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.generic_write_end
      3786 ±  5%     -44.7%       2092 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.up_read.ext4_da_map_blocks
      3930 ±  3%     -23.6%       3002 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.up_write.ext4_buffered_write_iter
      3900 ±  4%     -22.5%       3021 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.vfs_write.ksys_write
      3879 ±  5%     -23.6%       2964 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_descend.xas_load
      3714 ±  4%     -21.8%       2905 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_load.pagecache_get_page
      3843 ±  3%     -22.9%       2961 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_start.xas_load
     22.60 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.___might_sleep.ext4_da_write_begin
     16.47 ± 57%  +12042.3%       1999 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.___might_sleep.vfs_write
      1878 ± 97%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.__ext4_journal_stop.ext4_da_write_end
      1854 ± 98%     -77.1%     424.33 ±236%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.__fsnotify_parent.vfs_write
     17.43 ± 21%     -44.8%       9.63 ± 68%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.__slab_free.kmem_cache_free
     20.52 ± 61%     -75.1%       5.10 ±118%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.debug_lockdep_rcu_enabled.jbd2_write_access_granted
     25.95 ± 41%     -55.2%      11.64 ± 36%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.debug_lockdep_rcu_enabled.pagecache_get_page
      1260 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.generic_write_end.ext4_da_write_end
      6.49 ±106%  +19559.8%       1275 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.get_obj_cgroup_from_current.kmem_cache_alloc
      1839 ± 97%     -72.4%     507.63 ±203%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.jbd2__journal_start.__ext4_journal_start_sb
      3849 ±  3%     -21.5%       3022 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.jbd2_journal_stop.__ext4_journal_stop
      3886 ±  3%     -21.6%       3045 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.ktime_get_coarse_real_ts64.current_time
      3739 ±  5%     -19.5%       3009 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_acquire.down_write
      3816 ±  3%     -21.5%       2995 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_is_held_type.___might_sleep
     27.08 ± 35%   +5798.0%       1597 ± 84%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_is_held_type.xas_start
      5.52 ±130%  +22154.6%       1229 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_release.__alloc_pages
      2566 ± 70%     -84.8%     390.12 ±233%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.new_sync_write.vfs_write
      3758 ±  4%     -56.6%       1629 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.pagecache_get_page.grab_cache_page_write_begin
      3939 ±  4%     -24.0%       2995 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.stop_this_handle.jbd2_journal_stop
      2993 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.unlock_page.ext4_da_write_begin
      4.34 ±141%   +9421.4%     412.77 ±232%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.xas_load.pagecache_get_page
     29.33 ± 28%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.__ext4_journal_stop.ext4_da_write_end
      1871 ± 98%     -99.1%      17.49 ± 77%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.debug_lockdep_rcu_enabled.common_file_perm
      3811 ±  5%     -25.2%       2849 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      1.27 ±178%  +97580.9%       1245 ±114%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.ext4_fc_track_inode.ext4_mark_iloc_dirty
    621.62 ±213%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.generic_write_end.ext4_da_write_end
      3932 ±  3%     -24.4%       2974 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.jbd2_journal_stop.__ext4_journal_stop
      3866 ±  3%     -21.8%       3024 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.ktime_get_coarse_real_ts64.current_time
      3879 ±  4%     -22.0%       3024 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_is_held_type.___might_sleep
      3806 ±  3%     -55.5%       1692 ± 84%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.pagecache_get_page.grab_cache_page_write_begin
      3948 ±  2%     -23.5%       3019 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.stop_this_handle.jbd2_journal_stop
      3741 ±  5%     -20.3%       2983 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.syscall_enter_from_user_mode.do_syscall_64
    631.42 ±209%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.unlock_page.ext4_da_write_begin
      3692 ±  6%     -20.5%       2933 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      3586 ±  3%     -19.8%       2876 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
      3898 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
      3804 ±  2%     -19.5%       3061 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      3842 ±  4%     -21.1%       3031 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      3885 ±  3%     -21.5%       3050 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__find_get_block.__getblk_gfp.__ext4_get_inode_loc
      3897 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
     30.86 ± 48%     -64.4%      10.98 ± 66%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__perf_sw_event.handle_mm_fault.do_user_addr_fault
      3886 ±  3%     -21.4%       3054 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3919 ±  3%     -21.7%       3070 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      3874 ±  2%     -24.8%       2912 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_es_insert_delayed_block.ext4_da_map_blocks.constprop
      3746 ±  4%     -18.3%       3059 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_es_lookup_extent.ext4_da_map_blocks.constprop
      3861 ±  3%     -20.6%       3066 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_fc_track_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
     33.67 ± 16%   +8418.5%       2868 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
     41.43 ± 16%   +7032.8%       2955 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.free_pcp_prepare.free_unref_page_list.release_pages
      3918 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      6.31 ±168%  +48208.7%       3049 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      3.01 ±222%    +1e+05%       3021 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty
      3905 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
      3931 ±  4%     -22.4%       3049 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      3921 ±  4%     -22.5%       3039 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop
      3916 ±  3%     -21.8%       3064 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
      3870 ±  3%     -20.2%       3089 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.down_write.ext4_buffered_write_iter
      3796 ±  4%     -19.1%       3071 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.ext4_get_group_desc.__ext4_get_inode_loc
      3809 ±  4%     -21.5%       2988 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.fs_reclaim_acquire.__alloc_pages
      3927 ±  3%     -22.1%       3058 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.fs_reclaim_acquire.kmem_cache_alloc
      3774 ±  4%     -19.6%       3034 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.get_mem_cgroup_from_mm.mem_cgroup_charge
      3794 ±  5%     -20.1%       3032 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.get_obj_cgroup_from_current.kmem_cache_alloc
      3779 ±  4%     -19.5%       3043 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.jbd2_write_access_granted.part
      3830 ±  4%     -19.7%       3076 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.kmem_cache_alloc.alloc_buffer_head
     58.90 ± 21%   +5007.4%       3008 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.memcg_slab_free_hook.kmem_cache_free
      3868 ±  3%     -21.7%       3030 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.pagecache_get_page.grab_cache_page_write_begin
      3883 ±  2%     -20.1%       3102 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.start_this_handle.jbd2__journal_start
      3833 ±  4%     -20.9%       3033 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.vfs_write.ksys_write
      3770 ±  3%     -21.0%       2980 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.__alloc_pages.pagecache_get_page
      3888 ±  2%     -20.9%       3074 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.aa_file_perm.common_file_perm
      3846 ±  5%     -20.6%       3054 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.ext4_get_group_desc.__ext4_get_inode_loc
      3638 ±  4%     -16.4%       3041 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_obj_cgroup_from_current.kmem_cache_alloc
      3837 ±  4%     -20.7%       3042 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.jbd2_write_access_granted.part
      3899 ±  4%     -21.9%       3044 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.kmem_cache_alloc.alloc_buffer_head
      3889 ±  3%     -21.4%       3059 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.kmem_cache_alloc.jbd2__journal_start
      3937 ±  4%     -22.4%       3056 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.pagecache_get_page.grab_cache_page_write_begin
      3961 ±  4%     -22.5%       3069 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.stop_this_handle.jbd2_journal_stop
      3850 ±  4%     -24.8%       2895 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.up_read.ext4_da_map_blocks
      3905 ±  4%     -22.3%       3034 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.up_write.ext4_buffered_write_iter
      3924 ±  3%     -22.3%       3050 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.vfs_write.ksys_write
      3944 ±  3%     -21.6%       3092 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.mark_buffer_dirty.__block_commit_write.isra
      3789 ±  4%     -23.4%       2903 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_is_watching.aa_file_perm.common_file_perm
     31.17 ± 29%   +4378.9%       1395 ± 98%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_is_watching.memcg_slab_free_hook.kmem_cache_free
      3838 ±  3%     -33.4%       2556 ± 39%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_is_watching.pagecache_get_page.grab_cache_page_write_begin
      3856 ±  4%     -22.4%       2991 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_is_watching.rcu_read_lock_held_common.rcu_read_lock_held
      3914 ±  3%     -20.3%       3118 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_lockdep_current_cpu_online.rcu_read_lock_held_common.rcu_read_lock_held
      3962 ±  2%     -21.7%       3103 ±  2%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3977 ±  2%     -21.8%       3112 ±  3%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2


                                                                                
                                  aim7.jobs-per-min                             
                                                                                
  190000 +------------------------------------------------------------------+   
  180000 |-OO O O                                                           |   
         |                                                                  |   
  170000 |-+                                                                |   
  160000 |-+                                                                |   
  150000 |-+     O O OO O OO O OO O O                                       |   
  140000 |-+                         O O O OO O OO O OO O OO                |   
         |                                                                  |   
  130000 |-+                                                                |   
  120000 |-+                                                                |   
  110000 |-+                                                                |   
  100000 |-+                                                                |   
         |.++.+.++.+.++.+.++.+.+                                            |   
   90000 |-+                    +.+.++.+.+.++.+.++.+.++.+.++.+.++.+.++.+.++.|   
   80000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                aim7.time.system_time                           
                                                                                
  16000 +-------------------------------------------------------------------+   
        |.++.+.+.++.+.++.+.++.+                       +      ++.+.+.++.+    |   
  15000 |-+                                                                 |   
  14000 |-+                                                                 |   
        |                                                                   |   
  13000 |-+                                                                 |   
  12000 |-+                                                                 |   
        |                                                                   |   
  11000 |-+                                                                 |   
  10000 |-+                                                                 |   
        |                            O OO O OO O O OO O OO O                |   
   9000 |-+      OO O OO O OO O O OO                                        |   
   8000 |-+                                                                 |   
        | OO O O                                                            |   
   7000 +-------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                              aim7.time.elapsed_time                            
                                                                                
  220 +---------------------------------------------------------------------+   
      |                                                                     |   
  200 |.+     .+.++.+.+.+ .+.+.++.+.+.++.+.+.++.+.+.++.+.+.++.+.+.++.+.+.++.|   
      | +.++.+           +                                                  |   
  180 |-+                                                                   |   
      |                                                                     |   
  160 |-+                                                                   |   
      |                                                                     |   
  140 |-+                                                                   |   
      |                               OO   O  O   O O  O   O                |   
  120 |-+      O OO O O OO O O OO O O    O   O  O    O   O                  |   
      |                                                                     |   
  100 |-O OO O                                                              |   
      |                                                                     |   
   80 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                            aim7.time.elapsed_time.max                          
                                                                                
  220 +---------------------------------------------------------------------+   
      |                                                                     |   
  200 |.+     .+.++.+.+.+ .+.+.++.+.+.++.+.+.++.+.+.++.+.+.++.+.+.++.+.+.++.|   
      | +.++.+           +                                                  |   
  180 |-+                                                                   |   
      |                                                                     |   
  160 |-+                                                                   |   
      |                                                                     |   
  140 |-+                                                                   |   
      |                               OO   O  O   O O  O   O                |   
  120 |-+      O OO O O OO O O OO O O    O   O  O    O   O                  |   
      |                                                                     |   
  100 |-O OO O                                                              |   
      |                                                                     |   
   80 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        aim7.time.voluntary_context_switches                    
                                                                                
  190000 +------------------------------------------------------------------+   
  180000 |-+                     .+.  .+. .++.+.++. .+ .+. +.+.    .+ .+.+  |   
         |.++.+.+               +   ++   +         +  +   +    ++.+  +    +.|   
  170000 |-+     :  .++.+. +.+. :                                           |   
  160000 |-+     +.+      +    +                                            |   
         |                                                                  |   
  150000 |-+                                                                |   
  140000 |-+                                                                |   
  130000 |-+                                                                |   
         |                                                                  |   
  120000 |-+                         O O O OO O OO O OO O OO                |   
  110000 |-+     O O OO O OO O OO O O                                       |   
         |                                                                  |   
  100000 |-O                                                                |   
   90000 +------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                        aim7.time.involuntary_context_switches                  
                                                                                
    2e+06 +-----------------------------------------------------------------+   
          |       +.+.+  +.++.++                                            |   
  1.8e+06 |-+     :            :                                            |   
          |       :             :                                           |   
  1.6e+06 |-+     :             :                                           |   
          |      :              :                                           |   
  1.4e+06 |-+    :               :          .++.           .+               |   
          |.     :               +.++.+.++.+    +.++.+.++.+  +.++.+.++.+.++.|   
  1.2e+06 |-++.+.+                                                          |   
          |                                                                 |   
    1e+06 |-+                                                               |   
          |       O O OO O OO OO O OO                                       |   
   800000 |-OO O O                                                          |   
          |                                  O          O                   |   
   600000 +-----------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |     .+.++.+. .+    ++.+.   +.      .+.             +. .+.+ .+.+.  .|   
  4000 |.++.+        +           +.+  +.+.++   ++.+.+.++.+.+  +    +     ++ |   
  3500 |-+                                                                  |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | OO                                                                 |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +.+.++.             .+                 .+.    .+   .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++  + +.+.+.+ .+.++.+   ++.+  + + |   
  3500 |-+                                     +       +                 +  |   
       |        O  O   OO   OO        O O         O O                       |   
  3000 |-+       O   O    O    O O OO     OO O OO     OO O O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .+    ++.             .+.             +. .+.+ .+.+.  .|   
  4000 |.++.+.+      +         +.+.++.+.+.++   ++.+.+.+ .+.+  +    +     ++ |   
  3500 |-+                                             +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | OO                                                                 |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  7000 +--------------------------------------------------------------------+   
       |.  .+.                 +    +    .++.+.             +.              |   
  6000 |-++   +         +.    : :  + :  +      +  +.+.+  +. : +.+. +.+.+.  +|   
       |       +  .+.+. : +.+ : : +  : +        :+     :+  +      +      ++ |   
  5000 |-+      ++     +     +   +    +         +      +                    |   
       |                                                                    |   
  4000 |-+                                                                  |   
       |                                                                    |   
  3000 |-+                                                                  |   
       |                                                                    |   
  2000 |-+      O  O O  O O OO O   O    O O  O      O O  O                  |   
       |         O     O         O  O O    O   OO O    O   O                |   
  1000 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  7000 +--------------------------------------------------------------------+   
       |                                               :                    |   
  6000 |-+                                             ::                   |   
       |                                               ::                   |   
  5000 |-+                                            : :                   |   
       |                +.+.++.                       : :                   |   
  4000 |.++.+.+.++.+.+.+       +.+.++.+.+.++.+.++.+.+.+  :.++.+.+.++.+.+.++.|   
       |               OO        O        O           O  +                  |   
  3000 |-+      OO O O    O OO O   OO O O  O O OO O O  O O O                |   
       |                                                                    |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                .+.  .+.    .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+.++.+.+.+ .+.++.+   ++   +.++ |   
  3500 |-+                                             +                    |   
       |        O  O   O     O O O  O O   O     O O   O                     |   
  3000 |-+       O   O  O O O      O    O  O O O    O  O O O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | OO                                                                 |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |     .+.++.+.   +   ++.                                .+.    .+    |   
  4000 |.++.+        +.+       +.+.++.+.+.++.+. +.+.+.+ .+. +.+   ++.+  + +.|   
  3500 |-+                                     +       +   +             +  |   
       |               OO O OO      O O   O     O O   O                     |   
  3000 |-+      OO   O         O O O    O  O O O    O  O O O                |   
  2500 |-+         O                                                        |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.+.   +.      .+.             +. .+.+ .+.+.  .|   
  4000 |.++.+.+      +           +.+  +.+.++   ++.+.+.++.+.+  +    +     ++ |   
  3500 |-+                                                                  |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | OO                                                                 |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |.  .+.                           .++.+.                             |   
  4000 |-++   +                +. .++. .+      + .+.+.+  +. +.+.+  +.+.+.  +|   
  3500 |-+     :  .+.+.++.+.+ +  +    +         +      :+  +     + :     ++ |   
       |       : +           +                         +          +         |   
  3000 |-+      +                                                           |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                   O     O    O           O                       |   
       |        OO O O OO O O  O O  O O   OO O OO O   OO O O                |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |  O                                                                 |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .+    ++  +   :+      .+.             +. .+.+ .+.+.  .|   
  4000 |.++.+.+      +           +.+  +.+.++   ++.+.+.++.+.+  +    +     ++ |   
  3500 |-+                                                                  |   
       |        O  O   OO O OO O O OO O O O  O  O O O O  O                  |   
  3000 |-+       O   O                     O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | OO                                                                 |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.             .+.             +. .+.+ .+.+.  .|   
  4000 |.++.+.+      +         +.+.++.+.+.++   ++.+.+.+ .+.+  +    +     ++ |   
  3500 |-+                                             +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.             .+.             +. .+.+ .+.+.  .|   
  4000 |.++.+.+      +         +.+.++.+.+.++   ++.+.+.+ .+.+  +    +     ++ |   
  3500 |-+                                             +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                .+.  .+.+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.   .+     +.+   ++     ++ |   
  3500 |-+                                     +  +.+  +.+.+                |   
       |               O    OO               O           O                  |   
  3000 |-+      OO O O  O O    O O OO O O OO   OO O O OO   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                .+.    .+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.+ .+.++.+   ++.+   ++ |   
  3500 |-+                                     +       +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.                                .+.    .+.  .|   
  4000 |.++.+.+      +         +.+.++.+.+.++.+. +.+.+.+ .+.++.+   ++.+   ++ |   
  3500 |-+                                     +       +                    |   
       |           O   OO O OO O      O      O    O      O                  |   
  3000 |-+      OO   O           O OO   O OO   OO   O OO   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                             +. .+.+ .+.+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.++.+.+  +    +     ++ |   
  3500 |-+                                     +                            |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                             +. .+.+ .+.+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.++.+.+  +    +     ++ |   
  3500 |-+                                     +                            |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.                                .+.          |   
  4000 |.++.+.+      +         +.+.++.+.+.++.+. +.+.+.+   .++.+   ++.+.+.++.|   
  3500 |-+                                     +       +.+                  |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.             .+                 .+.         .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++  + +.+.+.++.+.++.+   ++.+.+.++ |   
  3500 |-+                                     +                            |   
       |           O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+      OO   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.+.   +.      .+              +. .+.  .+.+.  .|   
  4000 |.++.+.+      +           +.+  +.+.++  + +.+.+.+ .+.+  +   ++     ++ |   
  3500 |-+                                     +       +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.+.   +.      .+              +. .+.  .+.+.  .|   
  4000 |.++.+.+      +           +.+  +.+.++  + +.+.+.+ .+.+  +   ++     ++ |   
  3500 |-+                                     +       +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++   ++.                             +. .+.    .+.  .|   
  4000 |.++.+.+      +         +.+.++.+.+.++.+.++.+.+.+ .+.+  +   ++.+   ++ |   
  3500 |-+                                             +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                .+.    .+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.+   .++.+   ++.+   ++ |   
  3500 |-+                                     +       +.+                  |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +.+.+                                  .+.  .+.+.   |   
  4000 |.++.+.+      +.+     +.+. .++. .+.++.+. +.+. .+ .+. +.+   ++     + +|   
  3500 |-+                       +    +        +    +  +   +              + |   
       |           O   O     O      O O      O  O O      O                  |   
  3000 |-+      OO   O  O O O  O O O    O OO   O    O OO   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                .+.  .+.+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+.++.+.+.+ .+.++.+   ++     ++ |   
  3500 |-+                                             +                    |   
       |               OO O OO O    O     O     O     O                     |   
  3000 |-+      OO O O           O O  O O  O O O  O O  O O O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.      + + +.                                       .+.   |   
  4000 |.++.+.+    +.+.++   +  +.+.++.+.+.+     +. .+.++. .++.+.+.++.+   + +|   
  3500 |-+                                 +.+.+  +      +                + |   
       |        O       O O O    O    O           O                         |   
  3000 |-+       O   O       O O   OO   O OO O OO   O OO O O                |   
  2500 |-+         O   O                                                    |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +.+.++.                                .+.  .+.     |   
  4000 |.++. .+      +.+       +.+.++.+.+.++.+. +.+.+.+ .+.  .+   ++   +.+ .|   
  3500 |-+  +                                  +       +   ++             + |   
       |                O        O  O   O O  O  O   O O  O                  |   
  3000 |-+      OO O O O  O OO O   O  O    O   O  O    O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.     +.+.++.             .+                 .+.    .+.   |   
  4000 |.++.+.+    +.+.+       +.+.++.+.+.++  + +.+.+.+   .++.+   ++.+   + +|   
  3500 |-+                                     +       +.+                + |   
       |               OO O OO          O    O      O    O                  |   
  3000 |-+      OO O O         O O OO O   OO   OO O   OO   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                 +.  .+.    .|   
  4000 |.++. .+      +.+       +.+.++.+.+.++.+. +.+.+.+ .+.++. +  ++   +.++ |   
  3500 |-+  +                                  +       +      +             |   
       |           O   OO O OO O O    O O O  O    O O O  O                  |   
  3000 |-+      OO   O             OO      O   OO      O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.    +  ++.                                       .+.   |   
  4000 |-+ .+.+      +.++      +.+.++.+.+.+ .+. +.   .+ .+.++. .+.++.+   ++.|   
  3500 |.++                                +   +  +.+  +      +             |   
       |           O   OO O OO        O   O       O   O                     |   
  3000 |-+      OO   O         O O OO   O  O O OO   O  O O O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |     .+.++.+. .++   ++.                             +. .+.         .|   
  4000 |.++.+        +         +.+.++.+.+.++.+. +.+.+.+ .+.+  +   ++.+.+.++ |   
  3500 |-+                                     +       +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |     .+.++.+. .++   ++.                             +. .+.         .|   
  4000 |.++.+        +         +.+.++.+.+.++.+. +.+.+.+ .+.+  +   ++.+.+.++ |   
  3500 |-+                                     +       +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       | O                                                                  |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.     +.+.++.                                .+.    .+.   |   
  4000 |.+   .+    +.+.+       +.+.++.+.+.++.+. +.+.+.+ .+.++.+   ++.+   + .|   
  3500 |-++.+                                  +       +                  + |   
       |        O  O   O    OO O O  O O   O  O  O O   O  O                  |   
  3000 |-+       O   O  O O        O    O  O   O    O  O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++.+.++.                                .+.    .+.  .|   
  4000 |.++.+.+      +         +.+.++.+.+.++.+. +.+.+.+ .+. +.+   ++.+   ++ |   
  3500 |-+                                     +       +   +                |   
       |           O    O O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+      OO   O O           O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                             +. .+.    .+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.+ .+.+  +   ++.+   ++ |   
  3500 |-+                                     +       +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.     +   ++.                                .+.+        .|   
  4000 |.++.+.+    +.+.+       +.+.++.+.+.++.+. +.+.+.+ .+. +.+    +.+.+. + |   
  3500 |-+                                     +       +   +             +  |   
       |           O      O  O      O O O       O O O                       |   
  3000 |-+      OO   O  O   O  O O O      OO O O      OO O O                |   
  2500 |-+             O                                                    |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+. .++.+.++.                                .+.    .+    |   
  4000 |.+ .+.+      +         +.+.++.+.+.++.+. +. .+.+   .++.+   ++.+  +  .|   
  3500 |-++                                    +  +    +.+               ++ |   
       |        O  O   OO O OO   O    O   O  O    O   O  O                  |   
  3000 |-+       O   O         O   OO   O  O   OO   O  O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+    +.+.++.                                .+.    .+.  .|   
  4000 |.++.+.+     + .+       +.+.++.+.+.++.+. +.+.+.+ .+.++.+   ++.+   ++ |   
  3500 |-+           +                         +       +                    |   
       |        O      OO O OO O O  O O O O     O O O O                     |   
  3000 |-+       O O O             O       O O O       O O O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                .+.  .+.+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.++.+.++.+   ++     ++ |   
  3500 |-+                                     +                            |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.                                .+.  .+.+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.++.+.++.+   ++     ++ |   
  3500 |-+                                     +                            |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +   ++.          .+                    .+.+ .+.+.  .|   
  4000 |.++.+.+      +.+       +.+.++.+.+  +.+.++.+.+.+ .+.++.+    +     ++ |   
  3500 |-+                                             +                    |   
       |        O  O   OO O OO O O  O O   O  O  O O   O  O                  |   
  3000 |-+       O   O             O    O  O   O    O  O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.     +.+.++.                                .+.    .+    |   
  4000 |.++.+.+    +.+.+       +.+.++.+.+.++.+. +.+. .+   .++.+   ++.+  +  .|   
  3500 |-+                                     +    +  +.+               ++ |   
       |        O  O   OO O OO   O  O O   O  O  O O   O  O                  |   
  3000 |-+       O   O         O   O    O  O   O    O  O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +.+.++.                                .+.    .+.   |   
  4000 |.++.+.+      +.+       +.+.++.+.+.++.+. +.+.+.+ .+.++.+   ++.+   ++.|   
  3500 |-+                                     +       +                    |   
       |           O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+      OO   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.   .++   ++.                             +. .+.    .+.  .|   
  4000 |.++.+.+    +.+         +.+.++.+.+.++.+.++.+.+.+ .+.+  +   ++.+   ++ |   
  3500 |-+                                             +                    |   
       |        O  O   OO O OO O O  O O O O  O  O O O O  O                  |   
  3000 |-+       O   O             O       O   O       O   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  8000 +--------------------------------------------------------------------+   
       |      :                                                             |   
  7000 |-+   : :                                                            |   
  6000 |-+   : :                                                            |   
       |     : :                                                            |   
  5000 |-+   : :                                                            |   
       |    :   :        .+.                                                |   
  4000 |.++.+   ++.+.+.++   ++.+.+.++.+.+.++.+. +.+.+.+ .+.++.+.+.++.+.+.++.|   
       |        O  O   OO O OO O               +       +                    |   
  3000 |-+       O   O           O OO O O OO O OO O O OO O O                |   
  2000 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.   .++.+.++.                                .+.          |   
  4000 |.++.+.+    +.+         +.+.++.+.+.++.+. +.+. .+     +.+   ++.+.+.  +|   
  3500 |-+                                     +    +  +.+.+             ++ |   
       |        O      OO O OO O O    O           O                         |   
  3000 |-+       O O O             OO   O OO O OO   O OO O O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |       .++.+.   +.+.++.             .+                 .+.    .+.  .|   
  4000 |-++. .+      +.+       +.+.++.+.+.++  + +.+. .+ .+.++.+   ++.+   ++ |   
  3500 |.+  +                                  +    +  +                    |   
       |        O  O   OO O OO   O  O O      O  O O      O                  |   
  3000 |-+       O   O         O   O    O OO   O    O OO   O                |   
  2500 |-+                                                                  |   
       |                                                                    |   
  2000 |-+                                                                  |   
  1500 |-+                                                                  |   
       |                                                                    |   
  1000 |-+                                                                  |   
   500 |-+                                                                  |   
       |                                                                    |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4300 +--------------------------------------------------------------------+   
       |                                                                    |   
  4200 |-+      ++       .+.+                                               |   
  4100 |-+      : :     +    +                                  +           |   
       |       :  :     :     :                             +   ::     +    |   
  4000 |-+     :   +   :      :                             :: : :    +:   :|   
       |     .+     + .+       :           +.+              :: :  +  +  :  :|   
  3900 |-+ .+        +         +.+.++.+.+. : :        +    :  :    :+   :  :|   
       |  +                               +   : +.   +:    :  +    +    :  :|   
  3800 |:+:                                   : : +.+ :   .+             :: |   
  3700 |::                                    : :      : +               ++ |   
       | +                                    : :      :+                   |   
  3600 |-+                                     :       +                    |   
       |                                       :                            |   
  3500 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  350 +---------------------------------------------------------------------+   
      |                         +  :  +:                        +           |   
  300 |-+                       :  : +  :       +    +          ::          |   
      |    +.+                 +    +   :       ::   :         : :          |   
      | +  : :                 :        :      : :   ::        :  :         |   
  250 |+++:   :               :         :      :  + : :  +.+   :  +         |   
      |   +   :               :          :     :   +: :  :  : :   :     .+ +|   
  200 |-+     :               :          :   +:     + : :   +.+    : +.+  + |   
      |       :               :          +  : +        ::          :+       |   
  150 |-+      :    +      +.:            + :          +           +        |   
      |        +.  + :  + +  +             +                                |   
      |          ++  : + +                                                  |   
  100 |-+             +                                                     |   
      |                                                                     |   
   50 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4300 +--------------------------------------------------------------------+   
       |                 .+.+                                               |   
  4200 |-+      ++      +   :                                               |   
  4100 |-+      : +     :    :                                              |   
       |       :   +    :    +                                  +           |   
  4000 |-+     :    :  :      :                             +   :+     +   :|   
       |      :     :  +      :                             :: :  +   + :  :|   
  3900 |-+    +      :+        +   ++   +    +              :: :   :.+  :  :|   
       |     +       +          + +  + + +  +:  +.+. .+    :  +    +     : :|   
  3800 |.++.+                    +    +   ++  : :   + :    :             +: |   
  3700 |-+                                    : :     :    +              + |   
       |                                       :       :  :                 |   
  3600 |-+                                     +       :  :                 |   
       |                                               +.+                  |   
  3500 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  450 +---------------------------------------------------------------------+   
      |           :                                                         |   
  400 |-+         ::                                                        |   
      |          : :                                                   +    |   
  350 |-+        : :                                           .+      ::   |   
      |         .+ :           +    +                         +  :    : :   |   
  300 |-+      +    :      +. +:   + :     +  +            + :   :    :  ++ |   
      |   ++   :    :.+.+  : +  : +  : +   :  ::           :::    + .+     :|   
  250 |-+:  : :     +   : :     :+    ::: : : ::           :+      +       :|   
      |  :  : :          ::     +     + : : ::  +. .++.+  :                 |   
  200 |.+    +           +               +   :    +    :  :                 |   
      |                                      +          : :                 |   
  150 |-+                                               : :                 |   
      |                                                  :                  |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
  4400 |-+                :                                                 |   
       |                 : :                                                |   
  4300 |-+               : :                                                |   
  4200 |-+      +       :  :                                                |   
       |       : +      +   :                                   +           |   
  4100 |-+     :  +   .+    ++                                  ::          |   
  4000 |-+    +    +.+        :             .+              +  : :    .+   :|   
  3900 |-+    :               :   .+   .+. + :        +     :+ :  : .+  :  :|   
       |+    :                 +.+  +.+   +   : +.+  ::     : +   ++    : + |   
  3800 |-++. :                                : :  + ::    :             +  |   
  3700 |-+  +                                 : :   +  :  .+                |   
       |                                       :       :.+                  |   
  3600 |-+                                     +       +                    |   
  3500 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  450 +---------------------------------------------------------------------+   
      | :                                :                                  |   
  400 |::                                ::                                 |   
      |: :                               ::  +                       +      |   
  350 |:+:                              : :  :                       ::     |   
      |  :                              : : : :      +     +    +   : : .+ .|   
  300 |-+: +.                   +     + :  :: +.     :+   +:   ::   :  +  + |   
      |   :: +      +           :     : :  +    +   +  +.+  :  : :  :       |   
  250 |-+ :   +     ::          ::   :: :        : :        :.+  : :        |   
      |   +    +   : :         : :   : ::        : :        +     :+        |   
  200 |-+       +  :  +    +. .+ :  +  :          +               +         |   
      |          ++    +  :  +    :+   :                                    |   
  150 |-+               + :       +    +                                    |   
      |                  +                                                  |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4400 +--------------------------------------------------------------------+   
       |                 : :                                                |   
  4300 |-+               : :                                                |   
  4200 |-+      +       +   :+                                  +           |   
       |       : +.+    :   +:                                  :           |   
  4100 |-+     :    :   :     :                                : :    .+    |   
  4000 |-+    +     :  :      :              +                 : :   + :    |   
       |      :      +.:       :             :        +     +  :  : :   :  :|   
  3900 |-+   :         +       +. .++. .+.+ : :       :     :: :  + :   :  :|   
  3800 |:+   :                   +    +    :: : +.+  ::     :::    +    :  :|   
       |: +.+                              +  : :  + : :   :  +          :: |   
  3700 |-::                                   : :   +  :.+.+             ++ |   
  3600 |-+                                     :       +                    |   
       |                                       +                            |   
  3500 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  450 +---------------------------------------------------------------------+   
      |                                         +.+                         |   
  400 |-+                                       : :                         |   
      |   + .+                 +    +.         :   :                        |   
  350 |-+ :+ :                 :+   : +        :   : +                      |   
      |  :    :                : : :  :       :     :::            +.+.+.   |   
  300 |-+:    :               :  : :   :      +     + :       +.+  :     +  |   
      |.+     :               :   :    :.+   +         +. .+  :  : :      :+|   
  250 |-+     :               :   +    +  + +            + : :   ::       + |   
      |        :  +       .+  :            +                ::    +         |   
  200 |-+      :  :+ .+  +  ::                              +               |   
      |        +.+  +  + :  ::                                              |   
  150 |-+               +    +                                              |   
      |                                                                     |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4300 +--------------------------------------------------------------------+   
       |                 : :                                                |   
  4200 |-+               : : +                                              |   
  4100 |-+     .++      +   + +                                 +           |   
       |      +   +     :      +    +                           ::   +.     |   
  4000 |-+    :    +   :        :   ::       +                 : :   : +    |   
       |     :     :   +        :   ::      ::                 :  + :  :   :|   
  3900 |-+   :      :  :         : :  :   + ::  +           +  :   ::   :  :|   
       |     :      : :          +.:  +. + +  : :+    +     :+:    +    :  :|   
  3800 |:++  :       ::            +    +     : : +. +:    :  +         : : |   
  3700 |:+:+:        +                        : :   +  : +.+             :+ |   
       | +  +                                 ::       :+                +  |   
  3600 |-+                                     :       +                    |   
       |                                       :                            |   
  3500 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  450 +---------------------------------------------------------------------+   
      |                                                                     |   
  400 |-+                                       +                           |   
      |      +                                 + :                          |   
  350 |-+   +:                            .+.++  :                     +    |   
      |    +  :                          +        :           +       + :   |   
  300 |-+  :  :                          :        +    +      ::    .+  :   |   
      |    :  :  +                       :         :  + +    : :  ++     : :|   
  250 |.+  :   :+:       +    .+    +.  :          : +   +.  :  :+       + :|   
      | + :    +  :     +:   +  +   : + :           +      + :  +        : :|   
  200 |-++:       +    +  :  :   : :  : :                   :             ::|   
      |   +        + .+   : :    : :   ::                   +             : |   
  150 |-+           +      ::     :    :                                  + |   
      |                    +      +    +                                    |   
  100 +---------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
  4400 |-+                +                                                 |   
       |                  :                                                 |   
  4300 |-+               : :                                                |   
  4200 |-+       +       : :                                                |   
       |         :+     +   :                                               |   
  4100 |-+      +  +    :   +                                   +      +    |   
  4000 |-+     :    :  +     +               +                  :+    +:    |   
  3900 |-+     :    : +       :             ::        +     +  :  + .+  :  :|   
       |     .+      +        : .+.  .+. .+ : : +    ::     :+ :   +    :  :|   
  3800 |:+ .+                  +   ++   +  +  : :+   ::    :  +          : :|   
  3700 |:++                                   : : +.+  :  .+             +: |   
       | +                                     :       :.+                + |   
  3600 |-+                                     +       +                    |   
  3500 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
  4400 |-+                :                                                 |   
       |                 : :                                                |   
  4300 |-+               : :                                                |   
  4200 |-+      ++      :   :                                               |   
  4100 |-+      : :     +   ++                                              |   
  4000 |-+     :  :     :     :                                  .+    +    |   
       |       :   +   +      :                             +   + :   +:    |   
  3900 |-+     :    :  :       :  .+   .+.            +     ::  :  :.+  :   |   
  3800 |.+     :    : :        +.+  +.+   ++         ::     :: :   +    :   |   
  3700 |-+ .+.:      ::                     +   +.   : :   :  ::        :  .|   
  3600 |-++   +      +                       +  : +.+  :   +  +          :+ |   
       |                                      +:       +. +              +  |   
  3500 |-+                                     +         +                  |   
  3400 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  4500 +--------------------------------------------------------------------+   
       |         +.     +.+.++.                                 +.          |   
  4000 |.+ .+.+.+  +.+. :      +. .++. .+. +.+.      .+     +. +  ++.+.+.  +|   
  3500 |-++            +         +    +   +    ++.+.+  +.+  : +          ++ |   
       |                                                 :  :               |   
  3000 |-+                                               :  :               |   
  2500 |-+                                                : :               |   
       |                                                  : :               |   
  2000 |-+                                                : :               |   
  1500 |-+                                                ::                |   
       |                                                  ::                |   
  1000 |-+                                                ::                |   
   500 |-+                                                 :                |   
       |                                                   :                |   
     0 +--------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  25 +----------------------------------------------------------------------+   
     |                                             :                        |   
     |                                             :                        |   
  20 |-+                                          ::                        |   
     |                                            : :                       |   
     |                                            : :                       |   
  15 |-+                                          : :                       |   
     |                                           :  :                       |   
  10 |-+                                         :  :                       |   
     |   +       +.       +                     ++  :  ++                   |   
     |   :       : +      :      +     +   .+. +    :  ::               +.+.|   
   5 |-+::       :  :    : :     ::    :: +   +      ::  :           +  :   |   
     |  : :     :   :    + :     ::   : : :          ::  :          : : :   |   
     | :  :     :    :  +   :   :  :  :  :           :    :         : ::    |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                                                                                                
                                                                                
                                                                                
  18 +----------------------------------------------------------------------+   
     |                                          +                           |   
  16 |-+                                        :                           |   
  14 |-+                                        :                           |   
     |                                          :               +           |   
  12 |-+                                       ::               :           |   
  10 |-+                                       ::              ::           |   
     |                           +     +       ::              ::         + |   
   8 |++             +           :     :+      : :            : :         : |   
   6 |-+             :   +       ::   :  +     : :        +   +  :     + : :|   
     | :            : :  :       ::   :  :     : :        :   :  :     : : :|   
   4 |-+:           : : ::      : :   :  :    :  :       : : :   :    :: : :|   
   2 |-+:           : : : : +   : :   :   :   :  : +     : : :   :    : :: :|   
     |   :         :   :  :+ +  :  : :    :   :  :+ +   :   :    :   :  :   |   
   0 +----------------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2sp9: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase/ucode:
  gcc-9/performance/4BRD_12G/ext4/x86_64-rhel-8.3/3000/RAID0/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp9/disk_rw/aim7/0x5003006

commit: 
  45f1df8c51 ("ext4: factor out write end code of inline file")
  57e8668f62 ("ext4: drop unnecessary journal handle in delalloc write")

45f1df8c51768910 57e8668f62e2f2fb09bc459d660 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     90778           +60.6%     145823        aim7.jobs-per-min
    199.62           -37.5%     124.76        aim7.time.elapsed_time
    199.62           -37.5%     124.76        aim7.time.elapsed_time.max
   1324570           -51.8%     638955        aim7.time.involuntary_context_switches
    225830           -10.2%     202874        aim7.time.minor_page_faults
     15634           -40.5%       9303        aim7.time.system_time
    261.18            -8.4%     239.24        aim7.time.user_time
    178177           -33.2%     119111        aim7.time.voluntary_context_switches
    250.50           -29.6%     176.29        uptime.boot
     17259            -8.9%      15731        slabinfo.Acpi-State.active_objs
     17273            -8.9%      15741        slabinfo.Acpi-State.num_objs
      7.20           +52.8%      11.00        iostat.cpu.idle
     91.26            -4.9%      86.75        iostat.cpu.system
      1.54           +46.1%       2.25        iostat.cpu.user
      6.32 ±  2%      +3.3        9.65        mpstat.cpu.all.idle%
      0.13            +0.0        0.17        mpstat.cpu.all.soft%
      1.55            +0.7        2.27        mpstat.cpu.all.usr%
      2792            -1.1%       2761        turbostat.Bzy_MHz
      6.16           +55.7%       9.60        turbostat.CPU%c1
      0.08 ±  4%     +50.4%       0.12 ±  5%  turbostat.CPU%c6
  36858184           -35.9%   23641216        turbostat.IRQ
    246453 ±  4%     -58.4%     102419 ±  3%  meminfo.Active
    245318 ±  4%     -58.7%     101371 ±  3%  meminfo.Active(anon)
    164084           -14.7%     140024        meminfo.AnonHugePages
     79817 ±  7%     +31.5%     104926 ±  6%  meminfo.Mapped
    290414 ±  4%     -43.6%     163760 ±  2%  meminfo.Shmem
      4880 ±  5%     +44.7%       7064 ±  3%  vmstat.io.bo
    921.67            -9.0%     839.14 ±  2%  vmstat.memory.buff
    191.33           -20.2%     152.71 ±  2%  vmstat.procs.r
      9184           -14.8%       7827        vmstat.system.cs
    181911            +1.8%     185188        vmstat.system.in
     14408 ± 95%     -93.9%     876.43 ± 69%  numa-vmstat.node0.nr_active_anon
     14408 ± 95%     -93.9%     876.43 ± 69%  numa-vmstat.node0.nr_zone_active_anon
     46826 ± 31%     -48.3%      24188 ±  4%  numa-vmstat.node1.nr_active_anon
    421765 ± 57%     -46.3%     226292 ± 13%  numa-vmstat.node1.nr_file_pages
     34238 ± 17%     -24.5%      25848 ± 14%  numa-vmstat.node1.nr_slab_reclaimable
     46826 ± 31%     -48.3%      24188 ±  4%  numa-vmstat.node1.nr_zone_active_anon
     57967 ± 94%     -92.8%       4197 ± 58%  numa-meminfo.node0.Active
     57365 ± 95%     -93.7%       3613 ± 72%  numa-meminfo.node0.Active(anon)
    188267 ± 31%     -47.7%      98408 ±  4%  numa-meminfo.node1.Active
    187734 ± 31%     -47.8%      97944 ±  4%  numa-meminfo.node1.Active(anon)
   1687213 ± 57%     -46.4%     905002 ± 13%  numa-meminfo.node1.FilePages
    136983 ± 17%     -24.5%     103406 ± 14%  numa-meminfo.node1.KReclaimable
    136983 ± 17%     -24.5%     103406 ± 14%  numa-meminfo.node1.SReclaimable
     61214 ±  4%     -58.8%      25240 ±  3%  proc-vmstat.nr_active_anon
    344154            -6.2%     322853        proc-vmstat.nr_dirty
   1009005            -5.3%     955766        proc-vmstat.nr_file_pages
    102291            +4.5%     106921        proc-vmstat.nr_inactive_anon
    344140            -6.2%     322836        proc-vmstat.nr_inactive_file
     60185            -2.0%      58966        proc-vmstat.nr_kernel_stack
     19934 ±  7%     +32.5%      26406 ±  6%  proc-vmstat.nr_mapped
     72483 ±  4%     -43.6%      40888 ±  2%  proc-vmstat.nr_shmem
     71089            -2.6%      69261        proc-vmstat.nr_slab_reclaimable
     82098            -0.8%      81403        proc-vmstat.nr_slab_unreclaimable
     61214 ±  4%     -58.8%      25240 ±  3%  proc-vmstat.nr_zone_active_anon
    102291            +4.5%     106921        proc-vmstat.nr_zone_inactive_anon
    344140            -6.2%     322836        proc-vmstat.nr_zone_inactive_file
    345202            -6.2%     323647        proc-vmstat.nr_zone_write_pending
     75303 ±  5%     -27.0%      54964 ±  6%  proc-vmstat.numa_hint_faults
     41471 ±  7%     -30.2%      28958 ±  6%  proc-vmstat.numa_hint_faults_local
    975502           -19.1%     789116        proc-vmstat.pgfault
     49514           -30.4%      34479        proc-vmstat.pgreuse
      2.14           -34.8%       1.40        perf-stat.i.MPKI
 2.864e+10           +37.8%  3.948e+10        perf-stat.i.branch-instructions
      0.21            -0.0        0.19        perf-stat.i.branch-miss-rate%
  57653789           +18.0%   68046121        perf-stat.i.branch-misses
  96992182            -8.6%   88683291        perf-stat.i.cache-misses
 2.877e+08            -9.7%  2.599e+08        perf-stat.i.cache-references
      9195           -15.0%       7818        perf-stat.i.context-switches
      1.70           -30.6%       1.18        perf-stat.i.cpi
 2.259e+11            -4.9%   2.15e+11        perf-stat.i.cpu-cycles
   3.9e+10           +38.6%  5.404e+10        perf-stat.i.dTLB-loads
 2.147e+10           +39.2%  2.988e+10        perf-stat.i.dTLB-stores
  22481412 ±  2%     +10.2%   24773658 ±  2%  perf-stat.i.iTLB-load-misses
 1.298e+11           +38.3%  1.794e+11        perf-stat.i.instructions
      5779 ±  2%     +24.5%       7193 ±  2%  perf-stat.i.instructions-per-iTLB-miss
      0.60           +41.9%       0.85        perf-stat.i.ipc
      6.52 ± 20%     +65.0%      10.76 ± 24%  perf-stat.i.major-faults
      2.57            -4.9%       2.44        perf-stat.i.metric.GHz
    273.69 ±  2%      +4.5%     286.07        perf-stat.i.metric.K/sec
      1015           +38.3%       1404        perf-stat.i.metric.M/sec
      4634           +28.1%       5936        perf-stat.i.minor-faults
     76.12            -2.3       73.78        perf-stat.i.node-load-miss-rate%
  10886353            -5.7%   10260641        perf-stat.i.node-load-misses
   3362438            +8.5%    3648289        perf-stat.i.node-loads
     60.87            -5.1       55.80        perf-stat.i.node-store-miss-rate%
   5284905            +5.6%    5582480        perf-stat.i.node-store-misses
   3184129           +27.5%    4058359        perf-stat.i.node-stores
      4637           +28.1%       5940        perf-stat.i.page-faults
      2.22           -34.7%       1.45        perf-stat.overall.MPKI
      0.20            -0.0        0.17        perf-stat.overall.branch-miss-rate%
     33.70            +0.4       34.13        perf-stat.overall.cache-miss-rate%
      1.74           -31.2%       1.20        perf-stat.overall.cpi
      2332            +4.0%       2424        perf-stat.overall.cycles-between-cache-misses
      0.00 ±131%      -0.0        0.00 ± 27%  perf-stat.overall.dTLB-store-miss-rate%
      5776 ±  2%     +25.5%       7246 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.57           +45.4%       0.83        perf-stat.overall.ipc
     76.41            -2.6       73.76        perf-stat.overall.node-load-miss-rate%
     62.41            -4.5       57.89        perf-stat.overall.node-store-miss-rate%
 2.864e+10           +37.9%   3.95e+10        perf-stat.ps.branch-instructions
  57611695           +18.0%   68000639        perf-stat.ps.branch-misses
  96905746            -8.4%   88722764        perf-stat.ps.cache-misses
 2.876e+08            -9.6%    2.6e+08        perf-stat.ps.cache-references
      9178           -15.1%       7790        perf-stat.ps.context-switches
  2.26e+11            -4.8%  2.151e+11        perf-stat.ps.cpu-cycles
   3.9e+10           +38.7%  5.407e+10        perf-stat.ps.dTLB-loads
 2.147e+10           +39.3%   2.99e+10        perf-stat.ps.dTLB-stores
  22482109 ±  2%     +10.3%   24788328 ±  2%  perf-stat.ps.iTLB-load-misses
 1.298e+11           +38.4%  1.795e+11        perf-stat.ps.instructions
      5.98 ± 20%     +64.9%       9.86 ± 23%  perf-stat.ps.major-faults
      4536           +27.1%       5764        perf-stat.ps.minor-faults
  10880508            -5.7%   10262694        perf-stat.ps.node-load-misses
   3359742            +8.7%    3651317        perf-stat.ps.node-loads
   5286670            +5.7%    5586216        perf-stat.ps.node-store-misses
   3184698           +27.6%    4063518        perf-stat.ps.node-stores
      4542           +27.1%       5774        perf-stat.ps.page-faults
 2.596e+13           -13.4%  2.247e+13        perf-stat.total.instructions
     22485 ±  2%     -26.0%      16638 ±  3%  softirqs.CPU0.RCU
     19140 ±  7%     -31.9%      13039 ± 16%  softirqs.CPU1.RCU
     16877 ±  3%     -31.1%      11629 ±  6%  softirqs.CPU10.RCU
     17193 ±  7%     -29.1%      12181 ±  9%  softirqs.CPU11.RCU
     16863 ±  3%     -30.9%      11648 ±  5%  softirqs.CPU12.RCU
     16663 ±  3%     -31.5%      11408 ±  3%  softirqs.CPU13.RCU
     16618 ±  2%     -32.6%      11200 ± 11%  softirqs.CPU14.RCU
     17173 ±  3%     -32.3%      11621 ±  4%  softirqs.CPU15.RCU
     16792 ±  2%     -32.3%      11372 ±  5%  softirqs.CPU16.RCU
     16283 ±  6%     -28.2%      11692 ± 15%  softirqs.CPU17.RCU
     16848 ±  2%     -31.6%      11518 ±  5%  softirqs.CPU18.RCU
     16708 ±  2%     -33.0%      11191 ±  5%  softirqs.CPU19.RCU
     18507 ±  7%     -28.1%      13313 ±  9%  softirqs.CPU2.RCU
     17234 ±  3%     -35.6%      11106 ±  2%  softirqs.CPU20.RCU
     17071 ±  6%     -33.2%      11400 ±  4%  softirqs.CPU21.RCU
     17569 ±  7%     -36.0%      11240 ±  7%  softirqs.CPU22.RCU
     17689 ±  5%     -31.6%      12098 ±  9%  softirqs.CPU23.RCU
     17886 ±  8%     -34.3%      11748 ±  5%  softirqs.CPU24.RCU
     17273 ±  5%     -35.0%      11230 ±  4%  softirqs.CPU25.RCU
     17234 ±  5%     -36.1%      11015 ±  8%  softirqs.CPU26.RCU
     17160 ±  5%     -32.7%      11545 ±  7%  softirqs.CPU27.RCU
     17669 ± 12%     -37.2%      11100 ±  7%  softirqs.CPU28.RCU
     16008 ± 11%     -31.1%      11033 ±  9%  softirqs.CPU29.RCU
     17388 ±  8%     -34.7%      11363 ±  4%  softirqs.CPU30.RCU
     16753 ±  3%     -31.3%      11512 ±  6%  softirqs.CPU31.RCU
     17246 ±  3%     -33.4%      11492 ±  4%  softirqs.CPU32.RCU
     17079 ±  3%     -33.1%      11428 ±  6%  softirqs.CPU33.RCU
     16882 ±  3%     -33.2%      11275 ±  3%  softirqs.CPU34.RCU
     17130 ±  2%     -33.8%      11333 ±  2%  softirqs.CPU36.RCU
     16998 ±  3%     -31.3%      11675 ±  7%  softirqs.CPU37.RCU
     16865           -31.7%      11519 ±  3%  softirqs.CPU38.RCU
     17009 ±  3%     -32.9%      11413 ±  3%  softirqs.CPU39.RCU
     17858 ±  3%     -26.4%      13141 ± 12%  softirqs.CPU4.RCU
     16750 ±  2%     -32.3%      11336 ±  3%  softirqs.CPU40.RCU
     16867 ±  2%     -30.8%      11669 ±  3%  softirqs.CPU42.RCU
     17052 ±  2%     -31.8%      11625 ±  4%  softirqs.CPU43.RCU
     14818 ±  4%     -32.4%      10023 ±  8%  softirqs.CPU44.RCU
     17965 ± 11%     -32.2%      12172 ± 10%  softirqs.CPU45.RCU
     17446 ±  3%     -30.7%      12084 ±  9%  softirqs.CPU46.RCU
     17293 ±  2%     -33.9%      11430 ±  2%  softirqs.CPU47.RCU
     17791 ±  2%     -32.1%      12078 ±  7%  softirqs.CPU48.RCU
     17569 ±  4%     -33.6%      11658 ±  4%  softirqs.CPU49.RCU
     17940 ±  5%     -31.1%      12358 ±  6%  softirqs.CPU5.RCU
     17964 ±  3%     -32.9%      12057 ±  8%  softirqs.CPU50.RCU
     18052 ±  8%     -33.3%      12032 ±  6%  softirqs.CPU51.RCU
     17570 ±  2%     -32.5%      11863 ±  5%  softirqs.CPU52.RCU
     17583 ±  2%     -30.9%      12156 ±  5%  softirqs.CPU53.RCU
     17751 ±  3%     -30.5%      12330 ±  7%  softirqs.CPU54.RCU
     17676 ±  3%     -27.9%      12748 ± 12%  softirqs.CPU55.RCU
     17726 ±  3%     -34.0%      11692 ±  6%  softirqs.CPU56.RCU
     17951 ±  2%     -32.6%      12104 ±  6%  softirqs.CPU57.RCU
     17238 ±  3%     -33.1%      11536 ±  9%  softirqs.CPU58.RCU
     17739           -34.7%      11591 ±  4%  softirqs.CPU59.RCU
     17240 ±  2%     -31.9%      11741 ±  5%  softirqs.CPU6.RCU
     17024 ±  2%     -35.0%      11069 ±  3%  softirqs.CPU60.RCU
     17078 ±  2%     -31.6%      11679 ±  6%  softirqs.CPU62.RCU
     17184 ±  3%     -31.9%      11707 ±  6%  softirqs.CPU63.RCU
     16932 ±  2%     -32.0%      11509 ±  5%  softirqs.CPU64.RCU
     17853 ±  5%     -32.9%      11979 ±  6%  softirqs.CPU66.RCU
     17244 ±  5%     -32.2%      11686 ±  8%  softirqs.CPU67.RCU
     17199 ±  3%     -32.6%      11591 ±  4%  softirqs.CPU68.RCU
     17081 ±  4%     -31.6%      11681 ±  5%  softirqs.CPU69.RCU
     17133 ±  5%     -30.4%      11930 ± 13%  softirqs.CPU7.RCU
     16953 ±  3%     -30.9%      11716 ±  8%  softirqs.CPU70.RCU
     17242 ±  3%     -34.1%      11362 ±  7%  softirqs.CPU71.RCU
     17221 ±  7%     -35.3%      11144 ± 10%  softirqs.CPU72.RCU
     16621 ±  4%     -32.1%      11292 ±  8%  softirqs.CPU73.RCU
     16836 ±  2%     -30.8%      11645 ±  5%  softirqs.CPU74.RCU
     15821 ±  5%     -30.9%      10928 ±  5%  softirqs.CPU75.RCU
     16064 ±  2%     -32.2%      10892 ±  4%  softirqs.CPU76.RCU
     16150 ±  4%     -30.7%      11195 ± 11%  softirqs.CPU77.RCU
     15789 ±  2%     -32.1%      10720 ±  5%  softirqs.CPU78.RCU
     16085 ±  7%     -34.6%      10523 ±  5%  softirqs.CPU79.RCU
     17256 ±  3%     -31.9%      11755 ±  3%  softirqs.CPU8.RCU
     15705 ±  3%     -31.7%      10729 ±  5%  softirqs.CPU80.RCU
     16253 ±  4%     -30.4%      11315 ±  5%  softirqs.CPU81.RCU
     16289 ±  3%     -33.7%      10806 ±  4%  softirqs.CPU82.RCU
     16352 ±  2%     -33.4%      10891 ±  5%  softirqs.CPU83.RCU
     17667 ± 14%     -37.0%      11139 ±  7%  softirqs.CPU84.RCU
     16499 ±  8%     -32.8%      11085 ±  6%  softirqs.CPU85.RCU
     16322 ±  3%     -32.4%      11031 ±  7%  softirqs.CPU86.RCU
     16451 ±  6%     -33.0%      11019 ±  8%  softirqs.CPU87.RCU
     17386 ±  4%     -26.8%      12735 ± 15%  softirqs.CPU9.RCU
   1506457           -31.9%    1025497        softirqs.RCU
    507635 ±  8%     -16.5%     423820 ±  9%  softirqs.SCHED
     44459           -28.2%      31902        softirqs.TIMER
    188022           -16.2%     157607 ±  6%  interrupts.CAL:Function_call_interrupts
    401728           -37.3%     251825        interrupts.CPU0.LOC:Local_timer_interrupts
      1269 ± 14%     -42.7%     727.00 ±  6%  interrupts.CPU0.RES:Rescheduling_interrupts
    401475           -37.2%     251976        interrupts.CPU1.LOC:Local_timer_interrupts
      1069 ±  3%     -35.1%     694.00 ±  7%  interrupts.CPU1.RES:Rescheduling_interrupts
    401539           -37.3%     251825        interrupts.CPU10.LOC:Local_timer_interrupts
      1074 ±  5%     -38.5%     661.14 ±  5%  interrupts.CPU10.RES:Rescheduling_interrupts
      2154 ±  9%     -17.5%       1778 ±  9%  interrupts.CPU11.CAL:Function_call_interrupts
    401523           -37.3%     251834        interrupts.CPU11.LOC:Local_timer_interrupts
      2150 ±  7%     -18.5%       1751 ±  7%  interrupts.CPU12.CAL:Function_call_interrupts
    401542           -37.3%     251771        interrupts.CPU12.LOC:Local_timer_interrupts
    401566           -37.3%     251805        interrupts.CPU13.LOC:Local_timer_interrupts
      1068 ±  5%     -36.0%     683.57 ±  4%  interrupts.CPU13.RES:Rescheduling_interrupts
      2101 ±  7%     -17.6%       1731 ±  7%  interrupts.CPU14.CAL:Function_call_interrupts
    401526           -37.3%     251768        interrupts.CPU14.LOC:Local_timer_interrupts
      1090 ± 12%     -35.5%     703.29 ±  5%  interrupts.CPU14.RES:Rescheduling_interrupts
      2055 ±  2%     -15.4%       1739 ±  7%  interrupts.CPU15.CAL:Function_call_interrupts
    401586           -37.3%     251729        interrupts.CPU15.LOC:Local_timer_interrupts
    401586           -37.3%     251875        interrupts.CPU16.LOC:Local_timer_interrupts
      1035 ±  3%     -36.1%     661.43 ±  4%  interrupts.CPU16.RES:Rescheduling_interrupts
      2068 ±  2%     -15.4%       1749 ±  4%  interrupts.CPU17.CAL:Function_call_interrupts
    401487           -37.3%     251768        interrupts.CPU17.LOC:Local_timer_interrupts
      1129 ± 13%     -40.9%     667.43 ±  6%  interrupts.CPU17.RES:Rescheduling_interrupts
      2139 ±  4%     -16.8%       1779 ±  7%  interrupts.CPU18.CAL:Function_call_interrupts
    401565           -37.3%     251745        interrupts.CPU18.LOC:Local_timer_interrupts
      2084 ±  3%     -15.4%       1763 ±  8%  interrupts.CPU19.CAL:Function_call_interrupts
    401536           -37.3%     251802        interrupts.CPU19.LOC:Local_timer_interrupts
    401612           -37.3%     251877        interrupts.CPU2.LOC:Local_timer_interrupts
      1186 ± 20%     -38.6%     729.14 ± 21%  interrupts.CPU2.RES:Rescheduling_interrupts
      2018           -14.8%       1720 ±  6%  interrupts.CPU20.CAL:Function_call_interrupts
    401539           -37.3%     251751        interrupts.CPU20.LOC:Local_timer_interrupts
      1036 ±  4%     -34.7%     677.00 ±  3%  interrupts.CPU20.RES:Rescheduling_interrupts
      2109 ±  4%     -17.4%       1741 ±  7%  interrupts.CPU21.CAL:Function_call_interrupts
    401543           -37.3%     251730        interrupts.CPU21.LOC:Local_timer_interrupts
      1031 ±  7%     -30.0%     721.57 ± 14%  interrupts.CPU21.RES:Rescheduling_interrupts
      2279 ±  9%     -25.6%       1695 ± 17%  interrupts.CPU22.CAL:Function_call_interrupts
    401617           -37.3%     251952        interrupts.CPU22.LOC:Local_timer_interrupts
      1255 ± 15%     -37.2%     788.43 ± 10%  interrupts.CPU22.RES:Rescheduling_interrupts
    401630           -37.3%     251855        interrupts.CPU23.LOC:Local_timer_interrupts
      1044 ±  6%     -35.0%     678.71 ±  6%  interrupts.CPU23.RES:Rescheduling_interrupts
      2260 ±  8%     -19.1%       1828 ± 10%  interrupts.CPU24.CAL:Function_call_interrupts
    401572           -37.3%     251829        interrupts.CPU24.LOC:Local_timer_interrupts
      1008 ±  7%     -33.7%     669.00 ±  5%  interrupts.CPU24.RES:Rescheduling_interrupts
    401600           -37.3%     251989        interrupts.CPU25.LOC:Local_timer_interrupts
      1219 ± 39%     -43.2%     692.29 ±  5%  interrupts.CPU25.RES:Rescheduling_interrupts
      2169 ±  4%     -16.5%       1812 ±  8%  interrupts.CPU26.CAL:Function_call_interrupts
    401594           -37.3%     251774        interrupts.CPU26.LOC:Local_timer_interrupts
      1010 ±  6%     -35.1%     656.00 ±  3%  interrupts.CPU26.RES:Rescheduling_interrupts
    401592           -37.3%     251790        interrupts.CPU27.LOC:Local_timer_interrupts
      1022 ± 11%     -33.5%     679.29 ±  8%  interrupts.CPU27.RES:Rescheduling_interrupts
      2194 ±  4%     -17.7%       1806 ±  8%  interrupts.CPU28.CAL:Function_call_interrupts
    401631           -37.3%     251782        interrupts.CPU28.LOC:Local_timer_interrupts
      1014 ±  8%     -34.6%     663.29 ±  4%  interrupts.CPU28.RES:Rescheduling_interrupts
    401639           -37.3%     251817        interrupts.CPU29.LOC:Local_timer_interrupts
      1001 ±  8%     -34.2%     658.86 ±  4%  interrupts.CPU29.RES:Rescheduling_interrupts
    401565           -37.3%     251812        interrupts.CPU3.LOC:Local_timer_interrupts
      2140 ±  3%     -19.1%       1732 ±  9%  interrupts.CPU30.CAL:Function_call_interrupts
    401550           -37.3%     251746        interrupts.CPU30.LOC:Local_timer_interrupts
    996.83 ±  7%     -34.4%     653.57 ±  6%  interrupts.CPU30.RES:Rescheduling_interrupts
      2381 ± 11%     -24.9%       1787 ±  8%  interrupts.CPU31.CAL:Function_call_interrupts
    401830           -37.3%     251762        interrupts.CPU31.LOC:Local_timer_interrupts
      1001 ±  5%     -34.1%     659.71 ±  5%  interrupts.CPU31.RES:Rescheduling_interrupts
    401561           -37.3%     251753        interrupts.CPU32.LOC:Local_timer_interrupts
      1170 ± 20%     -45.0%     644.29 ±  7%  interrupts.CPU32.RES:Rescheduling_interrupts
      2229 ±  2%     -22.1%       1737 ±  7%  interrupts.CPU33.CAL:Function_call_interrupts
    401526           -37.3%     251739        interrupts.CPU33.LOC:Local_timer_interrupts
      1266 ± 30%     -49.1%     644.29 ±  4%  interrupts.CPU33.RES:Rescheduling_interrupts
      2121 ±  3%     -17.3%       1755 ±  7%  interrupts.CPU34.CAL:Function_call_interrupts
    401563           -37.3%     251741        interrupts.CPU34.LOC:Local_timer_interrupts
      1020 ±  5%     -34.7%     666.29 ±  7%  interrupts.CPU34.RES:Rescheduling_interrupts
      2115           -17.2%       1751 ±  7%  interrupts.CPU35.CAL:Function_call_interrupts
    401606           -37.3%     251748        interrupts.CPU35.LOC:Local_timer_interrupts
      1025 ±  6%     -33.7%     680.14 ± 12%  interrupts.CPU35.RES:Rescheduling_interrupts
      2128           -17.0%       1766 ±  5%  interrupts.CPU36.CAL:Function_call_interrupts
    401550           -37.3%     251786        interrupts.CPU36.LOC:Local_timer_interrupts
      1131 ± 23%     -38.3%     697.86 ±  8%  interrupts.CPU36.RES:Rescheduling_interrupts
      2151 ±  4%     -19.1%       1741 ±  7%  interrupts.CPU37.CAL:Function_call_interrupts
    401531           -37.3%     251738        interrupts.CPU37.LOC:Local_timer_interrupts
    989.67 ±  4%     -33.4%     658.71 ±  5%  interrupts.CPU37.RES:Rescheduling_interrupts
      2247 ±  6%     -23.9%       1710 ±  7%  interrupts.CPU38.CAL:Function_call_interrupts
    401539           -37.3%     251921        interrupts.CPU38.LOC:Local_timer_interrupts
      1191 ± 40%     -44.2%     665.14 ±  5%  interrupts.CPU38.RES:Rescheduling_interrupts
      2120 ±  4%     -19.5%       1707 ± 11%  interrupts.CPU39.CAL:Function_call_interrupts
    401589           -37.3%     251725        interrupts.CPU39.LOC:Local_timer_interrupts
      1013 ±  6%     -34.4%     664.29 ±  4%  interrupts.CPU39.RES:Rescheduling_interrupts
      2160 ± 10%     -24.3%       1635 ± 18%  interrupts.CPU4.CAL:Function_call_interrupts
    401585           -37.3%     251863        interrupts.CPU4.LOC:Local_timer_interrupts
      1089 ±  6%     -38.3%     672.14 ±  6%  interrupts.CPU4.RES:Rescheduling_interrupts
      2065 ±  4%     -13.7%       1781 ±  6%  interrupts.CPU40.CAL:Function_call_interrupts
    401558           -37.3%     251736        interrupts.CPU40.LOC:Local_timer_interrupts
      1011 ±  5%     -30.2%     705.86 ±  9%  interrupts.CPU40.RES:Rescheduling_interrupts
      2080 ±  3%     -12.8%       1814 ±  5%  interrupts.CPU41.CAL:Function_call_interrupts
    401557           -37.3%     251868        interrupts.CPU41.LOC:Local_timer_interrupts
    978.33 ±  5%     -31.9%     666.00 ±  6%  interrupts.CPU41.RES:Rescheduling_interrupts
      2110 ±  4%     -17.7%       1736 ±  6%  interrupts.CPU42.CAL:Function_call_interrupts
    401490           -37.2%     251954        interrupts.CPU42.LOC:Local_timer_interrupts
      1162 ± 30%     -40.2%     695.29 ± 13%  interrupts.CPU42.RES:Rescheduling_interrupts
      3420 ±  3%     -22.1%       2662 ±  9%  interrupts.CPU43.CAL:Function_call_interrupts
    401432           -37.3%     251855        interrupts.CPU43.LOC:Local_timer_interrupts
      1817 ±  3%     -35.8%       1167 ±  6%  interrupts.CPU43.RES:Rescheduling_interrupts
    401495           -37.3%     251669        interrupts.CPU44.LOC:Local_timer_interrupts
      1019 ±  8%     -35.9%     654.00 ±  6%  interrupts.CPU44.RES:Rescheduling_interrupts
    401455           -37.3%     251722        interrupts.CPU45.LOC:Local_timer_interrupts
      1026 ±  6%     -33.9%     678.57 ±  3%  interrupts.CPU45.RES:Rescheduling_interrupts
      2087 ±  3%     -16.6%       1740 ±  7%  interrupts.CPU46.CAL:Function_call_interrupts
    401594           -37.3%     251780        interrupts.CPU46.LOC:Local_timer_interrupts
      1180 ± 27%     -40.4%     704.00 ± 11%  interrupts.CPU46.RES:Rescheduling_interrupts
      2181 ± 11%     -20.0%       1745 ±  8%  interrupts.CPU47.CAL:Function_call_interrupts
    401568           -37.3%     251691        interrupts.CPU47.LOC:Local_timer_interrupts
      1055 ±  8%     -36.5%     669.71 ±  5%  interrupts.CPU47.RES:Rescheduling_interrupts
      2051           -12.5%       1794 ±  8%  interrupts.CPU48.CAL:Function_call_interrupts
    401616           -37.3%     251829        interrupts.CPU48.LOC:Local_timer_interrupts
      1144 ± 16%     -40.3%     683.86 ±  7%  interrupts.CPU48.RES:Rescheduling_interrupts
    401485           -37.3%     251669        interrupts.CPU49.LOC:Local_timer_interrupts
      1034 ±  7%     -35.6%     666.14 ±  6%  interrupts.CPU49.RES:Rescheduling_interrupts
    401535           -37.3%     251759        interrupts.CPU5.LOC:Local_timer_interrupts
      1132 ± 14%     -38.1%     701.29 ±  7%  interrupts.CPU5.RES:Rescheduling_interrupts
      2054 ±  3%     -14.7%       1751 ±  8%  interrupts.CPU50.CAL:Function_call_interrupts
    401524           -37.3%     251864        interrupts.CPU50.LOC:Local_timer_interrupts
      1176 ± 20%     -41.8%     684.71 ±  4%  interrupts.CPU50.RES:Rescheduling_interrupts
      2031           -14.6%       1734 ±  7%  interrupts.CPU51.CAL:Function_call_interrupts
    401525           -37.3%     251741        interrupts.CPU51.LOC:Local_timer_interrupts
      1037 ±  7%     -32.2%     703.71 ±  4%  interrupts.CPU51.RES:Rescheduling_interrupts
      2096 ±  5%     -17.4%       1731 ±  7%  interrupts.CPU52.CAL:Function_call_interrupts
    401531           -37.3%     251815        interrupts.CPU52.LOC:Local_timer_interrupts
      1108 ± 16%     -36.6%     702.71 ±  6%  interrupts.CPU52.RES:Rescheduling_interrupts
      2150 ± 10%     -18.6%       1750 ±  6%  interrupts.CPU53.CAL:Function_call_interrupts
    401493           -37.3%     251753        interrupts.CPU53.LOC:Local_timer_interrupts
      1074 ± 13%     -33.8%     711.14 ± 23%  interrupts.CPU53.RES:Rescheduling_interrupts
      2048 ±  2%     -15.2%       1738 ±  7%  interrupts.CPU54.CAL:Function_call_interrupts
    401527           -37.3%     251756        interrupts.CPU54.LOC:Local_timer_interrupts
      1095 ± 17%     -35.1%     711.29 ± 14%  interrupts.CPU54.RES:Rescheduling_interrupts
      2127 ±  8%     -18.9%       1725 ±  7%  interrupts.CPU55.CAL:Function_call_interrupts
    401437           -37.3%     251653        interrupts.CPU55.LOC:Local_timer_interrupts
      1080 ± 10%     -37.7%     673.57 ±  8%  interrupts.CPU55.RES:Rescheduling_interrupts
    401549           -37.3%     251786        interrupts.CPU56.LOC:Local_timer_interrupts
    401529           -37.3%     251825        interrupts.CPU57.LOC:Local_timer_interrupts
    401519           -37.3%     251741        interrupts.CPU58.LOC:Local_timer_interrupts
      2221 ±  8%     -22.8%       1715 ±  7%  interrupts.CPU59.CAL:Function_call_interrupts
    401561           -37.3%     251782        interrupts.CPU59.LOC:Local_timer_interrupts
      1143 ± 15%     -41.5%     668.43 ±  6%  interrupts.CPU59.RES:Rescheduling_interrupts
    401527           -37.3%     251809        interrupts.CPU6.LOC:Local_timer_interrupts
      2052           -16.0%       1724 ±  7%  interrupts.CPU60.CAL:Function_call_interrupts
    401559           -37.3%     251734        interrupts.CPU60.LOC:Local_timer_interrupts
      1062 ± 11%     -36.4%     675.86 ±  4%  interrupts.CPU60.RES:Rescheduling_interrupts
    401579           -37.3%     251930        interrupts.CPU61.LOC:Local_timer_interrupts
      1073 ±  9%     -35.2%     695.29 ±  5%  interrupts.CPU61.RES:Rescheduling_interrupts
      2026           -16.4%       1694 ±  6%  interrupts.CPU62.CAL:Function_call_interrupts
    401546           -37.3%     251800        interrupts.CPU62.LOC:Local_timer_interrupts
      1084 ± 10%     -39.1%     661.00 ±  6%  interrupts.CPU62.RES:Rescheduling_interrupts
    401570           -37.3%     251806        interrupts.CPU63.LOC:Local_timer_interrupts
      2020           -13.4%       1749 ±  7%  interrupts.CPU64.CAL:Function_call_interrupts
    401497           -37.3%     251691        interrupts.CPU64.LOC:Local_timer_interrupts
      1062 ± 22%     -34.3%     697.86 ±  7%  interrupts.CPU64.RES:Rescheduling_interrupts
    401628           -37.3%     251795        interrupts.CPU65.LOC:Local_timer_interrupts
    944.00 ± 10%     -31.4%     647.86 ±  6%  interrupts.CPU65.RES:Rescheduling_interrupts
      2111 ±  2%     -17.6%       1740 ±  6%  interrupts.CPU66.CAL:Function_call_interrupts
    401596           -37.3%     251875        interrupts.CPU66.LOC:Local_timer_interrupts
    933.17 ± 11%     -33.6%     619.71 ±  7%  interrupts.CPU66.RES:Rescheduling_interrupts
      2100 ±  4%     -17.7%       1729 ±  5%  interrupts.CPU67.CAL:Function_call_interrupts
    401516           -37.3%     251881        interrupts.CPU67.LOC:Local_timer_interrupts
    915.67 ±  6%     -35.3%     592.14 ±  6%  interrupts.CPU67.RES:Rescheduling_interrupts
      2085           -16.6%       1739 ±  7%  interrupts.CPU68.CAL:Function_call_interrupts
    401604           -37.3%     251890        interrupts.CPU68.LOC:Local_timer_interrupts
    889.17 ±  7%     -30.5%     618.14 ±  9%  interrupts.CPU68.RES:Rescheduling_interrupts
      2107 ±  3%     -17.3%       1743 ±  7%  interrupts.CPU69.CAL:Function_call_interrupts
    401546           -37.3%     251866        interrupts.CPU69.LOC:Local_timer_interrupts
    922.83 ±  9%     -33.3%     615.86 ±  6%  interrupts.CPU69.RES:Rescheduling_interrupts
      2079 ±  3%     -13.4%       1801 ±  6%  interrupts.CPU7.CAL:Function_call_interrupts
    401528           -37.3%     251839        interrupts.CPU7.LOC:Local_timer_interrupts
      1051 ±  6%     -33.4%     700.71 ± 11%  interrupts.CPU7.RES:Rescheduling_interrupts
      2141 ±  3%     -19.0%       1735 ±  6%  interrupts.CPU70.CAL:Function_call_interrupts
    401620           -37.3%     251847        interrupts.CPU70.LOC:Local_timer_interrupts
    900.67 ±  5%     -31.1%     621.00 ± 19%  interrupts.CPU70.RES:Rescheduling_interrupts
    401640           -37.3%     251858        interrupts.CPU71.LOC:Local_timer_interrupts
    872.83 ±  8%     -30.6%     605.71 ±  7%  interrupts.CPU71.RES:Rescheduling_interrupts
    401692           -37.3%     251891        interrupts.CPU72.LOC:Local_timer_interrupts
    916.67 ±  9%     -33.6%     608.43 ±  5%  interrupts.CPU72.RES:Rescheduling_interrupts
      2193 ±  8%     -26.4%       1613 ± 19%  interrupts.CPU73.CAL:Function_call_interrupts
    401633           -37.3%     251932        interrupts.CPU73.LOC:Local_timer_interrupts
    948.17 ±  9%     -36.2%     604.57 ±  9%  interrupts.CPU73.RES:Rescheduling_interrupts
      2082           -16.6%       1736 ±  5%  interrupts.CPU74.CAL:Function_call_interrupts
    401660           -37.3%     251876        interrupts.CPU74.LOC:Local_timer_interrupts
    918.33 ± 13%     -34.9%     597.43 ±  4%  interrupts.CPU74.RES:Rescheduling_interrupts
      2069 ±  2%     -14.9%       1761 ±  9%  interrupts.CPU75.CAL:Function_call_interrupts
    401603           -37.3%     251789        interrupts.CPU75.LOC:Local_timer_interrupts
    866.00 ±  6%     -29.7%     608.71 ±  6%  interrupts.CPU75.RES:Rescheduling_interrupts
    401847           -37.3%     251928        interrupts.CPU76.LOC:Local_timer_interrupts
    934.33 ±  6%     -34.1%     615.71 ±  7%  interrupts.CPU76.RES:Rescheduling_interrupts
      2073 ±  2%     -15.3%       1757 ±  7%  interrupts.CPU77.CAL:Function_call_interrupts
    401647           -37.3%     251841        interrupts.CPU77.LOC:Local_timer_interrupts
    876.83 ±  5%     -30.8%     607.14 ±  8%  interrupts.CPU77.RES:Rescheduling_interrupts
      2107 ±  3%     -18.3%       1721 ±  7%  interrupts.CPU78.CAL:Function_call_interrupts
    401649           -37.3%     251893        interrupts.CPU78.LOC:Local_timer_interrupts
    950.50 ±  8%     -39.0%     579.43 ±  7%  interrupts.CPU78.RES:Rescheduling_interrupts
      2137 ±  2%     -18.8%       1734 ±  7%  interrupts.CPU79.CAL:Function_call_interrupts
    401672           -37.3%     251888        interrupts.CPU79.LOC:Local_timer_interrupts
    401425           -37.3%     251856        interrupts.CPU8.LOC:Local_timer_interrupts
      1140 ± 21%     -36.6%     723.00 ± 12%  interrupts.CPU8.RES:Rescheduling_interrupts
      2134 ±  7%     -17.5%       1761 ±  4%  interrupts.CPU80.CAL:Function_call_interrupts
    401664           -37.3%     251877        interrupts.CPU80.LOC:Local_timer_interrupts
    890.17 ±  8%     -33.4%     593.29 ±  5%  interrupts.CPU80.RES:Rescheduling_interrupts
    401760           -37.3%     251899        interrupts.CPU81.LOC:Local_timer_interrupts
    926.50 ±  8%     -31.8%     631.43 ± 11%  interrupts.CPU81.RES:Rescheduling_interrupts
      2163 ± 10%     -19.2%       1748 ±  8%  interrupts.CPU82.CAL:Function_call_interrupts
    401574           -37.3%     251849        interrupts.CPU82.LOC:Local_timer_interrupts
    882.33 ±  9%     -31.4%     604.86 ±  9%  interrupts.CPU82.RES:Rescheduling_interrupts
      2171 ±  5%     -19.9%       1739 ±  5%  interrupts.CPU83.CAL:Function_call_interrupts
    401660           -37.3%     251895        interrupts.CPU83.LOC:Local_timer_interrupts
    936.67 ±  6%     -37.5%     585.14 ±  5%  interrupts.CPU83.RES:Rescheduling_interrupts
      2114           -18.1%       1732 ±  7%  interrupts.CPU84.CAL:Function_call_interrupts
    401625           -37.3%     251919        interrupts.CPU84.LOC:Local_timer_interrupts
    975.50 ± 17%     -39.6%     588.86 ±  5%  interrupts.CPU84.RES:Rescheduling_interrupts
      2123 ±  3%     -18.0%       1740 ±  5%  interrupts.CPU85.CAL:Function_call_interrupts
    401702           -37.3%     251953        interrupts.CPU85.LOC:Local_timer_interrupts
    885.17 ±  7%     -35.1%     574.86 ±  6%  interrupts.CPU85.RES:Rescheduling_interrupts
    401653           -37.3%     251938        interrupts.CPU86.LOC:Local_timer_interrupts
      2078 ±  4%     -18.9%       1686 ±  7%  interrupts.CPU87.CAL:Function_call_interrupts
    401520           -37.3%     251897        interrupts.CPU87.LOC:Local_timer_interrupts
    856.17 ±  6%     -34.2%     563.29 ±  4%  interrupts.CPU87.RES:Rescheduling_interrupts
    401534           -37.3%     251752        interrupts.CPU9.LOC:Local_timer_interrupts
      1095 ± 14%     -38.5%     673.29 ±  5%  interrupts.CPU9.RES:Rescheduling_interrupts
  35338709           -37.3%   22159984        interrupts.LOC:Local_timer_interrupts
     92311           -34.8%      60163        interrupts.RES:Rescheduling_interrupts
     35.82           -35.8        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     34.81           -34.8        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     32.01           -32.0        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
     50.44           -29.7       20.69        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     27.55           -26.6        0.93 ±  4%  perf-profile.calltrace.cycles-pp.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     15.86 ±  2%     -15.9        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     15.69 ±  2%     -15.7        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     11.03           -11.0        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
     79.82            -9.8       70.04        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      8.94 ±  3%      -8.9        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end.generic_perform_write
      8.08            -8.1        0.00        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     86.70            -7.5       79.21        perf-profile.calltrace.cycles-pp.new_sync_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.40            -7.4        0.00        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end.generic_perform_write
     86.29            -7.4       78.90        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write.do_syscall_64
      7.00 ±  3%      -7.0        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      6.80 ±  4%      -6.8        0.00        perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.ext4_da_write_end
      6.16 ±  4%      -6.2        0.00        perf-profile.calltrace.cycles-pp.do_raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      3.47 ±  9%      -0.9        2.56 ±  7%  perf-profile.calltrace.cycles-pp.do_raw_read_unlock._raw_read_unlock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb
      2.55 ±  8%      -0.5        2.08 ±  6%  perf-profile.calltrace.cycles-pp.lock_acquire._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb
      2.16 ±  9%      -0.4        1.75 ±  6%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire._raw_read_lock.start_this_handle.jbd2__journal_start
      1.82 ±  5%      -0.3        1.56 ±  3%  perf-profile.calltrace.cycles-pp.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write
      1.82 ±  5%      -0.3        1.56 ±  2%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_update_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter
      0.59 ±  6%      -0.2        0.38 ± 63%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb
      1.32 ±  4%      -0.1        1.20 ±  3%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_update_time.file_update_time.ext4_write_checks
      0.77 ±  4%      -0.1        0.65 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.fs_reclaim_acquire.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      0.96 ±  4%      -0.1        0.87 ±  3%  perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_update_time.file_update_time
      0.93 ±  5%      -0.1        0.85 ±  3%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.60 ±  5%      +0.3        0.89 ±  4%  perf-profile.calltrace.cycles-pp.ext4_da_reserve_space.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.83 ±  4%      +0.3        1.16 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.aa_file_perm.common_file_perm.security_file_permission.vfs_write
      0.58 ±  2%      +0.3        0.92 ±  3%  perf-profile.calltrace.cycles-pp.syscall_enter_from_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.61 ±  4%      +0.4        0.97 ±  3%  perf-profile.calltrace.cycles-pp.lock_is_held_type.rcu_read_lock_any_held.vfs_write.ksys_write.do_syscall_64
      0.52 ±  3%      +0.4        0.89 ±  3%  perf-profile.calltrace.cycles-pp.__pagevec_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.67 ±  4%      +0.4        1.04 ±  5%  perf-profile.calltrace.cycles-pp.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.69 ±  4%      +0.4        1.07 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.72 ±  4%      +0.4        1.13 ±  3%  perf-profile.calltrace.cycles-pp.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.62 ±  4%      +0.4        1.03 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.free_buffer_head.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range
      0.92 ±  4%      +0.4        1.32 ±  4%  perf-profile.calltrace.cycles-pp.jbd2_write_access_granted.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      0.71 ±  4%      +0.4        1.13 ±  4%  perf-profile.calltrace.cycles-pp.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.64 ±  4%      +0.4        1.06 ±  3%  perf-profile.calltrace.cycles-pp.free_buffer_head.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode
      0.74 ±  4%      +0.5        1.20 ±  4%  perf-profile.calltrace.cycles-pp.__set_page_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end
      0.73 ±  4%      +0.5        1.19 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.75 ±  3%      +0.5        1.21 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      1.00 ±  4%      +0.5        1.47 ±  3%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.70 ±  5%      +0.5        1.18 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks
      0.97 ±  3%      +0.5        1.47 ±  4%  perf-profile.calltrace.cycles-pp.xas_descend.xas_load.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.78 ±  4%      +0.5        1.28 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.75 ±  4%      +0.5        1.27 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.77 ±  6%      +0.5        1.29 ±  5%  perf-profile.calltrace.cycles-pp.__find_get_block.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add_fn.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      0.00            +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.ext4_es_insert_delayed_block.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.do_sys_open.do_syscall_64
      0.88 ±  3%      +0.5        1.43 ±  3%  perf-profile.calltrace.cycles-pp.llseek
      0.00            +0.5        0.55 ±  5%  perf-profile.calltrace.cycles-pp.xa_get_order.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      0.00            +0.6        0.55 ±  3%  perf-profile.calltrace.cycles-pp.ext4_es_lookup_extent.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.creat64
      0.78 ±  3%      +0.6        1.34 ±  4%  perf-profile.calltrace.cycles-pp.__cancel_dirty_page.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode
      0.00            +0.6        0.57 ±  4%  perf-profile.calltrace.cycles-pp.___might_sleep.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.89 ±  3%      +0.6        1.46 ±  3%  perf-profile.calltrace.cycles-pp.rcu_read_lock_any_held.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.57 ±  4%  perf-profile.calltrace.cycles-pp.__ext4_handle_dirty_metadata.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.26 ±100%      +0.6        0.84 ±  3%  perf-profile.calltrace.cycles-pp.xas_start.xas_load.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.00            +0.6        0.58 ±  4%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.trace_hardirqs_on.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks
      0.00            +0.6        0.60 ±  4%  perf-profile.calltrace.cycles-pp.rcu_read_lock_sched_held.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.6        0.61 ±  4%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.82 ±  2%      +0.6        1.42 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.down_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.00            +0.6        0.61 ±  3%  perf-profile.calltrace.cycles-pp.lock_page_memcg.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end
      0.26 ±100%      +0.6        0.87 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.__pagevec_release.truncate_inode_pages_range.ext4_evict_inode.evict
      0.00            +0.6        0.64 ±  5%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.17 ±141%      +0.6        0.82 ±  4%  perf-profile.calltrace.cycles-pp.rcu_read_lock_held.xas_descend.xas_load.pagecache_get_page.grab_cache_page_write_begin
      0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.account_page_dirtied.__set_page_dirty.mark_buffer_dirty.__block_commit_write.block_write_end
      0.00            +0.7        0.66 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.jbd2_write_access_granted.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_reserve_inode_write
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
      1.27 ±  4%      +0.7        1.94 ±  4%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      0.00            +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.rcu_read_lock_sched_held.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.vfs_write.ksys_write.do_syscall_64
      0.00            +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.fs_reclaim_acquire.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.17 ±141%      +0.7        0.84 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.98 ±  6%      +0.7        1.66 ±  4%  perf-profile.calltrace.cycles-pp.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.lock_release.aa_file_perm.common_file_perm.security_file_permission.vfs_write
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.get_obj_cgroup_from_current.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers.create_empty_buffers
      0.84 ±  5%      +0.7        1.53 ±  4%  perf-profile.calltrace.cycles-pp.ext4_get_group_desc.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      1.82 ±  4%      +0.7        2.51 ±  3%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +0.7        0.69 ±  3%  perf-profile.calltrace.cycles-pp.copyin.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +0.7        0.69 ±  4%  perf-profile.calltrace.cycles-pp.lock_release.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.ext4_get_group_desc.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      1.83 ±  4%      +0.7        2.53 ±  4%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.08 ±223%      +0.7        0.79 ±  4%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page
      0.00            +0.7        0.71 ±  3%  perf-profile.calltrace.cycles-pp.lock_release.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks
      0.00            +0.7        0.73 ±  4%  perf-profile.calltrace.cycles-pp.lock_release.up_write.ext4_buffered_write_iter.new_sync_write.vfs_write
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.lock_release.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.98 ±  5%      +0.7        1.73 ±  4%  perf-profile.calltrace.cycles-pp.mem_cgroup_charge.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      0.00            +0.8        0.75 ±  3%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.lru_cache_add.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin
      0.00            +0.8        0.77 ±  4%  perf-profile.calltrace.cycles-pp.__lock_acquire.lock_acquire.down_write.ext4_buffered_write_iter.new_sync_write
      0.00            +0.8        0.79 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire._raw_spin_lock.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.memcg_slab_free_hook.kmem_cache_free.free_buffer_head.try_to_free_buffers.truncate_cleanup_page
      1.53 ±  4%      +0.8        2.37 ±  4%  perf-profile.calltrace.cycles-pp.xas_load.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +0.9        0.86 ±  4%  perf-profile.calltrace.cycles-pp.lock_acquire.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      1.56 ±  4%      +0.9        2.43 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers.create_empty_buffers.ext4_block_write_begin
      1.31 ±  3%      +0.9        2.20 ±  4%  perf-profile.calltrace.cycles-pp.down_write.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      2.30 ±  5%      +0.9        3.21 ±  4%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      0.00            +0.9        0.92 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      1.62 ±  4%      +0.9        2.54 ±  3%  perf-profile.calltrace.cycles-pp.alloc_buffer_head.alloc_page_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin
      1.64 ±  4%      +0.9        2.57 ±  3%  perf-profile.calltrace.cycles-pp.alloc_page_buffers.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.73 ±  4%      +1.0        2.69 ±  3%  perf-profile.calltrace.cycles-pp.aa_file_perm.common_file_perm.security_file_permission.vfs_write.ksys_write
      2.00 ±  4%      +1.0        2.96 ±  3%  perf-profile.calltrace.cycles-pp.common_file_perm.security_file_permission.vfs_write.ksys_write.do_syscall_64
      2.87 ±  5%      +1.0        3.84 ±  4%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1.92 ±  4%      +1.0        2.92 ±  3%  perf-profile.calltrace.cycles-pp.create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2.04 ±  4%      +1.0        3.08 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.64 ±  4%      +1.1        4.76 ±  3%  perf-profile.calltrace.cycles-pp.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write.vfs_write
      2.17 ±  3%      +1.1        3.30 ±  3%  perf-profile.calltrace.cycles-pp.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      1.76 ±  3%      +1.1        2.90 ±  3%  perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_page.truncate_inode_pages_range.ext4_evict_inode.evict
      1.72 ±  4%      +1.2        2.95 ±  4%  perf-profile.calltrace.cycles-pp.ktime_get_coarse_real_ts64.current_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter
      1.77 ±  4%      +1.3        3.04 ±  4%  perf-profile.calltrace.cycles-pp.current_time.file_update_time.ext4_write_checks.ext4_buffered_write_iter.new_sync_write
      2.11 ±  5%      +1.4        3.48 ±  4%  perf-profile.calltrace.cycles-pp.__add_to_page_cache_locked.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin
      3.78 ±  4%      +1.4        5.17 ±  3%  perf-profile.calltrace.cycles-pp.ext4_write_checks.ext4_buffered_write_iter.new_sync_write.vfs_write.ksys_write
      1.95 ±  5%      +1.4        3.39 ±  4%  perf-profile.calltrace.cycles-pp.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.93 ±  5%      +1.4        3.37 ±  4%  perf-profile.calltrace.cycles-pp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.00            +1.8        1.77 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      2.84 ±  4%      +1.9        4.71 ±  3%  perf-profile.calltrace.cycles-pp.add_to_page_cache_lru.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write
      3.43 ±  3%      +1.9        5.35 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.43 ±  3%      +1.9        5.35 ±  3%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.44 ±  3%      +1.9        5.36 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      3.44 ±  3%      +1.9        5.36 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.44 ±  3%      +1.9        5.36 ±  3%  perf-profile.calltrace.cycles-pp.__close
      0.00            +2.1        2.13 ±  6%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      3.27 ±  3%      +2.2        5.43 ±  3%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dput
      3.38 ±  3%      +2.2        5.60 ±  3%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dput.__fput
      3.39 ±  3%      +2.2        5.61 ±  3%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dput.__fput.task_work_run
      3.40 ±  3%      +2.2        5.63 ±  3%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_prepare
      3.41 ±  3%      +2.2        5.65 ±  3%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.42 ±  3%      +2.2        5.66 ±  3%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.43 ±  3%      +2.2        5.67 ±  3%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.12 ±  4%      +2.4        6.52        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      3.24 ±  5%      +2.5        5.69 ±  2%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00            +2.9        2.91 ±  7%  perf-profile.calltrace.cycles-pp._raw_read_unlock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +3.0        2.96 ±  3%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end.generic_perform_write
      0.00            +3.1        3.05 ±  5%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      0.00            +3.5        3.50 ±  3%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +3.5        3.52 ±  3%  perf-profile.calltrace.cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +3.5        3.54 ±  6%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      0.00            +3.9        3.88 ±  5%  perf-profile.calltrace.cycles-pp.do_raw_read_lock.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      8.45            +4.7       13.16        perf-profile.calltrace.cycles-pp.pagecache_get_page.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      8.53            +4.7       13.27        perf-profile.calltrace.cycles-pp.grab_cache_page_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00            +7.6        7.64 ±  3%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00            +7.8        7.78 ±  3%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +10.6       10.60        perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.86 ±  5%     +18.8       19.63        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      0.00           +21.2       21.21        perf-profile.calltrace.cycles-pp.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.00           +22.0       22.01        perf-profile.calltrace.cycles-pp.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
      0.00           +32.7       32.70        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00           +41.5       41.46        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write
      0.00           +45.6       45.58        perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.new_sync_write.vfs_write
     50.45           -29.7       20.70        perf-profile.children.cycles-pp.ext4_da_write_begin
     27.63           -26.6        1.01        perf-profile.children.cycles-pp.ext4_da_write_end
     37.41           -14.4       23.03        perf-profile.children.cycles-pp.__ext4_journal_start_sb
     35.96           -13.8       22.20        perf-profile.children.cycles-pp.jbd2__journal_start
     33.07           -13.3       19.75        perf-profile.children.cycles-pp.start_this_handle
     79.88            -9.8       70.12        perf-profile.children.cycles-pp.generic_perform_write
     16.52 ±  2%      -8.3        8.19 ±  3%  perf-profile.children.cycles-pp.__ext4_journal_stop
     16.27 ±  2%      -8.2        8.05 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_stop
     86.75            -7.5       79.27        perf-profile.children.cycles-pp.new_sync_write
     86.29            -7.4       78.91        perf-profile.children.cycles-pp.ext4_buffered_write_iter
      9.26 ±  3%      -5.2        4.02 ±  4%  perf-profile.children.cycles-pp.stop_this_handle
     92.20            -4.4       87.83        perf-profile.children.cycles-pp.vfs_write
     92.37            -4.3       88.04        perf-profile.children.cycles-pp.ksys_write
      7.31 ±  2%      -3.8        3.47 ±  4%  perf-profile.children.cycles-pp.add_transaction_credits
      6.47 ±  4%      -2.1        4.40 ±  2%  perf-profile.children.cycles-pp.do_raw_read_lock
      4.46 ±  7%      -1.0        3.45 ±  4%  perf-profile.children.cycles-pp._raw_read_unlock
      3.89 ±  9%      -1.0        2.92 ±  5%  perf-profile.children.cycles-pp.do_raw_read_unlock
      0.93            -0.4        0.54        perf-profile.children.cycles-pp.ext4_journal_check_start
     99.09            -0.3       98.77        perf-profile.children.cycles-pp.do_syscall_64
      0.52 ±  2%      -0.3        0.19 ±  5%  perf-profile.children.cycles-pp.unlock_page
     99.17            -0.3       98.89        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.94 ±  2%      -0.3        1.68 ±  2%  perf-profile.children.cycles-pp.generic_update_time
      0.14 ± 16%      -0.1        0.09 ± 18%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.21 ±  5%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__brelse
      0.06 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.__slab_free
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.12 ±  5%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.up_read
      0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.uncharge_batch
      0.06 ±  6%      +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.crypto_shash_update
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge_pages
      0.05 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.trace_preempt_off
      0.05 ±  8%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.iov_iter_advance
      0.07            +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.12 ±  8%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.disk_rw
      0.20 ±  3%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.__might_sleep
      0.06 ±  6%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.06 ±  6%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__ext4_unlink
      0.09 ±  4%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.ext4_unlink
      0.06 ±  6%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.drain_obj_stock
      0.08            +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__ext4_new_inode
      0.10 ±  6%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.vfs_unlink
      0.09 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.rcu_core
      0.11 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_1
      0.12 ±  6%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__fget_light
      0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_invalidatepage
      0.02 ± 99%      +0.0        0.07 ±  4%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.07 ±  6%      +0.0        0.12        perf-profile.children.cycles-pp.__mod_node_page_state
      0.02 ± 99%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.12 ±  4%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.05 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_track_foreign_dirty_slowpath
      0.07 ±  5%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.xas_find_conflict
      0.12            +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.tracer_hardirqs_off
      0.09            +0.1        0.14        perf-profile.children.cycles-pp._raw_write_unlock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ext4_lookup
      0.96 ±  2%      +0.1        1.01        perf-profile.children.cycles-pp.up_write
      0.15 ±  5%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.14 ±  6%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.__fdget_pos
      0.08            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.__x64_sys_write
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.ext4_add_entry
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.do_sys_times
      0.00            +0.1        0.05 ±  6%  perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.01 ±223%      +0.1        0.06        perf-profile.children.cycles-pp.do_raw_spin_unlock
      0.07 ±  7%      +0.1        0.12 ±  2%  perf-profile.children.cycles-pp.xas_create
      0.10 ±  5%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.ksys_lseek
      0.21 ±  8%      +0.1        0.26        perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.04 ± 73%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.file_modified
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.tracer_preempt_off
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.mark_page_accessed
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.map_id_up
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.xas_alloc
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.xas_set_mark
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__ext4_read_dirblock
      0.01 ±223%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__rcu_read_lock
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.timestamp_truncate
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.open64
      0.07 ±  5%      +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.generic_write_checks
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__es_insert_extent
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ext4_free_inode
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.tracer_preempt_on
      0.01 ±223%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.00            +0.1        0.06 ± 10%  perf-profile.children.cycles-pp.times
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.__x64_sys_times
      0.00            +0.1        0.06 ±  5%  perf-profile.children.cycles-pp.memcg_check_events
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.16 ±  2%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.17 ±  3%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.iov_iter_fault_in_readable
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_bread
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_getblk
      0.10 ± 10%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.trace_preempt_on
      0.13 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.ext4_create
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.get_mem_cgroup_from_objcg
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.10 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.06 ± 11%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.cpuacct_charge
      0.09 ±  5%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.xas_find
      0.12 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__xa_set_mark
      0.17 ±  2%      +0.1        0.25        perf-profile.children.cycles-pp.rmqueue
      0.13 ±  5%      +0.1        0.21        perf-profile.children.cycles-pp.free_unref_page_list
      0.12 ±  8%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.08 ±  5%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.13 ±  5%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.refill_obj_stock
      0.11            +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.try_charge
      0.24 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.13 ±  5%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.in_lock_functions
      0.22 ±  3%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      0.21 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.memset_erms
      0.12 ±  4%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.uncharge_page
      0.19 ±  2%      +0.1        0.29        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.14 ±  2%      +0.1        0.24        perf-profile.children.cycles-pp._raw_write_lock
      0.18 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.lookup_open
      0.14 ±  3%      +0.1        0.24        perf-profile.children.cycles-pp._raw_spin_unlock_irq
      0.22 ±  3%      +0.1        0.33        perf-profile.children.cycles-pp.down_read
      0.08 ±  7%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.17 ±  2%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.19 ±  5%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.__entry_text_start
      0.16 ±  3%      +0.1        0.27 ±  2%  perf-profile.children.cycles-pp.xas_store
      1.24            +0.1        1.35        perf-profile.children.cycles-pp.fs_reclaim_acquire
      0.32 ±  5%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.ext4_inode_csum
      0.13 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.tracer_hardirqs_on
      0.16 ±  4%      +0.1        0.29        perf-profile.children.cycles-pp.__rcu_read_unlock
      0.24 ±  4%      +0.1        0.37 ±  2%  perf-profile.children.cycles-pp.debug_smp_processor_id
      0.36 ±  5%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.21 ± 11%      +0.1        0.34 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.26 ±  9%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.29 ±  3%      +0.1        0.43        perf-profile.children.cycles-pp.__dquot_alloc_space
      0.24 ±  2%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.ext4_fc_track_inode
      0.24 ±  3%      +0.1        0.38        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.41 ± 10%      +0.2        0.56 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.29 ±  2%      +0.2        0.44 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.24 ±  3%      +0.2        0.39 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.21 ± 15%      +0.2        0.36 ±  8%  perf-profile.children.cycles-pp.unlink
      0.24 ±  2%      +0.2        0.40        perf-profile.children.cycles-pp.mem_cgroup_uncharge_list
      0.20            +0.2        0.36 ±  2%  perf-profile.children.cycles-pp.unaccount_page_cache_page
      0.32 ±  2%      +0.2        0.49 ±  3%  perf-profile.children.cycles-pp.find_held_lock
      0.22 ± 17%      +0.2        0.38 ±  9%  perf-profile.children.cycles-pp.do_unlinkat
      0.39            +0.2        0.58        perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.42            +0.2        0.61        perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.15 ±  4%      +0.2        0.35 ±  2%  perf-profile.children.cycles-pp.lock_page_lruvec_irqsave
      0.38            +0.2        0.58        perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.53 ± 10%      +0.2        0.73 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.79 ± 10%      +0.2        1.01 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.84 ± 10%      +0.2        1.07 ±  2%  perf-profile.children.cycles-pp.tick_sched_timer
      0.78 ± 10%      +0.2        1.00 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.33 ±  3%      +0.2        0.56        perf-profile.children.cycles-pp.preempt_count_add
      1.22 ±  8%      +0.2        1.45 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.43 ±  2%      +0.2        0.66        perf-profile.children.cycles-pp.lockdep_hardirqs_on
      0.31 ±  3%      +0.2        0.55        perf-profile.children.cycles-pp.account_page_cleaned
      0.31 ±  6%      +0.2        0.56 ±  3%  perf-profile.children.cycles-pp.creat64
      0.18 ± 33%      +0.2        0.43 ± 12%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.34 ±  2%      +0.3        0.60        perf-profile.children.cycles-pp.xa_get_order
      0.48            +0.3        0.74        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.55 ±  6%      +0.3        1.80 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.49            +0.3        0.75        perf-profile.children.cycles-pp.copyin
      1.60 ±  6%      +0.3        1.87 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.38 ±  5%      +0.3        0.65 ±  2%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.38 ±  8%      +0.3        0.65 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      0.37 ±  7%      +0.3        0.65 ±  2%  perf-profile.children.cycles-pp.path_openat
      0.38            +0.3        0.65        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.39 ±  6%      +0.3        0.67 ±  2%  perf-profile.children.cycles-pp.do_sys_open
      0.39 ±  6%      +0.3        0.67 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      0.46            +0.3        0.75        perf-profile.children.cycles-pp.trace_hardirqs_off_finish
      0.45            +0.3        0.74        perf-profile.children.cycles-pp.trace_hardirqs_on_prepare
      0.49 ±  2%      +0.3        0.78 ±  2%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.42            +0.3        0.71        perf-profile.children.cycles-pp.account_page_dirtied
      0.66 ±  2%      +0.3        0.96        perf-profile.children.cycles-pp.lockdep_hardirqs_off
      0.45 ±  2%      +0.3        0.76        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.45 ±  3%      +0.3        0.76        perf-profile.children.cycles-pp.preempt_count_sub
      0.39 ±  2%      +0.3        0.70        perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.94 ±  5%      +0.3        2.25        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.82 ±  5%      +0.3        2.13        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.52            +0.3        0.84        perf-profile.children.cycles-pp.__pagevec_lru_add
      0.64            +0.3        0.96        perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.74 ±  2%      +0.3        1.07        perf-profile.children.cycles-pp.trace_hardirqs_off
      0.70 ±  2%      +0.3        1.04 ±  2%  perf-profile.children.cycles-pp.validate_chain
      1.89            +0.3        2.24        perf-profile.children.cycles-pp.kmem_cache_free
      0.49 ±  2%      +0.4        0.86        perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.57 ±  3%      +0.4        0.97        perf-profile.children.cycles-pp.release_pages
      0.73            +0.4        1.14        perf-profile.children.cycles-pp.__alloc_pages
      0.56 ±  2%      +0.4        0.97        perf-profile.children.cycles-pp.__pagevec_release
      0.60 ±  2%      +0.4        1.01 ±  2%  perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.78            +0.4        1.22        perf-profile.children.cycles-pp.lru_cache_add
      1.05            +0.5        1.51        perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.77 ±  2%      +0.5        1.23        perf-profile.children.cycles-pp.iov_iter_copy_from_user_atomic
      0.68 ±  2%      +0.5        1.15 ±  2%  perf-profile.children.cycles-pp.free_buffer_head
      0.70            +0.5        1.17 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock
      0.69            +0.5        1.16        perf-profile.children.cycles-pp.xas_start
      0.70            +0.5        1.18        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.76            +0.5        1.24        perf-profile.children.cycles-pp.lock_page_memcg
      0.80            +0.5        1.29        perf-profile.children.cycles-pp.__set_page_dirty
      1.00            +0.5        1.51        perf-profile.children.cycles-pp.mark_held_locks
      1.15            +0.5        1.66        perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      1.14            +0.5        1.68        perf-profile.children.cycles-pp.__this_cpu_preempt_check
      0.91 ±  3%      +0.6        1.48 ±  3%  perf-profile.children.cycles-pp.llseek
      0.93            +0.6        1.52        perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      1.01 ±  2%      +0.6        1.61        perf-profile.children.cycles-pp.rcu_read_lock_any_held
      0.83            +0.6        1.44        perf-profile.children.cycles-pp.__cancel_dirty_page
      0.94 ±  3%      +0.6        1.56        perf-profile.children.cycles-pp.__find_get_block
      4.12            +0.7        4.79        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.26            +0.7        1.95        perf-profile.children.cycles-pp.xas_descend
      2.01            +0.7        2.72        perf-profile.children.cycles-pp.match_held_lock
      1.46            +0.7        2.21        perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.97 ±  2%      +0.8        1.74        perf-profile.children.cycles-pp.ext4_get_group_desc
      1.94            +0.8        2.71        perf-profile.children.cycles-pp.ext4_da_map_blocks
      1.95            +0.8        2.73        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      1.18 ±  3%      +0.8        1.96        perf-profile.children.cycles-pp.__getblk_gfp
      1.06 ±  2%      +0.8        1.87        perf-profile.children.cycles-pp.mem_cgroup_charge
      1.21 ±  2%      +0.8        2.03        perf-profile.children.cycles-pp._raw_spin_lock
      2.43 ±  5%      +0.9        3.28 ±  2%  perf-profile.children.cycles-pp.debug_lockdep_rcu_enabled
      1.74            +0.9        2.62        perf-profile.children.cycles-pp.mark_lock
      1.77            +0.9        2.70        perf-profile.children.cycles-pp.lockdep_hardirqs_on_prepare
      3.92            +0.9        4.86        perf-profile.children.cycles-pp.___might_sleep
      1.41            +1.0        2.39        perf-profile.children.cycles-pp.down_write
      1.82            +1.0        2.81        perf-profile.children.cycles-pp.trace_hardirqs_on
      1.97            +1.0        2.96        perf-profile.children.cycles-pp.aa_file_perm
      2.64            +1.0        3.63        perf-profile.children.cycles-pp.ext4_do_update_inode
      1.73            +1.0        2.75        perf-profile.children.cycles-pp.alloc_buffer_head
      1.75            +1.0        2.78        perf-profile.children.cycles-pp.alloc_page_buffers
      2.72            +1.0        3.77        perf-profile.children.cycles-pp.__block_commit_write
      2.75            +1.1        3.80        perf-profile.children.cycles-pp.block_write_end
      3.28            +1.1        4.34        perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      2.14            +1.1        3.21        perf-profile.children.cycles-pp.common_file_perm
      2.13            +1.1        3.22        perf-profile.children.cycles-pp.mark_buffer_dirty
      2.04            +1.1        3.15        perf-profile.children.cycles-pp.create_empty_buffers
      2.18            +1.1        3.32        perf-profile.children.cycles-pp.security_file_permission
      1.93            +1.1        3.08        perf-profile.children.cycles-pp.xas_load
      3.88            +1.2        5.06        perf-profile.children.cycles-pp.file_update_time
      1.88            +1.2        3.13        perf-profile.children.cycles-pp.try_to_free_buffers
      2.31            +1.2        3.56        perf-profile.children.cycles-pp.truncate_cleanup_page
      1.81            +1.3        3.06        perf-profile.children.cycles-pp.rcu_read_lock_held
      2.34            +1.3        3.63        perf-profile.children.cycles-pp.rcu_is_watching
      4.03            +1.3        5.34        perf-profile.children.cycles-pp.ext4_write_checks
      1.85            +1.4        3.21        perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      2.62            +1.4        3.98        perf-profile.children.cycles-pp.rcu_lockdep_current_cpu_online
      1.90            +1.4        3.30        perf-profile.children.cycles-pp.current_time
      2.25            +1.5        3.77        perf-profile.children.cycles-pp.__add_to_page_cache_locked
      2.24 ±  2%      +1.6        3.84        perf-profile.children.cycles-pp.__ext4_get_inode_loc
      2.25 ±  2%      +1.6        3.86        perf-profile.children.cycles-pp.ext4_get_inode_loc
      3.44 ±  3%      +1.9        5.36 ±  3%  perf-profile.children.cycles-pp.__close
      3.04            +2.0        5.00        perf-profile.children.cycles-pp.add_to_page_cache_lru
      3.49            +2.0        5.52        perf-profile.children.cycles-pp.truncate_inode_pages_range
      3.61            +2.1        5.69        perf-profile.children.cycles-pp.ext4_evict_inode
      3.62            +2.1        5.70        perf-profile.children.cycles-pp.evict
      3.63            +2.1        5.72        perf-profile.children.cycles-pp.__dentry_kill
      3.66            +2.1        5.76        perf-profile.children.cycles-pp.task_work_run
      3.65            +2.1        5.75        perf-profile.children.cycles-pp.__fput
      3.66            +2.1        5.77        perf-profile.children.cycles-pp.dput
      4.41            +2.2        6.56        perf-profile.children.cycles-pp.ext4_block_write_begin
      3.83            +2.2        5.99        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.72            +2.4        6.08        perf-profile.children.cycles-pp.ext4_reserve_inode_write
      8.48 ±  2%      +2.7       11.17        perf-profile.children.cycles-pp.__lock_acquire
      4.73            +2.7        7.48        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      5.89            +3.1        8.95        perf-profile.children.cycles-pp.rcu_read_lock_held_common
      6.99            +3.5       10.45        perf-profile.children.cycles-pp.lock_release
      7.02            +3.5       10.53        perf-profile.children.cycles-pp.check_preemption_disabled
      7.37            +3.8       11.13        perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      8.56            +4.8       13.34        perf-profile.children.cycles-pp.grab_cache_page_write_begin
      8.54            +4.8       13.33        perf-profile.children.cycles-pp.pagecache_get_page
     12.62            +5.4       18.00        perf-profile.children.cycles-pp.lock_is_held_type
     12.72            +5.7       18.41        perf-profile.children.cycles-pp.rcu_read_lock_sched_held
     14.94 ±  2%      +5.9       20.83        perf-profile.children.cycles-pp.lock_acquire
      8.84           +25.2       34.00        perf-profile.children.cycles-pp.ext4_dirty_inode
     10.14           +33.1       43.26        perf-profile.children.cycles-pp.__mark_inode_dirty
     11.07           +34.5       45.59        perf-profile.children.cycles-pp.generic_write_end
     10.65 ±  3%      -5.6        5.04 ±  4%  perf-profile.self.cycles-pp.start_this_handle
      8.63 ±  3%      -5.0        3.58 ±  5%  perf-profile.self.cycles-pp.stop_this_handle
      7.17 ±  2%      -3.8        3.40 ±  4%  perf-profile.self.cycles-pp.add_transaction_credits
      5.45 ±  2%      -2.7        2.71 ±  3%  perf-profile.self.cycles-pp.jbd2_journal_stop
      6.35 ±  4%      -2.0        4.31 ±  2%  perf-profile.self.cycles-pp.do_raw_read_lock
      3.81 ±  9%      -0.9        2.86 ±  5%  perf-profile.self.cycles-pp.do_raw_read_unlock
      0.50 ±  3%      -0.3        0.18 ±  4%  perf-profile.self.cycles-pp.unlock_page
      0.47 ±  5%      -0.3        0.21 ±  2%  perf-profile.self.cycles-pp.up_write
      0.49 ±  3%      -0.2        0.25 ±  4%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.55 ±  3%      -0.2        0.40 ±  4%  perf-profile.self.cycles-pp.do_raw_spin_lock
      0.31 ±  6%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.new_sync_write
      0.25 ± 11%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.__ext4_journal_stop
      0.29 ±  2%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.ext4_journal_check_start
      0.28 ±  2%      -0.1        0.19 ±  5%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.40 ±  4%      -0.1        0.32 ±  3%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.49 ±  2%      -0.1        0.43 ±  5%  perf-profile.self.cycles-pp.__block_commit_write
      0.15 ±  5%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.89 ±  2%      -0.1        0.84 ±  3%  perf-profile.self.cycles-pp.pagecache_get_page
      0.24 ±  7%      -0.0        0.19 ±  5%  perf-profile.self.cycles-pp.jbd2__journal_start
      0.11 ±  7%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.truncate_cleanup_page
      0.21 ±  4%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__brelse
      0.13 ±  2%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.block_invalidatepage
      0.08 ±  5%      -0.0        0.06 ± 10%  perf-profile.self.cycles-pp.__ext4_journal_start_sb
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.release_pages
      0.07 ±  7%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.07            +0.0        0.09 ±  3%  perf-profile.self.cycles-pp.ksys_write
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.__mod_node_page_state
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.iov_iter_fault_in_readable
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.xas_load
      0.06 ±  9%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.06 ±  9%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.crypto_shash_update
      0.38 ±  2%      +0.0        0.41 ±  3%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.09            +0.0        0.12 ±  2%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.10 ±  8%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.disk_rw
      0.05 ±  8%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.05 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.iov_iter_advance
      0.04 ± 44%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.llseek
      0.06 ±  9%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.33 ±  4%      +0.0        0.36 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.16 ±  4%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.__might_sleep
      0.06 ±  7%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.57            +0.0        0.60        perf-profile.self.cycles-pp.ext4_do_update_inode
      0.06 ±  8%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.05 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.09 ±  6%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.06 ±  8%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.04 ± 44%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.trace_preempt_off
      0.07 ±  5%      +0.0        0.11 ±  8%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.11 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.trace_hardirqs_off
      0.10 ±  4%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.memcg_slab_free_hook
      0.25 ±  3%      +0.0        0.29 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.12 ±  4%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.tracer_hardirqs_off
      0.20 ±  9%      +0.0        0.24        perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      0.08 ±  5%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.trace_hardirqs_on_prepare
      0.10 ±  4%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__rcu_read_lock
      0.09 ±  5%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__entry_text_start
      0.07 ±  9%      +0.0        0.12 ±  2%  perf-profile.self.cycles-pp.trace_preempt_on
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.current_time
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tracer_preempt_on
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.do_raw_spin_unlock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_write
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mark_page_accessed
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.map_id_up
      0.08 ±  6%      +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.05 ±  6%  perf-profile.self.cycles-pp.ext4_inode_csum_set
      0.00            +0.1        0.05 ±  6%  perf-profile.self.cycles-pp.ext4_fc_track_inode
      0.00            +0.1        0.05 ±  6%  perf-profile.self.cycles-pp.xas_store
      0.15 ±  5%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.down_write
      0.08 ±  4%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.trace_hardirqs_off_finish
      0.10 ±  4%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited
      0.09            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.generic_write_end
      0.09 ± 17%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      0.00            +0.1        0.06 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.02 ±141%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.09 ±  4%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.in_lock_functions
      0.01 ±223%      +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.06 ±  5%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.00            +0.1        0.06 ±  5%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.generic_write_checks
      0.14 ±  6%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.generic_perform_write
      0.13 ±  5%      +0.1        0.19 ±  6%  perf-profile.self.cycles-pp.common_file_perm
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.01 ±223%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.file_update_time
      0.01 ±223%      +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.ext4_get_group_desc
      0.12 ±  8%      +0.1        0.19 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.10 ±  4%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.12 ± 10%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.00            +0.1        0.08 ±  9%  perf-profile.self.cycles-pp.security_file_permission
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__ext4_mark_inode_dirty
      0.17 ±  4%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.trace_hardirqs_on
      0.20 ±  2%      +0.1        0.29        perf-profile.self.cycles-pp.memset_erms
      0.13 ±  2%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.rcu_read_lock_held
      0.31 ±  4%      +0.1        0.40 ±  3%  perf-profile.self.cycles-pp.lockdep_hardirqs_off
      0.21 ±  2%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.11 ±  4%      +0.1        0.21        perf-profile.self.cycles-pp.tracer_hardirqs_on
      0.20 ±  2%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.debug_smp_processor_id
      0.08 ±  6%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.14 ±  2%      +0.1        0.25        perf-profile.self.cycles-pp.iov_iter_copy_from_user_atomic
      0.17 ±  4%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.15 ±  3%      +0.1        0.26        perf-profile.self.cycles-pp.__rcu_read_unlock
      0.16 ±  6%      +0.1        0.27 ±  2%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.21            +0.1        0.32 ±  4%  perf-profile.self.cycles-pp.find_held_lock
      0.27 ±  4%      +0.1        0.40        perf-profile.self.cycles-pp.lockdep_hardirqs_on
      0.26 ±  9%      +0.1        0.40 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.60            +0.2        0.77        perf-profile.self.cycles-pp.___might_sleep
      0.26 ±  4%      +0.2        0.44 ±  2%  perf-profile.self.cycles-pp.preempt_count_add
      0.36 ±  2%      +0.2        0.55        perf-profile.self.cycles-pp.mark_held_locks
      0.28 ±  2%      +0.2        0.48 ±  2%  perf-profile.self.cycles-pp.preempt_count_sub
      0.36 ±  6%      +0.2        0.56 ±  2%  perf-profile.self.cycles-pp.__find_get_block
      0.44            +0.2        0.68 ±  2%  perf-profile.self.cycles-pp.__this_cpu_preempt_check
      0.40 ±  3%      +0.2        0.64        perf-profile.self.cycles-pp.lockdep_hardirqs_on_prepare
      0.47            +0.2        0.72        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      0.68 ±  2%      +0.3        1.00 ±  2%  perf-profile.self.cycles-pp.validate_chain
      0.68 ±  2%      +0.4        1.10        perf-profile.self.cycles-pp.rcu_read_lock_held_common
      1.06 ±  2%      +0.4        1.49        perf-profile.self.cycles-pp.rcu_read_lock_sched_held
      1.60            +0.5        2.13        perf-profile.self.cycles-pp.match_held_lock
      2.14 ±  6%      +0.7        2.83 ±  2%  perf-profile.self.cycles-pp.debug_lockdep_rcu_enabled
      1.60            +0.8        2.39        perf-profile.self.cycles-pp.lock_acquire
      1.39            +0.8        2.19        perf-profile.self.cycles-pp.rcu_is_watching
      1.60            +0.8        2.42        perf-profile.self.cycles-pp.lock_release
      1.68            +0.8        2.52        perf-profile.self.cycles-pp.mark_lock
      1.86            +1.0        2.82        perf-profile.self.cycles-pp.rcu_lockdep_current_cpu_online
      6.72 ±  3%      +1.8        8.54        perf-profile.self.cycles-pp.__lock_acquire
      6.59            +3.3        9.86        perf-profile.self.cycles-pp.check_preemption_disabled
      7.53            +3.3       10.83        perf-profile.self.cycles-pp.lock_is_held_type
      0.04 ± 63%    +580.7%       0.27 ± 35%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.82 ± 10%     -55.8%       2.57 ± 50%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      7.03 ± 86%     -71.7%       1.99 ± 65%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.filemap_map_pages.do_fault
      0.04 ± 65%    +620.3%       0.32 ± 17%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      0.06 ±153%    +478.3%       0.36 ± 30%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.delete_from_page_cache_batch.truncate_inode_pages_range
      0.00 ±223%    +2e+05%       0.34 ± 31%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.release_pages.__pagevec_release
      0.00 ±223%  +29471.4%       0.05 ±214%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.lru_add_drain.__pagevec_release.truncate_inode_pages_range
      0.05 ±105%    +334.7%       0.21 ± 46%  perf-sched.sch_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.try_to_wake_up.wake_up_q.rwsem_wake
      0.12 ±136%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
      0.25 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
      0.00 ±142%   +9506.6%       0.21 ±169%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__rcu_read_unlock.kmem_cache_alloc
      0.02 ±223%   +1200.0%       0.29 ± 70%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.find_lock_entries.truncate_inode_pages_range
      0.04 ±223%   +1297.5%       0.53 ± 47%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.free_unref_page_list.release_pages
      0.22 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
      0.01 ±220%   +2194.2%       0.29 ± 43%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.free_buffer_head
      0.01 ± 29%     -79.0%       0.00 ±121%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ksys_lseek.do_syscall_64
      0.20 ± 38%     -39.3%       0.12 ± 23%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
      0.04 ±206%    +589.0%       0.27 ± 47%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.lock_page_memcg
      0.01 ±218%   +5776.8%       0.47 ± 27%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.uncharge_page
      0.63 ±112%     -83.0%       0.11 ± 58%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.ext4_get_group_desc
      0.00 ±159%  +90732.7%       1.06 ±214%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.mem_cgroup_uncharge_list
      0.01 ±223%   +6577.7%       0.36 ± 50%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.memcg_slab_free_hook
      0.23 ± 85%     -65.3%       0.08 ± 61%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.mark_buffer_dirty.__block_commit_write
      0.07 ±104%    +429.9%       0.35 ± 33%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memcg_slab_free_hook.kmem_cache_free
      0.13 ± 63%     -75.1%       0.03 ±140%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
      0.00 ±223%    +1e+05%       0.34 ± 28%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.page_counter_cancel.page_counter_uncharge
      0.00 ±152%  +81642.9%       0.41 ± 97%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.uncharge_batch.mem_cgroup_uncharge_list
      2.40 ±210%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
      0.00 ±223%   +1378.6%       0.01 ± 65%  perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.refill_obj_stock.memcg_slab_free_hook
      0.05 ±199%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.unlock_page.ext4_da_write_begin
      0.25 ±104%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
      0.15 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
      0.01 ±213%   +2915.6%       0.28 ± 53%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
      0.00 ±165%  +52785.7%       0.35 ±102%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_releasepage.truncate_cleanup_page.truncate_inode_pages_range
      0.00 ±152%  +56842.9%       0.28 ± 77%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.free_pcp_prepare.free_unref_page_list.release_pages
      0.20 ±128%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      0.34 ±106%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
      0.00 ± 82%    +339.3%       0.01 ± 38%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.__mem_cgroup_charge.mem_cgroup_charge
      0.31 ± 92%     -73.0%       0.08 ± 54%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
      0.28 ± 51%     -50.7%       0.14 ± 51%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.start_this_handle.jbd2__journal_start
      0.00 ±152%  +61042.9%       0.31 ± 42%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.uncharge_page.mem_cgroup_uncharge_list
      0.00 ± 46%   +3965.8%       0.16 ± 65%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.__alloc_pages.pagecache_get_page
      2.88 ±205%     -97.0%       0.09 ± 90%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.aa_file_perm.common_file_perm
      0.03 ±223%   +1156.1%       0.36 ± 48%  perf-sched.sch_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.memcg_slab_free_hook.kmem_cache_free
      0.01 ±223%  +14013.5%       0.82 ±124%  perf-sched.sch_delay.avg.ms.rwsem_down_read_slowpath.down_read.rmap_walk_anon.remove_migration_ptes
      0.01 ±223%  +31475.0%       2.10 ± 69%  perf-sched.sch_delay.avg.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      5.21 ± 68%    +561.8%      34.50 ± 76%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     17.79 ±  7%     -39.6%      10.74 ± 31%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      9.11 ± 68%     -67.4%       2.97 ±118%  perf-sched.sch_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.page_vma_mapped_walk.remove_migration_pte
      0.02 ± 65%  +40927.8%       9.78 ± 18%  perf-sched.sch_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.release_pages.__pagevec_release
      0.00 ±223%  +47050.6%       0.86 ±232%  perf-sched.sch_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.lru_add_drain.__pagevec_release.truncate_inode_pages_range
      2.45 ±141%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
     17.09 ±103%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
     10.10 ± 15%     -54.3%       4.61 ± 89%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_journal_check_start.__ext4_journal_start_sb
      8.62 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
      0.45 ±219%   +1399.4%       6.77 ± 15%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.free_buffer_head
      0.04 ±  9%     -67.1%       0.01 ±116%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ksys_lseek.do_syscall_64
      1.26 ±216%    +702.4%      10.12 ± 32%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.lock_page_memcg
      0.32 ±220%   +2338.4%       7.81 ± 13%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.uncharge_page
     13.84 ± 33%     -46.4%       7.42 ± 42%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.kmem_cache_alloc
      0.02 ±100%   +4246.5%       0.75 ±231%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.mem_cgroup_charge
      0.12 ±223%   +5536.4%       6.53 ± 43%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.memcg_slab_free_hook
      8.84 ± 62%     -75.8%       2.14 ±159%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
      0.01 ±223%  +95426.3%       6.05 ± 14%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.page_counter_cancel.page_counter_uncharge
      0.00 ±223%  +1.5e+05%       7.37 ± 11%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.refill_obj_stock.memcg_slab_free_hook
    106.45 ± 61%     -74.8%      26.77 ± 82%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
      0.01 ±223%  +31947.1%       1.82 ±154%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.truncate_cleanup_page.truncate_inode_pages_range
      0.01 ±146%  +47539.7%       3.89 ± 87%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.uncharge_batch.mem_cgroup_uncharge_list
    637.62 ±214%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
      0.01 ±223%  +37942.9%       1.90 ±240%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.kmem_cache_free.free_buffer_head
      0.00 ±223%   +1361.4%       0.05 ± 36%  perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.refill_obj_stock.memcg_slab_free_hook
      0.67 ±210%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.unlock_page.ext4_da_write_begin
     36.32 ±166%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
     26.83 ±120%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
      0.20 ±214%   +2830.7%       5.73 ± 45%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
      0.01 ±174%  +54967.1%       4.50 ± 88%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_releasepage.truncate_cleanup_page.truncate_inode_pages_range
      0.01 ±147%  +47311.3%       5.37 ± 65%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.free_pcp_prepare.free_unref_page_list.release_pages
     30.85 ±161%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
     47.67 ±175%    -100.0%       0.00        perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
      0.01 ±120%  +51232.5%       7.10 ± 23%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.uncharge_page.mem_cgroup_uncharge_list
      0.05 ± 22%  +16188.6%       7.36 ± 50%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.__alloc_pages.pagecache_get_page
     10.78 ± 48%     -54.7%       4.88 ± 66%  perf-sched.sch_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_obj_cgroup_from_current.kmem_cache_alloc
      0.01 ±223%  +47324.1%       2.53 ±155%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.down_read.page_lock_anon_vma_read.rmap_walk_anon
      0.01 ±223%  +59434.7%       3.47 ±119%  perf-sched.sch_delay.max.ms.rwsem_down_read_slowpath.down_read.rmap_walk_anon.remove_migration_ptes
      0.01 ±223%  +2.1e+05%      13.83 ± 31%  perf-sched.sch_delay.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
    101194 ±  9%     -16.2%      84822 ±  3%  perf-sched.total_wait_and_delay.count.ms
      8871 ±  9%     -21.3%       6985 ± 11%  perf-sched.total_wait_and_delay.max.ms
      8871 ±  9%     -21.3%       6985 ± 11%  perf-sched.total_wait_time.max.ms
    294.92 ±  2%     -22.2%     229.42 ±  5%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    336.41 ± 12%     -35.4%     217.40 ±  9%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    283.17 ±  5%     +13.9%     322.39 ±  5%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
    245.16 ±  7%     +32.8%     325.49 ±  6%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
     34.96 ± 21%    +680.3%     272.82 ±  6%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
    240.23 ± 15%     +32.3%     317.90 ±  8%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
    245.06 ± 16%     +33.7%     327.60 ±  8%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
     91.68 ±141%    +254.0%     324.57 ± 13%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_delayed_block.ext4_da_map_blocks
    348.92 ± 17%     -74.9%      87.56 ±158%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.balance_dirty_pages_ratelimited.generic_perform_write.ext4_buffered_write_iter
      1176 ± 16%     -50.6%     581.14 ± 23%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
    482.00 ± 25%     -70.7%     141.16 ±115%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
    314.08 ± 10%     -25.2%     234.92 ± 10%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
    142.70 ±141%    +283.1%     546.70 ± 19%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.__ext4_handle_dirty_metadata
    351.27 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
    174.28 ± 71%    +102.2%     352.33 ± 13%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
    371.14 ± 22%     -62.5%     139.31 ±116%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.current_time.file_update_time
    138.07 ±100%    +156.0%     353.38 ± 19%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
    280.09 ±  4%     +25.3%     351.02 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
    310.05 ±  5%     -20.6%     246.29 ±  5%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
     41.52 ±223%    +877.4%     405.86 ± 17%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
    247.47 ± 46%     +60.7%     397.61 ±  7%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
    188.74 ± 72%    +111.7%     399.59 ± 13%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.jbd2_write_access_granted
     86.90 ±141%    +311.7%     357.78 ± 13%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.kmem_cache_alloc
    329.02 ± 18%     -66.8%     109.33 ±116%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.pagecache_get_page
    336.48 ± 11%     -50.5%     166.43 ± 70%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.vfs_write
     51.35 ±223%    +934.0%     530.95 ± 21%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.xa_get_order
     41.99 ±223%    +857.1%     401.89 ± 13%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_page_memcg.mark_buffer_dirty
    334.25 ± 23%     -59.4%     135.59 ±115%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.aa_file_perm
    348.53 ± 12%     -25.7%     259.05 ± 42%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.vfs_write
    162.40 ±100%    +192.9%     475.66 ± 21%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.obj_cgroup_charge.kmem_cache_alloc
    287.27 ± 14%     -77.2%      65.56 ±160%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
    292.43 ±  5%     +24.6%     364.41 ±  5%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
    336.26 ± 11%     -39.1%     204.82 ±  9%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
    320.43 ± 15%     -42.6%     183.84 ± 41%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
    351.90 ±  9%     -78.0%      77.52 ±158%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
     49.38 ±223%    +543.5%     317.80 ± 10%  perf-sched.wait_and_delay.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.jbd2_write_access_granted.part
    128.42 ± 22%    +137.9%     305.50 ±  2%  perf-sched.wait_and_delay.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
    739.86           -28.4%     529.51        perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    250.50 ±  5%    +200.5%     752.86 ±  6%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     24616 ±  9%     -54.2%      11276 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
    159.67 ± 46%     +53.9%     245.71 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__dquot_alloc_space.ext4_da_reserve_space
    221.67 ± 46%     +42.9%     316.71 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_da_reserve_space.ext4_da_map_blocks
      1340 ±  9%     +18.7%       1591 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
    934.67 ±  9%     +17.1%       1094 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
    561.17 ± 10%     +27.3%     714.29 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
    735.67 ±  6%     +29.3%     950.86 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
      3.33 ±223%    +662.9%      25.43 ± 17%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.alloc_buffer_head.alloc_page_buffers.create_empty_buffers
    542.00 ±  6%     +32.0%     715.29 ±  2%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
    259.33 ±  9%     -62.2%      98.14 ±116%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
    942.83 ±  8%     +23.5%       1164 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
      5.67 ±141%    +343.7%      25.14 ± 23%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.__ext4_handle_dirty_metadata
     39.00 ±141%    +232.6%     129.71 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.__mark_inode_dirty
    161.67 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
    269.17 ± 71%     +97.9%     532.57 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
    173.50 ± 11%     -31.0%     119.71 ± 18%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2__journal_start.__ext4_journal_start_sb
      3823 ±  9%     -61.8%       1462 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
     55.33 ±101%    +156.4%     141.86 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_alloc.alloc_buffer_head
      1210 ± 10%     +21.2%       1467 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
    435.50 ±  9%     +20.3%     523.86 ±  3%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
     33.50 ±223%    +656.1%     253.29 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
     47.83 ±100%    +141.3%     115.43 ±  8%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_obj_cgroup_from_current
    113.67 ± 71%    +123.3%     253.86 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.jbd2_write_access_granted
     49.17 ±141%    +247.2%     170.71 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.kmem_cache_alloc
    574.17 ±  9%     -33.1%     384.14 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.start_this_handle
      6.33 ±223%    +784.2%      56.00 ± 18%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.xa_get_order
    643.33 ±  4%     +25.9%     810.14 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.rcu_read_lock_held
     38.67 ±223%    +526.2%     242.14 ±  5%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_page_memcg.mark_buffer_dirty
    106.50 ±  8%     -51.8%      51.29 ± 64%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.stop_this_handle
    213.00 ± 11%     -91.3%      18.57 ±159%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
    588.17 ± 10%     -80.3%     115.86 ±158%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
      6075 ± 11%     -68.4%       1917 ±  7%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
    785.00 ±  6%     +12.0%     878.86 ±  4%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
      0.83 ±223%    +877.1%       8.14 ± 20%  perf-sched.wait_and_delay.count.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.refill_obj_stock.memcg_slab_free_hook
    212.67 ±  7%     -32.2%     144.29 ±  8%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop
    206.83 ± 13%     -36.4%     131.57 ± 42%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.start_this_handle.jbd2__journal_start
     19.50 ±223%    +798.2%     175.14 ± 10%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.jbd2_write_access_granted.part
     38.00 ±141%    +317.3%     158.57 ±  6%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.kmem_cache_alloc.alloc_buffer_head
     17.33 ± 72%    +104.4%      35.43 ±  9%  perf-sched.wait_and_delay.count.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.mem_cgroup_charge.__add_to_page_cache_locked
      1213 ±  5%     +32.9%       1612 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      1114 ±  9%    +176.2%       3079 ±  2%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3986 ±  5%     -22.5%       3088 ±  2%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1691 ± 27%     -27.7%       1223 ±  2%  perf-sched.wait_and_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
      4061 ±  4%     -22.0%       3166 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
      3991 ±  5%     -22.0%       3115 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
      3957 ±  5%     -21.9%       3090        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      3956 ±  5%     -21.7%       3098 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
      3952 ±  5%     -22.1%       3078 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
      3917 ±  5%     -77.9%     864.72 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.balance_dirty_pages_ratelimited.generic_perform_write.ext4_buffered_write_iter
      3990 ±  4%     -22.7%       3086 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
      3988 ±  5%     -22.6%       3086 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
      3963 ±  5%     -22.2%       3082        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      3991 ±  4%     -66.5%       1335 ±115%  perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
      3990 ±  4%     -22.5%       3092        perf-sched.wait_and_delay.max.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
      3958 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
      3660 ±  3%     -66.9%       1213 ±115%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.current_time.file_update_time
      3935 ±  5%     -22.5%       3051 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2__journal_start.__ext4_journal_start_sb
      4034 ±  4%     -23.0%       3104 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
      4003 ±  5%     -23.0%       3084        perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
      3949 ±  5%     -21.9%       3082 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
      3954 ±  5%     -66.4%       1328 ±115%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.pagecache_get_page
      3977 ±  5%     -22.7%       3074        perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.start_this_handle
      3970 ±  5%     -45.0%       2183 ± 63%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.vfs_write
      4009 ±  5%     -22.5%       3106        perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.___might_sleep
      3902 ±  5%     -65.9%       1330 ±115%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.aa_file_perm
      3905 ±  4%     -33.2%       2610 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.ext4_get_group_desc
      3933 ±  5%     -44.6%       2177 ± 63%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.stop_this_handle
      3984 ±  5%     -34.5%       2610 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.vfs_write
      3946 ±  4%     -78.3%     855.55 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
      3973 ±  4%     -78.0%     873.72 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
      3663 ±  4%     -31.1%       2525 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_is_watching.rcu_read_lock_held_common
      4023 ±  4%     -22.6%       3114 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
      4001 ±  4%     -22.7%       3094 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
      3968 ±  3%     -33.8%       2625 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      3945 ±  5%     -23.2%       3030 ±  2%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop
      3947 ±  4%     -77.7%     881.67 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
      3944 ±  5%     -77.6%     883.47 ±158%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.pagecache_get_page.grab_cache_page_write_begin
      3952 ±  4%     -33.9%       2614 ± 40%  perf-sched.wait_and_delay.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.start_this_handle.jbd2__journal_start
      4015 ±  4%     -22.5%       3112 ±  2%  perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4023 ±  4%     -22.9%       3103        perf-sched.wait_and_delay.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      8871 ±  9%     -22.6%       6863 ± 12%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
    294.88 ±  2%     -22.3%     229.15 ±  5%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    336.25 ± 12%     -35.5%     216.85 ±  9%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    231.04 ± 35%     -71.5%      65.86 ± 42%  perf-sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    282.88 ±  5%     +13.8%     321.95 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
    245.01 ±  7%     +32.7%     325.07 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
      3.51 ±101%   +5602.2%     199.96 ±125%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.filemap_map_pages.do_fault
     19.49 ± 20%     -40.8%      11.53 ± 46%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.pick_file.close_fd
     34.92 ± 21%    +680.3%     272.50 ±  6%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      0.05 ±223%  +27674.5%      12.78 ± 33%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.wp_page_copy.__handle_mm_fault
      0.69 ±193%  +72515.3%     502.98 ± 73%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.zap_pte_range.unmap_page_range
    240.07 ± 15%     +32.1%     317.14 ±  8%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
     37.49 ± 34%    +724.8%     309.21 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.delete_from_page_cache_batch.truncate_inode_pages_range
    244.88 ± 16%     +33.5%     326.99 ±  8%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
     39.93 ± 53%    +688.9%     315.02 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.release_pages.__pagevec_release
      4.14 ± 19%    +245.8%      14.33 ± 42%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.sched_move_task.do_exit
     29.97 ± 80%    +787.8%     266.04 ± 28%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.task_sched_runtime.thread_group_cputime
    227.89 ± 18%     +42.4%     324.41 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_delayed_block.ext4_da_map_blocks
    348.76 ± 17%     -29.5%     245.90 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.balance_dirty_pages_ratelimited.generic_perform_write.ext4_buffered_write_iter
      1175 ± 16%     -50.8%     577.98 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
     17.65 ±  5%   +1631.5%     305.66 ± 44%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.jbd2_journal_grab_journal_head.jbd2_journal_try_to_free_buffers.truncate_cleanup_page
     18.03 ± 13%   +1839.4%     349.76 ± 62%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.lru_add_drain.__pagevec_release.truncate_inode_pages_range
     45.94 ±141%   +1209.1%     601.42 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.rwsem_down_write_slowpath.path_openat.do_filp_open
    478.98 ± 25%     -44.0%     268.26 ± 20%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
    313.88 ± 10%     -25.3%     234.40 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
    519.58 ± 98%     -97.8%      11.60 ± 48%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.PageHuge.__add_to_page_cache_locked
    186.95 ± 98%    +192.3%     546.50 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.__ext4_handle_dirty_metadata
    128.42 ±106%    +249.6%     448.98 ± 37%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.__getblk_gfp
    402.91 ± 50%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
    331.33 ± 96%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_start_sb.ext4_da_write_begin
    351.01 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
    147.25 ± 42%    +126.1%     332.89 ± 29%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_mark_inode_dirty.ext4_dirty_inode
    240.95 ± 14%     +45.8%     351.34 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
    382.43 ± 70%     -75.7%      92.94 ±134%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__getblk_gfp.__ext4_get_inode_loc
    216.00 ±106%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__might_sleep.ext4_da_write_begin
    270.98 ± 93%     -53.0%     127.25 ±102%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__rcu_read_lock.aa_file_perm
     22.91 ± 42%   +1372.9%     337.48 ± 46%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.block_invalidatepage.truncate_cleanup_page
    370.91 ± 22%     -43.7%     208.72 ± 55%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.current_time.file_update_time
    242.33 ± 19%     +45.8%     353.29 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
     25.87 ± 75%   +1078.8%     304.98 ± 49%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.find_lock_entries.truncate_inode_pages_range
     26.95 ± 76%   +1407.8%     406.32 ± 25%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.free_unref_page_list.release_pages
    272.75 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
    279.63 ±  4%     +25.4%     350.59 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
     17.76 ±  4%   +1535.8%     290.46 ± 28%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.free_buffer_head
    309.85 ±  5%     -20.6%     246.17 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
    228.60 ±  9%     +76.8%     404.10 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
    280.31 ± 17%     +41.8%     397.46 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
    263.42 ± 16%     +51.6%     399.42 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.jbd2_write_access_granted
    210.51 ± 19%     +69.8%     357.54 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.kmem_cache_alloc
    175.50 ± 49%    +112.5%     372.98 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.lock_page_memcg
     17.93 ±  8%   +1407.3%     270.28 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.memcg_slab_free_hook
    328.84 ± 18%     -27.5%     238.48 ± 11%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.pagecache_get_page
    336.37 ± 11%     -32.6%     226.62 ± 22%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.vfs_write
    142.54 ± 75%    +272.2%     530.48 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.xa_get_order
     16.59 ± 13%   +1738.0%     304.89 ± 46%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_find
    185.41 ± 21%    +116.7%     401.70 ± 13%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_page_memcg.mark_buffer_dirty
    334.10 ± 23%     -26.6%     245.23 ± 27%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.aa_file_perm
     87.18 ±116%    +374.8%     413.92 ± 68%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.mem_cgroup_charge
     17.39 ± 13%   +1826.7%     335.07 ± 35%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.mem_cgroup_uncharge_list
     18.25 ±  8%   +1456.3%     283.99 ± 50%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.memcg_slab_free_hook
    348.42 ± 12%     -19.9%     279.02 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.vfs_write
    106.13 ± 46%    +197.7%     315.98 ± 24%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memcg_slab_free_hook.kmem_cache_free
    237.73 ± 40%    +100.0%     475.43 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.obj_cgroup_charge.kmem_cache_alloc
     43.74 ±134%    +725.0%     360.82 ± 53%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.page_counter_cancel.page_counter_uncharge
    416.45 ± 67%     -83.6%      68.16 ±189%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.page_vma_mapped_walk.try_to_unmap_one
    287.08 ± 14%     -25.9%     212.67 ± 11%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
      2.17 ±223%   +6682.2%     146.93 ±221%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.preempt_count_sub._raw_write_unlock
     13.49 ± 35%   +2242.0%     315.90 ±114%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.get_mem_cgroup_from_mm
      7.72 ±122%  +12323.0%     958.68 ±102%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.get_obj_cgroup_from_current
     26.64 ± 72%   +1107.2%     321.59 ± 17%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.refill_obj_stock.memcg_slab_free_hook
    292.29 ±  5%     +24.6%     364.24 ±  5%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
    336.10 ± 11%     -39.1%     204.72 ±  9%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
     25.68 ± 55%    +593.2%     178.02 ± 36%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.truncate_cleanup_page.truncate_inode_pages_range
    279.99 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
    121.98 ±204%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.___might_sleep.ext4_da_write_begin
    146.14 ±202%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.__ext4_journal_stop.ext4_da_write_end
    212.94 ±212%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.generic_write_end.ext4_da_write_end
    238.51 ± 28%     -41.5%     139.60 ± 47%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.jbd2_journal_stop.__ext4_journal_stop
    322.56 ± 69%     -70.3%      95.89 ± 70%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.kmem_cache_free.jbd2_journal_stop
      1.22 ±223%  +86129.2%       1055 ±122%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_release.mem_cgroup_uncharge_list
    139.70 ± 98%     -76.2%      33.27 ±162%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.mark_buffer_dirty.__block_commit_write
     15.13 ± 16%     -34.1%       9.98 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.new_sync_write.vfs_write
     14.53 ± 26%   +2968.2%     445.79 ± 20%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.refill_obj_stock.memcg_slab_free_hook
      6.41 ± 82%   +1103.7%      77.17 ±195%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.security_file_permission.vfs_write
    258.85 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.unlock_page.ext4_da_write_begin
    148.15 ±202%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.___might_sleep.ext4_da_write_begin
    183.63 ±142%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.__ext4_journal_stop.ext4_da_write_end
      1.68 ±222%  +12519.4%     212.38 ±234%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.__might_sleep.block_invalidatepage
      1.95 ±168%  +10929.5%     215.39 ±146%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.apparmor_file_permission.security_file_permission
     23.06 ± 58%     -57.4%       9.83 ± 31%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.ext4_da_map_blocks.constprop
     12.46 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.generic_write_end.ext4_da_write_end
    218.56 ± 23%     -47.5%     114.74 ± 34%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.jbd2_journal_stop.__ext4_journal_stop
    224.93 ± 20%     -41.6%     131.28 ± 21%  perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.stop_this_handle.jbd2_journal_stop
    143.07 ±132%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.unlock_page.ext4_da_write_begin
    169.04 ± 80%    +113.8%     361.33 ± 28%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__alloc_pages.pagecache_get_page.grab_cache_page_write_begin
    276.29 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
    204.86 ± 22%     +78.3%     365.23 ± 19%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__find_get_block.__getblk_gfp.__ext4_get_inode_loc
    237.44 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
    320.27 ± 15%     -34.5%     209.77 ±  7%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
     43.98 ±137%    +604.4%     309.77 ± 58%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_invalidatepage.truncate_cleanup_page.truncate_inode_pages_range
     46.23 ±146%    +534.4%     293.29 ± 85%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_releasepage.truncate_cleanup_page.truncate_inode_pages_range
     40.25 ±133%    +732.4%     335.03 ± 45%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.free_pcp_prepare.free_unref_page_list.release_pages
    264.48 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      1.08 ±223%  +31494.7%     342.70 ± 15%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      2.66 ±164%  +11815.9%     317.36 ±  6%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty
    293.07 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
    171.32 ± 74%     +90.1%     325.59 ± 27%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_alloc.alloc_buffer_head.alloc_page_buffers
     93.40 ± 81%    +284.7%     359.34 ± 51%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.__mem_cgroup_charge.mem_cgroup_charge
    351.59 ±  9%     -35.3%     227.63 ± 16%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
    316.34 ± 22%     -32.0%     214.96 ± 27%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.down_write.ext4_buffered_write_iter
     30.22 ±100%    +886.7%     298.18 ± 31%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.memcg_slab_free_hook.kmem_cache_free
    409.87 ± 97%     -76.6%      95.93 ±221%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_mem_cgroup_from_objcg.obj_cgroup_charge_pages
    204.60 ± 22%     +54.0%     315.10 ± 10%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.jbd2_write_access_granted.part
     30.57 ± 88%   +1014.4%     340.67 ± 32%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.memcg_slab_free_hook.kmem_cache_free
    294.06 ± 15%     -34.0%     194.10 ± 28%  perf-sched.wait_time.avg.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.up_write.ext4_buffered_write_iter
      0.28 ±223%  +1.8e+05%     500.77 ±203%  perf-sched.wait_time.avg.ms.rwsem_down_read_slowpath.down_read.rmap_walk_anon.remove_migration_ptes
    128.19 ± 22%    +138.0%     305.04 ±  2%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      3.33 ±223%   +5410.0%     183.60 ± 55%  perf-sched.wait_time.avg.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
     53.01 ± 64%    +475.4%     305.05 ± 32%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.__fdget_pos.ksys_write
     34.33 ± 58%    +543.1%     220.76 ± 28%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.ext4_orphan_del.ext4_evict_inode
    739.83           -28.4%     529.48        perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      1114 ±  9%    +176.2%       3079 ±  2%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3986 ±  5%     -22.6%       3086 ±  2%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3852 ±  4%     -37.3%       2415 ± 40%  perf-sched.wait_time.max.ms.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3930 ±  5%     -21.6%       3080 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.ext4_es_lookup_extent.ext4_da_map_blocks
      4060 ±  4%     -22.7%       3136 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_read_unlock.start_this_handle.jbd2__journal_start
      3972 ±  5%     -22.8%       3066 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.__dquot_alloc_space.ext4_da_reserve_space
      3942 ±  5%     -21.8%       3084        perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_block_write_begin.ext4_da_write_begin
     22.79 ± 19%     -56.1%      10.01 ± 74%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_da_release_space.ext4_es_remove_extent
      3947 ±  5%     -21.8%       3086        perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_da_reserve_space.ext4_da_map_blocks
      3991 ±  5%     -22.0%       3115 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.ext4_do_update_inode.ext4_mark_iloc_dirty
      3253 ± 44%     -62.4%       1223 ±112%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.page_vma_mapped_walk.remove_migration_pte
     24.51 ± 18%     -39.9%      14.73 ± 45%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.pick_file.close_fd
      3957 ±  5%     -22.0%       3086        perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.try_to_free_buffers.truncate_cleanup_page
      0.05 ±223%  +47165.8%      21.74 ± 51%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.wp_page_copy.__handle_mm_fault
      2.47 ±202%  +99594.9%       2466 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock.zap_pte_range.unmap_page_range
      3953 ±  5%     -21.7%       3096 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.__add_to_page_cache_locked.add_to_page_cache_lru
     38.30 ± 23%     -39.0%      23.38 ± 35%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irq.shmem_getpage_gfp.shmem_write_begin
      3950 ±  5%     -22.1%       3077 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_spin_unlock_irqrestore.mark_buffer_dirty.__block_commit_write
      3914 ±  6%     -21.9%       3056 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_delayed_block.ext4_da_map_blocks
     15.13 ± 58%   +5130.9%     791.48 ±152%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk._raw_write_unlock.ext4_es_insert_extent.ext4_ext_map_blocks
      3916 ±  5%     -23.2%       3006        perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.balance_dirty_pages_ratelimited.generic_perform_write.ext4_buffered_write_iter
      3990 ±  4%     -22.9%       3076 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.cpu_stop_queue_work.stop_one_cpu.migrate_task_to
      3934 ±  5%     -23.2%       3021 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      3987 ±  5%     -22.6%       3085 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.iov_iter_copy_from_user_atomic.generic_perform_write.ext4_buffered_write_iter
     45.22 ± 15%   +6403.6%       2941 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.jbd2_journal_grab_journal_head.jbd2_journal_try_to_free_buffers.truncate_cleanup_page
     34.94 ± 24%   +7961.5%       2816 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.lru_add_drain.__pagevec_release.truncate_inode_pages_range
      3963 ±  5%     -22.5%       3070 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.lru_cache_add.add_to_page_cache_lru.pagecache_get_page
      3988 ±  4%     -23.2%       3064 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.stop_two_cpus.migrate_swap.task_numa_migrate
      3875 ±  7%     -23.7%       2956        perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.try_to_wake_up.wake_up_q.rwsem_wake
      3988 ±  4%     -22.5%       3091        perf-sched.wait_time.max.ms.preempt_schedule_common.preempt_schedule_thunk.vfs_write.ksys_write.do_syscall_64
      1764 ± 97%     -98.9%      18.65 ± 74%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.PageHuge.__add_to_page_cache_locked
      3863 ±  5%     -23.9%       2939        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.down_write
      3820 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_da_write_begin
      3818 ±  6%     -23.7%       2913        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.ext4_journal_check_start
      3768 ±  6%     -34.2%       2479 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.kmem_cache_alloc
      3731 ±  6%     -23.6%       2849 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.pagecache_get_page
      3833 ±  5%     -24.6%       2889 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.___might_sleep.vfs_write
      3773 ±  7%     -21.5%       2963 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__add_to_page_cache_locked.add_to_page_cache_lru
      1898 ± 98%     -56.3%     830.39 ±154%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__anon_vma_interval_tree_subtree_search.rmap_walk_anon
      3920 ±  4%     -22.4%       3041        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__block_commit_write.isra
      3800 ±  6%     -20.5%       3022 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__brelse.ext4_do_update_inode
      3748 ±  3%     -20.2%       2990        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_get_inode_loc.ext4_get_inode_loc
      2574 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_start_sb.ext4_da_write_begin
      3864 ±  4%     -21.6%       3031 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.__mark_inode_dirty
      3953 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__ext4_journal_stop.ext4_da_write_end
      3903 ±  5%     -22.6%       3020 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__fget_light.__fdget_pos
      3935 ±  5%     -21.6%       3083 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__find_get_block.__getblk_gfp
      3900 ±  5%     -25.8%       2894 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__fsnotify_parent.vfs_write
      3835 ±  2%     -21.9%       2994 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__get_user_nocheck_1.iov_iter_fault_in_readable
      2387 ± 69%     -66.4%     802.26 ±153%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__getblk_gfp.__ext4_get_inode_loc
      3827 ±  6%     -23.3%       2935 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mark_inode_dirty.__block_commit_write
      3829 ±  7%     -20.6%       3039 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mark_inode_dirty.generic_write_end
      3854 ±  7%     -21.2%       3036        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__mem_cgroup_charge.mem_cgroup_charge
      1901 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.__might_sleep.ext4_da_write_begin
      3741 ±  5%     -19.9%       2998        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.aa_file_perm.common_file_perm
      3138 ± 43%     -74.7%     793.65 ±150%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.block_write_end.generic_write_end
      3874 ±  5%     -22.0%       3020 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.common_file_perm.security_file_permission
      3658 ±  3%     -33.5%       2432 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.current_time.file_update_time
      3943 ±  5%     -22.9%       3040 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.___might_sleep
      3877 ±  5%     -22.1%       3020        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.aa_file_perm
      3878 ±  6%     -22.3%       3013        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.debug_lockdep_rcu_enabled.rcu_read_lock_held_common
      3835 ±  5%     -24.8%       2882 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3666 ±  4%     -33.0%       2458 ± 41%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.down_read.ext4_da_map_blocks
      3914 ±  6%     -23.3%       3003 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.down_write.ext4_buffered_write_iter
      3903 ±  6%     -24.8%       2935 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_block_write_begin.ext4_da_write_begin
      3795 ±  4%     -21.4%       2982 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_buffered_write_iter.new_sync_write
      3806 ±  5%     -20.9%       3009 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_da_map_blocks.constprop
      3956 ±  5%     -24.3%       2993 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_da_write_begin.generic_perform_write
      3875 ±  4%     -22.7%       2993 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_da_write_end.generic_perform_write
      3838 ±  4%     -21.4%       3017 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_do_update_inode.ext4_mark_iloc_dirty
      3806 ±  4%     -21.3%       2995 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_file_write_iter.new_sync_write
      3966 ±  5%     -23.1%       3050 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_journal_check_start.__ext4_journal_start_sb
      3911 ±  5%     -22.1%       3048        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      3652 ±  3%     -55.6%       1619 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.fs_reclaim_release.kmem_cache_alloc
      3884 ±  5%     -21.1%       3065 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_perform_write.ext4_buffered_write_iter
      3777 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.generic_write_end.ext4_da_write_end
      3670 ±  3%     -19.2%       2964 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.iov_iter_fault_in_readable.generic_perform_write
      3934 ±  5%     -22.4%       3051 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2__journal_start.__ext4_journal_start_sb
      3820 ±  7%     -21.3%       3005 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata
      3787 ±  4%     -20.4%       3014        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_get_write_access.__ext4_journal_get_write_access
      4032 ±  4%     -23.0%       3103 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_journal_stop.__ext4_journal_stop
      3954 ±  5%     -23.1%       3039 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.jbd2_write_access_granted.part
      3862 ±  6%     -21.2%       3042        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_alloc.alloc_buffer_head
      3948 ±  5%     -23.5%       3021 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_alloc.jbd2__journal_start
     58.01 ± 31%   +4930.8%       2918 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.free_buffer_head
      4000 ±  5%     -23.2%       3073 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.kmem_cache_free.jbd2_journal_stop
      3161 ± 44%     -61.5%       1215 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ksys_lseek.do_syscall_64
      3827 ±  5%     -22.7%       2960 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ksys_write.do_syscall_64
      4002 ±  5%     -23.0%       3083        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.ktime_get_coarse_real_ts64.current_time
      3959 ±  5%     -22.6%       3065        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.aa_file_perm
      3844 ±  6%     -21.0%       3038 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_read
      3949 ±  5%     -22.5%       3062 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.down_write
      3935 ±  5%     -21.9%       3071 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.ext4_get_group_desc
      3980 ±  5%     -21.1%       3142 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.fs_reclaim_acquire
      3909 ±  4%     -22.7%       3021 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.get_obj_cgroup_from_current
      3945 ±  5%     -21.9%       3082 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.jbd2_write_access_granted
      3849 ±  5%     -21.1%       3036        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.kmem_cache_alloc
      3586 ±  2%     -16.6%       2990        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.mem_cgroup_charge
     55.62 ± 20%   +5299.5%       3002 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.memcg_slab_free_hook
      3952 ±  5%     -22.4%       3067        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.pagecache_get_page
      3968 ±  5%     -22.6%       3073        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.start_this_handle
      3968 ±  5%     -23.0%       3054        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_acquire.vfs_write
      4009 ±  5%     -22.5%       3105        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.___might_sleep
      3724 ±  7%     -21.5%       2923 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.get_mem_cgroup_from_mm
      3892 ±  5%     -23.7%       2971 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.pagecache_get_page
      3920 ±  5%     -22.1%       3055 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_descend
     34.99 ± 25%   +8143.2%       2884 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_find
      3925 ±  5%     -22.2%       3053 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_is_held_type.xas_start
      3957 ±  4%     -23.1%       3045 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_page_memcg.mark_buffer_dirty
      3796 ±  3%     -21.4%       2984 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.__alloc_pages
      3902 ±  5%     -22.7%       3015        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.aa_file_perm
      3904 ±  4%     -22.2%       3039        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.ext4_get_group_desc
      3855 ±  7%     -22.0%       3008 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.jbd2_write_access_granted
      3934 ±  5%     -22.6%       3045        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.kmem_cache_alloc
     34.19 ± 20%   +8311.2%       2875 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.mem_cgroup_uncharge_list
     46.67 ± 24%   +6041.6%       2866 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.memcg_slab_free_hook
      3924 ±  5%     -22.6%       3039 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.pagecache_get_page
      3930 ±  5%     -23.2%       3019 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.stop_this_handle
      3894 ±  5%     -22.3%       3024 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.up_write
      3983 ±  5%     -23.6%       3044 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.lock_release.vfs_write
      3923 ±  5%     -23.8%       2991 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.mark_buffer_dirty.__block_commit_write
      3592 ±  3%     -29.4%       2536 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.mark_page_accessed.__find_get_block
      3802 ±  7%     -20.6%       3018        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memcg_slab_free_hook.kmem_cache_free
      3870 ±  6%     -24.0%       2940 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.memset_erms.kmem_cache_alloc
      3946 ±  4%     -23.9%       3003 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.new_sync_write.vfs_write
      3818 ±  5%     -20.9%       3021        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.obj_cgroup_charge.kmem_cache_alloc
      2408 ± 69%     -81.1%     456.08 ±230%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.page_vma_mapped_walk.try_to_unmap_one
      3972 ±  4%     -22.4%       3083 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.pagecache_get_page.grab_cache_page_write_begin
      2.17 ±223%  +18825.4%     409.99 ±235%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.preempt_count_sub._raw_write_unlock
      3662 ±  4%     -30.9%       2529 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_is_watching.rcu_read_lock_held_common
      3780 ±  4%     -21.7%       2958        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_lockdep_current_cpu_online.rcu_read_lock_held_common
     20.96 ± 49%   +5816.9%       1239 ±111%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.get_mem_cgroup_from_mm
      8.31 ±122%  +19057.1%       1592 ± 85%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.get_obj_cgroup_from_current
      3803 ±  7%     -32.1%       2582 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held.xas_descend
      3726 ±  8%     -34.3%       2447 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rcu_read_lock_held_common.rcu_read_lock_held
      3829 ±  3%     -20.9%       3029        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.rmqueue.get_page_from_freelist
      3700 ±  4%     -23.8%       2819 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.security_file_permission.vfs_write
      3968 ±  5%     -22.8%       3064        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.start_this_handle.jbd2__journal_start
      4023 ±  4%     -22.6%       3113 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.stop_this_handle.jbd2_journal_stop
      4001 ±  4%     -22.7%       3092 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_enter_from_user_mode.do_syscall_64
      3820 ±  5%     -34.5%       2503 ± 41%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3797 ±  4%     -21.0%       3000 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.try_charge.__mem_cgroup_charge
      3974 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.ext4_da_write_begin
      3883 ±  6%     -23.4%       2975 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.unlock_page.generic_write_end
      3785 ±  7%     -46.8%       2012 ± 61%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.up_read.ext4_da_map_blocks
      3973 ±  5%     -23.8%       3027 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.up_write.ext4_buffered_write_iter
      3955 ±  4%     -24.0%       3005 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.vfs_write.ksys_write
      3934 ±  5%     -23.6%       3006 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_descend.xas_load
      3857 ±  6%     -35.5%       2488 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_load.pagecache_get_page
      3896 ±  5%     -23.6%       2977 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_apic_timer_interrupt.xas_start.xas_load
    573.23 ±215%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.___might_sleep.ext4_da_write_begin
    682.90 ±214%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.__ext4_journal_stop.ext4_da_write_end
    620.01 ±217%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.generic_write_end.ext4_da_write_end
      3966 ±  4%     -25.6%       2950 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.jbd2_journal_stop.__ext4_journal_stop
      3759 ±  7%     -45.9%       2032 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.kmem_cache_free.jbd2_journal_stop
      3773 ±  4%     -19.4%       3041 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.ktime_get_coarse_real_ts64.current_time
      3753 ±  6%     -55.6%       1665 ± 84%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_acquire.aa_file_perm
      3740 ±  5%     -22.9%       2885 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_acquire.fs_reclaim_acquire
      3897 ±  4%     -23.0%       3002 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_is_held_type.___might_sleep
      1.50 ±223%  +84348.9%       1266 ±113%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.lock_release.mem_cgroup_uncharge_list
     25.04 ± 57%   +9895.8%       2502 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.memcg_slab_free_hook.kmem_cache_free
     28.43 ± 29%   +9617.4%       2762 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.refill_obj_stock.memcg_slab_free_hook
      9.36 ± 90%   +4140.2%     396.71 ±230%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.security_file_permission.vfs_write
      3870 ±  6%     -47.6%       2027 ± 62%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.start_this_handle.jbd2__journal_start
      3955 ±  5%     -23.6%       3022 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.stop_this_handle.jbd2_journal_stop
      3819 ±  5%     -22.5%       2958 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.syscall_enter_from_user_mode.do_syscall_64
      2499 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_call_function_single.unlock_page.ext4_da_write_begin
    686.68 ±217%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.___might_sleep.ext4_da_write_begin
      1263 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.__ext4_journal_stop.ext4_da_write_end
     19.04 ± 56%   +8561.2%       1648 ± 84%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.__might_sleep.__ext4_handle_dirty_metadata
      1.68 ±222%  +24908.5%     420.89 ±238%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.__might_sleep.block_invalidatepage
      2.39 ±147%  +34286.2%     820.45 ±153%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.apparmor_file_permission.security_file_permission
      3680 ±  3%     -19.9%       2946 ±  6%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     73.00 ±104%     -73.2%      19.60 ± 37%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.ext4_da_map_blocks.constprop
     24.26 ± 65%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.generic_write_end.ext4_da_write_end
      3973 ±  3%     -25.4%       2965 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.jbd2_journal_stop.__ext4_journal_stop
      3777 ±  6%     -20.9%       2987 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.ktime_get_coarse_real_ts64.current_time
      3831 ±  5%     -25.0%       2872 ±  5%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_acquire.start_this_handle
      3926 ±  5%     -24.4%       2970 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_is_held_type.___might_sleep
      3806 ±  3%     -21.2%       3000 ±  4%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_is_held_type.rcu_read_lock_held
      6.83 ±140%   +6458.6%     448.26 ±230%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.lock_release.__alloc_pages
      3774 ±  7%     -23.4%       2891 ±  7%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.start_this_handle.jbd2__journal_start
      3970 ±  4%     -23.6%       3033 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.stop_this_handle.jbd2_journal_stop
      3787 ±  6%     -22.0%       2953 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.syscall_enter_from_user_mode.do_syscall_64
      1252 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_irq.irqentry_exit.asm_sysvec_reschedule_ipi.unlock_page.ext4_da_write_begin
      3953 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_da_write_begin.generic_perform_write
      3893 ±  4%     -22.0%       3035 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      3954 ±  5%     -23.6%       3021        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      3913 ±  6%     -22.0%       3051 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__find_get_block.__getblk_gfp.__ext4_get_inode_loc
      3979 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.__mark_inode_dirty.generic_write_end.ext4_da_write_end
      3934 ±  5%     -23.0%       3030 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3966 ±  3%     -23.0%       3054 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_da_write_end.generic_perform_write.ext4_buffered_write_iter
      3798 ±  6%     -33.2%       2537 ± 40%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_es_insert_delayed_block.ext4_da_map_blocks.constprop
      3850 ±  6%     -21.5%       3021 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_es_lookup_extent.ext4_da_map_blocks.constprop
      3897 ±  3%     -22.3%       3029 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.ext4_fc_track_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      3954 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_da_write_begin
      2.17 ±223%  +1.4e+05%       3043 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2__journal_start.__ext4_journal_start_sb.ext4_dirty_inode
      2.66 ±164%  +1.1e+05%       3005        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty
      3926 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.jbd2_journal_stop.__ext4_journal_stop.ext4_da_write_end
      3928 ±  5%     -22.5%       3043 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_alloc.jbd2__journal_start.__ext4_journal_start_sb
      3941 ±  5%     -23.1%       3029 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.kmem_cache_free.jbd2_journal_stop.__ext4_journal_stop
      3938 ±  4%     -22.9%       3035 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.aa_file_perm.common_file_perm
      3965 ±  5%     -23.5%       3032 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.down_write.ext4_buffered_write_iter
      3842 ±  5%     -19.6%       3091 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.ext4_get_group_desc.__ext4_get_inode_loc
      3734 ±  3%     -20.0%       2988 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.fs_reclaim_acquire.__alloc_pages
      3972 ±  5%     -23.3%       3046 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.fs_reclaim_acquire.kmem_cache_alloc
      3843 ±  6%     -21.6%       3014 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.get_obj_cgroup_from_current.kmem_cache_alloc
      3800 ±  6%     -20.6%       3018 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.jbd2_write_access_granted.part
      3912 ±  5%     -21.9%       3056 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.kmem_cache_alloc.alloc_buffer_head
      3944 ±  5%     -22.5%       3056        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.pagecache_get_page.grab_cache_page_write_begin
      3941 ±  5%     -23.0%       3036 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.start_this_handle.jbd2__journal_start
      3941 ±  5%     -22.7%       3048 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_acquire.vfs_write.ksys_write
      3870 ±  4%     -21.6%       3033        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.__alloc_pages.pagecache_get_page
      3566 ±  4%     -16.3%       2983 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.__mem_cgroup_charge.mem_cgroup_charge
      3903 ±  5%     -21.9%       3046 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.aa_file_perm.common_file_perm
      3878 ±  5%     -21.8%       3032 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.ext4_get_group_desc.__ext4_get_inode_loc
      3875 ±  6%     -23.3%       2973 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_mem_cgroup_from_mm.mem_cgroup_charge
      1812 ± 98%     -80.1%     359.92 ±234%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_mem_cgroup_from_objcg.obj_cgroup_charge_pages
      3881 ±  5%     -22.0%       3025 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.get_obj_cgroup_from_current.kmem_cache_alloc
      3920 ±  5%     -22.3%       3045        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.jbd2_write_access_granted.part
      3915 ±  4%     -22.5%       3034 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.kmem_cache_alloc.alloc_buffer_head
      3930 ±  5%     -22.9%       3031        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.kmem_cache_alloc.jbd2__journal_start
      3710 ±  6%     -20.3%       2958        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.mark_buffer_dirty.__block_commit_write
      3738 ±  7%     -20.2%       2984 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.mem_cgroup_charge.__add_to_page_cache_locked
      3947 ±  5%     -22.2%       3072 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.pagecache_get_page.grab_cache_page_write_begin
      3901 ±  5%     -22.3%       3031 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.stop_this_handle.jbd2_journal_stop
      3941 ±  5%     -22.7%       3045 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.up_write.ext4_buffered_write_iter
      3941 ±  5%     -23.4%       3020        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.vfs_write.ksys_write
      3810 ±  7%     -22.2%       2965 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.lock_release.xa_get_order.__add_to_page_cache_locked
      3933 ±  5%     -22.1%       3062 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.mark_buffer_dirty.__block_commit_write.isra
      3784 ±  5%     -22.4%       2938 ±  3%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_is_watching.pagecache_get_page.grab_cache_page_write_begin
      3913 ±  4%     -22.5%       3034 ±  2%  perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_is_watching.rcu_read_lock_held_common.rcu_read_lock_held
      3915 ±  5%     -23.1%       3012        perf-sched.wait_time.max.ms.preempt_schedule_notrace.preempt_schedule_notrace_thunk.rcu_lockdep_current_cpu_online.rcu_read_lock_held_common.rcu_read_lock_held
      0.28 ±223%  +3.1e+05%     861.26 ±152%  perf-sched.wait_time.max.ms.rwsem_down_read_slowpath.down_read.rmap_walk_anon.remove_migration_ptes
      2.73 ±223%   +1181.8%      35.01 ± 31%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.__put_anon_vma.unlink_anon_vmas.free_pgtables
      4011 ±  4%     -22.5%       3108 ±  2%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.do_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4008 ±  4%     -22.6%       3103        perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.path_openat.do_filp_open.do_sys_openat2
      3.33 ±223%  +75791.2%       2528 ± 40%  perf-sched.wait_time.max.ms.rwsem_down_write_slowpath.unlink_anon_vmas.free_pgtables.exit_mmap
      8871 ±  9%     -22.6%       6863 ± 12%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      3752 ±  7%     -23.1%       2887 ±  4%  perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-rc5-00042-g57e8668f62e2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0-rc5 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_MPTCP_KUNIT_TEST=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
# CONFIG_WWAN is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_KUNIT_TEST=y
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_KPROBES_SANITY_TEST is not set
CONFIG_BACKTRACE_SELF_TEST=y
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=y
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
CONFIG_BITFIELD_KUNIT=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
# CONFIG_LINEAR_RANGES_TEST is not set
CONFIG_CMDLINE_KUNIT_TEST=y
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='aim7'
	export testcase='aim7'
	export category='benchmark'
	export job_origin='aim7-fs-raid.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2sp9'
	export tbox_group='lkp-csl-2sp9'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='60fea73b67d8df38c2e352c9'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-57e8668f62e2f2fb09bc459d660f2a-20210726-14530-lwo3t8-4.yaml'
	export id='abac61428772f20e18e604acdce7bb6ccf580705'
	export queuer_version='/lkp-src'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=88
	export memory='128G'
	export nr_hdd_partitions=4
	export nr_ssd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2'
	export brand='Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz'
	export commit='57e8668f62e2f2fb09bc459d660f2af04aad9255'
	export ucode='0x5003006'
	export need_kconfig_hw='{"I40E"=>"y"}
SATA_AHCI'
	export need_kconfig='{"BLK_DEV_RAM"=>"m"}
{"BLK_DEV"=>"y"}
{"BLOCK"=>"y"}
MD_RAID1
EXT4_FS'
	export enqueue_time='2021-07-26 20:14:51 +0800'
	export _id='60fea74d67d8df38c2e352ca'
	export _rt='/result/aim7/performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='f2cd46e6ec007ad117228a5a7eb190be7c95b2a1'
	export base_commit='2734d6c1b1a089fb593ef6a23d4b70903526fe0c'
	export branch='linux-review/Zhang-Yi/ext4-improve-delalloc-buffer-write-performance/20210718-105534'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/aim7/performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/3'
	export scheduler_version='/lkp/lkp/.src-20210726-152025'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-57e8668f62e2f2fb09bc459d660f2a-20210726-14530-lwo3t8-4.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linux-review/Zhang-Yi/ext4-improve-delalloc-buffer-write-performance/20210718-105534
commit=57e8668f62e2f2fb09bc459d660f2af04aad9255
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/vmlinuz-5.13.0-rc5-00042-g57e8668f62e2
max_uptime=2100
RESULT_ROOT=/result/aim7/performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d8079fac1681-1_20210725.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.14.0-rc2-01153-gf2cd46e6ec00'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/vmlinuz-5.13.0-rc5-00042-g57e8668f62e2'
	export dequeue_time='2021-07-26 20:32:55 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-57e8668f62e2f2fb09bc459d660f2a-20210726-14530-lwo3t8-4.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_brd=4 ramdisk_size=12884901888 $LKP_SRC/setup/disk

	run_setup raid_level='raid1' $LKP_SRC/setup/md

	run_setup fs='ext4' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor delay=15 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='disk_rw' load=3000 $LKP_SRC/tests/wrapper aim7
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env delay=15 $LKP_SRC/stats/wrapper perf-profile
	env test='disk_rw' load=3000 $LKP_SRC/stats/wrapper aim7
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat

	$LKP_SRC/stats/wrapper time aim7.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/aim7-fs-raid.yaml:
suite: aim7
testcase: aim7
category: benchmark
perf-profile:
  delay: 15
disk: 4BRD_12G
md: RAID1
fs: ext4
aim7:
  test: disk_rw
  load: 3000
job_origin: aim7-fs-raid.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2sp9
tbox_group: lkp-csl-2sp9
kconfig: x86_64-rhel-8.3
submit_id: 60fe32a767d8df1097a28b83
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-57e8668f62e2f2fb09bc459d660f2a-20210726-4247-w66lg1-2.yaml"
id: e3ec97611b67ec7a0852a73755e769f3accb01cf
queuer_version: "/lkp-src"
:#! hosts/lkp-csl-2sp9:
model: Cascade Lake
nr_node: 2
nr_cpu: 88
memory: 128G
nr_hdd_partitions: 4
nr_ssd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-ST4000NM0035-1V4107_ZC13Q1RD-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part1"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB480G7_PHDV723200JX480BGN-part2"
brand: Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz
:#! include/category/benchmark:
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/queue/cyclic:
commit: 57e8668f62e2f2fb09bc459d660f2af04aad9255
:#! include/testbox/lkp-csl-2sp9:
ucode: '0x5003006'
need_kconfig_hw:
- I40E: y
- SATA_AHCI
:#! include/disk/nr_brd:
need_kconfig:
- BLK_DEV_RAM: m
- BLK_DEV: y
- BLOCK: y
- MD_RAID1
- EXT4_FS
:#! include/md/raid_level:
:#! include/fs/OTHERS:
enqueue_time: 2021-07-26 11:57:27.519537175 +08:00
_id: 60fe32bb67d8df1097a28b85
_rt: "/result/aim7/performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: f2cd46e6ec007ad117228a5a7eb190be7c95b2a1
base_commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
branch: linux-devel/devel-hourly-20210724-180738
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/aim7/performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/0"
scheduler_version: "/lkp/lkp/.src-20210726-110645"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp9/aim7-performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006-debian-10.4-x86_64-20200603.cgz-57e8668f62e2f2fb09bc459d660f2a-20210726-4247-w66lg1-2.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210724-180738
- commit=57e8668f62e2f2fb09bc459d660f2af04aad9255
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/vmlinuz-5.13.0-rc5-00042-g57e8668f62e2
- max_uptime=2100
- RESULT_ROOT=/result/aim7/performance-4BRD_12G-ext4-3000-RAID1-disk_rw-ucode=0x5003006/lkp-csl-2sp9/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20210621.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-d8079fac1681-1_20210725.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/md_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/fs_20200714.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/aim7-x86_64-1-1_20210701.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-3.7-4_20200721.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210724-100040/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-rc3-00322-g3cbdec3597d4
repeat_to: 3
:#! user overrides:
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/57e8668f62e2f2fb09bc459d660f2af04aad9255/vmlinuz-5.13.0-rc5-00042-g57e8668f62e2"
dequeue_time: 2021-07-26 12:01:22.504387404 +08:00
:#! /lkp/lkp/.src-20210726-110645/include/site/inn:
job_state: finished
loadavg: 1607.69 805.44 307.78 1/836 12734
start_time: '1627272165'
end_time: '1627272289'
version: "/lkp/lkp/.src-20210726-110717:d9f42258:2879108ed"

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "-r" "brd"
 "modprobe" "brd" "rd_nr=4" "rd_size=12582912"
 "dmsetup" "remove_all"
 "wipefs" "-a" "--force" "/dev/ram0"
 "wipefs" "-a" "--force" "/dev/ram1"
 "wipefs" "-a" "--force" "/dev/ram2"
 "wipefs" "-a" "--force" "/dev/ram3"
 "mdadm" "-q" "--create" "/dev/md0" "--chunk=256" "--level=raid1" "--raid-devices=4" "--force" "--assume-clean" "/dev/ram0" "/dev/ram1" "/dev/ram2" "/dev/ram3"
wipefs -a --force /dev/md0
mkfs -t ext4 -q -F /dev/md0
mkdir -p /fs/md0
mount -t ext4 /dev/md0 /fs/md0

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo "500 32000 128 512" > /proc/sys/kernel/sem
cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 disk_rw
EOF
echo "/fs/md0" > config

	(
		echo lkp-csl-2sp9
		echo disk_rw

		echo 1
		echo 3000
		echo 2
		echo 3000
		echo 1
	) | ./multitask -t &

--CE+1k2dSO48ffgeK--
