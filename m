Return-Path: <linux-ext4+bounces-10596-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF1BB5C55
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 03:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA76E3B2E5C
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728C6296BB9;
	Fri,  3 Oct 2025 01:55:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BA28853A
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 01:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456532; cv=none; b=NODpbGvSbgPGXuslNrXh3DIM7rBL1tVdlhrywU7ZgVXnhDTUBUL/rFrVJtjl1otgMDsAMOxubRY8+IM6bPqJEAazn2erubLSvcYsZnjrjV61xQiU0r4JfNc8Dy6LeGGd+pWlSe/ZIWgzYsaOZMhmPBbOuFGCUcs2/vqeRx+OOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456532; c=relaxed/simple;
	bh=qWk8AgrJJmhOEMXTnwKeHf7XXlaYB3mebSxW6Owi3VM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R/tJ783Vd4u168Wvf/x/+/d5QPWN5ZNNxNgRCUsyowGdT9qTDhoK1a9zLV1XVJlXnSezxBcSXSCuDYh22QVamTsEusYqd+9Rm/FLfKrLAtPTqrb6QCLVXR20yr2Xs8RGg1H1mmKE1le/lIS8G/DvnMT/nlMljgUfOHQZM2A8rvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-42b2a51fad2so36254055ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 02 Oct 2025 18:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759456526; x=1760061326;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dH7U9A7PVp4O2sNOAlP/euqgHj07irDgR0pPKn7bG5k=;
        b=uEhJvnfF5Rk7wWA9T8t7m6LEAzZmSqrcP1N2YLiPFsqtmz6lYcKAbhAbeqCqNYfobG
         P8aW4lvpPpTLUKDWZy+zszsM3nJZnXxjvVjnTyWD3O9yU9aaKdGwJxyEsQyuLlK/hPll
         4iT/qpdKVNqkgsE8NHBO/45IqOFcxiS9orPJRyTC3RMkv3NpIVgnXraUgDahshzEq0FU
         fxJVSkT4fbzY/35be8cafWA1Ijkd9hPhGnlayWWx+Av7A3HgFKb1TcMUnE3+JSxwPTHf
         4GsXHA74UwhO13+4dVnPhTDLVN0i1RGXjb5B+fghzQX1at/+Yvs1jBep3HAbmLTDgl1V
         r9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXrWoufFX2rLz2elVxJW/qLWmhdce8gN+ElIYn19uyfXfwLaxAxsyACcbqNbpXH65T1n2LbyFDT2Dou@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+iaF07V6ByDTDtGlMvk+4IHRDOkm6SXMYKK7zp/3AWmaHLbc
	OzX60u4wJYku0/jXyBXPOVtRcakJp5T6UVQrzEKjZa+914PSRdG0aculRI8KDaX2Ly7jhoVVrj0
	6ItS8W9/dVRKmjDwNXtlroIVOBbUuzUZkOhsm8W12uIwtshojNCeD4sKf/BM=
X-Google-Smtp-Source: AGHT+IGVi2G4IMqu2sDDmMmN6PgzJGI4RFf8seXYTB5TIGQ5b8pXkw7aM65h6RtsSsQeYspyrDLXWSjD55ZOiQRkYfI7DKq265B5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3785:b0:424:805a:be98 with SMTP id
 e9e14a558f8ab-42e7b220cd4mr14510605ab.9.1759456525977; Thu, 02 Oct 2025
 18:55:25 -0700 (PDT)
Date: Thu, 02 Oct 2025 18:55:25 -0700
In-Reply-To: <68c58bfa.050a0220.3c6139.04d2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df2d0d.050a0220.1696c6.0039.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7f7072574127 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135c1ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9d13d0fd373120a
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e49334580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16758458580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dce8562bc0e/disk-7f707257.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f79b72b8bfa8/vmlinux-7f707257.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0289c1875c1/bzImage-7f707257.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3bb52035efeb/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1022a85b980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:240!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 7460 Comm: syz.5.349 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_write_inline_data+0x43c/0x440 fs/ext4/inline.c:240
Code: c1 38 c1 0f 8c 19 ff ff ff 48 89 df 49 89 d7 e8 fa b0 b0 ff 4c 89 fa e9 06 ff ff ff e8 2d 07 4c ff 90 0f 0b e8 25 07 4c ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc9000bff7828 EFLAGS: 00010293
RAX: ffffffff82726f5b RBX: 0000000000000078 RCX: ffff888026215ac0
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000078
RBP: ffff8880773424a2 R08: ffff8880599a2387 R09: 1ffff1100b334470
R10: dffffc0000000000 R11: ffffed100b334471 R12: 000000000000003c
R13: ffffc9000bff78e0 R14: 0000000000000000 R15: ffff888077341f48
FS:  00007f61146ab6c0(0000) GS:ffff888126380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdcd7e1e000 CR3: 0000000010f34000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x336/0xab0 fs/ext4/inline.c:807
 generic_perform_write+0x62a/0x900 mm/filemap.c:4196
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f611378eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f61146ab038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f61139e5fa0 RCX: 00007f611378eec9
RDX: 0000000000000078 RSI: 0000200000000600 RDI: 0000000000000005
RBP: 00007f6113811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f61139e6038 R14: 00007f61139e5fa0 R15: 00007fff25d44648
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x43c/0x440 fs/ext4/inline.c:240
Code: c1 38 c1 0f 8c 19 ff ff ff 48 89 df 49 89 d7 e8 fa b0 b0 ff 4c 89 fa e9 06 ff ff ff e8 2d 07 4c ff 90 0f 0b e8 25 07 4c ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f
RSP: 0018:ffffc9000bff7828 EFLAGS: 00010293
RAX: ffffffff82726f5b RBX: 0000000000000078 RCX: ffff888026215ac0
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000078
RBP: ffff8880773424a2 R08: ffff8880599a2387 R09: 1ffff1100b334470
R10: dffffc0000000000 R11: ffffed100b334471 R12: 000000000000003c
R13: ffffc9000bff78e0 R14: 0000000000000000 R15: ffff888077341f48
FS:  00007f61146ab6c0(0000) GS:ffff888126380000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efcc67a1d58 CR3: 0000000010f34000 CR4: 0000000000350ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

