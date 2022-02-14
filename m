Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8EC4B3F25
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Feb 2022 02:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbiBNB6f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Feb 2022 20:58:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiBNB6b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Feb 2022 20:58:31 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FE9575CC
        for <linux-ext4@vger.kernel.org>; Sun, 13 Feb 2022 17:58:19 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y6-20020a929506000000b002beffccab3bso3528334ilh.22
        for <linux-ext4@vger.kernel.org>; Sun, 13 Feb 2022 17:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JjFWsPUuzBb1VJ9NTYslCq1ep8IWkPz4XiBKHNpnLHM=;
        b=SlvSEiUIl8HdWGQjL+eCS8wn5vRorhXmvvB/T8V3YaIgsVheo1F1uJ7U8wW3BxVMMc
         TXFJLlLc8KBQaXoZqh+CSAe29XycP6vIig5PnVw+1ukgey6KFvSOUX5n8lZA6mlOrMOp
         iBw6bpDOf/UuWavFBt9CfiOWvkORHjhVqNnrqP9q4ArthGmUJg9xqCZBiHP2KRUSeRWJ
         FIdY2gHsB0eEVhAP76q1Q9z2i/QQYa4gJG5JCCorJihdKd8IaDW74U4rYhrqNR6GozM7
         MSq7co8eq60OPImqZSxGjGB1zPh0pH39UvLROCQEWILUvA72dBbudb830pyCKU/nGeOf
         1F5Q==
X-Gm-Message-State: AOAM533wEzyGplyw+uY+eaVg5lw1dm0knqxoEX98y2/Rt+zPP2Vx47bR
        bj3a5++1U6HKie+ZaPQXthyYhswdD2K4nWlsbMxDxV92tTZp
X-Google-Smtp-Source: ABdhPJwrLMeSAOHqeDGc66F+5x2mSKsIRJDitWM/u2eEqVvm4GHcETUppCHmxPO3BdbsrQlAAbAAIgHBwlspYxrFnws/wk2nEXp0
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1409:: with SMTP id k9mr7138106jad.54.1644803898488;
 Sun, 13 Feb 2022 17:58:18 -0800 (PST)
Date:   Sun, 13 Feb 2022 17:58:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000183d9e05d7f0c0ee@google.com>
Subject: [syzbot] kernel BUG in ext4_ind_remove_space
From:   syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>
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

HEAD commit:    ef6b35306dd8 Add linux-next specific files for 20220204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1602d71c700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0431e0b00810b4f
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d31674700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com

EXT4-fs warning (device sda1): ext4_block_to_path:105: block 1074791436 > max in inode 1187
------------[ cut here ]------------
kernel BUG at fs/ext4/indirect.c:1244!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3853 Comm: syz-executor.0 Not tainted 5.17.0-rc2-next-20220204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_ind_remove_space+0xfde/0x1400 fs/ext4/indirect.c:1244
Code: 00 0f 85 36 03 00 00 48 8b 0b 4c 89 fe 44 8b 4c 24 20 48 8b 7c 24 10 48 83 c1 04 e8 6c bb ff ff e9 02 f6 ff ff e8 12 c3 5f ff <0f> 0b 4c 8b 7c 24 50 e9 8e f9 ff ff e8 01 c3 5f ff 48 8b 7c 24 10
RSP: 0018:ffffc90003647ab8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88807acdba80 RSI: ffffffff8218e5de RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff8218d85a R11: 0000000000000000 R12: 0000000000001000
R13: ffffc90003647b68 R14: ffffc90003647b88 R15: ffff88806ccc2a80
FS:  00007f2b2de3d700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2961b6f090 CR3: 000000006d02e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_punch_hole+0xf3e/0x1110 fs/ext4/inode.c:4044
 ext4_fallocate+0x1194/0x3ed0 fs/ext4/extents.c:4694
 vfs_fallocate+0x48d/0xe10 fs/open.c:310
 ksys_fallocate fs/open.c:333 [inline]
 __do_sys_fallocate fs/open.c:341 [inline]
 __se_sys_fallocate fs/open.c:339 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:339
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2b2e6c8059
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2b2de3d168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f2b2e7daf60 RCX: 00007f2b2e6c8059
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000005
RBP: 00007f2b2e72208d R08: 0000000000000000 R09: 0000000000000000
R10: 00000ffeffeff000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcd330bbaf R14: 00007f2b2de3d300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ind_remove_space+0xfde/0x1400 fs/ext4/indirect.c:1244
Code: 00 0f 85 36 03 00 00 48 8b 0b 4c 89 fe 44 8b 4c 24 20 48 8b 7c 24 10 48 83 c1 04 e8 6c bb ff ff e9 02 f6 ff ff e8 12 c3 5f ff <0f> 0b 4c 8b 7c 24 50 e9 8e f9 ff ff e8 01 c3 5f ff 48 8b 7c 24 10
RSP: 0018:ffffc90003647ab8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88807acdba80 RSI: ffffffff8218e5de RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff8218d85a R11: 0000000000000000 R12: 0000000000001000
R13: ffffc90003647b68 R14: ffffc90003647b88 R15: ffff88806ccc2a80
FS:  00007f2b2de3d700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020200000 CR3: 000000006d02e000 CR4: 00000000003506f0
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
