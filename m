Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111902E0784
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 09:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgLVIy4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 03:54:56 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:45603 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLVIy4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 03:54:56 -0500
Received: by mail-io1-f70.google.com with SMTP id x7so7020382ion.12
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 00:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0rhtpZGCeqTji2dyuV97MK4dbm12jQx4Z2+0a5I3EOM=;
        b=tRKQV96F92KcqtH4Tv/rDgTAKBghDcgmPA7ttytdQKxexDPaZR1Qft4VmfxC1tEC6d
         dc2l3IfMSr43T86g2eEnjlIHVwXs97rwRoLl3+m3fhu/i/NH5h2fVk2lSYKwy3TI9mlO
         wEue5zS49d1K0wpZ6f6ZwQ1rlnIhHuCGVw7VnzREgGwVpBcDZwmCE3OyQ29SnBniijln
         5fTmiiuV2SlyA/FtkST8TwxgFtYKLkZFLPcnqRZqwWekvHGovhCUi2hIUfDvXjv5R2ec
         tWLygwc4qvqS6q9mn3Rhc5XnfEXrkyyrtwMD4ySrhpV1vNGUv/HDiOunxxSrcI4B1id0
         Z4tA==
X-Gm-Message-State: AOAM533zjp6Lp6H1cQYXG1sWH/UGW8d1ugwTbU+otZB5rMoWyHj6jA8k
        xOnw5JePj3Ca/+yaWL5qJ0g4f2nPSvaQEcGNKC8yJQg+u+M7
X-Google-Smtp-Source: ABdhPJyVVjcKkjRgLhzupAUnJLeUMVAcVsV9mDp4V/rlUpljQmKnUXUnevZ9gXUyPv7n//oRroo2HHvLXw2vTV3eI0XhFJGwiIKe
MIME-Version: 1.0
X-Received: by 2002:a92:cc03:: with SMTP id s3mr20709296ilp.146.1608627255224;
 Tue, 22 Dec 2020 00:54:15 -0800 (PST)
Date:   Tue, 22 Dec 2020 00:54:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001faff305b709b8ad@google.com>
Subject: general protection fault in ext4_commit_super
From:   syzbot <syzbot+9043030c040ce1849a60@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15b4aecb500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c81cc44aa25b5b3
dashboard link: https://syzkaller.appspot.com/bug?extid=9043030c040ce1849a60
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17983487500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c02937500000

The issue was bisected to:

commit e810c942a325cf749e859d7aa3a43dc219cea299
Author: Jan Kara <jack@suse.cz>
Date:   Wed Dec 16 10:18:40 2020 +0000

    ext4: save error info to sb through journal if available

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1282f137500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1182f137500000
console output: https://syzkaller.appspot.com/x/log.txt?x=1682f137500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9043030c040ce1849a60@syzkaller.appspotmail.com
Fixes: e810c942a325 ("ext4: save error info to sb through journal if available")

general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.10.0-next-20201218-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events flush_stashed_error_work
RIP: 0010:ext4_commit_super+0x52/0x510 fs/ext4/super.c:5548
Code: 48 c1 ea 03 80 3c 02 00 0f 85 21 04 00 00 48 8b 9d 78 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f1 03 00 00 48 8b 5b 60 48 85 db 0f 84 13 01 00
RSP: 0018:ffffc90000cc7cb8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000000c RSI: ffffffff8217a0db RDI: 0000000000000060
RBP: ffff88802441c000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8217a7fa R11: 0000000000000000 R12: ffff88802441c000
R13: ffff88802441c678 R14: ffff8880109a5a00 R15: ffff8880b9c34440
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 0000000014038000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 flush_stashed_error_work+0x1c9/0x2a0 fs/ext4/super.c:727
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Modules linked in:
---[ end trace dca7dc492b64f0a6 ]---
RIP: 0010:ext4_commit_super+0x52/0x510 fs/ext4/super.c:5548
Code: 48 c1 ea 03 80 3c 02 00 0f 85 21 04 00 00 48 8b 9d 78 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 60 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f1 03 00 00 48 8b 5b 60 48 85 db 0f 84 13 01 00
RSP: 0018:ffffc90000cc7cb8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000000c RSI: ffffffff8217a0db RDI: 0000000000000060
RBP: ffff88802441c000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8217a7fa R11: 0000000000000000 R12: ffff88802441c000
R13: ffff88802441c678 R14: ffff8880109a5a00 R15: ffff8880b9c34440
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 0000000025563000 CR4: 00000000001506f0
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
