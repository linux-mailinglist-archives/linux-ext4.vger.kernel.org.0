Return-Path: <linux-ext4+bounces-7514-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF5A9E0C8
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Apr 2025 10:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1248D3B265E
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Apr 2025 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D62475C7;
	Sun, 27 Apr 2025 08:21:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D01DE2D8
	for <linux-ext4@vger.kernel.org>; Sun, 27 Apr 2025 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745742085; cv=none; b=GZMWHJSC7xWHPgHHLiM/0IyGmlu0ONO0VPOxnbKiTKUMs207c9xfhRPp+mzPWux4sMvDYPEVmmpiBKuQuH859YeS63qJiPbl9dzUidyv/8ZrJxPPs5+POjUUv7sLzTXhX/s1QB9Sg+AsFq17FZ4Nq0ANwdeyuqCtjLNq9SXVXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745742085; c=relaxed/simple;
	bh=buMXtnro85aLbJ8vzlE+WVBcMzVVJdOoueenXL85wUI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OLEIEj/VMAGFQR/lo73nDJKa7qPW27JmaoTFyi4Q5H0S9dN5z/TpFjaPB3H5+8BFv9t84IVsyXdWM0Naqc8yYZ8GvPBT4Let4Tv4stVCUmv9PyL6HeBsmbsSnLPGWMQmUmjQe2gb885IwUJ1vBARplgoCEeLF0LutZFS3iUl38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b5875e250so433764439f.0
        for <linux-ext4@vger.kernel.org>; Sun, 27 Apr 2025 01:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745742082; x=1746346882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vAf/JFA/8xW4355KhkGlJwhLhf96j10N4gFAjUa7/E=;
        b=jmnEpRHNa4VXKKPz5JsFqMFOvtCaCzl/eF5JbgvqpxXW7ebUyBiWuYHuwB7uquihpe
         lJLqNdWA+a1skNG8zT476aK22wn8XGaUc3S0IzdYsWWprzlc/nzPmZLLXhqmcG30yRFq
         TXRBqQ+8oQTWAfkIO6TwYHkXmNrDnHO8J/I88kPKvhq2KBODK7f6nnZuzbKXRIZRv1GC
         yr+BEt9hkKPegOHXimw/RSo/qJOEBGJNUjks6FjG0BiG5VkKTCPu/jkX8u1Cx8MOzKJ6
         37sCWJvedX/AiVJxZiyLYXUG3fXQlDBwmqeC/4rtcL3zqx827nv1GXFJjJw589xKVLOr
         zKSA==
X-Forwarded-Encrypted: i=1; AJvYcCXOXePFYKhkuD1bVRDnqNb4jaaebPAmeBuwMcGRP4k0PQ2kc3URRuZBkosNyeF3HQ8h79krVtZJiTJl@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHPr9WZzQxCCS5cUrQOFNfC1aLd0HnzmMl3ubnhxYuOc17vVk
	ve2lfwiZGwEwGexCiY5mUDER1CtC8CSEOIM/xZXEx1vA8GiLa7gnacfNrMe+ACY+N14zLeD5W5D
	oY5eBN4bTANvVBcJqZ+jJnwO+O0J3juK5PzlScsCgsTDNdZcIGjLWa/I=
X-Google-Smtp-Source: AGHT+IGE7hEw88NJG3K6Qu+an7B7jyY6Me8dPkz4tLYNe3C6IrTsSxcikrvR7eDOrshYhqZ7dVNPNAvG4BlInsb2fOMtRDDeBa2k
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0b:b0:864:48eb:30fd with SMTP id
 ca18e2360f4ac-8645cd45231mr786974639f.11.1745742082674; Sun, 27 Apr 2025
 01:21:22 -0700 (PDT)
Date: Sun, 27 Apr 2025 01:21:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680de902.050a0220.3b8549.0081.GAE@google.com>
Subject: [syzbot] [ext4?] general protection fault in jbd2_journal_dirty_metadata
From: syzbot <syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12730374580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90837c100b88a636
dashboard link: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149e6270580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-5bc10186.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a2f39285e07/vmlinux-5bc10186.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a37a55f34fb/bzImage-5bc10186.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/852ff332bbf1/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=14730374580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/e42a022d555a/mount_9.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/7cbdc25f298f/mount_13.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=109e6270580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com

(syz.0.497,7529,0):ocfs2_xa_prepare_entry:2151 ERROR: status = -30
(syz.0.497,7529,0):ocfs2_xa_set:2254 ERROR: status = -30
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 7529 Comm: syz.0.497 Not tainted 6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jbd2_journal_dirty_metadata+0x234/0xcd0 fs/jbd2/transaction.c:1531
Code: 74 08 4c 89 ff e8 ec a5 9c ff 4d 39 37 0f 84 49 01 00 00 e8 de b0 3a ff 31 c0 e9 5e 05 00 00 4c 8b 34 24 4c 89 f0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 f7 e8 be a5 9c ff 49 8b 06 48 89 44 24 38
RSP: 0018:ffffc9000d47ec18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88801f980000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff888043abc420 R08: ffff888043aacd9f R09: 1ffff110087559b3
R10: dffffc0000000000 R11: ffffed10087559b4 R12: 1ffff1100382e0df
R13: 1ffff11008757884 R14: 0000000000000000 R15: 1ffff1100382e0dc
FS:  00007f9939c2b6c0(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5fec172720 CR3: 000000004e785000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_journal_dirty+0x149/0x740 fs/ocfs2/journal.c:812
 ocfs2_xa_journal_dirty fs/ocfs2/xattr.c:1453 [inline]
 ocfs2_xa_set+0x2516/0x3050 fs/ocfs2/xattr.c:2263
 ocfs2_xattr_block_set+0x3c4/0x2bc0 fs/ocfs2/xattr.c:2985
 __ocfs2_xattr_set_handle+0x661/0xf20 fs/ocfs2/xattr.c:3387
 ocfs2_xattr_set+0xde8/0x11f0 fs/ocfs2/xattr.c:3650
 __vfs_setxattr+0x439/0x480 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:234
 vfs_setxattr+0x16b/0x2f0 fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 filename_setxattr+0x274/0x600 fs/xattr.c:665
 path_setxattrat+0x364/0x3a0 fs/xattr.c:713
 __do_sys_setxattr fs/xattr.c:747 [inline]
 __se_sys_setxattr fs/xattr.c:743 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9938d8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9939c2b038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007f9938fb6160 RCX: 00007f9938d8e969
RDX: 0000200000000240 RSI: 0000200000000140 RDI: 0000200000000080
RBP: 00007f9938e10ab1 R08: 0000000000000002 R09: 0000000000000000
R10: 000000000000001e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9938fb6160 R15: 00007fff798d5618
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jbd2_journal_dirty_metadata+0x234/0xcd0 fs/jbd2/transaction.c:1531
Code: 74 08 4c 89 ff e8 ec a5 9c ff 4d 39 37 0f 84 49 01 00 00 e8 de b0 3a ff 31 c0 e9 5e 05 00 00 4c 8b 34 24 4c 89 f0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 f7 e8 be a5 9c ff 49 8b 06 48 89 44 24 38
RSP: 0018:ffffc9000d47ec18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff88801f980000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff888043abc420 R08: ffff888043aacd9f R09: 1ffff110087559b3
R10: dffffc0000000000 R11: ffffed10087559b4 R12: 1ffff1100382e0df
R13: 1ffff11008757884 R14: 0000000000000000 R15: 1ffff1100382e0dc
FS:  00007f9939c2b6c0(0000) GS:ffff88808d6cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000940c71 CR3: 000000004e785000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	74 08                	je     0xa
   2:	4c 89 ff             	mov    %r15,%rdi
   5:	e8 ec a5 9c ff       	call   0xff9ca5f6
   a:	4d 39 37             	cmp    %r14,(%r15)
   d:	0f 84 49 01 00 00    	je     0x15c
  13:	e8 de b0 3a ff       	call   0xff3ab0f6
  18:	31 c0                	xor    %eax,%eax
  1a:	e9 5e 05 00 00       	jmp    0x57d
  1f:	4c 8b 34 24          	mov    (%rsp),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 be a5 9c ff       	call   0xff9ca5f6
  38:	49 8b 06             	mov    (%r14),%rax
  3b:	48 89 44 24 38       	mov    %rax,0x38(%rsp)


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

