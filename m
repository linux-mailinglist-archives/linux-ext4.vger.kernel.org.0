Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC8F536BBB
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiE1IvY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 04:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiE1IvX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 04:51:23 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B3820E
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 01:51:19 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a12-20020a92c54c000000b002d2f39932e8so3481730ilj.19
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 01:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J/Bvj0UtmLqlRvJkLZqTVi4pXgT9dcuuCMl+vXAnuic=;
        b=gXyCgpqbSc8tKxrTZQMt31jgoLwlDtl1BtJdDpozLNCq+jUt9+/3nr9FtXHgbHFvZm
         lQdJGQSKUBlOCp0X9OZegbDwbN+0F51ZHSuBteOQTUvBdgCn9fHfKSyzP4VjpnftfQP8
         c81DCuefnQ0HADo3OMSFsOb7958FffpiOidivbHSpR6ji0Yjw3Zo6JeOCUU9enFi8LzQ
         +aFTNjc1c5Msxrxa9FcbSABGSCBmYrCo7cZv9zI6K70M7oKTJLfpw2urHFpPfI6OoLwe
         f2XMk1HZg/j15MGXjVrfnXfI8YuzM+jxPBex169V/VMFrDjM29j7GSPNMR2auWrcC7JZ
         bQYw==
X-Gm-Message-State: AOAM532YefSr6C/tmkBl/sOJxSeHrX2tRYPEQBgCpk3DIaPj5rkJ7HQ+
        q4Pjdtxcizu1PFffF7B/kdUDVxUHAvAYWpcanXBesQLC2Kb2
X-Google-Smtp-Source: ABdhPJyqQO0DFztvD+Xp8W8VpZqE0oT3XdfAKEC85MMQIeUxEDusQ6f6XCGD7+MLxrZjSbJ9kqWKXhIQWEwtG25ApAfa1zcYYTbI
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c8:b0:664:f10e:5c84 with SMTP id
 b8-20020a05660214c800b00664f10e5c84mr12739965iow.115.1653727877966; Sat, 28
 May 2022 01:51:17 -0700 (PDT)
Date:   Sat, 28 May 2022 01:51:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8b00505e00e8610@google.com>
Subject: [syzbot] KASAN: use-after-free Read in ext4_xattr_set_entry (5)
From:   syzbot <syzbot+43ddf9603437b6bad4e0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
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

HEAD commit:    0966d385830d riscv: Fix auipc+jalr relocation range checks
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=16e9aa39f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6295d67591064921
dashboard link: https://syzkaller.appspot.com/bug?extid=43ddf9603437b6bad4e0
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43ddf9603437b6bad4e0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x212/0x2034 fs/ext4/xattr.c:1593
Read of size 4 at addr ffffaf800f477ffe by task syz-executor.1/5063

CPU: 1 PID: 5063 Comm: syz-executor.1 Not tainted 5.17.0-rc1-syzkaller-00002-g0966d385830d #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff8000a228>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:113
[<ffffffff831668cc>] show_stack+0x34/0x40 arch/riscv/kernel/stacktrace.c:119
[<ffffffff831756ba>] __dump_stack lib/dump_stack.c:88 [inline]
[<ffffffff831756ba>] dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:106
[<ffffffff8047479e>] print_address_description.constprop.0+0x2a/0x330 mm/kasan/report.c:255
[<ffffffff80474d4c>] __kasan_report mm/kasan/report.c:442 [inline]
[<ffffffff80474d4c>] kasan_report+0x184/0x1e0 mm/kasan/report.c:459
[<ffffffff804759f4>] check_region_inline mm/kasan/generic.c:183 [inline]
[<ffffffff804759f4>] __asan_load4+0x6e/0x96 mm/kasan/generic.c:255
[<ffffffff807c17b4>] ext4_xattr_set_entry+0x212/0x2034 fs/ext4/xattr.c:1593
[<ffffffff807c6c80>] ext4_xattr_ibody_set+0x5c/0x158 fs/ext4/xattr.c:2210
[<ffffffff807c73da>] ext4_xattr_set_handle+0x65e/0xea0 fs/ext4/xattr.c:2367
[<ffffffff807c7e6e>] ext4_xattr_set+0x12e/0x2b4 fs/ext4/xattr.c:2480
[<ffffffff807c9abc>] ext4_xattr_trusted_set+0x34/0x46 fs/ext4/xattr_trusted.c:38
[<ffffffff8052af96>] __vfs_setxattr+0x106/0x172 fs/xattr.c:180
[<ffffffff8052cd3e>] __vfs_setxattr_noperm+0xca/0x378 fs/xattr.c:214
[<ffffffff8052d156>] __vfs_setxattr_locked+0x16a/0x186 fs/xattr.c:275
[<ffffffff8052d2a8>] vfs_setxattr+0x136/0x296 fs/xattr.c:301
[<ffffffff8052d61a>] setxattr+0x212/0x29a fs/xattr.c:575
[<ffffffff8052d844>] path_setxattr+0x1a2/0x1bc fs/xattr.c:595
[<ffffffff8052daca>] __do_sys_setxattr fs/xattr.c:611 [inline]
[<ffffffff8052daca>] sys_setxattr+0x36/0x48 fs/xattr.c:607
[<ffffffff80005716>] ret_from_syscall+0x0/0x2

The buggy address belongs to the page:
page:ffffaf807aa95178 refcount:2 mapcount:0 mapping:ffffaf800ab50810 index:0xb8 pfn:0x8f677
memcg:ffffaf80073e0000
aops:def_blk_aops ino:fd00000
flags: 0x880000203a(referenced|dirty|lru|active|private|section=17|node=0|zone=0)
raw: 000000880000203a ffffaf807aa95138 ffffaf807aaa3e08 ffffaf800ab50810
raw: 00000000000000b8 ffffaf800dbbe910 00000002ffffffff ffffaf80073e0000
raw: 00000000000007ff
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x148c40(GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL), pid 1, ts 83303672800, free_ts 0
 __set_page_owner+0x48/0x136 mm/page_owner.c:183
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0xd0/0x10a mm/page_alloc.c:2427
 prep_new_page mm/page_alloc.c:2434 [inline]
 get_page_from_freelist+0x8da/0x12d8 mm/page_alloc.c:4165
 __alloc_pages+0x150/0x3b6 mm/page_alloc.c:5389
 alloc_pages+0x132/0x2a6 mm/mempolicy.c:2271
 folio_alloc+0x24/0x30 mm/mempolicy.c:2281
 filemap_alloc_folio mm/filemap.c:987 [inline]
 __filemap_get_folio+0x63c/0xd58 mm/filemap.c:1990
 pagecache_get_page+0x2e/0x230 mm/folio-compat.c:125
 find_or_create_page include/linux/pagemap.h:488 [inline]
 grow_dev_page fs/buffer.c:949 [inline]
 grow_buffers fs/buffer.c:1014 [inline]
 __getblk_slow+0x1f2/0x738 fs/buffer.c:1041
 __getblk_gfp+0x74/0x78 fs/buffer.c:1334
 sb_getblk_gfp include/linux/buffer_head.h:334 [inline]
 ext4_sb_breadahead_unmovable+0x46/0xa8 fs/ext4/super.c:264
 __ext4_get_inode_loc+0x9d6/0xc08 fs/ext4/inode.c:4488
 __ext4_get_inode_loc_noinmem+0xb2/0x138 fs/ext4/inode.c:4518
 __ext4_iget+0x348/0x20f8 fs/ext4/inode.c:4711
 ext4_lookup fs/ext4/namei.c:1785 [inline]
 ext4_lookup+0x28a/0x4ea fs/ext4/namei.c:1760
 lookup_open.isra.0+0x6a6/0xd4a fs/namei.c:3308
page_owner free stack trace missing

Memory state around the buggy address:
 ffffaf800f477f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffaf800f477f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffaf800f478000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffffaf800f478080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffffaf800f478100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
EXT4-fs error (device vda): ext4_xattr_set_entry:1596: inode #640: comm syz-executor.1: corrupted xattr entries


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
