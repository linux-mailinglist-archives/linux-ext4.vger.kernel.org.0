Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076D865A305
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Dec 2022 08:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLaHIj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Dec 2022 02:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLaHIi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Dec 2022 02:08:38 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E92F13D29
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 23:08:36 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id x8-20020a056e02194800b0030c1ca49d7dso5391989ilu.8
        for <linux-ext4@vger.kernel.org>; Fri, 30 Dec 2022 23:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pGYmnK5Em3omduAmXAUIIsSu268FxWvkMKl6w5XXOc=;
        b=0Lf0m6ZsCUt87CquXncwinPHQspc0Mq8qMAaTED+nsQRiTd5n4gxD6Lu3XCaMA8SEg
         zUDVywaKEe428X9+zICx+qFUT7W/wQw4p1rQREtJzR41CbR0GlxR+fiiM6ixDKi61blf
         asQb0aRI/64RFbkRZ6tA1mgSzpRJuo1O0UOv+pP2m8A/8IdXy9mpaLrFtuwDwrDpqaYz
         qxW6tgiBxsOTafN9y97WzZc9IVuS2FVtuUcHLvmm/k6g1jFlr1jxdWQuGq71z0goOBSM
         eFw+KGT8PwVQUqVUrzp+coSzcAUUwsJHoV23A0LkHGyYQh0NxVpOTEobu2XJGHK65opj
         OoPw==
X-Gm-Message-State: AFqh2kpFy/SKi6qumDfa6CXFrM2Y1qBgUnbDPi/IXEeYd9K6LkquqEAE
        66zt368hYPybTO2YLIb1+wrR6tvcWBoWzWUphfhBJUvK69/K
X-Google-Smtp-Source: AMrXdXuZ+of9Gf5Vq6qlxEV8vcJv5Jixun0gVyBHkfiUkxE8DjEcGFm9waVwnkCd8+i6v0zzI9ejCDmbTlU94iALKjDt9Ix2VV39
MIME-Version: 1.0
X-Received: by 2002:a92:ad0e:0:b0:30c:2e5a:3b74 with SMTP id
 w14-20020a92ad0e000000b0030c2e5a3b74mr504255ilh.286.1672470515614; Fri, 30
 Dec 2022 23:08:35 -0800 (PST)
Date:   Fri, 30 Dec 2022 23:08:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb09de05f11a626d@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent (2)
From:   syzbot <syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16ad35e4480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=bf4bb7731ef73b83a3b4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109a70f4480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1200b8f4480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e23e9197fa8a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
Read of size 4 at addr ffff888073644750 by task syz-executor420/5067

CPU: 0 PID: 5067 Comm: syz-executor420 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
 ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
 ext4_clu_mapped+0x117/0x970 fs/ext4/extents.c:5809
 ext4_insert_delayed_block fs/ext4/inode.c:1696 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
 ext4_da_get_block_prep+0x9e8/0x13c0 fs/ext4/inode.c:1870
 ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1098
 ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3082
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
 ext4_file_write_iter+0x1d0/0x18f0
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4b7a9737b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc5cac3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7a9737b9
RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f4b7a933050 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000079f R11: 0000000000000246 R12: 00007f4b7a9330e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001cd9100 refcount:0 mapcount:0 mapping:0000000000000000 index:0x2 pfn:0x73644
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001cd9148 ffffea0001cd90c8 0000000000000000
raw: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x8(__GFP_MOVABLE), pid 1, tgid 1 (swapper/0), ts 12379768059, free_ts 13547634018
 split_map_pages+0x25b/0x540 mm/compaction.c:97
 isolate_freepages_range+0x4ac/0x510 mm/compaction.c:735
 alloc_contig_range+0x6a9/0x980 mm/page_alloc.c:9363
 __alloc_contig_pages mm/page_alloc.c:9386 [inline]
 alloc_contig_pages+0x3c8/0x4e0 mm/page_alloc.c:9463
 debug_vm_pgtable_alloc_huge_page+0xcd/0x120 mm/debug_vm_pgtable.c:1065
 init_args+0xa3a/0xdc0 mm/debug_vm_pgtable.c:1188
 debug_vm_pgtable+0x9a/0x4a0 mm/debug_vm_pgtable.c:1226
 do_one_initcall+0x1d1/0x410 init/main.c:1306
 do_initcall_level+0x168/0x220 init/main.c:1379
 do_initcalls+0x43/0x90 init/main.c:1395
 kernel_init_freeable+0x428/0x5e0 init/main.c:1634
 kernel_init+0x19/0x2b0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x19/0x4c0 mm/page_alloc.c:3464
 free_contig_range+0xa3/0x160 mm/page_alloc.c:9485
 destroy_args+0xfe/0x940 mm/debug_vm_pgtable.c:998
 debug_vm_pgtable+0x43d/0x4a0 mm/debug_vm_pgtable.c:1318
 do_one_initcall+0x1d1/0x410 init/main.c:1306
 do_initcall_level+0x168/0x220 init/main.c:1379
 do_initcalls+0x43/0x90 init/main.c:1395
 kernel_init_freeable+0x428/0x5e0 init/main.c:1634
 kernel_init+0x19/0x2b0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888073644600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888073644680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888073644700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff888073644780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888073644800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
