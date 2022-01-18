Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A72492917
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jan 2022 16:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbiARPAf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jan 2022 10:00:35 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:34800 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiARPAe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jan 2022 10:00:34 -0500
Received: by mail-il1-f198.google.com with SMTP id a18-20020a923312000000b002b384dccc91so13884582ilf.1
        for <linux-ext4@vger.kernel.org>; Tue, 18 Jan 2022 07:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j5wUom1MNv/KYtuHOQzJ0aBGj9CsWbo4IzoCjBRZRY4=;
        b=iFsmbx89Rybfe6iLEM3OLbSEParvdAZVPi7cVtx1VIwzu5jMUXcWtl+vvGQkpw8CRe
         6/U0394uR6O5rhX1l/BP0++4hQ6z3Mi3NSik+nEVXl1OwWjCYQM1J8bH4quxCdzP3E/v
         0pMUvTJQTXDw1loSysfmPqssTO0cEnZS/37U6lCVUTgQTKuXtRfNoCYsLO4ba963/cHx
         WO8T4DRCR2lrHDqcFmAq3D2W6sLvgrWIDqW1UpZzyMpGrlZN9EJv0HMejuJLinStyMVl
         xlbNtmuoQfgkTaboPyBZoO3AUitDzcSaxxS3HFoOZJrlyWq0a29uz4qSLZ0YnVx7+U2q
         LLEw==
X-Gm-Message-State: AOAM530AssGMyCHRbZkQeh7SZJ9GIso+ydp6IMUpzsl7gtV0QtnNLukA
        QfS87WPxtHGaRbYeM3OjQ0sEdpORZy/i6TS521kPkQxM+mGo
X-Google-Smtp-Source: ABdhPJzxwGHLnyIMalpvFYJgau08HciU89xtYGfzxsRsnCjWXgOfEw2JLFUdgu8o4E21WDhE7X7P/wOpBTaGZ4LkkaPC+3HPaYfR
MIME-Version: 1.0
X-Received: by 2002:a02:2207:: with SMTP id o7mr3257680jao.99.1642518034121;
 Tue, 18 Jan 2022 07:00:34 -0800 (PST)
Date:   Tue, 18 Jan 2022 07:00:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6092905d5dc875d@google.com>
Subject: [syzbot] kernel BUG in jbd2_journal_get_create_access
From:   syzbot <syzbot+f6645952f81bfbe3907f@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fb3b0673b7d5 Merge tag 'mailbox-v5.17' of git://git.linaro..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c5a3f7b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10dbcfb2ca32737b
dashboard link: https://syzkaller.appspot.com/bug?extid=f6645952f81bfbe3907f
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6645952f81bfbe3907f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/jbd2/transaction.c:1284!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3618 Comm: syz-executor.3 Not tainted 5.16.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:jbd2_journal_get_create_access+0x443/0x450 fs/jbd2/transaction.c:1281
Code: ff ff ff 48 89 ef e8 6c cc 91 ff e9 24 ff ff ff e8 42 63 46 ff 0f 0b e8 3b 63 46 ff 0f 0b e8 34 63 46 ff 0f 0b e8 2d 63 46 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 55 41 57 41 56 41 55 41 54
RSP: 0018:ffffc9000288f890 EFLAGS: 00010293
RAX: ffffffff823e5703 RBX: ffff88805e7d6600 RCX: ffff88807d450000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff823e5454 R09: 0000000000000003
R10: fffff52000511f01 R11: 0000000000000004 R12: dffffc0000000000
R13: ffff88805b4e26e0 R14: ffff88805e7d6480 R15: ffff88801d5560f0
FS:  0000555556d51400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200003c0 CR3: 0000000061c29000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_journal_get_create_access+0xaf/0x550 fs/ext4/ext4_jbd2.c:324
 ext4_getblk+0x3d6/0x700 fs/ext4/inode.c:873
 ext4_bread+0x2a/0x170 fs/ext4/inode.c:902
 ext4_append+0x1a6/0x370 fs/ext4/namei.c:67
 ext4_init_new_dir+0x337/0xa10 fs/ext4/namei.c:2893
 ext4_mkdir+0x4b8/0xc00 fs/ext4/namei.c:2939
 vfs_mkdir+0x2f6/0x4d0 fs/namei.c:3883
 do_mkdirat+0x277/0x530 fs/namei.c:3909
 __do_sys_mkdir fs/namei.c:3929 [inline]
 __se_sys_mkdir fs/namei.c:3927 [inline]
 __x64_sys_mkdir+0x6a/0x80 fs/namei.c:3927
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5d854ff0f7
Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca6f9cc88 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ffca6f9cd10 RCX: 00007f5d854ff0f7
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffca6f9cd10
RBP: 00007ffca6f9ccec R08: 0000000000000000 R09: 0000000000000005
R10: 00007ffca6f9ca25 R11: 0000000000000206 R12: 0000000000000032
R13: 000000000005ac17 R14: 0000000000000003 R15: 00007ffca6f9cd50
 </TASK>
Modules linked in:
---[ end trace 24a9214ffe9eda3d ]---
RIP: 0010:jbd2_journal_get_create_access+0x443/0x450 fs/jbd2/transaction.c:1281
Code: ff ff ff 48 89 ef e8 6c cc 91 ff e9 24 ff ff ff e8 42 63 46 ff 0f 0b e8 3b 63 46 ff 0f 0b e8 34 63 46 ff 0f 0b e8 2d 63 46 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 55 41 57 41 56 41 55 41 54
RSP: 0018:ffffc9000288f890 EFLAGS: 00010293
RAX: ffffffff823e5703 RBX: ffff88805e7d6600 RCX: ffff88807d450000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff823e5454 R09: 0000000000000003
R10: fffff52000511f01 R11: 0000000000000004 R12: dffffc0000000000
R13: ffff88805b4e26e0 R14: ffff88805e7d6480 R15: ffff88801d5560f0
FS:  0000555556d51400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200003c0 CR3: 0000000061c29000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
