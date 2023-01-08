Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27B0661381
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Jan 2023 04:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjAHDrg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Jan 2023 22:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAHDrf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Jan 2023 22:47:35 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3A32719F
        for <linux-ext4@vger.kernel.org>; Sat,  7 Jan 2023 19:47:34 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i7-20020a056e021b0700b003033a763270so3567600ilv.19
        for <linux-ext4@vger.kernel.org>; Sat, 07 Jan 2023 19:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQLB00WQd68qrRQA672AQnBNiJMOAPfrMUg3muGLgrI=;
        b=xWUlDny3DT2u6jossse99eBXsa3fuFHWLe8LeP3KU516XL9ddrI6To2ZykzEvq1EyD
         G1MGCzmUHgjwm7rSqpDSH0X2X2zt8qHLLvbNyKBN3IWooWfpnCdXFNuYQNP2ac8ZpWvV
         h/Q+B00zmMxY1cmwVuqJgRpKjj/h+oMF7r5kb1MOy57f5vCxJ4Q6tnj6tax43rdJEU5p
         KUds81KZJ1o4VhwEWugap8YiLM8qrihz6ayGyvFKjNZIq/jYtyOVR0l7tJqgKmhN1y+a
         1YTWs154COFGaLm2cAHSX3vISJdW4f5QId9wa+zk4RPpIbnxeCB36Q7DMT8CN2R4PaHN
         aPXQ==
X-Gm-Message-State: AFqh2krnmRDpPhViy588bOwo96lN84/ckuZt86eNoKJVWUtEc8OeBvUf
        E3LbLODNT836S7odZ5Sn4nVVyFlxG9KOaqfDWs4pPzqKmRLv
X-Google-Smtp-Source: AMrXdXtJwWRh9AmqZokyge7qrJ1NmFx/4vhVVD25IeDrdNbbW/1FRGWQ38yqwe18R+oTrKsBNKWh31xbJ2J11gVjrrokguqh3tf0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:30c:baf:6dee with SMTP id
 l14-20020a056e0212ee00b0030c0baf6deemr4057182iln.232.1673149653822; Sat, 07
 Jan 2023 19:47:33 -0800 (PST)
Date:   Sat, 07 Jan 2023 19:47:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5b55505f1b882d2@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in find_inode_fast
From:   syzbot <syzbot+77d6fcc37bbb92f26048@syzkaller.appspotmail.com>
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

HEAD commit:    512dee0c00ad Merge tag 'x86-urgent-2023-01-04' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15646c8c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=77d6fcc37bbb92f26048
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11aec6fa480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17af7d38480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfe07129fec8/disk-512dee0c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b694f4342135/vmlinux-512dee0c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dcea4a460ec2/bzImage-512dee0c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6b86252caf20/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77d6fcc37bbb92f26048@syzkaller.appspotmail.com

INFO: task syz-executor232:5073 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00024-g512dee0c00ad #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor232 state:D stack:21024 pid:5073  ppid:5072   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x995/0xe20 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 __wait_on_freeing_inode fs/inode.c:2196 [inline]
 find_inode_fast+0x35a/0x4c0 fs/inode.c:950
 iget_locked+0xb1/0x830 fs/inode.c:1273
 __ext4_iget+0x22e/0x3ed0 fs/ext4/inode.c:4861
 ext4_xattr_inode_iget+0x68/0x4e0 fs/ext4/xattr.c:389
 ext4_xattr_inode_dec_ref_all+0x1a7/0xe50 fs/ext4/xattr.c:1148
 ext4_xattr_delete_inode+0xb04/0xcd0 fs/ext4/xattr.c:2880
 ext4_evict_inode+0xd7c/0x10b0 fs/ext4/inode.c:296
 evict+0x2a4/0x620 fs/inode.c:664
 ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5516 [inline]
 ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa5406fd5ea
RSP: 002b:00007ffc7232f968 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa5406fd5ea
RDX: 0000000020000440 RSI: 0000000020000000 RDI: 00007ffc7232f970
RBP: 00007ffc7232f970 R08: 00007ffc7232f9b0 R09: 0000000000000432
R10: 0000000000804a03 R11: 0000000000000202 R12: 0000000000000004
R13: 0000555556a7a2c0 R14: 00007ffc7232f9b0 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d326f50 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d327750 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d326d80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4743:
 #0: ffff88814bdd0098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x53b/0x1650 drivers/tty/n_tty.c:2177
2 locks held by syz-executor232/5073:
 #0: ffff88802a5380e0 (&type->s_umount_key#28/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228
 #1: ffff88802a538650 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1811 [inline]
 #1: ffff88802a538650 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1933 [inline]
 #1: ffff88802a538650 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x4cd/0x10b0 fs/ext4/inode.c:240

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc2-syzkaller-00024-g512dee0c00ad #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x46f/0x4f0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1ba/0x420 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4421 Comm: klogd Not tainted 6.2.0-rc2-syzkaller-00024-g512dee0c00ad #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:vsnprintf+0x3cd/0x1cb0 lib/vsprintf.c:2829
Code: e8 08 92 e0 f6 48 83 fb 28 4c 8b 7c 24 08 0f 87 80 08 00 00 e8 d4 8d e0 f6 48 8b 7c 24 30 48 89 f8 48 c1 e8 03 42 80 3c 28 00 <74> 05 e8 ac 37 36 f7 89 d8 49 03 5e 10 44 8d 78 08 48 8b 44 24 10
RSP: 0018:ffffc90002f6f7a0 EFLAGS: 00000246
RAX: 1ffff920005edf22 RBX: 0000000000000010 RCX: ffff88807d8e1d40
RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffffc90002f6f910
RBP: ffffc90002f6f890 R08: ffffffff8aab4d78 R09: ffffffff8aab4b6e
R10: 0000000000000012 R11: ffff88807d8e1d40 R12: ffff0a0000000509
R13: dffffc0000000000 R14: ffffc90002f6f900 R15: ffffc90082f6fae2
FS:  00007f99d0120800(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005630c40b8a40 CR3: 000000002b714000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sprintf+0xc7/0x110 lib/vsprintf.c:3000
 print_time kernel/printk/printk.c:1357 [inline]
 info_print_prefix+0x153/0x2e0 kernel/printk/printk.c:1383
 record_print_text+0x12e/0x430 kernel/printk/printk.c:1432
 syslog_print+0x3a0/0x5e0 kernel/printk/printk.c:1643
 do_syslog+0x815/0x8f0 kernel/printk/printk.c:1762
 __do_sys_syslog kernel/printk/printk.c:1854 [inline]
 __se_sys_syslog kernel/printk/printk.c:1852 [inline]
 __x64_sys_syslog+0x78/0x90 kernel/printk/printk.c:1852
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f99d02bb8b7
Code: 73 01 c3 48 8b 0d c1 05 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 67 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 05 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffec1edf228 EFLAGS: 00000206 ORIG_RAX: 0000000000000067
RAX: ffffffffffffffda RBX: 00007f99d0448490 RCX: 00007f99d02bb8b7
RDX: 00000000000003ff RSI: 00007f99d0448490 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000007 R09: 000055d7b192cd50
R10: 0000000000004000 R11: 0000000000000206 R12: 00007f99d0448490
R13: 00007f99d044850e R14: 00007f99d044850e R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
