Return-Path: <linux-ext4+bounces-4246-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF697DC1A
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2024 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53618282ABB
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648FB154BE3;
	Sat, 21 Sep 2024 08:17:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426E13FD72
	for <linux-ext4@vger.kernel.org>; Sat, 21 Sep 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906643; cv=none; b=gmuzgY9/VirmOqxNAK8eZaIPMU8aMltJzxZOqWgcELl4dSiuxX5YLAXfsgg8iJRR0kWhPWWsRWpVNY5XhEqh54QKOU3MUjkYqpmzmabTJlqwiQKKW7ZmNZtN04p/vfjG0mHVjuB0Ej85day+OHytwM6/w8NlhxeY3cXcbUNeOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906643; c=relaxed/simple;
	bh=g++pXi4T1DSzlKp/R53oIfSkv1FeId8VMhHLbL26c1E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GvOFcmLeH7RqHqyPv4pzXm4hVKBC6TSVMUdxUJdIwZJmTRCmCd7KcIEYgjGXIkeYezJmZV9zyRcf1456YMCBmyhIzhgt97FEPAz3bfPw/BCjg/VWgBBoUTDvYN1SnOirQtspsqJIsNpCp8Rg5s7dBwulQmmA7zrrfX1d63d1/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so16967015ab.3
        for <linux-ext4@vger.kernel.org>; Sat, 21 Sep 2024 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726906640; x=1727511440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVoTkAm9RTVzwPh5+t1mp2pZQ32hgob0QzBtdBsA1tI=;
        b=BOmzgWMffIqgfEZp5cNO42Yn0j57RlRR0NfocyosXDN4Hl+a6F7Rw5cGv+cRsSe2lW
         GKPistpwHzBNNGK9toImER6ZaAhnTVKdO8jMcQk3+eZEKMz9J/M9fTUKfoafCCGMpfzQ
         WCxNiPSxokfZirGEVJVaX3YlbEmy1LG8O3yNRrS5AnlQweGCQWFAFNL1/3q709qBGG1m
         7yBLPY7T/y2qYQrZc8m0yNy66qOM6TEiIU3NS7ltWxokoltdvIkUk5ho70gKztB0YC4F
         yDWIm19H9jwdumh0oNFItkvwRM6AvLj6TE5OtE32y0gbb1ki5bwHNp987OEmIV+b2Xwz
         qzrw==
X-Forwarded-Encrypted: i=1; AJvYcCXwRgZdx0UQNAhBAdoGa19/2ldPMQUVrMUR2TEQSdKKSu55q7MU6HHhPHn79/g2hD5wGMpr6kJVD+xS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/jlLI+Ul/DOOOsVxh+AyNQQbGPxUMj3vGGPbnpM5XO/DQmFP
	f81MKzZaBetpZCpSFc44xZUi71iLvRcSRSseaihVVgefAIl0LeNQTplEY3fuyEWrou91WZP5Sbn
	lsOipDPSrTcWo/5P/4QaYJ4i/RYe3J4lhQlU0Gnh+TGxRt2DsW+VVENw=
X-Google-Smtp-Source: AGHT+IEGT06m/Z0bkz8Gj8M8Hm3ZGerK5oN1wsvWfNEr0w1FNVNcgj7Cuxuw+DotJIzIMK2hTIbJLiFvNQpRW589yZ+Ev3ack4QE
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:39f:6180:afca with SMTP id
 e9e14a558f8ab-3a0c8cd7625mr61261645ab.13.1726906640696; Sat, 21 Sep 2024
 01:17:20 -0700 (PDT)
Date: Sat, 21 Sep 2024 01:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee8110.050a0220.3195df.003f.GAE@google.com>
Subject: [syzbot] [ext4?] KCSAN: data-race in __filemap_add_folio / sync_bdevs (2)
From: syzbot <syzbot+cf1fa2a387833ee7edec@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1868f9d0260e Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1067ff00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b3c9c7ae5fde27e
dashboard link: https://syzkaller.appspot.com/bug?extid=cf1fa2a387833ee7edec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16d776046b21/disk-1868f9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b09f78f002c/vmlinux-1868f9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7705cc7035ce/bzImage-1868f9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf1fa2a387833ee7edec@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __filemap_add_folio / sync_bdevs

read-write to 0xffff8881004c24b0 of 8 bytes by task 2929 on cpu 0:
 __filemap_add_folio+0x439/0x710 mm/filemap.c:920
 filemap_add_folio+0x9c/0x1b0 mm/filemap.c:972
 __filemap_get_folio+0x2f1/0x5b0 mm/filemap.c:1960
 grow_dev_folio fs/buffer.c:1043 [inline]
 grow_buffers fs/buffer.c:1109 [inline]
 __getblk_slow fs/buffer.c:1135 [inline]
 bdev_getblk+0x173/0x3b0 fs/buffer.c:1437
 __getblk include/linux/buffer_head.h:380 [inline]
 jbd2_journal_get_descriptor_buffer+0xcf/0x210 fs/jbd2/journal.c:974
 jbd2_journal_commit_transaction+0xc03/0x33e0 fs/jbd2/commit.c:610
 kjournald2+0x20b/0x3c0 fs/jbd2/journal.c:201
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff8881004c24b0 of 8 bytes by task 1695 on cpu 1:
 sync_bdevs+0xd6/0x260 block/bdev.c:1228
 ksys_sync+0x8c/0xe0 fs/sync.c:106
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 x64_sys_call+0x2693/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:163
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000a25 -> 0x0000000000000a26

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 1695 Comm: syz.0.18383 Tainted: G        W          6.11.0-syzkaller-07462-g1868f9d0260e #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


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

