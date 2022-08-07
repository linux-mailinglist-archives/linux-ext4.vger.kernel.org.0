Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8BD58BAEB
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Aug 2022 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiHGNId (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Aug 2022 09:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiHGNIa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Aug 2022 09:08:30 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5CF6326
        for <linux-ext4@vger.kernel.org>; Sun,  7 Aug 2022 06:08:25 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g22-20020a056602249600b0067caba4f24bso3502338ioe.4
        for <linux-ext4@vger.kernel.org>; Sun, 07 Aug 2022 06:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=vnV7cRg3Tne8wd1q+sHQ0TMC7i9eytqxDhJim1J4PTk=;
        b=qAi01wczPWCNnZwX+uNwxYCd2xb9rggjSluK5T13ncLvgyh+oa2g1ZD3GemAAVaHSr
         DSplyFLP9qW9uDh9bHMbtDrlJevR5rokXJtUuWKmEvxLS8WH0CRaY+a9EoUoFqn+ztp8
         dGed6+WVMpPZBhHfeuUgDX1bh4tt1kPWKphJsg9RK+MkRb5ZKuKVzyfgeErp85yHaWq/
         AkwxzLhgt4BwdKjm5tCdQvPcjSe2bgV1N+dJ4diexAW7K5LKiXqNax+BgBaV/JObYqew
         NndLDbKbjlacmF10DQsnIYDC2otDKk240cgiTso9lrdS157eDK2xkYfrHx5FtPXEETXV
         qrAw==
X-Gm-Message-State: ACgBeo1I/RENmq135xz2/OExiGlZU8+Al3SKjiwAE70NpPP6fIMgfLA7
        bh6wC6sOeU2vdTdJkV2rHbrDPxD9S/t+pqDJyyTGxRmB3XCT
X-Google-Smtp-Source: AA6agR6whLfcV4UNv9AyPfLUwXg8drboA+u/W1C+Ck6IN9btxeb1lHo5HZoxcp8lDr2MnbD/siGrvT+zeI+92sxDdRM/szahmWZE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1694:b0:342:f3b4:1518 with SMTP id
 f20-20020a056638169400b00342f3b41518mr1186838jat.0.1659877705062; Sun, 07 Aug
 2022 06:08:25 -0700 (PDT)
Date:   Sun, 07 Aug 2022 06:08:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb20b605e5a66457@google.com>
Subject: [syzbot] possible deadlock in ext4_xattr_get
From:   syzbot <syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com>
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

HEAD commit:    cb71b93c2dc3 Add linux-next specific files for 20220628
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bdcf3c080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
dashboard link: https://syzkaller.appspot.com/bug?extid=62120febbd1ee3c3c860
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10256c61080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f3c832080000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12420fe2080000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11420fe2080000
console output: https://syzkaller.appspot.com/x/log.txt?x=16420fe2080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
5.19.0-rc4-next-20220628-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor246/3601 is trying to acquire lock:
ffff888075af28e8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_get+0x14e/0xa10 fs/ext4/xattr.c:650

but task is already holding lock:
ffff888075af2c20 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
ffff888075af2c20 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: chown_common+0x364/0x710 fs/open.c:727

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}:
       down_write+0x90/0x150 kernel/locking/rwsem.c:1542
       inode_lock include/linux/fs.h:761 [inline]
       ext4_xattr_inode_create fs/ext4/xattr.c:1445 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1528 [inline]
       ext4_xattr_set_entry+0x2ab3/0x3850 fs/ext4/xattr.c:1656
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
       __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:642
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5665 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
       down_read+0x98/0x440 kernel/locking/rwsem.c:1489
       ext4_xattr_get+0x14e/0xa10 fs/ext4/xattr.c:650
       __vfs_getxattr+0xd9/0x140 fs/xattr.c:401
       cap_inode_need_killpriv+0x3c/0x60 security/commoncap.c:301
       security_inode_need_killpriv+0x40/0x90 security/security.c:1420
       notify_change+0x6e7/0x1440 fs/attr.c:351
       chown_common+0x61b/0x710 fs/open.c:734
       do_fchownat+0x126/0x1e0 fs/open.c:765
       __do_sys_fchownat fs/open.c:780 [inline]
       __se_sys_fchownat fs/open.c:777 [inline]
       __x64_sys_fchownat+0xba/0x150 fs/open.c:777
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x46/0xb0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ea_inode->i_rwsem#9/1);
                               lock(&ei->xattr_sem);
                               lock(&ea_inode->i_rwsem#9/1);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

2 locks held by syz-executor246/3601:
 #0: ffff88801d65e460 (sb_writers#4){.+.+}-{0:0}, at: do_fchownat+0x101/0x1e0 fs/open.c:762
 #1: ffff888075af2c20 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:761 [inline]
 #1: ffff888075af2c20 (&ea_inode->i_rwsem#9/1){+.+.}-{3:3}, at: chown_common+0x364/0x710 fs/open.c:727

stack backtrace:
CPU: 0 PID: 3601 Comm: syz-executor246 Not tainted 5.19.0-rc4-next-20220628-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
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
 down_read+0x98/0x440 kernel/locking/rwsem.c:1489
 ext4_xattr_get+0x14e/0xa10 fs/ext4/xattr.c:650
 __vfs_getxattr+0xd9/0x140 fs/xattr.c:401
 cap_inode_need_killpriv+0x3c/0x60 security/commoncap.c:301
 security_inode_need_killpriv+0x40/0x90 security/security.c:1420
 notify_change+0x6e7/0x1440 fs/attr.c:351
 chown_common+0x61b/0x710 fs/open.c:734
 do_fchownat+0x126/0x1e0 fs/open.c:765
 __do_sys_fchownat fs/open.c:780 [inline]
 __se_sys_fchownat fs/open.c:777 [inline]
 __x64_sys_fchownat+0xba/0x150 fs/open.c:777
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7ff813f7d0e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc815d6a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
