Return-Path: <linux-ext4+bounces-4366-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1B6988E45
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Sep 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E03C281E90
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Sep 2024 07:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443119DFA2;
	Sat, 28 Sep 2024 07:43:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7819DF64
	for <linux-ext4@vger.kernel.org>; Sat, 28 Sep 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727509410; cv=none; b=LviqANfFT9G9MYYodh0+4JoYdJmWJAvU8M5R0xkcGjw/S/D6r2SnWEbl2LTpKrQOSCGO+aA076S1hKCjQqIoYtw0AJl6pon30nWHOOUYlGnDG9qW7c//qJeza/eZw2MchqWGpl9Wszqv96YiwpzKNNAvpJoF1my+1cpY/HfK0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727509410; c=relaxed/simple;
	bh=Tkb88qVKUeBdJ42G5bZlcBOL2evQ60bmKznik7IOpmw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X+caNjiKDXZaHSVZ2s20R3DA4s/9xHWktnpObn5zRpIbM9Qe8vkAZ2OE4oTRIiyXpP7X2DCTdmM1tffAHM+VXynlqv3VLaS5izUGJgMHSiZRuB0qhMTJk2nc234e8mS2JRh1TmvCYBWIS6N05VqXfUsp8J7keXjyS7sZhQxwbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3496b480dso14170335ab.2
        for <linux-ext4@vger.kernel.org>; Sat, 28 Sep 2024 00:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727509408; x=1728114208;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG+T+iEHIkMxk78v6Kd9mBWnMS1ZVclr8awfuHMXyDo=;
        b=COvdWznWHbTBnQlgtds1QDybz3n7YHMXmjafmmKk1onRScXCQNhofeOr+s+XQlyy6K
         Ek4R3YHcqsmVOj+4Dj7MTBxmTSI/bAyVMQHcLseBC5Iy0+wAczoOE6+0bIu4pcwV6wL7
         qhBYim4emhdKlZUql+nVHcsb68daZwxdMleE393/SOXZKJ3EPvlpKoSL9IyyWEnP1/6y
         4OEwCtKkCPgDGWalHkQC9/KpfMoOjmZAKenjgWaCnOnO3aBJs4K6R3e6Hdk4fTbbO3Pg
         JVCsE52SWysEWrGSVt6ocJM8XtgB5yl9Tx+J4bVr/v49UcmnPYaswd1VIHprOPMcSRSz
         PI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDtqgNErssG3qZOybNSAShdy5TuqPM+1eUey7CnRHi44CB48muqIAbXMMFKeGnLwD53l7LXV4c6+Wz@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAwvJxGKy8QMh+nRtxMrNT0y1HwOejGgtDw/nr0JqlLDCjK8+
	muvE4irsXBfc0k4R14W6CGJSI6JAregtysAo/brTJtOiCr/b5cz8NyFcPa/+vaoLErIPLgh12uK
	xdJeh+/IcO0kuS3MDHTHj6Dy1s+M9fKD4Jw+mgTDgWx8RaBbZx0twiQI=
X-Google-Smtp-Source: AGHT+IFM1YWvUWRHXQWqE/Aadyx9q2Mwl55+UhMiIQs002s9HIo9pMzVcizKzN+EyQgJLG9zGOzbZLHfKBn/QzOiFDkCvBtLvZ8C
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0c:0:b0:3a3:35f0:4c0c with SMTP id
 e9e14a558f8ab-3a3451b070dmr41985425ab.18.1727509407940; Sat, 28 Sep 2024
 00:43:27 -0700 (PDT)
Date: Sat, 28 Sep 2024 00:43:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7b39f.050a0220.46d20.0037.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_lookup_create
From: syzbot <syzbot+d91a6e2efb07bd3354e9@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jun.nie@linaro.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b7275670032 Add linux-next specific files for 20240925
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fdd627980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=441f6022e7a2db73
dashboard link: https://syzkaller.appspot.com/bug?extid=d91a6e2efb07bd3354e9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1771ca80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e0907980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de8e955e430e/disk-2b727567.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cdc30f0c4010/vmlinux-2b727567.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bce68c83e37/bzImage-2b727567.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b35179829fb5/mount_0.gz

The issue was bisected to:

commit 1e9d62d252812575ded7c620d8fc67c32ff06c16
Author: Jun Nie <jun.nie@linaro.org>
Date:   Tue Jan 3 01:45:16 2023 +0000

    ext4: optimize ea_inode block expansion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14edcaa9980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16edcaa9980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12edcaa9980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d91a6e2efb07bd3354e9@syzkaller.appspotmail.com
Fixes: 1e9d62d25281 ("ext4: optimize ea_inode block expansion")

EXT4-fs: Ignoring removed nomblk_io_submit option
======================================================
WARNING: possible circular locking dependency detected
6.11.0-next-20240925-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor177/5387 is trying to acquire lock:
ffff888071dd97c8 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
ffff888071dd97c8 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_create fs/ext4/xattr.c:1514 [inline]
ffff888071dd97c8 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_lookup_create+0x1a31/0x1f20 fs/ext4/xattr.c:1596

but task is already holding lock:
ffff888071ddc7e0 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4180

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem/3){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ext4_update_i_disksize fs/ext4/ext4.h:3398 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1452 [inline]
       ext4_xattr_inode_lookup_create+0x16b8/0x1f20 fs/ext4/xattr.c:1602
       ext4_xattr_ibody_set+0x214/0x730 fs/ext4/xattr.c:2269
       ext4_xattr_set_handle+0xba6/0x1580 fs/ext4/xattr.c:2446
       ext4_xattr_set+0x241/0x3d0 fs/ext4/xattr.c:2560
       __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
       vfs_setxattr+0x221/0x430 fs/xattr.c:321
       do_setxattr fs/xattr.c:629 [inline]
       path_setxattr+0x37e/0x4d0 fs/xattr.c:658
       __do_sys_setxattr fs/xattr.c:676 [inline]
       __se_sys_setxattr fs/xattr.c:672 [inline]
       __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:672
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       inode_lock include/linux/fs.h:815 [inline]
       ext4_xattr_inode_create fs/ext4/xattr.c:1514 [inline]
       ext4_xattr_inode_lookup_create+0x1a31/0x1f20 fs/ext4/xattr.c:1596
       ext4_xattr_block_set+0x274/0x3980 fs/ext4/xattr.c:1916
       ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
       ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2836
       __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5831
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5874 [inline]
       __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5952
       ext4_ext_truncate+0x9f/0x2b0 fs/ext4/extents.c:4457
       ext4_truncate+0xa1b/0x11c0 fs/ext4/inode.c:4185
       ext4_evict_inode+0x90f/0xf50 fs/ext4/inode.c:263
       evict+0x4e8/0x9b0 fs/inode.c:806
       __dentry_kill+0x20d/0x630 fs/dcache.c:615
       dput+0x19f/0x2b0 fs/dcache.c:857
       do_renameat2+0xda1/0x13f0 fs/namei.c:5181
       __do_sys_renameat2 fs/namei.c:5213 [inline]
       __se_sys_renameat2 fs/namei.c:5210 [inline]
       __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5210
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/3);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem/3);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***

7 locks held by syz-executor177/5387:
 #0: ffff88802da0e420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88802da0e730 (&type->s_vfs_rename_key){+.+.}-{3:3}, at: lock_rename fs/namei.c:3165 [inline]
 #1: ffff88802da0e730 (&type->s_vfs_rename_key){+.+.}-{3:3}, at: do_renameat2+0x5cf/0x13f0 fs/namei.c:5114
 #2: ffff88807755f0f0 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #2: ffff88807755f0f0 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: lock_two_directories+0x145/0x220 fs/namei.c:3131
 #3: ffff888071dd83f8 (&type->i_mutex_dir_key#3/5){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #3: ffff888071dd83f8 (&type->i_mutex_dir_key#3/5){+.+.}-{3:3}, at: lock_two_directories+0x16f/0x220 fs/namei.c:3132
 #4: ffff88802da0e610 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1721 [inline]
 #4: ffff88802da0e610 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1904 [inline]
 #4: ffff88802da0e610 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x2f4/0xf50 fs/ext4/inode.c:217
 #5: ffff888071ddc7e0 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_truncate+0x994/0x11c0 fs/ext4/inode.c:4180
 #6: ffff888071ddc620 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:161 [inline]
 #6: ffff888071ddc620 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5871 [inline]
 #6: ffff888071ddc620 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x491/0x880 fs/ext4/inode.c:5952

stack backtrace:
CPU: 0 UID: 0 PID: 5387 Comm: syz-executor177 Not tainted 6.11.0-next-20240925-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 down_write+0x99/0x220 kernel/locking/rwsem.c:1577
 inode_lock include/linux/fs.h:815 [inline]
 ext4_xattr_inode_create fs/ext4/xattr.c:1514 [inline]
 ext4_xattr_inode_lookup_create+0x1a31/0x1f20 fs/ext4/xattr.c:1596
 ext4_xattr_block_set+0x274/0x3980 fs/ext4/xattr.c:1916
 ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
 ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2836
 __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5831
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5874 [inline]
 __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5952
 ext4_ext_truncate+0x9f/0x2b0 fs/ext4/extents.c:4457
 ext4_truncate+0xa1b/0x11c0 fs/ext4/inode.c:4185
 ext4_evict_inode+0x90f/0xf50 fs/ext4/inode.c:263
 evict+0x4e8/0x9b0 fs/inode.c:806
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 dput+0x19f/0x2b0 fs/dcache.c:857
 do_renameat2+0xda1/0x13f0 fs/namei.c:5181
 __do_sys_renameat2 fs/namei.c:5213 [inline]
 __se_sys_renameat2 fs/namei.c:5210 [inline]
 __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5210
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9326d33469
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdce15cbc8 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007f9326d7c0a0 RCX: 00007f9326d33469
RDX: 0000000000000005 RSI: 0000000020000080 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffdce15cc00
R10: 00000000200000c0 R11: 0000000000000246 R12: 00007ffdce15cbec
R13: 0000000000000031 R14: 431bde82d7b634db R15: 00007ffdce15cc20
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

