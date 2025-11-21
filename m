Return-Path: <linux-ext4+bounces-11966-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C4C78137
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 10:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7E2D12C7DD
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Nov 2025 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0A33F378;
	Fri, 21 Nov 2025 09:14:03 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E22BD001
	for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716443; cv=none; b=XtVkpAh/c+A+Zf1LHJmCpehpZHTgzto/rZrOedpCHNf2diIkTGIITsxn9u79FWUUNt1waE355sJRBzkLWjHxu/CL3rL7yxxzNIu8sQseJAyhN8gECxlpXe3YpwJoHo7tL/sVjCku2Yh0Rwm4O1XXaizKmpgNGHRdBDEvKmP9BBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716443; c=relaxed/simple;
	bh=Jc2DqQ/fP8BK3WMoG3tuD7oT46LSQbdlO8kprYWRsUs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=UQXUS8+QRvCFtbnFM326BdGIBadMg8Q2HVWQ/WT7WcXOBygC+0PA6B1t1aOxgNxMKpCQD38qxzHVhgcehv/6iDUL9wtI8QLi/BBYrb0VYVcQaiYsamieh68+WYQJlL4ANaaT/R/0L9+JoutaDDxWwZxed1sa2YKJOfmR8WoTOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945c705df24so296484839f.0
        for <linux-ext4@vger.kernel.org>; Fri, 21 Nov 2025 01:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716440; x=1764321240;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaU7b1tPnAy9MbStdPZMM0LGfXCMkPH3WaOdRjKt+hs=;
        b=VcgM+t05pEv9wvjeh7TLynYBmoA8Ggtl3vDFp9TmEIlAlaU5MzuBh4a9v5BaTkNg/D
         3dVhOcSmZFzlCSmcDbqM5NK2Kf3Jb6jtsHZXE7XZ5/O2tjcgW6CyUHxE0096kcJRcE1N
         qdVmjOPT1pshu9xqzjlpECsgV5nCoPD056V3T0g79mrdhEIxcRzbknxKOdSw6fdbVUzs
         GoVTJtfbTbfjkQFr9xmcbz0PkPogtgNuBL3p5l+Pp9MBIao1isjntCH+dy/k1vd06buN
         Cwu/dnu3ZPsC2W7EmOfkT0/+HHplAwYAibYNsP3z90OOyiJV6/8/aPnKespkgDkjGdgp
         r9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFnx+lTeRfPd491IqmzSLJhYAFneiDeOmRwwasm4sL5JLjbaOPjUelQsnqSdHjtJAbIXsj0MwIQg/p@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7YnhKUxvHMvyqABQyKmpQRIQrHq3IuHxgZunnRkS+j2afzQV
	X0g/iJnO9TNcurMCdlHix2eLRyBRY3s913IILpulGNxDSJmtxfGPlQnIwenhBw1U1DCRB/bqP8A
	NW15e2IbdPjuS0kjRczKOnJjuP6DHUSUbDDdUj/Ev51ZOmwCrl+ncoEZ4X8k=
X-Google-Smtp-Source: AGHT+IFkkL80B3Q5Vrbgw3AmsqESm7/didpzZgdBjDKGxCVoYouEQfQZKWZ4yk0DY9khMYFu82Gv5R1iSm6itsrelpJ1FgSgppR0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2145:b0:433:7929:e7a8 with SMTP id
 e9e14a558f8ab-435aa8d0f3amr41238845ab.12.1763716440667; Fri, 21 Nov 2025
 01:14:00 -0800 (PST)
Date: Fri, 21 Nov 2025 01:14:00 -0800
In-Reply-To: <20251121002209.416949-2-eraykrdg1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69202d58.a70a0220.2ea503.004a.GAE@google.com>
Subject: [syzbot ci] Re: ext4: fix unaligned preallocation with bigalloc
From: syzbot ci <syzbot+cib6a48fc441f958bd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, albinbabuvarghese20@gmail.com, 
	david.hunter.linux@gmail.com, eraykrdg1@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	syzbot@syzkaller.appspotmail.com, tytso@mit.edu
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] ext4: fix unaligned preallocation with bigalloc
https://lore.kernel.org/all/20251121002209.416949-2-eraykrdg1@gmail.com
* [PATCH] ext4: fix unaligned preallocation with bigalloc

and found the following issue:
kernel BUG in ext4_mb_new_inode_pa

Full report is available here:
https://ci.syzbot.org/series/5fbb06a2-0d5c-4936-94b6-d73abad55373

***

kernel BUG in ext4_mb_new_inode_pa

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      23cb64fb76257309e396ea4cec8396d4a1dbae68
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/3beb0e0f-6449-481d-8a5c-870149d28caf/config
C repro:   https://ci.syzbot.org/findings/891b93f7-ef7e-4890-8c4b-ed438fa3fa28/c_repro
syz repro: https://ci.syzbot.org/findings/891b93f7-ef7e-4890-8c4b-ed438fa3fa28/syz_repro

loop0: detected capacity change from 0 to 1024
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:5312!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5990 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ext4_mb_new_inode_pa+0x144e/0x1520 fs/ext4/mballoc.c:5312
Code: 5d 04 00 eb 2c e8 42 d8 43 ff 90 0f 0b e8 3a d8 43 ff 90 0f 0b e8 32 d8 43 ff eb 3c e8 2b d8 43 ff 90 0f 0b e8 23 d8 43 ff 90 <0f> 0b e8 1b d8 43 ff 31 f6 65 ff 0d 82 24 f2 0f 0f 94 c3 40 0f 94
RSP: 0018:ffffc900037c6a88 EFLAGS: 00010293
RAX: ffffffff827c2b9d RBX: 0000000000000201 RCX: ffff8881ba628000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: 0000000000000210
RBP: 0000000000000190 R08: ffffea000418ec37 R09: 1ffffd4000831d86
R10: dffffc0000000000 R11: fffff94000831d87 R12: 0000000000000004
R13: ffff88801b03f2b8 R14: dffffc0000000000 R15: 0000000000000210
FS:  0000555557696500(0000) GS:ffff88818eb3b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f863fff CR3: 000000016b520000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 ext4_mb_try_best_found+0x33e/0x440 fs/ext4/mballoc.c:2389
 ext4_mb_regular_allocator+0x9fa/0x2970 fs/ext4/mballoc.c:3040
 ext4_mb_new_blocks+0xd11/0x4720 fs/ext4/mballoc.c:6319
 ext4_ext_map_blocks+0x161a/0x6ac0 fs/ext4/extents.c:4383
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x860/0x1740 fs/ext4/inode.c:811
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:910
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:943
 ext4_block_write_begin+0x993/0x1710 fs/ext4/inode.c:1198
 ext4_write_begin+0xc04/0x19a0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x445/0xda0 fs/ext4/inode.c:3129
 generic_perform_write+0x2c5/0x900 mm/filemap.c:4254
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_pwrite64 fs/read_write.c:793 [inline]
 __do_sys_pwrite64 fs/read_write.c:801 [inline]
 __se_sys_pwrite64 fs/read_write.c:798 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:798
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f2c38f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff15880d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f3f2c5e5fa0 RCX: 00007f3f2c38f6c9
RDX: 0000000000000001 RSI: 00002000000005c0 RDI: 0000000000000004
RBP: 00007f3f2c411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000004fed0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3f2c5e5fa0 R14: 00007f3f2c5e5fa0 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_new_inode_pa+0x144e/0x1520 fs/ext4/mballoc.c:5312
Code: 5d 04 00 eb 2c e8 42 d8 43 ff 90 0f 0b e8 3a d8 43 ff 90 0f 0b e8 32 d8 43 ff eb 3c e8 2b d8 43 ff 90 0f 0b e8 23 d8 43 ff 90 <0f> 0b e8 1b d8 43 ff 31 f6 65 ff 0d 82 24 f2 0f 0f 94 c3 40 0f 94
RSP: 0018:ffffc900037c6a88 EFLAGS: 00010293
RAX: ffffffff827c2b9d RBX: 0000000000000201 RCX: ffff8881ba628000
RDX: 0000000000000000 RSI: 0000000000000201 RDI: 0000000000000210
RBP: 0000000000000190 R08: ffffea000418ec37 R09: 1ffffd4000831d86
R10: dffffc0000000000 R11: fffff94000831d87 R12: 0000000000000004
R13: ffff88801b03f2b8 R14: dffffc0000000000 R15: 0000000000000210
FS:  0000555557696500(0000) GS:ffff88818eb3b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f863fff CR3: 000000016b520000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

