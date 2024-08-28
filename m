Return-Path: <linux-ext4+bounces-3948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF7963514
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 00:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AE21C22577
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 22:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D851AD9E9;
	Wed, 28 Aug 2024 22:55:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFDE1AD401
	for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885725; cv=none; b=H/YEFUVAAP1zwvdDuvnEYJabOzraKqu8Q1lOoel4rNlbzamFAKBh5rD5s4ltFimjWGRDHYu5DDUcZfzutzf+r5hUA3vOjPPNpDfmtAqAaJ9AyG22G61v2me5Sqj9YPfRMMkn9FFQYELCcXXh8AaQ6w8qfYOUPXcm8gHggQAHVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885725; c=relaxed/simple;
	bh=R9JXWiIiyGK3Phni+fRUuMd6wD8dDnQ6XIGzMe7vtjY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nz/mTFO6Z1cYFMwFRTRuhRgOmU7cFMvdFXA279zZRtp9xCtv2eRDGU40Cjq2r8a5X/H+r8ZXxbORai/HSITN3Hp2aVARG/xX9mRBKAkT+bbtGUeiRQ8vyP7MIHY7DrnBEECLtKnOwUMm2w8bgKpIryyB0f9jk/Ka2l9KS3ys6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d49576404so77755935ab.3
        for <linux-ext4@vger.kernel.org>; Wed, 28 Aug 2024 15:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724885723; x=1725490523;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mRoEGntO1okv8sBZu8N5HLaZV2qiVXBA0Xd8Txm6AM=;
        b=o5Zck1yTzABkl594JWjtTp6iF4BVRvf413mcqV6aJACqJG/Ofj4ienNcPomYeKK1Xv
         S6WJHLvM2IOJaa6W4BRVM6hSkFh4hP2qRfagQFSOJAdBeDiL+BPVNGmVhqbbmdyCAerL
         vzpXkJheCs1Yy91Ltr92fqYpOzOur+jXmuKH2ssdjSUrLKzaM0zbNiZ14T4LrpsmKMyP
         ralKee1rdOOsNdOnpx0LiQOjHmvWH4N2PqYUNfz+Vtza2wJWdOZ8EvqxG+CGsu42N9I2
         JnrjFKf/nvlFnlBcCIqzixdK8I3ULOq3O26tT+bW0JMmgEB5KzbKAIAwIzwH+ShfFLII
         ygyg==
X-Forwarded-Encrypted: i=1; AJvYcCUMmJ5HD7Lur7eS6LvrT24laOHssmFCRAh+VwzKXE3vn/bQl6R8Y5s7LCfYTVXnwm0NegSN34r0oejC@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8fEI89Yb1HtjiOOqCNORsQQyYRtTXhJLC6+wI1yG/Io0FQO4
	51zYABhGxnQ7o1JB8CqxAVNYCE/HiYS8Mwa03xEbpfKRefcgLln/fciE6qyQmSoW9ulSwJ1MTki
	lXzTXnvHVub1MchmY5lcRNac88t+NMuPlxPy7CkNrnUySFYkiOt23FZY=
X-Google-Smtp-Source: AGHT+IGEAJ61HZ2G3S91Z1M146hV5zPpircsJ/ILw9pQB9WmQRc5rlHzyksR/f9Spy9dkFUDwOs+2ob9kKr0B+dYbglFhwIO1tXz
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152a:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39f3787b858mr942485ab.1.1724885723324; Wed, 28 Aug 2024
 15:55:23 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:55:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d133670620c640fe@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_inlinedir_to_tree
From: syzbot <syzbot+46b0888255f68622d309@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1660edd5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=46b0888255f68622d309
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d4ae09980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158d6609980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7569f02310fb/disk-d2bafcf2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e30fee7b6c1d/vmlinux-d2bafcf2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ffddebac153/bzImage-d2bafcf2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e4fb4afad539/mount_0.gz

The issue was bisected to:

commit e5598d6ae62626d261b046a2f19347c38681ff51
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Thu Aug 24 22:53:31 2023 +0000

    io_uring: compact SQ/CQ heads/tails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13308233980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b08233980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17308233980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46b0888255f68622d309@syzkaller.appspotmail.com
Fixes: e5598d6ae626 ("io_uring: compact SQ/CQ heads/tails")

EXT4-fs error (device loop0): htree_dirblock_to_tree:1112: inode #2: block 21: comm syz-executor129: bad entry in directory: directory entry overrun - offset=1004, inode=0, rec_len=1000, size=1024 fake=0
==================================================================
BUG: KASAN: use-after-free in ext4_read_inline_data fs/ext4/inline.c:209 [inline]
BUG: KASAN: use-after-free in ext4_inlinedir_to_tree+0x57a/0x11d0 fs/ext4/inline.c:1365
Read of size 324 at addr ffff8880717c5c05 by task syz-executor129/5213

CPU: 0 UID: 0 PID: 5213 Comm: syz-executor129 Not tainted 6.11.0-rc4-syzkaller-00255-gd2bafcf224f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 ext4_read_inline_data fs/ext4/inline.c:209 [inline]
 ext4_inlinedir_to_tree+0x57a/0x11d0 fs/ext4/inline.c:1365
 ext4_htree_fill_tree+0x5d8/0x1400 fs/ext4/namei.c:1211
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x2b1c/0x3500 fs/ext4/dir.c:142
 iterate_dir+0x57a/0x810 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:407 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb146ca613
Code: c1 66 0f 1f 44 00 00 48 83 c4 08 48 89 ef 5b 5d e9 42 23 fb ff 66 90 b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b8 ff ff ff f7 d8
RSP: 002b:00007fffaa54eac8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000555567e83770 RCX: 00007fcb146ca613
RDX: 0000000000008000 RSI: 0000555567e83770 RDI: 0000000000000005
RBP: 0000555567e83744 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000293 R12: ffffffffffffffb8
R13: 0000000000000016 R14: 0000555567e83740 R15: 00007fffaa551e30
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x5615451c4 pfn:0x717c5
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000100 dead000000000122 0000000000000000
raw: 00000005615451c4 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 5174, tgid 5174 (sftp-server), ts 48575534501, free_ts 49882330156
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 folio_alloc_mpol_noprof mm/mempolicy.c:2281 [inline]
 vma_alloc_folio_noprof+0x12e/0x230 mm/mempolicy.c:2312
 folio_prealloc+0x31/0x170
 alloc_anon_folio mm/memory.c:4498 [inline]
 do_anonymous_page mm/memory.c:4555 [inline]
 do_pte_missing mm/memory.c:3945 [inline]
 handle_pte_fault+0x255e/0x6fc0 mm/memory.c:5521
 __handle_mm_fault mm/memory.c:5664 [inline]
 handle_mm_fault+0xf70/0x1880 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5174 tgid 5174 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x100f/0x1ac0 mm/page_alloc.c:2660
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3425
 __mmput+0x115/0x380 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880717c5b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880717c5b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880717c5c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8880717c5c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880717c5d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

