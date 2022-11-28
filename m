Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D4C63A60A
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 11:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiK1KXw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 05:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiK1KXu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 05:23:50 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03D1A817
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 02:23:47 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so8370263ila.2
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 02:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hR70/mlsdt+KaMvBAhjHNbTGKAIGN2hhPJ7D7NWuTQU=;
        b=tJ4m5VY503A3JC/ZR2wIJr0UtrMTLyBw7z8vQR13wHL9H1UeHxhuVINhL99nWBYPPS
         jRRUPI8Zsua90msV+xdl3cjwXfFiPtFou/+zxtGDOC86sMkSl3Hxc6LLoQM8Sftd2fJg
         FPKev06EIgbH0+n/rKNUbWyTGjDkzJJrlm3CnqDpjTKhxwJRbmcwn8MIvy2KnLVggyIy
         2GcnOL2MaETJxvACpZADovdkDF8psUvCRogXS0ZwfsRboGfzw0CQ0EBeYiDj1HW6RNfK
         J1r1/1ILEes2Z/XIpaoWfMoorR4naTimnx6qlmGn9QHO1DIPOTa2ZFOn8DaOqo/b9EFg
         iN1Q==
X-Gm-Message-State: ANoB5pk6ctJqFI1HljbgjCz6Qc6P1rO+qjAMmgJxSC3hPT65SKfpPN5V
        6Z15yEciksTv/eAAPGin/xCPuBwtiEob7W3vfMjTLWWOR2ZH
X-Google-Smtp-Source: AA0mqf6C3vnEM+6JI2ZUrGJBTmLk0GLEIh2ExLkK9KQ6djDKV/d7C5I70Qi8dxR77/TtRN6F/rcrXybNQZUvEJ3T7iPd7NwvlnYj
MIME-Version: 1.0
X-Received: by 2002:a02:168a:0:b0:375:f2f:9b66 with SMTP id
 a132-20020a02168a000000b003750f2f9b66mr24470182jaa.145.1669631026964; Mon, 28
 Nov 2022 02:23:46 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:23:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044b47605ee8544b2@google.com>
Subject: [syzbot] kernel BUG in __ext4_journal_stop
From:   syzbot <syzbot+bdab24d5bf96d57c50b0@syzkaller.appspotmail.com>
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

HEAD commit:    cf562a45a0d5 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111947ed880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128220a1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11859d55880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a92dc058341/disk-cf562a45.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c320c2307225/vmlinux-cf562a45.xz
kernel image: https://storage.googleapis.com/syzbot-assets/00049e41b3c5/bzImage-cf562a45.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1c3d3c1b6bda/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdab24d5bf96d57c50b0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
------------[ cut here ]------------
kernel BUG at fs/ext4/ext4_jbd2.c:53!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3634 Comm: syz-executor383 Not tainted 6.1.0-rc6-syzkaller-00375-gcf562a45a0d5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ext4_put_nojournal fs/ext4/ext4_jbd2.c:53 [inline]
RIP: 0010:__ext4_journal_stop+0x18b/0x190 fs/ext4/ext4_jbd2.c:116
Code: 5b 41 5c 41 5d 41 5e 41 5f 5d c3 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 11 ff ff ff e8 3f cb af ff e9 07 ff ff ff e8 85 b1 5b ff <0f> 0b 0f 1f 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 10 89 d5 89
RSP: 0018:ffffc90003cef840 EFLAGS: 00010293
RAX: ffffffff822ee66b RBX: 0000000000000000 RCX: ffff888024c81d40
RDX: 0000000000000000 RSI: 0000000000000323 RDI: ffffffff8cabd2f1
RBP: 0000000000000323 R08: ffffffff8234d69d R09: fffffbfff1cebdfe
R10: fffffbfff1cebdfe R11: 1ffffffff1cebdfd R12: ffff888074426750
R13: 1ffff1100e884cea R14: 0000000000000012 R15: ffffffff8cabd2f1
FS:  00007f91dbeb5700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91dbe94718 CR3: 000000002916b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x743/0xcd0 fs/ext4/inline.c:803
 generic_perform_write+0x3dc/0x5e0 mm/filemap.c:3764
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
 ext4_file_write_iter+0x1d0/0x18d0
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f91dbf09579
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f91dbeb52f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f91dbf8e7a0 RCX: 00007f91dbf09579
RDX: 0000000000000009 RSI: 0000000020000f80 RDI: 0000000000000004
RBP: 00007f91dbf5b828 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f91dbf5b0c0
R13: 0000000020000800 R14: 0030656c69662f2e R15: 00007f91dbf8e7a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_put_nojournal fs/ext4/ext4_jbd2.c:53 [inline]
RIP: 0010:__ext4_journal_stop+0x18b/0x190 fs/ext4/ext4_jbd2.c:116
Code: 5b 41 5c 41 5d 41 5e 41 5f 5d c3 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 11 ff ff ff e8 3f cb af ff e9 07 ff ff ff e8 85 b1 5b ff <0f> 0b 0f 1f 00 55 41 57 41 56 41 55 41 54 53 48 83 ec 10 89 d5 89
RSP: 0018:ffffc90003cef840 EFLAGS: 00010293
RAX: ffffffff822ee66b RBX: 0000000000000000 RCX: ffff888024c81d40
RDX: 0000000000000000 RSI: 0000000000000323 RDI: ffffffff8cabd2f1
RBP: 0000000000000323 R08: ffffffff8234d69d R09: fffffbfff1cebdfe
R10: fffffbfff1cebdfe R11: 1ffffffff1cebdfd R12: ffff888074426750
R13: 1ffff1100e884cea R14: 0000000000000012 R15: ffffffff8cabd2f1
FS:  00007f91dbeb5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000204 CR3: 000000002916b000 CR4: 00000000003506e0
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
