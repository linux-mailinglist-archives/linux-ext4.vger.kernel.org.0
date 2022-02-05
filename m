Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031B74AAC59
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Feb 2022 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355151AbiBETua (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Feb 2022 14:50:30 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:55011 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiBETua (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Feb 2022 14:50:30 -0500
Received: by mail-io1-f69.google.com with SMTP id k20-20020a5d91d4000000b0061299fad2fdso5983435ior.21
        for <linux-ext4@vger.kernel.org>; Sat, 05 Feb 2022 11:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Pbli/zQZbI/e8abqX3qPdH10otwvl66OLiSLsnZ1wuk=;
        b=mW+R2oHzSDm4QOeF6sdIVXXnKA4Qsd0oLonPkuwQuuJJblQOJZtMrduwzZsY33Ph1D
         52wRXXcQJ10j8aILa4Wi37pnEPIdvua/53j1KvG4yIAAykA4ucpRTOloLXJUpPCwjpa0
         7nTyTAdSge0cjdPkKAFVTLwSaP+a7BBCmbY8xb0EULBKCT38AwrwrKTtvoM49BBeDJ9L
         qc5C5zsRRVvAhEKakyMkUr5tuBJoCPvyHSFRBmcNDAoP6vX0m2wVnUjAU64KeYZFo7f3
         HPP/mxHH9WbyXeVTvHcI20sIYVnuIjno5IVmRLff8+NZw/SwMg6QMBh4ct/ubJUtNdNF
         Um7Q==
X-Gm-Message-State: AOAM530EODrNX1Yls5tV96OBCE1Px/strD1tgABy5wE7g2xoa4YQAlqt
        VB49u/ItROmycmPVOw49tL3yJ6jOCHeD0nDYPDn5q/36egg8
X-Google-Smtp-Source: ABdhPJxsqU2+4I+Y558rOIAcUGrzYJIhMIp++rKydhM04pu8XCcKESAedR6b/OIizbSLp9k9qOFF52y4GPh01mwe43XxF47o0ZfW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:: with SMTP id s6mr2453788ilu.301.1644090629623;
 Sat, 05 Feb 2022 11:50:29 -0800 (PST)
Date:   Sat, 05 Feb 2022 11:50:29 -0800
In-Reply-To: <0000000000001e0ba105d5c2dede@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f517d505d74aad30@google.com>
Subject: Re: [syzbot] general protection fault in ext4_fill_super
From:   syzbot <syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    0457e5153e0e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146d12b4700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd57c0f940a9a1ec
dashboard link: https://syzkaller.appspot.com/bug?extid=138c9e58e3cb22eae3b4
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f7004fb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178cf108700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+138c9e58e3cb22eae3b4@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 0 PID: 3603 Comm: syz-executor131 Not tainted 5.17.0-rc2-syzkaller-00316-g0457e5153e0e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_fill_super+0x247/0x770 fs/ext4/super.c:5550
Code: 3b 4c 89 6c 24 20 49 8d bd a8 06 00 00 be 2f 00 00 00 ba 21 00 00 00 e8 87 5a d9 01 4d 8d af 90 00 00 00 4d 89 ec 49 c1 ec 03 <41> 80 3c 2c 00 74 08 4c 89 ef e8 ca 7d 96 ff 49 c7 45 00 01 00 00
RSP: 0018:ffffc9000284fbe8 EFLAGS: 00010206
RAX: ffff8880217dc6ac RBX: ffff88801c4048f0 RCX: ffff88807d4b9d00
RDX: 0000000000000000 RSI: 000000000000002f RDI: 0000000000000035
RBP: dffffc0000000000 R08: ffffffff84142d6e R09: fffffbfff197f79f
R10: fffffbfff197f79f R11: 0000000000000000 R12: 0000000000000012
R13: 0000000000000090 R14: ffff888014784f00 R15: 0000000000000000
FS:  00005555563943c0(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001c361000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_tree_bdev+0x406/0x630 fs/super.c:1292
 vfs_get_tree+0x86/0x270 fs/super.c:1497
 do_new_mount fs/namespace.c:2994 [inline]
 path_mount+0x1986/0x2c30 fs/namespace.c:3324
 do_mount fs/namespace.c:3337 [inline]
 __do_sys_mount fs/namespace.c:3545 [inline]
 __se_sys_mount+0x308/0x3c0 fs/namespace.c:3522
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb3d4cbca49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0c4f4df8 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb3d4cbca49
RDX: 0000000020000100 RSI: 00000000200000c0 RDI: 0000000020000080
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000003636
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc0c4f4e00
R13: 00007ffc0c4f4ea0 R14: 00007ffc0c4f4e60 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_fill_super+0x247/0x770 fs/ext4/super.c:5550
Code: 3b 4c 89 6c 24 20 49 8d bd a8 06 00 00 be 2f 00 00 00 ba 21 00 00 00 e8 87 5a d9 01 4d 8d af 90 00 00 00 4d 89 ec 49 c1 ec 03 <41> 80 3c 2c 00 74 08 4c 89 ef e8 ca 7d 96 ff 49 c7 45 00 01 00 00
RSP: 0018:ffffc9000284fbe8 EFLAGS: 00010206

RAX: ffff8880217dc6ac RBX: ffff88801c4048f0 RCX: ffff88807d4b9d00
RDX: 0000000000000000 RSI: 000000000000002f RDI: 0000000000000035
----------------
Code disassembly (best guess):
   0:	3b 4c 89 6c          	cmp    0x6c(%rcx,%rcx,4),%ecx
   4:	24 20                	and    $0x20,%al
   6:	49 8d bd a8 06 00 00 	lea    0x6a8(%r13),%rdi
   d:	be 2f 00 00 00       	mov    $0x2f,%esi
  12:	ba 21 00 00 00       	mov    $0x21,%edx
  17:	e8 87 5a d9 01       	callq  0x1d95aa3
  1c:	4d 8d af 90 00 00 00 	lea    0x90(%r15),%r13
  23:	4d 89 ec             	mov    %r13,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	41 80 3c 2c 00       	cmpb   $0x0,(%r12,%rbp,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 ca 7d 96 ff       	callq  0xff967e03
  39:	49                   	rex.WB
  3a:	c7                   	.byte 0xc7
  3b:	45 00 01             	add    %r8b,(%r9)

