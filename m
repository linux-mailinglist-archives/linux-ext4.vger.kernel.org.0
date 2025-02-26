Return-Path: <linux-ext4+bounces-6576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C427BA45C0E
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C627717233C
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2025 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF324E00C;
	Wed, 26 Feb 2025 10:43:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2E2459D5
	for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2025 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566604; cv=none; b=EiE44ZDekE2ksjX43dNmjD6Q5EMoVHNZwXr5lXNl11G0UupyQ3W9Kl4rnS9eQa6keLOJCUbhy+UOAXuGuMxKek2ba2vlE+EvmvOk3Uyvpi0L1FF4Wt5C8drF1gx0EmBHPmbyqfCVJ5gUenNFPZvA6dwnm220HjjEGhGR33yrSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566604; c=relaxed/simple;
	bh=/1D2hWZ33Wvm8tZchRpvwsmFkPCAijJoSs7d8EyqLjg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NFwZNwhAaZYTt3hUbr6J8FlIYXzbKeoTkqunknrmhYSTs0Jup74Ux8W+WVcw5HkoGzV18GHtT4uyvw5ifiiag54CYexPu00WyBOP058EYbbOl60REnAfmB8+ty/wlxkh4hJu09wSwnYvHfYHkwYoY+ub+PfAHcLYkq6zbMcUTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d289bf6c39so5554905ab.1
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2025 02:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566602; x=1741171402;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLamul0Qy1bSNuPWUSE2AWn8j3h3sPf3L6/qyPeSfR8=;
        b=OJ5xqQ3Vm/7Ab4x8Jff0abBOCAhJXCDxGvBDHsG1MoLr8O3xYsRrqXzX4r8g+VyITR
         4kApf7RwaDyDs8mxmMwkPCUwBOPG/t0IAJ2YU8OteBb95MhOYPHNWZypOiQImrbxQKVH
         jmECTF2lljYh1Ab2bHjRao2llfQVjZDHZHkAfouOVVz160dZkL69LaYmv1y6MVyh2pAb
         7FzcyZgS4ZVOg/sBMPXfUUIJIO6md1VDzNTtfIWsYCoYwj+nRtZ7AqJGT9UTRTn4ozKf
         Et0Ayq9fQDCpRbEjkDdB1F9NPOLeG0eLqj9wWLYIl6oyxYHzZru+FRqgfjt1Y20TG9Gl
         B+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtPLe9l4CL6PIu597HC6OIZ6WPSLVVVqifaND+dD+/vjymMqudf3KJ5d5RSUuMZswtEZqSq8KUlKuP@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzibfEDLiOuMjirjFO0Rx6Rhc3Q1LouHDbjQe4DFNxVHg7qPb
	Ln8gTX8IizAGLoAfNZPxc92v0mVpBzn4MVP85BYgUWJsN9zc8CK+9mOK2GgoaSIlLtas8iRjcYd
	/nFnzmxTWNjTjpRvw2Xy/GK+rUUne5xuvbmourYp5Timoho3ckrfXX3M=
X-Google-Smtp-Source: AGHT+IEozNnp1RtmNrcxO3YpCynOBqGVr75Ha2A7UsRZoGZ85WoOwK1VOHFxodkoYYhmcdFTIg3Tv6nG2Vgy81FdzccUMzmPTSz9
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cb4e:0:b0:3d1:84ad:165e with SMTP id
 e9e14a558f8ab-3d2c020ccabmr203896295ab.7.1740566601966; Wed, 26 Feb 2025
 02:43:21 -0800 (PST)
Date: Wed, 26 Feb 2025 02:43:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bef049.050a0220.38b081.00ef.GAE@google.com>
Subject: [syzbot] [mm?] [ext4?] WARNING in get_dump_page
From: syzbot <syzbot+0b544778e9923a3de766@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, cem@kernel.org, 
	clm@fb.com, djwong@kernel.org, dsterba@suse.com, jack@suse.cz, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=107eec98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=0b544778e9923a3de766
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176626e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147eec98580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1e5dabe499e7/disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e0f27be469a/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e058c08d6c9/bzImage-d082ecbc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/24600c6adfb8/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=16397fdf980000)

The issue was bisected to:

commit 5121711eb8dbcbed70b1db429a4665f413844164
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Fri Nov 15 15:30:32 2024 +0000

    fs: enable pre-content events on supported file systems

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ae1db0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12ae1db0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14ae1db0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b544778e9923a3de766@syzkaller.appspotmail.com
Fixes: 5121711eb8db ("fs: enable pre-content events on supported file systems")

WARNING: CPU: 0 PID: 5840 at mm/gup.c:1856 __get_user_pages_locked mm/gup.c:1856 [inline]
WARNING: CPU: 0 PID: 5840 at mm/gup.c:1856 get_dump_page+0x242/0x2f0 mm/gup.c:2275
Modules linked in:
CPU: 0 UID: 0 PID: 5840 Comm: syz-executor267 Not tainted 6.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:__get_user_pages_locked mm/gup.c:1856 [inline]
RIP: 0010:get_dump_page+0x242/0x2f0 mm/gup.c:2275
Code: 00 00 00 48 3b 8c 24 80 00 00 00 0f 85 a3 00 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 1f 37 03 ff e8 0f b4 b4 ff 90 <0f> 0b 90 eb ae 44 89 c9 80 e1 07 80 c1 03 38 c1 0f 8c db fe ff ff
RSP: 0018:ffffc900032c7180 EFLAGS: 00010293
RAX: ffffffff820d09f1 RBX: 0000000000000000 RCX: ffff8880346f0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900032c7250 R08: ffffffff820d0968 R09: 1ffffd4000399126
R10: dffffc0000000000 R11: fffff94000399127 R12: 1ffff92000658e38
R13: dffffc0000000000 R14: 1ffff92000658e34 R15: 0000000000000000
FS:  0000555587160380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff9150b8f8 CR3: 0000000075dae000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 dump_user_range+0x14d/0x970 fs/coredump.c:943
 elf_core_dump+0x4054/0x4a80 fs/binfmt_elf.c:2129
 do_coredump+0x232c/0x32c0 fs/coredump.c:758
 get_signal+0x13e5/0x1720 kernel/signal.c:3021
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 irqentry_exit_to_user_mode+0x7e/0x250 kernel/entry/common.c:231
 exc_page_fault+0x590/0x8b0 arch/x86/mm/fault.c:1541
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7ff653b312d1
Code: c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:00000000fffffe10 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007ff653b312c9
RDX: 0000000000000000 RSI: 00000000fffffe10 RDI: 0000000000000000
RBP: 00007fff9150b940 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 00007ff653b7f9dc R14: 00007ff653b7a0e2 R15: 00007fff9150b930
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

