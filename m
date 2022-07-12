Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E46571962
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiGLMDe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiGLMDa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 08:03:30 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B4F32449
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 05:03:25 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so4637526ila.5
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 05:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=N9XPujyBZ2/ryQlBBQQ03hv6z0OqO8Mjqr5LPCgVqfE=;
        b=K48Std3PaxL4eLauVG1o5E8CMWyDzZTw9IWyVC9F12/uQt8hSuyjy3GK/G4NCavBwE
         SsjGpHQ7QZTltWQVfvnAxNzw5kPw+A3Bu7nSXLaYGI8pnjmlNlWpI5Lc5tRKmF3qm7AB
         hB/7OxFHCqjJFARR0gkwwrvSuOAipKl9mL+5k+P3fv8dbQ1PuLglDDt+q/qD4cp4+se1
         eixWgxUSlVwbYbilwhFc8ZZz2D6rfRZqzm3lVeWcGu0DB4wAIIXx+Gk37auIK3BRVicN
         Gv2OHqYQUBl2y0n1Tp2cVME+CXZaoGe8kitArCpKc5ELO5jootjyzUkR5kVNjBq06EEJ
         XW5Q==
X-Gm-Message-State: AJIora+h0DVCtZjLGMQpRUsyiB4UuZfDed5LQC/5HyszlDfblbJI6XWw
        Zb6W/1K5rUdN1OMRuiiBAvfEobRm8PAaIckmkwdeLvGKa/TY
X-Google-Smtp-Source: AGRyM1snq3fN4US+l1ihx+F5435GZK7vF7S9s0oz+N53IhMNIozcmbYzlTQUwtJ7R38MQhcqXknYCwkln9KKCaCIqO126diIgmJ4
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c8:b0:672:4e60:7294 with SMTP id
 g8-20020a05660203c800b006724e607294mr11591865iov.17.1657627405260; Tue, 12
 Jul 2022 05:03:25 -0700 (PDT)
Date:   Tue, 12 Jul 2022 05:03:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a91fff05e39a74b0@google.com>
Subject: [syzbot] possible deadlock in ext4_xattr_set_handle (2)
From:   syzbot <syzbot+689207c321874efe3382@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    32346491ddf2 Linux 5.19-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123106e8080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=525bc0635a2b942a
dashboard link: https://syzkaller.appspot.com/bug?extid=689207c321874efe3382
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+689207c321874efe3382@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.19.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/19826 is trying to acquire lock:
ffffffff8bebda20 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages+0x15c/0x570 mm/page_alloc.c:5200

but task is already holding lock:
ffff888025ba94d8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
ffff888025ba94d8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x15c/0x1500 fs/ext4/xattr.c:2293

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x90/0x150 kernel/locking/rwsem.c:1542
       ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
       ext4_xattr_set_handle+0x15c/0x1500 fs/ext4/xattr.c:2293
       __ext4_set_acl+0x338/0x570 fs/ext4/acl.c:217
       ext4_set_acl+0x443/0x580 fs/ext4/acl.c:258
       set_posix_acl+0x22d/0x2e0 fs/posix_acl.c:946
       posix_acl_xattr_set+0x135/0x1a0 fs/posix_acl.c:965
       __vfs_removexattr+0xfe/0x170 fs/xattr.c:470
       __vfs_removexattr_locked+0x1ac/0x440 fs/xattr.c:505
       vfs_removexattr+0xcb/0x250 fs/xattr.c:527
       ovl_do_removexattr fs/overlayfs/overlayfs.h:279 [inline]
       ovl_workdir_create+0x484/0xbd0 fs/overlayfs/super.c:813
       ovl_make_workdir fs/overlayfs/super.c:1367 [inline]
       ovl_get_workdir fs/overlayfs/super.c:1514 [inline]
       ovl_fill_super+0x1950/0x6380 fs/overlayfs/super.c:2070
       mount_nodev+0x60/0x110 fs/super.c:1413
       legacy_get_tree+0x105/0x220 fs/fs_context.c:610
       vfs_get_tree+0x89/0x2f0 fs/super.c:1497
       do_new_mount fs/namespace.c:3040 [inline]
       path_mount+0x1320/0x1fa0 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __ia32_sys_mount+0x27e/0x300 fs/namespace.c:3568
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x53/0x62

-> #1 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfe7/0x14a0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x3a8/0x4a0 fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5949
       __mark_inode_dirty+0x495/0x1050 fs/fs-writeback.c:2381
       mark_inode_dirty_sync include/linux/fs.h:2337 [inline]
       iput.part.0+0x57/0x820 fs/inode.c:1767
       iput+0x58/0x70 fs/inode.c:1760
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       shrink_dentry_list+0x23c/0x800 fs/dcache.c:1201
       prune_dcache_sb+0xe7/0x140 fs/dcache.c:1282
       super_cache_scan+0x336/0x590 fs/super.c:104
       do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:770
       shrink_slab_memcg mm/vmscan.c:839 [inline]
       shrink_slab+0x3ee/0x6f0 mm/vmscan.c:918
       shrink_node_memcgs mm/vmscan.c:3124 [inline]
       shrink_node+0x8b3/0x1db0 mm/vmscan.c:3245
       shrink_zones mm/vmscan.c:3482 [inline]
       do_try_to_free_pages+0x3b5/0x1700 mm/vmscan.c:3540
       try_to_free_pages+0x2ac/0x840 mm/vmscan.c:3775
       __perform_reclaim mm/page_alloc.c:4641 [inline]
       __alloc_pages_direct_reclaim mm/page_alloc.c:4663 [inline]
       __alloc_pages_slowpath.constprop.0+0xa8a/0x2160 mm/page_alloc.c:5066
       __alloc_pages+0x436/0x510 mm/page_alloc.c:5439
       alloc_pages+0x1aa/0x310 mm/mempolicy.c:2272
       folio_alloc+0x1c/0x70 mm/mempolicy.c:2282
       filemap_alloc_folio mm/filemap.c:996 [inline]
       __filemap_get_folio+0x614/0xf00 mm/filemap.c:1992
       filemap_fault+0x1670/0x24e0 mm/filemap.c:3158
       __do_fault+0x10d/0x650 mm/memory.c:4165
       do_read_fault mm/memory.c:4511 [inline]
       do_fault mm/memory.c:4640 [inline]
       handle_pte_fault mm/memory.c:4903 [inline]
       __handle_mm_fault+0x2739/0x3f50 mm/memory.c:5042
       handle_mm_fault+0x1c8/0x790 mm/memory.c:5140
       do_user_addr_fault+0x489/0x11c0 arch/x86/mm/fault.c:1397
       handle_page_fault arch/x86/mm/fault.c:1484 [inline]
       exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1540
       asm_exc_page_fault+0x27/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5665 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
       __fs_reclaim_acquire mm/page_alloc.c:4589 [inline]
       fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4603
       prepare_alloc_pages+0x15c/0x570 mm/page_alloc.c:5200
       __alloc_pages+0x145/0x510 mm/page_alloc.c:5415
       __alloc_pages_node include/linux/gfp.h:587 [inline]
       alloc_pages_node include/linux/gfp.h:610 [inline]
       kmalloc_large_node+0x62/0x130 mm/slub.c:4460
       __kmalloc_node+0x2ec/0x390 mm/slub.c:4476
       kmalloc_node include/linux/slab.h:623 [inline]
       kvmalloc_node+0xa4/0x190 mm/util.c:613
       kvmalloc include/linux/slab.h:750 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1472 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1515 [inline]
       ext4_xattr_set_entry+0x1d94/0x3850 fs/ext4/xattr.c:1656
       ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2209
       ext4_xattr_set_handle+0x964/0x1500 fs/ext4/xattr.c:2366
       ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2479
       __vfs_setxattr+0x115/0x180 fs/xattr.c:182
       __vfs_setxattr_noperm+0x125/0x5f0 fs/xattr.c:216
       __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:277
       vfs_setxattr+0x13f/0x330 fs/xattr.c:303
       setxattr+0x146/0x160 fs/xattr.c:611
       path_setxattr+0x197/0x1c0 fs/xattr.c:630
       __do_sys_setxattr fs/xattr.c:646 [inline]
       __se_sys_setxattr fs/xattr.c:642 [inline]
       __ia32_sys_setxattr+0xbc/0x150 fs/xattr.c:642
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x53/0x62

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> jbd2_handle --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(jbd2_handle);
                               lock(&ei->xattr_sem);
  lock(fs_reclaim);

 *** DEADLOCK ***

3 locks held by syz-executor.3/19826:
 #0: ffff888014a30460 (sb_writers#4){.+.+}-{0:0}, at: path_setxattr+0xb2/0x1c0 fs/xattr.c:628
 #1: ffff888025ba9810 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:741 [inline]
 #1: ffff888025ba9810 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0x11c/0x330 fs/xattr.c:302
 #2: ffff888025ba94d8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:142 [inline]
 #2: ffff888025ba94d8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x15c/0x1500 fs/ext4/xattr.c:2293

stack backtrace:
CPU: 0 PID: 19826 Comm: syz-executor.3 Not tainted 5.19.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5665 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
 __fs_reclaim_acquire mm/page_alloc.c:4589 [inline]
 fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4603
 prepare_alloc_pages+0x15c/0x570 mm/page_alloc.c:5200
 __alloc_pages+0x145/0x510 mm/page_alloc.c:5415
 __alloc_pages_node include/linux/gfp.h:587 [inline]
 alloc_pages_node include/linux/gfp.h:610 [inline]
 kmalloc_large_node+0x62/0x130 mm/slub.c:4460
 __kmalloc_node+0x2ec/0x390 mm/slub.c:4476
 kmalloc_node include/linux/slab.h:623 [inline]
 kvmalloc_node+0xa4/0x190 mm/util.c:613
 kvmalloc include/linux/slab.h:750 [inline]
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1472 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1515 [inline]
 ext4_xattr_set_entry+0x1d94/0x3850 fs/ext4/xattr.c:1656
 ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2209
 ext4_xattr_set_handle+0x964/0x1500 fs/ext4/xattr.c:2366
 ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2479
 __vfs_setxattr+0x115/0x180 fs/xattr.c:182
 __vfs_setxattr_noperm+0x125/0x5f0 fs/xattr.c:216
 __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:277
 vfs_setxattr+0x13f/0x330 fs/xattr.c:303
 setxattr+0x146/0x160 fs/xattr.c:611
 path_setxattr+0x197/0x1c0 fs/xattr.c:630
 __do_sys_setxattr fs/xattr.c:646 [inline]
 __se_sys_setxattr fs/xattr.c:642 [inline]
 __ia32_sys_setxattr+0xbc/0x150 fs/xattr.c:642
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x53/0x62
RIP: 0023:0xf7f22549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7efc5cc EFLAGS: 00000296 ORIG_RAX: 00000000000000e2
RAX: ffffffffffffffda RBX: 0000000020000080 RCX: 0000000020000040
RDX: 0000000020000540 RSI: 000000000000c001 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
