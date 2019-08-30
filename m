Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF18A3E88
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2019 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfH3TjG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Aug 2019 15:39:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42748 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3TjG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Aug 2019 15:39:06 -0400
Received: by mail-io1-f71.google.com with SMTP id x9so9729866ior.9
        for <linux-ext4@vger.kernel.org>; Fri, 30 Aug 2019 12:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FTbnECkwX1k08K13xihoScCca2rgDwnviVrV9UZiWrU=;
        b=PUVZ8BMAZJ5StXMoBn5Ky6l2YrxRGhnRh7qGiodllQ9cKGmg+hAUmlQfZcWQmK5I70
         AZLymf3EqLENlRbJRWr3G5nGRDwrqdkL2q4JTXm5idN9UaP+NoqONKs9MIezgXZku/Yn
         u+FUC9/FlLxA2tZrr1eE3v9cP4ez2KlDUPwQVEcPM1QNXtfDbGFYtVHayRxmIiHS7D3c
         05fSYdqmWX0UD1tKt+BQKUc9Iprm7s5mmcHFgLx+reF0KzbcAI3n3r4JuSGQkbMYQafc
         UlRLOGLoPGtEwHM4Co8iWfxG6wgRWslRcFwThUp7W6TRDiqhCE/zxhaUG1OuN3qckZcp
         /EOw==
X-Gm-Message-State: APjAAAXP1JI3H3XMsHlGAhnPHzLCiDh0nXk78urGboUa9780FtVcyex9
        vioPTh8pGU0ptk81FmUAic+I3oBxMLZyLXpTtOFiHznKJVyP
X-Google-Smtp-Source: APXvYqxUEVRlule/rXFBzIQf0q7idLvhTnyeapvy1aABxBhC+5ULqwOFQbKJR4rZ2VONFMtMv5keWmps+si50dAeNGvC2WKVFPC3
MIME-Version: 1.0
X-Received: by 2002:a05:6602:18d:: with SMTP id m13mr8596613ioo.12.1567193945849;
 Fri, 30 Aug 2019 12:39:05 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:39:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fc70605915ac6ad@google.com>
Subject: WARNING: ODEBUG bug in ext4_fill_super
From:   syzbot <syzbot+0bf8ddafbdf2c46eb6f3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ed858b88 Add linux-next specific files for 20190826
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14209eca600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8373cd9733e305
dashboard link: https://syzkaller.appspot.com/bug?extid=0bf8ddafbdf2c46eb6f3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0bf8ddafbdf2c46eb6f3@syzkaller.appspotmail.com

EXT4-fs (loop2): corrupt root inode, run e2fsck
EXT4-fs (loop2): mount failed
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: percpu_counter hint: 0x0
WARNING: CPU: 0 PID: 12342 at lib/debugobjects.c:481  
debug_print_object+0x168/0x250 lib/debugobjects.c:481
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12342 Comm: syz-executor.2 Not tainted 5.3.0-rc6-next-20190826  
#73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:220
  __warn.cold+0x2f/0x3c kernel/panic.c:581
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:debug_print_object+0x168/0x250 lib/debugobjects.c:481
Code: dd 60 6c e6 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b5 00 00 00 48  
8b 14 dd 60 6c e6 87 48 c7 c7 c0 61 e6 87 e8 20 31 01 fe <0f> 0b 83 05 f3  
67 83 06 01 48 83 c4 20 5b 41 5c 41 5d 41 5e 5d c3
RSP: 0018:ffff88806c9ff938 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815bd606 RDI: ffffed100d93ff19
RBP: ffff88806c9ff978 R08: ffff888067d48140 R09: ffffed1015d04109
R10: ffffed1015d04108 R11: ffff8880ae820847 R12: 0000000000000001
R13: ffffffff8935e800 R14: 0000000000000000 R15: ffff88806903c818
  __debug_check_no_obj_freed lib/debugobjects.c:963 [inline]
  debug_check_no_obj_freed+0x2d4/0x43f lib/debugobjects.c:994
  kfree+0xf8/0x2c0 mm/slab.c:3755
  ext4_fill_super+0x8cb/0xcc80 fs/ext4/super.c:4684
  mount_bdev+0x304/0x3c0 fs/super.c:1407
  ext4_mount+0x35/0x40 fs/ext4/super.c:6019
  legacy_get_tree+0x113/0x220 fs/fs_context.c:651
  vfs_get_tree+0x8f/0x380 fs/super.c:1482
  do_new_mount fs/namespace.c:2796 [inline]
  do_mount+0x13b3/0x1c30 fs/namespace.c:3116
  ksys_mount+0xdb/0x150 fs/namespace.c:3325
  __do_sys_mount fs/namespace.c:3339 [inline]
  __se_sys_mount fs/namespace.c:3336 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3336
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c2ca
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 9d 8d fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7a 8d fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fa684517a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fa684517b40 RCX: 000000000045c2ca
RDX: 00007fa684517ae0 RSI: 0000000020000000 RDI: 00007fa684517b00
RBP: 0000000000001000 R08: 00007fa684517b40 R09: 00007fa684517ae0
R10: 0000000000000001 R11: 0000000000000206 R12: 0000000000000003
R13: 00000000004c89d6 R14: 00000000004df8f8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
