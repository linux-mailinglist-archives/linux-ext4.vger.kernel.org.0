Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCBF60243F
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Oct 2022 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJRGVm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Oct 2022 02:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJRGVl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Oct 2022 02:21:41 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55468994F
        for <linux-ext4@vger.kernel.org>; Mon, 17 Oct 2022 23:21:39 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g15-20020a6be60f000000b006bc6bc8715aso9031465ioh.12
        for <linux-ext4@vger.kernel.org>; Mon, 17 Oct 2022 23:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faGjuzhogqBypdpV/KaOrYEs5IAU337bnqL3YA7SSvQ=;
        b=oJQRYfDS4yLPFq+VdP8X7livJCy6bL/Rc6E9g1wE7vDOVJb7P1aIum5JixmG3hv/9v
         wS8J2VRMzL+Aksvu4kswrsxXqEZrxP4PM+8vkL03mFf7L1F10pi0nLtG80FbFccO7Uxw
         ub0bFRdDrzzXhi+abdv28k0aMIMYFZZCaxFXcTwq9a7zuDo59Xa4P0MiKTzRLLAnSPO5
         vLEqC3gauLLn40YvR/eYrXF+i/jB1CFsmvCqIaAtOcYTnwNMkLjHN18VSm4k4fWq7RAm
         +ezE1eTmS3Nomt5QtL3d8hS14NYmBicTsdapkN/5FOsVyBzXmrXuT2bYui81p+7dog5p
         DC4Q==
X-Gm-Message-State: ACrzQf3x1BzWPBLhYyPaBx5pyILmQwCjxvsA4ErGp9WXZArkZXHBqG4B
        pjadCJ26Lm7iWO+W1zEksM90inNYEcIpiBWRE50sDN1Ehy1O
X-Google-Smtp-Source: AMsMyM574cPFodi2mBA6+TygElGK8uSfgU3+BDMYWr8mX4FnrDhqe9LVBq4Jwi1t2YgU/eyUYys1lnjFR8AeU+x4h94aib5Rfw+9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3cc9:b0:363:cbc6:1c5d with SMTP id
 bc9-20020a0566383cc900b00363cbc61c5dmr1247872jab.110.1666074099025; Mon, 17
 Oct 2022 23:21:39 -0700 (PDT)
Date:   Mon, 17 Oct 2022 23:21:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d791e805eb491ad3@google.com>
Subject: [syzbot] BUG: spinlock bad magic in ext4_xattr_set_handle
From:   syzbot <syzbot+39b09ced386069540413@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=179610d2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=39b09ced386069540413
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39b09ced386069540413@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 264192
EXT4-fs (loop5): mounted filesystem without journal. Quota mode: none.
BUG: spinlock bad magic on CPU#0, syz-executor.5/20801
 lock: 0xffff0001204eff50, .magic: ffff8000, .owner: access/1629495328, .owner_cpu: 0
CPU: 0 PID: 20801 Comm: syz-executor.5 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 spin_dump kernel/locking/spinlock_debug.c:69 [inline]
 spin_bug+0xa8/0xec kernel/locking/spinlock_debug.c:77
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0xb0/0x110 kernel/locking/spinlock_debug.c:114
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:120 [inline]
 _raw_spin_lock_irq+0x78/0x9c kernel/locking/spinlock.c:170
 rwsem_down_write_slowpath+0xdc/0x468 kernel/locking/rwsem.c:1128
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write+0x88/0xcc kernel/locking/rwsem.c:1553
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_xattr_set_handle+0xd0/0x994 fs/ext4/xattr.c:2309
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0x174/0x280 fs/xattr.c:313
 do_setxattr fs/xattr.c:600 [inline]
 setxattr fs/xattr.c:623 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:642
 __do_sys_lsetxattr fs/xattr.c:665 [inline]
 __se_sys_lsetxattr fs/xattr.c:661 [inline]
 __arm64_sys_lsetxattr+0x2c/0x40 fs/xattr.c:661
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Unable to handle kernel paging request at virtual address ffff80000d272a40
Mem abort info:
  ESR = 0x0000000096000047
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000047
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c566b000
[ffff80000d272a40] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=100000023fffa003, pte=0000000000000000
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 20801 Comm: syz-executor.5 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x198/0x380 kernel/locking/qspinlock.c:474
lr : queued_spin_lock_slowpath+0x114/0x380 kernel/locking/qspinlock.c:405
sp : ffff8000133bb760
x29: ffff8000133bb760 x28: ffff0001204efee0 x27: 0000000000000000
x26: ffff80000ce26a9f x25: ffff00011fca2000 x24: ffff0001fefd0a40
x23: 0000000000000000 x22: ffff80000d30cf28 x21: ffff80000d272a40
x20: 0000000000000000 x19: ffff0001204eff50 x18: 00000000000000c0
x17: 6e69676e45206574 x16: 0000000000000002 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000db4 x12: 0000000000000000
x11: ffff80000d272a40 x10: 0000000000040000 x9 : ffff0001fefd0a48
x8 : ffff0001fefd0a40 x7 : 545b5d3632333339 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000ce26a9f x0 : 0000000000000001
Call trace:
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 queued_spin_lock_slowpath+0x198/0x380 kernel/locking/qspinlock.c:471
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x10c/0x110 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:120 [inline]
 _raw_spin_lock_irq+0x78/0x9c kernel/locking/spinlock.c:170
 rwsem_down_write_slowpath+0xdc/0x468 kernel/locking/rwsem.c:1128
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write+0x88/0xcc kernel/locking/rwsem.c:1553
 ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 ext4_xattr_set_handle+0xd0/0x994 fs/ext4/xattr.c:2309
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0x174/0x280 fs/xattr.c:313
 do_setxattr fs/xattr.c:600 [inline]
 setxattr fs/xattr.c:623 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:642
 __do_sys_lsetxattr fs/xattr.c:665 [inline]
 __se_sys_lsetxattr fs/xattr.c:661 [inline]
 __arm64_sys_lsetxattr+0x2c/0x40 fs/xattr.c:661
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 8b2c4ecc f85f818c 1200056b 8b2b52ab (f82b6988) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b2c4ecc 	add	x12, x22, w12, uxtw #3
   4:	f85f818c 	ldur	x12, [x12, #-8]
   8:	1200056b 	and	w11, w11, #0x3
   c:	8b2b52ab 	add	x11, x21, w11, uxtw #4
* 10:	f82b6988 	str	x8, [x12, x11] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
