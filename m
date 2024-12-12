Return-Path: <linux-ext4+bounces-5589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C849EE803
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 14:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31530188994F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B220B7FA;
	Thu, 12 Dec 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5Dos4nx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05838396
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011210; cv=none; b=Az0DYpAEznk77n+VO6xSenE9fzYJmOsttWeCpn+YnxF6JBHN/0Rkn95odnDGhouv/6RIOnAd+yuQScnGphwMExBIjM+vI9bNmSd19vvxBY1HdLdqbFqzyL/m2hYC8+3C/ktYoQiUJMzWuU+tdAD+4GxAdNddSV0fIyd3+gyrKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011210; c=relaxed/simple;
	bh=GW1h45qOHHFkD9YbZQv5dDEpb/0qV/w7xoZ+2wWNj1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRuRzh44U0KQx9GXLaWrG0CEyN7xtOGpyCMXlkMSpWGMnFASf2+idEYSFOY4aHI9JM6csdFZbZ1hwUXCIhHUsCzpeK0A0iNI1jR8MoqZBw7LTetkZKq/IvdcEyXEbntmUm+y9thYgrwjrfbLtwl46nAJKBd+MAGPvECsWWOuqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D5Dos4nx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rgt3POqfULleywx8IGxCSUi+J4/0B+ZSPs+3Da/cnJI=; b=D5Dos4nxC5ZP9I+ywCgyCtNClF
	msKj34itXy0P5IujeVFOLO30qrnc68DnXWaLz5n/aPGBXvOzFxw58q4gz5sqblOD9q8qUSvVZZ+v0
	ewHuTZDRE4G5pdqUSdf1sxADvEwPPNo3cL7RkYap5NGQsC8Z2hjIDUG5t38SXV8Lajkc1S1boZW21
	/T9GffInLK16TvDAEmuar+RsybjYtg6WFUwEJpUDnsS5tT0lRc2VY/Hmxp2boRlRmP+sxOdzYY490
	dmH4r4UoHwY9gfJRSGfncrcvolIi5XIuWIMLJ6OLpeql+y77qxNSPFsGPdDKZW0M+TtCYv1vBeJzw
	xARX+p/Q==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLjWU-000000061rC-3HuT;
	Thu, 12 Dec 2024 13:46:34 +0000
Message-ID: <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>, Stefan Hajnoczi
 <stefanha@redhat.com>,  Jason Wang <jasowang@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>,  ming.lei@redhat.com, Petr Mladek
 <pmladek@suse.com>, John Ogness <jogness@linutronix.de>, Peter Zijlstra
 <peterz@infradead.org>
Date: Thu, 12 Dec 2024 13:46:33 +0000
In-Reply-To: <87ldwl9g93.ffs@tglx>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
	 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
	 <20241211124240.GA310916@fedora>
	 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
	 <87ldwl9g93.ffs@tglx>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-RWkRk4tcyg4Gd+jfk8/p"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-RWkRk4tcyg4Gd+jfk8/p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-12-12 at 14:34 +0100, Thomas Gleixner wrote:
>=20
> David, can you retest with the debug patch below? That should pin-point
> the real culprit.

B[    1.545489] ------------[ cut here ]------------
[    1.546338] DEBUG_LOCKS_WARN_ON(suspend_syscore_active)
[    1.546375] WARNING: CPU: 0 PID: 18 at kernel/locking/lockdep.c:4471 loc=
kdep_hardirqs_on+0x13a/0x140
[    1.548658] Modules linked in:
[    1.549164] CPU: 0 UID: 0 PID: 18 Comm: rcu_preempt Not tainted 6.13.0-r=
c1+ #2034
[    1.550421] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.552173] RIP: 0010:lockdep_hardirqs_on+0x13a/0x140
[    1.552918] Code: 85 c9 74 13 8b 15 c6 b8 de 02 85 d2 0f 84 4d ff ff ff =
e9 58 ff ff ff 48 c7 c6 a3 47 e5 bb 48 c7 c7 4c 8f e4 bb e8 96 52 e6 fe <0f=
> 0b eb d6 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[    1.555728] RSP: 0018:ffffbde64009bcc8 EFLAGS: 00010082
[    1.556513] RAX: 0000000000000000 RBX: ffff9d23c18db340 RCX: ffffffffbc7=
82a08
[    1.557579] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00001
[    1.558629] RBP: ffffffffba20fe54 R08: 0000000000000000 R09: 00000000000=
00000
[    1.559683] R10: 0000000000037e0c R11: 0000000000000000 R12: ffff9d23c3a=
18000
[    1.560721] R13: 0000000000000000 R14: ffff9d23c18db340 R15: 00000000000=
00000
[    1.561758] FS:  0000000000000000(0000) GS:ffff9d243d600000(0000) knlGS:=
0000000000000000
[    1.562925] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.563765] CR2: 00007fa03567f070 CR3: 00000000039b0001 CR4: 00000000001=
70ef0
[    1.564825] Call Trace:
[    1.565178]  <TASK>
[    1.565483]  ? __warn.cold+0xb7/0x151
[    1.566009]  ? lockdep_hardirqs_on+0x13a/0x140
[    1.566663]  ? report_bug+0xff/0x140
[    1.567176]  ? console_unlock+0x9d/0x150
[    1.567745]  ? handle_bug+0x58/0x90
[    1.568239]  ? exc_invalid_op+0x17/0x70
[    1.568796]  ? asm_exc_invalid_op+0x1a/0x20
[    1.569411]  ? finish_task_switch.isra.0+0xc4/0x2d0
[    1.570125]  ? lockdep_hardirqs_on+0x13a/0x140
[    1.570759]  ? lockdep_hardirqs_on+0x13a/0x140
[    1.571399]  finish_task_switch.isra.0+0xc4/0x2d0
[    1.572062]  __schedule+0x50a/0x1a10
[    1.572586]  ? find_held_lock+0x2b/0x80
[    1.573125]  ? schedule+0xea/0x140
[    1.573616]  ? __pfx_rcu_gp_kthread+0x10/0x10
[    1.574232]  schedule+0x3a/0x140
[    1.574708]  schedule_timeout+0x91/0x110
[    1.575261]  ? __pfx_process_timeout+0x10/0x10
[    1.575896]  rcu_gp_fqs_loop+0x10b/0x5b0
[    1.576455]  ? _raw_spin_unlock_irq+0x28/0x50
[    1.577072]  rcu_gp_kthread+0xf8/0x1b0
[    1.577621]  kthread+0xd5/0x100
[    1.578066]  ? __pfx_kthread+0x10/0x10
[    1.578606]  ret_from_fork+0x34/0x50
[    1.579110]  ? __pfx_kthread+0x10/0x10
[    1.579661]  ret_from_fork_asm+0x1a/0x30
[    1.580210]  </TASK>
[    1.580533] irq event stamp: 4182
[    1.581000] hardirqs last  enabled at (4181): [<ffffffffbb36b74a>] _raw_=
spin_unlock_irqrestore+0x5a/0x70
[    1.582346] hardirqs last disabled at (4182): [<ffffffffbb35fa37>] __sch=
edule+0xf67/0x1a10
[    1.583504] softirqs last  enabled at (0): [<ffffffffba1b92d7>] copy_pro=
cess+0xac7/0x2ba0
[    1.584651] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.585531] ---[ end trace 0000000000000000 ]---
[    1.586205] ------------[ cut here ]------------
[    1.586863] WARNING: CPU: 0 PID: 18 at kernel/time/timekeeping.c:807 kti=
me_get+0xd6/0x100
[    1.588024] Modules linked in:
[    1.588464] CPU: 0 UID: 0 PID: 18 Comm: rcu_preempt Tainted: G        W =
         6.13.0-rc1+ #2034
[    1.589748] Tainted: [W]=3DWARN
[    1.590162] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.591771] RIP: 0010:ktime_get+0xd6/0x100
[    1.592362] Code: cc cc cc cc 48 d1 e8 48 f7 d0 48 85 c8 74 22 8b 0d 23 =
16 eb 03 83 f9 3f 0f 87 f9 13 d4 ff 48 8b 05 17 16 eb 03 48 d3 e8 eb be <0f=
> 0b e9 40 ff ff ff 48 8b 15 04 16 eb 03 8b 35 fa 15 eb 03 8b 3d
[    1.594979] RSP: 0018:ffffbde64009bb90 EFLAGS: 00010002
[    1.595724] RAX: 0000000000000001 RBX: ffff9d243d639b28 RCX: 00000000000=
00003
[    1.596727] RDX: 00000000ffffff01 RSI: 0000000000000000 RDI: ffff9d243d6=
39b28
[    1.597732] RBP: ffff9d243d6390c0 R08: 0000000000000000 R09: ffff9d243d7=
39bc1
[    1.598735] R10: ffff9d243d627580 R11: 0000000000000000 R12: 000000001cb=
51477
[    1.599736] R13: 00000000972b390b R14: 000000000335a525 R15: 00000000000=
00001
[    1.600750] FS:  0000000000000000(0000) GS:ffff9d243d600000(0000) knlGS:=
0000000000000000
[    1.601871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.602670] CR2: 00007fa03567f070 CR3: 00000000039b0001 CR4: 00000000001=
70ef0
[    1.603669] Call Trace:
[    1.604007]  <TASK>
[    1.604304]  ? __warn.cold+0xb7/0x151
[    1.604811]  ? ktime_get+0xd6/0x100
[    1.605300]  ? report_bug+0xff/0x140
[    1.605794]  ? handle_bug+0x58/0x90
[    1.606276]  ? exc_invalid_op+0x17/0x70
[    1.606813]  ? asm_exc_invalid_op+0x1a/0x20
[    1.607413]  ? ktime_get+0xd6/0x100
[    1.607907]  start_dl_timer+0x7c/0x200
[    1.608433]  update_curr_dl_se+0x1bf/0x1f0
[    1.609002]  update_curr+0x1a6/0x1d0
[    1.609523]  dequeue_entity+0x2b/0x630
[    1.610047]  ? asm_sysvec_kvm_asyncpf_interrupt+0x1a/0x20
[    1.610797]  dequeue_entities+0x113/0x5d0
[    1.611364]  ? __pfx_rcu_gp_kthread+0x10/0x10
[    1.611964]  dequeue_task_fair+0x139/0x2a0
[    1.612539]  ? __pfx_rcu_gp_kthread+0x10/0x10
[    1.613140]  __schedule+0x859/0x1a10
[    1.613636]  ? lock_timer_base+0x2b/0xf0
[    1.614176]  ? lock_acquire+0x2a2/0x310
[    1.614718]  ? lock_release+0x218/0x2c0
[    1.615248]  ? __pfx_rcu_gp_kthread+0x10/0x10
[    1.615861]  schedule+0x3a/0x140
[    1.616317]  schedule_timeout+0x91/0x110
[    1.616859]  ? __pfx_process_timeout+0x10/0x10
[    1.617477]  rcu_gp_fqs_loop+0x10b/0x5b0
[    1.618018]  ? _raw_spin_unlock_irq+0x28/0x50
[    1.618624]  rcu_gp_kthread+0xf8/0x1b0
[    1.619145]  kthread+0xd5/0x100
[    1.619617]  ? __pfx_kthread+0x10/0x10
[    1.620135]  ret_from_fork+0x34/0x50
[    1.620678]  ? __pfx_kthread+0x10/0x10
[    1.621202]  ret_from_fork_asm+0x1a/0x30
[    1.621756]  </TASK>
[    1.622057] irq event stamp: 4183
[    1.622519] hardirqs last  enabled at (4183): [<ffffffffba20fe54>] finis=
h_task_switch.isra.0+0xc4/0x2d0
[    1.623816] hardirqs last disabled at (4182): [<ffffffffbb35fa37>] __sch=
edule+0xf67/0x1a10
[    1.624952] softirqs last  enabled at (0): [<ffffffffba1b92d7>] copy_pro=
cess+0xac7/0x2ba0
[    1.626085] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    1.626958] ---[ end trace 0000000000000000 ]---
[    1.627802] ------------[ cut here ]------------
[    1.628457] Interrupts enabled after irqrouter_resume+0x0/0x50
[    1.629279] WARNING: CPU: 0 PID: 214 at drivers/base/syscore.c:103 sysco=
re_resume+0x18a/0x220
[    1.630485] Modules linked in:
[    1.630901] CPU: 0 UID: 0 PID: 214 Comm: loadret Tainted: G        W    =
      6.13.0-rc1+ #2034
[    1.632088] Tainted: [W]=3DWARN
[    1.632500] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.634079] RIP: 0010:syscore_resume+0x18a/0x220
[    1.634717] Code: 00 e9 21 ff ff ff 80 3d 22 d0 d3 01 00 0f 85 03 ff ff =
ff 48 8b 73 18 48 c7 c7 8d f6 e9 bb c6 05 0a d0 d3 01 01 e8 d6 55 46 ff <0f=
> 0b e9 e5 fe ff ff e8 aa e9 54 ff 84 c0 0f 85 fb fe ff ff 80 3d
[    1.637298] RSP: 0018:ffffbde6402c7b38 EFLAGS: 00010286
[    1.638015] RAX: 0000000000000000 RBX: ffffffffbc9918c0 RCX: ffffffffbc7=
82a08
[    1.638995] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 00000000000=
00001
[    1.639982] RBP: 0000000000037e0c R08: 0000000000000000 R09: 00000000000=
00000
[    1.640961] R10: 0000000000000000 R11: 7075727265746e49 R12: ffffbde6402=
c7b68
[    1.641956] R13: ffffffffbc68ebe0 R14: 00000000fee1dead R15: 00000000000=
00000
[    1.642933] FS:  00007fed47db1680(0000) GS:ffff9d243d600000(0000) knlGS:=
0000000000000000
[    1.644036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.644825] CR2: 00007fa03567f070 CR3: 00000000039b0001 CR4: 00000000001=
70ef0
[    1.645811] Call Trace:
[    1.646145]  <TASK>
[    1.646437]  ? __warn.cold+0xb7/0x151
[    1.646935]  ? syscore_resume+0x18a/0x220
[    1.647485]  ? report_bug+0xff/0x140
[    1.647973]  ? console_unlock+0x9d/0x150
[    1.648513]  ? handle_bug+0x58/0x90
[    1.648990]  ? exc_invalid_op+0x17/0x70
[    1.649528]  ? asm_exc_invalid_op+0x1a/0x20
[    1.650106]  ? syscore_resume+0x18a/0x220
[    1.650661]  ? syscore_resume+0x18a/0x220
[    1.651210]  kernel_kexec+0xff/0x190
[    1.651712]  __do_sys_reboot+0x206/0x250
[    1.652267]  do_syscall_64+0x95/0x180
[    1.652774]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[    1.653473]  ? smp_call_function_many_cond+0x11c/0x790
[    1.654172]  ? lock_acquire+0xd0/0x310
[    1.654690]  ? free_unref_page+0x22b/0x6a0
[    1.655249]  ? __slab_free+0xdf/0x330
[    1.655760]  ? do_kexec_load+0x11d/0x340
[    1.656304]  ? kfree+0x2bf/0x3a0
[    1.656749]  ? __x64_sys_kexec_load+0xa9/0xe0
[    1.657356]  ? kfree+0xdb/0x3a0
[    1.657797]  ? do_kexec_load+0x11d/0x340
[    1.658342]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[    1.659042]  ? syscall_exit_to_user_mode+0x97/0x290
[    1.659720]  ? do_syscall_64+0xa1/0x180
[    1.660245]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    1.660941] RIP: 0033:0x7fed47ce160d
[    1.661434] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f3 47 0c 00 f7 d8 64 89 01 48
[    1.663995] RSP: 002b:00007ffc75b2de78 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a9
[    1.665024] RAX: ffffffffffffffda RBX: 00007ffc75b2dfe8 RCX: 00007fed47c=
e160d
[    1.666000] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[    1.666974] RBP: 00007ffc75b2dec0 R08: 0000000000000000 R09: 00000000000=
00000
[    1.667947] R10: 00007fed47dbce90 R11: 0000000000000246 R12: 00000000000=
00001
[    1.668918] R13: 0000000000000000 R14: 00007fed47dec000 R15: 00000000004=
03e00
[    1.669899]  </TASK>
[    1.670195] irq event stamp: 12392
[    1.670661] hardirqs last  enabled at (12391): [<ffffffffba2ff03f>] smp_=
call_function_many_cond+0x66f/0x790
[    1.671990] hardirqs last disabled at (12392): [<ffffffffba305b2c>] kern=
el_kexec+0x13c/0x190
[    1.673135] softirqs last  enabled at (12376): [<ffffffffba1c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[    1.674307] softirqs last disabled at (12363): [<ffffffffba1c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[    1.675472] ---[ end trace 0000000000000000 ]---


--=-RWkRk4tcyg4Gd+jfk8/p
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjEyMTM0NjMzWjAvBgkqhkiG9w0BCQQxIgQgDn3dtgLd
Jce57VdgDFTiHjPBg5IgZp//QWDabBF8dlswgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCeIyz392dYCuEDxGFOXU/CeM5r0dEa6kLZ
oA+ZIlzHuD5jDqNWUlwhW4v/E+wmml5okMd3althhJfgTTZBQwWBJYDDAvmJg0LgJZ7sO3Dmyz1D
TnRuJ1z060uC/pMKB5X+4ngV2EbVG7biJ3pjZwmyvV73HiwQHtQSv4IODFebhMmPrQXLh4M5S+BS
x+91HEhR0/jU2uJJQ9FEFG/qUA9pYcrUrpbPPtpctaC0Ig6fWcOg+/MX3y5uYwFuRIu9ML6JsRoO
jenqcqm69f+x1AtgaxX3oBgE6Vvxlt9DdTF+gSOaOuZLjOppYbHLzumoTCgCoHQYwWJsFdqq4Wx5
JTuXEO6USRWP0Y4dxPLPeR5gd+U7v2HrW+G7knL3Z8JpKXrZEgLtVSgIlb1Wp4j2sv/pNhm6d89O
ct6/dM7MBYkGpi0wW8ZV0f5sq2mLVsMluorJzC5vzjzGnlQjVnqoy+9B7RZMhQkvFervxeanR+5u
if4D05pyPTWeZ/lIUrn4Jh+XOLqv/k4k3S+FfZSfj6ab8uZ2t7eWs0B+IJU0A45+B8yz8yzPhWa3
9f/hTK6Q8bpCBAwSukD2OxP3yks5jRDI+/vw+NuFJY2dqaz5fZD6fikBKFj1yj/J8haz0r2xsQWM
MkHCmmKHe4dcimVEKBk9xh6Fyls5q0ZJinEImxqcsgAAAAAAAA==


--=-RWkRk4tcyg4Gd+jfk8/p--

