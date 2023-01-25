Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE95F67A7B5
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jan 2023 01:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjAYA2t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 19:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjAYA2o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 19:28:44 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A832E5087E
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 16:28:12 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id n2-20020a6b7202000000b0070768a0a88bso9754934ioc.12
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 16:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHz9nUalEZpL+NYGlZGsQfum4vHxjPouJjL9/+2yvJQ=;
        b=SZ4hEQkkYrJ1qRD8WmqI0CvK0SyzoT9sjpxJsgE3rsDuv2Jw8CaK5J5TMbyyepEabX
         RmauqlNSvy9g63pvsVUllk/4i6LAqNF5nKFJ7L6J85pc3rIvdqG/ny3t+HeEz1EyXZjt
         vfcWQo/jNIH6OInBnoAVOzssJcsyljp+GSEa5ZOvq/SfYyD8ULUdqeR0q0ksWO59gd8d
         1kwC7NExDdlYeV8ej4S1zN2OMfUsQdK7RQnjSPeTB/MFSHTx5tqHmAOlpPeaz2/voTno
         BIBmuRhE+gIaBTH2BKpBaThKOa/XdGUPDbdRnV6AKODUNeMjkvI93PoJPK3omHKMDUD8
         jVpA==
X-Gm-Message-State: AFqh2kpsGfFLDr12UtX2DL+CkH1SUuomniDAMC5JGPHZotAmY53ZDF++
        P905lYrk7Ret6czWpyeMyJa4O/JzHujgavfvVo9msQCNFo0d
X-Google-Smtp-Source: AMrXdXspl2RwG0xe0vbGsOk4B3nhvQHCg5/uehBUvE66cNYOOcS7ltg534+IEfflwDF4glDRj6lU0zIsMGCbTnIwUNuFxj+YzuE1
MIME-Version: 1.0
X-Received: by 2002:a5d:94c7:0:b0:6de:383e:4146 with SMTP id
 y7-20020a5d94c7000000b006de383e4146mr1832543ior.48.1674606456228; Tue, 24 Jan
 2023 16:27:36 -0800 (PST)
Date:   Tue, 24 Jan 2023 16:27:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6540d05f30bb23f@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (3)
From:   syzbot <syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com>
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

HEAD commit:    edc00350d205 Merge tag 'block-6.2-2023-01-20' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134b1441480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=899d86a7610a0ea0
dashboard link: https://syzkaller.appspot.com/bug?extid=edce54daffee36421b4c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com

ext4 filesystem being mounted at /syzkaller-testdir3627507797/syzkaller.9jT2hR/316/file0 supports timestamps until 2038 (0x7fffffff)
======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc4-syzkaller-00350-gedc00350d205 #0 Not tainted
------------------------------------------------------
syz-executor.2/573 is trying to acquire lock:
ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:271 [inline]
ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:720 [inline]
ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3434 [inline]
ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: __kmem_cache_alloc_node+0x41/0x430 mm/slub.c:3491

but task is already holding lock:
ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x160/0x1510 fs/ext4/xattr.c:2305

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x94/0x220 kernel/locking/rwsem.c:1562
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0x160/0x1510 fs/ext4/xattr.c:2305
       __ext4_set_acl+0x35c/0x5a0 fs/ext4/acl.c:217
       ext4_set_acl+0x484/0x5f0 fs/ext4/acl.c:259
       set_posix_acl+0x25b/0x320 fs/posix_acl.c:957
       vfs_remove_acl+0x276/0x640 fs/posix_acl.c:1209
       ovl_do_remove_acl fs/overlayfs/overlayfs.h:292 [inline]
       ovl_workdir_create+0x462/0x800 fs/overlayfs/super.c:821
       ovl_make_workdir fs/overlayfs/super.c:1294 [inline]
       ovl_get_workdir fs/overlayfs/super.c:1444 [inline]
       ovl_fill_super+0x1a02/0x6330 fs/overlayfs/super.c:2000
       mount_nodev+0x64/0x120 fs/super.c:1405
       legacy_get_tree+0x109/0x220 fs/fs_context.c:610
       vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
       do_new_mount fs/namespace.c:3145 [inline]
       path_mount+0x132a/0x1e20 fs/namespace.c:3475
       do_mount fs/namespace.c:3488 [inline]
       __do_sys_mount fs/namespace.c:3697 [inline]
       __se_sys_mount fs/namespace.c:3674 [inline]
       __ia32_sys_mount+0x282/0x300 fs/namespace.c:3674
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

-> #1 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xfe7/0x14a0 fs/jbd2/transaction.c:463
       jbd2__journal_start+0x39d/0x9b0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x6e9/0x860 fs/ext4/ext4_jbd2.c:111
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0xa5/0x130 fs/ext4/inode.c:6107
       __mark_inode_dirty+0x247/0x11e0 fs/fs-writeback.c:2419
       mark_inode_dirty_sync include/linux/fs.h:2470 [inline]
       iput.part.0+0x57/0x880 fs/inode.c:1770
       iput+0x5c/0x80 fs/inode.c:1763
       dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
       __dentry_kill+0x3c0/0x640 fs/dcache.c:607
       shrink_dentry_list+0x240/0x800 fs/dcache.c:1201
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1282
       super_cache_scan+0x33a/0x590 fs/super.c:104
       do_shrink_slab+0x464/0xce0 mm/vmscan.c:843
       shrink_slab+0x175/0x660 mm/vmscan.c:1003
       shrink_node_memcgs mm/vmscan.c:6140 [inline]
       shrink_node+0x95d/0x1f40 mm/vmscan.c:6169
       kswapd_shrink_node mm/vmscan.c:6960 [inline]
       balance_pgdat+0x8f5/0x1530 mm/vmscan.c:7150
       kswapd+0x70b/0xfc0 mm/vmscan.c:7410
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4688
       might_alloc include/linux/sched/mm.h:271 [inline]
       slab_pre_alloc_hook mm/slab.h:720 [inline]
       slab_alloc_node mm/slub.c:3434 [inline]
       __kmem_cache_alloc_node+0x41/0x430 mm/slub.c:3491
       __do_kmalloc_node mm/slab_common.c:967 [inline]
       __kmalloc_node+0x4d/0xd0 mm/slab_common.c:975
       kmalloc_node include/linux/slab.h:610 [inline]
       kvmalloc_node+0x76/0x1a0 mm/util.c:581
       kvmalloc include/linux/slab.h:737 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1484 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1527 [inline]
       ext4_xattr_set_entry+0x1d92/0x3a00 fs/ext4/xattr.c:1669
       ext4_xattr_block_set+0x61b/0x3000 fs/ext4/xattr.c:1906
       ext4_xattr_set_handle+0xd8a/0x1510 fs/ext4/xattr.c:2390
       ext4_xattr_set+0x144/0x360 fs/ext4/xattr.c:2492
       __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
       __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
       __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
       vfs_setxattr+0x143/0x340 fs/xattr.c:323
       do_setxattr+0x151/0x190 fs/xattr.c:608
       setxattr+0x146/0x160 fs/xattr.c:631
       path_setxattr+0x197/0x1c0 fs/xattr.c:650
       __do_sys_setxattr fs/xattr.c:666 [inline]
       __se_sys_setxattr fs/xattr.c:662 [inline]
       __ia32_sys_setxattr+0xc0/0x160 fs/xattr.c:662
       do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
       __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
       do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
       entry_SYSENTER_compat_after_hwframe+0x70/0x82

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

3 locks held by syz-executor.2/573:
 #0: ffff8880650a0460 (sb_writers#4){.+.+}-{0:0}, at: path_setxattr+0xb2/0x1c0 fs/xattr.c:648
 #1: ffff8880277eb628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff8880277eb628 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_setxattr+0x120/0x340 fs/xattr.c:322
 #2: ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x160/0x1510 fs/ext4/xattr.c:2305

stack backtrace:
CPU: 2 PID: 573 Comm: syz-executor.2 Not tainted 6.2.0-rc4-syzkaller-00350-gedc00350d205 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]
 fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4688
 might_alloc include/linux/sched/mm.h:271 [inline]
 slab_pre_alloc_hook mm/slab.h:720 [inline]
 slab_alloc_node mm/slub.c:3434 [inline]
 __kmem_cache_alloc_node+0x41/0x430 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc_node+0x4d/0xd0 mm/slab_common.c:975
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x76/0x1a0 mm/util.c:581
 kvmalloc include/linux/slab.h:737 [inline]
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1484 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1527 [inline]
 ext4_xattr_set_entry+0x1d92/0x3a00 fs/ext4/xattr.c:1669
 ext4_xattr_block_set+0x61b/0x3000 fs/ext4/xattr.c:1906
 ext4_xattr_set_handle+0xd8a/0x1510 fs/ext4/xattr.c:2390
 ext4_xattr_set+0x144/0x360 fs/ext4/xattr.c:2492
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
 __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
 __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
 vfs_setxattr+0x143/0x340 fs/xattr.c:323
 do_setxattr+0x151/0x190 fs/xattr.c:608
 setxattr+0x146/0x160 fs/xattr.c:631
 path_setxattr+0x197/0x1c0 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __ia32_sys_setxattr+0xc0/0x160 fs/xattr.c:662
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f96549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f915cc EFLAGS: 00000296 ORIG_RAX: 00000000000000e2
RAX: ffffffffffffffda RBX: 00000000200000c0 RCX: 0000000020000180
RDX: 00000000200005c0 RSI: 0000000000002000 RDI: 0000000000000000
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
