Return-Path: <linux-ext4+bounces-3772-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB19564DE
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 09:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E9A1F2462C
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE156158520;
	Mon, 19 Aug 2024 07:42:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2914AD3D
	for <linux-ext4@vger.kernel.org>; Mon, 19 Aug 2024 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053350; cv=none; b=isb4n2FSv7D7EyfwymF7clJXYKsv8/1Kx4/JN1pJFMcDApkiI3r7I4BkwHykYpGRgKozLVfgKaGC3Pu0iBUp8FiLT+Lgx2VEKKZgIB9q8BZHqzMsfyZvMGwGxxlIoOQQJUqo1vr6sAlVONQ/emVCIMH+8Dw3Dy/FD407Mmijuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053350; c=relaxed/simple;
	bh=+JDLI63S1ln8et2UVMGrEsItpYkbK0XsXQggLMv1DI4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bvqLBlQMVbzA6xo74sglCxiyeDynLBbl5lScirXRbsF1MT2Gtr40soXDCVI1ZoERlyuYvDOnqBgJgqnwo0SeUtQBn6apjPg3CM+PgyymBx2qa3CFbd6XjBLdo2w99AxpOLCBrTI/+QMr1XW/vkfQlxmCuoW2hQc4Hn4mxKIqTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-822372161efso284345939f.0
        for <linux-ext4@vger.kernel.org>; Mon, 19 Aug 2024 00:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053348; x=1724658148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pw0Pj8KvLQLM9Mw/vG95gIC/N37eafE73fcwI3LDHFg=;
        b=QSMe7ht9zyF63l1QwWhnObR2cwtwALYln6nQhD8q1heQAj6MG9VUBLjixU2nKk+acM
         FZY0g/9m3gsxbyXJQJ7Zfcmj7LuI0xfW09ESQXCJom2lYHyjDlEoL9qOyhdztWWoJal/
         xvxXXuFG3xZFX/YCIMjvH7R6NO0RmC3qyouaFAwo9oTh9J+MA8awJByfECHbrHGPouF4
         9ZZ1M3sRUMakh38+FH+bJ6vw2JEmRLVOKL2FEWG5UvLjGjDooP5N0XIbn9tNyKRhT6DV
         7+B//RiBuxdhSEoHL/lpihDsWQyg3T9eXqBzoUR7eQ77my68rb3RwtFJt0MmwBRA3irC
         jg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK6i3Y6ny2UgkNzWl1Itw2oYga80codA4FVOHm+sOXVlt/bgHDdaf9lZTVxWBvehKDyDdFlW+CmgKCY1+b58k8Yx6NLM5hRnTjUA==
X-Gm-Message-State: AOJu0YxaqdP9fHuptcGCn8hshKBvqFZG47aDXiqiNt81WKbXChg+Weoy
	iqOKZ8uIF9tFp9H2d1HVSmByvQticz1SiIw20ODNWWfiXdI3b+qCSbscoJPPyQn98OhVvRx5KKU
	bzW0O1uXgVpNEgeaqN1K8jAefNaTmev86myUo1ktrzN9MoBCDwabi4Jw=
X-Google-Smtp-Source: AGHT+IH6T/IC2jUcSg/RgvP695bUb09z977MQDV3/XgELvG3iPoIyfaXC7QIOxbiH5AZ1l4+bBshweC3eNR1INU7atoV71WH2+kz
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8327:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4cce15dbcf6mr571306173.2.1724053348051; Mon, 19 Aug 2024
 00:42:28 -0700 (PDT)
Date: Mon, 19 Aug 2024 00:42:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062812a062004738b@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir (2)
From: syzbot <syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    47ac09b91bef Linux 6.11-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153eeafd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=0c2508114d912a54ee79
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1335fe05980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156ba6fd980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-47ac09b9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6db2a1c6b666/vmlinux-47ac09b9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1c782255526/bzImage-47ac09b9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/83fcfca5f30f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c2508114d912a54ee79@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
loop0: detected capacity change from 2048 to 2047
==================================================================
BUG: KASAN: use-after-free in ext4_search_dir+0xf2/0x1c0 fs/ext4/namei.c:1500
Read of size 1 at addr ffff88803e91130f by task syz-executor269/5103

CPU: 0 UID: 0 PID: 5103 Comm: syz-executor269 Not tainted 6.11.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 ext4_search_dir+0xf2/0x1c0 fs/ext4/namei.c:1500
 ext4_find_inline_entry+0x4be/0x5e0 fs/ext4/inline.c:1697
 __ext4_find_entry+0x2b4/0x1b30 fs/ext4/namei.c:1573
 ext4_lookup_entry fs/ext4/namei.c:1727 [inline]
 ext4_lookup+0x15f/0x750 fs/ext4/namei.c:1795
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
 filename_create+0x297/0x540 fs/namei.c:3980
 do_symlinkat+0xf9/0x3a0 fs/namei.c:4587
 __do_sys_symlinkat fs/namei.c:4610 [inline]
 __se_sys_symlinkat fs/namei.c:4607 [inline]
 __x64_sys_symlinkat+0x95/0xb0 fs/namei.c:4607
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3e73ced469
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4d40c258 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 0032656c69662f2e RCX: 00007f3e73ced469
RDX: 0000000020000200 RSI: 00000000ffffff9c RDI: 00000000200001c0
RBP: 0000000000000000 R08: 00007fff4d40c290 R09: 00007fff4d40c290
R10: 0023706f6f6c2f76 R11: 0000000000000246 R12: 00007fff4d40c27c
R13: 0000000000000003 R14: 431bde82d7b634db R15: 00007fff4d40c2b0
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7fb7091d9 pfn:0x3e911
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 dead000000000100 dead000000000122 0000000000000000
raw: 00000007fb7091d9 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 5083, tgid 5083 (sshd), ts 84338308196, free_ts 84419190442
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
 handle_mm_fault+0x1029/0x1980 mm/memory.c:5832
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 5083 tgid 5083 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2660
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 unmap_region+0x2df/0x350 mm/mmap.c:2441
 do_vmi_align_munmap+0x1122/0x18c0 mm/mmap.c:2754
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
 __vm_munmap+0x1fc/0x400 mm/mmap.c:3109
 __do_sys_munmap mm/mmap.c:3126 [inline]
 __se_sys_munmap mm/mmap.c:3123 [inline]
 __x64_sys_munmap+0x68/0x80 mm/mmap.c:3123
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803e911200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803e911280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88803e911300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff88803e911380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803e911400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

