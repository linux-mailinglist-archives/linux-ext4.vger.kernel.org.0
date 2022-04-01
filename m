Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895364EEB0C
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Apr 2022 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiDAKNz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 06:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiDAKNs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 06:13:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3526E54A
        for <linux-ext4@vger.kernel.org>; Fri,  1 Apr 2022 03:11:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so2063785pjk.4
        for <linux-ext4@vger.kernel.org>; Fri, 01 Apr 2022 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R3u990n2asqpncMN2GapcClO/pYW1lRXSxbh33GC8pM=;
        b=SsmrnTebS72G47IIBTLu7kT+ouWT10k30VwI33NsTWH+io57TjhIWUhCP2G+EjPAP6
         owD7U6bi4pjTWe9Xx7yFOho7pFPVznuKbUjPQgguwGqInmNlMYgm15LkUiFrL2HpBJDR
         26lrsYX9jFQ5NiXBU6La+Y7tU+bpLPvW4JE8JAFSh5MM90yj0QljM96LLhbGBlGoRYsT
         La0kl1d9PgvvqtikIpZgK3P1G8BcQABYuNt48O/PTJHyJ3hAWHqltNuWgHb8o08vv3Oj
         cCyBRIxmpBskjYMPfSgLqOotwaRwW0L7C4zAZq24fai7q5N7DgTeKlG1tPb1wj77weWx
         bYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3u990n2asqpncMN2GapcClO/pYW1lRXSxbh33GC8pM=;
        b=gl39fWHzsGrIzJjmslOyIMXmKJ7dwIxN42hQmU09OfbScnMLNIzv/sj4iS9c5ClB9J
         8xB9Uqyis62LN27ueSUnIYfVmsEcPUjwaztzY5JgIcNiFrLSbHfqi2hLsNP+8ANdFJEL
         P5BePUFZxK7dG4iueko052b4sIOPHpkADV1BXSrCucUw02cfqwkl9Uc0UnjZqqn/N/yj
         /FK7s0BL1b5nuPFo1EdBEomIrH6U93Yb1Kcg/69JLMNwtRjEN55h7/FsYBIXSB1gQ2Fh
         H3TubDYPJfnjnm5+mX+wnhdegzI6gQ3kfeTgTKaXCxJ9eohTkxmdFN6PJEoHFSGnXEsx
         ANMw==
X-Gm-Message-State: AOAM533yEdHZrtnN9bouVHjBg2m23biiELvlLeffC8ir2fGFZyQ9DopJ
        oFYFnPEP5pL5XjQgqL61sEw=
X-Google-Smtp-Source: ABdhPJxYRSuEIK+ADYW/yLpfEdS2OzMqhC/yfV3rpR1pot+aEnGPC+6SXCSvQl/00bGBAB+VzeNiNQ==
X-Received: by 2002:a17:902:e9c2:b0:153:c185:c7b1 with SMTP id 2-20020a170902e9c200b00153c185c7b1mr9713360plk.92.1648807918368;
        Fri, 01 Apr 2022 03:11:58 -0700 (PDT)
Received: from localhost ([122.179.46.149])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a0023c500b004fae15ab86dsm2440613pfc.52.2022.04.01.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:11:57 -0700 (PDT)
Date:   Fri, 1 Apr 2022 15:41:55 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     chill <maximkabox13@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: Use-After-Free Write in jbd2_journal_wait_updates in mainline
 Linux kernel 5.17
Message-ID: <20220401101155.c7xrnites7bmwjza@riteshh-domain>
References: <CANpfEhMi-9bFLCof9QODZgc8A31QWst8X5BAiQw4Mp=PhvWF=Q@mail.gmail.com>
 <20220401091950.eszmhrgjhd4j4745@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401091950.eszmhrgjhd4j4745@quack3.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/04/01 11:19AM, Jan Kara wrote:
> On Thu 31-03-22 16:51:59, chill wrote:
> > Hello, I found a similar vulnerability in the kernel like this:
> > https://groups.google.com/g/syzkaller-bugs/c/AHp-BfwUM50/m/Jas1oKfmAAAJ in
> > the kernel: https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.17.tar.xz
> > REPORT:
> > ==================================================================
> > BUG: KASAN: use-after-free in instrument_atomic_read_write
> > include/linux/instrumented.h:101 [inline]
> > BUG: KASAN: use-after-free in atomic_try_cmpxchg_acquire
> > include/linux/atomic/atomic-instrumented.h:541 [inline]
> > BUG: KASAN: use-after-free in queued_spin_lock
> > include/asm-generic/qspinlock.h:82 [inline]
> > BUG: KASAN: use-after-free in do_raw_spin_lock include/linux/spinlock.h:185
> > [inline]
> > BUG: KASAN: use-after-free in __raw_spin_lock
> > include/linux/spinlock_api_smp.h:134 [inline]
> > BUG: KASAN: use-after-free in _raw_spin_lock+0x73/0xd0
> > kernel/locking/spinlock.c:154
> > Write of size 4 at addr ffff8880236f11a0 by task syz-executor.2/9557
> >
> > CPU: 0 PID: 9557 Comm: syz-executor.2 Not tainted 5.17.0-rc6 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2
> > 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x4d/0x66 lib/dump_stack.c:106
> >  print_address_description.constprop.0+0x1f/0x150 mm/kasan/report.c:255
> >  __kasan_report mm/kasan/report.c:442 [inline]
> >  kasan_report.cold+0x7f/0x11b mm/kasan/report.c:459
> >  check_region_inline mm/kasan/generic.c:183 [inline]
> >  kasan_check_range+0xf9/0x1e0 mm/kasan/generic.c:189
> >  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> >  atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:541
> > [inline]
> >  queued_spin_lock include/asm-generic/qspinlock.h:82 [inline]
> >  do_raw_spin_lock include/linux/spinlock.h:185 [inline]
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
> >  _raw_spin_lock+0x73/0xd0 kernel/locking/spinlock.c:154
> >  spin_lock include/linux/spinlock.h:349 [inline]
> >  jbd2_journal_wait_updates+0x1f1/0x280 fs/jbd2/transaction.c:861
> >  jbd2_journal_lock_updates+0x13a/0x2e0 fs/jbd2/transaction.c:896
> >  ext4_ioctl_checkpoint fs/ext4/ioctl.c:1085 [inline]
> >  __ext4_ioctl+0xb5b/0x44f0 fs/ext4/ioctl.c:1562
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:874 [inline]
> >  __se_sys_ioctl fs/ioctl.c:860 [inline]
> >  __x64_sys_ioctl+0x170/0x1d0 fs/ioctl.c:860
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Thanks for report. This should be fixed by commit f7f497cb702 ("jbd2: kill
> t_handle_lock transaction spinlock") which got just merged into 5.18-rc1.

Thanks Jan,
This I think is now picked by Greg too for 5.17 stable [1].

[1]: https://lore.kernel.org/all/20220325150421.134448886@linuxfoundation.org/

-ritesh
