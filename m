Return-Path: <linux-ext4+bounces-4897-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7089B98BD
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A4281936
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19F1D0F49;
	Fri,  1 Nov 2024 19:35:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FF156880
	for <linux-ext4@vger.kernel.org>; Fri,  1 Nov 2024 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489732; cv=none; b=B4HXHkrfMqL5WtZkKEb85/7l5hi/yCrKyL3KJ44ds83Y/qIKs1WSSBPsVIRHHgWa/M5yncxrlem2q5te928JlBcfWih3M78lPZXqpertimYPNki8efBG/sCEj3970dg3YUxB4K40dshFf7fVM155pIWsbVxzvRl619qBHkY4cvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489732; c=relaxed/simple;
	bh=P5NjpOhW1w/eEvKGZGqUAC4prQu4vS1OH7oViAEO6fc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N5/ptDqEEn08oa/D+sJu8hkXgkRoZtIbVHT82lWEOlOztr/8s8EySH2t43LhNvwiWT2Yk96J+xxBcdV8tsuJV8zXz0cp0GzHP4BatgeVOsbT5O/EAiiiV5dniTniO5HPdR0t8D9EdXERol4S0hjDJTrkvO6mtNK65MTltNKguYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so21058215ab.2
        for <linux-ext4@vger.kernel.org>; Fri, 01 Nov 2024 12:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489730; x=1731094530;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8lPGkX/utG/2/9kudO/gDT8XABATxXzqo3GFDswoXQ=;
        b=BCijjgCyd5VPfkrPEKqn2SrEEJBVtBG0Fe7bpTtkYAPA49D04/XAM9RRsidY1eJ6LM
         WXNEXoz+LUZjFLahM1uc5xA5Oe+s+zNbEk/QOznkDMvE5liTWFjMwDIWtikqGE0UIMXe
         jyYKLHBHPfzdHdkA7QCP05nIrqXRayJe9luh6OQIwOYRU+CXE84zSELD0t11aZ8N0HAN
         LpTa5fFA5ZZsJSc9tEgkp1s/Z5h94f8ugPSADRdrRClmhEYof9VnQNBWzI9lLuuBFAe7
         cAVmNO9hGvqFyBx5FJq+qK+JMnBqBO7+DtY6TSnOr8vslHQDTRvHi8o+gtZyQI+kGnve
         MiJQ==
X-Gm-Message-State: AOJu0YyhEz5Ca3gG15bxYo/pJ+qB4yqGU38lfipRR6dkBcoEA0/u/85i
	Re4TN7BBlVXqmJQWYqtQQnEMwq5xI9rx4hP/2lByZg0FrbyX1WssCihNlXcgS0F2z5iS2+EGH1z
	uPSOmIY7aTw0zOFQ3g8DkgWfxlOQUkabXXH+JBuxy2PkoyQVeeNrl+xI=
X-Google-Smtp-Source: AGHT+IHw+LrlwAqbJ6U84O21Bx/q5NNgr0Xzmcbw+SGTE4hharPM24LAWznN28NKOQk0iN2AhATamaPfyONNWfbQZuWHNHov9V2o
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:8748:0:b0:3a5:e1f5:157c with SMTP id
 e9e14a558f8ab-3a5e1f51a2dmr103901755ab.15.1730489730072; Fri, 01 Nov 2024
 12:35:30 -0700 (PDT)
Date: Fri, 01 Nov 2024 12:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67252d82.050a0220.35b515.0177.GAE@google.com>
Subject: [syzbot] [ext4?] divide error in qnx6_mmi_fill_super
From: syzbot <syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    819837584309 Linux 6.12-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11653230580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=6a0633f11d3fb88860bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1617fe5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1117fe5f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-81983758.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c67be4ca64cb/vmlinux-81983758.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6ab06862875/bzImage-81983758.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/31f696da7624/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1eae9e19d2c5/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a0633f11d3fb88860bf@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 128
qnx6: unable to set blocksize
loop0: detected capacity change from 0 to 128
Oops: divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5358 Comm: syz-executor346 Not tainted 6.12.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:qnx6_mmi_fill_super+0x20c/0x810 fs/qnx6/super_mmi.c:68
Code: c4 28 4c 89 e0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 60 05 00 00 45 85 f6 41 8b 04 24 89 c6 0f ce 0f 44 f0 b8 00 10 00 00 31 d2 <f7> f6 41 89 c6 4c 89 ff e8 67 c0 87 01 89 c3 31 ff 89 c6 e8 4c 83
RSP: 0018:ffffc9000ceb7ac8 EFLAGS: 00010246
RAX: 0000000000001000 RBX: dffffc0000000000 RCX: ffff888000d80000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888048292034
RBP: 0000000000000000 R08: ffffffff831258ff R09: ffffffff8c617e00
R10: ffffffff8c617a00 R11: ffffffff8c617600 R12: ffff888048292028
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880467de000
FS:  00007f9aec9cb6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d713e729c8 CR3: 0000000000e4c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qnx6_fill_super+0x181/0x15a0 fs/qnx6/inode.c:321
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9aeca3746a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9aec9cb038 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020009e00 RCX: 00007f9aeca3746a
RDX: 0000000020009e00 RSI: 0000000020000080 RDI: 00007f9aec9cb090
RBP: 00007f9aec9cb090 R08: 00007f9aec9cb0d0 R09: 002c73665f696d6d
R10: 000000000020c800 R11: 0000000000000286 R12: 0000000020000080
R13: 00007f9aec9cb0d0 R14: 0000000000009e0d R15: 0000000020000040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:qnx6_mmi_fill_super+0x20c/0x810 fs/qnx6/super_mmi.c:68
Code: c4 28 4c 89 e0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 60 05 00 00 45 85 f6 41 8b 04 24 89 c6 0f ce 0f 44 f0 b8 00 10 00 00 31 d2 <f7> f6 41 89 c6 4c 89 ff e8 67 c0 87 01 89 c3 31 ff 89 c6 e8 4c 83
RSP: 0018:ffffc9000ceb7ac8 EFLAGS: 00010246
RAX: 0000000000001000 RBX: dffffc0000000000 RCX: ffff888000d80000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888048292034
RBP: 0000000000000000 R08: ffffffff831258ff R09: ffffffff8c617e00
R10: ffffffff8c617a00 R11: ffffffff8c617600 R12: ffff888048292028
R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880467de000
FS:  00007f9aec9cb6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9ae443f000 CR3: 0000000000e4c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	28 4c 89 e0          	sub    %cl,-0x20(%rcx,%rcx,4)
   4:	48 c1 e8 03          	shr    $0x3,%rax
   8:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
   c:	84 c0                	test   %al,%al
   e:	0f 85 60 05 00 00    	jne    0x574
  14:	45 85 f6             	test   %r14d,%r14d
  17:	41 8b 04 24          	mov    (%r12),%eax
  1b:	89 c6                	mov    %eax,%esi
  1d:	0f ce                	bswap  %esi
  1f:	0f 44 f0             	cmove  %eax,%esi
  22:	b8 00 10 00 00       	mov    $0x1000,%eax
  27:	31 d2                	xor    %edx,%edx
* 29:	f7 f6                	div    %esi <-- trapping instruction
  2b:	41 89 c6             	mov    %eax,%r14d
  2e:	4c 89 ff             	mov    %r15,%rdi
  31:	e8 67 c0 87 01       	call   0x187c09d
  36:	89 c3                	mov    %eax,%ebx
  38:	31 ff                	xor    %edi,%edi
  3a:	89 c6                	mov    %eax,%esi
  3c:	e8                   	.byte 0xe8
  3d:	4c                   	rex.WR
  3e:	83                   	.byte 0x83


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

