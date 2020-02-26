Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2016F841
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZG5N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 01:57:13 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:47864 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgBZG5N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Feb 2020 01:57:13 -0500
Received: by mail-il1-f199.google.com with SMTP id k9so2001806ilq.14
        for <linux-ext4@vger.kernel.org>; Tue, 25 Feb 2020 22:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0A/aJuXil3fRC5ZrLYrxKglpBgEk4ru362RxrN9hh+E=;
        b=c/Xd3ZAoejL1If5l4snL8f80PsV7wNH+vDqv9ZwGemSo32eaUeWg9VTGCRuhA2NQ0M
         cdQ7ow3hZzNGNKWfRxe989hMQ/gEwT2/NAUNqkNFgEQqDCCP483kXKK94dluLG0sAlQF
         0596m5dZGIHfWOVLV7lFvE3ln4PGNX2Pix99dihzj7sRoC5AsZdjSUhTHjyBvQMG6fRI
         En3voDE6IDD2pRaRqIqyhKepaOXgkIWMg4DXr8SrogWxavbA3Y/yKFfL46seYTp3DM8x
         5PWQHwfoflrWvfS8RxOzoMKtVXCVF13bC8+Ww+ZkqOFRgK4M57Fjk1QAA2uEJOP2jW10
         /ZTQ==
X-Gm-Message-State: APjAAAXQdMFAiqZE5MANgcdXnKrnG07tseU+7Ye3i4dCBH35M2fNLUqd
        E2k/W17iCapaE+CuiMUpoG/bOLQJup+Kx6X4yUr/mQG+7coU
X-Google-Smtp-Source: APXvYqyV/rMRdskpKjSHWEFPaRIKm1VB0/+VtKT2u9fmyU+7gwY/A3JVWR+TPyIwdYf2cRV/mCpX0Zvuw0gq4/zlBtr7VtcV/5/V
MIME-Version: 1.0
X-Received: by 2002:a92:3f0f:: with SMTP id m15mr2916799ila.164.1582700231027;
 Tue, 25 Feb 2020 22:57:11 -0800 (PST)
Date:   Tue, 25 Feb 2020 22:57:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e7156059f751d7b@google.com>
Subject: WARNING in ext4_write_inode
From:   syzbot <syzbot+1f9dc49e8de2582d90c2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2eee258 Merge tag 'for-5.6-rc2-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1706127ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e57a6b450fb9883
dashboard link: https://syzkaller.appspot.com/bug?extid=1f9dc49e8de2582d90c2
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f9dc49e8de2582d90c2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2697 at fs/ext4/inode.c:5097 ext4_write_inode+0x4eb/0x5b0 fs/ext4/inode.c:5097
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 2697 Comm: xfsaild/loop1 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 panic+0x264/0x7a9 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1b6/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 do_error_trap+0xcf/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:ext4_write_inode+0x4eb/0x5b0 fs/ext4/inode.c:5097
Code: 65 48 8b 04 25 28 00 00 00 48 3b 45 d0 0f 85 d2 00 00 00 44 89 f8 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 d5 37 72 ff <0f> 0b eb d2 e8 cc 37 72 ff 41 bf fb ff ff ff eb c5 89 d9 80 e1 07
RSP: 0018:ffffc90001b97700 EFLAGS: 00010293
RAX: ffffffff8204d1ab RBX: 0000000000000800 RCX: ffff888049612580
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000000
RBP: ffffc90001b97760 R08: ffffffff8204cd2e R09: ffffed1015d47004
R10: ffffed1015d47004 R11: 0000000000000000 R12: ffff88809229e588
R13: ffff888049612580 R14: 0000000000200844 R15: 0000000000000000
 write_inode fs/fs-writeback.c:1312 [inline]
 __writeback_single_inode+0x550/0x620 fs/fs-writeback.c:1511
 writeback_single_inode+0x3b9/0x800 fs/fs-writeback.c:1565
 sync_inode fs/fs-writeback.c:2602 [inline]
 sync_inode_metadata+0x7a/0xc0 fs/fs-writeback.c:2622
 ext4_fsync_nojournal fs/ext4/fsync.c:94 [inline]
 ext4_sync_file+0x4c9/0x890 fs/ext4/fsync.c:172
 vfs_fsync_range+0xfd/0x1a0 fs/sync.c:197
 generic_write_sync include/linux/fs.h:2867 [inline]
 ext4_buffered_write_iter+0x520/0x5c0 fs/ext4/file.c:277
 ext4_file_write_iter+0xb06/0x1810 include/linux/fs.h:796
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write fs/read_write.c:483 [inline]
 __vfs_write+0x5a1/0x740 fs/read_write.c:496
 __kernel_write+0x11d/0x350 fs/read_write.c:515
 do_acct_process+0xf9c/0x1390 kernel/acct.c:522
 slow_acct_process kernel/acct.c:581 [inline]
 acct_process+0x478/0x590 kernel/acct.c:607
 do_exit+0x580/0x2000 kernel/exit.c:791
 kthread+0x350/0x350 kernel/kthread.c:257
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
