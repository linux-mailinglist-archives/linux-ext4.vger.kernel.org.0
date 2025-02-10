Return-Path: <linux-ext4+bounces-6401-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C718A2F496
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 18:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B781162FE3
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E630E256C98;
	Mon, 10 Feb 2025 17:04:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3781F462E
	for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207063; cv=none; b=HZewAZQNXZaUOD6kSqUIrsPRYkLSxT5+KK9/YLzswir54FmS3RtIpsOY89QrAUXsx4KRUzmlAynIQWIB2WAb1avrM5Ju+YkMlMHSA+2smmohVVy5GXPs4G0b5LHlIouJvcveJX+UmMExwyB6UMefZjDBdRbaw1w6tfm3DzQ0Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207063; c=relaxed/simple;
	bh=ayDh2XGkK8pdTTCHt3YthG9+gbxnM+ZS2XGaCXOhg60=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iEJCxUjaXD4SPMg+CsTaWFGgMtxWlWSwgj2JmyBEy4j0B8p3H3RW3LHgXdyoSkrJm2tuCeUE0b4JeJy5QHQPVr+EZJPM7IA5Lf6bCh1Ud2fkNZCS6x5SjdJAP1Y3vgVog6MLAG760sGOZlNOeKQ4kRnsma5u9d3ZkVN+o82BmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cf64584097so35665845ab.2
        for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 09:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739207061; x=1739811861;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GT+g3UbstXLhzNW5rP1Aqw38eFbZ1w5rUxR73G8bj1I=;
        b=wCPkCeYMP8COPXo4bQ4Ylj7UYkoCrqRG9v/60b23kg1d7bDI9hsXRFG1coq7623LWm
         0/Y4c7QGhgRaCiK78VUsRwu6awT9lFIQea+VtmlM4+ovMBBB212CUCcIXOXVmAu32aQB
         0EgxGFfjrR2AE0jtIJWRUaA6QyjphB2ydPvEOCKvtmRoJbNd7+WGV37Z1J/VVaiKF6ow
         5EI2+/jI/jV+/cKCXciqRr0TTdiCHc5fw0C4h555QWzhZs6x8c6DF1HD6f02DVFA6+pS
         ushna5xIevIklz74saS58qq7m2glYlVU8Yt4AUHbnNbGAoR3+kI8Bto+5Tb78LAbQVmq
         lkXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqgeVhHqyKrUZL4Ts5K3TFQuP7zW1UC072goIh2j4Fa3puENlWb/piwrQcjrSbp1TUHmoBfzc3sb4z@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZRopn7JuIJhDvdhPMOzL+z1T3Ie9Zasfn6IBx5TGrs6Xn9YD
	0uokIDNIwvlUu2WJh9cdKehDAUS4QmFPA9wnojDs77ogY4njJYg+Tmm3sYL3DJujcNWDmifQ3JJ
	i2ymomi9kwsX4nm5drFCae4BzrOLxh6JMoCjgCpSozOHHsJWUH82QlS4=
X-Google-Smtp-Source: AGHT+IGUE2boMaoqj5trTNkX7hMjoHNOU6Pk4rn16Ze27x+v3ITQ77e8y+sWklE/WTqYaPgxnCBmZZgqjLv6NCu0AdJpxf/SNYlU
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0e:b0:3cf:cac9:b02d with SMTP id
 e9e14a558f8ab-3d13dd609b2mr111016245ab.8.1739207060742; Mon, 10 Feb 2025
 09:04:20 -0800 (PST)
Date: Mon, 10 Feb 2025 09:04:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aa3194.050a0220.3d72c.0054.GAE@google.com>
Subject: [syzbot] [ext4?] [net?] general protection fault in __dev_set_rx_mode
From: syzbot <syzbot+b0e409c0b9976e4b3923@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162e5318580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
dashboard link: https://syzkaller.appspot.com/bug?extid=b0e409c0b9976e4b3923
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149d41b0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-92514ef2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4d8b91f8769/vmlinux-92514ef2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c24ec4365966/bzImage-92514ef2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2fed19de440d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0e409c0b9976e4b3923@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xffec282c2c2c2c34: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xff616161616161a0-0xff616161616161a7]
CPU: 0 UID: 0 PID: 30 Comm: kworker/u4:2 Not tainted 6.14.0-rc1-syzkaller-00034-g92514ef226f5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:__dev_set_rx_mode+0x1c2/0x280 net/core/dev.c:9092
Code: 8b 04 24 42 0f b6 04 20 84 c0 48 8b 5c 24 08 0f 85 b3 00 00 00 40 88 2b eb 05 e8 e9 78 00 f8 49 83 c6 40 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 3f 11 67 f8 49 8b 2e 48 85 ed 74
RSP: 0018:ffffc900005177e0 EFLAGS: 00010a02
RAX: 1fec2c2c2c2c2c34 RBX: ffff888042c70410 RCX: ffff888030eca440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff89bee4d6 R09: 1ffff1100858e015
R10: dffffc0000000000 R11: ffffed100858e016 R12: dffffc0000000000
R13: ffff888042c70000 R14: ff616161616161a1 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4808733114 CR3: 000000003efa4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __dev_mc_add net/core/dev_addr_lists.c:872 [inline]
 dev_mc_add+0xca/0x110 net/core/dev_addr_lists.c:886
 igmp6_group_added+0x1a4/0x710 net/ipv6/mcast.c:684
 __ipv6_dev_mc_inc+0x8da/0xac0 net/ipv6/mcast.c:988
 addrconf_join_solict net/ipv6/addrconf.c:2240 [inline]
 addrconf_dad_begin net/ipv6/addrconf.c:4095 [inline]
 addrconf_dad_work+0x44f/0x16a0 net/ipv6/addrconf.c:4223
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__dev_set_rx_mode+0x1c2/0x280 net/core/dev.c:9092
Code: 8b 04 24 42 0f b6 04 20 84 c0 48 8b 5c 24 08 0f 85 b3 00 00 00 40 88 2b eb 05 e8 e9 78 00 f8 49 83 c6 40 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 3f 11 67 f8 49 8b 2e 48 85 ed 74
RSP: 0018:ffffc900005177e0 EFLAGS: 00010a02
RAX: 1fec2c2c2c2c2c34 RBX: ffff888042c70410 RCX: ffff888030eca440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff89bee4d6 R09: 1ffff1100858e015
R10: dffffc0000000000 R11: ffffed100858e016 R12: dffffc0000000000
R13: ffff888042c70000 R14: ff616161616161a1 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4808733114 CR3: 000000003efa4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 04 24             	mov    (%rsp),%eax
   3:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
   8:	84 c0                	test   %al,%al
   a:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
   f:	0f 85 b3 00 00 00    	jne    0xc8
  15:	40 88 2b             	mov    %bpl,(%rbx)
  18:	eb 05                	jmp    0x1f
  1a:	e8 e9 78 00 f8       	call   0xf8007908
  1f:	49 83 c6 40          	add    $0x40,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 3f 11 67 f8       	call   0xf8671178
  39:	49 8b 2e             	mov    (%r14),%rbp
  3c:	48 85 ed             	test   %rbp,%rbp
  3f:	74                   	.byte 0x74


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

