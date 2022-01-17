Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAA4903A8
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jan 2022 09:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiAQIXb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jan 2022 03:23:31 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:49901 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiAQIXa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jan 2022 03:23:30 -0500
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso9158617iov.16
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jan 2022 00:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QxKMT5LAEmZnn1r9W6tJTXOl8V4rMwLHQiGSEFo1LBI=;
        b=aqijjs3iJh2SR4a3hFJefwslzVMRMRnCRVvpoX9ilvAEw2ZHqkzNSZqaeAOL/WKoSO
         xYpOwrXIrCldaCg/Af41AkCuwiJ9jz7kBUKT8m4nSWX0ndgosKdL00kf9FODHfwKBFTL
         tIgnQ6RIKaouU8KgzwRDLqCXiCGyMW78KPCuFaG46vge+YKxLLMYIvzOv0tuByOq+tSK
         7c0udIrVf1p3ealdp2Y2wRVxGIR+/7xL9u4HZLXyKQy7VtNtMd3AtGDb3GlV+lRQmt73
         AzSfBhkIv+8g86tCrMt9lG36G3ua8Gs0Es07JozhnYKcF50sI9/fmAo9PQNcpg5hS/KJ
         35LQ==
X-Gm-Message-State: AOAM531NCNPuirto2QQVjvTiR0fDKbz9vt2BOCTj+9LPRxYBToGDnEcv
        5xmxuVOu51QtElo0Pk4UE8U7Msr5/b2kWpN6KfGF0SI/HMSI
X-Google-Smtp-Source: ABdhPJymNz+PB5dyl0t/6clsWCsNl1aXfQ2IWqsnKuGaxrLcEhBn6C53z43D7zU3uErX+5g6St0xkeMCJeyiUxJ792SY7E922wiP
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22bb:: with SMTP id z27mr454733jas.199.1642407810434;
 Mon, 17 Jan 2022 00:23:30 -0800 (PST)
Date:   Mon, 17 Jan 2022 00:23:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e0ba105d5c2dede@google.com>
Subject: [syzbot] general protection fault in ext4_fill_super
From:   syzbot <syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    daadb3bd0e8d Merge tag 'locking_core_for_v5.17_rc1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122fc6f7b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec2807b2e9360dbb
dashboard link: https://syzkaller.appspot.com/bug?extid=138c9e58e3cb22eae3b4
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com

RBP: 00007f283db0b1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffb1b01d5f R14: 00007f283db0b300 R15: 0000000000022000
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 0 PID: 32175 Comm: syz-executor.3 Not tainted 5.16.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_fill_super+0x240/0x770 fs/ext4/super.c:5551
Code: 3b 4c 89 6c 24 20 49 8d bd a8 06 00 00 be 2f 00 00 00 ba 21 00 00 00 e8 5e 6d d8 01 4d 8d af 90 00 00 00 4d 89 ec 49 c1 ec 03 <41> 80 3c 2c 00 74 08 4c 89 ef e8 11 4e 97 ff 49 c7 45 00 01 00 00
RSP: 0018:ffffc9000b5cfbe8 EFLAGS: 00010206
RAX: ffff8880234c46ac RBX: ffff888090bc7cf0 RCX: 0000000000040000
RDX: ffffc9000abd9000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: dffffc0000000000 R08: ffffffff8411122e R09: fffffbfff197f727
R10: fffffbfff197f727 R11: 0000000000000000 R12: 0000000000000012
R13: 0000000000000090 R14: ffff888071347b00 R15: 0000000000000000
FS:  00007f283db0b700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6db90cb558 CR3: 000000008fafc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_tree_bdev+0x406/0x630 fs/super.c:1295
 vfs_get_tree+0x86/0x270 fs/super.c:1500
 do_new_mount fs/namespace.c:2994 [inline]
 path_mount+0x1986/0x2c30 fs/namespace.c:3324
 do_mount fs/namespace.c:3337 [inline]
 __do_sys_mount fs/namespace.c:3545 [inline]
 __se_sys_mount+0x308/0x3c0 fs/namespace.c:3522
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f283f195eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f283db0b168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f283f2a8f60 RCX: 00007f283f195eb9
RDX: 0000000020000240 RSI: 0000000020000000 RDI: 0000000020000100
RBP: 00007f283db0b1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fffb1b01d5f R14: 00007f283db0b300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 2017ba6e0452af99 ]---
RIP: 0010:ext4_fill_super+0x240/0x770 fs/ext4/super.c:5551
Code: 3b 4c 89 6c 24 20 49 8d bd a8 06 00 00 be 2f 00 00 00 ba 21 00 00 00 e8 5e 6d d8 01 4d 8d af 90 00 00 00 4d 89 ec 49 c1 ec 03 <41> 80 3c 2c 00 74 08 4c 89 ef e8 11 4e 97 ff 49 c7 45 00 01 00 00
RSP: 0018:ffffc9000b5cfbe8 EFLAGS: 00010206
RAX: ffff8880234c46ac RBX: ffff888090bc7cf0 RCX: 0000000000040000
RDX: ffffc9000abd9000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: dffffc0000000000 R08: ffffffff8411122e R09: fffffbfff197f727
R10: fffffbfff197f727 R11: 0000000000000000 R12: 0000000000000012
R13: 0000000000000090 R14: ffff888071347b00 R15: 0000000000000000
FS:  00007f283db0b700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8eb615a718 CR3: 000000008fafc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3b 4c 89 6c          	cmp    0x6c(%rcx,%rcx,4),%ecx
   4:	24 20                	and    $0x20,%al
   6:	49 8d bd a8 06 00 00 	lea    0x6a8(%r13),%rdi
   d:	be 2f 00 00 00       	mov    $0x2f,%esi
  12:	ba 21 00 00 00       	mov    $0x21,%edx
  17:	e8 5e 6d d8 01       	callq  0x1d86d7a
  1c:	4d 8d af 90 00 00 00 	lea    0x90(%r15),%r13
  23:	4d 89 ec             	mov    %r13,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	41 80 3c 2c 00       	cmpb   $0x0,(%r12,%rbp,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 11 4e 97 ff       	callq  0xff974e4a
  39:	49                   	rex.WB
  3a:	c7                   	.byte 0xc7
  3b:	45 00 01             	add    %r8b,(%r9)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
