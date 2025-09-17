Return-Path: <linux-ext4+bounces-10231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9477B7E1A2
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4D93B08D0
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11F30CB28;
	Wed, 17 Sep 2025 12:40:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8786A1EBA07
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112832; cv=none; b=HaSQw4LJjn7+TbWk1LQ/eAgKxJZVVEcq5rhXC/vR6VynxRbEbZCswvtqttx0DzNYtcT3j3fEDFgm87i603caD7dIkCL+z2gVhEoeR3HzzO1alMoo3Xb7MbSZuoj1olm7i3dWcwfSiXtLoRzGxSrPRrr1NPMDt7uiusDZJS3/sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112832; c=relaxed/simple;
	bh=gJS6ru81vZ5rYgVxqEYtHD6rzC3kO+J2wVr/aaQuIOE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CNHev5+f3cx8cQpDS4To1+Odl8YcCAkuFzTiH7MnUThifXOJT6gDuRcRQlbyaYSECksAvBFuevWTdmM+GoZvc2dPlwOGSShS9RhX2fE9AifBVdFALNqgfb0Bgn/8JVZJ4O6in8bxTIrLOjLo5lJrvP2Ki6pkOMrb9HaeVv4460U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-411db730dcaso215202725ab.0
        for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 05:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112829; x=1758717629;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQcA3Zhoofert7ZxLPjYSX1OcdzvMpvdJJzpRym2tHE=;
        b=OTWN446vovDDF4PbCJ9M7zmwRGZrtn8QHj1tjXP8Y+HTtE2ZNSlqx7sEIQ74bzNTxr
         nQeugVU9BWh9yWcHxo8ptG9Llt73zILC6CboTb6ER0ft0RQ93SUapJWCno5cBcfoOV95
         p6V/soWufjB6HRLzuwuMRa2Mmf8ZhxyNGcGbvUqZJGQjSj7wGAFIAmNp7PH8xqhikzDP
         dqD/K8CPHFaPp40Eh0jTqEFmtNTsN3pheNzu+W9k5GKY5VIytO/F8XoN7er0qS8C8GzR
         3yUxZ5jaTJxUZx1f2GTqHSr/pCp1YnbjS8/bTWVcnM8w/WSWTMdbhQG+8q6BrD5JGxFE
         TAqA==
X-Forwarded-Encrypted: i=1; AJvYcCUX8eOWHvrYSXT6DRONN822Cll/Ggl8grcjBqsFsqSulrWiVG8/Kx4UosHDiuefiYKl+dx+v9LH8Xin@vger.kernel.org
X-Gm-Message-State: AOJu0YxecOMTrHAcL5Psn2JmE5M4OCqzfpqG1TxGdo5G+6JwJTXKLJGa
	2QOj0AG975XhotvH71DafxVssFC2SGveAn5r8kUXxav8487t3X8HMLLTk/2UL2n2rPprFddaraS
	3bRJUu5scIGrVc/U1qk86onHXdpLQYZiDXsHq59MqtvqfEi3GCAR0Qey1Tbs=
X-Google-Smtp-Source: AGHT+IE6qa82aCxx1r7zZNmiCrY5xeCTFR7ZJTdfavF9GOCbpzXElzMwZ0LTxt4rikr26hm3NfEkN4wINeIsJl/ihdkSbBn4hp37
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:424:47e:c27 with SMTP id
 e9e14a558f8ab-4241a4df3e8mr28688105ab.10.1758112829608; Wed, 17 Sep 2025
 05:40:29 -0700 (PDT)
Date: Wed, 17 Sep 2025 05:40:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68caac3d.050a0220.2ff435.055e.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: trying to register non-static key in ext4_xattr_get
From: syzbot <syzbot+3028e4abe404f87a385f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f20375f5b7 Merge tag 'pci-v6.17-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fd5934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=3028e4abe404f87a385f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c68f77b43077/disk-22f20375.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ef15b7a075a/vmlinux-22f20375.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c341517a203/bzImage-22f20375.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3028e4abe404f87a385f@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 UID: 0 PID: 13193 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
 register_lock_class+0x105/0x320 kernel/locking/lockdep.c:1299
 __lock_acquire+0x99/0xd20 kernel/locking/lockdep.c:5112
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:170
 __rwbase_read_lock+0xa1/0x180 kernel/locking/rwbase_rt.c:76
 rwbase_read_lock kernel/locking/rwbase_rt.c:147 [inline]
 __down_read kernel/locking/rwsem.c:1466 [inline]
 down_read+0x127/0x1f0 kernel/locking/rwsem.c:1539
 ext4_xattr_get+0x10a/0x6a0 fs/ext4/xattr.c:704
 __vfs_getxattr+0x3f1/0x430 fs/xattr.c:423
 smk_fetch+0xb4/0x140 security/smack/smack_lsm.c:289
 smack_d_instantiate+0x6f5/0x940 security/smack/smack_lsm.c:3606
 security_d_instantiate+0x10a/0x200 security/security.c:4109
 d_splice_alias_ops+0x71/0x370 fs/dcache.c:2998
 ext4_lookup+0x2b9/0x6c0 fs/ext4/namei.c:1814
 __lookup_slow+0x29d/0x3d0 fs/namei.c:1808
 lookup_slow+0x53/0x70 fs/namei.c:1825
 walk_component+0x2d2/0x400 fs/namei.c:2129
 lookup_last fs/namei.c:2630 [inline]
 path_lookupat+0x163/0x430 fs/namei.c:2654
 filename_lookup+0x212/0x570 fs/namei.c:2683
 user_path_at+0x3a/0x60 fs/namei.c:3127
 ksys_umount fs/namespace.c:2112 [inline]
 __do_sys_umount fs/namespace.c:2120 [inline]
 __se_sys_umount fs/namespace.c:2118 [inline]
 __x64_sys_umount+0xee/0x160 fs/namespace.c:2118
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa56aa0fed7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcf1d8f548 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa56aa0fed7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcf1d8f600
RBP: 00007ffcf1d8f600 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcf1d906f0
R13: 00007fa56aa91c05 R14: 000055558570a4a8 R15: 00007ffcf1d917c0
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a000000b: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xdead4ead00000058-0xdead4ead0000005f]
CPU: 1 UID: 0 PID: 13193 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:rt_mutex_top_waiter kernel/locking/rtmutex_common.h:138 [inline]
RIP: 0010:task_blocks_on_rt_mutex kernel/locking/rtmutex.c:1240 [inline]
RIP: 0010:__rt_mutex_slowlock kernel/locking/rtmutex.c:1719 [inline]
RIP: 0010:__rt_mutex_slowlock_locked+0xb61/0x25e0 kernel/locking/rtmutex.c:1760
Code: ff ff ff ff e8 70 30 5b 09 85 c0 0f 84 45 04 00 00 48 85 db 0f 84 49 04 00 00 48 89 5c 24 48 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 10 f6 81 00 48 8b 44 24 10 48 39
RSP: 0018:ffffc9000413f2a0 EFLAGS: 00010802
RAX: 1bd5a9d5a000000b RBX: dead4ead00000058 RCX: 0000000000000078
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff88802f9559ac
RBP: ffffc9000413f490 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000827e44 R12: ffff88802f957060
R13: ffff88802f955958 R14: 00000000fffffffe R15: dffffc0000000000
FS:  000055558570a500(0000) GS:ffff8881269bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcf1d8dca8 CR3: 00000000537e4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rwbase_read_lock+0xbc/0x180 kernel/locking/rwbase_rt.c:114
 rwbase_read_lock kernel/locking/rwbase_rt.c:147 [inline]
 __down_read kernel/locking/rwsem.c:1466 [inline]
 down_read+0x127/0x1f0 kernel/locking/rwsem.c:1539
 ext4_xattr_get+0x10a/0x6a0 fs/ext4/xattr.c:704
 __vfs_getxattr+0x3f1/0x430 fs/xattr.c:423
 smk_fetch+0xb4/0x140 security/smack/smack_lsm.c:289
 smack_d_instantiate+0x6f5/0x940 security/smack/smack_lsm.c:3606
 security_d_instantiate+0x10a/0x200 security/security.c:4109
 d_splice_alias_ops+0x71/0x370 fs/dcache.c:2998
 ext4_lookup+0x2b9/0x6c0 fs/ext4/namei.c:1814
 __lookup_slow+0x29d/0x3d0 fs/namei.c:1808
 lookup_slow+0x53/0x70 fs/namei.c:1825
 walk_component+0x2d2/0x400 fs/namei.c:2129
 lookup_last fs/namei.c:2630 [inline]
 path_lookupat+0x163/0x430 fs/namei.c:2654
 filename_lookup+0x212/0x570 fs/namei.c:2683
 user_path_at+0x3a/0x60 fs/namei.c:3127
 ksys_umount fs/namespace.c:2112 [inline]
 __do_sys_umount fs/namespace.c:2120 [inline]
 __se_sys_umount fs/namespace.c:2118 [inline]
 __x64_sys_umount+0xee/0x160 fs/namespace.c:2118
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa56aa0fed7
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcf1d8f548 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa56aa0fed7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcf1d8f600
RBP: 00007ffcf1d8f600 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcf1d906f0
R13: 00007fa56aa91c05 R14: 000055558570a4a8 R15: 00007ffcf1d917c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rt_mutex_top_waiter kernel/locking/rtmutex_common.h:138 [inline]
RIP: 0010:task_blocks_on_rt_mutex kernel/locking/rtmutex.c:1240 [inline]
RIP: 0010:__rt_mutex_slowlock kernel/locking/rtmutex.c:1719 [inline]
RIP: 0010:__rt_mutex_slowlock_locked+0xb61/0x25e0 kernel/locking/rtmutex.c:1760
Code: ff ff ff ff e8 70 30 5b 09 85 c0 0f 84 45 04 00 00 48 85 db 0f 84 49 04 00 00 48 89 5c 24 48 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 10 f6 81 00 48 8b 44 24 10 48 39
RSP: 0018:ffffc9000413f2a0 EFLAGS: 00010802
RAX: 1bd5a9d5a000000b RBX: dead4ead00000058 RCX: 0000000000000078
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff88802f9559ac
RBP: ffffc9000413f490 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000827e44 R12: ffff88802f957060
R13: ffff88802f955958 R14: 00000000fffffffe R15: dffffc0000000000
FS:  000055558570a500(0000) GS:ffff8881269bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcf1d8dca8 CR3: 00000000537e4000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	e8 70 30 5b 09       	call   0x95b3075
   5:	85 c0                	test   %eax,%eax
   7:	0f 84 45 04 00 00    	je     0x452
   d:	48 85 db             	test   %rbx,%rbx
  10:	0f 84 49 04 00 00    	je     0x45f
  16:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
  1b:	48 83 c3 58          	add    $0x58,%rbx
  1f:	48 89 d8             	mov    %rbx,%rax
  22:	48 c1 e8 03          	shr    $0x3,%rax
* 26:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2b:	74 08                	je     0x35
  2d:	48 89 df             	mov    %rbx,%rdi
  30:	e8 10 f6 81 00       	call   0x81f645
  35:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  3a:	48                   	rex.W
  3b:	39                   	.byte 0x39


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

