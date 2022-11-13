Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A20627317
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Nov 2022 23:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiKMWzt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Nov 2022 17:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKMWzt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Nov 2022 17:55:49 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969910055
        for <linux-ext4@vger.kernel.org>; Sun, 13 Nov 2022 14:55:47 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso8254616ilh.18
        for <linux-ext4@vger.kernel.org>; Sun, 13 Nov 2022 14:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3b6FkKZW+23Of3EsqNlUBJgBpLPOPTcyCvgsQ8NmMQ=;
        b=Oi1Vpqv2I4y7zc0nrw56wjfjOVMn52dJ0oixzVov0o6mWhMXg7IGUUuh+Jl8j1WeOU
         9D1cswzBrWJh/KRwKSy2uGMSbQ6fXy+1OZxayIfUxBYZkQuiS3l+r4Ryo8LKHlg6/DTy
         jxCK+mkff/bTg5u5uiuTdZ+mytInRGoL8z24tGmBpfwp9Rs+2WzNenJHbuSk5gSQgchL
         pPrffAcmK8coSoFxuavcDoY02mdWoKt4B1anb/NkUmjoWIo2V0nCYktK/cV5fIyhv8M5
         f46aw7Job+xJlRnQdJneH7xKddQGmljOcMsF3z0dHN25AaLvFUOcYs/k6BAMdLGeUtMP
         svuQ==
X-Gm-Message-State: ANoB5pn84h5zMkHtTgkqKnUOnuPJSddmuV2rDikypeNDfPTzJ9wJgB+l
        0VJi2nhq3qdXlL/xXsXZvdx6N9S4/Vk2IVsfyZ/QtXAnb7CQ
X-Google-Smtp-Source: AA0mqf7ztgYvbwLdMex5Xa2yksdx/z+Ma6DJOwt3xQpEEdvKJaFshcj2MBCy3PBTbuXGP/oyaYvOoxqEs7OjWMW2CX/GEvcrelNH
MIME-Version: 1.0
X-Received: by 2002:a02:ca09:0:b0:375:b13e:ec83 with SMTP id
 i9-20020a02ca09000000b00375b13eec83mr4667239jak.232.1668380147266; Sun, 13
 Nov 2022 14:55:47 -0800 (PST)
Date:   Sun, 13 Nov 2022 14:55:47 -0800
In-Reply-To: <0000000000006a74dd05e9931449@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000073a4a05ed620676@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ext4_enable_quotas
From:   syzbot <syzbot+ea70429cd5cf47ba8937@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    af7a05689189 Merge tag 'mips-fixes_6.1_1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175bb059880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbe7c32024f5b72
dashboard link: https://syzkaller.appspot.com/bug?extid=ea70429cd5cf47ba8937
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10930249880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11af96ae880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/78620ee9e532/disk-af7a0568.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2155a76a6304/vmlinux-af7a0568.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d4c407e5692/bzImage-af7a0568.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/6bdee54735f1/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7fefac3c26b8/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea70429cd5cf47ba8937@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 264192
==================================================================
BUG: KASAN: slab-out-of-bounds in lockdep_set_quota_inode fs/ext4/super.c:6803 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_quota_enable fs/ext4/super.c:6913 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_enable_quotas+0x577/0xcf0 fs/ext4/super.c:6940
Read of size 8 at addr ffff88806e14ffd8 by task syz-executor602/14324

CPU: 0 PID: 14324 Comm: syz-executor602 Not tainted 6.1.0-rc4-syzkaller-00372-gaf7a05689189 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 lockdep_set_quota_inode fs/ext4/super.c:6803 [inline]
 ext4_quota_enable fs/ext4/super.c:6913 [inline]
 ext4_enable_quotas+0x577/0xcf0 fs/ext4/super.c:6940
 __ext4_fill_super fs/ext4/super.c:5500 [inline]
 ext4_fill_super+0x7ee4/0x8610 fs/ext4/super.c:5643
 get_tree_bdev+0x400/0x620 fs/super.c:1324
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4d005b102a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4d0055a138 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f4d005b102a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f4d0055a180
RBP: 0000000000000004 R08: 00007f4d0055a1c0 R09: 00007f4d0055a1f0
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f4d0055a1c0
R13: 0000000000000029 R14: 00007f4d0055a180 R15: 00000000200005d8
 </TASK>

Allocated by task 13530:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x180/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1366
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bb0 fs/f2fs/inode.c:505
 f2fs_fill_super+0x5382/0x6c40 fs/f2fs/super.c:4341
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 call_rcu+0x163/0x9c0 kernel/rcu/tree.c:2798
 f2fs_fill_super+0x5669/0x6c40 fs/f2fs/super.c:4516
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 call_rcu+0x163/0x9c0 kernel/rcu/tree.c:2798
 f2fs_fill_super+0x5669/0x6c40 fs/f2fs/super.c:4516
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88806e14f360
 which belongs to the cache f2fs_inode_cache of size 2144
The buggy address is located 1048 bytes to the right of
 2144-byte region [ffff88806e14f360, ffff88806e14fbc0)

The buggy address belongs to the physical page:
page:ffffea0001b85200 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88806e14ac60 pfn:0x6e148
head:ffffea0001b85200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001b89a08 ffffea0001bdbe08 ffff888146d52640
raw: ffff88806e14ac60 00000000000e000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 11995, tgid 11991 (syz-executor602), ts 992233933290, free_ts 11204603085
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4288
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5555
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x233/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1366
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bb0 fs/f2fs/inode.c:505
 f2fs_fill_super+0x52c4/0x6c40 fs/f2fs/super.c:4333
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 free_contig_range+0xa3/0x160 mm/page_alloc.c:9493
 destroy_args+0xfe/0x935 mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x44d/0x4a6 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x1c9/0x400 init/main.c:1303
 do_initcall_level+0x168/0x218 init/main.c:1376
 do_initcalls+0x4b/0x8c init/main.c:1392
 kernel_init_freeable+0x428/0x5d5 init/main.c:1631
 kernel_init+0x19/0x2b0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff88806e14fe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806e14ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88806e14ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                    ^
 ffff88806e150000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806e150080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

