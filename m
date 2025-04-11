Return-Path: <linux-ext4+bounces-7210-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C6A86302
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Apr 2025 18:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07E61BA08AA
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Apr 2025 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEDC21CA07;
	Fri, 11 Apr 2025 16:16:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80921C9E5
	for <linux-ext4@vger.kernel.org>; Fri, 11 Apr 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388185; cv=none; b=pQ+C7RwLO5+t6vkWhxAsCMCzuxtZOk9TBmrU2Gs676nDNR2kBTflFdMhkYBq+Mj8qjYMlLEwEP1WZqB3XqQhukWAzlvzaULiwWmeEBPknrvR6/3VRMpbp4+wMLDAP4liqFJWju5dt9YIiFOl+IbpCqMjiNNajdzHg/xEOQngx8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388185; c=relaxed/simple;
	bh=ofG/bh88nXyGpqlK5TshtTQr9cd49SO+uJzCwBw3KLk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IopiBqeYPKyzWSYBgsTYyzSc0ZmYFIjv9IgqVWXx/tqyYswGmIpp5ZkxwLpxWRLd17sz1oOzMVwrhcONg3UJesaN210p5JasJQZ26D+0QiVWjawbg+9NCGwv+3o4m8VLCYH4mKZGhyufaFUYPM5GB+M0T9jHSxA9VESsLvPErGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86186c58c41so33013539f.1
        for <linux-ext4@vger.kernel.org>; Fri, 11 Apr 2025 09:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744388183; x=1744992983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQQgQ7UyS3LAdQoJwwRUwxPug3+VYmSPMHNWzlZpu7g=;
        b=TKmfRHnltpbvYDyA8Ctm3on2jNuTsDfjkSsXBIDT7BxjY5Z7V5ugEK4jefPRLb2C/E
         q3KL3x3A2WRIiKl4JIazXKvuCjWQd04GRe0RfybInmdHlG2jSgWiNfxc8y36ShnW56R6
         Tb5vOuQtf9b1CGPHOBk764qGu+ytW5QJLMErA5vn9eU26HbWKnZKJeVl7D5cVgPkzA5g
         R64xcTj/JaTQmITaZJXbgcB4iA1m9pBXjYLAUMoRsS1NzWMZ7zZ7+zAoC20CBYoi2X42
         Xd8yS6hCBjlnNYoIpymvIBe5kwD9KqtrLXblEd/lWUZIYemmgrjqHXfm2w5JuUoO6mfA
         8lLg==
X-Forwarded-Encrypted: i=1; AJvYcCUtBBB+u9bmorVAZLt+yAYE9RQ/TIOcmApeKlk7xLAajxdhClmV+sAqlWHjxXDWf6DTt/hSaxX6LfzA@vger.kernel.org
X-Gm-Message-State: AOJu0YykOlyQ5021csY4dfY49rDqEDMktx3GJ0enz1jXAKxluevysSvD
	3pnQg2peU1wbPQZSf6l8C3pqjooqhJaFHZ1/ZXpyNHItqwbX5H7j7umATLBQAhJ0cJLN1lY6u18
	iulwDdD52wIm9gRi/vnQiWvEMhEhaV+gLb8yFebKzovx8j8UPdEnZygQ=
X-Google-Smtp-Source: AGHT+IEe4DwMfsWGIOsRrmluePkQd1t+HY4zIFS0USg703O/1roEm3f4y8+Ckg8Q0QViO6JDMSw+MTbDD8BrjyKQPKMWtQc7aaBe
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3804:b0:3d6:cb9b:cbd6 with SMTP id
 e9e14a558f8ab-3d7ec227bf0mr32050795ab.13.1744388183354; Fri, 11 Apr 2025
 09:16:23 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:16:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f94057.050a0220.2c5fcf.0001.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_ext_insert_extent (2)
From: syzbot <syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17198c04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f175b153b655dbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=ad86dcdffd6785f56e03
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1d71d1bf77d/disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f1638f065da/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b3e49834705/bzImage-0af2f6be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com

EXT4-fs error (device loop3): mb_free_blocks:1945: group 0, inode 19: block 289:freeing already freed block (bit 18); block bitmap corrupt.
------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:2151!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6611 Comm: syz.3.178 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:ext4_ext_insert_extent+0x317c/0x4610 fs/ext4/extents.c:2151
Code: 8b 74 24 60 e8 c5 ab ff ff 48 89 04 24 e9 2c da ff ff e8 97 40 4c ff 41 8d 9c 1c 00 80 ff ff e9 be ee ff ff e8 85 40 4c ff 90 <0f> 0b e8 7d 40 4c ff 44 01 e3 e9 1f f1 ff ff e8 70 40 4c ff 01 dd
RSP: 0018:ffffc900049ff0f0 EFLAGS: 00010287
RAX: 000000000004b428 RBX: ffff88807e54ec30 RCX: ffffc9000c50b000
RDX: 0000000000080000 RSI: ffffffff826efc8b RDI: 0000000000000004
RBP: ffff88804d74c418 R08: 0000000000000004 R09: 0000000000000028
R10: 0000000000000028 R11: 0000000000000000 R12: 0000000000000028
R13: 0000000000000028 R14: 0000000000000054 R15: ffff888053f4dc18
FS:  00007fe2885d66c0(0000) GS:ffff8881249b9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3080cff8 CR3: 000000005ea0a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_ext_map_blocks+0x205b/0x5d60 fs/ext4/extents.c:4400
 ext4_map_create_blocks fs/ext4/inode.c:519 [inline]
 ext4_map_blocks+0x45b/0x1390 fs/ext4/inode.c:705
 _ext4_get_block+0x24e/0x5a0 fs/ext4/inode.c:784
 ext4_get_block_unwritten+0x29/0x110 fs/ext4/inode.c:817
 ext4_block_write_begin+0x3fb/0xf40 fs/ext4/inode.c:1066
 ext4_write_begin+0x670/0x11f0 fs/ext4/inode.c:1221
 ext4_da_write_begin+0x29d/0x990 fs/ext4/inode.c:2931
 generic_perform_write+0x3d0/0x930 mm/filemap.c:4102
 ext4_buffered_write_iter+0x119/0x440 fs/ext4/file.c:299
 ext4_file_write_iter+0xa4c/0x1d10 fs/ext4/file.c:718
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x5bd/0x1180 fs/read_write.c:684
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe28778d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe2885d6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe2879a5fa0 RCX: 00007fe28778d169
RDX: 000000000000fcb8 RSI: 0000200000000140 RDI: 0000000000000007
RBP: 00007fe28780e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe2879a5fa0 R15: 00007ffee8100088
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_insert_extent+0x317c/0x4610 fs/ext4/extents.c:2151
Code: 8b 74 24 60 e8 c5 ab ff ff 48 89 04 24 e9 2c da ff ff e8 97 40 4c ff 41 8d 9c 1c 00 80 ff ff e9 be ee ff ff e8 85 40 4c ff 90 <0f> 0b e8 7d 40 4c ff 44 01 e3 e9 1f f1 ff ff e8 70 40 4c ff 01 dd
RSP: 0018:ffffc900049ff0f0 EFLAGS: 00010287
RAX: 000000000004b428 RBX: ffff88807e54ec30 RCX: ffffc9000c50b000
RDX: 0000000000080000 RSI: ffffffff826efc8b RDI: 0000000000000004
RBP: ffff88804d74c418 R08: 0000000000000004 R09: 0000000000000028
R10: 0000000000000028 R11: 0000000000000000 R12: 0000000000000028
R13: 0000000000000028 R14: 0000000000000054 R15: ffff888053f4dc18
FS:  00007fe2885d66c0(0000) GS:ffff8881249b9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb70b406378 CR3: 000000005ea0a000 CR4: 0000000000350ef0


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

