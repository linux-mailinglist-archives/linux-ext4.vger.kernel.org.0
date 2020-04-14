Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B551A7369
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 08:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405810AbgDNGLP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Apr 2020 02:11:15 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48124 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405711AbgDNGLO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Apr 2020 02:11:14 -0400
Received: by mail-io1-f71.google.com with SMTP id v23so7654402ioj.14
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 23:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dp9g8mlqS21tA+hBIwuqpfDgBMUNKPQT3364Pmoe6Xg=;
        b=QuAPqcM4ZEi1Y++EFw+kd9KeQEfy1LCNu7pq+/OPmJe1Y13W+pKLytXygRtX/EWONH
         XAmCBhXjixsQvPI6JlPRXKw5qx2J1WOIT88R81H/PcUvKH05qPdn+u9L+gUCxSek6B8f
         UtuwVW5LUHuW8wk442CDd3+u/SOdiX1wpiKNX5Ii5e+GHNaEFnbY4I7adNsgGD+30Uo1
         p7hpOYtR5KsBWlZrz4ETtxfXSdNfbwUVmwJA3H3cvStYWZLgL1fAvfC9xE2x4bVmRRv7
         Je4E3KA9/uVcRw+AG63X9BpEvJhSiquTIhZRcRSS/JOWso6zyCHeooK4t7TrhdQGGawD
         ug6A==
X-Gm-Message-State: AGi0PubwxJ8L/7huH6xHHQKk/9p8IcgaL5UbAIp8Rc2VWh3qNF/z21ix
        VP2VynxJ1p33PTf+uqSXKktIRgawTFM5afvwGpM3IEC1sBDe
X-Google-Smtp-Source: APiQypLnMVdq7JazadG+OQhVzEsxasIx/tZprsNZoX/Tool6HxzlBwDWKvTR8XTuH3OilK6Kub914d0aNNbq9wBombWdE0DZD2oB
MIME-Version: 1.0
X-Received: by 2002:a6b:3111:: with SMTP id j17mr20228883ioa.17.1586844673678;
 Mon, 13 Apr 2020 23:11:13 -0700 (PDT)
Date:   Mon, 13 Apr 2020 23:11:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016a67305a33a11f7@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in
 generic_perform_write (2)
From:   syzbot <syzbot+bca9799bf129256190da@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5b8b9d0c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13507b43e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c5a352e32a1944
dashboard link: https://syzkaller.appspot.com/bug?extid=bca9799bf129256190da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1620c007e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117f975de00000

The bug was bisected to:

commit 5f0663bb4a64f588f0a2dd6d1be68d40f9af0086
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Thu Dec 21 20:25:11 2017 +0000

    ext4, dax: introduce ext4_dax_aops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11046b5de00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13046b5de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15046b5de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 86de7067 P4D 86de7067 PUD 8eb7e067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8522 Comm: syz-executor124 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90004707a38 EFLAGS: 00010246
RAX: ffffffff883cb0a0 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff8880880c68e0 RDI: ffff888098a0c300
RBP: ffff8880880c68e0 R08: 0000000000000000 R09: ffffc90004707ac0
R10: ffff88808ddee607 R11: ffffed1011bbdcc0 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90004707d18
FS:  00007ff4c6fcc700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000086de6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 generic_perform_write+0x20a/0x4e0 mm/filemap.c:3302
 ext4_buffered_write_iter+0x1f7/0x450 fs/ext4/file.c:270
 ext4_file_write_iter+0x1ec/0x13f0 fs/ext4/file.c:642
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write+0x4a2/0x700 fs/read_write.c:484
 __vfs_write+0xc9/0x100 fs/read_write.c:497
 vfs_write+0x268/0x5d0 fs/read_write.c:559
 ksys_write+0x12d/0x250 fs/read_write.c:612
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x44ecf9
Code: bd ca fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b ca fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff4c6fcbce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006e79e8 RCX: 000000000044ecf9
RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006e79e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e79ec
R13: 00007ffce52c26cf R14: 00007ff4c6fcc9c0 R15: 0000000000000000
Modules linked in:
CR2: 0000000000000000
---[ end trace a03cde52885aaa2a ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90004707a38 EFLAGS: 00010246
RAX: ffffffff883cb0a0 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffff8880880c68e0 RDI: ffff888098a0c300
RBP: ffff8880880c68e0 R08: 0000000000000000 R09: ffffc90004707ac0
R10: ffff88808ddee607 R11: ffffed1011bbdcc0 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90004707d18
FS:  00007ff4c6fcc700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff4c6f89db8 CR3: 0000000086de6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
