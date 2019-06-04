Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB93509C
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2019 22:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFDUHH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jun 2019 16:07:07 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:40406 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfFDUHG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jun 2019 16:07:06 -0400
Received: by mail-it1-f200.google.com with SMTP id u10so2219itb.5
        for <linux-ext4@vger.kernel.org>; Tue, 04 Jun 2019 13:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Qx32/jmFXzvap35zBa5P6GJR66Mkv/YmIfI7vIS/BYo=;
        b=q7AgBR6Jongxhmwk/1yZqwtNrNOxz+RnX/XEBU5b/iVMd7YvBku0YQ2FM5wioV7yYq
         4kXxyesqN9m4qJt9SFOwVuzuPcnxrI1HPDrcmA7LVQ8sM1WQIXFKd5UZk/pkJV7ToJSB
         JA8tvbrGSYnWZeKWOw6DXZB/jMMXhE/Q6W0662NUXYwtyKkyGgzoirC/0bmNFgLbaguj
         4SHVLu+Ok/0QibbHHqIOBIylfoZDKakSHOysQXKP+tarCXlIp/PkBylV/COZwqdrK3jC
         sMT/HkNq2JbItH9yoXPKyL/bbM/lxzc8WlFxpdkJ1sBRoYkTveqa3f94YbqwOWat3o89
         tJvA==
X-Gm-Message-State: APjAAAW2qwdGBR6cdp7v3PG1mGxUjHA8c6uspy0dpRnl+3SmegFacOIN
        vcFJzTljhhlbjqwOOvKKQRlJes02MeAkNarE5jzuLY0AdIBg
X-Google-Smtp-Source: APXvYqyxyoyD6gRXj7sk/YxH/ul0VNXXPgY/O7450SxPFKvjV9FEinAzm6jp/s5WKZh56OkqsrqXOsyqchAF2OJQR9D0yObIPIbo
MIME-Version: 1.0
X-Received: by 2002:a24:fcc4:: with SMTP id b187mr6727127ith.179.1559678825697;
 Tue, 04 Jun 2019 13:07:05 -0700 (PDT)
Date:   Tue, 04 Jun 2019 13:07:05 -0700
In-Reply-To: <000000000000fa91e1058a358cd5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ea120058a850695@google.com>
Subject: Re: possible deadlock in __do_page_fault (2)
From:   syzbot <syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, hdanton@sina.com, jmorris@namei.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d210d4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=606e524a3ca9617cf8c0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ddae0ea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e78f16a00000

The bug was bisected to:

commit 69d61f577d147b396be0991b2ac6f65057f7d445
Author: Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed Apr 3 21:47:46 2019 +0000

     ima: verify mprotect change is consistent with mmap policy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16461c5aa00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15461c5aa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11461c5aa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com
Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap  
policy")

======================================================
WARNING: possible circular locking dependency detected
5.2.0-rc3-next-20190604 #8 Not tainted
------------------------------------------------------
syz-executor361/10886 is trying to acquire lock:
00000000c4471342 (&mm->mmap_sem#2){++++}, at: do_user_addr_fault  
arch/x86/mm/fault.c:1406 [inline]
00000000c4471342 (&mm->mmap_sem#2){++++}, at: __do_page_fault+0x9e9/0xda0  
arch/x86/mm/fault.c:1521

but task is already holding lock:
000000009878d2b3 (&sb->s_type->i_mutex_key#10){+.+.}, at: inode_trylock  
include/linux/fs.h:798 [inline]
000000009878d2b3 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
ext4_file_write_iter+0x246/0x1070 fs/ext4/file.c:232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sb->s_type->i_mutex_key#10){+.+.}:
        down_write+0x38/0xa0 kernel/locking/rwsem.c:66
        inode_lock include/linux/fs.h:778 [inline]
        process_measurement+0x15ae/0x15e0  
security/integrity/ima/ima_main.c:228
        ima_file_mmap+0x11a/0x130 security/integrity/ima/ima_main.c:370
        security_file_mprotect+0xd5/0x100 security/security.c:1426
        do_mprotect_pkey+0x537/0xa30 mm/mprotect.c:550
        __do_sys_mprotect mm/mprotect.c:582 [inline]
        __se_sys_mprotect mm/mprotect.c:579 [inline]
        __x64_sys_mprotect+0x78/0xb0 mm/mprotect.c:579
        do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&mm->mmap_sem#2){++++}:
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
        down_read+0x3f/0x1e0 kernel/locking/rwsem.c:24
        do_user_addr_fault arch/x86/mm/fault.c:1406 [inline]
        __do_page_fault+0x9e9/0xda0 arch/x86/mm/fault.c:1521
        do_page_fault+0x71/0x57d arch/x86/mm/fault.c:1552
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

3 locks held by syz-executor361/10886:
  #0: 00000000b8e64295 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
  #1: 00000000e032805f (sb_writers#3){.+.+}, at: file_start_write  
include/linux/fs.h:2836 [inline]
  #1: 00000000e032805f (sb_writers#3){.+.+}, at: vfs_write+0x485/0x5d0  
fs/read_write.c:557
  #2: 000000009878d2b3 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
inode_trylock include/linux/fs.h:798 [inline]
  #2: 000000009878d2b3 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
ext4_file_write_iter+0x246/0x1070 fs/ext4/file.c:232

stack backtrace:
CPU: 0 PID: 10886 Comm: syz-executor361 Not tainted 5.2.0-rc3-next-20190604  
#8
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
  do_user_addr_fault arch/x86/mm/fault.c:1406 [inline]
  __do_page_fault+0x9e9/0xda0 arch/x86/mm/fault.c:1521
  do_page_fault+0x71/0x57d arch/x86/mm/fault.c:1552
  page_fault+0x1e/0x30 arch/x86/entry/entry_64.S:1156
RIP: 0010:fault_in_pages_readable include/linux/pagemap.h:600 [inline]
RIP: 0010:iov_iter_fault_in_readable+0x377/0x450 lib/iov_iter.c:426
Code: 89 f6 41 88 57 e0 e8 b8 dd 3c fe 45 85 f6 74 c1 e9 70 fe ff ff e8 29  
dc 3c fe 0f 1f 00 0f ae e8 44 89 f0 48 8b 8d 68 ff ff ff <8a> 11 89 c3 0f  
1f 00 41 88 57 d0 31 ff 89 de e8 85 dd 3c fe 85 db
RSP: 0018:ffff88808ca6f918 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000200011ff
RDX: 0000000000000000 RSI: ffffffff83341b37 RDI: 0000000000000007
RBP: ffff88808ca6f9b8 R08: ffff88809be68000 R09: ffff88809be688f8
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000000001000 R14: 0000000000000000 R15: ffff88808ca6f990
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
RIP: 0033:0x446939
Code: e8 4c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007effabbcdce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446939
RDX: 000000000007fe00 RSI: 0000000020000200 RDI: 0000000000000006
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007ffd5dd15ddf R14: 00007effabbce9c0 R15: 20c49ba5e353f7cf

