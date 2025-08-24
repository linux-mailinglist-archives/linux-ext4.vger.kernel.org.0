Return-Path: <linux-ext4+bounces-9591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A584B33343
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 01:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95BB37AC66C
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Aug 2025 23:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348A23A995;
	Sun, 24 Aug 2025 23:26:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F06749C
	for <linux-ext4@vger.kernel.org>; Sun, 24 Aug 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756077985; cv=none; b=UVrjst3hqE6LuJJ1i71bCMAGRd6HM/sNx7U1ZB736SsT3wS2Xa9ZhzqQkNPUCQu8CXIvvgeRzRdcpmp43JbgOZxpsZiatSnqLXNeyh+j4LmHk44CWpMUpR2QUzkmlnIuG3ulMuGVXpFfxI25IpcEHMdDuQCgrgrQSZu/5ElpgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756077985; c=relaxed/simple;
	bh=WL/PCzcPczoLHs2rCrK3K1tT69aZSc2pQg8vBvqDU6o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rKSpLHDdx0FYcoAYEOkTGvbVKo3nPBY8PsDb+UriBbwUusYFa/jv35G+h4ctW6frTVzGOqe7T++lwyvTeMjSfN7WczvYwUGeC5cp6m4hrNhWLI0plV/hrTgnZY+1b4HcbMpLFRYbq1KXtTxgmr10KIT96gE0l0MA34NC484A49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88432cebd70so968757639f.0
        for <linux-ext4@vger.kernel.org>; Sun, 24 Aug 2025 16:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756077983; x=1756682783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeASAeQYlpsQ9RhBqwrRbmk9GK1TR2ICTW6KvP1vWzo=;
        b=JdPoowm40mj8DEJDPZ3NMpSyy0ByjRXFUU53ZahIvRHGFFj7SQ2xJd94SOLLVpt3Yi
         riCrFRu1E0TlhmgO0QFJNCrvD4/tW/Rn4bMBfW6Z1+qLUWf8KqL/dnWcFN731GM/wKsZ
         HLyVhV+G5TlxIX6fUW4Q5CHNYh6IADpN9+iCnA1g/jm7XwwHOk7tpqPa8W5HSzGAUwI9
         5Ph2eJv6pzUr9xp24il/rYv+tZPsxxcGXjGmDjEOBtJVyNjO/VPuxXuzM4RbXCqM5N9O
         JCFzO78HGHQlo0JKwLURIjOeh7rDHp/NWgKG1r20FWNjGylLqt13bxjDSPCteN1wdYQc
         aTkg==
X-Forwarded-Encrypted: i=1; AJvYcCUYD6JkzYxUAFdhkCqyknWQ+y/zFZ0cu3B1gFw/9yc0RyWUOLTC4/4UOXIE8T/pTxKYhCu9NQtKBBw/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lqgCW2+5yB8kQtWSZ3Oy10gQig+HemY3203igpR/Y6Ox2hnx
	bWAwlwrQ88+HCEfzznv2nxXCzSgcyWmTx8CUZVvBT5qZMnazxTkkARh597p2V6km8niF8/k6zqr
	3qNzUH1G+jLDHyD6mE6ZPc3yH195J3js6JuF4SxZZPwB5MMyPyUIeTyt8Nh0=
X-Google-Smtp-Source: AGHT+IEBlW9J4d6iOXS6jGvV2mk14Pa8BE5wCJfJ3rrr5SKSd9OraxnJFVpurlfGDMrR5UrWmX6UEcySYod3kykABj5OQV92paL/
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3ec:df8e:6ab5 with SMTP id
 e9e14a558f8ab-3ecdf8e6e90mr20478025ab.20.1756077983241; Sun, 24 Aug 2025
 16:26:23 -0700 (PDT)
Date: Sun, 24 Aug 2025 16:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ab9f9f.050a0220.37038e.0080.GAE@google.com>
Subject: [syzbot] [ext4?] general protection fault in xa_destroy
From: syzbot <syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c330cb607721 Merge tag 'i2c-for-6.17-rc3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115a7a34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=1713b1aa266195b916c2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bb57ae49985b/disk-c330cb60.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bac705cd2981/vmlinux-c330cb60.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9817d12458c5/bzImage-c330cb60.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com

EXT4-fs: no memory for groupinfo slab cache
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 6121 Comm: syz.1.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 fb 3c ed fe cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000ad37700 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: ffffffff8b7c3b57 RCX: 29738ff3f3108600
RDX: 0000000000000000 RSI: ffffffff8b7c3b57 RDI: 0000000000000003
RBP: ffffffff8b786d59 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f47127 R12: 0000000000000000
R13: 0000000000000018 R14: 0000000000000018 R15: 0000000000000001
FS:  00007f0bf6da46c0(0000) GS:ffff888125c1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4414b3ff98 CR3: 0000000078296000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:567
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 xa_destroy+0x59/0x2e0 lib/xarray.c:2390
 ext4_mb_avg_fragment_size_destroy fs/ext4/mballoc.c:3659 [inline]
 ext4_mb_init+0x136a/0x2860 fs/ext4/mballoc.c:3817
 __ext4_fill_super fs/ext4/super.c:5558 [inline]
 ext4_fill_super+0x5253/0x6090 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0bf5f9038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0bf6da3e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0bf6da3ef0 RCX: 00007f0bf5f9038a
RDX: 0000200000000240 RSI: 0000200000000280 RDI: 00007f0bf6da3eb0
RBP: 0000200000000240 R08: 00007f0bf6da3ef0 R09: 0000000000000004
R10: 0000000000000004 R11: 0000000000000246 R12: 0000200000000280
R13: 00007f0bf6da3eb0 R14: 0000000000000236 R15: 0000200000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 fb 3c ed fe cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc9000ad37700 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: ffffffff8b7c3b57 RCX: 29738ff3f3108600
RDX: 0000000000000000 RSI: ffffffff8b7c3b57 RDI: 0000000000000003
RBP: ffffffff8b786d59 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f47127 R12: 0000000000000000
R13: 0000000000000018 R14: 0000000000000018 R15: 0000000000000001
FS:  00007f0bf6da46c0(0000) GS:ffff888125c1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4414b3ff98 CR3: 0000000078296000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	66 0f 1f 00          	nopw   (%rax)
  1c:	48 c1 ef 03          	shr    $0x3,%rdi
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
  2e:	3c 08                	cmp    $0x8,%al
  30:	0f 92 c0             	setb   %al
  33:	e9 fb 3c ed fe       	jmp    0xfeed3d33
  38:	cc                   	int3
  39:	66                   	data16
  3a:	66                   	data16
  3b:	66                   	data16
  3c:	66                   	data16
  3d:	66                   	data16
  3e:	66                   	data16
  3f:	2e                   	cs


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

