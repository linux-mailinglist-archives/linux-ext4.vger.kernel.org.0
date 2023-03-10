Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94A6B3517
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 05:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCJEBN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Mar 2023 23:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCJEBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Mar 2023 23:01:02 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC68102B6C
        for <linux-ext4@vger.kernel.org>; Thu,  9 Mar 2023 20:00:56 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id k23-20020a5e8917000000b0074cbfb58b5bso1908622ioj.14
        for <linux-ext4@vger.kernel.org>; Thu, 09 Mar 2023 20:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678420855;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Fz06YZUC1A3BSkG+VjaMAUzJWyCavf9Mnx3/HzzAdM=;
        b=2uP1Va+Vn1+PqZA3RFShT73nLMCMsZ8h9C78QyxU4OL/7pPau/lMWSTzhVbyksqf1e
         cMDtVUiKpkEm3gMAYqghPYbdHl/nYZg7Cy81FyOyCi2g4acqwY1ywbntNZgEWMTG6Cae
         gdMY6fktbryGfKWtkeZ38f3WeRW7KGA2t+K1yKJt8cCJQMQraQMISfoFTHVZjkDqAhMV
         3dj65PLi63+61oHujstCjhVwmsIOF/S3rGIh8/BpA520jN+eFo0esyc1KJ7bHj+6wFZB
         B7+R1HihpJxG1t36Hp1nW3pgEqYgsrfqJoj7VU8EgQ4NmjUiPp3z0ric41HGn1X2aLYD
         m4Ww==
X-Gm-Message-State: AO0yUKWbEH6t5PhCKehD4KX90WJ3173yyvXzu1u/UU/lqT31CVUMAaD3
        Oq/W8qElVyaYILXsjKJB9F3B2il57UeWFNNE60fZpNO/xXIz
X-Google-Smtp-Source: AK7set+7yppofA/utux1mLS6MDSD5I8lh5RFL/UwnMt03JhO7zeykExKdQZjtgEmkab/ts97ewzrOZQF8RonQ/Druls/ywknS8gD
MIME-Version: 1.0
X-Received: by 2002:a6b:6a11:0:b0:745:68ef:e410 with SMTP id
 x17-20020a6b6a11000000b0074568efe410mr11301247iog.0.1678420855331; Thu, 09
 Mar 2023 20:00:55 -0800 (PST)
Date:   Thu, 09 Mar 2023 20:00:55 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dda0af05f683ce66@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_expand_extra_isize_ea (2)
From:   syzbot <syzbot+7f99d7ca409ff61ff282@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f915322fe014 Merge tag 'v6.3-p2' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f98c6cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc0f7cfe5b32efe2
dashboard link: https://syzkaller.appspot.com/bug?extid=7f99d7ca409ff61ff282
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b5906c911a8/disk-f915322f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dba92a9c1a17/vmlinux-f915322f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4fca23736a8/bzImage-f915322f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f99d7ca409ff61ff282@syzkaller.appspotmail.com

EXT4-fs (loop5): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: writeback.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 10480 at mm/slab_common.c:935 folio_order include/linux/mm.h:850 [inline]
WARNING: CPU: 1 PID: 10480 at mm/slab_common.c:935 free_large_kmalloc+0x3d/0x190 mm/slab_common.c:933
Modules linked in:
CPU: 1 PID: 10480 Comm: syz-executor.5 Not tainted 6.2.0-syzkaller-13563-gf915322fe014 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:free_large_kmalloc+0x3d/0x190 mm/slab_common.c:935
Code: 48 8b 04 25 28 00 00 00 48 89 44 24 08 48 8b 47 08 a8 01 0f 85 4e 01 00 00 49 89 f6 0f 1f 44 00 00 49 f7 07 00 00 01 00 75 25 <0f> 0b 31 db 80 3d 90 02 97 0c 00 75 21 c6 05 87 02 97 0c 01 48 c7
RSP: 0018:ffffc90006707748 EFLAGS: 00010246
RAX: ffffea0000afcf08 RBX: 0000000000000012 RCX: ffffea0000afcf08
RDX: ffffea0000000000 RSI: ffff88804f4105a4 RDI: ffffea00013d0400
RBP: ffffc90006707968 R08: ffffffff813ed30c R09: fffffbfff209e04c
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88804f4105a4
R13: 0000000000000000 R14: ffff88804f4105a4 R15: ffffea00013d0400
FS:  00007f5424471700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002000 CR3: 000000008f925000 CR4: 00000000003506e0
DR0: 00000000ffff070c DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_xattr_move_to_block fs/ext4/xattr.c:2680 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0x1227/0x1c40 fs/ext4/xattr.c:2835
 __ext4_expand_extra_isize+0x2f7/0x3d0 fs/ext4/inode.c:5955
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5998 [inline]
 __ext4_mark_inode_dirty+0x60e/0x9d0 fs/ext4/inode.c:6076
 __ext4_unlink+0x997/0xbb0 fs/ext4/namei.c:3256
 ext4_unlink+0x294/0x840 fs/ext4/namei.c:3299
 vfs_unlink+0x35d/0x5f0 fs/namei.c:4250
 do_unlinkat+0x4a1/0x940 fs/namei.c:4316
 __do_sys_unlinkat fs/namei.c:4359 [inline]
 __se_sys_unlinkat fs/namei.c:4352 [inline]
 __x64_sys_unlinkat+0xce/0xf0 fs/namei.c:4352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f542368c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5424471168 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007f54237abf80 RCX: 00007f542368c0f9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f54236e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffff833d89f R14: 00007f5424471300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
