Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118766A9FD
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Jan 2023 08:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjANHvk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Jan 2023 02:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjANHvj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Jan 2023 02:51:39 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3BD213B
        for <linux-ext4@vger.kernel.org>; Fri, 13 Jan 2023 23:51:38 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id k5-20020a6bf705000000b0070483a64c60so3758571iog.18
        for <linux-ext4@vger.kernel.org>; Fri, 13 Jan 2023 23:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ2/GdpNqFVa8WL2BF1b4vAT5O7O2lmUCTX6JevYCDA=;
        b=B9HebuS8CqZ6gtTNDvGeQRb2Rdn7ndrGrLEISxECCexvUj7mi/gRCkSnubHY6T9tmD
         HbWPGsQ/Efn53sUtfodPRRSpxQhQUNd2lK3EpvKrgwq246HTaVs/A/rcbnLaqLLauhMj
         i71GjzkEKhwjzO4WDzMDD/PUaFJJPpcoyJ56iYymoVX8cFR/6qmqQiIu+qHawFNvFHcZ
         TefzsQXcmN/CYsCAD9pgew9lem1ISBs5+2ft2pFUPlWUQEqUCn61XYjTvLVhmDsj9tNp
         e1qHY/8ptrXLtof7AaQAon2Z0sJtUKOWShs6VqodWeA8MvBTtrc44/qv3MmMeEoIP3C0
         afHg==
X-Gm-Message-State: AFqh2krvW6uxxl/HIOfOriZL0eu5WYcw46cru1I696PqFkfOxDkSO0bb
        dVRJiUiZuMkHj41RzK7jfgB5rBg40hdpjzLn5tnVWWnYSJdN
X-Google-Smtp-Source: AMrXdXvXT75BpBuD6eHw8gg/07yf8v/CN3X+ME1/yWOn/hujMnGrNnTnVKB7+GUUX2D+/8Yf1MSjxOJE3NDQDwtuN/tVJVrNEl5c
MIME-Version: 1.0
X-Received: by 2002:a5d:8d07:0:b0:704:a441:de49 with SMTP id
 p7-20020a5d8d07000000b00704a441de49mr46675ioj.186.1673682697536; Fri, 13 Jan
 2023 23:51:37 -0800 (PST)
Date:   Fri, 13 Jan 2023 23:51:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a74de505f2349eb1@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_setattr
From:   syzbot <syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com>
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

HEAD commit:    358a161a6a9e Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=166001ba480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2573056c6a11f00d
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb68193bdb95af4340a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287585a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167d644a480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/99d14e0f4c19/disk-358a161a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23275b612976/vmlinux-358a161a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed79195fac61/Image-358a161a.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6e1f0d31d9b5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_mb_mark_diskspace_used:3789: comm syz-executor184: Allocating blocks 44-48 which overlap fs metadata
EXT4-fs error (device loop0): ext4_xattr_block_set:2175: inode #12: comm syz-executor184: bad block 0
======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc3-syzkaller-16369-g358a161a6a9e #0 Not tainted
------------------------------------------------------
syz-executor184/4449 is trying to acquire lock:
ffff0000cb1ae540 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:801 [inline]
ffff0000cb1ae540 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0x804/0xb38 fs/ext4/inode.c:5545

but task is already holding lock:
ffff0000cb1ae3a0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff0000cb1ae3a0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: do_truncate+0xf8/0x154 fs/open.c:63

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       ext4_xattr_inode_create fs/ext4/xattr.c:1457 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1540 [inline]
       ext4_xattr_set_entry+0xdf4/0xe40 fs/ext4/xattr.c:1669
       ext4_xattr_block_set+0x3d0/0x1404 fs/ext4/xattr.c:1975
       ext4_xattr_set_handle+0x724/0x9a0 fs/ext4/xattr.c:2390
       ext4_xattr_set+0x104/0x1d4 fs/ext4/xattr.c:2492
       ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
       __vfs_setxattr+0x290/0x29c fs/xattr.c:202
       __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:236
       __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:297
       vfs_setxattr+0xf4/0x1f4 fs/xattr.c:323
       do_setxattr fs/xattr.c:608 [inline]
       setxattr fs/xattr.c:631 [inline]
       path_setxattr+0x32c/0x424 fs/xattr.c:650
       __do_sys_setxattr fs/xattr.c:666 [inline]
       __se_sys_setxattr fs/xattr.c:662 [inline]
       __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:662
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #2 (&ei->xattr_sem){++++}-{3:3}:
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
       ext4_xattr_set_handle+0xd0/0x9a0 fs/ext4/xattr.c:2305
       ext4_initxattrs+0x50/0xac fs/ext4/xattr_security.c:44
       security_inode_init_security+0x208/0x278 security/security.c:1147
       ext4_init_security+0x44/0x58 fs/ext4/xattr_security.c:58
       __ext4_new_inode+0x1a88/0x1c78 fs/ext4/ialloc.c:1324
       ext4_create+0x124/0x26c fs/ext4/namei.c:2809
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11f0 fs/namei.c:3711
       do_filp_open+0xdc/0x1b8 fs/namei.c:3741
       do_sys_openat2+0xb8/0x22c fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (jbd2_handle){.+.+}-{0:0}:
       start_this_handle+0x6e0/0x7fc fs/jbd2/transaction.c:463
       jbd2__journal_start+0x148/0x1f0 fs/jbd2/transaction.c:520
       __ext4_journal_start_sb+0x158/0x210 fs/ext4/ext4_jbd2.c:111
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_truncate+0x3b4/0x72c fs/ext4/inode.c:4315
       ext4_setattr+0x900/0xb38 fs/ext4/inode.c:5622
       notify_change+0x738/0x7d0 fs/attr.c:482
       do_truncate+0x10c/0x154 fs/open.c:65
       do_sys_ftruncate+0x1b4/0x1c4 fs/open.c:193
       __do_sys_ftruncate fs/open.c:204 [inline]
       __se_sys_ftruncate fs/open.c:202 [inline]
       __arm64_sys_ftruncate+0x28/0x38 fs/open.c:202
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (mapping.invalidate_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       filemap_invalidate_lock include/linux/fs.h:801 [inline]
       ext4_setattr+0x804/0xb38 fs/ext4/inode.c:5545
       notify_change+0x738/0x7d0 fs/attr.c:482
       do_truncate+0x10c/0x154 fs/open.c:65
       handle_truncate+0xf4/0x154 fs/namei.c:3216
       do_open fs/namei.c:3561 [inline]
       path_openat+0xee0/0x11f0 fs/namei.c:3714
       do_filp_open+0xdc/0x1b8 fs/namei.c:3741
       do_sys_openat2+0xb8/0x22c fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_openat fs/open.c:1342 [inline]
       __se_sys_openat fs/open.c:1337 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  mapping.invalidate_lock --> &ei->xattr_sem --> &ea_inode->i_rwsem#8/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->xattr_sem);
                               lock(&ea_inode->i_rwsem#8/1);
  lock(mapping.invalidate_lock);

 *** DEADLOCK ***

2 locks held by syz-executor184/4449:
 #0: ffff0000c6723460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x64 fs/namespace.c:508
 #1: ffff0000cb1ae3a0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff0000cb1ae3a0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: do_truncate+0xf8/0x154 fs/open.c:63

stack backtrace:
CPU: 1 PID: 4449 Comm: syz-executor184 Not tainted 6.2.0-rc3-syzkaller-16369-g358a161a6a9e #0
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
 down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
 filemap_invalidate_lock include/linux/fs.h:801 [inline]
 ext4_setattr+0x804/0xb38 fs/ext4/inode.c:5545
 notify_change+0x738/0x7d0 fs/attr.c:482
 do_truncate+0x10c/0x154 fs/open.c:65
 handle_truncate+0xf4/0x154 fs/namei.c:3216
 do_open fs/namei.c:3561 [inline]
 path_openat+0xee0/0x11f0 fs/namei.c:3714
 do_filp_open+0xdc/0x1b8 fs/namei.c:3741
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
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
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
