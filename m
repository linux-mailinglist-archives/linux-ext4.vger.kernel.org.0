Return-Path: <linux-ext4+bounces-2508-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A38C57AF
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4391C218BB
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3A144D01;
	Tue, 14 May 2024 14:09:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDFB1442FE
	for <linux-ext4@vger.kernel.org>; Tue, 14 May 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695784; cv=none; b=pxz0QzxF0vALUlLnKxq3Fah4D5Ymr3B+lRoavgMedYzWI/09xglMsWuudxluOUfPNoeXIdTQ669jYvRNoxJMtvZugQVqZzvLLi19khwGR3/oWaEq8coQdIkoSOX9rRYo/4oMoRBLyLXei09+4bf+iIqc4E1I6R3QMQwZr19xUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695784; c=relaxed/simple;
	bh=uFVLMc2dCPX3QA+rPjkxmWD9+AoFoVwbL5sdkWZ1yvg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VGHR9sW4Ht+ZPXfSnziM41Zuf1fdGa2jz1xJdw3wqFbHdYqZcB1X8CvJfM3tD8mXpA2HFux97nfZA5sFnJfnIBu0Fr8SNJQmb2GgUA3tw0Fi5zgkKJao0XHo4ypJn/zI8rJOAeQrb+3HpxxOPFJQWzZTepC6TM/7QtVLkjti7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7da42114485so672253039f.2
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2024 07:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715695782; x=1716300582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ow+va0NL09oHiLyUJDVqcOYGH0oFWbtP+DEeWNKHuPQ=;
        b=CI4ZeCtjdd/I+rz3/33h3N+ZIdttxwpP8oEeRei0bso5odSaTOCn5FGzk+qaAvy71D
         a8ZVeZn/iDN5GYYq796x7SnSnENx8vNhR2mfi2jq87cw40QbLWlGqJPO7NVsY12ISBFD
         LwFt5l4K/No2xplSUI7G8P+z6FulCl/skCqcYfhZDGs//WtabCwc7TEqdHWTRiRiOvjl
         firdeRNvlE7LWjnQZKiTyZAsXBdo6PBp6ermHfNHB+hZgJfEH+Ak6vVz48kfZcfmD9ze
         FXeYg7AwiLLKRinZ4HpSRzYEmBQyPr8TZDbXlo7ANxnWOemmartysyi4EB60BQYdCNCv
         Y4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVRZ3q2S7XVCxgZAiSuPCXwnrOj1XS7Z4vhvr70JXkPbSzp+vHg7QT0SxOt61Kf0ebY7Djpe+neum6p/1AQScyylrea4f52Gyv8Dg==
X-Gm-Message-State: AOJu0YzcJ0QOkOhE6684y9xtyLgRugJvQtl5F4TdWG0wXHQmQgrZOtjs
	S8sxueqp3GuiWWdlLXW6SzI7rztHEorVsejedmfnYyFs6NFs7ZGV/7InG0m7PFu5V5wJv/LXxWw
	dXTMzSniCcSUDlhocze2aA0bmEqiQ00DUrB/ZknVnZ9Z5NxBUXbqdFm0=
X-Google-Smtp-Source: AGHT+IHnwsKU/9B2eiUzkrwUMRvpWyDkoKtbAkOFkgmDZbSBt/iz8MnYlWPso5djWSHdnaqPmDuNx3tEu1A4b5zvsO0zxUq0Se88
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1609:b0:7da:bccd:c3e3 with SMTP id
 ca18e2360f4ac-7e1b519b30amr55912839f.1.1715695782650; Tue, 14 May 2024
 07:09:42 -0700 (PDT)
Date: Tue, 14 May 2024 07:09:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaf7ec06186a8d13@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    448b3fe5a0ea Merge tag 'hwmon-for-v6.9-rc8' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1797c7a8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=11af34d3c0711f233fd4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105badd4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f14fa8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccbdd58c1f3e/disk-448b3fe5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6786079c3170/vmlinux-448b3fe5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/496bdcf3d703/bzImage-448b3fe5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b2986628c43b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com

EXT4-fs error (device loop0): make_indexed_dir:2282: inode #2: block 255: comm syz-executor396: bad entry in directory: rec_len is smaller than minimal - offset=0, inode=5120, rec_len=0, size=993 fake=0
EXT4-fs warning (device loop0): dx_probe:832: inode #2: comm syz-executor396: Unrecognised inode hash code 49
EXT4-fs warning (device loop0): dx_probe:965: inode #2: comm syz-executor396: Corrupt directory, running e2fsck is recommended
==================================================================
BUG: KASAN: use-after-free in __ext4_check_dir_entry+0x6fd/0x880 fs/ext4/dir.c:85
Read of size 2 at addr ffff8880683ae003 by task syz-executor396/5071

CPU: 0 PID: 5071 Comm: syz-executor396 Not tainted 6.9.0-rc7-syzkaller-00117-g448b3fe5a0ea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __ext4_check_dir_entry+0x6fd/0x880 fs/ext4/dir.c:85
 ext4_readdir+0x145d/0x3800 fs/ext4/dir.c:258
 iterate_dir+0x539/0x6f0 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8311a13ed9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd43d6adc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007ffd43d6ae10 RCX: 00007f8311a13ed9
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007ffd43d6ae18 R08: 000055556bcad0c0 R09: 000055556bcad0c0
R10: 000055556bcad0c0 R11: 0000000000000246 R12: 00007f8311a906a0
R13: 00007ffd43d6ae10 R14: 0000000000000004 R15: 0000000000000003
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x683ae
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 ffffea0001a0ebc8 ffff8880b9444570 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 5065, tgid -1706810074 (sftp-server), ts 5065, free_ts 54138803695
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 alloc_pages_mpol+0x3e8/0x680 mm/mempolicy.c:2264
 vma_alloc_folio+0xf3/0x1f0 mm/mempolicy.c:2303
 folio_prealloc+0x31/0x170
 alloc_anon_folio mm/memory.c:4375 [inline]
 do_anonymous_page mm/memory.c:4433 [inline]
 do_pte_missing mm/memory.c:3878 [inline]
 handle_pte_fault mm/memory.c:5300 [inline]
 __handle_mm_fault+0x3a03/0x7250 mm/memory.c:5441
 handle_mm_fault+0x27f/0x770 mm/memory.c:5606
 do_user_addr_fault arch/x86/mm/fault.c:1331 [inline]
 handle_page_fault arch/x86/mm/fault.c:1474 [inline]
 exc_page_fault+0x446/0x8a0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5065 tgid 5065 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_folios+0x1f2/0xc10 mm/page_alloc.c:2536
 folios_put_refs+0x93a/0xa60 mm/swap.c:1034
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:329
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x4bb/0xd60 mm/mmap.c:3280
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exit_mm+0x220/0x310 kernel/exit.c:569
 do_exit+0x99e/0x27e0 kernel/exit.c:865
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880683adf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880683adf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880683ae000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8880683ae080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880683ae100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

