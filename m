Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8283F2905
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 11:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhHTJS5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 05:18:57 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50122 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhHTJS5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 05:18:57 -0400
Received: by mail-io1-f70.google.com with SMTP id k6-20020a6b3c060000b0290568c2302268so5043671iob.16
        for <linux-ext4@vger.kernel.org>; Fri, 20 Aug 2021 02:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=klpds5T+BVnKDxwQfgde5Ruga8lw8fM9KzndfRF2hYI=;
        b=kXcgcYUOboWtVuPrE8frU8VRhLHE3EeZZPGWO1pOwdDqRfnHqjYUk/5UNX87yOPS5b
         M7VValw2Ft1FbFoMedgxRr838554XvUUe3pTf/jyc6chUyg/h9SSTFYksUEXCuxBut3j
         QyslSZrToiH9MnTG+pWnh0JXW89YOhUhJVow2rd4AREeki81boB2QoqT8c9H2EzOPyfq
         q54qrkSqDlUqG6rbjSC28cYI1QsTvHkX1kb2i7b7fRZNApnnaRGT2c4f+ybuYHN6bVoQ
         EyC9E+HxQqn+1SRz8g3AQyLFtYsJHjr6T2Vz1coH5ZEq93j2ccr6vPWuMPCjVJszeqVA
         cnAg==
X-Gm-Message-State: AOAM531/FIHDIC3mc0OQYLn6GpNrIcfp64r2oNDrCv4lVSbr5Mt51gJJ
        rS2cbVbpbPWqZM+oVSSnq6tHFYSRCcWCw885oIkSMr/prbLz
X-Google-Smtp-Source: ABdhPJylV48gv+oQiugYq4pMyfopzJmlDqmby+b/HBcp/bwuOd16+TI764Yo8TR6qBSSjQZyIRsI77VAUFCHwXPWouBBKgH57gvu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d5:: with SMTP id j21mr17125127jat.119.1629451099380;
 Fri, 20 Aug 2021 02:18:19 -0700 (PDT)
Date:   Fri, 20 Aug 2021 02:18:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f523b005c9fa252c@google.com>
Subject: [syzbot] KASAN: use-after-free Read in ext4_find_extent
From:   syzbot <syzbot+333dc3792ca8ce20b80c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    614cb2751d31 Merge tag 'trace-v5.14-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164bc961300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=333dc3792ca8ce20b80c
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+333dc3792ca8ce20b80c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch fs/ext4/extents.c:784 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0xae9/0xcc0 fs/ext4/extents.c:904
Read of size 4 at addr ffff888043db6024 by task kworker/u4:11/12775

CPU: 0 PID: 12775 Comm: kworker/u4:11 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-7:5)
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_address_description+0x66/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x163/0x210 mm/kasan/report.c:436
 ext4_ext_binsearch fs/ext4/extents.c:784 [inline]
 ext4_find_extent+0xae9/0xcc0 fs/ext4/extents.c:904
 ext4_ext_map_blocks+0x1e7/0x7210 fs/ext4/extents.c:4061
 ext4_map_blocks+0xab3/0x1cb0 fs/ext4/inode.c:638
 mpage_map_one_extent fs/ext4/inode.c:2395 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2448 [inline]
 ext4_writepages+0x1797/0x3f30 fs/ext4/inode.c:2800
 do_writepages+0x12e/0x2b0 mm/page-writeback.c:2355
 __writeback_single_inode+0xd4/0x590 fs/fs-writeback.c:1613
 writeback_sb_inodes+0xd8e/0x2b80 fs/fs-writeback.c:1878
 wb_writeback+0x423/0x9c0 fs/fs-writeback.c:2051
 wb_do_writeback fs/fs-writeback.c:2196 [inline]
 wb_workfn+0x41b/0x13c0 fs/fs-writeback.c:2237
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the page:
page:ffffea00010f6d80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x100 pfn:0x43db6
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001189248 ffffea00015da888 0000000000000000
raw: 0000000000000100 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x1101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRITE), pid 20166, ts 379239124786, free_ts 380213300070
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4169
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5391
 __page_cache_alloc+0x79/0x1c0 mm/filemap.c:1005
 pagecache_get_page+0x85e/0xf70 mm/filemap.c:1885
 grab_cache_page_write_begin+0x50/0x90 mm/filemap.c:3610
 ext4_da_write_begin+0x539/0x10c0 fs/ext4/inode.c:2984
 generic_perform_write+0x262/0x580 mm/filemap.c:3656
 ext4_buffered_write_iter+0x41c/0x590 fs/ext4/file.c:269
 ext4_file_write_iter+0x8f7/0x1b90 fs/ext4/file.c:519
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0xa39/0xc90 fs/read_write.c:605
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1397
 free_unref_page_prepare mm/page_alloc.c:3332 [inline]
 free_unref_page_list+0x118/0xad0 mm/page_alloc.c:3448
 release_pages+0x18bb/0x1af0 mm/swap.c:972
 __pagevec_release+0x7d/0xf0 mm/swap.c:992
 pagevec_release include/linux/pagevec.h:81 [inline]
 truncate_inode_pages_range+0x472/0x12d0 mm/truncate.c:329
 ext4_evict_inode+0x424/0xf70 fs/ext4/inode.c:223
 evict+0x2a4/0x620 fs/inode.c:584
 do_unlinkat+0x528/0x990 fs/namei.c:4109
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff888043db5f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888043db5f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888043db6000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff888043db6080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888043db6100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
