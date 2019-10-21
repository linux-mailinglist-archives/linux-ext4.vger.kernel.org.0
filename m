Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCBBEDE3B3
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 07:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfJUFYK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 01:24:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46615 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfJUFYK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 01:24:10 -0400
Received: by mail-io1-f70.google.com with SMTP id t15so12498087ios.13
        for <linux-ext4@vger.kernel.org>; Sun, 20 Oct 2019 22:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ibEOpCoeiPYGLofBO4gILotcPFeGeTi4EnMlW4wbLyg=;
        b=WPG0CNvYKWWwOS1uHGrP8NUeU/OHDhM034DSRQSgoz24kVwekaRS1onmdnSNI8OGUr
         j4owqxoCTtp/jsja27k8PdFHWiE9sK9hU19a2F6sPiETuAYqhNft1ZxfKx2eacMiIlX9
         3VFKEQQax2e76BhZ5TSpKKr4/vWi15ysyjapyZHzLuMKB5c75SWgqpmB2esXPwr1d6ow
         5EIAp3e7jNrLD20Z9jf5Lu7SoKdwr4H9zmMtqwVsRhJeKoWK0lNR4ooPJR/Et2McDKuC
         uwVzKazo+XkmeIyyuhvYb7TdLL810rRsZQ7DxDeouJ+rTpCiNW8iNy3LsyHQHklx2Hsn
         Dd4Q==
X-Gm-Message-State: APjAAAVKjIt7nS7fjQ1TRsSmIier3WwXvio5SXZGan88FZCvsG+YL1ib
        TzANAQjD3ULAZuDYLun23udhAKrxMw6fSl4D84jcIGXDygzx
X-Google-Smtp-Source: APXvYqyToV0HA6Xpp8sNTdjKNR8Rm0cybuN9cxK5b3p7FgMSp/8ymdO5V7IogUMWiqb0fVTnEdJK87QC7SuYdRsIh075fQ0OMu9v
MIME-Version: 1.0
X-Received: by 2002:a92:8404:: with SMTP id l4mr4531041ild.15.1571635447792;
 Sun, 20 Oct 2019 22:24:07 -0700 (PDT)
Date:   Sun, 20 Oct 2019 22:24:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000950f21059564e4c7@google.com>
Subject: BUG: unable to handle kernel paging request in __ext4_expand_extra_isize
From:   syzbot <syzbot+33d7ea72e47de3bdf4e1@syzkaller.appspotmail.com>
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

HEAD commit:    64c5e530 Merge tag 'arc-4.19-rc8' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17add285400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=33d7ea72e47de3bdf4e1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+33d7ea72e47de3bdf4e1@syzkaller.appspotmail.com

EXT4-fs (sda1): Mount option "noacl" will be removed by 3.5
Contact linux-ext4@vger.kernel.org if you think we should keep it.

EXT4-fs error (device sda1): ext4_expand_extra_isize_ea:2727: inode #16554:  
comm syz-executor0: corrupted in-inode xattr
EXT4-fs (sda1): re-mounted. Opts:  
debug_want_extra_isize=0x0000000074000000,noacl,
BUG: unable to handle kernel paging request at ffffed0044000000
EXT4-fs error (device sda1): ext4_expand_extra_isize_ea:2727: inode #16558:  
comm syz-executor2: corrupted in-inode xattr
PGD 21ffef067 P4D 21ffef067 PUD 21ffed067 PMD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5720 Comm: rs:main Q:Reg Not tainted 4.19.0-rc7+ #52
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memory_is_nonzero mm/kasan/kasan.c:195 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/kasan.c:210 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/kasan.c:241 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/kasan.c:257 [inline]
RIP: 0010:check_memory_region+0x9e/0x1b0 mm/kasan/kasan.c:267
Code: c8 49 c1 f9 03 45 85 c9 0f 84 23 01 00 00 48 83 38 00 75 1c 45 8d 41  
ff 4a 8d 5c c0 08 48 83 c0 08 48 39 c3 0f 84 a8 00 00 00 <48> 83 38 00 74  
ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 0a 80
RSP: 0018:ffff8801d8bb6f98 EFLAGS: 00010206
RAX: ffffed0044000000 RBX: ffffed00518c2bf0 RCX: ffffffff82171b58
RDX: 0000000000000001 RSI: 0000000073ffffe0 RDI: ffff880218615fa0
RBP: ffff8801d8bb6fb0 R08: 0000000001cffffe R09: 0000000001cfffff
R10: ffffed00518c2bef R11: ffff88028c615f7f R12: ffffed00518c2bf0
R13: 0000000000000004 R14: ffff880218615fa0 R15: 0000000074000000
FS:  00007fef5d695700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed0044000000 CR3: 00000001c3a63000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  memset+0x23/0x40 mm/kasan/kasan.c:285
  memset include/linux/string.h:330 [inline]
  __ext4_expand_extra_isize+0x178/0x240 fs/ext4/inode.c:5865
EXT4-fs error (device sda1): ext4_expand_extra_isize_ea:2727: inode #16548:  
comm syz-executor3: corrupted in-inode xattr
  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5917 [inline]
  ext4_mark_inode_dirty+0x902/0xb30 fs/ext4/inode.c:5993
overlayfs: failed to resolve './file1': -2
EXT4-fs warning (device sda1): ext4_expand_extra_isize_ea:2789: Unable to  
expand inode 16558. Delete some EAs or run e2fsck.
  ext4_dirty_inode+0x97/0xc0 fs/ext4/inode.c:6027
  __mark_inode_dirty+0x7c3/0x1510 fs/fs-writeback.c:2129
==================================================================
BUG: KASAN: use-after-free in memset include/linux/string.h:330 [inline]
BUG: KASAN: use-after-free in __ext4_expand_extra_isize+0x178/0x240  
fs/ext4/inode.c:5865
Write of size 1946157024 at addr ffff8801b65c65a0 by task  
syz-executor1/21720

CPU: 0 PID: 21720 Comm: syz-executor1 Not tainted 4.19.0-rc7+ #52
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
  mark_inode_dirty include/linux/fs.h:2070 [inline]
  __generic_write_end+0x320/0x400 fs/buffer.c:2117
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  generic_write_end+0x6c/0x90 fs/buffer.c:2162
  ext4_da_write_end+0x2e0/0xcd0 fs/ext4/inode.c:3173
  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
  memset+0x23/0x40 mm/kasan/kasan.c:285
  memset include/linux/string.h:330 [inline]
  __ext4_expand_extra_isize+0x178/0x240 fs/ext4/inode.c:5865
  ext4_try_to_expand_extra_isize fs/ext4/inode.c:5917 [inline]
  ext4_mark_inode_dirty+0x902/0xb30 fs/ext4/inode.c:5993
  generic_perform_write+0x4ca/0x6a0 mm/filemap.c:3150
  ext4_dirty_inode+0x97/0xc0 fs/ext4/inode.c:6027
  __mark_inode_dirty+0x7c3/0x1510 fs/fs-writeback.c:2129
  __generic_file_write_iter+0x26e/0x630 mm/filemap.c:3264
  ext4_file_write_iter+0x390/0x1420 fs/ext4/file.c:266
  call_write_iter include/linux/fs.h:1808 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
  generic_update_time+0x26a/0x450 fs/inode.c:1651
  update_time fs/inode.c:1667 [inline]
  file_update_time+0x390/0x640 fs/inode.c:1877
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  ext4_page_mkwrite+0x1fe/0x14a0 fs/ext4/inode.c:6171
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  do_page_mkwrite+0x14e/0x660 mm/memory.c:2388
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fef5f0f319d
Code: d1 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48  
83 ec 08 e8 be fa ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 07 fb ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fef5d694000 EFLAGS: 00000293
  do_shared_fault mm/memory.c:3717 [inline]
  do_fault mm/memory.c:3756 [inline]
  handle_pte_fault mm/memory.c:3983 [inline]
  __handle_mm_fault+0x35ca/0x53e0 mm/memory.c:4107
  ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000388 RCX: 00007fef5f0f319d
RDX: 0000000000000388 RSI: 000000000236aa90 RDI: 0000000000000005
RBP: 000000000236aa90 R08: 656c6c616b7a7973 R09: 6c656e72656b2072
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007fef5d694480 R14: 0000000000000008 R15: 000000000236a890
Modules linked in:
CR2: ffffed0044000000
---[ end trace 9a8a1d955d622e7a ]---
RIP: 0010:memory_is_nonzero mm/kasan/kasan.c:195 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/kasan.c:210 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/kasan.c:241 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/kasan.c:257 [inline]
RIP: 0010:check_memory_region+0x9e/0x1b0 mm/kasan/kasan.c:267
Code: c8 49 c1 f9 03 45 85 c9 0f 84 23 01 00 00 48 83 38 00 75 1c 45 8d 41  
ff 4a 8d 5c c0 08 48 83 c0 08 48 39 c3 0f 84 a8 00 00 00 <48> 83 38 00 74  
ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 0a 80
RSP: 0018:ffff8801d8bb6f98 EFLAGS: 00010206
  handle_mm_fault+0x54f/0xc70 mm/memory.c:4144
RAX: ffffed0044000000 RBX: ffffed00518c2bf0 RCX: ffffffff82171b58
RDX: 0000000000000001 RSI: 0000000073ffffe0 RDI: ffff880218615fa0
  __do_page_fault+0x67d/0xed0 arch/x86/mm/fault.c:1395
RBP: ffff8801d8bb6fb0 R08: 0000000001cffffe R09: 0000000001cfffff
R10: ffffed00518c2bef R11: ffff88028c615f7f R12: ffffed00518c2bf0
R13: 0000000000000004 R14: ffff880218615fa0 R15: 0000000074000000
FS:  00007fef5d695700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  do_page_fault+0xf2/0x7e0 arch/x86/mm/fault.c:1470
CR2: ffffed0044000000 CR3: 00000001c3a63000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
