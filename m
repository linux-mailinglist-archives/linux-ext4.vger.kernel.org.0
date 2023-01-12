Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73235666F50
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjALKQ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Jan 2023 05:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbjALKOn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Jan 2023 05:14:43 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E9513E02
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 02:13:40 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so13163837iln.21
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 02:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1B5TtT93/g+vbsCCntuxK9Qixxn6vCU63S0WfdyW6sQ=;
        b=Kaa8LzC+XhW1AFzd89cDoOuq001el8gDggcQ8XweKFKubEiXmdUTRgmsD7l+AZWYwQ
         CG9QIZZh/IXpoOsw27yUXjnJr4tKnVlOviyS4BLnnMzWUorGpMl/SzBCIWT05EFY3LkD
         ZvfMmhnjiCq9MkJXarFO3gmdO0+mMG2OMVv5LNbFnIHdCghm9YVw0g8tzOCogjK1wLyM
         wOlkoYud9IbthsGn0xD9ZVpTTyMjVK0BxHDnbZiBQMrh/mDv6Fef51V+gRNjxUpUDAY5
         wMq3kr3uKeSC2RSUCgIeacIDRNHAd8AwXVnpRspLeoEhMpjJOHD8vA1Ogts0olAa10Uk
         MJ2A==
X-Gm-Message-State: AFqh2kpN7ygg8cS7g8wRhGv/SqI8kABW6REwZ37dqi0QYY9xLOtX0Imr
        V3G5FksVuZWEu42A5Hj4AqYvOuRvhLdcjY64PHkrwow3TBD8
X-Google-Smtp-Source: AMrXdXstN08MdP+LVlblsKZyVLtN6R1NGC2DQ6OUTQfXpVl56ghh30pIHM47hWcSea2JFgrv8MpsTzMGy6YpNizJLdcj+4AY3Khv
MIME-Version: 1.0
X-Received: by 2002:a02:caa1:0:b0:389:ce3b:6bc0 with SMTP id
 e1-20020a02caa1000000b00389ce3b6bc0mr6314944jap.61.1673518420110; Thu, 12 Jan
 2023 02:13:40 -0800 (PST)
Date:   Thu, 12 Jan 2023 02:13:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4b96605f20e5e2f@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in signalfd_cleanup
From:   syzbot <syzbot+8317cc9c082c19d576a0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11369f1c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=8317cc9c082c19d576a0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8317cc9c082c19d576a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
Read of size 8 at addr ffff888075a278f0 by task syz-executor.3/5101

CPU: 1 PID: 5101 Comm: syz-executor.3 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
 __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
 __wake_up kernel/sched/wait.c:160 [inline]
 __wake_up_pollfree+0x1d/0x60 kernel/sched/wait.c:246
 wake_up_pollfree include/linux/wait.h:271 [inline]
 signalfd_cleanup+0x46/0x60 fs/signalfd.c:38
 __cleanup_sighand kernel/fork.c:1688 [inline]
 __cleanup_sighand+0x76/0xb0 kernel/fork.c:1685
 __exit_signal kernel/exit.c:209 [inline]
 release_task+0xbfa/0x1870 kernel/exit.c:255
 wait_task_zombie kernel/exit.c:1198 [inline]
 wait_consider_task+0x306d/0x3ce0 kernel/exit.c:1425
 do_wait_thread kernel/exit.c:1488 [inline]
 do_wait+0x7cd/0xd90 kernel/exit.c:1605
 kernel_wait4+0x150/0x260 kernel/exit.c:1768
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1796
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f65a2089ca7
Code: 89 7c 24 10 48 89 4c 24 18 e8 f5 58 02 00 4c 8b 54 24 18 8b 54 24 14 41 89 c0 48 8b 74 24 08 8b 7c 24 10 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24 10 e8 25 59 02 00 8b 44
RSP: 002b:00007ffefc1200b0 EFLAGS: 00000293
 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 000000000000054a RCX: 00007f65a2089ca7
RDX: 0000000040000001 RSI: 00007ffefc12013c RDI: 00000000ffffffff
RBP: 00007ffefc12013c R08: 0000000000000000 R09: 00007ffefc1ad080
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 000000000021b8d4 R14: 0000000000000009 R15: 00007ffefc1201a0
 </TASK>

Allocated by task 14352:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1062
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2407
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3429
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 12659:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0xec/0x4e0 mm/slub.c:3809
 io_req_caches_free+0x1a9/0x1e6 io_uring/io_uring.c:2737
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2967
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888075a278c0
 which belongs to the cache io_kiocb of size 216
The buggy address is located 48 bytes inside of
 216-byte region [ffff888075a278c0, ffff888075a27998)

The buggy address belongs to the physical page:
page:ffffea0001d689c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75a27
memcg:ffff888028fe9e01
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888146399500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff888028fe9e01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 12466, tgid 12462 (syz-executor.3), ts 1668345481737, free_ts 1642794681828
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2281
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
 kmem_cache_alloc_bulk+0x23d/0x730 mm/slub.c:4026
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1062
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2407
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3429
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2637
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x20e/0x580 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:2692 [inline]
 ext4_alloc_inode+0x28/0x680 fs/ext4/super.c:1321
 alloc_inode+0x61/0x230 fs/inode.c:260
 new_inode_pseudo fs/inode.c:1019 [inline]
 new_inode+0x2b/0x280 fs/inode.c:1047
 __ext4_new_inode+0x399/0x58c0 fs/ext4/ialloc.c:959
 ext4_create+0x2da/0x4e0 fs/ext4/namei.c:2809
 lookup_open.isra.0+0xee7/0x1270 fs/namei.c:3414
 open_last_lookups fs/namei.c:3482 [inline]
 path_openat+0x97a/0x2b40 fs/namei.c:3712
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311

Memory state around the buggy address:
 ffff888075a27780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075a27800: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
>ffff888075a27880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                             ^
 ffff888075a27900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075a27980: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
