Return-Path: <linux-ext4+bounces-6245-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE6A1DC4C
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2025 19:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FBE165988
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39F190472;
	Mon, 27 Jan 2025 18:57:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302A18FDBD
	for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2025 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738004249; cv=none; b=k7n6ohN+qEHqDjJ32YFVE9PIRdj/MhbZSi64LpantMn9uQcjXiGU3+yyY6CjXGK7EEsQqqBMImZanMs1EG48GrXTZnXmsUrjIU1Q9vJvYIm8kPIOCiY113MPWyRsAMH9qpJHLFtNf75s9iiHyGs5BjTO5g5au+LJ6UYRROoGdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738004249; c=relaxed/simple;
	bh=Irbtvuv3M4iQhQ87ABPC4S+AQ5W12yrTGIMJa66tOos=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BuBohXZsrA0pBAT70mMSxvt+mkDJwG5FQBF/7hORMNLWWIvYSwXWSOCJU7o9wSvza4TSAasuZlUGfGtbGVmDGr+/Lvek9MZ/odyqq5BJsL113WCmLyNNfC0Hj49X84YJsa+l3nXUaqxj3y5gsn4/seihyFF6kGGJTmfktj2P/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce7c75cae9so39935365ab.1
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2025 10:57:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738004246; x=1738609046;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ce4Jel8k5YTpetQniWt3z9fHjK1qO5A/34EZW4fq8po=;
        b=IpweKfUb9aPDVrkLbR7MNpLrhckNhbO72ac1qlBcJdjL6umBUaebLFRZWJ8QmqDit7
         gqHzAQBpuQQ2T0CjbtbyNEIJHT9p2GKyjjOXIRnB1jW9n9ZgXHVm9yykQB8kM8aN1ZNs
         mynk0DNw+EPVWdulgYP5L3BmDwes5Kn6Auz424xEnMsaRKhrYnyz4CvDFIwX6+j+wNeO
         wrW7yAZ3vQ5nt9duQh6HZsKG0doFX25C3xxIVKFEjdGMsOrpDeIrjNpxRgNjlIulxdTp
         hyTbn3V+4PQSt4hDNREO3WE3J2WpfqZ1YZasRlGzf/llTyn8cOSIBnF1BPVz7+CTBiKu
         hi9w==
X-Forwarded-Encrypted: i=1; AJvYcCV0aEkPZLXljKzR7KJ9Oz07GnKVd4hUO/qqRTHhsrWNUJtF4McxmQdij05zAi466zwmqZX2U7X6fjBr@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFs6NswHPhglefmGO/XmhnpAfeWNNzVP0VkftL1BmABFyaC8P
	uXcPlLVsVBWTF4C+xYif6X93qE2R+f6Vq1gwg9Cnu0fPEbRGnFO0W2Y563ulavzt14HqaQjyboh
	0gL6XGMYUZfHbsc6XZ6aSiwJ4cVY7Wm0G5mEUY3uHz5OLQcF0SbwiTnc=
X-Google-Smtp-Source: AGHT+IHJ2T98Ld5+vyQfZDQvFZ662KyFf7VTOw+Q5pNmMPXr7w1RmsliXZttRCnEcwuGsg835cY5Nh6w4QC1AGpacu7Kft28EN4H
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3cf:c8f0:70f8 with SMTP id
 e9e14a558f8ab-3cff3db9ce6mr4585915ab.4.1738004246734; Mon, 27 Jan 2025
 10:57:26 -0800 (PST)
Date: Mon, 27 Jan 2025 10:57:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6797d716.050a0220.ac840.01d6.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (2)
From: syzbot <syzbot+3f197ab3ac3fca17f7cf@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    21266b8df522 Merge tag 'AT_EXECVE_CHECK-v6.14-rc1' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13775ab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9e008bfc27b14db
dashboard link: https://syzkaller.appspot.com/bug?extid=3f197ab3ac3fca17f7cf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-21266b8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96d2e2351b97/vmlinux-21266b8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df52cb464cba/bzImage-21266b8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f197ab3ac3fca17f7cf@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
EXT4-fs: Ignoring removed i_version option
EXT4-fs: Ignoring removed orlov option
EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
EXT4-fs (loop0): encrypted files will use data=ordered instead of data journaling mode
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:203!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.13.0-syzkaller-04858-g21266b8df522 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_es_end fs/ext4/extents_status.c:203 [inline]
RIP: 0010:__es_tree_search fs/ext4/extents_status.c:221 [inline]
RIP: 0010:ext4_es_cache_extent+0x68d/0x7e0 fs/ext4/extents_status.c:985
Code: ff e9 b1 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 38 fe ff ff 4c 89 f7 e8 fe 53 b0 ff e9 2b fe ff ff e8 24 ce 49 ff 90 <0f> 0b e8 ac a1 7d 09 f3 0f 1e fa 65 8b 1d 2d 3b ae 7d bf 07 00 00
RSP: 0018:ffffc9000d4bf340 EFLAGS: 00010283
RAX: ffffffff82559acc RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e502000 RSI: 00000000000008a1 RDI: 00000000000008a2
RBP: ffffc9000d4bf448 R08: ffffffff82559802 R09: fffff52001a97e58
R10: dffffc0000000000 R11: fffff52001a97e58 R12: 0000000000000021
R13: dffffc0000000000 R14: ffff888043da7b0c R15: 1ffff110087b4f61
FS:  00007fb74f8116c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb74eb96788 CR3: 0000000043882000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_cache_extents fs/ext4/extents.c:540 [inline]
 ext4_find_extent+0x3e8/0xd50 fs/ext4/extents.c:927
 ext4_get_verity_descriptor_location fs/ext4/verity.c:292 [inline]
 ext4_get_verity_descriptor+0x122/0x610 fs/ext4/verity.c:346
 fsverity_get_descriptor+0x8e/0x440 fs/verity/open.c:330
 ensure_verity_info fs/verity/open.c:370 [inline]
 __fsverity_file_open+0x15d/0x2b0 fs/verity/open.c:391
 fsverity_file_open include/linux/fsverity.h:300 [inline]
 ext4_file_open+0x25a/0x8b0 fs/ext4/file.c:892
 do_dentry_open+0xbe1/0x1b70 fs/open.c:938
 vfs_open+0x3e/0x330 fs/open.c:1068
 do_open fs/namei.c:3828 [inline]
 path_openat+0x2c84/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1395
 do_sys_open fs/open.c:1410 [inline]
 __do_sys_openat fs/open.c:1426 [inline]
 __se_sys_openat fs/open.c:1421 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb74e98cd29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb74f811038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fb74eba5fa0 RCX: 00007fb74e98cd29
RDX: 0000000000000000 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 00007fb74ea0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000030 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb74eba5fa0 R15: 00007fff9c4d19b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_end fs/ext4/extents_status.c:203 [inline]
RIP: 0010:__es_tree_search fs/ext4/extents_status.c:221 [inline]
RIP: 0010:ext4_es_cache_extent+0x68d/0x7e0 fs/ext4/extents_status.c:985
Code: ff e9 b1 fe ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 38 fe ff ff 4c 89 f7 e8 fe 53 b0 ff e9 2b fe ff ff e8 24 ce 49 ff 90 <0f> 0b e8 ac a1 7d 09 f3 0f 1e fa 65 8b 1d 2d 3b ae 7d bf 07 00 00
RSP: 0018:ffffc9000d4bf340 EFLAGS: 00010283
RAX: ffffffff82559acc RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000e502000 RSI: 00000000000008a1 RDI: 00000000000008a2
RBP: ffffc9000d4bf448 R08: ffffffff82559802 R09: fffff52001a97e58
R10: dffffc0000000000 R11: fffff52001a97e58 R12: 0000000000000021
R13: dffffc0000000000 R14: ffff888043da7b0c R15: 1ffff110087b4f61
FS:  00007fb74f8116c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb74eb96788 CR3: 0000000043882000 CR4: 0000000000352ef0
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

