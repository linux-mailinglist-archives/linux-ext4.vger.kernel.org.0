Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A556586A0
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Dec 2022 21:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiL1UQp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Dec 2022 15:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiL1UQo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Dec 2022 15:16:44 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E800E14D31
        for <linux-ext4@vger.kernel.org>; Wed, 28 Dec 2022 12:16:41 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so10618309ilu.4
        for <linux-ext4@vger.kernel.org>; Wed, 28 Dec 2022 12:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSXYMt9F0DljBBJAoeS8ed0co8SNZwaD/wJIXGf4jtI=;
        b=ZUcYojvV6EJS/GLUgFqWv5YUjiwBUSxiFJywdE/cQ3FdCA2aUhAAe9swhZDYCOqWJY
         q09L4+mMHxjJ5jDjSHxvkxwlVgQdRUeGqlW/49qGywHPcKukx/DVhqw3vUgXxUSck1km
         kYNSlu/0BdPpta4vZVIKyJs+HAtX2sa3jUgWnx/Vtxl53JQqPAOswynR2sp0Y+aTqx8p
         KRk0p39d2E15EJkL7oJXTJWkiacYv9M9Q7ARxuWQUBI6OlEB2nzDPit0TcQYyUaNXE4l
         ywurV14PJ64Ttt2hQxYtNKBKlQBhtt1HIsANhFzBmgDJLm8NNlsNJa4gTI7K/OAkUStJ
         5VzQ==
X-Gm-Message-State: AFqh2kr5jS1aWPP4J2YjKsL5e9xpOtCTidmAeVeExyCxYKIlkmdz0my5
        MB/yFqFKZ8Md1XDQtlRotEijWWLic0vfM6GG5v6zO0MaRsyF
X-Google-Smtp-Source: AMrXdXv6jKhQuYftlLetBmbX477fP15MKMfQi0gyJr5HNxY0Zra+9mTDy3BudcHp2z7DhMtMcaFYssjmO6EunwXuNYv6x3bKBDX6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:303:4b02:47eb with SMTP id
 g14-20020a056e021a2e00b003034b0247ebmr2346852ile.251.1672258601271; Wed, 28
 Dec 2022 12:16:41 -0800 (PST)
Date:   Wed, 28 Dec 2022 12:16:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6c7b005f0e90bf1@google.com>
Subject: [syzbot] [ext4?] kernel panic: EXT4-fs (device loop0): panic forced
 after error (2)
From:   syzbot <syzbot+3c45794f522ad93b0eb6@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13527f8c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=3c45794f522ad93b0eb6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d7f2e4480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c8d2ac480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/510d16df06c8/disk-72a85e2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50ef5477a1d4/vmlinux-72a85e2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2acd6f1189a/bzImage-72a85e2b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6f0bbc430a64/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c45794f522ad93b0eb6@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
EXT4-fs error (device loop0): ext4_map_blocks:607: inode #2: block 2: comm syz-executor170: lblock 0 mapped to illegal pblock 2 (length 1)
Kernel panic - not syncing: EXT4-fs (device loop0): panic forced after error
CPU: 1 PID: 5069 Comm: syz-executor170 Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 panic+0x2d6/0x710 kernel/panic.c:318
 ext4_handle_error+0x848/0x8a0 fs/ext4/super.c:685
 __ext4_error_inode+0x2e1/0x4c0 fs/ext4/super.c:808
 ext4_map_blocks+0xadf/0x1cc0
 ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:864
 ext4_bread+0x2a/0x170 fs/ext4/inode.c:920
 __ext4_read_dirblock+0xc9/0x890 fs/ext4/namei.c:144
 dx_probe+0xb7/0x1590 fs/ext4/namei.c:818
 ext4_dx_find_entry fs/ext4/namei.c:1771 [inline]
 __ext4_find_entry+0x599/0x1ba0 fs/ext4/namei.c:1616
 ext4_lookup_entry fs/ext4/namei.c:1752 [inline]
 ext4_lookup+0x11c/0x690 fs/ext4/namei.c:1820
 __lookup_slow+0x266/0x3a0 fs/namei.c:1685
 lookup_slow fs/namei.c:1702 [inline]
 lookup_one_unlocked+0x3f8/0x670 fs/namei.c:2772
 lookup_one_positive_unlocked fs/namei.c:2801 [inline]
 lookup_positive_unlocked+0x27/0xb0 fs/namei.c:2841
 dquot_quota_on_mount+0x56/0xe0 fs/quota/dquot.c:2514
 ext4_quota_on_mount fs/ext4/orphan.c:316 [inline]
 ext4_orphan_cleanup+0x687/0x1340 fs/ext4/orphan.c:444
 __ext4_fill_super fs/ext4/super.c:5516 [inline]
 ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd5f592fbca
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcfa196b78 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd5f592fbca
RDX: 0000000020000440 RSI: 0000000020000480 RDI: 00007ffcfa196b90
RBP: 00007ffcfa196b90 R08: 00007ffcfa196bd0 R09: 0000000000000474
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000004
R13: 00005555565362c0 R14: 0000000000000000 R15: 00007ffcfa196bd0
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
