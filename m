Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865C56573C9
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Dec 2022 08:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiL1H7n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Dec 2022 02:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiL1H7j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Dec 2022 02:59:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F23EA0
        for <linux-ext4@vger.kernel.org>; Tue, 27 Dec 2022 23:59:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so9957897iln.21
        for <linux-ext4@vger.kernel.org>; Tue, 27 Dec 2022 23:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f0SSbrbKdPRV2FOQBrSJx+fP69PRnW3/+v2Fk9Xt6Ko=;
        b=uK460OyV56LLwL77kDtBElJ8CqM4HP7as8fBUH5Wj4sZIMQJZDhm/LBAgilUIq7xGn
         Ya4TUd25mnh2oYe5fnJ6dv4La9gg8lYRM8m6nnq0D26obVUEJADx43whKzlNiCrntJX9
         Rt/G1N6K3x6l14dt/ge188W+Sq5ROVUaReCii8yDsBWGc6452qahPSaMh3f2NSeU3KJd
         Xy3JjNlYl/xEH1fNe6S5OQS69kVhdQkLZBPQZ7067r6cRyTI+R//NQGS5t/NgPlteryO
         TNTMXeb3HO+3fZ32HogfUMG8XotT5sLQbGJTPt2WsOFcpAjuFsZfBqMA7e2D6lzaEcer
         FJpQ==
X-Gm-Message-State: AFqh2kpWufQ/aHBdgqasSW+atl8Todxz83TKlQn1kmzbdml0U3EgymdD
        YO5iXns58cr9e4p3vxuEd6BJWKyFOZtBDZeriLkmbavxbTM0
X-Google-Smtp-Source: AMrXdXuaegKlNWjgLZS1VuM/DxztTaKZM0Y6leW45NV+fYKRhFfgCCJ62/LgHSgbVm1sgcEFqS+tVPFYgz9Hlpn4HA3Jsmloay2q
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:30b:fe74:8e15 with SMTP id
 m8-20020a056e021c2800b0030bfe748e15mr1104165ilh.11.1672214377982; Tue, 27 Dec
 2022 23:59:37 -0800 (PST)
Date:   Tue, 27 Dec 2022 23:59:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd2b9505f0debfd1@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_find_inline_entry
From:   syzbot <syzbot+d3bb749184481f92deb5@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=124896ff880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=d3bb749184481f92deb5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11711df8480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161e81b0480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5ea71b2bd574/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3bb749184481f92deb5@syzkaller.appspotmail.com

EXT4-fs: Warning: mounting with an experimental mount option 'dioread_nolock' for blocksize < PAGE_SIZE
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
------------------------------------------------------
syz-executor246/3073 is trying to acquire lock:
ffff0000cacbcd48 (&ei->xattr_sem){++++}-{3:3}, at: ext4_find_inline_entry+0x80/0x224 fs/ext4/inline.c:1690

but task is already holding lock:
ffff0000cacbda10 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff0000cacbda10 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: vfs_unlink+0x78/0x300 fs/namei.c:4241

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       ext4_xattr_inode_create fs/ext4/xattr.c:1454 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1537 [inline]
       ext4_xattr_set_entry+0xde4/0xe28 fs/ext4/xattr.c:1665
       ext4_xattr_ibody_set+0x94/0x184 fs/ext4/xattr.c:2225
       ext4_xattr_set_handle+0x648/0x9a0 fs/ext4/xattr.c:2382
       ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2496
       ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
       __vfs_setxattr+0x250/0x260 fs/xattr.c:182
       __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
       __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
       vfs_setxattr+0xf4/0x1f4 fs/xattr.c:309
       do_setxattr fs/xattr.c:594 [inline]
       setxattr fs/xattr.c:617 [inline]
       path_setxattr+0x354/0x414 fs/xattr.c:636
       __do_sys_lsetxattr fs/xattr.c:659 [inline]
       __se_sys_lsetxattr fs/xattr.c:655 [inline]
       __arm64_sys_lsetxattr+0x2c/0x40 fs/xattr.c:655
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       ext4_find_inline_entry+0x80/0x224 fs/ext4/inline.c:1690
       __ext4_find_entry+0xe8/0xb4c fs/ext4/namei.c:1596
       ext4_find_entry fs/ext4/namei.c:1731 [inline]
       __ext4_unlink+0xa8/0x3e4 fs/ext4/namei.c:3215
       ext4_unlink+0x150/0x200 fs/ext4/namei.c:3291
       vfs_unlink+0x1dc/0x300 fs/namei.c:4252
       do_unlinkat+0x200/0x3dc fs/namei.c:4320
       __do_sys_unlinkat fs/namei.c:4363 [inline]
       __se_sys_unlinkat fs/namei.c:4356 [inline]
       __arm64_sys_unlinkat+0x7c/0xa8 fs/namei.c:4356
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->xattr_sem);
                               lock(&ea_inode->i_rwsem#8/1);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz-executor246/3073:
 #0: ffff0000ca036460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x64 fs/namespace.c:393
 #1: ffff0000cacbd080 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #1: ffff0000cacbd080 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0xf0/0x3dc fs/namei.c:4303
 #2: ffff0000cacbda10 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #2: ffff0000cacbda10 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: vfs_unlink+0x78/0x300 fs/namei.c:4241

stack backtrace:
CPU: 1 PID: 3073 Comm: syz-executor246 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
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
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
 ext4_find_inline_entry+0x80/0x224 fs/ext4/inline.c:1690
 __ext4_find_entry+0xe8/0xb4c fs/ext4/namei.c:1596
 ext4_find_entry fs/ext4/namei.c:1731 [inline]
 __ext4_unlink+0xa8/0x3e4 fs/ext4/namei.c:3215
 ext4_unlink+0x150/0x200 fs/ext4/namei.c:3291
 vfs_unlink+0x1dc/0x300 fs/namei.c:4252
 do_unlinkat+0x200/0x3dc fs/namei.c:4320
 __do_sys_unlinkat fs/namei.c:4363 [inline]
 __se_sys_unlinkat fs/namei.c:4356 [inline]
 __arm64_sys_unlinkat+0x7c/0xa8 fs/namei.c:4356
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
