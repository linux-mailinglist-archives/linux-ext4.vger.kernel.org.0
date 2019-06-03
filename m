Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425773333D
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 17:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfFCPPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 11:15:06 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:57492 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbfFCPPG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jun 2019 11:15:06 -0400
Received: by mail-it1-f198.google.com with SMTP id s2so13293294itl.7
        for <linux-ext4@vger.kernel.org>; Mon, 03 Jun 2019 08:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aYyoLqNm2bvzm13kcrGrqf8JQRrHiCh2MlKzN8QfK5k=;
        b=svLVpRK2Yl23X+2ffkLHUgu7mfux7nVCdxNxfUW0hgNkBY2uBUqsrXeRxraVJ6dkjh
         FeyYI0qiylctm2csVK+rbg67YLKGq/JfwGCKb3E0KiiJSPGBKEUjRWKC7wbl27E+BwE8
         +MUr39WUx/s7Ak/2PCgAlzbA6yb4lC/Gvyul1ToqGQaDtN2zYuFgfpfmlA6+PogTP3N9
         gU8pLptdmB/0ThS7Llyy8SC1iAL6gsXBsehwo0UbqIuMFOPJX3UzGUGStVUoiODnc6Ky
         6KKaOFM8IZdHHVRF4xyzZFOKT9nGuiWC+8i6leFhktR7MLvDfLUr1tEzDphdLfKK6dvK
         pZww==
X-Gm-Message-State: APjAAAUf9xvoAN4KTE6ZfybTzrsMy4u+CqJZ2oc8FrmxkU43BaNW6v+C
        RKNMU2exfoPCk4vEcC6HQjz//MPHUH2pfZ/j8JVdwXAgPN2j
X-Google-Smtp-Source: APXvYqyBague7h2bLjgMeqhSpGLzzxeQ3h+R8fyfVD8l1gn6Om+rQ+/flDQ5jS+8lz36qjT8p49BzHBlrhWJhf7CLFLI/8+sTits
MIME-Version: 1.0
X-Received: by 2002:a24:7cd8:: with SMTP id a207mr8296754itd.68.1559574905376;
 Mon, 03 Jun 2019 08:15:05 -0700 (PDT)
Date:   Mon, 03 Jun 2019 08:15:05 -0700
In-Reply-To: <000000000000fa91e1058a358cd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c5c7b058a6cd4f6@google.com>
Subject: Re: possible deadlock in __do_page_fault (2)
From:   syzbot <syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, hdanton@sina.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    3c09c195 Add linux-next specific files for 20190531
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=134e29dea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cfb24468280cd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=606e524a3ca9617cf8c0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10572ca6a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.2.0-rc2-next-20190531 #4 Not tainted
------------------------------------------------------
syz-executor.0/16846 is trying to acquire lock:
00000000120cad2f (&mm->mmap_sem#2){++++}, at: do_user_addr_fault  
arch/x86/mm/fault.c:1407 [inline]
00000000120cad2f (&mm->mmap_sem#2){++++}, at: __do_page_fault+0x9e9/0xda0  
arch/x86/mm/fault.c:1522

but task is already holding lock:
00000000fd4e5238 (&sb->s_type->i_mutex_key#10){+.+.}, at: inode_trylock  
include/linux/fs.h:798 [inline]
00000000fd4e5238 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
ext4_file_write_iter+0x246/0x1070 fs/ext4/file.c:232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#10){+.+.}:
        down_write+0x38/0xa0 kernel/locking/rwsem.c:66
        inode_lock include/linux/fs.h:778 [inline]
        process_measurement+0x15ae/0x15e0  
security/integrity/ima/ima_main.c:228
        ima_file_mmap+0x11a/0x130 security/integrity/ima/ima_main.c:370
        security_file_mprotect+0xd5/0x100 security/security.c:1430
        do_mprotect_pkey+0x537/0xa30 mm/mprotect.c:550
        __do_sys_pkey_mprotect mm/mprotect.c:590 [inline]
        __se_sys_pkey_mprotect mm/mprotect.c:587 [inline]
        __x64_sys_pkey_mprotect+0x97/0xf0 mm/mprotect.c:587
        do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&mm->mmap_sem#2){++++}:
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
        down_read+0x3f/0x1e0 kernel/locking/rwsem.c:24
        do_user_addr_fault arch/x86/mm/fault.c:1407 [inline]
        __do_page_fault+0x9e9/0xda0 arch/x86/mm/fault.c:1522
        do_page_fault+0x71/0x57d arch/x86/mm/fault.c:1553
        page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1156
        fault_in_pages_readable include/linux/pagemap.h:600 [inline]
        iov_iter_fault_in_readable+0x377/0x450 lib/iov_iter.c:426
        generic_perform_write+0x186/0x520 mm/filemap.c:3197
        __generic_file_write_iter+0x25e/0x630 mm/filemap.c:3336
        ext4_file_write_iter+0x332/0x1070 fs/ext4/file.c:266
        call_write_iter include/linux/fs.h:1870 [inline]
        new_sync_write+0x4d3/0x770 fs/read_write.c:483
        __vfs_write+0xe1/0x110 fs/read_write.c:496
        vfs_write+0x268/0x5d0 fs/read_write.c:558
        ksys_write+0x14f/0x290 fs/read_write.c:611
        __do_sys_write fs/read_write.c:623 [inline]
        __se_sys_write fs/read_write.c:620 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:620
        do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&sb->s_type->i_mutex_key#10);
                                lock(&mm->mmap_sem#2);
                                lock(&sb->s_type->i_mutex_key#10);
   lock(&mm->mmap_sem#2);

  *** DEADLOCK ***

3 locks held by syz-executor.0/16846:
  #0: 00000000ae9485f5 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
  #1: 00000000485be47f (sb_writers#3){.+.+}, at: file_start_write  
include/linux/fs.h:2836 [inline]
  #1: 00000000485be47f (sb_writers#3){.+.+}, at: vfs_write+0x485/0x5d0  
fs/read_write.c:557
  #2: 00000000fd4e5238 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
inode_trylock include/linux/fs.h:798 [inline]
  #2: 00000000fd4e5238 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
ext4_file_write_iter+0x246/0x1070 fs/ext4/file.c:232

stack backtrace:
CPU: 1 PID: 16846 Comm: syz-executor.0 Not tainted 5.2.0-rc2-next-20190531  
#4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.cold+0x1cc/0x28f kernel/locking/lockdep.c:1566
  check_prev_add kernel/locking/lockdep.c:2311 [inline]
  check_prevs_add kernel/locking/lockdep.c:2419 [inline]
  validate_chain kernel/locking/lockdep.c:2801 [inline]
  __lock_acquire+0x3755/0x5490 kernel/locking/lockdep.c:3790
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
  down_read+0x3f/0x1e0 kernel/locking/rwsem.c:24
  do_user_addr_fault arch/x86/mm/fault.c:1407 [inline]
  __do_page_fault+0x9e9/0xda0 arch/x86/mm/fault.c:1522
  do_page_fault+0x71/0x57d arch/x86/mm/fault.c:1553
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1156
RIP: 0010:fault_in_pages_readable include/linux/pagemap.h:600 [inline]
RIP: 0010:iov_iter_fault_in_readable+0x377/0x450 lib/iov_iter.c:426
Code: 89 f6 41 88 57 e0 e8 48 e5 3c fe 45 85 f6 74 c1 e9 70 fe ff ff e8 b9  
e3 3c fe 0f 1f 00 0f ae e8 44 89 f0 48 8b 8d 68 ff ff ff <8a> 11 89 c3 0f  
1f 00 41 88 57 d0 31 ff 89 de e8 15 e5 3c fe 85 db
RSP: 0018:ffff88808bd7f918 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000002000127f
RDX: 0000000000000000 RSI: ffffffff833406b7 RDI: 0000000000000007
RBP: ffff88808bd7f9b8 R08: ffff888085396040 R09: ffff888085396938
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88808bd7f990
  generic_perform_write+0x186/0x520 mm/filemap.c:3197
  __generic_file_write_iter+0x25e/0x630 mm/filemap.c:3336
  ext4_file_write_iter+0x332/0x1070 fs/ext4/file.c:266
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fedf6831c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459279
RDX: 000000000000ff7f RSI: 0000000020000280 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fedf68326d4
R13: 00000000004c8aa4 R14: 00000000004df468 R15: 00000000ffffffff

