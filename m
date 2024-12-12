Return-Path: <linux-ext4+bounces-5582-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D19EE4C4
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 12:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954B01885DB9
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B72116E8;
	Thu, 12 Dec 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lQhzLYUx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D91EC4D2
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001677; cv=none; b=ZPB34nvzGpxi4loPCoK/eujFkg75gQGeCcU/VSzidrIbrq2M9QItACRyKto5s8p6R5pnI1fUBENl6yJuT2fQZhcyTzxC5/PoqMMO51MkcM7r1v1ivv4lz2VmCJTT9kgihTOeKhesosCEsrpZl2evLkI56e5JSE3QcDl6nWy4JYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001677; c=relaxed/simple;
	bh=duI0d4yCkioAAkfEuewJDfv1zbDPXRsdOuupCYU9UHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c1tv961dXY8Mc9/FyZUOSa3NhWOLXbYRCGq1l4ZVtXh6iSUtwjzUC+vKC5xfmjP4R7BawpncCxqEGD3HbbFFUXuNQWptuMYsraTBh5yNrXkz32w2XppM3HcO41+ocHz4vlnsLD0lbsDdRbfUkHyxbj2Ry2Su+RPUfFnLQPuiNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lQhzLYUx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lbyhn9AaMh6cMvtv8QsfTcoH9zaHxiYszRy22yXKL3k=; b=lQhzLYUxTboQpIM2reN6tt3t1+
	rMnDoxMtRLURFmyp/5fTNPKxuSV9FfcrIQ+H6dC44R0Lai02zsu8bBS0Aaeo7zUuDLft4a+e2BH2Z
	F9W7txqMrmcpyh6gNWgazpH6YPQr3UCt6/pA1gl6t98JBhEUGlWdk+hMeNC402VkVvBbOKUQn8IAf
	9+RfQtkP3s42fAqfGCH11ICfAxAJ3/ncGdyHJhv4LQL4w7fu9Def76x2yw7RB7ZN84IeHwu4YspJO
	S43RoaTDOShuXR4qRGz4eftEcFpYSC5bfsHd5VQKieXjvVHUzV/75xZ7mnCfNJ8MTboYYilP5bgsb
	77qmsukQ==;
Received: from 54-240-197-238.amazon.com ([54.240.197.238] helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLh2o-00000005Cw9-28HQ;
	Thu, 12 Dec 2024 11:07:46 +0000
Message-ID: <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
From: David Woodhouse <dwmw2@infradead.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung
 <dyoung@redhat.com>, kexec <kexec@lists.infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>,  ming.lei@redhat.com
Date: Thu, 12 Dec 2024 11:07:45 +0000
In-Reply-To: <20241211124240.GA310916@fedora>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
	 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
	 <20241211124240.GA310916@fedora>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-eAs6ZMokKcdHbolCA3FX"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-eAs6ZMokKcdHbolCA3FX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-12-11 at 07:42 -0500, Stefan Hajnoczi wrote:
> On Tue, Dec 10, 2024 at 09:56:43AM +0800, Jason Wang wrote:
> > Adding more virtio-blk people here.
>=20
> Please try Ming Lei's recent fix in Jens' tree:
>=20
> =C2=A0 virtio-blk: don't keep queue frozen during system suspend
> =C2=A0 commit: 7678abee0867e6b7fb89aa40f6e9f575f755fb37
>=20
> https://git.kernel.dk/cgit/linux/commit/?h=3Dblock-6.13&id=3D7678abee0867=
e6b7fb89aa40f6e9f575f755fb37

Thanks. That does make those warnings go away. I do still get this one
occasionally though. It seems to go away without 'no_console_suspend'
on the command line, but I'm not sure that makes it OK.

B[   23.665211] ------------[ cut here ]------------
[   23.665790] Interrupts enabled after irqrouter_resume+0x0/0x50
[   23.666596] WARNING: CPU: 0 PID: 560 at drivers/base/syscore.c:103 sysco=
re_resume+0x18a/0x220
[   23.667587] Modules linked in:
[   23.667964] CPU: 0 UID: 0 PID: 560 Comm: loadret Not tainted 6.13.0-rc1+=
 #2033
[   23.668806] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   23.670086] RIP: 0010:syscore_resume+0x18a/0x220
[   23.670614] Code: 00 e9 21 ff ff ff 80 3d 62 d0 d3 01 00 0f 85 03 ff ff =
ff 48 8b 73 18 48 c7 c7 06 f6 e9 a9 c6 05 4a d0 d3 01 01 e8 16 56 46 ff <0f=
> 0b e9 e5 fe ff ff e8 ea e9 54 ff 84 c0 0f 85 fb fe ff ff 80 3d
[   23.672525] RSP: 0018:ffffb2f640aefbb8 EFLAGS: 00010282
[   23.673060] RAX: 0000000000000000 RBX: ffffffffaa9918c0 RCX: 00000000000=
00027
[   23.673759] RDX: ffff8d75fdc21a88 RSI: 0000000000000001 RDI: ffff8d75fdc=
21a80
[   23.674474] RBP: 0000000000037e0c R08: 0000000000000000 R09: 00000000000=
00000
[   23.675198] R10: 0000000000000001 R11: ffffffffaa782fd8 R12: ffffb2f640a=
efbe8
[   23.675905] R13: ffffffffaa68ebe0 R14: 00000000fee1dead R15: 00000000000=
00000
[   23.676610] FS:  00007f058661a540(0000) GS:ffff8d75fdc00000(0000) knlGS:=
0000000000000000
[   23.677431] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.678015] CR2: 000055a0b9f49b70 CR3: 0000000014798001 CR4: 00000000001=
70ef0
[   23.678727] Call Trace:
[   23.679015]  <TASK>
[   23.679248]  ? __warn.cold+0xb7/0x151
[   23.679629]  ? syscore_resume+0x18a/0x220
[   23.680086]  ? report_bug+0xff/0x140
[   23.680484]  ? console_unlock+0x9d/0x150
[   23.680891]  ? handle_bug+0x58/0x90
[   23.681257]  ? exc_invalid_op+0x17/0x70
[   23.681643]  ? asm_exc_invalid_op+0x1a/0x20
[   23.682077]  ? syscore_resume+0x18a/0x220
[   23.682493]  ? syscore_resume+0x18a/0x220
[   23.682929]  kernel_kexec+0xf6/0x180
[   23.683305]  __do_sys_reboot+0x206/0x250
[   23.683721]  do_syscall_64+0x95/0x180
[   23.684163]  ? __lock_acquire+0x45f/0x25c0
[   23.684622]  ? __lock_acquire+0x45f/0x25c0
[   23.685100]  ? __handle_mm_fault+0x7df/0xfa0
[   23.685612]  ? reacquire_held_locks+0xd2/0x1f0
[   23.686118]  ? do_user_addr_fault+0x555/0x8a0
[   23.686615]  ? lock_acquire+0xd0/0x310
[   23.687022]  ? find_held_lock+0x2b/0x80
[   23.687470]  ? do_user_addr_fault+0x59f/0x8a0
[   23.687928]  ? do_user_addr_fault+0x5a9/0x8a0
[   23.688406]  ? trace_hardirqs_off+0x4b/0xc0
[   23.688837]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   23.689367]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.689866] RIP: 0033:0x7f058654c15d
[   23.690244] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fb 5c 0c 00 f7 d8 64 89 01 48
[   23.692088] RSP: 002b:00007ffccf368718 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a9
[   23.692857] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f05865=
4c15d
[   23.693575] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[   23.694317] RBP: 00007ffccf368760 R08: 0000004d00000000 R09: 0000004d000=
00000
[   23.695017] R10: 00007f0586640f30 R11: 0000000000000246 R12: 00000000004=
01070
[   23.695719] R13: 00007ffccf368840 R14: 0000000000000000 R15: 00000000000=
00000
[   23.696453]  </TASK>
[   23.696681] irq event stamp: 15565
[   23.697043] hardirqs last  enabled at (15573): [<ffffffffa8281b8e>] __up=
_console_sem+0x7e/0x90
[   23.697855] hardirqs last disabled at (15580): [<ffffffffa8281b73>] __up=
_console_sem+0x63/0x90
[   23.698673] softirqs last  enabled at (14798): [<ffffffffa81c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[   23.699481] softirqs last disabled at (14777): [<ffffffffa81c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[   23.700284] ---[ end trace 0000000000000000 ]---
[   23.702460] ------------[ cut here ]------------
[   23.702963] WARNING: CPU: 0 PID: 560 at kernel/time/hrtimer.c:995 hrtime=
rs_resume_local+0x29/0x40
[   23.703885] Modules linked in:
[   23.704223] CPU: 0 UID: 0 PID: 560 Comm: loadret Tainted: G        W    =
      6.13.0-rc1+ #2033
[   23.705089] Tainted: [W]=3DWARN
[   23.705415] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   23.706536] RIP: 0010:hrtimers_resume_local+0x29/0x40
[   23.707068] Code: 90 66 0f 1f 00 0f 1f 44 00 00 8b 05 c5 57 81 02 85 c0 =
74 18 65 8b 05 0e 8c d4 57 85 c0 75 0d 65 8b 05 c7 88 d4 57 85 c0 74 02 <0f=
> 0b 31 ff e9 de ee ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
[   23.708834] RSP: 0018:ffffb2f640aefb50 EFLAGS: 00010202
[   23.709429] RAX: 0000000000000001 RBX: 000000059af022d0 RCX: 00000000000=
006e0
[   23.710121] RDX: 000000000000000e RSI: 000000008e2b60ca RDI: 00000000000=
006e0
[   23.710831] RBP: ffffb2f640aefba8 R08: 0000000000000001 R09: 00000000000=
00000
[   23.711559] R10: 0000000000000001 R11: ffffffffac18d188 R12: 00000000000=
00206
[   23.712249] R13: ffffffffaa666ca0 R14: 00000000fee1dead R15: 00000000000=
00000
[   23.712952] FS:  00007f058661a540(0000) GS:ffff8d75fdc00000(0000) knlGS:=
0000000000000000
[   23.713746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.714301] CR2: 000055a0b9f49b70 CR3: 0000000014798001 CR4: 00000000001=
70ef0
[   23.714997] Call Trace:
[   23.715274]  <TASK>
[   23.715512]  ? __warn.cold+0xb7/0x151
[   23.715884]  ? hrtimers_resume_local+0x29/0x40
[   23.716330]  ? report_bug+0xff/0x140
[   23.716711]  ? handle_bug+0x58/0x90
[   23.717071]  ? exc_invalid_op+0x17/0x70
[   23.717465]  ? asm_exc_invalid_op+0x1a/0x20
[   23.717890]  ? hrtimers_resume_local+0x29/0x40
[   23.718356]  timekeeping_resume+0x148/0x190
[   23.718772]  syscore_resume+0x67/0x220
[   23.719151]  kernel_kexec+0xf6/0x180
[   23.719568]  __do_sys_reboot+0x206/0x250
[   23.720044]  do_syscall_64+0x95/0x180
[   23.720429]  ? __lock_acquire+0x45f/0x25c0
[   23.720849]  ? __lock_acquire+0x45f/0x25c0
[   23.721258]  ? __handle_mm_fault+0x7df/0xfa0
[   23.721697]  ? reacquire_held_locks+0xd2/0x1f0
[   23.722139]  ? do_user_addr_fault+0x555/0x8a0
[   23.722618]  ? lock_acquire+0xd0/0x310
[   23.723053]  ? find_held_lock+0x2b/0x80
[   23.723505]  ? do_user_addr_fault+0x59f/0x8a0
[   23.724010]  ? do_user_addr_fault+0x5a9/0x8a0
[   23.724467]  ? trace_hardirqs_off+0x4b/0xc0
[   23.724916]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   23.725404]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.725935] RIP: 0033:0x7f058654c15d
[   23.726318] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fb 5c 0c 00 f7 d8 64 89 01 48
[   23.728079] RSP: 002b:00007ffccf368718 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a9
[   23.728827] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f05865=
4c15d
[   23.729560] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[   23.730358] RBP: 00007ffccf368760 R08: 0000004d00000000 R09: 0000004d000=
00000
[   23.731089] R10: 00007f0586640f30 R11: 0000000000000246 R12: 00000000004=
01070
[   23.731755] R13: 00007ffccf368840 R14: 0000000000000000 R15: 00000000000=
00000
[   23.732455]  </TASK>
[   23.732681] irq event stamp: 16269
[   23.733016] hardirqs last  enabled at (16277): [<ffffffffa8281b8e>] __up=
_console_sem+0x7e/0x90
[   23.733823] hardirqs last disabled at (16286): [<ffffffffa8281b73>] __up=
_console_sem+0x63/0x90
[   23.734639] softirqs last  enabled at (15872): [<ffffffffa81c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[   23.735463] softirqs last disabled at (15863): [<ffffffffa81c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[   23.736316] ---[ end trace 0000000000000000 ]---
[   23.736789]=20
[   23.736993] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   23.737439] WARNING: inconsistent lock state
[   23.737908] 6.13.0-rc1+ #2033 Tainted: G        W        =20
[   23.738493] --------------------------------
[   23.738900] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[   23.739468] loadret/560 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   23.739957] ffff8d75fdc267d8 (hrtimer_bases.lock){?.-.}-{2:2}, at: retri=
gger_next_event+0x38/0xd0
[   23.740813] {IN-HARDIRQ-W} state was registered at:
[   23.741276]   lock_acquire+0xd0/0x310
[   23.741628]   _raw_spin_lock_irqsave+0x48/0x70
[   23.742058]   hrtimer_run_queues+0x4d/0x150
[   23.742455]   update_process_times+0x34/0xf0
[   23.742853]   tick_periodic+0x29/0xe0
[   23.743216]   tick_handle_periodic+0x24/0x70
[   23.743621]   timer_interrupt+0x18/0x30
[   23.743999]   __handle_irq_event_percpu+0x87/0x260
[   23.744449]   handle_irq_event+0x38/0x90
[   23.744819]   handle_level_irq+0x8e/0x160
[   23.745212]   __common_interrupt+0x5c/0x120
[   23.745603]   common_interrupt+0x80/0xa0
[   23.745986]   asm_common_interrupt+0x26/0x40
[   23.746395]   __x86_return_thunk+0x0/0x10
[   23.746772]   _raw_spin_unlock_irqrestore+0x45/0x70
[   23.747251]   __setup_irq+0x34d/0x6a0
[   23.747602]   request_threaded_irq+0x115/0x1b0
[   23.748039]   hpet_time_init+0x31/0x50
[   23.748396]   x86_late_time_init+0x1b/0x40
[   23.748786]   start_kernel+0x998/0xa40
[   23.749154]   x86_64_start_reservations+0x24/0x30
[   23.749600]   x86_64_start_kernel+0xed/0xf0
[   23.750011]   common_startup_64+0x13e/0x141
[   23.750398] irq event stamp: 16325
[   23.750745] hardirqs last  enabled at (16325): [<ffffffffa8281b8e>] __up=
_console_sem+0x7e/0x90
[   23.751549] hardirqs last disabled at (16324): [<ffffffffa8281b73>] __up=
_console_sem+0x63/0x90
[   23.752349] softirqs last  enabled at (15872): [<ffffffffa81c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[   23.753138] softirqs last disabled at (15863): [<ffffffffa81c6c12>] __ir=
q_exit_rcu+0xe2/0x100
[   23.753956]=20
[   23.753956] other info that might help us debug this:
[   23.754597]  Possible unsafe locking scenario:
[   23.754597]=20
[   23.755163]        CPU0
[   23.755397]        ----
[   23.755637]   lock(hrtimer_bases.lock);
[   23.756010]   <Interrupt>
[   23.756264]     lock(hrtimer_bases.lock);
[   23.756640]=20
[   23.756640]  *** DEADLOCK ***
[   23.756640]=20
[   23.757197] 1 lock held by loadret/560:
[   23.757555]  #0: ffffffffaa6902c8 (system_transition_mutex){+.+.}-{4:4},=
 at: __do_sys_reboot+0xc5/0x250
[   23.758426]=20
[   23.758426] stack backtrace:
[   23.758867] CPU: 0 UID: 0 PID: 560 Comm: loadret Tainted: G        W    =
      6.13.0-rc1+ #2033
[   23.759806] Tainted: [W]=3DWARN
[   23.760151] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   23.761228] Call Trace:
[   23.761481]  <TASK>
[   23.761713]  dump_stack_lvl+0x84/0xd0
[   23.762117]  print_usage_bug.part.0+0x257/0x340
[   23.762553]  mark_lock+0x735/0x960
[   23.762911]  ? vprintk_emit+0x111/0x460
[   23.763288]  ? hrtimers_resume_local+0x29/0x40
[   23.763704]  ? _printk+0x6c/0x90
[   23.764018]  __lock_acquire+0x7ee/0x25c0
[   23.764385]  ? __warn.cold+0x7f/0x151
[   23.764727]  ? hrtimers_resume_local+0x29/0x40
[   23.765161]  ? nbcon_get_cpu_emergency_nesting+0xa/0x30
[   23.765643]  ? nbcon_cpu_emergency_exit+0xe/0x40
[   23.766081]  ? report_bug+0xff/0x140
[   23.766428]  lock_acquire+0xd0/0x310
[   23.766771]  ? retrigger_next_event+0x38/0xd0
[   23.767189]  _raw_spin_lock+0x30/0x40
[   23.767542]  ? retrigger_next_event+0x38/0xd0
[   23.767967]  retrigger_next_event+0x38/0xd0
[   23.768365]  timekeeping_resume+0x148/0x190
[   23.768763]  syscore_resume+0x67/0x220
[   23.769136]  kernel_kexec+0xf6/0x180
[   23.769478]  __do_sys_reboot+0x206/0x250
[   23.769851]  do_syscall_64+0x95/0x180
[   23.770205]  ? __lock_acquire+0x45f/0x25c0
[   23.770590]  ? __lock_acquire+0x45f/0x25c0
[   23.770987]  ? __handle_mm_fault+0x7df/0xfa0
[   23.771395]  ? reacquire_held_locks+0xd2/0x1f0
[   23.771812]  ? do_user_addr_fault+0x555/0x8a0
[   23.772229]  ? lock_acquire+0xd0/0x310
[   23.772584]  ? find_held_lock+0x2b/0x80
[   23.772934]  ? do_user_addr_fault+0x59f/0x8a0
[   23.773350]  ? do_user_addr_fault+0x5a9/0x8a0
[   23.773761]  ? trace_hardirqs_off+0x4b/0xc0
[   23.774169]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
[   23.774643]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   23.775111] RIP: 0033:0x7f058654c15d
[   23.775451] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fb 5c 0c 00 f7 d8 64 89 01 48
[   23.777180] RSP: 002b:00007ffccf368718 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a9
[   23.777872] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f05865=
4c15d
[   23.778535] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee=
1dead
[   23.779181] RBP: 00007ffccf368760 R08: 0000004d00000000 R09: 0000004d000=
00000
[   23.779836] R10: 00007f0586640f30 R11: 0000000000000246 R12: 00000000004=
01070
[   23.780497] R13: 00007ffccf368840 R14: 0000000000000000 R15: 00000000000=
00000
[   23.781181]  </TASK>
[   23.781485] Enabling non-boot CPUs ...
[   23.781875] crash hp: kexec_trylock() failed, kdump image may be inaccur=
ate
[   23.782558] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   23.784675] CPU1 is up
[   23.789380] virtio_blk virtio1: 2/0/0 default/read/poll queues
[   23.794137] OOM killer enabled.
Success794454] Restarting tasks ... done.


--=-eAs6ZMokKcdHbolCA3FX
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQxMjEyMTEwNzQ1WjAvBgkqhkiG9w0BCQQxIgQgn1b0E2ib
M7lx6XbDbcdf5cy3BT89/D2kEZLcXl7UCgIwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgAQJW+mureLkDPdEQc3xHNXCHeiTp/epYw+
5K1ta+L9pUKYVucoOG+l8UbWTR2A3+Eu9YKgjko8xEMGLAxKO7H0ijr0vBIA0Sz8g25+KL7v9Hyz
JpKtQyjGEyrZn8YWcZrco48ir2TUFhbLpbmF3mPDaJb2H0pgyx2MrxqjE2ltL17Qal4OUcEA3/Pi
OlqLmt8ArL797kO99I6AYWJP/vHRop2o5qCMzyimDRKQ92mLHC+IKghStAK59Px3AOW+Czsi/Xiz
zXfWJ2Scsy4XIsMyebJaekTmWPukHkVNeLxGLdFVU4ILVSKTVGrfTiYp3u7nMOr71cBTHn1hYLC9
AbKVB7VfrwNzBGo/pWlOgkCKNNC6sbTMlSFIclT2lGkOnQd3SDZZjsQkVCplmLMop169l2l5bKYb
OvQ+HqkAUWlvIjNtvPABLUK9xNIN3hMZX+SAbB0yo8iH+SeMUZ6Wx20liVasBPsLqW2hNXqRRHm1
FlXLZhlDqDp3pgrRLx5PJOApaC1Sqf8JG3LKUdQb+YRebdd5qOjdTqJNMG0UXEXHQr3yjmjCXaLc
Le6WdpR8LyXa/LM9L+QZRshQLYZmZuRMrn71S7aY88CnaSujAxBSG3g1oUlBPjIG8QR5jo24SVdf
Us7ftIuiso0pQpodpZCjKC4l+eNdl726F0QQFRvWNAAAAAAAAA==


--=-eAs6ZMokKcdHbolCA3FX--

