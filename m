Return-Path: <linux-ext4+bounces-12751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E70D162BF
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 02:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B88E5300A7B5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 01:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C733727CCF2;
	Tue, 13 Jan 2026 01:31:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F68245031
	for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267889; cv=none; b=pKDD/nzDZDQsvCii0Ypw5jmzOPp8xGjAjETSn9Nb5LkrC1WYrR702IREM54NFvPq1cvSwlDHYUP93FIF57zQ3IrS3SnZxJTZFhqI9j3K23cB+RDUOsT/yu6gYy39iDWt/sWk26g2czoQ+LyZMzD2Ju3xw26acjVWBf7CXh91y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267889; c=relaxed/simple;
	bh=cDCThmhjxiLpnqzEXaHva+HPIXJlnYU/Tqd/XAfBiVg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OfwkCxhfsky+eUr1+fE6+VBzYc/OVwnMv2PaPyoFnRYIOd9kiF71CAcQawL8hjKgYVLavkqkdNQ+qVxZc1toVin9i5Wxhygq7WRpGervu4g95mCLwpwC0w+L60Woc/ii6vgSuP+P1D+9DZ9iHso1+8KWlo5OGxP35t0BDsSSDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65b153371efso12623114eaf.1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jan 2026 17:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768267886; x=1768872686;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TiEsnucEzlTm+k5nQRjpRWf/Spo+9/eUqbpiUOBv7nU=;
        b=eNuVhrhygRvliVW/7ZcI7ajX8lgKrlXKd9bzLWuEHqNBXXXgXEtLqChE2jrEzMJs4k
         MEylv+hHKDhJgFMOlI4+GbvV9OOD4eSFLbv8SQAXbd/I/hoqQBXlzxh0/wsRm72gKwRz
         VDdoYJpAiRg0XNlTyDF7LYZ7CC7Qd8ElQ9B5vyeIY6klXooDpwgzQkvbP8UvoxU2XiVw
         8K856+Kq8JYZhjguGaEMuXNGm3CFAdLFNuOAX4uYmW6BC7zwL2B2Pro1FTcs5bA2CEsQ
         jA4u29zB5Bc5wrSTgCVcQ1nE1/MwxMW1ZYHu7Ep5Z8ZfU02gmdk7Gk9pajAgp2RQWoy+
         uLiA==
X-Forwarded-Encrypted: i=1; AJvYcCW+9l9EglwqYcQQasptk05T42HSLo4ApA/5S9f/tniqnibpWQ5YVc2eg3vFSiqeYNnEgACnHXYJD5md@vger.kernel.org
X-Gm-Message-State: AOJu0YyEw+EcOZKhtNznyFXkvyrAmkS7/WEpwHCwhl3z1G5ESWH308yX
	vjyi2McTS8Jv1ZCVbekPphAUf4t7DbVTjYfPVxlv6Dx3CyDiIHfynHm5+7fc4F99d+DImyQUU0R
	ufVWIkMUbi+mqNnsUgcsshfm0u3QfySrWteoktH5sVZ/tUnvvhioyDNsy3IM=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6181:b0:65f:6532:6874 with SMTP id
 006d021491bc7-660f29f8a55mr472042eaf.24.1768267886535; Mon, 12 Jan 2026
 17:31:26 -0800 (PST)
Date: Mon, 12 Jan 2026 17:31:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6965a06e.050a0220.38aacd.0005.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_read_inline_data
From: syzbot <syzbot+6986a30df88382d1f7bf@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    54e82e93ca93 Merge tag 'core_urgent_for_v6.19_rc4' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108c5074580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=6986a30df88382d1f7bf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e0df92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1641b1fc580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-54e82e93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3befb5f53a4/vmlinux-54e82e93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92820ca1dbd8/bzImage-54e82e93.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6baf5cb1e4ff/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1317583a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6986a30df88382d1f7bf@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
loop0: detected capacity change from 2048 to 2045
==================================================================
BUG: KASAN: use-after-free in ext4_read_inline_data+0x1d0/0x2c0 fs/ext4/inline.c:214
Read of size 68 at addr ffff8880566c2810 by task syz.0.17/5510

CPU: 0 UID: 0 PID: 5510 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 ext4_read_inline_data+0x1d0/0x2c0 fs/ext4/inline.c:214
 ext4_read_inline_dir+0x2b3/0xb80 fs/ext4/inline.c:1405
 ext4_readdir+0x3e8/0x3e90 fs/ext4/dir.c:162
 iterate_dir+0x399/0x570 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97a4b8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97a59cc038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f97a4de5fa0 RCX: 00007f97a4b8f7c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f97a4c13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f97a4de6038 R14: 00007f97a4de5fa0 R15: 00007fff8c641cb8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7fd834db2 pfn:0x566c2
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea000159b0c8 ffffea000159b148 0000000000000000
raw: 00000007fd834db2 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP), pid 5511, tgid 5511 (rm), ts 103393754947, free_ts 103419734757
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1857
 prep_new_page mm/page_alloc.c:1865 [inline]
 get_page_from_freelist+0x24e0/0x2580 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2486
 folio_alloc_mpol_noprof mm/mempolicy.c:2505 [inline]
 vma_alloc_folio_noprof+0xe4/0x200 mm/mempolicy.c:2540
 folio_prealloc+0x30/0x180 mm/memory.c:-1
 alloc_anon_folio mm/memory.c:5165 [inline]
 do_anonymous_page mm/memory.c:5222 [inline]
 do_pte_missing+0x14e8/0x3330 mm/memory.c:4399
 handle_pte_fault mm/memory.c:6273 [inline]
 __handle_mm_fault mm/memory.c:6411 [inline]
 handle_mm_fault+0x1b26/0x32b0 mm/memory.c:6580
 do_user_addr_fault+0xa7c/0x1380 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x71/0xd0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
page last free pid 5511 tgid 5511 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_unref_folios+0xdb3/0x14f0 mm/page_alloc.c:3000
 folios_put_refs+0x584/0x670 mm/swap.c:1002
 free_pages_and_swap_cache+0x4be/0x520 mm/swap_state.c:358
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:397 [inline]
 tlb_flush_mmu+0x3a0/0x680 mm/mmu_gather.c:404
 tlb_finish_mmu+0xc3/0x1d0 mm/mmu_gather.c:497
 exit_mmap+0x439/0xb10 mm/mmap.c:1290
 __mmput+0x118/0x430 kernel/fork.c:1173
 exit_mm+0x169/0x230 kernel/exit.c:581
 do_exit+0x627/0x22f0 kernel/exit.c:959
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1112
 __do_sys_exit_group kernel/exit.c:1123 [inline]
 __se_sys_exit_group kernel/exit.c:1121 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1121
 __pfx_syscall_get_nr+0x0/0x10 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880566c2700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880566c2780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880566c2800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff8880566c2880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880566c2900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

