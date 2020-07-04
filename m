Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D120821445C
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Jul 2020 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgGDGnX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 Jul 2020 02:43:23 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57327 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgGDGnX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 Jul 2020 02:43:23 -0400
Received: by mail-io1-f71.google.com with SMTP id l22so20551882iob.23
        for <linux-ext4@vger.kernel.org>; Fri, 03 Jul 2020 23:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GQHAa6+3QMCUpWXfH+pfAZwNIfkvEKykxXwlRq72QJc=;
        b=UQ7z7ZZpD6UVrbx/54QfkT6T+Y1psnlFoVjKZPcDlP8XnLEo3tiMqgFtyUyt0gctWC
         zIOiZzBHGD69tX4vU8xyp8Z9k8ooi/JxiTKm247/YKQy82OsNmSkhu+1ava6CFgcNE8P
         Owkm18A6VDznUo9RB/svspxj12yQ79PeIRopXdaplF+Xr/F7tHSXoDhQB/ReXnxxFJOt
         QUX9log4h9+Q9lBpGz1O6CvnbLcizzoFxnuFM0d/4QZZQCxdAUIKEvoWgn35THVmfilR
         YXuuRu8yOWb5nTy3iDtbakcH1oD9LUkhTiLq0/stKGGof7deZLJNvX+w56hsH7pkbFWR
         fviA==
X-Gm-Message-State: AOAM530/NO/noI+GllJj2xr+xCJxNqLo1Y2ACYf0CZouTJ8MU4rY8xQ9
        20xJViDcec4kkOdaLfNs0SZVUdfxx5RtoiVnkcjytL7y6nSC
X-Google-Smtp-Source: ABdhPJzMsfrzIL+jv6NJvvrHOt5Ppwx73r9Yp50JqG8XtsGl1bm4Ws3hp6FfoI7R9oZZmh90Ro0br7MQitZFVdXrgpyPOvfe9Hkt
MIME-Version: 1.0
X-Received: by 2002:a92:8411:: with SMTP id l17mr22273707ild.83.1593845002082;
 Fri, 03 Jul 2020 23:43:22 -0700 (PDT)
Date:   Fri, 03 Jul 2020 23:43:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d1dc105a997f52f@google.com>
Subject: BUG: Bad page state (7)
From:   syzbot <syzbot+d518e502e242315e777c@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    36e3135d Add linux-next specific files for 20200626
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14ae8923100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da5d3b3f1820f562
dashboard link: https://syzkaller.appspot.com/bug?extid=d518e502e242315e777c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d518e502e242315e777c@syzkaller.appspotmail.com

BUG: Bad page state in process kworker/u4:1  pfn:1f9a6b
page:ffffea0007e69ac0 refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8881f9a6bb98
flags: 0x57ffe0000000000()
raw: 057ffe0000000000 dead000000000100 dead000000000122 0000000000000000
raw: ffff8881f9a6bb98 ffff8881f9a6b040 00000000ffffffff ffff8881fae55b01
page dumped because: page still charged to cgroup
page->mem_cgroup:ffff8881fae55b01
Modules linked in:
CPU: 1 PID: 22199 Comm: kworker/u4:1 Not tainted 5.8.0-rc2-next-20200626-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 bad_page.cold+0x9c/0xbd mm/page_alloc.c:638
 check_free_page_bad mm/page_alloc.c:1093 [inline]
 check_free_page mm/page_alloc.c:1103 [inline]
 free_pages_prepare mm/page_alloc.c:1204 [inline]
 free_pcp_prepare+0x2f9/0x390 mm/page_alloc.c:1245
 free_unref_page_prepare mm/page_alloc.c:3095 [inline]
 free_unref_page+0x12/0x2d0 mm/page_alloc.c:3144
 slab_destroy mm/slab.c:1615 [inline]
 slabs_destroy+0x89/0xc0 mm/slab.c:1631
 __cache_free_alien mm/slab.c:778 [inline]
 cache_free_alien mm/slab.c:794 [inline]
 ___cache_free+0x39a/0x750 mm/slab.c:3442
 qlink_free mm/kasan/quarantine.c:148 [inline]
 qlist_free_all+0x79/0x140 mm/kasan/quarantine.c:167
 quarantine_reduce+0x17e/0x200 mm/kasan/quarantine.c:260
 __kasan_kmalloc.constprop.0+0x9e/0xd0 mm/kasan/common.c:475
 slab_post_alloc_hook mm/slab.h:535 [inline]
 slab_alloc mm/slab.c:3306 [inline]
 __do_kmalloc mm/slab.c:3647 [inline]
 __kmalloc+0x174/0x4d0 mm/slab.c:3658
 kmalloc_array+0x42/0x70 include/linux/slab.h:594
 kcalloc include/linux/slab.h:605 [inline]
 ext4_find_extent+0x984/0xce0 fs/ext4/extents.c:869
 ext4_ext_map_blocks+0x1e2/0x61b0 fs/ext4/extents.c:4059
 ext4_map_blocks+0x7b8/0x1650 fs/ext4/inode.c:626
 ext4_convert_unwritten_extents+0x1c6/0x570 fs/ext4/extents.c:4755
 ext4_convert_unwritten_io_end_vec+0x122/0x270 fs/ext4/extents.c:4794
 ext4_end_io_end fs/ext4/page-io.c:187 [inline]
 ext4_do_flush_completed_IO fs/ext4/page-io.c:260 [inline]
 ext4_end_io_rsv_work+0x2b3/0x640 fs/ext4/page-io.c:274
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
