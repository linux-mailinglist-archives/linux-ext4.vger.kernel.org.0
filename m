Return-Path: <linux-ext4+bounces-10457-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B393BBA590D
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 06:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF121C03832
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 04:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB730212552;
	Sat, 27 Sep 2025 04:51:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC041F94A
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758948693; cv=none; b=XHHzePJg7Jn/ufjlMXlhJelNQDG+9oh0j5qqKs/MG0Z/87Bj7+vKQTQodbkbggY5z3igGo7JHZ2Gii9d4tPa+VtvhFFToIeOEFglEtBcaGyggw7t4rjvedk2mQrajnHPOrEZnFpCsGIgH5lJ5DyCitzel59srGfsX/j8mTrUC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758948693; c=relaxed/simple;
	bh=+8VJcWVcTBWDMMi9CXwX5RaEFBPA3ahSGJ6psvA3ClM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YnRSNSpm9bf3zDDjEDjf61bSqQfNB+xJgGgdzsLQpvMsfRty0epb7EQ1hv7NTS8DzmdslN4GpgN4hZEQQaU4Bh46FxhkhH7JwHfr3bAhaX+OxFI1/m4t/yDCd14W4BGfULq+AQzDWcqZsWjnOHXsFHsIMwsjjVhtp/lEw2x/7k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-42594b7f324so53121905ab.1
        for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 21:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758948691; x=1759553491;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UFnJucvISRNqIEwLGqwT+rp6ExL31k9RQGQNKs4YQQ=;
        b=LFsJ3Xyxt1veEU0mvIvoid32V3gwz14o2xds3ldBXagrvp66LtmXCGKyPoSUIUAxIe
         bYfcoKH7Vl7TPT+kwx22oGcJG6VF564rlnxA+guquEbmMrLPJPaJ9KJ1vQhOLXi9/ir1
         9ISTGNog1LM8s6e1p7e4AHNPN8QHI6MvmXTs8R7B0x2i4DTN1LivrPZ0KnVSjddAeWuI
         7TRdwsrMB3vsSTy7EkwTT9QF0GITV4+vkV/KmRmLG2GIW32xR2rmW6TrWRsFJoHYUz42
         Eqrd4IvBxt35Fx5eeGGS5jx2phzVfA0d4Cib4c9FVuqi44e4KD14W6iTsUzDeO0n8a1Y
         NrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTDKaQzcriIx8Wvn+5C3xe4JzUhL+7UUUXDiYsHll2LnYxcLv45VM1ixN2i06Qqf6TnN44FOi2Yfsy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7sUy9TtrirPbZocL98w741JKBVQMQfHCCMhNuHiDdUn4gSwBP
	/c4wQFUKC+3UUQIvXtjpQyUX+bkBq5X8NVmOLmA62A6KQghVxwsqHicUbcQy4ko2xtmSKaU/eMW
	/q10Z7jCguDBigBytGI4LKJQMrEGsL0Yq9dRM11F0cTY8Kn6Unr3NtQka+LE=
X-Google-Smtp-Source: AGHT+IGn+v1lXcT0slsnE/ZOrO0j0gbTEkebQ8Zq3jFB3wHgoQMDab1xyet9S3+2FBy1/mwuUx/vzrKYmYx0fuM97F/Ah/AQBktC
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:230a:b0:425:7788:871 with SMTP id
 e9e14a558f8ab-42875791953mr31005765ab.12.1758948690874; Fri, 26 Sep 2025
 21:51:30 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:51:30 -0700
In-Reply-To: <6862c942.a70a0220.2f4de1.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d76d52.a00a0220.102ee.000c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in __ext4_check_dir_entry
From: syzbot <syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, djwong@kernel.org, dmantipov@yandex.ru, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    083fc6d7fa0d Merge tag 'sched-urgent-2025-09-26' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106a3d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=5322c5c260eb44d209ed
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e032e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146a3d34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/198ae77e2418/disk-083fc6d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d3f065fd75c/vmlinux-083fc6d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e65812e9d7b0/bzImage-083fc6d7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/275ff9023118/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1749327c580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com

EXT4-fs warning (device loop2): dx_probe:801: inode #2: comm syz.2.1679: Unrecognised inode hash code 4
EXT4-fs warning (device loop2): dx_probe:934: inode #2: comm syz.2.1679: Corrupt directory, running e2fsck is recommended
==================================================================
BUG: KASAN: slab-use-after-free in __ext4_check_dir_entry+0x708/0x8a0 fs/ext4/dir.c:85
Read of size 2 at addr ffff888032f79003 by task syz.2.1679/10706

CPU: 0 UID: 0 PID: 10706 Comm: syz.2.1679 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __ext4_check_dir_entry+0x708/0x8a0 fs/ext4/dir.c:85
 ext4_readdir+0x12a2/0x3b70 fs/ext4/dir.c:262
 iterate_dir+0x3a5/0x580 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f33499feec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f334906e038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f3349c55fa0 RCX: 00007f33499feec9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f3349a81f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3349c56038 R14: 00007f3349c55fa0 R15: 00007ffebc0b5dc8
 </TASK>

Allocated by task 43:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_node_noprof+0x14e/0x330 mm/slub.c:4292
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:763 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x29f/0xbc0 drivers/net/netdevsim/dev.c:866
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 43:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kmem_cache_free+0x195/0x510 mm/slub.c:4797
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:836 [inline]
 nsim_dev_trap_report_work+0x7fa/0xbc0 drivers/net/netdevsim/dev.c:866
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888032f79000
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 3 bytes inside of
 freed 240-byte region [ffff888032f79000, ffff888032f790f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32f79
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff88801de968c0 ffffea000085e780 dead000000000004
raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5208, tgid 5208 (udevd), ts 27594846702, free_ts 27586335299
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0x8d1/0xdc0 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 kmem_cache_alloc_node_noprof+0xf2/0x330 mm/slub.c:4292
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 netlink_sendmsg+0x5c6/0xb30 net/netlink/af_netlink.c:1871
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x508/0x820 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5216 tgid 5216 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xb59/0xce0 mm/page_alloc.c:2895
 __slab_free+0x2db/0x390 mm/slub.c:4606
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4191 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x143/0x310 mm/slub.c:4247
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2919 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888032f78f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888032f78f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888032f79000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888032f79080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff888032f79100: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

