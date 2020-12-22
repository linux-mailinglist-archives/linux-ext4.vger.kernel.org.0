Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067A52E06FB
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 08:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLVHzA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 02:55:00 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46654 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVHy7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 02:54:59 -0500
Received: by mail-il1-f198.google.com with SMTP id x14so11152239ilg.13
        for <linux-ext4@vger.kernel.org>; Mon, 21 Dec 2020 23:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+3sNvl7/QSHl39uxlPG0jsZu7BL9zj0pQ6s3H/yv4X8=;
        b=akyauQbwMtROlMqMysp7iPjvMXXwzF9FHI0qJd2i/1T/FFV0LHF9BKXqjBVF0R+xDH
         O6AIqAHuqv/qI7255wgDUjjw8c8cH5iuYGW5WIOgidWqjr39lxh0RenewF+mHg//XXfE
         m9lDuMhR//VpiYO1kdim7rziC1rt5ROv8VzCIMATVm2cLNlGnhkzZMaHSbw0Vjd5jS8G
         wr9xsQ/dYqCyaq5smRilwlKM/VI/2CtbYVojmx7X/eHqSsUUX2rzOk7Qkqaq7dTCU2nm
         gsVeCjYGrHgRXENTUTYp/EuoxT03LhjBr95ejVn3+Yt3Ng+cacQGnkG4DLFybHKrlyZQ
         Vbdg==
X-Gm-Message-State: AOAM531IvFdcrGjfH+d7uB0QIHYYBl/VPzGwNbMvaG8lJhsxsFOb1IO/
        P+qhBHmcXmr/w++TCxiSn4h/dxXgkUp9NVct8v95SR4bYtm2
X-Google-Smtp-Source: ABdhPJyWyGv19J7btbOf5mVhqJtXur7SuUDuAkRiR+3zBBkYG1bH/NjYvBz+ifg2ChRU7msSu5X0dX6nLvUq4PevqVxSTPoWh/YR
MIME-Version: 1.0
X-Received: by 2002:a92:ae06:: with SMTP id s6mr20668626ilh.282.1608623658795;
 Mon, 21 Dec 2020 23:54:18 -0800 (PST)
Date:   Mon, 21 Dec 2020 23:54:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2877f05b708e1a5@google.com>
Subject: WARNING: ODEBUG bug in ext4_fill_super (2)
From:   syzbot <syzbot+3002ac6b4fd242a64228@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, clang-built-linux@googlegroups.com,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0d52778b Add linux-next specific files for 20201218
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16190613500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c81cc44aa25b5b3
dashboard link: https://syzkaller.appspot.com/bug?extid=3002ac6b4fd242a64228
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128f5123500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f9f30f500000

The issue was bisected to:

commit e810c942a325cf749e859d7aa3a43dc219cea299
Author: Jan Kara <jack@suse.cz>
Date:   Wed Dec 16 10:18:40 2020 +0000

    ext4: save error info to sb through journal if available

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d9df07500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d9df07500000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d9df07500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3002ac6b4fd242a64228@syzkaller.appspotmail.com
Fixes: e810c942a325 ("ext4: save error info to sb through journal if available")

EXT4-fs error (device loop3): ext4_fill_super:4943: inode #2: comm syz-executor723: iget: root inode unallocated
EXT4-fs (loop3): get root inode failed
EXT4-fs (loop3): mount failed
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint: flush_stashed_error_work+0x0/0x2a0 fs/ext4/ext4.h:2040
WARNING: CPU: 0 PID: 13670 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 0 PID: 13670 Comm: syz-executor723 Not tainted 5.10.0-next-20201218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 20 af bf 89 4c 89 ee 48 c7 c7 20 a3 bf 89 e8 30 78 05 05 <0f> 0b 83 05 55 8a b9 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90001d0f9b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888024b63600 RSI: ffffffff815b95f5 RDI: fffff520003a1f29
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815b7a4b R11: 0000000000000000 R12: ffffffff896ae040
R13: ffffffff89bfa920 R14: ffffffff814911f0 R15: dffffc0000000000
FS:  000000000163a940(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000043fb60 CR3: 000000001226b000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __debug_check_no_obj_freed lib/debugobjects.c:987 [inline]
 debug_check_no_obj_freed+0x309/0x430 lib/debugobjects.c:1018
 slab_free_hook mm/slub.c:1540 [inline]
 slab_free_freelist_hook+0x12b/0x1d0 mm/slub.c:1586
 slab_free mm/slub.c:3157 [inline]
 kfree+0xdb/0x3c0 mm/slub.c:4156
 ext4_fill_super+0x86c/0xdf40 fs/ext4/super.c:5174
 mount_bdev+0x34d/0x410 fs/super.c:1366
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2896 [inline]
 path_mount+0x12ae/0x1e70 fs/namespace.c:3227
 do_mount fs/namespace.c:3240 [inline]
 __do_sys_mount fs/namespace.c:3448 [inline]
 __se_sys_mount fs/namespace.c:3425 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3425
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44873a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 cd a2 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 aa a2 fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fff16496da8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff16496e00 RCX: 000000000044873a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff16496dc0
RBP: 00007fff16496dc0 R08: 00007fff16496e00 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
R13: 0000000000000005 R14: 0000000000000004 R15: 0000000000000004


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
