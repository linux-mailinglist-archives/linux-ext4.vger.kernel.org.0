Return-Path: <linux-ext4+bounces-7084-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8664A7D2BA
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 05:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A6E188DC99
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 03:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8A221DA6;
	Mon,  7 Apr 2025 03:57:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90586213256
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 03:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743998247; cv=none; b=ucMSWTz0xApHs6HWxmLdAgI/MwOwKFIvAzHjB0bpC6cUt41da9w5aMP/fI5oOG/oYGZqOvq+vzs1J/Uh50GvaLalF7vaJiO03cLE//vICQQaFP5VwFJ2Gb/UiOfhkPC/86eG7J834hrQJgtbB2J91Zbjdbd8udFF36KfN90t8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743998247; c=relaxed/simple;
	bh=wGLK6m9CzNM2EuVft9Fawq866DDFGdirphfng8/RcDI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SpahIdPdCzsmHo/L05/3YUTVhQqnV0RNVAWxu7sttOxTWY2z6m8OrMvvDsfB3t08QmEV7G2GCebFs8PMThOuDEsNNNnNge7q1sGXJLTB9bswZndYlS1GrcujIamy/LnnCPrzz4GCNrOnyBF+l9LwM6IDRP5/iqpopfHSXf4l7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85e7f5129d5so341645639f.0
        for <linux-ext4@vger.kernel.org>; Sun, 06 Apr 2025 20:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743998244; x=1744603044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKzLutUCNaIzSgschoETKEDm1mOKKBzsstahLbLQNSY=;
        b=QjEMtIg8d8Z5rMpPb5+vXlgMOYLGriq8vAPFs3maZeIHyznQFAfAhG4bnXCxBT661l
         /P6FMQK3bqP0oUVeudWqyQZnXuBwJj9DSCvD6QWneS50HlCc+g/t2JncrXZytl6YWBut
         oklBToMjqebBZqL6w19KOM/2Z2cbvFWD/erG3FXF4k5k1kG48zZmQVulqcCXhtum904G
         2FvPHR/0VByG+MKhFp5VSU82eS+AHoXKzMR/XJ8WxnKb71fU7hC9ZhI6YVmNLCNJFTL1
         h2UhWqgAkjIjZKDgN2n/p1reV6mhqtzQ2/Zkc0mTLh0QoGchtPDB/z/N6GDX/sjWoseZ
         3qAw==
X-Forwarded-Encrypted: i=1; AJvYcCVKkkSHOlr3aml+K53VnqiPFRvV3Gx55IBcgk/af5qE9WJQLObIWQsnGC4FQbBin3YFbZdJ1wW4kRE7@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHouDNxTUByN0McyTYZ2SGQhXu+qyBXJ+d1K37GpipY7PPs8J
	vOLDLVH1XlVA1Te/B/JBH3fJZ+lYjTEj1Q8eUdhd0ZEwGy/PI0GFlF29q9cE7KD4nSKdLyipDQw
	d5mT93OxFri1LarluX5LKx4c0p6V1uUyyG2XMIZsZlis4qPk9Vn2d6OM=
X-Google-Smtp-Source: AGHT+IEj3DJK9Q0Ai2Iz8F3ii81wS4KN558dK+KHwRRLf4upHyxOti907c8PHes02vpuNfEMXs1iY0RRwrtIV6biPBFkndXpyY64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338d:b0:3d3:ff09:432c with SMTP id
 e9e14a558f8ab-3d6e3eea064mr121332535ab.4.1743998244558; Sun, 06 Apr 2025
 20:57:24 -0700 (PDT)
Date: Sun, 06 Apr 2025 20:57:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f34d24.050a0220.0a13.027c.GAE@google.com>
Subject: [syzbot] [ext4?] [overlayfs?] WARNING in file_seek_cur_needs_f_lock
From: syzbot <syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, amir73il@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    16cd1c265776 Merge tag 'timers-cleanups-2025-04-06' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e7923f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79406130aa88d22
dashboard link: https://syzkaller.appspot.com/bug?extid=4036165fc595a74b09b2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f9bd98580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1571c7e4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4435e7379c4/disk-16cd1c26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a00533ae7ab/vmlinux-16cd1c26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2069327dcea6/bzImage-16cd1c26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5824 at fs/file.c:1201 file_seek_cur_needs_f_lock+0x141/0x190 fs/file.c:1201
Modules linked in:
CPU: 0 UID: 0 PID: 5824 Comm: syz-executor625 Not tainted 6.14.0-syzkaller-13546-g16cd1c265776 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:file_seek_cur_needs_f_lock+0x141/0x190 fs/file.c:1201
Code: 31 ff 89 c3 89 c6 e8 0e 9e 7f ff 84 db 74 15 e8 25 a3 7f ff bb 01 00 00 00 89 d8 5b 5d 41 5c c3 cc cc cc cc e8 10 a3 7f ff 90 <0f> 0b 90 eb e0 e8 05 a3 7f ff 31 db 89 d8 5b 5d 41 5c c3 cc cc cc
RSP: 0018:ffffc90002f07df8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff823b9ae2
RDX: ffff888031808000 RSI: ffffffff823b9b00 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: bfffffffffffffff
R13: 0000000000000005 R14: 00000ffffffff000 R15: 00000ffffffff000
FS:  00005555717cf380(0000) GS:ffff8881249b3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001000 CR3: 0000000026d60000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 generic_file_llseek_size+0x153/0x480 fs/read_write.c:178
 ext4_llseek+0x180/0x2f0 fs/ext4/file.c:941
 vfs_llseek+0x9a/0xe0 fs/read_write.c:387
 ovl_llseek+0x15c/0x2c0 fs/overlayfs/file.c:277
 vfs_llseek fs/read_write.c:387 [inline]
 ksys_lseek+0xf0/0x1b0 fs/read_write.c:400
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc41bae4a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc49e17ef8 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 0000200000000140 RCX: 00007fdc41bae4a9
RDX: 0000000000000001 RSI: 0000000000000005 RDI: 0000000000000003
RBP: 00007fdc41c21610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc49e180c8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

