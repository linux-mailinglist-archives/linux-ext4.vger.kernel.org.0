Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7373094A6
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 12:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhA3LF6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 06:05:58 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43368 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhA3LF5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 06:05:57 -0500
Received: by mail-il1-f197.google.com with SMTP id b4so9615680ilj.10
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 03:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jCBSnhYhEzX3fnG+CyRibw/WOx8ApQmO7+F32f63PTk=;
        b=hqZMs/UPuZYCynQCcbr6+b9n5fxF4hA1ytHjF3z6D4eJ/iKfSxIE0kmeQsS3S0G1wY
         0z57ErjaKMFYJLtd+vFPVAzByRGMb3rEq4rkfMNaNI2UqIDjgHHh8Vi2zaTN8wW58gZ9
         rSrHLq3aeZhFMcXAAr3c1ypDf37G+kCpZlkLOLFNIiwedjnfwkoahvvLztR0gtYQ0zKr
         cALDu8XpQuOsfHiqEhxcU9suG1GOjJ91zSkcfCkiLe6CEfet/P5890iAjCZMZ+bTIawf
         /2+Yx7PzTpg1KEjMQQlf2P4BHWGx+B6lzPwmGYXHKRjC3QdnX+TvdUAyA7CVZacVX3dR
         k5dA==
X-Gm-Message-State: AOAM532JKTBEFuSkC3BZAJpaNTQR3wJyLz9sJIcS0CTWgE3ZmnSfY9mE
        iPQVrncIWLVgbCr9ncSNSrbJXA6RObuV93FEBEDQFVexwBNm
X-Google-Smtp-Source: ABdhPJxqHQKx65sKV365XJS+R6hQXLKWru0dwR6RmmGnXjPCjtsNz2RsBBFz7eXX8MCZHUc/AjXaDUrBvEACyoxrTngsHIGqkPve
MIME-Version: 1.0
X-Received: by 2002:a02:c76b:: with SMTP id k11mr7469699jao.57.1612004716035;
 Sat, 30 Jan 2021 03:05:16 -0800 (PST)
Date:   Sat, 30 Jan 2021 03:05:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079c56a05ba1c18c3@google.com>
Subject: KASAN: use-after-free Read in ext4_xattr_set_entry (4)
From:   syzbot <syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8ad8187 fs/pipe: allow sendfile() to pipe again
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b8ad10d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96b123631a6700e9
dashboard link: https://syzkaller.appspot.com/bug?extid=4cb1e27475bf90a9b926
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11131f94d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3761b500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x3151/0x3780 fs/ext4/xattr.c:1586
Read of size 4 at addr ffff888030c00004 by task syz-executor392/11280

CPU: 0 PID: 11280 Comm: syz-executor392 Not tainted 5.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 ext4_xattr_set_entry+0x3151/0x3780 fs/ext4/xattr.c:1586
 ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
 ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
 ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
 __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
 __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
 __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
 vfs_setxattr+0x135/0x320 fs/xattr.c:291
 setxattr+0x1ff/0x290 fs/xattr.c:553
 path_setxattr+0x170/0x190 fs/xattr.c:572
 __do_sys_setxattr fs/xattr.c:587 [inline]
 __se_sys_setxattr fs/xattr.c:583 [inline]
 __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:583
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x445589
Code: e8 4c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b cc fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffdf5f9b28 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 0000000000445589
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000020000100
RBP: 0000000001a18c30 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000073d
R13: 00007fffdf5f9ba0 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:00000000f7ed6945 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x1 pfn:0x30c00
flags: 0xfff00000000000()
raw: 00fff00000000000 ffffea0000c56508 ffffea0000c17d88 0000000000000000
raw: 0000000000000001 0000000000000001 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888030bfff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888030bfff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888030c00000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888030c00080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888030c00100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
