Return-Path: <linux-ext4+bounces-10219-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01480B5A1E6
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 22:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CC21BC788B
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 20:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C02DFA27;
	Tue, 16 Sep 2025 20:09:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9D284B29
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053375; cv=none; b=sQZyNDmPnOY+Otwb2Fxtf02cxqOABbdoouXrTLqqCEP1OkIXPCNtNueQvwjJqHFitdGre1k+H0PN96dqj1J1DRc+K/GcAiqCSJ3YeRYBE1TEwhUDwbXMqluVmK3WQWlIV+NHnImMQqJ99KdmGqCB1RU05lWSUdbUKyr0sgztqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053375; c=relaxed/simple;
	bh=qzzecwpESccFuFNo7R6BWAlARHDuDtXA1zzB8Fv/bWw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E4NydxPQ0FzEwu6xqy4ctZIetp70tg/nhpjtNlMROKwFM8qxgnYO6GzLLj8DLM3+b4JulDcBXFjvLR6Oiw6s1fe44n2QZRa0UA6II3QmiJ/VTtK+KvczWZqWven8f6tyaXQDzQkpSVn4jj8GvUYRh1PpOzbgEF4jy7y6LceBlOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-896d8bc595aso203938339f.1
        for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 13:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053372; x=1758658172;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uigoYBYRLLUFTGVUhaRkWpUMCR0hrpQWRdx1/7NNXXg=;
        b=FVVXUBcciXSnosebXFU4TRdf1vecrTwd5KuBt1GS3GGTVvp8ycyx3a5JMCnEEpWqPG
         k7ADhq6bzMYEaPEEVpP0XO3++zaXzs31aDDL48G/jALLjMND5KMtnBu3QOv99n3A1/2r
         zlQpjdDBvjHAwyImF5nQM7t5/NzNX2kR4i4MxH6lAy4vk0huZOLnFOa2fwRlsl+/TmLZ
         PFHdzQbJF5Y6LoRRbXTbyPQbdNcuFmrg+0KntbE0UKmVmU6vwT0T5O2ZJ19EZ40uPmWI
         g0j5OyRV2xl3xhnigqrxdpZCuF2A05hmpZMJe3FYiaI/xAYIkyTA4GyKEHP9sPpRlc4V
         /SUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtAPzVTu7Ca82rojgP5cwhcrq9bYfEgdFXMsuRyhGTA2VgBZSwgGf5Ad0P+W+o5hbsy24GatMNKQ5g@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOYfv7494s3VYyMQiwV2xLq5Yu9e915eYvmNKnxF4PNPSsew9
	8dgy7Lo/hziUo8eiHSaelV76tkg2lZEiVbaKkS+I6MsTW0xHVCRlCHf+xWTQg/VvnO+/BN/3Sc6
	QR51635mL8DG1HHPUWc/k/eQ73gWxUKEkMPvnCgwuLg3EO0yki78dIE7/5cI=
X-Google-Smtp-Source: AGHT+IEEVmKLfNRiKV3Z/I2lgiOGH+2DKtHA2AqpYMGHFguDp9CqVFvehaAi1vAC1d6hRchv7aFkun5KhrURZf8EnDgtoGFFkDtj
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1567:b0:424:388:6ced with SMTP id
 e9e14a558f8ab-42403886eadmr116067025ab.14.1758053372134; Tue, 16 Sep 2025
 13:09:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:09:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9c3fc.050a0220.3c6139.0e66.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_xattr_block_set (3)
From: syzbot <syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1709747c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1089747c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100fcf62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/230712d5bcfe/disk-46a51f4f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c02b11d16746/vmlinux-46a51f4f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1526fd71bea/bzImage-46a51f4f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c8e39bedb73d/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17b2fb12580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
EXT4-fs (loop0): orphan cleanup on readonly fs
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6102 at fs/ext4/xattr.c:1906 ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Modules linked in:
CPU: 1 UID: 0 PID: 6102 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_xattr_block_set+0x25b5/0x2ac0 fs/ext4/xattr.c:1906
Code: 00 00 00 e8 dd 71 a2 ff f0 80 63 28 fd eb 28 e8 71 34 43 ff 31 db 48 c7 44 24 20 00 00 00 00 e9 88 f1 ff ff e8 5c 34 43 ff 90 <0f> 0b 90 e9 0e dc ff ff e8 4e 34 43 ff 48 8b 5c 24 10 4c 8b 74 24
RSP: 0018:ffffc90003e77220 EFLAGS: 00010293
RAX: ffffffff827b39b4 RBX: ffffc90003e77548 RCX: ffff88802e9a8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003e77408 R08: 0000000000000000 R09: 0000000000000000
R10: ffff88805487c400 R11: ffff88805487c000 R12: 0000000000000000
R13: 1ffff920007ceeaa R14: 1ffff920007ceea9 R15: ffffc90003e77550
FS:  000055556e470500(0000) GS:ffff8881269bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005624941c2138 CR3: 000000004081c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
 __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6506
 ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5609 [inline]
 ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f976e92034a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3b5e27e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc3b5e2870 RCX: 00007f976e92034a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffc3b5e2830
RBP: 0000200000000180 R08: 00007ffc3b5e2870 R09: 000000000080078b
R10: 000000000080078b R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffc3b5e2830 R14: 0000000000000473 R15: 0000200000000680
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

