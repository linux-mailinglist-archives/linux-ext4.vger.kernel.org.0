Return-Path: <linux-ext4+bounces-10507-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D762BB21B7
	for <lists+linux-ext4@lfdr.de>; Thu, 02 Oct 2025 02:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C123192216F
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Oct 2025 00:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E54A32;
	Thu,  2 Oct 2025 00:10:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651BA41
	for <linux-ext4@vger.kernel.org>; Thu,  2 Oct 2025 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363836; cv=none; b=cGojQkkPlcmcoHmlgp0XwDViLoUODL4kQCjRAlP89u9gWPzfZlv+Q3auej6Y4Qzq+OsKWomlt256qsVNFW+zjhXR6VURrWFMpQ+oPEC9agmvpm6CHgpRAmRjLNfAfz3J4I54OlKuQJ+mVJj4wWyjdAUevKYO+z5STCPpdlYqLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363836; c=relaxed/simple;
	bh=nGtG//UwSiOC7j/s5aI7uBONsY6W4rhN9Dt7OdwLsnw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b+6vEn4fU42tTEmQCyMaHkwWRJUEctFmzzB21cgRNJyhTrxZFW9k6q1BcImUAM1H/+J3U0Qz2WTc65I9xTQlIwJnbtskxnunYyfwP7To05D09nFs1ZFHIFunq/P33xHV/w4AhP1+MhlP0AeQftV0i3fYH1AV9ekRX2I22JnSTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-9374627bb7eso198631239f.1
        for <linux-ext4@vger.kernel.org>; Wed, 01 Oct 2025 17:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759363833; x=1759968633;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFVNWbWuQMVw9msMpATVBSpa9OIDNQOKyA+W7+Ch6m4=;
        b=RIIeSZeVV2s+vUjyg3SULUezUrx7BRhsaBSQO2XPuQe4ik/OeIkfdrGzrQheCCPHii
         yC/ElNoj/tbtGzzMLMpTjQQMOXnKqj6rNLXvp5xwMtkTxJBEQ5EFu/mmiwolXD+9VSn5
         lPyQNtthCrLmaCEwsNBNbdWr3gvjKOcz17nEAOpeJ3POZwztaFhL+21+Anyxqal+Rr6j
         QsMQpnpnGeRUlzmLFq4QVnJVpMEkrxCXjPho7Gj+Z8QDOk+83WL0WKDtkarE5kUdIE1s
         r6a0gJxZuK4j+vmc9sKFYJiDu2YRtZ9pD2/7U/DqoVxWvoVotj750iYbA3Zj+hPJXiZG
         Hl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc6zXjMazpNZz5Y/kRRk9kt8STeUjT2Q8E3Xov8JvEC0W5A/nYsJM8Hi39FnTUv9PQ4k9yB9eShsb3@vger.kernel.org
X-Gm-Message-State: AOJu0YysLmOt37+FdLTbqJfm8aE6+n5NG6/T+eU9yzs1CQs+4V/6L7ek
	YRsA20d5peAtZ+sQsdh2pxhyppAb/NBV4VmUy14WbbdsgUGPZXOQseaQYelNkNxrWNJo0gJ8/yx
	oZLfQztROYCiPPaRdbETXxYEIAWC5Yrp3+DdCLMbq/iXgnrFfuaw3UaS+fYA=
X-Google-Smtp-Source: AGHT+IGjb5hEJ/7yJWBDWVALOD8pfVf18BhtT3dObGhNTlszT0T+Ul7PXrG2U9XM76i1MfGdVvICIpeipf/ZWOuMFO9Is1rRcq+g
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:424:7128:a06a with SMTP id
 e9e14a558f8ab-42d8b1b2759mr20435535ab.7.1759363833281; Wed, 01 Oct 2025
 17:10:33 -0700 (PDT)
Date: Wed, 01 Oct 2025 17:10:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ddc2f9.a00a0220.102ee.006d.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bd8092580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee1d7eda39c03d2c
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f30a7c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1109e942580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-50c19e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33a22a854fe0/vmlinux-50c19e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e68f79994eb8/bzImage-50c19e20.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/921fccc3cfcf/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16c42092580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_search_dir+0xf1/0x1b0 fs/ext4/namei.c:1469
Read of size 1 at addr ffff8880528ccb57 by task syz.0.24/5691

CPU: 0 UID: 0 PID: 5691 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_search_dir+0xf1/0x1b0 fs/ext4/namei.c:1469
 ext4_find_inline_entry+0x492/0x5f0 fs/ext4/inline.c:1621
 __ext4_find_entry+0x2fd/0x1f20 fs/ext4/namei.c:1542
 ext4_lookup_entry fs/ext4/namei.c:1703 [inline]
 ext4_lookup+0x13d/0x6c0 fs/ext4/namei.c:1771
 lookup_open fs/namei.c:3774 [inline]
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x1101/0x3830 fs/namei.c:4131
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f807b98eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f807c806038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f807bbe6090 RCX: 00007f807b98eec9
RDX: 0000000000000042 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007f807ba11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f807bbe6128 R14: 00007f807bbe6090 R15: 00007ffea28141a8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7fe26f59e pfn:0x528cc
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea00014a3348 ffffea00014a3208 0000000000000000
raw: 00000007fe26f59e 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 5688, tgid 5688 (rm), ts 112106822009, free_ts 112155145845
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 folio_alloc_mpol_noprof mm/mempolicy.c:2435 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2470
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 alloc_anon_folio mm/memory.c:4997 [inline]
 do_anonymous_page mm/memory.c:5054 [inline]
 do_pte_missing mm/memory.c:4232 [inline]
 handle_pte_fault mm/memory.c:6052 [inline]
 __handle_mm_fault+0x2ab9/0x5440 mm/memory.c:6195
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5688 tgid 5688 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 free_unref_folios+0xdbd/0x1520 mm/page_alloc.c:2952
 folios_put_refs+0x559/0x640 mm/swap.c:999
 free_pages_and_swap_cache+0x277/0x520 mm/swap_state.c:264
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x44c/0xb50 mm/mmap.c:1293
 __mmput+0x118/0x430 kernel/fork.c:1130
 exit_mm+0x1da/0x2c0 kernel/exit.c:582
 do_exit+0x648/0x2300 kernel/exit.c:949
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1111
 x64_sys_call+0x21f7/0x2200 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880528cca00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880528cca80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880528ccb00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff8880528ccb80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880528ccc00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

