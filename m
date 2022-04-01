Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485934EEA44
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Apr 2022 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbiDAJVs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242965AbiDAJVr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 05:21:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E94D9F2
        for <linux-ext4@vger.kernel.org>; Fri,  1 Apr 2022 02:19:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 756B221110;
        Fri,  1 Apr 2022 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648804796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MqZS2ffNONM0NxDKplPeZE1PEbHgdc058ywGpxyaEEY=;
        b=Q/EMS+WxVHLvVTGJXFCex0MnL7nOxPGMsvpYhX9h3c2HJ4M7CkZlSGXKV2F0ObIiDK4nER
        FhWPLWGZ94MDcXObvg0pz9X2XiiuQ/SLqNgn8sAsE0noN2KFSfpDl28QYhD2bnXyvdibHq
        G980SBKYyrb6nYA71Spd8x+5Bmf9+lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648804796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MqZS2ffNONM0NxDKplPeZE1PEbHgdc058ywGpxyaEEY=;
        b=tbY5RAHejLBf62raqbZg8drdshUSQFgA8dTIli2J0SCGfSgo5KdpUJRy2NKc8osfF+r3Vq
        EiptSrCLlXhPkJDw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62261A3B82;
        Fri,  1 Apr 2022 09:19:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4148DA0610; Fri,  1 Apr 2022 11:19:50 +0200 (CEST)
Date:   Fri, 1 Apr 2022 11:19:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     chill <maximkabox13@gmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: Use-After-Free Write in jbd2_journal_wait_updates in mainline
 Linux kernel 5.17
Message-ID: <20220401091950.eszmhrgjhd4j4745@quack3.lan>
References: <CANpfEhMi-9bFLCof9QODZgc8A31QWst8X5BAiQw4Mp=PhvWF=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpfEhMi-9bFLCof9QODZgc8A31QWst8X5BAiQw4Mp=PhvWF=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 31-03-22 16:51:59, chill wrote:
> Hello, I found a similar vulnerability in the kernel like this:
> https://groups.google.com/g/syzkaller-bugs/c/AHp-BfwUM50/m/Jas1oKfmAAAJ in
> the kernel: https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.17.tar.xz
> REPORT:
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read_write
> include/linux/instrumented.h:101 [inline]
> BUG: KASAN: use-after-free in atomic_try_cmpxchg_acquire
> include/linux/atomic/atomic-instrumented.h:541 [inline]
> BUG: KASAN: use-after-free in queued_spin_lock
> include/asm-generic/qspinlock.h:82 [inline]
> BUG: KASAN: use-after-free in do_raw_spin_lock include/linux/spinlock.h:185
> [inline]
> BUG: KASAN: use-after-free in __raw_spin_lock
> include/linux/spinlock_api_smp.h:134 [inline]
> BUG: KASAN: use-after-free in _raw_spin_lock+0x73/0xd0
> kernel/locking/spinlock.c:154
> Write of size 4 at addr ffff8880236f11a0 by task syz-executor.2/9557
> 
> CPU: 0 PID: 9557 Comm: syz-executor.2 Not tainted 5.17.0-rc6 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2
> 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x4d/0x66 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x1f/0x150 mm/kasan/report.c:255
>  __kasan_report mm/kasan/report.c:442 [inline]
>  kasan_report.cold+0x7f/0x11b mm/kasan/report.c:459
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0xf9/0x1e0 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>  atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:541
> [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:82 [inline]
>  do_raw_spin_lock include/linux/spinlock.h:185 [inline]
>  __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
>  _raw_spin_lock+0x73/0xd0 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:349 [inline]
>  jbd2_journal_wait_updates+0x1f1/0x280 fs/jbd2/transaction.c:861
>  jbd2_journal_lock_updates+0x13a/0x2e0 fs/jbd2/transaction.c:896
>  ext4_ioctl_checkpoint fs/ext4/ioctl.c:1085 [inline]
>  __ext4_ioctl+0xb5b/0x44f0 fs/ext4/ioctl.c:1562
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x170/0x1d0 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

Thanks for report. This should be fixed by commit f7f497cb702 ("jbd2: kill
t_handle_lock transaction spinlock") which got just merged into 5.18-rc1.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
