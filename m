Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E3D64FC34
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Dec 2022 21:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiLQUXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Dec 2022 15:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLQUXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Dec 2022 15:23:39 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B65E0CF
        for <linux-ext4@vger.kernel.org>; Sat, 17 Dec 2022 12:23:37 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id s22-20020a6bdc16000000b006e2d7c78010so2626733ioc.21
        for <linux-ext4@vger.kernel.org>; Sat, 17 Dec 2022 12:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eOpFqGpwkUsU/PaMKCKCrxmyrnrYaOTFPop5D3XZ8FU=;
        b=ej6QurTtlmzvK/pd+DW01qtLXLwfrOwql5ObaomqdMlIbjmPJgSTABVW+g5rVtnumQ
         qRo8XiKk5uOnArgzte/hfE7l5BVxI/GqD4v2m7J//Pcb5ne9ideX/sNIGHWpRxjX5ls2
         10vMwKmDOXUpSAQc94RqU0iRbOkBR5JDi8i2JkfLiChes9gMnNG9/dJB0LXGp2sAGlq5
         eNMLlsOHevF8WTtPqQgVTCr1y2I8QUs5a4oRG/SlLzG3u0lyWka2BaMbl59B5waRZ2NY
         Vr1SnuyJaTXYO+8Cnz5Cfv8XILFPMDKlBMnsTbnokoqzE7gfCMGKO5X89s04TE4v2ClJ
         Io1A==
X-Gm-Message-State: ANoB5pnilkv+3EK8WvMuR6sdlralYjEDUrUglMKQM7qyyWroZa1160Iy
        Ck3yRnF4be22gPbRWGITmJ9BryfWPDqBx6KZK/Ge6XFSfHsn
X-Google-Smtp-Source: AA0mqf5lRVMS4o6Oykhpeta6b+msjjuoSk+c5JJLtNE7AxzJTVhrLrJr428eZVE6vMIu3U+JfsDlRGjH++m4LNz0R5aCSZCnnPTM
MIME-Version: 1.0
X-Received: by 2002:a92:6f06:0:b0:300:d7db:639e with SMTP id
 k6-20020a926f06000000b00300d7db639emr44984840ilc.264.1671308617173; Sat, 17
 Dec 2022 12:23:37 -0800 (PST)
Date:   Sat, 17 Dec 2022 12:23:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fd14305f00bdc84@google.com>
Subject: [syzbot] kernel BUG in ext4_do_writepages
From:   syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    02bf43c7b7f7 Merge tag 'fs.xattr.simple.rework.rbtree.rwlo..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d48f33880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166cffdf880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172b1f2b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45f211dceffb/disk-02bf43c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd0c63aa3713/vmlinux-02bf43c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/734647e04fd0/bzImage-02bf43c7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/192035fab0d1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:2782!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1100 Comm: kworker/u4:5 Not tainted 6.1.0-syzkaller-03295-g02bf43c7b7f7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:1)
RIP: 0010:ext4_do_writepages+0x3c27/0x3c30 fs/ext4/inode.c:2781
Code: c7 50 d6 4b 8d 4c 89 fa e8 46 c9 33 02 e9 c0 fb ff ff e8 4c 7b 53 ff 0f 0b e8 45 7b 53 ff 0f 0b e8 fe 4d 5c 08 e8 39 7b 53 ff <0f> 0b 0f 1f 80 00 00 00 00 55 41 57 41 56 53 48 89 fb 49 bf 00 00
RSP: 0018:ffffc90004ffede0 EFLAGS: 00010293
RAX: ffffffff8237eaa7 RBX: 0000008000000000 RCX: ffff8880207dd7c0
RDX: 0000000000000000 RSI: 0000008000000000 RDI: 0000000000000000
RBP: ffffc90004fff150 R08: ffffffff8237b469 R09: ffffed100e7b8791
R10: ffffed100e7b8791 R11: 1ffff1100e7b8790 R12: ffff888073dc3ee0
R13: ffffc90004fff650 R14: 0000008410000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f224f000000 CR3: 0000000019fee000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_writepages+0x1e0/0x290 fs/ext4/inode.c:2965
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
 __writeback_single_inode+0xd1/0x670 fs/fs-writeback.c:1587
 writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1878
 __writeback_inodes_wb+0x125/0x420 fs/fs-writeback.c:1949
 wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2054
 wb_check_background_flush fs/fs-writeback.c:2120 [inline]
 wb_do_writeback fs/fs-writeback.c:2208 [inline]
 wb_workfn+0xb3f/0xef0 fs/fs-writeback.c:2235
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_do_writepages+0x3c27/0x3c30 fs/ext4/inode.c:2781
Code: c7 50 d6 4b 8d 4c 89 fa e8 46 c9 33 02 e9 c0 fb ff ff e8 4c 7b 53 ff 0f 0b e8 45 7b 53 ff 0f 0b e8 fe 4d 5c 08 e8 39 7b 53 ff <0f> 0b 0f 1f 80 00 00 00 00 55 41 57 41 56 53 48 89 fb 49 bf 00 00
RSP: 0018:ffffc90004ffede0 EFLAGS: 00010293
RAX: ffffffff8237eaa7 RBX: 0000008000000000 RCX: ffff8880207dd7c0
RDX: 0000000000000000 RSI: 0000008000000000 RDI: 0000000000000000
RBP: ffffc90004fff150 R08: ffffffff8237b469 R09: ffffed100e7b8791
R10: ffffed100e7b8791 R11: 1ffff1100e7b8790 R12: ffff888073dc3ee0
R13: ffffc90004fff650 R14: 0000008410000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f224f0df000 CR3: 0000000021186000 CR4: 00000000003506f0
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
