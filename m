Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3074AEAA9
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 07:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiBIG4F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 01:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBIG4E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 01:56:04 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC540C05CB82
        for <linux-ext4@vger.kernel.org>; Tue,  8 Feb 2022 22:56:07 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso1156474iov.16
        for <linux-ext4@vger.kernel.org>; Tue, 08 Feb 2022 22:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=v6NI/9n3A4ZoZ3rcZ4LdaTBZfEjCvcrIMB9GrpEWb8o=;
        b=og6qMZM54TcJ99K5Hn0fB3MI7lAj+rVPk52IBmpgMN4nuWcC1lDU1yvsJWEclyCkKG
         9p9A6axtyGc6mTTbHgJ4wd3rZoBEN7RNrCBkFULDcWgtbAOniqIVO/BYS+WiWfJ37hix
         G9Eq750FOS+gcnFHBF5OcSlEfWApbTm7cb2G54sUk3SX+RrhgmPYXzUHxP+G1+UtLLKM
         /TQ8B9qHGesEm+7FqutqH0k+0PjugC6DDRs2dHds0UIFjyvNn6h+26LniXxFEWN/zRov
         bWNUX6JYEAVu2LsDCx52iAzk5sJmNiKWDTC4YzQwMLqC5e8Y7WKvz/0LKWcqfE3BhW89
         Ynbw==
X-Gm-Message-State: AOAM531CYu8cSwVuMw5GKXUv8Z8XqWI09ulrklQzDtYpRMCy8ELlm8Uq
        eo3NP7M4s47b8vGjWQcc17FMKf4vD9YVqkJd85HT9P3GmUwj
X-Google-Smtp-Source: ABdhPJxiRwD1cCblHdWC8H+X3JMFRu/QlUOLTx+qSrlvow5Hy7LpXuyguU1G8/BLCVGrbVjMnJ4KRuiYNcwgfaed47ZFyg4RkSGg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1649:: with SMTP id v9mr446589ilu.199.1644389767311;
 Tue, 08 Feb 2022 22:56:07 -0800 (PST)
Date:   Tue, 08 Feb 2022 22:56:07 -0800
In-Reply-To: <20220209064338.vjhlaaav5dqb2hah@riteshh-domain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3f46005d7905312@google.com>
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

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in jbd2_journal_wait_updates

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: use-after-free in jbd2_journal_wait_updates+0x110/0x270 fs/jbd2/transaction.c:842
Read of size 4 at addr ffff8880692a7ed0 by task syz-executor737/6052

CPU: 0 PID: 6052 Comm: syz-executor737 Not tainted 5.17.0-rc3-syzkaller-00031-g3ca14294b33a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x8d/0x336 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 jbd2_journal_wait_updates+0x110/0x270 fs/jbd2/transaction.c:842
 jbd2_journal_lock_updates+0x183/0x350 fs/jbd2/transaction.c:884
 ext4_ioctl_checkpoint fs/ext4/ioctl.c:1085 [inline]
 __ext4_ioctl+0x1fba/0x57e0 fs/ext4/ioctl.c:1562
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fd37940fa79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd07b8da78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd37940fa79
RDX: 00000000200001c0 RSI: 000000004004662b RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd07b8dac0 R09: 00007ffd07b8dac0
R10: 00007ffd07b8d500 R11: 0000000000000246 R12: 00007ffd07b8daac
R13: 00007ffd07b8dac0 R14: 00007ffd07b8db00 R15: 000000000000013e
 </TASK>

Allocated by task 4066:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x202/0x3a0 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:705 [inline]
 start_this_handle+0x674/0x14a0 fs/jbd2/transaction.c:370
 jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:520
 __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_unlink+0x2f4/0x9e0 fs/ext4/namei.c:3224
 vfs_unlink+0x351/0x920 fs/namei.c:4150
 do_unlinkat+0x3c9/0x650 fs/namei.c:4218
 __do_sys_unlink fs/namei.c:4266 [inline]
 __se_sys_unlink fs/namei.c:4264 [inline]
 __x64_sys_unlink+0xc6/0x110 fs/namei.c:4264
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 6049:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x130/0x160 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kmem_cache_free+0xd8/0x340 mm/slub.c:3526
 jbd2_journal_free_transaction+0x30/0x40 fs/jbd2/transaction.c:62
 __jbd2_journal_remove_checkpoint+0x438/0x840 fs/jbd2/checkpoint.c:735
 jbd2_log_do_checkpoint+0x49c/0xf80 fs/jbd2/checkpoint.c:354
 jbd2_journal_flush+0x1a5/0xc70 fs/jbd2/journal.c:2465
 ext4_ioctl_checkpoint fs/ext4/ioctl.c:1086 [inline]
 __ext4_ioctl+0x200d/0x57e0 fs/ext4/ioctl.c:1562
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8880692a7e00
 which belongs to the cache jbd2_transaction_s of size 280
The buggy address is located 208 bytes inside of
 280-byte region [ffff8880692a7e00, ffff8880692a7f18)
The buggy address belongs to the page:
page:ffffea0001a4a980 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x692a6
head:ffffea0001a4a980 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001a4c380 dead000000000002 ffff888017fe3a00
raw: 0000000000000000 0000000080150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 4065, ts 93350012176, free_ts 14405406818
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0xa72/0x2f50 mm/page_alloc.c:4165
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5389
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2271
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab mm/slub.c:1944 [inline]
 new_slab+0x28a/0x3b0 mm/slub.c:2004
 ___slab_alloc+0x87c/0xe90 mm/slub.c:3018
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3105
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x35c/0x3a0 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:705 [inline]
 start_this_handle+0x674/0x14a0 fs/jbd2/transaction.c:370
 jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:520
 __ext4_journal_start_sb+0x227/0x4a0 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5899
 __mark_inode_dirty+0x45b/0xfe0 fs/fs-writeback.c:2409
 generic_update_time fs/inode.c:1856 [inline]
 inode_update_time fs/inode.c:1869 [inline]
 touch_atime+0x63d/0x700 fs/inode.c:1941
 file_accessed include/linux/fs.h:2421 [inline]
 iterate_dir+0x465/0x700 fs/readdir.c:70
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13a/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0x374/0x870 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3404
 free_contig_range+0xa8/0xf0 mm/page_alloc.c:9335
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1018
 debug_vm_pgtable+0x298e/0x2a20 mm/debug_vm_pgtable.c:1332
 do_one_initcall+0x103/0x650 init/main.c:1300
 do_initcall_level init/main.c:1373 [inline]
 do_initcalls init/main.c:1389 [inline]
 do_basic_setup init/main.c:1408 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1613
 kernel_init+0x1a/0x1d0 init/main.c:1502
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff8880692a7d80: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880692a7e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880692a7e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff8880692a7f00: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880692a7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         3ca14294 jbd2: Remove CONFIG_JBD2_DEBUG to update t_ma..
git tree:       https://github.com/riteshharjani/linux.git jbd2-kill-t-handle-lock
console output: https://syzkaller.appspot.com/x/log.txt?x=16b914a4700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

