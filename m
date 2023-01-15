Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF666B0F6
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Jan 2023 13:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjAOM14 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Jan 2023 07:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjAOM1w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Jan 2023 07:27:52 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20FEC78
        for <linux-ext4@vger.kernel.org>; Sun, 15 Jan 2023 04:27:51 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id d24-20020a5d9bd8000000b006ee2ddf6d77so16177389ion.6
        for <linux-ext4@vger.kernel.org>; Sun, 15 Jan 2023 04:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Nk4RzGt65DEJz/HGwzWTwIKEV7jTZ1O/jwFYmzra2E=;
        b=XRUAswspYG2TnTuM77t3aQSZzNVt4q4aPk2db1wq3DtdNsoMy9jhpjCxfBdbZ0iK4j
         oAOz9V23t/fQEfHbdlbMclWc/24ge03MGrYCp0bGU5BQmHxQwGNtUrwYTywPn6DkGbdm
         j4r/DkeoPlv/a+4pNgO82hmIoS502SZVDHpIwjZIbYSUNevBaxEJFOHe9jCgs+BuKo8q
         +ig+VNALJCgmDDmL8Cfxih4XyRJjRnhy1CHhvAgo7rKtItCFWiX271mxOpWzUZFg6fUl
         qyWVfSogS+L2+oHw/IYDElhhdo3oHET872Qp6GqfS55ULY+w/4Y/4LD7yGMpMW2ISGMU
         xHZg==
X-Gm-Message-State: AFqh2krYMrLyENY4glN0Bb6YbMyFux4l8ViJTyHnC+WyIUF8bQEIfXmd
        EeyN5uzIZ2lRzyvOvxYxDnBsUJFZLrbSmzFPMRIhssjeQ+UM
X-Google-Smtp-Source: AMrXdXseJVL1OQfWTvLHbp7cYD7t91z1YDVELMxHBgTD1CD0PtMqogs+S88hjAbUMdZJX7KKBp7mKdxvK19BCE/Sv+a9K1HR3VN4
MIME-Version: 1.0
X-Received: by 2002:a6b:d613:0:b0:6ed:3090:2ae5 with SMTP id
 w19-20020a6bd613000000b006ed30902ae5mr8137739ioa.100.1673785670969; Sun, 15
 Jan 2023 04:27:50 -0800 (PST)
Date:   Sun, 15 Jan 2023 04:27:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005937d105f24c9809@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget
From:   syzbot <syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com>
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

HEAD commit:    7dd4b804e080 Merge tag 'nfsd-6.2-3' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a536a4480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=298c5d8fb4a128bc27b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8f3d4c62796/disk-7dd4b804.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb3961bfb8a3/vmlinux-7dd4b804.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1b3589ad06f2/bzImage-7dd4b804.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+298c5d8fb4a128bc27b0@syzkaller.appspotmail.com

EXT4-fs (loop2): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc3-syzkaller-00021-g7dd4b804e080 #0 Not tainted
------------------------------------------------------
syz-executor.2/14465 is trying to acquire lock:
ffff8880747b5440 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff8880747b5440 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_iget+0x270/0x5d0 fs/ext4/xattr.c:427

but task is already holding lock:
ffff888080c9f0e0 (&ei->i_data_sem){++++}-{3:3}, at: ext4_setattr+0x1bf1/0x2be0 fs/ext4/inode.c:5585

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem){++++}-{3:3}:
       down_write+0x94/0x220 kernel/locking/rwsem.c:1562
       ext4_update_i_disksize fs/ext4/ext4.h:3383 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1402 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1544 [inline]
       ext4_xattr_set_entry+0x309c/0x3a00 fs/ext4/xattr.c:1669
       ext4_xattr_ibody_set+0x131/0x3a0 fs/ext4/xattr.c:2221
       ext4_xattr_set_handle+0x968/0x1510 fs/ext4/xattr.c:2378
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
       __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:662
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       down_write+0x94/0x220 kernel/locking/rwsem.c:1562
       inode_lock include/linux/fs.h:756 [inline]
       ext4_xattr_inode_iget+0x270/0x5d0 fs/ext4/xattr.c:427
       ext4_xattr_inode_get+0x161/0x740 fs/ext4/xattr.c:490
       ext4_xattr_move_to_block fs/ext4/xattr.c:2568 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2669 [inline]
       ext4_expand_extra_isize_ea+0xde7/0x1680 fs/ext4/xattr.c:2761
       __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5957
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6000 [inline]
       __ext4_mark_inode_dirty+0x534/0x940 fs/ext4/inode.c:6078
       ext4_setattr+0x1c6a/0x2be0 fs/ext4/inode.c:5588
       notify_change+0xca7/0x1420 fs/attr.c:482
       do_truncate+0x143/0x200 fs/open.c:65
       handle_truncate fs/namei.c:3216 [inline]
       do_open fs/namei.c:3561 [inline]
       path_openat+0x2157/0x2a50 fs/namei.c:3714
       do_filp_open+0x1ba/0x410 fs/namei.c:3741
       do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0xcd/0x120 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***

5 locks held by syz-executor.2/14465:
 #0: ffff88802aee8460 (sb_writers#4){.+.+}-{0:0}, at: do_open fs/namei.c:3550 [inline]
 #0: ffff88802aee8460 (sb_writers#4){.+.+}-{0:0}, at: path_openat+0x19b3/0x2a50 fs/namei.c:3714
 #1: ffff888080c9f258 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888080c9f258 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:63
 #2: ffff888080c9f3f8 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:801 [inline]
 #2: ffff888080c9f3f8 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_setattr+0x75a/0x2be0 fs/ext4/inode.c:5545
 #3: ffff888080c9f0e0 (&ei->i_data_sem){++++}-{3:3}, at: ext4_setattr+0x1bf1/0x2be0 fs/ext4/inode.c:5585
 #4: ffff888080c9ef20 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #4: ffff888080c9ef20 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5997 [inline]
 #4: ffff888080c9ef20 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4a8/0x940 fs/ext4/inode.c:6078

stack backtrace:
CPU: 0 PID: 14465 Comm: syz-executor.2 Not tainted 6.2.0-rc3-syzkaller-00021-g7dd4b804e080 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
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
 down_write+0x94/0x220 kernel/locking/rwsem.c:1562
 inode_lock include/linux/fs.h:756 [inline]
 ext4_xattr_inode_iget+0x270/0x5d0 fs/ext4/xattr.c:427
 ext4_xattr_inode_get+0x161/0x740 fs/ext4/xattr.c:490
 ext4_xattr_move_to_block fs/ext4/xattr.c:2568 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2669 [inline]
 ext4_expand_extra_isize_ea+0xde7/0x1680 fs/ext4/xattr.c:2761
 __ext4_expand_extra_isize+0x33e/0x470 fs/ext4/inode.c:5957
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6000 [inline]
 __ext4_mark_inode_dirty+0x534/0x940 fs/ext4/inode.c:6078
 ext4_setattr+0x1c6a/0x2be0 fs/ext4/inode.c:5588
 notify_change+0xca7/0x1420 fs/attr.c:482
 do_truncate+0x143/0x200 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x2157/0x2a50 fs/namei.c:3714
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd03008c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd030dfc168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fd0301abf80 RCX: 00007fd03008c0c9
RDX: 0000000000000000 RSI: 0000000000000060 RDI: 0000000020000080
RBP: 00007fd0300e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffbc94e36f R14: 00007fd030dfc300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
