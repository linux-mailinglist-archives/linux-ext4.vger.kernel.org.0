Return-Path: <linux-ext4+bounces-4369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE56F989676
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Sep 2024 19:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65650281190
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Sep 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D745917BED0;
	Sun, 29 Sep 2024 17:12:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5B154BED
	for <linux-ext4@vger.kernel.org>; Sun, 29 Sep 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629954; cv=none; b=cLJWSp0kpQMs7Zn8D1D4tGYtbOvubRiV9m3Y8Cfr3mtiK0vp+MbqIsXCQa1kFiLRemP343E/HEn4JTMup5bwqjHpTahWq/vmXGijTg03Vzri/IEK+awRegUOYe4CRVsXPXmyJHJ43K0CjSh0DuDim2zpAkfQ3Xxgk6/SMH98fxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629954; c=relaxed/simple;
	bh=EaXRUEmfB79k/Z0BeIOPUDzlzgGDwf/cukr9QkhFr/w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XkO0RYx2ylGi8AJbFzkFaAchB7gw/XgTXVgLKCJBjS5mmnGyTfHzD+Gfs+jDSmPAXvjPtYtaAafNB+B12yex7XP03gq3HOAcgyTl2s4AWpLxeilm+p9HG/T1Oxd8PLo2MwzQ8lClk/iPo60swUDBVxB554FXiO6QWT78G3E7geo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cda24c462so357425039f.0
        for <linux-ext4@vger.kernel.org>; Sun, 29 Sep 2024 10:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629952; x=1728234752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oLiFtWq3lpVzqaTZ+/xin618Ir4btGMwE3p+GRGDS8=;
        b=Y4lHCqW812eO7blYTAI9TJ9KrA/cAwGCMIhkE5I4fEW5WZH0fioEQq6e38IvMJlPih
         HZx27erBx0zVu/NQeQt5bNN6hm5MH/7duiMsk0Y90iIuvb/kO5GaiVdE46GQuYoZ9wyC
         4FesGhoDNEVqJc8Sy2wbetD71qNqHQH/uNysOk1jHt3FPRLDeXiPad/ndj8z0BhXwrln
         kvSvN4MfUBObbzYw24aOELXJqDHGrDtNdGDBDS5otD3Y/LFiTGbNp87JwJWAatJakJM1
         a1Fm9h0NE7wubU0++/cMM0/4whaw7VH3mX7Ab/wwXkehsykGjjVYmimzzL3SV6laKOxp
         1WwA==
X-Forwarded-Encrypted: i=1; AJvYcCVEvNj+jVwRIO0vGt9Z1uSQVDkrZuCD316BCZV4eH6MVuQbGhFi2Ry5QstOatX6us3YLvzxwXKPnMTY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00IXqL+ILL2mz0L4re+PEgGCe/J1QzF5NYfFFbB/7NETKBjqS
	BGFhRrDE7mXR19V8S0DsRCXTFYB0HOtRTjZhIozSI2I1ojR24YT4BIen+WsqmIq1Nek9d6xLGev
	PfrkDarz2AbQWvDrdJ1QsLX5o0I3AhAEgqddnSsblPfxQT9VYNLptZI0=
X-Google-Smtp-Source: AGHT+IHxgiVeJXHJ017W8Jzgtl1T+AZNKyPUUAUgljHC66OS0lsN4Nq4JhLIOFPVmVbbbE0ijf0zKcbfmIW266Zr3fWHC7K1k0HB
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:3a2:74eb:91fa with SMTP id
 e9e14a558f8ab-3a3451c1b12mr71194785ab.25.1727629952365; Sun, 29 Sep 2024
 10:12:32 -0700 (PDT)
Date: Sun, 29 Sep 2024 10:12:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f98a80.050a0220.6bad9.0021.GAE@google.com>
Subject: [syzbot] [ext4?] [ocfs2?] WARNING in jbd2_journal_update_sb_log_tail
From: syzbot <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
To: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    684a64bf32b6 Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138c0907980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd75e1a00004094f
dashboard link: https://syzkaller.appspot.com/bug?extid=96ee12698391289383dd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bea99f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d04aa9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-684a64bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f05b4b08a420/vmlinux-684a64bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d59f9edaf3bc/bzImage-684a64bf.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a82758cb7d80/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96ee12698391289383dd@syzkaller.appspotmail.com

(syz-executor214,5103,0):ocfs2_block_check_validate:402 ERROR: CRC32 failed: stored: 0xb3775c19, computed 0x2dd1c265. Applying ECC.
JBD2: Ignoring recovery information on journal
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5103 at fs/jbd2/journal.c:1887 jbd2_journal_update_sb_log_tail+0x2ba/0x360 fs/jbd2/journal.c:1887
Modules linked in:
CPU: 0 UID: 0 PID: 5103 Comm: syz-executor214 Not tainted 6.11.0-syzkaller-10547-g684a64bf32b6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jbd2_journal_update_sb_log_tail+0x2ba/0x360 fs/jbd2/journal.c:1887
Code: 1c ff 41 80 3c 2c 00 74 08 4c 89 ff e8 9f 71 86 ff 41 80 27 f7 4c 89 f7 e8 f3 1c 56 09 31 ed e9 72 fe ff ff e8 47 c4 1c ff 90 <0f> 0b 90 41 80 3c 2c 00 75 d5 eb db 44 89 f1 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90000e46d70 EFLAGS: 00010293
RAX: ffffffff8277f0f9 RBX: 0000000000000000 RCX: ffff8880002ba440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8277f0c9 R09: fffff520001c8d9c
R10: dffffc0000000000 R11: fffff520001c8d9c R12: 1ffff1100808bc00
R13: ffff88803d2e301c R14: ffff88804045e0b0 R15: ffff88804045e000
FS:  000055558c7ca380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd277995ed8 CR3: 000000003fef2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 journal_reset fs/jbd2/journal.c:1779 [inline]
 jbd2_journal_load+0x708/0xbc0 fs/jbd2/journal.c:2109
 ocfs2_journal_load+0xed/0x6d0 fs/ocfs2/journal.c:1143
 ocfs2_check_volume fs/ocfs2/super.c:2421 [inline]
 ocfs2_mount_volume+0xc12/0x1940 fs/ocfs2/super.c:1817
 ocfs2_fill_super+0x475a/0x5750 fs/ocfs2/super.c:1084
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb2af90112a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3f741ce8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe3f741d00 RCX: 00007fb2af90112a
RDX: 0000000020004740 RSI: 0000000020004780 RDI: 00007ffe3f741d00
RBP: 0000000000000004 R08: 00007ffe3f741d40 R09: 0000000000004701
R10: 000000000100000a R11: 0000000000000282 R12: 000000000100000a
R13: 00007ffe3f741d40 R14: 0000000000000003 R15: 0000000001000000
 </TASK>


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

