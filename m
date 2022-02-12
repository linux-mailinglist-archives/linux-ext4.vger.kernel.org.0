Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E474B3402
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Feb 2022 10:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiBLJZX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Feb 2022 04:25:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiBLJZX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Feb 2022 04:25:23 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634562656A
        for <linux-ext4@vger.kernel.org>; Sat, 12 Feb 2022 01:25:20 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id g15-20020a92520f000000b002bec6a02012so2189424ilb.18
        for <linux-ext4@vger.kernel.org>; Sat, 12 Feb 2022 01:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=n0c9B5mqiyvNX7hEORg3tf68mAVgwYUCwgEl/oUCva8=;
        b=HCza12jzxiqd+UHEpphExeEZ57GICmkxEdevUM2C1PG8vOW+Fdh+Gu6zHOE6z+hMYz
         4X8zO2AOP2s4id/TTUf5l5DD9rc6oF4vLPuOKF+7n9v2f1VNBbR0PP2lYqBcxzydrAt4
         UuZqGcQajNnO3rRM6sS2NPid683muTlo4GSVlheVGA+A0eaOkZ2sf0GNUu6BaKN7otqz
         ZW5ODYu4JGoD2ClWHMlaopnTLHEMrANSutajIWf/itglaeXiSa+UtVPAxBK902C4HTGm
         RuB+fJzg1mTBqKqIxBcxP2WIC4SIYzRCRjopCd/eHGUtCbOiGFYBhsmAMdr7RGkPOsxG
         RXFQ==
X-Gm-Message-State: AOAM531IaUqOXVg987oL4uyTsWg2UJZHiwKNHrAMxgenlJo/tATpUswe
        WRVic8jGOvUiLNp76Ok8cAN52fNqVu1/WTedSLkt1vuQA19H
X-Google-Smtp-Source: ABdhPJyZIjEXOU001SZ5BJieLiT3Zh/Hh5Z/5A39uD3yFqKKawf4c5rRAf9szlhfhvonxQ2emA2k2Q7r8ZDxbDSuwS3kKlbkNvTA
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b10:: with SMTP id p16mr2867919iov.44.1644657919677;
 Sat, 12 Feb 2022 01:25:19 -0800 (PST)
Date:   Sat, 12 Feb 2022 01:25:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000145b2805d7cec3d0@google.com>
Subject: [syzbot] kernel BUG in ext4_split_extent_at
From:   syzbot <syzbot+9df2b537192e605d3f78@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11320c2c700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=9df2b537192e605d3f78
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9df2b537192e605d3f78@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:3199!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 14330 Comm: syz-executor.1 Not tainted 5.17.0-rc3-syzkaller-00020-g555f3d7be91a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_split_extent_at+0x910/0xe10 fs/ext4/extents.c:3199
Code: de e8 74 52 6a ff 48 85 db 0f 84 37 04 00 00 e8 d6 4f 6a ff 66 41 81 ce 00 80 66 44 89 74 24 7c e9 0c fb ff ff e8 c0 4f 6a ff <0f> 0b e8 b9 4f 6a ff 4c 89 e8 31 ff 25 ff 7f 00 00 48 89 c6 48 89
RSP: 0018:ffffc9000476f730 EFLAGS: 00010212
RAX: 00000000000059b6 RBX: 0000000000008028 RCX: ffffc9000a282000
RDX: 0000000000040000 RSI: ffffffff820e28d0 RDI: 0000000000000003
RBP: ffff888072591c30 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff820e21c7 R11: 00000000ffff8000 R12: ffff88802603d054
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f8a3dd98700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d743000 CR3: 000000007dc31000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_force_split_extent_at fs/ext4/extents.c:319 [inline]
 ext4_swap_extents+0x8e3/0x14c0 fs/ext4/extents.c:5662
 move_extent_per_page fs/ext4/move_extent.c:360 [inline]
 ext4_move_extents+0x1c86/0x3ee0 fs/ext4/move_extent.c:672
 __ext4_ioctl+0x33e6/0x57e0 fs/ext4/ioctl.c:1285
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8a3f423059
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8a3dd98168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8a3f535f60 RCX: 00007f8a3f423059
RDX: 0000000020000200 RSI: 00000000c028660f RDI: 0000000000000005
RBP: 00007f8a3f47d08d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffd2956f0f R14: 00007f8a3dd98300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_split_extent_at+0x910/0xe10 fs/ext4/extents.c:3199
Code: de e8 74 52 6a ff 48 85 db 0f 84 37 04 00 00 e8 d6 4f 6a ff 66 41 81 ce 00 80 66 44 89 74 24 7c e9 0c fb ff ff e8 c0 4f 6a ff <0f> 0b e8 b9 4f 6a ff 4c 89 e8 31 ff 25 ff 7f 00 00 48 89 c6 48 89
RSP: 0018:ffffc9000476f730 EFLAGS: 00010212
RAX: 00000000000059b6 RBX: 0000000000008028 RCX: ffffc9000a282000
RDX: 0000000000040000 RSI: ffffffff820e28d0 RDI: 0000000000000003
RBP: ffff888072591c30 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff820e21c7 R11: 00000000ffff8000 R12: ffff88802603d054
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f8a3dd98700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f51c4218718 CR3: 000000007dc31000 CR4: 0000000000350ee0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
