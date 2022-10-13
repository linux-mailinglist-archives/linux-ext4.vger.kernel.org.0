Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198825FD5E5
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Oct 2022 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJMIF6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Oct 2022 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJMIFy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Oct 2022 04:05:54 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB56146395
        for <linux-ext4@vger.kernel.org>; Thu, 13 Oct 2022 01:05:51 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso622863iob.20
        for <linux-ext4@vger.kernel.org>; Thu, 13 Oct 2022 01:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUnRaxqYqXkrwerVTp/d6txF1b+SFIRn9usC1sP0gUY=;
        b=lu4yC2bIBi/PrTXvJqxCRRdRzmx9ovhSZlRo9oD1EsEVVnWBVXGAKVdjgiIRm6RA58
         qTNDJ9kSh/HnYJNL5iQ0gP8Wa/yUk8rqWncY2oCCqzHYR3LAJ/OZJM7ZfSI0myG7weAA
         zszJ5xgINZLCAp5UPRoX3zZ2YE8G3K0FEPFu+Oqrbtdn69GJ9bM5W8gK2dr4ku7ugY+7
         v2ojrfm9dymH17Fs7BstYKT39AMjKMvzWuXrCIbBC/vq0EcMuhUMlv3gNibqn3ev7bKz
         1L5prUfS+PpAjuGaF8i8+l6cLBmbtAiRjzDYkYlqBp3e9R2W2NJCI26Tr7c+agE/SijG
         BBAQ==
X-Gm-Message-State: ACrzQf0CR/rfDmazrr/f90F0HZxq7Um3d2JXKdaw8O6y63WxM21OxURY
        jA62PVNpPDTv+hZ043x29eoGqi4dtjpvHMoVRUHzi27Q1g8m
X-Google-Smtp-Source: AMsMyM7S5Wxx2NdDC0TJUQONdXOwZSfkepQnHZCzbFebSVRfkOJy6nqoPIgG+dmmK89MDZmemf5850EIbjhasl5MGncY4qn3aJhQ
MIME-Version: 1.0
X-Received: by 2002:a02:aa8a:0:b0:363:b24c:d2c7 with SMTP id
 u10-20020a02aa8a000000b00363b24cd2c7mr11689456jai.126.1665648340991; Thu, 13
 Oct 2022 01:05:40 -0700 (PDT)
Date:   Thu, 13 Oct 2022 01:05:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af835305eae5f974@google.com>
Subject: [syzbot] WARNING: locking bug in ext4_es_lookup_extent
From:   syzbot <syzbot+c07a3726c89b814d58f1@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1527787c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=c07a3726c89b814d58f1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c07a3726c89b814d58f1@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 22100 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4727 [inline]
WARNING: CPU: 1 PID: 22100 at kernel/locking/lockdep.c:231 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
Modules linked in:
CPU: 1 PID: 22100 Comm: syz-executor.2 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff80001355b760
x29: ffff80001355b840 x28: 0000000000000001 x27: ffff00011ab9b528
x26: ffff00010f3a0d20 x25: ffff00011ab9bf58 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000001 x19: aaaaab5555430f42 x18: 0000000000000060
x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff00011ab9b500
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 12b67c41ea08a500
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 check_wait_context kernel/locking/lockdep.c:4727 [inline]
 __lock_acquire+0x2b0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x68/0x84 kernel/locking/spinlock.c:228
 ext4_es_lookup_extent+0x64/0x25c fs/ext4/extents_status.c:933
 ext4_map_blocks+0xb4/0xaec fs/ext4/inode.c:528
 ext4_protect_reserved_inode fs/ext4/block_validity.c:168 [inline]
 ext4_setup_system_zone+0x3bc/0x76c fs/ext4/block_validity.c:251
 __ext4_fill_super+0x2e74/0x36d4 fs/ext4/super.c:5274
 ext4_fill_super+0x100/0x2d8 fs/ext4/super.c:5517
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ext4_get_tree+0x28/0x38 fs/ext4/super.c:5547
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 953
hardirqs last  enabled at (953): [<ffff80000bfc89b4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (953): [<ffff80000bfc89b4>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (952): [<ffff80000bfc87f0>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (952): [<ffff80000bfc87f0>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (858): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (845): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000160bbe000
[00000000000000b8] pgd=080000015cbc6003, p4d=080000015cbc6003, pud=0800000165248003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 22100 Comm: syz-executor.2 Tainted: G        W          6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4727 [inline]
pc : __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4727 [inline]
lr : __lock_acquire+0x298/0x30a4 kernel/locking/lockdep.c:5003
sp : ffff80001355b760
x29: ffff80001355b840 x28: 0000000000000001 x27: ffff00011ab9b528
x26: ffff00010f3a0d20 x25: ffff00011ab9bf58 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000001 x19: aaaaab5555430f42 x18: 0000000000000060
x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff00011ab9b500
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c0d5c x10: ffff80000dd0b198 x9 : 0000000000050f42
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4728 [inline]
 __lock_acquire+0x2d0/0x30a4 kernel/locking/lockdep.c:5003
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x68/0x84 kernel/locking/spinlock.c:228
 ext4_es_lookup_extent+0x64/0x25c fs/ext4/extents_status.c:933
 ext4_map_blocks+0xb4/0xaec fs/ext4/inode.c:528
 ext4_protect_reserved_inode fs/ext4/block_validity.c:168 [inline]
 ext4_setup_system_zone+0x3bc/0x76c fs/ext4/block_validity.c:251
 __ext4_fill_super+0x2e74/0x36d4 fs/ext4/super.c:5274
 ext4_fill_super+0x100/0x2d8 fs/ext4/super.c:5517
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ext4_get_tree+0x28/0x38 fs/ext4/super.c:5547
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: b002db8a 91056210 9106614a b9400329 (3942e114) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	b002db8a 	adrp	x10, 0x5b71000
   4:	91056210 	add	x16, x16, #0x158
   8:	9106614a 	add	x10, x10, #0x198
   c:	b9400329 	ldr	w9, [x25]
* 10:	3942e114 	ldrb	w20, [x8, #184] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
