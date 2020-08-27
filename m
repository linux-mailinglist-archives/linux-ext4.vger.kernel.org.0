Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9CB253BF6
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Aug 2020 04:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgH0CsR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Aug 2020 22:48:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:42314 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0CsR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Aug 2020 22:48:17 -0400
Received: by mail-il1-f198.google.com with SMTP id f67so506346ilf.9
        for <linux-ext4@vger.kernel.org>; Wed, 26 Aug 2020 19:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2UFQjLFbMkws7Mzxk49K5HdYI7gIOD5cuAkyrXQPUF0=;
        b=JElN3quke0mjFq11l/yiDizL8sBcR1gX8AQfDa0hXnbZfhCJayws+jItceVlAuDpEq
         4lu0Edb7MTJViCp/+wAF4fsGYQxKrACk/1v81z4nU90vjiPIu/G3+wTJNU3RZwSXIqXZ
         NWxdvBbqgHhExP1OmkkW5q5xufDwuuOkiV1sQIuw3f4eUL6RIe88EazyihTstbHvZ21P
         QLWNvk5Zef+Vrn80ZubGWiHHpp7zUKsuvwDhJwlw7TtAdFQiufMKIF3M2JaukhwcGDch
         RP0TfK0pTmdJO2yMOFgJiiDYlScppST6wA4ZjTZWHkDLBM1X1NW4AZmcLy8f0KW5kCV7
         N/Bg==
X-Gm-Message-State: AOAM533udh4Cm5gEKn64LyOa9Uj1OjqBW1oDwo1UntSWc9RXP0XFcVq+
        pmQUdcq+peybDZyq0le3JB71itjRLpJXvoUt1yCo5P20x2BY
X-Google-Smtp-Source: ABdhPJw9zYRpb1Fe2uEASqEaOoYoZWdCeQkFeJ79llzNTG1g9VQDsQbKXLHbKqhO1aQgUxJsG9yW50qogBXETPGaHvMKEke91pLn
MIME-Version: 1.0
X-Received: by 2002:a02:9149:: with SMTP id b9mr17429709jag.50.1598496496131;
 Wed, 26 Aug 2020 19:48:16 -0700 (PDT)
Date:   Wed, 26 Aug 2020 19:48:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3a33205add2f7b2@google.com>
Subject: kernel BUG at fs/ext4/inode.c:LINE!
From:   syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f83cb6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
dashboard link: https://syzkaller.appspot.com/bug?extid=3622cea378100f45d59f
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287ac96900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c7ac46900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:2598!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 27612 Comm: syz-executor879 Not tainted 5.9.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mpage_prepare_extent_to_map+0xd34/0xd40 fs/ext4/inode.c:2598
Code: 89 e8 a0 74 9f ff 0f 0b e8 59 81 70 ff 4c 89 e7 48 c7 c6 da a3 07 89 e8 8a 74 9f ff 0f 0b e8 43 81 70 ff 0f 0b e8 3c 81 70 ff <0f> 0b e8 c5 b3 25 06 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53
RSP: 0018:ffffc9000a0974d8 EFLAGS: 00010293
RAX: ffffffff820476e4 RBX: 00fffe000000a01f RCX: ffff88808ea5c340
RDX: 0000000000000000 RSI: 000000000000a01f RDI: 000000000000ffff
RBP: ffffea00020d4f80 R08: ffffffff820471e4 R09: fffff9400041a9f1
R10: fffff9400041a9f1 R11: 0000000000000000 R12: ffffea00020d4f80
R13: ffffc9000a0977b0 R14: 1ffffd400041a9f1 R15: dffffc0000000000
FS:  00007f5055f25700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004ae4b0 CR3: 00000000a2d7f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ext4_writepages+0xa98/0x3750 fs/ext4/inode.c:2735
 do_writepages+0xda/0x1f0 mm/page-writeback.c:2352
 __filemap_fdatawrite_range+0x2a5/0x350 mm/filemap.c:422
 filemap_write_and_wait_range+0xca/0x160 mm/filemap.c:655
 iomap_dio_rw+0x5a7/0xeb0 fs/iomap/direct-io.c:478
 ext4_dio_read_iter fs/ext4/file.c:77 [inline]
 ext4_file_read_iter+0x544/0x6d0 fs/ext4/file.c:129
 call_read_iter include/linux/fs.h:1876 [inline]
 generic_file_splice_read+0x3c5/0x640 fs/splice.c:312
 do_splice_to fs/splice.c:870 [inline]
 splice_direct_to_actor+0x3bd/0xb60 fs/splice.c:950
 do_splice_direct+0x201/0x340 fs/splice.c:1059
 do_sendfile+0x86d/0x1210 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1601 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1587
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x448bc9
Code: e8 1c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5055f24ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006e4a28 RCX: 0000000000448bc9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00000000006e4a20 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffb R11: 0000000000000246 R12: 00000000006e4a2c
R13: 00007ffdc73a76df R14: 00007f5055f259c0 R15: 20c49ba5e353f7cf
Modules linked in:
---[ end trace aba5fca59eda2183 ]---
RIP: 0010:mpage_prepare_extent_to_map+0xd34/0xd40 fs/ext4/inode.c:2598
Code: 89 e8 a0 74 9f ff 0f 0b e8 59 81 70 ff 4c 89 e7 48 c7 c6 da a3 07 89 e8 8a 74 9f ff 0f 0b e8 43 81 70 ff 0f 0b e8 3c 81 70 ff <0f> 0b e8 c5 b3 25 06 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54 53
RSP: 0018:ffffc9000a0974d8 EFLAGS: 00010293
RAX: ffffffff820476e4 RBX: 00fffe000000a01f RCX: ffff88808ea5c340
RDX: 0000000000000000 RSI: 000000000000a01f RDI: 000000000000ffff
RBP: ffffea00020d4f80 R08: ffffffff820471e4 R09: fffff9400041a9f1
R10: fffff9400041a9f1 R11: 0000000000000000 R12: ffffea00020d4f80
R13: ffffc9000a0977b0 R14: 1ffffd400041a9f1 R15: dffffc0000000000
FS:  00007f5055f25700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004ae4b0 CR3: 00000000a2d7f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
