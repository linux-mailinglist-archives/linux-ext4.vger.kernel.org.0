Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25082314989
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 08:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBIHd4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 02:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhBIHdm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 02:33:42 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB4FC06178A
        for <linux-ext4@vger.kernel.org>; Mon,  8 Feb 2021 23:33:01 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h16so12285410qth.11
        for <linux-ext4@vger.kernel.org>; Mon, 08 Feb 2021 23:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVEpjbClC035S5ibQ3e069K0mlhkJOTLLZx1pzdF8aU=;
        b=A7ld3lRuRRxyXXaZ/d0gq+YdppkaG7bYeFmD/q9DXvw85a57FrepHQnBDcERwKMC/o
         7mnTT0HZCc3BRHX9dYfsWPidFIiyw8zA9s4K3tbUFbWH3tfddAtMXUP75BqlWtR0OZGS
         qCQDIrpv5d1wfr0eboPmcipgNv/N+hQfocTdNg8MH5eGItRGheo3OzCsHok5wOsC3Lio
         WPXA8vqUqnXx5wgzgL59qh46vm0ixvozA6LEuTRzsdmPUMhcBHTSy4nrUKIBhd4wSSgD
         9NNGZom1RQBjqqqK0M5MX7hahO9PcVACEz3wEAZbDHLVAHR2Q/k9BrvIktu8kjEH3SdB
         Anlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVEpjbClC035S5ibQ3e069K0mlhkJOTLLZx1pzdF8aU=;
        b=pwC9bKnUh/ebe4DUlzoxDZNhADus5xeagnYwQsJEzgNkY0zx8dZItL1XdDUrL57MK4
         tLp7fSx7Jgadz+dGTfuYGIL2T5apcreDVTfxkTxeOCKW6k77ytYyMLZArhMqxYwEwuIp
         8E7h95cwHPuLVTnNoO4MXKea/DLcHvdJtOiH0QK2kO3lu9vjD53Ak8pcL+tnR0qDV7ld
         7hW/zmakVH9aZgikH7E/dcd72RbUF/7w/2VZpqy8/yQovJUukM3IR7o70EzNomz3UwzL
         N5P+7YODAT17CvIHWoh8vrnmJ717P3gXG9ZLtt7ZO/4D4rRYYuddiUHnVP21zPDMMgRf
         oHqA==
X-Gm-Message-State: AOAM532A8sFpMEWmXWSfgxl+bVGJExN/oE6UZkUr+RmYHF0nBhR46lIN
        qfbh4JpXka9MiAOuMBrXxg+sxCqgaNcCW7j5FatIzg==
X-Google-Smtp-Source: ABdhPJxkLG3FPyzIVtW5cCxCr3nmn7U00/ybPHgPiZNqo8uHfZfMsemqI6bYvfmwhfSgKtQNKpF9fHhelj8yfoFh4Ko=
X-Received: by 2002:ac8:7c82:: with SMTP id y2mr18604566qtv.67.1612855980867;
 Mon, 08 Feb 2021 23:33:00 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038fcd705babe13b5@google.com>
In-Reply-To: <00000000000038fcd705babe13b5@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Feb 2021 08:32:49 +0100
Message-ID: <CACT4Y+ZyNWDL94b-iLsHapk85vkH7JzV+R2Wf44-1N47dpy5tA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ext4_inode_journal_mode
To:     syzbot <syzbot+b2ffafb709f9a29ec5b4@syzkaller.appspotmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Feb 7, 2021 at 1:20 PM syzbot
<syzbot+b2ffafb709f9a29ec5b4@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    73d62e81 kmsan: random: prevent boot-time reports in _mix_..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=152188c4d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df698232b2ac45c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=b2ffafb709f9a29ec5b4
> compiler:       Debian clang version 11.0.1-2
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b2ffafb709f9a29ec5b4@syzkaller.appspotmail.com

+ext4 maintainers

> =====================================================
> BUG: KMSAN: uninit-value in ext4_inode_journal_mode+0x28b/0x4f0 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/ext4_jbd2.c:16
> CPU: 1 PID: 8577 Comm: syz-executor.0 Not tainted 5.10.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack syzkaller/managers/upstream-kmsan-gce-386/kernel/lib/dump_stack.c:77 [inline]
>  dump_stack+0x21c/0x280 syzkaller/managers/upstream-kmsan-gce-386/kernel/lib/dump_stack.c:118
>  kmsan_report+0xfb/0x1e0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan_report.c:118
>  __msan_warning+0x5f/0xa0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan_instr.c:197
>  ext4_inode_journal_mode+0x28b/0x4f0 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/ext4_jbd2.c:16
>  ext4_should_journal_data syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/ext4_jbd2.h:467 [inline]
>  ext4_evict_inode+0x1bb/0x2b30 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/inode.c:201
>  evict+0x4b5/0xec0 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/inode.c:578
>  iput_final syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/inode.c:1654 [inline]
>  iput+0xb06/0xec0 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/inode.c:1680
>  __ext4_new_inode+0x3dd2/0x9c70 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/ialloc.c:1354
>  ext4_create+0x47e/0x960 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/namei.c:2619
>  lookup_open syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:3104 [inline]
>  open_last_lookups syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:3178 [inline]
>  path_openat+0x2b71/0x6a30 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:3366
>  do_filp_open+0x2b8/0x710 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:3396
>  do_sys_openat2+0xa92/0x1150 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/open.c:1168
>  do_sys_open syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/open.c:1184 [inline]
>  __do_compat_sys_openat syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/open.c:1242 [inline]
>  __se_compat_sys_openat+0x2ae/0x310 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/open.c:1240
>  __ia32_compat_sys_openat+0x56/0x70 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/open.c:1240
>  do_syscall_32_irqs_on syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:80 [inline]
>  __do_fast_syscall_32+0x102/0x160 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:139
>  do_fast_syscall_32+0x6a/0xc0 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:162
>  do_SYSENTER_32+0x73/0x90 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:205
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> RIP: 0023:0xf7f79549
> Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f55525fc EFLAGS: 00000296 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000200004c0
> RDX: 0000000000000042 RSI: 0000000000000180 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>  kmsan_save_stack_with_flags+0x3c/0x90 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan.c:121
>  kmsan_alloc_page+0xd3/0x1f0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/kmsan/kmsan_shadow.c:274
>  __alloc_pages_nodemask+0x827/0xf90 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/page_alloc.c:4989
>  alloc_pages_current+0x7b6/0xb60 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/mempolicy.c:2271
>  alloc_pages syzkaller/managers/upstream-kmsan-gce-386/kernel/./include/linux/gfp.h:547 [inline]
>  alloc_slab_page syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:1630 [inline]
>  allocate_slab+0x346/0x11a0 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:1773
>  new_slab syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:1834 [inline]
>  new_slab_objects syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2593 [inline]
>  ___slab_alloc+0xd42/0x1930 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2756
>  __slab_alloc syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2796 [inline]
>  slab_alloc_node syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2871 [inline]
>  slab_alloc syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2915 [inline]
>  kmem_cache_alloc+0xb71/0x1040 syzkaller/managers/upstream-kmsan-gce-386/kernel/mm/slub.c:2920
>  ext4_alloc_inode+0x5e/0x870 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/super.c:1294
>  alloc_inode syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/inode.c:234 [inline]
>  new_inode_pseudo+0xa7/0x580 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/inode.c:930
>  new_inode+0x5a/0x3d0 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/inode.c:959
>  __ext4_new_inode+0x3a0/0x9c70 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/ialloc.c:956
>  ext4_symlink+0x8a4/0x19a0 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/ext4/namei.c:3336
>  vfs_symlink+0x6c4/0x8f0 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:3960
>  do_symlinkat+0x389/0x930 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:3987
>  __do_sys_symlink syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:4006 [inline]
>  __se_sys_symlink+0x74/0x90 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:4004
>  __ia32_sys_symlink+0x3e/0x60 syzkaller/managers/upstream-kmsan-gce-386/kernel/fs/namei.c:4004
>  do_syscall_32_irqs_on syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:80 [inline]
>  __do_fast_syscall_32+0x102/0x160 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:139
>  do_fast_syscall_32+0x6a/0xc0 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:162
>  do_SYSENTER_32+0x73/0x90 syzkaller/managers/upstream-kmsan-gce-386/kernel/arch/x86/entry/common.c:205
>  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> =====================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000038fcd705babe13b5%40google.com.
