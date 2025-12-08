Return-Path: <linux-ext4+bounces-12224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF042CAC72E
	for <lists+linux-ext4@lfdr.de>; Mon, 08 Dec 2025 09:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44EFD3024E7B
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Dec 2025 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D12D29C7;
	Mon,  8 Dec 2025 08:03:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB2289E06
	for <linux-ext4@vger.kernel.org>; Mon,  8 Dec 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181004; cv=none; b=sUbEYRYCtxGCNMqyBCezneyEfjl9S6BXgSPK4itWglle7+Gp1CbHpsnLKmFzFyTQJetk0rz7MjYojD2xyo3nKKtEcbfcuWVbZIllB23rRJ4oCvjiKmR9tQSdrWXkkqf7xnOYEYE3a4qg5Y0BTmKgYMuZnwcPKyce9PFLgK0rqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181004; c=relaxed/simple;
	bh=amLFd2m+0Avu4Rxu5zX7h28qHyMWrDzkOthdokwATbw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GLOylovi4NN3k3MkoyHFuZfoLhj6GNUjdmDUWDlMhY0+scWIWK2QPUN8OthZKHJ6rljtqihAl427BQ1JwRoa/ogU2Bbz3Ss3/9MT+m4KLvdXh8xB4yMFO2jrm/DY8NigLJVkyp4sNozyve3Ln7LK6zCL1YvYfbY2EBmeMQdAtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-450fd003480so5958069b6e.2
        for <linux-ext4@vger.kernel.org>; Mon, 08 Dec 2025 00:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765181002; x=1765785802;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTIWGFMfKu1kSX/Bl5YWfzg4ivzYMGwoIO+BrmOk9+I=;
        b=nSFt0bu4yqMET7Spig5oOaBfrjVWiFTJuhTJfVakyRBO3Bv1FTNZN9zpStfQglqDDT
         GrU4PD8NZ2IJ1CWeUZOzO0hMLnZHSZZ5md5yBZ216vH64f3+60JwP7jw7IyjRt/uM1cz
         vDBjpxL3tRIRXrG9tfb/PmPCKmnUku+R3vDTWMV2vAO88bVaKaZH+ibGOjWiNXqoFkj8
         vDan585pgV2tk078cIO3JlXuQo6w6whUm7iU4jBmdt04y0zw49tUGLTTiN3EVgeRz+dm
         cULcAjSe99/1OkL8psHP3D3k55ftJJiREm44cL+1anaoHgNWOF9NoOL1Y0AC1sQ+Hyvu
         8XFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUsnRbZlc6IK1/szVYCqhFjshlA6544UPapwg4h279q6SsTau4BdY8nULTBOmgJTd5CaRm5Krj9e7v@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+a56+X9pGPnELyOltHJbVvSyWyvicX6yEnSbLvTZfxXL6RJ+
	Zwa2ltZDUf32PWCPWHZcnjl/hgcJ7poc0/Ymywc2/FQDKypN7r2amUagDcIf0Jh58d/kai6e/e8
	AeNMuyLEHJ8+Beqies1qbRaXz3azCLpcSDx2ks3RDFTemV4INJzHHV6f6JOU=
X-Google-Smtp-Source: AGHT+IENtbla23UIJTXeyTsVf9vvmJOf77wywFXOdZc+H889QzDbiTxvvkWqKIomTBh15vXpBKbbsUNrrABl1g1m7KQCyqwks1/T
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b0a:b0:659:9a49:905e with SMTP id
 006d021491bc7-6599a95d217mr2821956eaf.41.1765181001867; Mon, 08 Dec 2025
 00:03:21 -0800 (PST)
Date: Mon, 08 Dec 2025 00:03:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69368649.a70a0220.38f243.0093.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_swap_extents
From: syzbot <syzbot+4ea6bd8737669b423aae@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d1d36025a617 Merge tag 'probes-v6.19' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138d8992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eaa3e2adda258a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4ea6bd8737669b423aae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145002c2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12893c1a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d1d36025.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8198d2c1f670/vmlinux-d1d36025.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51df1359897b/bzImage-d1d36025.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b2df79151221/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=105002c2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ea6bd8737669b423aae@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:5683!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5528 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_swap_extents+0x196c/0x19a0 fs/ext4/extents.c:5683
Code: fe c1 38 c1 0f 8c 7e fe ff ff e8 1f 17 b3 ff e9 74 fe ff ff e8 b5 79 4b ff 90 0f 0b e8 ad 79 4b ff 90 0f 0b e8 a5 79 4b ff 90 <0f> 0b e8 9d 79 4b ff 90 0f 0b e8 95 79 4b ff 90 0f 0b e8 8d 79 4b
RSP: 0018:ffffc9000cc0f2c0 EFLAGS: 00010293
RAX: ffffffff8275e17b RBX: 0000000000000000 RCX: ffff88801fb324c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffff888042379547 R09: 1ffff1100846f2a8
R10: dffffc0000000000 R11: ffffed100846f2a9 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007fed9d1f96c0(0000) GS:ffff88808d683000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30863fff CR3: 0000000000731000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mext_move_extent fs/ext4/move_extent.c:396 [inline]
 ext4_move_extents+0x2c58/0x3830 fs/ext4/move_extent.c:616
 __ext4_ioctl fs/ext4/ioctl.c:1652 [inline]
 ext4_ioctl+0x2cf9/0x4760 fs/ext4/ioctl.c:1917
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed9c38f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed9d1f9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fed9c5e5fa0 RCX: 00007fed9c38f7c9
RDX: 0000200000000080 RSI: 00000000c028660f RDI: 0000000000000005
RBP: 00007fed9d1f9090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fed9c5e6038 R14: 00007fed9c5e5fa0 R15: 00007fffbb119b38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_swap_extents+0x196c/0x19a0 fs/ext4/extents.c:5683
Code: fe c1 38 c1 0f 8c 7e fe ff ff e8 1f 17 b3 ff e9 74 fe ff ff e8 b5 79 4b ff 90 0f 0b e8 ad 79 4b ff 90 0f 0b e8 a5 79 4b ff 90 <0f> 0b e8 9d 79 4b ff 90 0f 0b e8 95 79 4b ff 90 0f 0b e8 8d 79 4b
RSP: 0018:ffffc9000cc0f2c0 EFLAGS: 00010293
RAX: ffffffff8275e17b RBX: 0000000000000000 RCX: ffff88801fb324c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffff888042379547 R09: 1ffff1100846f2a8
R10: dffffc0000000000 R11: ffffed100846f2a9 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007fed9d1f96c0(0000) GS:ffff88808d683000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30863fff CR3: 0000000000731000 CR4: 0000000000352ef0


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

