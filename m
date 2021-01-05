Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4012EA584
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 07:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbhAEGj4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 01:39:56 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44092 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbhAEGjz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 01:39:55 -0500
Received: by mail-io1-f72.google.com with SMTP id a1so13334014ioa.11
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jan 2021 22:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=07g5Su3wVkEtBIc4bVk48l6HEb0Q5sYjwp4ioRKi5hU=;
        b=I42Ng973ns3P+501RfoNEiQaHXuLmRkrkVA1PENravAVInk4knajmYYr3hi8tBWuJS
         pXFSLuB8kwoyg5/Ei6bt+3quWCGFSQhEWEkz7DsRlzSF6pWvBr9kv1Xh7jm0m6h0UxFX
         eUea/9PL1O3laIq/IEhiphqpGdnWEcLmiHaTtXyH2F+AvI7di0ZOp5+CyGIZSGw84nE8
         RDNpVX8kJRZBFZXgjC9eRwveCJAorqY9huVYBBbgZPwKlcdiDTNJLgiW1LNidVvuIjLF
         4seBe7LHxxdMV628zbPN0DwlLmynQxuTR6t7OvD2MzstbzBF02XcN8i9dUA8OQoOuJgk
         yAcA==
X-Gm-Message-State: AOAM532NFKHkvpZk4BJ5/bNRV0Lk2Aadr42dRYjeBHEUOgmyxtlQUI48
        RTsl9inX5aefU1HcxpgGzgHSGrDh/RFCZz43R+YplUhxJmyX
X-Google-Smtp-Source: ABdhPJx6D4Y5MFZZgTa+u1b2RKy1Qkv6OSZnadFTIxD+EgipGtewdV8XpNS0QheuDtwOGODD8lKq/sWaHb64Z+MiK2fBR111gudL
MIME-Version: 1.0
X-Received: by 2002:a92:c986:: with SMTP id y6mr51391451iln.57.1609828754796;
 Mon, 04 Jan 2021 22:39:14 -0800 (PST)
Date:   Mon, 04 Jan 2021 22:39:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014357e05b82177c8@google.com>
Subject: kernel BUG at fs/ext4/ext4.h:LINE!
From:   syzbot <syzbot+b2947dd3e8c72dbe609b@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f6e1ea19 Merge tag 'ceph-for-5.11-rc2' of git://github.com..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1364b1a3500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2455d075a1c4afa8
dashboard link: https://syzkaller.appspot.com/bug?extid=b2947dd3e8c72dbe609b
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2947dd3e8c72dbe609b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/ext4.h:3221!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 12285 Comm: syz-executor.5 Not tainted 5.11.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_get_group_info fs/ext4/ext4.h:3221 [inline]
RIP: 0010:ext4_get_group_info+0x340/0x3a0 fs/ext4/ext4.h:3216
Code: ff 48 c7 c2 c0 03 5f 89 be 83 02 00 00 48 c7 c7 a0 ff 5e 89 c6 05 6c 40 d2 0a 01 e8 f9 59 aa 06 e9 e4 fd ff ff e8 20 9e 69 ff <0f> 0b e8 c9 31 ac ff e9 16 fd ff ff e8 bf 31 ac ff e9 50 fd ff ff
RSP: 0018:ffffc90002ddfc58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffff75e0 RCX: 0000000000000000
RDX: ffff88806a563780 RSI: ffffffff8208d670 RDI: 0000000000000003
RBP: ffff888021ef0000 R08: 0000000000000010 R09: 0000000000000000
R10: ffffffff8208d3a0 R11: 0000000000000000 R12: ffff888021eee000
R13: 0000000000000010 R14: ffff888021eee678 R15: ffffc90002ddfd60
FS:  0000000002296940(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005643b7305d18 CR3: 000000002b612000 CR4: 0000000000350ee0
Call Trace:
 ext4_mb_load_buddy_gfp+0xc6/0x1350 fs/ext4/mballoc.c:1156
 ext4_discard_preallocations+0x8c6/0xea0 fs/ext4/mballoc.c:4400
 ext4_release_file+0x2f0/0x370 fs/ext4/file.c:150
 __fput+0x283/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x190 kernel/task_work.c:140
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x417b71
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 1a 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffe30828230 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000417b71
RDX: 0000000000000000 RSI: ffffffff88edf75e RDI: 0000000000000004
RBP: 0000000000000001 R08: ffffffff8128f848 R09: 0000000006ccd617
R10: 00007ffe30828310 R11: 0000000000000293 R12: 000000000119ca00
R13: 000000000119ca00 R14: 00000000000003e8 R15: 000000000119c0dc
Modules linked in:
---[ end trace 321f8951b9d369a1 ]---
RIP: 0010:ext4_get_group_info fs/ext4/ext4.h:3221 [inline]
RIP: 0010:ext4_get_group_info+0x340/0x3a0 fs/ext4/ext4.h:3216
Code: ff 48 c7 c2 c0 03 5f 89 be 83 02 00 00 48 c7 c7 a0 ff 5e 89 c6 05 6c 40 d2 0a 01 e8 f9 59 aa 06 e9 e4 fd ff ff e8 20 9e 69 ff <0f> 0b e8 c9 31 ac ff e9 16 fd ff ff e8 bf 31 ac ff e9 50 fd ff ff
RSP: 0018:ffffc90002ddfc58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffff75e0 RCX: 0000000000000000
RDX: ffff88806a563780 RSI: ffffffff8208d670 RDI: 0000000000000003
RBP: ffff888021ef0000 R08: 0000000000000010 R09: 0000000000000000
R10: ffffffff8208d3a0 R11: 0000000000000000 R12: ffff888021eee000
R13: 0000000000000010 R14: ffff888021eee678 R15: ffffc90002ddfd60
FS:  0000000002296940(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
