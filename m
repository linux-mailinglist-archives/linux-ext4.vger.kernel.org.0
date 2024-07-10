Return-Path: <linux-ext4+bounces-3173-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1BA92CF12
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD51C21B1D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45C218FDCA;
	Wed, 10 Jul 2024 10:20:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EF18FA33
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jul 2024 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606824; cv=none; b=HhjYo0QegQskQygkRmnGdqFLSZYtj7gfeqgQu3iLbqdcJCzVjoljrWqR2HWto6cbFjuydhLHd7AG8HrcbOSLv/dDOqJE4J1w1jVo/LByX6lbsICH4QoXf33F8MVaSzUqNcx+J0MJXXLlh3vXF3ks8aZNOvsj9YlYpc+/YFDApcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606824; c=relaxed/simple;
	bh=jkTe2USL6lLIMEivDJ5SrpTbG0+48gv3Cf97doyOFHo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XIwhDu5ust0wo0NNt5F1VqV3YrLfbBjxf1WOz7RIuZY1InmZhsR8m+uARbRrcheCaHApS+CEHZZEkauZzTmE9D1bLPkOBm8CPUaqe/7EtSMI83QMkYUDB84Lj1m2a6EY1ibSC23nc1keAdyDofLJMqZ/8un3wGWBh0GaajskZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso97441039f.1
        for <linux-ext4@vger.kernel.org>; Wed, 10 Jul 2024 03:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720606822; x=1721211622;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9HCLxBVLDJCrzW833xEgiyxMooVhvyunK+9fhjyPJ4=;
        b=ZoMd74XUc8EgDPcWU2+icivifHf2swAzg0Z/LNVhNShYeTTSbVGTCjbrx1ocpKxUX2
         LidFotmsXzaiuZ+Nwawy+R7vsPFr2NkHSZte6rUxSBz+kIKv1JxIju8/uzK8CIDNJpS8
         ZJTfTqrFjMz67mptPtL1snDknjBbiYPTvHqTBYR08GxTDnnl3/9DA5w1dThKUIdF2uaQ
         AnmIIhlzJ+pjBIJ4dWiTNv7jeUqkTqk5PiJRQwE+d6iN/0pWIdk55LTSV9wbeIvApXkz
         SxQdQNssVJtJ8LiYZ8wbpXMQN0ZP5J2EsweJu3tV2uG8lzfaJfX9DcsA4WjkuYQCbKUz
         b1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvBCNIIo4lcWUCYvBgzMYlkmMGpRD/sZh5IPXpkQaZSudfAIon8clfETR/cNe/FFVl57EAidOQ6M99yRksIXcvWCw6wKWyRKINyA==
X-Gm-Message-State: AOJu0YzMmgEfILU0gBTsGBCWSvlS89oyf+RaBqD29yYfiOzptY1Gn0An
	50DpK/u8XvQ8EdaSzaYNgfbQMhWyjiXUDHlappXx2kSKX7HP8+4BVi9pAi7kAwLWnpaIep4YhfG
	TvvcfBsPhA9B7jkLKdeOUnSl2zIZ6ZCNjgcMjKC24F34xTOKVCqTpdTY=
X-Google-Smtp-Source: AGHT+IFTILk7tbzpvi+97apZnNxp5Fdw3+BSsXsdX/g7qlf0Lq75bz+3hJZ3sSHrmNaUuEPJ+vwVfs88w4YiFiz1T16chFksJnFB
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:710a:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4c0b29ba495mr459462173.2.1720606821773; Wed, 10 Jul 2024
 03:20:21 -0700 (PDT)
Date: Wed, 10 Jul 2024 03:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000690606061ce1fe7e@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in ext4_stop_mmpd
From: syzbot <syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    34afb82a3c67 Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1444869e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5e93dc1544ee/disk-34afb82a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/005e374613f0/vmlinux-34afb82a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6931db81a1a/bzImage-34afb82a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com

INFO: task syz-executor:16187 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc7-syzkaller-00012-g34afb82a3c67 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20288 pid:16187 tgid:16187 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 kthread_stop+0x19e/0x630 kernel/kthread.c:710
 ext4_stop_mmpd+0x47/0xb0 fs/ext4/mmp.c:261
 ext4_put_super+0x6f6/0xcd0 fs/ext4/super.c:1362
 generic_shutdown_super+0x136/0x2d0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1685
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7301
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9123f76f07
RSP: 002b:00007fffeca9de48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9123f76f07
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffeca9df00
RBP: 00007fffeca9df00 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffeca9efc0
R13: 00007f9123fe3515 R14: 00000000000f57c0 R15: 00000000000f4f30
 </TASK>
INFO: task kmmpd-loop3:16389 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc7-syzkaller-00012-g34afb82a3c67 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kmmpd-loop3     state:D stack:27680 pid:16389 tgid:16389 ppid:2      flags:0x00024000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 percpu_rwsem_wait+0x3c2/0x450 kernel/locking/percpu-rwsem.c:162
 __percpu_down_read+0xee/0x130 kernel/locking/percpu-rwsem.c:177
 percpu_down_read include/linux/percpu-rwsem.h:65 [inline]
 __sb_start_write include/linux/fs.h:1655 [inline]
 sb_start_write include/linux/fs.h:1791 [inline]
 write_mmp_block+0x2f2/0x3a0 fs/ext4/mmp.c:66
 kmmpd+0x26d/0xaa0 fs/ext4/mmp.c:246
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u8:1/12:
 #0: ffff888018ecb948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888018ecb948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc90000117d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc90000117d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff88802fd960e0 (&type->s_umount_key#31){++++}-{3:3}, at: super_trylock_shared+0x22/0xf0 fs/super.c:562
 #3: ffff8880b942a718 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x744/0xeb0 kernel/time/timer.c:1164
1 lock held by khungtaskd/30:
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333f20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by dhcpcd/4747:
 #0: ffff888051767678 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: netlink_dump+0xcb/0xe50 net/netlink/af_netlink.c:2277
 #1: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: netlink_dump+0x5d3/0xe50 net/netlink/af_netlink.c:2336
2 locks held by getty/4835:
 #0: ffff88802fd500a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f0e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:4/5136:
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015080948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900046f7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900046f7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
6 locks held by kworker/u8:9/9949:
 #0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888015ed3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc90003adfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc90003adfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffffffff8f5c80d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffff88806e0340e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88806e0340e8 (&dev->mutex){....}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff88806e0340e8 (&dev->mutex){....}-{3:3}, at: devlink_pernet_pre_exit+0x13b/0x440 net/devlink/core.c:506
 #4: ffff88806e035250 (&devlink->lock_key#117){+.+.}-{3:3}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff88806e035250 (&devlink->lock_key#117){+.+.}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff88806e035250 (&devlink->lock_key#117){+.+.}-{3:3}, at: devlink_pernet_pre_exit+0x14d/0x440 net/devlink/core.c:506
 #5: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: nsim_init_netdevsim drivers/net/netdevsim/netdev.c:678 [inline]
 #5: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: nsim_create+0x408/0x890 drivers/net/netdevsim/netdev.c:750
1 lock held by syz-executor/16187:
 #0: ffff88801fb3e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88801fb3e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88801fb3e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: deactivate_super+0xb5/0xf0 fs/super.c:505
1 lock held by kmmpd-loop3/16389:
 #0: ffff88801fb3e420 (sb_writers#4){++++}-{0:0}, at: kmmpd+0x26d/0xaa0 fs/ext4/mmp.c:246
1 lock held by syz.3.1124/16973:
 #0: ffff88801fb3e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88801fb3e0e0 (&type->s_umount_key#31){++++}-{3:3}, at: super_lock+0x196/0x400 fs/super.c:120
2 locks held by kworker/u8:5/17216:
 #0: ffff8880b943e758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffff8880b9428948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3a7/0x770 kernel/sched/psi.c:976
8 locks held by syz-executor/17933:
 #0: ffff88801e4ee420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2854 [inline]
 #0: ffff88801e4ee420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #1: ffff88802a9d4488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
 #2: ffff8880236b6788 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
 #3: ffffffff8eee1f28 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff8880582a00e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff8880582a00e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
 #4: ffff8880582a00e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1290
 #5: ffff8880582a7250 (&devlink->lock_key#121){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #7: ffffffff8e3392f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:939
1 lock held by syz-executor/18023:
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
1 lock held by syz-executor/18040:
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
1 lock held by syz-executor/18086:
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
2 locks held by syz-executor/18127:
 #0: ffffffff8f5c80d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c6/0x7b0 net/core/net_namespace.c:504
 #1: ffffffff8f5d4908 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x20e/0x710 net/ipv4/ip_tunnel.c:1159

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc7-syzkaller-00012-g34afb82a3c67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc7-syzkaller-00012-g34afb82a3c67 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:check_kcov_mode kernel/kcov.c:184 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x70 kernel/kcov.c:207
Code: 80 d4 03 00 65 8b 15 b0 ad 6d 7e f7 c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 1c 16 00 00 00 74 2c 8b 91 f8 15 00 00 <83> fa 02 75 21 48 8b 91 00 16 00 00 48 8b 32 48 8d 7e 01 8b 89 fc
RSP: 0018:ffffc90000116a80 EFLAGS: 00000246
RAX: ffffffff8140f017 RBX: ffffffff8accb138 RCX: ffff8880176b5a00
RDX: 0000000000000000 RSI: ffffffff8accb138 RDI: ffffc90000116b60
RBP: ffffc90000116b60 R08: 0000000000000003 R09: ffffc90000116c50
R10: 0000000000000003 R11: ffffffff8181dca0 R12: ffff8880176b5a00
R13: dffffc0000000000 R14: ffffc90000116c40 R15: ffffc90000116b60
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc5ed43f8c CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0x27/0x2a00 arch/x86/kernel/unwind_orc.c:469
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4123 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4136
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 cfg80211_inform_single_bss_data+0xd78/0x2360 net/wireless/scan.c:2265
 cfg80211_inform_bss_data+0x3dd/0x5a70 net/wireless/scan.c:3117
 cfg80211_inform_bss_frame_data+0x3bc/0x720 net/wireless/scan.c:3207
 ieee80211_bss_info_update+0x8a7/0xbc0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1099 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1578 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1962/0x2d70 net/mac80211/ibss.c:1605
 ieee80211_iface_process_skb net/mac80211/iface.c:1603 [inline]
 ieee80211_iface_work+0x8a3/0xf10 net/mac80211/iface.c:1657
 cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

