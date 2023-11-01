Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428137DDC73
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 07:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376542AbjKAFgf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 01:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345104AbjKAFge (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 01:36:34 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3258103
        for <linux-ext4@vger.kernel.org>; Tue, 31 Oct 2023 22:36:23 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-581ed663023so8487064eaf.2
        for <linux-ext4@vger.kernel.org>; Tue, 31 Oct 2023 22:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698816983; x=1699421783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgHEX9qRR2Z35ffqNbzDkc5Dn4BGcDXB9Wtmg7DNzas=;
        b=ZyIyv9CbBJilJ4ksOo/O8KL0JWvnNDBQUGn+ZtUUZuuYbGSHdaM0sILQi8Fd62zllQ
         pVTec9iNGLpKl8R+msS5ux9uf/0gDY3yuCQULx7+d1KqVDkHN8wy5ixcYMe75PhH9jSU
         JAdBfmhrRXG7K69KRcMmW+DpVtKdhlB2BXaQwF/97ECBUWq4cIyw+HDXp5E+U6y4mlrb
         7e3V/2eVAFqq49gTkTtHXsurMTHaMUl7u4zK3mOb8YnKlH5XU6gHAt484P2Jde2g0gBY
         2xjkxxJVnQXC6Ngm+NxtHgqSt99yiQVNwGG4V0AhcUUNnHpMhBu6qGApAg1cEhkBo1Y8
         WfyQ==
X-Gm-Message-State: AOJu0YzyWudg81rEpePnw4kiX2MwHW0iLeLR5p3UmPnblhkyVIp6zAwA
        hHFv06K/g7btL6gNIGCJ2gHEHQHlxAI4bjwuP+UdKIE41Rx6
X-Google-Smtp-Source: AGHT+IEzBkJMgIjoCvzRernhl6/B2GK3AQHsf3SznOR1K5AoUmlhNyWXoxi3qN7Vnzt3/ogYoQkcx3G6i0KClAWef4NGeZnyvmQw
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d61e:b0:1ef:b8a5:3d01 with SMTP id
 a30-20020a056870d61e00b001efb8a53d01mr5653384oaq.3.1698816983026; Tue, 31 Oct
 2023 22:36:23 -0700 (PDT)
Date:   Tue, 31 Oct 2023 22:36:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfd180060910a687@google.com>
Subject: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
From:   syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    888cf78c29e2 Merge tag 'iommu-fix-v6.6-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10339673680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=b408cd9b40ec25380ee1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165bbce3680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e776d64243c/disk-888cf78c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ce776a2bcfc/vmlinux-888cf78c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86a6c193c013/bzImage-888cf78c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8021bba287f0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc003ffff113: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x00000001ffff8898-0x00000001ffff889f]
CPU: 1 PID: 5308 Comm: syz-executor.4 Not tainted 6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:lookup_object lib/debugobjects.c:195 [inline]
RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:564 [inline]
RIP: 0010:__debug_object_init+0xf3/0x2b0 lib/debugobjects.c:634
Code: d8 48 c1 e8 03 42 80 3c 20 00 0f 85 85 01 00 00 48 8b 1b 48 85 db 0f 84 9f 00 00 00 48 8d 7b 18 83 c5 01 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 4c 01 00 00 4c 3b 73 18 75 c3 48 8d 7b 10 48
RSP: 0018:ffffc900050e7d08 EFLAGS: 00010012
RAX: 000000003ffff113 RBX: 00000001ffff8880 RCX: ffffffff8169123e
RDX: 1ffffffff249b149 RSI: 0000000000000004 RDI: 00000001ffff8898
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000216
R10: 0000000000000003 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff924d8a48 R14: ffffc900050e7d90 R15: ffffffff924d8a50
FS:  0000555556eec480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa23ab065ee CR3: 000000007e5c1000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 hrtimer_init_sleeper_on_stack kernel/time/hrtimer.c:447 [inline]
 hrtimer_nanosleep+0x122/0x440 kernel/time/hrtimer.c:2098
 common_nsleep+0xa1/0xc0 kernel/time/posix-timers.c:1350
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1373 [inline]
 __x64_sys_clock_nanosleep+0x344/0x490 kernel/time/posix-timers.c:1373
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1a56a7ef5
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 f6 b9 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 4f ba ff ff 48 8b 04 24 48 83 c4 28 f7 d8
RSP: 002b:00007ffe80c6ee30 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 00007ff1a579bf80 RCX: 00007ff1a56a7ef5
RDX: 00007ffe80c6ee70 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ff1a579d980 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000fef3
R13: ffffffffffffffff R14: 00007ff1a5200000 R15: 000000000000fbb2
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lookup_object lib/debugobjects.c:195 [inline]
RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:564 [inline]
RIP: 0010:__debug_object_init+0xf3/0x2b0 lib/debugobjects.c:634
Code: d8 48 c1 e8 03 42 80 3c 20 00 0f 85 85 01 00 00 48 8b 1b 48 85 db 0f 84 9f 00 00 00 48 8d 7b 18 83 c5 01 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 4c 01 00 00 4c 3b 73 18 75 c3 48 8d 7b 10 48
RSP: 0018:ffffc900050e7d08 EFLAGS: 00010012

RAX: 000000003ffff113 RBX: 00000001ffff8880 RCX: ffffffff8169123e
RDX: 1ffffffff249b149 RSI: 0000000000000004 RDI: 00000001ffff8898
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000216
R10: 0000000000000003 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff924d8a48 R14: ffffc900050e7d90 R15: ffffffff924d8a50
FS:  0000555556eec480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa23ab065ee CR3: 000000007e5c1000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0:	d8 48 c1             	fmuls  -0x3f(%rax)
   3:	e8 03 42 80 3c       	call   0x3c80420b
   8:	20 00                	and    %al,(%rax)
   a:	0f 85 85 01 00 00    	jne    0x195
  10:	48 8b 1b             	mov    (%rbx),%rbx
  13:	48 85 db             	test   %rbx,%rbx
  16:	0f 84 9f 00 00 00    	je     0xbb
  1c:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  20:	83 c5 01             	add    $0x1,%ebp
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 4c 01 00 00    	jne    0x181
  35:	4c 3b 73 18          	cmp    0x18(%rbx),%r14
  39:	75 c3                	jne    0xfffffffe
  3b:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
