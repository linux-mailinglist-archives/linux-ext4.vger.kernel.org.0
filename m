Return-Path: <linux-ext4+bounces-1-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD6C7E7EDD
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Nov 2023 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5421C20DB3
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Nov 2023 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406DB3B2BD;
	Fri, 10 Nov 2023 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1P9XP7bi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB383A29D
	for <linux-ext4@vger.kernel.org>; Fri, 10 Nov 2023 17:46:39 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C37D9D
	for <linux-ext4@vger.kernel.org>; Thu,  9 Nov 2023 22:47:18 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cdc669c5eso505461cf.1
        for <linux-ext4@vger.kernel.org>; Thu, 09 Nov 2023 22:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699598837; x=1700203637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1gTqrJKHlb0DQZEnTZIMK5A0G74ZbPPA6krp64Uv1U=;
        b=1P9XP7biqo6BAs5FmOevxu1Ngl67YD1PwCfl+BxXEfrfq9b9snKj9BdYIbkFJh7zOl
         rXzpm052sl/LIGDD78pm/nXHmJ2vo0ZQ4cYjXRe8eLeOKi/FrPQdqFUBvLvvjuSNCs1j
         F1rgubk2vyxcdDhQlPSPg0i5qzTNRz9SGvwxKYbdW47QMzrjJ+Gq2j4GKIxq1yooSpqt
         WAEbciQHM0ZlufeEr7UKgc+XIA4ZLlIhyqohNS9+AHS0enRbkK0fZhAH07ByWKt3qf9S
         CFiQVPkuIaNCgeUwYK7IX1F0BhicBMlHLMNj6iJGZdjLSOwFKGr902dWsMlnv/VI/T9L
         CkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598837; x=1700203637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1gTqrJKHlb0DQZEnTZIMK5A0G74ZbPPA6krp64Uv1U=;
        b=J3n7moRlY12u0qCmpQL9YXBFVbtJKr8NXiYDoEwey6H4ZoptLoUfiVPUwefQ/Ozt1O
         9cS/q1tNimFDZ5VNmQW5ZsmMFMNBtrkc1zSNZXN3lXb9y4J6JVYeTh2RC0PTMfX9xk98
         AVbpytGa5vQxk+rOEcBKZKYhgZelVZE6fpHhPHR5U0oFJz6lG62H7K6BO1RssVgkzZwe
         Tc3VxAjIOr1kv2Y6RovjgOH0RUxiqb/k+ifcl8mFXmnAcLLokY8h5URdrQkYkNsOpkW2
         R5no7943WUTDMk6hm/HcqXrK/3SFjRFyklwbmbSj8QFNPhPaAuobJ5BKlcjaP6Mldz0l
         bueA==
X-Gm-Message-State: AOJu0YzLyko40HcX1v3KABpXIqbYGLLZ09L61Pnu7lw2ca7jabqv12bW
	pQRUPgZFRIq8EUU8J/SOHGdO+cCiQ3lSoPD2L6pbce3vVSvg7VEKvbPP3bi8
X-Google-Smtp-Source: AGHT+IFfJqPrd41UFTHcJYQAfbj7mIw6bg8DwFRN5S/STX1gsKnTCPU/T443l/TfVXIpwH1zvFQDYoS9WL1D7NKTe0Y=
X-Received: by 2002:a17:902:f688:b0:1bb:2c7b:6d67 with SMTP id
 l8-20020a170902f68800b001bb2c7b6d67mr475537plg.11.1699592431687; Thu, 09 Nov
 2023 21:00:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000cfd180060910a687@google.com> <875y2lmxys.ffs@tglx>
 <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com> <87r0l8kv1s.ffs@tglx>
In-Reply-To: <87r0l8kv1s.ffs@tglx>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 9 Nov 2023 21:00:18 -0800
Message-ID: <CANp29Y5BnnYBauXyHmUKrgrn5LZpz8nDuZFTwLLB7WHq4DS6Wg@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 8:57=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Thu, Nov 02 2023 at 13:08, Aleksandr Nogikh wrote:
> > On Wed, Nov 1, 2023 at 1:58=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >> Unfortunately repro.syz does not hold up to its name and refuses to
> >> reproduce.
> >
> > For me, on a locally built kernel (gcc 13.2.0) it didn't work either.
> >
> > But, interestingly, it does reproduce using the syzbot-built kernel
> > shared via the "Downloadable assets" [1] in the original report. The
> > repro crashed the kernel in ~1 minute.
> >
> > [1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.=
md
> >
> > [  125.919060][    C0] BUG: KASAN: stack-out-of-bounds in rb_next+0x10a=
/0x130
> > [  125.921169][    C0] Read of size 8 at addr ffffc900048e7c60 by task
> > kworker/0:1/9
> > [  125.923235][    C0]
> > [  125.923243][    C0] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
> > 6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
> > [  125.924546][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9,
> > 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  125.926915][    C0] Workqueue: events nsim_dev_trap_report_work
> > [  125.929333][    C0]
> > [  125.929341][    C0] Call Trace:
> > [  125.929350][    C0]  <IRQ>
> > [  125.929356][    C0]  dump_stack_lvl+0xd9/0x1b0
> > [  125.931302][    C0]  print_report+0xc4/0x620
> > [  125.932115][    C0]  ? __virt_addr_valid+0x5e/0x2d0
> > [  125.933194][    C0]  kasan_report+0xda/0x110
> > [  125.934814][    C0]  ? rb_next+0x10a/0x130
> > [  125.936521][    C0]  ? rb_next+0x10a/0x130
> > [  125.936544][    C0]  rb_next+0x10a/0x130
> > [  125.936565][    C0]  timerqueue_del+0xd4/0x140
> > [  125.936590][    C0]  __remove_hrtimer+0x99/0x290
> > [  125.936613][    C0]  __hrtimer_run_queues+0x55b/0xc10
> > [  125.936638][    C0]  ? enqueue_hrtimer+0x310/0x310
> > [  125.936659][    C0]  ? ktime_get_update_offsets_now+0x3bc/0x610
> > [  125.936688][    C0]  hrtimer_interrupt+0x31b/0x800
> > [  125.936715][    C0]  __sysvec_apic_timer_interrupt+0x105/0x3f0
> > [  125.936737][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0
> > [  125.936755][    C0]  </IRQ>
> > [  125.936759][    C0]  <TASK>
>
> Which is a completely different failure mode.
>
> It explodes in the hrtimer interrupt when dequeuing an hrtimer for
> expiry. That means the corresponding embedded rb_node is corrupted,
> which points to random data corruption.
>
> As you can reproduce (it still fails here with the provided assets),
> does the failure change when you run it several times?

Hmm, it's weird. Maybe I was very lucky that time.

The reproducer does work on the attached disk image, but definitely
not very often. I've just run it 10 times or so and got interleaved
BUG/KFENCE bug reports like this (twice):
https://pastebin.com/W0TkRsnw

These seem to be related to ext4 rather than hrtimers though.

--=20
Aleksandr

>
> Thanks,
>
>         tglx

