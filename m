Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63EA4AE8CA
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 06:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiBIFFq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 00:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376998AbiBIEbT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Feb 2022 23:31:19 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A4C043183
        for <linux-ext4@vger.kernel.org>; Tue,  8 Feb 2022 20:19:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id a18-20020a923312000000b002b384dccc91so706652ilf.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Feb 2022 20:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=V0oUs8Mx3rtUGoc6VtbBLRU4MEGqEwBOLiYyT0DNM1I=;
        b=BaeWaFzESv3iGaWzl+8MbYu4itRmEzeCL0EqQInitn+HnXvvNLb7+OIPEBosKByPO1
         i54D1KtDZjtKdr/8HhoCFCw0j+HIbA9geo1rCVhTyBYNn7JyQDnM0VUFv5qzd8/QIrHq
         8lAThlv8YAYLsfHQWgq69UwxhIvpno1GOtNMJtN10iNeDJU272YHeqkmBFcNTABLtkSW
         38XBqRgm+zWsRQJTO2S17210MEFKzKMo9+uPz9uEj/fR/AUZA9XQPFaldd8vzw+S7Zds
         q14c999wZn2n8OOPoJep3l6j53x6dhR1lhuhAP4XV/Yeug606XlwScdLJmMn9gEoMdHV
         rYrQ==
X-Gm-Message-State: AOAM532kD88DtG94uceXg6xrhkhoVkNF/A2jA6yIxSrc69aLRJBjuz8O
        BGAR6GJzhCQvoQPoObq4tWugYgq4v5Jny0pn5nyMsFnC/Bgm
X-Google-Smtp-Source: ABdhPJxSSrP5TXs3Lv23bfLj/ZlWwvRmDEwRn2BPdnVck0GR99EZvMC0SeN4NXidHMQRO+bhQTW5ynez4pnVIHEIenmDrpKMMAen
MIME-Version: 1.0
X-Received: by 2002:a92:d58e:: with SMTP id a14mr234775iln.210.1644380360324;
 Tue, 08 Feb 2022 20:19:20 -0800 (PST)
Date:   Tue, 08 Feb 2022 20:19:20 -0800
In-Reply-To: <00000000000040c94205d78125af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040b9d905d78e23ee@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
From:   syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
To:     jack@suse.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ef6b35306dd8 Add linux-next specific files for 20220204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1390be28700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0431e0b00810b4f
dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133db2b4700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17beb4a4700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3d9c/0x54d0 kernel/locking/lockdep.c:4897
Read of size 8 at addr ffff88806dd607f8 by task syz-executor106/5085

CPU: 0 PID: 5085 Comm: syz-executor106 Not tainted 5.17.0-rc2-next-20220204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xa5/0x3e0 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 __lock_acquire+0x3d9c/0x54d0 kernel/locking/lockdep.c:4897
 lock_acquire kernel/locking/lockdep.c:5639 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5604
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:354 [inline]
 jbd2_journal_wait_updates+0x221/0x2b0 fs/jbd2/transaction.c:861
 jbd2_journal_lock_updates+0x183/0x350 fs/jbd2/transaction.c:896
 ext4_ioctl_checkpoint fs/ext4/ioctl.c:1085 [inline]
 __ext4_ioctl+0x1fbb/0x5d10 fs/ext4/ioctl.c:1562
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fdf375bca89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb1463618 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fdf375bca89
RDX: 00000000200001c0 RSI: 000000004004662b RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffeb1463660 R09: 00007ffeb1463660
R10: 00007ffeb14630a0 R11: 0000000000000246 R12: 00007ffeb146364c
R13: 00007ffeb1463660 R14: 00007ffeb14636a0 R15: 00000000000000e5
 </TASK>

Allocated by task 5083:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:705 [inline]
 start_this_handle+0x66e/0x1380 fs/jbd2/transaction.c:375
 jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:525
 __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
 __ext4_new_inode+0x2d9e/0x56f0 fs/ext4/ialloc.c:1080
 ext4_symlink+0x485/0xd40 fs/ext4/namei.c:3293
 vfs_symlink fs/namei.c:4299 [inline]
 vfs_symlink+0x108/0x2c0 fs/namei.c:4284
 do_symlinkat+0x261/0x2e0 fs/namei.c:4328
 __do_sys_symlink fs/namei.c:4350 [inline]
 __se_sys_symlink fs/namei.c:4348 [inline]
 __x64_sys_symlink+0x75/0x90 fs/namei.c:4348
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 5079:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:226 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kmem_cache_free+0xdb/0x3b0 mm/slub.c:3526
 jbd2_journal_free_transaction+0x30/0x40 fs/jbd2/transaction.c:62
 __jbd2_journal_remove_checkpoint+0x438/0x840 fs/jbd2/checkpoint.c:735
 jbd2_log_do_checkpoint+0x494/0xf70 fs/jbd2/checkpoint.c:354
 jbd2_journal_flush+0x1a5/0xc70 fs/jbd2/journal.c:2465
 ext4_ioctl_checkpoint fs/ext4/ioctl.c:1086 [inline]
 __ext4_ioctl+0x200e/0x5d10 fs/ext4/ioctl.c:1562
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88806dd60780
 which belongs to the cache jbd2_transaction_s of size 280
The buggy address is located 120 bytes inside of
 280-byte region [ffff88806dd60780, ffff88806dd60898)
The buggy address belongs to the page:
page:ffffea0001b75800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6dd60
head:ffffea0001b75800 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001b75300 dead000000000002 ffff888017f083c0
raw: 0000000000000000 0000000080150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 3637, ts 427493856385, free_ts 14110756876
 prep_new_page mm/page_alloc.c:2489 [inline]
 get_page_from_freelist+0x13ea/0x31d0 mm/page_alloc.c:4219
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5435
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2268
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x295/0x400 mm/slub.c:2004
 ___slab_alloc+0x7ed/0xe00 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x35c/0x3a0 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:705 [inline]
 start_this_handle+0x66e/0x1380 fs/jbd2/transaction.c:375
 jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:525
 __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5899
 __mark_inode_dirty+0x45b/0xfe0 fs/fs-writeback.c:2370
 generic_update_time fs/inode.c:1856 [inline]
 inode_update_time fs/inode.c:1869 [inline]
 touch_atime+0x63d/0x700 fs/inode.c:1941
 file_accessed include/linux/fs.h:2422 [inline]
 iterate_dir+0x465/0x700 fs/readdir.c:70
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13a/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1356 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3376 [inline]
 free_unref_page+0x19/0x6c0 mm/page_alloc.c:3455
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9434
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1018
 debug_vm_pgtable+0x2a74/0x2b06 mm/debug_vm_pgtable.c:1332
 do_one_initcall+0x103/0x650 init/main.c:1303
 do_initcall_level init/main.c:1378 [inline]
 do_initcalls init/main.c:1394 [inline]
 do_basic_setup init/main.c:1413 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1618
 kernel_init+0x1a/0x1d0 init/main.c:1507
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88806dd60680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806dd60700: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88806dd60780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88806dd60800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806dd60880: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

