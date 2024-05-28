Return-Path: <linux-ext4+bounces-2667-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8358D203E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827882833F9
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACA16FF5E;
	Tue, 28 May 2024 15:21:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE31E867
	for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909691; cv=none; b=TEE4qwwReoccR2DN6JZMmJEkEmeRt4aEvjBUobbNnWtVe084Fo+tknhfEzghRAxSsnFE+8k9vczv98sSEH09vOQFnMQCyeOXWueawx7lGIwyN6LKAQd7/JNs3eLog2Rnjn6qfW63yF9j+km1WvLQz0oOs5i9527ycQGzM0HGoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909691; c=relaxed/simple;
	bh=WYZbV5xFlgZu35mIgZNZ76WWInEpSuEwmzAH/IAInqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GuJ6Gh4AJCeZ76dkzK8CdyU21tTGVQdNdLPf9Cu+FkdSxweQ7gWq7874ApgZvEQ0nBJkxHHhHopbq+dz0DF0f0uGZZYEkhbzsU8kuH39GelqwZxIxxZGqeFteR1ESgh4YtHVfYLG954sW0crkI7ReM3LmCgGPLJ67D6xfV/s2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3737b3c496fso8929005ab.2
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 08:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909689; x=1717514489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjY1aJxK2mtu2f2Xg7tUdSsfdTT1/DMe99R4SshjrJc=;
        b=P+zNv3duzukatDcUkKVWycI2NH0xGPL/I48jA6IF94+yM2eX7zlN0SupE1iYIet+88
         7NcMO7XvU/WMXYfxymfFmJUAnAk3/alX7lJYnASzrGLxyFSDcIzufRtENSaIWVG3VKPh
         t97/I/LzFKe8g87/NGqRmkKhu55/aqKhuGWU6c3lNGdiInCFYb7yPFq3rvocwxoLMV1f
         m/vZRKR+gCXg9gXsxzfoB7yeQeAlHh7arWuawSZ/f5EKCyunZnZzt+VEYlDSYRxcZNQs
         XB3VsL3/af/kdzu2qagGYl8CF6iAsGEfhttElCkr3RShP4COY5r065udzhi5LaL6ydoe
         VKnA==
X-Forwarded-Encrypted: i=1; AJvYcCVwzbtYeUcTqn9XWi5Jle1mVZFTHGhezNoWrk9v3nQs5AYKaem+fk9G4i/vLD1BHB8zNfsJGuya38OOLL2gd9pbRHsFSpSiiFoF2A==
X-Gm-Message-State: AOJu0YxOLQ6u/iCkoQYAukcVZMuuWThH52QJOg5YbYPi47zNch8K25DV
	PSgkPLS0cbHRzg0X4F/WvjLBYYtnRcBeB2IvotGUcRenzGWF5t1xg+l8FVJdiugM3q8fz9UFVMb
	Sl9TeF4UK8TFuVEZCEDDaquOukKyeOsI3NbAnn/xWwLZnBcQp0J7hG/g=
X-Google-Smtp-Source: AGHT+IFb1g813XOjK0j1uTTp5Ujavf28B1qezT9f4QoHBDWV+bKl5HXoiX8KE2o4hVy5QUNJunMIrJchYiZ1wBBIpyJfvvky/zP/
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c743:0:b0:373:874e:93be with SMTP id
 e9e14a558f8ab-373874e977emr4475755ab.3.1716909689728; Tue, 28 May 2024
 08:21:29 -0700 (PDT)
Date: Tue, 28 May 2024 08:21:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b03350619853096@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_xattr_inode_lookup_create
From: syzbot <syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=120d27a4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138da210980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1053d8fc980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02867060d65d/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bb75fbf6fb1/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd38cadddf33/bzImage-8f6a15f0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e24b09069472/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=178e5ca4980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=144e5ca4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=104e5ca4980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe42a669c87e4a980051@syzkaller.appspotmail.com

EXT4-fs warning (device loop0): ext4_xattr_inode_create:1471: refuse to create EA inode when umounting
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5082 at fs/ext4/xattr.c:1472 ext4_xattr_inode_create fs/ext4/xattr.c:1472 [inline]
WARNING: CPU: 0 PID: 5082 at fs/ext4/xattr.c:1472 ext4_xattr_inode_lookup_create+0xc38/0x1ea0 fs/ext4/xattr.c:1590
Modules linked in:
CPU: 0 PID: 5082 Comm: syz-executor226 Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:ext4_xattr_inode_create fs/ext4/xattr.c:1472 [inline]
RIP: 0010:ext4_xattr_inode_lookup_create+0xc38/0x1ea0 fs/ext4/xattr.c:1590
Code: 18 e9 b4 03 00 00 4d 89 e5 e8 24 5d 2c ff 4c 89 ff 48 c7 c6 28 a4 b8 8d ba bf 05 00 00 48 c7 c1 40 a1 df 8b e8 39 15 fc ff 90 <0f> 0b 90 49 c7 c4 ea ff ff ff 4c 8b 74 24 68 4c 8b 7c 24 18 e9 96
RSP: 0018:ffffc900034a7120 EFLAGS: 00010246
RAX: 347f6253c1206700 RBX: 0000000000000000 RCX: 347f6253c1206700
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900034a72f0 R08: ffffffff8176a12c R09: 1ffff92000694d9c
R10: dffffc0000000000 R11: fffff52000694d9d R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffc900034a7230 R15: ffff888023e3c000
FS:  0000555564020380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555640296f8 CR3: 0000000078050000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_xattr_block_set+0x277/0x3880 fs/ext4/xattr.c:1910
 ext4_xattr_move_to_block fs/ext4/xattr.c:2663 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2738 [inline]
 ext4_expand_extra_isize_ea+0x12d7/0x1cf0 fs/ext4/xattr.c:2830
 __ext4_expand_extra_isize+0x2fb/0x3e0 fs/ext4/inode.c:5782
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5825 [inline]
 __ext4_mark_inode_dirty+0x524/0x880 fs/ext4/inode.c:5903
 ext4_dirty_inode+0xce/0x110 fs/ext4/inode.c:5935
 __mark_inode_dirty+0x325/0xe20 fs/fs-writeback.c:2486
 mark_inode_dirty_sync include/linux/fs.h:2421 [inline]
 iput+0x1fe/0x930 fs/inode.c:1764
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1538
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1555
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
 kill_block_super+0x44/0x90 fs/super.c:1676
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7319
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2404
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x273/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f15671fa587
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffeafe5a078 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f15671fa587
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffeafe5a130
RBP: 00007ffeafe5a130 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffeafe5b1a0
R13: 00005555640216c0 R14: 431bde82d7b634db R15: 00007ffeafe5b1c0
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

