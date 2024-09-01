Return-Path: <linux-ext4+bounces-4001-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9120967571
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Sep 2024 09:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2D1F21D3C
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Sep 2024 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D41420B0;
	Sun,  1 Sep 2024 07:32:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFA3BBF7
	for <linux-ext4@vger.kernel.org>; Sun,  1 Sep 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725175951; cv=none; b=RHRHoqoowUkKnrtLSGs5a1hPsY1NDACF/KfB2d9XPog1xl5tG3UOY4pd/x3jVX6UXdX47jifrITnOGBuz44M01cXu77z0CET9rhgrifGJ2BXProY+lnB/TbNZBC91LVq8szl0W6CaxVH5wU2FgpMPzzyWe6B/+jAeEz9VWjP6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725175951; c=relaxed/simple;
	bh=lhHmSIFlfOhsvXH4BF49h/sJ9P/P4k781SaVMjCr8mk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lCZuQyJhMfSEzEi4dCR4HijRfBLtDpLQACYkHLmNMESX2LgSi+5OInjBaEmhX3ABQrq3ghZxZx/T29PPgSsAN9oRR20V1CupI8+D8qMYzJCWTBabpSoS1vEQ+l7pwcerQ5hXOoYXru9aVGtFm7DERF1eJIq5L57lQ9oQjRVrsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a246af0aaso263209339f.3
        for <linux-ext4@vger.kernel.org>; Sun, 01 Sep 2024 00:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725175949; x=1725780749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhtyiptobKnf7p7yUACoKUO35fQRerDujRz4nFJZpwo=;
        b=HC8aKYT9FZn/7faDTnotV7w7OGurcWL1hG/Ho5DQC2sZ2kFtfskBYHTQ9pJ6Y/Db3X
         Sp5nScIIAnIfd3LKVMFmjXYqR9mEBWzNjB5yRstZ+0bplnAIpsvk9YLU5eYdqpa2Pe9z
         +kuYz7f1y8h1sXPakQM91crIS64Rv2WZeFXNLedMyREKjkmsU5Dc0V9xjYDuPdBxFHv/
         MmwyWcIRwI1nFH5zevaT2R0rEJ9QLYXKg1fZwa7dKKg8xybdKDWI3JO+k8J3pELFnf1F
         sKklr02nWC6nN2X7Pb7hiCSZ9V3t0mcmCzOZ/U/ttijLN89Z0qbwNU5kjHWDlEHhx/OO
         /GHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQIDEZBlq9Pup1z/HkTzVxBVJb68prbPG9Pe0COxnxiRJ6pYjacCiY7iTOnESYSgyZz0gswGadojG3@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJoaCrIMTGCJpLXcM66X/5HvkKA60bjs7tMj+FKF5BxmZMLzs
	iGSLzCJx7C4+R6AFdXMON9xzaXP04lVbBFIj/y+rTUZ2Ew1b/YBZB3GyedKYGiMbGKHrcYzJAme
	437ia0XYr+IlLeskcECkNp0+h9BPoUeDodgHh4AzOVYdCnd/wcCVoeUM=
X-Google-Smtp-Source: AGHT+IGODkJ2/t8+7n+KOiKKcdu5qVfUKk207pcOTqjUBPB4dCRViVB09xipg/PUOQvTF7WuePbs+Ju3htihSoKwkm2J1wJBilIg
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d82:b0:806:bf73:1167 with SMTP id
 ca18e2360f4ac-82a262d1ac0mr19847939f.3.1725175949220; Sun, 01 Sep 2024
 00:32:29 -0700 (PDT)
Date: Sun, 01 Sep 2024 00:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0ed7b062109d3da@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_inline_data_truncate
From: syzbot <syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, libaokun1@huawei.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ritesh.list@gmail.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    86987d84b968 Merge tag 'v6.11-rc5-client-fixes' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14411109980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa6090cbe3c97dc9565
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147eff87980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f6122b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87692913ef45/disk-86987d84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a27da6973d7f/vmlinux-86987d84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e28d02ce725/bzImage-86987d84.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dd0ff7b97552/mount_0.gz

The issue was bisected to:

commit 67d7d8ad99beccd9fe92d585b87f1760dc9018e3
Author: Baokun Li <libaokun1@huawei.com>
Date:   Thu Jun 16 02:13:56 2022 +0000

    ext4: fix use-after-free in ext4_xattr_set_entry

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1282b835980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1182b835980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1682b835980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com
Fixes: 67d7d8ad99be ("ext4: fix use-after-free in ext4_xattr_set_entry")

loop0: detected capacity change from 1024 to 1023
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:1953!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5220 Comm: syz-executor398 Not tainted 6.11.0-rc5-syzkaller-00057-g86987d84b968 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:ext4_inline_data_truncate+0xced/0xcf0 fs/ext4/inline.c:1953
Code: e9 17 fd ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 44 fd ff ff e8 c3 fb a1 ff e9 3a fd ff ff e8 09 ad 58 09 e8 04 df 3d ff 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
RSP: 0018:ffffc900035cf660 EFLAGS: 00010293
RAX: ffffffff8255ac9c RBX: ffffc900035cf700 RCX: ffff8880241b9e00
RDX: 0000000000000000 RSI: 00000000ffffffc3 RDI: 0000000000000000
RBP: ffffc900035cf7f0 R08: ffffffff8255a948 R09: 1ffff1100e59f149
R10: dffffc0000000000 R11: ffffed100e59f14a R12: ffffc900035cf760
R13: dffffc0000000000 R14: 0000000000000002 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005649eaf8b000 CR3: 000000000e534000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_truncate+0x3c7/0x11a0 fs/ext4/inode.c:4174
 ext4_evict_inode+0x90f/0xf50 fs/ext4/inode.c:258
 evict+0x532/0x950 fs/inode.c:704
 __dentry_kill+0x20d/0x630 fs/dcache.c:610
 dput+0x19f/0x2b0 fs/dcache.c:852
 __fput+0x5f8/0x8a0 fs/file_table.c:430
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f841d2244b9
Code: Unable to access opcode bytes at 0x7f841d22448f.
RSP: 002b:00007fffda637bd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f841d2244b9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f841d2a0370 R08: ffffffffffffffb8 R09: 00007fffda637df8
R10: 0000000000000007 R11: 0000000000000246 R12: 00007f841d2a0370
R13: 0000000000000000 R14: 00007f841d2a10e0 R15: 00007f841d1f2d80
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_inline_data_truncate+0xced/0xcf0 fs/ext4/inline.c:1953
Code: e9 17 fd ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 44 fd ff ff e8 c3 fb a1 ff e9 3a fd ff ff e8 09 ad 58 09 e8 04 df 3d ff 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e
RSP: 0018:ffffc900035cf660 EFLAGS: 00010293
RAX: ffffffff8255ac9c RBX: ffffc900035cf700 RCX: ffff8880241b9e00
RDX: 0000000000000000 RSI: 00000000ffffffc3 RDI: 0000000000000000
RBP: ffffc900035cf7f0 R08: ffffffff8255a948 R09: 1ffff1100e59f149
R10: dffffc0000000000 R11: ffffed100e59f14a R12: ffffc900035cf760
R13: dffffc0000000000 R14: 0000000000000002 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005649eaf8b000 CR3: 000000000e534000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

