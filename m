Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC0665CD7
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 14:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbjAKNmq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 08:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbjAKNlt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 08:41:49 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539222BF7
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 05:40:47 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so10869098ilb.11
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 05:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzQQ6j3xd3RX0pgot03pOrH3KmyxUXX716sVZ1t6cMc=;
        b=j73xaaom0PUaqg2UZyw5DljQjstaN/Xmwdy99Wc1wU2IKVXxoMFGRCn1FjfQzS1PuZ
         PPSGfAsjtkO8E0IcyR2rdqkC9AcANAAFAMB5P1zS8+Pb151lg9EbHIKSkcWIuZT/WtDL
         9/Lv2bH3cm7Ne5x25NvB7QK+BN99O2PF/knh/PXKJwnBgrozzLDe5mg4m5wjGArDshlC
         pBWwQJLbmwUsqR4ZNuyLKVGoCvCRMJuxzhxzyw6PRe0KHT9lCtvfZvLFo/Cz4THALgoL
         OpUAcPxlTmQsfL55neaSH3KdAbgEletXjjksXfRnoJwTaqLHrW0Shw/vFWSynzM7E1gP
         1AIQ==
X-Gm-Message-State: AFqh2kqgChFgRlLnNbMhbJdrIxrm30xJp6i8CvvdWPw6uIKPFQCmbWpW
        RIC3TeyA5g8hUiNrJMIsoTVM+ZczqmiCXI31fd/PKHZsfO7G
X-Google-Smtp-Source: AMrXdXuPcd9EVTFjKAVpY02ePCK2IRtZSMSgxaG3bkDqpSdqRHzhCKiJWFfOaFnv9AS0keKiIky7wbZu0qEFAkgqSRnl2cZ42Str
MIME-Version: 1.0
X-Received: by 2002:a5d:9f56:0:b0:6de:383e:4146 with SMTP id
 u22-20020a5d9f56000000b006de383e4146mr4746984iot.48.1673444446687; Wed, 11
 Jan 2023 05:40:46 -0800 (PST)
Date:   Wed, 11 Jan 2023 05:40:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbd8aa05f1fd2516@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode
From:   syzbot <syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com>
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

HEAD commit:    a689b938df39 Merge tag 'block-2023-01-06' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ad94ec480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33ad6720950f996d
dashboard link: https://syzkaller.appspot.com/bug?extid=38e6635a03c83c76297a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114dd83a480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fcfa927aa80/disk-a689b938.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e92e2a5e7778/vmlinux-a689b938.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e792fc2d1a8/bzImage-a689b938.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b75cc56d037b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com

INFO: task syz-executor.4:9169 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00256-ga689b938df39 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:23608 pid:9169  ppid:5142   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 mb_cache_entry_wait_unused+0x165/0x240 fs/mbcache.c:148
 ext4_evict_ea_inode+0x148/0x300 fs/ext4/xattr.c:449
 ext4_evict_inode+0x112/0x10b0 fs/ext4/inode.c:181
 evict+0x2a4/0x620 fs/inode.c:664
 ext4_xattr_set_entry+0x1c00/0x3a70 fs/ext4/xattr.c:1806
 ext4_xattr_block_set+0xf78/0x3760 fs/ext4/xattr.c:1906
 ext4_xattr_set_handle+0xe1c/0x1680 fs/ext4/xattr.c:2390
 ext4_xattr_set+0x245/0x3d0 fs/ext4/xattr.c:2492
 __vfs_setxattr+0x485/0x4c0 fs/xattr.c:202
 __vfs_setxattr_noperm+0x128/0x5d0 fs/xattr.c:236
 vfs_setxattr+0x228/0x450 fs/xattr.c:323
 do_setxattr fs/xattr.c:608 [inline]
 setxattr fs/xattr.c:631 [inline]
 path_setxattr+0x393/0x4c0 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __x64_sys_setxattr+0xb7/0xd0 fs/xattr.c:662
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff4bcc8c0c9
RSP: 002b:00007ff4bbffe168 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007ff4bcdabf80 RCX: 00007ff4bcc8c0c9
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 00000000200001c0
RBP: 00007ff4bcce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffd743acaf R14: 00007ff4bbffe300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:9184 blocked for more than 144 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00256-ga689b938df39 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:25192 pid:9184  ppid:5142   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 __wait_on_freeing_inode fs/inode.c:2196 [inline]
 find_inode_fast+0x332/0x480 fs/inode.c:950
 iget_locked+0xb1/0x830 fs/inode.c:1273
 __ext4_iget+0x242/0x3f40 fs/ext4/inode.c:4861
 ext4_xattr_inode_cache_find fs/ext4/xattr.c:1491 [inline]
 ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1527 [inline]
 ext4_xattr_set_entry+0x2181/0x3a70 fs/ext4/xattr.c:1669
 ext4_xattr_block_set+0x8c3/0x3760 fs/ext4/xattr.c:1975
 ext4_xattr_set_handle+0xe1c/0x1680 fs/ext4/xattr.c:2390
 ext4_xattr_set+0x245/0x3d0 fs/ext4/xattr.c:2492
 __vfs_setxattr+0x485/0x4c0 fs/xattr.c:202
 __vfs_setxattr_noperm+0x128/0x5d0 fs/xattr.c:236
 vfs_setxattr+0x228/0x450 fs/xattr.c:323
 do_setxattr fs/xattr.c:608 [inline]
 setxattr fs/xattr.c:631 [inline]
 path_setxattr+0x393/0x4c0 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __x64_sys_setxattr+0xb7/0xd0 fs/xattr.c:662
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff4bcc8c0c9
RSP: 002b:00007ff4b3c1d168 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007ff4bcdac050 RCX: 00007ff4bcc8c0c9
RDX: 00000000200005c0 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00007ff4bcce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffd743acaf R14: 00007ff4b3c1d300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d5239d0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d5241d0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d523800 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4735:
 #0: ffff88814a264098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6e8/0x1e50 drivers/tty/n_tty.c:2177
2 locks held by kworker/1:0/5135:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
 #1: ffffc90003f9fd00 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
2 locks held by kworker/0:3/5163:
 #0: ffff888012872538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
 #1: ffffc9000400fd00 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
3 locks held by kworker/0:5/5200:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
 #1: ffffc90003e9fd00 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
 #2: ffffffff8d528e38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:292 [inline]
 #2: ffffffff8d528e38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3a6/0x890 kernel/rcu/tree_exp.h:946
3 locks held by kworker/1:5/5203:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
 #1: ffffc9000462fd00 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
 #2: ffffffff8d528e38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #2: ffffffff8d528e38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x46f/0x890 kernel/rcu/tree_exp.h:946
2 locks held by kworker/1:7/5219:
 #0: ffff888012870d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x796/0xd10 kernel/workqueue.c:2262
 #1: ffffc9000469fd00 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x7d0/0xd10 kernel/workqueue.c:2264
3 locks held by syz-executor.4/9169:
 #0: ffff888020370460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff8880751f2218 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff8880751f2218 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0x1e8/0x450 fs/xattr.c:322
 #2: ffff8880751f1ee0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff8880751f1ee0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x26b/0x1680 fs/ext4/xattr.c:2305
3 locks held by syz-executor.4/9184:
 #0: ffff888020370460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff8880751f7258 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff8880751f7258 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: vfs_setxattr+0x1e8/0x450 fs/xattr.c:322
 #2: ffff8880751f6f20 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff8880751f6f20 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x26b/0x1680 fs/ext4/xattr.c:2305
3 locks held by syz-executor.3/9889:
 #0: ffff88807c130460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff888069874030 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888069874030 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: vfs_setxattr+0x1e8/0x450 fs/xattr.c:322
 #2: ffff888069873cf8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff888069873cf8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x26b/0x1680 fs/ext4/xattr.c:2305
3 locks held by syz-executor.3/9903:
 #0: ffff88807c130460 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff888069816850 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888069816850 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: vfs_setxattr+0x1e8/0x450 fs/xattr.c:322
 #2: ffff888069816518 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
 #2: ffff888069816518 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x26b/0x1680 fs/ext4/xattr.c:2305
2 locks held by udevd/9968:
2 locks held by udevd/9970:
1 lock held by udevd/10223:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc2-syzkaller-00256-ga689b938df39 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x4e3/0x560 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x19b/0x3e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 9969 Comm: udevd Not tainted 6.2.0-rc2-syzkaller-00256-ga689b938df39 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:kasan_check_range+0x3/0x2e0 mm/kasan/generic.c:188
Code: 89 c7 e8 80 32 e2 08 31 c0 c3 0f 0b b8 ea ff ff ff c3 0f 0b b8 ea ff ff ff c3 cc cc cc cc cc cc cc cc cc cc cc cc cc 55 41 57 <41> 56 53 b0 01 48 85 f6 0f 84 ed 01 00 00 48 89 fd 48 01 f5 0f 82
RSP: 0018:ffffc90003b9f990 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 000000000000002c RCX: ffffffff816c9c80
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff90970180
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: fffffbfff1d60456 R11: 1ffffffff1d60455 R12: 0000000000040000
R13: ffff88802b34d7c0 R14: 00000000000c002c R15: 000000000000002c
FS:  00007f4326e2e840(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555557fd708 CR3: 000000007bb85000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class kernel/locking/lockdep.c:227 [inline]
 check_wait_context kernel/locking/lockdep.c:4729 [inline]
 __lock_acquire+0x490/0x1f60 kernel/locking/lockdep.c:5005
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
 local_lock_acquire+0x1d/0x70 include/linux/local_lock_internal.h:29
 ___slab_alloc+0x149/0xeb0 mm/slub.c:3112
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x268/0x350 mm/slub.c:3476
 getname_flags+0xb8/0x4e0 fs/namei.c:139
 do_sys_openat2+0xd2/0x500 fs/open.c:1304
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4326f25697
Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
RSP: 002b:00007ffc95aa1200 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00005651f2c318b0 RCX: 00007f4326f25697
RDX: 0000000000080000 RSI: 00007ffc95aa1338 RDI: 00000000ffffff9c
RBP: 00007ffc95aa1338 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 00005651f2c318b0 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
