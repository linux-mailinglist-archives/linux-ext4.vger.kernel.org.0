Return-Path: <linux-ext4+bounces-10364-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E048B949D4
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF46016AB4B
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841130F92F;
	Tue, 23 Sep 2025 06:49:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F339274B55
	for <linux-ext4@vger.kernel.org>; Tue, 23 Sep 2025 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610193; cv=none; b=k4qPS01J3OTflXJ6ScRN6PrNH4YUrgOY+AFPRQKCh+k7viWxJ+btq99tAZfrSQl9sbP0KkApr+0ubmWdw1pAkSAxXYXwq/JfNVIHb7EZgGVsRDGiirGcbWAWwXF44u5X/0P7WDUH27mtPY9d+OY+wjqTURahriDfK/m7OznuTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610193; c=relaxed/simple;
	bh=y2xXAN6fsjiOsrglwVGUYqI/+fngTfO6twy2UxLP/0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FWiUXqpl8MTd0P7x6PGJBH7c1bSGX1KD30Sj6BUiPGbA7fTWOKsCQtrcFwDmdTLVbQzbaT0HBbFB8QZ0o0KsiF46/601JK4hxtTvenPv+RdyUW5DwKzgwGqYMWaLwfDpYdMHF2sB3EGp9RZLFWyj5mX2c6crZZuK8ca+NWzYrn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42486b1d287so37410475ab.0
        for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 23:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758610190; x=1759214990;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+0nR0l5xi2ZPgeAlq0yrhc9opZMrbgxpYLe7VwbU0k=;
        b=iXGIvadftYyT4RrtncVqqWH0zRLnP1Pyhwsta9mLcTYAPKGb6xF5jS7fjYutwB35Om
         rdzx1W6Mr9r5Ww0gWw1URT3bG2lVas66Y5mDMn+OHe8bqSSp1NmWpY1ln0XWMAH1B9A1
         YOTw0ujbR9LpZq80d+3Srj4oB+AaNbLGZfcvZR4SGX6B7ga5sAFMyjpFy0Bzjv7J2ova
         KeHnxd27WjNWb/FEWu36yBqeS/Yq9qFaYYqLtEXcBO0K1eAIjvs2hOHWSftyOTgAqNu6
         MQNJA5QPa7v19t1SYuIy70Vw+wYchAsdp7dorI7uLffuqPGYQlAEa9/zndO+rsQvuTYM
         5dDA==
X-Forwarded-Encrypted: i=1; AJvYcCWUll2RtZNVaed4MP6Q1yNl8TEsvdad7J8YHcg96002dIN8qPrwCTIebGhndbB1kbF0orx6upqMeTmk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Y7lvv1o5vQbbFTwwRiB0MajtZSGttwtxYdiKvfrH4Hm2w2XZ
	fnbm0ATLWY65X3tIkvgWS0aEFjbyRqArp5rxPdUoO0DXXxd4cjzO5HoYtb6GauihM4P5XsDXgVh
	/q7aMb0SDxR6hWERFxcf3ykoyKxKVvaQN2kCRFU23PA9y+mELw+YHvqoEhlI=
X-Google-Smtp-Source: AGHT+IFeLnxF3U/PAtUlvPa5vrcP3KxC1j1HJfHxGNlK2xFKnExpBUAmcG4od6VkJRuL/TxzJ7t51KWUVLg7HLZwpBUdzfmV0Tze
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1529:b0:424:a30:d64b with SMTP id
 e9e14a558f8ab-42581e82000mr20932565ab.19.1758610190557; Mon, 22 Sep 2025
 23:49:50 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:49:50 -0700
In-Reply-To: <20250923012724.2378858-1-yi.zhang@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2430e.050a0220.139b6.0020.GAE@google.com>
Subject: [syzbot ci] Re: ext4: optimize online defragment
From: syzbot ci <syzbot+ci8005d4bb935760f0@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, yangerkun@huawei.com, 
	yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] ext4: optimize online defragment
https://lore.kernel.org/all/20250923012724.2378858-1-yi.zhang@huaweicloud.com
* [PATCH 01/13] ext4: fix an off-by-one issue during moving extents
* [PATCH 02/13] ext4: correct the checking of quota files before moving extents
* [PATCH 03/13] ext4: introduce seq counter for the extent status entry
* [PATCH 04/13] ext4: make ext4_es_lookup_extent() pass out the extent seq counter
* [PATCH 05/13] ext4: pass out extent seq counter when mapping blocks
* [PATCH 06/13] ext4: use EXT4_B_TO_LBLK() in mext_check_arguments()
* [PATCH 07/13] ext4: add mext_check_validity() to do basic check
* [PATCH 08/13] ext4: refactor mext_check_arguments()
* [PATCH 09/13] ext4: rename mext_page_mkuptodate() to mext_folio_mkuptodate()
* [PATCH 10/13] ext4: introduce mext_move_extent()
* [PATCH 11/13] ext4: switch to using the new extent movement method
* [PATCH 12/13] ext4: add large folios support for moving extents
* [PATCH 13/13] ext4: add two trace points for moving extents

and found the following issues:
* KASAN: slab-out-of-bounds Read in ext4_inode_journal_mode
* general protection fault in ext4_inode_journal_mode

Full report is available here:
https://ci.syzbot.org/series/89adca9b-1e59-47cd-8ba6-0a57d76309c9

***

KASAN: slab-out-of-bounds Read in ext4_inode_journal_mode

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      07e27ad16399afcd693be20211b0dfae63e0615f
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/17d2b187-99c8-4493-9c72-e8fcf7741d20/config
C repro:   https://ci.syzbot.org/findings/b98c412d-c481-4663-b80b-a50550db3406/c_repro
syz repro: https://ci.syzbot.org/findings/b98c412d-c481-4663-b80b-a50550db3406/syz_repro

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
ext4 filesystem being mounted at /0/bus supports timestamps until 2038-01-19 (0x7fffffff)
==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_inode_journal_mode+0x7b/0x480 fs/ext4/ext4_jbd2.c:12
Read of size 8 at addr ffff88801cefc378 by task syz.0.17/5984

CPU: 0 UID: 0 PID: 5984 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 ext4_inode_journal_mode+0x7b/0x480 fs/ext4/ext4_jbd2.c:12
 ext4_should_journal_data fs/ext4/ext4_jbd2.h:381 [inline]
 mext_check_validity fs/ext4/move_extent.c:426 [inline]
 ext4_move_extents+0x2bb/0x3630 fs/ext4/move_extent.c:579
 __ext4_ioctl fs/ext4/ioctl.c:1356 [inline]
 ext4_ioctl+0x26a7/0x33c0 fs/ext4/ioctl.c:1616
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a6678ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea3688b38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6a669d5fa0 RCX: 00007f6a6678ec29
RDX: 0000200000000040 RSI: 00000000c028660f RDI: 0000000000000004
RBP: 00007f6a66811e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6a669d5fa0 R14: 00007f6a669d5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 1:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4407
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 shmem_fill_super+0xc8/0x1190 mm/shmem.c:5059
 vfs_get_super fs/super.c:1325 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1344
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 fc_mount fs/namespace.c:1247 [inline]
 vfs_kern_mount+0xbe/0x160 fs/namespace.c:1286
 devtmpfs_init+0x98/0x330 drivers/base/devtmpfs.c:484
 driver_init+0x15/0x60 drivers/base/init.c:25
 do_basic_setup+0xf/0x70 init/main.c:1363
 kernel_init_freeable+0x334/0x4b0 init/main.c:1579
 kernel_init+0x1d/0x1d0 init/main.c:1469
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88801cefc000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 544 bytes to the right of
 allocated 344-byte region [ffff88801cefc000, ffff88801cefc158)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1cefc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a441c80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a441c80 dead000000000122 0000000000000000
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea000073bf01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 1877776345, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4402
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 shmem_fill_super+0xc8/0x1190 mm/shmem.c:5059
 vfs_get_super fs/super.c:1325 [inline]
 get_tree_nodev+0xbb/0x150 fs/super.c:1344
 vfs_get_tree+0x92/0x2b0 fs/super.c:1815
 fc_mount fs/namespace.c:1247 [inline]
 vfs_kern_mount+0xbe/0x160 fs/namespace.c:1286
 devtmpfs_init+0x98/0x330 drivers/base/devtmpfs.c:484
 driver_init+0x15/0x60 drivers/base/init.c:25
 do_basic_setup+0xf/0x70 init/main.c:1363
 kernel_init_freeable+0x334/0x4b0 init/main.c:1579
 kernel_init+0x1d/0x1d0 init/main.c:1469
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801cefc200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801cefc280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801cefc300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                                ^
 ffff88801cefc380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801cefc400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


***

general protection fault in ext4_inode_journal_mode

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      07e27ad16399afcd693be20211b0dfae63e0615f
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/17d2b187-99c8-4493-9c72-e8fcf7741d20/config
syz repro: https://ci.syzbot.org/findings/9f9fdff9-ee39-4921-9a7a-35ab05cc081b/syz_repro

EXT4-fs (loop1): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 r/w without journal. Quota mode: none.
ext4 filesystem being mounted at /0/mnt supports timestamps until 2038-01-19 (0x7fffffff)
Oops: general protection fault, probably for non-canonical address 0xdffffc000000006f: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000378-0x000000000000037f]
CPU: 0 UID: 0 PID: 6013 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ext4_inode_journal_mode+0x6d/0x480 fs/ext4/ext4_jbd2.c:12
Code: 00 4d 03 7d 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 03 9e b6 ff 41 bc 78 03 00 00 4d 03 27 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 e5 9d b6 ff 49 83 3c 24 00 0f 84 01
RSP: 0018:ffffc90002d6f638 EFLAGS: 00010206
RAX: 000000000000006f RBX: ffff88811249ad48 RCX: ffff888021ed9cc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88811249ad48
RBP: dffffc0000000000 R08: ffff88811249ae2f R09: 1ffff110224935c5
R10: dffffc0000000000 R11: ffffed10224935c6 R12: 0000000000000378
R13: ffff88811249ad70 R14: 1ffff110224935ae R15: ffff88801bfa6640
FS:  00007fa922e456c0(0000) GS:ffff8880b8612000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000040 CR3: 000000010f5f6000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ext4_should_journal_data fs/ext4/ext4_jbd2.h:381 [inline]
 mext_check_validity fs/ext4/move_extent.c:426 [inline]
 ext4_move_extents+0x2bb/0x3630 fs/ext4/move_extent.c:579
 __ext4_ioctl fs/ext4/ioctl.c:1356 [inline]
 ext4_ioctl+0x26a7/0x33c0 fs/ext4/ioctl.c:1616
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa921f8ec29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa922e45038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa9221d5fa0 RCX: 00007fa921f8ec29
RDX: 0000200000000040 RSI: 00000000c028660f RDI: 0000000000000004
RBP: 00007fa922011e41 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa9221d6038 R14: 00007fa9221d5fa0 R15: 00007ffcaaedca68
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_inode_journal_mode+0x6d/0x480 fs/ext4/ext4_jbd2.c:12
Code: 00 4d 03 7d 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 03 9e b6 ff 41 bc 78 03 00 00 4d 03 27 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 e5 9d b6 ff 49 83 3c 24 00 0f 84 01
RSP: 0018:ffffc90002d6f638 EFLAGS: 00010206
RAX: 000000000000006f RBX: ffff88811249ad48 RCX: ffff888021ed9cc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88811249ad48
RBP: dffffc0000000000 R08: ffff88811249ae2f R09: 1ffff110224935c5
R10: dffffc0000000000 R11: ffffed10224935c6 R12: 0000000000000378
R13: ffff88811249ad70 R14: 1ffff110224935ae R15: ffff88801bfa6640
FS:  00007fa922e456c0(0000) GS:ffff8881a3c12000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000012c0 CR3: 000000010f5f6000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	00 4d 03             	add    %cl,0x3(%rbp)
   3:	7d 00                	jge    0x5
   5:	4c 89 f8             	mov    %r15,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  10:	74 08                	je     0x1a
  12:	4c 89 ff             	mov    %r15,%rdi
  15:	e8 03 9e b6 ff       	call   0xffb69e1d
  1a:	41 bc 78 03 00 00    	mov    $0x378,%r12d
  20:	4d 03 27             	add    (%r15),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 e5 9d b6 ff       	call   0xffb69e1d
  38:	49 83 3c 24 00       	cmpq   $0x0,(%r12)
  3d:	0f                   	.byte 0xf
  3e:	84 01                	test   %al,(%rcx)


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

