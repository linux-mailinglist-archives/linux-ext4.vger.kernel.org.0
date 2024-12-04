Return-Path: <linux-ext4+bounces-5490-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732FF9E4603
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2024 21:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD63169D32
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2024 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8E18FC85;
	Wed,  4 Dec 2024 20:43:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549A1632DF
	for <linux-ext4@vger.kernel.org>; Wed,  4 Dec 2024 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733345010; cv=none; b=hZtHgUDt8jk4uwPOsGWpBeC6lB9Gg8Fsu87W1CT7vuep9xco9ms8lf5pIwXBcDxMEutUHWQb2u2APLxI9FZkC8Sho3/3k4W45VJXcz/3prtZK5QyUMKQjSOrTx2AweVFbulKdelCvvnjGq1gPWWjvoOCwb6UJDHxrM682arO7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733345010; c=relaxed/simple;
	bh=MxqrL7P+q5TtbAG4Bjz4LhtI/kOkk5CviQKzYIdVOEo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FL4FB+f+Ps9GRXby4V6PATCJpEaP5aW1Wbu8LxMgbG6GTvXgGz8jV3knC9jklRZe+QMSysj9NEgxiwspTLZwpMgCooemlACiHqW+kmAYy3UKBS8fjVj2mLJ4Wu0WBQRUkG1+eeodd9hNr+1Esp0G13vKCSGto6Ie/3VMkSbFn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a7cff77f99so1942085ab.3
        for <linux-ext4@vger.kernel.org>; Wed, 04 Dec 2024 12:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733345008; x=1733949808;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6k9FdKQ2cY0hs7m3TWq6tSTQAE+PkoV2U5ODf+4lDTE=;
        b=cW3eJfB4/3hwykWtRKsHz5m5SvXT4laQIDZYP7Be6WefTu2YxzgJvIac9ud+D/u6h/
         eqa6FZKQrM46xZ9+UyYIjUg/+w272tbpuhF1GcpH66CSEjut0MXjeY79tXLgkx76Ojsy
         d85j2q8+j4v/nO0edYOu4NuAp9ZQJf1lQ7HDYbO+UJiksK4lfFlPFWUr7Z0G+Ew+5Ytx
         CW2RUjO7wCMJH5Q3d2N0B3JHXuxl+uuectgvd/oC074ffkCA95IDpDSZ6iO//K3mS8KZ
         S7BBfw+DWLt/30WFDajNe+HAVP9oJNzdGjTW93lLam/MYelMGeAt1ntipWk+4nkecLtI
         lk9g==
X-Forwarded-Encrypted: i=1; AJvYcCV5GhTT/prbrPSucNdwfaMv+BTRmNPSz1q3isjddnXDukbAisRTO7/iEDGj9BKR6SOqx6n6eXVsS8DC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DuWTKr0iXTzTaFbBWfSEcFqfueEvbTYgdG4JDO4f5VIkDPoe
	fLwpacfZdDa5j7J+LBrGzXgjcz8M7A4bzg++YihSQuj+av1ORjhzGA2TzsupNwMcqc8kW1PQ7E3
	RZLvFowdy+g4lMb6EpR0gw8vidMmbAhuIHQsCcVvLEvMX4SkKrL2l/NU=
X-Google-Smtp-Source: AGHT+IGzcfQlcveK056IjyzEAo6BuiDtS7T5gBiKtK++qt8PMl5gkvyuubW/bOBIEUWrnazFAgccABw+QgUre2ueSmGU7oZrkqBW
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c246:0:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3a7f9a3838cmr101282705ab.1.1733345008365; Wed, 04 Dec 2024
 12:43:28 -0800 (PST)
Date: Wed, 04 Dec 2024 12:43:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6750bef0.050a0220.17bd51.007a.GAE@google.com>
Subject: [syzbot] [wireless?] [ext4?] general protection fault in pcpu_alloc
From: syzbot <syzbot+e874685d80aae83785cc@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bcc8eda6d349 Merge tag 'turbostat-2024.11.30' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128dbf78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ebff8e07a0ee6f
dashboard link: https://syzkaller.appspot.com/bug?extid=e874685d80aae83785cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bd15e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7dd7042cbaae/disk-bcc8eda6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/48269d20d4af/vmlinux-bcc8eda6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/010f2b2a997f/bzImage-bcc8eda6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/73a779ed9f88/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e874685d80aae83785cc@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xec2c282c2c2c2c2d: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x6161616161616168-0x616161616161616f]
CPU: 0 UID: 0 PID: 5926 Comm: syz-executor Not tainted 6.12.0-syzkaller-12113-gbcc8eda6d349 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__hlist_del include/linux/list.h:982 [inline]
RIP: 0010:hlist_del include/linux/list.h:994 [inline]
RIP: 0010:__alloc_object lib/debugobjects.c:232 [inline]
RIP: 0010:pcpu_alloc+0x1a8/0x300 lib/debugobjects.c:256
Code: 2e 4c 89 e8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ef e8 0c d2 3e fd 49 89 5d 00 48 85 db 74 1c 48 83 c3 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 ea d1 3e fd 4c 89 2b 41 80 3c 2f 00
RSP: 0018:ffffc900038a6f60 EFLAGS: 00010006
RAX: 0c2c2c2c2c2c2c2d RBX: 6161616161616169 RCX: 0000000000000001
RDX: ffffffff8c09c480 RSI: ffffffff8c5e9080 RDI: ffffffff8c5e9040
RBP: dffffc0000000000 R08: 0000000000000003 R09: fffff52000714ddc
R10: dffffc0000000000 R11: fffff52000714ddc R12: 1ffff1100f228801
R13: ffff8880b863fe00 R14: ffff888079144008 R15: 1ffff1100f228800
FS:  000055555fac2500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555915bb808 CR3: 000000001cad4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_object+0xbf/0x310 lib/debugobjects.c:458
 lookup_object_or_alloc lib/debugobjects.c:685 [inline]
 __debug_object_init+0x185/0x470 lib/debugobjects.c:743
 ieee80211_alloc_hw_nm+0x126e/0x1ea0 net/mac80211/main.c:976
 mac80211_hwsim_new_radio+0x1db/0x4a90 drivers/net/wireless/virtual/mac80211_hwsim.c:5146
 hwsim_new_radio_nl+0xece/0x2290 drivers/net/wireless/virtual/mac80211_hwsim.c:6203
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f811ad826dc
Code: 2a 5a 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5a 02 00 48 8b
RSP: 002b:00007ffd7f24e760 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f811ba74620 RCX: 00007f811ad826dc
RDX: 0000000000000024 RSI: 00007f811ba74670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd7f24e7b4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f811ba74670 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__hlist_del include/linux/list.h:982 [inline]
RIP: 0010:hlist_del include/linux/list.h:994 [inline]
RIP: 0010:__alloc_object lib/debugobjects.c:232 [inline]
RIP: 0010:pcpu_alloc+0x1a8/0x300 lib/debugobjects.c:256
Code: 2e 4c 89 e8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ef e8 0c d2 3e fd 49 89 5d 00 48 85 db 74 1c 48 83 c3 08 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 ea d1 3e fd 4c 89 2b 41 80 3c 2f 00
RSP: 0018:ffffc900038a6f60 EFLAGS: 00010006
RAX: 0c2c2c2c2c2c2c2d RBX: 6161616161616169 RCX: 0000000000000001
RDX: ffffffff8c09c480 RSI: ffffffff8c5e9080 RDI: ffffffff8c5e9040
RBP: dffffc0000000000 R08: 0000000000000003 R09: fffff52000714ddc
R10: dffffc0000000000 R11: fffff52000714ddc R12: 1ffff1100f228801
R13: ffff8880b863fe00 R14: ffff888079144008 R15: 1ffff1100f228800
FS:  000055555fac2500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555915bb808 CR3: 000000001cad4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	2e 4c 89 e8          	cs mov %r13,%rax
   4:	48 c1 e8 03          	shr    $0x3,%rax
   8:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
   c:	74 08                	je     0x16
   e:	4c 89 ef             	mov    %r13,%rdi
  11:	e8 0c d2 3e fd       	call   0xfd3ed222
  16:	49 89 5d 00          	mov    %rbx,0x0(%r13)
  1a:	48 85 db             	test   %rbx,%rbx
  1d:	74 1c                	je     0x3b
  1f:	48 83 c3 08          	add    $0x8,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 ea d1 3e fd       	call   0xfd3ed222
  38:	4c 89 2b             	mov    %r13,(%rbx)
  3b:	41 80 3c 2f 00       	cmpb   $0x0,(%r15,%rbp,1)


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

