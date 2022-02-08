Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321744AD90E
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Feb 2022 14:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350368AbiBHNQQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Feb 2022 08:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbiBHMtV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Feb 2022 07:49:21 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E821CC03FEC0
        for <linux-ext4@vger.kernel.org>; Tue,  8 Feb 2022 04:49:19 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id y3-20020a920903000000b002be462612d7so2985566ilg.10
        for <linux-ext4@vger.kernel.org>; Tue, 08 Feb 2022 04:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LILgmaTVo/1JE6yj0VZe2DfLRyhwEAIW7H0s3PK9z1Q=;
        b=QQjvWgOmKxdq/EP2pZytggdk1O3K/5qSaaiepWYZ73ye6kTXSEG0Rrr9VZszd5n75D
         G2f68p4qw9QYKVBG6SPYiKS1uiEUnjAZV4Y2R079dw9wl6ozQokTUM8l1OCYjRo6OCoA
         N3aILBYcJoZn38APHyNQSKmJYKVPEesoaIhq1TFKbaYuM5fKDs8EN9XQ/ZNeGxXOYKJl
         o+1fsNPgVYbwkTWY3E7X+cU54mpqYgQbFQFFozTlBddFrMa0XvoMymBoMbHG3nsQckZE
         lpcqhKLytHwyqY9ENAP63IauEnkvYxAC9UKj9BlQ2FKTch7lt1j/sB1c2eeFvYVYjcTN
         Oz7w==
X-Gm-Message-State: AOAM533SUzhX+P7/dZiJXUxNtVbI5k1XsBRy6WC+/w3JE9N+U8ayegDU
        Yy8E/YRotSGBUG1A92zI/JKoi5CLYgc8o7jvrf6JKhDVwFmH
X-Google-Smtp-Source: ABdhPJyHF/bz0NHZtPucUyqh7rdiMkDtlJosaan0ozlyDjbEqEaeKKeoDj2aglsQ9tl9+lsk6iarSkBCiGJ6dPxko/fGvvpSid9p
MIME-Version: 1.0
X-Received: by 2002:a02:b80c:: with SMTP id o12mr2028114jam.279.1644324559306;
 Tue, 08 Feb 2022 04:49:19 -0800 (PST)
Date:   Tue, 08 Feb 2022 04:49:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040c94205d78125af@google.com>
Subject: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
From:   syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e55852700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e0a6a3dbf057cf
dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b03872700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0xda/0x2b00 kernel/locking/lockdep.c:4897
Read of size 8 at addr ffff88807440e978 by task syz-executor.0/4247

CPU: 1 PID: 4247 Comm: syz-executor.0 Not tainted 5.17.0-rc3-syzkaller-00020-g555f3d7be91a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_address_description+0x65/0x3a0 mm/kasan/report.c:255
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report+0x19a/0x1f0 mm/kasan/report.c:459
 __lock_acquire+0xda/0x2b00 kernel/locking/lockdep.c:4897
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5639
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 jbd2_journal_wait_updates+0x2cb/0x400 fs/jbd2/transaction.c:861
 jbd2_journal_lock_updates+0x33b/0x420 fs/jbd2/transaction.c:896
 ext4_ioctl_checkpoint fs/ext4/ioctl.c:1085 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1562 [inline]
 ext4_ioctl+0x34c7/0x65d0 fs/ext4/ioctl.c:1578
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe61dd9b059
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe61d510168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe61deadf60 RCX: 00007fe61dd9b059
RDX: 0000000020000000 RSI: 000000004004662b RDI: 0000000000000003
RBP: 00007fe61ddf508d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff8864c31f R14: 00007fe61d510300 R15: 0000000000022000
 </TASK>

Allocated by task 4239:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0xb2/0xe0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:260 [inline]
 slab_post_alloc_hook mm/slab.h:732 [inline]
 slab_alloc_node mm/slub.c:3230 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x1c9/0x310 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:705 [inline]
 start_this_handle+0x328/0x1630 fs/jbd2/transaction.c:375
 jbd2__journal_start+0x2ca/0x5b0 fs/jbd2/transaction.c:525
 __ext4_journal_start_sb+0x111/0x1e0 fs/ext4/ext4_jbd2.c:105
 __ext4_new_inode+0x1421/0x5740 fs/ext4/ialloc.c:1080
 ext4_create+0x280/0x550 fs/ext4/namei.c:2746
 lookup_open fs/namei.c:3330 [inline]
 open_last_lookups fs/namei.c:3400 [inline]
 path_openat+0x12ec/0x36a0 fs/namei.c:3606
 do_filp_open+0x277/0x4f0 fs/namei.c:3636
 do_sys_openat2+0x13b/0x500 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 4249:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0x126/0x180 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:236 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1754
 slab_free mm/slub.c:3509 [inline]
 kmem_cache_free+0xb6/0x1c0 mm/slub.c:3526
 __jbd2_journal_remove_checkpoint+0x529/0x5c0 fs/jbd2/checkpoint.c:735
 jbd2_log_do_checkpoint+0xe7b/0x10b0 fs/jbd2/checkpoint.c:354
 jbd2_journal_flush+0x298/0xd70 fs/jbd2/journal.c:2465
 ext4_ioctl_checkpoint fs/ext4/ioctl.c:1086 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1562 [inline]
 ext4_ioctl+0x3512/0x65d0 fs/ext4/ioctl.c:1578
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88807440e900
 which belongs to the cache jbd2_transaction_s of size 280
The buggy address is located 120 bytes inside of
 280-byte region [ffff88807440e900, ffff88807440ea18)
The buggy address belongs to the page:
page:ffffea0001d10380 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7440e
head:ffffea0001d10380 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888146724500
raw: 0000000000000000 0000000080150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 3153, ts 22972783543, free_ts 11342396906
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0x729/0x9e0 mm/page_alloc.c:4165
 __alloc_pages+0x255/0x580 mm/page_alloc.c:5389
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0xce/0x3f0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x3fe/0xc30 mm/slub.c:3018
 __slab_alloc mm/slub.c:3105 [inline]
 slab_alloc_node mm/slub.c:3196 [inline]
 slab_alloc mm/slub.c:3238 [inline]
 kmem_cache_alloc+0x276/0x310 mm/slub.c:3243
 kmem_cache_zalloc include/linux/slab.h:705 [inline]
 start_this_handle+0x328/0x1630 fs/jbd2/transaction.c:375
 jbd2__journal_start+0x2ca/0x5b0 fs/jbd2/transaction.c:525
 __ext4_journal_start_sb+0x111/0x1e0 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_dirty_inode+0x8a/0x100 fs/ext4/inode.c:5899
 __mark_inode_dirty+0xb6/0x8f0 fs/fs-writeback.c:2409
 generic_update_time fs/inode.c:1856 [inline]
 inode_update_time fs/inode.c:1869 [inline]
 touch_atime+0x3ef/0x650 fs/inode.c:1941
 file_accessed include/linux/fs.h:2421 [inline]
 filemap_read+0x25c2/0x27f0 mm/filemap.c:2744
 __kernel_read+0x5d0/0xaf0 fs/read_write.c:439
 prepare_binprm fs/exec.c:1657 [inline]
 search_binary_handler fs/exec.c:1711 [inline]
 exec_binprm fs/exec.c:1768 [inline]
 bprm_execve+0x808/0x1470 fs/exec.c:1837
 do_execveat_common+0x44c/0x590 fs/exec.c:1926
 do_execve fs/exec.c:1994 [inline]
 __do_sys_execve fs/exec.c:2070 [inline]
 __se_sys_execve fs/exec.c:2065 [inline]
 __x64_sys_execve+0x8e/0xa0 fs/exec.c:2065
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1352 [inline]
 free_pcp_prepare+0xd1c/0xe00 mm/page_alloc.c:1404
 free_unref_page_prepare mm/page_alloc.c:3325 [inline]
 free_unref_page+0x7d/0x580 mm/page_alloc.c:3404
 free_contig_range+0xa4/0x100 mm/page_alloc.c:9335
 destroy_args+0xfe/0x971 mm/debug_vm_pgtable.c:1018
 debug_vm_pgtable+0x449/0x4a1 mm/debug_vm_pgtable.c:1332
 do_one_initcall+0xbd/0x2b0 init/main.c:1300
 do_initcall_level+0x14a/0x1f5 init/main.c:1373
 do_initcalls+0x4b/0x8c init/main.c:1389
 kernel_init_freeable+0x43a/0x5c6 init/main.c:1613
 kernel_init+0x19/0x2b0 init/main.c:1502
 ret_from_fork+0x1f/0x30

Memory state around the buggy address:
 ffff88807440e800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807440e880: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807440e900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88807440e980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807440ea00: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
