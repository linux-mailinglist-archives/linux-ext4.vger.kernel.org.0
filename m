Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1530457C5FC
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiGUIQX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGUIQW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 04:16:22 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA67D1FE
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jul 2022 01:16:21 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id q15-20020a056e0220ef00b002dcf06b188fso644733ilv.6
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jul 2022 01:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XiflHrkGhMohfp90y6rm8XzN9ejlCNoFswsBGQ/pU/U=;
        b=OkkuhsY8k5LfXtLz8almRiQ+rM7qoITQ3xoeC6Y83ypMn7s/+h8UPhklNZuO5XFgVu
         spAiC2GQL/mbJRzYyixPsx6ysZRpO2nV9Nvo8EFmfRGt1TQEnBdN7RHUJwVZlRBYmMs4
         pa3vnOBUlps1eGwR6R6O/zQ0gZrHYgCUnBXIV8WYNGY2vxNVXTB1mBgHt+KeJm2votbl
         zoDYbnL9ess1PGU0U59CJHeWoQpzgek5zvs56lsQJxzGwAqMNJewE8A2NIzWQNI+HxhF
         PZuPrDPEU2H8x04TRfSWPrzOrZgpCEDHHmt52RtxOvQj5Aa7tIxEdEh5zTdOPGumBfQy
         vYrA==
X-Gm-Message-State: AJIora/qE6m5gCvoFF2pXXCIhkAVZBE+hKWJc0QuRCN52vFi+1yH4EZf
        T3pxuPTnDJiMYKh5HdjLtfnZNcI4jhmBP+lk1tRLjEqRfwV/
X-Google-Smtp-Source: AGRyM1uRrMW3mfids6Sst+N2N2tZanU9cElVjImRKGVG39qcdE0cDece+SGIR9+7ZcJQeC7ZuGEGQblaXekZAhQ4tDDbiJSvbChG
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2203:b0:33e:b93f:5882 with SMTP id
 l3-20020a056638220300b0033eb93f5882mr21645815jas.66.1658391380915; Thu, 21
 Jul 2022 01:16:20 -0700 (PDT)
Date:   Thu, 21 Jul 2022 01:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028796b05e44c55e9@google.com>
Subject: [syzbot] WARNING in ext2_get_group_desc
From:   syzbot <syzbot+d273f7d7f58afd93be48@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    c658cabbfd32 Merge tag 's390-5.19-6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149c07d0080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf350e66d4493550
dashboard link: https://syzkaller.appspot.com/bug?extid=d273f7d7f58afd93be48
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d273f7d7f58afd93be48@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 20
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3999 at fs/ext2/balloc.c:51 ext2_get_group_desc+0x88/0xb4 fs/ext2/balloc.c:51
block_group >= groups_count - block_group = 1, groups_count = 1
Modules linked in:
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 3999 Comm: syz-executor.1 Not tainted 5.19.0-rc6-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<816f379c>] (dump_backtrace) from [<816f3acc>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:253)
 r7:81d72500 r6:82422fec r5:60000093 r4:81d80550
[<816f3ab4>] (show_stack) from [<816fc3f8>] (__dump_stack lib/dump_stack.c:88 [inline])
[<816f3ab4>] (show_stack) from [<816fc3f8>] (dump_stack_lvl+0x48/0x54 lib/dump_stack.c:106)
[<816fc3b0>] (dump_stack_lvl) from [<816fc41c>] (dump_stack+0x18/0x1c lib/dump_stack.c:113)
 r5:00000000 r4:82642d14
[<816fc404>] (dump_stack) from [<816f4668>] (panic+0x11c/0x360 kernel/panic.c:274)
[<816f454c>] (panic) from [<80242a2c>] (__warn+0x98/0x198 kernel/panic.c:623)
 r3:00000001 r2:00000000 r1:00000000 r0:81d72500
 r7:806112e0
[<80242994>] (__warn) from [<816f4948>] (warn_slowpath_fmt+0x9c/0xd4 kernel/panic.c:653)
 r8:00000009 r7:806112e0 r6:00000033 r5:81db0ac4 r4:81db0a80
[<816f48b0>] (warn_slowpath_fmt) from [<806112e0>] (ext2_get_group_desc+0x88/0xb4 fs/ext2/balloc.c:51)
 r8:00000001 r7:851d1c00 r6:ee24dde0 r5:851d1c00 r4:00000000
[<80611258>] (ext2_get_group_desc) from [<80615118>] (ext2_get_inode+0x94/0x134 fs/ext2/inode.c:1345)
 r4:00000002
[<80615084>] (ext2_get_inode) from [<80617194>] (ext2_iget+0x84/0x438 fs/ext2/inode.c:1425)
 r9:88485670 r8:00000000 r7:851d1c00 r6:00000002 r5:00000000 r4:8497b6f8
[<80617110>] (ext2_iget) from [<8061a940>] (ext2_fill_super+0xb30/0xe14 fs/ext2/super.c:1162)
 r8:00000000 r7:84af7600 r6:88307400 r5:851d1c00 r4:88485600
[<80619e10>] (ext2_fill_super) from [<8049e2a0>] (mount_bdev+0x178/0x1a4 fs/super.c:1367)
 r10:852b4000 r9:83917dbc r8:00000083 r7:852b4000 r6:00000000 r5:851d1c00
 r4:83917b80
[<8049e128>] (mount_bdev) from [<806189ac>] (ext2_mount+0x20/0x28 fs/ext2/super.c:1465)
 r9:86184b80 r8:86184200 r7:ee24df6c r6:00000020 r5:8061898c r4:85352f00
[<8061898c>] (ext2_mount) from [<804de934>] (legacy_get_tree+0x2c/0x50 fs/fs_context.c:610)
[<804de908>] (legacy_get_tree) from [<8049c85c>] (vfs_get_tree+0x2c/0x108 fs/super.c:1497)
 r5:85352f00 r4:85352f00
[<8049c830>] (vfs_get_tree) from [<804c5818>] (do_new_mount fs/namespace.c:3040 [inline])
[<8049c830>] (vfs_get_tree) from [<804c5818>] (path_mount+0x3e8/0xabc fs/namespace.c:3370)
 r6:00000020 r5:00000000 r4:85352f00
[<804c5430>] (path_mount) from [<804c6428>] (do_mount fs/namespace.c:3383 [inline])
[<804c5430>] (path_mount) from [<804c6428>] (__do_sys_mount fs/namespace.c:3591 [inline])
[<804c5430>] (path_mount) from [<804c6428>] (sys_mount+0x118/0x220 fs/namespace.c:3568)
 r10:00000000 r9:76f05ef8 r8:00000000 r7:00000000 r6:852b4000 r5:86184200
 r4:86184b80
[<804c6310>] (sys_mount) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:64)
Exception stack(0xee24dfa8 to 0xee24dff0)
dfa0:                   76f05ef8 20000000 76f05eb8 20000240 20000000 00000000
dfc0: 76f05ef8 20000000 20000340 00000015 76f05eb8 00000000 76f05eb8 00000000
dfe0: 000862b8 76f05e70 00016a48 0004d500
 r10:00000015 r9:84f38bc0 r8:80200288 r7:00000015 r6:20000340 r5:20000000
 r4:76f05ef8
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
