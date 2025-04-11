Return-Path: <linux-ext4+bounces-7212-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952FA86902
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Apr 2025 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D027446EC7
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Apr 2025 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E198278E7D;
	Fri, 11 Apr 2025 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UCj14d9u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FA1C8639
	for <linux-ext4@vger.kernel.org>; Fri, 11 Apr 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744412331; cv=none; b=uavBe8EXnSvJ3IXgpUrgk0Ecs9l15xhKO0qcLh/KA4YrrEVXe1gRuwRbIEWmgmeee943MU8VMqK1PaDIRUClTUwwcgNnFbS4qqHWFFSJ0WRUVndsaLDEeJD0VD+ug1AAC8apd/k4ZrCFOkcWICJxrciIBIpmZT4QoHADwVOvvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744412331; c=relaxed/simple;
	bh=Rvwz6B7WjQ9aS+mIrbXocavpS12R/CsRW6l3SMPPqfc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=fRsMtPNeyIqxyC9hpGb0gG9H+f2xTN1QO8l4v6nAxj4J/8ANEPD7YydjeBFnsdzCrU80TSR2CkEOF77xXF+Jra9RcNfckopwxZu+miI15pEV3YzyzmrfqpQK5oxrqBqTA6JcdpyFdktWbMk74VppVGBpntpQvd/7BYTiOH3kNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UCj14d9u; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ji3x6277x5bxxml7rukr6767uy.protonmail; t=1744412320; x=1744671520;
	bh=WiyRGCHozQCIhlkks3OkNbFo4ayxAfDGHp7A6vFvypQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=UCj14d9udVhZI2/AfzbJ/ElUEZolshM8DXHoO/yhn1wEvA2Hf02V4jEMGe4xpr3/J
	 uOxqkbff0UsIOqIS3XaRLSuVFzufJVV89LNtWlYwBKMXSu5OOrD1XmYRr/ZR99ga+H
	 IbBuU5f0usPUpvrE1pH/+PlgALx3d+8rJX8zH6uGmsPpKYE0avz97rkZvNpAzizjtp
	 oTffnagdsLxmAWTE81Vk2UUdmUvi1SSxv67KxxZwwD6iVRl62tVxiu/3MnPkJRvj1I
	 gcPMAPolHzU3tT4X8hmJYlyY2nLw5TzCuYEYy7+06k8XOv2UnFubw8R36V60/4oJCs
	 kT3om0kBwi4cQ==
Date: Fri, 11 Apr 2025 22:58:36 +0000
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
From: Charith Amarasinghe <char8@proton.me>
Subject: 6.12 stuck jbd2 kernel task
Message-ID: <66m4l71s4ANfMiUZejbuy4I10428c0I-mROXkkvtD_frTsEzhb7xgh-H3ugGl_K5wr3IOo3hjfNKerH_70pQ5MO1w34m-12cIPacpZMi9Cg=@proton.me>
Feedback-ID: 49408879:user:proton
X-Pm-Message-ID: 5bcc32143fe4cf93388f8d05a5985ea896bc39ef
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

We're running ext4 filesystems on top ZFS Zvols on top of a Ceph RBD. This =
is a weird/convoluted configuration, but works for the most part.

We've recently seen lockups of processes on specific ext4 file systems (low=
 %es). We see various tasks stuck in uninterruptible sleep (D process state=
 flag), all of them with stacktraces in ext4 functions.

We got these with=C2=A0`echo w > /proc/sysrq-trigger`. We think this starts=
 in a [jbd2/zbd-XXX] kernel task, stack trace below:

Any help in isolating/identifying/mitigating this problem would be apprecia=
ted.

We can't find any indicators to relate this to ZFS or Ceph so we think its =
a ext4 issue. We don't know what triggers it.

-------- log extract --------
[425499.839903] task:jbd2/zd4512-8   state:D stack:0     pid:79548 tgid:795=
48 ppid:2      flags:0x00004000
[425499.841648] Call Trace:
[425499.842266]  <TASK>
[425499.842781]  __schedule+0x403/0xbf0
[425499.843593]  schedule+0x27/0xf0
[425499.844245]  jbd2_journal_wait_updates+0x76/0xe0
[425499.845252]  ? __pfx_autoremove_wake_function+0x10/0x10
[425499.846425]  jbd2_journal_commit_transaction+0x26d/0x1b90
[425499.847538]  ? kvm_sched_clock_read+0x11/0x20
[425499.848449]  ? kvm_sched_clock_read+0x11/0x20
[425499.849385]  ? sched_clock+0x10/0x30
[425499.850137]  ? sched_clock_cpu+0xf/0x190
[425499.850913]  ? psi_task_switch+0xb7/0x200
[425499.851705]  ? __timer_delete_sync+0x85/0xf0
[425499.852557]  kjournald2+0xac/0x250
[425499.853271]  ? __pfx_autoremove_wake_function+0x10/0x10
[425499.854254]  ? __pfx_kjournald2+0x10/0x10
[425499.855048]  kthread+0xcf/0x100
[425499.855699]  ? __pfx_kthread+0x10/0x10
[425499.856444]  ret_from_fork+0x31/0x50
[425499.857175]  ? __pfx_kthread+0x10/0x10
[425499.857917]  ret_from_fork_asm+0x1a/0x30
[425499.858719]  </TASK>
-------- end --------

We see the process that was writing into this zvol also stuck, stacktrace b=
elow
-------- log extract --------
[425499.859242] task:mysqld          state:D stack:0     pid:79670 tgid:796=
70 ppid:79555  flags:0x00004006
[425499.860904] Call Trace:
[425499.861454]  <TASK>
[425499.861961]  __schedule+0x403/0xbf0
[425499.862704]  schedule+0x27/0xf0
[425499.863364]  jbd2_log_wait_commit+0xd7/0x140
[425499.864192]  ? __pfx_autoremove_wake_function+0x10/0x10
[425499.865179]  ext4_sync_file+0x1cb/0x370                                =
                                                                           =
                                                                [425499.865=
937]  do_fsync+0x3a/0x70
[425499.866626]  ? syscall_trace_enter+0x90/0x190
[425499.867475]  __x64_sys_fdatasync+0x16/0x20
[425499.870633]  do_syscall_64+0x82/0x160
[425499.871376]  ? do_fault+0x281/0x4d0
[425499.872073]  ? __handle_mm_fault+0x7b8/0xfd0
[425499.872909]  ? __count_memcg_events+0x53/0xf0
[425499.873742]  ? count_memcg_events.constprop.0+0x1a/0x30
[425499.874744]  ? handle_mm_fault+0xae/0x2d0
[425499.875517]  ? do_user_addr_fault+0x379/0x670
[425499.876341]  ? clear_bhb_loop+0x55/0xb0
[425499.877099]  ? clear_bhb_loop+0x55/0xb0
[425499.877852]  ? clear_bhb_loop+0x55/0xb0
[425499.878634]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[425499.879575] RIP: 0033:0x7ff3a8b9b177
[425499.880279] RSP: 002b:00007ffe8cda2dd8 EFLAGS: 00000246 ORIG_RAX: 00000=
0000000004b
[425499.881645] RAX: ffffffffffffffda RBX: 00007ffe8cda2f10 RCX: 00007ff3a8=
b9b177
[425499.882966] RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000=
000003
[425499.884257] RBP: 00007ffe8cda2ea0 R08: 0000000000000038 R09: 0000000000=
000014
[425499.885554] R10: 00007ff3a8aa5348 R11: 0000000000000246 R12: 0000000000=
000003
[425499.888869] R13: 0000000000000010 R14: 00000000024972ac R15: 00007ffe8c=
da3220
[425499.890795]  </TASK>
------ end ------

Any other processes that attempt to touch this device, eg processes calling=
 the mount syscall are also stuck in uninterruptible sleep.
------- log ---------
[425634.387016] task:appl state:D stack:0     pid:5486  tgid:48022 ppid:1  =
    flags:0x00000006
[425634.391820] Call Trace:
[425634.392598]  <TASK>
[425634.393288]  __schedule+0x403/0xbf0
[425634.394299]  schedule+0x27/0xf0
[425634.395241]  schedule_preempt_disabled+0x15/0x30
[425634.396507]  rwsem_down_write_slowpath+0x282/0x600
[425634.397682]  ? __pfx_super_s_dev_set+0x10/0x10
[425634.398984]  down_write+0x5a/0x60
[425634.399984]  super_lock+0x5b/0x150
[425634.401007]  ? __pfx_super_s_dev_test+0x10/0x10
[425634.402328]  ? __pfx_super_s_dev_set+0x10/0x10
[425634.403214]  grab_super+0x42/0x170
[425634.403925]  ? mntput_no_expire+0x4a/0x260
[425634.404721]  ? __pfx_super_s_dev_test+0x10/0x10
[425634.405618]  sget_fc+0x22e/0x410
[425634.406335]  ? __pfx_ext4_fill_super+0x10/0x10
[425634.407216]  get_tree_bdev_flags+0xb1/0x1d0
[425634.408041]  vfs_get_tree+0x26/0xf0
[425634.408743]  path_mount+0x4b1/0xae0
[425634.409460]  __x64_sys_mount+0x117/0x150
[425634.410262]  do_syscall_64+0x82/0x160
[425634.410982]  ? do_syscall_64+0x8e/0x160
[425634.411738]  ? count_memcg_events.constprop.0+0x1a/0x30
[425634.412762]  ? handle_mm_fault+0xae/0x2d0
[425634.413559]  ? do_user_addr_fault+0x379/0x670
[425634.414397]  ? clear_bhb_loop+0x55/0xb0
[425634.415161]  ? clear_bhb_loop+0x55/0xb0
[425634.415927]  ? clear_bhb_loop+0x55/0xb0
[425634.416665]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[425634.417616] RIP: 0033:0x40a58e
[425634.418262] RSP: 002b:000000c0067931b0 EFLAGS: 00000216 ORIG_RAX: 00000=
000000000a5
[425634.419686] RAX: ffffffffffffffda RBX: 000000c009b0a6f0 RCX: 0000000000=
40a58e
[425634.423215] RDX: 000000c003ee68a0 RSI: 000000c007d590a0 RDI: 000000c009=
b0a6f0
[425634.424880] RBP: 000000c0067931f0 R08: 000000c003ee6888 R09: 0000000000=
000000
[425634.426698] R10: 0000000000000000 R11: 0000000000000216 R12: 0000000000=
00008a
[425634.428812] R13: 000000c006880800 R14: 000000c004a9dba0 R15: 0000000000=
000026
[425634.431684]  </TASK>
--------- end --------

Thanks,
C.




