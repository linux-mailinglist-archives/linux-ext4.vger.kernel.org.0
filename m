Return-Path: <linux-ext4+bounces-8581-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863EFAE30B1
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Jun 2025 18:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736193A596E
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Jun 2025 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803D1E3DCD;
	Sun, 22 Jun 2025 16:06:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E81422AB
	for <linux-ext4@vger.kernel.org>; Sun, 22 Jun 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608388; cv=none; b=KWbS/+eL5mk9yprk7KtM7t/m0G/Jrm9Q68UCIPUYX5zQXuXWEUv9NYg0oR1oNOu3RDnP9sqPqVSzYdl0W9Gdx6NoocGSMh5I3O1ipzBS2VzLl/9TXUUGph6o0sE92VhErTtwhdOP3K/WBVWft8VKVajDFAtxLTf/FkhOa2ffpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608388; c=relaxed/simple;
	bh=QtqSdw0XeDim7ssYq1U3SyRQBEDFpF9U8ijzIYdCBO4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b6VLrSxtSH2tVVBwkWA7AzptbZaSaa4NVnbdCaTh1hc3JY5MvxQ8Ikg4Gx3AgPB2N/Jb3Oxo9Gwfav2xq7q585IORrSDGdxiKPrgLT0APByUqCGdY0AX9wYJI/KDDVc7UDmcivmDuzxE7U94S6NfQi5MvjaEONJn4Bd+gvsu/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8730ca8143eso280616839f.0
        for <linux-ext4@vger.kernel.org>; Sun, 22 Jun 2025 09:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750608386; x=1751213186;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0V151CDHfoWBQ8MiOSvoJ2kdjMySgSwqw2rZQCfy+Os=;
        b=HypFtz0BejNGAKZWnhxGbxsMvqKxY+VqVWUpMseF6bmzcW6Kq0XhOLlGGdGPrOUZTa
         qU+qfZs5qAkWTEygtct9vX0Rmu4rAidGmIfhwaH4dBlp/ovsMh7ozrGROC1IPlfLJDVf
         +0rTl0l6aCeJkgt77NI3FMe6mMLby/IBuJJF1c+Vn4BSvDomqWvnxIwpwtxlpI8qqEPU
         TGT+GsjH3eQa7SRjXTUC7F1ZJnaUc6WEjO0+GJ44dUOYZNmpxWrPkkerbjQ+ZdP5JSYF
         EOewfijbBeBHBWOw4lMmFhi1308tfyIgFmPE3lktkPMmGTan8kWMwzDSQAOIalakEX/T
         2kMA==
X-Forwarded-Encrypted: i=1; AJvYcCWAtqyIeDHysKlZNQhBdb6r/to/vJnLF/ab+UftIgEQUIHO0wlAYrgD8Tfseu+y/Cn8fpEwjL19FaCU@vger.kernel.org
X-Gm-Message-State: AOJu0YzdutXRg9dy3/wdeGVPyEh7NmAdh6F+JlkObmJ/COl0gNBQleVZ
	TlTvabht8ejVWne/1hYCyJiRo83wnETEjv04ifQW5Va9SCWowoMt/sbSkY197H3qxirJtb1Kplw
	E7S8+kQM3HgRgcU5yvp674FGurRVw0KP0fGiST+prf7T2CRG+C+E5cOM28Tc=
X-Google-Smtp-Source: AGHT+IHs+we2xp73wL8GThscj4fHO6euYfpGxjmtLjfzEoE7KVFc8tnjHX8BFArNqG1cV/qvHtst2iUxMfMeRRN4C9k/sMfAB03u
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318c:b0:3dd:f02d:2d26 with SMTP id
 e9e14a558f8ab-3de39538520mr93082125ab.2.1750608385975; Sun, 22 Jun 2025
 09:06:25 -0700 (PDT)
Date: Sun, 22 Jun 2025 09:06:25 -0700
In-Reply-To: <67f94057.050a0220.2c5fcf.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68582a01.050a0220.bba34.0008.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_ext_insert_extent (2)
From: syzbot <syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    739a6c93cc75 Merge tag 'nfsd-6.16-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a19b0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=ad86dcdffd6785f56e03
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14af2182580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f5a65b9fc0ed/disk-739a6c93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f1b70f2f048/vmlinux-739a6c93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8ab27807c85/bzImage-739a6c93.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/376364fe7b8f/mount_2.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10af2182580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:2153!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 6732 Comm: syz.4.53 Not tainted 6.16.0-rc2-syzkaller-00318-g739a6c93cc75 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:ext4_ext_insert_extent+0x4ab7/0x4af0 fs/ext4/extents.c:2153
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c a6 e7 ff ff 48 89 df e8 2c 8b b6 ff e9 99 e7 ff ff e8 62 0d 53 ff 90 0f 0b e8 5a 0d 53 ff 90 <0f> 0b e8 52 0d 53 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000455ec60 EFLAGS: 00010293
RAX: ffffffff826d4f26 RBX: 0000000000000023 RCX: ffff888026e93c00
RDX: 0000000000000000 RSI: 0000000000000023 RDI: 0000000000000023
RBP: ffffc9000455ee10 R08: ffff8880609943a7 R09: 1ffff1100c132874
R10: dffffc0000000000 R11: ffffed100c132875 R12: 0000000000000023
R13: dffffc0000000000 R14: ffff88806bfde448 R15: ffff888027bf3d00
FS:  00007fe4a5ed66c0(0000) GS:ffff888125d51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003000 CR3: 0000000070c0d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_ext_map_blocks+0x1792/0x6ac0 fs/ext4/extents.c:4404
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x931/0x18d0 fs/ext4/inode.c:813
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:892
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:925
 ext4_block_write_begin+0x6f8/0x14b0 fs/ext4/inode.c:1178
 ext4_write_begin+0xa4f/0x1680 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x449/0xd20 fs/ext4/inode.c:3057
 generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 do_iter_readv_writev+0x56e/0x7f0 fs/read_write.c:-1
 vfs_writev+0x31a/0x960 fs/read_write.c:1057
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev2 fs/read_write.c:1211 [inline]
 __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe4a4f8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe4a5ed6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007fe4a51b5fa0 RCX: 00007fe4a4f8e929
RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007fe4a5010b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe4a51b5fa0 R15: 00007fffc4eaed48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_insert_extent+0x4ab7/0x4af0 fs/ext4/extents.c:2153
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c a6 e7 ff ff 48 89 df e8 2c 8b b6 ff e9 99 e7 ff ff e8 62 0d 53 ff 90 0f 0b e8 5a 0d 53 ff 90 <0f> 0b e8 52 0d 53 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000455ec60 EFLAGS: 00010293
RAX: ffffffff826d4f26 RBX: 0000000000000023 RCX: ffff888026e93c00
RDX: 0000000000000000 RSI: 0000000000000023 RDI: 0000000000000023
RBP: ffffc9000455ee10 R08: ffff8880609943a7 R09: 1ffff1100c132874
R10: dffffc0000000000 R11: ffffed100c132875 R12: 0000000000000023
R13: dffffc0000000000 R14: ffff88806bfde448 R15: ffff888027bf3d00
FS:  00007fe4a5ed66c0(0000) GS:ffff888125d51000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005610a8772950 CR3: 0000000070c0d000 CR4: 0000000000350ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

