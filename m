Return-Path: <linux-ext4+bounces-9995-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921AB561C6
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 17:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B277AD070
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70E2F0C5B;
	Sat, 13 Sep 2025 15:21:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5642BAF4
	for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757776893; cv=none; b=sEtic4STQnxSqScxQL0jg0ydb+T6lJUvfA+0Vq9MO1v4veXk7pLR14FqVtsGSVZsqRANwgoaoV4qEsYr41X95JmUV7frEjKK1t9+jRZvIFp3xFlnopM3cbr5xbDiZ4ZMte2X8F+zU4gz86f/FejEUoM+yi07KlxTMu5JFDmQGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757776893; c=relaxed/simple;
	bh=RVD8gQbDMJ+de91MlBon7BFLDmf1Spiqsd4F3T/HbPk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rXwBVWLWV+v7soDkPD18+WN7UFeAVF16XSc5fTvV8qX90c9Cf3+yQOQiDkXJbENErS0mgJVm1CsSooNKVyfVzb9Dg19eB8/MSIaxyfwU3Y/qtOFlGvVkDbzcYqpClQDNTSh2zh+uCBJ0nsnQkvDO1yHPaaaTrhRnc/eui+BdDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-417306d252cso34894205ab.2
        for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 08:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757776890; x=1758381690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEqce8YnI1rs4tL9ATEg3joyhTmgKU8jihNRIpGC0GY=;
        b=CVtJrJZy3yQWX4W+6lXVXMih7pox/OKWzkUjOLRSoQtTt0Waa28CvmtJYqkqWPukRb
         2L2b1ncWYHWTXZSn5KP73B0Uk+9jlebu6xyz06PiTuauqhSGDuRg4iBW2jo9C0Lfo9bP
         Lc0/KaqkoDB8kQBtw+BRioJDZDWb2qJVn8PomzU7lIbcnbegRg+9gbhhR7o8qMHp1EvM
         lB9Wo7sa1XN1pwT6t2jtZZkr8/JmrjiBfoAZFxc/ahtiviHvPvye5uvmrALBpfO4N+kl
         sBJ1LDxXWy5wE0dpbSkOCuBYLWMwApWKwjzc0jI5AmekwrZeMkSRW9iELo1585E7+GUT
         yp1A==
X-Forwarded-Encrypted: i=1; AJvYcCWtwYuxDsKtNVkXnf1N6tZS59DnVFjLsh2XUo5KxGKP3osh8MqaHCOV5ZTwgfG2NkdDEssZMkyQdArB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxty11aUtcuefid07q9Bbbu8IHHF94q7Q9ulES6URCvdDBpG1pn
	D+rCJAXGy5q6lPvUGcc45piedBZ4/iQy1Qwy4JYxdFLu0Vx4M3gDDPruTwtiGwaVyaW4Il1SH6+
	xs8yi9Fb5H4gvDGExRlFIp6pbCldd8TEWqfvfFJtVXGJpnLs1LHt64F6dpPQ=
X-Google-Smtp-Source: AGHT+IH5l9P4F+jp9aAtqOgrYs/hhNkgB4cL8zF7xwP/ScnbovR92IAzkKRKsd83JTy/hPg/McBha0OQ5cPM85j6BOzs5ne8jX1d
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:412:fa25:dd4e with SMTP id
 e9e14a558f8ab-4209d40ff57mr76176315ab.1.1757776890614; Sat, 13 Sep 2025
 08:21:30 -0700 (PDT)
Date: Sat, 13 Sep 2025 08:21:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f540c4aade9 Add linux-next specific files for 20250910
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10025d62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df0dfb072f52/disk-5f540c4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20649042ae30/vmlinux-5f540c4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c16358268b8/bzImage-5f540c4a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:240!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 28152 Comm: syz.8.5004 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_write_inline_data+0x43c/0x440 fs/ext4/inline.c:240
Code: c1 38 c1 0f 8c 19 ff ff ff 48 89 df 49 89 d7 e8 fa c8 b0 ff 4c 89 fa e9 06 ff ff ff e8 7d c2 4c ff 90 0f 0b e8 75 c2 4c ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc900045273a8 EFLAGS: 00010287
RAX: ffffffff8272facb RBX: 0000000000003000 RCX: 0000000000080000
RDX: ffffc90016e08000 RSI: 0000000000001d1a RDI: 0000000000001d1b
RBP: ffff888012035472 R08: ffff88807cd4e387 R09: 1ffff1100f9a9c70
R10: dffffc0000000000 R11: ffffed100f9a9c71 R12: 000000000000003c
R13: ffffc90004527460 R14: 0000000000002000 R15: ffff888012034f18
FS:  00007f73a18866c0(0000) GS:ffff8881259f0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30511ff8 CR3: 0000000049be6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x336/0xab0 fs/ext4/inline.c:807
 generic_perform_write+0x627/0x900 mm/filemap.c:4230
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 iter_file_splice_write+0x972/0x10e0 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0xfe/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x5a8/0xcc0 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1230
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f73a098eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f73a1886038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f73a0bd5fa0 RCX: 00007f73a098eba9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f73a0a11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020fffe82 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f73a0bd6038 R14: 00007f73a0bd5fa0 R15: 00007ffcafa37c38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x43c/0x440 fs/ext4/inline.c:240
Code: c1 38 c1 0f 8c 19 ff ff ff 48 89 df 49 89 d7 e8 fa c8 b0 ff 4c 89 fa e9 06 ff ff ff e8 7d c2 4c ff 90 0f 0b e8 75 c2 4c ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc900045273a8 EFLAGS: 00010287
RAX: ffffffff8272facb RBX: 0000000000003000 RCX: 0000000000080000
RDX: ffffc90016e08000 RSI: 0000000000001d1a RDI: 0000000000001d1b
RBP: ffff888012035472 R08: ffff88807cd4e387 R09: 1ffff1100f9a9c70
R10: dffffc0000000000 R11: ffffed100f9a9c71 R12: 000000000000003c
R13: ffffc90004527460 R14: 0000000000002000 R15: ffff888012034f18
FS:  00007f73a18866c0(0000) GS:ffff8881259f0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8fb8e97d58 CR3: 0000000049be6000 CR4: 00000000003526f0


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

