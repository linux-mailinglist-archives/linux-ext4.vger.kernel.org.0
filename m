Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA76A71C8
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCAREU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 12:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCARET (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 12:04:19 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A843919
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 09:04:06 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y14-20020a92c74e000000b003157134a9fbso8153904ilp.2
        for <linux-ext4@vger.kernel.org>; Wed, 01 Mar 2023 09:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ijtyYwUSpPiADlS8jXaq8RNP7rAhwQrJbgxXtqNnsk=;
        b=aNUqPIv2eZJxWrGGkC84egX1QyZQSK6WTKLLUs4CbwVQNfdYBNygO81E0oyi2ZkKmg
         ntcwrSttaJhp66LiYq11HsrV3dCCQ0D2wUrS2aBzgVjH0F0hEbQecxj0iVNkAI14pr9e
         bsevLU2Tajrxm113axuwlzmYGnYvOGy8IASDYpc+cItSQipCpKAhtM6MHawvombU3UVg
         ANOMbSHXMt11JTofSR6zuYLQ5RrcEvayXAgxA5l7wJFim6qqLa6JwpwUAzKXsK6BBFTM
         kcJNZ9cpXsVjcM7pwm+0SDD1S3wUlnIkEyH1ZBIL8MAXyJHLbqfKLTotpgpiQRrQ0QIJ
         TUvA==
X-Gm-Message-State: AO0yUKWoEVbpTeNRi7Ydzwp3Jn+epn1xemEmnSInHHk+NrivbyQs1ZBt
        2d0GNgsk5SsVIYM1U9YlmaYHsE5IrjlCPftigtZRejn980xy
X-Google-Smtp-Source: AK7set8uFRynAEITgWsfrGesrBup2CAk3VxbpWdX/bYU859iY/Hj9DUIPdja/medu71lSLKEl+EqARAhgw2v71t/elag0Fpb4znZ
MIME-Version: 1.0
X-Received: by 2002:a02:3312:0:b0:3c4:dda2:da6e with SMTP id
 c18-20020a023312000000b003c4dda2da6emr3316494jae.4.1677690246030; Wed, 01 Mar
 2023 09:04:06 -0800 (PST)
Date:   Wed, 01 Mar 2023 09:04:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000286e1a05f5d9b3c6@google.com>
Subject: [syzbot] [ext4?] memory leak in ext4_expand_extra_isize_ea
From:   syzbot <syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    c0927a7a5391 Merge tag 'xfs-6.3-merge-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d973a8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5733ca1757172ad
dashboard link: https://syzkaller.appspot.com/bug?extid=0d042627c4f2ad332195
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16598c22c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12376874c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5732f39d793/disk-c0927a7a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a0b9fb85e380/vmlinux-c0927a7a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f4253a65ff3/bzImage-c0927a7a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2162c5bd66e2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810658dc00 (size 1024):
  comm "syz-executor463", pid 5080, jiffies 4294961132 (age 13.510s)
  hex dump (first 32 bytes):
    00 fb 8e 00 00 cf e8 9e ac aa 80 5a e1 26 a9 9c  ...........Z.&..
    71 e3 ea 67 33 7f 9a ef ca d1 17 51 5c 7f 0e 4b  q..g3......Q\..K
  backtrace:
    [<ffffffff8153410d>] __do_kmalloc_node mm/slab_common.c:966 [inline]
    [<ffffffff8153410d>] __kmalloc_node+0x4d/0x120 mm/slab_common.c:974
    [<ffffffff81523dd2>] kmalloc_node include/linux/slab.h:610 [inline]
    [<ffffffff81523dd2>] kvmalloc_node+0xa2/0x180 mm/util.c:603
    [<ffffffff8188b446>] kvmalloc include/linux/slab.h:737 [inline]
    [<ffffffff8188b446>] ext4_xattr_move_to_block fs/ext4/xattr.c:2635 [inline]
    [<ffffffff8188b446>] ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
    [<ffffffff8188b446>] ext4_expand_extra_isize_ea+0x786/0xb80 fs/ext4/xattr.c:2835
    [<ffffffff8181539b>] __ext4_expand_extra_isize+0x18b/0x200 fs/ext4/inode.c:5955
    [<ffffffff8181fa55>] ext4_try_to_expand_extra_isize fs/ext4/inode.c:5998 [inline]
    [<ffffffff8181fa55>] __ext4_mark_inode_dirty+0x245/0x370 fs/ext4/inode.c:6076
    [<ffffffff818942fe>] ext4_set_acl+0x21e/0x340 fs/ext4/acl.c:263
    [<ffffffff8170e672>] set_posix_acl+0x112/0x150 fs/posix_acl.c:956
    [<ffffffff8170eb72>] vfs_set_acl+0x2b2/0x4a0 fs/posix_acl.c:1098
    [<ffffffff81710ea0>] do_set_acl+0x90/0x140 fs/posix_acl.c:1247
    [<ffffffff81690a63>] do_setxattr+0x73/0xf0 fs/xattr.c:606
    [<ffffffff81690b9d>] setxattr+0xbd/0xe0 fs/xattr.c:632
    [<ffffffff81690cd8>] path_setxattr+0x118/0x130 fs/xattr.c:651
    [<ffffffff81690d79>] __do_sys_lsetxattr fs/xattr.c:674 [inline]
    [<ffffffff81690d79>] __se_sys_lsetxattr fs/xattr.c:670 [inline]
    [<ffffffff81690d79>] __x64_sys_lsetxattr+0x29/0x30 fs/xattr.c:670
    [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
