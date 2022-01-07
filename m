Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6D4879CD
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiAGPkX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 10:40:23 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41610 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiAGPkX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 10:40:23 -0500
Received: by mail-il1-f200.google.com with SMTP id h23-20020a056e021d9700b002b49f2b9bccso3978522ila.8
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jan 2022 07:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dvC8bxPjiwLGXSkNcF3Q93xX7JWFUNuMn44uek3aYtA=;
        b=oe4QkMrRIBXdWAEqSN//lG+O4ita5g3ZmJ/VazxwZvWj9p0zZY81/UuWOLL/XwBr5w
         085LtE4U7BaMr6c9KAwd5LHt2ECXXDAaBmz20v/BM+qtRjDK5Uikq4EEoSWLVghMi508
         9uKtdGGib4GXkjNqM3AXHdIn7CUqNA/rvmbPmBYCbRgoUTn5teRsW8DspUI1de+pkjhA
         mfRnkW6wJSMn0YeoWHRMApkhNThwIw7qzkNh6ZCv/XnU5hGmSKArZ4gKVviBwO44qfob
         oA7zZJGfDNH2Lmirnz2bv6lhpJ1KYl64SLbCw9zpmsSMJWCjvjX04JYp6969spmMTiyZ
         qcRA==
X-Gm-Message-State: AOAM530HhY+mPvCv8H7KY+QRn7PchpaetMoVUrRqoqA48LuoS2domx27
        z9UeiFhTFJVspzVVeyc4ddftUHtJp9TMi7FqZ7Hs3097jFIl
X-Google-Smtp-Source: ABdhPJyquJ3rLlkIovZ8hSfmH5P1AHmL9UwceMYom0IfHxoqJ35nICd0eUN+EtC2+Xby1IUIr2Aiuq5leXycezl5PZrxMZdnVaQO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:140e:: with SMTP id k14mr30556024jad.119.1641570022402;
 Fri, 07 Jan 2022 07:40:22 -0800 (PST)
Date:   Fri, 07 Jan 2022 07:40:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f2f3605d4ffce9e@google.com>
Subject: [syzbot] KMSAN: uninit-value in ext4_inode_journal_mode (2)
From:   syzbot <syzbot+11542230634289d7f1f6@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, glider@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11473f2db00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=11542230634289d7f1f6
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11542230634289d7f1f6@syzkaller.appspotmail.com

syz-executor.0 (pid 3634) is setting deprecated v1 encryption policy; recommend upgrading to v2.
=====================================================
BUG: KMSAN: uninit-value in ext4_inode_journal_mode+0x29f/0x510 fs/ext4/ext4_jbd2.c:16
 ext4_inode_journal_mode+0x29f/0x510 fs/ext4/ext4_jbd2.c:16
 ext4_should_journal_data fs/ext4/ext4_jbd2.h:465 [inline]
 ext4_evict_inode+0x1b5/0x2d10 fs/ext4/inode.c:202
 evict+0x4f4/0xdd0 fs/inode.c:590
 iput_final fs/inode.c:1670 [inline]
 iput+0xc53/0x1100 fs/inode.c:1696
 __ext4_new_inode+0xf32/0x8440 fs/ext4/ialloc.c:1362
 ext4_create+0x455/0x940 fs/ext4/namei.c:2746
 lookup_open fs/namei.c:3280 [inline]
 open_last_lookups fs/namei.c:3350 [inline]
 path_openat+0x2e88/0x5ea0 fs/namei.c:3556
 do_filp_open+0x306/0x760 fs/namei.c:3586
 do_sys_openat2+0x263/0x8f0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_creat fs/open.c:1304 [inline]
 __se_sys_creat fs/open.c:1298 [inline]
 __ia32_sys_creat+0x122/0x1a0 fs/open.c:1298
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0xbbf/0x1090 mm/page_alloc.c:5409
 alloc_pages+0x8a5/0xb80
 alloc_slab_page mm/slub.c:1810 [inline]
 allocate_slab+0x287/0x1c10 mm/slub.c:1947
 new_slab mm/slub.c:2010 [inline]
 ___slab_alloc+0xb85/0x1e30 mm/slub.c:3039
 __slab_alloc mm/slub.c:3126 [inline]
 slab_alloc_node mm/slub.c:3217 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 kmem_cache_alloc+0xbb3/0x11c0 mm/slub.c:3264
 ext4_alloc_inode+0x5e/0x870 fs/ext4/super.c:1295
 alloc_inode fs/inode.c:235 [inline]
 new_inode_pseudo+0xa6/0x5a0 fs/inode.c:944
 new_inode+0x5a/0x3c0 fs/inode.c:973
 __ext4_new_inode+0x3cb/0x8440 fs/ext4/ialloc.c:960
 ext4_mkdir+0x623/0x1870 fs/ext4/namei.c:2929
 vfs_mkdir+0x8ca/0xba0 fs/namei.c:3883
 do_mkdirat+0x3f5/0x8e0 fs/namei.c:3909
 __do_sys_mkdirat fs/namei.c:3924 [inline]
 __se_sys_mkdirat fs/namei.c:3922 [inline]
 __x64_sys_mkdirat+0x11a/0x160 fs/namei.c:3922
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

CPU: 0 PID: 3634 Comm: syz-executor.0 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
