Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969674AAF90
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Feb 2022 14:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiBFNtY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Feb 2022 08:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbiBFNtX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Feb 2022 08:49:23 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883D2C0401C4
        for <linux-ext4@vger.kernel.org>; Sun,  6 Feb 2022 05:49:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id a3-20020a92d103000000b002bdfc5108dfso2225065ilb.9
        for <linux-ext4@vger.kernel.org>; Sun, 06 Feb 2022 05:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2BjaMGDo4/nb0cgziCObjwAIJLqV0IFNYkvzhO5UBCM=;
        b=X88UFwQZGEhibRC6BmnQEqHYEV2EGvgyCuLkB391/9vXkrYbSilPNBX372vA7puhhg
         GP7FCSUnb66WgNsIDpWMs4MQMhxcY5n+jiY33TBXI2kFLD87xA7HNO02Lbpq+3GrqsyY
         LYDdejTd+OsvL58txUBEl0fbH19gpLqFi1zCTByBWSAo58G8x6m5OpYxDsUGsI7/lIz+
         zZtx7E4gHQjLFoZElIlDH/XCKitZOaeJWKsr8qdcZ5K7CNNfkRWmj86Ic7D8kgZvl1BY
         X8HH4kAQPih1OS85h1I5CCtoPwL0SBpagJFOSNPPcq06q2ZYGehc2SBI2K40rnTbRT9E
         BTDw==
X-Gm-Message-State: AOAM530pqVP+nb/wGnhn3LEi/Le2nmEX+PDX2fKwggyY2M+zQ1eSoFQA
        T9HsE5Kc/24u3M0QFetbTBJ/4/aaoSHbKgRdnQBAbMggqjem
X-Google-Smtp-Source: ABdhPJyrtf9K1fc0nnjSzQa41PslNz5JT188h0hOhiBRCbCMRX44ELEtSDOus0Y+q8gBFL3acNPlpTbI7OjY+y+Meg2n+cuzPMFu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164f:: with SMTP id a15mr3896146jat.272.1644155360871;
 Sun, 06 Feb 2022 05:49:20 -0800 (PST)
Date:   Sun, 06 Feb 2022 05:49:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d898d05d759c00a@google.com>
Subject: [syzbot] kernel BUG in ext4_es_cache_extent
From:   syzbot <syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com>
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

HEAD commit:    9f7fb8de5d9b Merge tag 'spi-fix-v5.17-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148d0304700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4a89edfcc8f7c74
dashboard link: https://syzkaller.appspot.com/bug?extid=c7358a3cd05ee786eb31
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124e0abfb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1758f610700000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12758738700000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11758738700000
console output: https://syzkaller.appspot.com/x/log.txt?x=16758738700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1051
EXT4-fs (loop0): ext4_check_descriptors: Checksum for group 0 failed (60935!=0)
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: writeback.
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:899!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3587 Comm: syz-executor288 Not tainted 5.17.0-rc2-syzkaller-00039-g9f7fb8de5d9b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_es_cache_extent+0x4e8/0x550 fs/ext4/extents_status.c:899
Code: 00 48 c7 c7 e0 6c c1 89 c6 05 71 25 6f 0b 01 e8 b0 b6 f6 06 e9 5a ff ff ff e8 94 9d 68 ff 0f 0b e9 d7 fc ff ff e8 88 9d 68 ff <0f> 0b e8 81 9d 68 ff 0f 0b e9 13 fe ff ff e8 25 df af ff e9 c2 fb
RSP: 0018:ffffc90001abee80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000013de RCX: 0000000000000000
RDX: ffff88807deb0000 RSI: ffffffff820fd0f8 RDI: 0000000000000003
RBP: ffff888074e6f048 R08: 00000000ffffffff R09: 0000000000000000
R10: ffffffff820fce3c R11: 0000000000000000 R12: 0000000000000001
R13: 00000000ffffffff R14: 1ffff92000357dd1 R15: 00008f1cffffffff
FS:  0000555556ad6300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f117149e4b0 CR3: 000000007cc1f000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_cache_extents+0x13e/0x2d0 fs/ext4/extents.c:518
 ext4_find_extent+0x8f6/0xd10 fs/ext4/extents.c:916
 ext4_ext_map_blocks+0x1e2/0x5f30 fs/ext4/extents.c:4098
 ext4_map_blocks+0x9ca/0x18a0 fs/ext4/inode.c:563
 ext4_getblk+0x553/0x6b0 fs/ext4/inode.c:849
 ext4_bread_batch+0x7c/0x550 fs/ext4/inode.c:923
 __ext4_find_entry+0x482/0x1050 fs/ext4/namei.c:1600
 ext4_lookup_entry fs/ext4/namei.c:1701 [inline]
 ext4_lookup fs/ext4/namei.c:1769 [inline]
 ext4_lookup+0x4fc/0x730 fs/ext4/namei.c:1760
 __lookup_slow+0x24c/0x480 fs/namei.c:1707
 lookup_slow fs/namei.c:1724 [inline]
 walk_component+0x40f/0x6a0 fs/namei.c:2020
 link_path_walk.part.0+0x7ef/0xf70 fs/namei.c:2347
 link_path_walk fs/namei.c:2272 [inline]
 path_openat+0x266/0x2940 fs/namei.c:3605
 do_filp_open+0x1aa/0x400 fs/namei.c:3636
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_openat fs/open.c:1246 [inline]
 __se_sys_openat fs/open.c:1241 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1241
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8e44f22f19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff98aa3238 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8e44f22f19
RDX: 000000000000c880 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007f8e44ee27b0 R08: 0000000800000015 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8e44ee2840
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_cache_extent+0x4e8/0x550 fs/ext4/extents_status.c:899
Code: 00 48 c7 c7 e0 6c c1 89 c6 05 71 25 6f 0b 01 e8 b0 b6 f6 06 e9 5a ff ff ff e8 94 9d 68 ff 0f 0b e9 d7 fc ff ff e8 88 9d 68 ff <0f> 0b e8 81 9d 68 ff 0f 0b e9 13 fe ff ff e8 25 df af ff e9 c2 fb
RSP: 0018:ffffc90001abee80 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000000013de RCX: 0000000000000000
RDX: ffff88807deb0000 RSI: ffffffff820fd0f8 RDI: 0000000000000003
RBP: ffff888074e6f048 R08: 00000000ffffffff R09: 0000000000000000
R10: ffffffff820fce3c R11: 0000000000000000 R12: 0000000000000001
R13: 00000000ffffffff R14: 1ffff92000357dd1 R15: 00008f1cffffffff
FS:  0000555556ad6300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f117149e4b0 CR3: 000000007cc1f000 CR4: 0000000000350ee0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
