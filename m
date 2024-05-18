Return-Path: <linux-ext4+bounces-2569-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F158F8C8FB0
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 07:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90CD28364A
	for <lists+linux-ext4@lfdr.de>; Sat, 18 May 2024 05:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF5DDA6;
	Sat, 18 May 2024 05:23:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26BD518
	for <linux-ext4@vger.kernel.org>; Sat, 18 May 2024 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716009803; cv=none; b=C0cPQAvcpNQMaQyrllX6Rz16Lnbl8TCR9eYBvG/cJ50BuiR8CP6tsnpUfkuNYj3vnoF0y4p1cUppowNoZk4l54Q7j7ZDrQD5UH8IQGrK9cZLCZh9XcAXZnewW8wiyDlSBHOhv5iccRofVffnniM1z+w2MQjQ1ki5cQCzFITxq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716009803; c=relaxed/simple;
	bh=AIQcw2wZPM2jkR0uml9IhV9m0z3uY/dRPmFHrhLZX58=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n2gY3K8fR8xfamFFW0CKyUVnTJXTig1CxEBiF9/dR2WOAohgC+3Lt55e5e3q+jCYgSfWa2niHk0DY6rSv7bGq1h5iknhUmy9v4/aUJilYcudHOvbZsKdM/z1u4WfeG1m7qE4U1FL53+S+5HuPbIos2kteDFr268Z7WeI0A8bM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so516964139f.3
        for <linux-ext4@vger.kernel.org>; Fri, 17 May 2024 22:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716009801; x=1716614601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MrL6pEfonU8pCkuJ3ORJE6oNNScN662RCAj0jCAlto=;
        b=bljCtuw3DmGTkfIXum18Y1OGcxcWZx2tr5ZcISBoiICJl/ZMXAj1oHjNLqTk3ydul5
         2v1pEosLxGSc3ah/WTmhxqA/DolQgavlA2XGhV4HtRxeO/ksUzrfhuOUPIDV3uKsBiSW
         JjhIEHxQ5esTZYRehCYfPw5JigPogPP8Y7Vu3Qy3FBt5/ELqEW08GeXtlJ2MVv/Ks2lT
         Hu5vdSZ6YprREZsFEEBd5R9SV+pMIqfNtDLEJ/xNz+3nfv0bmYsqpFNLX33lD/wAL1nh
         MDGjAnjfrT1Lngilf8gh9ppQJSRpgLF0U4oOy3J3VsJvb0mr6PClWp+DBsF7XWAsfKyn
         1lLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7WaXLh0y3XO7tR4njoHp7yaflCS+ahEna+Q/YRE9Z8OR705XeWje0qLXomF21T1P0navZzTIjf4PylNR0arE9SDRn09fywRBVWw==
X-Gm-Message-State: AOJu0YzNpFHuWh/zPE390pjQHk7akCc/sUfdETkMEfs7Ce79wzHFe17A
	QIhFxL5YQqBuNlL7CPj6bQwejTlSV1itCJ7CFH8P+sZmljbrP9woetbIZ2vyw/voPQn+ZXh34fF
	chrpq39LzbnP2hnb4A5cNGDW/Gfgvxigi1QOnWNL38DqJfD5xC/vvcVE=
X-Google-Smtp-Source: AGHT+IG/gkkkdt2qPSXew6UJVstE0tcqo+Fse0E7P2g0ogpqqmHbm4kmwGoyaaYHhH9Yq0nQCEu3t3UXOqAL7FEty/UA1aJ60InD
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-48958af8591mr1634520173.3.1716009801501; Fri, 17 May 2024
 22:23:21 -0700 (PDT)
Date: Fri, 17 May 2024 22:23:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a65f480618b3aad9@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_mb_add_groupinfo
From: syzbot <syzbot+caf3fed221ac23a1398f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5131c3fdf26 Merge tag 'x86-shstk-2024-05-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152fcf98980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fdb182f40cdd66f7
dashboard link: https://syzkaller.appspot.com/bug?extid=caf3fed221ac23a1398f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a5131c3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d23116dab9c/vmlinux-a5131c3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd8b9de9af4f/bzImage-a5131c3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+caf3fed221ac23a1398f@syzkaller.appspotmail.com

Looking for class "c->lock" with key __key.0, but found a different class "&c->lock" with the same key
WARNING: CPU: 3 PID: 5490 at kernel/locking/lockdep.c:932 look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Modules linked in:
CPU: 3 PID: 5490 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-01768-ga5131c3fdf26 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:look_up_lock_class+0x133/0x140 kernel/locking/lockdep.c:932
Code: c7 c7 80 bc 0c 8b e8 9c a3 7d f6 90 0f 0b 90 90 90 31 db eb be c6 05 78 f3 b3 04 01 90 48 c7 c7 a0 bf 0c 8b e8 7e a3 7d f6 90 <0f> 0b 90 90 e9 62 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900076bf4d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffffffff93d7a900 RCX: ffffc90006f69000
RDX: 0000000000040000 RSI: ffffffff81514aa6 RDI: 0000000000000001
RBP: ffffffff9466e9d0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000006b6f6f4c R12: ffffe8ffad57d2c0
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff94656ba0
FS:  0000000000000000(0000) GS:ffff88802c500000(0063) knlGS:00000000f5e47b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f73d30c4 CR3: 00000000003a6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0xb1/0x1230 kernel/locking/lockdep.c:1284
 __lock_acquire+0x111/0x3b30 kernel/locking/lockdep.c:5014
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 ___slab_alloc+0x73b/0x1810 mm/slub.c:3641
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3682
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 kmem_cache_alloc+0x2f3/0x330 mm/slub.c:3925
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 ext4_mb_add_groupinfo+0x43f/0x1180 fs/ext4/mballoc.c:3343
 ext4_mb_init_backend fs/ext4/mballoc.c:3422 [inline]
 ext4_mb_init+0x1273/0x2530 fs/ext4/mballoc.c:3719
 __ext4_fill_super fs/ext4/super.c:5518 [inline]
 ext4_fill_super+0x6e08/0xaea0 fs/ext4/super.c:5695
 get_tree_bdev+0x36f/0x610 fs/super.c:1614
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6e1/0x1f10 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __ia32_sys_mount+0x295/0x320 fs/namespace.c:3875
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7255579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5e47400 EFLAGS: 00000292 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f5e47460 RCX: 00000000200005c0
RDX: 0000000020000100 RSI: 0000000001018e58 RDI: 00000000f5e474a0
RBP: 00000000f5e47460 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

