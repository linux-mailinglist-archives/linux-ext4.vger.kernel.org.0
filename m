Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FE7DF205
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 13:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKBMJN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Nov 2023 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKBMJN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Nov 2023 08:09:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F1192
        for <linux-ext4@vger.kernel.org>; Thu,  2 Nov 2023 05:09:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc30de471dso76565ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 02 Nov 2023 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698926950; x=1699531750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3bCx5CCooPYj1BvJi7qkrEgopG1E3ih5T9cCzZ0dUw=;
        b=aq29/+x7q7QOpAPkNJh1KFGlbJsmCC+BczUKp9PZEi0m9QHXM9JvF6G4Dxl9rky4YP
         KzV8Y85EFGfsbdKRqm0QW9koSPv6f95bk63P18rjq6zDa4pnbQMHuWAStJCJT+A1uGvh
         Q0FPGBXNs8G5jTX672ijRTRIRGF+ZhXpi1LsdVcSk7vCQKVIemXLujeZca4eKlrz2Ndm
         8RBbFA3b/ATcCnFZJtPKPdVy4SQdvHw8pUTh2d183Urzy7CCUXPaNFEeCSao0WBPk6Ob
         M1CVQ8V3qVL2IIJwlUqmkhqF5yibq3f56T01UAW0Af838YZos/jqcQ1wqZwSZJanQ37+
         QApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926950; x=1699531750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3bCx5CCooPYj1BvJi7qkrEgopG1E3ih5T9cCzZ0dUw=;
        b=TD2+bRzTLwh6EvZ/K/5q5kHK1QdK7DYNvsD+/X6r01xA2qIaVBkRW+N41omzNo1kzB
         nMCYxtfGbXvD+UdIq8ATQKxXcCPdb/+T1TyLiclZEfpCmrynNB3QSixqQcnl1T3TNkkX
         96wnIw0RCrmd4D1yLX/+pr2VQHZH8Cjm27Y0ZhDpbzKR8U05n2TfOJcdk8qEFsuOIiBP
         IEp0GX3Vo5F9SHmEeUEFHToyj90mTKYrCKxsubaRN92KUijx3nR7kouRMawiU/0pbh6E
         sTr+PHobs+1UFkoBDbDxOy51LhJzPs6dlu4x7IDY55tZ5OsSqdHbuMMIdw0MLOJdyK+8
         8T6Q==
X-Gm-Message-State: AOJu0YyTLudDIwRB6FKIc39pKN9ZhwIOYhZMkP9TUlBGZxjo2rdglYwQ
        XzXHJBUsVFZLu0EDvG+AW6pOWVXkk1EZPhqbjNYctA==
X-Google-Smtp-Source: AGHT+IEOjxIqPMvkPrgTv2pyQJ4CT19Aqko2Fcjtn55rIlRpk3ILPFB0WbGngUAHLyZ+hqipT+4kNWlKicKYJ4etiyE=
X-Received: by 2002:a17:902:d4c9:b0:1cc:2bb6:66eb with SMTP id
 o9-20020a170902d4c900b001cc2bb666ebmr98635plg.16.1698926949690; Thu, 02 Nov
 2023 05:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cfd180060910a687@google.com> <875y2lmxys.ffs@tglx>
In-Reply-To: <875y2lmxys.ffs@tglx>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 2 Nov 2023 13:08:58 +0100
Message-ID: <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 1, 2023 at 1:58=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Oct 31 2023 at 22:36, syzbot wrote:
> > general protection fault, probably for non-canonical address 0xdffffc00=
3ffff113: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: probably user-memory-access in range [0x00000001ffff8898-0x00000=
001ffff889f]
> > CPU: 1 PID: 5308 Comm: syz-executor.4 Not tainted 6.6.0-rc7-syzkaller-0=
0142-g888cf78c29e2 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/09/2023
> > RIP: 0010:lookup_object lib/debugobjects.c:195 [inline]
> > RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:564 [inline]
> > RIP: 0010:__debug_object_init+0xf3/0x2b0 lib/debugobjects.c:634
> > Code: d8 48 c1 e8 03 42 80 3c 20 00 0f 85 85 01 00 00 48 8b 1b 48 85 db=
 0f 84 9f 00 00 00 48 8d 7b 18 83 c5 01 48 89 f8 48 c1 e8 03 <42> 80 3c 20 =
00 0f 85 4c 01 00 00 4c 3b 73 18 75 c3 48 8d 7b 10 48
> > RSP: 0018:ffffc900050e7d08 EFLAGS: 00010012
> > RAX: 000000003ffff113 RBX: 00000001ffff8880 RCX: ffffffff8169123e
> > RDX: 1ffffffff249b149 RSI: 0000000000000004 RDI: 00000001ffff8898
> > RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000216
> > R10: 0000000000000003 R11: 0000000000000000 R12: dffffc0000000000
> > R13: ffffffff924d8a48 R14: ffffc900050e7d90 R15: ffffffff924d8a50
> > FS:  0000555556eec480(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa23ab065ee CR3: 000000007e5c1000 CR4: 0000000000350ee0
>
> So this dies in debugobjects::lookup_object()
>
> hlist_for_each_entry()
>
> >   10: 48 8b 1b                mov    (%rbx),%rbx
>
> Gets the next entry
>
> >   13: 48 85 db                test   %rbx,%rbx
> >   16: 0f 84 9f 00 00 00       je     0xbb
>
> Checks for the termination condition (NULL pointer)
>
> >   1c: 48 8d 7b 18             lea    0x18(%rbx),%rdi
>
> Calculates the address of obj->object
>
> >   20: 83 c5 01                add    $0x1,%ebp
>
> cnt++;
>
> >   23: 48 89 f8                mov    %rdi,%rax
> >   26: 48 c1 e8 03             shr    $0x3,%rax
>
> KASAN shadow address calculation
>
> > * 2a: 42 80 3c 20 00          cmpb   $0x0,(%rax,%r12,1) <-- trapping in=
struction
>
> Kasan accesses 0xdffffc003ffff113 and dies.
>
> RBX contains the pointer to the next object: 0x00000001ffff8880 which is
> clearly a user space address, but I have no idea where that might come
> from. It's obviously data corruption of unknown provenience.
>
> Unfortunately repro.syz does not hold up to its name and refuses to
> reproduce.

For me, on a locally built kernel (gcc 13.2.0) it didn't work either.

But, interestingly, it does reproduce using the syzbot-built kernel
shared via the "Downloadable assets" [1] in the original report. The
repro crashed the kernel in ~1 minute.

[1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md

[  125.919060][    C0] BUG: KASAN: stack-out-of-bounds in rb_next+0x10a/0x1=
30
[  125.921169][    C0] Read of size 8 at addr ffffc900048e7c60 by task
kworker/0:1/9
[  125.923235][    C0]
[  125.923243][    C0] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
[  125.924546][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  125.926915][    C0] Workqueue: events nsim_dev_trap_report_work
[  125.929333][    C0]
[  125.929341][    C0] Call Trace:
[  125.929350][    C0]  <IRQ>
[  125.929356][    C0]  dump_stack_lvl+0xd9/0x1b0
[  125.931302][    C0]  print_report+0xc4/0x620
[  125.932115][    C0]  ? __virt_addr_valid+0x5e/0x2d0
[  125.933194][    C0]  kasan_report+0xda/0x110
[  125.934814][    C0]  ? rb_next+0x10a/0x130
[  125.936521][    C0]  ? rb_next+0x10a/0x130
[  125.936544][    C0]  rb_next+0x10a/0x130
[  125.936565][    C0]  timerqueue_del+0xd4/0x140
[  125.936590][    C0]  __remove_hrtimer+0x99/0x290
[  125.936613][    C0]  __hrtimer_run_queues+0x55b/0xc10
[  125.936638][    C0]  ? enqueue_hrtimer+0x310/0x310
[  125.936659][    C0]  ? ktime_get_update_offsets_now+0x3bc/0x610
[  125.936688][    C0]  hrtimer_interrupt+0x31b/0x800
[  125.936715][    C0]  __sysvec_apic_timer_interrupt+0x105/0x3f0
[  125.936737][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0
[  125.936755][    C0]  </IRQ>
[  125.936759][    C0]  <TASK>



>
> Thanks,
>
>         tglx
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/875y2lmxys.ffs%40tglx.
