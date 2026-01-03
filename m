Return-Path: <linux-ext4+bounces-12540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7D2CEF824
	for <lists+linux-ext4@lfdr.de>; Sat, 03 Jan 2026 01:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 260CA301355F
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jan 2026 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8253A1E9B;
	Sat,  3 Jan 2026 00:10:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C71FC8
	for <linux-ext4@vger.kernel.org>; Sat,  3 Jan 2026 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767399022; cv=none; b=u6aPsp3Ov4TvQdBj+S5oPA7L7jFrzuCMcqhoPNV9Jm4eTMS5UEw172LE44vBhI71tnGprG4IaEDqijSPF4gs1ikHDEueWMjSrSs4885WqrawyAr8lLQ4pzhyMTEQqCRxrV6uC2CtqZ+f76e2IR3Gj1VTYsgVaVohFA2X2tGdXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767399022; c=relaxed/simple;
	bh=i+05l102Bg3/+Tk9zBxnQfiVso+h4rucEpZtG75bhXY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pO/wugQHBoMVzFNpiAczibwkEXeKx7ZCdmVFpsHg2Br5JNT2FaTLFNo6Ub6wP+SFsS26jwEfAUTXUy8OysljRSTIU/qzPta2mV0WPOe3sGz3TUsq5salKy60/OjrGD9m6modPHnkq8wDCUz4BZ4UbZUp2Z5bssphRt9w38W9DAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65ed4d39a1bso13838664eaf.2
        for <linux-ext4@vger.kernel.org>; Fri, 02 Jan 2026 16:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767399019; x=1768003819;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvdimUrzchyWqzbfC4bLNMI4E3IwgbowVzCpPstHSeA=;
        b=roHSNbhFy4bRaXkOzt1S90fGjZx3WdC67G+7KCNCjDt2O5TqCH7p/8i/rtlRtPQ2cp
         xOsPZyv3C1DUEI/zKqjqOaA2KuY3yirjLeGcmCrfgsVOkmvzpB2UPFZ7EbeKp9400FwH
         F3DX9O+QY1VsYcHt4zA9dfM/CZgvgvexnizVYNOEEacpUv8NrQIqTSKovW7Y+SvtBXOD
         k0BYIA5QCLD7bp69+ZCcWJYyCSA1Pj54i3udBxtQhHQEAzAm9hO9yVG/qDyNkbFGYpVG
         pAIgRRAUMD/LtNdLJJakdWbpblbpfDF1HYagwsVxtclcmfSN4D4SjgpzRY1tZPTnsjXu
         VsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ46WtNZhqew4qMlKvQ4AL6wKuwv+tBNanYjRKs72ECpsmXqY021LkYY/vmB12R4+o6imWDr30r35u@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2wyvKEhmgflXRwDxaK4kii7ctJdZsSHVfaHgk63aufbX0oXZ
	gOSA8uXLlQkQNM/184MHE6BYVDzv9YLdOPashBsEv8lTYjyM0grDPn5pTNNFJnoujrIHA5jyZSP
	kkH0zr5zf3K9BNj7avBJ0X9DWrWJPEvz7YIfAIcUFvcSBV8nMHxFLLKcvWqw=
X-Google-Smtp-Source: AGHT+IGEoVJSLSX3+CtFowo2n9hqsuZGxPiw4GTvHL0BJRX8Pq6fVLUEe9gBfd5GSUCmTi3wpCDv36w6MS5xPwRWrH3beM5kEMGn
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c4b:b0:659:9a49:8f59 with SMTP id
 006d021491bc7-65d0e9ac7aamr13275758eaf.30.1767399019506; Fri, 02 Jan 2026
 16:10:19 -0800 (PST)
Date: Fri, 02 Jan 2026 16:10:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69585e6b.050a0220.a1b6.0368.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in ext4_map_blocks (5)
From: syzbot <syzbot+f4bc1dbf84c55838d09c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc3aa43b44bd Add linux-next specific files for 20251219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142c029a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1bc82c6189c463
dashboard link: https://syzkaller.appspot.com/bug?extid=f4bc1dbf84c55838d09c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1799b49a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30bf539e6f28/disk-cc3aa43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2f8b08e342/vmlinux-cc3aa43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec7ee6ece11f/bzImage-cc3aa43b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5981c8e54820/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1248949a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4bc1dbf84c55838d09c@syzkaller.appspotmail.com

INFO: task kworker/u8:6:195 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:6    state:D stack:23544 pid:195   tgid:195   ppid:2      task_flags:0x4248060 flags:0x00080000
Workqueue: writeback wb_workfn (flush-7:1)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 __schedule_loop kernel/sched/core.c:6948 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6963
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7020
 rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
 __down_write_common kernel/locking/rwsem.c:1317 [inline]
 __down_write kernel/locking/rwsem.c:1326 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1591
 ext4_map_blocks+0x73f/0x16f0 fs/ext4/inode.c:815
 mpage_map_one_extent fs/ext4/inode.c:2380 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2474 [inline]
 ext4_do_writepages+0x222f/0x4500 fs/ext4/inode.c:2932
 ext4_writepages+0x203/0x350 fs/ext4/inode.c:3026
 do_writepages+0x32e/0x550 mm/page-writeback.c:2598
 __writeback_single_inode+0x133/0x1240 fs/fs-writeback.c:1737
 writeback_sb_inodes+0x93a/0x1870 fs/fs-writeback.c:2030
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2107
 wb_writeback+0x43f/0xaa0 fs/fs-writeback.c:2218
 wb_check_old_data_flush fs/fs-writeback.c:2322 [inline]
 wb_do_writeback fs/fs-writeback.c:2375 [inline]
 wb_workfn+0xad2/0xed0 fs/fs-writeback.c:2403
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u8:1/13:
 #0: ffff88801baa7148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3254
 #1: ffffc90000127b80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3255
 #2: ffffffff8f504e10 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf7/0x7a0 net/core/net_namespace.c:670
 #3: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: default_device_exit_batch+0xdc/0x9e0 net/core/dev.c:13041
1 lock held by khungtaskd/31:
 #0: ffffffff8e13f2e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f2e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e13f2e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
5 locks held by kworker/u8:6/195:
 #0: ffff888140e85948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3254
 #1: ffffc90003037b80 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3255
 #2: ffff8880312360e0 (&type->s_umount_key#32){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:563
 #3: ffff888057928b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 #3: ffff888057928b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
 #3: ffff888057928b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025
 #4: ffff88805e59e2b0 (&ei->i_data_sem){++++}-{4:4}, at: ext4_map_blocks+0x73f/0x16f0 fs/ext4/inode.c:815
3 locks held by kworker/u8:7/1137:
 #0: ffff888030954148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x841/0x15a0 kernel/workqueue.c:3254
 #1: ffffc9000429fb80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x868/0x15a0 kernel/workqueue.c:3255
 #2: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x112/0x14b0 net/ipv6/addrconf.c:4194
2 locks held by getty/5584:
 #0: ffff88803590d0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x449/0x1460 drivers/tty/n_tty.c:2211
4 locks held by syz.1.48/6567:
 #0: ffff888031236420 (sb_writers#4){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2680 [inline]
 #0: ffff888031236420 (sb_writers#4){.+.+}-{0:0}, at: vfs_writev+0x288/0x960 fs/read_write.c:1055
 #1: ffff88805e59e420 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #1: ffff88805e59e420 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: ext4_buffered_write_iter+0x9f/0x3a0 fs/ext4/file.c:294
 #2: ffff88805e59e5c0 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock include/linux/fs.h:1083 [inline]
 #2: ffff88805e59e5c0 (mapping.invalidate_lock#2){++++}-{4:4}, at: ext4_truncate_failed_write fs/ext4/truncate.h:20 [inline]
 #2: ffff88805e59e5c0 (mapping.invalidate_lock#2){++++}-{4:4}, at: ext4_write_end+0x736/0x9e0 fs/ext4/inode.c:1491
 #3: ffff88805e59e2b0 (&ei->i_data_sem){++++}-{4:4}, at: ext4_truncate+0xab0/0x12e0 fs/ext4/inode.c:4608
3 locks held by kworker/u8:16/6595:
1 lock held by syz-executor/7011:
 #0: ffffffff8e144e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #0: ffffffff8e144e38 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x3b9/0x730 kernel/rcu/tree_exp.h:956
1 lock held by syz-executor/11659:
 #0: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8ec/0x1c90 net/core/rtnetlink.c:4071
7 locks held by syz-executor/11765:
 #0: ffff888034aa0420 (sb_writers#7){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2680 [inline]
 #0: ffff888034aa0420 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x211/0xb30 fs/read_write.c:682
 #1: ffff888034ab6888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1de/0x540 fs/kernfs/file.c:343
 #2: ffff888141f5f788 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888141f5f788 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x231/0x540 fs/kernfs/file.c:344
 #3: ffffffff8ed9f508 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x360 drivers/net/netdevsim/bus.c:234
 #4: ffff88805d4fc0e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #4: ffff88805d4fc0e8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1104 [inline]
 #4: ffff88805d4fc0e8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb6/0x800 drivers/base/dd.c:1302
 #5: ffff88805d4fe250 (&devlink->lock_key#48){+.+.}-{4:4}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1778
 #6: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #6: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: unregister_netdevice_notifier_net+0x8d/0x2a0 net/core/dev.c:2113
2 locks held by syz-executor/11879:
 #0: ffffffff8fa26b60 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa26b60 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8fa26b60 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8ec/0x1c90 net/core/rtnetlink.c:4071
2 locks held by syz-executor/11933:
 #0: ffffffff8fa44b48 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa44b48 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8fa44b48 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f512448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8ec/0x1c90 net/core/rtnetlink.c:4071
3 locks held by dhcpcd-run-hook/12165:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:363 [inline]
 watchdog+0xe40/0xe90 kernel/hung_task.c:557
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5188 Comm: klogd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:unwind_next_frame+0x5/0x23d0 arch/x86/kernel/unwind_orc.c:485
Code: e1 07 80 c1 03 38 c1 7c 92 48 89 df e8 e4 31 b4 00 eb 88 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 81 ec 98 00 00 00 49 89 fe 48 bd 00
RSP: 0018:ffffc90000a087f8 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffc90000a088c0 RCX: 22455e0eb6d45800
RDX: dffffc0000000000 RSI: ffffffff821cc5a0 RDI: ffffc90000a08808
RBP: ffffc90000a08890 R08: ffffc90000a088d0 R09: 0000000000000003
R10: ffffc90000a08858 R11: ffffffff81ad9d50 R12: ffff88807d813d00
R13: 0000000000000000 R14: ffffffff81ad9d50 R15: ffffc90000a08808
FS:  00007fbf88869c80(0000) GS:ffff888125d25000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8aaca7f000 CR3: 000000007d90c000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kfree+0x1c0/0x660 mm/slub.c:6882
 slab_free_after_rcu_debug+0x5d/0x260 mm/slub.c:6720
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xd70/0x1870 kernel/rcu/tree.c:2857
 handle_softirqs+0x27d/0x850 kernel/softirq.c:626
 do_softirq+0xec/0x180 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x224/0x430 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xca/0x890 net/core/skbuff.c:6712
 sock_alloc_send_pskb+0x84d/0x980 net/core/sock.c:2995
 unix_dgram_sendmsg+0x454/0x1840 net/unix/af_unix.c:2130
 sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
 __sock_sendmsg net/socket.c:752 [inline]
 __sys_sendto+0x3ce/0x540 net/socket.c:2221
 __do_sys_sendto net/socket.c:2228 [inline]
 __se_sys_sendto net/socket.c:2224 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2224
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf889b9407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffd695e3580 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fbf88869c80 RCX: 00007fbf889b9407
RDX: 000000000000004c RSI: 00007ffd695e36c0 RDI: 0000000000000003
RBP: 00007ffd695e3af0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000202 R12: 00007ffd695e3b08
R13: 00007ffd695e36c0 R14: 0000000000000031 R15: 00007ffd695e36c0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

