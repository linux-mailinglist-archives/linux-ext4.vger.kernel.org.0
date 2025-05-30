Return-Path: <linux-ext4+bounces-8248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE4AC8AB4
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 11:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125491BA27E3
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966AB21E082;
	Fri, 30 May 2025 09:28:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3321578F
	for <linux-ext4@vger.kernel.org>; Fri, 30 May 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597307; cv=none; b=JXtRIBpdzsUohH4ZaxUng8PlO5Z9YsenzFbX/bD6W6joljpu5tKaaySNxTZ3y3WvP8IoBYDOZr04VlOim4QZaE22KaDl7UANoItTqJbcUuu4jSx3fTdKR2ZvtRLzf+sYfCdDoRvrXXsntoBQud18Y+lStCxfQqtf2UAHcE0pyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597307; c=relaxed/simple;
	bh=uT25BXC8aiIN2if1X7W5ufA0j1GYNkBxlIjE05cNxLM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nzIxm6a7gE12MUUTyqhgyh/MWHiRw4AwFw+HWFcOUPPeaMDrTB7LSQlLyFWqZTfPYbPJ4sWPRKPJmczceHlXLZ8m6b0dfInpbGmR0K3glsaGkFyYA79NWJOrM8FWjCWnRBamLkBAZ43jthCP4H+kFrW1UshgYkef3O9F39wSomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3dc870a4ff5so20439265ab.3
        for <linux-ext4@vger.kernel.org>; Fri, 30 May 2025 02:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597304; x=1749202104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmZLF+sbgUSSdhYb3r1jseS5cZOLcM/dMLZzx55rrmo=;
        b=w29vsYCuv7tHCy1fCT9alldFC8U2Vd19iD+aGsmQH3wOytCuvMrzLhPYwshGc3iRc7
         HQfw/Jhy7hi+u08MRxT288IbcCH9HpLCFGbOrnDsbFeB/1H1B/J6OHMvEp04ciHpWhPN
         P9q6CLJSIz46X6ljx3wx2ao3/MMbqY2MuicWHuPwBqXUVbfcRWnkzuxCwYEXXxqQTDv7
         E9HYPU9DC1rhnkqwoFzqv1d1aR5h7DoEKwJL3rdLlDjMts/XbnfLxNTxDbUlF6lk1xek
         ri2A6OPJeFs+X+AYmXjyF3RyRvvs/5zhZPf0aPoh0wVLreJb19niIMrpDVccP9IKAiOa
         KpfA==
X-Forwarded-Encrypted: i=1; AJvYcCVoLb4EqRsXO/sYi0nzOGfkbz/YU7nueYYSZ1236gQQ2A1yis7GUH17vnifDR7FN8LJLyqx37GbLR/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFuszevc20mFW3L3MgiDcoEZRAadzjI4RYYGLo12TnOonorFz
	NKJ4iV0+i79Zc0ETC8vFEvv/pDaIsUVrencvnkdabQmYoU+l8Ldzt+4IW3lfRCsxyeuOoAHjxDG
	ZfbRr99dw9qpcLVF5BcFdoIKcjxJJhz5DL8BvqhIFED1/wpEL0RQ42POcCfk=
X-Google-Smtp-Source: AGHT+IFgBAWP9tjCTLpYZOQkDZy1UGz7BNuGsiaWqONI2VPxMt8mjJCFr0fI/7GfmufaiXEoVClOTmhVCDBYeTCuwC2tjqhaawVm
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a21:b0:3dd:892d:b25e with SMTP id
 e9e14a558f8ab-3dd9cbf6c36mr12434255ab.22.1748597304567; Fri, 30 May 2025
 02:28:24 -0700 (PDT)
Date: Fri, 30 May 2025 02:28:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68397a38.a00a0220.d8eae.0005.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in jbd2_journal_dirty_metadata (2)
From: syzbot <syzbot+f71f98e4cf272ac05861@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c89756bcf406 Merge tag 'pm-6.16-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174dabf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ded97a85afe9a6c8
dashboard link: https://syzkaller.appspot.com/bug?extid=f71f98e4cf272ac05861
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c89756bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b21d74e73303/vmlinux-c89756bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b778ededeb75/bzImage-c89756bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f71f98e4cf272ac05861@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
ocfs2: Mounting device (7,0) on (node local, slot 0) with writeback data mode.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5317 at fs/jbd2/transaction.c:1552 jbd2_journal_dirty_metadata+0x978/0xcd0 fs/jbd2/transaction.c:1552
Modules linked in:
CPU: 0 UID: 0 PID: 5317 Comm: syz.0.0 Not tainted 6.15.0-syzkaller-03478-gc89756bcf406 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jbd2_journal_dirty_metadata+0x978/0xcd0 fs/jbd2/transaction.c:1552
Code: 24 41 89 e8 4d 89 f9 50 41 56 41 55 53 e8 a0 f2 a0 fe 48 83 c4 20 90 0f 0b 90 bb ea ff ff ff e9 09 fe ff ff e8 a9 57 39 ff 90 <0f> 0b 90 bb e4 ff ff ff e9 f6 fd ff ff 48 8b 44 24 28 48 83 c0 18
RSP: 0018:ffffc9000d4ce938 EFLAGS: 00010283
RAX: ffffffff82869aa7 RBX: 0000000000000000 RCX: 0000000000100000
RDX: ffffc9000de7a000 RSI: 0000000000092c37 RDI: 0000000000092c38
RBP: ffff888052d6b750 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52001a99d18 R12: 1ffff1100a59d7cf
R13: dffffc0000000000 R14: 1ffff1100a5ad6e9 R15: 1ffff1100a59d7cc
FS:  00007f2f05ca06c0(0000) GS:ffff88808d28f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c7145f1168 CR3: 000000003f33b000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_journal_dirty+0x149/0x740 fs/ocfs2/journal.c:834
 ocfs2_split_refcount_rec+0xb46/0x12a0 fs/ocfs2/refcounttree.c:1965
 ocfs2_decrease_refcount_rec fs/ocfs2/refcounttree.c:2190 [inline]
 __ocfs2_decrease_refcount+0x551/0x1780 fs/ocfs2/refcounttree.c:2249
 ocfs2_make_clusters_writable fs/ocfs2/refcounttree.c:3262 [inline]
 ocfs2_replace_cow+0xd5a/0x1b90 fs/ocfs2/refcounttree.c:3346
 ocfs2_refcount_cow_hunk fs/ocfs2/refcounttree.c:3424 [inline]
 ocfs2_refcount_cow+0x779/0xc90 fs/ocfs2/refcounttree.c:3467
 ocfs2_prepare_inode_for_write fs/ocfs2/file.c:2340 [inline]
 ocfs2_file_write_iter+0xe28/0x1d10 fs/ocfs2/file.c:2451
 iter_file_splice_write+0x93a/0x1000 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1158
 splice_direct_to_actor+0x5a5/0xcc0 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1227
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f04d8e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f05ca0038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f2f04fb5fa0 RCX: 00007f2f04d8e969
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000007
RBP: 00007f2f04e10ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000800000009 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2f04fb5fa0 R15: 00007fff8a1ca8d8
 </TASK>


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

