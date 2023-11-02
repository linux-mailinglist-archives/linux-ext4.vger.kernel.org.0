Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F37DF72B
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 16:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347590AbjKBP5O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Nov 2023 11:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347626AbjKBP5N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Nov 2023 11:57:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99418C;
        Thu,  2 Nov 2023 08:57:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698940623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1gAqQ3hVHK5gcuRSfvCq9nhAUdWEClgAM1YV5Y08zdM=;
        b=yyvRMEmqpu+wjA5jae5xZXmkTO5mcvpaCikaDM2+0+elrMESGuldNIiaaKjdRjU2hHSL9H
        JSEMXNRSI1BQPio84UUh4K4W7gqZsH/P7lhYp08v2L/b6XvO0wew5vunmyKPuPxnxfD0sw
        Ta7u1NK+jdNRdeepxHX9lXnOHJ9w7S6tsOu7vsTM5NZNu4rS7xfPgrgr27o2T1KQU0oGNG
        hXVB604qDQ6pZpAy9y4m9xpkxf6ew0cXsme1dO7qbINpOBiUa/lfe5C4MPCfnJZsh+Da7M
        MXppaVtteR2cgKcLp36lsg73rIwtxaEmxcMc8Nb1GyByx5Lmc1mJIoNddTI7bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698940623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1gAqQ3hVHK5gcuRSfvCq9nhAUdWEClgAM1YV5Y08zdM=;
        b=Qg+YOBQAjjT5w+UVEws3EENDdp84Up87aRQtq7uHWUP3QjvWgZbNRBUcsbdkNNiYaxIK0/
        9/9yR7Fpdrg/6FAw==
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
In-Reply-To: <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com>
References: <000000000000cfd180060910a687@google.com> <875y2lmxys.ffs@tglx>
 <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com>
Date:   Thu, 02 Nov 2023 16:57:03 +0100
Message-ID: <87r0l8kv1s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 02 2023 at 13:08, Aleksandr Nogikh wrote:
> On Wed, Nov 1, 2023 at 1:58=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> Unfortunately repro.syz does not hold up to its name and refuses to
>> reproduce.
>
> For me, on a locally built kernel (gcc 13.2.0) it didn't work either.
>
> But, interestingly, it does reproduce using the syzbot-built kernel
> shared via the "Downloadable assets" [1] in the original report. The
> repro crashed the kernel in ~1 minute.
>
> [1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md
>
> [  125.919060][    C0] BUG: KASAN: stack-out-of-bounds in rb_next+0x10a/0=
x130
> [  125.921169][    C0] Read of size 8 at addr ffffc900048e7c60 by task
> kworker/0:1/9
> [  125.923235][    C0]
> [  125.923243][    C0] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
> 6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
> [  125.924546][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9,
> 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  125.926915][    C0] Workqueue: events nsim_dev_trap_report_work
> [  125.929333][    C0]
> [  125.929341][    C0] Call Trace:
> [  125.929350][    C0]  <IRQ>
> [  125.929356][    C0]  dump_stack_lvl+0xd9/0x1b0
> [  125.931302][    C0]  print_report+0xc4/0x620
> [  125.932115][    C0]  ? __virt_addr_valid+0x5e/0x2d0
> [  125.933194][    C0]  kasan_report+0xda/0x110
> [  125.934814][    C0]  ? rb_next+0x10a/0x130
> [  125.936521][    C0]  ? rb_next+0x10a/0x130
> [  125.936544][    C0]  rb_next+0x10a/0x130
> [  125.936565][    C0]  timerqueue_del+0xd4/0x140
> [  125.936590][    C0]  __remove_hrtimer+0x99/0x290
> [  125.936613][    C0]  __hrtimer_run_queues+0x55b/0xc10
> [  125.936638][    C0]  ? enqueue_hrtimer+0x310/0x310
> [  125.936659][    C0]  ? ktime_get_update_offsets_now+0x3bc/0x610
> [  125.936688][    C0]  hrtimer_interrupt+0x31b/0x800
> [  125.936715][    C0]  __sysvec_apic_timer_interrupt+0x105/0x3f0
> [  125.936737][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0
> [  125.936755][    C0]  </IRQ>
> [  125.936759][    C0]  <TASK>

Which is a completely different failure mode.

It explodes in the hrtimer interrupt when dequeuing an hrtimer for
expiry. That means the corresponding embedded rb_node is corrupted,
which points to random data corruption.

As you can reproduce (it still fails here with the provided assets),
does the failure change when you run it several times?

Thanks,

        tglx
