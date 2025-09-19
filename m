Return-Path: <linux-ext4+bounces-10252-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A59B87BAA
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 04:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66421CC13C8
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99464259CAC;
	Fri, 19 Sep 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/5Hvyoj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EB257852
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249275; cv=none; b=OwEDOAFHu5fJZHnWUdM1OG6QzbWyZCCk3L4o4++IFCV4dBPeVhkCDHpNZ67GMKZajGN1HMVA6HfpHcN3tj2bhqhUUtYB2ymoRbpGZgB4t5Vzoob10PeEftzGVgyWUgXJ04nylgg8tIMf1tbyPgsFPCJZZZ16uESLlKVIT7KkwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249275; c=relaxed/simple;
	bh=j/dWPq4YFWIryUm+SlfOUKY0qJl5tfzc88bGQe0Rs50=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=men3hq+1C2OFRgUE0Zt3k8+FEOlMosLP2WPyn/aATl9lttd7fukJF0QpgLutfliPzw9tlo9zZXNUCS1siqw5GM0zmUrY2ZoSqdnw27zT+bFn+d38zo+LVAxpuM28BsGD/WGTm7CmOuZ4wbnmwwlcVnPZZxtxlgnyeO4kPdWg55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/5Hvyoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF829C4CEF7
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758249274;
	bh=j/dWPq4YFWIryUm+SlfOUKY0qJl5tfzc88bGQe0Rs50=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o/5HvyojQ4ydmEEj42fQl1j85BJeR8M19pblZwNofGx/BSobMIDvt1PAiUBJSFEE/
	 xHg8MrMdrQF7iqpJdT5c8rjbhIfxVC6ruTYS7ZJk/3vrvoMnSKY9FtPVbMNO/UoRiP
	 U/sYVhoMP8gEoFebbswpk8/clo4jRq9VogcVuWxWqxyXxeRQg/Zo3pMgYN73hM4esO
	 p7o4IzUZG13bGBKhKBdNt0lIPw0SgksbAXhL5+FHF8IkSQGj9K4vr00yAr5ACDBN56
	 2HyG104W5CNvcnLqW1c6WXx7IW+EWpWWdf7f3EeDL1dG3f+jRI2o5NKiLwAaJreZnq
	 Wgyh83qhZECMg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9EC69C41614; Fri, 19 Sep 2025 02:34:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Fri, 19 Sep 2025 02:34:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: waxihus@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220535-13602-JaLqHptZf4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220535-13602@https.bugzilla.kernel.org/>
References: <bug-220535-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220535

--- Comment #7 from waxihus@gmail.com ---
have reproduced with the latest version and untainted kernel, see attachment
for more dmesg log:
source code clone from 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
[  533.816688] INFO: task kworker/u778:1:1854 blocked for more than 481
seconds.
[  533.816713]       Not tainted 6.17.0-rc6-master-default #2
[  533.816723] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this
message.
[  533.816734] task:kworker/u778:1  state:D stack:0     pid:1854  tgid:1854=
=20
ppid:2      task_flags:0x4248060 flags:0x00004000
[  533.816751] Workqueue: writeback wb_workfn (flush-259:1)
[  533.816766] Call Trace:
[  533.816773]  <TASK>
[  533.816782]  __schedule+0x462/0x1400
[  533.816793]  ? sysvec_apic_timer_interrupt+0xf/0x90
[  533.816804]  ? srso_alias_return_thunk+0x5/0xfbef5
[  533.816817]  schedule+0x27/0xd0
[  533.816825]  schedule_preempt_disabled+0x15/0x30
[  533.816834]  __mutex_lock.constprop.0+0x357/0x940
[  533.816846]  mutex_lock_io+0x41/0x50
[  533.816857]  __jbd2_log_wait_for_space+0xda/0x1f0 [jbd2
371d593b5f5403746c7713ab4dc9d5e5c1953199]
[  533.816877]  add_transaction_credits+0x2f2/0x300 [jbd2
371d593b5f5403746c7713ab4dc9d5e5c1953199]
[  533.816895]  start_this_handle+0xfe/0x520 [jbd2
371d593b5f5403746c7713ab4dc9d5e5c1953199]
[  533.816910]  ? srso_alias_return_thunk+0x5/0xfbef5
[  533.816921]  jbd2__journal_start+0xfe/0x200 [jbd2
371d593b5f5403746c7713ab4dc9d5e5c1953199]
[  533.816936]  ext4_do_writepages+0x46a/0xee0 [ext4
893473fac91f34d580e31648f305d1177dd81b63]
[  533.816968]  ? __dequeue_entity+0x3c0/0x480
[  533.816977]  ? update_load_avg+0x80/0x760
[  533.816985]  ? srso_alias_return_thunk+0x5/0xfbef5
[  533.816996]  ? ext4_writepages+0xbe/0x190 [ext4
893473fac91f34d580e31648f305d1177dd81b63]
[  533.817019]  ext4_writepages+0xbe/0x190 [ext4
893473fac91f34d580e31648f305d1177dd81b63]
[  533.817044]  do_writepages+0xc7/0x160
[  533.817055]  __writeback_single_inode+0x41/0x340
[  533.817066]  writeback_sb_inodes+0x215/0x4c0
[  533.817084]  __writeback_inodes_wb+0x4c/0xe0
[  533.817094]  wb_writeback+0x192/0x300
[  533.817105]  ? get_nr_inodes+0x3b/0x60
[  533.817116]  wb_workfn+0x38a/0x460
[  533.817126]  process_one_work+0x1a1/0x3e0
[  533.817137]  worker_thread+0x292/0x420
[  533.817147]  ? __pfx_worker_thread+0x10/0x10
[  533.817156]  kthread+0xfc/0x240
[  533.817165]  ? __pfx_kthread+0x10/0x10
[  533.817174]  ? __pfx_kthread+0x10/0x10
[  533.817182]  ret_from_fork+0x1c1/0x1f0
[  533.817192]  ? __pfx_kthread+0x10/0x10
[  533.817200]  ret_from_fork_asm+0x1a/0x30


Also have a soft lockup, but the probability is very low.
[  329.157094] watchdog: BUG: soft lockup - CPU#21 stuck for 67s!
[kworker/u513:2:795]
[  329.157169] Workqueue: writeback wb_workfn (flush-259:8)
[  329.157176] RIP: 0010:queued_read_lock_slowpath+0x52/0x130
[  329.157194] Call Trace:
[  329.157196]  <TASK>
[  329.157200]  start_this_handle+0x99/0x520 [jbd2
0a56678a235e076a07e3222376de4dc1cbec6f17]
[  329.157216]  ? finish_task_switch.isra.0+0x97/0x2c0
[  329.157220]  jbd2__journal_start+0xfe/0x200 [jbd2
0a56678a235e076a07e3222376de4dc1cbec6f17]
[  329.157226]  ext4_do_writepages+0x46a/0xee0 [ext4
bcac05fee1dc1aaf21870e1e652c064619591c71]
[  329.157273]  ? find_get_block_common+0x1a8/0x3f0
[  329.157277]  ? ext4_writepages+0xbe/0x190 [ext4
bcac05fee1dc1aaf21870e1e652c064619591c71]
[  329.157303]  ext4_writepages+0xbe/0x190 [ext4
bcac05fee1dc1aaf21870e1e652c064619591c71]
[  329.157328]  do_writepages+0xc7/0x160
[  329.157331]  __writeback_single_inode+0x41/0x340
[  329.157334]  writeback_sb_inodes+0x215/0x4c0
[  329.157339]  __writeback_inodes_wb+0x4c/0xe0
[  329.157341]  wb_writeback+0x192/0x300
[  329.157344]  ? get_nr_inodes+0x3b/0x60
[  329.157347]  wb_workfn+0x291/0x460
[  329.157350]  process_one_work+0x1a1/0x3e0
[  329.157353]  worker_thread+0x292/0x420
[  329.157356]  ? __pfx_worker_thread+0x10/0x10
[  329.157358]  kthread+0xfc/0x240
[  329.157360]  ? __pfx_kthread+0x10/0x10
[  329.157361]  ? __pfx_kthread+0x10/0x10
[  329.157362]  ret_from_fork+0x1c1/0x1f0
[  329.157365]  ? __pfx_kthread+0x10/0x10
[  329.157366]  ret_from_fork_asm+0x1a/0x30

Reproduction Steps:
Format 10 NVMe drives with XFS and run 3 concurrent 100GB file reads on each
drive.
Format 1 NVMe drive with EXT4 and run 256 concurrent operations for creating
files and folders, as well as adding and deleting xattrs (the issue can als=
o be
reproduced with 192 concurrent operations, though the probability is lower).

cpuinfo=EF=BC=9A
# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                192
On-line CPU(s) list:   0-191
Thread(s) per core:    2
Core(s) per socket:    96
Socket(s):             1
NUMA node(s):          2
Vendor ID:             AuthenticAMD
CPU family:            25
Model:                 17
Model name:            AMD EPYC 9A14 96-Core Processor
Stepping:              1
CPU MHz:               3699.375
CPU max MHz:           3703.3760
CPU min MHz:           1500.0000
BogoMIPS:              5200.37
Virtualization:        AMD-V
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              32768K
NUMA node0 CPU(s):     0-47,96-143
NUMA node1 CPU(s):     48-95,144-191
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe=
1gb
rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl xtopology nonstop_tsc cpuid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 pcid sse4_1
sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topo=
ext
perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpuid_fault cpb cat_l3 cdp=
_l3
hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgsbase
bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdseed adx smap
avx512ifma clflushopt clwb avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec
xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local user_shstk
avx512_bf16 clzero irperf xsaveerptr rdpru wbnoinvd amd_ppin cppc arat npt =
lbrv
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilt=
er
pfthreshold avic v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi um=
ip
pku ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
avx512_vpopcntdq la57 rdpid overflow_recov succor smca fsrm flush_l1d
debug_swap

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

