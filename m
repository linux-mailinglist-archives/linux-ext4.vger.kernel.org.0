Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173D4B322F
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Feb 2022 01:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbiBLAr2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Feb 2022 19:47:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiBLAr2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Feb 2022 19:47:28 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37650D79
        for <linux-ext4@vger.kernel.org>; Fri, 11 Feb 2022 16:47:26 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id q24-20020a5d8358000000b006133573a011so7439851ior.23
        for <linux-ext4@vger.kernel.org>; Fri, 11 Feb 2022 16:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jc30QT8f4scBqobRyundyPLPktYc4x+ym4PxvVJOVaQ=;
        b=GbT0H5UM8Pwi6UNXEZ0BTLYdU0mjRKVK3p4UzQGLWbKtvSyMRvo0DgS202mO78Jjzy
         Vm24wKkaiIHlasMh2keFZ6xZMWHvSnq2eRF+Gak8EiqREcC1UD60InUvZ82uzuTva6ll
         I2zKSoKjm7tvLNZmDxqlVrXQ1PArqHiBy1B0stX5Vrmud67UYHxPQ/ULH5Ds77+jQtRO
         DlN8RiCstQk8zaVJh9h339QvyjABsWHqkEnJ25pGKZmfg6F0pLIueNQwDAQj/meb42K+
         Dn6RaRd7jgHvAo3szNn0oixdHcJ58kW8ClPai84VR1qjvlq1f+jtsc9b17RWaqKbacgs
         QU2Q==
X-Gm-Message-State: AOAM533ifvpd3qlQnTmcTinwrnzlK29Jic63r7pGI0wpCbXWBgJNjX0S
        o4mUsblU6sK0MG6NZCt8nXvxEoRIDLApiI8px1Hvp7y3MY5a
X-Google-Smtp-Source: ABdhPJwzmLaA6z4T0Ml6/moeuB4bOqH/jbhfXiUsB/fuH7IvFqBI/RTZntQot8i+hPVsQaUTF/Yit1eeI8JlOf9xYw9HnZZkEGBR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0a:: with SMTP id s10mr2159849ild.297.1644626845549;
 Fri, 11 Feb 2022 16:47:25 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:47:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eacb0205d7c7865e@google.com>
Subject: [syzbot] WARNING in ext4_write_inode (2)
From:   syzbot <syzbot+748cc361874fca7d33cc@syzkaller.appspotmail.com>
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

HEAD commit:    1d41d2e82623 Merge tag 'riscv-for-linus-5.17-rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ca859a700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
dashboard link: https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+748cc361874fca7d33cc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3846 at fs/ext4/inode.c:5160 ext4_write_inode+0x333/0x5a0 fs/ext4/inode.c:5160
Modules linked in:
CPU: 0 PID: 3846 Comm: syz-executor.1 Not tainted 5.17.0-rc3-syzkaller-00188-g1d41d2e82623 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_write_inode+0x333/0x5a0 fs/ext4/inode.c:5160
Code: b6 04 02 84 c0 74 08 3c 03 0f 8e 46 02 00 00 8b b5 b0 06 00 00 4c 89 f7 e8 fa 3a 12 00 41 89 c4 e9 ed fd ff ff e8 dd fa 63 ff <0f> 0b 45 31 e4 e9 de fd ff ff e8 ce fa 63 ff 48 89 ef 48 8d 74 24
RSP: 0018:ffffc9000283f2d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff92000507e5b RCX: 0000000000000000
RDX: ffff888076c10000 RSI: ffffffff82147d63 RDI: 0000000000000003
RBP: ffff88805722b478 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff82147ae1 R11: 0000000000000000 R12: 0000000000000800
R13: ffffc9000283f438 R14: dffffc0000000000 R15: ffff88805722b4a0
FS:  0000555556fd9400(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33346000 CR3: 000000006020a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1471 [inline]
 __writeback_single_inode+0xb70/0x10d0 fs/fs-writeback.c:1683
 writeback_single_inode+0x2a5/0x460 fs/fs-writeback.c:1739
 write_inode_now+0x15c/0x1d0 fs/fs-writeback.c:2739
 iput_final fs/inode.c:1731 [inline]
 iput.part.0+0x460/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:745 [inline]
 dput+0x64d/0xbd0 fs/dcache.c:913
 ovl_destroy_inode+0x38/0x110 fs/overlayfs/super.c:207
 destroy_inode+0xc4/0x1b0 fs/inode.c:310
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 shrink_dentry_list+0x128/0x490 fs/dcache.c:1201
 prune_dcache_sb+0xe7/0x140 fs/dcache.c:1282
 super_cache_scan+0x336/0x590 fs/super.c:104
 do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:773
 shrink_slab_memcg mm/vmscan.c:842 [inline]
 shrink_slab+0x3ee/0x6f0 mm/vmscan.c:921
 shrink_node_memcgs mm/vmscan.c:3172 [inline]
 shrink_node+0x8c1/0x1eb0 mm/vmscan.c:3293
 shrink_zones mm/vmscan.c:3530 [inline]
 do_try_to_free_pages+0x376/0x1700 mm/vmscan.c:3588
 try_to_free_mem_cgroup_pages+0x2cd/0x840 mm/vmscan.c:3902
 reclaim_high.constprop.0+0x190/0x250 mm/memcontrol.c:2300
 mem_cgroup_handle_over_high+0x18c/0x540 mm/memcontrol.c:2484
 tracehook_notify_resume include/linux/tracehook.h:197 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x1ab/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1bc5ba24c7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd48f9e3c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffea RBX: 0000000000000000 RCX: 00007f1bc5ba24c7
RDX: 00007ffd48f9e49d RSI: 000000000000000a RDI: 00007ffd48f9e490
RBP: 00007ffd48f9e490 R08: 00000000ffffffff R09: 00007ffd48f9e260
R10: 0000555556fda893 R11: 0000000000000246 R12: 00007f1bc5bfa1ea
R13: 00007ffd48f9f550 R14: 0000555556fda810 R15: 00007ffd48f9f590
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
