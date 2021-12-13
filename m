Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE747348E
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Dec 2021 20:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbhLMTBa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Dec 2021 14:01:30 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:42889 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbhLMTB3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Dec 2021 14:01:29 -0500
Received: by mail-il1-f197.google.com with SMTP id 11-20020a056e0220cb00b002ac12986811so2418417ilq.9
        for <linux-ext4@vger.kernel.org>; Mon, 13 Dec 2021 11:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IjOBdkaNIK6gC+Baxtp5WU85YNW/1FamwWergs9nsxY=;
        b=ZP5ER69FZhhM6gfQy9odpc2j4/4ve3V/j3LdumJfNBYFMPTDi8fC0XYgMn91GU/Nc2
         sgMLcEQZaC0Z0JGaB3+PmBgCyhod7OT8+S88BsloR10FtsqK9N+uqbtm61c6jC0438CN
         +Cn3Is48Tvw3pNI7B8LtI3vNXOljS4oBVunwr5PPI9m4sKVEgfPPBNvVgG6qXRxiCjFb
         1F7mrB9hJdvYpRSdcM5KBFrC+b6NTEubyY9y5j7eYcbTUbsBWjW5Yh/MqEL46Lum7knF
         fZqQNy2ra7oDp56YLcyeaCdOhoCbs7bkIkXgrVz8P5OZN8dMiDxKSNyZEY+PNmRlMTRH
         UQwA==
X-Gm-Message-State: AOAM530Hxs6Ewd74pDWJPe1dOi6H//QgoyrGOWU1Kfz0IGk0bsOe0Y7b
        erYZXeDCJRA7jCuuE9C90NWa223ukXaix5Re+zmQBiL6zIU0
X-Google-Smtp-Source: ABdhPJxgvZINxtvZccOmSP4U13GjBQFYuKlwNhuEsoD8rG7od8JO30mcJ3PVxU7vdhF0UbMi5LnQ0TLLOaZCZ6t7zhU0zMqr9Xp3
MIME-Version: 1.0
X-Received: by 2002:a05:6638:359f:: with SMTP id v31mr101712jal.230.1639422088976;
 Mon, 13 Dec 2021 11:01:28 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:01:28 -0800
In-Reply-To: <0000000000004c915205b1a04ad9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040225805d30bb3a8@google.com>
Subject: Re: [syzbot] kernel BUG at fs/ext4/inline.c:LINE!
From:   syzbot <syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    2585cf9dfaad Linux 5.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1034be69b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44af4fa322f7642f
dashboard link: https://syzkaller.appspot.com/bug?extid=4faa160fa96bfba639f8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148458d1b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f6169b00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119be2ab900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139be2ab900000
console output: https://syzkaller.appspot.com/x/log.txt?x=159be2ab900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:755!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3633 Comm: syz-executor843 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_write_inline_data_end+0xa11/0x1120 fs/ext4/inline.c:755
Code: 01 44 89 f6 e8 40 dc 67 ff 41 83 fe 01 0f 87 2a fb ff ff e8 11 da 67 ff 4c 89 e7 e8 79 fe 90 ff e9 9e fb ff ff e8 ff d9 67 ff <0f> 0b e8 f8 d9 67 ff 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc9000281f3a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888076750000 RSI: ffffffff820fd161 RDI: 0000000000000003
RBP: ffff8880737a5c58 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff820fc907 R11: 0000000000000000 R12: ffffea0001f0d640
R13: 0000000000000001 R14: ffff8880737a5a08 R15: ffffc9000281f400
FS:  00007f57f9ace700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c0556fbf48 CR3: 000000007a16f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_end+0x200/0xcf0 fs/ext4/inode.c:1292
 ext4_da_write_end+0x375/0x990 fs/ext4/inode.c:3026
 generic_perform_write+0x2c6/0x510 mm/filemap.c:3765
 ext4_buffered_write_iter+0x1ac/0x3b0 fs/ext4/file.c:269
 ext4_file_write_iter+0x423/0x14e0 fs/ext4/file.c:681
 call_write_iter include/linux/fs.h:2162 [inline]
 do_iter_readv_writev+0x472/0x750 fs/read_write.c:725
 do_iter_write+0x188/0x710 fs/read_write.c:851
 vfs_iter_write+0x70/0xa0 fs/read_write.c:892
 iter_file_splice_write+0x723/0xc70 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0xaf2/0x1250 fs/read_write.c:1245
 __do_sys_sendfile64 fs/read_write.c:1310 [inline]
 __se_sys_sendfile64 fs/read_write.c:1296 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1296
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f57f9b21de9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f57f9ace2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f57f9ba74c0 RCX: 00007f57f9b21de9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007f57f9b740cc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007f57f9b730c8 R14: 0000000300000002 R15: 00007f57f9ba74c8
 </TASK>
Modules linked in:
---[ end trace e6a45f74f6d725ce ]---
RIP: 0010:ext4_write_inline_data_end+0xa11/0x1120 fs/ext4/inline.c:755
Code: 01 44 89 f6 e8 40 dc 67 ff 41 83 fe 01 0f 87 2a fb ff ff e8 11 da 67 ff 4c 89 e7 e8 79 fe 90 ff e9 9e fb ff ff e8 ff d9 67 ff <0f> 0b e8 f8 d9 67 ff 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc9000281f3a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888076750000 RSI: ffffffff820fd161 RDI: 0000000000000003
RBP: ffff8880737a5c58 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff820fc907 R11: 0000000000000000 R12: ffffea0001f0d640
R13: 0000000000000001 R14: ffff8880737a5a08 R15: ffffc9000281f400
FS:  00007f57f9ace700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57f9aad718 CR3: 000000007a16f000 CR4: 0000000000350ef0

