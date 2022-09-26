Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0D5EA797
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiIZNr2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbiIZNqw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 09:46:52 -0400
Received: from mail-qv1-xf46.google.com (mail-qv1-xf46.google.com [IPv6:2607:f8b0:4864:20::f46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C301F0CE5
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 05:04:04 -0700 (PDT)
Received: by mail-qv1-xf46.google.com with SMTP id f9-20020ad442c9000000b004ac7f4fde18so3673096qvr.14
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 05:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=tFzVL/nxQUvW5WQJG6L+XDDgtG08LJ+8jTsO5J7895w=;
        b=kWQQi7YmBJIscGDHA2CInk+7ED+dU8QUdbXzOdpVoZZht3+rRiT2OQ2aaeshGJy3tn
         x1LdQq7eV1xzsAfuOzwRFjGb151vVrr3TnqFeNIoXxhpSDLK8aqL2/dYW2SuFE9QONJ2
         nPAM3/i/cYgrZRW8H7Wkk5vhc+kCU2P26bAi3mA57Ah7YBkp0K5tBb8FrjtSHleF+Iqs
         IaqRkO1FosoAKXeqX/t8hX/Yfc40letkTTxaBc++uWt10SZNXKulttdF7jdFOjTtFWQi
         CpHfMfLORsRTnYQ7Q8cuA6WfyzHwe8H/NUtntPdLeE8YZX5xXqzu2368zGbVH1IZMfh5
         Qf8w==
X-Gm-Message-State: ACrzQf3Nr+bidLpwIieolCH0E2iCftMcNgjn6bohEfScAjnkeWCE2wJm
        dbDVHtMQGeagCoV+DLxrE4KHkl8rndOaYvIevo6CNJI203q9
X-Google-Smtp-Source: AMsMyM6c6r1O1VyilSlQ6wAnfHpRnHXhIAlMHqfn/QPN2tGmj1GVVl6p0TRHP1gNB42zuSAP3Y2eChWrAvARoqw+qLz2hC5SPGu9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1929:b0:35a:bb76:b0ac with SMTP id
 p41-20020a056638192900b0035abb76b0acmr11416370jal.153.1664192795537; Mon, 26
 Sep 2022 04:46:35 -0700 (PDT)
Date:   Mon, 26 Sep 2022 04:46:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a74dd05e9931449@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in ext4_enable_quotas
From:   syzbot <syzbot+ea70429cd5cf47ba8937@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bf682942cd26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e7f318880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=ea70429cd5cf47ba8937
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a27f1315833f/disk-bf682942.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10067330020a/vmlinux-bf682942.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea70429cd5cf47ba8937@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: slab-out-of-bounds in lockdep_set_quota_inode fs/ext4/super.c:6677 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_quota_enable fs/ext4/super.c:6787 [inline]
BUG: KASAN: slab-out-of-bounds in ext4_enable_quotas+0x577/0xcf0 fs/ext4/super.c:6814
Read of size 8 at addr ffff8880512c1a60 by task syz-executor.0/14097

CPU: 0 PID: 14097 Comm: syz-executor.0 Not tainted 6.0.0-rc6-syzkaller-00210-gbf682942cd26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 lockdep_set_quota_inode fs/ext4/super.c:6677 [inline]
 ext4_quota_enable fs/ext4/super.c:6787 [inline]
 ext4_enable_quotas+0x577/0xcf0 fs/ext4/super.c:6814
 __ext4_fill_super+0x9305/0x9a10 fs/ext4/super.c:5363
 ext4_fill_super+0x313/0x700 fs/ext4/super.c:5517
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f473308bb9a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4731ffdf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f473308bb9a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f4731ffdfe0
RBP: 00007f4731ffe020 R08: 00007f4731ffe020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f4731ffdfe0 R15: 0000000020000080
 </TASK>

Allocated by task 8066:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0xa3/0xd0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x175/0x2d0 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1361
 alloc_inode fs/inode.c:260 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1287
 f2fs_iget+0x52/0x4930 fs/f2fs/inode.c:489
 f2fs_fill_super+0x4fd6/0x6c90 fs/f2fs/super.c:4265
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0x970 kernel/rcu/tree.c:2793
 f2fs_fill_super+0x537b/0x6c90 fs/f2fs/super.c:4448
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880512c11b0
 which belongs to the cache f2fs_inode_cache of size 2136
The buggy address is located 88 bytes to the right of
 2136-byte region [ffff8880512c11b0, ffff8880512c1a08)

The buggy address belongs to the physical page:
page:ffffea000144b000 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880512c2c38 pfn:0x512c0
head:ffffea000144b000 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff88807cbb6e01
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff88801bf883c0
raw: ffff8880512c2c38 00000000800e0009 00000001ffffffff ffff88807cbb6e01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 7508, tgid 7507 (syz-executor.5), ts 142200130740, free_ts 141953283665
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5515
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x225/0x2d0 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1361
 alloc_inode fs/inode.c:260 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1287
 f2fs_iget+0x52/0x4930 fs/f2fs/inode.c:489
 f2fs_fill_super+0x38c1/0x6c90 fs/f2fs/super.c:4157
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 kmem_cache_alloc_node+0x1cc/0x350 mm/slub.c:3298
 __alloc_skb+0xcf/0x2b0 net/core/skbuff.c:422
 alloc_skb include/linux/skbuff.h:1257 [inline]
 alloc_skb_with_frags+0xaf/0x810 net/core/skbuff.c:6021
 sock_alloc_send_pskb+0x938/0xa70 net/core/sock.c:2665
 unix_dgram_sendmsg+0x5ab/0x2010 net/unix/af_unix.c:1912
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 sock_write_iter+0x3d4/0x540 net/socket.c:1108
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:578
 ksys_write+0x177/0x2a0 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880512c1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880512c1980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880512c1a00: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff8880512c1a80: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880512c1b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
