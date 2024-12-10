Return-Path: <linux-ext4+bounces-5523-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC89EA492
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 02:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C64165E57
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 01:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC937603F;
	Tue, 10 Dec 2024 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfM73rTG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069341C64
	for <linux-ext4@vger.kernel.org>; Tue, 10 Dec 2024 01:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795822; cv=none; b=l5D1/GCwX8nzZMGzdZuTzHUovUcNbiaxr0Fz3htxgN99Z+M0oe/i1xj+h3MzJWaVJ+GQhxsFyDPufXbEFxDQHVNhes/QekUxoWp40SzbxqJYC3fK6tMgTE8c/3jNHW6Usvn15pRO60c2sFEZw1UuPKTlRWUY3upR/KqmKn8+P+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795822; c=relaxed/simple;
	bh=4PytcCjlen3BDIFpTDeqUk3FfHoJnxiDyrHR8bibkpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liDBxGU1azd9WHqmhzz2hsCPfw+NMX10mogyLMAEOYYlH/z2tta8pXT2YVVKTJCXC6YyErdWlz/trascf7+pMFS7WFDhVOSvhZZgKwf2sb4YKyp5VIGaS79qWHs+nZ+6wkOtpz1xIFBUD4d7sOwf4VIZnZggBNJ08lYGU02q6SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfM73rTG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733795818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C10ivEiClGOEmfYyHi1fmnR72tEE6jqEmT7c5EriUhM=;
	b=NfM73rTGJJjCH+3ooDEvqtu1rVBZ81O29RcGoCXB1hJRSEny0Kqc/yllAJDxaPJq656YUQ
	Cv99Aq1aMnwARw9AFpS14dk6EPheKQyOy3nDK//k/SF6p8t0UWQBi+4kyAMwZYzBwoRofM
	mDNEH43q3ET4bO9lbJPYOWS90NNlTjo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-nxRzjhXcOsu5CJDG6Qm8mw-1; Mon, 09 Dec 2024 20:56:56 -0500
X-MC-Unique: nxRzjhXcOsu5CJDG6Qm8mw-1
X-Mimecast-MFC-AGG-ID: nxRzjhXcOsu5CJDG6Qm8mw
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-72522df68a9so4119053b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 09 Dec 2024 17:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733795815; x=1734400615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C10ivEiClGOEmfYyHi1fmnR72tEE6jqEmT7c5EriUhM=;
        b=UQno02eHf8jROKZBUPXLzK3zWcMph3rjrrk6AQh7n0x5p0JkawW8onvMygeq0S14Ur
         6UGtBKT46hfl7XYVycUMiMtTK2VeqeZFYbjx3vn8OSec32U8to51H8u3NdQcQQqUhiwB
         odFgcMUVp+v46dupbrIhX4UnqNV/BezATWSAnz2+sDzXV3OlvgB/xQZ8nlE4UJllbP7J
         2ia2xlPwH0fRCcNJX30ZuA9x7qGkwxNlwFadl8xAv/hOCWQ8aZnGLx/vFL2OjelG7BWi
         iQFlWva8XyrWvg7aOtN+v8zsGsQieF4nTRbk1zyheuwjjxTUubbtAkAbv9toGuI72FXT
         APVA==
X-Forwarded-Encrypted: i=1; AJvYcCV/UrxBY/W6iC9k496GV8QB0DsWIsfRN57tIpaq9RxiMnkx0mtEmYhQ2ACPryG+yLm8st9H/jrscWjm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo66Vrz+3uJ8Ki+yOlHd/a0eLPnNMSOthikNLXEdDJxbXGJdNI
	CyA9Hp0E5AyjJZvvGOMYgr8jKh74BvGHfSHhFt8Z/I1z8p8NGnIc/8ktNt3uTjX8n7YnmrG4u0X
	aPgdAaI+TjrBsTFMGr1aJJ5vmeKm0yHk856F1cHntL/C78g912fPnIH0vIXUzumoCBUHbmkCR/K
	RRIzuqOdnS0TM7dk1kA68aj0HUhq8qCuCReA==
X-Gm-Gg: ASbGnctgKoAvk/F8xOGZf3euVZI2Nnw+iLSe5XyILsoVppqeWhA3FYoMf384TJP8QfM
	p8Wif+mPwF24Vtn/nqfxwWTUzQlkh2zdcm0Wq
X-Received: by 2002:a05:6a00:1f09:b0:727:3cd0:1167 with SMTP id d2e1a72fcca58-7273cd013d6mr3757405b3a.21.1733795814834;
        Mon, 09 Dec 2024 17:56:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAJ3YURlOGQ88g3qQmW5qmy4G0hHPHu2X24U08d8ahKmGTinNoioWxRB1EyTbWaMpQ1cFgolyJVymGGmiCF4U=
X-Received: by 2002:a05:6a00:1f09:b0:727:3cd0:1167 with SMTP id
 d2e1a72fcca58-7273cd013d6mr3757363b3a.21.1733795814226; Mon, 09 Dec 2024
 17:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
In-Reply-To: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Dec 2024 09:56:43 +0800
Message-ID: <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
To: David Woodhouse <dwmw2@infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, 
	kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, eperezma <eperezma@redhat.com>, 
	Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding more virtio-blk people here.

On Mon, Dec 9, 2024 at 10:49=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> Using the test case in https://git.kernel.org/torvalds/c/07fa619f2a40c
> I see sporadic lockdep warnings.
>
> This warning on the way into kexec seems to happen every time:
>
> [   67.416890] Freezing user space processes
> [   67.419277] Freezing user space processes completed (elapsed 0.001 sec=
onds)
> [   67.420754] OOM killer disabled.
> [   67.433337] BUG: workqueue leaked atomic, lock or RCU: kworker/u8:7[55=
8]
> [   67.433337]      preempt=3D0x00000000 lock=3D0->2 RCU=3D0->0 workfn=3D=
async_run_entry_fn
> [   67.436941] 2 locks held by kworker/u8:7/558:
> [   67.437912]  #0: ffff893982fdb858 (&q->q_usage_counter(io)){++++}-{0:0=
}, at: virtblk_freeze+0x28/0x70
> [   67.439980]  #1: ffff893982fdb890 (&q->q_usage_counter(queue)){++++}-{=
0:0}, at: virtblk_freeze+0x28/0x70
> [   67.441783] CPU: 0 UID: 0 PID: 558 Comm: kworker/u8:7 Not tainted 6.13=
.0-rc1+ #2032
> [   67.442462] Disabling non-boot CPUs ...
> [   67.443101] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   67.443106] Workqueue: async async_run_entry_fn
> [   67.443114] Call Trace:
> [   67.443117]  <TASK>
> [   67.443123]  dump_stack_lvl+0x84/0xd0
> [   67.447325]  process_one_work.cold+0x6d/0xc8
> [   67.447991]  ? __pfx_async_run_entry_fn+0x10/0x10
> [   67.448644]  ? process_one_work+0x24a/0x590
> [   67.449226]  worker_thread+0x1c3/0x3b0
> [   67.449757]  ? __pfx_worker_thread+0x10/0x10
> [   67.450345]  kthread+0xd5/0x100
> [   67.450822]  ? __pfx_kthread+0x10/0x10
> [   67.451320]  ret_from_fork+0x34/0x50
> [   67.451775]  ? __pfx_kthread+0x10/0x10
> [   67.452239]  ret_from_fork_asm+0x1a/0x30
> [   67.452747]  </TASK>
> [   67.471104] smpboot: CPU 1 is now offline
>
>
>
> This one happens only occasionally (1 in 20 or so):
>
> B[   67.487529] ------------[ cut here ]------------
> [   67.488018] Interrupts enabled after irqrouter_resume+0x0/0x50
> [   67.488684] WARNING: CPU: 0 PID: 571 at drivers/base/syscore.c:103 sys=
core_resume+0x18a/0x220
> [   67.489571] Modules linked in:
> [   67.489920] CPU: 0 UID: 0 PID: 571 Comm: loadret Not tainted 6.13.0-rc=
1+ #2032
> [   67.490692] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   67.491856] RIP: 0010:syscore_resume+0x18a/0x220
> [   67.492347] Code: 00 e9 21 ff ff ff 80 3d 62 d0 d3 01 00 0f 85 03 ff f=
f ff 48 8b 73 18 48 c7 c7 06 f6 e9 8d c6 05 4a d0 d3 01 01 e8 16 56 46 ff <=
0f> 0b e9 e5 fe ff ff e8 ea e9 54 ff 84 c0 0f 85 fb fe ff ff 80 3d
> [   67.494253] RSP: 0018:ffffaca540773a08 EFLAGS: 00010286
> [   67.494816] RAX: 0000000000000000 RBX: ffffffff8e9918c0 RCX: 000000000=
0000027
> [   67.495560] RDX: ffff8939fdc21a88 RSI: 0000000000000001 RDI: ffff8939f=
dc21a80
> [   67.496324] RBP: 0000000000037e0c R08: 0000000000000000 R09: 000000000=
0000000
> [   67.497052] R10: 0000000000000001 R11: ffffffff8e782fd8 R12: ffffaca54=
0773a38
> [   67.497788] R13: ffffffff8e68ebe0 R14: 00000000fee1dead R15: 000000000=
0000000
> [   67.498504] FS:  00007f9ae771f540(0000) GS:ffff8939fdc00000(0000) knlG=
S:0000000000000000
> [   67.499320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.499930] CR2: 0000559aeea00b70 CR3: 0000000007a5e001 CR4: 000000000=
0170ef0
> [   67.500650] Call Trace:
> [   67.500913]  <TASK>
> [   67.501147]  ? __warn.cold+0xb7/0x151
> [   67.501535]  ? syscore_resume+0x18a/0x220
> [   67.501963]  ? report_bug+0xff/0x140
> [   67.502331]  ? console_unlock+0x9d/0x150
> [   67.502757]  ? handle_bug+0x58/0x90
> [   67.503128]  ? exc_invalid_op+0x17/0x70
> [   67.503529]  ? asm_exc_invalid_op+0x1a/0x20
> [   67.503975]  ? syscore_resume+0x18a/0x220
> [   67.504390]  ? syscore_resume+0x18a/0x220
> [   67.504814]  kernel_kexec+0xf6/0x180
> [   67.505190]  __do_sys_reboot+0x206/0x250
> [   67.505653]  do_syscall_64+0x95/0x180
> [   67.506037]  ? __lock_acquire+0x45f/0x25c0
> [   67.506451]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.506974]  ? smp_call_function_many_cond+0x11c/0x790
> [   67.507503]  ? lock_acquire+0xd0/0x310
> [   67.507896]  ? free_unref_page+0x22b/0x6a0
> [   67.508316]  ? find_held_lock+0x2b/0x80
> [   67.508725]  ? free_unref_page+0x510/0x6a0
> [   67.509157]  ? do_raw_spin_unlock+0x4d/0xb0
> [   67.509592]  ? _raw_spin_unlock+0x23/0x40
> [   67.510006]  ? free_unref_page+0x510/0x6a0
> [   67.510428]  ? arch_kexec_pre_free_pages+0x1a/0x40
> [   67.510938]  ? do_kexec_load+0x11d/0x340
> [   67.511343]  ? kfree+0xdb/0x3a0
> [   67.511697]  ? __x64_sys_kexec_load+0xa9/0xe0
> [   67.512149]  ? kfree+0xdb/0x3a0
> [   67.512485]  ? do_kexec_load+0x11d/0x340
> [   67.512912]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.513430]  ? syscall_exit_to_user_mode+0x97/0x290
> [   67.513935]  ? do_syscall_64+0xa1/0x180
> [   67.514333]  ? find_held_lock+0x2b/0x80
> [   67.514736]  ? do_user_addr_fault+0x59f/0x8a0
> [   67.515193]  ? do_user_addr_fault+0x5a9/0x8a0
> [   67.515655]  ? trace_hardirqs_off+0x4b/0xc0
> [   67.516102]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.516625]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   67.517138] RIP: 0033:0x7f9ae765115d
> [   67.517515] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fb 5c 0c 00 f7 d8 64 89 01 48
> [   67.519312] RSP: 002b:00007ffd17db0ad8 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a9
> [   67.520057] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ae=
765115d
> [   67.520760] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000f=
ee1dead
> [   67.521454] RBP: 00007ffd17db0b20 R08: 0000004d00000000 R09: 0000004d0=
0000000
> [   67.522172] R10: 00007f9ae7745f30 R11: 0000000000000246 R12: 000000000=
0401070
> [   67.522881] R13: 00007ffd17db0c00 R14: 0000000000000000 R15: 000000000=
0000000
> [   67.523593]  </TASK>
> [   67.523832] irq event stamp: 15605
> [   67.524181] hardirqs last  enabled at (15613): [<ffffffff8c281b8e>] __=
up_console_sem+0x7e/0x90
> [   67.525034] hardirqs last disabled at (15620): [<ffffffff8c281b73>] __=
up_console_sem+0x63/0x90
> [   67.525935] softirqs last  enabled at (14732): [<ffffffff8c1c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   67.526780] softirqs last disabled at (14717): [<ffffffff8c1c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   67.527616] ---[ end trace 0000000000000000 ]---
> [   67.530225] ------------[ cut here ]------------
> [   67.530760] WARNING: CPU: 0 PID: 571 at kernel/time/hrtimer.c:995 hrti=
mers_resume_local+0x29/0x40
> [   67.531654] Modules linked in:
> [   67.531982] CPU: 0 UID: 0 PID: 571 Comm: loadret Tainted: G        W  =
        6.13.0-rc1+ #2032
> [   67.532862] Tainted: [W]=3DWARN
> [   67.533185] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   67.534313] RIP: 0010:hrtimers_resume_local+0x29/0x40
> [   67.534833] Code: 90 66 0f 1f 00 0f 1f 44 00 00 8b 05 c5 57 81 02 85 c=
0 74 18 65 8b 05 0e 8c d4 73 85 c0 75 0d 65 8b 05 c7 88 d4 73 85 c0 74 02 <=
0f> 0b 31 ff e9 de ee ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> [   67.536771] RSP: 0018:ffffaca5407739a0 EFLAGS: 00010202
> [   67.537296] RAX: 0000000000000001 RBX: 0000000fcd31f08b RCX: 000000000=
00006e0
> [   67.538000] RDX: 0000000000000029 RSI: 00000000007f56f4 RDI: 000000000=
00006e0
> [   67.538706] RBP: ffffaca5407739f8 R08: 0000000000000001 R09: 000000000=
0000000
> [   67.539406] R10: 0000000000000001 R11: ffffffff9018d188 R12: 000000000=
0000202
> [   67.540104] R13: ffffffff8e666ca0 R14: 00000000fee1dead R15: 000000000=
0000000
> [   67.540840] FS:  00007f9ae771f540(0000) GS:ffff8939fdc00000(0000) knlG=
S:0000000000000000
> [   67.541638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.542218] CR2: 0000559aeea00b70 CR3: 0000000007a5e001 CR4: 000000000=
0170ef0
> [   67.542915] Call Trace:
> [   67.543185]  <TASK>
> [   67.543413]  ? __warn.cold+0xb7/0x151
> [   67.543804]  ? hrtimers_resume_local+0x29/0x40
> [   67.544269]  ? report_bug+0xff/0x140
> [   67.544646]  ? handle_bug+0x58/0x90
> [   67.544999]  ? exc_invalid_op+0x17/0x70
> [   67.545396]  ? asm_exc_invalid_op+0x1a/0x20
> [   67.545862]  ? hrtimers_resume_local+0x29/0x40
> [   67.546318]  timekeeping_resume+0x148/0x190
> [   67.546743]  syscore_resume+0x67/0x220
> [   67.547132]  kernel_kexec+0xf6/0x180
> [   67.547491]  __do_sys_reboot+0x206/0x250
> [   67.547902]  do_syscall_64+0x95/0x180
> [   67.548285]  ? __lock_acquire+0x45f/0x25c0
> [   67.548714]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.549255]  ? smp_call_function_many_cond+0x11c/0x790
> [   67.549783]  ? lock_acquire+0xd0/0x310
> [   67.550176]  ? free_unref_page+0x22b/0x6a0
> [   67.550594]  ? find_held_lock+0x2b/0x80
> [   67.550973]  ? free_unref_page+0x510/0x6a0
> [   67.551409]  ? do_raw_spin_unlock+0x4d/0xb0
> [   67.551849]  ? _raw_spin_unlock+0x23/0x40
> [   67.552263]  ? free_unref_page+0x510/0x6a0
> [   67.552682]  ? arch_kexec_pre_free_pages+0x1a/0x40
> [   67.553169]  ? do_kexec_load+0x11d/0x340
> [   67.553553]  ? kfree+0xdb/0x3a0
> [   67.553895]  ? __x64_sys_kexec_load+0xa9/0xe0
> [   67.554345]  ? kfree+0xdb/0x3a0
> [   67.554678]  ? do_kexec_load+0x11d/0x340
> [   67.555073]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.555581]  ? syscall_exit_to_user_mode+0x97/0x290
> [   67.556121]  ? do_syscall_64+0xa1/0x180
> [   67.556506]  ? find_held_lock+0x2b/0x80
> [   67.556898]  ? do_user_addr_fault+0x59f/0x8a0
> [   67.557347]  ? do_user_addr_fault+0x5a9/0x8a0
> [   67.557795]  ? trace_hardirqs_off+0x4b/0xc0
> [   67.558221]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.558721]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   67.559230] RIP: 0033:0x7f9ae765115d
> [   67.559625] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fb 5c 0c 00 f7 d8 64 89 01 48
> [   67.561378] RSP: 002b:00007ffd17db0ad8 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a9
> [   67.562124] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ae=
765115d
> [   67.562815] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000f=
ee1dead
> [   67.563507] RBP: 00007ffd17db0b20 R08: 0000004d00000000 R09: 0000004d0=
0000000
> [   67.564223] R10: 00007f9ae7745f30 R11: 0000000000000246 R12: 000000000=
0401070
> [   67.564912] R13: 00007ffd17db0c00 R14: 0000000000000000 R15: 000000000=
0000000
> [   67.565614]  </TASK>
> [   67.565847] irq event stamp: 16351
> [   67.566214] hardirqs last  enabled at (16361): [<ffffffff8c281b8e>] __=
up_console_sem+0x7e/0x90
> [   67.567039] hardirqs last disabled at (16368): [<ffffffff8c281b73>] __=
up_console_sem+0x63/0x90
> [   67.567867] softirqs last  enabled at (16260): [<ffffffff8c1c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   67.568702] softirqs last disabled at (16245): [<ffffffff8c1c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   67.569516] ---[ end trace 0000000000000000 ]---
> [   67.569981]
> [   67.570150] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   67.570561] WARNING: inconsistent lock state
> [   67.570982] 6.13.0-rc1+ #2032 Tainted: G        W
> [   67.571501] --------------------------------
> [   67.571922] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [   67.572490] loadret/571 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [   67.572984] ffff8939fdc267d8 (hrtimer_bases.lock){?.-.}-{2:2}, at: ret=
rigger_next_event+0x38/0xd0
> [   67.573831] {IN-HARDIRQ-W} state was registered at:
> [   67.574299]   lock_acquire+0xd0/0x310
> [   67.574670]   _raw_spin_lock_irqsave+0x48/0x70
> [   67.575102]   hrtimer_run_queues+0x4d/0x150
> [   67.575504]   update_process_times+0x34/0xf0
> [   67.575926]   tick_periodic+0x29/0xe0
> [   67.576287]   tick_handle_periodic+0x24/0x70
> [   67.576715]   timer_interrupt+0x18/0x30
> [   67.577093]   __handle_irq_event_percpu+0x87/0x260
> [   67.577573]   handle_irq_event+0x38/0x90
> [   67.577970]   handle_level_irq+0x8e/0x160
> [   67.578350]   __common_interrupt+0x5c/0x120
> [   67.578763]   common_interrupt+0x80/0xa0
> [   67.579144]   asm_common_interrupt+0x26/0x40
> [   67.579558]   __x86_return_thunk+0x0/0x10
> [   67.579951]   _raw_spin_unlock_irqrestore+0x45/0x70
> [   67.580418]   __setup_irq+0x34d/0x6a0
> [   67.580787]   request_threaded_irq+0x115/0x1b0
> [   67.581214]   hpet_time_init+0x31/0x50
> [   67.581577]   x86_late_time_init+0x1b/0x40
> [   67.581975]   start_kernel+0x998/0xa40
> [   67.582336]   x86_64_start_reservations+0x24/0x30
> [   67.582792]   x86_64_start_kernel+0xed/0xf0
> [   67.583187]   common_startup_64+0x13e/0x141
> [   67.583603] irq event stamp: 16407
> [   67.583934] hardirqs last  enabled at (16407): [<ffffffff8c281b8e>] __=
up_console_sem+0x7e/0x90
> [   67.584742] hardirqs last disabled at (16406): [<ffffffff8c281b73>] __=
up_console_sem+0x63/0x90
> [   67.585537] softirqs last  enabled at (16260): [<ffffffff8c1c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   67.586338] softirqs last disabled at (16245): [<ffffffff8c1c6c12>] __=
irq_exit_rcu+0xe2/0x100
> [   67.587143]
> [   67.587143] other info that might help us debug this:
> [   67.587759]  Possible unsafe locking scenario:
> [   67.587759]
> [   67.588319]        CPU0
> [   67.588564]        ----
> [   67.588822]   lock(hrtimer_bases.lock);
> [   67.589192]   <Interrupt>
> [   67.589451]     lock(hrtimer_bases.lock);
> [   67.589843]
> [   67.589843]  *** DEADLOCK ***
> [   67.589843]
> [   67.590400] 1 lock held by loadret/571:
> [   67.590775]  #0: ffffffff8e6902c8 (system_transition_mutex){+.+.}-{4:4=
}, at: __do_sys_reboot+0xc5/0x250
> [   67.591655]
> [   67.591655] stack backtrace:
> [   67.592073] CPU: 0 UID: 0 PID: 571 Comm: loadret Tainted: G        W  =
        6.13.0-rc1+ #2032
> [   67.592883] Tainted: [W]=3DWARN
> [   67.593176] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   67.594234] Call Trace:
> [   67.594480]  <TASK>
> [   67.594707]  dump_stack_lvl+0x84/0xd0
> [   67.595067]  print_usage_bug.part.0+0x257/0x340
> [   67.595505]  mark_lock+0x735/0x960
> [   67.595849]  ? vprintk_emit+0x111/0x460
> [   67.596221]  ? hrtimers_resume_local+0x29/0x40
> [   67.596666]  ? _printk+0x6c/0x90
> [   67.596986]  __lock_acquire+0x7ee/0x25c0
> [   67.597367]  ? __warn.cold+0x7f/0x151
> [   67.597728]  ? hrtimers_resume_local+0x29/0x40
> [   67.598160]  ? nbcon_get_cpu_emergency_nesting+0xa/0x30
> [   67.598671]  ? nbcon_cpu_emergency_exit+0xe/0x40
> [   67.599115]  ? report_bug+0xff/0x140
> [   67.599462]  lock_acquire+0xd0/0x310
> [   67.599815]  ? retrigger_next_event+0x38/0xd0
> [   67.600234]  _raw_spin_lock+0x30/0x40
> [   67.600603]  ? retrigger_next_event+0x38/0xd0
> [   67.601025]  retrigger_next_event+0x38/0xd0
> [   67.601425]  timekeeping_resume+0x148/0x190
> [   67.601832]  syscore_resume+0x67/0x220
> [   67.602193]  kernel_kexec+0xf6/0x180
> [   67.602542]  __do_sys_reboot+0x206/0x250
> [   67.602934]  do_syscall_64+0x95/0x180
> [   67.603292]  ? __lock_acquire+0x45f/0x25c0
> [   67.603706]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.604188]  ? smp_call_function_many_cond+0x11c/0x790
> [   67.604684]  ? lock_acquire+0xd0/0x310
> [   67.605049]  ? free_unref_page+0x22b/0x6a0
> [   67.605444]  ? find_held_lock+0x2b/0x80
> [   67.605820]  ? free_unref_page+0x510/0x6a0
> [   67.606209]  ? do_raw_spin_unlock+0x4d/0xb0
> [   67.606621]  ? _raw_spin_unlock+0x23/0x40
> [   67.607008]  ? free_unref_page+0x510/0x6a0
> [   67.607406]  ? arch_kexec_pre_free_pages+0x1a/0x40
> [   67.607873]  ? do_kexec_load+0x11d/0x340
> [   67.608251]  ? kfree+0xdb/0x3a0
> [   67.608565]  ? __x64_sys_kexec_load+0xa9/0xe0
> [   67.608999]  ? kfree+0xdb/0x3a0
> [   67.609314]  ? do_kexec_load+0x11d/0x340
> [   67.609699]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.610179]  ? syscall_exit_to_user_mode+0x97/0x290
> [   67.610654]  ? do_syscall_64+0xa1/0x180
> [   67.611027]  ? find_held_lock+0x2b/0x80
> [   67.611399]  ? do_user_addr_fault+0x59f/0x8a0
> [   67.611839]  ? do_user_addr_fault+0x5a9/0x8a0
> [   67.612265]  ? trace_hardirqs_off+0x4b/0xc0
> [   67.612662]  ? lockdep_hardirqs_on_prepare+0xdb/0x190
> [   67.613147]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   67.613639] RIP: 0033:0x7f9ae765115d
> [   67.613988] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fb 5c 0c 00 f7 d8 64 89 01 48
> [   67.615719] RSP: 002b:00007ffd17db0ad8 EFLAGS: 00000246 ORIG_RAX: 0000=
0000000000a9
> [   67.616429] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ae=
765115d
> [   67.617098] RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000f=
ee1dead
> [   67.617770] RBP: 00007ffd17db0b20 R08: 0000004d00000000 R09: 0000004d0=
0000000
> [   67.618440] R10: 00007f9ae7745f30 R11: 0000000000000246 R12: 000000000=
0401070
> [   67.619120] R13: 00007ffd17db0c00 R14: 0000000000000000 R15: 000000000=
0000000
> [   67.619803]  </TASK>
> [   67.620127] Enabling non-boot CPUs ...
>
>
> I also saw this one *between* attempts, presumably caused by the virtblk_=
freeze() one:
>
> [   23.699450]
> [   23.699826] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   23.701054] WARNING: possible circular locking dependency detected
> [   23.702409] 6.13.0-rc1+ #2032 Not tainted
> [   23.703148] ------------------------------------------------------
> [   23.704248] kworker/u8:4/76 is trying to acquire lock:
> [   23.705177] ffff892c811a2d48 ((wq_completion)ext4-rsv-conversion){+.+.=
}-{0:0}, at: process_one_work+0x51d/0x590
> [   23.706899]
> [   23.706899] but task is already holding lock:
> [   23.707829] ffff892c82fb5430 (&q->q_usage_counter(io)){++++}-{0:0}, at=
: virtblk_freeze+0x28/0x70
> [   23.709152]
> [   23.709152] which lock already depends on the new lock.
> [   23.709152]
> [   23.710309]
> [   23.710309] the existing dependency chain (in reverse order) is:
> [   23.711374]
> [   23.711374] -> #3 (&q->q_usage_counter(io)){++++}-{0:0}:
> [   23.712380]        blk_mq_submit_bio+0x90d/0xb00
> [   23.713006]        __submit_bio+0x10d/0x1f0
> [   23.713559]        submit_bio_noacct_nocheck+0x324/0x420
> [   23.714266]        ext4_bio_write_folio+0x1fc/0x750
> [   23.714851]        mpage_submit_folio+0x8d/0xb0
> [   23.715409]        mpage_process_page_bufs+0xd0/0x1b0
> [   23.716024]        mpage_prepare_extent_to_map+0x1d0/0x510
> [   23.716669]        ext4_do_writepages+0x4ec/0xee0
> [   23.717246]        ext4_writepages+0xe0/0x280
> [   23.717772]        do_writepages+0xeb/0x290
> [   23.718264]        filemap_fdatawrite_wbc+0x4f/0x70
> [   23.718830]        __filemap_fdatawrite_range+0x60/0x90
> [   23.719440]        file_write_and_wait_range+0x47/0xb0
> [   23.720049]        ext4_sync_file+0xac/0x3e0
> [   23.720548]        do_fsync+0x39/0x70
> [   23.720995]        __x64_sys_fsync+0x13/0x20
> [   23.721481]        do_syscall_64+0x95/0x180
> [   23.721943]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   23.722522]
> [   23.722522] -> #2 (jbd2_handle){++++}-{0:0}:
> [   23.723139]        start_this_handle+0x193/0x540
> [   23.723634]        jbd2_journal_start_reserved+0x54/0x1e0
> [   23.724210]        __ext4_journal_start_reserved+0x7a/0x170
> [   23.724756]        ext4_convert_unwritten_io_end_vec+0x2b/0xe0
> [   23.725304]        ext4_end_io_rsv_work+0x102/0x1d0
> [   23.725798]        process_one_work+0x21f/0x590
> [   23.726255]        worker_thread+0x1c3/0x3b0
> [   23.726690]        kthread+0xd5/0x100
> [   23.727072]        ret_from_fork+0x34/0x50
> [   23.727481]        ret_from_fork_asm+0x1a/0x30
> [   23.727939]
> [   23.727939] -> #1 ((work_completion)(&ei->i_rsv_conversion_work)){+.+.=
}-{0:0}:
> [   23.728788]        process_one_work+0x1f4/0x590
> [   23.729267]        worker_thread+0x1c3/0x3b0
> [   23.729715]        kthread+0xd5/0x100
> [   23.730100]        ret_from_fork+0x34/0x50
> [   23.730502]        ret_from_fork_asm+0x1a/0x30
> [   23.730944]
> [   23.730944] -> #0 ((wq_completion)ext4-rsv-conversion){+.+.}-{0:0}:
> [   23.731688]        __lock_acquire+0x14ba/0x25c0
> [   23.732142]        lock_acquire+0xd0/0x310
> [   23.732550]        process_one_work+0x52e/0x590
> [   23.732995]        worker_thread+0x1c3/0x3b0
> [   23.733424]        kthread+0xd5/0x100
> [   23.733783]        ret_from_fork+0x34/0x50
> [   23.734191]        ret_from_fork_asm+0x1a/0x30
> [   23.734632]
> [   23.734632] other info that might help us debug this:
> [   23.734632]
> [   23.735409] Chain exists of:
> [   23.735409]   (wq_completion)ext4-rsv-conversion --> jbd2_handle --> &=
q->q_usage_counter(io)
> [   23.735409]
> [   23.736630]  Possible unsafe locking scenario:
> [   23.736630]
> [   23.737214]        CPU0                    CPU1
> [   23.737662]        ----                    ----
> [   23.738124]   lock(&q->q_usage_counter(io));
> [   23.738539]                                lock(jbd2_handle);
> [   23.739112]                                lock(&q->q_usage_counter(io=
));
> [   23.739770]   lock((wq_completion)ext4-rsv-conversion);
> [   23.740296]
> [   23.740296]  *** DEADLOCK ***
> [   23.740296]
> [   23.740850] 2 locks held by kworker/u8:4/76:
> [   23.741284]  #0: ffff892c82fb5430 (&q->q_usage_counter(io)){++++}-{0:0=
}, at: virtblk_freeze+0x28/0x70
> [   23.742172]  #1: ffff892c82fb5468 (&q->q_usage_counter(queue)){++++}-{=
0:0}, at: virtblk_freeze+0x28/0x70
> [   23.743083]
> [   23.743083] stack backtrace:
> [   23.743514] CPU: 0 UID: 0 PID: 76 Comm: kworker/u8:4 Not tainted 6.13.=
0-rc1+ #2032
> [   23.744259] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   23.745355] Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
> [   23.745947] Call Trace:
> [   23.746207]  <TASK>
> [   23.746428]  dump_stack_lvl+0x84/0xd0
> [   23.746807]  print_circular_bug.cold+0x178/0x1be
> [   23.747280]  check_noncircular+0x148/0x160
> [   23.747694]  __lock_acquire+0x14ba/0x25c0
> [   23.748114]  lock_acquire+0xd0/0x310
> [   23.748480]  ? process_one_work+0x51d/0x590
> [   23.748906]  ? mark_held_locks+0x40/0x70
> [   23.749303]  process_one_work+0x52e/0x590
> [   23.749705]  ? process_one_work+0x51d/0x590
> [   23.750136]  worker_thread+0x1c3/0x3b0
> [   23.750503]  ? __pfx_worker_thread+0x10/0x10
> [   23.750923]  kthread+0xd5/0x100
> [   23.751235]  ? __pfx_kthread+0x10/0x10
> [   23.751601]  ret_from_fork+0x34/0x50
> [   23.751968]  ? __pfx_kthread+0x10/0x10
> [   23.752334]  ret_from_fork_asm+0x1a/0x30
> [   23.752721]  </TASK>
> [   23.753031] BUG: workqueue leaked atomic, lock or RCU: kworker/u8:4[76=
]
> [   23.753031]      preempt=3D0x00000000 lock=3D2->0 RCU=3D0->0 workfn=3D=
ext4_end_io_rsv_work
> [   23.754419] INFO: lockdep is turned off.
> [   23.754814] CPU: 0 UID: 0 PID: 76 Comm: kworker/u8:4 Not tainted 6.13.=
0-rc1+ #2032
> [   23.755537] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   23.756621] Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
> [   23.757214] Call Trace:
> [   23.757464]  <TASK>
> [   23.757682]  dump_stack_lvl+0x84/0xd0
> [   23.758060]  process_one_work.cold+0x6d/0xc8
> [   23.758481]  ? __pfx_ext4_end_io_rsv_work+0x10/0x10
> [   23.758946]  ? process_one_work+0x24a/0x590
> [   23.759339]  worker_thread+0x1c3/0x3b0
> [   23.759706]  ? __pfx_worker_thread+0x10/0x10
> [   23.760276]  kthread+0xd5/0x100
> [   23.760581]  ? __pfx_kthread+0x10/0x10
> [   23.760956]  ret_from_fork+0x34/0x50
> [   23.761306]  ? __pfx_kthread+0x10/0x10
> [   23.761669]  ret_from_fork_asm+0x1a/0x30
> [   23.762064]  </TASK>
>
>
>


