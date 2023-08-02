Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1496676CAF3
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjHBKgW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjHBKfy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 06:35:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA822704;
        Wed,  2 Aug 2023 03:31:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A52621AE6;
        Wed,  2 Aug 2023 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690972313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjWWOQPQFSkL0mWkO/+cs41MMQZ19N/fmYdaRbGzo8A=;
        b=cyqmcAJFFOSSlQoCAIiBfb69CkC+oVLi20MF96xlCO/FysUDxhDIIQG+bs1mF9i7Ql9hUC
        mcHISCleXxXNvsG5r9hQv5+U9yANxpktkWnVDKP7Wz2/B7ETHvBXATz8eDsQhO1QBzMPpV
        hkqj6Vc86udTLN8S5WkN++mzZrsZZFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690972313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjWWOQPQFSkL0mWkO/+cs41MMQZ19N/fmYdaRbGzo8A=;
        b=kk/9LKVtaGFr7Lkam8o3KpuhrLTD64IptbcxlZbfLWno1jQQDVpDAxBqgtu4TaYJEVsRNY
        EuPu3awhgElIHDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5102513919;
        Wed,  2 Aug 2023 10:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tXa+E5kwymQqCQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 10:31:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D790AA076B; Wed,  2 Aug 2023 12:31:52 +0200 (CEST)
Date:   Wed, 2 Aug 2023 12:31:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [ext4]  4f3d1e4533:  fio.write_iops -2.5%
 regression
Message-ID: <20230802103152.ae3s43z6yjkhnkee@quack3>
References: <202307190954.683c919b-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202307190954.683c919b-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Wed 19-07-23 10:15:32, kernel test robot wrote:
> kernel test robot noticed a -2.5% regression of fio.write_iops on:
>=20
> commit: 4f3d1e4533b0982034f316ace85415d3bc57e3da ("ext4: Ensure ext4_mb_p=
refetch_fini() is called for all prefetched BGs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

The only explanation I have for this (since the patch only modifies
behavior of background initialization of block groups) is that with the
above mentioned commit, we properly initialize all the groups in the
background (previously we could have mistakenly skipped some) and this
background initialization slows down the fio benchmark a bit. There is
logic in the background initialization to bail out if the disk is busy but
still it interferes with the running workload a bit.

When we do benchmarking in SUSE, we actually make sure to initialize all we
can during mkfs time ("-E lazy_itable_init=3D0" helps) and then also wait
after mount until all the background init & fetching is done to avoid
similar flaky benchmark results (we wait for "ext4lazyinit" kthread to
exit).=20

In either case I don't think there's anything to fix in the kernel in this
case.

								Honza

> testcase: fio-basic
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> parameters:
>=20
> 	runtime: 300s
> 	disk: 1HDD
> 	fs: ext4
> 	nr_task: 1
> 	test_size: 128G
> 	rw: write
> 	bs: 4k
> 	ioengine: sync
> 	cpufreq_governor: performance
>=20
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307190954.683c919b-oliver.san=
g@intel.com
>=20
>=20
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runt=
ime/rw/tbox_group/test_size/testcase:
>   4k/gcc-12/performance/1HDD/ext4/sync/x86_64-rhel-8.3/1/debian-11.1-x86_=
64-20220510.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic
>=20
> commit:=20
>   3c6296046c ("ext4: Don't skip prefetching BLOCK_UNINIT groups")
>   4f3d1e4533 ("ext4: Ensure ext4_mb_prefetch_fini() is called for all pre=
fetched BGs")
>=20
> 3c6296046c85333b 4f3d1e4533b0982034f316ace85=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \ =20
>      96.15            -0.2%      95.95        iostat.cpu.idle
>       3.04            +6.5%       3.23 =B1  2%  iostat.cpu.iowait
>       0.75            +0.5%       0.76        iostat.cpu.system
>       0.06 =B1  2%      -0.1%       0.06 =B1  2%  iostat.cpu.user
>       9.14 =B1 38%     -24.8%       6.88 =B1 50%  perf-c2c.DRAM.local
>      27.43 =B1 17%     -18.9%      22.25 =B1 21%  perf-c2c.DRAM.remote
>      71.57 =B1 12%      -1.8%      70.25 =B1 12%  perf-c2c.HITM.local
>      14.14 =B1 21%     -12.5%      12.38 =B1 25%  perf-c2c.HITM.remote
>      85.71 =B1 11%      -3.6%      82.62 =B1 10%  perf-c2c.HITM.total
>      96.15            -0.2       95.95        mpstat.cpu.all.idle%
>       3.05            +0.2        3.25 =B1  2%  mpstat.cpu.all.iowait%
>       0.59            +0.0        0.59        mpstat.cpu.all.irq%
>       0.03 =B1  5%      +0.0        0.04 =B1  4%  mpstat.cpu.all.soft%
>       0.13            -0.0        0.13        mpstat.cpu.all.sys%
>       0.06 =B1  2%      +0.0        0.06 =B1  2%  mpstat.cpu.all.usr%
>     300.29            +0.0%     300.30        time.elapsed_time
>     300.29            +0.0%     300.30        time.elapsed_time.max
>  1.517e+08            -2.5%  1.479e+08        time.file_system_outputs
>     161.00 =B1  7%      -5.9%     151.50 =B1  7%  time.involuntary_contex=
t_switches
>       8582 =B1 16%      -1.5%       8452 =B1 15%  time.maximum_resident_s=
et_size
>       2253            -0.1%       2251        time.minor_page_faults
>       4096            +0.0%       4096        time.page_size
>      10.57 =B1  4%      -5.4%      10.00        time.percent_of_cpu_this_=
job_got
>      26.40            -2.8%      25.65        time.system_time
>       6.84 =B1  3%      -1.0%       6.77 =B1  3%  time.user_time
>      67547            -1.0%      66872        time.voluntary_context_swit=
ches
>       0.00          -100.0%       0.00        numa-numastat.node0.interle=
ave_hit
>    8172846 =B1 76%     -15.5%    6906019 =B1 94%  numa-numastat.node0.loc=
al_node
>    3555855 =B1 86%     -19.2%    2874774 =B1100%  numa-numastat.node0.num=
a_foreign
>    8213018 =B1 75%     -15.5%    6940189 =B1 94%  numa-numastat.node0.num=
a_hit
>    2322489 =B1115%     +21.8%    2829144 =B1100%  numa-numastat.node0.num=
a_miss
>    2340494 =B1114%     +22.3%    2863278 =B1 98%  numa-numastat.node0.oth=
er_node
>       0.00          -100.0%       0.00        numa-numastat.node1.interle=
ave_hit
>    6046825 =B1109%     +15.0%    6952463 =B1 94%  numa-numastat.node1.loc=
al_node
>    2297905 =B1116%     +23.2%    2829967 =B1100%  numa-numastat.node1.num=
a_foreign
>    6073084 =B1108%     +15.0%    6984658 =B1 94%  numa-numastat.node1.num=
a_hit
>    3533268 =B1 86%     -18.6%    2874774 =B1100%  numa-numastat.node1.num=
a_miss
>    3559280 =B1 86%     -18.3%    2906887 =B1 98%  numa-numastat.node1.oth=
er_node
>      95.71            -0.7%      95.00        vmstat.cpu.id
>       1.00            +0.0%       1.00        vmstat.cpu.sy
>       0.00          -100.0%       0.00        vmstat.cpu.us
>       2.86 =B1 12%      +5.0%       3.00        vmstat.cpu.wa
>       0.86 =B1 40%     +16.7%       1.00        vmstat.io.bi
>     102648            -6.2%      96267 =B1  2%  vmstat.io.bo
>      10886            -0.1%      10880        vmstat.memory.buff
>   62767240            -1.5%   61808853        vmstat.memory.cache
>  1.995e+08            +0.5%  2.005e+08        vmstat.memory.free
>       1.43 =B1 34%     +40.0%       2.00        vmstat.procs.b
>       0.00          -100.0%       0.00        vmstat.procs.r
>       2072            -0.3%       2067 =B1  2%  vmstat.system.cs
>      64874            -0.0%      64845        vmstat.system.in
>      39.29            -0.1%      39.25        turbostat.Avg_MHz
>       1.10            -0.0        1.09        turbostat.Busy%
>       3600            +0.0%       3600        turbostat.Bzy_MHz
>   19501099            +0.0%   19506120        turbostat.C1
>      99.72            +0.0       99.73        turbostat.C1%
>      98.90            +0.0%      98.91        turbostat.CPU%c1
>      80.71 =B1  6%      -2.4%      78.75 =B1  6%  turbostat.CoreTmp
>       0.17 =B1  2%      -0.1%       0.17        turbostat.IPC
>   19675125            +0.0%   19676681        turbostat.IRQ
>       1455 =B1 66%     +87.5%       2728 =B1126%  turbostat.POLL
>      80.29 =B1  5%      -2.5%      78.25 =B1  5%  turbostat.PkgTmp
>     242.65            -1.1%     239.92        turbostat.PkgWatt
>      56.39            -0.3%      56.21        turbostat.RAMWatt
>       3093            +0.0%       3093        turbostat.TSC_MHz
>       0.01            +0.0        0.01        fio.latency_100ms%
>       0.01            +0.0        0.01        fio.latency_100us%
>       0.19            +0.0        0.19        fio.latency_10ms%
>       2.35 =B1  4%      -0.0        2.33 =B1  2%  fio.latency_10us%
>       0.01            +0.0        0.01        fio.latency_20ms%
>       0.10 =B1  4%      +0.0        0.11 =B1  2%  fio.latency_20us%
>       0.01            +0.0        0.01        fio.latency_250ms%
>       0.01            +0.0        0.01        fio.latency_250us%
>       0.01 =B1 63%      +0.0        0.01 =B1 37%  fio.latency_2ms%
>      91.42            +0.2       91.65        fio.latency_2us%
>       0.00 =B1158%      -0.0        0.00 =B1173%  fio.latency_4ms%
>       5.93 =B1  6%      -0.2        5.72 =B1  4%  fio.latency_4us%
>       0.01 =B1 86%      -0.0        0.00 =B1129%  fio.latency_500ms%
>       0.01            +0.0        0.01        fio.latency_50ms%
>       0.01            +0.0        0.01        fio.latency_50us%
>     300.29            +0.0%     300.30        fio.time.elapsed_time
>     300.29            +0.0%     300.30        fio.time.elapsed_time.max
>  1.517e+08            -2.5%  1.479e+08        fio.time.file_system_outputs
>     161.00 =B1  7%      -5.9%     151.50 =B1  7%  fio.time.involuntary_co=
ntext_switches
>       8582 =B1 16%      -1.5%       8452 =B1 15%  fio.time.maximum_reside=
nt_set_size
>       2253            -0.1%       2251        fio.time.minor_page_faults
>       4096            +0.0%       4096        fio.time.page_size
>      10.57 =B1  4%      -5.4%      10.00        fio.time.percent_of_cpu_t=
his_job_got
>      26.40            -2.8%      25.65        fio.time.system_time
>       6.84 =B1  3%      -1.0%       6.77 =B1  3%  fio.time.user_time
>      67547            -1.0%      66872        fio.time.voluntary_context_=
switches
>   18968277            -2.5%   18488028        fio.workload
>     246.98            -2.5%     240.73        fio.write_bw_MBps
>       1923            -0.7%       1910        fio.write_clat_90%_us
>       2466            -1.9%       2420 =B1  3%  fio.write_clat_95%_us
>       4658            -0.7%       4624        fio.write_clat_99%_us
>      15609            +2.6%      16021        fio.write_clat_mean_us
>     359915            +1.7%     366016 =B1  3%  fio.write_clat_stddev
>      63226            -2.5%      61625        fio.write_iops
>      34259            -0.5%      34081        meminfo.Active
>      15516 =B1  2%      -1.1%      15346 =B1  2%  meminfo.Active(anon)
>      18742            -0.0%      18733        meminfo.Active(file)
>     183456 =B1  9%      +0.8%     184983 =B1  5%  meminfo.AnonHugePages
>     341569            -0.1%     341250        meminfo.AnonPages
>      10886            -0.1%      10879        meminfo.Buffers
>   60957435            -1.5%   60027353        meminfo.Cached
>  1.319e+08            +0.0%  1.319e+08        meminfo.CommitLimit
>     702695            -0.1%     702335        meminfo.Committed_AS
>  2.588e+08            +0.2%  2.594e+08        meminfo.DirectMap1G
>   10966162 =B1 10%      -4.9%   10427904 =B1 39%  meminfo.DirectMap2M
>     364262 =B1 22%      -1.3%     359508 =B1 20%  meminfo.DirectMap4k
>   43195034            +0.0%   43202254        meminfo.Dirty
>       2048            +0.0%       2048        meminfo.Hugepagesize
>   58491167            -1.6%   57560868        meminfo.Inactive
>     349043            -0.1%     348651        meminfo.Inactive(anon)
>   58142123            -1.6%   57212216        meminfo.Inactive(file)
>    1735123            -1.5%    1708705        meminfo.KReclaimable
>      14107            -0.4%      14052        meminfo.KernelStack
>      34533            -0.2%      34454        meminfo.Mapped
>  2.576e+08            +0.0%  2.576e+08        meminfo.MemAvailable
>  1.996e+08            +0.5%  2.005e+08        meminfo.MemFree
>  2.638e+08            +0.0%  2.638e+08        meminfo.MemTotal
>   64201413            -1.5%   63238211        meminfo.Memused
>       0.00       +8.8e+101%       0.88 =B1264%  meminfo.Mlocked
>       4328            -0.0%       4326        meminfo.PageTables
>      29433            +0.7%      29625        meminfo.Percpu
>    1735123            -1.5%    1708705        meminfo.SReclaimable
>     346996            -1.3%     342564        meminfo.SUnreclaim
>      22771            -0.8%      22598        meminfo.Shmem
>    2082120            -1.5%    2051270        meminfo.Slab
>    2784647            -0.0%    2784646        meminfo.Unevictable
>  1.374e+13            +0.0%  1.374e+13        meminfo.VmallocTotal
>     250145            -0.3%     249431        meminfo.VmallocUsed
>      13834 =B1  3%      +1.9%      14097 =B1  3%  meminfo.Writeback
>   64202772            -1.5%   63239679        meminfo.max_used_kB
>      10408 =B1 67%      -7.4%       9639 =B1 75%  numa-meminfo.node0.Acti=
ve
>       1197 =B1 30%      +3.6%       1240 =B1 23%  numa-meminfo.node0.Acti=
ve(anon)
>       9211 =B1 73%      -8.8%       8399 =B1 84%  numa-meminfo.node0.Acti=
ve(file)
>      57593 =B1123%      +1.5%      58464 =B1 85%  numa-meminfo.node0.Anon=
HugePages
>     132128 =B1 64%      +2.0%     134798 =B1 40%  numa-meminfo.node0.Anon=
Pages
>     164460 =B1 51%     +16.2%     191141 =B1 38%  numa-meminfo.node0.Anon=
Pages.max
>   21956572 =B1 14%      -1.7%   21582624 =B1 14%  numa-meminfo.node0.Dirty
>   32542746 =B1 29%      -8.7%   29698542 =B1 34%  numa-meminfo.node0.File=
Pages
>   31041556 =B1 31%      -7.5%   28726429 =B1 34%  numa-meminfo.node0.Inac=
tive
>     138298 =B1 61%      +1.1%     139843 =B1 39%  numa-meminfo.node0.Inac=
tive(anon)
>   30903257 =B1 31%      -7.5%   28586585 =B1 34%  numa-meminfo.node0.Inac=
tive(file)
>    1005600 =B1 77%     -16.2%     842773 =B1 95%  numa-meminfo.node0.KRec=
laimable
>       7284 =B1  6%      +2.2%       7447 =B1  7%  numa-meminfo.node0.Kern=
elStack
>      19938 =B1 75%     -32.6%      13431 =B1112%  numa-meminfo.node0.Mapp=
ed
>   97440244 =B1 10%      +3.1%  1.005e+08 =B1 11%  numa-meminfo.node0.MemF=
ree
>  1.317e+08            +0.0%  1.317e+08        numa-meminfo.node0.MemTotal
>   34256594 =B1 30%      -8.8%   31228527 =B1 35%  numa-meminfo.node0.MemU=
sed
>       0.00       +1.2e+101%       0.12 =B1264%  numa-meminfo.node0.Mlocked
>       2321 =B1 13%      -2.8%       2257 =B1 16%  numa-meminfo.node0.Page=
Tables
>    1005600 =B1 77%     -16.2%     842773 =B1 95%  numa-meminfo.node0.SRec=
laimable
>     196324 =B1 46%      -9.8%     177055 =B1 53%  numa-meminfo.node0.SUnr=
eclaim
>       6963 =B1 16%      -7.2%       6465 =B1 23%  numa-meminfo.node0.Shmem
>    1201925 =B1 72%     -15.2%    1019829 =B1 88%  numa-meminfo.node0.Slab
>    1623293 =B1 75%     -32.4%    1097072 =B1114%  numa-meminfo.node0.Unev=
ictable
>       7266 =B1 61%      -2.6%       7074 =B1 77%  numa-meminfo.node0.Writ=
eback
>      23841 =B1 29%      +2.4%      24425 =B1 30%  numa-meminfo.node1.Acti=
ve
>      14310 =B1  4%      -1.5%      14090 =B1  4%  numa-meminfo.node1.Acti=
ve(anon)
>       9530 =B1 71%      +8.4%      10334 =B1 68%  numa-meminfo.node1.Acti=
ve(file)
>     125879 =B1 56%      +0.5%     126531 =B1 47%  numa-meminfo.node1.Anon=
HugePages
>     209495 =B1 40%      -1.4%     206536 =B1 27%  numa-meminfo.node1.Anon=
Pages
>     280959 =B1 34%      -0.5%     279649 =B1 19%  numa-meminfo.node1.Anon=
Pages.max
>   21239244 =B1 15%      +1.8%   21619480 =B1 14%  numa-meminfo.node1.Dirty
>   28426462 =B1 33%      +6.7%   30334457 =B1 33%  numa-meminfo.node1.File=
Pages
>   27450562 =B1 35%      +5.0%   28829304 =B1 34%  numa-meminfo.node1.Inac=
tive
>     210811 =B1 40%      -0.9%     208902 =B1 27%  numa-meminfo.node1.Inac=
tive(anon)
>   27239751 =B1 35%      +5.1%   28620401 =B1 34%  numa-meminfo.node1.Inac=
tive(file)
>     729558 =B1107%     +18.7%     865777 =B1 93%  numa-meminfo.node1.KRec=
laimable
>       6817 =B1  7%      -3.1%       6604 =B1  9%  numa-meminfo.node1.Kern=
elStack
>      14618 =B1103%     +44.0%      21046 =B1 71%  numa-meminfo.node1.Mapp=
ed
>  1.021e+08 =B1 10%      -2.0%  1.001e+08 =B1 11%  numa-meminfo.node1.MemF=
ree
>  1.321e+08            +0.0%  1.321e+08        numa-meminfo.node1.MemTotal
>   29945714 =B1 34%      +6.9%   32004426 =B1 35%  numa-meminfo.node1.MemU=
sed
>       0.00       +1.6e+102%       1.62 =B1264%  numa-meminfo.node1.Mlocked
>       2000 =B1 15%      +3.4%       2069 =B1 17%  numa-meminfo.node1.Page=
Tables
>     729558 =B1107%     +18.7%     865777 =B1 93%  numa-meminfo.node1.SRec=
laimable
>     150687 =B1 61%      +9.8%     165494 =B1 57%  numa-meminfo.node1.SUnr=
eclaim
>      15808 =B1  8%      +2.0%      16127 =B1 11%  numa-meminfo.node1.Shmem
>     880247 =B1 99%     +17.2%    1031272 =B1 87%  numa-meminfo.node1.Slab
>    1161353 =B1105%     +45.3%    1687573 =B1 74%  numa-meminfo.node1.Unev=
ictable
>       6488 =B1 75%     +10.4%       7160 =B1 76%  numa-meminfo.node1.Writ=
eback
>     165.57 =B1 24%      -1.4%     163.25 =B1 22%  proc-vmstat.direct_map_=
level2_splits
>       5.43 =B1 29%     -10.2%       4.88 =B1 80%  proc-vmstat.direct_map_=
level3_splits
>       3878 =B1  2%      -1.1%       3836 =B1  2%  proc-vmstat.nr_active_a=
non
>       4685            -0.0%       4683        proc-vmstat.nr_active_file
>      85391            -0.1%      85312        proc-vmstat.nr_anon_pages
>      89.00 =B1 10%      +0.8%      89.75 =B1  5%  proc-vmstat.nr_anon_tra=
nsparent_hugepages
>   18969312            -2.5%   18489055        proc-vmstat.nr_dirtied
>   10798854            +0.0%   10800591        proc-vmstat.nr_dirty
>    6405343            +0.0%    6406173        proc-vmstat.nr_dirty_backgr=
ound_threshold
>   12826349            +0.0%   12828011        proc-vmstat.nr_dirty_thresh=
old
>   15242782            -1.5%   15009879        proc-vmstat.nr_file_pages
>   49891205            +0.5%   50132381        proc-vmstat.nr_free_pages
>      87261            -0.1%      87162        proc-vmstat.nr_inactive_anon
>   14536233            -1.6%   14303375        proc-vmstat.nr_inactive_file
>       0.00       +1.2e+101%       0.12 =B1264%  proc-vmstat.nr_isolated_a=
non
>      14105            -0.4%      14051        proc-vmstat.nr_kernel_stack
>       8633            -0.2%       8613        proc-vmstat.nr_mapped
>       0.00       +1.2e+101%       0.12 =B1264%  proc-vmstat.nr_mlock
>       1081            -0.0%       1081        proc-vmstat.nr_page_table_p=
ages
>       5693            -0.8%       5649        proc-vmstat.nr_shmem
>     433799            -1.5%     427185        proc-vmstat.nr_slab_reclaim=
able
>      86751            -1.3%      85642        proc-vmstat.nr_slab_unrecla=
imable
>     696161            -0.0%     696161        proc-vmstat.nr_unevictable
>       3460 =B1  4%      +2.1%       3531 =B1  3%  proc-vmstat.nr_writeback
>    7758636            -6.2%    7277165 =B1  2%  proc-vmstat.nr_written
>       3878 =B1  2%      -1.1%       3836 =B1  2%  proc-vmstat.nr_zone_act=
ive_anon
>       4685            -0.0%       4683        proc-vmstat.nr_zone_active_=
file
>      87261            -0.1%      87162        proc-vmstat.nr_zone_inactiv=
e_anon
>   14536233            -1.6%   14303375        proc-vmstat.nr_zone_inactiv=
e_file
>     696161            -0.0%     696161        proc-vmstat.nr_zone_unevict=
able
>   10802315            +0.0%   10804123        proc-vmstat.nr_zone_write_p=
ending
>    5853761 =B1  8%      -2.5%    5704742 =B1  4%  proc-vmstat.numa_foreign
>       1000 =B1242%    +280.2%       3802 =B1102%  proc-vmstat.numa_hint_f=
aults
>       6.29 =B1148%   +9970.5%     633.00 =B1244%  proc-vmstat.numa_hint_f=
aults_local
>   14288500 =B1  3%      -2.5%   13927181        proc-vmstat.numa_hit
>       6.43 =B1173%    +269.4%      23.75 =B1112%  proc-vmstat.numa_huge_p=
te_updates
>       0.00          -100.0%       0.00        proc-vmstat.numa_interleave
>   14222068 =B1  3%      -2.5%   13860816        proc-vmstat.numa_local
>    5855757 =B1  7%      -2.6%    5703919 =B1  4%  proc-vmstat.numa_miss
>    5899774 =B1  8%      -2.2%    5770166 =B1  3%  proc-vmstat.numa_other
>       1358 =B1244%    +373.0%       6426 =B1104%  proc-vmstat.numa_pages_=
migrated
>       5538 =B1161%    +261.5%      20020 =B1 82%  proc-vmstat.numa_pte_up=
dates
>       7927 =B1  4%      -0.3%       7903 =B1  4%  proc-vmstat.pgactivate
>   20287900            -2.4%   19799295        proc-vmstat.pgalloc_normal
>     692551            +0.5%     695757        proc-vmstat.pgfault
>     703292            +0.6%     707503        proc-vmstat.pgfree
>       1358 =B1244%    +373.0%       6426 =B1104%  proc-vmstat.pgmigrate_s=
uccess
>     281.14 =B1 40%     +16.7%     328.00        proc-vmstat.pgpgin
>   31054498            -6.2%   29131770 =B1  2%  proc-vmstat.pgpgout
>      29285            +1.0%      29579        proc-vmstat.pgreuse
>     114.86 =B1  5%      -1.1%     113.62 =B1  4%  proc-vmstat.thp_collaps=
e_alloc
>       0.29 =B1244%     +75.0%       0.50 =B1141%  proc-vmstat.thp_deferre=
d_split_page
>       8.43 =B1  8%      +2.3%       8.62 =B1  9%  proc-vmstat.thp_fault_a=
lloc
>       0.71 =B1244%    +792.5%       6.38 =B1119%  proc-vmstat.thp_migrati=
on_success
>       0.29 =B1244%     +75.0%       0.50 =B1141%  proc-vmstat.thp_split_p=
md
>       0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_a=
lloc
>      33.29 =B1134%     +27.3%      42.38 =B1114%  proc-vmstat.unevictable=
_pgs_culled
>       0.00       +7.6e+103%      75.88 =B1264%  proc-vmstat.unevictable_p=
gs_mlocked
>       0.00         +5e+101%       0.50 =B1264%  proc-vmstat.unevictable_p=
gs_munlocked
>       0.00         +5e+101%       0.50 =B1264%  proc-vmstat.unevictable_p=
gs_rescued
>    2296763            -0.0%    2296608        proc-vmstat.unevictable_pgs=
_scanned
>     299.00 =B1 30%      +3.6%     309.75 =B1 23%  numa-vmstat.node0.nr_ac=
tive_anon
>       2302 =B1 73%      -8.8%       2099 =B1 84%  numa-vmstat.node0.nr_ac=
tive_file
>      33031 =B1 64%      +2.0%      33699 =B1 40%  numa-vmstat.node0.nr_an=
on_pages
>      27.86 =B1124%      +1.0%      28.12 =B1 87%  numa-vmstat.node0.nr_an=
on_transparent_hugepages
>    9907211 =B1 33%      -7.0%    9211522 =B1 38%  numa-vmstat.node0.nr_di=
rtied
>    5489159 =B1 14%      -1.7%    5395664 =B1 14%  numa-vmstat.node0.nr_di=
rty
>    8136061 =B1 29%      -8.7%    7424899 =B1 34%  numa-vmstat.node0.nr_fi=
le_pages
>   24359684 =B1 10%      +3.1%   25116813 =B1 11%  numa-vmstat.node0.nr_fr=
ee_pages
>      34574 =B1 61%      +1.1%      34960 =B1 39%  numa-vmstat.node0.nr_in=
active_anon
>    7726189 =B1 31%      -7.5%    7146910 =B1 34%  numa-vmstat.node0.nr_in=
active_file
>       0.14 =B1244%    -100.0%       0.00        numa-vmstat.node0.nr_isol=
ated_anon
>       7284 =B1  6%      +2.3%       7454 =B1  7%  numa-vmstat.node0.nr_ke=
rnel_stack
>       4985 =B1 75%     -32.6%       3357 =B1112%  numa-vmstat.node0.nr_ma=
pped
>       0.00          -100.0%       0.00        numa-vmstat.node0.nr_mlock
>     580.00 =B1 13%      -2.8%     563.88 =B1 16%  numa-vmstat.node0.nr_pa=
ge_table_pages
>       1740 =B1 16%      -7.2%       1616 =B1 23%  numa-vmstat.node0.nr_sh=
mem
>     251410 =B1 77%     -16.2%     210700 =B1 95%  numa-vmstat.node0.nr_sl=
ab_reclaimable
>      49082 =B1 46%      -9.8%      44264 =B1 53%  numa-vmstat.node0.nr_sl=
ab_unreclaimable
>     405822 =B1 75%     -32.4%     274267 =B1114%  numa-vmstat.node0.nr_un=
evictable
>       1843 =B1 59%      -3.6%       1776 =B1 79%  numa-vmstat.node0.nr_wr=
iteback
>    4222687 =B1 61%     -14.6%    3607998 =B1 78%  numa-vmstat.node0.nr_wr=
itten
>     299.00 =B1 30%      +3.6%     309.75 =B1 23%  numa-vmstat.node0.nr_zo=
ne_active_anon
>       2302 =B1 73%      -8.8%       2099 =B1 84%  numa-vmstat.node0.nr_zo=
ne_active_file
>      34574 =B1 61%      +1.1%      34960 =B1 39%  numa-vmstat.node0.nr_zo=
ne_inactive_anon
>    7726188 =B1 31%      -7.5%    7146910 =B1 34%  numa-vmstat.node0.nr_zo=
ne_inactive_file
>     405822 =B1 75%     -32.4%     274267 =B1114%  numa-vmstat.node0.nr_zo=
ne_unevictable
>    5491002 =B1 14%      -1.7%    5397440 =B1 14%  numa-vmstat.node0.nr_zo=
ne_write_pending
>    3555855 =B1 86%     -19.2%    2874774 =B1100%  numa-vmstat.node0.numa_=
foreign
>    8213113 =B1 75%     -15.5%    6940388 =B1 94%  numa-vmstat.node0.numa_=
hit
>       0.00          -100.0%       0.00        numa-vmstat.node0.numa_inte=
rleave
>    8172940 =B1 76%     -15.5%    6906217 =B1 94%  numa-vmstat.node0.numa_=
local
>    2322489 =B1115%     +21.8%    2829144 =B1100%  numa-vmstat.node0.numa_=
miss
>    2340494 =B1114%     +22.3%    2863278 =B1 98%  numa-vmstat.node0.numa_=
other
>       3577 =B1  4%      -1.5%       3522 =B1  4%  numa-vmstat.node1.nr_ac=
tive_anon
>       2382 =B1 71%      +8.4%       2583 =B1 68%  numa-vmstat.node1.nr_ac=
tive_file
>      52374 =B1 40%      -1.4%      51633 =B1 27%  numa-vmstat.node1.nr_an=
on_pages
>      61.00 =B1 56%      +0.4%      61.25 =B1 48%  numa-vmstat.node1.nr_an=
on_transparent_hugepages
>    9062101 =B1 36%      +2.4%    9277522 =B1 38%  numa-vmstat.node1.nr_di=
rtied
>    5309855 =B1 15%      +1.8%    5404888 =B1 14%  numa-vmstat.node1.nr_di=
rty
>    7107018 =B1 33%      +6.7%    7583852 =B1 33%  numa-vmstat.node1.nr_fi=
le_pages
>   25531215 =B1 10%      -2.0%   25016703 =B1 11%  numa-vmstat.node1.nr_fr=
ee_pages
>      52704 =B1 40%      -0.9%      52226 =B1 27%  numa-vmstat.node1.nr_in=
active_anon
>    6810339 =B1 35%      +5.1%    7155338 =B1 34%  numa-vmstat.node1.nr_in=
active_file
>       6818 =B1  7%      -3.2%       6602 =B1  9%  numa-vmstat.node1.nr_ke=
rnel_stack
>       3654 =B1103%     +44.0%       5262 =B1 71%  numa-vmstat.node1.nr_ma=
pped
>       0.00       +3.8e+101%       0.38 =B1264%  numa-vmstat.node1.nr_mlock
>     499.57 =B1 15%      +3.4%     516.62 =B1 17%  numa-vmstat.node1.nr_pa=
ge_table_pages
>       3952 =B1  8%      +2.0%       4032 =B1 11%  numa-vmstat.node1.nr_sh=
mem
>     182398 =B1107%     +18.7%     216450 =B1 93%  numa-vmstat.node1.nr_sl=
ab_reclaimable
>      37673 =B1 61%      +9.8%      41373 =B1 57%  numa-vmstat.node1.nr_sl=
ab_unreclaimable
>     290337 =B1105%     +45.3%     421892 =B1 74%  numa-vmstat.node1.nr_un=
evictable
>       1627 =B1 74%     +10.1%       1791 =B1 78%  numa-vmstat.node1.nr_wr=
iteback
>    3536416 =B1 73%      +3.7%    3666622 =B1 76%  numa-vmstat.node1.nr_wr=
itten
>       3577 =B1  4%      -1.5%       3522 =B1  4%  numa-vmstat.node1.nr_zo=
ne_active_anon
>       2382 =B1 71%      +8.4%       2583 =B1 68%  numa-vmstat.node1.nr_zo=
ne_active_file
>      52704 =B1 40%      -0.9%      52226 =B1 27%  numa-vmstat.node1.nr_zo=
ne_inactive_anon
>    6810339 =B1 35%      +5.1%    7155337 =B1 34%  numa-vmstat.node1.nr_zo=
ne_inactive_file
>     290337 =B1105%     +45.3%     421892 =B1 74%  numa-vmstat.node1.nr_zo=
ne_unevictable
>    5311484 =B1 15%      +1.8%    5406680 =B1 14%  numa-vmstat.node1.nr_zo=
ne_write_pending
>    2297905 =B1116%     +23.2%    2829967 =B1100%  numa-vmstat.node1.numa_=
foreign
>    6073045 =B1108%     +15.0%    6984946 =B1 94%  numa-vmstat.node1.numa_=
hit
>       0.00          -100.0%       0.00        numa-vmstat.node1.numa_inte=
rleave
>    6046786 =B1109%     +15.0%    6952751 =B1 94%  numa-vmstat.node1.numa_=
local
>    3533268 =B1 86%     -18.6%    2874774 =B1100%  numa-vmstat.node1.numa_=
miss
>    3559280 =B1 86%     -18.3%    2906887 =B1 98%  numa-vmstat.node1.numa_=
other
>       6.32            -0.6%       6.29        perf-stat.i.MPKI
>  2.319e+08            -1.7%   2.28e+08        perf-stat.i.branch-instruct=
ions
>       0.71            +0.0        0.73        perf-stat.i.branch-miss-rat=
e%
>    1688722            -0.3%    1684085        perf-stat.i.branch-misses
>      20.82 =B1  2%      -1.0       19.85        perf-stat.i.cache-miss-ra=
te%
>    1681590            -4.2%    1610595        perf-stat.i.cache-misses
>    7493340            -1.7%    7369155        perf-stat.i.cache-references
>       2026            -0.2%       2022 =B1  2%  perf-stat.i.context-switc=
hes
>       2.00 =B1  2%      +1.3%       2.03 =B1  2%  perf-stat.i.cpi
>      64001            +0.0%      64002        perf-stat.i.cpu-clock
>  1.831e+09 =B1  2%      -1.0%  1.813e+09 =B1  2%  perf-stat.i.cpu-cycles
>      69.37            +0.2%      69.50        perf-stat.i.cpu-migrations
>       1587 =B1  2%      +7.7%       1709 =B1  3%  perf-stat.i.cycles-betw=
een-cache-misses
>       0.03 =B1 15%      +0.0        0.03 =B1  5%  perf-stat.i.dTLB-load-m=
iss-rate%
>      59316 =B1 14%      -1.9%      58180 =B1  4%  perf-stat.i.dTLB-load-m=
isses
>  3.092e+08            -1.5%  3.045e+08        perf-stat.i.dTLB-loads
>       0.01 =B1  2%      +0.0        0.01 =B1  4%  perf-stat.i.dTLB-store-=
miss-rate%
>      13664 =B1  2%      -0.8%      13548 =B1  3%  perf-stat.i.dTLB-store-=
misses
>  1.586e+08            -1.6%  1.561e+08        perf-stat.i.dTLB-stores
>  1.131e+09            -1.7%  1.112e+09        perf-stat.i.instructions
>       0.53 =B1  2%      -1.2%       0.53        perf-stat.i.ipc
>       0.01 =B1130%    +155.9%       0.02 =B1 58%  perf-stat.i.major-faults
>       0.03 =B1  2%      -1.1%       0.03 =B1  2%  perf-stat.i.metric.GHz
>     133.49            -1.8%     131.15        perf-stat.i.metric.K/sec
>      10.93            -1.6%      10.76        perf-stat.i.metric.M/sec
>       1913            +0.5%       1923        perf-stat.i.minor-faults
>      70.37 =B1  5%      -3.1       67.30 =B1  7%  perf-stat.i.node-load-m=
iss-rate%
>      74229 =B1 10%     -15.1%      62993 =B1 13%  perf-stat.i.node-load-m=
isses
>      36203 =B1  9%      -3.6%      34893 =B1  9%  perf-stat.i.node-loads
>      22.33 =B1 14%      -3.0       19.35 =B1  9%  perf-stat.i.node-store-=
miss-rate%
>     304517 =B1  8%      -4.0%     292217 =B1  5%  perf-stat.i.node-store-=
misses
>     705246 =B1  3%      -2.4%     687973        perf-stat.i.node-stores
>       1913            +0.5%       1923        perf-stat.i.page-faults
>      64001            +0.0%      64002        perf-stat.i.task-clock
>       6.63            -0.0%       6.63        perf-stat.overall.MPKI
>       0.73            +0.0        0.74        perf-stat.overall.branch-mi=
ss-rate%
>      22.44            -0.6       21.86        perf-stat.overall.cache-mis=
s-rate%
>       1.62 =B1  2%      +0.6%       1.63        perf-stat.overall.cpi
>       1089            +3.4%       1125 =B1  2%  perf-stat.overall.cycles-=
between-cache-misses
>       0.02 =B1 14%      -0.0        0.02 =B1  5%  perf-stat.overall.dTLB-=
load-miss-rate%
>       0.01 =B1  2%      +0.0        0.01 =B1  3%  perf-stat.overall.dTLB-=
store-miss-rate%
>       0.62 =B1  2%      -0.7%       0.61        perf-stat.overall.ipc
>      67.11 =B1  4%      -3.0       64.09 =B1  7%  perf-stat.overall.node-=
load-miss-rate%
>      30.14 =B1  8%      -0.3       29.79 =B1  3%  perf-stat.overall.node-=
store-miss-rate%
>      17876            +1.0%      18051        perf-stat.overall.path-leng=
th
>  2.311e+08            -1.7%  2.272e+08        perf-stat.ps.branch-instruc=
tions
>    1682635            -0.3%    1678039        perf-stat.ps.branch-misses
>    1675559            -4.2%    1604789        perf-stat.ps.cache-misses
>    7466545            -1.7%    7342786        perf-stat.ps.cache-referenc=
es
>       2019            -0.2%       2015 =B1  2%  perf-stat.ps.context-swit=
ches
>      63788            +0.0%      63789        perf-stat.ps.cpu-clock
>  1.825e+09 =B1  2%      -1.0%  1.806e+09 =B1  2%  perf-stat.ps.cpu-cycles
>      69.20            +0.2%      69.32        perf-stat.ps.cpu-migrations
>      59121 =B1 14%      -1.9%      57988 =B1  4%  perf-stat.ps.dTLB-load-=
misses
>  3.081e+08            -1.5%  3.034e+08        perf-stat.ps.dTLB-loads
>      13616 =B1  2%      -0.8%      13501 =B1  3%  perf-stat.ps.dTLB-store=
-misses
>   1.58e+08            -1.6%  1.555e+08        perf-stat.ps.dTLB-stores
>  1.127e+09            -1.7%  1.108e+09        perf-stat.ps.instructions
>       0.01 =B1130%    +155.9%       0.02 =B1 58%  perf-stat.ps.major-faul=
ts
>       1906            +0.5%       1916        perf-stat.ps.minor-faults
>      73981 =B1 10%     -15.1%      62784 =B1 13%  perf-stat.ps.node-load-=
misses
>      36087 =B1  9%      -3.6%      34783 =B1  9%  perf-stat.ps.node-loads
>     303335 =B1  8%      -4.0%     291086 =B1  5%  perf-stat.ps.node-store=
-misses
>     702698 =B1  3%      -2.5%     685445        perf-stat.ps.node-stores
>       1906            +0.5%       1916        perf-stat.ps.page-faults
>      63788            +0.0%      63789        perf-stat.ps.task-clock
>  3.391e+11            -1.6%  3.337e+11        perf-stat.total.instructions
>      10.54 =B1244%     +36.1%      14.35 =B1130%  sched_debug.cfs_rq:/.MI=
N_vruntime.avg
>     674.87 =B1244%     +36.1%     918.59 =B1130%  sched_debug.cfs_rq:/.MI=
N_vruntime.max
>       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vr=
untime.min
>      83.70 =B1244%     +36.1%     113.92 =B1130%  sched_debug.cfs_rq:/.MI=
N_vruntime.stddev
>       0.09 =B1  5%      +0.9%       0.09 =B1  8%  sched_debug.cfs_rq:/.h_=
nr_running.avg
>       1.00            +0.0%       1.00        sched_debug.cfs_rq:/.h_nr_r=
unning.max
>       0.27 =B1  2%      -1.0%       0.26 =B1  4%  sched_debug.cfs_rq:/.h_=
nr_running.stddev
>      43132 =B1  8%      -5.5%      40747 =B1 12%  sched_debug.cfs_rq:/.lo=
ad.avg
>    1009035 =B1  4%      +0.1%    1009841 =B1  4%  sched_debug.cfs_rq:/.lo=
ad.max
>     178967 =B1  3%      -2.6%     174319 =B1  5%  sched_debug.cfs_rq:/.lo=
ad.stddev
>      66.29 =B1 10%      -8.0%      60.95 =B1 10%  sched_debug.cfs_rq:/.lo=
ad_avg.avg
>       1106 =B1  7%      -5.8%       1042 =B1  7%  sched_debug.cfs_rq:/.lo=
ad_avg.max
>     224.95 =B1  4%      -5.2%     213.21 =B1  7%  sched_debug.cfs_rq:/.lo=
ad_avg.stddev
>      10.54 =B1244%     +36.1%      14.35 =B1130%  sched_debug.cfs_rq:/.ma=
x_vruntime.avg
>     674.87 =B1244%     +36.1%     918.59 =B1130%  sched_debug.cfs_rq:/.ma=
x_vruntime.max
>       0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vr=
untime.min
>      83.70 =B1244%     +36.1%     113.92 =B1130%  sched_debug.cfs_rq:/.ma=
x_vruntime.stddev
>      13566 =B1 16%     +11.3%      15094 =B1 21%  sched_debug.cfs_rq:/.mi=
n_vruntime.avg
>      28371 =B1 14%      -0.4%      28244 =B1 10%  sched_debug.cfs_rq:/.mi=
n_vruntime.max
>       6773 =B1 17%      +7.8%       7301 =B1 43%  sched_debug.cfs_rq:/.mi=
n_vruntime.min
>       3925 =B1 14%      +4.1%       4085 =B1 13%  sched_debug.cfs_rq:/.mi=
n_vruntime.stddev
>       0.09 =B1  5%      +0.9%       0.09 =B1  8%  sched_debug.cfs_rq:/.nr=
_running.avg
>       1.00            +0.0%       1.00        sched_debug.cfs_rq:/.nr_run=
ning.max
>       0.27 =B1  2%      -1.0%       0.26 =B1  4%  sched_debug.cfs_rq:/.nr=
_running.stddev
>      30.01 =B1 26%     -13.0%      26.10 =B1 19%  sched_debug.cfs_rq:/.re=
moved.load_avg.avg
>     512.00 =B1 39%      +0.0%     512.00 =B1 40%  sched_debug.cfs_rq:/.re=
moved.load_avg.max
>     108.94 =B1 31%      -4.4%     104.14 =B1 29%  sched_debug.cfs_rq:/.re=
moved.load_avg.stddev
>      12.70 =B1 28%     -15.4%      10.74 =B1 25%  sched_debug.cfs_rq:/.re=
moved.runnable_avg.avg
>     259.81 =B1 39%      -0.7%     258.08 =B1 40%  sched_debug.cfs_rq:/.re=
moved.runnable_avg.max
>      49.80 =B1 34%      -5.6%      47.02 =B1 35%  sched_debug.cfs_rq:/.re=
moved.runnable_avg.stddev
>      12.70 =B1 28%     -15.4%      10.74 =B1 25%  sched_debug.cfs_rq:/.re=
moved.util_avg.avg
>     259.81 =B1 39%      -0.7%     258.08 =B1 40%  sched_debug.cfs_rq:/.re=
moved.util_avg.max
>      49.80 =B1 34%      -5.6%      47.02 =B1 35%  sched_debug.cfs_rq:/.re=
moved.util_avg.stddev
>     104.40 =B1  3%      -3.0%     101.32 =B1  3%  sched_debug.cfs_rq:/.ru=
nnable_avg.avg
>     699.88 =B1  7%      +0.5%     703.42 =B1 11%  sched_debug.cfs_rq:/.ru=
nnable_avg.max
>     144.26 =B1  8%      -2.0%     141.39 =B1  7%  sched_debug.cfs_rq:/.ru=
nnable_avg.stddev
>       1296 =B1196%     -93.0%      90.97 =B15015%  sched_debug.cfs_rq:/.s=
pread0.avg
>      16100 =B1 33%     -17.8%      13242 =B1 39%  sched_debug.cfs_rq:/.sp=
read0.max
>      -5496           +40.1%      -7700        sched_debug.cfs_rq:/.spread=
0.min
>       3925 =B1 14%      +4.1%       4084 =B1 13%  sched_debug.cfs_rq:/.sp=
read0.stddev
>     104.31 =B1  3%      -2.9%     101.26 =B1  3%  sched_debug.cfs_rq:/.ut=
il_avg.avg
>     699.86 =B1  7%      +0.5%     703.31 =B1 11%  sched_debug.cfs_rq:/.ut=
il_avg.max
>     144.20 =B1  8%      -2.0%     141.33 =B1  7%  sched_debug.cfs_rq:/.ut=
il_avg.stddev
>      10.35 =B1 16%      -3.2%      10.02 =B1 13%  sched_debug.cfs_rq:/.ut=
il_est_enqueued.avg
>     237.48 =B1 10%      -2.0%     232.62 =B1  9%  sched_debug.cfs_rq:/.ut=
il_est_enqueued.max
>      40.11 =B1 10%      -3.4%      38.75 =B1 11%  sched_debug.cfs_rq:/.ut=
il_est_enqueued.stddev
>     938250 =B1  3%      -0.5%     933185 =B1  3%  sched_debug.cpu.avg_idl=
e.avg
>    1098159 =B1 14%      +1.4%    1114007 =B1 14%  sched_debug.cpu.avg_idl=
e.max
>     446053 =B1  9%      +6.1%     473179 =B1 18%  sched_debug.cpu.avg_idl=
e.min
>     129839 =B1 25%      -0.5%     129157 =B1 19%  sched_debug.cpu.avg_idl=
e.stddev
>     213403 =B1  2%     +10.1%     234962 =B1 16%  sched_debug.cpu.clock.a=
vg
>     213405 =B1  2%     +10.1%     234963 =B1 16%  sched_debug.cpu.clock.m=
ax
>     213401 =B1  2%     +10.1%     234960 =B1 16%  sched_debug.cpu.clock.m=
in
>       1.00 =B1  3%      +3.3%       1.04 =B1  2%  sched_debug.cpu.clock.s=
tddev
>     211784 =B1  2%      +9.7%     232324 =B1 16%  sched_debug.cpu.clock_t=
ask.avg
>     212396 =B1  2%     +10.0%     233709 =B1 16%  sched_debug.cpu.clock_t=
ask.max
>     196698            +0.6%     197824        sched_debug.cpu.clock_task.=
min
>       1944 =B1 29%    +125.9%       4393 =B1108%  sched_debug.cpu.clock_t=
ask.stddev
>     294.42 =B1 10%      +4.7%     308.20 =B1  3%  sched_debug.cpu.curr->p=
id.avg
>       7518            -0.1%       7514        sched_debug.cpu.curr->pid.m=
ax
>       1191 =B1  3%      +1.0%       1203        sched_debug.cpu.curr->pid=
=2Estddev
>     516499 =B1  6%      -0.1%     516017 =B1  6%  sched_debug.cpu.max_idl=
e_balance_cost.avg
>     584334 =B1 16%      +1.7%     594376 =B1 14%  sched_debug.cpu.max_idl=
e_balance_cost.max
>     500000            +0.0%     500000        sched_debug.cpu.max_idle_ba=
lance_cost.min
>      17972 =B1143%     +18.7%      21340 =B1129%  sched_debug.cpu.max_idl=
e_balance_cost.stddev
>       4294            +0.0%       4294        sched_debug.cpu.next_balanc=
e.avg
>       4294            +0.0%       4294        sched_debug.cpu.next_balanc=
e.max
>       4294            +0.0%       4294        sched_debug.cpu.next_balanc=
e.min
>       0.00 =B1 24%     +17.1%       0.00 =B1 26%  sched_debug.cpu.next_ba=
lance.stddev
>       0.07 =B1 12%      +6.0%       0.07 =B1  5%  sched_debug.cpu.nr_runn=
ing.avg
>       1.00            +0.0%       1.00        sched_debug.cpu.nr_running.=
max
>       0.21 =B1  8%      +3.2%       0.22        sched_debug.cpu.nr_runnin=
g.stddev
>      11488            +0.3%      11525        sched_debug.cpu.nr_switches=
=2Eavg
>     210532 =B1  2%      -0.1%     210227        sched_debug.cpu.nr_switch=
es.max
>       1061 =B1  8%      +8.2%       1148 =B1 15%  sched_debug.cpu.nr_swit=
ches.min
>      27936 =B1  2%      -2.0%      27391        sched_debug.cpu.nr_switch=
es.stddev
>  2.008e+09 =B1  7%      +8.0%   2.17e+09 =B1  6%  sched_debug.cpu.nr_unin=
terruptible.avg
>  4.295e+09            +0.0%  4.295e+09        sched_debug.cpu.nr_uninterr=
uptible.max
>  2.137e+09            +0.3%  2.143e+09        sched_debug.cpu.nr_uninterr=
uptible.stddev
>     213402 =B1  2%     +10.1%     234960 =B1 16%  sched_debug.cpu_clk
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.avg
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.max
>     996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->b=
w.min
>  4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
>     212163 =B1  2%     +10.2%     233723 =B1 16%  sched_debug.ktime
>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runti=
me.avg
>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runti=
me.max
>     950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runti=
me.min
>       0.00 =B1 60%      -2.3%       0.00 =B1 43%  sched_debug.rt_rq:.rt_t=
ime.avg
>       0.02 =B1 60%      -2.3%       0.02 =B1 43%  sched_debug.rt_rq:.rt_t=
ime.max
>       0.00 =B1 60%      -2.3%       0.00 =B1 43%  sched_debug.rt_rq:.rt_t=
ime.stddev
>     206340            +0.6%     207483        sched_debug.sched_clk
>       1.00            +0.0%       1.00        sched_debug.sched_clock_sta=
ble()
>   58611259            +0.0%   58611259        sched_debug.sysctl_sched.sy=
sctl_sched_features
>       0.75            +0.0%       0.75        sched_debug.sysctl_sched.sy=
sctl_sched_idle_min_granularity
>      24.00            +0.0%      24.00        sched_debug.sysctl_sched.sy=
sctl_sched_latency
>       3.00            +0.0%       3.00        sched_debug.sysctl_sched.sy=
sctl_sched_min_granularity
>       1.00            +0.0%       1.00        sched_debug.sysctl_sched.sy=
sctl_sched_tunable_scaling
>       4.00            +0.0%       4.00        sched_debug.sysctl_sched.sy=
sctl_sched_wakeup_granularity
>       0.00 =B1118%     -67.2%       0.00 =B1264%  perf-sched.sch_delay.av=
g.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
>       0.00        +2.5e+98%       0.00 =B1264%  perf-sched.sch_delay.avg.=
ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__pu=
t_user_4
>       0.00 =B1244%    -100.0%       0.00        perf-sched.sch_delay.avg.=
ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.avg.=
ms.__cond_resched.down_write.vma_prepare.__split_vma.mprotect_fixup
>       0.00 =B1244%    +162.5%       0.00 =B1173%  perf-sched.sch_delay.av=
g.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_writ=
e.ksys_write
>       0.00        +7.5e+98%       0.00 =B1173%  perf-sched.sch_delay.avg.=
ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_fr=
om_fork
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.avg.=
ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>       0.00 =B1158%     -67.2%       0.00 =B1264%  perf-sched.sch_delay.av=
g.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
>       0.00 =B1244%    -100.0%       0.00        perf-sched.sch_delay.avg.=
ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>       0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms=
=2E__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.01 =B1 17%     -14.9%       0.01 =B1 16%  perf-sched.sch_delay.av=
g.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.00           +12.5%       0.00 =B1 29%  perf-sched.sch_delay.avg.=
ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.00 =B1 12%      +0.6%       0.00 =B1 11%  perf-sched.sch_delay.av=
g.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.00 =B1  8%      -0.4%       0.00 =B1  8%  perf-sched.sch_delay.av=
g.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.00 =B1244%    +308.3%       0.00 =B1 79%  perf-sched.sch_delay.av=
g.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user=
_mode.asm_sysvec_apic_timer_interrupt
>       0.00 =B1 51%     +21.4%       0.01 =B1 15%  perf-sched.sch_delay.av=
g.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_=
mode.do_syscall_64
>       0.00 =B1 13%      -1.1%       0.00 =B1 20%  perf-sched.sch_delay.av=
g.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
>       0.00 =B1 19%      +6.9%       0.00 =B1 15%  perf-sched.sch_delay.av=
g.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>       0.01 =B1  3%      -1.2%       0.01 =B1  2%  perf-sched.sch_delay.av=
g.ms.irq_thread.kthread.ret_from_fork
>       0.00        +1.6e+99%       0.00 =B1173%  perf-sched.sch_delay.avg.=
ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kth=
read
>       0.00 =B1 20%      -0.8%       0.00 =B1 10%  perf-sched.sch_delay.av=
g.ms.kjournald2.kthread.ret_from_fork
>       0.00 =B1 26%      +2.1%       0.00 =B1 24%  perf-sched.sch_delay.av=
g.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.00           +68.8%       0.00 =B1107%  perf-sched.sch_delay.avg.=
ms.rcu_gp_kthread.kthread.ret_from_fork
>       0.00            +6.3%       0.00 =B1 15%  perf-sched.sch_delay.avg.=
ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.00 =B1 19%      -7.0%       0.00 =B1 15%  perf-sched.sch_delay.av=
g.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>       0.00 =B1 13%      +6.5%       0.00 =B1 14%  perf-sched.sch_delay.av=
g.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_w=
ait
>       0.00 =B1 41%     -26.5%       0.00 =B1 78%  perf-sched.sch_delay.av=
g.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_ma=
p_blocks
>       0.00 =B1 95%     +75.0%       0.00 =B1 43%  perf-sched.sch_delay.av=
g.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
>       0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms=
=2Eschedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>       0.01 =B1 69%     +16.7%       0.01 =B1 11%  perf-sched.sch_delay.av=
g.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
>       0.00        +6.2e+98%       0.00 =B1177%  perf-sched.sch_delay.avg.=
ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
>       0.00 =B1 75%     +15.1%       0.00 =B1 10%  perf-sched.sch_delay.av=
g.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
>       0.00 =B1 19%      +9.4%       0.00 =B1 20%  perf-sched.sch_delay.av=
g.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty=
_pages_ratelimited_flags
>       0.00 =B1 17%      -8.3%       0.00 =B1 15%  perf-sched.sch_delay.av=
g.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.avg.=
ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
>       0.00 =B1 13%      -1.1%       0.00 =B1 13%  perf-sched.sch_delay.av=
g.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00        +1.2e+99%       0.00 =B1131%  perf-sched.sch_delay.avg.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
>       0.00        +1.1e+99%       0.00 =B1129%  perf-sched.sch_delay.avg.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
>       0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms=
=2Esmpboot_thread_fn.kthread.ret_from_fork
>       0.01 =B1 16%      +3.8%       0.01 =B1 10%  perf-sched.sch_delay.av=
g.ms.syslog_print.do_syslog.kmsg_read.vfs_read
>       0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms=
=2Ewait_for_partner.fifo_open.do_dentry_open.do_open
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.avg.=
ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__=
journal_start
>       0.01 =B1  3%      +1.6%       0.01        perf-sched.sch_delay.avg.=
ms.worker_thread.kthread.ret_from_fork
>       0.00 =B1118%     -67.2%       0.00 =B1264%  perf-sched.sch_delay.ma=
x.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
>       0.01 =B1 15%      -7.5%       0.00 =B1 15%  perf-sched.sch_delay.ma=
x.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_p=
tr.__sched_setaffinity
>       0.00        +2.5e+98%       0.00 =B1264%  perf-sched.sch_delay.max.=
ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__pu=
t_user_4
>       0.00 =B1244%    -100.0%       0.00        perf-sched.sch_delay.max.=
ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.max.=
ms.__cond_resched.down_write.vma_prepare.__split_vma.mprotect_fixup
>       0.00 =B1244%    +162.5%       0.00 =B1173%  perf-sched.sch_delay.ma=
x.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_writ=
e.ksys_write
>       0.00        +7.5e+98%       0.00 =B1173%  perf-sched.sch_delay.max.=
ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_fr=
om_fork
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.max.=
ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
>       0.00 =B1158%     -67.2%       0.00 =B1264%  perf-sched.sch_delay.ma=
x.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
>       0.00 =B1244%    -100.0%       0.00        perf-sched.sch_delay.max.=
ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>       0.01 =B1 57%     -17.1%       0.00 =B1 11%  perf-sched.sch_delay.ma=
x.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.01 =B1 20%     -11.6%       0.01 =B1 21%  perf-sched.sch_delay.ma=
x.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.00 =B1 23%     +72.2%       0.01 =B1 52%  perf-sched.sch_delay.ma=
x.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.01 =B1 52%     +20.6%       0.01 =B1 45%  perf-sched.sch_delay.ma=
x.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.01 =B1 37%     -12.5%       0.01 =B1 41%  perf-sched.sch_delay.ma=
x.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.00 =B1244%    +337.5%       0.00 =B1 77%  perf-sched.sch_delay.ma=
x.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user=
_mode.asm_sysvec_apic_timer_interrupt
>       0.01 =B1 45%     +17.5%       0.01 =B1 10%  perf-sched.sch_delay.ma=
x.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_=
mode.do_syscall_64
>       0.00 =B1 20%      -3.8%       0.00 =B1 14%  perf-sched.sch_delay.ma=
x.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
>       0.01 =B1 19%      +5.0%       0.01 =B1 22%  perf-sched.sch_delay.ma=
x.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>       0.02 =B1  6%     +30.9%       0.02 =B1 62%  perf-sched.sch_delay.ma=
x.ms.irq_thread.kthread.ret_from_fork
>       0.00        +1.6e+99%       0.00 =B1173%  perf-sched.sch_delay.max.=
ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kth=
read
>       0.00 =B1 20%      -0.8%       0.00 =B1 10%  perf-sched.sch_delay.ma=
x.ms.kjournald2.kthread.ret_from_fork
>       0.02 =B1 58%     +36.2%       0.02 =B1 61%  perf-sched.sch_delay.ma=
x.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.01 =B1  5%   +9107.6%       0.63 =B1261%  perf-sched.sch_delay.ma=
x.ms.rcu_gp_kthread.kthread.ret_from_fork
>       0.01 =B1 21%      -7.5%       0.00 =B1 15%  perf-sched.sch_delay.ma=
x.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>       0.01 =B1 36%      -7.5%       0.01 =B1 15%  perf-sched.sch_delay.ma=
x.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>       0.01 =B1 13%      -4.4%       0.01 =B1 19%  perf-sched.sch_delay.ma=
x.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_w=
ait
>       0.00 =B1 41%     -26.5%       0.00 =B1 78%  perf-sched.sch_delay.ma=
x.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_ma=
p_blocks
>       0.00 =B1 95%     +75.0%       0.00 =B1 43%  perf-sched.sch_delay.ma=
x.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
>       0.01 =B1 58%      -8.5%       0.01 =B1 60%  perf-sched.sch_delay.ma=
x.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_cl=
one
>       0.01 =B1 69%     +41.0%       0.01 =B1 21%  perf-sched.sch_delay.ma=
x.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
>       0.00        +6.2e+98%       0.00 =B1177%  perf-sched.sch_delay.max.=
ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
>       0.00 =B1 75%     +38.2%       0.00 =B1 17%  perf-sched.sch_delay.ma=
x.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
>       0.01 =B1 40%     -17.4%       0.01 =B1 34%  perf-sched.sch_delay.ma=
x.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty=
_pages_ratelimited_flags
>       0.01 =B1 19%     -26.7%       0.00 =B1 15%  perf-sched.sch_delay.ma=
x.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.max.=
ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
>       0.01 =B1 10%     +14.3%       0.01 =B1 33%  perf-sched.sch_delay.ma=
x.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00        +1.5e+99%       0.00 =B1129%  perf-sched.sch_delay.max.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
>       0.00        +1.1e+99%       0.00 =B1129%  perf-sched.sch_delay.max.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
>       0.01 =B1 41%      -2.3%       0.01 =B1 24%  perf-sched.sch_delay.ma=
x.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.01 =B1 22%      +5.7%       0.01 =B1 16%  perf-sched.sch_delay.ma=
x.ms.syslog_print.do_syslog.kmsg_read.vfs_read
>       0.01 =B1 52%     -36.1%       0.00 =B1 29%  perf-sched.sch_delay.ma=
x.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.sch_delay.max.=
ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__=
journal_start
>       2.51            +0.4%       2.52        perf-sched.sch_delay.max.ms=
=2Eworker_thread.kthread.ret_from_fork
>       0.00 =B1 12%      +5.0%       0.00        perf-sched.total_sch_dela=
y.average.ms
>       2.51           +12.8%       2.83 =B1 28%  perf-sched.total_sch_dela=
y.max.ms
>     102.66 =B1  2%      +2.3%     105.00 =B1  2%  perf-sched.total_wait_a=
nd_delay.average.ms
>       6051            +0.0%       6052        perf-sched.total_wait_and_d=
elay.count.ms
>       4995            +0.0%       4995        perf-sched.total_wait_and_d=
elay.max.ms
>     102.65 =B1  2%      +2.3%     104.99 =B1  2%  perf-sched.total_wait_t=
ime.average.ms
>       4995            +0.0%       4995        perf-sched.total_wait_time.=
max.ms
>      23.43            +0.0%      23.43        perf-sched.wait_and_delay.a=
vg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_=
ptr.__sched_setaffinity
>       0.00       +2.4e+103%      24.07 =B1264%  perf-sched.wait_and_delay=
=2Eavg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fo=
rk
>     799.90            -0.0%     799.90        perf-sched.wait_and_delay.a=
vg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>      17.86            +0.0%      17.86        perf-sched.wait_and_delay.a=
vg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>     222.01 =B1  5%      -3.4%     214.41        perf-sched.wait_and_delay=
=2Eavg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscal=
l_64
>       0.29            -0.5%       0.29        perf-sched.wait_and_delay.a=
vg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>     106.88           +16.8%     124.89 =B1 26%  perf-sched.wait_and_delay=
=2Eavg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>     101.85            -0.0%     101.84        perf-sched.wait_and_delay.a=
vg.ms.irq_thread.kthread.ret_from_fork
>       0.00       +5.6e+104%     563.93 =B1264%  perf-sched.wait_and_delay=
=2Eavg.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjourna=
ld2.kthread
>     326.82 =B1 11%     -21.2%     257.48 =B1 58%  perf-sched.wait_and_del=
ay.avg.ms.kjournald2.kthread.ret_from_fork
>      33.59 =B1  4%      +0.3%      33.70 =B1  4%  perf-sched.wait_and_del=
ay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       4.29 =B1  7%      +1.1%       4.33 =B1 10%  perf-sched.wait_and_del=
ay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
>     571.99            +0.0%     571.99        perf-sched.wait_and_delay.a=
vg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>     144.08            -0.1%     143.93        perf-sched.wait_and_delay.a=
vg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>     376.22 =B1  2%      -5.8%     354.56 =B1  9%  perf-sched.wait_and_del=
ay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_ep=
oll_wait
>       0.00       +4.3e+103%      42.98 =B1174%  perf-sched.wait_and_delay=
=2Eavg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ex=
t4_map_blocks
>       0.31 =B1  2%      -2.4%       0.30        perf-sched.wait_and_delay=
=2Eavg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kern=
el_clone
>     175.85 =B1 65%     +28.5%     226.04 =B1 14%  perf-sched.wait_and_del=
ay.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
>       0.00       +1.3e+103%      12.87 =B1264%  perf-sched.wait_and_delay=
=2Eavg.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
>       0.00       +7.3e+104%     731.94 =B1 44%  perf-sched.wait_and_delay=
=2Eavg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio=
_wait
>       7.54            +1.7%       7.67 =B1  2%  perf-sched.wait_and_delay=
=2Eavg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_=
dirty_pages_ratelimited_flags
>     452.41            -0.0%     452.21        perf-sched.wait_and_delay.a=
vg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       4.71 =B1  4%      -0.9%       4.67 =B1  4%  perf-sched.wait_and_del=
ay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00       +1.3e+103%      13.06 =B1264%  perf-sched.wait_and_delay=
=2Eavg.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_tran=
smit
>     588.89 =B1  2%      +0.6%     592.45        perf-sched.wait_and_delay=
=2Eavg.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.00            +0.0%       0.00        perf-sched.wait_and_delay.a=
vg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
>     325.19            +3.6%     336.95 =B1  5%  perf-sched.wait_and_delay=
=2Eavg.ms.worker_thread.kthread.ret_from_fork
>     384.00            +0.0%     384.00        perf-sched.wait_and_delay.c=
ount.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_p=
tr.__sched_setaffinity
>       0.00       +1.2e+101%       0.12 =B1264%  perf-sched.wait_and_delay=
=2Ecount.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
>      10.00            +0.0%      10.00        perf-sched.wait_and_delay.c=
ount.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>     503.14            -0.0%     503.12        perf-sched.wait_and_delay.c=
ount.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>     112.00            +0.0%     112.00        perf-sched.wait_and_delay.c=
ount.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>     111.00            +0.0%     111.00        perf-sched.wait_and_delay.c=
ount.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>      44.29            -4.3%      42.38 =B1  3%  perf-sched.wait_and_delay=
=2Ecount.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>      48.00            +0.0%      48.00        perf-sched.wait_and_delay.c=
ount.irq_thread.kthread.ret_from_fork
>       0.00       +1.2e+101%       0.12 =B1264%  perf-sched.wait_and_delay=
=2Ecount.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournal=
d2.kthread
>       1.00           -25.0%       0.75 =B1 57%  perf-sched.wait_and_delay=
=2Ecount.kjournald2.kthread.ret_from_fork
>       1911 =B1  4%      -0.3%       1904 =B1  4%  perf-sched.wait_and_del=
ay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
>     466.29            +0.6%     469.00        perf-sched.wait_and_delay.c=
ount.rcu_gp_kthread.kthread.ret_from_fork
>      21.00            +0.0%      21.00        perf-sched.wait_and_delay.c=
ount.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>      32.86            +0.4%      33.00        perf-sched.wait_and_delay.c=
ount.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>      13.71 =B1  3%      +3.9%      14.25 =B1  7%  perf-sched.wait_and_del=
ay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epo=
ll_wait
>       0.00       +2.5e+101%       0.25 =B1173%  perf-sched.wait_and_delay=
=2Ecount.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext=
4_map_blocks
>      78.00            +0.0%      78.00        perf-sched.wait_and_delay.c=
ount.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_cl=
one
>       0.71 =B1 63%    +425.0%       3.75 =B1 39%  perf-sched.wait_and_del=
ay.count.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
>       0.00       +1.2e+101%       0.12 =B1264%  perf-sched.wait_and_delay=
=2Ecount.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
>       0.00       +3.6e+102%       3.62 =B1 45%  perf-sched.wait_and_delay=
=2Ecount.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_=
wait
>     631.57            -1.3%     623.12        perf-sched.wait_and_delay.c=
ount.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty=
_pages_ratelimited_flags
>      19.57 =B1  3%      -0.4%      19.50 =B1  4%  perf-sched.wait_and_del=
ay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
>     637.29 =B1  3%      -0.3%     635.50 =B1  6%  perf-sched.wait_and_del=
ay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00       +2.5e+101%       0.25 =B1264%  perf-sched.wait_and_delay=
=2Ecount.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_trans=
mit
>     517.86 =B1  2%      +0.8%     521.88        perf-sched.wait_and_delay=
=2Ecount.smpboot_thread_fn.kthread.ret_from_fork
>      32.00            +0.0%      32.00        perf-sched.wait_and_delay.c=
ount.wait_for_partner.fifo_open.do_dentry_open.do_open
>     461.86 =B1  3%      +0.5%     464.38 =B1  3%  perf-sched.wait_and_del=
ay.count.worker_thread.kthread.ret_from_fork
>       4995            +0.0%       4995        perf-sched.wait_and_delay.m=
ax.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_=
ptr.__sched_setaffinity
>       0.00       +2.4e+103%      24.07 =B1264%  perf-sched.wait_and_delay=
=2Emax.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fo=
rk
>     999.89            -0.0%     999.89        perf-sched.wait_and_delay.m=
ax.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       1000            +0.0%       1000        perf-sched.wait_and_delay.m=
ax.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       1566 =B1 66%     -36.0%       1002        perf-sched.wait_and_delay=
=2Emax.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscal=
l_64
>      11.37            -0.1%      11.36        perf-sched.wait_and_delay.m=
ax.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>     324.06 =B1 11%    +165.8%     861.46 =B1163%  perf-sched.wait_and_del=
ay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>     105.01            -0.0%     105.01        perf-sched.wait_and_delay.m=
ax.ms.irq_thread.kthread.ret_from_fork
>       0.00       +5.6e+104%     563.93 =B1264%  perf-sched.wait_and_delay=
=2Emax.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjourna=
ld2.kthread
>     326.82 =B1 11%     -21.2%     257.48 =B1 58%  perf-sched.wait_and_del=
ay.max.ms.kjournald2.kthread.ret_from_fork
>       1002            +0.0%       1002        perf-sched.wait_and_delay.m=
ax.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       5.00            +0.0%       5.00        perf-sched.wait_and_delay.m=
ax.ms.rcu_gp_kthread.kthread.ret_from_fork
>       1000            -0.0%       1000        perf-sched.wait_and_delay.m=
ax.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>     250.00            +0.0%     250.01        perf-sched.wait_and_delay.m=
ax.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>     515.39 =B1  5%      -2.8%     500.81        perf-sched.wait_and_delay=
=2Emax.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_ep=
oll_wait
>       0.00       +4.3e+103%      42.98 =B1174%  perf-sched.wait_and_delay=
=2Emax.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ex=
t4_map_blocks
>       0.62 =B1  3%      -3.4%       0.60 =B1  2%  perf-sched.wait_and_del=
ay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kern=
el_clone
>     175.85 =B1 65%     +69.9%     298.77 =B1 10%  perf-sched.wait_and_del=
ay.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
>       0.00       +1.3e+103%      12.87 =B1264%  perf-sched.wait_and_delay=
=2Emax.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
>       0.00       +9.3e+104%     926.46 =B1 47%  perf-sched.wait_and_delay=
=2Emax.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio=
_wait
>      91.27 =B1 34%     -17.7%      75.14 =B1 57%  perf-sched.wait_and_del=
ay.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_=
dirty_pages_ratelimited_flags
>     504.72            +0.0%     504.75        perf-sched.wait_and_delay.m=
ax.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       6.86 =B1  5%      -1.6%       6.75 =B1  6%  perf-sched.wait_and_del=
ay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00       +1.3e+103%      13.12 =B1264%  perf-sched.wait_and_delay=
=2Emax.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_tran=
smit
>       2727 =B1 26%     +10.2%       3006        perf-sched.wait_and_delay=
=2Emax.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.01 =B1 52%     -36.1%       0.00 =B1 29%  perf-sched.wait_and_del=
ay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
>       2770 =B1 21%     +11.4%       3085 =B1 31%  perf-sched.wait_and_del=
ay.max.ms.worker_thread.kthread.ret_from_fork
>      23.43            +0.0%      23.43        perf-sched.wait_time.avg.ms=
=2E__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr=
=2E__sched_setaffinity
>       1.25 =B1244%     +50.9%       1.88 =B1173%  perf-sched.wait_time.av=
g.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_writ=
e.ksys_write
>       0.00         +2e+102%       2.04 =B1173%  perf-sched.wait_time.avg.=
ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_fr=
om_fork
>      19.01 =B1158%     +26.6%      24.07 =B1264%  perf-sched.wait_time.av=
g.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
>       0.01 =B1244%    -100.0%       0.00        perf-sched.wait_time.avg.=
ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>     799.90            -0.0%     799.90        perf-sched.wait_time.avg.ms=
=2E__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       1.56 =B1 10%      -7.0%       1.45 =B1  8%  perf-sched.wait_time.av=
g.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>      17.86            +0.0%      17.86        perf-sched.wait_time.avg.ms=
=2Edo_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>     222.01 =B1  5%      -3.4%     214.41        perf-sched.wait_time.avg.=
ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>       0.28            -0.5%       0.28        perf-sched.wait_time.avg.ms=
=2Edo_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.00        +3.8e+98%       0.00 =B1264%  perf-sched.wait_time.avg.=
ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_m=
ode.asm_sysvec_apic_timer_interrupt
>       0.37 =B1244%     +31.3%       0.48 =B1264%  perf-sched.wait_time.av=
g.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_=
mode.do_syscall_64
>      43.66 =B1 25%     +16.6%      50.90 =B1 36%  perf-sched.wait_time.av=
g.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
>     106.88           +16.8%     124.89 =B1 26%  perf-sched.wait_time.avg.=
ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>     101.83            -0.0%     101.82        perf-sched.wait_time.avg.ms=
=2Eirq_thread.kthread.ret_from_fork
>       0.00       +5.6e+104%     563.93 =B1264%  perf-sched.wait_time.avg.=
ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kth=
read
>     326.81 =B1 11%     -21.2%     257.48 =B1 58%  perf-sched.wait_time.av=
g.ms.kjournald2.kthread.ret_from_fork
>      33.58 =B1  4%      +0.3%      33.70 =B1  4%  perf-sched.wait_time.av=
g.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       4.29 =B1  7%      +1.0%       4.33 =B1 10%  perf-sched.wait_time.av=
g.ms.rcu_gp_kthread.kthread.ret_from_fork
>     571.98            +0.0%     571.98        perf-sched.wait_time.avg.ms=
=2Eschedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>     144.08            -0.1%     143.92        perf-sched.wait_time.avg.ms=
=2Eschedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>     376.21 =B1  2%      -5.8%     354.55 =B1  9%  perf-sched.wait_time.av=
g.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_w=
ait
>      79.73 =B1 43%      +0.4%      80.05 =B1 85%  perf-sched.wait_time.av=
g.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_ma=
p_blocks
>       0.31 =B1  2%      -2.3%       0.30        perf-sched.wait_time.avg.=
ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>     175.84 =B1 65%     +28.5%     226.03 =B1 14%  perf-sched.wait_time.av=
g.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
>       0.00       +2.6e+103%      25.87 =B1173%  perf-sched.wait_time.avg.=
ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
>       0.00       +7.3e+104%     731.94 =B1 44%  perf-sched.wait_time.avg.=
ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
>       7.54            +1.7%       7.66 =B1  2%  perf-sched.wait_time.avg.=
ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_p=
ages_ratelimited_flags
>     452.40            -0.0%     452.21        perf-sched.wait_time.avg.ms=
=2Eschedule_timeout.kcompactd.kthread.ret_from_fork
>       0.00 =B1 31%      -4.5%       0.00 =B1 37%  perf-sched.wait_time.av=
g.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
>       4.70 =B1  4%      -0.9%       4.66 =B1  4%  perf-sched.wait_time.av=
g.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00       +2.8e+103%      28.17 =B1129%  perf-sched.wait_time.avg.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
>       0.00       +3.9e+103%      39.05 =B1129%  perf-sched.wait_time.avg.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
>     588.89 =B1  2%      +0.6%     592.45        perf-sched.wait_time.avg.=
ms.smpboot_thread_fn.kthread.ret_from_fork
>       1.57 =B1 10%      -7.0%       1.46 =B1  8%  perf-sched.wait_time.av=
g.ms.syslog_print.do_syslog.kmsg_read.vfs_read
>       0.00       +9.7e+101%       0.97 =B1264%  perf-sched.wait_time.avg.=
ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__=
journal_start
>     325.18            +3.6%     336.94 =B1  5%  perf-sched.wait_time.avg.=
ms.worker_thread.kthread.ret_from_fork
>       4995            +0.0%       4995        perf-sched.wait_time.max.ms=
=2E__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr=
=2E__sched_setaffinity
>       1.25 =B1244%     +64.9%       2.06 =B1173%  perf-sched.wait_time.ma=
x.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_writ=
e.ksys_write
>       0.00         +2e+102%       2.04 =B1173%  perf-sched.wait_time.max.=
ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_fr=
om_fork
>      19.01 =B1158%     +26.6%      24.07 =B1264%  perf-sched.wait_time.ma=
x.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
>       0.01 =B1244%    -100.0%       0.00        perf-sched.wait_time.max.=
ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>     999.89            -0.0%     999.89        perf-sched.wait_time.max.ms=
=2E__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       3.11 =B1 10%      -7.0%       2.90 =B1  8%  perf-sched.wait_time.ma=
x.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       1000            +0.0%       1000        perf-sched.wait_time.max.ms=
=2Edo_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       1566 =B1 66%     -36.0%       1002        perf-sched.wait_time.max.=
ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>      11.36            -0.1%      11.35        perf-sched.wait_time.max.ms=
=2Edo_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.00        +6.2e+98%       0.00 =B1264%  perf-sched.wait_time.max.=
ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_m=
ode.asm_sysvec_apic_timer_interrupt
>       1.11 =B1244%     -12.5%       0.97 =B1264%  perf-sched.wait_time.ma=
x.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_=
mode.do_syscall_64
>      80.64 =B1 29%     +58.8%     128.02 =B1 36%  perf-sched.wait_time.ma=
x.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
>     324.05 =B1 11%    +165.8%     861.45 =B1163%  perf-sched.wait_time.ma=
x.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
>     105.00            -0.0%     104.99        perf-sched.wait_time.max.ms=
=2Eirq_thread.kthread.ret_from_fork
>       0.00       +5.6e+104%     563.93 =B1264%  perf-sched.wait_time.max.=
ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kth=
read
>     326.81 =B1 11%     -21.2%     257.48 =B1 58%  perf-sched.wait_time.ma=
x.ms.kjournald2.kthread.ret_from_fork
>       1002            +0.0%       1002        perf-sched.wait_time.max.ms=
=2Epipe_read.vfs_read.ksys_read.do_syscall_64
>       5.00            +0.0%       5.00        perf-sched.wait_time.max.ms=
=2Ercu_gp_kthread.kthread.ret_from_fork
>       1000            -0.0%       1000        perf-sched.wait_time.max.ms=
=2Eschedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
>     250.00            +0.0%     250.00        perf-sched.wait_time.max.ms=
=2Eschedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
>     515.39 =B1  5%      -2.8%     500.80        perf-sched.wait_time.max.=
ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
>      79.73 =B1 43%      +0.4%      80.05 =B1 85%  perf-sched.wait_time.ma=
x.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_ma=
p_blocks
>       0.62 =B1  3%      -3.4%       0.60 =B1  2%  perf-sched.wait_time.ma=
x.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_cl=
one
>     175.84 =B1 65%     +69.9%     298.77 =B1 10%  perf-sched.wait_time.ma=
x.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
>       0.00       +2.6e+103%      25.87 =B1173%  perf-sched.wait_time.max.=
ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
>       0.00       +9.3e+104%     926.46 =B1 47%  perf-sched.wait_time.max.=
ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
>      91.27 =B1 34%     -17.7%      75.13 =B1 57%  perf-sched.wait_time.ma=
x.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty=
_pages_ratelimited_flags
>     504.71            +0.0%     504.75        perf-sched.wait_time.max.ms=
=2Eschedule_timeout.kcompactd.kthread.ret_from_fork
>       0.00 =B1 31%      -4.5%       0.00 =B1 37%  perf-sched.wait_time.ma=
x.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
>       6.86 =B1  5%      -1.6%       6.75 =B1  6%  perf-sched.wait_time.ma=
x.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.00       +3.9e+103%      39.21 =B1129%  perf-sched.wait_time.max.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
>       0.00       +3.9e+103%      39.11 =B1129%  perf-sched.wait_time.max.=
ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
>       2727 =B1 26%     +10.2%       3006        perf-sched.wait_time.max.=
ms.smpboot_thread_fn.kthread.ret_from_fork
>       3.13 =B1 10%      -7.0%       2.91 =B1  8%  perf-sched.wait_time.ma=
x.ms.syslog_print.do_syslog.kmsg_read.vfs_read
>       0.00       +9.7e+101%       0.97 =B1264%  perf-sched.wait_time.max.=
ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__=
journal_start
>       2770 =B1 21%     +11.4%       3085 =B1 31%  perf-sched.wait_time.ma=
x.ms.worker_thread.kthread.ret_from_fork
>       8.72 =B1 11%      -1.4        7.28 =B1 12%  perf-profile.calltrace.=
cycles-pp.__libc_write
>       8.45 =B1 11%      -1.4        7.08 =B1 13%  perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
>       8.42 =B1 11%      -1.4        7.06 =B1 13%  perf-profile.calltrace.=
cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
>       8.36 =B1 11%      -1.3        7.03 =B1 13%  perf-profile.calltrace.=
cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_wr=
ite
>       8.30 =B1 11%      -1.3        6.97 =B1 13%  perf-profile.calltrace.=
cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe=
=2E__libc_write
>       8.02 =B1 10%      -1.3        6.76 =B1 13%  perf-profile.calltrace.=
cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry=
_SYSCALL_64_after_hwframe
>       7.74 =B1 10%      -1.2        6.53 =B1 14%  perf-profile.calltrace.=
cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_wri=
te.do_syscall_64
>       2.99 =B1 66%      -0.9        2.05 =B1 79%  perf-profile.calltrace.=
cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrup=
t.asm_sysvec_apic_timer_interrupt
>       3.32 =B1 58%      -0.9        2.46 =B1 63%  perf-profile.calltrace.=
cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysv=
ec_apic_timer_interrupt.acpi_safe_halt
>       3.59 =B1 53%      -0.8        2.76 =B1 56%  perf-profile.calltrace.=
cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_i=
nterrupt.acpi_safe_halt.acpi_idle_enter
>       3.02 =B1 10%      -0.6        2.44 =B1 13%  perf-profile.calltrace.=
cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.=
vfs_write.ksys_write
>       2.90 =B1 10%      -0.5        2.36 =B1 13%  perf-profile.calltrace.=
cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buff=
ered_write_iter.vfs_write
>       2.54 =B1 10%      -0.5        2.06 =B1 13%  perf-profile.calltrace.=
cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_pe=
rform_write.ext4_buffered_write_iter
>       0.47 =B1 42%      -0.4        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratel=
imited_flags.generic_perform_write.ext4_buffered_write_iter
>       0.47 =B1 42%      -0.4        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.cgroup_rstat_flush_atomic.do_flush_stats.mem_cgroup_wb_stats.bala=
nce_dirty_pages.balance_dirty_pages_ratelimited_flags
>       0.47 =B1 42%      -0.4        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_di=
rty_pages_ratelimited_flags.generic_perform_write
>       0.52 =B1 42%      -0.4        0.14 =B1174%  perf-profile.calltrace.=
cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic=
_perform_write.ext4_buffered_write_iter.vfs_write
>       0.69 =B1 14%      -0.4        0.31 =B1102%  perf-profile.calltrace.=
cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.generic_wr=
ite_end.generic_perform_write
>       2.94 =B1 11%      -0.3        2.59 =B1 17%  perf-profile.calltrace.=
cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_ite=
r.vfs_write.ksys_write
>       0.62 =B1 45%      -0.3        0.34 =B1103%  perf-profile.calltrace.=
cycles-pp.ktime_get.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt=
=2E__sysvec_apic_timer_interrupt
>       0.42 =B1 64%      -0.3        0.15 =B1173%  perf-profile.calltrace.=
cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_w=
rite_end.generic_write_end
>       0.82 =B1 52%      -0.3        0.57 =B1 63%  perf-profile.calltrace.=
cycles-pp.tick_sched_do_timer.tick_sched_timer.__hrtimer_run_queues.hrtimer=
_interrupt.__sysvec_apic_timer_interrupt
>       0.31 =B1 87%      -0.2        0.07 =B1264%  perf-profile.calltrace.=
cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush_atomic.do_flush_stat=
s.mem_cgroup_wb_stats.balance_dirty_pages
>      35.42 =B1  5%      -0.2       35.21 =B1  6%  perf-profile.calltrace.=
cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_=
safe_halt.acpi_idle_enter.cpuidle_enter_state
>       0.58 =B1 41%      -0.2        0.38 =B1 78%  perf-profile.calltrace.=
cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_=
buffered_write_iter.vfs_write.ksys_write
>       0.34 =B1 89%      -0.2        0.14 =B1173%  perf-profile.calltrace.=
cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_wr=
ite_iter.vfs_write.ksys_write
>       0.50 =B1 69%      -0.2        0.31 =B1100%  perf-profile.calltrace.=
cycles-pp._raw_spin_trylock.rebalance_domains.__do_softirq.__irq_exit_rcu.s=
ysvec_apic_timer_interrupt
>       1.12 =B1 13%      -0.2        0.93 =B1 20%  perf-profile.calltrace.=
cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.=
ext4_buffered_write_iter.vfs_write
>       0.55 =B1 43%      -0.2        0.39 =B1 79%  perf-profile.calltrace.=
cycles-pp._raw_spin_lock_irqsave.rcu_report_qs_rdp.rcu_core.__do_softirq.__=
irq_exit_rcu
>       1.73 =B1 12%      -0.2        1.57 =B1 17%  perf-profile.calltrace.=
cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext=
4_buffered_write_iter.vfs_write
>       0.14 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.fio_gettime
>       0.34 =B1 87%      -0.1        0.21 =B1129%  perf-profile.calltrace.=
cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_bal=
ance.rebalance_domains
>       1.40 =B1 22%      -0.1        1.28 =B1 29%  perf-profile.calltrace.=
cycles-pp.ext4_end_io_rsv_work.process_one_work.worker_thread.kthread.ret_f=
rom_fork
>       0.18 =B1160%      -0.1        0.07 =B1264%  perf-profile.calltrace.=
cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin=
=2Egeneric_perform_write
>       1.38 =B1 22%      -0.1        1.27 =B1 29%  perf-profile.calltrace.=
cycles-pp.ext4_finish_bio.ext4_release_io_end.ext4_end_io_rsv_work.process_=
one_work.worker_thread
>       1.39 =B1 22%      -0.1        1.28 =B1 29%  perf-profile.calltrace.=
cycles-pp.ext4_release_io_end.ext4_end_io_rsv_work.process_one_work.worker_=
thread.kthread
>       0.46 =B1 65%      -0.1        0.36 =B1 77%  perf-profile.calltrace.=
cycles-pp.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_b=
egin.generic_perform_write.ext4_buffered_write_iter
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev_generic_help=
er_fb_dirty.drm_fb_helper_damage_work.process_one_work
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_gem_vmap.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev=
_generic_helper_fb_dirty.drm_fb_helper_damage_work
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_gem_shmem_object_vmap.drm_gem_vmap.drm_gem_vmap_unlocked.drm_cl=
ient_buffer_vmap.drm_fbdev_generic_helper_fb_dirty
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_gem_shmem_vmap_locked.drm_gem_shmem_object_vmap.drm_gem_vmap.dr=
m_gem_vmap_unlocked.drm_client_buffer_vmap
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_gem_shmem_get_pages.drm_gem_shmem_vmap_locked.drm_gem_shmem_obj=
ect_vmap.drm_gem_vmap.drm_gem_vmap_unlocked
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_gem_shmem_get_pages_locked.drm_gem_shmem_get_pages.drm_gem_shme=
m_vmap_locked.drm_gem_shmem_object_vmap.drm_gem_vmap
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked.drm_gem_shmem_get_=
pages.drm_gem_shmem_vmap_locked.drm_gem_shmem_object_vmap
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.shmem_read_mapping_page_gfp.drm_gem_get_pages.drm_gem_shmem_get_pag=
es_locked.drm_gem_shmem_get_pages.drm_gem_shmem_vmap_locked
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.drm_client_buffer_vmap.drm_fbdev_generic_helper_fb_dirty.drm_fb_hel=
per_damage_work.process_one_work.worker_thread
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.shmem_get_folio_gfp.shmem_read_folio_gfp.shmem_read_mapping_page_gf=
p.drm_gem_get_pages.drm_gem_shmem_get_pages_locked
>       0.10 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.shmem_read_folio_gfp.shmem_read_mapping_page_gfp.drm_gem_get_pages.=
drm_gem_shmem_get_pages_locked.drm_gem_shmem_get_pages
>       0.09 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_read_folio_gfp.shmem_re=
ad_mapping_page_gfp.drm_gem_get_pages
>       0.09 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_read_folio_gfp=
=2Eshmem_read_mapping_page_gfp
>       0.09 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffer=
ed_write_iter.vfs_write
>       5.38 =B1  9%      -0.1        5.29 =B1  4%  perf-profile.calltrace.=
cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_=
interrupt.acpi_safe_halt.acpi_idle_enter
>       0.09 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.asm_sysvec_irq_work.xas_load.filemap_get_entry.shmem_get_folio_gfp.=
shmem_read_folio_gfp
>       0.09 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.sysvec_irq_work.asm_sysvec_irq_work.xas_load.filemap_get_entry.shme=
m_get_folio_gfp
>       0.09 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.xas_load.file=
map_get_entry
>       0.09 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.=
xas_load
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.asm_sysvec_irq_work.fio_gettime
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.sysvec_irq_work.asm_sysvec_irq_work.fio_gettime
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.fio_gettime
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.=
fio_gettime
>       0.36 =B1 90%      -0.1        0.28 =B1100%  perf-profile.calltrace.=
cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perfo=
rm_write.ext4_buffered_write_iter
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.fio_io_end
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_beg=
in.ext4_da_write_begin.generic_perform_write
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_w=
ritepages.__writeback_single_inode
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.check_cpu_stall.rcu_pending.rcu_sched_clock_irq.update_process_time=
s.tick_sched_handle
>       4.81 =B1  9%      -0.1        4.73 =B1  3%  perf-profile.calltrace.=
cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysve=
c_apic_timer_interrupt.acpi_safe_halt
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.asm_sysvec_irq_work.fio_io_end
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.sysvec_irq_work.asm_sysvec_irq_work.fio_io_end
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.fio_io_end
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.=
fio_io_end
>       0.08 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers.ex=
t4_block_write_begin.ext4_da_write_begin
>       0.94 =B1 23%      -0.1        0.87 =B1 45%  perf-profile.calltrace.=
cycles-pp.folio_end_writeback.ext4_finish_bio.ext4_release_io_end.ext4_end_=
io_rsv_work.process_one_work
>       0.07 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_foli=
o.ext4_da_write_begin
>       0.15 =B1158%      -0.1        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64_after_hwframe.execve
>       0.15 =B1158%      -0.1        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
>       0.15 =B1158%      -0.1        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.execve
>       0.15 =B1158%      -0.1        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.exe=
cve
>       0.15 =B1158%      -0.1        0.08 =B1264%  perf-profile.calltrace.=
cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_6=
4_after_hwframe.execve
>       2.03 =B1 15%      -0.1        1.96 =B1 10%  perf-profile.calltrace.=
cycles-pp.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.=
asm_sysvec_apic_timer_interrupt
>       0.07 =B1244%      -0.1        0.00        perf-profile.calltrace.cy=
cles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.g=
eneric_perform_write.ext4_buffered_write_iter
>       3.64 =B1 25%      -0.1        3.57 =B1 12%  perf-profile.calltrace.=
cycles-pp.worker_thread.kthread.ret_from_fork
>       3.61 =B1 25%      -0.1        3.54 =B1 12%  perf-profile.calltrace.=
cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>       1.16 =B1 13%      -0.1        1.09 =B1 14%  perf-profile.calltrace.=
cycles-pp.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_sched_h=
andle.tick_sched_timer
>       0.83 =B1 22%      -0.1        0.76 =B1 45%  perf-profile.calltrace.=
cycles-pp.__folio_end_writeback.folio_end_writeback.ext4_finish_bio.ext4_re=
lease_io_end.ext4_end_io_rsv_work
>       0.42 =B1 64%      -0.1        0.36 =B1 79%  perf-profile.calltrace.=
cycles-pp.native_apic_msr_eoi_write.__sysvec_apic_timer_interrupt.sysvec_ap=
ic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
>       3.84 =B1 23%      -0.1        3.79 =B1 12%  perf-profile.calltrace.=
cycles-pp.ret_from_fork
>       3.84 =B1 23%      -0.1        3.79 =B1 12%  perf-profile.calltrace.=
cycles-pp.kthread.ret_from_fork
>       1.76 =B1 12%      -0.0        1.72 =B1  5%  perf-profile.calltrace.=
cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_i=
nterrupt.asm_sysvec_apic_timer_interrupt
>       0.60 =B1 43%      -0.0        0.56 =B1 41%  perf-profile.calltrace.=
cycles-pp.rcu_report_qs_rdp.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_api=
c_timer_interrupt
>       1.02 =B1 15%      -0.0        0.98 =B1 20%  perf-profile.calltrace.=
cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic=
_perform_write.ext4_buffered_write_iter
>       0.89 =B1 25%      -0.0        0.85 =B1 13%  perf-profile.calltrace.=
cycles-pp.ext4_bio_write_folio.mpage_submit_folio.mpage_map_and_submit_buff=
ers.mpage_map_and_submit_extent.ext4_do_writepages
>       0.78 =B1 19%      -0.0        0.74 =B1  6%  perf-profile.calltrace.=
cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.__=
irq_exit_rcu
>       0.32 =B1158%      -0.0        0.28 =B1173%  perf-profile.calltrace.=
cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk=
_emit._printk
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.calltrace.=
cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.=
asm_sysvec_irq_work
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.calltrace.=
cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.=
sysvec_irq_work
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.calltrace.=
cycles-pp._printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_i=
rq_work
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.calltrace.=
cycles-pp.vprintk_emit._printk.irq_work_single.irq_work_run_list.irq_work_r=
un
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.calltrace.=
cycles-pp.console_unlock.vprintk_emit._printk.irq_work_single.irq_work_run_=
list
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.calltrace.=
cycles-pp.console_flush_all.console_unlock.vprintk_emit._printk.irq_work_si=
ngle
>       1.32 =B1 12%      -0.0        1.28 =B1 11%  perf-profile.calltrace.=
cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_s=
ched_timer.__hrtimer_run_queues
>       0.90 =B1  9%      -0.0        0.86 =B1 13%  perf-profile.calltrace.=
cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handl=
er.__hrtimer_run_queues.hrtimer_interrupt
>       1.42 =B1  9%      -0.0        1.39 =B1 18%  perf-profile.calltrace.=
cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_i=
nterrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       0.33 =B1158%      -0.0        0.31 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.=
ret_from_fork
>       0.33 =B1158%      -0.0        0.31 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.proce=
ss_one_work.worker_thread.kthread
>       0.15 =B1244%      -0.0        0.13 =B1264%  perf-profile.calltrace.=
cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_u=
nlock.vprintk_emit
>       0.62 =B1 42%      -0.0        0.61 =B1 41%  perf-profile.calltrace.=
cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuid=
le_idle_call.do_idle
>       0.08 =B1244%      -0.0        0.07 =B1264%  perf-profile.calltrace.=
cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rcu_repor=
t_qs_rdp.rcu_core.__do_softirq
>       1.02 =B1 11%      +0.0        1.03 =B1  6%  perf-profile.calltrace.=
cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec=
_apic_timer_interrupt
>       0.51 =B1 65%      +0.0        0.51 =B1 60%  perf-profile.calltrace.=
cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da=
_write_begin.generic_perform_write
>       1.67 =B1 10%      +0.0        1.68 =B1 12%  perf-profile.calltrace.=
cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sch=
ed_handle.tick_sched_timer
>       0.66 =B1 44%      +0.0        0.67 =B1  6%  perf-profile.calltrace.=
cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_doma=
ins.__do_softirq
>       1.14 =B1  8%      +0.0        1.16 =B1 13%  perf-profile.calltrace.=
cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues=
=2Ehrtimer_interrupt.__sysvec_apic_timer_interrupt
>       1.76 =B1  6%      +0.0        1.79 =B1 12%  perf-profile.calltrace.=
cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt._=
_sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       1.11 =B1 14%      +0.0        1.14 =B1 12%  perf-profile.calltrace.=
cycles-pp.note_gp_changes.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_=
timer_interrupt
>       1.14 =B1 11%      +0.0        1.18 =B1 13%  perf-profile.calltrace.=
cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.=
cpu_startup_entry
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.wb_do_writeback.wb_workfn.process_one_work.worker_thread.kthread
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.wb_writeback.wb_do_writeback.wb_workfn.process_one_work.worker_th=
read
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn.proc=
ess_one_work
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writ=
eback.wb_workfn
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_w=
b.wb_writeback.wb_do_writeback
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writ=
eback_inodes_wb.wb_writeback
>       1.37 =B1 27%      +0.1        1.43 =B1 14%  perf-profile.calltrace.=
cycles-pp.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages.do=
_writepages.__writeback_single_inode
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.ext4_writepages.do_writepages.__writeback_single_inode.writeback_=
sb_inodes.__writeback_inodes_wb
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.calltrace.=
cycles-pp.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_sing=
le_inode.writeback_sb_inodes
>       1.95 =B1 12%      +0.1        2.01 =B1 22%  perf-profile.calltrace.=
cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_time=
r_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       1.36 =B1 27%      +0.1        1.42 =B1 13%  perf-profile.calltrace.=
cycles-pp.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_=
writepages.ext4_writepages.do_writepages
>       0.07 =B1244%      +0.1        0.13 =B1173%  perf-profile.calltrace.=
cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_i=
nterrupt.__sysvec_apic_timer_interrupt
>       0.08 =B1244%      +0.1        0.15 =B1173%  perf-profile.calltrace.=
cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.__irq_=
exit_rcu.sysvec_apic_timer_interrupt
>       0.00            +0.1        0.06 =B1264%  perf-profile.calltrace.cy=
cles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interru=
pt.__sysvec_apic_timer_interrupt
>       1.15 =B1 23%      +0.1        1.22 =B1 16%  perf-profile.calltrace.=
cycles-pp.mpage_submit_folio.mpage_map_and_submit_buffers.mpage_map_and_sub=
mit_extent.ext4_do_writepages.ext4_writepages
>       0.52 =B1 67%      +0.1        0.59 =B1 12%  perf-profile.calltrace.=
cycles-pp.__folio_start_writeback.ext4_bio_write_folio.mpage_submit_folio.m=
page_map_and_submit_buffers.mpage_map_and_submit_extent
>       0.00            +0.1        0.07 =B1264%  perf-profile.calltrace.cy=
cles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_api=
c_timer_interrupt.sysvec_apic_timer_interrupt
>       0.00            +0.1        0.07 =B1264%  perf-profile.calltrace.cy=
cles-pp.asm_sysvec_irq_work.get_io_u
>       0.00            +0.1        0.07 =B1264%  perf-profile.calltrace.cy=
cles-pp.sysvec_irq_work.asm_sysvec_irq_work.get_io_u
>       0.00            +0.1        0.07 =B1264%  perf-profile.calltrace.cy=
cles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_io_u
>       0.00            +0.1        0.07 =B1264%  perf-profile.calltrace.cy=
cles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.=
get_io_u
>       0.08 =B1244%      +0.1        0.15 =B1173%  perf-profile.calltrace.=
cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_wor=
k.memcpy_toio
>       0.08 =B1244%      +0.1        0.15 =B1173%  perf-profile.calltrace.=
cycles-pp.asm_sysvec_irq_work.memcpy_toio.drm_fb_memcpy.ast_primary_plane_h=
elper_atomic_update.drm_atomic_helper_commit_planes
>       0.08 =B1244%      +0.1        0.15 =B1173%  perf-profile.calltrace.=
cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.memcpy_toio.drm_fb_memcpy.ast=
_primary_plane_helper_atomic_update
>       0.08 =B1244%      +0.1        0.15 =B1173%  perf-profile.calltrace.=
cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.memcpy_toio=
=2Edrm_fb_memcpy
>       0.98 =B1 10%      +0.1        1.05 =B1 20%  perf-profile.calltrace.=
cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt._=
_sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
>       0.00            +0.1        0.07 =B1264%  perf-profile.calltrace.cy=
cles-pp.update_rq_clock_task.scheduler_tick.update_process_times.tick_sched=
_handle.tick_sched_timer
>       0.00            +0.1        0.08 =B1264%  perf-profile.calltrace.cy=
cles-pp.asm_sysvec_irq_work.td_io_queue
>       0.00            +0.1        0.08 =B1264%  perf-profile.calltrace.cy=
cles-pp.sysvec_irq_work.asm_sysvec_irq_work.td_io_queue
>       0.00            +0.1        0.08 =B1264%  perf-profile.calltrace.cy=
cles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.td_io_queue
>       0.00            +0.1        0.08 =B1264%  perf-profile.calltrace.cy=
cles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.=
td_io_queue
>       0.00            +0.1        0.08 =B1264%  perf-profile.calltrace.cy=
cles-pp.calc_global_load_tick.scheduler_tick.update_process_times.tick_sche=
d_handle.tick_sched_timer
>       0.00            +0.1        0.09 =B1264%  perf-profile.calltrace.cy=
cles-pp.td_io_queue
>       0.00            +0.1        0.10 =B1264%  perf-profile.calltrace.cy=
cles-pp.get_io_u
>       1.33 =B1 14%      +0.1        1.43 =B1 11%  perf-profile.calltrace.=
cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_in=
it
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.calltrace.=
cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_=
64_start_reservations
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.calltrace.=
cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.calltrace.=
cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_6=
4_no_verify
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.calltrace.=
cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.second=
ary_startup_64_no_verify
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.calltrace.=
cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64=
_start_kernel.secondary_startup_64_no_verify
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.calltrace.=
cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservati=
ons.x86_64_start_kernel
>       1.38 =B1 15%      +0.1        1.49 =B1 13%  perf-profile.calltrace.=
cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_ker=
nel
>       0.17 =B1158%      +0.1        0.29 =B1101%  perf-profile.calltrace.=
cycles-pp.run_rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_tim=
er_interrupt.asm_sysvec_apic_timer_interrupt
>       1.37 =B1 15%      +0.1        1.49 =B1 12%  perf-profile.calltrace.=
cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_r=
est_init
>       0.44 =B1 64%      +0.1        0.56 =B1 40%  perf-profile.calltrace.=
cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.44 =B1 64%      +0.1        0.56 =B1 40%  perf-profile.calltrace.=
cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.13 =B1244%      +0.1        0.25 =B1173%  perf-profile.calltrace.=
cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.=
drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
>       0.15 =B1244%      +0.1        0.28 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_f=
b_helper_damage_work.process_one_work.worker_thread
>       0.15 =B1244%      +0.1        0.28 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_hel=
per_fb_dirty.drm_fb_helper_damage_work.process_one_work
>       0.15 =B1244%      +0.1        0.28 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirt=
yfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
>       0.13 =B1244%      +0.1        0.26 =B1173%  perf-profile.calltrace.=
cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic=
_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
>       0.13 =B1244%      +0.1        0.26 =B1173%  perf-profile.calltrace.=
cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_=
helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
>       0.13 =B1244%      +0.1        0.26 =B1173%  perf-profile.calltrace.=
cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_p=
lanes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commi=
t_tail.commit_tail
>       0.13 =B1244%      +0.1        0.26 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_h=
elper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helpe=
r_atomic_commit_tail
>       0.13 =B1244%      +0.1        0.26 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_c=
ommit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
>       0.13 =B1244%      +0.1        0.26 =B1173%  perf-profile.calltrace.=
cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm=
=2East_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_=
commit
>       0.08 =B1244%      +0.2        0.23 =B1130%  perf-profile.calltrace.=
cycles-pp.cpuidle_governor_latency_req.menu_select.cpuidle_idle_call.do_idl=
e.cpu_startup_entry
>       2.44 =B1  6%      +0.3        2.72 =B1  6%  perf-profile.calltrace.=
cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_sec=
ondary
>       6.02 =B1  9%      +0.5        6.47 =B1 16%  perf-profile.calltrace.=
cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_=
task_tick.scheduler_tick.update_process_times
>      16.75 =B1  3%      +0.5       17.22 =B1  7%  perf-profile.calltrace.=
cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_=
apic_timer_interrupt.sysvec_apic_timer_interrupt
>      19.61 =B1  2%      +0.7       20.30 =B1  6%  perf-profile.calltrace.=
cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interr=
upt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
>       9.66 =B1  6%      +0.7       10.41 =B1 12%  perf-profile.calltrace.=
cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sch=
ed_handle.tick_sched_timer
>      43.07 =B1  4%      +0.8       43.82 =B1  3%  perf-profile.calltrace.=
cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.=
cpuidle_idle_call
>       9.35 =B1  6%      +0.8       10.13 =B1 12%  perf-profile.calltrace.=
cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tic=
k.update_process_times.tick_sched_handle
>      14.95 =B1  5%      +0.8       15.75 =B1  7%  perf-profile.calltrace.=
cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer=
_run_queues.hrtimer_interrupt
>      15.11 =B1  5%      +0.8       15.92 =B1  7%  perf-profile.calltrace.=
cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_i=
nterrupt.__sysvec_apic_timer_interrupt
>      12.71 =B1  5%      +0.8       13.54 =B1 10%  perf-profile.calltrace.=
cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_=
timer.__hrtimer_run_queues
>      24.55 =B1  2%      +0.9       25.48 =B1  5%  perf-profile.calltrace.=
cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sys=
vec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
>      23.75 =B1  2%      +1.0       24.70 =B1  6%  perf-profile.calltrace.=
cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer=
_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
>      77.39 =B1  2%      +1.3       78.74        perf-profile.calltrace.cy=
cles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_sec=
ondary
>      78.37 =B1  2%      +1.4       79.82        perf-profile.calltrace.cy=
cles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_sta=
rtup_entry
>      77.30 =B1  2%      +1.5       78.81        perf-profile.calltrace.cy=
cles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call=
=2Edo_idle
>      80.76 =B1  2%      +1.6       82.34        perf-profile.calltrace.cy=
cles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.seconda=
ry_startup_64_no_verify
>      81.47 =B1  2%      +1.6       83.10        perf-profile.calltrace.cy=
cles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>      81.47 =B1  2%      +1.6       83.10        perf-profile.calltrace.cy=
cles-pp.start_secondary.secondary_startup_64_no_verify
>      81.30 =B1  2%      +1.6       82.93        perf-profile.calltrace.cy=
cles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_v=
erify
>      82.85            +1.7       84.59        perf-profile.calltrace.cycl=
es-pp.secondary_startup_64_no_verify
>     106.34            +1.9      108.23        perf-profile.calltrace.cycl=
es-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidl=
e_enter_state.cpuidle_enter
>       8.81 =B1 11%      -1.5        7.34 =B1 12%  perf-profile.children.c=
ycles-pp.__libc_write
>      10.24 =B1  9%      -1.3        8.92 =B1 11%  perf-profile.children.c=
ycles-pp.entry_SYSCALL_64_after_hwframe
>      10.21 =B1  8%      -1.3        8.90 =B1 11%  perf-profile.children.c=
ycles-pp.do_syscall_64
>       8.43 =B1 11%      -1.3        7.13 =B1 13%  perf-profile.children.c=
ycles-pp.ksys_write
>       8.36 =B1 11%      -1.3        7.07 =B1 13%  perf-profile.children.c=
ycles-pp.vfs_write
>       8.04 =B1 10%      -1.3        6.78 =B1 13%  perf-profile.children.c=
ycles-pp.ext4_buffered_write_iter
>       7.76 =B1 10%      -1.2        6.56 =B1 14%  perf-profile.children.c=
ycles-pp.generic_perform_write
>       4.73 =B1 43%      -1.1        3.65 =B1 44%  perf-profile.children.c=
ycles-pp.ktime_get
>       3.41 =B1 58%      -0.9        2.54 =B1 62%  perf-profile.children.c=
ycles-pp.tick_irq_enter
>       3.67 =B1 53%      -0.8        2.83 =B1 56%  perf-profile.children.c=
ycles-pp.irq_enter_rcu
>       3.02 =B1 10%      -0.6        2.44 =B1 13%  perf-profile.children.c=
ycles-pp.generic_write_end
>       2.91 =B1 10%      -0.5        2.38 =B1 13%  perf-profile.children.c=
ycles-pp.block_write_end
>       2.55 =B1 10%      -0.5        2.06 =B1 13%  perf-profile.children.c=
ycles-pp.__block_commit_write
>       2.27 =B1 10%      -0.4        1.90 =B1 13%  perf-profile.children.c=
ycles-pp._raw_spin_lock_irqsave
>       2.96 =B1 11%      -0.4        2.60 =B1 17%  perf-profile.children.c=
ycles-pp.ext4_da_write_begin
>       0.62 =B1 35%      -0.2        0.41 =B1 20%  perf-profile.children.c=
ycles-pp.xas_load
>       0.88 =B1 42%      -0.2        0.68 =B1 33%  perf-profile.children.c=
ycles-pp.tick_sched_do_timer
>       1.12 =B1 12%      -0.2        0.93 =B1 20%  perf-profile.children.c=
ycles-pp.ext4_block_write_begin
>       0.26 =B1 79%      -0.2        0.10 =B1 49%  perf-profile.children.c=
ycles-pp.filemap_get_entry
>       0.69 =B1 15%      -0.2        0.54 =B1 21%  perf-profile.children.c=
ycles-pp.mark_buffer_dirty
>       1.74 =B1 13%      -0.2        1.59 =B1 17%  perf-profile.children.c=
ycles-pp.__filemap_get_folio
>       0.49 =B1 60%      -0.1        0.34 =B1 15%  perf-profile.children.c=
ycles-pp.fio_gettime
>       1.40 =B1 22%      -0.1        1.28 =B1 29%  perf-profile.children.c=
ycles-pp.ext4_end_io_rsv_work
>       0.56 =B1 14%      -0.1        0.45 =B1 23%  perf-profile.children.c=
ycles-pp.__folio_mark_dirty
>       0.19 =B1112%      -0.1        0.08 =B1 14%  perf-profile.children.c=
ycles-pp.drm_gem_shmem_get_pages
>       0.19 =B1112%      -0.1        0.08 =B1 14%  perf-profile.children.c=
ycles-pp.drm_gem_shmem_get_pages_locked
>       0.19 =B1112%      -0.1        0.08 =B1 14%  perf-profile.children.c=
ycles-pp.drm_gem_get_pages
>       0.19 =B1112%      -0.1        0.08 =B1 14%  perf-profile.children.c=
ycles-pp.shmem_read_mapping_page_gfp
>       0.20 =B1106%      -0.1        0.08 =B1 22%  perf-profile.children.c=
ycles-pp.drm_gem_vmap_unlocked
>       0.20 =B1106%      -0.1        0.08 =B1 22%  perf-profile.children.c=
ycles-pp.drm_gem_vmap
>       0.20 =B1106%      -0.1        0.08 =B1 22%  perf-profile.children.c=
ycles-pp.drm_gem_shmem_object_vmap
>       0.20 =B1106%      -0.1        0.08 =B1 22%  perf-profile.children.c=
ycles-pp.drm_gem_shmem_vmap_locked
>       1.39 =B1 22%      -0.1        1.27 =B1 29%  perf-profile.children.c=
ycles-pp.ext4_finish_bio
>       0.17 =B1120%      -0.1        0.06 =B1 15%  perf-profile.children.c=
ycles-pp.shmem_read_folio_gfp
>       1.39 =B1 22%      -0.1        1.28 =B1 29%  perf-profile.children.c=
ycles-pp.ext4_release_io_end
>       0.15 =B1140%      -0.1        0.05 =B1 58%  perf-profile.children.c=
ycles-pp.shmem_get_folio_gfp
>      35.48 =B1  5%      -0.1       35.38 =B1  6%  perf-profile.children.c=
ycles-pp.sysvec_apic_timer_interrupt
>       0.13 =B1177%      -0.1        0.03 =B1102%  perf-profile.children.c=
ycles-pp.drm_client_buffer_vmap
>       0.60 =B1 19%      -0.1        0.50 =B1 22%  perf-profile.children.c=
ycles-pp.folio_create_empty_buffers
>       0.92 =B1 20%      -0.1        0.82 =B1 12%  perf-profile.children.c=
ycles-pp._raw_spin_trylock
>       0.95 =B1  8%      -0.1        0.86 =B1 14%  perf-profile.children.c=
ycles-pp.native_sched_clock
>       0.65 =B1 16%      -0.1        0.56 =B1 15%  perf-profile.children.c=
ycles-pp.balance_dirty_pages_ratelimited_flags
>       0.57 =B1 21%      -0.1        0.48 =B1 16%  perf-profile.children.c=
ycles-pp.balance_dirty_pages
>       0.48 =B1 16%      -0.1        0.40 =B1 21%  perf-profile.children.c=
ycles-pp.copyin
>       0.39 =B1 15%      -0.1        0.30 =B1 30%  perf-profile.children.c=
ycles-pp.ext4_da_write_end
>       0.63 =B1 20%      -0.1        0.55 =B1 32%  perf-profile.children.c=
ycles-pp.native_queued_spin_lock_slowpath
>       0.54 =B1 19%      -0.1        0.46 =B1 22%  perf-profile.children.c=
ycles-pp.copy_page_from_iter_atomic
>       0.23 =B1 37%      -0.1        0.15 =B1 34%  perf-profile.children.c=
ycles-pp.timekeeping_advance
>       0.23 =B1 37%      -0.1        0.15 =B1 34%  perf-profile.children.c=
ycles-pp.update_wall_time
>       0.56 =B1 24%      -0.1        0.48 =B1 20%  perf-profile.children.c=
ycles-pp.folio_alloc
>       0.41 =B1 23%      -0.1        0.33 =B1 25%  perf-profile.children.c=
ycles-pp.folio_alloc_buffers
>       0.27 =B1 13%      -0.1        0.20 =B1 23%  perf-profile.children.c=
ycles-pp.read
>       0.54 =B1 21%      -0.1        0.47 =B1 17%  perf-profile.children.c=
ycles-pp.__alloc_pages
>       0.38 =B1 24%      -0.1        0.30 =B1 26%  perf-profile.children.c=
ycles-pp.alloc_buffer_head
>       3.64 =B1 25%      -0.1        3.57 =B1 12%  perf-profile.children.c=
ycles-pp.worker_thread
>       0.19 =B1 24%      -0.1        0.12 =B1 42%  perf-profile.children.c=
ycles-pp.__xa_set_mark
>       1.20 =B1 11%      -0.1        1.13 =B1 14%  perf-profile.children.c=
ycles-pp.rcu_pending
>       3.61 =B1 25%      -0.1        3.54 =B1 12%  perf-profile.children.c=
ycles-pp.process_one_work
>       0.08 =B1244%      -0.1        0.01 =B1264%  perf-profile.children.c=
ycles-pp.fio_io_end
>       5.50 =B1  8%      -0.1        5.43 =B1  4%  perf-profile.children.c=
ycles-pp.__irq_exit_rcu
>       2.07 =B1 14%      -0.1        2.01 =B1 10%  perf-profile.children.c=
ycles-pp.rcu_core
>       0.43 =B1 12%      -0.1        0.36 =B1 20%  perf-profile.children.c=
ycles-pp.ext4_da_get_block_prep
>       0.92 =B1  8%      -0.1        0.86 =B1 11%  perf-profile.children.c=
ycles-pp.sched_clock_cpu
>       0.38 =B1135%      -0.1        0.32 =B1164%  perf-profile.children.c=
ycles-pp.irq_work_run_list
>       0.51 =B1 20%      -0.1        0.45 =B1 17%  perf-profile.children.c=
ycles-pp.cgroup_rstat_flush_atomic
>       0.28 =B1 18%      -0.1        0.22 =B1 21%  perf-profile.children.c=
ycles-pp.vfs_read
>       0.51 =B1 20%      -0.1        0.45 =B1 16%  perf-profile.children.c=
ycles-pp.cgroup_rstat_flush_locked
>       0.30 =B1 17%      -0.1        0.24 =B1 19%  perf-profile.children.c=
ycles-pp.ksys_read
>       0.51 =B1 20%      -0.1        0.45 =B1 17%  perf-profile.children.c=
ycles-pp.mem_cgroup_wb_stats
>       0.44 =B1 26%      -0.1        0.38 =B1 21%  perf-profile.children.c=
ycles-pp.kmem_cache_alloc
>       3.86 =B1 23%      -0.1        3.80 =B1 12%  perf-profile.children.c=
ycles-pp.ret_from_fork
>       0.51 =B1 20%      -0.1        0.45 =B1 16%  perf-profile.children.c=
ycles-pp.do_flush_stats
>       1.06 =B1 10%      -0.1        1.00 =B1  9%  perf-profile.children.c=
ycles-pp._raw_spin_lock
>       3.84 =B1 23%      -0.1        3.79 =B1 12%  perf-profile.children.c=
ycles-pp.kthread
>       4.91 =B1  9%      -0.1        4.85 =B1  3%  perf-profile.children.c=
ycles-pp.__do_softirq
>       0.17 =B1 23%      -0.1        0.11 =B1 40%  perf-profile.children.c=
ycles-pp.thread_main
>       1.19 =B1 10%      -0.1        1.14 =B1 12%  perf-profile.children.c=
ycles-pp.read_tsc
>       0.35 =B1 16%      -0.1        0.30 =B1 20%  perf-profile.children.c=
ycles-pp.xas_descend
>       0.66 =B1 30%      -0.0        0.61 =B1 13%  perf-profile.children.c=
ycles-pp.__folio_start_writeback
>       0.10 =B1 40%      -0.0        0.05 =B1 95%  perf-profile.children.c=
ycles-pp.xas_start
>       1.81 =B1 11%      -0.0        1.77 =B1  5%  perf-profile.children.c=
ycles-pp.rebalance_domains
>       0.84 =B1 19%      -0.0        0.79 =B1  6%  perf-profile.children.c=
ycles-pp.update_sd_lb_stats
>       0.10 =B1 57%      -0.0        0.05 =B1 61%  perf-profile.children.c=
ycles-pp.account_io_completion
>       0.44 =B1 14%      -0.0        0.40 =B1 17%  perf-profile.children.c=
ycles-pp.get_page_from_freelist
>       0.15 =B1 22%      -0.0        0.10 =B1 45%  perf-profile.children.c=
ycles-pp.irqtime_account_process_tick
>       0.27 =B1160%      -0.0        0.22 =B1176%  perf-profile.children.c=
ycles-pp.io_serial_in
>       0.19 =B1 22%      -0.0        0.15 =B1 22%  perf-profile.children.c=
ycles-pp.ext4_da_map_blocks
>       0.09 =B1 50%      -0.0        0.05 =B1 92%  perf-profile.children.c=
ycles-pp.xa_get_order
>       0.06 =B1 46%      -0.0        0.02 =B1180%  perf-profile.children.c=
ycles-pp.__open64_nocancel
>       1.02 =B1 15%      -0.0        0.98 =B1 20%  perf-profile.children.c=
ycles-pp.filemap_add_folio
>       0.13 =B1 23%      -0.0        0.09 =B1 50%  perf-profile.children.c=
ycles-pp.seq_read_iter
>       0.79 =B1  8%      -0.0        0.74 =B1 13%  perf-profile.children.c=
ycles-pp.irqtime_account_irq
>       0.11 =B1 37%      -0.0        0.07 =B1 42%  perf-profile.children.c=
ycles-pp.folio_unlock
>       1.36 =B1 12%      -0.0        1.32 =B1 11%  perf-profile.children.c=
ycles-pp.rcu_sched_clock_irq
>       0.05 =B1 69%      -0.0        0.02 =B1176%  perf-profile.children.c=
ycles-pp.up_write
>       0.10 =B1 22%      -0.0        0.06 =B1 24%  perf-profile.children.c=
ycles-pp.asm_common_interrupt
>       0.10 =B1 22%      -0.0        0.06 =B1 24%  perf-profile.children.c=
ycles-pp.common_interrupt
>       0.06 =B1 54%      -0.0        0.02 =B1131%  perf-profile.children.c=
ycles-pp.___slab_alloc
>       0.04 =B1121%      -0.0        0.00        perf-profile.children.cyc=
les-pp.dequeue_task_fair
>       0.67 =B1 20%      -0.0        0.64 =B1 18%  perf-profile.children.c=
ycles-pp.rcu_report_qs_rdp
>       0.03 =B1119%      -0.0        0.00        perf-profile.children.cyc=
les-pp.dequeue_entity
>       0.07 =B1 74%      -0.0        0.04 =B1103%  perf-profile.children.c=
ycles-pp.alloc_pages
>       0.10 =B1 28%      -0.0        0.06 =B1 79%  perf-profile.children.c=
ycles-pp.node_dirty_ok
>       0.87 =B1 18%      -0.0        0.83 =B1  4%  perf-profile.children.c=
ycles-pp.find_busiest_group
>       0.32 =B1158%      -0.0        0.28 =B1173%  perf-profile.children.c=
ycles-pp.serial8250_console_write
>       0.13 =B1 38%      -0.0        0.09 =B1 63%  perf-profile.children.c=
ycles-pp.tick_check_broadcast_expired
>       0.89 =B1 25%      -0.0        0.86 =B1 13%  perf-profile.children.c=
ycles-pp.ext4_bio_write_folio
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.irq_work_run
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp._printk
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.vprintk_emit
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.console_unlock
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.console_flush_all
>       0.04 =B1102%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.pcpu_alloc
>       0.67 =B1 20%      -0.0        0.64 =B1 24%  perf-profile.children.c=
ycles-pp.__filemap_add_folio
>       0.10 =B1 25%      -0.0        0.06 =B1 23%  perf-profile.children.c=
ycles-pp.__common_interrupt
>       0.20 =B1 16%      -0.0        0.17 =B1 37%  perf-profile.children.c=
ycles-pp.__mod_memcg_lruvec_state
>       0.29 =B1 20%      -0.0        0.26 =B1 35%  perf-profile.children.c=
ycles-pp.local_clock
>       0.08 =B1 19%      -0.0        0.05 =B1 65%  perf-profile.children.c=
ycles-pp.setlocale
>       0.09 =B1 25%      -0.0        0.06 =B1 23%  perf-profile.children.c=
ycles-pp.handle_irq_event
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.asm_sysvec_irq_work
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.sysvec_irq_work
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.__sysvec_irq_work
>       0.32 =B1158%      -0.0        0.29 =B1173%  perf-profile.children.c=
ycles-pp.irq_work_single
>       0.31 =B1158%      -0.0        0.28 =B1173%  perf-profile.children.c=
ycles-pp.wait_for_lsr
>       0.09 =B1 25%      -0.0        0.06 =B1 23%  perf-profile.children.c=
ycles-pp.__handle_irq_event_percpu
>       0.14 =B1 25%      -0.0        0.11 =B1 28%  perf-profile.children.c=
ycles-pp.rmqueue_bulk
>       0.19 =B1 16%      -0.0        0.16 =B1 19%  perf-profile.children.c=
ycles-pp.hrtimer_get_next_event
>       0.24 =B1 26%      -0.0        0.21 =B1 31%  perf-profile.children.c=
ycles-pp.mmap_region
>       0.40 =B1 24%      -0.0        0.37 =B1 13%  perf-profile.children.c=
ycles-pp.percpu_counter_add_batch
>       0.14 =B1 33%      -0.0        0.11 =B1 46%  perf-profile.children.c=
ycles-pp.run_posix_cpu_timers
>       0.26 =B1 20%      -0.0        0.24 =B1 21%  perf-profile.children.c=
ycles-pp.rmqueue
>       0.40 =B1 15%      -0.0        0.38 =B1 16%  perf-profile.children.c=
ycles-pp.update_irq_load_avg
>       0.19 =B1 32%      -0.0        0.17 =B1 33%  perf-profile.children.c=
ycles-pp.ksys_mmap_pgoff
>       0.07 =B1 57%      -0.0        0.04 =B1 86%  perf-profile.children.c=
ycles-pp.xas_clear_mark
>       0.17 =B1 28%      -0.0        0.14 =B1 44%  perf-profile.children.c=
ycles-pp.schedule
>       0.26 =B1 20%      -0.0        0.23 =B1 33%  perf-profile.children.c=
ycles-pp.folio_account_dirtied
>       0.13 =B1 30%      -0.0        0.10 =B1 21%  perf-profile.children.c=
ycles-pp.cpuidle_reflect
>       0.02 =B1158%      -0.0        0.00        perf-profile.children.cyc=
les-pp.in_ramp_time
>       1.44 =B1  8%      -0.0        1.42 =B1 17%  perf-profile.children.c=
ycles-pp.clockevents_program_event
>       0.25 =B1 28%      -0.0        0.23 =B1 29%  perf-profile.children.c=
ycles-pp.vm_mmap_pgoff
>       0.05 =B1 66%      -0.0        0.03 =B1102%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_prepare_planes
>       0.20 =B1 17%      -0.0        0.18 =B1 28%  perf-profile.children.c=
ycles-pp.__x64_sys_openat
>       0.25 =B1 29%      -0.0        0.22 =B1 29%  perf-profile.children.c=
ycles-pp.do_mmap
>       0.08 =B1 73%      -0.0        0.05 =B1 94%  perf-profile.children.c=
ycles-pp.__split_vma
>       0.04 =B1 89%      -0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.allocate_slab
>       0.02 =B1116%      -0.0        0.00        perf-profile.children.cyc=
les-pp.io_schedule_timeout
>       0.20 =B1 18%      -0.0        0.18 =B1 28%  perf-profile.children.c=
ycles-pp.do_sys_openat2
>       0.04 =B1 95%      -0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.vma_interval_tree_insert
>       0.69 =B1 12%      -0.0        0.67 =B1 13%  perf-profile.children.c=
ycles-pp.native_apic_msr_eoi_write
>       0.95 =B1 23%      -0.0        0.93 =B1 30%  perf-profile.children.c=
ycles-pp.folio_end_writeback
>       0.08 =B1 50%      -0.0        0.06 =B1 54%  perf-profile.children.c=
ycles-pp.__fprop_add_percpu
>       0.62 =B1 18%      -0.0        0.60 =B1 11%  perf-profile.children.c=
ycles-pp.update_sg_lb_stats
>       0.05 =B1 66%      -0.0        0.03 =B1102%  perf-profile.children.c=
ycles-pp.drm_gem_fb_vmap
>       0.07 =B1 67%      -0.0        0.05 =B1 85%  perf-profile.children.c=
ycles-pp.__pthread_disable_asynccancel
>       0.46 =B1 20%      -0.0        0.44 =B1 25%  perf-profile.children.c=
ycles-pp.__mod_lruvec_page_state
>       0.06 =B1 74%      -0.0        0.04 =B1 86%  perf-profile.children.c=
ycles-pp.io_completed
>       0.15 =B1 36%      -0.0        0.13 =B1 31%  perf-profile.children.c=
ycles-pp.__cond_resched
>       0.14 =B1 14%      -0.0        0.12 =B1 20%  perf-profile.children.c=
ycles-pp.ext4_es_lookup_extent
>       0.05 =B1 43%      -0.0        0.03 =B1106%  perf-profile.children.c=
ycles-pp.security_file_permission
>       0.16 =B1 32%      -0.0        0.14 =B1 45%  perf-profile.children.c=
ycles-pp.filemap_map_pages
>       0.07 =B1 17%      -0.0        0.05 =B1 85%  perf-profile.children.c=
ycles-pp.add_lat_sample
>       0.09 =B1 52%      -0.0        0.07 =B1 47%  perf-profile.children.c=
ycles-pp.mas_store_prealloc
>       0.18 =B1 22%      -0.0        0.16 =B1 40%  perf-profile.children.c=
ycles-pp.path_openat
>       0.02 =B1163%      -0.0        0.00        perf-profile.children.cyc=
les-pp.tick_nohz_idle_got_tick
>       0.02 =B1163%      -0.0        0.00        perf-profile.children.cyc=
les-pp.current_time
>       0.04 =B1 89%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.handle_fasteoi_irq
>       0.04 =B1 89%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.acpi_irq
>       0.04 =B1 89%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.acpi_ev_sci_xrupt_handler
>       0.04 =B1 89%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.acpi_os_read_port
>       0.04 =B1 89%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.acpi_ev_gpe_detect
>       0.04 =B1 89%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.acpi_ev_detect_gpe
>       0.06 =B1 79%      -0.0        0.04 =B1 80%  perf-profile.children.c=
ycles-pp.mm_init
>       0.02 =B1116%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.folio_memcg_unlock
>       0.02 =B1116%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.timer_clear_idle
>       0.03 =B1 87%      -0.0        0.01 =B1174%  perf-profile.children.c=
ycles-pp.ext4_file_write_iter
>       0.03 =B1 87%      -0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.schedule_timeout
>       0.12 =B1 20%      -0.0        0.10 =B1 28%  perf-profile.children.c=
ycles-pp.filemap_get_folios_tag
>       0.02 =B1158%      -0.0        0.00        perf-profile.children.cyc=
les-pp.cpuidle_select
>       0.02 =B1161%      -0.0        0.00        perf-profile.children.cyc=
les-pp._find_first_bit
>       0.02 =B1116%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.ntime_since
>       0.03 =B1120%      -0.0        0.01 =B1174%  perf-profile.children.c=
ycles-pp.alloc_bprm
>       0.02 =B1159%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__memcpy
>       0.02 =B1159%      -0.0        0.00        perf-profile.children.cyc=
les-pp.drm_atomic_helper_cleanup_planes
>       0.02 =B1159%      -0.0        0.00        perf-profile.children.cyc=
les-pp.drm_gem_fb_vunmap
>       0.02 =B1159%      -0.0        0.00        perf-profile.children.cyc=
les-pp.ramp_time_over
>       0.02 =B1159%      -0.0        0.00        perf-profile.children.cyc=
les-pp.syscall_return_via_sysret
>       0.02 =B1159%      -0.0        0.00        perf-profile.children.cyc=
les-pp.evlist__id2evsel
>       0.07 =B1 49%      -0.0        0.05 =B1 87%  perf-profile.children.c=
ycles-pp.next_uptodate_page
>       0.20 =B1 23%      -0.0        0.19 =B1 34%  perf-profile.children.c=
ycles-pp.memcg_slab_post_alloc_hook
>       0.18 =B1 19%      -0.0        0.17 =B1 39%  perf-profile.children.c=
ycles-pp.do_filp_open
>       0.02 =B1162%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.ext4_dirty_inode
>       0.24 =B1 30%      -0.0        0.23 =B1 12%  perf-profile.children.c=
ycles-pp.ct_idle_exit
>       0.11 =B1 70%      -0.0        0.09 =B1 48%  perf-profile.children.c=
ycles-pp.file_modified_flags
>       0.08 =B1 62%      -0.0        0.06 =B1 62%  perf-profile.children.c=
ycles-pp.run_timer_softirq
>       0.01 =B1158%      -0.0        0.00        perf-profile.children.cyc=
les-pp.put_io_u
>       0.01 =B1158%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__update_load_avg_se
>       0.01 =B1158%      -0.0        0.00        perf-profile.children.cyc=
les-pp.dup_task_struct
>       0.06 =B1 68%      -0.0        0.05 =B1 82%  perf-profile.children.c=
ycles-pp.down_write
>       0.03 =B1 89%      -0.0        0.02 =B1175%  perf-profile.children.c=
ycles-pp.show_stat
>       0.02 =B1162%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__percpu_counter_init
>       0.03 =B1116%      -0.0        0.02 =B1179%  perf-profile.children.c=
ycles-pp.sched_ttwu_pending
>       0.72 =B1 18%      -0.0        0.70 =B1 16%  perf-profile.children.c=
ycles-pp.tick_nohz_next_event
>       0.05 =B1 70%      -0.0        0.04 =B1111%  perf-profile.children.c=
ycles-pp.tick_do_update_jiffies64
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.mas_wr_modify
>       0.04 =B1142%      -0.0        0.03 =B1104%  perf-profile.children.c=
ycles-pp.update_vsyscall
>       0.05 =B1 67%      -0.0        0.04 =B1 81%  perf-profile.children.c=
ycles-pp.__irqentry_text_start
>       0.03 =B1 87%      -0.0        0.02 =B1182%  perf-profile.children.c=
ycles-pp.rcu_nocb_flush_deferred_wakeup
>       0.02 =B1160%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.rcu_report_qs_rnp
>       0.42 =B1 21%      -0.0        0.41 =B1 15%  perf-profile.children.c=
ycles-pp.check_cpu_stall
>       0.04 =B1123%      -0.0        0.02 =B1133%  perf-profile.children.c=
ycles-pp.__get_io_u
>       0.04 =B1121%      -0.0        0.02 =B1133%  perf-profile.children.c=
ycles-pp.io_queue_event
>       0.02 =B1162%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.dput
>       0.04 =B1 90%      -0.0        0.03 =B1144%  perf-profile.children.c=
ycles-pp.step_into
>       0.03 =B1116%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.acpi_hw_gpe_read
>       0.08 =B1 68%      -0.0        0.07 =B1 45%  perf-profile.children.c=
ycles-pp.entry_SYSRETQ_unsafe_stack
>       0.02 =B1158%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.devkmsg_read
>       0.02 =B1158%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.force_qs_rnp
>       0.02 =B1159%      -0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.generic_update_time
>       0.02 =B1116%      -0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.getname_flags
>       0.02 =B1116%      -0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.wait4
>       0.24 =B1 26%      -0.0        0.23 =B1 34%  perf-profile.children.c=
ycles-pp.__schedule
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.mas_wr_node_store
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.io_u_mark_depth
>       0.17 =B1 31%      -0.0        0.16 =B1 42%  perf-profile.children.c=
ycles-pp.do_read_fault
>       0.04 =B1 88%      -0.0        0.03 =B1104%  perf-profile.children.c=
ycles-pp.update_load_avg
>       0.02 =B1161%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.vma_prepare
>       0.02 =B1159%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.check_move_unevictable_folios
>       0.02 =B1159%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.check_move_unevictable_pages
>       0.02 =B1159%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__bitmap_and
>       0.03 =B1127%      -0.0        0.02 =B1130%  perf-profile.children.c=
ycles-pp.sched_idle_set_state
>       0.02 =B1158%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.vma_complete
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp._copy_from_user
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.mas_next_entry
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.scsi_io_completion
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.log_io_u
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.mas_wr_walk
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.scsi_end_request
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.mas_wr_store_entry
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.perf_swevent_start
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.refill_obj_stock
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__get_obj_cgroup_from_memcg
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp._IO_fwrite
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__anon_vma_prepare
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.do_open
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.kmem_cache_free_bulk
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.rcu_accelerate_cbs
>       0.14 =B1 30%      -0.0        0.13 =B1 21%  perf-profile.children.c=
ycles-pp.__entry_text_start
>       0.01 =B1158%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp._raw_read_lock
>       0.02 =B1169%      -0.0        0.01 =B1174%  perf-profile.children.c=
ycles-pp.policy_node
>       0.03 =B1124%      -0.0        0.02 =B1130%  perf-profile.children.c=
ycles-pp.irq_work_needs_cpu
>       0.04 =B1 87%      -0.0        0.03 =B1106%  perf-profile.children.c=
ycles-pp.node_page_state
>       0.18 =B1 14%      -0.0        0.17 =B1 30%  perf-profile.children.c=
ycles-pp.lru_add_fn
>       0.02 =B1158%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.find_idlest_cpu
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.get_start_offset
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.io_bytes_exceeded
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.page_remove_rmap
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.rcu_segcblist_ready_cbs
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.remove_vm_area
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.workingset_update_node
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__list_add_valid
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.init_icd
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__memcg_kmem_charge_page
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.task_tick_idle
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__vmalloc_node_range
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__vmalloc_area_node
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__alloc_pages_bulk
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.do_nanosleep
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.alloc_thread_stack_node
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__d_add
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.get_idle_time
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.update_curr
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__file_remove_privs
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.entry_SYSCALL_64_safe_stack
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.rcu_needs_cpu
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.free_unref_page_list
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.irq_exit_rcu
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.jbd2__journal_start
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.__ext4_mark_inode_dirty
>       0.01 =B1244%      -0.0        0.00        perf-profile.children.cyc=
les-pp.open64
>       0.11 =B1 29%      -0.0        0.10 =B1 28%  perf-profile.children.c=
ycles-pp.hrtimer_forward
>       0.07 =B1 77%      -0.0        0.06 =B1 80%  perf-profile.children.c=
ycles-pp.activate_task
>       0.06 =B1 46%      -0.0        0.06 =B1 87%  perf-profile.children.c=
ycles-pp.error_return
>       0.13 =B1 22%      -0.0        0.13 =B1 21%  perf-profile.children.c=
ycles-pp.__xa_clear_mark
>       0.50 =B1 11%      -0.0        0.49 =B1 16%  perf-profile.children.c=
ycles-pp.update_rq_clock_task
>       0.04 =B1 91%      -0.0        0.03 =B1100%  perf-profile.children.c=
ycles-pp.xas_find_marked
>       0.06 =B1 77%      -0.0        0.05 =B1 62%  perf-profile.children.c=
ycles-pp.can_stop_idle_tick
>       0.08 =B1 53%      -0.0        0.07 =B1 64%  perf-profile.children.c=
ycles-pp.call_timer_fn
>       0.06 =B1 50%      -0.0        0.05 =B1 86%  perf-profile.children.c=
ycles-pp.get_mem_cgroup_from_mm
>       0.04 =B1 89%      -0.0        0.03 =B1111%  perf-profile.children.c=
ycles-pp.select_task_rq_fair
>       0.02 =B1159%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.update_sg_wakeup_stats
>       0.02 =B1159%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.find_idlest_group
>       0.03 =B1163%      -0.0        0.02 =B1180%  perf-profile.children.c=
ycles-pp.xas_set_mark
>       1.13 =B1 10%      -0.0        1.13 =B1  5%  perf-profile.children.c=
ycles-pp.load_balance
>       0.03 =B1123%      -0.0        0.03 =B1100%  perf-profile.children.c=
ycles-pp.hrtimer_run_queues
>       0.05 =B1 69%      -0.0        0.05 =B1 85%  perf-profile.children.c=
ycles-pp.ext4_update_bh_state
>       0.03 =B1118%      -0.0        0.03 =B1133%  perf-profile.children.c=
ycles-pp.inode_to_bdi
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__slab_free
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.get_arg_page
>       0.03 =B1159%      -0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.wait_for_xmitr
>       0.06 =B1 76%      -0.0        0.05 =B1 80%  perf-profile.children.c=
ycles-pp.enqueue_task_fair
>       0.85 =B1 23%      -0.0        0.84 =B1 31%  perf-profile.children.c=
ycles-pp.__folio_end_writeback
>       0.05 =B1104%      -0.0        0.04 =B1106%  perf-profile.children.c=
ycles-pp.filemap_get_folios
>       0.07 =B1 55%      -0.0        0.07 =B1 24%  perf-profile.children.c=
ycles-pp.rcu_do_batch
>       0.05 =B1 68%      -0.0        0.05 =B1 43%  perf-profile.children.c=
ycles-pp.pipe_read
>       0.21 =B1 32%      -0.0        0.21 =B1 19%  perf-profile.children.c=
ycles-pp.process_interval
>       0.02 =B1116%      -0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.get_next_seq_offset
>       0.10 =B1 26%      -0.0        0.10 =B1 28%  perf-profile.children.c=
ycles-pp.mem_cgroup_css_rstat_flush
>       0.34 =B1 11%      -0.0        0.34 =B1 22%  perf-profile.children.c=
ycles-pp.folio_add_lru
>       0.05 =B1 76%      -0.0        0.05 =B1 81%  perf-profile.children.c=
ycles-pp.enqueue_entity
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.poll_spurious_irqs
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__get_user_pages
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.shuffle_freelist
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.get_user_pages_remote
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.get_cpu_sleep_time_us
>       0.43 =B1106%      -0.0        0.42 =B1111%  perf-profile.children.c=
ycles-pp.drm_fb_helper_damage_work
>       0.43 =B1106%      -0.0        0.42 =B1111%  perf-profile.children.c=
ycles-pp.drm_fbdev_generic_helper_fb_dirty
>       0.11 =B1 39%      -0.0        0.10 =B1 52%  perf-profile.children.c=
ycles-pp.do_vmi_munmap
>       0.14 =B1 44%      -0.0        0.14 =B1 27%  perf-profile.children.c=
ycles-pp.tick_program_event
>       0.10 =B1 53%      -0.0        0.09 =B1 61%  perf-profile.children.c=
ycles-pp.do_vmi_align_munmap
>       0.02 =B1159%      -0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.__xstat64
>       0.08 =B1 57%      -0.0        0.08 =B1 61%  perf-profile.children.c=
ycles-pp.add_clat_sample
>       0.02 =B1116%      -0.0        0.02 =B1131%  perf-profile.children.c=
ycles-pp.perf_iterate_sb
>       0.21 =B1 32%      -0.0        0.21 =B1 19%  perf-profile.children.c=
ycles-pp.cmd_stat
>       0.21 =B1 32%      -0.0        0.21 =B1 19%  perf-profile.children.c=
ycles-pp.dispatch_events
>       0.02 =B1169%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.handle_edge_irq
>       0.06 =B1 49%      -0.0        0.06 =B1 94%  perf-profile.children.c=
ycles-pp.ct_kernel_exit
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.perf_event_mmap_output
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.wake_up_new_task
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.clock_nanosleep
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__msecs_to_jiffies
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.perf_swevent_stop
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.mas_destroy
>       0.09 =B1 61%      -0.0        0.09 =B1 60%  perf-profile.children.c=
ycles-pp.__mark_inode_dirty
>       0.03 =B1120%      -0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.do_set_pte
>       0.02 =B1118%      -0.0        0.02 =B1134%  perf-profile.children.c=
ycles-pp.folio_mapping
>       0.05 =B1112%      -0.0        0.05 =B1 64%  perf-profile.children.c=
ycles-pp.timekeeping_update
>       0.04 =B1 65%      -0.0        0.04 =B1107%  perf-profile.children.c=
ycles-pp.balance_fair
>       0.03 =B1121%      -0.0        0.03 =B1134%  perf-profile.children.c=
ycles-pp.__vfork
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__switch_to
>       0.07 =B1 47%      -0.0        0.07 =B1 67%  perf-profile.children.c=
ycles-pp.evlist_cpu_iterator__next
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__x64_sys_clock_nanosleep
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.common_nsleep
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.hrtimer_nanosleep
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.affine_move_task
>       0.08 =B1 27%      -0.0        0.08 =B1 20%  perf-profile.children.c=
ycles-pp.menu_reflect
>       0.07 =B1 51%      -0.0        0.07 =B1 75%  perf-profile.children.c=
ycles-pp.newidle_balance
>       0.02 =B1161%      -0.0        0.02 =B1137%  perf-profile.children.c=
ycles-pp.do_anonymous_page
>       0.09 =B1 48%      -0.0        0.09 =B1 30%  perf-profile.children.c=
ycles-pp.rcu_gp_kthread
>       0.06 =B1 50%      -0.0        0.06 =B1 44%  perf-profile.children.c=
ycles-pp.elf_map
>       0.16 =B1 31%      +0.0        0.16 =B1 27%  perf-profile.children.c=
ycles-pp.release_pages
>       0.19 =B1 36%      +0.0        0.19 =B1 39%  perf-profile.children.c=
ycles-pp.do_fault
>       0.32 =B1 35%      +0.0        0.32 =B1 23%  perf-profile.children.c=
ycles-pp.mpage_prepare_extent_to_map
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.fold_vm_numa_events
>       0.03 =B1116%      +0.0        0.03 =B1134%  perf-profile.children.c=
ycles-pp.__count_memcg_events
>       0.07 =B1 90%      +0.0        0.07 =B1 50%  perf-profile.children.c=
ycles-pp.__pagevec_release
>       0.08 =B1 47%      +0.0        0.08 =B1 36%  perf-profile.children.c=
ycles-pp.nr_iowait_cpu
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.poll_idle
>       0.02 =B1166%      +0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.__x64_sys_vfork
>       0.12 =B1 52%      +0.0        0.12 =B1 32%  perf-profile.children.c=
ycles-pp.__note_gp_changes
>       0.05 =B1 66%      +0.0        0.05 =B1 62%  perf-profile.children.c=
ycles-pp.__sysvec_call_function_single
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.task_work_run
>       0.02 =B1158%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.__mod_zone_page_state
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.do_cow_fault
>       0.12 =B1 30%      +0.0        0.12 =B1 47%  perf-profile.children.c=
ycles-pp.copy_process
>       0.52 =B1 16%      +0.0        0.52 =B1 21%  perf-profile.children.c=
ycles-pp.run_rebalance_domains
>       0.08 =B1 59%      +0.0        0.09 =B1 49%  perf-profile.children.c=
ycles-pp.__run_timers
>       0.03 =B1116%      +0.0        0.04 =B1105%  perf-profile.children.c=
ycles-pp.account_process_tick
>       0.01 =B1158%      +0.0        0.02 =B1179%  perf-profile.children.c=
ycles-pp.sync_regs
>       0.04 =B1 86%      +0.0        0.05 =B1 67%  perf-profile.children.c=
ycles-pp.rcu_all_qs
>       0.03 =B1 90%      +0.0        0.04 =B1 81%  perf-profile.children.c=
ycles-pp.__x64_sys_sched_setaffinity
>       0.02 =B1116%      +0.0        0.03 =B1100%  perf-profile.children.c=
ycles-pp.drm_gem_check_release_pagevec
>       0.07 =B1 51%      +0.0        0.08 =B1 68%  perf-profile.children.c=
ycles-pp.xas_find_conflict
>       0.02 =B1172%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.__list_del_entry_valid
>       0.04 =B1 91%      +0.0        0.04 =B1 60%  perf-profile.children.c=
ycles-pp.drm_gem_vunmap_unlocked
>       0.04 =B1 91%      +0.0        0.04 =B1 60%  perf-profile.children.c=
ycles-pp.drm_gem_vunmap
>       0.04 =B1 91%      +0.0        0.04 =B1 60%  perf-profile.children.c=
ycles-pp.drm_gem_shmem_vunmap
>       0.37 =B1 18%      +0.0        0.38 =B1 17%  perf-profile.children.c=
ycles-pp.perf_pmu_nop_void
>       0.18 =B1 21%      +0.0        0.18 =B1 18%  perf-profile.children.c=
ycles-pp.ct_kernel_enter
>       0.07 =B1 26%      +0.0        0.07 =B1 46%  perf-profile.children.c=
ycles-pp.sysvec_call_function_single
>       0.02 =B1244%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.mas_split
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.__d_alloc
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.children.c=
ycles-pp.sched_clock_tick
>       0.05 =B1 68%      +0.0        0.05 =B1 86%  perf-profile.children.c=
ycles-pp.perf_event_mmap
>       0.01 =B1158%      +0.0        0.02 =B1175%  perf-profile.children.c=
ycles-pp.nohz_balancer_kick
>       0.02 =B1116%      +0.0        0.03 =B1130%  perf-profile.children.c=
ycles-pp.__radix_tree_lookup
>       0.28 =B1 16%      +0.0        0.28 =B1 23%  perf-profile.children.c=
ycles-pp.folio_batch_move_lru
>       0.11 =B1 27%      +0.0        0.12 =B1 34%  perf-profile.children.c=
ycles-pp.fault_in_readable
>       0.01 =B1244%      +0.0        0.02 =B1176%  perf-profile.children.c=
ycles-pp.__set_cpus_allowed_ptr
>       0.01 =B1244%      +0.0        0.01 =B1174%  perf-profile.children.c=
ycles-pp.vsnprintf
>       0.01 =B1244%      +0.0        0.01 =B1174%  perf-profile.children.c=
ycles-pp.__wake_up_common
>       0.03 =B1119%      +0.0        0.03 =B1103%  perf-profile.children.c=
ycles-pp.asm_sysvec_reschedule_ipi
>       0.08 =B1 29%      +0.0        0.08 =B1 49%  perf-profile.children.c=
ycles-pp.syscall_exit_to_user_mode
>       0.04 =B1 89%      +0.0        0.04 =B1113%  perf-profile.children.c=
ycles-pp.rcu_gp_fqs_loop
>       0.04 =B1 94%      +0.0        0.04 =B1 81%  perf-profile.children.c=
ycles-pp.__fget_light
>       0.02 =B1158%      +0.0        0.02 =B1130%  perf-profile.children.c=
ycles-pp.generic_write_checks
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.__do_sys_wait4
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.kernel_wait4
>       0.08 =B1 21%      +0.0        0.08 =B1 53%  perf-profile.children.c=
ycles-pp.begin_new_exec
>       0.02 =B1158%      +0.0        0.02 =B1131%  perf-profile.children.c=
ycles-pp.xas_create
>       0.12 =B1 25%      +0.0        0.12 =B1 37%  perf-profile.children.c=
ycles-pp.fault_in_iov_iter_readable
>       0.06 =B1 90%      +0.0        0.06 =B1 59%  perf-profile.children.c=
ycles-pp.tick_nohz_stop_idle
>       0.06 =B1 71%      +0.0        0.06 =B1 83%  perf-profile.children.c=
ycles-pp.copy_strings
>       0.02 =B1244%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.utime_since_now
>       0.20 =B1 26%      +0.0        0.21 =B1 20%  perf-profile.children.c=
ycles-pp._raw_spin_unlock_irqrestore
>       0.08 =B1 47%      +0.0        0.09 =B1 45%  perf-profile.children.c=
ycles-pp.update_rt_rq_load_avg
>       0.02 =B1160%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.ext4_generic_write_checks
>       0.02 =B1158%      +0.0        0.02 =B1137%  perf-profile.children.c=
ycles-pp.acpi_idle_do_entry
>       0.02 =B1163%      +0.0        0.02 =B1133%  perf-profile.children.c=
ycles-pp.__sched_setaffinity
>       0.01 =B1244%      +0.0        0.01 =B1174%  perf-profile.children.c=
ycles-pp.mas_preallocate
>       0.01 =B1244%      +0.0        0.01 =B1174%  perf-profile.children.c=
ycles-pp.ext4_nonda_switch
>       0.05 =B1 73%      +0.0        0.05 =B1 69%  perf-profile.children.c=
ycles-pp.pick_next_task_fair
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.mas_walk
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.cpu_stopper_thread
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.migration_cpu_stop
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.children.c=
ycles-pp.move_queued_task
>       0.02 =B1159%      +0.0        0.02 =B1182%  perf-profile.children.c=
ycles-pp.free_pgtables
>       0.07 =B1 47%      +0.0        0.07 =B1 53%  perf-profile.children.c=
ycles-pp.evsel__read_counter
>       0.02 =B1164%      +0.0        0.03 =B1100%  perf-profile.children.c=
ycles-pp.mprotect_fixup
>       1.71 =B1 10%      +0.0        1.72 =B1 11%  perf-profile.children.c=
ycles-pp.arch_scale_freq_tick
>       0.03 =B1117%      +0.0        0.04 =B1 80%  perf-profile.children.c=
ycles-pp.io_u_sync_complete
>       0.01 =B1244%      +0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.apparmor_file_permission
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.memcg_account_kmem
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__mod_timer
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.get_nohz_timer_target
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.acpi_os_execute_deferred
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.acpi_ev_asynch_execute_gpe_method
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.acpi_ns_evaluate
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.acpi_ps_execute_method
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.acpi_ps_parse_aml
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.acpi_ps_parse_loop
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__fxstat64
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__get_task_ioprio
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__kmem_cache_alloc_bulk
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__tlb_remove_page_size
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.copy_page
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.inode_needs_update_time
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.getenv
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.perf_stat_process_counter
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__perf_event_read_value
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.dentry_kill
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.rcu_gp_init
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__send_signal_locked
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.complete_signal
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.cpu_stop_queue_work
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.kmem_cache_alloc_bulk
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.memmove
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.process_counters
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.cpu_latency_qos_limit
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__flush_smp_call_function_queue
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.hrtimer_wakeup
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.vma_interval_tree_remove
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.fio_syncio_queue
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp._IO_setvbuf
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__kmalloc_node
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.do_wait
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.flush_tlb_func
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.native_flush_tlb_one_user
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.page_add_file_rmap
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.do_poll
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__mmdrop
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__x64_sys_poll
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.blk_mq_submit_bio
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.do_sys_poll
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.copy_page_range
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.copy_p4d_range
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__poll
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.perf_evlist__poll
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__check_object_size
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.security_file_alloc
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.setup_arg_pages
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.mas_push_data
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.delayed_vfree_work
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.printk_get_next_message
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.vfree
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.clear_page_erms
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.mutex_lock
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp._IO_file_xsputn
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__call_rcu_common
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.khugepaged_scan_mm_slot
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.khugepaged
>       0.03 =B1117%      +0.0        0.03 =B1 78%  perf-profile.children.c=
ycles-pp.drm_gem_put_pages
>       0.03 =B1117%      +0.0        0.03 =B1 78%  perf-profile.children.c=
ycles-pp.drm_gem_shmem_put_pages_locked
>       0.37 =B1 20%      +0.0        0.38 =B1 21%  perf-profile.children.c=
ycles-pp.get_next_timer_interrupt
>       0.24 =B1 12%      +0.0        0.25 =B1 19%  perf-profile.children.c=
ycles-pp.asm_sysvec_call_function_single
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.ct_irq_exit
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__fput
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.unlink_anon_vmas
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.select_task_rq
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.autoremove_wake_function
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.find_vma
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.mt_find
>       0.01 =B1244%      +0.0        0.02 =B1176%  perf-profile.children.c=
ycles-pp.load_elf_interp
>       0.01 =B1244%      +0.0        0.02 =B1176%  perf-profile.children.c=
ycles-pp.tick_nohz_idle_retain_tick
>       0.10 =B1 25%      +0.0        0.10 =B1 66%  perf-profile.children.c=
ycles-pp.try_to_wake_up
>       0.04 =B1 91%      +0.0        0.05 =B1 65%  perf-profile.children.c=
ycles-pp.try_charge_memcg
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.io_u_mark_submit
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.diskstats_show
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.finish_task_switch
>       0.01 =B1244%      +0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.__wake_up_common_lock
>       0.17 =B1 34%      +0.0        0.18 =B1 26%  perf-profile.children.c=
ycles-pp.arch_cpu_idle_exit
>       0.18 =B1 17%      +0.0        0.19 =B1 29%  perf-profile.children.c=
ycles-pp.call_cpuidle
>       0.35 =B1 16%      +0.0        0.36 =B1 11%  perf-profile.children.c=
ycles-pp.update_rq_clock
>       0.03 =B1117%      +0.0        0.04 =B1108%  perf-profile.children.c=
ycles-pp.wp_page_copy
>       0.18 =B1 30%      +0.0        0.19 =B1 20%  perf-profile.children.c=
ycles-pp.read_counters
>       0.03 =B1 88%      +0.0        0.04 =B1 61%  perf-profile.children.c=
ycles-pp.memset_orig
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.flush_tlb_mm_range
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.slab_pre_alloc_hook
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.timekeeping_max_deferment
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.__d_lookup_rcu
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.mutex_unlock
>       0.05 =B1 42%      +0.0        0.06 =B1 88%  perf-profile.children.c=
ycles-pp.exec_mmap
>       0.01 =B1244%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.megasas_isr_fusion
>       0.01 =B1244%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.complete_cmd_fusion
>       0.01 =B1244%      +0.0        0.02 =B1182%  perf-profile.children.c=
ycles-pp.task_tick_mm_cid
>       0.23 =B1 32%      +0.0        0.24 =B1 18%  perf-profile.children.c=
ycles-pp.__libc_start_main
>       0.23 =B1 32%      +0.0        0.24 =B1 18%  perf-profile.children.c=
ycles-pp.main
>       0.23 =B1 32%      +0.0        0.24 =B1 18%  perf-profile.children.c=
ycles-pp.run_builtin
>       0.20 =B1 27%      +0.0        0.21 =B1 42%  perf-profile.children.c=
ycles-pp.__mod_lruvec_state
>       0.15 =B1 46%      +0.0        0.16 =B1 19%  perf-profile.children.c=
ycles-pp._find_next_and_bit
>       0.00            +0.0        0.01 =B1264%  perf-profile.children.cyc=
les-pp.rcu_preempt_deferred_qs
>       0.05 =B1 44%      +0.0        0.06 =B1 43%  perf-profile.children.c=
ycles-pp.update_group_capacity
>       0.01 =B1244%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.open_last_lookups
>       0.01 =B1244%      +0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.__switch_to_asm
>       0.04 =B1 91%      +0.0        0.05 =B1 86%  perf-profile.children.c=
ycles-pp.perf_event_mmap_event
>       0.04 =B1 96%      +0.0        0.05 =B1 62%  perf-profile.children.c=
ycles-pp.mpage_process_folio
>       0.01 =B1244%      +0.0        0.02 =B1185%  perf-profile.children.c=
ycles-pp.swake_up_one
>       0.05 =B1 72%      +0.0        0.07 =B1 70%  perf-profile.children.c=
ycles-pp.memcg_alloc_slab_cgroups
>       0.13 =B1 25%      +0.0        0.14 =B1 35%  perf-profile.children.c=
ycles-pp.kernel_clone
>       0.29 =B1 35%      +0.0        0.30 =B1 28%  perf-profile.children.c=
ycles-pp.__handle_mm_fault
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.sched_clock_idle_wakeup_event
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.__alloc_file
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.pick_link
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.__legitimize_path
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.alloc_empty_file
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.try_to_unlazy
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.__perf_sw_event
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.ext4_io_submit
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.submit_bio_noacct_nocheck
>       0.00            +0.0        0.01 =B1173%  perf-profile.children.cyc=
les-pp.tick_nohz_get_next_hrtimer
>       0.04 =B1 93%      +0.0        0.05 =B1 41%  perf-profile.children.c=
ycles-pp.__fdget_pos
>       0.01 =B1244%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.mas_alloc_nodes
>       0.01 =B1244%      +0.0        0.02 =B1129%  perf-profile.children.c=
ycles-pp.xas_find
>       0.07 =B1 75%      +0.0        0.08 =B1 49%  perf-profile.children.c=
ycles-pp.cgroup_rstat_updated
>       0.25 =B1 25%      +0.0        0.26 =B1 82%  perf-profile.children.c=
ycles-pp.get_io_u
>       0.18 =B1 28%      +0.0        0.20 =B1 35%  perf-profile.children.c=
ycles-pp.__x64_sys_exit_group
>       0.06 =B1 64%      +0.0        0.08 =B1 67%  perf-profile.children.c=
ycles-pp.xas_store
>       0.05 =B1 76%      +0.0        0.06 =B1 82%  perf-profile.children.c=
ycles-pp.schedule_idle
>       0.10 =B1 51%      +0.0        0.12 =B1 41%  perf-profile.children.c=
ycles-pp.intel_pmu_disable_all
>       0.01 =B1244%      +0.0        0.02 =B1181%  perf-profile.children.c=
ycles-pp.cpuidle_not_available
>       0.00            +0.0        0.01 =B1174%  perf-profile.children.cyc=
les-pp.do_open_execat
>       0.37 =B1 18%      +0.0        0.38 =B1 17%  perf-profile.children.c=
ycles-pp._raw_spin_lock_irq
>       0.01 =B1244%      +0.0        0.02 =B1173%  perf-profile.children.c=
ycles-pp.kmem_cache_alloc_lru
>       0.02 =B1158%      +0.0        0.03 =B1104%  perf-profile.children.c=
ycles-pp.invoke_rcu_core
>       0.06 =B1 49%      +0.0        0.07 =B1 55%  perf-profile.children.c=
ycles-pp.raise_softirq
>       0.03 =B1172%      +0.0        0.04 =B1 79%  perf-profile.children.c=
ycles-pp.__x64_sys_mprotect
>       0.03 =B1172%      +0.0        0.04 =B1 79%  perf-profile.children.c=
ycles-pp.do_mprotect_pkey
>       0.08 =B1 72%      +0.0        0.09 =B1 52%  perf-profile.children.c=
ycles-pp.sched_setaffinity
>       0.03 =B1117%      +0.0        0.04 =B1107%  perf-profile.children.c=
ycles-pp.dup_mmap
>       0.02 =B1159%      +0.0        0.03 =B1102%  perf-profile.children.c=
ycles-pp.proc_reg_read_iter
>       0.48 =B1 15%      +0.0        0.50 =B1 21%  perf-profile.children.c=
ycles-pp.update_blocked_averages
>       0.00            +0.0        0.02 =B1173%  perf-profile.children.cyc=
les-pp.perf_read
>       0.00            +0.0        0.02 =B1173%  perf-profile.children.cyc=
les-pp.__kmem_cache_alloc_node
>       0.00            +0.0        0.02 =B1176%  perf-profile.children.cyc=
les-pp.__bio_try_merge_page
>       0.00            +0.0        0.02 =B1176%  perf-profile.children.cyc=
les-pp.folio_mkclean
>       0.20 =B1 20%      +0.0        0.22 =B1 23%  perf-profile.children.c=
ycles-pp.idle_cpu
>       0.09 =B1 47%      +0.0        0.10 =B1 56%  perf-profile.children.c=
ycles-pp.__do_sys_clone
>       0.06 =B1 73%      +0.0        0.07 =B1 45%  perf-profile.children.c=
ycles-pp.ttwu_do_activate
>       0.01 =B1244%      +0.0        0.02 =B1137%  perf-profile.children.c=
ycles-pp.create_elf_tables
>       0.05 =B1 65%      +0.0        0.07 =B1 60%  perf-profile.children.c=
ycles-pp.mod_objcg_state
>       0.18 =B1 28%      +0.0        0.20 =B1 35%  perf-profile.children.c=
ycles-pp.do_group_exit
>       0.00            +0.0        0.02 =B1179%  perf-profile.children.cyc=
les-pp.perf_evsel__read
>       0.01 =B1244%      +0.0        0.02 =B1132%  perf-profile.children.c=
ycles-pp.profile_tick
>       0.01 =B1244%      +0.0        0.02 =B1133%  perf-profile.children.c=
ycles-pp.restore_regs_and_return_to_kernel
>       0.11 =B1 28%      +0.0        0.12 =B1 30%  perf-profile.children.c=
ycles-pp.rb_erase
>       0.02 =B1159%      +0.0        0.03 =B1136%  perf-profile.children.c=
ycles-pp.bio_add_folio
>       0.05 =B1 96%      +0.0        0.06 =B1 68%  perf-profile.children.c=
ycles-pp.filename_lookup
>       0.05 =B1 96%      +0.0        0.06 =B1 68%  perf-profile.children.c=
ycles-pp.path_lookupat
>       0.01 =B1158%      +0.0        0.03 =B1106%  perf-profile.children.c=
ycles-pp.mtree_range_walk
>       0.04 =B1189%      +0.0        0.06 =B1192%  perf-profile.children.c=
ycles-pp.delay_tsc
>       0.01 =B1244%      +0.0        0.03 =B1138%  perf-profile.children.c=
ycles-pp.raw_spin_rq_lock_nested
>       0.36 =B1 13%      +0.0        0.38 =B1 17%  perf-profile.children.c=
ycles-pp.x86_pmu_disable
>       0.04 =B1 64%      +0.0        0.06 =B1 66%  perf-profile.children.c=
ycles-pp.kmem_cache_free
>       0.08 =B1 53%      +0.0        0.10 =B1 54%  perf-profile.children.c=
ycles-pp.smpboot_thread_fn
>       0.03 =B1158%      +0.0        0.05 =B1 85%  perf-profile.children.c=
ycles-pp.vfs_statx
>       0.07 =B1 76%      +0.0        0.09 =B1 36%  perf-profile.children.c=
ycles-pp.__mmap
>       0.41 =B1 24%      +0.0        0.43 =B1 19%  perf-profile.children.c=
ycles-pp.__x64_sys_execve
>       0.41 =B1 24%      +0.0        0.43 =B1 19%  perf-profile.children.c=
ycles-pp.do_execveat_common
>       0.00            +0.0        0.02 =B1174%  perf-profile.children.cyc=
les-pp.__pthread_enable_asynccancel
>       0.00            +0.0        0.02 =B1129%  perf-profile.children.cyc=
les-pp.ttwu_queue_wakelist
>       0.05 =B1 88%      +0.0        0.07 =B1 69%  perf-profile.children.c=
ycles-pp.dup_mm
>       0.06 =B1 44%      +0.0        0.08 =B1 49%  perf-profile.children.c=
ycles-pp._dl_addr
>       0.14 =B1 30%      +0.0        0.16 =B1 34%  perf-profile.children.c=
ycles-pp.exit_mm
>       0.06 =B1 72%      +0.0        0.08 =B1 45%  perf-profile.children.c=
ycles-pp.zap_pmd_range
>       0.01 =B1244%      +0.0        0.03 =B1104%  perf-profile.children.c=
ycles-pp.exit_to_user_mode_loop
>       0.25 =B1 25%      +0.0        0.27 =B1 17%  perf-profile.children.c=
ycles-pp.timerqueue_del
>       0.14 =B1 32%      +0.0        0.16 =B1 39%  perf-profile.children.c=
ycles-pp.__update_blocked_fair
>       0.02 =B1158%      +0.0        0.05 =B1 78%  perf-profile.children.c=
ycles-pp.__lookup_slow
>       0.16 =B1 31%      +0.0        0.18 =B1 52%  perf-profile.children.c=
ycles-pp.__mod_node_page_state
>       0.00            +0.0        0.02 =B1173%  perf-profile.children.cyc=
les-pp.unmap_region
>       0.07 =B1 48%      +0.0        0.09 =B1 61%  perf-profile.children.c=
ycles-pp.walk_component
>       0.01 =B1244%      +0.0        0.04 =B1113%  perf-profile.children.c=
ycles-pp.obj_cgroup_charge
>       0.17 =B1 28%      +0.0        0.20 =B1 35%  perf-profile.children.c=
ycles-pp.do_exit
>       0.03 =B1 87%      +0.0        0.06 =B1 81%  perf-profile.children.c=
ycles-pp.exit_to_user_mode_prepare
>       0.02 =B1244%      +0.0        0.04 =B1 59%  perf-profile.children.c=
ycles-pp.mas_wr_bnode
>       0.30 =B1 35%      +0.0        0.32 =B1 25%  perf-profile.children.c=
ycles-pp.handle_mm_fault
>       0.03 =B1163%      +0.0        0.05 =B1 59%  perf-profile.children.c=
ycles-pp.mod_zone_page_state
>       0.11 =B1 33%      +0.0        0.14 =B1 40%  perf-profile.children.c=
ycles-pp.__libc_fork
>       0.01 =B1244%      +0.0        0.04 =B1 79%  perf-profile.children.c=
ycles-pp.get_obj_cgroup_from_current
>       0.01 =B1244%      +0.0        0.03 =B1102%  perf-profile.children.c=
ycles-pp.d_alloc
>       0.11 =B1 46%      +0.0        0.13 =B1 41%  perf-profile.children.c=
ycles-pp.link_path_walk
>       0.40 =B1 26%      +0.0        0.43 =B1 19%  perf-profile.children.c=
ycles-pp.execve
>       0.07 =B1 50%      +0.0        0.10 =B1 40%  perf-profile.children.c=
ycles-pp.__update_load_avg_cfs_rq
>       0.00            +0.0        0.03 =B1100%  perf-profile.children.cyc=
les-pp.___perf_sw_event
>       0.01 =B1244%      +0.0        0.03 =B1104%  perf-profile.children.c=
ycles-pp.d_alloc_parallel
>       0.01 =B1158%      +0.0        0.04 =B1107%  perf-profile.children.c=
ycles-pp.lookup_fast
>       0.01 =B1244%      +0.0        0.04 =B1 88%  perf-profile.children.c=
ycles-pp.folio_memcg_lock
>       0.00            +0.0        0.03 =B1102%  perf-profile.children.cyc=
les-pp.__vm_munmap
>       2.04 =B1 13%      +0.0        2.07 =B1 24%  perf-profile.children.c=
ycles-pp.ktime_get_update_offsets_now
>       0.06 =B1 72%      +0.0        0.09 =B1 44%  perf-profile.children.c=
ycles-pp.unmap_page_range
>       0.02 =B1161%      +0.0        0.05 =B1 63%  perf-profile.children.c=
ycles-pp.td_io_prep
>       0.10 =B1 32%      +0.0        0.13 =B1 22%  perf-profile.children.c=
ycles-pp.rb_next
>       0.04 =B1125%      +0.0        0.07 =B1 53%  perf-profile.children.c=
ycles-pp.vfs_fstatat
>       0.25 =B1 21%      +0.0        0.28 =B1 25%  perf-profile.children.c=
ycles-pp.exec_binprm
>       0.03 =B1117%      +0.0        0.06 =B1 73%  perf-profile.children.c=
ycles-pp._find_next_bit
>       0.01 =B1158%      +0.0        0.04 =B1107%  perf-profile.children.c=
ycles-pp.tlb_batch_pages_flush
>       0.38 =B1 14%      +0.0        0.41 =B1 15%  perf-profile.children.c=
ycles-pp.hrtimer_next_event_without
>       0.40 =B1 21%      +0.0        0.43 =B1 11%  perf-profile.children.c=
ycles-pp.ct_kernel_exit_state
>       0.04 =B1125%      +0.0        0.07 =B1 54%  perf-profile.children.c=
ycles-pp.__do_sys_newstat
>       0.21 =B1 24%      +0.0        0.24 =B1 19%  perf-profile.children.c=
ycles-pp.irqentry_exit
>       1.21 =B1 12%      +0.0        1.24 =B1 14%  perf-profile.children.c=
ycles-pp.tick_nohz_get_sleep_length
>       0.05 =B1 42%      +0.0        0.08 =B1 37%  perf-profile.children.c=
ycles-pp.ct_nmi_exit
>       0.02 =B1118%      +0.0        0.06 =B1 64%  perf-profile.children.c=
ycles-pp.pipe_write
>       1.18 =B1  9%      +0.0        1.21 =B1 13%  perf-profile.children.c=
ycles-pp.perf_rotate_context
>       0.24 =B1 14%      +0.0        0.27 =B1 23%  perf-profile.children.c=
ycles-pp.hrtimer_update_next_event
>       1.82 =B1  6%      +0.0        1.85 =B1 12%  perf-profile.children.c=
ycles-pp.perf_mux_hrtimer_handler
>       0.07 =B1 77%      +0.0        0.10 =B1 44%  perf-profile.children.c=
ycles-pp.unmap_vmas
>       0.11 =B1 56%      +0.0        0.14 =B1 23%  perf-profile.children.c=
ycles-pp.charge_memcg
>       0.18 =B1 34%      +0.0        0.22 =B1 16%  perf-profile.children.c=
ycles-pp.__mem_cgroup_charge
>       0.24 =B1 22%      +0.0        0.28 =B1 25%  perf-profile.children.c=
ycles-pp.search_binary_handler
>       0.03 =B1 88%      +0.0        0.06 =B1 88%  perf-profile.children.c=
ycles-pp.tlb_finish_mmu
>       1.13 =B1 13%      +0.0        1.16 =B1 12%  perf-profile.children.c=
ycles-pp.note_gp_changes
>       0.06 =B1 42%      +0.0        0.09 =B1 52%  perf-profile.children.c=
ycles-pp.write
>       0.28 =B1 22%      +0.0        0.31 =B1 19%  perf-profile.children.c=
ycles-pp.bprm_execve
>       0.16 =B1 27%      +0.0        0.19 =B1 28%  perf-profile.children.c=
ycles-pp.error_entry
>       0.05 =B1 91%      +0.0        0.08 =B1 45%  perf-profile.children.c=
ycles-pp.zap_pte_range
>       0.18 =B1 28%      +0.0        0.21 =B1 36%  perf-profile.children.c=
ycles-pp.__mmput
>       0.18 =B1 30%      +0.0        0.21 =B1 36%  perf-profile.children.c=
ycles-pp.exit_mmap
>       0.08 =B1 49%      +0.0        0.11 =B1 22%  perf-profile.children.c=
ycles-pp.mpage_process_page_bufs
>       0.34 =B1 18%      +0.0        0.38 =B1 19%  perf-profile.children.c=
ycles-pp.__hrtimer_next_event_base
>       0.21 =B1 30%      +0.0        0.25 =B1 23%  perf-profile.children.c=
ycles-pp.irq_work_tick
>       0.24 =B1 23%      +0.0        0.27 =B1 25%  perf-profile.children.c=
ycles-pp.load_elf_binary
>       0.26 =B1 27%      +0.0        0.30 =B1 19%  perf-profile.children.c=
ycles-pp.tick_nohz_irq_exit
>       0.01 =B1244%      +0.0        0.05 =B1 83%  perf-profile.children.c=
ycles-pp.update_dl_rq_load_avg
>       0.21 =B1 26%      +0.0        0.25 =B1 19%  perf-profile.children.c=
ycles-pp.ct_nmi_enter
>       0.07 =B1 53%      +0.0        0.12 =B1 32%  perf-profile.children.c=
ycles-pp.sched_clock
>       0.01 =B1244%      +0.0        0.05 =B1 93%  perf-profile.children.c=
ycles-pp.strnlen_user
>       0.20 =B1 36%      +0.0        0.24 =B1 39%  perf-profile.children.c=
ycles-pp.tick_check_oneshot_broadcast_this_cpu
>       0.07 =B1 48%      +0.0        0.11 =B1 33%  perf-profile.children.c=
ycles-pp.tick_nohz_tick_stopped
>       0.03 =B1118%      +0.0        0.08 =B1 40%  perf-profile.children.c=
ycles-pp.__libc_read
>       0.07 =B1 68%      +0.0        0.12 =B1 51%  perf-profile.children.c=
ycles-pp.tsc_verify_tsc_adjust
>       0.03 =B1118%      +0.0        0.08 =B1 39%  perf-profile.children.c=
ycles-pp.readn
>       0.26 =B1 30%      +0.0        0.31 =B1 53%  perf-profile.children.c=
ycles-pp.calc_global_load_tick
>       0.02 =B1116%      +0.1        0.07 =B1 48%  perf-profile.children.c=
ycles-pp.pm_qos_read_value
>       0.08 =B1 41%      +0.1        0.13 =B1 29%  perf-profile.children.c=
ycles-pp.rb_insert_color
>       0.08 =B1 68%      +0.1        0.14 =B1 42%  perf-profile.children.c=
ycles-pp.arch_cpu_idle_enter
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.wb_workfn
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.wb_do_writeback
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.wb_writeback
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.__writeback_inodes_wb
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.writeback_sb_inodes
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.__writeback_single_inode
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.do_writepages
>       1.37 =B1 27%      +0.1        1.43 =B1 14%  perf-profile.children.c=
ycles-pp.mpage_map_and_submit_extent
>       1.05 =B1  9%      +0.1        1.10 =B1 20%  perf-profile.children.c=
ycles-pp.lapic_next_deadline
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.ext4_writepages
>       1.71 =B1 26%      +0.1        1.77 =B1  8%  perf-profile.children.c=
ycles-pp.ext4_do_writepages
>       1.37 =B1 27%      +0.1        1.43 =B1 14%  perf-profile.children.c=
ycles-pp.mpage_map_and_submit_buffers
>       0.28 =B1 18%      +0.1        0.34 =B1 17%  perf-profile.children.c=
ycles-pp.irqentry_enter
>       1.16 =B1 22%      +0.1        1.22 =B1 15%  perf-profile.children.c=
ycles-pp.mpage_submit_folio
>       0.15 =B1 33%      +0.1        0.23 =B1 73%  perf-profile.children.c=
ycles-pp.trigger_load_balance
>       0.28 =B1 18%      +0.1        0.36 =B1 14%  perf-profile.children.c=
ycles-pp.get_cpu_device
>       0.08 =B1 61%      +0.1        0.16 =B1137%  perf-profile.children.c=
ycles-pp.td_io_queue
>       0.33 =B1 30%      +0.1        0.41 =B1 22%  perf-profile.children.c=
ycles-pp.do_user_addr_fault
>       0.26 =B1 21%      +0.1        0.34 =B1 23%  perf-profile.children.c=
ycles-pp.folio_clear_dirty_for_io
>       0.39 =B1 27%      +0.1        0.47 =B1 21%  perf-profile.children.c=
ycles-pp.asm_exc_page_fault
>       0.33 =B1 30%      +0.1        0.42 =B1 20%  perf-profile.children.c=
ycles-pp.exc_page_fault
>       0.26 =B1130%      +0.1        0.35 =B1126%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_commit
>       0.26 =B1130%      +0.1        0.35 =B1125%  perf-profile.children.c=
ycles-pp.drm_atomic_commit
>       0.20 =B1168%      +0.1        0.29 =B1155%  perf-profile.children.c=
ycles-pp.commit_tail
>       0.20 =B1168%      +0.1        0.29 =B1155%  perf-profile.children.c=
ycles-pp.ast_mode_config_helper_atomic_commit_tail
>       0.26 =B1130%      +0.1        0.35 =B1124%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_dirtyfb
>       0.18 =B1174%      +0.1        0.28 =B1158%  perf-profile.children.c=
ycles-pp.drm_fb_memcpy
>       0.18 =B1174%      +0.1        0.28 =B1158%  perf-profile.children.c=
ycles-pp.memcpy_toio
>       0.18 =B1174%      +0.1        0.28 =B1158%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_commit_tail_rpm
>       0.18 =B1174%      +0.1        0.28 =B1158%  perf-profile.children.c=
ycles-pp.drm_atomic_helper_commit_planes
>       0.18 =B1174%      +0.1        0.28 =B1158%  perf-profile.children.c=
ycles-pp.ast_primary_plane_helper_atomic_update
>       1.41 =B1 12%      +0.1        1.52 =B1 12%  perf-profile.children.c=
ycles-pp.native_irq_return_iret
>       0.31 =B1 17%      +0.1        0.42 =B1 17%  perf-profile.children.c=
ycles-pp.enqueue_hrtimer
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.children.c=
ycles-pp.x86_64_start_kernel
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.children.c=
ycles-pp.x86_64_start_reservations
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.children.c=
ycles-pp.start_kernel
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.children.c=
ycles-pp.arch_call_rest_init
>       1.38 =B1 15%      +0.1        1.50 =B1 13%  perf-profile.children.c=
ycles-pp.rest_init
>       0.22 =B1 27%      +0.1        0.35 =B1 23%  perf-profile.children.c=
ycles-pp.timerqueue_add
>       0.41 =B1 18%      +0.2        0.56 =B1 15%  perf-profile.children.c=
ycles-pp.cpuidle_governor_latency_req
>       2.50 =B1  6%      +0.3        2.78 =B1  6%  perf-profile.children.c=
ycles-pp.menu_select
>       7.09 =B1  8%      +0.5        7.55 =B1 16%  perf-profile.children.c=
ycles-pp.__intel_pmu_enable_all
>      17.07 =B1  3%      +0.5       17.59 =B1  7%  perf-profile.children.c=
ycles-pp.tick_sched_timer
>      20.04 =B1  2%      +0.7       20.78 =B1  6%  perf-profile.children.c=
ycles-pp.__hrtimer_run_queues
>      24.95 =B1  2%      +0.8       25.71 =B1  5%  perf-profile.children.c=
ycles-pp.__sysvec_apic_timer_interrupt
>      24.17 =B1  2%      +0.8       24.94 =B1  5%  perf-profile.children.c=
ycles-pp.hrtimer_interrupt
>       9.83 =B1  6%      +0.8       10.62 =B1 12%  perf-profile.children.c=
ycles-pp.perf_event_task_tick
>       9.75 =B1  6%      +0.8       10.56 =B1 11%  perf-profile.children.c=
ycles-pp.perf_adjust_freq_unthr_context
>      15.37 =B1  5%      +0.9       16.24 =B1  7%  perf-profile.children.c=
ycles-pp.tick_sched_handle
>      15.23 =B1  5%      +0.9       16.10 =B1  7%  perf-profile.children.c=
ycles-pp.update_process_times
>      71.39 =B1  2%      +0.9       72.26        perf-profile.children.cyc=
les-pp.asm_sysvec_apic_timer_interrupt
>      12.98 =B1  5%      +0.9       13.86 =B1 10%  perf-profile.children.c=
ycles-pp.scheduler_tick
>      78.42 =B1  2%      +1.4       79.87        perf-profile.children.cyc=
les-pp.cpuidle_enter_state
>      78.74 =B1  2%      +1.5       80.20        perf-profile.children.cyc=
les-pp.cpuidle_enter
>      77.36 =B1  2%      +1.5       78.85        perf-profile.children.cyc=
les-pp.acpi_idle_enter
>      77.19 =B1  2%      +1.5       78.72        perf-profile.children.cyc=
les-pp.acpi_safe_halt
>      81.47 =B1  2%      +1.6       83.10        perf-profile.children.cyc=
les-pp.start_secondary
>      82.22            +1.7       83.92        perf-profile.children.cycle=
s-pp.cpuidle_idle_call
>      82.85            +1.7       84.59        perf-profile.children.cycle=
s-pp.secondary_startup_64_no_verify
>      82.85            +1.7       84.59        perf-profile.children.cycle=
s-pp.cpu_startup_entry
>      82.85            +1.7       84.59        perf-profile.children.cycle=
s-pp.do_idle
>       3.71 =B1 55%      -1.0        2.69 =B1 59%  perf-profile.self.cycle=
s-pp.ktime_get
>       1.78 =B1 12%      -0.3        1.44 =B1 14%  perf-profile.self.cycle=
s-pp.__block_commit_write
>       1.64 =B1 10%      -0.3        1.33 =B1 10%  perf-profile.self.cycle=
s-pp._raw_spin_lock_irqsave
>       0.91 =B1  9%      -0.1        0.80 =B1 15%  perf-profile.self.cycle=
s-pp.native_sched_clock
>       0.58 =B1 60%      -0.1        0.47 =B1 43%  perf-profile.self.cycle=
s-pp.tick_sched_do_timer
>       0.91 =B1 21%      -0.1        0.80 =B1 12%  perf-profile.self.cycle=
s-pp._raw_spin_trylock
>       0.48 =B1 17%      -0.1        0.39 =B1 22%  perf-profile.self.cycle=
s-pp.copyin
>       0.38 =B1 14%      -0.1        0.30 =B1 31%  perf-profile.self.cycle=
s-pp.ext4_da_write_end
>       0.63 =B1 19%      -0.1        0.54 =B1 32%  perf-profile.self.cycle=
s-pp.native_queued_spin_lock_slowpath
>       1.02 =B1 10%      -0.1        0.94 =B1 10%  perf-profile.self.cycle=
s-pp._raw_spin_lock
>       0.40 =B1 29%      -0.1        0.34 =B1 16%  perf-profile.self.cycle=
s-pp.fio_gettime
>       0.77 =B1  8%      -0.1        0.71 =B1 17%  perf-profile.self.cycle=
s-pp.rcu_pending
>       0.15 =B1 35%      -0.1        0.08 =B1 50%  perf-profile.self.cycle=
s-pp.thread_main
>       1.16 =B1 11%      -0.1        1.10 =B1 12%  perf-profile.self.cycle=
s-pp.read_tsc
>       0.30 =B1 14%      -0.1        0.25 =B1 22%  perf-profile.self.cycle=
s-pp.xas_descend
>       0.14 =B1 25%      -0.1        0.09 =B1 43%  perf-profile.self.cycle=
s-pp.irqtime_account_process_tick
>       0.24 =B1 26%      -0.0        0.19 =B1 29%  perf-profile.self.cycle=
s-pp.get_io_u
>       0.08 =B1 53%      -0.0        0.04 =B1100%  perf-profile.self.cycle=
s-pp.account_io_completion
>       0.06 =B1 45%      -0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.irq_work_run_list
>       0.13 =B1 37%      -0.0        0.08 =B1 47%  perf-profile.self.cycle=
s-pp.rcu_core
>       0.27 =B1160%      -0.0        0.22 =B1176%  perf-profile.self.cycle=
s-pp.io_serial_in
>       0.18 =B1 13%      -0.0        0.14 =B1 39%  perf-profile.self.cycle=
s-pp.xas_load
>       0.09 =B1 49%      -0.0        0.05 =B1 87%  perf-profile.self.cycle=
s-pp.__libc_write
>       0.07 =B1 50%      -0.0        0.03 =B1134%  perf-profile.self.cycle=
s-pp.node_dirty_ok
>       0.09 =B1 67%      -0.0        0.06 =B1120%  perf-profile.self.cycle=
s-pp.timekeeping_advance
>       0.14 =B1 34%      -0.0        0.10 =B1 26%  perf-profile.self.cycle=
s-pp.acpi_idle_enter
>       0.12 =B1 27%      -0.0        0.09 =B1 24%  perf-profile.self.cycle=
s-pp.rmqueue_bulk
>       0.08 =B1 48%      -0.0        0.04 =B1 78%  perf-profile.self.cycle=
s-pp.ext4_da_write_begin
>       0.11 =B1 40%      -0.0        0.07 =B1 51%  perf-profile.self.cycle=
s-pp.mark_buffer_dirty
>       0.09 =B1 71%      -0.0        0.06 =B1 84%  perf-profile.self.cycle=
s-pp.__cond_resched
>       0.03 =B1 91%      -0.0        0.00        perf-profile.self.cycles-=
pp.ksys_write
>       0.04 =B1 91%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.up_write
>       0.09 =B1 62%      -0.0        0.06 =B1 63%  perf-profile.self.cycle=
s-pp.kmem_cache_alloc
>       0.37 =B1 21%      -0.0        0.34 =B1 31%  perf-profile.self.cycle=
s-pp.block_write_end
>       0.10 =B1 39%      -0.0        0.07 =B1 42%  perf-profile.self.cycle=
s-pp.folio_unlock
>       0.13 =B1 36%      -0.0        0.10 =B1 45%  perf-profile.self.cycle=
s-pp.run_posix_cpu_timers
>       0.50 =B1 19%      -0.0        0.47 =B1 14%  perf-profile.self.cycle=
s-pp.update_sg_lb_stats
>       0.14 =B1 48%      -0.0        0.11 =B1 36%  perf-profile.self.cycle=
s-pp.vfs_write
>       0.07 =B1 64%      -0.0        0.04 =B1 93%  perf-profile.self.cycle=
s-pp.xas_start
>       0.09 =B1 44%      -0.0        0.06 =B1 71%  perf-profile.self.cycle=
s-pp.clockevents_program_event
>       0.10 =B1 51%      -0.0        0.07 =B1 47%  perf-profile.self.cycle=
s-pp.timerqueue_del
>       0.05 =B1 44%      -0.0        0.03 =B1144%  perf-profile.self.cycle=
s-pp.ct_kernel_exit
>       0.03 =B1 87%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.irqentry_exit
>       0.08 =B1 29%      -0.0        0.05 =B1 64%  perf-profile.self.cycle=
s-pp.cpuidle_reflect
>       0.10 =B1 39%      -0.0        0.08 =B1 66%  perf-profile.self.cycle=
s-pp.folio_end_writeback
>       0.05 =B1106%      -0.0        0.02 =B1129%  perf-profile.self.cycle=
s-pp.ct_idle_exit
>       0.39 =B1 17%      -0.0        0.36 =B1 18%  perf-profile.self.cycle=
s-pp.update_irq_load_avg
>       0.11 =B1 42%      -0.0        0.09 =B1 65%  perf-profile.self.cycle=
s-pp.tick_check_broadcast_expired
>       0.02 =B1116%      -0.0        0.00        perf-profile.self.cycles-=
pp.folio_memcg_unlock
>       0.03 =B1 87%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.ext4_file_write_iter
>       0.03 =B1116%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.run_rebalance_domains
>       0.18 =B1 26%      -0.0        0.16 =B1 29%  perf-profile.self.cycle=
s-pp.update_sd_lb_stats
>       0.08 =B1 50%      -0.0        0.06 =B1 46%  perf-profile.self.cycle=
s-pp.ext4_block_write_begin
>       0.04 =B1 94%      -0.0        0.02 =B1179%  perf-profile.self.cycle=
s-pp.ext4_da_map_blocks
>       0.05 =B1120%      -0.0        0.03 =B1100%  perf-profile.self.cycle=
s-pp.generic_write_end
>       0.09 =B1 44%      -0.0        0.06 =B1 42%  perf-profile.self.cycle=
s-pp.memcg_slab_post_alloc_hook
>       0.14 =B1 11%      -0.0        0.12 =B1 39%  perf-profile.self.cycle=
s-pp.__mod_memcg_lruvec_state
>       0.69 =B1 11%      -0.0        0.67 =B1 13%  perf-profile.self.cycle=
s-pp.native_apic_msr_eoi_write
>       0.04 =B1 96%      -0.0        0.02 =B1173%  perf-profile.self.cycle=
s-pp.vma_interval_tree_insert
>       0.05 =B1 91%      -0.0        0.03 =B1132%  perf-profile.self.cycle=
s-pp.down_write
>       0.07 =B1 67%      -0.0        0.05 =B1 78%  perf-profile.self.cycle=
s-pp.folio_add_lru
>       0.35 =B1 24%      -0.0        0.33 =B1 16%  perf-profile.self.cycle=
s-pp.percpu_counter_add_batch
>       0.07 =B1 18%      -0.0        0.05 =B1 84%  perf-profile.self.cycle=
s-pp.add_lat_sample
>       0.02 =B1163%      -0.0        0.00        perf-profile.self.cycles-=
pp.entry_SYSCALL_64_after_hwframe
>       0.03 =B1117%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.filemap_get_entry
>       0.04 =B1 89%      -0.0        0.02 =B1129%  perf-profile.self.cycle=
s-pp.acpi_os_read_port
>       0.06 =B1 49%      -0.0        0.04 =B1 84%  perf-profile.self.cycle=
s-pp.filemap_get_folios_tag
>       0.03 =B1120%      -0.0        0.01 =B1173%  perf-profile.self.cycle=
s-pp.hrtimer_run_queues
>       0.18 =B1 32%      -0.0        0.17 =B1 17%  perf-profile.self.cycle=
s-pp.ext4_da_get_block_prep
>       0.06 =B1 71%      -0.0        0.04 =B1 87%  perf-profile.self.cycle=
s-pp.__pthread_disable_asynccancel
>       0.06 =B1 74%      -0.0        0.04 =B1 88%  perf-profile.self.cycle=
s-pp.io_completed
>       0.13 =B1 33%      -0.0        0.11 =B1 32%  perf-profile.self.cycle=
s-pp.__filemap_add_folio
>       0.02 =B1159%      -0.0        0.00        perf-profile.self.cycles-=
pp.__memcpy
>       0.02 =B1159%      -0.0        0.00        perf-profile.self.cycles-=
pp.ramp_time_over
>       0.02 =B1159%      -0.0        0.00        perf-profile.self.cycles-=
pp.syscall_return_via_sysret
>       0.02 =B1159%      -0.0        0.00        perf-profile.self.cycles-=
pp.evlist__id2evsel
>       0.02 =B1159%      -0.0        0.00        perf-profile.self.cycles-=
pp.in_ramp_time
>       0.03 =B1122%      -0.0        0.02 =B1175%  perf-profile.self.cycle=
s-pp.__get_io_u
>       0.21 =B1 18%      -0.0        0.20 =B1 19%  perf-profile.self.cycle=
s-pp.scheduler_tick
>       0.01 =B1158%      -0.0        0.00        perf-profile.self.cycles-=
pp.pipe_read
>       0.04 =B1 91%      -0.0        0.03 =B1129%  perf-profile.self.cycle=
s-pp.xas_find_marked
>       0.06 =B1 49%      -0.0        0.05 =B1 87%  perf-profile.self.cycle=
s-pp.next_uptodate_page
>       0.04 =B1142%      -0.0        0.03 =B1104%  perf-profile.self.cycle=
s-pp.update_vsyscall
>       0.08 =B1 51%      -0.0        0.07 =B1 51%  perf-profile.self.cycle=
s-pp.perf_event_task_tick
>       0.04 =B1121%      -0.0        0.02 =B1133%  perf-profile.self.cycle=
s-pp.io_queue_event
>       0.09 =B1 60%      -0.0        0.08 =B1 52%  perf-profile.self.cycle=
s-pp.hrtimer_next_event_without
>       0.10 =B1 23%      -0.0        0.08 =B1 50%  perf-profile.self.cycle=
s-pp.mem_cgroup_css_rstat_flush
>       0.10 =B1 36%      -0.0        0.08 =B1 34%  perf-profile.self.cycle=
s-pp.hrtimer_forward
>       0.03 =B1115%      -0.0        0.02 =B1173%  perf-profile.self.cycle=
s-pp.tick_nohz_stop_idle
>       0.35 =B1 12%      -0.0        0.34 =B1 27%  perf-profile.self.cycle=
s-pp.cpuidle_enter_state
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.rcu_report_qs_rnp
>       0.08 =B1 65%      -0.0        0.07 =B1 45%  perf-profile.self.cycle=
s-pp.entry_SYSRETQ_unsafe_stack
>       0.04 =B1121%      -0.0        0.03 =B1102%  perf-profile.self.cycle=
s-pp.__mod_lruvec_state
>       0.02 =B1159%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.check_move_unevictable_folios
>       0.03 =B1119%      -0.0        0.02 =B1132%  perf-profile.self.cycle=
s-pp.can_stop_idle_tick
>       0.03 =B1 87%      -0.0        0.02 =B1132%  perf-profile.self.cycle=
s-pp.balance_dirty_pages_ratelimited_flags
>       0.08 =B1 55%      -0.0        0.07 =B1 78%  perf-profile.self.cycle=
s-pp.add_clat_sample
>       0.11 =B1 26%      -0.0        0.10 =B1 43%  perf-profile.self.cycle=
s-pp.fault_in_readable
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.read_counters
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.mas_wr_node_store
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp._copy_from_user
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.apparmor_file_permission
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.log_io_u
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.syscall_exit_to_user_mode
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.policy_node
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.refill_obj_stock
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.cpuidle_select
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.__folio_mark_dirty
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.__get_obj_cgroup_from_memcg
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.ntime_since
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp._IO_fwrite
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.current_time
>       0.01 =B1158%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp._raw_read_lock
>       0.03 =B1 87%      -0.0        0.03 =B1130%  perf-profile.self.cycle=
s-pp.filemap_map_pages
>       0.06 =B1 44%      -0.0        0.05 =B1 62%  perf-profile.self.cycle=
s-pp.folio_account_dirtied
>       0.41 =B1 22%      -0.0        0.40 =B1 14%  perf-profile.self.cycle=
s-pp.check_cpu_stall
>       0.08 =B1 68%      -0.0        0.07 =B1 22%  perf-profile.self.cycle=
s-pp.enqueue_hrtimer
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.filemap_add_folio
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.get_start_offset
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.io_bytes_exceeded
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.put_io_u
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.security_file_permission
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.workingset_update_node
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.do_syscall_64
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.get_cpu_sleep_time_us
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.tick_nohz_idle_got_tick
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.kmem_cache_free_bulk
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.__file_remove_privs
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp._find_first_bit
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.entry_SYSCALL_64_safe_stack
>       0.01 =B1244%      -0.0        0.00        perf-profile.self.cycles-=
pp.__update_load_avg_se
>       0.54 =B1 11%      -0.0        0.53 =B1 13%  perf-profile.self.cycle=
s-pp.cpuidle_idle_call
>       0.02 =B1159%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.update_sg_wakeup_stats
>       0.02 =B1167%      -0.0        0.02 =B1175%  perf-profile.self.cycle=
s-pp.xas_set_mark
>       0.02 =B1169%      -0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.irq_work_needs_cpu
>       0.02 =B1115%      -0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.sched_idle_set_state
>       0.09 =B1 57%      -0.0        0.08 =B1 23%  perf-profile.self.cycle=
s-pp.ct_kernel_enter
>       0.06 =B1 50%      -0.0        0.05 =B1 87%  perf-profile.self.cycle=
s-pp.copy_page_from_iter_atomic
>       0.07 =B1 39%      -0.0        0.07 =B1 65%  perf-profile.self.cycle=
s-pp.generic_perform_write
>       0.04 =B1144%      -0.0        0.04 =B1104%  perf-profile.self.cycle=
s-pp.mpage_prepare_extent_to_map
>       0.05 =B1 69%      -0.0        0.05 =B1 85%  perf-profile.self.cycle=
s-pp.ext4_update_bh_state
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.__slab_free
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.alloc_pages
>       0.07 =B1 68%      -0.0        0.07 =B1 45%  perf-profile.self.cycle=
s-pp.ext4_es_lookup_extent
>       0.07 =B1 50%      -0.0        0.07 =B1 52%  perf-profile.self.cycle=
s-pp.nr_iowait_cpu
>       0.08 =B1 24%      -0.0        0.08 =B1 52%  perf-profile.self.cycle=
s-pp.folio_create_empty_buffers
>       0.09 =B1 23%      -0.0        0.09 =B1 28%  perf-profile.self.cycle=
s-pp.lru_add_fn
>       0.03 =B1115%      -0.0        0.03 =B1130%  perf-profile.self.cycle=
s-pp.account_process_tick
>       0.06 =B1 67%      -0.0        0.06 =B1 69%  perf-profile.self.cycle=
s-pp.__update_blocked_fair
>       0.02 =B1163%      -0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.folio_alloc_buffers
>       0.15 =B1 28%      -0.0        0.14 =B1 21%  perf-profile.self.cycle=
s-pp._raw_spin_unlock_irqrestore
>       0.04 =B1117%      -0.0        0.04 =B1 82%  perf-profile.self.cycle=
s-pp.xas_clear_mark
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.acpi_idle_do_entry
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.generic_write_checks
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.update_group_capacity
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.__bitmap_and
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.xas_create
>       0.02 =B1161%      -0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.node_page_state
>       0.07 =B1 74%      -0.0        0.07 =B1 60%  perf-profile.self.cycle=
s-pp.get_page_from_freelist
>       0.23 =B1 12%      -0.0        0.23 =B1 17%  perf-profile.self.cycle=
s-pp.irqtime_account_irq
>       0.04 =B1 97%      -0.0        0.04 =B1 81%  perf-profile.self.cycle=
s-pp.update_blocked_averages
>       0.16 =B1 42%      -0.0        0.16 =B1 24%  perf-profile.self.cycle=
s-pp.hrtimer_interrupt
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.__switch_to
>       0.07 =B1 67%      -0.0        0.07 =B1 65%  perf-profile.self.cycle=
s-pp.rmqueue
>       0.01 =B1244%      -0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.mpage_map_and_submit_buffers
>       0.02 =B1159%      -0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.get_next_seq_offset
>       0.17 =B1 14%      -0.0        0.17 =B1 28%  perf-profile.self.cycle=
s-pp.call_cpuidle
>       0.30 =B1 19%      -0.0        0.30 =B1 21%  perf-profile.self.cycle=
s-pp.do_idle
>       0.04 =B1144%      -0.0        0.04 =B1 81%  perf-profile.self.cycle=
s-pp.__alloc_pages
>       0.05 =B1 64%      -0.0        0.05 =B1 85%  perf-profile.self.cycle=
s-pp.intel_pmu_disable_all
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.fold_vm_numa_events
>       0.02 =B1159%      +0.0        0.02 =B1173%  perf-profile.self.cycle=
s-pp.io_u_sync_complete
>       0.01 =B1244%      +0.0        0.01 =B1174%  perf-profile.self.cycle=
s-pp.utime_since_now
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.self.cycle=
s-pp.hrtimer_get_next_event
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.self.cycle=
s-pp.poll_idle
>       0.06 =B1 45%      +0.0        0.06 =B1 69%  perf-profile.self.cycle=
s-pp.__mark_inode_dirty
>       0.05 =B1 96%      +0.0        0.05 =B1 63%  perf-profile.self.cycle=
s-pp.local_clock
>       0.04 =B1 94%      +0.0        0.04 =B1 79%  perf-profile.self.cycle=
s-pp.__fget_light
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.kmem_cache_free
>       0.02 =B1163%      +0.0        0.02 =B1129%  perf-profile.self.cycle=
s-pp.__list_del_entry_valid
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.arch_cpu_idle_exit
>       0.12 =B1 31%      +0.0        0.12 =B1 29%  perf-profile.self.cycle=
s-pp.ext4_finish_bio
>       0.01 =B1244%      +0.0        0.01 =B1264%  perf-profile.self.cycle=
s-pp.task_tick_mm_cid
>       0.01 =B1158%      +0.0        0.02 =B1179%  perf-profile.self.cycle=
s-pp.sync_regs
>       0.26 =B1 27%      +0.0        0.26 =B1 19%  perf-profile.self.cycle=
s-pp.tick_nohz_next_event
>       0.05 =B1 71%      +0.0        0.05 =B1 86%  perf-profile.self.cycle=
s-pp.get_mem_cgroup_from_mm
>       0.22 =B1 24%      +0.0        0.22 =B1 14%  perf-profile.self.cycle=
s-pp.perf_pmu_nop_void
>       0.03 =B1178%      +0.0        0.03 =B1104%  perf-profile.self.cycle=
s-pp.filemap_get_folios
>       0.02 =B1116%      +0.0        0.03 =B1130%  perf-profile.self.cycle=
s-pp.ext4_buffered_write_iter
>       0.03 =B1 88%      +0.0        0.04 =B1 81%  perf-profile.self.cycle=
s-pp.memset_orig
>       0.18 =B1 35%      +0.0        0.18 =B1 17%  perf-profile.self.cycle=
s-pp.ext4_bio_write_folio
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.self.cycle=
s-pp.inode_to_bdi
>       0.01 =B1244%      +0.0        0.01 =B1173%  perf-profile.self.cycle=
s-pp.__mod_zone_page_state
>       0.04 =B1117%      +0.0        0.04 =B1 79%  perf-profile.self.cycle=
s-pp.cgroup_rstat_updated
>       1.88 =B1 13%      +0.0        1.88 =B1 27%  perf-profile.self.cycle=
s-pp.ktime_get_update_offsets_now
>       0.12 =B1 45%      +0.0        0.13 =B1 26%  perf-profile.self.cycle=
s-pp.tick_program_event
>       0.01 =B1158%      +0.0        0.02 =B1173%  perf-profile.self.cycle=
s-pp.rcu_all_qs
>       0.04 =B1 88%      +0.0        0.04 =B1 81%  perf-profile.self.cycle=
s-pp.rcu_report_qs_rdp
>       0.01 =B1244%      +0.0        0.01 =B1174%  perf-profile.self.cycle=
s-pp.profile_tick
>       0.01 =B1244%      +0.0        0.01 =B1174%  perf-profile.self.cycle=
s-pp.ext4_nonda_switch
>       0.10 =B1 48%      +0.0        0.10 =B1 36%  perf-profile.self.cycle=
s-pp.__note_gp_changes
>       0.14 =B1 39%      +0.0        0.15 =B1 33%  perf-profile.self.cycle=
s-pp.sched_clock_cpu
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__handle_mm_fault
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.link_path_walk
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.try_to_wake_up
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__xa_set_mark
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__get_task_ioprio
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__count_memcg_events
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__kmem_cache_alloc_bulk
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__tlb_remove_page_size
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.copy_page
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.timer_clear_idle
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.tick_sched_handle
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.evsel__read_counter
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.vma_interval_tree_remove
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.fio_syncio_queue
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.native_flush_tlb_one_user
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.perf_event_mmap_output
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.vsnprintf
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.tick_nohz_get_next_hrtimer
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.bio_add_folio
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__fprop_add_percpu
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.clear_page_erms
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.mutex_lock
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.ttwu_queue_wakelist
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp._IO_file_xsputn
>       0.17 =B1 19%      +0.0        0.17 =B1 26%  perf-profile.self.cycle=
s-pp.__folio_start_writeback
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__kmem_cache_alloc_node
>       0.12 =B1 49%      +0.0        0.13 =B1 22%  perf-profile.self.cycle=
s-pp.__mod_lruvec_page_state
>       0.06 =B1 49%      +0.0        0.06 =B1 59%  perf-profile.self.cycle=
s-pp.raise_softirq
>       0.01 =B1244%      +0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.rcu_nocb_flush_deferred_wakeup
>       0.01 =B1244%      +0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.restore_regs_and_return_to_kernel
>       0.01 =B1244%      +0.0        0.02 =B1176%  perf-profile.self.cycle=
s-pp.tick_nohz_idle_retain_tick
>       0.13 =B1 29%      +0.0        0.14 =B1 31%  perf-profile.self.cycle=
s-pp.release_pages
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.io_u_mark_submit
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.timekeeping_max_deferment
>       0.01 =B1244%      +0.0        0.02 =B1175%  perf-profile.self.cycle=
s-pp.__filemap_get_folio
>       0.08 =B1 47%      +0.0        0.09 =B1 45%  perf-profile.self.cycle=
s-pp.update_rt_rq_load_avg
>       0.04 =B1 96%      +0.0        0.05 =B1 63%  perf-profile.self.cycle=
s-pp.mpage_process_folio
>       0.03 =B1 88%      +0.0        0.04 =B1 59%  perf-profile.self.cycle=
s-pp.menu_reflect
>       0.01 =B1244%      +0.0        0.02 =B1188%  perf-profile.self.cycle=
s-pp.cpuidle_not_available
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.tick_nohz_irq_exit
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.__d_lookup_rcu
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.mutex_unlock
>       0.01 =B1244%      +0.0        0.02 =B1175%  perf-profile.self.cycle=
s-pp.__schedule
>       0.13 =B1 35%      +0.0        0.14 =B1 43%  perf-profile.self.cycle=
s-pp.folio_clear_dirty_for_io
>       0.10 =B1 49%      +0.0        0.11 =B1 36%  perf-profile.self.cycle=
s-pp.__sysvec_apic_timer_interrupt
>       0.02 =B1159%      +0.0        0.03 =B1130%  perf-profile.self.cycle=
s-pp.__radix_tree_lookup
>       1.71 =B1 10%      +0.0        1.72 =B1 11%  perf-profile.self.cycle=
s-pp.arch_scale_freq_tick
>       0.02 =B1158%      +0.0        0.03 =B1101%  perf-profile.self.cycle=
s-pp.try_charge_memcg
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.fio_io_end
>       0.00            +0.0        0.01 =B1264%  perf-profile.self.cycles-=
pp.rcu_preempt_deferred_qs
>       0.02 =B1158%      +0.0        0.03 =B1108%  perf-profile.self.cycle=
s-pp.xas_find_conflict
>       0.01 =B1244%      +0.0        0.02 =B1173%  perf-profile.self.cycle=
s-pp.__switch_to_asm
>       0.19 =B1 23%      +0.0        0.20 =B1 21%  perf-profile.self.cycle=
s-pp.idle_cpu
>       0.31 =B1 20%      +0.0        0.32 =B1 20%  perf-profile.self.cycle=
s-pp.cpuidle_enter
>       0.04 =B1 93%      +0.0        0.05 =B1 88%  perf-profile.self.cycle=
s-pp.memcg_alloc_slab_cgroups
>       0.00            +0.0        0.01 =B1173%  perf-profile.self.cycles-=
pp.get_obj_cgroup_from_current
>       0.11 =B1 21%      +0.0        0.13 =B1 16%  perf-profile.self.cycle=
s-pp.update_rq_clock
>       0.00            +0.0        0.01 =B1174%  perf-profile.self.cycles-=
pp.xas_find
>       0.11 =B1 34%      +0.0        0.12 =B1 27%  perf-profile.self.cycle=
s-pp.rcu_sched_clock_irq
>       0.14 =B1 46%      +0.0        0.16 =B1 20%  perf-profile.self.cycle=
s-pp._find_next_and_bit
>       0.00            +0.0        0.02 =B1176%  perf-profile.self.cycles-=
pp.__bio_try_merge_page
>       0.00            +0.0        0.02 =B1176%  perf-profile.self.cycles-=
pp.folio_mkclean
>       0.01 =B1244%      +0.0        0.02 =B1130%  perf-profile.self.cycle=
s-pp.file_modified_flags
>       0.01 =B1244%      +0.0        0.02 =B1134%  perf-profile.self.cycle=
s-pp.folio_mapping
>       0.00            +0.0        0.02 =B1179%  perf-profile.self.cycles-=
pp.shmem_get_folio_gfp
>       0.01 =B1244%      +0.0        0.02 =B1132%  perf-profile.self.cycle=
s-pp.invoke_rcu_core
>       0.06 =B1 44%      +0.0        0.07 =B1 54%  perf-profile.self.cycle=
s-pp._dl_addr
>       0.01 =B1158%      +0.0        0.03 =B1106%  perf-profile.self.cycle=
s-pp.mtree_range_walk
>       0.03 =B1 87%      +0.0        0.05 =B1 80%  perf-profile.self.cycle=
s-pp.mod_objcg_state
>       0.00            +0.0        0.02 =B1175%  perf-profile.self.cycles-=
pp.error_return
>       0.00            +0.0        0.02 =B1175%  perf-profile.self.cycles-=
pp.nohz_balancer_kick
>       0.04 =B1189%      +0.0        0.06 =B1192%  perf-profile.self.cycle=
s-pp.delay_tsc
>       0.21 =B1 45%      +0.0        0.23 =B1 26%  perf-profile.self.cycle=
s-pp.update_process_times
>       0.05 =B1 43%      +0.0        0.07 =B1 54%  perf-profile.self.cycle=
s-pp.ct_nmi_exit
>       0.00            +0.0        0.02 =B1173%  perf-profile.self.cycles-=
pp.__pthread_enable_asynccancel
>       0.09 =B1 32%      +0.0        0.10 =B1 29%  perf-profile.self.cycle=
s-pp.rb_erase
>       0.05 =B1 71%      +0.0        0.07 =B1 33%  perf-profile.self.cycle=
s-pp.td_io_queue
>       0.15 =B1 21%      +0.0        0.17 =B1 14%  perf-profile.self.cycle=
s-pp.load_balance
>       0.00            +0.0        0.02 =B1173%  perf-profile.self.cycles-=
pp.enqueue_entity
>       0.01 =B1244%      +0.0        0.03 =B1102%  perf-profile.self.cycle=
s-pp.folio_memcg_lock
>       0.23 =B1 35%      +0.0        0.25 =B1 47%  perf-profile.self.cycle=
s-pp.__folio_end_writeback
>       0.30 =B1 15%      +0.0        0.32 =B1 20%  perf-profile.self.cycle=
s-pp.x86_pmu_disable
>       0.12 =B1 26%      +0.0        0.15 =B1 18%  perf-profile.self.cycle=
s-pp.update_rq_clock_task
>       0.02 =B1161%      +0.0        0.05 =B1 62%  perf-profile.self.cycle=
s-pp.td_io_prep
>       0.28 =B1 19%      +0.0        0.31 =B1 16%  perf-profile.self.cycle=
s-pp.__hrtimer_next_event_base
>       0.32 =B1 19%      +0.0        0.35 =B1 18%  perf-profile.self.cycle=
s-pp._raw_spin_lock_irq
>       0.00            +0.0        0.02 =B1181%  perf-profile.self.cycles-=
pp.obj_cgroup_charge
>       0.08 =B1 44%      +0.0        0.10 =B1 38%  perf-profile.self.cycle=
s-pp.tick_nohz_get_sleep_length
>       0.02 =B1159%      +0.0        0.04 =B1 59%  perf-profile.self.cycle=
s-pp.charge_memcg
>       0.02 =B1167%      +0.0        0.05 =B1 60%  perf-profile.self.cycle=
s-pp.mod_zone_page_state
>       0.05 =B1 44%      +0.0        0.08 =B1 49%  perf-profile.self.cycle=
s-pp.irqentry_enter
>       0.37 =B1 19%      +0.0        0.40 =B1 10%  perf-profile.self.cycle=
s-pp.ct_kernel_exit_state
>       0.00            +0.0        0.02 =B1132%  perf-profile.self.cycles-=
pp.find_busiest_group
>       0.00            +0.0        0.02 =B1100%  perf-profile.self.cycles-=
pp.___perf_sw_event
>       0.03 =B1119%      +0.0        0.05 =B1 64%  perf-profile.self.cycle=
s-pp.folio_batch_move_lru
>       0.10 =B1158%      +0.0        0.13 =B1145%  perf-profile.self.cycle=
s-pp.memcpy_toio
>       0.07 =B1 50%      +0.0        0.10 =B1 40%  perf-profile.self.cycle=
s-pp.__update_load_avg_cfs_rq
>       0.06 =B1 67%      +0.0        0.08 =B1 44%  perf-profile.self.cycle=
s-pp.tick_sched_timer
>       0.15 =B1 33%      +0.0        0.18 =B1 54%  perf-profile.self.cycle=
s-pp.__mod_node_page_state
>       0.15 =B1 33%      +0.0        0.18 =B1 35%  perf-profile.self.cycle=
s-pp.__irq_exit_rcu
>       0.21 =B1 30%      +0.0        0.24 =B1 27%  perf-profile.self.cycle=
s-pp.irq_work_tick
>       0.01 =B1244%      +0.0        0.04 =B1106%  perf-profile.self.cycle=
s-pp.xas_store
>       0.05 =B1100%      +0.0        0.08 =B1 44%  perf-profile.self.cycle=
s-pp.perf_mux_hrtimer_handler
>       0.08 =B1 25%      +0.0        0.11 =B1 24%  perf-profile.self.cycle=
s-pp.rb_next
>       0.08 =B1 44%      +0.0        0.12 =B1 36%  perf-profile.self.cycle=
s-pp.get_next_timer_interrupt
>       0.05 =B1 69%      +0.0        0.08 =B1 54%  perf-profile.self.cycle=
s-pp.tick_irq_enter
>       0.16 =B1 27%      +0.0        0.19 =B1 29%  perf-profile.self.cycle=
s-pp.error_entry
>       0.03 =B1 90%      +0.0        0.07 =B1 46%  perf-profile.self.cycle=
s-pp.cgroup_rstat_flush_locked
>       0.15 =B1 18%      +0.0        0.18 =B1 35%  perf-profile.self.cycle=
s-pp.__do_softirq
>       0.50 =B1 12%      +0.0        0.53 =B1 17%  perf-profile.self.cycle=
s-pp.sysvec_apic_timer_interrupt
>       0.00            +0.0        0.04 =B1134%  perf-profile.self.cycles-=
pp.zap_pte_range
>       0.08 =B1 49%      +0.0        0.11 =B1 22%  perf-profile.self.cycle=
s-pp.mpage_process_page_bufs
>       0.01 =B1244%      +0.0        0.05 =B1112%  perf-profile.self.cycle=
s-pp.strnlen_user
>       0.03 =B1158%      +0.0        0.07 =B1 65%  perf-profile.self.cycle=
s-pp.__entry_text_start
>       0.11 =B1 22%      +0.0        0.15 =B1 42%  perf-profile.self.cycle=
s-pp.ct_nmi_enter
>       0.19 =B1 35%      +0.0        0.23 =B1 36%  perf-profile.self.cycle=
s-pp.tick_check_oneshot_broadcast_this_cpu
>       0.00            +0.0        0.04 =B1111%  perf-profile.self.cycles-=
pp._find_next_bit
>       0.03 =B1127%      +0.0        0.07 =B1 32%  perf-profile.self.cycle=
s-pp.sched_clock
>       0.30 =B1 17%      +0.0        0.34 =B1 12%  perf-profile.self.cycle=
s-pp.__hrtimer_run_queues
>       0.01 =B1244%      +0.0        0.05 =B1 83%  perf-profile.self.cycle=
s-pp.update_dl_rq_load_avg
>       0.06 =B1 67%      +0.0        0.10 =B1 62%  perf-profile.self.cycle=
s-pp.tsc_verify_tsc_adjust
>       0.13 =B1 48%      +0.0        0.17 =B1 29%  perf-profile.self.cycle=
s-pp.perf_rotate_context
>       0.08 =B1 51%      +0.0        0.12 =B1 29%  perf-profile.self.cycle=
s-pp.cpuidle_governor_latency_req
>       0.07 =B1 56%      +0.0        0.11 =B1 38%  perf-profile.self.cycle=
s-pp.rb_insert_color
>       0.25 =B1 16%      +0.0        0.30 =B1 17%  perf-profile.self.cycle=
s-pp.irq_enter_rcu
>       0.77 =B1 14%      +0.0        0.82 =B1 13%  perf-profile.self.cycle=
s-pp.note_gp_changes
>       0.51 =B1 20%      +0.0        0.56 =B1 12%  perf-profile.self.cycle=
s-pp.asm_sysvec_apic_timer_interrupt
>       0.05 =B1 69%      +0.0        0.10 =B1 26%  perf-profile.self.cycle=
s-pp.tick_nohz_tick_stopped
>       0.04 =B1 93%      +0.1        0.09 =B1 35%  perf-profile.self.cycle=
s-pp.hrtimer_update_next_event
>       1.05 =B1  9%      +0.1        1.10 =B1 20%  perf-profile.self.cycle=
s-pp.lapic_next_deadline
>       0.02 =B1159%      +0.1        0.07 =B1 51%  perf-profile.self.cycle=
s-pp.pm_qos_read_value
>       0.25 =B1 34%      +0.1        0.30 =B1 55%  perf-profile.self.cycle=
s-pp.calc_global_load_tick
>       0.09 =B1 60%      +0.1        0.14 =B1 35%  perf-profile.self.cycle=
s-pp.rebalance_domains
>       0.13 =B1 37%      +0.1        0.19 =B1 78%  perf-profile.self.cycle=
s-pp.trigger_load_balance
>       0.80 =B1  9%      +0.1        0.87 =B1  8%  perf-profile.self.cycle=
s-pp.menu_select
>       0.27 =B1 19%      +0.1        0.35 =B1 16%  perf-profile.self.cycle=
s-pp.get_cpu_device
>       0.14 =B1 36%      +0.1        0.22 =B1 23%  perf-profile.self.cycle=
s-pp.timerqueue_add
>       1.41 =B1 12%      +0.1        1.52 =B1 12%  perf-profile.self.cycle=
s-pp.native_irq_return_iret
>       2.89 =B1  5%      +0.3        3.17 =B1  6%  perf-profile.self.cycle=
s-pp.perf_adjust_freq_unthr_context
>       7.09 =B1  8%      +0.5        7.55 =B1 16%  perf-profile.self.cycle=
s-pp.__intel_pmu_enable_all
>      39.34 =B1  2%      +1.4       40.77 =B1  6%  perf-profile.self.cycle=
s-pp.acpi_safe_halt
>=20
>=20
>=20
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>=20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20
>=20

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 6.4.0-rc5 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"gcc-12 (Debian 12.2.0-14) 12.2.0"
> CONFIG_CC_IS_GCC=3Dy
> CONFIG_GCC_VERSION=3D120200
> CONFIG_CLANG_VERSION=3D0
> CONFIG_AS_IS_GNU=3Dy
> CONFIG_AS_VERSION=3D24000
> CONFIG_LD_IS_BFD=3Dy
> CONFIG_LD_VERSION=3D24000
> CONFIG_LLD_VERSION=3D0
> CONFIG_CC_CAN_LINK=3Dy
> CONFIG_CC_CAN_LINK_STATIC=3Dy
> CONFIG_CC_HAS_ASM_GOTO_OUTPUT=3Dy
> CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=3Dy
> CONFIG_TOOLS_SUPPORT_RELR=3Dy
> CONFIG_CC_HAS_ASM_INLINE=3Dy
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
> CONFIG_PAHOLE_VERSION=3D125
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_TABLE_SORT=3Dy
> CONFIG_THREAD_INFO_IN_TASK=3Dy
>=20
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_BUILD_SALT=3D""
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_HAVE_KERNEL_LZ4=3Dy
> CONFIG_HAVE_KERNEL_ZSTD=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=3D""
> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=3Dy
> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> CONFIG_AUDITSYSCALL=3Dy
>=20
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> CONFIG_GENERIC_IRQ_INJECTION=3Dy
> CONFIG_HARDIRQS_SW_RESEND=3Dy
> CONFIG_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> CONFIG_GENERIC_MSI_IRQ=3Dy
> CONFIG_IRQ_MSI_IOMMU=3Dy
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> CONFIG_IRQ_FORCED_THREADING=3Dy
> CONFIG_SPARSE_IRQ=3Dy
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
>=20
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_CONTEXT_TRACKING=3Dy
> CONFIG_CONTEXT_TRACKING_IDLE=3Dy
>=20
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ_COMMON=3Dy
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=3Dy
> CONFIG_CONTEXT_TRACKING_USER=3Dy
> # CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=3D125
> # end of Timers subsystem
>=20
> CONFIG_BPF=3Dy
> CONFIG_HAVE_EBPF_JIT=3Dy
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
>=20
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=3Dy
> CONFIG_BPF_JIT=3Dy
> CONFIG_BPF_JIT_ALWAYS_ON=3Dy
> CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=3Dy
> # CONFIG_BPF_PRELOAD is not set
> # CONFIG_BPF_LSM is not set
> # end of BPF subsystem
>=20
> CONFIG_PREEMPT_VOLUNTARY_BUILD=3Dy
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=3Dy
> # CONFIG_PREEMPT is not set
> # CONFIG_PREEMPT_DYNAMIC is not set
> # CONFIG_SCHED_CORE is not set
>=20
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=3Dy
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_SCHED_AVG_IRQ=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
>=20
> CONFIG_CPU_ISOLATION=3Dy
>=20
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_TASKS_RUDE_RCU=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> CONFIG_RCU_NOCB_CPU=3Dy
> # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
> # CONFIG_RCU_LAZY is not set
> # end of RCU Subsystem
>=20
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=3D20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
>=20
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
>=20
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> CONFIG_CC_HAS_INT128=3Dy
> CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
> CONFIG_GCC11_NO_ARRAY_BOUNDS=3Dy
> CONFIG_CC_NO_ARRAY_BOUNDS=3Dy
> CONFIG_ARCH_SUPPORTS_INT128=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> CONFIG_CGROUPS=3Dy
> CONFIG_PAGE_COUNTER=3Dy
> # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> CONFIG_MEMCG=3Dy
> CONFIG_MEMCG_KMEM=3Dy
> CONFIG_BLK_CGROUP=3Dy
> CONFIG_CGROUP_WRITEBACK=3Dy
> CONFIG_CGROUP_SCHED=3Dy
> CONFIG_FAIR_GROUP_SCHED=3Dy
> CONFIG_CFS_BANDWIDTH=3Dy
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_SCHED_MM_CID=3Dy
> CONFIG_CGROUP_PIDS=3Dy
> CONFIG_CGROUP_RDMA=3Dy
> CONFIG_CGROUP_FREEZER=3Dy
> CONFIG_CGROUP_HUGETLB=3Dy
> CONFIG_CPUSETS=3Dy
> CONFIG_PROC_PID_CPUSET=3Dy
> CONFIG_CGROUP_DEVICE=3Dy
> CONFIG_CGROUP_CPUACCT=3Dy
> CONFIG_CGROUP_PERF=3Dy
> CONFIG_CGROUP_BPF=3Dy
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_TIME_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> # CONFIG_CHECKPOINT_RESTORE is not set
> CONFIG_SCHED_AUTOGROUP=3Dy
> CONFIG_RELAY=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_RD_LZ4=3Dy
> CONFIG_RD_ZSTD=3Dy
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_INITRAMFS_PRESERVE_MTIME=3Dy
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=3Dy
> CONFIG_LD_ORPHAN_WARN_LEVEL=3D"warn"
> CONFIG_SYSCTL=3Dy
> CONFIG_HAVE_UID16=3Dy
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> CONFIG_EXPERT=3Dy
> CONFIG_UID16=3Dy
> CONFIG_MULTIUSER=3Dy
> CONFIG_SGETMASK_SYSCALL=3Dy
> CONFIG_SYSFS_SYSCALL=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_FUTEX_PI=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_IO_URING=3Dy
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_MEMBARRIER=3Dy
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_SELFTEST is not set
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
> CONFIG_KCMP=3Dy
> CONFIG_RSEQ=3Dy
> # CONFIG_DEBUG_RSEQ is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=3Dy
> CONFIG_GUEST_PERF_EVENTS=3Dy
> # CONFIG_PC104 is not set
>=20
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=3Dy
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
>=20
> CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> CONFIG_PROFILING=3Dy
> CONFIG_TRACEPOINTS=3Dy
> # end of General setup
>=20
> CONFIG_64BIT=3Dy
> CONFIG_X86_64=3Dy
> CONFIG_X86=3Dy
> CONFIG_INSTRUCTION_DECODER=3Dy
> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> CONFIG_HAVE_INTEL_TXT=3Dy
> CONFIG_X86_64_SMP=3Dy
> CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_PGTABLE_LEVELS=3D5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy
>=20
> #
> # Processor type and features
> #
> CONFIG_SMP=3Dy
> CONFIG_X86_FEATURE_NAMES=3Dy
> CONFIG_X86_X2APIC=3Dy
> CONFIG_X86_MPPARSE=3Dy
> # CONFIG_GOLDFISH is not set
> # CONFIG_X86_CPU_RESCTRL is not set
> CONFIG_X86_EXTENDED_PLATFORM=3Dy
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=3Dy
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=3Dy
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=3Dy
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=3Dy
> CONFIG_PARAVIRT=3Dy
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=3Dy
> CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=3Dy
> CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
> # CONFIG_PVH is not set
> CONFIG_PARAVIRT_TIME_ACCOUNTING=3Dy
> CONFIG_PARAVIRT_CLOCK=3Dy
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_INTEL_TDX_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=3Dy
> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_CMPXCHG64=3Dy
> CONFIG_X86_CMOV=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_IA32_FEAT_CTL=3Dy
> CONFIG_X86_VMX_FEATURE_NAMES=3Dy
> CONFIG_PROCESSOR_SELECT=3Dy
> CONFIG_CPU_SUP_INTEL=3Dy
> # CONFIG_CPU_SUP_AMD is not set
> # CONFIG_CPU_SUP_HYGON is not set
> # CONFIG_CPU_SUP_CENTAUR is not set
> # CONFIG_CPU_SUP_ZHAOXIN is not set
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> CONFIG_BOOT_VESA_SUPPORT=3Dy
> CONFIG_MAXSMP=3Dy
> CONFIG_NR_CPUS_RANGE_BEGIN=3D8192
> CONFIG_NR_CPUS_RANGE_END=3D8192
> CONFIG_NR_CPUS_DEFAULT=3D8192
> CONFIG_NR_CPUS=3D8192
> CONFIG_SCHED_CLUSTER=3Dy
> CONFIG_SCHED_SMT=3Dy
> CONFIG_SCHED_MC=3Dy
> CONFIG_SCHED_MC_PRIO=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCELOG_LEGACY=3Dy
> CONFIG_X86_MCE_INTEL=3Dy
> CONFIG_X86_MCE_THRESHOLD=3Dy
> CONFIG_X86_MCE_INJECT=3Dm
>=20
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dm
> CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
> CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
> # end of Performance monitoring
>=20
> CONFIG_X86_16BIT=3Dy
> CONFIG_X86_ESPFIX64=3Dy
> CONFIG_X86_VSYSCALL_EMULATION=3Dy
> CONFIG_X86_IOPL_IOPERM=3Dy
> CONFIG_MICROCODE=3Dy
> CONFIG_MICROCODE_INTEL=3Dy
> CONFIG_MICROCODE_LATE_LOADING=3Dy
> CONFIG_X86_MSR=3Dy
> CONFIG_X86_CPUID=3Dy
> CONFIG_X86_5LEVEL=3Dy
> CONFIG_X86_DIRECT_GBPAGES=3Dy
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_NUMA=3Dy
> # CONFIG_AMD_NUMA is not set
> CONFIG_X86_64_ACPI_NUMA=3Dy
> CONFIG_NUMA_EMU=3Dy
> CONFIG_NODES_SHIFT=3D10
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
> CONFIG_X86_PMEM_LEGACY=3Dm
> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=3Dy
> CONFIG_MTRR_SANITIZER=3Dy
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> CONFIG_X86_PAT=3Dy
> CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> CONFIG_X86_UMIP=3Dy
> CONFIG_CC_HAS_IBT=3Dy
> CONFIG_X86_KERNEL_IBT=3Dy
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> CONFIG_X86_INTEL_TSX_MODE_OFF=3Dy
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_X86_SGX is not set
> CONFIG_EFI=3Dy
> CONFIG_EFI_STUB=3Dy
> CONFIG_EFI_HANDOVER_PROTOCOL=3Dy
> CONFIG_EFI_MIXED=3Dy
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_MAP=3Dy
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=3Dy
> CONFIG_HZ=3D1000
> CONFIG_SCHED_HRTICK=3Dy
> CONFIG_KEXEC=3Dy
> CONFIG_KEXEC_FILE=3Dy
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=3Dy
> # CONFIG_KEXEC_SIG is not set
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_KEXEC_JUMP=3Dy
> CONFIG_PHYSICAL_START=3D0x1000000
> CONFIG_RELOCATABLE=3Dy
> CONFIG_RANDOMIZE_BASE=3Dy
> CONFIG_X86_NEED_RELOCS=3Dy
> CONFIG_PHYSICAL_ALIGN=3D0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
> CONFIG_RANDOMIZE_MEMORY=3Dy
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa
> # CONFIG_ADDRESS_MASKING is not set
> CONFIG_HOTPLUG_CPU=3Dy
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> CONFIG_LEGACY_VSYSCALL_XONLY=3Dy
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=3Dy
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=3Dy
> CONFIG_LIVEPATCH=3Dy
> # end of Processor type and features
>=20
> CONFIG_CC_HAS_SLS=3Dy
> CONFIG_CC_HAS_RETURN_THUNK=3Dy
> CONFIG_CC_HAS_ENTRY_PADDING=3Dy
> CONFIG_FUNCTION_PADDING_CFI=3D11
> CONFIG_FUNCTION_PADDING_BYTES=3D16
> CONFIG_CALL_PADDING=3Dy
> CONFIG_HAVE_CALL_THUNKS=3Dy
> CONFIG_CALL_THUNKS=3Dy
> CONFIG_PREFIX_SYMBOLS=3Dy
> CONFIG_SPECULATION_MITIGATIONS=3Dy
> CONFIG_PAGE_TABLE_ISOLATION=3Dy
> CONFIG_RETPOLINE=3Dy
> CONFIG_RETHUNK=3Dy
> CONFIG_CALL_DEPTH_TRACKING=3Dy
> # CONFIG_CALL_THUNKS_DEBUG is not set
> CONFIG_CPU_IBRS_ENTRY=3Dy
> # CONFIG_SLS is not set
> CONFIG_ARCH_HAS_ADD_PAGES=3Dy
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy
>=20
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> CONFIG_SUSPEND=3Dy
> CONFIG_SUSPEND_FREEZER=3Dy
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> CONFIG_HIBERNATE_CALLBACKS=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy
> CONFIG_PM_STD_PARTITION=3D""
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM_SLEEP_SMP=3Dy
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_USERSPACE_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=3Dy
> # CONFIG_PM_DEBUG is not set
> CONFIG_PM_CLK=3Dy
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=3Dy
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
> CONFIG_ACPI_EC_DEBUGFS=3Dm
> CONFIG_ACPI_AC=3Dy
> CONFIG_ACPI_BATTERY=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_VIDEO=3Dm
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_TAD=3Dm
> CONFIG_ACPI_DOCK=3Dy
> CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> CONFIG_ACPI_CPPC_LIB=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_IPMI=3Dm
> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_ACPI_PLATFORM_PROFILE=3Dm
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> CONFIG_ACPI_TABLE_UPGRADE=3Dy
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=3Dy
> CONFIG_ACPI_CONTAINER=3Dy
> CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> CONFIG_ACPI_SBS=3Dm
> CONFIG_ACPI_HED=3Dy
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> CONFIG_ACPI_BGRT=3Dy
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_ACPI_NFIT=3Dm
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=3Dy
> CONFIG_ACPI_HMAT=3Dy
> CONFIG_HAVE_ACPI_APEI=3Dy
> CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> CONFIG_ACPI_APEI=3Dy
> CONFIG_ACPI_APEI_GHES=3Dy
> CONFIG_ACPI_APEI_PCIEAER=3Dy
> CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
> CONFIG_ACPI_APEI_EINJ=3Dm
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> # CONFIG_ACPI_DPTF is not set
> CONFIG_ACPI_WATCHDOG=3Dy
> CONFIG_ACPI_EXTLOG=3Dm
> CONFIG_ACPI_ADXL=3Dy
> # CONFIG_ACPI_CONFIGFS is not set
> # CONFIG_ACPI_PFRUT is not set
> CONFIG_ACPI_PCC=3Dy
> # CONFIG_ACPI_FFH is not set
> # CONFIG_PMIC_OPREGION is not set
> CONFIG_ACPI_PRMT=3Dy
> CONFIG_X86_PM_TIMER=3Dy
>=20
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> CONFIG_CPU_FREQ_STAT=3Dy
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>=20
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=3Dy
> # CONFIG_X86_PCC_CPUFREQ is not set
> # CONFIG_X86_AMD_PSTATE is not set
> # CONFIG_X86_AMD_PSTATE_UT is not set
> CONFIG_X86_ACPI_CPUFREQ=3Dm
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_P4_CLOCKMOD=3Dm
>=20
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=3Dm
> # end of CPU Frequency scaling
>=20
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=3Dy
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> CONFIG_CPU_IDLE_GOV_HALTPOLL=3Dy
> CONFIG_HALTPOLL_CPUIDLE=3Dy
> # end of CPU Idle
>=20
> CONFIG_INTEL_IDLE=3Dy
> # end of Power management and ACPI options
>=20
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_MMCONF_FAM10H=3Dy
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=3Dy
> # end of Bus options (PCI etc.)
>=20
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=3Dy
> # CONFIG_X86_X32_ABI is not set
> CONFIG_COMPAT_32=3Dy
> CONFIG_COMPAT=3Dy
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> # end of Binary Emulations
>=20
> CONFIG_HAVE_KVM=3Dy
> CONFIG_HAVE_KVM_PFNCACHE=3Dy
> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> CONFIG_HAVE_KVM_IRQFD=3Dy
> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING_TSO=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=3Dy
> CONFIG_HAVE_KVM_EVENTFD=3Dy
> CONFIG_KVM_MMIO=3Dy
> CONFIG_KVM_ASYNC_PF=3Dy
> CONFIG_HAVE_KVM_MSI=3Dy
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> CONFIG_KVM_VFIO=3Dy
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> CONFIG_KVM_COMPAT=3Dy
> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> CONFIG_HAVE_KVM_NO_POLL=3Dy
> CONFIG_KVM_XFER_TO_GUEST_WORK=3Dy
> CONFIG_HAVE_KVM_PM_NOTIFIER=3Dy
> CONFIG_KVM_GENERIC_HARDWARE_ENABLING=3Dy
> CONFIG_VIRTUALIZATION=3Dy
> CONFIG_KVM=3Dm
> # CONFIG_KVM_WERROR is not set
> CONFIG_KVM_INTEL=3Dm
> # CONFIG_KVM_AMD is not set
> CONFIG_KVM_SMM=3Dy
> # CONFIG_KVM_XEN is not set
> CONFIG_AS_AVX512=3Dy
> CONFIG_AS_SHA1_NI=3Dy
> CONFIG_AS_SHA256_NI=3Dy
> CONFIG_AS_TPAUSE=3Dy
> CONFIG_AS_GFNI=3Dy
>=20
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_HOTPLUG_SMT=3Dy
> CONFIG_GENERIC_ENTRY=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_JUMP_LABEL=3Dy
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=3Dy
> CONFIG_KPROBES_ON_FTRACE=3Dy
> CONFIG_UPROBES=3Dy
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> CONFIG_KRETPROBES=3Dy
> CONFIG_KRETPROBE_ON_RETHOOK=3Dy
> CONFIG_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_OPTPROBES=3Dy
> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
> CONFIG_HAVE_NMI=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> CONFIG_ARCH_WANTS_NO_INSTR=3Dy
> CONFIG_HAVE_ASM_MODVERSIONS=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_RSEQ=3Dy
> CONFIG_HAVE_RUST=3Dy
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_HAVE_PERF_REGS=3Dy
> CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> CONFIG_MMU_GATHER_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_MERGE_VMAS=3Dy
> CONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=3Dy
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> CONFIG_HAVE_ARCH_SECCOMP=3Dy
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> CONFIG_SECCOMP=3Dy
> CONFIG_SECCOMP_FILTER=3Dy
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=3Dy
> CONFIG_HAVE_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR_STRONG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
> CONFIG_LTO_NONE=3Dy
> CONFIG_ARCH_SUPPORTS_CFI_CLANG=3Dy
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_USER=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=3Dy
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_MOVE_PUD=3Dy
> CONFIG_HAVE_MOVE_PMD=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> CONFIG_HAVE_EXIT_THREAD=3Dy
> CONFIG_ARCH_MMAP_RND_BITS=3D28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
> CONFIG_HAVE_OBJTOOL=3Dy
> CONFIG_HAVE_JUMP_LABEL_HACK=3Dy
> CONFIG_HAVE_NOINSTR_HACK=3Dy
> CONFIG_HAVE_NOINSTR_VALIDATION=3Dy
> CONFIG_HAVE_UACCESS_VALIDATION=3Dy
> CONFIG_HAVE_STACK_VALIDATION=3Dy
> CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> CONFIG_OLD_SIGSUSPEND3=3Dy
> CONFIG_COMPAT_OLD_SIGACTION=3Dy
> CONFIG_COMPAT_32BIT_TIME=3Dy
> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> CONFIG_VMAP_STACK=3Dy
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
> CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> CONFIG_STRICT_KERNEL_RWX=3Dy
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> CONFIG_STRICT_MODULE_RWX=3Dy
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
> CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> CONFIG_HAVE_STATIC_CALL=3Dy
> CONFIG_HAVE_STATIC_CALL_INLINE=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=3Dy
> CONFIG_DYNAMIC_SIGFRAME=3Dy
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=3Dy
>=20
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> # end of GCOV-based kernel profiling
>=20
> CONFIG_HAVE_GCC_PLUGINS=3Dy
> CONFIG_GCC_PLUGINS=3Dy
> # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> CONFIG_FUNCTION_ALIGNMENT_4B=3Dy
> CONFIG_FUNCTION_ALIGNMENT_16B=3Dy
> CONFIG_FUNCTION_ALIGNMENT=3D16
> # end of General architecture-dependent options
>=20
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULE_SIG_FORMAT=3Dy
> CONFIG_MODULES=3Dy
> # CONFIG_MODULE_DEBUG is not set
> CONFIG_MODULE_FORCE_LOAD=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_MODULE_SIG=3Dy
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=3Dy
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> CONFIG_MODULE_SIG_SHA256=3Dy
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH=3D"sha256"
> CONFIG_MODULE_COMPRESS_NONE=3Dy
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy
> CONFIG_BLK_CGROUP_RWSTAT=3Dy
> CONFIG_BLK_CGROUP_PUNT_BIO=3Dy
> CONFIG_BLK_DEV_BSG_COMMON=3Dy
> CONFIG_BLK_ICQ=3Dy
> CONFIG_BLK_DEV_BSGLIB=3Dy
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> CONFIG_BLK_DEV_INTEGRITY_T10=3Dm
> # CONFIG_BLK_DEV_ZONED is not set
> CONFIG_BLK_DEV_THROTTLING=3Dy
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> CONFIG_BLK_WBT=3Dy
> CONFIG_BLK_WBT_MQ=3Dy
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> # CONFIG_BLK_CGROUP_IOCOST is not set
> # CONFIG_BLK_CGROUP_IOPRIO is not set
> CONFIG_BLK_DEBUG_FS=3Dy
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
>=20
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> # end of Partition Types
>=20
> CONFIG_BLK_MQ_PCI=3Dy
> CONFIG_BLK_MQ_VIRTIO=3Dy
> CONFIG_BLK_PM=3Dy
> CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy
> CONFIG_BLK_MQ_STACKING=3Dy
>=20
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dy
> CONFIG_IOSCHED_BFQ=3Dy
> CONFIG_BFQ_GROUP_IOSCHED=3Dy
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
>=20
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> CONFIG_PADATA=3Dy
> CONFIG_ASN1=3Dy
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_READ_UNLOCK=3Dy
> CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_WRITE_UNLOCK=3Dy
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> CONFIG_QUEUED_SPINLOCKS=3Dy
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> CONFIG_QUEUED_RWLOCKS=3Dy
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
> CONFIG_FREEZER=3Dy
>=20
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_COMPAT_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> CONFIG_BINFMT_MISC=3Dm
> CONFIG_COREDUMP=3Dy
> # end of Executable file formats
>=20
> #
> # Memory Management options
> #
> CONFIG_ZPOOL=3Dy
> CONFIG_SWAP=3Dy
> CONFIG_ZSWAP=3Dy
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=3Dy
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"
> CONFIG_ZBUD=3Dy
> # CONFIG_Z3FOLD is not set
> CONFIG_ZSMALLOC=3Dy
> CONFIG_ZSMALLOC_STAT=3Dy
> CONFIG_ZSMALLOC_CHAIN_SIZE=3D8
>=20
> #
> # SLAB allocator options
> #
> # CONFIG_SLAB is not set
> CONFIG_SLUB=3Dy
> # CONFIG_SLUB_TINY is not set
> CONFIG_SLAB_MERGE_DEFAULT=3Dy
> CONFIG_SLAB_FREELIST_RANDOM=3Dy
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_SLUB_CPU_PARTIAL=3Dy
> # end of SLAB allocator options
>=20
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SPARSEMEM=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=3Dy
> CONFIG_HAVE_FAST_GUP=3Dy
> CONFIG_NUMA_KEEP_MEMINFO=3Dy
> CONFIG_MEMORY_ISOLATION=3Dy
> CONFIG_EXCLUSIVE_SYSTEM_RAM=3Dy
> CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> CONFIG_MEMORY_HOTPLUG=3Dy
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_MEMORY_HOTREMOVE=3Dy
> CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> CONFIG_MEMORY_BALLOON=3Dy
> CONFIG_BALLOON_COMPACTION=3Dy
> CONFIG_COMPACTION=3Dy
> CONFIG_COMPACT_UNEVICTABLE_DEFAULT=3D1
> CONFIG_PAGE_REPORTING=3Dy
> CONFIG_MIGRATION=3Dy
> CONFIG_DEVICE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
> CONFIG_CONTIG_ALLOC=3Dy
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_MMU_NOTIFIER=3Dy
> CONFIG_KSM=3Dy
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_MEMORY_FAILURE=3Dy
> CONFIG_HWPOISON_INJECT=3Dm
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_THP_SWAP=3Dy
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_FRONTSWAP=3Dy
> # CONFIG_CMA is not set
> CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
> CONFIG_PAGE_IDLE_FLAG=3Dy
> CONFIG_IDLE_PAGE_TRACKING=3Dy
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy
> CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
> CONFIG_ARCH_HAS_ZONE_DMA_SET=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_ZONE_DMA32=3Dy
> CONFIG_ZONE_DEVICE=3Dy
> CONFIG_GET_FREE_REGION=3Dy
> CONFIG_DEVICE_PRIVATE=3Dy
> CONFIG_VMAP_PFN=3Dy
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> CONFIG_ARCH_HAS_PKEYS=3Dy
> CONFIG_VM_EVENT_COUNTERS=3Dy
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_DMAPOOL_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> CONFIG_SECRETMEM=3Dy
> # CONFIG_ANON_VMA_NAME is not set
> CONFIG_USERFAULTFD=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy
> CONFIG_PTE_MARKER_UFFD_WP=3Dy
> # CONFIG_LRU_GEN is not set
> CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=3Dy
> CONFIG_PER_VMA_LOCK=3Dy
>=20
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
>=20
> CONFIG_NET=3Dy
> CONFIG_NET_INGRESS=3Dy
> CONFIG_NET_EGRESS=3Dy
> CONFIG_SKB_EXTENSIONS=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dm
> CONFIG_UNIX=3Dy
> CONFIG_UNIX_SCM=3Dy
> CONFIG_AF_UNIX_OOB=3Dy
> CONFIG_UNIX_DIAG=3Dm
> CONFIG_TLS=3Dm
> CONFIG_TLS_DEVICE=3Dy
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_OFFLOAD=3Dy
> CONFIG_XFRM_ALGO=3Dy
> CONFIG_XFRM_USER=3Dy
> # CONFIG_XFRM_USER_COMPAT is not set
> # CONFIG_XFRM_INTERFACE is not set
> CONFIG_XFRM_SUB_POLICY=3Dy
> CONFIG_XFRM_MIGRATE=3Dy
> CONFIG_XFRM_STATISTICS=3Dy
> CONFIG_XFRM_AH=3Dm
> CONFIG_XFRM_ESP=3Dm
> CONFIG_XFRM_IPCOMP=3Dm
> # CONFIG_NET_KEY is not set
> CONFIG_XDP_SOCKETS=3Dy
> # CONFIG_XDP_SOCKETS_DIAG is not set
> CONFIG_NET_HANDSHAKE=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_FIB_TRIE_STATS=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_ROUTE_CLASSID=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE_DEMUX=3Dm
> CONFIG_NET_IP_TUNNEL=3Dm
> CONFIG_NET_IPGRE=3Dm
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_IP_MROUTE_COMMON=3Dy
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_NET_IPVTI=3Dm
> CONFIG_NET_UDP_TUNNEL=3Dm
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=3Dm
> CONFIG_INET_ESP=3Dm
> CONFIG_INET_ESP_OFFLOAD=3Dm
> # CONFIG_INET_ESPINTCP is not set
> CONFIG_INET_IPCOMP=3Dm
> CONFIG_INET_TABLE_PERTURB_ORDER=3D16
> CONFIG_INET_XFRM_TUNNEL=3Dm
> CONFIG_INET_TUNNEL=3Dm
> CONFIG_INET_DIAG=3Dm
> CONFIG_INET_TCP_DIAG=3Dm
> CONFIG_INET_UDP_DIAG=3Dm
> CONFIG_INET_RAW_DIAG=3Dm
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dm
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dm
> CONFIG_TCP_CONG_HTCP=3Dm
> CONFIG_TCP_CONG_HSTCP=3Dm
> CONFIG_TCP_CONG_HYBLA=3Dm
> CONFIG_TCP_CONG_VEGAS=3Dm
> CONFIG_TCP_CONG_NV=3Dm
> CONFIG_TCP_CONG_SCALABLE=3Dm
> CONFIG_TCP_CONG_LP=3Dm
> CONFIG_TCP_CONG_VENO=3Dm
> CONFIG_TCP_CONG_YEAH=3Dm
> CONFIG_TCP_CONG_ILLINOIS=3Dm
> CONFIG_TCP_CONG_DCTCP=3Dm
> # CONFIG_TCP_CONG_CDG is not set
> CONFIG_TCP_CONG_BBR=3Dm
> CONFIG_DEFAULT_CUBIC=3Dy
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> CONFIG_TCP_MD5SIG=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_IPV6_ROUTER_PREF=3Dy
> CONFIG_IPV6_ROUTE_INFO=3Dy
> CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> CONFIG_INET6_AH=3Dm
> CONFIG_INET6_ESP=3Dm
> CONFIG_INET6_ESP_OFFLOAD=3Dm
> # CONFIG_INET6_ESPINTCP is not set
> CONFIG_INET6_IPCOMP=3Dm
> CONFIG_IPV6_MIP6=3Dm
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=3Dm
> CONFIG_INET6_TUNNEL=3Dm
> CONFIG_IPV6_VTI=3Dm
> CONFIG_IPV6_SIT=3Dm
> CONFIG_IPV6_SIT_6RD=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_IPV6_TUNNEL=3Dm
> CONFIG_IPV6_GRE=3Dm
> CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> # CONFIG_IPV6_SUBTREES is not set
> CONFIG_IPV6_MROUTE=3Dy
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_PIMSM_V2=3Dy
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=3Dy
> # CONFIG_MPTCP is not set
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NET_PTP_CLASSIFY=3Dy
> CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
> CONFIG_NETFILTER=3Dy
> CONFIG_NETFILTER_ADVANCED=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dm
>=20
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=3Dy
> CONFIG_NETFILTER_EGRESS=3Dy
> CONFIG_NETFILTER_SKIP_EGRESS=3Dy
> CONFIG_NETFILTER_NETLINK=3Dm
> CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
> CONFIG_NETFILTER_FAMILY_ARP=3Dy
> CONFIG_NETFILTER_BPF_LINK=3Dy
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
> CONFIG_NETFILTER_NETLINK_LOG=3Dm
> CONFIG_NETFILTER_NETLINK_OSF=3Dm
> CONFIG_NF_CONNTRACK=3Dm
> CONFIG_NF_LOG_SYSLOG=3Dm
> CONFIG_NETFILTER_CONNCOUNT=3Dm
> CONFIG_NF_CONNTRACK_MARK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_ZONES=3Dy
> CONFIG_NF_CONNTRACK_PROCFS=3Dy
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
> CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> CONFIG_NF_CONNTRACK_LABELS=3Dy
> CONFIG_NF_CONNTRACK_OVS=3Dy
> CONFIG_NF_CT_PROTO_DCCP=3Dy
> CONFIG_NF_CT_PROTO_GRE=3Dy
> CONFIG_NF_CT_PROTO_SCTP=3Dy
> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> CONFIG_NF_CONNTRACK_AMANDA=3Dm
> CONFIG_NF_CONNTRACK_FTP=3Dm
> CONFIG_NF_CONNTRACK_H323=3Dm
> CONFIG_NF_CONNTRACK_IRC=3Dm
> CONFIG_NF_CONNTRACK_BROADCAST=3Dm
> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
> CONFIG_NF_CONNTRACK_SNMP=3Dm
> CONFIG_NF_CONNTRACK_PPTP=3Dm
> CONFIG_NF_CONNTRACK_SANE=3Dm
> CONFIG_NF_CONNTRACK_SIP=3Dm
> CONFIG_NF_CONNTRACK_TFTP=3Dm
> CONFIG_NF_CT_NETLINK=3Dm
> CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
> CONFIG_NF_CT_NETLINK_HELPER=3Dm
> CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
> CONFIG_NF_NAT=3Dm
> CONFIG_NF_NAT_AMANDA=3Dm
> CONFIG_NF_NAT_FTP=3Dm
> CONFIG_NF_NAT_IRC=3Dm
> CONFIG_NF_NAT_SIP=3Dm
> CONFIG_NF_NAT_TFTP=3Dm
> CONFIG_NF_NAT_REDIRECT=3Dy
> CONFIG_NF_NAT_MASQUERADE=3Dy
> CONFIG_NF_NAT_OVS=3Dy
> CONFIG_NETFILTER_SYNPROXY=3Dm
> CONFIG_NF_TABLES=3Dm
> CONFIG_NF_TABLES_INET=3Dy
> CONFIG_NF_TABLES_NETDEV=3Dy
> CONFIG_NFT_NUMGEN=3Dm
> CONFIG_NFT_CT=3Dm
> CONFIG_NFT_CONNLIMIT=3Dm
> CONFIG_NFT_LOG=3Dm
> CONFIG_NFT_LIMIT=3Dm
> CONFIG_NFT_MASQ=3Dm
> CONFIG_NFT_REDIR=3Dm
> CONFIG_NFT_NAT=3Dm
> # CONFIG_NFT_TUNNEL is not set
> CONFIG_NFT_QUEUE=3Dm
> CONFIG_NFT_QUOTA=3Dm
> CONFIG_NFT_REJECT=3Dm
> CONFIG_NFT_REJECT_INET=3Dm
> CONFIG_NFT_COMPAT=3Dm
> CONFIG_NFT_HASH=3Dm
> CONFIG_NFT_FIB=3Dm
> CONFIG_NFT_FIB_INET=3Dm
> # CONFIG_NFT_XFRM is not set
> CONFIG_NFT_SOCKET=3Dm
> # CONFIG_NFT_OSF is not set
> # CONFIG_NFT_TPROXY is not set
> # CONFIG_NFT_SYNPROXY is not set
> CONFIG_NF_DUP_NETDEV=3Dm
> CONFIG_NFT_DUP_NETDEV=3Dm
> CONFIG_NFT_FWD_NETDEV=3Dm
> CONFIG_NFT_FIB_NETDEV=3Dm
> # CONFIG_NFT_REJECT_NETDEV is not set
> # CONFIG_NF_FLOW_TABLE is not set
> CONFIG_NETFILTER_XTABLES=3Dy
> # CONFIG_NETFILTER_XTABLES_COMPAT is not set
>=20
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=3Dm
> CONFIG_NETFILTER_XT_CONNMARK=3Dm
>=20
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CT=3Dm
> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
> CONFIG_NETFILTER_XT_TARGET_HL=3Dm
> CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
> CONFIG_NETFILTER_XT_NAT=3Dm
> CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
>=20
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
> CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
> CONFIG_NETFILTER_XT_MATCH_HL=3Dm
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
> CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
> CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
>=20
> # CONFIG_IP_SET is not set
> CONFIG_IP_VS=3Dm
> CONFIG_IP_VS_IPV6=3Dy
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=3D12
>=20
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=3Dy
> CONFIG_IP_VS_PROTO_UDP=3Dy
> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> CONFIG_IP_VS_PROTO_ESP=3Dy
> CONFIG_IP_VS_PROTO_AH=3Dy
> CONFIG_IP_VS_PROTO_SCTP=3Dy
>=20
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dm
> CONFIG_IP_VS_WRR=3Dm
> CONFIG_IP_VS_LC=3Dm
> CONFIG_IP_VS_WLC=3Dm
> CONFIG_IP_VS_FO=3Dm
> CONFIG_IP_VS_OVF=3Dm
> CONFIG_IP_VS_LBLC=3Dm
> CONFIG_IP_VS_LBLCR=3Dm
> CONFIG_IP_VS_DH=3Dm
> CONFIG_IP_VS_SH=3Dm
> # CONFIG_IP_VS_MH is not set
> CONFIG_IP_VS_SED=3Dm
> CONFIG_IP_VS_NQ=3Dm
> # CONFIG_IP_VS_TWOS is not set
>=20
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=3D8
>=20
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=3D12
>=20
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dm
> CONFIG_IP_VS_NFCT=3Dy
> CONFIG_IP_VS_PE_SIP=3Dm
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=3Dm
> CONFIG_NF_SOCKET_IPV4=3Dm
> CONFIG_NF_TPROXY_IPV4=3Dm
> CONFIG_NF_TABLES_IPV4=3Dy
> CONFIG_NFT_REJECT_IPV4=3Dm
> CONFIG_NFT_DUP_IPV4=3Dm
> CONFIG_NFT_FIB_IPV4=3Dm
> CONFIG_NF_TABLES_ARP=3Dy
> CONFIG_NF_DUP_IPV4=3Dm
> CONFIG_NF_LOG_ARP=3Dm
> CONFIG_NF_LOG_IPV4=3Dm
> CONFIG_NF_REJECT_IPV4=3Dm
> CONFIG_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_NF_NAT_PPTP=3Dm
> CONFIG_NF_NAT_H323=3Dm
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_AH=3Dm
> CONFIG_IP_NF_MATCH_ECN=3Dm
> CONFIG_IP_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_ECN=3Dm
> CONFIG_IP_NF_TARGET_TTL=3Dm
> CONFIG_IP_NF_RAW=3Dm
> CONFIG_IP_NF_SECURITY=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> CONFIG_IP_NF_ARP_MANGLE=3Dm
> # end of IP: Netfilter Configuration
>=20
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_SOCKET_IPV6=3Dm
> CONFIG_NF_TPROXY_IPV6=3Dm
> CONFIG_NF_TABLES_IPV6=3Dy
> CONFIG_NFT_REJECT_IPV6=3Dm
> CONFIG_NFT_DUP_IPV6=3Dm
> CONFIG_NFT_FIB_IPV6=3Dm
> CONFIG_NF_DUP_IPV6=3Dm
> CONFIG_NF_REJECT_IPV6=3Dm
> CONFIG_NF_LOG_IPV6=3Dm
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_AH=3Dm
> CONFIG_IP6_NF_MATCH_EUI64=3Dm
> CONFIG_IP6_NF_MATCH_FRAG=3Dm
> CONFIG_IP6_NF_MATCH_OPTS=3Dm
> CONFIG_IP6_NF_MATCH_HL=3Dm
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
> CONFIG_IP6_NF_MATCH_MH=3Dm
> CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP6_NF_MATCH_RT=3Dm
> # CONFIG_IP6_NF_MATCH_SRH is not set
> # CONFIG_IP6_NF_TARGET_HL is not set
> CONFIG_IP6_NF_FILTER=3Dm
> CONFIG_IP6_NF_TARGET_REJECT=3Dm
> CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_RAW=3Dm
> CONFIG_IP6_NF_SECURITY=3Dm
> CONFIG_IP6_NF_NAT=3Dm
> CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP6_NF_TARGET_NPT=3Dm
> # end of IPv6: Netfilter Configuration
>=20
> CONFIG_NF_DEFRAG_IPV6=3Dm
> CONFIG_NF_TABLES_BRIDGE=3Dm
> # CONFIG_NFT_BRIDGE_META is not set
> CONFIG_NFT_BRIDGE_REJECT=3Dm
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> CONFIG_BRIDGE_NF_EBTABLES=3Dm
> CONFIG_BRIDGE_EBT_BROUTE=3Dm
> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
> CONFIG_BRIDGE_EBT_T_NAT=3Dm
> CONFIG_BRIDGE_EBT_802_3=3Dm
> CONFIG_BRIDGE_EBT_AMONG=3Dm
> CONFIG_BRIDGE_EBT_ARP=3Dm
> CONFIG_BRIDGE_EBT_IP=3Dm
> CONFIG_BRIDGE_EBT_IP6=3Dm
> CONFIG_BRIDGE_EBT_LIMIT=3Dm
> CONFIG_BRIDGE_EBT_MARK=3Dm
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
> CONFIG_BRIDGE_EBT_STP=3Dm
> CONFIG_BRIDGE_EBT_VLAN=3Dm
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
> CONFIG_BRIDGE_EBT_DNAT=3Dm
> CONFIG_BRIDGE_EBT_MARK_T=3Dm
> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
> CONFIG_BRIDGE_EBT_SNAT=3Dm
> CONFIG_BRIDGE_EBT_LOG=3Dm
> CONFIG_BRIDGE_EBT_NFLOG=3Dm
> # CONFIG_BPFILTER is not set
> CONFIG_IP_DCCP=3Dy
> CONFIG_INET_DCCP_DIAG=3Dm
>=20
> #
> # DCCP CCIDs Configuration
> #
> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> CONFIG_IP_DCCP_CCID3=3Dy
> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
> CONFIG_IP_DCCP_TFRC_LIB=3Dy
> # end of DCCP CCIDs Configuration
>=20
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> # end of DCCP Kernel Hacking
>=20
> CONFIG_IP_SCTP=3Dm
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
> CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
> CONFIG_INET_SCTP_DIAG=3Dm
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> CONFIG_STP=3Dm
> CONFIG_GARP=3Dm
> CONFIG_MRP=3Dm
> CONFIG_BRIDGE=3Dm
> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> # CONFIG_BRIDGE_MRP is not set
> # CONFIG_BRIDGE_CFM is not set
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=3Dm
> CONFIG_VLAN_8021Q_GVRP=3Dy
> CONFIG_VLAN_8021Q_MVRP=3Dy
> CONFIG_LLC=3Dm
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> CONFIG_NET_SCHED=3Dy
>=20
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_HFSC=3Dm
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_MULTIQ=3Dm
> CONFIG_NET_SCH_RED=3Dm
> CONFIG_NET_SCH_SFB=3Dm
> CONFIG_NET_SCH_SFQ=3Dm
> CONFIG_NET_SCH_TEQL=3Dm
> CONFIG_NET_SCH_TBF=3Dm
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> CONFIG_NET_SCH_MQPRIO_LIB=3Dm
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_NETEM=3Dm
> CONFIG_NET_SCH_DRR=3Dm
> CONFIG_NET_SCH_MQPRIO=3Dm
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=3Dm
> CONFIG_NET_SCH_QFQ=3Dm
> CONFIG_NET_SCH_CODEL=3Dm
> CONFIG_NET_SCH_FQ_CODEL=3Dy
> # CONFIG_NET_SCH_CAKE is not set
> CONFIG_NET_SCH_FQ=3Dm
> CONFIG_NET_SCH_HHF=3Dm
> CONFIG_NET_SCH_PIE=3Dm
> # CONFIG_NET_SCH_FQ_PIE is not set
> CONFIG_NET_SCH_INGRESS=3Dm
> CONFIG_NET_SCH_PLUG=3Dm
> # CONFIG_NET_SCH_ETS is not set
> CONFIG_NET_SCH_DEFAULT=3Dy
> # CONFIG_DEFAULT_FQ is not set
> # CONFIG_DEFAULT_CODEL is not set
> CONFIG_DEFAULT_FQ_CODEL=3Dy
> # CONFIG_DEFAULT_SFQ is not set
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH=3D"fq_codel"
>=20
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_BASIC=3Dm
> CONFIG_NET_CLS_ROUTE4=3Dm
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> CONFIG_CLS_U32_PERF=3Dy
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_FLOW=3Dm
> CONFIG_NET_CLS_CGROUP=3Dy
> CONFIG_NET_CLS_BPF=3Dm
> CONFIG_NET_CLS_FLOWER=3Dm
> CONFIG_NET_CLS_MATCHALL=3Dm
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> CONFIG_NET_EMATCH_CMP=3Dm
> CONFIG_NET_EMATCH_NBYTE=3Dm
> CONFIG_NET_EMATCH_U32=3Dm
> CONFIG_NET_EMATCH_META=3Dm
> CONFIG_NET_EMATCH_TEXT=3Dm
> # CONFIG_NET_EMATCH_CANID is not set
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dm
> CONFIG_NET_ACT_GACT=3Dm
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dm
> CONFIG_NET_ACT_SAMPLE=3Dm
> # CONFIG_NET_ACT_IPT is not set
> CONFIG_NET_ACT_NAT=3Dm
> CONFIG_NET_ACT_PEDIT=3Dm
> CONFIG_NET_ACT_SIMP=3Dm
> CONFIG_NET_ACT_SKBEDIT=3Dm
> CONFIG_NET_ACT_CSUM=3Dm
> # CONFIG_NET_ACT_MPLS is not set
> CONFIG_NET_ACT_VLAN=3Dm
> CONFIG_NET_ACT_BPF=3Dm
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_CTINFO is not set
> CONFIG_NET_ACT_SKBMOD=3Dm
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=3Dm
> # CONFIG_NET_ACT_GATE is not set
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=3Dy
> CONFIG_DCB=3Dy
> CONFIG_DNS_RESOLVER=3Dm
> # CONFIG_BATMAN_ADV is not set
> CONFIG_OPENVSWITCH=3Dm
> CONFIG_OPENVSWITCH_GRE=3Dm
> CONFIG_VSOCKETS=3Dm
> CONFIG_VSOCKETS_DIAG=3Dm
> CONFIG_VSOCKETS_LOOPBACK=3Dm
> CONFIG_VIRTIO_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
> CONFIG_HYPERV_VSOCKETS=3Dm
> CONFIG_NETLINK_DIAG=3Dm
> CONFIG_MPLS=3Dy
> CONFIG_NET_MPLS_GSO=3Dy
> CONFIG_MPLS_ROUTING=3Dm
> CONFIG_MPLS_IPTUNNEL=3Dm
> CONFIG_NET_NSH=3Dy
> # CONFIG_HSR is not set
> CONFIG_NET_SWITCHDEV=3Dy
> CONFIG_NET_L3_MASTER_DEV=3Dy
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_PCPU_DEV_REFCNT=3Dy
> CONFIG_MAX_SKB_FRAGS=3D17
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
> CONFIG_XPS=3Dy
> CONFIG_CGROUP_NET_PRIO=3Dy
> CONFIG_CGROUP_NET_CLASSID=3Dy
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_BPF_STREAM_PARSER=3Dy
> CONFIG_NET_FLOW_LIMIT=3Dy
>=20
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=3Dm
> CONFIG_NET_DROP_MONITOR=3Dy
> # end of Network testing
> # end of Networking options
>=20
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=3Dm
> CONFIG_CAN_RAW=3Dm
> CONFIG_CAN_BCM=3Dm
> CONFIG_CAN_GW=3Dm
> # CONFIG_CAN_J1939 is not set
> # CONFIG_CAN_ISOTP is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=3Dy
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=3Dy
> CONFIG_WIRELESS=3Dy
> CONFIG_CFG80211=3Dm
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
> CONFIG_CFG80211_DEFAULT_PS=3Dy
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> # CONFIG_CFG80211_WEXT is not set
> CONFIG_MAC80211=3Dm
> CONFIG_MAC80211_HAS_RC=3Dy
> CONFIG_MAC80211_RC_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> # CONFIG_MAC80211_MESH is not set
> CONFIG_MAC80211_LEDS=3Dy
> CONFIG_MAC80211_DEBUGFS=3Dy
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> CONFIG_RFKILL=3Dm
> CONFIG_RFKILL_LEDS=3Dy
> CONFIG_RFKILL_INPUT=3Dy
> # CONFIG_RFKILL_GPIO is not set
> CONFIG_NET_9P=3Dy
> CONFIG_NET_9P_FD=3Dy
> CONFIG_NET_9P_VIRTIO=3Dy
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=3Dm
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=3Dm
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=3Dy
> CONFIG_LWTUNNEL_BPF=3Dy
> CONFIG_DST_CACHE=3Dy
> CONFIG_GRO_CELLS=3Dy
> CONFIG_SOCK_VALIDATE_XMIT=3Dy
> CONFIG_NET_SELFTESTS=3Dy
> CONFIG_NET_SOCK_MSG=3Dy
> CONFIG_PAGE_POOL=3Dy
> # CONFIG_PAGE_POOL_STATS is not set
> CONFIG_FAILOVER=3Dm
> CONFIG_ETHTOOL_NETLINK=3Dy
>=20
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=3Dy
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> CONFIG_PCIEPORTBUS=3Dy
> CONFIG_HOTPLUG_PCI_PCIE=3Dy
> CONFIG_PCIEAER=3Dy
> CONFIG_PCIEAER_INJECT=3Dm
> CONFIG_PCIE_ECRC=3Dy
> CONFIG_PCIEASPM=3Dy
> CONFIG_PCIEASPM_DEFAULT=3Dy
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=3Dy
> CONFIG_PCIE_DPC=3Dy
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCIE_EDR is not set
> CONFIG_PCI_MSI=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=3Dy
> CONFIG_PCI_PF_STUB=3Dm
> CONFIG_PCI_ATS=3Dy
> CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> CONFIG_PCI_IOV=3Dy
> CONFIG_PCI_PRI=3Dy
> CONFIG_PCI_PASID=3Dy
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=3Dy
> CONFIG_PCI_HYPERV=3Dm
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> CONFIG_PCIE_BUS_DEFAULT=3Dy
> # CONFIG_PCIE_BUS_SAFE is not set
> # CONFIG_PCIE_BUS_PERFORMANCE is not set
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D64
> CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> CONFIG_HOTPLUG_PCI_SHPC=3Dy
>=20
> #
> # PCI controller drivers
> #
> CONFIG_VMD=3Dy
> CONFIG_PCI_HYPERV_INTERFACE=3Dm
>=20
> #
> # Cadence-based PCIe controllers
> #
> # end of Cadence-based PCIe controllers
>=20
> #
> # DesignWare-based PCIe controllers
> #
> # CONFIG_PCI_MESON is not set
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # end of DesignWare-based PCIe controllers
>=20
> #
> # Mobiveil-based PCIe controllers
> #
> # end of Mobiveil-based PCIe controllers
> # end of PCI controller drivers
>=20
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
>=20
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
>=20
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
>=20
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=3Dy
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> # CONFIG_DEVTMPFS_SAFE is not set
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>=20
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=3Dy
> CONFIG_FW_LOADER_DEBUG=3Dy
> CONFIG_FW_LOADER_PAGED_BUF=3Dy
> CONFIG_FW_LOADER_SYSFS=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> CONFIG_FW_LOADER_USER_HELPER=3Dy
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=3Dy
> # CONFIG_FW_UPLOAD is not set
> # end of Firmware loader
>=20
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_HMEM_REPORTING=3Dy
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
> CONFIG_REGMAP=3Dy
> CONFIG_REGMAP_I2C=3Dm
> CONFIG_REGMAP_SPI=3Dm
> CONFIG_DMA_SHARED_BUFFER=3Dy
> # CONFIG_DMA_FENCE_TRACE is not set
> # CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
> # end of Generic Driver Options
>=20
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # CONFIG_MHI_BUS_EP is not set
> # end of Bus devices
>=20
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
>=20
> #
> # Firmware Drivers
> #
>=20
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
>=20
> CONFIG_EDD=3Dm
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=3Dy
> CONFIG_DMIID=3Dy
> CONFIG_DMI_SYSFS=3Dy
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> # CONFIG_ISCSI_IBFT is not set
> CONFIG_FW_CFG_SYSFS=3Dy
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=3Dy
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
>=20
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_ESRT=3Dy
> CONFIG_EFI_VARS_PSTORE=3Dy
> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=3Dy
> CONFIG_EFI_SOFT_RESERVE=3Dy
> CONFIG_EFI_DXE_MEM_ATTRIBUTES=3Dy
> CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> # CONFIG_APPLE_PROPERTIES is not set
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> CONFIG_EFI_EARLYCON=3Dy
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=3Dy
> # CONFIG_EFI_DISABLE_RUNTIME is not set
> # CONFIG_EFI_COCO_SECRET is not set
> # end of EFI (Extensible Firmware Interface) Support
>=20
> CONFIG_UEFI_CPER=3Dy
> CONFIG_UEFI_CPER_X86=3Dy
>=20
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
>=20
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PARPORT_SERIAL=3Dm
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_1284=3Dy
> CONFIG_PNP=3Dy
> # CONFIG_PNP_DEBUG_MESSAGES is not set
>=20
> #
> # Protocols
> #
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_NULL_BLK=3Dm
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=3Dm
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> # CONFIG_ZRAM is not set
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D0
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_RAM=3Dm
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D16384
> CONFIG_CDROM_PKTCDVD=3Dm
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_VIRTIO_BLK=3Dm
> CONFIG_BLK_DEV_RBD=3Dm
> # CONFIG_BLK_DEV_UBLK is not set
>=20
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=3Dm
> CONFIG_BLK_DEV_NVME=3Dm
> CONFIG_NVME_MULTIPATH=3Dy
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> # CONFIG_NVME_FC is not set
> # CONFIG_NVME_TCP is not set
> # CONFIG_NVME_AUTH is not set
> # CONFIG_NVME_TARGET is not set
> # end of NVME Support
>=20
> #
> # Misc devices
> #
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> CONFIG_TIFM_CORE=3Dm
> CONFIG_TIFM_7XX1=3Dm
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=3Dm
> # CONFIG_SGI_XP is not set
> CONFIG_HP_ILO=3Dm
> # CONFIG_SGI_GRU is not set
> CONFIG_APDS9802ALS=3Dm
> CONFIG_ISL29003=3Dm
> CONFIG_ISL29020=3Dm
> CONFIG_SENSORS_TSL2550=3Dm
> CONFIG_SENSORS_BH1770=3Dm
> CONFIG_SENSORS_APDS990X=3Dm
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> # CONFIG_C2PORT is not set
>=20
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=3Dm
> CONFIG_EEPROM_MAX6875=3Dm
> CONFIG_EEPROM_93CX6=3Dm
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
>=20
> # CONFIG_CB710_CORE is not set
>=20
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
>=20
> # CONFIG_SENSORS_LIS3_I2C is not set
> # CONFIG_ALTERA_STAPL is not set
> CONFIG_INTEL_MEI=3Dm
> CONFIG_INTEL_MEI_ME=3Dm
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_INTEL_MEI_GSC is not set
> # CONFIG_INTEL_MEI_HDCP is not set
> # CONFIG_INTEL_MEI_PXP is not set
> # CONFIG_VMWARE_VMCI is not set
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_UACCE is not set
> CONFIG_PVPANIC=3Dy
> # CONFIG_PVPANIC_MMIO is not set
> # CONFIG_PVPANIC_PCI is not set
> # CONFIG_GP_PCI1XXXX is not set
> # end of Misc devices
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dy
> CONFIG_RAID_ATTRS=3Dm
> CONFIG_SCSI_COMMON=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DMA=3Dy
> CONFIG_SCSI_NETLINK=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_CHR_DEV_SG=3Dm
> CONFIG_BLK_DEV_BSG=3Dy
> CONFIG_CHR_DEV_SCH=3Dm
> CONFIG_SCSI_ENCLOSURE=3Dm
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_SCSI_LOGGING=3Dy
> CONFIG_SCSI_SCAN_ASYNC=3Dy
>=20
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=3Dm
> CONFIG_SCSI_FC_ATTRS=3Dm
> CONFIG_SCSI_ISCSI_ATTRS=3Dm
> CONFIG_SCSI_SAS_ATTRS=3Dm
> CONFIG_SCSI_SAS_LIBSAS=3Dm
> CONFIG_SCSI_SAS_ATA=3Dy
> CONFIG_SCSI_SAS_HOST_SMP=3Dy
> CONFIG_SCSI_SRP_ATTRS=3Dm
> # end of SCSI Transports
>=20
> CONFIG_SCSI_LOWLEVEL=3Dy
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> CONFIG_MEGARAID_NEWGEN=3Dy
> CONFIG_MEGARAID_MM=3Dm
> CONFIG_MEGARAID_MAILBOX=3Dm
> CONFIG_MEGARAID_LEGACY=3Dm
> CONFIG_MEGARAID_SAS=3Dm
> CONFIG_SCSI_MPT3SAS=3Dm
> CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_MPI3MR is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> CONFIG_HYPERV_STORAGE=3Dm
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> CONFIG_SCSI_ISCI=3Dm
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> # CONFIG_SCSI_VIRTIO is not set
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> CONFIG_SCSI_DH=3Dy
> CONFIG_SCSI_DH_RDAC=3Dy
> CONFIG_SCSI_DH_HP_SW=3Dy
> CONFIG_SCSI_DH_EMC=3Dy
> CONFIG_SCSI_DH_ALUA=3Dy
> # end of SCSI device support
>=20
> CONFIG_ATA=3Dm
> CONFIG_SATA_HOST=3Dy
> CONFIG_PATA_TIMINGS=3Dy
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_FORCE=3Dy
> CONFIG_ATA_ACPI=3Dy
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=3Dy
>=20
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=3Dm
> CONFIG_SATA_MOBILE_LPM_POLICY=3D0
> CONFIG_SATA_AHCI_PLATFORM=3Dm
> # CONFIG_AHCI_DWC is not set
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=3Dy
>=20
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=3Dy
>=20
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=3Dm
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
>=20
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
>=20
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_RZ1000 is not set
> # CONFIG_PATA_PARPORT is not set
>=20
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=3Dm
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dy
> CONFIG_MD_AUTODETECT=3Dy
> CONFIG_MD_LINEAR=3Dm
> CONFIG_MD_RAID0=3Dm
> CONFIG_MD_RAID1=3Dm
> CONFIG_MD_RAID10=3Dm
> CONFIG_MD_RAID456=3Dm
> # CONFIG_MD_MULTIPATH is not set
> CONFIG_MD_FAULTY=3Dm
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> CONFIG_BLK_DEV_DM=3Dm
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=3Dm
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=3Dm
> CONFIG_DM_PERSISTENT_DATA=3Dm
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=3Dm
> CONFIG_DM_SNAPSHOT=3Dm
> CONFIG_DM_THIN_PROVISIONING=3Dm
> CONFIG_DM_CACHE=3Dm
> CONFIG_DM_CACHE_SMQ=3Dm
> CONFIG_DM_WRITECACHE=3Dm
> # CONFIG_DM_EBS is not set
> CONFIG_DM_ERA=3Dm
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=3Dm
> CONFIG_DM_LOG_USERSPACE=3Dm
> CONFIG_DM_RAID=3Dm
> CONFIG_DM_ZERO=3Dm
> CONFIG_DM_MULTIPATH=3Dm
> CONFIG_DM_MULTIPATH_QL=3Dm
> CONFIG_DM_MULTIPATH_ST=3Dm
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> CONFIG_DM_DELAY=3Dm
> # CONFIG_DM_DUST is not set
> CONFIG_DM_UEVENT=3Dy
> CONFIG_DM_FLAKEY=3Dm
> CONFIG_DM_VERITY=3Dm
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> # CONFIG_DM_VERITY_FEC is not set
> CONFIG_DM_SWITCH=3Dm
> CONFIG_DM_LOG_WRITES=3Dm
> CONFIG_DM_INTEGRITY=3Dm
> CONFIG_DM_AUDIT=3Dy
> # CONFIG_TARGET_CORE is not set
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=3Dm
> CONFIG_FIREWIRE_OHCI=3Dm
> CONFIG_FIREWIRE_SBP2=3Dm
> CONFIG_FIREWIRE_NET=3Dm
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
>=20
> CONFIG_MACINTOSH_DRIVERS=3Dy
> CONFIG_MAC_EMUMOUSEBTN=3Dy
> CONFIG_NETDEVICES=3Dy
> CONFIG_MII=3Dy
> CONFIG_NET_CORE=3Dy
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_IFB is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_AMT is not set
> # CONFIG_MACSEC is not set
> CONFIG_NETCONSOLE=3Dm
> CONFIG_NETCONSOLE_DYNAMIC=3Dy
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_TUN=3Dm
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=3Dm
> # CONFIG_NLMON is not set
> # CONFIG_NET_VRF is not set
> # CONFIG_VSOCKMON is not set
> # CONFIG_ARCNET is not set
> CONFIG_ETHERNET=3Dy
> CONFIG_MDIO=3Dy
> # CONFIG_NET_VENDOR_3COM is not set
> CONFIG_NET_VENDOR_ADAPTEC=3Dy
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=3Dy
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=3Dy
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=3Dy
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=3Dy
> # CONFIG_ENA_ETHERNET is not set
> # CONFIG_NET_VENDOR_AMD is not set
> CONFIG_NET_VENDOR_AQUANTIA=3Dy
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=3Dy
> CONFIG_NET_VENDOR_ASIX=3Dy
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=3Dy
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> # CONFIG_CX_ECAT is not set
> CONFIG_NET_VENDOR_BROADCOM=3Dy
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_CADENCE=3Dy
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=3Dy
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> CONFIG_CAVIUM_PTP=3Dy
> # CONFIG_LIQUIDIO is not set
> # CONFIG_LIQUIDIO_VF is not set
> CONFIG_NET_VENDOR_CHELSIO=3Dy
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=3Dy
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=3Dy
> CONFIG_NET_VENDOR_DAVICOM=3Dy
> # CONFIG_DM9051 is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=3Dy
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=3Dy
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=3Dy
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_ENGLEDER=3Dy
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=3Dy
> CONFIG_NET_VENDOR_FUNGIBLE=3Dy
> # CONFIG_FUN_ETH is not set
> CONFIG_NET_VENDOR_GOOGLE=3Dy
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=3Dy
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=3Dy
> CONFIG_NET_VENDOR_INTEL=3Dy
> # CONFIG_E100 is not set
> CONFIG_E1000=3Dy
> CONFIG_E1000E=3Dy
> CONFIG_E1000E_HWTS=3Dy
> CONFIG_IGB=3Dy
> CONFIG_IGB_HWMON=3Dy
> # CONFIG_IGBVF is not set
> CONFIG_IXGBE=3Dy
> CONFIG_IXGBE_HWMON=3Dy
> # CONFIG_IXGBE_DCB is not set
> # CONFIG_IXGBE_IPSEC is not set
> # CONFIG_IXGBEVF is not set
> CONFIG_I40E=3Dy
> # CONFIG_I40E_DCB is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> CONFIG_IGC=3Dy
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_ADI=3Dy
> # CONFIG_ADIN1110 is not set
> CONFIG_NET_VENDOR_LITEX=3Dy
> CONFIG_NET_VENDOR_MARVELL=3Dy
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_OCTEON_EP is not set
> # CONFIG_PRESTERA is not set
> CONFIG_NET_VENDOR_MELLANOX=3Dy
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=3Dy
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=3Dy
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> # CONFIG_VCAP is not set
> CONFIG_NET_VENDOR_MICROSEMI=3Dy
> CONFIG_NET_VENDOR_MICROSOFT=3Dy
> # CONFIG_MICROSOFT_MANA is not set
> CONFIG_NET_VENDOR_MYRI=3Dy
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NI=3Dy
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_NATSEMI=3Dy
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=3Dy
> # CONFIG_S2IO is not set
> CONFIG_NET_VENDOR_NETRONOME=3Dy
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_8390=3Dy
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=3Dy
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=3Dy
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=3Dy
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=3Dy
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=3Dy
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_BROCADE=3Dy
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_QUALCOMM=3Dy
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=3Dy
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=3Dy
> # CONFIG_ATP is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> CONFIG_R8169=3Dy
> CONFIG_NET_VENDOR_RENESAS=3Dy
> CONFIG_NET_VENDOR_ROCKER=3Dy
> # CONFIG_ROCKER is not set
> CONFIG_NET_VENDOR_SAMSUNG=3Dy
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=3Dy
> CONFIG_NET_VENDOR_SILAN=3Dy
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=3Dy
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> # CONFIG_SFC_SIENA is not set
> CONFIG_NET_VENDOR_SMSC=3Dy
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=3Dy
> CONFIG_NET_VENDOR_STMICRO=3Dy
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=3Dy
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=3Dy
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=3Dy
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=3Dy
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VERTEXCOM=3Dy
> # CONFIG_MSE102X is not set
> CONFIG_NET_VENDOR_VIA=3Dy
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WANGXUN=3Dy
> # CONFIG_NGBE is not set
> # CONFIG_TXGBE is not set
> CONFIG_NET_VENDOR_WIZNET=3Dy
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=3Dy
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_PHYLINK=3Dy
> CONFIG_PHYLIB=3Dy
> CONFIG_SWPHY=3Dy
> # CONFIG_LED_TRIGGER_PHY is not set
> CONFIG_FIXED_PHY=3Dy
> # CONFIG_SFP is not set
>=20
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_ADIN_PHY is not set
> # CONFIG_ADIN1100_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> CONFIG_AX88796B_PHY=3Dy
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_BCM54140_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM84881_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> # CONFIG_MEDIATEK_GE_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_T1S_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_MOTORCOMM_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_CBTX_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_NCN26000_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> CONFIG_REALTEK_PHY=3Dy
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> # CONFIG_DP83TD510_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> # CONFIG_PSE_CONTROLLER is not set
> # CONFIG_CAN_DEV is not set
> CONFIG_MDIO_DEVICE=3Dy
> CONFIG_MDIO_BUS=3Dy
> CONFIG_FWNODE_MDIO=3Dy
> CONFIG_ACPI_MDIO=3Dy
> CONFIG_MDIO_DEVRES=3Dy
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_THUNDER is not set
>=20
> #
> # MDIO Multiplexers
> #
>=20
> #
> # PCS device drivers
> #
> # end of PCS device drivers
>=20
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=3Dy
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> CONFIG_USB_RTL8152=3Dy
> # CONFIG_USB_LAN78XX is not set
> CONFIG_USB_USBNET=3Dy
> CONFIG_USB_NET_AX8817X=3Dy
> CONFIG_USB_NET_AX88179_178A=3Dy
> # CONFIG_USB_NET_CDCETHER is not set
> # CONFIG_USB_NET_CDC_EEM is not set
> # CONFIG_USB_NET_CDC_NCM is not set
> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> # CONFIG_USB_NET_CDC_MBIM is not set
> # CONFIG_USB_NET_DM9601 is not set
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> # CONFIG_USB_NET_SMSC75XX is not set
> # CONFIG_USB_NET_SMSC95XX is not set
> # CONFIG_USB_NET_GL620A is not set
> # CONFIG_USB_NET_NET1080 is not set
> # CONFIG_USB_NET_PLUSB is not set
> # CONFIG_USB_NET_MCS7830 is not set
> # CONFIG_USB_NET_RNDIS_HOST is not set
> # CONFIG_USB_NET_CDC_SUBSET is not set
> # CONFIG_USB_NET_ZAURUS is not set
> # CONFIG_USB_NET_CX82310_ETH is not set
> # CONFIG_USB_NET_KALMIA is not set
> # CONFIG_USB_NET_QMI_WWAN is not set
> # CONFIG_USB_HSO is not set
> # CONFIG_USB_NET_INT51X1 is not set
> # CONFIG_USB_IPHETH is not set
> # CONFIG_USB_SIERRA_NET is not set
> # CONFIG_USB_NET_CH9200 is not set
> # CONFIG_USB_NET_AQC111 is not set
> # CONFIG_WLAN is not set
> # CONFIG_WAN is not set
>=20
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
>=20
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> CONFIG_HYPERV_NET=3Dy
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=3Dm
> # CONFIG_ISDN is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_LEDS=3Dy
> CONFIG_INPUT_FF_MEMLESS=3Dm
> CONFIG_INPUT_SPARSEKMAP=3Dm
> # CONFIG_INPUT_MATRIXKMAP is not set
> CONFIG_INPUT_VIVALDIFMAP=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_JOYDEV=3Dm
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_PS2_ALPS=3Dy
> CONFIG_MOUSE_PS2_BYD=3Dy
> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> CONFIG_MOUSE_PS2_CYPRESS=3Dy
> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> CONFIG_MOUSE_PS2_ELANTECH=3Dy
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
> CONFIG_MOUSE_PS2_SENTELIC=3Dy
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> CONFIG_MOUSE_PS2_VMMOUSE=3Dy
> CONFIG_MOUSE_PS2_SMBUS=3Dy
> CONFIG_MOUSE_SERIAL=3Dm
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> CONFIG_MOUSE_CYAPA=3Dm
> CONFIG_MOUSE_ELAN_I2C=3Dm
> CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
> CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
> CONFIG_MOUSE_VSXXXAA=3Dm
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> # CONFIG_INPUT_MISC is not set
> CONFIG_RMI4_CORE=3Dm
> CONFIG_RMI4_I2C=3Dm
> CONFIG_RMI4_SPI=3Dm
> CONFIG_RMI4_SMB=3Dm
> CONFIG_RMI4_F03=3Dy
> CONFIG_RMI4_F03_SERIO=3Dm
> CONFIG_RMI4_2D_SENSOR=3Dy
> CONFIG_RMI4_F11=3Dy
> CONFIG_RMI4_F12=3Dy
> CONFIG_RMI4_F30=3Dy
> CONFIG_RMI4_F34=3Dy
> # CONFIG_RMI4_F3A is not set
> CONFIG_RMI4_F55=3Dy
>=20
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=3Dy
> CONFIG_SERIO_RAW=3Dm
> CONFIG_SERIO_ALTERA_PS2=3Dm
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=3Dm
> CONFIG_HYPERV_KEYBOARD=3Dm
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
>=20
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_VT_CONSOLE_SLEEP=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LEGACY_TIOCSTI=3Dy
> CONFIG_LDISC_AUTOLOAD=3Dy
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=3Dy
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_DMA=3Dy
> CONFIG_SERIAL_8250_PCILIB=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_EXAR=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D64
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> # CONFIG_SERIAL_8250_PCI1XXXX is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=3Dy
> CONFIG_SERIAL_8250_DWLIB=3Dy
> CONFIG_SERIAL_8250_DW=3Dy
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=3Dy
> CONFIG_SERIAL_8250_MID=3Dy
> CONFIG_SERIAL_8250_PERICOM=3Dy
>=20
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_SERIAL_ARC=3Dm
> CONFIG_SERIAL_ARC_NR_PORTS=3D1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
>=20
> CONFIG_SERIAL_MCTRL_GPIO=3Dy
> CONFIG_SERIAL_NONSTANDARD=3Dy
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_SYNCLINK_GT=3Dm
> CONFIG_N_HDLC=3Dm
> CONFIG_N_GSM=3Dm
> CONFIG_NOZOMI=3Dm
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=3Dy
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_TTY_PRINTK is not set
> CONFIG_PRINTER=3Dm
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dm
> CONFIG_VIRTIO_CONSOLE=3Dm
> CONFIG_IPMI_HANDLER=3Dm
> CONFIG_IPMI_DMI_DECODE=3Dy
> CONFIG_IPMI_PLAT_DATA=3Dy
> CONFIG_IPMI_PANIC_EVENT=3Dy
> CONFIG_IPMI_PANIC_STRING=3Dy
> CONFIG_IPMI_DEVICE_INTERFACE=3Dm
> CONFIG_IPMI_SI=3Dm
> CONFIG_IPMI_SSIF=3Dm
> CONFIG_IPMI_WATCHDOG=3Dm
> CONFIG_IPMI_POWEROFF=3Dm
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
> CONFIG_HW_RANDOM_INTEL=3Dm
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_VIA=3Dm
> CONFIG_HW_RANDOM_VIRTIO=3Dy
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=3Dy
> CONFIG_NVRAM=3Dy
> CONFIG_DEVPORT=3Dy
> CONFIG_HPET=3Dy
> CONFIG_HPET_MMAP=3Dy
> # CONFIG_HPET_MMAP_DEFAULT is not set
> CONFIG_HANGCHECK_TIMER=3Dm
> CONFIG_UV_MMTIMER=3Dm
> CONFIG_TCG_TPM=3Dy
> CONFIG_HW_RANDOM_TPM=3Dy
> CONFIG_TCG_TIS_CORE=3Dy
> CONFIG_TCG_TIS=3Dy
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> CONFIG_TCG_TIS_I2C_ATMEL=3Dm
> CONFIG_TCG_TIS_I2C_INFINEON=3Dm
> CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
> CONFIG_TCG_NSC=3Dm
> CONFIG_TCG_ATMEL=3Dm
> CONFIG_TCG_INFINEON=3Dm
> CONFIG_TCG_CRB=3Dy
> # CONFIG_TCG_VTPM_PROXY is not set
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=3Dm
> # CONFIG_XILLYBUS is not set
> # CONFIG_XILLYUSB is not set
> # end of Character devices
>=20
> #
> # I2C support
> #
> CONFIG_I2C=3Dy
> CONFIG_ACPI_I2C_OPREGION=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_COMPAT=3Dy
> CONFIG_I2C_CHARDEV=3Dm
> CONFIG_I2C_MUX=3Dm
>=20
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=3Dm
> # end of Multiplexer I2C Chip support
>=20
> CONFIG_I2C_HELPER_AUTO=3Dy
> CONFIG_I2C_SMBUS=3Dm
> CONFIG_I2C_ALGOBIT=3Dy
> CONFIG_I2C_ALGOPCA=3Dm
>=20
> #
> # I2C Hardware Bus support
> #
>=20
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> CONFIG_I2C_I801=3Dm
> CONFIG_I2C_ISCH=3Dm
> CONFIG_I2C_ISMT=3Dm
> CONFIG_I2C_PIIX4=3Dm
> CONFIG_I2C_NFORCE2=3Dm
> CONFIG_I2C_NFORCE2_S4985=3Dm
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=3Dm
> CONFIG_I2C_VIA=3Dm
> CONFIG_I2C_VIAPRO=3Dm
>=20
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=3Dm
>=20
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=3Dm
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=3Dm
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=3Dm
> CONFIG_I2C_SIMTEC=3Dm
> # CONFIG_I2C_XILINX is not set
>=20
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_CP2615 is not set
> CONFIG_I2C_PARPORT=3Dm
> # CONFIG_I2C_PCI1XXXX is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
>=20
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=3Dm
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
>=20
> CONFIG_I2C_STUB=3Dm
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
>=20
> # CONFIG_I3C is not set
> CONFIG_SPI=3Dy
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=3Dy
> # CONFIG_SPI_MEM is not set
>=20
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_LM70_LLP is not set
> # CONFIG_SPI_MICROCHIP_CORE is not set
> # CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PCI1XXXX is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> # CONFIG_SPI_AMD is not set
>=20
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
>=20
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=3Dy
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=3Dy
> # CONFIG_PPS_DEBUG is not set
>=20
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=3Dm
> CONFIG_PPS_CLIENT_PARPORT=3Dm
> CONFIG_PPS_CLIENT_GPIO=3Dm
>=20
> #
> # PPS generators support
> #
>=20
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=3Dy
> CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy
> # CONFIG_DP83640_PHY is not set
> # CONFIG_PTP_1588_CLOCK_INES is not set
> CONFIG_PTP_1588_CLOCK_KVM=3Dm
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # end of PTP clock support
>=20
> CONFIG_PINCTRL=3Dy
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_CY8C95X0 is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
>=20
> #
> # Intel pinctrl drivers
> #
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> # CONFIG_PINCTRL_ALDERLAKE is not set
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LAKEFIELD is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_METEORLAKE is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> # CONFIG_PINCTRL_TIGERLAKE is not set
> # end of Intel pinctrl drivers
>=20
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
>=20
> CONFIG_GPIOLIB=3Dy
> CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
> CONFIG_GPIO_ACPI=3Dy
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=3Dy
> CONFIG_GPIO_CDEV=3Dy
> CONFIG_GPIO_CDEV_V1=3Dy
>=20
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_ICH=3Dm
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
>=20
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
>=20
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_FXL6408 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
>=20
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_ELKHARTLAKE is not set
> # end of MFD GPIO expanders
>=20
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
>=20
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
>=20
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
>=20
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_LATCH is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
>=20
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=3Dy
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_SUPPLY=3Dy
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=3Dy
> # CONFIG_IP5XXX_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_MAX77976 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_BD99954 is not set
> # CONFIG_BATTERY_UG3105 is not set
> CONFIG_HWMON=3Dy
> CONFIG_HWMON_VID=3Dm
> # CONFIG_HWMON_DEBUG_CHIP is not set
>=20
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=3Dm
> CONFIG_SENSORS_ABITUGURU3=3Dm
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=3Dm
> CONFIG_SENSORS_AD7418=3Dm
> CONFIG_SENSORS_ADM1025=3Dm
> CONFIG_SENSORS_ADM1026=3Dm
> CONFIG_SENSORS_ADM1029=3Dm
> CONFIG_SENSORS_ADM1031=3Dm
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=3Dm
> CONFIG_SENSORS_ADT7X10=3Dm
> # CONFIG_SENSORS_ADT7310 is not set
> CONFIG_SENSORS_ADT7410=3Dm
> CONFIG_SENSORS_ADT7411=3Dm
> CONFIG_SENSORS_ADT7462=3Dm
> CONFIG_SENSORS_ADT7470=3Dm
> CONFIG_SENSORS_ADT7475=3Dm
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=3Dm
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=3Dm
> CONFIG_SENSORS_APPLESMC=3Dm
> CONFIG_SENSORS_ASB100=3Dm
> CONFIG_SENSORS_ATXP1=3Dm
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=3Dm
> CONFIG_SENSORS_DS1621=3Dm
> # CONFIG_SENSORS_DELL_SMM is not set
> CONFIG_SENSORS_I5K_AMB=3Dm
> CONFIG_SENSORS_F71805F=3Dm
> CONFIG_SENSORS_F71882FG=3Dm
> CONFIG_SENSORS_F75375S=3Dm
> CONFIG_SENSORS_FSCHMD=3Dm
> # CONFIG_SENSORS_FTSTEUTATES is not set
> CONFIG_SENSORS_GL518SM=3Dm
> CONFIG_SENSORS_GL520SM=3Dm
> CONFIG_SENSORS_G760A=3Dm
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=3Dm
> CONFIG_SENSORS_IBMPEX=3Dm
> CONFIG_SENSORS_I5500=3Dm
> CONFIG_SENSORS_CORETEMP=3Dm
> CONFIG_SENSORS_IT87=3Dm
> CONFIG_SENSORS_JC42=3Dm
> # CONFIG_SENSORS_POWR1220 is not set
> CONFIG_SENSORS_LINEAGE=3Dm
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=3Dm
> CONFIG_SENSORS_LTC4215=3Dm
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=3Dm
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=3Dm
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=3Dm
> CONFIG_SENSORS_MAX1619=3Dm
> CONFIG_SENSORS_MAX1668=3Dm
> CONFIG_SENSORS_MAX197=3Dm
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX31760 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=3Dm
> CONFIG_SENSORS_MAX6650=3Dm
> CONFIG_SENSORS_MAX6697=3Dm
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MC34VR500 is not set
> CONFIG_SENSORS_MCP3021=3Dm
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=3Dm
> # CONFIG_SENSORS_LM70 is not set
> CONFIG_SENSORS_LM73=3Dm
> CONFIG_SENSORS_LM75=3Dm
> CONFIG_SENSORS_LM77=3Dm
> CONFIG_SENSORS_LM78=3Dm
> CONFIG_SENSORS_LM80=3Dm
> CONFIG_SENSORS_LM83=3Dm
> CONFIG_SENSORS_LM85=3Dm
> CONFIG_SENSORS_LM87=3Dm
> CONFIG_SENSORS_LM90=3Dm
> CONFIG_SENSORS_LM92=3Dm
> CONFIG_SENSORS_LM93=3Dm
> CONFIG_SENSORS_LM95234=3Dm
> CONFIG_SENSORS_LM95241=3Dm
> CONFIG_SENSORS_LM95245=3Dm
> CONFIG_SENSORS_PC87360=3Dm
> CONFIG_SENSORS_PC87427=3Dm
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775_CORE=3Dm
> CONFIG_SENSORS_NCT6775=3Dm
> # CONFIG_SENSORS_NCT6775_I2C is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
> # CONFIG_SENSORS_NZXT_SMART2 is not set
> # CONFIG_SENSORS_OCC_P8_I2C is not set
> # CONFIG_SENSORS_OXP is not set
> CONFIG_SENSORS_PCF8591=3Dm
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=3Dm
> CONFIG_SENSORS_SHT21=3Dm
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=3Dm
> CONFIG_SENSORS_DME1737=3Dm
> CONFIG_SENSORS_EMC1403=3Dm
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC2305 is not set
> CONFIG_SENSORS_EMC6W201=3Dm
> CONFIG_SENSORS_SMSC47M1=3Dm
> CONFIG_SENSORS_SMSC47M192=3Dm
> CONFIG_SENSORS_SMSC47B397=3Dm
> CONFIG_SENSORS_SCH56XX_COMMON=3Dm
> CONFIG_SENSORS_SCH5627=3Dm
> CONFIG_SENSORS_SCH5636=3Dm
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS7828=3Dm
> # CONFIG_SENSORS_ADS7871 is not set
> CONFIG_SENSORS_AMC6821=3Dm
> CONFIG_SENSORS_INA209=3Dm
> CONFIG_SENSORS_INA2XX=3Dm
> # CONFIG_SENSORS_INA238 is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=3Dm
> CONFIG_SENSORS_TMP102=3Dm
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=3Dm
> CONFIG_SENSORS_TMP421=3Dm
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=3Dm
> CONFIG_SENSORS_VIA686A=3Dm
> CONFIG_SENSORS_VT1211=3Dm
> CONFIG_SENSORS_VT8231=3Dm
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=3Dm
> CONFIG_SENSORS_W83791D=3Dm
> CONFIG_SENSORS_W83792D=3Dm
> CONFIG_SENSORS_W83793=3Dm
> CONFIG_SENSORS_W83795=3Dm
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=3Dm
> CONFIG_SENSORS_W83L786NG=3Dm
> CONFIG_SENSORS_W83627HF=3Dm
> CONFIG_SENSORS_W83627EHF=3Dm
> # CONFIG_SENSORS_XGENE is not set
>=20
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=3Dm
> CONFIG_SENSORS_ATK0110=3Dm
> # CONFIG_SENSORS_ASUS_WMI is not set
> # CONFIG_SENSORS_ASUS_EC is not set
> CONFIG_THERMAL=3Dy
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> CONFIG_THERMAL_HWMON=3Dy
> CONFIG_THERMAL_ACPI=3Dy
> CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
> CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> CONFIG_THERMAL_GOV_BANG_BANG=3Dy
> CONFIG_THERMAL_GOV_USER_SPACE=3Dy
> # CONFIG_THERMAL_EMULATION is not set
>=20
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=3Dm
> CONFIG_X86_THERMAL_VECTOR=3Dy
> CONFIG_INTEL_TCC=3Dy
> CONFIG_X86_PKG_TEMP_THERMAL=3Dm
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>=20
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
>=20
> CONFIG_INTEL_PCH_THERMAL=3Dm
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_HFI_THERMAL is not set
> # end of Intel thermal drivers
>=20
> CONFIG_WATCHDOG=3Dy
> CONFIG_WATCHDOG_CORE=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
> CONFIG_WATCHDOG_SYSFS=3Dy
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
>=20
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
>=20
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=3Dm
> CONFIG_WDAT_WDT=3Dm
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ADVANTECH_EC_WDT is not set
> CONFIG_ALIM1535_WDT=3Dm
> CONFIG_ALIM7101_WDT=3Dm
> # CONFIG_EBC_C384_WDT is not set
> # CONFIG_EXAR_WDT is not set
> CONFIG_F71808E_WDT=3Dm
> # CONFIG_SP5100_TCO is not set
> CONFIG_SBC_FITPC2_WATCHDOG=3Dm
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=3Dm
> CONFIG_IBMASR=3Dm
> # CONFIG_WAFER_WDT is not set
> CONFIG_I6300ESB_WDT=3Dy
> CONFIG_IE6XX_WDT=3Dm
> CONFIG_ITCO_WDT=3Dy
> CONFIG_ITCO_VENDOR_SUPPORT=3Dy
> CONFIG_IT8712F_WDT=3Dm
> CONFIG_IT87_WDT=3Dm
> CONFIG_HP_WATCHDOG=3Dm
> CONFIG_HPWDT_NMI_DECODING=3Dy
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> CONFIG_NV_TCO=3Dm
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=3Dm
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> CONFIG_VIA_WDT=3Dm
> CONFIG_W83627HF_WDT=3Dm
> CONFIG_W83877F_WDT=3Dm
> CONFIG_W83977F_WDT=3Dm
> CONFIG_MACHZ_WDT=3Dm
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> CONFIG_INTEL_MEI_WDT=3Dm
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
>=20
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=3Dm
> CONFIG_WDTPCI=3Dm
>=20
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=3Dy
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=3Dy
> # CONFIG_BCMA is not set
>=20
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=3Dy
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_MFD_SMPRO is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=3Dm
> CONFIG_LPC_SCH=3Dm
> CONFIG_MFD_INTEL_LPSS=3Dy
> CONFIG_MFD_INTEL_LPSS_ACPI=3Dy
> CONFIG_MFD_INTEL_LPSS_PCI=3Dy
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6370 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_MFD_OCELOT is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_SY7636A is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RT5120 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=3Dm
> CONFIG_MFD_SM501_GPIO=3Dy
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=3Dm
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_INTEL_M10_BMC_SPI is not set
> # end of Multifunction device drivers
>=20
> # CONFIG_REGULATOR is not set
> CONFIG_RC_CORE=3Dm
> CONFIG_LIRC=3Dy
> CONFIG_RC_MAP=3Dm
> CONFIG_RC_DECODERS=3Dy
> CONFIG_IR_IMON_DECODER=3Dm
> CONFIG_IR_JVC_DECODER=3Dm
> CONFIG_IR_MCE_KBD_DECODER=3Dm
> CONFIG_IR_NEC_DECODER=3Dm
> CONFIG_IR_RC5_DECODER=3Dm
> CONFIG_IR_RC6_DECODER=3Dm
> # CONFIG_IR_RCMM_DECODER is not set
> CONFIG_IR_SANYO_DECODER=3Dm
> # CONFIG_IR_SHARP_DECODER is not set
> CONFIG_IR_SONY_DECODER=3Dm
> # CONFIG_IR_XMP_DECODER is not set
> CONFIG_RC_DEVICES=3Dy
> CONFIG_IR_ENE=3Dm
> CONFIG_IR_FINTEK=3Dm
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> CONFIG_IR_ITE_CIR=3Dm
> # CONFIG_IR_MCEUSB is not set
> CONFIG_IR_NUVOTON=3Dm
> # CONFIG_IR_REDRAT3 is not set
> CONFIG_IR_SERIAL=3Dm
> CONFIG_IR_SERIAL_TRANSMITTER=3Dy
> # CONFIG_IR_STREAMZAP is not set
> # CONFIG_IR_TOY is not set
> # CONFIG_IR_TTUSBIR is not set
> CONFIG_IR_WINBOND_CIR=3Dm
> # CONFIG_RC_ATI_REMOTE is not set
> # CONFIG_RC_LOOPBACK is not set
> # CONFIG_RC_XBOX_DVD is not set
>=20
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
>=20
> CONFIG_MEDIA_SUPPORT=3Dm
> CONFIG_MEDIA_SUPPORT_FILTER=3Dy
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy
>=20
> #
> # Media device types
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
>=20
> #
> # Media drivers
> #
>=20
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
>=20
> #
> # Media drivers
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> # end of Media drivers
>=20
> #
> # Media ancillary drivers
> #
> # end of Media ancillary drivers
>=20
> #
> # Graphics support
> #
> CONFIG_APERTURE_HELPERS=3Dy
> CONFIG_VIDEO_CMDLINE=3Dy
> CONFIG_VIDEO_NOMODESET=3Dy
> # CONFIG_AGP is not set
> CONFIG_INTEL_GTT=3Dm
> CONFIG_VGA_SWITCHEROO=3Dy
> CONFIG_DRM=3Dm
> CONFIG_DRM_MIPI_DSI=3Dy
> CONFIG_DRM_KMS_HELPER=3Dm
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> # CONFIG_DRM_DEBUG_MODESET_LOCK is not set
> CONFIG_DRM_FBDEV_EMULATION=3Dy
> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> CONFIG_DRM_DISPLAY_HELPER=3Dm
> CONFIG_DRM_DISPLAY_DP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDCP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDMI_HELPER=3Dy
> CONFIG_DRM_DP_AUX_CHARDEV=3Dy
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=3Dm
> CONFIG_DRM_BUDDY=3Dm
> CONFIG_DRM_VRAM_HELPER=3Dm
> CONFIG_DRM_TTM_HELPER=3Dm
> CONFIG_DRM_GEM_SHMEM_HELPER=3Dm
>=20
> #
> # I2C encoder or helper chips
> #
> # CONFIG_DRM_I2C_CH7006 is not set
> # CONFIG_DRM_I2C_SIL164 is not set
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
>=20
> #
> # ARM devices
> #
> # end of ARM devices
>=20
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_I915=3Dm
> CONFIG_DRM_I915_FORCE_PROBE=3D""
> CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> CONFIG_DRM_I915_USERPTR=3Dy
> # CONFIG_DRM_I915_GVT_KVMGT is not set
>=20
> #
> # drm/i915 Debugging
> #
> # CONFIG_DRM_I915_WERROR is not set
> # CONFIG_DRM_I915_DEBUG is not set
> # CONFIG_DRM_I915_DEBUG_MMIO is not set
> # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> # CONFIG_DRM_I915_DEBUG_GUC is not set
> # CONFIG_DRM_I915_SELFTEST is not set
> # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
> # end of drm/i915 Debugging
>=20
> #
> # drm/i915 Profile Guided Optimisation
> #
> CONFIG_DRM_I915_REQUEST_TIMEOUT=3D20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=3D10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
> CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=3D7500
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000
> CONFIG_DRM_I915_STOP_TIMEOUT=3D100
> CONFIG_DRM_I915_TIMESLICE_DURATION=3D1
> # end of drm/i915 Profile Guided Optimisation
>=20
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_VMWGFX is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_UDL is not set
> CONFIG_DRM_AST=3Dm
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_QXL=3Dm
> CONFIG_DRM_VIRTIO_GPU=3Dm
> CONFIG_DRM_VIRTIO_GPU_KMS=3Dy
> CONFIG_DRM_PANEL=3Dy
>=20
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
> # CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
>=20
> CONFIG_DRM_BRIDGE=3Dy
> CONFIG_DRM_PANEL_BRIDGE=3Dy
>=20
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
>=20
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_BOCHS=3Dm
> CONFIG_DRM_CIRRUS_QEMU=3Dm
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_DRM_PANEL_MIPI_DBI is not set
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9163 is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_GUD is not set
> # CONFIG_DRM_SSD130X is not set
> # CONFIG_DRM_HYPERV is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy
>=20
> #
> # Frame buffer Devices
> #
> CONFIG_FB_NOTIFY=3Dy
> CONFIG_FB=3Dy
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_SYS_FILLRECT=3Dm
> CONFIG_FB_SYS_COPYAREA=3Dm
> CONFIG_FB_SYS_IMAGEBLIT=3Dm
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=3Dm
> CONFIG_FB_DEFERRED_IO=3Dy
> # CONFIG_FB_MODE_HELPERS is not set
> CONFIG_FB_TILEBLITTING=3Dy
>=20
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=3Dy
> CONFIG_FB_EFI=3Dy
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_HYPERV=3Dm
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
>=20
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=3Dm
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=3Dm
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_KTZ8866 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> CONFIG_BACKLIGHT_APPLE=3Dm
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_LP855X=3Dm
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
>=20
> CONFIG_HDMI=3Dy
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
>=20
> CONFIG_LOGO=3Dy
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=3Dy
> # end of Graphics support
>=20
> # CONFIG_DRM_ACCEL is not set
> # CONFIG_SOUND is not set
> CONFIG_HID_SUPPORT=3Dy
> CONFIG_HID=3Dy
> CONFIG_HID_BATTERY_STRENGTH=3Dy
> CONFIG_HIDRAW=3Dy
> CONFIG_UHID=3Dm
> CONFIG_HID_GENERIC=3Dy
>=20
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=3Dm
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=3Dm
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=3Dm
> # CONFIG_HID_APPLEIR is not set
> CONFIG_HID_ASUS=3Dm
> CONFIG_HID_AUREAL=3Dm
> CONFIG_HID_BELKIN=3Dm
> # CONFIG_HID_BETOP_FF is not set
> # CONFIG_HID_BIGBEN_FF is not set
> CONFIG_HID_CHERRY=3Dm
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_CMEDIA=3Dm
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> CONFIG_HID_CYPRESS=3Dm
> CONFIG_HID_DRAGONRISE=3Dm
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELAN is not set
> CONFIG_HID_ELECOM=3Dm
> # CONFIG_HID_ELO is not set
> # CONFIG_HID_EVISION is not set
> CONFIG_HID_EZKEY=3Dm
> # CONFIG_HID_FT260 is not set
> CONFIG_HID_GEMBIRD=3Dm
> CONFIG_HID_GFRM=3Dm
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_GT683R is not set
> CONFIG_HID_KEYTOUCH=3Dm
> CONFIG_HID_KYE=3Dm
> # CONFIG_HID_UCLOGIC is not set
> CONFIG_HID_WALTOP=3Dm
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_VRC2 is not set
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=3Dm
> CONFIG_HID_ICADE=3Dm
> CONFIG_HID_ITE=3Dm
> CONFIG_HID_JABRA=3Dm
> CONFIG_HID_TWINHAN=3Dm
> CONFIG_HID_KENSINGTON=3Dm
> CONFIG_HID_LCPOWER=3Dm
> CONFIG_HID_LED=3Dm
> CONFIG_HID_LENOVO=3Dm
> # CONFIG_HID_LETSKETCH is not set
> CONFIG_HID_LOGITECH=3Dm
> CONFIG_HID_LOGITECH_DJ=3Dm
> CONFIG_HID_LOGITECH_HIDPP=3Dm
> # CONFIG_LOGITECH_FF is not set
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> CONFIG_HID_MAGICMOUSE=3Dy
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_MEGAWORLD_FF is not set
> # CONFIG_HID_REDRAGON is not set
> CONFIG_HID_MICROSOFT=3Dm
> CONFIG_HID_MONTEREY=3Dm
> CONFIG_HID_MULTITOUCH=3Dm
> # CONFIG_HID_NINTENDO is not set
> CONFIG_HID_NTI=3Dm
> # CONFIG_HID_NTRIG is not set
> CONFIG_HID_ORTEK=3Dm
> CONFIG_HID_PANTHERLORD=3Dm
> # CONFIG_PANTHERLORD_FF is not set
> # CONFIG_HID_PENMOUNT is not set
> CONFIG_HID_PETALYNX=3Dm
> CONFIG_HID_PICOLCD=3Dm
> CONFIG_HID_PICOLCD_FB=3Dy
> CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> CONFIG_HID_PICOLCD_LCD=3Dy
> CONFIG_HID_PICOLCD_LEDS=3Dy
> CONFIG_HID_PICOLCD_CIR=3Dy
> CONFIG_HID_PLANTRONICS=3Dm
> # CONFIG_HID_PXRC is not set
> # CONFIG_HID_RAZER is not set
> CONFIG_HID_PRIMAX=3Dm
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> CONFIG_HID_SAITEK=3Dm
> CONFIG_HID_SAMSUNG=3Dm
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SIGMAMICRO is not set
> # CONFIG_HID_SONY is not set
> CONFIG_HID_SPEEDLINK=3Dm
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=3Dm
> CONFIG_HID_SUNPLUS=3Dm
> CONFIG_HID_RMI=3Dm
> CONFIG_HID_GREENASIA=3Dm
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_HYPERV_MOUSE=3Dm
> CONFIG_HID_SMARTJOYPLUS=3Dm
> # CONFIG_SMARTJOYPLUS_FF is not set
> CONFIG_HID_TIVO=3Dm
> CONFIG_HID_TOPSEED=3Dm
> # CONFIG_HID_TOPRE is not set
> CONFIG_HID_THINGM=3Dm
> CONFIG_HID_THRUSTMASTER=3Dm
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> # CONFIG_HID_WACOM is not set
> CONFIG_HID_WIIMOTE=3Dm
> CONFIG_HID_XINMO=3Dm
> CONFIG_HID_ZEROPLUS=3Dm
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=3Dm
> CONFIG_HID_SENSOR_HUB=3Dy
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dm
> CONFIG_HID_ALPS=3Dm
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
>=20
> #
> # HID-BPF support
> #
> # CONFIG_HID_BPF is not set
> # end of HID-BPF support
>=20
> #
> # USB HID support
> #
> CONFIG_USB_HID=3Dy
> # CONFIG_HID_PID is not set
> # CONFIG_USB_HIDDEV is not set
> # end of USB HID support
>=20
> CONFIG_I2C_HID=3Dm
> # CONFIG_I2C_HID_ACPI is not set
> # CONFIG_I2C_HID_OF is not set
>=20
> #
> # Intel ISH HID support
> #
> # CONFIG_INTEL_ISH_HID is not set
> # end of Intel ISH HID support
>=20
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
>=20
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_SUPPORT=3Dy
> CONFIG_USB_COMMON=3Dy
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB=3Dy
> CONFIG_USB_PCI=3Dy
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=3Dy
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dy
> CONFIG_USB_AUTOSUSPEND_DELAY=3D2
> CONFIG_USB_MON=3Dy
>=20
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=3Dy
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PCI=3Dy
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> CONFIG_USB_EHCI_PCI=3Dy
> # CONFIG_USB_EHCI_FSL is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_PCI=3Dy
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=3Dy
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
>=20
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
>=20
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
>=20
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_REALTEK is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_STORAGE_ONETOUCH is not set
> # CONFIG_USB_STORAGE_KARMA is not set
> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
> # CONFIG_USB_UAS is not set
>=20
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
>=20
> #
> # USB dual-mode controller drivers
> #
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
>=20
> #
> # USB port drivers
> #
> # CONFIG_USB_SERIAL is not set
>=20
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_USS720 is not set
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
>=20
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
>=20
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=3Dy
> # CONFIG_TYPEC_TCPM is not set
> CONFIG_TYPEC_UCSI=3Dy
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=3Dy
> # CONFIG_UCSI_STM32G0 is not set
> # CONFIG_TYPEC_TPS6598X is not set
> # CONFIG_TYPEC_RT1719 is not set
> # CONFIG_TYPEC_STUSB160X is not set
> # CONFIG_TYPEC_WUSB3801 is not set
>=20
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> # CONFIG_TYPEC_MUX_FSA4480 is not set
> # CONFIG_TYPEC_MUX_GPIO_SBU is not set
> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
>=20
> #
> # USB Type-C Alternate Mode drivers
> #
> # CONFIG_TYPEC_DP_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
>=20
> # CONFIG_USB_ROLE_SWITCH is not set
> CONFIG_MMC=3Dm
> CONFIG_MMC_BLOCK=3Dm
> CONFIG_MMC_BLOCK_MINORS=3D8
> CONFIG_SDIO_UART=3Dm
> # CONFIG_MMC_TEST is not set
>=20
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=3Dm
> CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
> CONFIG_MMC_SDHCI_PCI=3Dm
> CONFIG_MMC_RICOH_MMC=3Dy
> CONFIG_MMC_SDHCI_ACPI=3Dm
> CONFIG_MMC_SDHCI_PLTFM=3Dm
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> # CONFIG_MMC_SPI is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_VUB300 is not set
> # CONFIG_MMC_USHC is not set
> # CONFIG_MMC_USDHI6ROL0 is not set
> CONFIG_MMC_CQHCI=3Dm
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_MMC_SDHCI_XENON is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
>=20
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> CONFIG_LEDS_LM3530=3Dm
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=3Dm
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP50XX is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2606MVV is not set
> # CONFIG_LEDS_BD2802 is not set
> CONFIG_LEDS_INTEL_SS4200=3Dm
> CONFIG_LEDS_LT3593=3Dm
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> # CONFIG_LEDS_IS31FL319X is not set
>=20
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T=
HINGM)
> #
> CONFIG_LEDS_BLINKM=3Dm
> CONFIG_LEDS_MLXCPLD=3Dm
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
>=20
> #
> # Flash and Torch LED drivers
> #
>=20
> #
> # RGB LED drivers
> #
>=20
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=3Dy
> CONFIG_LEDS_TRIGGER_TIMER=3Dm
> CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
> # CONFIG_LEDS_TRIGGER_DISK is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
> CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
>=20
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
> CONFIG_LEDS_TRIGGER_CAMERA=3Dm
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> # CONFIG_LEDS_TRIGGER_AUDIO is not set
> # CONFIG_LEDS_TRIGGER_TTY is not set
>=20
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> CONFIG_EDAC_SUPPORT=3Dy
> CONFIG_EDAC=3Dy
> CONFIG_EDAC_LEGACY_SYSFS=3Dy
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_GHES=3Dy
> CONFIG_EDAC_E752X=3Dm
> CONFIG_EDAC_I82975X=3Dm
> CONFIG_EDAC_I3000=3Dm
> CONFIG_EDAC_I3200=3Dm
> CONFIG_EDAC_IE31200=3Dm
> CONFIG_EDAC_X38=3Dm
> CONFIG_EDAC_I5400=3Dm
> CONFIG_EDAC_I7CORE=3Dm
> CONFIG_EDAC_I5100=3Dm
> CONFIG_EDAC_I7300=3Dm
> CONFIG_EDAC_SBRIDGE=3Dm
> CONFIG_EDAC_SKX=3Dm
> # CONFIG_EDAC_I10NM is not set
> CONFIG_EDAC_PND2=3Dm
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_MC146818_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_HCTOSYS=3Dy
> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=3Dy
>=20
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
>=20
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=3Dm
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=3Dm
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=3Dm
> CONFIG_RTC_DRV_MAX6900=3Dm
> CONFIG_RTC_DRV_RS5C372=3Dm
> CONFIG_RTC_DRV_ISL1208=3Dm
> CONFIG_RTC_DRV_ISL12022=3Dm
> CONFIG_RTC_DRV_X1205=3Dm
> CONFIG_RTC_DRV_PCF8523=3Dm
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=3Dm
> CONFIG_RTC_DRV_PCF8583=3Dm
> CONFIG_RTC_DRV_M41T80=3Dm
> CONFIG_RTC_DRV_M41T80_WDT=3Dy
> CONFIG_RTC_DRV_BQ32K=3Dm
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=3Dm
> # CONFIG_RTC_DRV_RX8010 is not set
> CONFIG_RTC_DRV_RX8581=3Dm
> CONFIG_RTC_DRV_RX8025=3Dm
> CONFIG_RTC_DRV_EM3027=3Dm
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
>=20
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> CONFIG_RTC_DRV_RX4581=3Dm
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=3Dy
>=20
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=3Dm
> CONFIG_RTC_DRV_DS3232_HWMON=3Dy
> # CONFIG_RTC_DRV_PCF2127 is not set
> CONFIG_RTC_DRV_RV3029C2=3Dm
> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> # CONFIG_RTC_DRV_RX6110 is not set
>=20
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=3Dy
> CONFIG_RTC_DRV_DS1286=3Dm
> CONFIG_RTC_DRV_DS1511=3Dm
> CONFIG_RTC_DRV_DS1553=3Dm
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=3Dm
> CONFIG_RTC_DRV_DS2404=3Dm
> CONFIG_RTC_DRV_STK17TA8=3Dm
> # CONFIG_RTC_DRV_M48T86 is not set
> CONFIG_RTC_DRV_M48T35=3Dm
> CONFIG_RTC_DRV_M48T59=3Dm
> CONFIG_RTC_DRV_MSM6242=3Dm
> CONFIG_RTC_DRV_BQ4802=3Dm
> CONFIG_RTC_DRV_RP5C01=3Dm
>=20
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
>=20
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=3Dy
> # CONFIG_DMADEVICES_DEBUG is not set
>=20
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=3Dy
> CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> CONFIG_DMA_ACPI=3Dy
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=3Dm
> # CONFIG_INTEL_IDXD is not set
> # CONFIG_INTEL_IDXD_COMPAT is not set
> CONFIG_INTEL_IOATDMA=3Dm
> # CONFIG_PLX_DMA is not set
> # CONFIG_XILINX_XDMA is not set
> # CONFIG_AMD_PTDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=3Dy
> CONFIG_DW_DMAC=3Dm
> CONFIG_DW_DMAC_PCI=3Dy
> # CONFIG_DW_EDMA is not set
> CONFIG_HSU_DMA=3Dy
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
>=20
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=3Dy
> CONFIG_DMATEST=3Dm
> CONFIG_DMA_ENGINE_RAID=3Dy
>=20
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=3Dy
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # end of DMABUF options
>=20
> CONFIG_DCA=3Dm
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> # CONFIG_UIO is not set
> CONFIG_VFIO=3Dm
> CONFIG_VFIO_CONTAINER=3Dy
> CONFIG_VFIO_IOMMU_TYPE1=3Dm
> CONFIG_VFIO_NOIOMMU=3Dy
> CONFIG_VFIO_VIRQFD=3Dy
> CONFIG_VFIO_PCI_CORE=3Dm
> CONFIG_VFIO_PCI_MMAP=3Dy
> CONFIG_VFIO_PCI_INTX=3Dy
> CONFIG_VFIO_PCI=3Dm
> # CONFIG_VFIO_PCI_VGA is not set
> # CONFIG_VFIO_PCI_IGD is not set
> CONFIG_IRQ_BYPASS_MANAGER=3Dm
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_ANCHOR=3Dy
> CONFIG_VIRTIO=3Dy
> CONFIG_VIRTIO_PCI_LIB=3Dy
> CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy
> CONFIG_VIRTIO_MENU=3Dy
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=3Dm
> # CONFIG_VIRTIO_MEM is not set
> CONFIG_VIRTIO_INPUT=3Dm
> # CONFIG_VIRTIO_MMIO is not set
> CONFIG_VIRTIO_DMA_SHARED_BUFFER=3Dm
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=3Dm
> CONFIG_VHOST_TASK=3Dy
> CONFIG_VHOST=3Dm
> CONFIG_VHOST_MENU=3Dy
> CONFIG_VHOST_NET=3Dm
> CONFIG_VHOST_VSOCK=3Dm
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>=20
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=3Dy
> # CONFIG_HYPERV_VTL_MODE is not set
> CONFIG_HYPERV_TIMER=3Dy
> CONFIG_HYPERV_UTILS=3Dm
> CONFIG_HYPERV_BALLOON=3Dm
> # end of Microsoft Hyper-V guest support
>=20
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_SURFACE_PLATFORMS=3Dy
> # CONFIG_SURFACE3_WMI is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_X86_PLATFORM_DEVICES=3Dy
> CONFIG_ACPI_WMI=3Dm
> CONFIG_WMI_BMOF=3Dm
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_UV_SYSFS is not set
> CONFIG_MXM_WMI=3Dm
> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> # CONFIG_YOGABOOK_WMI is not set
> CONFIG_ACERHDF=3Dm
> # CONFIG_ACER_WIRELESS is not set
> CONFIG_ACER_WMI=3Dm
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=3Dm
> CONFIG_ASUS_LAPTOP=3Dm
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_ASUS_WMI is not set
> # CONFIG_ASUS_TF103C_DOCK is not set
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_EEEPC_LAPTOP=3Dm
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_AMILO_RFKILL=3Dm
> CONFIG_FUJITSU_LAPTOP=3Dm
> CONFIG_FUJITSU_TABLET=3Dm
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_X86_PLATFORM_DRIVERS_HP is not set
> # CONFIG_WIRELESS_HOTKEY is not set
> # CONFIG_IBM_RTL is not set
> CONFIG_IDEAPAD_LAPTOP=3Dm
> # CONFIG_LENOVO_YMC is not set
> CONFIG_SENSORS_HDAPS=3Dm
> # CONFIG_THINKPAD_ACPI is not set
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_IFS is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> CONFIG_INTEL_PMC_CORE=3Dm
>=20
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
>=20
> CONFIG_INTEL_WMI=3Dy
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> CONFIG_INTEL_WMI_THUNDERBOLT=3Dm
>=20
> #
> # Intel Uncore Frequency Control
> #
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> # end of Intel Uncore Frequency Control
>=20
> CONFIG_INTEL_HID_EVENT=3Dm
> CONFIG_INTEL_VBTN=3Dm
> # CONFIG_INTEL_INT0002_VGPIO is not set
> CONFIG_INTEL_OAKTRAIL=3Dm
> # CONFIG_INTEL_PUNIT_IPC is not set
> CONFIG_INTEL_RST=3Dm
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_TURBO_MAX_3=3Dy
> # CONFIG_INTEL_VSEC is not set
> # CONFIG_MSI_EC is not set
> CONFIG_MSI_LAPTOP=3Dm
> CONFIG_MSI_WMI=3Dm
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> CONFIG_SAMSUNG_LAPTOP=3Dm
> CONFIG_SAMSUNG_Q10=3Dm
> CONFIG_TOSHIBA_BT_RFKILL=3Dm
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> CONFIG_ACPI_CMPC=3Dm
> CONFIG_COMPAL_LAPTOP=3Dm
> # CONFIG_LG_LAPTOP is not set
> CONFIG_PANASONIC_LAPTOP=3Dm
> CONFIG_SONY_LAPTOP=3Dm
> CONFIG_SONYPI_COMPAT=3Dy
> # CONFIG_SYSTEM76_ACPI is not set
> CONFIG_TOPSTAR_LAPTOP=3Dm
> # CONFIG_SERIAL_MULTI_INSTANTIATE is not set
> CONFIG_MLX_PLATFORM=3Dm
> CONFIG_INTEL_IPS=3Dm
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> # CONFIG_WINMATE_FM07_KEYS is not set
> CONFIG_P2SB=3Dy
> CONFIG_HAVE_CLK=3Dy
> CONFIG_HAVE_CLK_PREPARE=3Dy
> CONFIG_COMMON_CLK=3Dy
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> # CONFIG_HWSPINLOCK is not set
>=20
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=3Dy
> CONFIG_I8253_LOCK=3Dy
> CONFIG_CLKBLD_I8253=3Dy
> # end of Clock Source drivers
>=20
> CONFIG_MAILBOX=3Dy
> CONFIG_PCC=3Dy
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=3Dy
> CONFIG_IOMMU_API=3Dy
> CONFIG_IOMMU_SUPPORT=3Dy
>=20
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
>=20
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=3Dy
> # CONFIG_AMD_IOMMU is not set
> CONFIG_DMAR_TABLE=3Dy
> CONFIG_INTEL_IOMMU=3Dy
> # CONFIG_INTEL_IOMMU_SVM is not set
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=3Dy
> CONFIG_INTEL_IOMMU_PERF_EVENTS=3Dy
> # CONFIG_IOMMUFD is not set
> CONFIG_IRQ_REMAP=3Dy
> CONFIG_HYPERV_IOMMU=3Dy
> # CONFIG_VIRTIO_IOMMU is not set
>=20
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
>=20
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
>=20
> # CONFIG_SOUNDWIRE is not set
>=20
> #
> # SOC (System On Chip) specific Drivers
> #
>=20
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
>=20
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
>=20
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
>=20
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
>=20
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
>=20
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
>=20
> # CONFIG_WPCM450_SOC is not set
>=20
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
>=20
> # CONFIG_SOC_TI is not set
>=20
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
>=20
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> CONFIG_NTB=3Dm
> # CONFIG_NTB_MSI is not set
> # CONFIG_NTB_AMD is not set
> # CONFIG_NTB_IDT is not set
> # CONFIG_NTB_INTEL is not set
> # CONFIG_NTB_EPF is not set
> # CONFIG_NTB_SWITCHTEC is not set
> # CONFIG_NTB_PINGPONG is not set
> # CONFIG_NTB_TOOL is not set
> # CONFIG_NTB_PERF is not set
> # CONFIG_NTB_TRANSPORT is not set
> CONFIG_PWM=3Dy
> CONFIG_PWM_SYSFS=3Dy
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_CLK is not set
> # CONFIG_PWM_DWC is not set
> CONFIG_PWM_LPSS=3Dm
> CONFIG_PWM_LPSS_PCI=3Dm
> CONFIG_PWM_LPSS_PLATFORM=3Dm
> # CONFIG_PWM_PCA9685 is not set
>=20
> #
> # IRQ chip support
> #
> # end of IRQ chip support
>=20
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
>=20
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
>=20
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
>=20
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
>=20
> CONFIG_POWERCAP=3Dy
> CONFIG_INTEL_RAPL_CORE=3Dm
> CONFIG_INTEL_RAPL=3Dm
> CONFIG_IDLE_INJECT=3Dy
> # CONFIG_MCB is not set
>=20
> #
> # Performance monitor support
> #
> # end of Performance monitor support
>=20
> CONFIG_RAS=3Dy
> # CONFIG_RAS_CEC is not set
> # CONFIG_USB4 is not set
>=20
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
>=20
> CONFIG_LIBNVDIMM=3Dm
> CONFIG_BLK_DEV_PMEM=3Dm
> CONFIG_ND_CLAIM=3Dy
> CONFIG_ND_BTT=3Dm
> CONFIG_BTT=3Dy
> CONFIG_ND_PFN=3Dm
> CONFIG_NVDIMM_PFN=3Dy
> CONFIG_NVDIMM_DAX=3Dy
> CONFIG_NVDIMM_KEYS=3Dy
> # CONFIG_NVDIMM_SECURITY_TEST is not set
> CONFIG_DAX=3Dy
> CONFIG_DEV_DAX=3Dm
> CONFIG_DEV_DAX_PMEM=3Dm
> CONFIG_DEV_DAX_HMEM=3Dm
> CONFIG_DEV_DAX_HMEM_DEVICES=3Dy
> CONFIG_DEV_DAX_KMEM=3Dm
> CONFIG_NVMEM=3Dy
> CONFIG_NVMEM_SYSFS=3Dy
>=20
> #
> # Layout Types
> #
> # CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
> # CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
> # end of Layout Types
>=20
> # CONFIG_NVMEM_RMEM is not set
>=20
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
>=20
> # CONFIG_FPGA is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> # end of Device Drivers
>=20
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=3Dy
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=3Dy
> CONFIG_LEGACY_DIRECT_IO=3Dy
> CONFIG_EXT2_FS=3Dm
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=3Dy
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=3Dm
> CONFIG_XFS_SUPPORT_V4=3Dy
> CONFIG_XFS_SUPPORT_ASCII_CI=3Dy
> CONFIG_XFS_QUOTA=3Dy
> CONFIG_XFS_POSIX_ACL=3Dy
> CONFIG_XFS_RT=3Dy
> CONFIG_XFS_DRAIN_INTENTS=3Dy
> CONFIG_XFS_ONLINE_SCRUB=3Dy
> # CONFIG_XFS_ONLINE_REPAIR is not set
> CONFIG_XFS_WARN=3Dy
> # CONFIG_XFS_DEBUG is not set
> # CONFIG_GFS2_FS is not set
> CONFIG_OCFS2_FS=3Dm
> CONFIG_OCFS2_FS_O2CB=3Dm
> CONFIG_OCFS2_FS_STATS=3Dy
> # CONFIG_OCFS2_DEBUG_MASKLOG is not set
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=3Dm
> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> # CONFIG_NILFS2_FS is not set
> CONFIG_F2FS_FS=3Dm
> CONFIG_F2FS_STAT_FS=3Dy
> CONFIG_F2FS_FS_XATTR=3Dy
> CONFIG_F2FS_FS_POSIX_ACL=3Dy
> # CONFIG_F2FS_FS_SECURITY is not set
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_F2FS_FS_COMPRESSION is not set
> CONFIG_F2FS_IOSTAT=3Dy
> # CONFIG_F2FS_UNFAIR_RWSEM is not set
> CONFIG_FS_DAX=3Dy
> CONFIG_FS_DAX_PMD=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> CONFIG_FILE_LOCKING=3Dy
> CONFIG_FS_ENCRYPTION=3Dy
> CONFIG_FS_ENCRYPTION_ALGS=3Dy
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=3Dy
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=3Dy
> CONFIG_QUOTACTL=3Dy
> CONFIG_AUTOFS4_FS=3Dy
> CONFIG_AUTOFS_FS=3Dy
> CONFIG_FUSE_FS=3Dm
> CONFIG_CUSE=3Dm
> # CONFIG_VIRTIO_FS is not set
> CONFIG_OVERLAY_FS=3Dm
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
>=20
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=3Dm
> # CONFIG_NETFS_STATS is not set
> # CONFIG_FSCACHE is not set
> # end of Caches
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> CONFIG_UDF_FS=3Dm
> # end of CD-ROM/DVD Filesystems
>=20
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dm
> CONFIG_MSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dm
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_VMCORE=3Dy
> CONFIG_PROC_VMCORE_DEVICE_DUMP=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_PROC_CHILDREN=3Dy
> CONFIG_PROC_PID_ARCH_STATUS=3Dy
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_HUGETLBFS=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy
> # CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_MEMFD_CREATE=3Dy
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> CONFIG_EFIVAR_FS=3Dy
> # end of Pseudo filesystems
>=20
> CONFIG_MISC_FILESYSTEMS=3Dy
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=3Dm
> CONFIG_CRAMFS_BLOCKDEV=3Dy
> CONFIG_SQUASHFS=3Dm
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=3Dy
> CONFIG_SQUASHFS_DECOMP_SINGLE=3Dy
> # CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
> CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=3Dy
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=3Dy
> CONFIG_SQUASHFS_ZLIB=3Dy
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=3Dy
> CONFIG_SQUASHFS_XZ=3Dy
> # CONFIG_SQUASHFS_ZSTD is not set
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=3Dy
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=3Dy
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=3Dy
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=3Dy
> CONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_PSTORE_RAM=3Dm
> # CONFIG_PSTORE_BLK is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dy
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V3_ACL=3Dy
> CONFIG_NFS_V4=3Dm
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=3Dy
> CONFIG_NFS_V4_2=3Dy
> CONFIG_PNFS_FILE_LAYOUT=3Dm
> CONFIG_PNFS_BLOCK=3Dm
> CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> CONFIG_ROOT_NFS=3Dy
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=3Dy
> CONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=3Dm
> # CONFIG_NFSD_V2 is not set
> CONFIG_NFSD_V3_ACL=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_PNFS=3Dy
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> CONFIG_NFSD_SCSILAYOUT=3Dy
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> # CONFIG_NFSD_V4_2_INTER_SSC is not set
> CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
> CONFIG_GRACE_PERIOD=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_ACL_SUPPORT=3Dy
> CONFIG_NFS_COMMON=3Dy
> CONFIG_NFS_V4_2_SSC_HELPER=3Dy
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dm
> CONFIG_SUNRPC_BACKCHANNEL=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dm
> CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=3Dy
> # CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=3Dy
> # CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
> # CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=3Dm
> CONFIG_CIFS_STATS2=3Dy
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
> CONFIG_CIFS_UPCALL=3Dy
> CONFIG_CIFS_XATTR=3Dy
> CONFIG_CIFS_POSIX=3Dy
> # CONFIG_CIFS_DEBUG is not set
> CONFIG_CIFS_DFS_UPCALL=3Dy
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS=3Dm
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_CODEPAGE_737=3Dm
> CONFIG_NLS_CODEPAGE_775=3Dm
> CONFIG_NLS_CODEPAGE_850=3Dm
> CONFIG_NLS_CODEPAGE_852=3Dm
> CONFIG_NLS_CODEPAGE_855=3Dm
> CONFIG_NLS_CODEPAGE_857=3Dm
> CONFIG_NLS_CODEPAGE_860=3Dm
> CONFIG_NLS_CODEPAGE_861=3Dm
> CONFIG_NLS_CODEPAGE_862=3Dm
> CONFIG_NLS_CODEPAGE_863=3Dm
> CONFIG_NLS_CODEPAGE_864=3Dm
> CONFIG_NLS_CODEPAGE_865=3Dm
> CONFIG_NLS_CODEPAGE_866=3Dm
> CONFIG_NLS_CODEPAGE_869=3Dm
> CONFIG_NLS_CODEPAGE_936=3Dm
> CONFIG_NLS_CODEPAGE_950=3Dm
> CONFIG_NLS_CODEPAGE_932=3Dm
> CONFIG_NLS_CODEPAGE_949=3Dm
> CONFIG_NLS_CODEPAGE_874=3Dm
> CONFIG_NLS_ISO8859_8=3Dm
> CONFIG_NLS_CODEPAGE_1250=3Dm
> CONFIG_NLS_CODEPAGE_1251=3Dm
> CONFIG_NLS_ASCII=3Dy
> CONFIG_NLS_ISO8859_1=3Dm
> CONFIG_NLS_ISO8859_2=3Dm
> CONFIG_NLS_ISO8859_3=3Dm
> CONFIG_NLS_ISO8859_4=3Dm
> CONFIG_NLS_ISO8859_5=3Dm
> CONFIG_NLS_ISO8859_6=3Dm
> CONFIG_NLS_ISO8859_7=3Dm
> CONFIG_NLS_ISO8859_9=3Dm
> CONFIG_NLS_ISO8859_13=3Dm
> CONFIG_NLS_ISO8859_14=3Dm
> CONFIG_NLS_ISO8859_15=3Dm
> CONFIG_NLS_KOI8_R=3Dm
> CONFIG_NLS_KOI8_U=3Dm
> CONFIG_NLS_MAC_ROMAN=3Dm
> CONFIG_NLS_MAC_CELTIC=3Dm
> CONFIG_NLS_MAC_CENTEURO=3Dm
> CONFIG_NLS_MAC_CROATIAN=3Dm
> CONFIG_NLS_MAC_CYRILLIC=3Dm
> CONFIG_NLS_MAC_GAELIC=3Dm
> CONFIG_NLS_MAC_GREEK=3Dm
> CONFIG_NLS_MAC_ICELAND=3Dm
> CONFIG_NLS_MAC_INUIT=3Dm
> CONFIG_NLS_MAC_ROMANIAN=3Dm
> CONFIG_NLS_MAC_TURKISH=3Dm
> CONFIG_NLS_UTF8=3Dm
> # CONFIG_DLM is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=3Dy
> # end of File systems
>=20
> #
> # Security options
> #
> CONFIG_KEYS=3Dy
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=3Dy
> CONFIG_TRUSTED_KEYS=3Dy
> CONFIG_TRUSTED_KEYS_TPM=3Dy
> CONFIG_ENCRYPTED_KEYS=3Dy
> # CONFIG_USER_DECRYPTED_DATA is not set
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITYFS=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_SECURITY_NETWORK_XFRM=3Dy
> CONFIG_SECURITY_PATH=3Dy
> CONFIG_INTEL_TXT=3Dy
> CONFIG_LSM_MMAP_MIN_ADDR=3D65535
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> CONFIG_HARDENED_USERCOPY=3Dy
> CONFIG_FORTIFY_SOURCE=3Dy
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=3Dy
> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> CONFIG_SECURITY_APPARMOR=3Dy
> # CONFIG_SECURITY_APPARMOR_DEBUG is not set
> CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=3Dy
> CONFIG_SECURITY_APPARMOR_HASH=3Dy
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
> CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=3Dy
> CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=3Dy
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=3Dy
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=3Dy
> CONFIG_INTEGRITY_SIGNATURE=3Dy
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
> CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> CONFIG_INTEGRITY_AUDIT=3Dy
> # CONFIG_IMA is not set
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> # CONFIG_EVM is not set
> CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
> # CONFIG_DEFAULT_SECURITY_APPARMOR is not set
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomo=
yo,apparmor,bpf"
>=20
> #
> # Kernel hardening options
> #
>=20
> #
> # Memory initialization
> #
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=3Dy
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=3Dy
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=3Dy
> # CONFIG_INIT_STACK_NONE is not set
> # CONFIG_INIT_STACK_ALL_PATTERN is not set
> CONFIG_INIT_STACK_ALL_ZERO=3Dy
> # CONFIG_GCC_PLUGIN_STACKLEAK is not set
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy
> # CONFIG_ZERO_CALL_USED_REGS is not set
> # end of Memory initialization
>=20
> CONFIG_RANDSTRUCT_NONE=3Dy
> # CONFIG_RANDSTRUCT_FULL is not set
> # CONFIG_RANDSTRUCT_PERFORMANCE is not set
> # end of Kernel hardening options
> # end of Security options
>=20
> CONFIG_XOR_BLOCKS=3Dm
> CONFIG_ASYNC_CORE=3Dm
> CONFIG_ASYNC_MEMCPY=3Dm
> CONFIG_ASYNC_XOR=3Dm
> CONFIG_ASYNC_PQ=3Dm
> CONFIG_ASYNC_RAID6_RECOV=3Dm
> CONFIG_CRYPTO=3Dy
>=20
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dy
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_SKCIPHER=3Dy
> CONFIG_CRYPTO_SKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> CONFIG_CRYPTO_AKCIPHER2=3Dy
> CONFIG_CRYPTO_AKCIPHER=3Dy
> CONFIG_CRYPTO_KPP2=3Dy
> CONFIG_CRYPTO_KPP=3Dm
> CONFIG_CRYPTO_ACOMP2=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_USER=3Dm
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> CONFIG_CRYPTO_NULL=3Dy
> CONFIG_CRYPTO_NULL2=3Dy
> CONFIG_CRYPTO_PCRYPT=3Dm
> CONFIG_CRYPTO_CRYPTD=3Dy
> CONFIG_CRYPTO_AUTHENC=3Dm
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_SIMD=3Dy
> # end of Crypto core or helper
>=20
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=3Dy
> CONFIG_CRYPTO_DH=3Dm
> # CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
> CONFIG_CRYPTO_ECC=3Dm
> CONFIG_CRYPTO_ECDH=3Dm
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # end of Public-key cryptography
>=20
> #
> # Block ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_ANUBIS=3Dm
> # CONFIG_CRYPTO_ARIA is not set
> CONFIG_CRYPTO_BLOWFISH=3Dm
> CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
> CONFIG_CRYPTO_CAMELLIA=3Dm
> CONFIG_CRYPTO_CAST_COMMON=3Dm
> CONFIG_CRYPTO_CAST5=3Dm
> CONFIG_CRYPTO_CAST6=3Dm
> CONFIG_CRYPTO_DES=3Dm
> CONFIG_CRYPTO_FCRYPT=3Dm
> CONFIG_CRYPTO_KHAZAD=3Dm
> CONFIG_CRYPTO_SEED=3Dm
> CONFIG_CRYPTO_SERPENT=3Dm
> CONFIG_CRYPTO_SM4=3Dm
> CONFIG_CRYPTO_SM4_GENERIC=3Dm
> CONFIG_CRYPTO_TEA=3Dm
> CONFIG_CRYPTO_TWOFISH=3Dm
> CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
> # end of Block ciphers
>=20
> #
> # Length-preserving ciphers and modes
> #
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_ARC4=3Dm
> CONFIG_CRYPTO_CHACHA20=3Dm
> CONFIG_CRYPTO_CBC=3Dy
> CONFIG_CRYPTO_CFB=3Dy
> CONFIG_CRYPTO_CTR=3Dy
> CONFIG_CRYPTO_CTS=3Dm
> CONFIG_CRYPTO_ECB=3Dy
> # CONFIG_CRYPTO_HCTR2 is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
> CONFIG_CRYPTO_LRW=3Dm
> CONFIG_CRYPTO_OFB=3Dm
> CONFIG_CRYPTO_PCBC=3Dm
> CONFIG_CRYPTO_XTS=3Dm
> # end of Length-preserving ciphers and modes
>=20
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_CCM=3Dm
> CONFIG_CRYPTO_GCM=3Dy
> CONFIG_CRYPTO_SEQIV=3Dy
> CONFIG_CRYPTO_ECHAINIV=3Dm
> CONFIG_CRYPTO_ESSIV=3Dm
> # end of AEAD (authenticated encryption with associated data) ciphers
>=20
> #
> # Hashes, digests, and MACs
> #
> CONFIG_CRYPTO_BLAKE2B=3Dm
> CONFIG_CRYPTO_CMAC=3Dm
> CONFIG_CRYPTO_GHASH=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> # CONFIG_CRYPTO_POLY1305 is not set
> CONFIG_CRYPTO_RMD160=3Dm
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_SHA512=3Dy
> CONFIG_CRYPTO_SHA3=3Dm
> # CONFIG_CRYPTO_SM3_GENERIC is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_VMAC=3Dm
> CONFIG_CRYPTO_WP512=3Dm
> CONFIG_CRYPTO_XCBC=3Dm
> CONFIG_CRYPTO_XXHASH=3Dm
> # end of Hashes, digests, and MACs
>=20
> #
> # CRCs (cyclic redundancy checks)
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> CONFIG_CRYPTO_CRC32=3Dm
> CONFIG_CRYPTO_CRCT10DIF=3Dy
> CONFIG_CRYPTO_CRC64_ROCKSOFT=3Dm
> # end of CRCs (cyclic redundancy checks)
>=20
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_LZO=3Dy
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> # end of Compression
>=20
> #
> # Random number generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=3Dm
> CONFIG_CRYPTO_DRBG_MENU=3Dy
> CONFIG_CRYPTO_DRBG_HMAC=3Dy
> CONFIG_CRYPTO_DRBG_HASH=3Dy
> CONFIG_CRYPTO_DRBG_CTR=3Dy
> CONFIG_CRYPTO_DRBG=3Dy
> CONFIG_CRYPTO_JITTERENTROPY=3Dy
> # end of Random number generation
>=20
> #
> # Userspace interface
> #
> CONFIG_CRYPTO_USER_API=3Dy
> # CONFIG_CRYPTO_USER_API_HASH is not set
> CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
> CONFIG_CRYPTO_USER_API_RNG=3Dy
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=3Dy
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=3Dy
> # CONFIG_CRYPTO_STATS is not set
> # end of Userspace interface
>=20
> CONFIG_CRYPTO_HASH_INFO=3Dy
>=20
> #
> # Accelerated Cryptographic Algorithms for CPU (x86)
> #
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> CONFIG_CRYPTO_AES_NI_INTEL=3Dy
> CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
> CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm
> # CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
> CONFIG_CRYPTO_CHACHA20_X86_64=3Dm
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> # CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> CONFIG_CRYPTO_SHA1_SSSE3=3Dy
> CONFIG_CRYPTO_SHA256_SSSE3=3Dy
> CONFIG_CRYPTO_SHA512_SSSE3=3Dm
> # CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm
> CONFIG_CRYPTO_CRC32C_INTEL=3Dm
> CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
> # end of Accelerated Cryptographic Algorithms for CPU (x86)
>=20
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy
> # CONFIG_FIPS_SIGNATURE_SELFTEST is not set
>=20
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=3Dy
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
> # CONFIG_SYSTEM_REVOCATION_LIST is not set
> # CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
> # end of Certificates for signature checking
>=20
> CONFIG_BINARY_PRINTF=3Dy
>=20
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=3Dm
> CONFIG_RAID6_PQ_BENCHMARK=3Dy
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_STRNLEN_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> CONFIG_CORDIC=3Dm
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=3Dy
> CONFIG_GENERIC_PCI_IOMAP=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
>=20
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_UTILS=3Dy
> CONFIG_CRYPTO_LIB_AES=3Dy
> CONFIG_CRYPTO_LIB_ARC4=3Dm
> CONFIG_CRYPTO_LIB_GF128MUL=3Dy
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=3Dm
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=3Dm
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA1=3Dy
> CONFIG_CRYPTO_LIB_SHA256=3Dy
> # end of Crypto library routines
>=20
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC_T10DIF=3Dy
> CONFIG_CRC64_ROCKSOFT=3Dm
> CONFIG_CRC_ITU_T=3Dm
> CONFIG_CRC32=3Dy
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=3Dy
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=3Dm
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=3Dm
> CONFIG_LIBCRC32C=3Dm
> CONFIG_CRC8=3Dm
> CONFIG_XXHASH=3Dy
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_LZ4_DECOMPRESS=3Dy
> CONFIG_ZSTD_COMMON=3Dy
> CONFIG_ZSTD_COMPRESS=3Dy
> CONFIG_ZSTD_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_IA64=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=3Dy
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_DECOMPRESS_LZ4=3Dy
> CONFIG_DECOMPRESS_ZSTD=3Dy
> CONFIG_GENERIC_ALLOCATOR=3Dy
> CONFIG_REED_SOLOMON=3Dm
> CONFIG_REED_SOLOMON_ENC8=3Dy
> CONFIG_REED_SOLOMON_DEC8=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dm
> CONFIG_TEXTSEARCH_BM=3Dm
> CONFIG_TEXTSEARCH_FSM=3Dm
> CONFIG_INTERVAL_TREE=3Dy
> CONFIG_XARRAY_MULTI=3Dy
> CONFIG_ASSOCIATIVE_ARRAY=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT=3Dy
> CONFIG_HAS_IOPORT_MAP=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_DMA_OPS=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> CONFIG_SWIOTLB=3Dy
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=3Dy
> CONFIG_CHECK_SIGNATURE=3Dy
> CONFIG_CPUMASK_OFFSTACK=3Dy
> # CONFIG_FORCE_NR_CPUS is not set
> CONFIG_CPU_RMAP=3Dy
> CONFIG_DQL=3Dy
> CONFIG_GLOB=3Dy
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=3Dy
> CONFIG_CLZ_TAB=3Dy
> CONFIG_IRQ_POLL=3Dy
> CONFIG_MPILIB=3Dy
> CONFIG_SIGNATURE=3Dy
> CONFIG_OID_REGISTRY=3Dy
> CONFIG_UCS2_STRING=3Dy
> CONFIG_HAVE_GENERIC_VDSO=3Dy
> CONFIG_GENERIC_GETTIMEOFDAY=3Dy
> CONFIG_GENERIC_VDSO_TIME_NS=3Dy
> CONFIG_FONT_SUPPORT=3Dy
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
> CONFIG_SG_POOL=3Dy
> CONFIG_ARCH_HAS_PMEM_API=3Dy
> CONFIG_MEMREGION=3Dy
> CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=3Dy
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> CONFIG_ARCH_HAS_COPY_MC=3Dy
> CONFIG_ARCH_STACKWALK=3Dy
> CONFIG_SBITMAP=3Dy
> # end of Library routines
>=20
> CONFIG_ASN1_ENCODER=3Dy
>=20
> #
> # Kernel hacking
> #
>=20
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_PRINTK_CALLER=3Dy
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> CONFIG_BOOT_PRINTK_DELAY=3Dy
> CONFIG_DYNAMIC_DEBUG=3Dy
> CONFIG_DYNAMIC_DEBUG_CORE=3Dy
> CONFIG_SYMBOLIC_ERRNAME=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # end of printk and dmesg options
>=20
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
>=20
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_AS_HAS_NON_CONST_LEB128=3Dy
> # CONFIG_DEBUG_INFO_NONE is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_DEBUG_INFO_REDUCED=3Dy
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> CONFIG_PAHOLE_HAS_LANG_EXCLUDE=3Dy
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=3D2048
> CONFIG_STRIP_ASM_SYMS=3Dy
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=3Dy
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
> CONFIG_OBJTOOL=3Dy
> # CONFIG_VMLINUX_MAP is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
>=20
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D""
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=3Dy
> CONFIG_HAVE_KCSAN_COMPILER=3Dy
> # CONFIG_KCSAN is not set
> # end of Generic Kernel Debugging Instruments
>=20
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # CONFIG_DEBUG_NET is not set
> # end of Networking Debugging
>=20
> #
> # Memory Debugging
> #
> # CONFIG_PAGE_EXTENSION is not set
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_SLUB_DEBUG is not set
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_TABLE_CHECK is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=3Dy
> # CONFIG_PTDUMP_DEBUGFS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_PER_VMA_LOCK_STATS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SHRINKER_DEBUG is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> # CONFIG_DEBUG_VIRTUAL is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=3Dy
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> # CONFIG_KASAN is not set
> CONFIG_HAVE_ARCH_KFENCE=3Dy
> # CONFIG_KFENCE is not set
> CONFIG_HAVE_ARCH_KMSAN=3Dy
> # end of Memory Debugging
>=20
> # CONFIG_DEBUG_SHIRQ is not set
>=20
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=3Dy
> CONFIG_PANIC_ON_OOPS_VALUE=3D1
> CONFIG_PANIC_TIMEOUT=3D0
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_WQ_WATCHDOG=3Dy
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
>=20
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_SCHED_INFO=3Dy
> CONFIG_SCHEDSTATS=3Dy
> # end of Scheduler Debugging
>=20
> # CONFIG_DEBUG_TIMEKEEPING is not set
>=20
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>=20
> # CONFIG_NMI_CHECK_CPU is not set
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
>=20
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=3Dy
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=3Dy
> # CONFIG_DEBUG_MAPLE_TREE is not set
> # end of Debug kernel data structures
>=20
> # CONFIG_DEBUG_CREDENTIALS is not set
>=20
> #
> # RCU Debugging
> #
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> # CONFIG_RCU_CPU_STALL_CPUTIME is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>=20
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> CONFIG_LATENCYTOP=3Dy
> # CONFIG_DEBUG_CGROUP_REF is not set
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_RETHOOK=3Dy
> CONFIG_RETHOOK=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_HAVE_FENTRY=3Dy
> CONFIG_HAVE_OBJTOOL_MCOUNT=3Dy
> CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=3Dy
> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_TRACER_MAX_TRACE=3Dy
> CONFIG_TRACE_CLOCK=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_GENERIC_TRACER=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=3Dy
> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_DYNAMIC_FTRACE=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> # CONFIG_FPROBE is not set
> CONFIG_FUNCTION_PROFILER=3Dy
> CONFIG_STACK_TRACER=3Dy
> # CONFIG_IRQSOFF_TRACER is not set
> CONFIG_SCHED_TRACER=3Dy
> CONFIG_HWLAT_TRACER=3Dy
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=3Dy
> CONFIG_TRACER_SNAPSHOT=3Dy
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> CONFIG_KPROBE_EVENTS=3Dy
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=3Dy
> CONFIG_BPF_EVENTS=3Dy
> CONFIG_DYNAMIC_EVENTS=3Dy
> CONFIG_PROBE_EVENTS=3Dy
> CONFIG_BPF_KPROBE_OVERRIDE=3Dy
> CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_FTRACE_MCOUNT_USE_CC=3Dy
> CONFIG_TRACING_MAP=3Dy
> CONFIG_SYNTH_EVENTS=3Dy
> # CONFIG_USER_EVENTS is not set
> CONFIG_HIST_TRIGGERS=3Dy
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=3Dm
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> # CONFIG_RV is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> CONFIG_STRICT_DEVMEM=3Dy
> # CONFIG_IO_STRICT_DEVMEM is not set
>=20
> #
> # x86 Debugging
> #
> CONFIG_EARLY_PRINTK_USB=3Dy
> CONFIG_X86_VERBOSE_BOOTUP=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_EARLY_PRINTK_DBGP=3Dy
> CONFIG_EARLY_PRINTK_USB_XDBC=3Dy
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_0X80=3Dy
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=3Dy
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=3Dy
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # CONFIG_UNWINDER_GUESS is not set
> # end of x86 Debugging
>=20
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=3Dy
> CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=3Dy
> # CONFIG_TEST_DHRY is not set
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_MAPLE_TREE is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_DYNAMIC_DEBUG is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_LIVEPATCH is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_HMM is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=3Dy
> # CONFIG_MEMTEST is not set
> # CONFIG_HYPERV_TESTING is not set
> # end of Kernel Testing and Coverage
>=20
> #
> # Rust hacking
> #
> # end of Rust hacking
> # end of Kernel hacking

> #!/bin/sh
>=20
> export_top_env()
> {
> 	export suite=3D'fio-basic'
> 	export testcase=3D'fio-basic'
> 	export category=3D'benchmark'
> 	export runtime=3D300
> 	export nr_task=3D1
> 	export test_size=3D'128G'
> 	export job_origin=3D'fio-basic-1hdd-write.yaml'
> 	export queue_cmdline_keys=3D'force_schedule
> force_reboot'
> 	export queue=3D'vip'
> 	export testbox=3D'lkp-icl-2sp9'
> 	export tbox_group=3D'lkp-icl-2sp9'
> 	export submit_id=3D'64b6343b0b9a932b7b60c01a'
> 	export job_file=3D'/lkp/jobs/queued/vip/lkp-icl-2sp9/fio-basic-4k-perfor=
mance-1HDD-ext4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d=
1e4533b0-20230718-76667-11nrsap-1.yaml'
> 	export id=3D'14d39c4aa7bd1e6a3e409195541457e8201dcf6d'
> 	export queuer_version=3D'/lkp/xsang/.src-20230718-105547'
> 	export model=3D'Ice Lake'
> 	export nr_node=3D2
> 	export nr_cpu=3D64
> 	export memory=3D'256G'
> 	export nr_ssd_partitions=3D3
> 	export nr_hdd_partitions=3D6
> 	export hdd_partitions=3D'/dev/disk/by-id/wwn-0x50014ee2be2f4b3a-part*'
> 	export ssd_partitions=3D'/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part1
> /dev/disk/by-id/wwn-0x500a0751e5ff0a85-part2
> /dev/disk/by-id/wwn-0x500a0751e5ff0a85-part3'
> 	export rootfs_partition=3D'/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part4'
> 	export kernel_cmdline_hw=3D'acpi_rsdp=3D0x698f6014'
> 	export result_service=3D'tmpfs'
> 	export LKP_SERVER=3D'10.239.97.5'
> 	export avoid_nfs=3D1
> 	export brand=3D'Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz'
> 	export need_kconfig=3D'{"XFS_DEBUG"=3D>"n"}
> {"XFS_WARN"=3D>"y"}
> {"PM_DEBUG"=3D>"n"}
> {"PM_SLEEP_DEBUG"=3D>"n"}
> {"DEBUG_ATOMIC_SLEEP"=3D>"n"}
> {"DEBUG_SPINLOCK_SLEEP"=3D>"n"}
> {"CIFS_DEBUG"=3D>"n"}
> {"SCSI_DEBUG"=3D>"n"}
> {"NFS_DEBUG"=3D>"n"}
> {"SUNRPC_DEBUG"=3D>"n"}
> {"DM_DEBUG"=3D>"n"}
> {"DEBUG_SHIRQ"=3D>"n"}
> {"OCFS2_DEBUG_MASKLOG"=3D>"n"}
> {"DEBUG_MEMORY_INIT"=3D>"n"}
> {"SLUB_DEBUG"=3D>"n"}
> {"EXPERT"=3D>"y"}
> {"PREEMPT_VOLUNTARY"=3D>"y"}
> {"PREEMPT_NONE"=3D>"n"}
> {"PREEMPT"=3D>"n"}
> {"PREEMPT_RT"=3D>"n"}
> {"PREEMPT_DYNAMIC"=3D>"n"}
> {"PREEMPT_VOLUNTARY_BEHAVIOUR"=3D>"y"}
> {"PREEMPT_BEHAVIOUR"=3D>"n"}
> {"PREEMPT_NONE_BEHAVIOUR"=3D>"n"}
> {"PREEMPT_DYNAMIC"=3D>"n"}
> {"PREEMPT_VOLUNTARY"=3D>"y"}
> {"PREEMPT_NONE"=3D>"n"}
> {"PREEMPT"=3D>"n"}
> {"PREEMPT_RT"=3D>"n"}
> BLK_DEV_SD
> SCSI
> {"BLOCK"=3D>"y"}
> SATA_AHCI
> SATA_AHCI_PLATFORM
> ATA
> {"PCI"=3D>"y"}
> EXT4_FS'
> 	export commit=3D'4f3d1e4533b0982034f316ace85415d3bc57e3da'
> 	export ucode=3D'0xd000389'
> 	export need_kconfig_hw=3D'{"MEGARAID_NEWGEN"=3D>"y"}
> MEGARAID_MM
> MEGARAID_MAILBOX
> MEGARAID_LEGACY
> MEGARAID_SAS'
> 	export kconfig=3D'x86_64-rhel-8.3'
> 	export enqueue_time=3D'2023-07-18 14:42:06 +0800'
> 	export _id=3D'64b634400b9a932b7b60c025'
> 	export _rt=3D'/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-wri=
te-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12=
/4f3d1e4533b0982034f316ace85415d3bc57e3da'
> 	export compiler=3D'gcc-12'
> 	export head_commit=3D'70e49dd32f8d664a83fc3eea895534f8d033b22c'
> 	export base_commit=3D'6995e2de6891c724bfeb2db33d7b87775f913ad1'
> 	export branch=3D'linus/master'
> 	export rootfs=3D'debian-11.1-x86_64-20220510.cgz'
> 	export user=3D'lkp'
> 	export scheduler_version=3D'/lkp/lkp/.src-20230718-114450'
> 	export arch=3D'x86_64'
> 	export max_uptime=3D2100
> 	export initrd=3D'/osimage/debian/debian-11.1-x86_64-20220510.cgz'
> 	export bootloader_append=3D'root=3D/dev/ram0
> RESULT_ROOT=3D/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-writ=
e-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/=
4f3d1e4533b0982034f316ace85415d3bc57e3da/8
> BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316ace8=
5415d3bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0
> branch=3Dlinus/master
> job=3D/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1HDD-ext4=
-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0-202307=
18-76667-11nrsap-1.yaml
> user=3Dlkp
> ARCH=3Dx86_64
> kconfig=3Dx86_64-rhel-8.3
> commit=3D4f3d1e4533b0982034f316ace85415d3bc57e3da
> nmi_watchdog=3D0
> acpi_rsdp=3D0x698f6014
> max_uptime=3D2100
> LKP_SERVER=3D10.239.97.5
> nokaslr
> selinux=3D0
> debug
> apic=3Ddebug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=3D100
> net.ifnames=3D0
> printk.devkmsg=3Don
> panic=3D-1
> softlockup_panic=3D1
> nmi_watchdog=3Dpanic
> oops=3Dpanic
> load_ramdisk=3D2
> prompt_ramdisk=3D0
> drbd.minor_count=3D8
> systemd.log_level=3Derr
> ignore_loglevel
> console=3Dtty0
> earlyprintk=3DttyS0,115200
> console=3DttyS0,115200
> vga=3Dnormal
> rw'
> 	export modules_initrd=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b09=
82034f316ace85415d3bc57e3da/modules.cgz'
> 	export bm_initrd=3D'/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ip=
config_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220=
513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515=
=2Ecgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/fio_20230715.cgz,/osimage/pkg/debia=
n-11.1-x86_64-20220510.cgz/fio-x86_64-3.33-1_20230715.cgz,/osimage/deps/deb=
ian-11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-=
x86_64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-=
20220510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/deb=
ian-11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x86=
_64-20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debia=
n-11.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/=
debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1-x=
86_64-20220510.cgz/rootfs_20220515.cgz'
> 	export ucode_initrd=3D'/osimage/ucode/intel-ucode-20230406.cgz'
> 	export lkp_initrd=3D'/osimage/user/lkp/lkp-x86_64.cgz'
> 	export site=3D'lkp-wsx01'
> 	export LKP_CGI_PORT=3D80
> 	export LKP_CIFS_PORT=3D139
> 	export job_initrd=3D'/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-perfo=
rmance-1HDD-ext4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3=
d1e4533b0-20230718-76667-11nrsap-1.cgz'
> 	export last_kernel=3D'6.4.0-02378-gd68f3b848dc3'
> 	export acpi_rsdp=3D'0x698f6014'
> 	export force_schedule=3Dtrue
> 	export force_reboot=3D1
> 	export kernel=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f31=
6ace85415d3bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0'
> 	export result_root=3D'/result/fio-basic/4k-performance-1HDD-ext4-sync-1-=
300s-write-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.=
3/gcc-12/4f3d1e4533b0982034f316ace85415d3bc57e3da/8'
>=20
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=3D/lkp/${user:-lkp}/src
> }
>=20
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
>=20
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
>=20
> 	export_top_env
>=20
> 	run_setup nr_hdd=3D1 $LKP_SRC/setup/disk
>=20
> 	run_setup fs=3D'ext4' $LKP_SRC/setup/fs
>=20
> 	run_setup rw=3D'write' bs=3D'4k' ioengine=3D'sync' $LKP_SRC/setup/fio-se=
tup-basic
>=20
> 	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'
>=20
> 	run_setup $LKP_SRC/setup/sanity-check
>=20
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
> 	run_monitor $LKP_SRC/monitors/wrapper uptime
> 	run_monitor $LKP_SRC/monitors/wrapper iostat
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
> 	run_monitor $LKP_SRC/monitors/wrapper proc-stat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper slabinfo
> 	run_monitor $LKP_SRC/monitors/wrapper interrupts
> 	run_monitor $LKP_SRC/monitors/wrapper lock_stat
> 	run_monitor lite_mode=3D1 $LKP_SRC/monitors/wrapper perf-sched
> 	run_monitor $LKP_SRC/monitors/wrapper softirqs
> 	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
> 	run_monitor $LKP_SRC/monitors/wrapper diskstats
> 	run_monitor $LKP_SRC/monitors/wrapper nfsstat
> 	run_monitor $LKP_SRC/monitors/wrapper cpuidle
> 	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
> 	run_monitor $LKP_SRC/monitors/wrapper turbostat
> 	run_monitor $LKP_SRC/monitors/wrapper sched_debug
> 	run_monitor $LKP_SRC/monitors/wrapper perf-stat
> 	run_monitor $LKP_SRC/monitors/wrapper mpstat
> 	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-c2c
> 	run_monitor debug_mode=3D0 $LKP_SRC/monitors/no-stdout/wrapper perf-prof=
ile
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
>=20
> 	run_test $LKP_SRC/tests/wrapper fio
> }
>=20
> extract_stats()
> {
> 	export stats_part_begin=3D
> 	export stats_part_end=3D
>=20
> 	$LKP_SRC/stats/wrapper fio
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper boot-time
> 	$LKP_SRC/stats/wrapper uptime
> 	$LKP_SRC/stats/wrapper iostat
> 	$LKP_SRC/stats/wrapper vmstat
> 	$LKP_SRC/stats/wrapper numa-numastat
> 	$LKP_SRC/stats/wrapper numa-vmstat
> 	$LKP_SRC/stats/wrapper numa-meminfo
> 	$LKP_SRC/stats/wrapper proc-vmstat
> 	$LKP_SRC/stats/wrapper meminfo
> 	$LKP_SRC/stats/wrapper slabinfo
> 	$LKP_SRC/stats/wrapper interrupts
> 	$LKP_SRC/stats/wrapper lock_stat
> 	env lite_mode=3D1 $LKP_SRC/stats/wrapper perf-sched
> 	$LKP_SRC/stats/wrapper softirqs
> 	$LKP_SRC/stats/wrapper diskstats
> 	$LKP_SRC/stats/wrapper nfsstat
> 	$LKP_SRC/stats/wrapper cpuidle
> 	$LKP_SRC/stats/wrapper turbostat
> 	$LKP_SRC/stats/wrapper sched_debug
> 	$LKP_SRC/stats/wrapper perf-stat
> 	$LKP_SRC/stats/wrapper mpstat
> 	$LKP_SRC/stats/wrapper perf-c2c
> 	env debug_mode=3D0 $LKP_SRC/stats/wrapper perf-profile
>=20
> 	$LKP_SRC/stats/wrapper time fio.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
>=20
> "$@"

> ---
> suite: fio-basic
> testcase: fio-basic
> category: benchmark
> runtime: 300s
> disk: 1HDD
> fs: ext4
> nr_task: 1
> test_size: 128G
> fio-setup-basic:
>   rw: write
>   bs: 4k
>   ioengine: sync
> fio:
> job_origin: fio-basic-1hdd-write.yaml
> queue_cmdline_keys:
> - branch
> - commit
> - kbuild_queue_analysis
> queue: bisect
> testbox: lkp-icl-2sp9
> tbox_group: lkp-icl-2sp9
> submit_id: 64b3f535617b43fead71c707
> job_file: "/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1HDD=
-ext4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0-2=
0230716-65197-glsvq8-1.yaml"
> id: d288c30ab88b87a9a92b4bbdd5bb422abda803d9
> queuer_version: "/zday/lkp"
> model: Ice Lake
> nr_node: 2
> nr_cpu: 64
> memory: 256G
> nr_ssd_partitions: 3
> nr_hdd_partitions: 6
> hdd_partitions: "/dev/disk/by-id/wwn-0x50014ee2be2f4b3a-part*"
> ssd_partitions:
> - "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part1"
> - "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part2"
> - "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part3"
> rootfs_partition: "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part4"
> kernel_cmdline_hw: acpi_rsdp=3D0x698f6014
> result_service: tmpfs
> LKP_SERVER: 10.239.97.5
> avoid_nfs: 1
> brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz
> need_kconfig:
> - XFS_DEBUG: n
> - XFS_WARN: y
> - PM_DEBUG: n
> - PM_SLEEP_DEBUG: n
> - DEBUG_ATOMIC_SLEEP: n
> - DEBUG_SPINLOCK_SLEEP: n
> - CIFS_DEBUG: n
> - SCSI_DEBUG: n
> - NFS_DEBUG: n
> - SUNRPC_DEBUG: n
> - DM_DEBUG: n
> - DEBUG_SHIRQ: n
> - OCFS2_DEBUG_MASKLOG: n
> - DEBUG_MEMORY_INIT: n
> - SLUB_DEBUG: n
> - EXPERT: y
> - PREEMPT_VOLUNTARY: y
> - PREEMPT_NONE: n
> - PREEMPT: n
> - PREEMPT_RT: n
> - PREEMPT_DYNAMIC: n
> - PREEMPT_VOLUNTARY_BEHAVIOUR: y
> - PREEMPT_BEHAVIOUR: n
> - PREEMPT_NONE_BEHAVIOUR: n
> - PREEMPT_DYNAMIC: n
> - PREEMPT_VOLUNTARY: y
> - PREEMPT_NONE: n
> - PREEMPT: n
> - PREEMPT_RT: n
> - BLK_DEV_SD
> - SCSI
> - BLOCK: y
> - SATA_AHCI
> - SATA_AHCI_PLATFORM
> - ATA
> - PCI: y
> - EXT4_FS
> kmsg:
> boot-time:
> uptime:
> iostat:
> heartbeat:
> vmstat:
> numa-numastat:
> numa-vmstat:
> numa-meminfo:
> proc-vmstat:
> proc-stat:
> meminfo:
> slabinfo:
> interrupts:
> lock_stat:
> perf-sched:
>   lite_mode: 1
> softirqs:
> bdi_dev_mapping:
> diskstats:
> nfsstat:
> cpuidle:
> cpufreq-stats:
> turbostat:
> sched_debug:
> perf-stat:
> mpstat:
> perf-c2c:
> perf-profile:
>   debug_mode: 0
> cpufreq_governor: performance
> sanity-check:
> commit: 4f3d1e4533b0982034f316ace85415d3bc57e3da
> ucode: '0xd000389'
> need_kconfig_hw:
> - MEGARAID_NEWGEN: y
> - MEGARAID_MM
> - MEGARAID_MAILBOX
> - MEGARAID_LEGACY
> - MEGARAID_SAS
> kconfig: x86_64-rhel-8.3
> enqueue_time: 2023-07-16 21:48:37.272837713 +08:00
> _id: 64b3ff4c617b43fead71c708
> _rt: "/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-write-128G/l=
kp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/4f3d1e45=
33b0982034f316ace85415d3bc57e3da"
> compiler: gcc-12
> head_commit: 4959e9be4eebd7076b1bb56ddee8467516d2bb38
> base_commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> branch: linux-devel/devel-hourly-20230715-100816
> rootfs: debian-11.1-x86_64-20220510.cgz
> user: lkp
> scheduler_version: "/lkp/lkp/src"
> arch: x86_64
> max_uptime: 2100
> initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
> bootloader_append:
> - root=3D/dev/ram0
> - RESULT_ROOT=3D/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-wr=
ite-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-1=
2/4f3d1e4533b0982034f316ace85415d3bc57e3da/0
> - BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316ac=
e85415d3bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0
> - branch=3Dlinux-devel/devel-hourly-20230715-100816
> - job=3D/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1HDD-ex=
t4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0-2023=
0716-65197-glsvq8-1.yaml
> - user=3Dlkp
> - ARCH=3Dx86_64
> - kconfig=3Dx86_64-rhel-8.3
> - commit=3D4f3d1e4533b0982034f316ace85415d3bc57e3da
> - nmi_watchdog=3D0
> - acpi_rsdp=3D0x698f6014
> - max_uptime=3D2100
> - LKP_SERVER=3D10.239.97.5
> - nokaslr
> - selinux=3D0
> - debug
> - apic=3Ddebug
> - sysrq_always_enabled
> - rcupdate.rcu_cpu_stall_timeout=3D100
> - net.ifnames=3D0
> - printk.devkmsg=3Don
> - panic=3D-1
> - softlockup_panic=3D1
> - nmi_watchdog=3Dpanic
> - oops=3Dpanic
> - load_ramdisk=3D2
> - prompt_ramdisk=3D0
> - drbd.minor_count=3D8
> - systemd.log_level=3Derr
> - ignore_loglevel
> - console=3Dtty0
> - earlyprintk=3DttyS0,115200
> - console=3DttyS0,115200
> - vga=3Dnormal
> - rw
> modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316=
ace85415d3bc57e3da/modules.cgz"
> bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20=
220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/=
osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osi=
mage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/deb=
ian-11.1-x86_64-20220510.cgz/fio_20230715.cgz,/osimage/pkg/debian-11.1-x86_=
64-20220510.cgz/fio-x86_64-3.33-1_20230715.cgz,/osimage/deps/debian-11.1-x8=
6_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-2022=
0510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cg=
z/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x8=
6_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x86_64-2022051=
0.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_=
64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1=
-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220=
510.cgz/rootfs_20220515.cgz"
> ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
> site: inn
> LKP_CGI_PORT: 80
> LKP_CIFS_PORT: 139
> oom-killer:
> watchdog:
> job_initrd: "/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1H=
DD-ext4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0=
-20230716-65197-glsvq8-1.cgz"
> last_kernel: 6.5.0-rc1-05385-g7ddd6fdbf494
> acpi_rsdp: '0x698f6014'
> repeat_to: 3
> bad_samples:
> - 238.7158203125
> - 235.755859375
> - 234.1630859375
>=20
> #! queue options
>=20
> #! user overrides
> kbuild_queue_analysis: 1
> kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316ace85415=
d3bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0"
> result_root: "/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-writ=
e-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/=
4f3d1e4533b0982034f316ace85415d3bc57e3da/0"
>=20
> #! schedule options
>=20
> #! /db/releases/20230716204618/lkp-src/include/site/inn
> dequeue_time: 2023-07-16 22:44:56.558007096 +08:00
> job_state: wget_kernel_fail

> dmsetup remove_all
> wipefs -a --force /dev/sdb1
> mkfs -t ext4 -q -F /dev/sdb1
> mkdir -p /fs/sdb1
> mount -t ext4 /dev/sdb1 /fs/sdb1
>=20
> for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
> do
> 	online_file=3D"$cpu_dir"/online
> 	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue
>=20
> 	file=3D"$cpu_dir"/cpufreq/scaling_governor
> 	[ -f "$file" ] && echo "performance" > "$file"
> done
>=20
> echo '[global]
> bs=3D4k
> ioengine=3Dsync
> iodepth=3D32
> size=3D137438953472
> nr_files=3D1
> filesize=3D137438953472
> direct=3D0
> runtime=3D300
> invalidate=3D1
> fallocate=3Dposix
> io_size=3D137438953472
> file_service_type=3Droundrobin
> random_distribution=3Drandom
> group_reporting
> pre_read=3D0
>=20
> [task_0]
> rw=3Dwrite
> directory=3D/fs/sdb1
> numjobs=3D1' | fio --output-format=3Djson -

--=20
Jan Kara <jack@suse.com>
SUSE Labs, CR
