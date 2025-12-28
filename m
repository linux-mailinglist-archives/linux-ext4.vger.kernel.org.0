Return-Path: <linux-ext4+bounces-12523-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA962CE03C0
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Dec 2025 02:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F5D3019BD5
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Dec 2025 01:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55719DF8D;
	Sun, 28 Dec 2025 01:12:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48592110
	for <linux-ext4@vger.kernel.org>; Sun, 28 Dec 2025 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766884345; cv=none; b=AlBPI8TZ8E7+I/kweyDsCh04FaGBpDYZndmN6LHfgLya+By2QEqGVzG+K943XsKu5foMYngsR8qCOEOB0GXTF2HekmFBAG83TlxmsRPmmxzq7PEr1ise44xD8305xAjFM+FLpbnKIsh7x9PHrlhjeQMAf7V9CzC+DrKbcNV79p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766884345; c=relaxed/simple;
	bh=CchwsTWG3DttAc2YMvQehIbf3PVAq69S/9ewqBjVd9M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dk1WZZhRmkyI+NL+ZyLievP8GqrC/vbmM9/hnCtwpJ9iAXKp0C8uBPW/HaBO4uSKIKO/msTvVTx16Nm8eWTIYCSgMYREMtV3rW12kKI/m3QEAY75Pl7RJU/ynPiHSSRa2V152xtCBiY9kMxrpThAtyFJMPo3D5iv+IAISMikpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c7028db074so19576371a34.1
        for <linux-ext4@vger.kernel.org>; Sat, 27 Dec 2025 17:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766884343; x=1767489143;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6eJpI88FKh6ZjVL9JK9hMzFPX1Tp1Rejj3iWj4Z0mE=;
        b=gmWrtb9dRtxDlBBbAb4J5D/V9+nsEQseGUkwGqco6OaU9wvd+kdBC6BsnMTnlYq+4U
         VpSLyKpS8nyzj2/0AKTOS9Xd4JgkIUjXRZBZ7lCO2I17+oPEt92qQA58LZizUwidIyWM
         xOi5G4DMwk/qiaA4CKsDGCB8a8C1JECS7F7YIU8cp8a4IIOwcxGJHiyR9ND9fJRjquoq
         Ma9qHSw2xPvqOAaYeKqIaXVI62H6/rQYtvxohf9A7NhruaygjeQa9uQ4Udd3gZUHXvZ5
         ThLpcX4ILEQ9i2iz8gwQ7ZP9GDJomFZannHeLHyjO8OnOD30RF1PjB3MPjRm0qupdjgx
         jQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCVdyuhGec4gczlzrZwXOszZDLhMxrjGGIf/piB3WTFTbCfItnqixC6ANR3r2oGOVjF9eylbXXcI32jJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhU4s21IrfKXQxzEc/w2ZxM2c3xYs83UGIcBFGcV1RWwoSG5B
	gWmYC4m/bcZZJqx8651MWt6XLhrlQ6Ww4olGylHi3WOnUl+WGmMWvlBeWe3clbZgcNoOprUiJbl
	BV9wwgCuVWJG7gcS0zK85q4NTPJmhF4tUsKifsdHwcImMi6dc+lNVjbOLkec=
X-Google-Smtp-Source: AGHT+IHTEVcSbFK80DYbOJRHn/QwP6HXdw1EfojU5MjuO0UruxieEPM+wqoHQfXrag6ukfJwKvvYDz/ITqYimjTnGR2LJknoPACC
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2225:b0:659:9a49:8f28 with SMTP id
 006d021491bc7-65d0eab99c4mr11097021eaf.57.1766884342781; Sat, 27 Dec 2025
 17:12:22 -0800 (PST)
Date: Sat, 27 Dec 2025 17:12:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695083f6.a70a0220.90d62.0015.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_mb_normalize_request (2)
From: syzbot <syzbot+90ae103900a7d79e46f1@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b927546677c8 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15344b92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=90ae103900a7d79e46f1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ddac8d425533/disk-b9275466.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d9161401879/vmlinux-b9275466.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc4982f21fd4/bzImage-b9275466.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90ae103900a7d79e46f1@syzkaller.appspotmail.com

EXT4-fs (loop2): start 0, size 131072, fe_logical 131072
------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:4657!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6131 Comm: syz.2.37 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:ext4_mb_normalize_request+0x1cd8/0x1d10 fs/ext4/mballoc.c:4657
Code: 71 ae ff 48 8b 44 24 38 48 8b 38 48 c7 c6 80 bc fe 8a 48 c7 c2 e0 d2 fe 8a 48 8b 4c 24 28 4d 89 f0 49 89 d9 e8 19 f5 09 00 90 <0f> 0b e8 f1 3a 4c ff 90 0f 0b e8 e9 3a 4c ff 90 0f 0b e8 e1 3a 4c
RSP: 0018:ffffc9000613ed20 EFLAGS: 00010246
RAX: f56237077cb2d800 RBX: 0000000000020000 RCX: f56237077cb2d800
RDX: ffffc9000ff71000 RSI: 0000000000000674 RDI: 0000000000000675
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000c27d2d R12: ffffffff00020800
R13: dffffc0000000000 R14: 0000000000020000 R15: 0000000000020000
FS:  00007f17dd9456c0(0000) GS:ffff888126def000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110f246add CR3: 000000002897a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_mb_new_blocks+0xc46/0x46b0 fs/ext4/mballoc.c:6310
 ext4_ext_map_blocks+0x1877/0x69c0 fs/ext4/extents.c:4383
 ext4_map_create_blocks fs/ext4/inode.c:613 [inline]
 ext4_map_blocks+0x82c/0x16f0 fs/ext4/inode.c:816
 _ext4_get_block+0x1fa/0x4c0 fs/ext4/inode.c:916
 ext4_block_write_begin+0xb03/0x1940 fs/ext4/inode.c:1203
 ext4_write_begin+0xb3a/0x1870 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x352/0xd30 fs/ext4/inode.c:3130
 generic_perform_write+0x29d/0x8c0 mm/filemap.c:4314
 ext4_buffered_write_iter+0xd0/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x293/0x1be0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5d5/0xb40 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x196/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17df6ff749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f17dd945038 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f17df956090 RCX: 00007f17df6ff749
RDX: 0000000000000001 RSI: 0000200000000140 RDI: 0000000000000008
RBP: 00007f17df783f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008000c61 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f17df956128 R14: 00007f17df956090 R15: 00007ffdca7c0738
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_normalize_request+0x1cd8/0x1d10 fs/ext4/mballoc.c:4657
Code: 71 ae ff 48 8b 44 24 38 48 8b 38 48 c7 c6 80 bc fe 8a 48 c7 c2 e0 d2 fe 8a 48 8b 4c 24 28 4d 89 f0 49 89 d9 e8 19 f5 09 00 90 <0f> 0b e8 f1 3a 4c ff 90 0f 0b e8 e9 3a 4c ff 90 0f 0b e8 e1 3a 4c
RSP: 0018:ffffc9000613ed20 EFLAGS: 00010246
RAX: f56237077cb2d800 RBX: 0000000000020000 RCX: f56237077cb2d800
RDX: ffffc9000ff71000 RSI: 0000000000000674 RDI: 0000000000000675
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff52000c27d2d R12: ffffffff00020800
R13: dffffc0000000000 R14: 0000000000020000 R15: 0000000000020000
FS:  00007f17dd9456c0(0000) GS:ffff888126def000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110f246add CR3: 000000002897a000 CR4: 00000000003526f0


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

