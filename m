Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28CE3ECA2E
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Aug 2021 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhHOQ1s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Aug 2021 12:27:48 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37602 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhHOQ1r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Aug 2021 12:27:47 -0400
Received: by mail-io1-f72.google.com with SMTP id n13-20020a5e8c0d0000b02905a890e11005so7993299ioj.4
        for <linux-ext4@vger.kernel.org>; Sun, 15 Aug 2021 09:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J9YvmhApo7LeDQzESKj7GYbqctC5oRNmbBAZx5Bpw0c=;
        b=Vqp1DwjGZSODydwR4KUX1GwyuLlEAciv2glrq9Zdz8Ha1ZN6jDn2Sq6cq9zOrLw36H
         TqXc6lyJss9S4JQsWAc0M2Y39J+C8bbds7dothzr0S1/556UAtXjjBZMrdmPOHYBEabi
         rTp8bQio3JWodMHWcVJ47RfZxmoyqj8FpTlq+v5lfKxeKJD6RKLHkL4rS4FjOXAoDtJA
         DLR/wMzHaZQb874HsrqhuysJgcb0nbm5usfrdZfQ4hgWoT1c+LyNUHGK9ytwTp/8E+vp
         d/WAVVStgivm2nVSVGyMN4CVBh7xQnU+v6bPzRxt1r3ahOPPnaE60nsD1bqBX1tpdnH3
         h6iQ==
X-Gm-Message-State: AOAM532ZB7SkenUnq+cc1elsL5gWSWtWetbu2AxGwDXRXkWXse9voJuO
        639u2XDmsrga9Tyt5GEn66b1Y0A8umgBtJGRRT+nkggumPlD
X-Google-Smtp-Source: ABdhPJxAzL/vvtdRvohDGldM0Is+D8egscBb71ndzl9m/c5d2xV92U8GRk1euh1lacQJ/zenDCMXgAz7Z6JeHyKLYq1nNTBvCsp5
MIME-Version: 1.0
X-Received: by 2002:a92:b112:: with SMTP id t18mr8970939ilh.36.1629044837452;
 Sun, 15 Aug 2021 09:27:17 -0700 (PDT)
Date:   Sun, 15 Aug 2021 09:27:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc107905c99b8e53@google.com>
Subject: [syzbot] KASAN: use-after-free Write in ext4_write_inline_data
From:   syzbot <syzbot+1bd003b0dbaa786227e6@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, bvanassche@acm.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    761c6d7ec820 Merge tag 'arc-5.14-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117755e9300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a20bae04b96ccd
dashboard link: https://syzkaller.appspot.com/bug?extid=1bd003b0dbaa786227e6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbbfe9300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124bbb81300000

The issue was bisected to:

commit 669de8bda87b92ab9a2fc663b3f5743c2ad1ae9f
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Thu Feb 14 23:00:54 2019 +0000

    kernel/workqueue: Use dynamic lockdep keys for workqueues

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17aa2665300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146a2665300000
console output: https://syzkaller.appspot.com/x/log.txt?x=106a2665300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1bd003b0dbaa786227e6@syzkaller.appspotmail.com
Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/fortify-string.h:191 [inline]
BUG: KASAN: use-after-free in ext4_write_inline_data+0x30d/0x3e0 fs/ext4/inline.c:245
Write of size 70 at addr ffff8880359ec4ef by task syz-executor244/8446

CPU: 1 PID: 8446 Comm: syz-executor244 Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 memcpy+0x39/0x60 mm/kasan/shadow.c:66
 memcpy include/linux/fortify-string.h:191 [inline]
 ext4_write_inline_data+0x30d/0x3e0 fs/ext4/inline.c:245
 ext4_write_inline_data_end+0x24c/0x6b0 fs/ext4/inline.c:754
 ext4_write_end+0x22b/0xf60 fs/ext4/inode.c:1290
 ext4_da_write_end+0x440/0xb50 fs/ext4/inode.c:3079
 generic_perform_write+0x2bd/0x500 mm/filemap.c:3667
 ext4_buffered_write_iter+0x244/0x4d0 fs/ext4/file.c:269
 ext4_file_write_iter+0x423/0x14e0 fs/ext4/file.c:680
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x75a/0xa40 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x44ac89
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8a10a6f2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004ce4e0 RCX: 000000000044ac89
RDX: 0000000000000082 RSI: 0000000020000180 RDI: 0000000000000008
RBP: 000000000049de98 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 024645fc87234f45 R14: 26e1d8b70aefbc5b R15: 00000000004ce4e8

The buggy address belongs to the page:
page:ffffea0000d67b00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x359ec
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0000497f88 ffffea0000614208 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), pid 8369, ts 45323892408, free_ts 45393497770
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4169
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5391
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 __pte_alloc_one include/asm-generic/pgalloc.h:63 [inline]
 pte_alloc_one+0x16/0x230 arch/x86/mm/pgtable.c:33
 do_fault_around mm/memory.c:4145 [inline]
 do_read_fault mm/memory.c:4166 [inline]
 do_fault mm/memory.c:4300 [inline]
 handle_pte_fault mm/memory.c:4558 [inline]
 __handle_mm_fault+0x49de/0x5320 mm/memory.c:4693
 handle_mm_fault+0x1c8/0x790 mm/memory.c:4791
 do_user_addr_fault+0x48b/0x11c0 arch/x86/mm/fault.c:1390
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1397
 free_unref_page_prepare mm/page_alloc.c:3332 [inline]
 free_unref_page_list+0x1a1/0x1050 mm/page_alloc.c:3448
 release_pages+0x824/0x20b0 mm/swap.c:972
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x620 mm/mmap.c:3203
 __mmput+0x122/0x470 kernel/fork.c:1101
 mmput+0x58/0x60 kernel/fork.c:1122
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xae2/0x2a60 kernel/exit.c:812
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff8880359ec380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880359ec400: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880359ec480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                          ^
 ffff8880359ec500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880359ec580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
