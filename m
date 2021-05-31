Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC23955DB
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhEaHRH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 May 2021 03:17:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:57043 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhEaHRD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 May 2021 03:17:03 -0400
Received: by mail-il1-f198.google.com with SMTP id 15-20020a920d0f0000b02901c54acae19eso7499099iln.23
        for <linux-ext4@vger.kernel.org>; Mon, 31 May 2021 00:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e3Sg/yJ7v/ElwEk3fKaKRKfCBKmAt77OVg5N6lZHBCk=;
        b=eOgNUhX2NDgH46YZlZ56S8qykY6KaFtuvooDdHw2p+42ZH13VxEpRwgGL/Fre3dqey
         7hXUcAx1+mg6cVKjPy+yqkfmREDudLhRy5DtYDAUD4jOxVNUFpnOECBiypoKYBlSDBBe
         MBGGoPR7/6LxFn+VArLwSaOSWpr4utg5zKTfKx05giuaugJLmbiQhsbMe8k/B/53KWZt
         c7iiYuwEPEQyaUr7O66jAyO3maFsluyyveW1pveYXGmvGHINknCgqmV4KfbO9CdNCrfW
         2eqWfpVq2zKPTJe1jYZ50uP3fOuV4rSJpRJAf2wCOWXZ4EzJTL5xwVS5FCnAtqWq+p3M
         tFyg==
X-Gm-Message-State: AOAM533PpvB3xR3QUD6TYjAfyP88yaWDgArqgEH9brkVismUz4iivMC9
        9G959ctlQ4UoVn+uB5UrUU/PKEXak/x9Wk1/vevYDJy4SCFc
X-Google-Smtp-Source: ABdhPJxxZhkxNLcjNI8DC0mUwoGbXnvplZ8lbg0+HFDnFJuWBjEYQMemL0uNKiOkQkszbCNWy0WKeHY0xVkFDkFjZYhyMQ9IqkNm
MIME-Version: 1.0
X-Received: by 2002:a92:dd89:: with SMTP id g9mr16787097iln.209.1622445324258;
 Mon, 31 May 2021 00:15:24 -0700 (PDT)
Date:   Mon, 31 May 2021 00:15:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003853da05c39afd00@google.com>
Subject: [syzbot] kernel BUG in mpage_prepare_extent_to_map
From:   syzbot <syzbot+99043e2052d9c50c81fc@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d276efd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f3da44a01882e99
dashboard link: https://syzkaller.appspot.com/bug?extid=99043e2052d9c50c81fc

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99043e2052d9c50c81fc@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:2625!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1259 Comm: kworker/u17:7 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: writeback wb_workfn
 (flush-8:0)
RIP: 0010:mpage_prepare_extent_to_map+0xb69/0xe20 fs/ext4/inode.c:2625
Code: 8d 5d ff e9 46 fc ff ff e8 d4 02 69 ff 0f 0b e8 cd 02 69 ff 48 c7 c6 80 75 7f 89 4c 89 ef e8 ae 23 9b ff 0f 0b e8 b7 02 69 ff <0f> 0b 45 31 ff e8 ad 02 69 ff 0f b6 9c 24 b8 00 00 00 31 ff 89 de
RSP: 0000:ffffc90004467238 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000000
RDX: ffff888016d3c240 RSI: ffffffff820b0ae9 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff820b0874 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffea00015cf440 R14: ffffc900044675c8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd171e3e73f CR3: 0000000045f64000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ext4_writepages+0x941/0x3b70 fs/ext4/inode.c:2754
 do_writepages+0xec/0x290 mm/page-writeback.c:2352
 __writeback_single_inode+0x126/0xfd0 fs/fs-writeback.c:1467
 writeback_sb_inodes+0x53d/0xef0 fs/fs-writeback.c:1732
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1801
 wb_writeback+0x814/0xc40 fs/fs-writeback.c:1907
 wb_check_start_all fs/fs-writeback.c:2031 [inline]
 wb_do_writeback fs/fs-writeback.c:2057 [inline]
 wb_workfn+0xb98/0x12d0 fs/fs-writeback.c:2091
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
