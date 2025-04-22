Return-Path: <linux-ext4+bounces-7376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21A7A96370
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Apr 2025 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D2B17A94A
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Apr 2025 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3C25D206;
	Tue, 22 Apr 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iv4wEbpf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431A2405F8;
	Tue, 22 Apr 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311881; cv=none; b=aKlEcb5pgGkTH6xobBhY7B7Do9TgK33IbaaH93T/oA4Ov0meocYKlyw4e5IaGmWOmSCA1+5WA6b4WtesGs/sfa5b97pZeQsfZ4AY1jzOo+d7GMPbFZRMfA+v5JDaZcK24skKhBaUMrhq+wjN880EVL22MB7fDeRb4yamb1/b/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311881; c=relaxed/simple;
	bh=PcT0XgA6GrPvbPqcvyrP+CFpHAr7WTzkXKXG8Va7QHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIlHadyH5uu0iSdOr2iEDuhh0+IqbGfzsJ1r9nP3oZTynGjyQ8wm1PN87mecYoD6Tj9YtCpkCspk6w86QhBMs3YXEKkOTyX9zcM9Bx5IFErlMgAQb9HRbzorERrjo++kRNB1mCAsabOulLT0XK/dOHy+KZ/RI+Fhz7+qjeTAt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iv4wEbpf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M47II6016264;
	Tue, 22 Apr 2025 08:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FoFf+Z
	vUn20wcXSzs2rNK9ncNZcGAXtoc7jE1dX/YPs=; b=iv4wEbpfOoKeSBir52VeJI
	QdCU3quOSO3tUmeSOqo7eXNopJpGL+rhax8KbZKgvE7puvIdPvU5bQSNpqa44A70
	3ft2/Lsa2LGYFawfNRn81+0jWjK4BC5e79zKOY3bAEHcql0ZMuIasP22qBeVs2Bw
	Tdx/QJinjaeTu/DaoaGRQd6jJ3l2hvxUHwQGrGahj94Me7oAIY+IlgBV/d/TXBj4
	LGZBGBtXJm1LRogHHg2bSiKBX7qfW3z5L+hsTU/p8H8B65IzyEHdby1BkW8Cy12y
	+gA6MXZ8KBXJjhtL3HwZKeJMuh9mLPDVK6OI/bn86lyHVJdwxJsnnnQXa9pWEVag
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663t613ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:51:08 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M8p8r9012800;
	Tue, 22 Apr 2025 08:51:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4663t613kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:51:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M5ZFDT012496;
	Tue, 22 Apr 2025 08:51:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 464p5t29y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 08:51:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53M8p5hI32768688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 08:51:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F4ED2004B;
	Tue, 22 Apr 2025 08:51:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8303E20040;
	Tue, 22 Apr 2025 08:51:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.249])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Apr 2025 08:51:03 +0000 (GMT)
Date: Tue, 22 Apr 2025 14:21:00 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Subject: Re: [linus:master] [ext4]  896b02d0b9:  stress-ng.fiemap.ops_per_sec
 15.8% regression
Message-ID: <aAdYdBjy4ERcfv3P@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <202504211320.5025beac-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202504211320.5025beac-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MmN2CsmPcZjmJY1EWwz4qJpwWFkjxRpo
X-Proofpoint-GUID: hUoyx2pbR3Deboo-SmaDB3bv5mfesaRM
X-Authority-Analysis: v=2.4 cv=GsRC+l1C c=1 sm=1 tr=0 ts=6807587c cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i3X5FwGiAAAA:8 a=NEAV23lmAAAA:8
 a=7Qg1no0YzWYdUPjgeWIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220064

On Mon, Apr 21, 2025 at 01:56:07PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a 15.8% regression of stress-ng.fiemap.ops_per_sec on:
> 
> 
> commit: 896b02d0b9e7deb4a4eb365e13dd912b49916519 ("ext4: Make sb update interval tunable")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      1a1d569a75f3ab2923cb62daf356d102e4df2b86]
> [test failed on linux-next/master f660850bc246fef15ba78c81f686860324396628]
> 
> testcase: stress-ng
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 60s
> 	fs: ext4
> 	test: fiemap
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202504211320.5025beac-lkp@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250421/202504211320.5025beac-lkp@intel.com
> 
> =========================================================================================
> compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/1HDD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fiemap/stress-ng/60s
> 
> commit: 
>   ce2f26e737 ("ext4: avoid journaling sb update on error if journal is destroying")
>   896b02d0b9 ("ext4: Make sb update interval tunable")

Hmm this is strange since this patch doesn't intend to change any
functionality. Let me try out the reproducer and get back to you if 
I see the regression as well.

Thanks,
ojaswin
> 
> ce2f26e73783b4a7 896b02d0b9e7deb4a4eb365e13d 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>       2.29 ±  6%     -13.2%       1.99 ±  7%  iostat.cpu.user
>    1688381 ±  2%     -16.4%    1411358 ±  4%  vmstat.system.cs
>       0.01 ± 12%      -0.0        0.01 ± 10%  mpstat.cpu.all.soft%
>       2.33 ±  6%      -0.3        2.01 ±  7%  mpstat.cpu.all.usr%
>      28467 ± 22%     +39.4%      39676 ± 13%  numa-meminfo.node0.Inactive
>      28467 ± 22%     +39.4%      39676 ± 13%  numa-meminfo.node0.Inactive(file)
>       7099 ± 22%     +40.0%       9937 ± 13%  numa-vmstat.node0.nr_inactive_file
>       7099 ± 22%     +40.0%       9937 ± 13%  numa-vmstat.node0.nr_zone_inactive_file
>    3186734 ±  2%     -13.0%    2770907        meminfo.Active
>    3186734 ±  2%     -13.0%    2770907        meminfo.Active(anon)
>    2332511 ±  4%     -17.1%    1933636 ±  2%  meminfo.Shmem
>     829642 ±  3%     -16.0%     696952 ±  4%  sched_debug.cpu.nr_switches.avg
>     992823 ±  4%     -14.5%     849332 ±  6%  sched_debug.cpu.nr_switches.max
>     153915 ±  5%     -15.2%     130547 ± 11%  sched_debug.cpu.nr_switches.stddev
>   64971130 ±  3%     -15.8%   54708915 ±  4%  stress-ng.fiemap.ops
>    1067456 ±  3%     -15.8%     898490 ±  4%  stress-ng.fiemap.ops_per_sec
>  1.079e+08 ±  2%     -16.0%   90643140 ±  4%  stress-ng.time.involuntary_context_switches
>      67.64 ±  9%     -16.5%      56.46 ±  9%  stress-ng.time.user_time
>     797292 ±  2%     -13.2%     692413        proc-vmstat.nr_active_anon
>    1499550            -6.7%    1398519        proc-vmstat.nr_file_pages
>     583908 ±  4%     -17.3%     483006 ±  2%  proc-vmstat.nr_shmem
>     797292 ±  2%     -13.2%     692413        proc-vmstat.nr_zone_active_anon
>    1256873 ±  2%     -12.3%    1102563        proc-vmstat.numa_hit
>    1190636 ±  2%     -13.0%    1036297        proc-vmstat.numa_local
>    1367314 ±  2%     -11.3%    1212232 ±  2%  proc-vmstat.pgalloc_normal
>     369155 ±  5%      -6.9%     343753 ±  2%  proc-vmstat.pgfault
>  2.492e+10 ±  2%     -18.5%  2.031e+10        perf-stat.i.branch-instructions
>  1.232e+08 ±  7%     -15.2%  1.045e+08 ±  6%  perf-stat.i.branch-misses
>  3.895e+08 ±  2%      -8.8%  3.553e+08        perf-stat.i.cache-references
>    1759358 ±  2%     -16.0%    1478535 ±  3%  perf-stat.i.context-switches
>       1.80 ±  2%     +22.5%       2.20        perf-stat.i.cpi
>  1.262e+11 ±  2%     -18.5%  1.028e+11        perf-stat.i.instructions
>       0.56 ±  2%     -18.5%       0.46        perf-stat.i.ipc
>      27.44 ±  2%     -15.8%      23.10 ±  3%  perf-stat.i.metric.K/sec
>       4132 ±  5%      -8.9%       3766 ±  2%  perf-stat.i.minor-faults
>       4132 ±  5%      -8.9%       3766 ±  2%  perf-stat.i.page-faults
>       1.79 ±  2%     +22.8%       2.20        perf-stat.overall.cpi
>       0.56 ±  2%     -18.6%       0.45        perf-stat.overall.ipc
>   2.45e+10 ±  2%     -18.5%  1.998e+10        perf-stat.ps.branch-instructions
>   1.21e+08 ±  7%     -15.0%  1.028e+08 ±  6%  perf-stat.ps.branch-misses
>  3.828e+08 ±  2%      -8.7%  3.496e+08        perf-stat.ps.cache-references
>    1729946 ±  2%     -15.9%    1454325 ±  3%  perf-stat.ps.context-switches
>  1.241e+11 ±  2%     -18.5%  1.011e+11        perf-stat.ps.instructions
>       4060 ±  5%      -8.8%       3703 ±  2%  perf-stat.ps.minor-faults
>       4060 ±  5%      -8.8%       3703 ±  2%  perf-stat.ps.page-faults
>  7.699e+12 ±  2%     -18.7%  6.262e+12 ±  2%  perf-stat.total.instructions
>       0.02 ±194%   +3583.1%       0.80 ±127%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>       0.14 ±  5%     +21.4%       0.17 ±  2%  perf-sched.sch_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       0.02 ± 12%     +35.4%       0.03 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.01 ±  3%     +14.8%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
>       2.90 ±107%    +259.8%      10.43 ± 35%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
>       8.62 ± 28%     +69.3%      14.58 ±  8%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>       0.02 ±194%   +5175.4%       1.14 ± 88%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>     395.95 ±185%     -99.6%       1.67 ± 45%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>      10.22 ± 15%     +49.3%      15.26 ±  4%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>       0.05 ± 10%     +29.0%       0.06 ± 13%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.14 ±  5%     +20.6%       0.17 ±  2%  perf-sched.total_sch_delay.average.ms
>       0.44 ±  3%     +19.7%       0.52 ±  3%  perf-sched.total_wait_and_delay.average.ms
>    6639596 ±  3%     -17.7%    5461347 ±  3%  perf-sched.total_wait_and_delay.count.ms
>       0.30 ±  2%     +19.3%       0.36 ±  3%  perf-sched.total_wait_time.average.ms
>       0.28 ±  3%     +20.8%       0.34 ±  2%  perf-sched.wait_and_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>    6614032 ±  3%     -17.8%    5436664 ±  3%  perf-sched.wait_and_delay.count.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       5.80 ±107%    +259.8%      20.86 ± 35%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
>      17.23 ± 28%     +69.3%      29.17 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>      20.45 ± 15%     +63.4%      33.41 ± 21%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
>       0.02 ±223%   +4040.9%       0.79 ±127%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>       0.15 ±  2%     +20.6%       0.18 ±  2%  perf-sched.wait_time.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
>       2.90 ±107%    +259.8%      10.43 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
>       8.62 ± 28%     +69.3%      14.58 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
>       0.02 ±223%   +5863.5%       1.14 ± 88%  perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>      10.22 ± 15%    +103.2%      20.77 ± 61%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
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
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

