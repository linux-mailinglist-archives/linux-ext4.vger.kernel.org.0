Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA728E032
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Oct 2020 14:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbgJNMBc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Oct 2020 08:01:32 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49708 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgJNMBZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Oct 2020 08:01:25 -0400
Received: by mail-io1-f72.google.com with SMTP id 140so2200395iou.16
        for <linux-ext4@vger.kernel.org>; Wed, 14 Oct 2020 05:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZGmoUCQTBwcfTzJTKLBkFcLOoqsmH7knjcMRgLLkdAY=;
        b=smCWQvpvdfpgKqYDxjnMz6iXB+YYgI2h9UfP1auHyl6XW8cq7lOaQX72CnvUjRFRGT
         /EsLNA7XPvceFwWJOkZXq1SgDJT2KvJ1TZ3oPyPbEUHxQpB3gqFazyJ9tqDRjzZdLnXO
         lVi803yMRRioTxoi2xsrhZrrSTto8+fhIpHnCYuMgQy5gJ4xv5h7mGTQsoPF1uDzSXt4
         QTsCDiNuPKVbeTCkyD+OP4MGjUqulobL0ooBFdo4FWAi/fKKyIIv9y+VbhklN+66buLu
         j8VavETH8XA+XUe/T+rJARWrMdKBXLyxLwXzfyAinTNuAarwvAc1TJD121XzVs9GbEoo
         Cpvg==
X-Gm-Message-State: AOAM531vO+yMIHHw7DUmNcQcSLgS647nJelDCguUtGj3AFz7KaNbYQrE
        wQSDWM3+D41gNvcalZ6mJn9KMl886TPmK4XgacUPjkmZa70h
X-Google-Smtp-Source: ABdhPJwLTnWEMK56bpSTTTT2Y/Z83v27f7qFguMx1gFSH3ledP9Tc2B9T2u86rFS5NIM9Q5rc4t+0aOGOlAtn/Xv4+OO2czBljMW
MIME-Version: 1.0
X-Received: by 2002:a92:c986:: with SMTP id y6mr3480273iln.10.1602676882967;
 Wed, 14 Oct 2020 05:01:22 -0700 (PDT)
Date:   Wed, 14 Oct 2020 05:01:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c915205b1a04ad9@google.com>
Subject: kernel BUG at fs/ext4/inline.c:LINE!
From:   syzbot <syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6f2f486d Merge tag 'spi-fix-v5.9-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a89478500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=4faa160fa96bfba639f8
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a0a8b900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119be2ab900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139be2ab900000
console output: https://syzkaller.appspot.com/x/log.txt?x=159be2ab900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:751!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23920 Comm: syz-executor.3 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_write_inline_data_end+0x847/0x880 fs/ext4/ext4.h:3341
Code: 38 c1 0f 8c 06 fc ff ff 4c 89 e7 e8 d3 ac b2 ff e9 f9 fb ff ff 48 ff cd 48 89 eb e9 69 fe ff ff e8 4e a5 49 06 e8 e9 c7 72 ff <0f> 0b e8 e2 c7 72 ff 0f 0b e8 db c7 72 ff 0f 0b e8 d4 c7 72 ff 0f
RSP: 0018:ffffc90005077940 EFLAGS: 00010293
RAX: ffffffff82023607 RBX: 0000000c00000000 RCX: ffff8880a6718140
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82022f07 R09: ffffed100ead147b
R10: ffffed100ead147b R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807568a5b8 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007faa624ff700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6db9e8bdb8 CR3: 000000009d643000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ext4_write_end+0x225/0xef0 fs/ext4/inode.c:1274
 generic_perform_write+0x344/0x4e0 mm/filemap.c:3516
 ext4_buffered_write_iter+0x44d/0x5d0 fs/ext4/file.c:269
 ext4_file_write_iter+0x891/0x19b0 include/linux/fs.h:784
 do_iter_readv_writev+0x4f9/0x6c0 include/linux/fs.h:1876
 do_iter_write+0x164/0x610 fs/read_write.c:1026
 vfs_writev fs/read_write.c:1099 [inline]
 do_pwritev+0x234/0x430 fs/read_write.c:1196
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45de59
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007faa624fec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 0000000000026400 RCX: 000000000045de59
RDX: 0000000000000001 RSI: 00000000200014c0 RDI: 0000000000000006
RBP: 000000000118c018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
R13: 00007ffc849922ef R14: 00007faa624ff9c0 R15: 000000000118bfd4
Modules linked in:
---[ end trace 636f601b36ee58e9 ]---
RIP: 0010:ext4_write_inline_data_end+0x847/0x880 fs/ext4/ext4.h:3341
Code: 38 c1 0f 8c 06 fc ff ff 4c 89 e7 e8 d3 ac b2 ff e9 f9 fb ff ff 48 ff cd 48 89 eb e9 69 fe ff ff e8 4e a5 49 06 e8 e9 c7 72 ff <0f> 0b e8 e2 c7 72 ff 0f 0b e8 db c7 72 ff 0f 0b e8 d4 c7 72 ff 0f
RSP: 0018:ffffc90005077940 EFLAGS: 00010293
RAX: ffffffff82023607 RBX: 0000000c00000000 RCX: ffff8880a6718140
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82022f07 R09: ffffed100ead147b
R10: ffffed100ead147b R11: 0000000000000000 R12: 0000000000000000
R13: ffff88807568a5b8 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007faa624ff700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000118c000 CR3: 000000009d643000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
