Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F175F3EC6
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiJDItp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJDItn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 04:49:43 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497E46140
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 01:49:42 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so3683208ilv.8
        for <linux-ext4@vger.kernel.org>; Tue, 04 Oct 2022 01:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/PeBeJ9PvoaX/tN0wI1nZ1CngK1R3YgpjgnVA4j3pJY=;
        b=Vtazcp1O/PEDViiWkUyoFY2i6S2lFOL2h5nPccDUdixQGgJJyjwE2jdft3H8IaJCBy
         9Bt8L/7skXvU4+dRqH1IUoK/5xOXns00u2z8fyX0I2S0crYC4Ax9xB9TGVILeXyVap7E
         Iu5my9H4XZZvRnMCq9AFYSoZPg5JzeatQMDFyEIDXVvo2mF6BWoOVB7ROQ497TceEs+U
         c0uKZwoqxiLaZBVDtcLiinM1EysKZdMkmTALQilZsTSEveAYCt60dxWiwKwJSsLWWVgy
         X2h/SBUUiCAC69M4Bm6YJJk7yHfXNmCYhJET1GHrEoYhcmQ6Nyvtpx6I9MUsX7V/xP8Z
         jYlA==
X-Gm-Message-State: ACrzQf0B/3ZVEx6BeTDDs2cyuwPa1Bq4b43peHbc4ImU6c1D7fhKDDlC
        ng/8bGCaZC4dOKh+S0kUYhzyd7Ky7T/i9GbZQ+7K0CzgIRZ1
X-Google-Smtp-Source: AMsMyM7ytwCWjCpC0I6GuQpheAUGws1iXQO3qra0vx3L/JjJYj5CWq7xMuKWSfsNqfOkGRa9XyMXDeBAji3dCrZHrHk3owdrDiGh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1504:b0:35a:2767:bf1a with SMTP id
 b4-20020a056638150400b0035a2767bf1amr12803586jat.76.1664873381684; Tue, 04
 Oct 2022 01:49:41 -0700 (PDT)
Date:   Tue, 04 Oct 2022 01:49:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082ed3805ea318a4a@google.com>
Subject: [syzbot] kernel BUG in ext4_mb_use_inode_pa
From:   syzbot <syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com>
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

HEAD commit:    4fe89d07dcc2 Linux 6.0
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15110d48880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48b99eaecc2b324f
dashboard link: https://syzkaller.appspot.com/bug?extid=4998f18bcd5fc7e40c8b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119bc15c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d97bc0880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce1d9b74a5e0/disk-4fe89d07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06e7c02fa7ba/vmlinux-4fe89d07.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4998f18bcd5fc7e40c8b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:4294!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3613 Comm: syz-executor426 Not tainted 6.0.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:ext4_mb_use_inode_pa+0x5f0/0x650 fs/ext4/mballoc.c:4294
Code: 48 c7 c7 a0 16 cb 8c 4c 89 e6 48 89 ea e8 98 1d 2b 02 e9 42 fd ff ff e8 de d7 50 ff 0f 0b e8 d7 d7 50 ff 0f 0b e8 d0 d7 50 ff <0f> 0b 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 0f 8c 58 ff ff ff 48 8b
RSP: 0018:ffffc9000379e7c8 EFLAGS: 00010293
RAX: ffffffff8236b1b0 RBX: 00000000ffffffff RCX: ffff888024fcd880
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: 1ffff1100e86149d R08: ffffffff8236af2b R09: ffffed100e86149b
R10: ffffed100e86149b R11: 1ffff1100e86149a R12: 0000000000000080
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88807430a4e8
FS:  00007f16182da700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002658b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_use_preallocated+0xcfd/0xf20 fs/ext4/mballoc.c:4392
 ext4_mb_new_blocks+0x539/0x3e80 fs/ext4/mballoc.c:5602
 ext4_ext_map_blocks+0x17b4/0x65b0 fs/ext4/extents.c:4285
 ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:645
 ext4_iomap_alloc fs/ext4/inode.c:3407 [inline]
 ext4_iomap_begin+0x8e3/0xd20 fs/ext4/inode.c:3457
 iomap_iter+0x606/0x8a0 fs/iomap/iter.c:74
 __iomap_dio_rw+0x16e7/0x20d0 fs/iomap/direct-io.c:601
 iomap_dio_rw+0x42/0xa0 fs/iomap/direct-io.c:690
 ext4_dio_write_iter fs/ext4/file.c:566 [inline]
 ext4_file_write_iter+0x168f/0x1ad0 fs/ext4/file.c:677
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 iter_file_splice_write+0x7fc/0xfc0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f161834f729
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f16182da2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f16183d5410 RCX: 00007f161834f729
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f16183a1cf4 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffa R11: 0000000000000246 R12: 00007f16183a18d0
R13: 00007f16183a10a8 R14: 0030656c69662f2e R15: 00007f16183d5418
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_use_inode_pa+0x5f0/0x650 fs/ext4/mballoc.c:4294
Code: 48 c7 c7 a0 16 cb 8c 4c 89 e6 48 89 ea e8 98 1d 2b 02 e9 42 fd ff ff e8 de d7 50 ff 0f 0b e8 d7 d7 50 ff 0f 0b e8 d0 d7 50 ff <0f> 0b 48 8b 0c 24 80 e1 07 80 c1 03 38 c1 0f 8c 58 ff ff ff 48 8b
RSP: 0018:ffffc9000379e7c8 EFLAGS: 00010293
RAX: ffffffff8236b1b0 RBX: 00000000ffffffff RCX: ffff888024fcd880
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: 1ffff1100e86149d R08: ffffffff8236af2b R09: ffffed100e86149b
R10: ffffed100e86149b R11: 1ffff1100e86149a R12: 0000000000000080
R13: dffffc0000000000 R14: 0000000000000002 R15: ffff88807430a4e8
FS:  00007f16182da700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000002658b000 CR4: 00000000003506e0
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
