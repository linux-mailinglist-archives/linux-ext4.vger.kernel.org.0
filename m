Return-Path: <linux-ext4+bounces-1063-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE6A846BE8
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 10:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770961F2D2EB
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Feb 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4947992E;
	Fri,  2 Feb 2024 09:24:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CB7A728
	for <linux-ext4@vger.kernel.org>; Fri,  2 Feb 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865875; cv=none; b=AhBhzKK0CYHLLNQUJPTfoSR0P+8PNdqUULWsWeRUh4UKfrPt68UnLG+RybGuaR/KewKY+tLUsxGlntP18cRcKedFj+9EFR7dIo2tj/s+T3GYa5tHexNjGb8mWd+Fj6/xq81NIkzGN1yGyExrzNg72anyPoF/Z6jUwD7eFkedhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865875; c=relaxed/simple;
	bh=KpO7yKY6sxbBzQ3uJr1u4FkYuO/0+Q+j+vxxKbE63hE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=awwMihFFubfRYUSAH0dHLNPmp8P4EW7A7XZkMik2MvZsD5f6Z09LYRgHcbmGb0dbqalb5KJuML9wb1DKlVy9BBCKlYqrrBq9Ea4V7K77fVFyN9pVeNbUAxV3ttFe5kPAfRQhrvVGTI4kKgK5XAZ97d1uZ73t6EWtOsofviaG3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363b685b342so633085ab.3
        for <linux-ext4@vger.kernel.org>; Fri, 02 Feb 2024 01:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865867; x=1707470667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WPtIpSzuSpFtfcglYU7ZOgBzedE9MgV+9Ht7eXOMfdY=;
        b=VRgAAK4KvYJYMx22NFgaiRE2XvgJt2w50jjbiR2s4LGMAOhsy+FdHVFrVLiUBLLcOA
         pk/20sufnKXJbR+rZE9xGscNTJKjc4H/qCeE6iq12FWZnZp+luawVrc93evT30USGv9v
         YTQy8tUtFFU0+ktULjEYbpNo/OmsDFG4yaO83tAcvX7hQcsG8CrZl6GYe+Q5gXnG1+xd
         zeB2UOzHpM7Tvg9BrC73ia1jW9iBofSJyA2M9e5dz1DPkezmi8OAwuoTMkuXaxxGMR+P
         SLih7e/fSj0gndBLFpER33Q5ik/aV1Czvo2r6VJrVUdW0sfDHC/0RLiaAhh1jEbDA2X0
         ELvA==
X-Gm-Message-State: AOJu0YzOQf1ZdRoizI0Vvr4j+MPl0IUVqKsNLUtPd4SLCdU3ag8naydY
	07F3I47idUPx8gW6lrnsUcS5jMbQVKiqLxX9xUre3KMPxmK+3bkrqoAgjw0uU+VX571y7Dg+hhV
	UjBG2oGGUVCxQOUS3mnrY0OFXyARHTPzpUNn7uU60kWdlw2Cn58z/ZnQ=
X-Google-Smtp-Source: AGHT+IFrqpxbgQOf8vCr0HY4EsOrYMQFMnr67z/eqirSmcXeyRBL5epRfdoHP++TUkOMJuJHsdvoDs7OL6lnAiRvkTjIGy/IQl+j
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:b0:363:7b21:c860 with SMTP id
 w13-20020a056e021a6d00b003637b21c860mr371640ilv.4.1706865866841; Fri, 02 Feb
 2024 01:24:26 -0800 (PST)
Date: Fri, 02 Feb 2024 01:24:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac258b061062ad8d@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data_end (2)
From: syzbot <syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6764c317b6bb Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132faab7e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c0ac5dfae6ecc58
dashboard link: https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90c636d7609b/disk-6764c317.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d76784c4adc/vmlinux-6764c317.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fa116a29660/bzImage-6764c317.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c89d865531d053abb2d@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:763!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 11999 Comm: syz-executor.1 Not tainted 6.8.0-rc2-syzkaller-00055-g6764c317b6bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:ext4_write_inline_data_end+0x550/0xc20 fs/ext4/inline.c:763
Code: 25 28 00 00 00 0f 85 1d 06 00 00 48 81 c4 b0 00 00 00 44 89 f0 5b 5d 41 5c 41 5d 41 5e 41 5f e9 46 d6 87 08 e8 21 65 4c ff 90 <0f> 0b e8 19 65 4c ff 4d 8d 7c 24 34 4c 89 e7 e8 5c 3c 7c ff be 04
RSP: 0018:ffffc90004a3f928 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880452c82b0 RCX: ffffffff82400124
RDX: ffff888020358000 RSI: ffffffff8240049f RDI: 0000000000000001
RBP: 0000000000000020 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000004 R12: ffffea00013a6980
R13: 0000000000000020 R14: ffff8880452c8050 R15: ffffc90004a3f978
FS:  00007f1365d136c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7e6f02425 CR3: 0000000028762000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_end+0x4af/0xed0 fs/ext4/inode.c:1284
 generic_perform_write+0x33b/0x620 mm/filemap.c:3941
 ext4_buffered_write_iter+0x11f/0x3d0 fs/ext4/file.c:299
 ext4_file_write_iter+0x819/0x1960 fs/ext4/file.c:698
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6e1/0x1110 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd8/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f136507dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1365d130c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f13651abf80 RCX: 00007f136507dda9
RDX: 0000000000000020 RSI: 00000000200002c0 RDI: 0000000000000005
RBP: 00007f13650ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f13651abf80 R15: 00007ffc77beff18
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data_end+0x550/0xc20 fs/ext4/inline.c:763
Code: 25 28 00 00 00 0f 85 1d 06 00 00 48 81 c4 b0 00 00 00 44 89 f0 5b 5d 41 5c 41 5d 41 5e 41 5f e9 46 d6 87 08 e8 21 65 4c ff 90 <0f> 0b e8 19 65 4c ff 4d 8d 7c 24 34 4c 89 e7 e8 5c 3c 7c ff be 04
RSP: 0018:ffffc90004a3f928 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880452c82b0 RCX: ffffffff82400124
RDX: ffff888020358000 RSI: ffffffff8240049f RDI: 0000000000000001
RBP: 0000000000000020 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000004 R12: ffffea00013a6980
R13: 0000000000000020 R14: ffff8880452c8050 R15: ffffc90004a3f978
FS:  00007f1365d136c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffb08627d58 CR3: 0000000028762000 CR4: 0000000000350ef0


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

