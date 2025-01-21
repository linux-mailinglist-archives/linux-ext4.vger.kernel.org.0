Return-Path: <linux-ext4+bounces-6184-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D98A1819A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 17:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510F07A3D66
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BBE2AF0A;
	Tue, 21 Jan 2025 16:00:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04081F4E3D
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737475235; cv=none; b=tr5Q73SIwdlMn1bSbVr6lMjj0yyyBAtNySWlBNy84qVddcTnrND6Et+Njwmvp4gPQB2K4uufj/hk0FTjPbqGpftX2smDCIK6kd6umz0UKidVVVxymC3g1fK7q08laueRfnV6v7dT0ogQy17ChhnqAfvLWjrawbEtdbl3amg5NBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737475235; c=relaxed/simple;
	bh=5zMYgLcdkMmQ6bDIR5Q258Iu2armucT7gOtavj076+A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pWmzQ9UaCubAFA9OSstT3idZTRLw9Qcdt5aDPwNmKkZY8buVGymXdwDUMJr5GmvqnAddqvnzk6k3iefFhcUlaGe1qN03mq4K+i4H3SVLQ7VOfNIS9ZLdW501Z0GYJLZQE3igITouoKvxiUOOx4R4lf1F7DKf7yLt6lXbzZPrOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ce795254afso89518815ab.1
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 08:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737475233; x=1738080033;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8O5MvLLvuofY4WI2Gb7QAWosrJSFAFqhmFgMNhefPwM=;
        b=YG2NQ4KQk594HDeMvVj9w9PHZ4xhjUEnoZzNmdfCsdnTEUwKNMeooxMnLoNLsS26Pl
         VdiFADUidPd7H23p4DogJH2fuPhUcjCi1JpfkF9rCc7C8xG/qNk8XaSSnlcGcM2xKEZW
         j4UsAlMYwXQDU8Q4Aw1KIvNwDy1RJvwtoBrwYVNwjdfoOY0oHg+lDCmq+SAiQkDJF0jg
         r4WjChOsFsWibJNb81f5UTZfjEgrV5Cwa7giu1mBVc0ki1fJBbKrDT4wpYqEseuQ4qo5
         Mzf9G3d37IhYWZv35NciWNU4rzWakGwbYTFvCGKNlfajEp5J0Wb3BnngIayPboZEb4WS
         lunw==
X-Forwarded-Encrypted: i=1; AJvYcCV7bU4mRe8kTY76gKA+Sq3xAzRkW6RSXmcOwhqbIqkh2DJuKJBgl81CDbQjvHkFgMwBxzJgs8yNfbKq@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2UaIaQIIZuZng6eYK30jQzooW+xFJbUx2Fgp4N+EHvL19zjV
	bwXRMv6RXgG/MikbZGSCxcPK8bFsAe4AkI628d3nGX/EukeHII2rYEObmpuLo8ZYkqX0nByFa+i
	u0amPjg6A4/VJa3J9PlQTcv5h1Q62ly36L2TMZchC2SwPBWps/GedHfw=
X-Google-Smtp-Source: AGHT+IFpRjFJHKGYmZwBNSI48Q8xO9kO7EtsP2yzC36VUcnhh7x+o6FwuNBUl2f/BCYBtHFWKwYnWfJpPglUo9x1tSmgPKR3LjAE
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a11:b0:3ce:6b10:17fc with SMTP id
 e9e14a558f8ab-3cf743ca060mr149803165ab.4.1737475232519; Tue, 21 Jan 2025
 08:00:32 -0800 (PST)
Date: Tue, 21 Jan 2025 08:00:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678fc4a0.050a0220.15cac.0060.GAE@google.com>
Subject: [syzbot] [ext4?] BUG: unable to handle kernel NULL pointer
 dereference in ext4_mb_add_groupinfo (2)
From: syzbot <syzbot+c41c38d18cb10c84caee@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    95ec54a420b8 Merge tag 'powerpc-6.14-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12946964580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=161bb0713bee7bb2
dashboard link: https://syzkaller.appspot.com/bug?extid=c41c38d18cb10c84caee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae4f5b920fb2/disk-95ec54a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/733fe3f9fdd1/vmlinux-95ec54a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1ff7ab4bd3a/bzImage-95ec54a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c41c38d18cb10c84caee@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 512
BUG: kernel NULL pointer dereference, address: 0000000000000012
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 800000007ee5d067 P4D 800000007ee5d067 PUD 33cf4067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6142 Comm: syz.3.43 Not tainted 6.13.0-syzkaller-00918-g95ec54a420b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:___slab_alloc+0x595/0x14a0 mm/slub.c:3773
Code: 85 fb 00 00 00 65 4c 8b 2c 25 c0 d4 03 00 4c 89 6b 28 49 83 7e 10 00 0f 85 82 01 00 00 49 8b 5e 18 48 85 db 0f 84 ea 04 00 00 <48> 8b 43 10 49 89 46 18 8b 4c 24 10 83 f9 ff 74 15 48 8b 03 48 83
RSP: 0018:ffffc9000522f6c8 EFLAGS: 00010002
RAX: 7513f5baf7a4fb00 RBX: 0000000000000002 RCX: ffff88802fa9a8d8
RDX: dffffc0000000000 RSI: ffffffff8c0aab60 RDI: ffffffff8c5f49e0
RBP: 0000000000000202 R08: ffffffff9428e887 R09: 1ffffffff2851d10
R10: dffffc0000000000 R11: fffffbfff2851d11 R12: ffff888058f948c0
R13: ffff88802fa99e00 R14: ffffe8ffffd71220 R15: ffffffff81f839cf
FS:  00007fa654bc36c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000012 CR3: 000000003348a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4175
 ext4_mb_add_groupinfo+0x6c3/0xfa0 fs/ext4/mballoc.c:3356
 ext4_mb_init_backend fs/ext4/mballoc.c:3435 [inline]
 ext4_mb_init+0x15ab/0x27e0 fs/ext4/mballoc.c:3733
 __ext4_fill_super fs/ext4/super.c:5559 [inline]
 ext4_fill_super+0x5f54/0x6e60 fs/ext4/super.c:5733
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa653d874ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa654bc2e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fa654bc2ef0 RCX: 00007fa653d874ca
RDX: 0000000020000180 RSI: 0000000020000640 RDI: 00007fa654bc2eb0
RBP: 0000000020000180 R08: 00007fa654bc2ef0 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000000246 R12: 0000000020000640
R13: 00007fa654bc2eb0 R14: 000000000000047b R15: 0000000020000100
 </TASK>
Modules linked in:
CR2: 0000000000000012
---[ end trace 0000000000000000 ]---
RIP: 0010:___slab_alloc+0x595/0x14a0 mm/slub.c:3773
Code: 85 fb 00 00 00 65 4c 8b 2c 25 c0 d4 03 00 4c 89 6b 28 49 83 7e 10 00 0f 85 82 01 00 00 49 8b 5e 18 48 85 db 0f 84 ea 04 00 00 <48> 8b 43 10 49 89 46 18 8b 4c 24 10 83 f9 ff 74 15 48 8b 03 48 83
RSP: 0018:ffffc9000522f6c8 EFLAGS: 00010002
RAX: 7513f5baf7a4fb00 RBX: 0000000000000002 RCX: ffff88802fa9a8d8
RDX: dffffc0000000000 RSI: ffffffff8c0aab60 RDI: ffffffff8c5f49e0
RBP: 0000000000000202 R08: ffffffff9428e887 R09: 1ffffffff2851d10
R10: dffffc0000000000 R11: fffffbfff2851d11 R12: ffff888058f948c0
R13: ffff88802fa99e00 R14: ffffe8ffffd71220 R15: ffffffff81f839cf
FS:  00007fa654bc36c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000012 CR3: 000000003348a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	85 fb                	test   %edi,%ebx
   2:	00 00                	add    %al,(%rax)
   4:	00 65 4c             	add    %ah,0x4c(%rbp)
   7:	8b 2c 25 c0 d4 03 00 	mov    0x3d4c0,%ebp
   e:	4c 89 6b 28          	mov    %r13,0x28(%rbx)
  12:	49 83 7e 10 00       	cmpq   $0x0,0x10(%r14)
  17:	0f 85 82 01 00 00    	jne    0x19f
  1d:	49 8b 5e 18          	mov    0x18(%r14),%rbx
  21:	48 85 db             	test   %rbx,%rbx
  24:	0f 84 ea 04 00 00    	je     0x514
* 2a:	48 8b 43 10          	mov    0x10(%rbx),%rax <-- trapping instruction
  2e:	49 89 46 18          	mov    %rax,0x18(%r14)
  32:	8b 4c 24 10          	mov    0x10(%rsp),%ecx
  36:	83 f9 ff             	cmp    $0xffffffff,%ecx
  39:	74 15                	je     0x50
  3b:	48 8b 03             	mov    (%rbx),%rax
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


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

