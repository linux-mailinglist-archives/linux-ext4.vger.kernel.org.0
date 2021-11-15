Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C945450205
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Nov 2021 11:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhKOKMT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Nov 2021 05:12:19 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:38603 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhKOKMR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Nov 2021 05:12:17 -0500
Received: by mail-io1-f70.google.com with SMTP id g4-20020a05660226c400b005e14d3f1e6bso10496453ioo.5
        for <linux-ext4@vger.kernel.org>; Mon, 15 Nov 2021 02:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hF0ttioIMMpwLziEFVAVA27akhYydgnvg2PvTxdpK+A=;
        b=BLxQCNHVOqR/d2/gpZZvXwFnEmrZw5hCEFFsGqXvvoZmyVVws/wL8fEz9vM1q1ILza
         MzVbqV2dfP4bjTBaHLUzRUwuAvGK/ital8JzHpchaQKszHfyskilCN3EeTF10+aIdCr0
         rLhBKNGa7gPYCMSfnj3h4JgqroomEQQhi+8K3bRAoT2TaUiH+cND1Hk96ujCYCFH0mR0
         cdtRZFmLiwUsVQ5JB9lSEtThON9Uk2tlO8gMxvERSceaW9gIME2ofmwgAlTzJouNIPLK
         B+WrOlAnBkaxFG/CGVTagCNTSPL/fLeyD3Gntul83lNuLmtGzP+1fPXVTXtzF0xxBXX1
         3KbA==
X-Gm-Message-State: AOAM531z8mbsoyJnFRxdx1YsPbxJVdmqn67CJUkksFpDYLUrpTPig9Id
        aoOsX75IuNPgeXoYrPYeqLnDnPDJRE0rGB9JHxy/lDGlBOJU
X-Google-Smtp-Source: ABdhPJyMy0HNydehOO4kay8Iu7HVVBGwKto7wYzC/CbGjZvwK3++R0wzUqLxB6mb9/rzkzHVpzKZLdL7wa2BCtojlim93gdjx07B
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1402:: with SMTP id n2mr21124467ilo.208.1636970962209;
 Mon, 15 Nov 2021 02:09:22 -0800 (PST)
Date:   Mon, 15 Nov 2021 02:09:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5d1ec05d0d1005f@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in crc16
From:   syzbot <syzbot+5c0bc87e73d3c68971d8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c8109c2ba35e Add linux-next specific files for 20211109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=145983eab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c83199208e103
dashboard link: https://syzkaller.appspot.com/bug?extid=5c0bc87e73d3c68971d8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c0bc87e73d3c68971d8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in crc16+0xcb/0xe0 lib/crc16.c:58
Read of size 1 at addr ffff88803a42e048 by task syz-executor.2/32756

CPU: 0 PID: 32756 Comm: syz-executor.2 Not tainted 5.15.0-next-20211109-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x320 mm/kasan/report.c:247
 __kasan_report mm/kasan/report.c:433 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:450
 crc16+0xcb/0xe0 lib/crc16.c:58
 ext4_group_desc_csum+0x646/0x9c0 fs/ext4/super.c:2832
 ext4_group_desc_csum_set+0xc7/0x2a0 fs/ext4/super.c:2855
 __ext4_new_inode+0x14e8/0x5ba0 fs/ext4/ialloc.c:1228
 ext4_create+0x2d6/0x4d0 fs/ext4/namei.c:2746
 lookup_open.isra.0+0xfe4/0x13d0 fs/namei.c:3280
 open_last_lookups fs/namei.c:3350 [inline]
 path_openat+0x9b8/0x2750 fs/namei.c:3556
 do_filp_open+0x1aa/0x400 fs/namei.c:3586
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_creat fs/open.c:1304 [inline]
 __se_sys_creat fs/open.c:1298 [inline]
 __x64_sys_creat+0xc9/0x120 fs/open.c:1298
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f47d529fae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47d2815188 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f47d53b2f60 RCX: 00007f47d529fae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
RBP: 00007f47d52f9f45 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc02a2c6ef R14: 00007f47d2815300 R15: 0000000000022000
 </TASK>

Allocated by task 31139:
 kasan_save_stack+0x1e/0x50 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:259 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3234 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3247
 inet_bind_bucket_create net/ipv4/inet_hashtables.c:70 [inline]
 __inet_hash_connect+0x8b7/0x1190 net/ipv4/inet_hashtables.c:802
 dccp_v4_connect+0xc44/0x16a0 net/dccp/ipv4.c:109
 __inet_stream_connect+0x8cf/0xed0 net/ipv4/af_inet.c:660
 inet_stream_connect+0x53/0xa0 net/ipv4/af_inet.c:724
 __sys_connect_file+0x155/0x1a0 net/socket.c:1896
 io_connect+0x15f/0x690 fs/io_uring.c:5206
 io_issue_sqe+0xc64/0x7010 fs/io_uring.c:6669
 __io_queue_sqe fs/io_uring.c:6974 [inline]
 io_queue_sqe fs/io_uring.c:7016 [inline]
 io_submit_sqe fs/io_uring.c:7219 [inline]
 io_submit_sqes+0x1bca/0x8a20 fs/io_uring.c:7325
 __do_sys_io_uring_enter+0xf6e/0x1f50 fs/io_uring.c:10039
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88803a42e000
 which belongs to the cache dccp_bind_bucket of size 72
The buggy address is located 0 bytes to the right of
 72-byte region [ffff88803a42e000, ffff88803a42e048)
The buggy address belongs to the page:
page:ffffea0000e90b80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3a42e
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff88814ac2bb40
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 26283, ts 2064035128689, free_ts 2063994647722
 prep_new_page mm/page_alloc.c:2418 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4149
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5369
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 alloc_slab_page mm/slub.c:1793 [inline]
 allocate_slab mm/slub.c:1930 [inline]
 new_slab+0x32d/0x4a0 mm/slub.c:1993
 ___slab_alloc+0x918/0xfe0 mm/slub.c:3022
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3109
 slab_alloc_node mm/slub.c:3200 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 kmem_cache_alloc+0x35c/0x3a0 mm/slub.c:3247
 inet_bind_bucket_create net/ipv4/inet_hashtables.c:70 [inline]
 __inet_hash_connect+0x8b7/0x1190 net/ipv4/inet_hashtables.c:802
 dccp_v4_connect+0xc44/0x16a0 net/dccp/ipv4.c:109
 __inet_stream_connect+0x8cf/0xed0 net/ipv4/af_inet.c:660
 inet_stream_connect+0x53/0xa0 net/ipv4/af_inet.c:724
 __sys_connect_file+0x155/0x1a0 net/socket.c:1896
 io_connect+0x15f/0x690 fs/io_uring.c:5206
 io_issue_sqe+0xc64/0x7010 fs/io_uring.c:6669
 __io_queue_sqe fs/io_uring.c:6974 [inline]
 io_queue_sqe fs/io_uring.c:7016 [inline]
 io_submit_sqe fs/io_uring.c:7219 [inline]
 io_submit_sqes+0x1bca/0x8a20 fs/io_uring.c:7325
 __do_sys_io_uring_enter+0xf6e/0x1f50 fs/io_uring.c:10039
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3309 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3425
 release_pages+0x3f4/0x1480 mm/swap.c:979
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x630 mm/mmap.c:3173
 __mmput+0x122/0x4b0 kernel/fork.c:1164
 mmput+0x56/0x60 kernel/fork.c:1185
 exit_mm kernel/exit.c:507 [inline]
 do_exit+0xb27/0x2b40 kernel/exit.c:819
 do_group_exit+0x125/0x310 kernel/exit.c:929
 get_signal+0x47d/0x2220 kernel/signal.c:2830
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88803a42df00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803a42df80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803a42e000: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
                                              ^
 ffff88803a42e080: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff88803a42e100: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
