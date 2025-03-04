Return-Path: <linux-ext4+bounces-6656-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FAAA4D9B1
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158D53B148A
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35921FDE15;
	Tue,  4 Mar 2025 10:01:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045C1FDA9D
	for <linux-ext4@vger.kernel.org>; Tue,  4 Mar 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082482; cv=none; b=Ki2PtH7WBxXlKy/9QX090vVzX7dOTSi2m+vnJ65QeuxWZkpvTAn0wyadIRxOOqoxQal0AjYvwWdiNdCMX3+Ow+LyGp7P6qmZbK4bBOf0NiebCA1/dYsCyl8YuCmCzrmvcBeOI876FkySnPTUOXCXdvTTKghUXUrO0E8FzmFzwgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082482; c=relaxed/simple;
	bh=iSoiNYOqMCkF7AVbCkITYjIuJh/zyuHGTYubyUPMm34=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ncfjg8818yXi3a6ClWFMruNvzpnecmX2J9nIHtT7RmROpAIdgYG6IUupXKVgL3zhtG0/LkfCM2EHLrKOi6viO75jQ6Hh1X7LICqTpr2x6Chqym02gaAyFG8nyc8V4Yhwwi1yKUYbee0QKlZMbevsoLYnnm8uEWpaQFLainIIUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d3dee8d31aso41455525ab.2
        for <linux-ext4@vger.kernel.org>; Tue, 04 Mar 2025 02:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741082480; x=1741687280;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwkcdBCtPeUm+n/SZESZuoQ69+eEylbZO03rQ5lowPU=;
        b=MwSME8SoPyYYnfJ67aIbSoEHILa9eCMH8xkW6UL9Z6rxXMhg081mzF4sy04+O45ah0
         L2dcjnrGs+kX55CmtPubRayYrFiM/qrlIHmmc6gYh3Yj7temfMm8IZ4G7A5Q4Ebb73O9
         7nrhg01BOufzloVm73vTbzediZWEuU7NvTjZlqVafVPTu8dR8sgMbCYtHHav0tJkOdNl
         8Yj4kaNgFtWRXXJgtS1kUYARa+Si/tVL+EPHaQiPhhRFCUgyb4RB8QMlZqHGpZfxC9lU
         Jw4mL0cJBH99fcvnz0RrvpBk0piSH751mk71jzqpGIw9Z9eyZ45ryduFXX2mTaVKSmtO
         FlZg==
X-Forwarded-Encrypted: i=1; AJvYcCXFbgDbJnjmltZInEKycba2iEGsDtzxEFtk+z61CkyaareKgkUxAK3HWReXGyXPzWTbMiitu4WAPFw3@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbXxvv63vl4Inp6hesuxXxEstN/sXqeDwG0h3ZAEJ8qPC45F4
	uPj14aJlhjpNLnaK+wIELu+ZfLfO91i+qp41qia9jy/piaYK5z32m5kshfysDclUhn8m6er3zpG
	9+EpeFHmkav8ZgTlPBzLfww//iPGqJs9JxUXEUzzo6CaLMUs0PA5843U=
X-Google-Smtp-Source: AGHT+IGOxX32wgNjdqg8BJGHxdUqtX9MxTDGkuy8CRidOihRlth0bKczY33wFHJl3CDuRTZn+nQigpcf/7PvEp+uRt8IUHn9IWBN
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1542:b0:3d2:b0f1:f5bd with SMTP id
 e9e14a558f8ab-3d3e6e22cf5mr172399835ab.3.1741082480019; Tue, 04 Mar 2025
 02:01:20 -0800 (PST)
Date: Tue, 04 Mar 2025 02:01:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c6cf6f.050a0220.15b4b9.0008.GAE@google.com>
Subject: [syzbot] [net?] [ext4?] BUG: corrupted list in __sk_destruct (2)
From: syzbot <syzbot+2f2bc79f24dae1dc62b6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@amazon.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eb172143d55 Linux 6.14-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e067a0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=2f2bc79f24dae1dc62b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126fd5a8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e7164e018a2/disk-7eb17214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30ec438ad743/vmlinux-7eb17214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b0e3bf8e8fd/bzImage-7eb17214.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cbb4ed5bd074/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14e498b7980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f2bc79f24dae1dc62b6@syzkaller.appspotmail.com

 slab kmalloc-32 start ffff88805f791000 pointer offset 0 size 32
list_del corruption. next->prev should be ffff88802029a200, but was ff61616161616161. (next=ffff88805f791000)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:67!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5948 Comm: syz-executor Not tainted 6.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__list_del_entry_valid_or_report+0x18c/0x190 lib/list_debug.c:65
Code: fa 89 10 fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 bb 0e 32 fd 49 8b 56 08 48 c7 c7 00 21 80 8c 4c 89 fe 4c 89 f1 e8 a5 9d 32 fc 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90003c8fb50 EFLAGS: 00010046
RAX: 000000000000006d RBX: 1ffff1100bef2201 RCX: bc1d858b0da16200
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc90003c8fcb0 R08: ffffffff81a114cc R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffff88805f791008
R13: dffffc0000000000 R14: ffff88805f791000 R15: ffff88802029a200
FS:  000055556c140500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c009736000 CR3: 000000005e410000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 ref_tracker_free+0x3e6/0x7e0 lib/ref_tracker.c:265
 __netns_tracker_free include/net/net_namespace.h:371 [inline]
 put_net_track include/net/net_namespace.h:386 [inline]
 __sk_destruct+0x3f5/0x690 net/core/sock.c:2307
 sock_put include/net/sock.h:1914 [inline]
 unix_release_sock+0xa70/0xd00 net/unix/af_unix.c:727
 unix_release+0x91/0xc0 net/unix/af_unix.c:1106
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1398
 __fput+0x3e9/0x9f0 fs/file_table.c:464
 __do_sys_close fs/open.c:1580 [inline]
 __se_sys_close fs/open.c:1565 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1565
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9cd538c8c7
Code: 44 00 00 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb bc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff090c5388 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f9cd538c8c7
RDX: 0000000000000000 RSI: 0000000000008933 RDI: 0000000000000005
RBP: 00007fff090c5390 R08: 000000000000000a R09: 00007fff090c53c2
R10: 00007fff090c57c6 R11: 0000000000000246 R12: 00007fff090c5410
R13: 00007f9cd540f3b5 R14: 00007f9cd60d4620 R15: 00007f9cd540f3b5
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x18c/0x190 lib/list_debug.c:65
Code: fa 89 10 fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 bb 0e 32 fd 49 8b 56 08 48 c7 c7 00 21 80 8c 4c 89 fe 4c 89 f1 e8 a5 9d 32 fc 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
RSP: 0018:ffffc90003c8fb50 EFLAGS: 00010046
RAX: 000000000000006d RBX: 1ffff1100bef2201 RCX: bc1d858b0da16200
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffffc90003c8fcb0 R08: ffffffff81a114cc R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffff88805f791008
R13: dffffc0000000000 R14: ffff88805f791000 R15: ffff88802029a200
FS:  000055556c140500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c009736000 CR3: 000000005e410000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

