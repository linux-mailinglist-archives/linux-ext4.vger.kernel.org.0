Return-Path: <linux-ext4+bounces-2931-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D6914448
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 10:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53421C201EE
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6DF4964D;
	Mon, 24 Jun 2024 08:10:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26C4962B
	for <linux-ext4@vger.kernel.org>; Mon, 24 Jun 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216622; cv=none; b=CnGU4TXIOBi2JtsFKcDIi+9Ib31awWxw02Y2QwP9XoVddBF2s+YObKIUiA779hEjWB9JxIzcPdkcmZYKv2ZGVXLkiuavUJLdWSiwy5YjLERy6i9fI4BsYtxM48JcTPBdnGRkl4mK9PfjN1o+SPofeuEHZDNU38we4UwYtt/twdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216622; c=relaxed/simple;
	bh=zIyvgWFaeIlC6wY0oLvhImDAkpB3sPxCGbJFpjHhtYU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=neKKS5zo2PAswxxzOkFdBSfWsHkre+qcQtx6/sQ3Horh5EkD/TOkwi0GQkj9oF+amRC5KJflG190FDMcpWM2FJ4LXTaeBBsmvliNo6pG+rsn8yr0ZWwlgAcsGPWM8G+NpaCNYTB/rJ+W6yMIaxTv5yXr3tgqwkZ2GYM550iKvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so528771539f.2
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jun 2024 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216620; x=1719821420;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4ui/w/2QHEuTbhE9x9Ney1/6b+4+wI7ecwps7AMd9k=;
        b=eI1tvV3p/gOITHTSolmehAMyKbE7FeVsSdGltOA+3Py5yRrIxn6Qnt8qftDvELl5Li
         ifs6x1wNRzdIXDFUsnrs4VMbZoJXjuyjkW7Kk+2ibR4VLm+4yuNDC223XlQucnvx71Ia
         iAh2pSjhAacOTXRVBFZynMxuE3I7yCSm1/o0C3cllQ3t0LWpjdhi90FMuXpi0nfIzcul
         3Ro3I4JWDETJX3YHuyxQ59vqB9e9a3d3NbdzbYxnSR+5fUN2E7F4TNlS4kdWwiWiXT1m
         U4bkLsw8kco2lPlv/0RK4ZGueUFWv8CnLwn7TqX0TVjwGh5bsgpBjl6+6/Vbib2Zns5G
         /3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXWmE5RwoGJ7uWyYovYehdXlYl0FOUwSACDDpYVZ/tLEe0niObBP1q0AbwrRKxXJw77jqiw1cA0Lm3t1FNG1mpSVvpCA829L5LJ7w==
X-Gm-Message-State: AOJu0YwHc9Rt7fL0jHtboxxExAeER1N6a0X+XVD5bqG/nUB43mXF3W+B
	2uOb9jQI+dJLIX5EZz1mnTqxEMMizo72+ZFtFI0aJeE2RTliLGZNLRZ7lWjATgU96gdjNJ4GyqO
	Rse+BcAdXvvQMwdPzwjbv/yyg3K+PMX0R1uemJzE3i9IBclWpu9EWi2U=
X-Google-Smtp-Source: AGHT+IFswqZDd0QhNaYPhOWm4JfDIL0Iv6J8blqz9+BBmj1/+K3kKzSiDXIJPipv1kvIV1AM1Mm6qTt7FGoEpq14wibUmsx0yxms
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0c:b0:7eb:ee5e:cc05 with SMTP id
 ca18e2360f4ac-7f3a4f6b459mr9015239f.4.1719216620082; Mon, 24 Jun 2024
 01:10:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 01:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eea704061b9e4fb8@google.com>
Subject: [syzbot] [ext4?] WARNING in __ext4_ioctl
From: syzbot <syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c16f0a4ed1c Merge tag 'i2c-for-6.10-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e04151980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d112b9ab538ebab
dashboard link: https://syzkaller.appspot.com/bug?extid=2cab87506a0e7885f4b9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b29845d4c0ce/disk-7c16f0a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e39e5d18a392/vmlinux-7c16f0a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6ac8c44d142/bzImage-7c16f0a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com

------------[ cut here ]------------
strnlen: detected buffer overflow: 17 byte read of buffer size 16
WARNING: CPU: 1 PID: 19420 at lib/string_helpers.c:1029 __fortify_report+0x9c/0xd0 lib/string_helpers.c:1029
Modules linked in:
CPU: 1 PID: 19420 Comm: syz-executor.1 Not tainted 6.10.0-rc4-syzkaller-00330-g7c16f0a4ed1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__fortify_report+0x9c/0xd0 lib/string_helpers.c:1029
Code: ed 48 c7 c0 20 c9 8f 8b 48 0f 44 d8 e8 8d 53 0b fd 4d 89 e0 48 89 ea 48 89 d9 4c 89 f6 48 c7 c7 a0 c9 8f 8b e8 e5 6e cd fc 90 <0f> 0b 90 90 5b 5d 41 5c 41 5d 41 5e e9 3e 67 8c 06 48 89 de 48 c7
RSP: 0018:ffffc90004c2fbf0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8b8fc920 RCX: ffffc9000bb9b000
RDX: 0000000000040000 RSI: ffffffff81514a46 RDI: 0000000000000001
RBP: 0000000000000011 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000010
R13: 0000000000000000 R14: ffffffff8b8fd2e0 R15: ffff88802bb42060
FS:  00007f6eba6e46c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff2d1cbc28 CR3: 0000000062552000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __fortify_panic+0x23/0x30 lib/string_helpers.c:1036
 strnlen include/linux/fortify-string.h:235 [inline]
 sized_strscpy include/linux/fortify-string.h:309 [inline]
 ext4_ioctl_getlabel fs/ext4/ioctl.c:1154 [inline]
 __ext4_ioctl+0x404d/0x4580 fs/ext4/ioctl.c:1609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x196/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6eb987d0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6eba6e40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6eb99b3f80 RCX: 00007f6eb987d0a9
RDX: 0000000020000100 RSI: 0000000081009431 RDI: 0000000000000003
RBP: 00007f6eb98ec074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6eb99b3f80 R15: 00007ffcd312f958
 </TASK>


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

