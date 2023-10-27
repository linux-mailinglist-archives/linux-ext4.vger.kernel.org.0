Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225227D8DF6
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Oct 2023 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjJ0FFc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Oct 2023 01:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0FFc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Oct 2023 01:05:32 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0961B2
        for <linux-ext4@vger.kernel.org>; Thu, 26 Oct 2023 22:05:26 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1ef4782ef93so1997365fac.1
        for <linux-ext4@vger.kernel.org>; Thu, 26 Oct 2023 22:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698383126; x=1698987926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rh0KXsNpRxx6btHgAIMOlmjDzMCaNEDaLetNUfJyvkc=;
        b=vmcz65vRbstSlALuqhah/N07gKcoBq0+c7BMl+zP/yeJ4xWD61jP+3Zc6Cwpdj2yDB
         YjEap543tuD2tLz5HT7BmL9kJsu6gnVXBtgJvLh7khsHlg7Ac7lTl0rMMSyNu0hM2crw
         qWkYyT0Qgr78YnCTo3s4NlFXrOuwlLhCPkG3c4d3M/smQd/M0RJFLxMMI/xL07L7hoWF
         5rVjj97+00lWmCn2NrJMOWmYzYwF54r0Qf+mA0OGSjvPf1SpEMDHgSg7UeE7Vg1CGtoN
         T+T4NZZjPBfS3UdyOyGmTQ469SBn8ypWuFf0wqzFmp7L5+Ne1I3NFub9S+M28qxy8SqB
         LjGw==
X-Gm-Message-State: AOJu0YzFJBSSzgq1gjLrDrZ3yUxoY+WVE2sx1GRuHwfIHry2+bvMkIbi
        hGlblCsYlFIDxhJU9jgT6sE2vEYebc8YdvlrMwUQ1vr4rhX+
X-Google-Smtp-Source: AGHT+IE+QWJTonndZGFf6jRDgdN8ovDhbsrDw5KU3d9PVED1jDX7UN40eqEyHwiV2ofZDEhCzZ5xYr/AYnjZgtPhv2DnIt3put66
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c599:b0:1e9:880f:340d with SMTP id
 ba25-20020a056870c59900b001e9880f340dmr2278393oab.5.1698383126293; Thu, 26
 Oct 2023 22:05:26 -0700 (PDT)
Date:   Thu, 26 Oct 2023 22:05:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef757e0608aba23d@google.com>
Subject: [syzbot] [ext4?] general protection fault in locks_remove_posix
From:   syzbot <syzbot+ba2c35eb32f5a85137f8@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2030579113a1 Add linux-next specific files for 20231020
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e75739680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37404d76b3c8840e
dashboard link: https://syzkaller.appspot.com/bug?extid=ba2c35eb32f5a85137f8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125607f5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a22e93680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a99a981e5d78/disk-20305791.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/073a5ba6a2a6/vmlinux-20305791.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7c1a7107f7b/bzImage-20305791.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/81394ce5859f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba2c35eb32f5a85137f8@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc001ffff11a: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x00000000ffff88d0-0x00000000ffff88d7]
CPU: 1 PID: 5052 Comm: udevd Not tainted 6.6.0-rc6-next-20231020-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:locks_remove_posix+0x100/0x510 fs/locks.c:2555
Code: 4d 8b ae 20 02 00 00 4d 85 ed 0f 84 0c 02 00 00 e8 15 60 7d ff 49 8d 55 50 48 b9 00 00 00 00 00 fc ff df 48 89 d6 48 c1 ee 03 <80> 3c 0e 00 0f 85 ae 03 00 00 49 8b 45 50 48 39 c2 0f 84 db 01 00
RSP: 0018:ffffc90003d6f948 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff8880271cca00 RCX: dffffc0000000000
RDX: 00000000ffff88d0 RSI: 000000001ffff11a RDI: ffff8880796982e0
RBP: 1ffff920007adf2b R08: 0000000000000003 R09: 0000000000004000
R10: 0000000000000000 R11: dffffc0000000000 R12: ffffc90003d6f988
R13: 00000000ffff8880 R14: ffff8880796980c0 R15: ffff8880271ccb90
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc227c3e000 CR3: 000000002000e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 filp_flush+0x11b/0x1a0 fs/open.c:1554
 filp_close+0x1c/0x30 fs/open.c:1563
 close_files fs/file.c:432 [inline]
 put_files_struct fs/file.c:447 [inline]
 put_files_struct+0x1df/0x360 fs/file.c:444
 exit_files+0x82/0xb0 fs/file.c:464
 do_exit+0xa51/0x2ac0 kernel/exit.c:866
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1021
 get_signal+0x2391/0x2760 kernel/signal.c:2904
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11c/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fc2276be3cd
Code: Unable to access opcode bytes at 0x7fc2276be3a3.
RSP: 002b:00007ffd929ccc20 EFLAGS: 00000246 ORIG_RAX: 00000000000000ea
RAX: 0000000000000000 RBX: 00007fc227b0bc80 RCX: 00007fc2276be3cd
RDX: 0000000000000006 RSI: 00000000000013bc RDI: 00000000000013bc
RBP: 00000000000013bc R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000006
R13: 00007ffd929cce30 R14: 0000000000001000 R15: 0000000000000000
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	4d 8b ae 20 02 00 00 	mov    0x220(%r14),%r13
   7:	4d 85 ed             	test   %r13,%r13
   a:	0f 84 0c 02 00 00    	je     0x21c
  10:	e8 15 60 7d ff       	call   0xff7d602a
  15:	49 8d 55 50          	lea    0x50(%r13),%rdx
  19:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  20:	fc ff df
  23:	48 89 d6             	mov    %rdx,%rsi
  26:	48 c1 ee 03          	shr    $0x3,%rsi
* 2a:	80 3c 0e 00          	cmpb   $0x0,(%rsi,%rcx,1) <-- trapping instruction
  2e:	0f 85 ae 03 00 00    	jne    0x3e2
  34:	49 8b 45 50          	mov    0x50(%r13),%rax
  38:	48 39 c2             	cmp    %rax,%rdx
  3b:	0f                   	.byte 0xf
  3c:	84 db                	test   %bl,%bl
  3e:	01 00                	add    %eax,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
