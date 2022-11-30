Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE8463E132
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Nov 2022 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiK3UKB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Nov 2022 15:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiK3UJu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Nov 2022 15:09:50 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE3891365
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 12:09:49 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id z15-20020a5e860f000000b006c09237cc06so12235255ioj.21
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 12:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KBzuD2ZwPlcaaxAlrMFnMjcuqM18+pImclhxcva+LQ=;
        b=Q06SX/NXGinkvPW7OSuTpz5H8i4pB5EfTRsd0MnxECSWqZJ9ubQq2RtMPH/2r38ijZ
         mfaWP4TABruTxBkkhp4Z2YDOcbZ7hypgxy3pPA3tYlNCull3vTEq6nuNpclJwrB1ZgYE
         ScIa6uJ3eJOLrwMz1gp8OjaX7YHzPBK7epIayH2ErstlnZpQGxO7gaErEOvfzERJhLxq
         yGK2Nix4fxlgCA4sQoyw0myZm7YVn+Xexfc/uu65BtOLTxkMHuU+WqJ5mZD5cF8zI1zc
         ukWzo3sw5NUX2ZoMG/UoWPQB0rn3Cf44yQjLMUzsbIi0SDQy/ii1xBhj+r2NA4fILWjM
         nVyg==
X-Gm-Message-State: ANoB5pnEma7YKFNq7Mt9ZPG5cVQk90V+vvnQ5/QD7wRFMjjtcI7rnERy
        sTpvBvmh5k5holhxqvS5zSqPNTg2LIip7teOsAkyda9czPxU
X-Google-Smtp-Source: AA0mqf45/dOb2H0TF2O8Pjzbn92juxt643OEPV+MjSlI6zV+7m79TSoPOd7UcvTktHjLMYX9TSAiIAyQjMQHQJcTsyeVY/ordq+F
MIME-Version: 1.0
X-Received: by 2002:a92:de07:0:b0:303:1d4b:aeec with SMTP id
 x7-20020a92de07000000b003031d4baeecmr5730734ilm.125.1669838988571; Wed, 30
 Nov 2022 12:09:48 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:09:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000befd1d05eeb5af30@google.com>
Subject: [syzbot] WARNING in ext4_expand_extra_isize_ea
From:   syzbot <syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com>
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

HEAD commit:    644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ad3e03880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=4d99a966fd74bdeeec36
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f49603880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163dfb9b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e867d6971304/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
EXT4-fs: Ignoring removed nobh option
EXT4-fs (loop0): orphan cleanup on readonly fs
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3631 at mm/page_alloc.c:5534 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
Modules linked in:
CPU: 1 PID: 3631 Comm: syz-executor261 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
Code: 5c 24 04 0f 85 f3 00 00 00 44 89 e1 81 e1 7f ff ff ff a9 00 00 04 00 41 0f 44 cc 41 89 cc e9 e3 00 00 00 c6 05 51 7b 8f 0c 01 <0f> 0b 83 fb 0a 0f 86 c8 fd ff ff 31 db 48 c7 44 24 20 0e 36 e0 45
RSP: 0018:ffffc90003ccf080 EFLAGS: 00010246
RAX: ffffc90003ccf0e0 RBX: 000000000000000c RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003ccf108
RBP: ffffc90003ccf198 R08: dffffc0000000000 R09: ffffc90003ccf0e0
R10: fffff52000799e21 R11: 1ffff92000799e1c R12: 0000000000040c40
R13: 1ffff92000799e18 R14: dffffc0000000000 R15: 1ffff92000799e14
FS:  0000555555c10300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc36f70000 CR3: 00000000744ad000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:223 [inline]
 alloc_pages_node include/linux/gfp.h:246 [inline]
 __kmalloc_large_node+0x8a/0x1a0 mm/slab_common.c:1096
 __do_kmalloc_node mm/slab_common.c:943 [inline]
 __kmalloc+0xfe/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 ext4_xattr_move_to_block fs/ext4/xattr.c:2558 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2673 [inline]
 ext4_expand_extra_isize_ea+0xe3f/0x1cd0 fs/ext4/xattr.c:2765
 __ext4_expand_extra_isize+0x2b8/0x3f0 fs/ext4/inode.c:5857
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5900 [inline]
 __ext4_mark_inode_dirty+0x51a/0x670 fs/ext4/inode.c:5978
 ext4_inline_data_truncate+0x548/0xd00 fs/ext4/inline.c:2021
 ext4_truncate+0x341/0xeb0 fs/ext4/inode.c:4221
 ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
 ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5515 [inline]
 ext4_fill_super+0x80ed/0x8610 fs/ext4/super.c:5643
 get_tree_bdev+0x400/0x620 fs/super.c:1324
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54cbc6ae2a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc36f6f8e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f54cbc6ae2a
RDX: 0000000020000440 RSI: 0000000020000480 RDI: 00007ffc36f6f8f0
RBP: 00007ffc36f6f8f0 R08: 00007ffc36f6f930 R09: 000000000000041e
R10: 0000000000000011 R11: 0000000000000206 R12: 0000000000000004
R13: 0000555555c102c0 R14: 00007ffc36f6f930 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
