Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447B2DE3B2
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 07:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfJUFXL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 01:23:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46382 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJUFXL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 01:23:11 -0400
Received: by mail-io1-f69.google.com with SMTP id t15so12496593ios.13
        for <linux-ext4@vger.kernel.org>; Sun, 20 Oct 2019 22:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZdKnZjst7DyyK+x6sCAL8/L6eZyuHz1MCtPw3YcdJ2s=;
        b=gecuNdCrpnseFg5js3PU9+J6Vq/kVEqgc1hWyZKY/3HPcDIUr6YRsPX/8FSbvZDVYM
         yifvC2bUTHQgq+MMOCsZNNPfgnbyQh65fGmJxEq5xVmWGQ8818dv/0yOAhBiTgIb2Eh8
         W+Tmy+TYwQuYhmZQJ+xNZtcf8D9X1GIVqCb1l/BcOvV5zLhJaov6uynrV3F+LsC5i2jT
         WMhmXF24rCSdU2++Z5NOm6E7PLvySeI/zhRQFt1hBmgJ4JyM6hQ65eC8oZXp5/xkUGJc
         TrKwwEzXo/rW3WHIDRr1hqPSJd0VrahbrQ58nmgCFKGNegHbtyWlnYPP+1GCOErXBiv2
         smUw==
X-Gm-Message-State: APjAAAVTQ5tmLgL/cR5j3lWcd4/wM22h5Mo0vPQBNn1XaVR55Kzl6VaC
        +7KTDZSw9VxTLgJ8GYt3qcH1kSsaFlIVeS0xgyBbr/V/Ywxq
X-Google-Smtp-Source: APXvYqzoxb7HOvJ+gHaP6gB1G2giklxm7tLizdjMyDWOASKppseVav8DVlJJN+ErF+ASQ0rhCtHXngteyKRreuM1MCqb9ZxGIzbj
MIME-Version: 1.0
X-Received: by 2002:a92:9edd:: with SMTP id s90mr5566194ilk.244.1571635388574;
 Sun, 20 Oct 2019 22:23:08 -0700 (PDT)
Date:   Sun, 20 Oct 2019 22:23:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d74c7059564e17f@google.com>
Subject: KASAN: use-after-free Write in __ext4_expand_extra_isize (2)
From:   syzbot <syzbot+44b6763edfc17144296f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b145b0eb Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13887f1f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ec3be9936e004f6
dashboard link: https://syzkaller.appspot.com/bug?extid=44b6763edfc17144296f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+44b6763edfc17144296f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memset include/linux/string.h:344 [inline]
BUG: KASAN: use-after-free in __ext4_expand_extra_isize+0x1ab/0x290  
fs/ext4/inode.c:5924
Write of size 736 at addr ffff88803763aea0 by task syz-executor.5/28447

CPU: 1 PID: 28447 Comm: syz-executor.5 Not tainted 5.4.0-rc1+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memset+0x24/0x40 mm/kasan/common.c:105
  memset include/linux/string.h:344 [inline]
  __ext4_expand_extra_isize+0x1ab/0x290 fs/ext4/inode.c:5924
  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5976 [inline]
  ext4_mark_inode_dirty+0x74e/0x9b0 fs/ext4/inode.c:6052
  ext4_ext_truncate+0x92/0x200 fs/ext4/extents.c:4583
  ext4_truncate+0xc6e/0x13c0 fs/ext4/inode.c:4511
  ext4_evict_inode+0x9d4/0x14e0 fs/ext4/inode.c:289
  evict+0x306/0x680 fs/inode.c:574
  iput_final fs/inode.c:1563 [inline]
  iput+0x55d/0x900 fs/inode.c:1589
  dentry_unlink_inode+0x2d9/0x400 fs/dcache.c:374
  __dentry_kill+0x38b/0x600 fs/dcache.c:579
  dentry_kill fs/dcache.c:698 [inline]
  dput+0x639/0xe10 fs/dcache.c:859
  __fput+0x424/0x890 fs/file_table.c:293
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x904/0x2e60 kernel/exit.c:817
  do_group_exit+0x135/0x360 kernel/exit.c:921
  get_signal+0x47c/0x2500 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f163d095cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000075c120 RCX: 0000000000459a59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000075c120
RBP: 000000000075c118 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000075c124
R13: 00007ffee9e6c79f R14: 00007f163d0969c0 R15: 000000000075c124

The buggy address belongs to the page:
page:ffffea0000dd8e80 refcount:2 mapcount:0 mapping:ffff8880a2d8e520  
index:0x487
def_blk_aops
flags: 0x1fffc000000203a(referenced|dirty|lru|active|private)
raw: 01fffc000000203a ffffea0000e4cc08 ffffea0000b54b88 ffff8880a2d8e520
raw: 0000000000000487 ffff88808f15d150 00000002ffffffff ffff8880a17cec40
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8880a17cec40

Memory state around the buggy address:
  ffff88803763af00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88803763af80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88803763b000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                    ^
  ffff88803763b080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff88803763b100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
