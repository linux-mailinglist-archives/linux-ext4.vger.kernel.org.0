Return-Path: <linux-ext4+bounces-5839-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E09FB50A
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2024 21:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986F31668AA
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2024 20:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2AE1CD1E1;
	Mon, 23 Dec 2024 20:14:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39891C245C
	for <linux-ext4@vger.kernel.org>; Mon, 23 Dec 2024 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734984874; cv=none; b=myp1od42Dg5q/7OmTdRZxpFCdhCo8JnxhoZ0bRitlPbDobOLS1jVVxFkYEc/giSxBCNAR3j6zoSkp5IcGpLUoSwkL674Ir5xXWPn618toFYOwcl+kRVBOtxYI7XFESynNAfwyFVuiewUOY+NCw+q5L+CdvOH1tRXxsshgxLTrNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734984874; c=relaxed/simple;
	bh=4TMlf9ybfgXCNe6z+GIF3irRgwfzaGF9/FiumtNJSxM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZG4eUIIKrbe+BN5gS4OvuQX3slDSmRUnzyKAj2ekGGUR13VbKVMjANmXDr+8OAilPhl+vtlVfCOguZm+F9we/K5uHDwCURcRirpjNJ/lAbE61o99pIs6sX589P4Fvaiih2k587HL9v0gOCgTl10cgxwM2TYVbKLSyyhqMttppvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so42503145ab.1
        for <linux-ext4@vger.kernel.org>; Mon, 23 Dec 2024 12:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734984872; x=1735589672;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZdTVYkFNLiHjKlol1WY7WpZhuv2ntj5b87hD0YQ4i4=;
        b=oYaLyw8BkrYV+P7/x+wKX9ovV/D+EDqufYvmx1n62aNPm0vwDphD0ch9iq/A1PWScx
         Uyt3eB/oMiLujX4l8lT5V1i0pUYAdVLYGsl16jaV0h+dVKJMHXH89TBxvkie43E2eRwO
         FB0xzu9mgIunYwUiztPgOiK3hZUwRy0vjdbkXdpKDMIPK57eVpCcTc6nFMgUdMZKKlzo
         B492awx8gEJrxY2RKX1vUytIZNdwGf6sm8EyR56GyAxaztnb+yQ/b4YFTEzWEvDZ5MQk
         hLyrPQkwg8WKBbz881C2Q6FuRxY74/u1estccOc/2FEeGD7j/FatTuYCuFWU4eb34S8P
         vzGw==
X-Forwarded-Encrypted: i=1; AJvYcCU2pq4EHzI58i/Tr3VS221MRaKRaRdJ/5guIvSxLL+jCXvQN+KUJ6hH4qiCvYrjYDAkrVq9jPr7/vWq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8CxqtLIrLmnoIY5WDrXcCk5vya7mUhHY9avzEOhQltZOGKKx
	EX1mgWRgogBc8Ri9vPXa9dkqV3/m8isNor3tspUVu0rWBQDEdkqC1CwXNEl/OZ0MpNnfW0TA1HE
	dnnt4DUOo3h31L17Z4l1nDN69PwJZ9TdrKOjjNuHZlkjXOBSewJVOZ/w=
X-Google-Smtp-Source: AGHT+IH4IiJt8IRV/5DC7atvlzds0FYAYVIdCS4s4bs/jgqB4smutllWWS+Ia8viwwqzoeMry+CU7t9Y5A3UXAPchhhXmipVawFi
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198e:b0:3ab:a274:d68 with SMTP id
 e9e14a558f8ab-3c2d2567418mr112485965ab.8.1734984872139; Mon, 23 Dec 2024
 12:14:32 -0800 (PST)
Date: Mon, 23 Dec 2024 12:14:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6769c4a8.050a0220.226966.0042.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in deactivate_slab (2)
From: syzbot <syzbot+ccda44e9a0f765fd9706@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2e7aff49b5da Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1129f7e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=696fb014d05da3a3
dashboard link: https://syzkaller.appspot.com/bug?extid=ccda44e9a0f765fd9706
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef408f67fde3/disk-2e7aff49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/414ac17a20dc/vmlinux-2e7aff49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a93415d2a7e7/Image-2e7aff49.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccda44e9a0f765fd9706@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/slub.c:3071!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 10301 Comm: syz.8.517 Not tainted 6.13.0-rc2-syzkaller-g2e7aff49b5da #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : deactivate_slab+0x2cc/0x36c mm/slub.c:3103
lr : ___slab_alloc+0x3c8/0xf4c mm/slub.c:3740
sp : ffff80009d7f7370
x29: ffff80009d7f7370 x28: 0000000000000000 x27: ffff8000810d3d04
x26: 0000000000000000 x25: 0080170003ffff00 x24: 0000000000000001
x23: 0000000000000000 x22: 0000000000000000 x21: ffff0000d71c1640
x20: ffff0000c898cd80 x19: fffffdffc36df305 x18: ffff0000d8a02240
x17: ffff800123d64000 x16: ffff800080460e20 x15: 0000000000000001
x14: 1ffff00011f300ca x13: ffff80009d7f8000 x12: 0000000000000003
x11: 0000000000080000 x10: 0000000000000003 x9 : 0000000000000000
x8 : ffff0000d71c1640 x7 : ffff800080b4ee7c x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 01f5000000000000
x2 : 0080170003ffff00 x1 : fffffdffc36df305 x0 : ffff0000d71c1640
Call trace:
 add_partial mm/slub.c:3103 [inline] (P)
 deactivate_slab+0x2cc/0x36c mm/slub.c:3097 (P)
 ___slab_alloc+0x3c8/0xf4c mm/slub.c:3740 (L)
 ___slab_alloc+0x3c8/0xf4c mm/slub.c:3740
 __slab_alloc+0x74/0xd0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 kmem_cache_alloc_noprof+0x300/0x410 mm/slub.c:4160
 ext4_mb_add_groupinfo+0x5d8/0xdf4 fs/ext4/mballoc.c:3356
 ext4_mb_init_backend fs/ext4/mballoc.c:3435 [inline]
 ext4_mb_init+0x107c/0x2014 fs/ext4/mballoc.c:3733
 __ext4_fill_super fs/ext4/super.c:5559 [inline]
 ext4_fill_super+0x4b50/0x57d0 fs/ext4/super.c:5733
 get_tree_bdev_flags+0x38c/0x494 fs/super.c:1636
 get_tree_bdev+0x2c/0x3c fs/super.c:1659
 ext4_get_tree+0x28/0x38 fs/ext4/super.c:5765
 vfs_get_tree+0x90/0x28c fs/super.c:1814
 do_new_mount+0x278/0x900 fs/namespace.c:3507
 path_mount+0x590/0xe04 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount fs/namespace.c:4034 [inline]
 __arm64_sys_mount+0x4d4/0x5ac fs/namespace.c:4034
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: d50323bf d65f03c0 d4210000 17ffffc0 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

