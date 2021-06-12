Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C683A5111
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jun 2021 23:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhFLV5j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Jun 2021 17:57:39 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35817 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLV5i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Jun 2021 17:57:38 -0400
Received: by mail-io1-f71.google.com with SMTP id q196-20020a6b8ecd0000b02904cdb284c06bso3729274iod.2
        for <linux-ext4@vger.kernel.org>; Sat, 12 Jun 2021 14:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JvW3AZLZ5AU0AeVEQLVMqJQnd1D3HCg+m7PNitgUroM=;
        b=oLPxotoS4JsMIjFBRQUkt3V7uS5YG2nZ6i9wsOyJAmjdGl9fBrBW/Wr8QPKuujX93F
         ABmzaargJm2kF/vX5qNKPtHhTZbyXKHtpr83FkzDs2488HY74+UXQ2PJfeLYB/hmivHX
         0n6hsIxTahqXrGwpPN4U1HTpu7cjB5QA/K8vEWUd2ZjuDNmxwCy4v3XHL2wf1kQxZMlM
         BBOCWTnaleSgqhrU7ul6Dluj9DbVmYszno2dfsx31RP9q7HUYFqpKpHAd7koRUY6gz58
         7pUGzobgVO1e3IEJc6EKSjWghhAN8DF/XvT7/9zuOcyERMCqoxEYymX5EynFlHwBELeo
         TWfQ==
X-Gm-Message-State: AOAM532Z3dKRZDW4WiLKSii7JIrYNJ34OcB1xdovDZm3KK/Ey+3+8E14
        8OUfxkprXHk0gMQ6AnhLaAcYKfzpBVKMdKeNZr8PrFS+ayKw
X-Google-Smtp-Source: ABdhPJxNWr/Wn2tHOO2mB6LLlN2OjW+gCFbH9DQt3FSPTw+LzePWeA3imaEKyodEkCq1yzO/L4Lvs6h4jl9qh6qM+lNBmGGAqgP5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3393:: with SMTP id h19mr10392817jav.0.1623534922684;
 Sat, 12 Jun 2021 14:55:22 -0700 (PDT)
Date:   Sat, 12 Jun 2021 14:55:22 -0700
In-Reply-To: <0000000000003853da05c39afd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058deb505c498ae70@google.com>
Subject: Re: [syzbot] kernel BUG in mpage_prepare_extent_to_map
From:   syzbot <syzbot+99043e2052d9c50c81fc@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ad347abe Merge tag 'trace-v5.13-rc5-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16223e3fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
dashboard link: https://syzkaller.appspot.com/bug?extid=99043e2052d9c50c81fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1204231fd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1324e4d0300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99043e2052d9c50c81fc@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue. Quota mode: none.
------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:2704!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8394 Comm: syz-executor475 Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_writepages+0x244d/0x3b70 fs/ext4/inode.c:2704
Code: e1 be 00 10 00 00 4c 89 ef 48 d3 ee ba 01 00 00 00 e8 57 23 fe ff 83 c0 01 89 84 24 bc 00 00 00 e9 2d e2 ff ff e8 73 d5 66 ff <0f> 0b e8 6c d5 66 ff 44 0f b6 a4 24 db 00 00 00 89 5c 24 08 e9 a7
RSP: 0018:ffffc900019ff580 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801cad54c0 RSI: ffffffff820e071d RDI: 0000000000000003
RBP: ffff888035bc5a08 R08: 0000000000000000 R09: ffff888035bc5a0f
R10: ffffffff820dfbf3 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888035bc5cf0 R14: ffffc900019ffa08 R15: ffff88801d9ea000
FS:  0000000000865300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff50003d188 CR3: 000000002e66c000 CR4: 0000000000350ee0
Call Trace:
 do_writepages+0xec/0x290 mm/page-writeback.c:2352
 __filemap_fdatawrite_range+0x2a5/0x390 mm/filemap.c:413
 file_write_and_wait_range+0xb2/0x120 mm/filemap.c:792
 ext4_sync_file+0x21f/0xfd0 fs/ext4/fsync.c:151
 vfs_fsync_range+0x13a/0x220 fs/sync.c:200
 generic_write_sync include/linux/fs.h:2982 [inline]
 ext4_buffered_write_iter+0x36a/0x4d0 fs/ext4/file.c:277
 ext4_file_write_iter+0x423/0x14e0 fs/ext4/file.c:680
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x796/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x443dc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef54952a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000443dc9
RDX: 0000000000000082 RSI: 0000000020000180 RDI: 0000000000000004
RBP: 0000000000403660 R08: 00000000004004a0 R09: 00000000004004a0
R10: 00000000004004a0 R11: 0000000000000246 R12: 00000000004036f0
R13: 0000000000000000 R14: 00000000004b2018 R15: 00000000004004a0
Modules linked in:
---[ end trace e0abbb4b21cfac7f ]---
RIP: 0010:ext4_writepages+0x244d/0x3b70 fs/ext4/inode.c:2704
Code: e1 be 00 10 00 00 4c 89 ef 48 d3 ee ba 01 00 00 00 e8 57 23 fe ff 83 c0 01 89 84 24 bc 00 00 00 e9 2d e2 ff ff e8 73 d5 66 ff <0f> 0b e8 6c d5 66 ff 44 0f b6 a4 24 db 00 00 00 89 5c 24 08 e9 a7
RSP: 0018:ffffc900019ff580 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801cad54c0 RSI: ffffffff820e071d RDI: 0000000000000003
RBP: ffff888035bc5a08 R08: 0000000000000000 R09: ffff888035bc5a0f
R10: ffffffff820dfbf3 R11: 0000000000000000 R12: 0000000000000001
R13: ffff888035bc5cf0 R14: ffffc900019ffa08 R15: ffff88801d9ea000
FS:  0000000000865300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f205933e000 CR3: 000000002e66c000 CR4: 0000000000350ef0

