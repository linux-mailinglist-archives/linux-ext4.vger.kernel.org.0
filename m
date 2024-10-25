Return-Path: <linux-ext4+bounces-4813-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3329B12FE
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Oct 2024 00:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BC11C220CB
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542DC1D90C8;
	Fri, 25 Oct 2024 22:56:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EDD176237
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896999; cv=none; b=E0G6ZLMu8rpn4Iy66lXFZDJj/f1KMaTHdK1HbQQlxxFwWO0eQZnCgj+MhkBYdcrEEPVVkVVS+C394mB9pG1Sz2X3RNVQIgI5HdM5N2RTFhGY3GszwO7Sr52Eg9bt2chNRs8GMgXFXa1UINRtxzTGDKiRiss5I3x1lGHBX2NBpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896999; c=relaxed/simple;
	bh=NURhX7VajXuVw6T/SlrS3FyO4xqhaC0mjC8KI6RSyxo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VWfg3USBkC/VtrLR67ykYeXBr6AsteyG1ATLqO/yWaEcMKg7GqyACI99Zz0f1slrubSAxAUhHrYXD4O5Bp8vkDHXaBFa2/dUARwoABrBlobktx6rvuz4VdNm9oehL/C/PbJD7fkQK286rBpXI5yv3MTxSTYfWTqvuB1mV6a2mhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c4554d29so24272255ab.1
        for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 15:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729896996; x=1730501796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1lQAxnGM3jVIiwN9wMg5CL9lmlYL6zssFNUQUkrfO0=;
        b=ljveuwQQbhaRkBxozMc+HrMqem+EsAwpGSoGrsXow2Ho7DWKTy+GBAhs1qg4FSh0Cs
         kKrkBlg1wmMeM8u2G9Lp2ToLs73aam8HEclVNkqdKN9LjIb0qMwGk8BKfBNu9mjphddL
         wVXqOiv5R5yPygVZJ5RBPRgglCu8018jh7CgNJhZpjapixMfwl+x4gQ02UMtxFV+PAit
         9JnW9zZQJcOqyCZm8Kf+XIriTvoy74UPdHvbfHKeXLjHJhM9ju5ocB18gL2sRuPkJpDl
         5wgtGANU/BgEBpMd1kMcl3CTo11m8PFhp5KiqhbdzXY4jkhzTmt9U2b5V3qgvuzMJYeH
         /Xkw==
X-Forwarded-Encrypted: i=1; AJvYcCWz+oKWGO88rEgIdudO2wY4xBbmoG8taxw1iEUmbwSp89Zu9jUXNSu6qKqbb1EU7TzB69C7llFt2j5B@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6BiqaO8Yhh78zhDiSlZuy+x/XtI0iHWyocg+ZsmkUHBuUSj9p
	PC06DG9KR+1Gn5vj2Okcv8u5BGX/gY7FgrUxQ2GLteiPPFj7gtnrw23i0Vyh9NzIlsSDCvuqnWY
	l+/kN4EfqGN3ptJl6vS3H12ewRfrhleUqx3XOkJ/cqYiD4DAf5Xn/VVI=
X-Google-Smtp-Source: AGHT+IGljCppUdoGLoka3lGWMIEEsikrn02ak4fWg30OQoS3diLQACy08ANIfBSEFsd7vvONGMeEVdQOpmJNltEU64YUAv8NFDyQ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:3a2:7651:9867 with SMTP id
 e9e14a558f8ab-3a4ed2b28damr7781745ab.13.1729896995821; Fri, 25 Oct 2024
 15:56:35 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:56:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c2223.050a0220.2fdf0c.021c.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Write in ext4_insert_dentry
From: syzbot <syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    42f7652d3eb5 Linux 6.12-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a89430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=0c99c3f90699936c1e77
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162e625f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14695c87980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-42f7652d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27fd6c638478/vmlinux-42f7652d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5f529516264/bzImage-42f7652d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c97aae4b16ba/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_orphan_get:1393: comm syz-executor407: couldn't read orphan inode 15 (err -117)
EXT4-fs (loop0): mounted filesystem 00000007-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
==================================================================
BUG: KASAN: use-after-free in ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
Write of size 251 at addr ffff88803f1f7f14 by task syz-executor407/5095

CPU: 0 UID: 0 PID: 5095 Comm: syz-executor407 Not tainted 6.12.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
 add_dirent_to_buf+0x3d9/0x750 fs/ext4/namei.c:2154
 make_indexed_dir+0xf98/0x1600 fs/ext4/namei.c:2351
 ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2455
 ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2796
 ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3431
 vfs_symlink+0x137/0x2e0 fs/namei.c:4615
 do_symlinkat+0x222/0x3a0 fs/namei.c:4641
 __do_sys_symlink fs/namei.c:4662 [inline]
 __se_sys_symlink fs/namei.c:4660 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4660
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc65cf86b99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca8aeb358 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fc65cf86b99
RDX: 0000000000000000 RSI: 0000000020000cc0 RDI: 0000000020000dc0
RBP: 00007fc65cffa5f0 R08: 00005555889c84c0 R09: 00005555889c84c0
R10: 00005555889c84c0 R11: 0000000000000246 R12: 00007ffca8aeb380
R13: 00007ffca8aeb5a8 R14: 431bde82d7b634db R15: 00007fc65cfcf03b
 </TASK>

The buggy address belongs to the physical page:
page: refcount:3 mapcount:0 mapping:ffff888031cb4d78 index:0x3f pfn:0x3f1f7
memcg:ffff888030476000
aops:def_blk_aops ino:700000 dentry name(?):""
flags: 0x4fff08000004214(referenced|dirty|workingset|private|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff08000004214 0000000000000000 dead000000000122 ffff888031cb4d78
raw: 000000000000003f ffff8880454cc658 00000003ffffffff ffff888030476000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Movable, gfp_mask 0x148c48(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE), pid 5095, tgid 5095 (syz-executor407), ts 63020312683, free_ts 62616757387
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 grow_dev_folio fs/buffer.c:1043 [inline]
 grow_buffers fs/buffer.c:1109 [inline]
 __getblk_slow fs/buffer.c:1135 [inline]
 bdev_getblk+0x1d8/0x550 fs/buffer.c:1437
 __getblk include/linux/buffer_head.h:380 [inline]
 sb_getblk include/linux/buffer_head.h:386 [inline]
 ext4_getblk+0x303/0x800 fs/ext4/inode.c:859
 ext4_bread+0x2e/0x180 fs/ext4/inode.c:905
 ext4_append+0x327/0x5c0 fs/ext4/namei.c:83
 make_indexed_dir+0x523/0x1600 fs/ext4/namei.c:2272
 ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2455
 ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2796
 ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3431
 vfs_symlink+0x137/0x2e0 fs/namei.c:4615
page last free pid 5089 tgid 5089 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 vms_clear_ptes+0x437/0x530 mm/vma.c:1096
 vms_complete_munmap_vmas+0x208/0x910 mm/vma.c:1140
 do_vmi_align_munmap+0x613/0x730 mm/vma.c:1349
 do_vmi_munmap+0x24e/0x2d0 mm/vma.c:1397
 __vm_munmap+0x24c/0x480 mm/mmap.c:1610
 __do_sys_munmap mm/mmap.c:1627 [inline]
 __se_sys_munmap mm/mmap.c:1624 [inline]
 __x64_sys_munmap+0x68/0x80 mm/mmap.c:1624
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803f1f7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803f1f7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803f1f8000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88803f1f8080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88803f1f8100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

