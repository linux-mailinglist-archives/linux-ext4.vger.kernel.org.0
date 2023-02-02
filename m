Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0C687613
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Feb 2023 07:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBBGym (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Feb 2023 01:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBBGym (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Feb 2023 01:54:42 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D78C21A38
        for <linux-ext4@vger.kernel.org>; Wed,  1 Feb 2023 22:54:40 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id k5-20020a6bf705000000b0070483a64c60so656367iog.18
        for <linux-ext4@vger.kernel.org>; Wed, 01 Feb 2023 22:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvD4QX200IQ/8CpFIuj36Lb+PGycTQWCnxiX7DHCu40=;
        b=1x/H2LNih/9wddZeo1gEhlFb06VXnNuqYGd2TYT0cf4cS/QA/nosFQLrrE8xc+JbFR
         gqWpywQ72JmNEFNTKE4EwJ6/8051/qna4KaIDUBba2tD6w4D0xAbwoBxB7rZ6+gSAtjP
         QtlyOwblKbdN23ZYnlv166MHrzLxeSuGYgE01pIdoMtiAqJcmae3JjgD+h7Qd/3ZnvT8
         axAoJkPUAZMm7eeE4fmQFm72sSEhmp0qOEQQ28H0HnLofcQuIl/nVvAMabhCsbCkJRLd
         HpeZWK3z5MuC5UV4uac3Hjk28+tdhhqPfJHPum1q1jkW1QAsKsqTKn0rWW+ga5UTyZMT
         OK+g==
X-Gm-Message-State: AO0yUKWTxvmaGFg7ed7t5QfN8549LFm0JTFZwKFTgpOJSQTg35Bgs0g3
        CX31waehJh1QePbs+F367QN/IXUVczcekR8jAkrmw5/8aoFn
X-Google-Smtp-Source: AK7set/D78PjDyQQL5mar05FmQ5njhY1MEqbXYFkT6oHv86bq3lzOyhMkhq2IHlFTIaVtfFJlJ/0R0Go4pUMvc+8ojrQhD9TMBxl
MIME-Version: 1.0
X-Received: by 2002:a5e:a702:0:b0:71c:29d4:ff9c with SMTP id
 b2-20020a5ea702000000b0071c29d4ff9cmr1246994iod.22.1675320879798; Wed, 01 Feb
 2023 22:54:39 -0800 (PST)
Date:   Wed, 01 Feb 2023 22:54:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ece18705f3b20934@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_group_desc_csum
From:   syzbot <syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com>
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

HEAD commit:    c96618275234 Fix up more non-executable files marked execu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14287dc1480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d5c2ee6c2bd4b8
dashboard link: https://syzkaller.appspot.com/bug?extid=8785e41224a3afd04321
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a829cd39e940/disk-c9661827.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abbc86f52a98/vmlinux-c9661827.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab0970dd4f84/bzImage-c9661827.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in crc16+0x206/0x280 lib/crc16.c:58
Read of size 1 at addr ffff888075f5c0a8 by task syz-executor.2/15586

CPU: 1 PID: 15586 Comm: syz-executor.2 Not tainted 6.2.0-rc5-syzkaller-00205-gc96618275234 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 crc16+0x206/0x280 lib/crc16.c:58
 ext4_group_desc_csum+0x81b/0xb20 fs/ext4/super.c:3187
 ext4_group_desc_csum_set+0x195/0x230 fs/ext4/super.c:3210
 ext4_mb_clear_bb fs/ext4/mballoc.c:6027 [inline]
 ext4_free_blocks+0x191a/0x2810 fs/ext4/mballoc.c:6173
 ext4_remove_blocks fs/ext4/extents.c:2527 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2710 [inline]
 ext4_ext_remove_space+0x24ef/0x46a0 fs/ext4/extents.c:2958
 ext4_ext_truncate+0x177/0x220 fs/ext4/extents.c:4416
 ext4_truncate+0xa6a/0xea0 fs/ext4/inode.c:4342
 ext4_setattr+0x10c8/0x1930 fs/ext4/inode.c:5622
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x272b/0x2dd0 fs/namei.c:3714
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f72f8a8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f72f97e3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f72f8bac050 RCX: 00007f72f8a8c0c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000280
RBP: 00007f72f8ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd165348bf R14: 00007f72f97e3300 R15: 0000000000022000
 </TASK>

Allocated by task 5119:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1b3/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 __kernfs_new_node+0xdb/0x730 fs/kernfs/dir.c:614
 kernfs_new_node+0x95/0x160 fs/kernfs/dir.c:676
 __kernfs_create_file+0x45/0x2e0 fs/kernfs/file.c:1047
 sysfs_add_file_mode_ns+0x21d/0x330 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x508/0xde0 fs/sysfs/group.c:148
 internal_create_groups fs/sysfs/group.c:188 [inline]
 sysfs_create_groups+0x5d/0x130 fs/sysfs/group.c:214
 create_dir lib/kobject.c:68 [inline]
 kobject_add_internal+0x723/0xd10 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x104/0x160 lib/kobject.c:441
 netdev_queue_add_kobject net/core/net-sysfs.c:1666 [inline]
 netdev_queue_update_kobjects+0x20c/0x4c0 net/core/net-sysfs.c:1718
 register_queue_kobjects net/core/net-sysfs.c:1779 [inline]
 netdev_register_kobject+0x263/0x310 net/core/net-sysfs.c:2019
 register_netdevice+0x1043/0x17a0 net/core/dev.c:10045
 bond_newlink+0x3f/0x90 drivers/net/bonding/bond_netlink.c:560
 rtnl_newlink_create net/core/rtnetlink.c:3407 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3624 [inline]
 rtnl_newlink+0x14b3/0x2020 net/core/rtnetlink.c:3637
 rtnetlink_rcv_msg+0x822/0xf10 net/core/rtnetlink.c:6141
 netlink_rcv_skb+0x1f0/0x470 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x7e7/0x9c0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x9b3/0xcd0 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 __sys_sendto+0x46e/0x5f0 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xda/0xf0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888075f5c000
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 0 bytes to the right of
 168-byte region [ffff888075f5c000, ffff888075f5c0a8)

The buggy address belongs to the physical page:
page:ffffea0001d7d700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75f5c
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8880129ebc80 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5119, tgid 5119 (syz-executor.3), ts 232703738304, free_ts 232703424583
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0xbd/0x190 mm/slub.c:1851
 allocate_slab+0x5e/0x3c0 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x268/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 __kernfs_new_node+0xdb/0x730 fs/kernfs/dir.c:614
 kernfs_new_node+0x95/0x160 fs/kernfs/dir.c:676
 __kernfs_create_file+0x45/0x2e0 fs/kernfs/file.c:1047
 sysfs_add_file_mode_ns+0x21d/0x330 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x508/0xde0 fs/sysfs/group.c:148
 internal_create_groups fs/sysfs/group.c:188 [inline]
 sysfs_create_groups+0x5d/0x130 fs/sysfs/group.c:214
 create_dir lib/kobject.c:68 [inline]
 kobject_add_internal+0x723/0xd10 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x104/0x160 lib/kobject.c:441
 netdev_queue_add_kobject net/core/net-sysfs.c:1666 [inline]
 netdev_queue_update_kobjects+0x20c/0x4c0 net/core/net-sysfs.c:1718
 register_queue_kobjects net/core/net-sysfs.c:1779 [inline]
 netdev_register_kobject+0x263/0x310 net/core/net-sysfs.c:2019
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x19/0x4c0 mm/page_alloc.c:3464
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x156/0x170 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x1e0/0x340 mm/slub.c:3491
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 ref_tracker_alloc+0x128/0x440 lib/ref_tracker.c:85
 __netdev_tracker_alloc include/linux/netdevice.h:4020 [inline]
 netdev_hold include/linux/netdevice.h:4049 [inline]
 rx_queue_add_kobject net/core/net-sysfs.c:1060 [inline]
 net_rx_queue_update_kobjects+0x15d/0x4c0 net/core/net-sysfs.c:1114
 register_queue_kobjects net/core/net-sysfs.c:1774 [inline]
 netdev_register_kobject+0x222/0x310 net/core/net-sysfs.c:2019
 register_netdevice+0x1043/0x17a0 net/core/dev.c:10045
 bond_newlink+0x3f/0x90 drivers/net/bonding/bond_netlink.c:560
 rtnl_newlink_create net/core/rtnetlink.c:3407 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3624 [inline]
 rtnl_newlink+0x14b3/0x2020 net/core/rtnetlink.c:3637
 rtnetlink_rcv_msg+0x822/0xf10 net/core/rtnetlink.c:6141
 netlink_rcv_skb+0x1f0/0x470 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x7e7/0x9c0 net/netlink/af_netlink.c:1365

Memory state around the buggy address:
 ffff888075f5bf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888075f5c000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888075f5c080: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
                                  ^
 ffff888075f5c100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888075f5c180: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
