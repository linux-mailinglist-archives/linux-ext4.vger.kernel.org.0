Return-Path: <linux-ext4+bounces-5997-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5773CA0802D
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2025 19:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89CD188AFA7
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2025 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58F1AA1CC;
	Thu,  9 Jan 2025 18:50:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C8BA2D
	for <linux-ext4@vger.kernel.org>; Thu,  9 Jan 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448628; cv=none; b=tqhnaTvf9g/hZD1pmgS546SPlUh5d3W+IAnq5n2IgBaXmLc+pBUNGGtsWswg90seCZ4MVoikhiL6XwXrOMFEup/flzKcNTx519cht8E5vrpcUxxN4mS0FtgQKwa5r5hqDXVYCJF4CqZfrO8uvZ3q88mwJx9LLrwb6R7tCqLcCqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448628; c=relaxed/simple;
	bh=H4CZjOmYC0NCec9umLKhSOFtV8cwSdEMnaok6rz7QWY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R0G6UEq23SfCAwTgg6m6ihr2x+CQA3wgLNx1uY0mCq6FnMwi+MEakMFUOH7I3tBpTZlvLNW0WsrKE7EmpERCjP/Zawp27M1K8bR7T7GBQ7yXPGAx6f33vVA1TOAoovZLBgTHTIPq3icK+bME9GPVckNSuBRUfhO01oUNZi1EewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so10300015ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 09 Jan 2025 10:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448625; x=1737053425;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THYoIrGbXFYQttYPv4IJLSufIMQMNQ+423rhjxYwkV8=;
        b=nQDEnNKRjZOMLYURi7rE761InxiohrZi+MNlJcyCae+4d00I7hVkXY+caWmOUHZan7
         ZyYtiT3VDA/GqpGZmDz0wUGNNt1TPXFIO3ppYSPQWakldLsxoXJoYEXHb90Y030VaSWp
         oKy96GCez6UhZ0bwLe/kQHZmEuLAFV8zfYIDpMGc5xkc6dGyXxshGOatPtTejD1XSVUD
         AV4lo5rduQx77BbIvxS4/eNYL3uh3AznE4hNXtpv0SSFVzoGdIS3Upl0ezTSAtKbfRqY
         qqGesZQY+fq0SClBrb2iCqiMnzva3ft+fYivCIBOhiIkQuYk6g8WhiBmVNgVI2f7blsf
         M25Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfZXpN7ZxHcsMzHW7s8SZe/4s6PWnkhVS7Zrk2WPxDJercaLEkrKTE4HyGFhEVAA5Z54XVeI/dlaAr@vger.kernel.org
X-Gm-Message-State: AOJu0YxadnUQPJUNrb7dmumPDr/x+qrIHFfxJ/78D2qQS1hDJxoah0Wk
	hgmfHrRQes+xDkf2CEyKP9vECOZwwJtcyjfhpOdWCzkSnVJLZksvDsYgzEibFhxkYv0dQhO1elA
	2tpDmLmp3Qooit+Yi4hLMXaI5TqwSSpcJ/DZbpBNFjMTGdgI5T0Sv9bQ=
X-Google-Smtp-Source: AGHT+IG/azm/OO33COTH/MEAo0RdCfHPpAZlNgKdXxjIsa/+yeH1um3lJpzaQofHUUWxZ47B38A4e9hntmQgP5Pg0WF6opMEY6HW
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1524:b0:3a7:764c:42fc with SMTP id
 e9e14a558f8ab-3ce3aa761famr61729735ab.21.1736448625031; Thu, 09 Jan 2025
 10:50:25 -0800 (PST)
Date: Thu, 09 Jan 2025 10:50:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67801a71.050a0220.25a300.01cb.GAE@google.com>
Subject: [syzbot] [ext4?] [udf?] [block?] kernel BUG in set_blocksize (2)
From: syzbot <syzbot+c6e047750c7e8603508b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, jack@suse.com, linux-block@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1178d418580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=c6e047750c7e8603508b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11556edf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/205ade41622a/disk-ab751705.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39aa1b893dfc/vmlinux-ab751705.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c741f4e4b082/bzImage-ab751705.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/512e46aed82f/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1952d0d2f4a4/mount_3.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/dc175c44b2d4/mount_7.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6e047750c7e8603508b@syzkaller.appspotmail.com

 folios_put_refs+0x76c/0x860 mm/swap.c:962
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc20 mm/mmap.c:1681
 __mmput+0x115/0x3b0 kernel/fork.c:1348
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9ad/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
------------[ cut here ]------------
kernel BUG at mm/filemap.c:2114!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 7712 Comm: syz.3.780 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:find_lock_entries+0xb8a/0xbb0 mm/filemap.c:2113
Code: 30 c7 ff 4c 89 ff 48 c7 c6 e0 aa 13 8c e8 5e a8 0e 00 90 0f 0b e8 26 30 c7 ff 4c 89 ff 48 c7 c6 c0 a4 13 8c e8 47 a8 0e 00 90 <0f> 0b e8 0f 30 c7 ff 4c 89 ff 48 c7 c6 a0 ad 13 8c e8 30 a8 0e 00
RSP: 0018:ffffc9000c6f73c0 EFLAGS: 00010246
RAX: dd31507b3d2b8c00 RBX: ffffc9000c6f7840 RCX: ffffc9000c6f6f03
RDX: 0000000000000002 RSI: ffffffff8c0aaae0 RDI: ffffffff8c5edd60
RBP: ffffc9000c6f7510 R08: ffffffff901856b7 R09: 1ffffffff2030ad6
R10: dffffc0000000000 R11: fffffbfff2030ad7 R12: 0000000000000080
R13: 0000000000000001 R14: ffffea0000d32180 R15: ffffea0000d32180
FS:  00007fce2da676c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78b6e0f000 CR3: 0000000077012000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 truncate_inode_pages_range+0x23b/0x10e0 mm/truncate.c:322
 kill_bdev block/bdev.c:91 [inline]
 set_blocksize+0x2f1/0x360 block/bdev.c:172
 sb_set_blocksize+0x47/0xf0 block/bdev.c:181
 udf_load_vrs+0xe6/0x1130 fs/udf/super.c:1998
 udf_fill_super+0x5eb/0x1ed0 fs/udf/super.c:2192
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce2cb874ca
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fce2da66e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fce2da66ef0 RCX: 00007fce2cb874ca
RDX: 0000000020000c40 RSI: 0000000020000c80 RDI: 00007fce2da66eb0
RBP: 0000000020000c40 R08: 00007fce2da66ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000c80
R13: 00007fce2da66eb0 R14: 0000000000000c40 R15: 000000002000b240
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:find_lock_entries+0xb8a/0xbb0 mm/filemap.c:2113
Code: 30 c7 ff 4c 89 ff 48 c7 c6 e0 aa 13 8c e8 5e a8 0e 00 90 0f 0b e8 26 30 c7 ff 4c 89 ff 48 c7 c6 c0 a4 13 8c e8 47 a8 0e 00 90 <0f> 0b e8 0f 30 c7 ff 4c 89 ff 48 c7 c6 a0 ad 13 8c e8 30 a8 0e 00
RSP: 0018:ffffc9000c6f73c0 EFLAGS: 00010246
RAX: dd31507b3d2b8c00 RBX: ffffc9000c6f7840 RCX: ffffc9000c6f6f03
RDX: 0000000000000002 RSI: ffffffff8c0aaae0 RDI: ffffffff8c5edd60
RBP: ffffc9000c6f7510 R08: ffffffff901856b7 R09: 1ffffffff2030ad6
R10: dffffc0000000000 R11: fffffbfff2030ad7 R12: 0000000000000080
R13: 0000000000000001 R14: ffffea0000d32180 R15: ffffea0000d32180
FS:  00007fce2da676c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78b6e0f000 CR3: 0000000077012000 CR4: 00000000003526f0
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

