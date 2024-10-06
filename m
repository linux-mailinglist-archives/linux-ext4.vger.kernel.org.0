Return-Path: <linux-ext4+bounces-4519-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCAD991FCE
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Oct 2024 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D1728207B
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Oct 2024 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF39189BB5;
	Sun,  6 Oct 2024 17:11:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2C155C8C
	for <linux-ext4@vger.kernel.org>; Sun,  6 Oct 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728234685; cv=none; b=WaHx704h83GHCOvkqI47RmhFH2U5oAr/PhFaeEvMuHLRJftZlfoUaLD5TKBtubKDyegQJ35Lg5aW48NQqCAwpJtNGBLZLpF/6CmN4GxuBXnKmilhmqDnReHdUP30FNHF+vkdgruwFCNzmqbnUzeB+L4vysw5iub7emGnaGNpl7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728234685; c=relaxed/simple;
	bh=A5KqEtuNzrXw9v/9eOVC6RUnGgwZZ0UeSRnjRqS3CS8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P3MgBhc9UYOAAVDz/DAvQ7dOELbWjhwA3LrZiuiE7ehK8nCcrveyhpWdr38W/2PQvUwsnOfzxQ6LjDXBJQ2quaaNOgbzUkrzPfPuOHlRhrDSJaOl9p8hdpRf2Gjq+/ao+r8tj+J0zTRIOEccFLvn2T3yOcAhdCkEJ2BL8iNbKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so68522895ab.2
        for <linux-ext4@vger.kernel.org>; Sun, 06 Oct 2024 10:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728234683; x=1728839483;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFCCDqD1CFdCuqQJcT5Vt9gD1U6eFGNHDs2x1j7aCp0=;
        b=Gs5wEB7tUYN+nuhwQ94y54eOOskL+Cwq74YXIVH1jThV3Tw0KW+QiLX2O51VJKHMkz
         6mvDxNLAff/v5RC4hcbf9DGXzegaQNIvnh/nQpXHpBJgqTYbA5N+eXSTgpUOcAZUKXkG
         K6w6ms6KLrj72UsAIn0X0UsZpwJAh1xNXpEA/d4idWMquPdvLQlTHe+IHn6oEDmYwEzJ
         1ErHk6M3a57kQ0lZafikbN3Quh+OqFSCc90ElkfVlVpGq9CvWdFSX276RfRLY0BNOPWk
         gS/nETjOBVPC/+o1fhQnTt0X61udW1UjB4GyvyPoV1WB1ey1qhu04UiojLO5xT4Zc3M4
         OU4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZSYUQ62gMtv1iD638gNfopHGJ/6jD0GkRj6TyWe500xw23QuQbu2zART3oYQk9pWzGJF8gDT8aVdJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwLI2fA+K2v9hkIIwrXVOWv+iaZTgfglG+n/paY4PSzcwPapKuk
	665m9Fj+iBHpwCeAAe1+2EEAAW0CEJXYArrHKjed1BeGKMm8VYmZc/tVqDrMnXLnHhHi6ABn+XE
	xTK8l1ttfvBraFTVYIC2zzdc5RO63q3DwV0W69OYXBttllHasBTZc7mQ=
X-Google-Smtp-Source: AGHT+IEPtAQ2Iry8Tq66DVOE0tnpd3k0kfQy8tnf9I13q2skAxX0hGtsIMh8Dc5TIgco8gJ1O2srG519/FuhYfiXdSvQUsZsmnpb
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a375a9aabdmr89329645ab.10.1728234683155; Sun, 06 Oct 2024
 10:11:23 -0700 (PDT)
Date: Sun, 06 Oct 2024 10:11:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6702c4bb.050a0220.49194.04d9.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in __ext4_check_dir_entry (3)
From: syzbot <syzbot+09921540dd04aba82a35@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17219927980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f009dd80b3799c2
dashboard link: https://syzkaller.appspot.com/bug?extid=09921540dd04aba82a35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102f23d0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1082e580580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08f3ba449e03/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17bcace1ab90/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da9183ac0145/bzImage-e32cde8d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/45cde0725f07/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ba5927980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ba5927980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ba5927980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09921540dd04aba82a35@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_orphan_get:1393: comm syz-executor400: couldn't read orphan inode 15 (err -117)
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
EXT4-fs warning (device loop0): dx_probe:833: inode #2: comm syz-executor400: Unrecognised inode hash code 4
EXT4-fs warning (device loop0): dx_probe:966: inode #2: comm syz-executor400: Corrupt directory, running e2fsck is recommended
==================================================================
BUG: KASAN: use-after-free in __ext4_check_dir_entry+0x6fd/0x880 fs/ext4/dir.c:85
Read of size 2 at addr ffff88807fc17003 by task syz-executor400/5217

CPU: 0 UID: 0 PID: 5217 Comm: syz-executor400 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __ext4_check_dir_entry+0x6fd/0x880 fs/ext4/dir.c:85
 ext4_readdir+0x1436/0x3a60 fs/ext4/dir.c:259
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:407 [inline]
 __se_sys_getdents64+0x1d3/0x4a0 fs/readdir.c:392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfd760b6d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe192a0be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007ffe192a0bf0 RCX: 00007fcfd760b6d9
RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007ffe192a0bf8 R08: 6c616b7a79732f2e R09: 6c616b7a79732f2e
R10: 6c616b7a79732f2e R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe192a0e58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x56388aa96 pfn:0x7fc17
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001ffe808 ffff8880b8644af0 0000000000000000
raw: 000000056388aa96 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 5214, tgid 5214 (sftp-server), ts 74824128125, free_ts 74900105933
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3039/0x3180 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 folio_alloc_mpol_noprof mm/mempolicy.c:2283 [inline]
 vma_alloc_folio_noprof+0x12e/0x230 mm/mempolicy.c:2314
 folio_prealloc+0x31/0x170
 alloc_anon_folio mm/memory.c:4721 [inline]
 do_anonymous_page mm/memory.c:4778 [inline]
 do_pte_missing mm/memory.c:3963 [inline]
 handle_pte_fault+0x24dd/0x6800 mm/memory.c:5751
 __handle_mm_fault mm/memory.c:5894 [inline]
 handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6062
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5214 tgid 5214 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xee2/0x18a0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc40 mm/mmap.c:1877
 __mmput+0x115/0x380 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807fc16f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807fc16f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807fc17000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807fc17080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807fc17100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

