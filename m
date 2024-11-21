Return-Path: <linux-ext4+bounces-5291-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF669D4964
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 10:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834291F21E13
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F871CB334;
	Thu, 21 Nov 2024 09:00:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA78C136358
	for <linux-ext4@vger.kernel.org>; Thu, 21 Nov 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179630; cv=none; b=nUQ48ah55ogjHUeHdAeJAsfBcpDSDbbjOIMXr+Av3UCQdaKpZMyI9Y6ny6cSSoaTFtNaVtMp7mnzIwYhqomWssGGLgpO++mHtZC9/i3+iLddYiRZNUCNWcXjSiLRnS6UJByoYKkf3yP4H88VlWyJhBsnSuzicJNcxFfMk2nFjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179630; c=relaxed/simple;
	bh=0pZ6FC72ApcrhdHAU8M2XWQ1KBmmDwfxkiijPW8do3k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xo+/Gras+0IsWllUm2DVojjJ5QGKf0/fg5F6FLiBlQj0dFNwgV/OcSY97tnGS3bRhsoH7atod33YWGKuu6sZH15zwM6z1eBBPN4FEtQqRcinn8hcOSwuzjopfeYP3rw2ymjOs6H+tviHvAICDXeVtsJThq6p32bITrg5OMd+JBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79088e7abso6475205ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Nov 2024 01:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179625; x=1732784425;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbo9m0XZMgb6dNGJZhRzeXwd435fnhHwFdxfyvcWvps=;
        b=vxXIFwDn1G4lz5bvWtEberctWgFktn1s+oGjPjVbuYG/MD8C6UMZibRWHA/767xw8Q
         XyxftDjQv9bdkx3aoPSnrhOKiqmAlzP9AAGBOfIU2UbhDrCFFWGKGAfwTTjO0+mbHLyW
         OpU717CzyOIV8E4N+aY1LfIYUVuKy5FMawYRJnCE3qJnb+3ekdhQaZMd8pdklCLKDri5
         BIlmpYkiJf0P17Rf/JsJ3HhoqhAIgnF8PUUYQDWEUVxUiBbuLp1gBIapzWKfQYI+I1O2
         mXZjXVaN7LS2abIEeuhQQuaQGXDWuxCw8QvnxUbGdNM30aHHvT31eu42G7gR1X4WZRFh
         iKrg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1jHUs9rcUOegc5dzY51DmScSKL9yyHQveO6heUjkF6Wmu65cLapCDYB/vZI3O0uiLFRLUUh3NwcB@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqQI2VJJeiIWB1vFTUh4nOwCtwB5IS1bNXqAfpHuXINoR7jmX
	IuFAh0XE+C/8pQi0zikcv/T+gZxgMiVf7JTB6Qr/UYmntLKyNECtpdmv2f6ZEbKsWCQ/i2oodO/
	nAAzsfOCmRJSTKvAjpUg0cfmC9Ol8sGZmZtCzBRm4OjSyGKUH0TJ9q8w=
X-Google-Smtp-Source: AGHT+IG0LqqCpejA4AgoN4h+S717FRAooPXjzDZb+3DwtHxqa9Bq1iTTI0p1ivcdahrksK/khwBicxDPMev8CD5NgOvItu13d9vR
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:3a7:9358:b286 with SMTP id
 e9e14a558f8ab-3a79358b407mr8135535ab.0.1732179624859; Thu, 21 Nov 2024
 01:00:24 -0800 (PST)
Date: Thu, 21 Nov 2024 01:00:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673ef6a8.050a0220.3c9d61.016c.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a5df3796467 Merge tag 'mm-hotfixes-stable-2024-11-16-15-3..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165adb5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca2f08f822652bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118eb2c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1395f130580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5912c1b48bcf/disk-4a5df379.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9bdeba257b7/vmlinux-4a5df379.xz
kernel image: https://storage.googleapis.com/syzbot-assets/567e5bf968eb/bzImage-4a5df379.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/94e36b599391/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:235!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5838 Comm: syz-executor116 Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:ext4_write_inline_data+0x36b/0x460 fs/ext4/inline.c:235
Code: df 41 ff e8 f7 df 41 ff 45 8d 64 2c c4 b8 3c 00 00 00 29 e8 4c 63 f0 e9 c7 fe ff ff e8 de df 41 ff 90 0f 0b e8 d6 df 41 ff 90 <0f> 0b e8 8e b8 a2 ff e9 d6 fd ff ff 4c 89 ff e8 81 b8 a2 ff e9 71
RSP: 0018:ffffc90003e078e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888074c38c98 RCX: ffffffff824b9874
RDX: ffff8880349bbc00 RSI: ffffffff824b9a7a RDI: 0000000000000006
RBP: 0000010000000005 R08: 0000000000000006 R09: 0000010000000006
R10: 000000000000003c R11: 0000000000000000 R12: 0000000000000001
R13: ffffc90003e07980 R14: 0000010000000006 R15: ffff888074c39242
FS:  00005555714a8380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000077348000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x278/0xc50 fs/ext4/inline.c:774
 ext4_da_write_end+0x54e/0xd00 fs/ext4/inode.c:3065
 generic_perform_write+0x4e8/0x920 mm/filemap.c:4069
 ext4_buffered_write_iter+0x119/0x3c0 fs/ext4/file.c:299
 ext4_file_write_iter+0x861/0x19d0 fs/ext4/file.c:698
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0x5b1/0x1150 fs/read_write.c:683
 ksys_pwrite64 fs/read_write.c:798 [inline]
 __do_sys_pwrite64 fs/read_write.c:808 [inline]
 __se_sys_pwrite64 fs/read_write.c:805 [inline]
 __x64_sys_pwrite64+0x200/0x260 fs/read_write.c:805
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f18e1c07679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5a649ea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007fff5a64a078 RCX: 00007f18e1c07679
RDX: 0000000000000001 RSI: 0000000020000300 RDI: 0000000000000004
RBP: 00007f18e1c7b610 R08: 0000000000000000 R09: 00007fff5a64a078
R10: 0000010000000005 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff5a64a068 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x36b/0x460 fs/ext4/inline.c:235
Code: df 41 ff e8 f7 df 41 ff 45 8d 64 2c c4 b8 3c 00 00 00 29 e8 4c 63 f0 e9 c7 fe ff ff e8 de df 41 ff 90 0f 0b e8 d6 df 41 ff 90 <0f> 0b e8 8e b8 a2 ff e9 d6 fd ff ff 4c 89 ff e8 81 b8 a2 ff e9 71
RSP: 0018:ffffc90003e078e0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888074c38c98 RCX: ffffffff824b9874
RDX: ffff8880349bbc00 RSI: ffffffff824b9a7a RDI: 0000000000000006
RBP: 0000010000000005 R08: 0000000000000006 R09: 0000010000000006
R10: 000000000000003c R11: 0000000000000000 R12: 0000000000000001
R13: ffffc90003e07980 R14: 0000010000000006 R15: ffff888074c39242
FS:  00005555714a8380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5524d17095 CR3: 0000000077348000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

