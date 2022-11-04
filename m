Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62272619D12
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Nov 2022 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKDQXv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Nov 2022 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKDQXp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Nov 2022 12:23:45 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80DFDA
        for <linux-ext4@vger.kernel.org>; Fri,  4 Nov 2022 09:23:43 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id 15-20020a056e0220cf00b0030099e75602so4138781ilq.21
        for <linux-ext4@vger.kernel.org>; Fri, 04 Nov 2022 09:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTWPEbO/ykIic7pHU+hcEuKyktIGyGHMpQy7LQ2p3V4=;
        b=2gcLN/qcrG7vuvV6nql8dIgMywFbBQkeP9scWZNWBcSro4cX+UH7+fO5+dl6GvpdEO
         ewdFP1prk6zqU/08uGwZXlvJ+j7LToYoaEJsCY5g7jrIuiN8kDYSB5XJCf1k7TgguhD8
         8IKXJDS+uuD0fToab4rA9pMjeTb+3z5cfu99rcnoYCKEa8cUbDeqBuhGg34dCJTkVeS1
         iBdRSfy8tQb6g/dMgeaLpNwvs0mZmh0p1gMvWU/kbN6XWpeYr4qgYGVsXZn/VL4lFaGV
         6ismtXWlZyfk7nlTRxD9Em4fEs94qX0SRTJT7OuPlME9HHUH9RsUTXfmEzQctnsYnNjm
         piBQ==
X-Gm-Message-State: ACrzQf0IlTQAmLfHDP53U1aQ8xxAEaVasR6RyPoD39+dpYMfXfRBgw81
        3pVitM6CHFs6bokuZFcRSTGPgu7D5xZ8QL4bayXnG6yaXfFg
X-Google-Smtp-Source: AMsMyM7wt8+0ov4Wtc+UITQX3Dd1/57ISzUGXZZ2wHXoV+VJLxlqahBGInfpF6zeVmzvyYu+t4adwQU1Y32UE1NRGAX+ZwaqHAXg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:2fc:636c:e233 with SMTP id
 v13-20020a056e02164d00b002fc636ce233mr20857341ilu.251.1667579023197; Fri, 04
 Nov 2022 09:23:43 -0700 (PDT)
Date:   Fri, 04 Nov 2022 09:23:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000500ba305eca77f88@google.com>
Subject: [syzbot] WARNING in ext4_xattr_block_set
From:   syzbot <syzbot+98346927678ac3059c77@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=120f2c0e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=98346927678ac3059c77
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168cc339880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119ac77a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4dd9a1b9ecac/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98346927678ac3059c77@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
EXT4-fs: Journaled quota options ignored when QUOTA feature is enabled
EXT4-fs (loop0): mounted filesystem without journal. Quota mode: writeback.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3611 at fs/ext4/xattr.c:2069 ext4_xattr_block_set+0x315f/0x3920
Modules linked in:
CPU: 0 PID: 3611 Comm: syz-executor383 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:ext4_xattr_block_set+0x315f/0x3920 fs/ext4/xattr.c:2069
Code: f0 41 ff 48 8b 7c 24 58 4c 89 fe e8 fb 64 c2 ff 45 31 e4 e9 24 f5 ff ff e8 7e f0 41 ff 45 31 e4 e9 17 f5 ff ff e8 71 f0 41 ff <0f> 0b e9 4e f2 ff ff e8 65 f0 41 ff 0f 0b e9 22 df ff ff 44 89 f9
RSP: 0018:ffffc90003e6f0a0 EFLAGS: 00010293
RAX: ffffffff8245df6f RBX: ffffc90003e6f1e8 RCX: ffff888023aa8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc90003e6f2f0 R08: ffffffff820bd909 R09: ffffed1005342b23
R10: ffffed1005342b23 R11: 1ffff11005342b22 R12: ffff888075fcd2f0
R13: dffffc0000000000 R14: 0000000000000000 R15: 1ffff11004ba8405
FS:  0000555556b01300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559471603278 CR3: 000000007bbfe000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_xattr_move_to_block fs/ext4/xattr.c:2604 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2673 [inline]
 ext4_expand_extra_isize_ea+0x137b/0x1cd0 fs/ext4/xattr.c:2765
 __ext4_expand_extra_isize+0x2b8/0x3f0 fs/ext4/inode.c:5857
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5900 [inline]
 __ext4_mark_inode_dirty+0x51a/0x670 fs/ext4/inode.c:5978
 ext4_rename fs/ext4/namei.c:3907 [inline]
 ext4_rename2+0x2936/0x4760 fs/ext4/namei.c:4169
 vfs_rename+0xd53/0x1130 fs/namei.c:4778
 do_renameat2+0xb53/0x1370 fs/namei.c:4929
 __do_sys_rename fs/namei.c:4975 [inline]
 __se_sys_rename fs/namei.c:4973 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4973
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f400cc61b29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe83d770a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f400cc61b29
RDX: 00007f400cc20023 RSI: 00000000200000c0 RDI: 0000000020000080
RBP: 00007f400cc212f0 R08: 00007ffe83d76fa0 R09: 0000000000000000
R10: 00007ffe83d76f70 R11: 0000000000000246 R12: 00007f400cc21380
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
