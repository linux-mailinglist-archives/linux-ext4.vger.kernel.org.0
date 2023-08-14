Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0651677AF49
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Aug 2023 04:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjHNCA2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Aug 2023 22:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjHNCAJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Aug 2023 22:00:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B1E62;
        Sun, 13 Aug 2023 19:00:07 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so58668601fa.3;
        Sun, 13 Aug 2023 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691978406; x=1692583206;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gdiUVCfefmSrKOT2hhgkOV+r/E/LWk4B8Og12To/uVs=;
        b=oleXimuyVhd+6HLviHQBvFwe0R4NuV6MYjAVBFo6RyLxVKPC+3cheIPzUEA/a27XSL
         o05r1KieOaeJ3h5+MPFYq8l9vPz0EV5MFF6HghYeMH+Dk9QiyHMwDRdR65Oya3viLhYQ
         pc8imqZfaM0wciIqczRefX3OwUes+GjFzQtd0jRWAfRP00MkkpRRk5o+TWmTxyY2ml8U
         hkakAusze+y1vv5lguksMYVZ2owU+nCFa7HE0/N4v5GZlIf6+2M/1yy1hxHbf2fCvliX
         JoAzS3Kn7tFh2yCG4MQsz8DZfgQiwEpw8aWSj4LONFMXmQbpY8Zs1De6l19qZkBKrHrj
         xX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691978406; x=1692583206;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdiUVCfefmSrKOT2hhgkOV+r/E/LWk4B8Og12To/uVs=;
        b=la4BG6xaFmrwwNQ3tQLub04+OhFPFokTjM2+7U62k/XkRfyN6NwWGclB3foiKwE9Wq
         DQ2STsW4cHcz4Huk1FEoObMalKC/gqJLYVwlCWGF1oXwYYTPCYkDktYvscfaCD9QfaXi
         9v4buwfczLnlcBdVySbb211XHdt40t5QY7gyI6kVP9ozm8fhXjB25un4e+3VcUl6phvk
         gPH6uZVm4AFrOR8/Itm1LuGC3QsuLzXZGE74YM3R0EM+loQ/JUKPNerVRDcwO9PQ0Zbg
         3gvONwD3u+t0ZfL7tqn1rekx+2w8sbizYGel4jkSAa1u8UJMXI1swscpsGuX7FFWVZ9n
         8aTQ==
X-Gm-Message-State: AOJu0YyQJwUhm9X1zT+zsysElCkaJSzRjCdKTddKlwhB74iCDPsJx8F2
        jsRF6N+6JsXuwd1gkK6qGVeqg6NLTvoCJro+2INDEtGKIEvFthN3OdU=
X-Google-Smtp-Source: AGHT+IHPNg5sf5Z6YAtr9FwTgay23XBse7/jzyQcPA3ebF6dDS/GPxda16FYk74Gkyi7arz6vxCjfCat0bT5nKu2bZc=
X-Received: by 2002:a2e:7315:0:b0:2b9:ac48:d804 with SMTP id
 o21-20020a2e7315000000b002b9ac48d804mr5345263ljc.38.1691978405224; Sun, 13
 Aug 2023 19:00:05 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Mon, 14 Aug 2023 09:59:53 +0800
Message-ID: <CALcu4raD4h9coiyEBL4Bm0zjDwxC2CyPiTwsP3zFuhot6y9Beg@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in ext4_es_insert_extent
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

When using Healer to fuzz the Linux-6.5-rc5,  the following crash
was triggered.

HEAD commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f (tag: v6.5-rc5)
git tree: upstream

console output:
https://drive.google.com/file/d/1yKtvQct90Q7xY09N28iIwqAUSjq2KQPs/view?usp=drive_link
kernel config:https://drive.google.com/file/d/1hClF9kiDlmdnocuMCe1WZezKlhuOCq9A/view?usp=drive_link
C reproducer:https://drive.google.com/file/d/1yfIE42YP4YKIeJ3VxJTRMLZn3b83cs8A/view?usp=drive_link
Syzlang reproducer:https://drive.google.com/file/d/1afZPMtWGcZMvSR8AfleA-lDn_bj-aWm1/view?usp=drive_link


If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>


FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x132/0x150 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x49f/0x5b0 lib/fault-inject.c:153
 should_failslab+0x5/0x10 mm/slab_common.c:1471
 slab_pre_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x5e/0x390 mm/slub.c:3494
 __es_alloc_extent fs/ext4/extents_status.c:467 [inline]
 __es_alloc_extent fs/ext4/extents_status.c:464 [inline]
 __es_insert_extent+0xde9/0x1440 fs/ext4/extents_status.c:815
 __es_remove_extent+0x73b/0x16f0 fs/ext4/extents_status.c:1383
 ext4_es_insert_extent+0x2a1/0xcb0 fs/ext4/extents_status.c:878
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 vfs_fallocate+0x492/0xed0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xce/0x140 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
RSP: 002b:00007fbdfe383068 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 000000000000000f RSI: 0000000000000010 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fbdfe363000
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in ext4_es_insert_extent+0xc68/0xcb0
fs/ext4/extents_status.c:894
Read of size 4 at addr ffff888112ecc1a4 by task syz-executor/8438

CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xba/0xf0 mm/kasan/report.c:588
 ext4_es_insert_extent+0xc68/0xcb0 fs/ext4/extents_status.c:894
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 vfs_fallocate+0x492/0xed0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xce/0x140 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
RSP: 002b:00007fbdfe383068 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 000000000000000f RSI: 0000000000000010 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fbdfe363000
 </TASK>

Allocated by task 8438:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7b/0x80 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x16b/0x390 mm/slub.c:3494
 kmem_cache_zalloc include/linux/slab.h:693 [inline]
 __es_alloc_extent fs/ext4/extents_status.c:469 [inline]
 ext4_es_insert_extent+0x672/0xcb0 fs/ext4/extents_status.c:873
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 vfs_fallocate+0x492/0xed0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xce/0x140 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 8438:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x161/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook+0x89/0x1c0 mm/slub.c:1818
 slab_free mm/slub.c:3801 [inline]
 kmem_cache_free+0xec/0x490 mm/slub.c:3823
 ext4_es_try_to_merge_right fs/ext4/extents_status.c:593 [inline]
 __es_insert_extent+0x9f4/0x1440 fs/ext4/extents_status.c:802
 ext4_es_insert_extent+0x2ca/0xcb0 fs/ext4/extents_status.c:882
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 vfs_fallocate+0x492/0xed0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xce/0x140 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888112ecc188
 which belongs to the cache extent_status of size 40
The buggy address is located 28 bytes inside of
 freed 40-byte region [ffff888112ecc188, ffff888112ecc1b0)

The buggy address belongs to the physical page:
page:ffffea00044bb300 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x112ecc
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000200 ffff888014391500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080490049 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask
0x12830(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_RECLAIM
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0xfe0/0x2b80 mm/page_alloc.c:3221
 __alloc_pages+0x1c7/0x490 mm/page_alloc.c:4477
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2292
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0xbc6/0x15c0 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x369/0x390 mm/slub.c:3494
 __es_alloc_extent fs/ext4/extents_status.c:467 [inline]
 __es_alloc_extent fs/ext4/extents_status.c:464 [inline]
 __es_insert_extent+0xde9/0x1440 fs/ext4/extents_status.c:815
 ext4_es_cache_extent+0x2cb/0x480 fs/ext4/extents_status.c:937
 ext4_cache_extents+0x13e/0x2d0 fs/ext4/extents.c:541
 ext4_find_extent+0xac0/0xd20 fs/ext4/extents.c:925
 ext4_ext_map_blocks+0x241/0x5980 fs/ext4/extents.c:4101
 ext4_map_blocks+0xa27/0x16f0 fs/ext4/inode.c:548
 ext4_mpage_readpages+0xd7d/0x1970 fs/ext4/readpage.c:297
 ext4_readahead+0x102/0x140 fs/ext4/inode.c:3104
 read_pages+0x1a2/0xd40 mm/readahead.c:160
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888112ecc080: 00 00 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00
 ffff888112ecc100: 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00 00 fc
>ffff888112ecc180: fc fa fb fb fb fb fc fc 00 00 00 00 00 fc fc 00
                               ^
 ffff888112ecc200: 00 00 00 00 fc fc 00 00 00 00 00 fc fc 00 00 00
 ffff888112ecc280: 00 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00 00
==================================================================

 ext4_es_try_to_merge_right fs/ext4/extents_status.c:593 [inline]
 __es_insert_extent+0x9f4/0x1440 fs/ext4/extents_status.c:802
 ext4_es_insert_extent+0x2ca/0xcb0 fs/ext4/extents_status.c:882
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 vfs_fallocate+0x492/0xed0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xce/0x140 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888112ecc188
 which belongs to the cache extent_status of size 40
The buggy address is located 28 bytes inside of
 freed 40-byte region [ffff888112ecc188, ffff888112ecc1b0)

The buggy address belongs to the physical page:
page:ffffea00044bb300 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x112ecc
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 057ff00000000200 ffff888014391500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080490049 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask
0x12830(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_RECLAIM
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0xfe0/0x2b80 mm/page_alloc.c:3221
 __alloc_pages+0x1c7/0x490 mm/page_alloc.c:4477
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2292
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0xbc6/0x15c0 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x369/0x390 mm/slub.c:3494
 __es_alloc_extent fs/ext4/extents_status.c:467 [inline]
 __es_alloc_extent fs/ext4/extents_status.c:464 [inline]
 __es_insert_extent+0xde9/0x1440 fs/ext4/extents_status.c:815
 ext4_es_cache_extent+0x2cb/0x480 fs/ext4/extents_status.c:937
 ext4_cache_extents+0x13e/0x2d0 fs/ext4/extents.c:541
 ext4_find_extent+0xac0/0xd20 fs/ext4/extents.c:925
 ext4_ext_map_blocks+0x241/0x5980 fs/ext4/extents.c:4101
 ext4_map_blocks+0xa27/0x16f0 fs/ext4/inode.c:548
 ext4_mpage_readpages+0xd7d/0x1970 fs/ext4/readpage.c:297
 ext4_readahead+0x102/0x140 fs/ext4/inode.c:3104
 read_pages+0x1a2/0xd40 mm/readahead.c:160
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888112ecc080: 00 00 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00
 ffff888112ecc100: 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00 00 fc
>ffff888112ecc180: fc fa fb fb fb fb fc fc 00 00 00 00 00 fc fc 00
                               ^
 ffff888112ecc200: 00 00 00 00 fc fc 00 00 00 00 00 fc fc 00 00 00
 ffff888112ecc280: 00 00 fc fc 00 00 00 00 00 fc fc 00 00 00 00 00
==================================================================
Kernel panic - not syncing: KASAN: panic_on_warn set ...
CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 panic+0x67e/0x730 kernel/panic.c:340
 check_panic_on_warn+0xad/0xb0 kernel/panic.c:236
 end_report+0x108/0x150 mm/kasan/report.c:225
 kasan_report+0xca/0xf0 mm/kasan/report.c:590
 ext4_es_insert_extent+0xc68/0xcb0 fs/ext4/extents_status.c:894
 ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
 ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
 ext4_zero_range fs/ext4/extents.c:4622 [inline]
 ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
 vfs_fallocate+0x492/0xed0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xce/0x140 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08
RSP: 002b:00007fbdfe383068 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 000000000000000f RSI: 0000000000000010 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000008000 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007fbdfe363000
 </TASK>
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
