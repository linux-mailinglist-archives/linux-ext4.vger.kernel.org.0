Return-Path: <linux-ext4+bounces-9811-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B234B434D3
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A214868AF
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21912BE622;
	Thu,  4 Sep 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ancVb/5n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502642BE029
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972738; cv=none; b=Zi9FlcweVc/fVcSjMd4Sh89tjjvasX9duXOhZSVLkrt/63A3CXOzyTZeH0ni9xVXcuemjFNCj4w/zADZQ3tUwqVOcAzAZu81CjhUWVdFkTifXKpLc3iP5BIDIMQhYqyQTfK47B3xgkWHvpoY+cIkenx/vQFl35eCIDsPG24J10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972738; c=relaxed/simple;
	bh=NMMONCEyg/Pqi0Sxi/kUm3Fyl/4wGpZM/hlDJPVTg9g=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=trcrs5JPMxpOMWGpk1pPEVd0/bNdYZBB7L9Ca1JkCT+KPN48uyApsqy4t5gI4yE4p8Djxkn/cAAb7+S0cY7QBzjXgPwxCR6zqCYMTf9B21fQ4BFDKIXZNIM4dvXcrxi3tkIfOwV9x2aU5H0+yvYsvrBY0vea0Ka7ZpIMfFJ7/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ancVb/5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CE81C4CEF7
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972738;
	bh=NMMONCEyg/Pqi0Sxi/kUm3Fyl/4wGpZM/hlDJPVTg9g=;
	h=From:To:Subject:Date:From;
	b=ancVb/5n+VXx6sZJjM67iZx5YNGBGs4TsinXm3VIxtkJRxJGaBbMxbH9PhGn903XG
	 Y+qUyNzIZzaTfTGLxCmnTlllCSY1g6nu97C3Hin3xWHHpehSZfulC8nFVlhrY94gpG
	 7C8/qjphMlV/5aG71xFz4LnZxivj0AVtw+EqS3z454irpoJDn6mwdP1Gx4uw4r24vl
	 8tTVOxMutD5HxZ6v9ErHljB+th4YvbeWzUpHXOKsQvRlGIF4KZqdaebMGpxinnBlQv
	 37UV8bqgbjCj7cQibBxr6cQp2rkphpmQZQEQdQb1AZlYyNAqQCbl5olMobTVB0GtpN
	 PrLAHrXBq9BLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1C15BC3279F; Thu,  4 Sep 2025 07:58:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220535] New: ext4 __jbd2_log_wait_for_space soft lockup and CPU
 stuck for 134s
Date: Thu, 04 Sep 2025 07:58:57 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-220535-13602@https.bugzilla.kernel.org/>
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

            Bug ID: 220535
           Summary: ext4 __jbd2_log_wait_for_space soft lockup and CPU
                    stuck for 134s
           Product: File System
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: waxihus@gmail.com
        Regression: No

On a three-node storage cluster, running mdtest concurrently causes a soft
lockup that leads to node crash.=20
System load averages spike to ~300=E2=80=93400 and heavy file I/O causes se=
vere memory
churn.=20
The issue reproduces on kernels 5.15.0-189 and 6.4, but does not occur on t=
he
SUSE SP4 (June 2023) kernel.

mdtest command:
mpirun -np 128 --hostfile /root/mpirun-hosts  mdtest -d /cluster_test_dir/ =
-n
10000 -z 1 -b 10 -u -R -w 4096 -e 4096

[ 1503.243551] perf: interrupt took too long (2501 > 2500), lowering
kernel.perf_event_max_sample_rate to 79750
[ 2064.418909] perf: interrupt took too long (3187 > 3126), lowering
kernel.perf_event_max_sample_rate to 62750
[ 2120.339245] BUG: workqueue lockup - pool cpus=3D118 node=3D1 flags=3D0x0=
 nice=3D0
stuck for 32s!
[ 2120.339282] Showing busy workqueues and worker pools:
[ 2120.339300] workqueue events: flags=3D0x0
[ 2120.339327]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[ 2120.339331]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[ 2120.339484] workqueue mm_percpu_wq: flags=3D0x8
[ 2120.339488]   pwq 236: cpus=3D118 node=3D1 flags=3D0x0 nice=3D0 active=
=3D3/256
refcnt=3D6
[ 2120.339490]     pending: vmstat_update, lru_add_drain_per_cpu BAR(853),
drain_local_pages_wq BAR(3933)
[ 2120.339516]   pwq 120: cpus=3D60 node=3D1 flags=3D0x0 nice=3D0 active=3D=
1/256 refcnt=3D2
[ 2120.339519]     pending: vmstat_update
[ 2120.339624] workqueue writeback: flags=3D0x4a
[ 2120.339625]   pwq 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0
active=3D1/256 refcnt=3D2
[ 2120.339629]     in-flight: 26886:wb_workfn
[ 2120.339670] workqueue kblockd: flags=3D0x18
[ 2120.339673]   pwq 237: cpus=3D118 node=3D1 flags=3D0x0 nice=3D-20 active=
=3D1/256
refcnt=3D2
[ 2120.339675]     pending: blk_mq_timeout_work
[ 2120.342089] workqueue yrfs_xq:30648e4: flags=3D0xa
[ 2120.342091]   pwq 257: cpus=3D0-31,64-95 node=3D0 flags=3D0x4 nice=3D0 a=
ctive=3D1/128
refcnt=3D2
[ 2120.342095]     in-flight: 28216:yrfs_ops_update_all_osds_capacity_work
[yrfs]
[ 2120.342179] pool 257: cpus=3D0-31,64-95 node=3D0 flags=3D0x4 nice=3D0 hu=
ng=3D0s
workers=3D8 idle: 48356 20446 785 831 821 786 825
[ 2120.342187] pool 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0 =
hung=3D0s
workers=3D8 idle: 47239 807 826 55340 34878 804 20445
[ 2120.342196] Showing backtraces of running workers in stalled CPU-bound
worker pools:
[ 2243.225831] BUG: workqueue lockup - pool cpus=3D45 node=3D1 flags=3D0x0 =
nice=3D0
stuck for 38s!
[ 2243.225883] Showing busy workqueues and worker pools:
[ 2243.225896] workqueue events: flags=3D0x0
[ 2243.225918]   pwq 90: cpus=3D45 node=3D1 flags=3D0x0 nice=3D0 active=3D1=
/256 refcnt=3D2
[ 2243.225922]     pending: mlx5e_rx_dim_work [mlx5_core]
[ 2243.226028]   pwq 54: cpus=3D27 node=3D0 flags=3D0x0 nice=3D0 active=3D1=
/256 refcnt=3D2
[ 2243.226031]     pending: mlx5e_rx_dim_work [mlx5_core]
[ 2243.226100]   pwq 0: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 active=3D1/2=
56 refcnt=3D2
[ 2243.226103]     pending: drm_fb_helper_damage_work [drm_kms_helper]
[ 2243.226271] workqueue mm_percpu_wq: flags=3D0x8
[ 2243.226291]   pwq 90: cpus=3D45 node=3D1 flags=3D0x0 nice=3D0 active=3D2=
/256 refcnt=3D4
[ 2243.226293]     pending: drain_local_pages_wq BAR(853), vmstat_update
[ 2243.226304]   pwq 56: cpus=3D28 node=3D0 flags=3D0x0 nice=3D0 active=3D1=
/256 refcnt=3D2
[ 2243.226306]     pending: vmstat_update
[ 2243.226405] workqueue writeback: flags=3D0x4a
[ 2243.226407]   pwq 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0
active=3D1/256 refcnt=3D2
[ 2243.226411]     in-flight: 26886:wb_workfn
[ 2243.226463] workqueue kblockd: flags=3D0x18
[ 2243.226482]   pwq 91: cpus=3D45 node=3D1 flags=3D0x0 nice=3D-20 active=
=3D1/256
refcnt=3D2
[ 2243.226485]     pending: blk_mq_timeout_work
[ 2243.229035] pool 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0 =
hung=3D0s
workers=3D7 idle: 34878 62315 826 55340 807 47239
[ 2243.229046] Showing backtraces of running workers in stalled CPU-bound
worker pools:
[ 2269.951231] rcu: INFO: rcu_preempt self-detected stall on CPU
[ 2269.951257] rcu:     45-....: (14999 ticks this GP)
idle=3D346/1/0x4000000000000000 softirq=3D270824/270824 fqs=3D5063=20
[ 2269.951284]  (t=3D15000 jiffies g=3D378937 q=3D2931783)
[ 2269.951288] NMI backtrace for cpu 45
[ 2269.951290] CPU: 45 PID: 26886 Comm: kworker/u258:1 Kdump: loaded Tainte=
d: G
S         OE  X  N 5.14.21-20250107.el7.x86_64 #1 SLE15-SP5 (unreleased)
d1123ed60f76c89394d27d1f68f473498cc063b4
[ 2269.951295] Hardware name: ASUSTeK COMPUTER INC. RS720-E11-RS24U/Z13PP-D=
32
Series, BIOS 2801 12/11/2024
[ 2269.951297] Workqueue: writeback wb_workfn (flush-259:17)
[ 2269.951305] Call Trace:
[ 2269.951309]  <IRQ>
[ 2269.951314]  dump_stack_lvl+0x58/0x7b
[ 2269.951320]  nmi_cpu_backtrace+0xf2/0x110
[ 2269.951326]  ? lapic_can_unplug_cpu+0xa0/0xa0
[ 2269.951331]  nmi_trigger_cpumask_backtrace+0xf2/0x140
[ 2269.951334]  rcu_dump_cpu_stacks+0xc8/0xfc
[ 2269.951338]  rcu_sched_clock_irq+0x9b1/0xe50
[ 2269.951345]  ? task_tick_fair+0x158/0x410
[ 2269.951349]  ? sched_clock_cpu+0x9/0xb0
[ 2269.951353]  ? trigger_load_balance+0x62/0x370
[ 2269.951356]  ? tick_sched_handle.isra.20+0x60/0x60
[ 2269.951359]  update_process_times+0x8c/0xb0
[ 2269.951363]  tick_sched_handle.isra.20+0x1d/0x60
[ 2269.951365]  tick_sched_timer+0x67/0x80
[ 2269.951367]  __hrtimer_run_queues+0x10b/0x2a0
[ 2269.951371]  hrtimer_interrupt+0xe5/0x250
[ 2269.951373]  __sysvec_apic_timer_interrupt+0x5a/0x130
[ 2269.951378]  sysvec_apic_timer_interrupt+0x4b/0x90
[ 2269.951382]  </IRQ>
[ 2269.951383]  <TASK>
[ 2269.951384]  asm_sysvec_apic_timer_interrupt+0x4d/0x60
[ 2269.951389] RIP: 0010:native_queued_spin_lock_slowpath+0x19d/0x1e0
[ 2269.951393] Code: c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6 48 05 =
40
47 03 00 48 03 04 f5 20 fc 03 a5 48 89 10 8b 42 08 85 c0 75 09 f3 90 <8b> 4=
2 08
85 c0 74 f7 48 8b 32 48 85 f6 74 94 0f 0d 0e eb 8f 8b 07
[ 2269.951395] RSP: 0000:ff730c07d357b8b0 EFLAGS: 00000246
[ 2269.951397] RAX: 0000000000000000 RBX: ff4364ec52698f08 RCX:
0000000000b80000
[ 2269.951399] RDX: ff4365197e374740 RSI: 000000000000005a RDI:
ff4364fbaa882450
[ 2269.951400] RBP: ff4364fd31d162d0 R08: 0000000000b80000 R09:
ffa50c073f167ac0
[ 2269.951401] R10: ff730c07d357b830 R11: 0000000000000000 R12:
ff4364fb339c8900
[ 2269.951402] R13: ff4364fbaa882000 R14: ff4364fbaa882450 R15:
0000000000a587a5
[ 2269.951405]  _raw_spin_lock+0x25/0x30
[ 2269.951409]  jbd2_log_do_checkpoint+0x149/0x300 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2269.951421]  __jbd2_log_wait_for_space+0xf1/0x1e0 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2269.951427]  add_transaction_credits+0x188/0x290 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2269.951432]  start_this_handle+0x107/0x530 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2269.951438]  ? kmem_cache_alloc+0x39c/0x4e0
[ 2269.951441]  jbd2__journal_start+0xf4/0x1f0 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2269.951447]  __ext4_journal_start_sb+0x105/0x120 [ext4
9b921105c859c08f218cdec280983ebbdfc1b3c6]
[ 2269.951480]  ext4_writepages+0x496/0xd30 [ext4
9b921105c859c08f218cdec280983ebbdfc1b3c6]
[ 2269.951501]  ? update_sd_lb_stats.constprop.149+0xfb/0x8e0
[ 2269.951505]  do_writepages+0xd2/0x1b0
[ 2269.951509]  ? fprop_reflect_period_percpu.isra.7+0x70/0xb0
[ 2269.951512]  __writeback_single_inode+0x41/0x350
[ 2269.951517]  writeback_sb_inodes+0x1d7/0x460
[ 2269.951520]  __writeback_inodes_wb+0x5f/0xd0
[ 2269.951523]  wb_writeback+0x235/0x2d0
[ 2269.951526]  wb_workfn+0x205/0x4a0
[ 2269.951528]  ? finish_task_switch+0x8a/0x2d0
[ 2269.951532]  process_one_work+0x264/0x440
[ 2269.951536]  worker_thread+0x2d/0x3c0
[ 2269.951538]  ? process_one_work+0x440/0x440
[ 2269.951540]  kthread+0x154/0x180
[ 2269.951543]  ? set_kthread_struct+0x50/0x50
[ 2269.951544]  ret_from_fork+0x1f/0x30
[ 2269.951549]  </TASK>
[ 2304.669118] BUG: workqueue lockup - pool cpus=3D45 node=3D1 flags=3D0x0 =
nice=3D0
stuck for 99s!
[ 2304.669152] BUG: workqueue lockup - pool cpus=3D45 node=3D1 flags=3D0x0 =
nice=3D-20
stuck for 87s!
[ 2304.669188] Showing busy workqueues and worker pools:
[ 2304.669201] workqueue events: flags=3D0x0
[ 2304.669222]   pwq 90: cpus=3D45 node=3D1 flags=3D0x0 nice=3D0 active=3D2=
/256 refcnt=3D3
[ 2304.669227]     pending: mlx5e_rx_dim_work [mlx5_core],
drm_fb_helper_damage_work [drm_kms_helper]
[ 2304.669497] workqueue mm_percpu_wq: flags=3D0x8
[ 2304.669517]   pwq 90: cpus=3D45 node=3D1 flags=3D0x0 nice=3D0 active=3D2=
/256 refcnt=3D4
[ 2304.669520]     pending: drain_local_pages_wq BAR(853), vmstat_update
[ 2304.669627] workqueue writeback: flags=3D0x4a
[ 2304.669628]   pwq 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0
active=3D1/256 refcnt=3D2
[ 2304.669633]     in-flight: 26886:wb_workfn
[ 2304.669685] workqueue kblockd: flags=3D0x18
[ 2304.669706]   pwq 91: cpus=3D45 node=3D1 flags=3D0x0 nice=3D-20 active=
=3D1/256
refcnt=3D2
[ 2304.669709]     pending: blk_mq_timeout_work
[ 2304.672268] pool 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0 =
hung=3D0s
workers=3D7 idle: 62315 55340 47239 34878 807 826
[ 2304.672278] Showing backtraces of running workers in stalled CPU-bound
worker pools:
[ 2335.390761] BUG: workqueue lockup - pool cpus=3D45 node=3D1 flags=3D0x0 =
nice=3D0
stuck for 130s!
[ 2335.390793] BUG: workqueue lockup - pool cpus=3D45 node=3D1 flags=3D0x0 =
nice=3D-20
stuck for 118s!
[ 2335.390830] Showing busy workqueues and worker pools:
[ 2335.390832] workqueue events: flags=3D0x0
[ 2335.390835]   pwq 242: cpus=3D121 node=3D1 flags=3D0x0 nice=3D0 active=
=3D1/256
refcnt=3D2
[ 2335.390839]     pending: kfree_rcu_monitor
[ 2335.390863]   pwq 92: cpus=3D46 node=3D1 flags=3D0x0 nice=3D0 active=3D1=
/256 refcnt=3D2
[ 2335.390866]     pending: kfree_rcu_monitor
[ 2335.390869]   pwq 90: cpus=3D45 node=3D1 flags=3D0x0 nice=3D0 active=3D4=
/256 refcnt=3D5
[ 2335.390872]     pending: mlx5e_rx_dim_work [mlx5_core],
drm_fb_helper_damage_work [drm_kms_helper], mlx5e_tx_dim_work [mlx5_core],
mlx5e_tx_dim_work [mlx5_core]
[ 2335.391266] workqueue mm_percpu_wq: flags=3D0x8
[ 2335.391287]   pwq 90: cpus=3D45 node=3D1 flags=3D0x0 nice=3D0 active=3D2=
/256 refcnt=3D4
[ 2335.391289]     pending: drain_local_pages_wq BAR(853), vmstat_update
[ 2335.391301]   pwq 32: cpus=3D16 node=3D0 flags=3D0x0 nice=3D0 active=3D1=
/256 refcnt=3D2
[ 2335.391304]     pending: vmstat_update
[ 2335.391399] workqueue writeback: flags=3D0x4a
[ 2335.391401]   pwq 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0
active=3D1/256 refcnt=3D2
[ 2335.391405]     in-flight: 26886:wb_workfn
[ 2335.391457] workqueue kblockd: flags=3D0x18
[ 2335.391476]   pwq 91: cpus=3D45 node=3D1 flags=3D0x0 nice=3D-20 active=
=3D1/256
refcnt=3D2
[ 2335.391478]     pending: blk_mq_timeout_work
[ 2335.393980] pool 258: cpus=3D32-63,96-127 node=3D1 flags=3D0x4 nice=3D0 =
hung=3D0s
workers=3D7 idle: 47239 55340 62315 34878 807 826
[ 2335.393990] Showing backtraces of running workers in stalled CPU-bound
worker pools:
[ 2346.279770] watchdog: BUG: soft lockup - CPU#45 stuck for 134s!
[kworker/u258:1:26886]
[ 2346.279798] Modules linked in: yrfs(OEN) cpufreq_conservative(EN) ip_vs(=
EN)
uio_pci_generic(EN) uio(EN) vfio_pci(EN) vfio_pci_core(EN) nf_conntrack(EN)
vfio_virqfd(EN) vfio_iommu_type1(EN) vfio(EN) cuse(EN) fuse(EN) msr(EN)
nf_defrag_ipv6(EN) nbd(EN) nf_defrag_ipv4(EN) af_packet(EN) rdma_ucm(OEX)
intel_rapl_msr(EN) rdma_cm(OEX) iw_cm(OEX) configfs(EN) intel_rapl_common(E=
N)
intel_uncore_frequency(EN) intel_uncore_frequency_common(EN) ib_ipoib(OEX)
i10nm_edac(EN) nfit(EN) ib_cm(OEX) libnvdimm(EN) x86_pkg_temp_thermal(EN)
coretemp(EN) lockd(EN) cdc_ether(EN) sd_mod(EN) ib_umad(OEX) kvm_intel(EN)
usbnet(EN) grace(EN) xfs(EN) sg(EN) libcrc32c(EN) sunrpc(EN) mii(EN) kvm(EN)
iTCO_wdt(EN) intel_pmc_bxt(EN) iTCO_vendor_support(EN) irqbypass(EN)
mfd_core(EN) crc32_pclmul(EN) ghash_clmulni_intel(EN) mlx5_ib(OEX)
nls_iso8859_1(EN) pmt_crashlog(EN) nls_cp437(EN) pmt_telemetry(EN)
ib_uverbs(OEX) wmi_bmof(EN) vfat(EN) aesni_intel(EN) i2c_i801(EN) idxd(EN)
intel_sdsi(EN) pmt_class(EN)
[ 2346.279851]  isst_if_mmio(EN) mei_me(EN) isst_if_mbox_pci(EN)
crypto_simd(EN) fat(EN) cryptd(EN) efi_pstore(EN) pcspkr(EN) ib_core(OEX)
intel_vsec(EN) idxd_bus(EN) isst_if_common(EN) mei(EN) i2c_smbus(EN)
i2c_ismt(EN) vmd(EN) wmi(EN) joydev(EN) acpi_ipmi(EN) ipmi_si(EN)
ipmi_devintf(EN) ipmi_msghandler(EN) cxl_acpi(EN) cxl_core(EN)
pinctrl_emmitsburg(EN) acpi_power_meter(EN) hid_generic(EN) button(EN)
usbhid(EN) knem(OEX) efivarfs(EN) ip_tables(EN) x_tables(EN) uas(EN)
usb_storage(EN) ext4(EN) crc16(EN) mbcache(EN) jbd2(EN) ast(EN)
drm_vram_helper(EN) drm_ttm_helper(EN) mlx5_core(OEX) ttm(EN) nvme(EN)
pci_hyperv_intf(EN) drm_kms_helper(EN) psample(EN) ahci(EN) syscopyarea(EN)
mlxdevm(OEX) nvme_core(EN) xhci_pci(EN) sysfillrect(EN) libahci(EN)
sysimgblt(EN) mlx_compat(OEX) xhci_pci_renesas(EN) nvme_common(EN)
fb_sys_fops(EN) igb(EN) mlxfw(OEX) t10_pi(EN) libata(EN) xhci_hcd(EN) dca(E=
N)
crc64_rocksoft(EN) drm(EN) crc32c_intel(EN) usbcore(EN) scsi_mod(EN) tls(EN)
[ 2346.279904]  i2c_algo_bit(EN) crc64(EN) xpmem(OEX)
[ 2346.279907] Supported: No, Unreleased kernel
[ 2346.279909] CPU: 45 PID: 26886 Comm: kworker/u258:1 Kdump: loaded Tainte=
d: G
S         OE  X  N 5.14.21-20250107.el7.x86_64 #1 SLE15-SP5 (unreleased)
d1123ed60f76c89394d27d1f68f473498cc063b4
[ 2346.279914] Hardware name: ASUSTeK COMPUTER INC. RS720-E11-RS24U/Z13PP-D=
32
Series, BIOS 2801 12/11/2024
[ 2346.279916] Workqueue: writeback wb_workfn (flush-259:17)
[ 2346.279923] RIP: 0010:native_queued_spin_lock_slowpath+0x19d/0x1e0
[ 2346.279929] Code: c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6 48 05 =
40
47 03 00 48 03 04 f5 20 fc 03 a5 48 89 10 8b 42 08 85 c0 75 09 f3 90 <8b> 4=
2 08
85 c0 74 f7 48 8b 32 48 85 f6 74 94 0f 0d 0e eb 8f 8b 07
[ 2346.279931] RSP: 0000:ff730c07d357b8b0 EFLAGS: 00000246
[ 2346.279934] RAX: 0000000000000000 RBX: ff4364ebccbed750 RCX:
0000000000b80000
[ 2346.279936] RDX: ff4365197e374740 RSI: 000000000000003f RDI:
ff4364fbaa882450
[ 2346.279937] RBP: ff4365013b9f3e00 R08: 0000000000b80000 R09:
0000000000000000
[ 2346.279938] R10: ff730c07d357b830 R11: 0000000000000000 R12:
ff4364fb339c8900
[ 2346.279939] R13: ff4364fbaa882000 R14: ff4364fbaa882450 R15:
0000000000a587a5
[ 2346.279940] FS:  0000000000000000(0000) GS:ff4365197e340000(0000)
knlGS:0000000000000000
[ 2346.279941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2346.279942] CR2: 00007f70c5710000 CR3: 00000018bc610002 CR4:
0000000000771ee0
[ 2346.279944] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[ 2346.279945] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
0000000000000400
[ 2346.279946] PKRU: 55555554
[ 2346.279946] Call Trace:
[ 2346.279950]  <TASK>
[ 2346.279952]  _raw_spin_lock+0x25/0x30
[ 2346.279956]  jbd2_log_do_checkpoint+0x149/0x300 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.279969]  __jbd2_log_wait_for_space+0xf1/0x1e0 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.279975]  add_transaction_credits+0x188/0x290 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.279981]  start_this_handle+0x107/0x530 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.279986]  ? kmem_cache_alloc+0x39c/0x4e0
[ 2346.279990]  jbd2__journal_start+0xf4/0x1f0 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.279996]  __ext4_journal_start_sb+0x105/0x120 [ext4
9b921105c859c08f218cdec280983ebbdfc1b3c6]
[ 2346.280027]  ext4_writepages+0x496/0xd30 [ext4
9b921105c859c08f218cdec280983ebbdfc1b3c6]
[ 2346.280049]  ? update_sd_lb_stats.constprop.149+0xfb/0x8e0
[ 2346.280054]  do_writepages+0xd2/0x1b0
[ 2346.280058]  ? fprop_reflect_period_percpu.isra.7+0x70/0xb0
[ 2346.280063]  __writeback_single_inode+0x41/0x350
[ 2346.280067]  writeback_sb_inodes+0x1d7/0x460
[ 2346.280071]  __writeback_inodes_wb+0x5f/0xd0
[ 2346.280074]  wb_writeback+0x235/0x2d0
[ 2346.280077]  wb_workfn+0x205/0x4a0
[ 2346.280079]  ? finish_task_switch+0x8a/0x2d0
[ 2346.280083]  process_one_work+0x264/0x440
[ 2346.280087]  worker_thread+0x2d/0x3c0
[ 2346.280089]  ? process_one_work+0x440/0x440
[ 2346.280091]  kthread+0x154/0x180
[ 2346.280094]  ? set_kthread_struct+0x50/0x50
[ 2346.280096]  ret_from_fork+0x1f/0x30
[ 2346.280100]  </TASK>
[ 2346.280102] Kernel panic - not syncing: softlockup: hung tasks
[ 2346.280117] CPU: 45 PID: 26886 Comm: kworker/u258:1 Kdump: loaded Tainte=
d: G
S         OEL X  N 5.14.21-20250107.el7.x86_64 #1 SLE15-SP5 (unreleased)
d1123ed60f76c89394d27d1f68f473498cc063b4
[ 2346.280147] Hardware name: ASUSTeK COMPUTER INC. RS720-E11-RS24U/Z13PP-D=
32
Series, BIOS 2801 12/11/2024
[ 2346.280163] Workqueue: writeback wb_workfn (flush-259:17)
[ 2346.280175] Call Trace:
[ 2346.280184]  <IRQ>
[ 2346.280191]  dump_stack_lvl+0x58/0x7b
[ 2346.280201]  panic+0x118/0x2f0
[ 2346.280213]  watchdog_timer_fn+0x1f1/0x210
[ 2346.280225]  ? softlockup_fn+0x30/0x30
[ 2346.280234]  __hrtimer_run_queues+0x10b/0x2a0
[ 2346.280246]  hrtimer_interrupt+0xe5/0x250
[ 2346.280257]  __sysvec_apic_timer_interrupt+0x5a/0x130
[ 2346.280271]  sysvec_apic_timer_interrupt+0x4b/0x90
[ 2346.280283]  </IRQ>
[ 2346.280289]  <TASK>
[ 2346.280296]  asm_sysvec_apic_timer_interrupt+0x4d/0x60
[ 2346.280309] RIP: 0010:native_queued_spin_lock_slowpath+0x19d/0x1e0
[ 2346.280322] Code: c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6 48 05 =
40
47 03 00 48 03 04 f5 20 fc 03 a5 48 89 10 8b 42 08 85 c0 75 09 f3 90 <8b> 4=
2 08
85 c0 74 f7 48 8b 32 48 85 f6 74 94 0f 0d 0e eb 8f 8b 07
[ 2346.280350] RSP: 0000:ff730c07d357b8b0 EFLAGS: 00000246
[ 2346.280361] RAX: 0000000000000000 RBX: ff4364ebccbed750 RCX:
0000000000b80000
[ 2346.280374] RDX: ff4365197e374740 RSI: 000000000000003f RDI:
ff4364fbaa882450
[ 2346.280386] RBP: ff4365013b9f3e00 R08: 0000000000b80000 R09:
0000000000000000
[ 2346.280399] R10: ff730c07d357b830 R11: 0000000000000000 R12:
ff4364fb339c8900
[ 2346.280411] R13: ff4364fbaa882000 R14: ff4364fbaa882450 R15:
0000000000a587a5
[ 2346.280425]  _raw_spin_lock+0x25/0x30
[ 2346.280434]  jbd2_log_do_checkpoint+0x149/0x300 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.280455]  __jbd2_log_wait_for_space+0xf1/0x1e0 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.280474]  add_transaction_credits+0x188/0x290 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.280495]  start_this_handle+0x107/0x530 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.280513]  ? kmem_cache_alloc+0x39c/0x4e0
[ 2346.280524]  jbd2__journal_start+0xf4/0x1f0 [jbd2
fe085bf250f00c1909bc8f60167717c81ef52839]
[ 2346.280543]  __ext4_journal_start_sb+0x105/0x120 [ext4
9b921105c859c08f218cdec280983ebbdfc1b3c6]
[ 2346.280986]  ext4_writepages+0x496/0xd30 [ext4
9b921105c859c08f218cdec280983ebbdfc1b3c6]
[ 2346.281361]  ? update_sd_lb_stats.constprop.149+0xfb/0x8e0
[ 2346.281706]  do_writepages+0xd2/0x1b0
[ 2346.282035]  ? fprop_reflect_period_percpu.isra.7+0x70/0xb0
[ 2346.282370]  __writeback_single_inode+0x41/0x350
[ 2346.282687]  writeback_sb_inodes+0x1d7/0x460
[ 2346.283007]  __writeback_inodes_wb+0x5f/0xd0
[ 2346.283322]  wb_writeback+0x235/0x2d0
[ 2346.283612]  wb_workfn+0x205/0x4a0
[ 2346.283908]  ? finish_task_switch+0x8a/0x2d0
[ 2346.284195]  process_one_work+0x264/0x440
[ 2346.284487]  worker_thread+0x2d/0x3c0
[ 2346.284762]  ? process_one_work+0x440/0x440
[ 2346.285045]  kthread+0x154/0x180
[ 2346.285317]  ? set_kthread_struct+0x50/0x50
[ 2346.285576]  ret_from_fork+0x1f/0x30
[ 2346.285830]  </TASK>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

