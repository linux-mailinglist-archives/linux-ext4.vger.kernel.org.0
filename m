Return-Path: <linux-ext4+bounces-3871-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9895C1BC
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2591C22FB8
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8AC79D2;
	Fri, 23 Aug 2024 00:00:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7633800
	for <linux-ext4@vger.kernel.org>; Fri, 23 Aug 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371229; cv=none; b=r3Ig8XrpxVylBz++IcZoZL5TM2jk5SlIrn0IbmdOWlGoMxU9ZoJ6PN1WhrVlycKHpIjcD03jmrywF4I8mupwA8+p1E0MmSZTVE2cLn3gWvMSF5SLmi/UpX3uKT89Z1FuH61wsc45fz1zzaoDsNdU3t9fHcgofLzbf3F6cIwmwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371229; c=relaxed/simple;
	bh=GX+vAFBQPMRb4ioEULW38ZYKLzt2D67aw/7WqZOQakI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CGMDVejDUBh3iCpxH3ntD2Yt3x+aBe67S4euRwi2nQruDNXEP0BtT2TL0ZTzhQj3iZHCAQTjGmOUolr4iV+O8LturkfZWBiKYiVJ46s3WoCIi7hKSsSbvcBcbUuRHc7y2om6AuhxAKmGpXhteO4GYQy4W+IC/AXH5yIiuu79Zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d2dbd9bebso19735355ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2024 17:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371227; x=1724976027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JOPpQ7a4Yvwd1RmC/w/uZSVRjCnYJKOpFwEzKsFw7j0=;
        b=FczjD8TRka0SjA7njvTKGBskD7O29/seELJdLFoxDsJqD7rZp39xxidBszufEFOCHG
         geUgIhi7hS5wSyW9m/YDfOugoGicsbWzx3tb0PgFOi+5VqQiojYrZ7pJME9Y/WjBIQWN
         ntzu1f95c7De7aVtOfe2zo0QwKlK7qLjLz0dLnBLMB66APmBO9hiOqETq5Fylgc37nOL
         snzo5NGp731KPnJszNsCYJky98OcB8BfjASFW30C7XTF8iVl7iOhfuysGFCCnQWoy1Jt
         YoAz3X0EorJsJqHl1qgFpnLBX9xEP9bEhvqkXTuT84Jkjz4FS1zG9PWieaEittD8HCy6
         IzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX22qtt2w5Juo/fh3dPK4lmKq6P6DsOV1o9bzmOKFqxvbITQRSYE6TQ3u0RfhXRwcc7InSnNV29KUha@vger.kernel.org
X-Gm-Message-State: AOJu0YxcaLc79sqYfmA41N8fL7Q7PaOvuiyTkHVePNvZ/h5tDcKrVa+L
	NEgbH32MvxyxB3VaFS+8shWEVPe8y5c+t7I2XhtKvDnFthouzNkdSPcxfZzkKBCM1ZWzPIq7hLA
	hCvLcQMerz4cTg5MpuANnlVFZJVSVzLVvWspcEBarplsJGm4r0kP98u8=
X-Google-Smtp-Source: AGHT+IFMMQ/bjTQQ01pDKJLOXG6Y/PlpbLQd57NDsO2gbEdnRLz0ymf89vy36QujbK9n2k7aCN7dIhr2cRHqMmzNoQU0Ml540MTn
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c546:0:b0:39d:4d70:7782 with SMTP id
 e9e14a558f8ab-39e3c9f3985mr173015ab.4.1724371226891; Thu, 22 Aug 2024
 17:00:26 -0700 (PDT)
Date: Thu, 22 Aug 2024 17:00:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070a66706204e7698@google.com>
Subject: [syzbot] [ext4?] [ocfs2?] kernel BUG in jbd2_cleanup_journal_tail
From: syzbot <syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com>
To: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f2d783a459 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ba0fcb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=8512f3dbd96253ffbe27
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a1fc09980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11da5cfd980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c3f2d783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d927f7c3cfd/vmlinux-c3f2d783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea54bdfad24b/bzImage-c3f2d783.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ec5187e2b71d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com

(syz-executor675,5099,0):ocfs2_check_volume:2425 ERROR: ocfs2 journal load failed! -22
(syz-executor675,5099,0):ocfs2_check_volume:2481 ERROR: status = -22
(syz-executor675,5099,0):ocfs2_mount_volume:1821 ERROR: status = -22
------------[ cut here ]------------
kernel BUG at fs/jbd2/checkpoint.c:321!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5099 Comm: syz-executor675 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jbd2_cleanup_journal_tail+0x2bf/0x2d0 fs/jbd2/checkpoint.c:321
Code: 24 40 80 e1 07 80 c1 03 38 c1 0f 8c 65 ff ff ff 48 8d 7c 24 40 e8 51 4d 8a ff e9 56 ff ff ff e8 57 1a 46 09 e8 a2 0b 23 ff 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90000e36d60 EFLAGS: 00010293
RAX: ffffffff82707f4e RBX: 0000000000000000 RCX: ffff88801a738000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000e36e30 R08: ffffffff82707dd7 R09: 1ffff11003709c16
R10: dffffc0000000000 R11: ffffed1003709c17 R12: 1ffff920001c6db0
R13: ffff88801b84e000 R14: 1ffff920001c6db6 R15: 1ffff11003709c00
FS:  000055555d18e380(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f251d195ed8 CR3: 000000001bee4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jbd2_journal_flush+0x290/0xc10 fs/jbd2/journal.c:2479
 ocfs2_journal_shutdown+0x443/0xbe0 fs/ocfs2/journal.c:1081
 ocfs2_mount_volume+0x169f/0x1940 fs/ocfs2/super.c:1842
 ocfs2_fill_super+0x483b/0x5880 fs/ocfs2/super.c:1084
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f15c3ba9dea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0f1577b8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc0f1577d0 RCX: 00007f15c3ba9dea
RDX: 0000000020004440 RSI: 0000000020000040 RDI: 00007ffc0f1577d0
RBP: 0000000000000004 R08: 00007ffc0f157810 R09: 0000000000004424
R10: 00000000000008c0 R11: 0000000000000282 R12: 00000000000008c0
R13: 00007ffc0f157810 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jbd2_cleanup_journal_tail+0x2bf/0x2d0 fs/jbd2/checkpoint.c:321
Code: 24 40 80 e1 07 80 c1 03 38 c1 0f 8c 65 ff ff ff 48 8d 7c 24 40 e8 51 4d 8a ff e9 56 ff ff ff e8 57 1a 46 09 e8 a2 0b 23 ff 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90000e36d60 EFLAGS: 00010293
RAX: ffffffff82707f4e RBX: 0000000000000000 RCX: ffff88801a738000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000e36e30 R08: ffffffff82707dd7 R09: 1ffff11003709c16
R10: dffffc0000000000 R11: ffffed1003709c17 R12: 1ffff920001c6db0
R13: ffff88801b84e000 R14: 1ffff920001c6db6 R15: 1ffff11003709c00
FS:  000055555d18e380(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f251d195ed8 CR3: 000000001bee4000 CR4: 0000000000350ef0
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

