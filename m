Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2E15FC3D5
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Oct 2022 12:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJLKgg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Oct 2022 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJLKgf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Oct 2022 06:36:35 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699BBA24E
        for <linux-ext4@vger.kernel.org>; Wed, 12 Oct 2022 03:36:34 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i4-20020a056e02152400b002fa876e95b3so12974389ilu.17
        for <linux-ext4@vger.kernel.org>; Wed, 12 Oct 2022 03:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=726YeQ3V7M0/A+m5EoxUUeMid2vMENKP8inDN5BryDw=;
        b=ORBbYsyLmkVMqUOspOP+8lCSC/jbkUvtbMdJuPGdIWGrkRGeu5DIObltHDp+CpCJPN
         RFYtWQdrNqI0DDTgvwUb6aH8bAnlVtlnd6bwaOkrNmncMY9+1iEDk9sgRcOPOJ50ewtA
         0e50O2YbY2P7dzedQIYlH2CR6levSvX8/rXZZ7ZbmqQbU5t0zqwYADfwV53ZS/3qoo2u
         qa+IcfvfwCSFDtQjWwN8fR2WWPIo2zwc7sVDdHfD0XywHPzBj7Hp6mLSAa/NAHTEBs0z
         s+ivaml47+X2O/xiNw9UotBcCXRBKPHO8BteDfXqYTz9Ug09RGupvA77ndMjH/dBufa/
         Mbnw==
X-Gm-Message-State: ACrzQf3L7oq2I0oInKqWobqCxEADf+l5xmif5S56TtTnPp9vqXcTk6fj
        YlhCyAgYm/HmDPjaQpWoEbfmVJme592Degoro4RxdbFUEZmO
X-Google-Smtp-Source: AMsMyM59CoUjiALFeu9H4zWQYkUEiBH+XU8QfaBJMX0K7pGWvY2E3AFQjBNohVlhkRPWR9bvjAhQsCKfPQDNFdi5kW11962mlUqD
MIME-Version: 1.0
X-Received: by 2002:a92:cdaf:0:b0:2fa:27e1:727a with SMTP id
 g15-20020a92cdaf000000b002fa27e1727amr14303755ild.135.1665570993987; Wed, 12
 Oct 2022 03:36:33 -0700 (PDT)
Date:   Wed, 12 Oct 2022 03:36:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071e45405ead3f73c@google.com>
Subject: [syzbot] WARNING in ext4_da_release_space
From:   syzbot <syzbot+c740bb18df70ad00952e@syzkaller.appspotmail.com>
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bbd09c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=c740bb18df70ad00952e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b7bfcc880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c59bdc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/70b26613fa58/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c740bb18df70ad00952e@syzkaller.appspotmail.com

EXT4-fs (loop0): Free/Dirty block details
EXT4-fs (loop0): free_blocks=0
EXT4-fs (loop0): dirty_blocks=0
EXT4-fs (loop0): Block reservation details
EXT4-fs (loop0): i_reserved_data_blocks=0
EXT4-fs warning (device loop0): ext4_da_release_space:1527: ext4_da_release_space: ino 18, to_free 1 with only 0 reserved data blocks
------------[ cut here ]------------
WARNING: CPU: 0 PID: 92 at fs/ext4/inode.c:1528 ext4_da_release_space+0x25e/0x370 fs/ext4/inode.c:1524
Modules linked in:
CPU: 0 PID: 92 Comm: kworker/u4:4 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:ext4_da_release_space+0x25e/0x370 fs/ext4/inode.c:1528
Code: a9 ff 4d 8b 07 4c 89 e7 48 c7 c6 87 2d 49 8c ba f7 05 00 00 48 c7 c1 00 90 a3 8a 45 89 f1 31 c0 53 e8 a6 6d 0e 00 48 83 c4 08 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 8a 44 05 00 84 c0 0f 85 da 00
RSP: 0018:ffffc900015f6c90 EFLAGS: 00010296
RAX: 42215896cd52ea00 RBX: 0000000000000000 RCX: 42215896cd52ea00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 1ffff1100e907d96 R08: ffffffff816aa79d R09: fffff520002bece5
R10: fffff520002bece5 R11: 1ffff920002bece4 R12: ffff888021fd2000
R13: ffff88807483ecb0 R14: 0000000000000001 R15: ffff88807483e740
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555569ba628 CR3: 000000000c88e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_es_remove_extent+0x1ab/0x260 fs/ext4/extents_status.c:1461
 mpage_release_unused_pages+0x24d/0xef0 fs/ext4/inode.c:1589
 ext4_writepages+0x12eb/0x3be0 fs/ext4/inode.c:2852
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
 __writeback_single_inode+0xd1/0x670 fs/fs-writeback.c:1587
 writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1870
 wb_writeback+0x41f/0x7b0 fs/fs-writeback.c:2044
 wb_do_writeback fs/fs-writeback.c:2187 [inline]
 wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2227
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
