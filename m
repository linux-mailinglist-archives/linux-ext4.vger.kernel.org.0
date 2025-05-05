Return-Path: <linux-ext4+bounces-7709-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C7AAB86B
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 08:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FCC3AF308
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D958290DA9;
	Tue,  6 May 2025 01:19:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812A290D95
	for <linux-ext4@vger.kernel.org>; Mon,  5 May 2025 23:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489207; cv=none; b=MigvoD7bDucyzx9B8qs3ydUSk5r+KH9vPYsBiknuCo64soM4c2JCstfli3Rybaf7c+8oidkittd9z7olqdIAqaRTL8ECfFza+ONrNyCrThSoTQzfnW/Pw3uinslqwykCKoJSrpBuLy1NFBLwZJOSk9Ml1EwtrY3lOTvTMriRPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489207; c=relaxed/simple;
	bh=4szCwPKUAWPCALZNQCt1FT3sTgBhoRie1V8vTB4SGZo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P1GKNbmk6Nk8z9qO0MiLgJTPTRIZ5vZFCuZ/R02spFngZc9Hhy5VbpDd0wXXPvYtPkq0LU0+QiQKahWbb09JctDoT5+fAYoMcyciJHs7cnOAokEjjvyi5dFsqJwDljtvB7vSg+Sy/uPSM0BiGDBXDK3IaF76Nnm1iIrgtCJ2fnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d94fe1037cso65548045ab.0
        for <linux-ext4@vger.kernel.org>; Mon, 05 May 2025 16:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746489203; x=1747094003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVvfQB2gd1o++AE5Iug9x1lhI2tv16s5HMfxraXsjOc=;
        b=qZY3Jww9A6iRrGOseik2P9u0DwUutCdUBeTMv9JexCcGvhz/ivolBemqzfv1RLagM0
         bOJD/BhAYGRXJ1O2EFkZOrRn2b7En73XgZ6Cw8dfrAGOmChaUlSX3q/SHJca9EN/yUMp
         V8vOk0avUIfABifbmLcNeQx8Jfk7TUhNbX6u0MsD5s/qP4CsLGIGUfH9LxBmjdFwlQ8P
         Pm+CiCl2ihYpOfxzf2xmSFMTjBwrF4iuy9Hm2n2NBb2bxz7nSzsEluoEMl2JVF/qhFOD
         WV3GTqe+qitFrF4SqRE3dj5OspjO47FfxwazVdK/VbMiF1e4BarizNvE0Y1Pr7MdWe2I
         Zaew==
X-Forwarded-Encrypted: i=1; AJvYcCV2x9Zfobhre0xxlgE0euPkJM61M6bLV1EnXt3FtwG5JHV2074ZHybu/HrxoeUYyoqR81qfINqCUYCN@vger.kernel.org
X-Gm-Message-State: AOJu0YwyExlYtgL9ggyYLRzyMoe1fqa4UI4ZsRIpW5JuKOjGrlcj67Dn
	wPUkRkvkYp1tD5zXSxYQBTNGqFSxFMXdLY44RARrjm0/loRy64ePyts2bFShO49E2bQg3d53t1z
	ZfdWEx/XdHHcmTYPIC5IWCDgPKSltZS6deGTgTI8WIIo3aAf5wddTYZ8=
X-Google-Smtp-Source: AGHT+IHFWRP2ubrDOHG2yQxffmplmBna/WWvzM/wBGg1xiw1HNcYYS4LHSGpsBSYKjmOrTiRUb30nVJ2Pn8USxw1fDGeQFGLso/O
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:3d8:7a02:a67b with SMTP id
 e9e14a558f8ab-3da6cdd6201mr14788035ab.8.1746489203173; Mon, 05 May 2025
 16:53:23 -0700 (PDT)
Date: Mon, 05 May 2025 16:53:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68194f73.050a0220.a19a9.0005.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_mb_normalize_request
From: syzbot <syzbot+7fc5cde5fbe19897a469@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f79eaa2ceac kbuild: Properly disable -Wunterminated-strin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148b3774580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42a9d552788177b
dashboard link: https://syzkaller.appspot.com/bug?extid=7fc5cde5fbe19897a469
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/edbf5e3df590/disk-4f79eaa2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9ed2fe174f6/vmlinux-4f79eaa2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c11b2a37db5c/bzImage-4f79eaa2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fc5cde5fbe19897a469@syzkaller.appspotmail.com

EXT4-fs: Ignoring removed nobh option
EXT4-fs: Ignoring removed bh option
EXT4-fs (loop9): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
EXT4-fs (loop9): start 0, size 131072, fe_logical 131136
------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:4555!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 8509 Comm: syz.9.234 Not tainted 6.15.0-rc4-syzkaller-00052-g4f79eaa2ceac #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:ext4_mb_normalize_request+0x1cc9/0x1d00 fs/ext4/mballoc.c:4555
Code: f5 ac ff 48 8b 44 24 38 48 8b 38 48 c7 c6 80 37 7e 8b 48 c7 c2 80 4d 7e 8b 48 8b 4c 24 28 4d 89 f0 49 89 d9 e8 38 a5 09 00 90 <0f> 0b e8 60 26 4d ff 90 0f 0b e8 58 26 4d ff 90 0f 0b e8 50 26 4d
RSP: 0018:ffffc9000496ed40 EFLAGS: 00010246
RAX: a8a732223c46f100 RBX: 0000000000020040 RCX: a8a732223c46f100
RDX: ffffc9000dd70000 RSI: 0000000000023bd3 RDI: 0000000000023bd4
RBP: 0000000000000000 R08: ffffc9000496e8e7 R09: 1ffff9200092dd1c
R10: dffffc0000000000 R11: fffff5200092dd1d R12: ffffffff00020800
R13: dffffc0000000000 R14: 0000000000020000 R15: 0000000000020000
FS:  00007fec5d95a6c0(0000) GS:ffff888126200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9695f6e270 CR3: 00000000207e0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_new_blocks+0xc59/0x46a0 fs/ext4/mballoc.c:6208
 ext4_ext_map_blocks+0x1618/0x67c0 fs/ext4/extents.c:4379
 ext4_map_create_blocks fs/ext4/inode.c:520 [inline]
 ext4_map_blocks+0x807/0x1740 fs/ext4/inode.c:706
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:785
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:818
 ext4_block_write_begin+0x543/0x1290 fs/ext4/inode.c:1067
 ext4_write_begin+0x6f6/0x12c0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x33a/0xa60 fs/ext4/inode.c:2932
 generic_perform_write+0x2c4/0x910 mm/filemap.c:4103
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x548/0xa90 fs/read_write.c:684
 ksys_pwrite64 fs/read_write.c:791 [inline]
 __do_sys_pwrite64 fs/read_write.c:799 [inline]
 __se_sys_pwrite64 fs/read_write.c:796 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:796
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec5cb8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec5d95a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007fec5cdb6080 RCX: 00007fec5cb8e969
RDX: 00000000000155c2 RSI: 0000200000000140 RDI: 000000000000000a
RBP: 00007fec5cc10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008000c64 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fec5cdb6080 R15: 00007fffed56a588
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_normalize_request+0x1cc9/0x1d00 fs/ext4/mballoc.c:4555
Code: f5 ac ff 48 8b 44 24 38 48 8b 38 48 c7 c6 80 37 7e 8b 48 c7 c2 80 4d 7e 8b 48 8b 4c 24 28 4d 89 f0 49 89 d9 e8 38 a5 09 00 90 <0f> 0b e8 60 26 4d ff 90 0f 0b e8 58 26 4d ff 90 0f 0b e8 50 26 4d
RSP: 0018:ffffc9000496ed40 EFLAGS: 00010246
RAX: a8a732223c46f100 RBX: 0000000000020040 RCX: a8a732223c46f100
RDX: ffffc9000dd70000 RSI: 0000000000023bd3 RDI: 0000000000023bd4
RBP: 0000000000000000 R08: ffffc9000496e8e7 R09: 1ffff9200092dd1c
R10: dffffc0000000000 R11: fffff5200092dd1d R12: ffffffff00020800
R13: dffffc0000000000 R14: 0000000000020000 R15: 0000000000020000
FS:  00007fec5d95a6c0(0000) GS:ffff888126200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562fcaf64131 CR3: 00000000207e0000 CR4: 00000000003526f0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

