Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4486E2D8710
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Dec 2020 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgLLONv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Dec 2020 09:13:51 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:38115 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLLONv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Dec 2020 09:13:51 -0500
Received: by mail-il1-f200.google.com with SMTP id e10so9494544ils.5
        for <linux-ext4@vger.kernel.org>; Sat, 12 Dec 2020 06:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XazMq+T2mE11tpZMIR+EQUcLWgHPeuEdA3COL5lTxkY=;
        b=OoVhl9eT6dtU2KmhKCuKwSqN/Y17VZ42aWGDnLjCNe2+Xho9ZhICvY3Nv4wwmBg5U2
         FHNgBHnLsy0JhcyHCKHkgV4MqnorN6Dc5Pcb6GqM3R3q+UQw6FCxRkdSLX0SjOb7aiZt
         YzCBjjLPzNPiFuykiUxDDH7xmdxkLnVnACFUjeX+hxG3LBPIIYQaaRiugKVmRuvGC5KW
         ytgjb9mpnIOA1uqhB+b/5L/kl+VxO2tVVyNjKJDivq/YktjMk1ssUWbWSMkRp5MlFgYT
         hdvwoxBZU+Mbq28VxZr0QMn+yOqYUWsvuBT0SRB3GRWzGQSS6hr0XXE+tYzkNslsbMhQ
         YAnQ==
X-Gm-Message-State: AOAM532pzZxBrWgPMt/vAX3lfGKerS76idSDd2B/ZmsngLlmc4A+DWHK
        JD8yhWD9E1Uj3hbf+MxiiYDJvj8nOxot9AqjZbWVQUZ2lirq
X-Google-Smtp-Source: ABdhPJx106Z6cBdjKm11r36+ybkHIPRmzunIjiryXWeO7CVbyqRJXS3o3WLJEg3f5Vgsye1ThuMO4CF6FJFvWycl+xFaQdqA0WaP
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cb:: with SMTP id r11mr23109652ilq.11.1607782390554;
 Sat, 12 Dec 2020 06:13:10 -0800 (PST)
Date:   Sat, 12 Dec 2020 06:13:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043e88405b6450217@google.com>
Subject: WARNING in ext4_xattr_set_entry
From:   syzbot <syzbot+98b881fdd8ebf45ab4ae@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cd796ed3 Merge tag 'trace-v5.10-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14721287500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e597c2b53c984cd8
dashboard link: https://syzkaller.appspot.com/bug?extid=98b881fdd8ebf45ab4ae
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f703500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13307137500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98b881fdd8ebf45ab4ae@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
ext4 filesystem being mounted at /root/file0 supports timestamps until 2038 (0x7fffffff)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 8454 at fs/ext4/xattr.c:1640 ext4_xattr_set_entry+0x30d0/0x3860 fs/ext4/xattr.c:1640
Modules linked in:
CPU: 1 PID: 8454 Comm: syz-executor801 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_xattr_set_entry+0x30d0/0x3860 fs/ext4/xattr.c:1640
Code: ff ff ff eb 05 e8 20 ad 5c ff 49 bd 00 00 00 00 00 fc ff df 48 8b 1c 24 48 8b ac 24 90 00 00 00 e9 b9 fd ff ff e8 00 ad 5c ff <0f> 0b e9 a1 d6 ff ff 48 8b 7c 24 78 4c 89 e6 e8 5c 81 c8 ff 49 8d
RSP: 0018:ffffc9000142f718 EFLAGS: 00010293
RAX: ffffffff82187230 RBX: 0000000000000000 RCX: ffff88801abc1a40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff92000285f5d R08: ffffffff821848ca R09: ffffffff89600dd0
R10: ffffffff89800000 R11: ffffffff898006be R12: 0000000000000001
R13: dffffc0000000000 R14: ffffc9000142fae8 R15: ffff8880291d9020
FS:  000000000151a880(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560573deec1e CR3: 00000000117d2000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ext4_xattr_block_set+0x386/0x3c50 fs/ext4/xattr.c:1942
 ext4_xattr_set_handle+0xead/0x1ed0 fs/ext4/xattr.c:2390
 ext4_xattr_set+0x1d8/0x310 fs/ext4/xattr.c:2491
 __vfs_setxattr+0x3be/0x400 fs/xattr.c:177
 __vfs_setxattr_noperm+0x11e/0x4b0 fs/xattr.c:208
 vfs_setxattr+0xde/0x270 fs/xattr.c:283
 setxattr+0x167/0x340 fs/xattr.c:548
 path_setxattr+0x109/0x1c0 fs/xattr.c:567
 __do_sys_lsetxattr fs/xattr.c:589 [inline]
 __se_sys_lsetxattr fs/xattr.c:585 [inline]
 __x64_sys_lsetxattr+0xb4/0xd0 fs/xattr.c:585
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4445a9
Code: 8d d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd1c974678 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00000000004445a9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000020000140
RBP: 00000000006cf018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402190
R13: 0000000000402220 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
