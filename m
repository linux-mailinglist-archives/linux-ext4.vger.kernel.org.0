Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813033F150E
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhHSIWB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 04:22:01 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:41510 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbhHSIWA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 04:22:00 -0400
Received: by mail-il1-f200.google.com with SMTP id l4-20020a92d8c40000b02902242b6ea4b3so2841225ilo.8
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 01:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Eb6HoG4IPAl9Hpav/QpD4nHzjmmUxM3oKXoCUI5RFOI=;
        b=c+waCDkwsx4bNGjwU2GVf+5B8jY+4e+EAGx1UEtjVfhQQlpX2NuDAaeZVSSbsHlFSa
         rs5QOYU1j4+NtIcwR4vjYYpSWNglAn+GlYr7NpyitaRHMH+6j9nxkxN5X/E2CTgcshQz
         PFVnz+KNu5jscjKQTboJfH5e6t/762WuvpvLMmY49YFj5s871BCdYYmEjais3vULGcm9
         y3nd3G/ofz8x0EEbjbyQOF+W8+4VYWU2O99oc9eC0NwmDAqpNq0M/cY4Bb9iWbfoehdU
         BTm1P3fy204l5osYHzMCtmKvCNMJyZxQlfP0I3Vk/Y4pW7Z29+vWa0LLJ/Weohto2dEg
         zB+A==
X-Gm-Message-State: AOAM532ohCMGYI7GGSfUJU+gKUBmVSPCjqrPt7Ok/oQJUR3rCND0ECID
        2+TgZgGHAdVF7b0bP6iJBHphrOu394CNkqnOzFQ0mJGRCyPS
X-Google-Smtp-Source: ABdhPJzloMYYTKvTvWQP+CgyF80OEz2uHg7OHiak7fr7GASRIE2ktWk1PVmCQwmwb0b2ZvWkBj2GtrIrbYzU8/l4LKD9aZyuLFrQ
MIME-Version: 1.0
X-Received: by 2002:a92:d741:: with SMTP id e1mr9058698ilq.18.1629361284277;
 Thu, 19 Aug 2021 01:21:24 -0700 (PDT)
Date:   Thu, 19 Aug 2021 01:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f6d2005c9e53c59@google.com>
Subject: [syzbot] kernel BUG in ext4_get_group_info
From:   syzbot <syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    614cb2751d31 Merge tag 'trace-v5.14-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128cfb31300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=e2efa3efc15a1c9e95c3
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122a0161300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com

EXT4-fs error (device loop1): ext4_map_blocks:718: inode #17: block 424: comm syz-executor.1: lblock 296 mapped to illegal pblock 424 (length 1)
------------[ cut here ]------------
kernel BUG at fs/ext4/ext4.h:3295!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10426 Comm: syz-executor.1 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_get_group_info+0x34d/0x350 fs/ext4/ext4.h:3295
Code: 5c ff 8b 74 24 04 48 c7 c7 40 77 88 8c 4c 89 f2 e8 08 9f 05 02 43 80 3c 2c 00 0f 85 6d fd ff ff e9 70 fd ff ff e8 a3 46 5c ff <0f> 0b 90 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 41 89 d5 89 f5
RSP: 0018:ffffc9000c49f320 EFLAGS: 00010293
RAX: ffffffff8223f12d RBX: 00000000fffff95a RCX: ffff88802d923880
RDX: 0000000000000000 RSI: 00000000fffff95a RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffff8223ee48 R09: ffffed1008f9ac2c
R10: ffffed1008f9ac2c R11: 0000000000000000 R12: 1ffff110073d74cf
R13: dffffc0000000000 R14: ffff8880328dc000 R15: ffff888039eba678
FS:  00007fe3035a4700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000002112848 CR3: 0000000033f2d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ext4_mb_load_buddy_gfp+0xc7/0x1370 fs/ext4/mballoc.c:1490
 ext4_discard_preallocations+0x811/0x16a0 fs/ext4/mballoc.c:4940
 ext4_truncate+0xa1a/0xec0 fs/ext4/inode.c:4259
 ext4_truncate_failed_write fs/ext4/truncate.h:20 [inline]
 ext4_write_begin+0xa7b/0x1350 fs/ext4/inode.c:1234
 ext4_da_write_begin+0x384/0x10c0 fs/ext4/inode.c:2960
 generic_perform_write+0x262/0x580 mm/filemap.c:3656
 ext4_buffered_write_iter+0x41c/0x590 fs/ext4/file.c:269
 ext4_file_write_iter+0x8f7/0x1b90 fs/ext4/file.c:519
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0xa39/0xc90 fs/read_write.c:605
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe3035a4188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 000000000d4ba0ff RSI: 00000000200009c0 RDI: 0000000000000007
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffd1a1dd7ef R14: 00007fe3035a4300 R15: 0000000000022000
Modules linked in:
---[ end trace 6608a809acf19a79 ]---
RIP: 0010:ext4_get_group_info+0x34d/0x350 fs/ext4/ext4.h:3295
Code: 5c ff 8b 74 24 04 48 c7 c7 40 77 88 8c 4c 89 f2 e8 08 9f 05 02 43 80 3c 2c 00 0f 85 6d fd ff ff e9 70 fd ff ff e8 a3 46 5c ff <0f> 0b 90 55 41 57 41 56 41 55 41 54 53 48 83 ec 20 41 89 d5 89 f5
RSP: 0018:ffffc9000c49f320 EFLAGS: 00010293
RAX: ffffffff8223f12d RBX: 00000000fffff95a RCX: ffff88802d923880
RDX: 0000000000000000 RSI: 00000000fffff95a RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffff8223ee48 R09: ffffed1008f9ac2c
R10: ffffed1008f9ac2c R11: 0000000000000000 R12: 1ffff110073d74cf
R13: dffffc0000000000 R14: ffff8880328dc000 R15: ffff888039eba678
FS:  00007fe3035a4700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000033f2d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	5c                   	pop    %rsp
   1:	ff 8b 74 24 04 48    	decl   0x48042474(%rbx)
   7:	c7 c7 40 77 88 8c    	mov    $0x8c887740,%edi
   d:	4c 89 f2             	mov    %r14,%rdx
  10:	e8 08 9f 05 02       	callq  0x2059f1d
  15:	43 80 3c 2c 00       	cmpb   $0x0,(%r12,%r13,1)
  1a:	0f 85 6d fd ff ff    	jne    0xfffffd8d
  20:	e9 70 fd ff ff       	jmpq   0xfffffd95
  25:	e8 a3 46 5c ff       	callq  0xff5c46cd
  2a:	0f 0b                	ud2     <-- trapping instruction
  2c:	90                   	nop
  2d:	55                   	push   %rbp
  2e:	41 57                	push   %r15
  30:	41 56                	push   %r14
  32:	41 55                	push   %r13
  34:	41 54                	push   %r12
  36:	53                   	push   %rbx
  37:	48 83 ec 20          	sub    $0x20,%rsp
  3b:	41 89 d5             	mov    %edx,%r13d
  3e:	89 f5                	mov    %esi,%ebp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
