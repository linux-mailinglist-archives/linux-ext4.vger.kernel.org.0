Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28D64FF37
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Dec 2022 16:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiLRPDi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 18 Dec 2022 10:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLRPDh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 18 Dec 2022 10:03:37 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FE4A1A7
        for <linux-ext4@vger.kernel.org>; Sun, 18 Dec 2022 07:03:35 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id e15-20020a056602158f00b006e01d8fa493so2952361iow.3
        for <linux-ext4@vger.kernel.org>; Sun, 18 Dec 2022 07:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V47kUFLXZGRSrLJliB6a7PDn5ugOYrfchGLPI8vBz6o=;
        b=NFp7dug4k1skXeiWFZOYq7r4XblXN2fLc7d20wpD+o8uboxYcqsfUKBy70MchfAlvi
         DU/2shdi/gxXjXk/uPAowHdElcHyA/HoeDWmSq8Yty7gEiaG0e9S6gnBKipSK9NX7Lxy
         1lIi9rYsONWFFeTAHIjlAwBiaHy0WoVbDvrMt+OKJYjNTLo1xPyK1HVfl7kE2rMVo/QV
         Pa0GbpIa9QQNzi0UYXcvHigAAbuIK3XKyxp5Xf0tZOZKXhUxvXTm/ZWopi86W4usTZF+
         MkWhsTLGqUwuLOXkkiByV7NkeZh0J6rfnO0W1PdQN99ypboIUi1FSGp6NRKfUkACwtb4
         nTBw==
X-Gm-Message-State: AFqh2koThw/B7ZQZEPVQyhiQz96uTgPCEx3VeHrQkalJEx4ISuwaIw6m
        Ha8v7GBe3X1R5vVp4B/8+jrMeyhBbVJ2qzS5+5iSuEJhKmif
X-Google-Smtp-Source: AMrXdXu9Fv5lgIWd2eswnv4opuPQxF2Nr1Eo6IH2tw7tet4nJaNi4JtOKz8Ik9fwOCzznoRKkx2NFlHOeewPTSixG030hCb+ZjLR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1048:b0:305:dff0:8851 with SMTP id
 p8-20020a056e02104800b00305dff08851mr946038ilj.159.1671375814242; Sun, 18 Dec
 2022 07:03:34 -0800 (PST)
Date:   Sun, 18 Dec 2022 07:03:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1b8bf05f01b81d7@google.com>
Subject: [syzbot] possible deadlock in ext4_ind_migrate
From:   syzbot <syzbot+a84e36883956fb0221b4@syzkaller.appspotmail.com>
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12802800480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=a84e36883956fb0221b4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a84e36883956fb0221b4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
------------------------------------------------------
syz-executor.3/8019 is trying to acquire lock:
ffff000118015b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ind_migrate+0xc8/0x318 fs/ext4/migrate.c:624

but task is already holding lock:
ffff000113706d30 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff000113706d30 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_fileattr_set+0x78/0x458 fs/ioctl.c:681

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#8){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       inode_lock_shared include/linux/fs.h:766 [inline]
       ext4_bmap+0x34/0x1c8 fs/ext4/inode.c:3164
       bmap+0x40/0x6c fs/inode.c:1798
       jbd2_journal_bmap fs/jbd2/journal.c:977 [inline]
       __jbd2_journal_erase fs/jbd2/journal.c:1789 [inline]
       jbd2_journal_flush+0x2a8/0x55c fs/jbd2/journal.c:2492
       ext4_ioctl_checkpoint fs/ext4/ioctl.c:1081 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1586 [inline]
       ext4_ioctl+0x1cb8/0x2378 fs/ext4/ioctl.c:1606
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (&journal->j_checkpoint_mutex){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       mutex_lock_io_nested+0x6c/0x88 kernel/locking/mutex.c:833
       __jbd2_log_wait_for_space+0xc0/0x330 fs/jbd2/checkpoint.c:110
       add_transaction_credits+0x4b4/0x604 fs/jbd2/transaction.c:298
       start_this_handle+0x2a0/0x7fc fs/jbd2/transaction.c:422
       jbd2__journal_start+0x148/0x1f0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x124/0x1dc fs/ext4/ext4_jbd2.c:105
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_ind_migrate+0xec/0x318 fs/ext4/migrate.c:626
       ext4_ioctl_setflags+0x5c0/0x5f0 fs/ext4/ioctl.c:695
       ext4_fileattr_set+0x174/0x528 fs/ext4/ioctl.c:1003
       vfs_fileattr_set+0x400/0x458 fs/ioctl.c:696
       do_vfs_ioctl+0x1374/0x16a4
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0x98/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       percpu_down_write+0x6c/0x188 kernel/locking/percpu-rwsem.c:227
       ext4_ind_migrate+0xc8/0x318 fs/ext4/migrate.c:624
       ext4_ioctl_setflags+0x5c0/0x5f0 fs/ext4/ioctl.c:695
       ext4_fileattr_set+0x174/0x528 fs/ext4/ioctl.c:1003
       vfs_fileattr_set+0x400/0x458 fs/ioctl.c:696
       do_vfs_ioctl+0x1374/0x16a4
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __arm64_sys_ioctl+0x98/0x140 fs/ioctl.c:856
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  &sbi->s_writepages_rwsem --> &journal->j_checkpoint_mutex --> &sb->s_type->i_mutex_key#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#8);
                               lock(&journal->j_checkpoint_mutex);
                               lock(&sb->s_type->i_mutex_key#8);
  lock(&sbi->s_writepages_rwsem);

 *** DEADLOCK ***

2 locks held by syz-executor.3/8019:
 #0: ffff000118016460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write_file+0x28/0xd8 fs/namespace.c:437
 #1: ffff000113706d30 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff000113706d30 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_fileattr_set+0x78/0x458 fs/ioctl.c:681

stack backtrace:
CPU: 1 PID: 8019 Comm: syz-executor.3 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 percpu_down_write+0x6c/0x188 kernel/locking/percpu-rwsem.c:227
 ext4_ind_migrate+0xc8/0x318 fs/ext4/migrate.c:624
 ext4_ioctl_setflags+0x5c0/0x5f0 fs/ext4/ioctl.c:695
 ext4_fileattr_set+0x174/0x528 fs/ext4/ioctl.c:1003
 vfs_fileattr_set+0x400/0x458 fs/ioctl.c:696
 do_vfs_ioctl+0x1374/0x16a4
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0x98/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
