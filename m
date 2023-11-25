Return-Path: <linux-ext4+bounces-159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7C87F89F9
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 11:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B061C20C05
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Nov 2023 10:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D6D260;
	Sat, 25 Nov 2023 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732610F0
	for <linux-ext4@vger.kernel.org>; Sat, 25 Nov 2023 02:34:21 -0800 (PST)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-2858e95c5f3so1831530a91.3
        for <linux-ext4@vger.kernel.org>; Sat, 25 Nov 2023 02:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700908460; x=1701513260;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se0ZOXdRV1peEbVSvfNfMV+mmpDxGBnZZU1k+8yU+cs=;
        b=Qk1aCAYJftmuVZ8U1l7O0Ft21XbutFcqN/UcBv8nbR3PJCVBscxKDi0eE4LdBPMwoT
         +SCOEyM5gc9VLB20YMXxMsd959iNxPSgYVz4fy9R6x7Ka1iWvq+ntYgN2HO0ylssGPNv
         EP43d3za0r+qndHkMIu7GrsNz4OFLtGJFfr4DnDoR0YeoB2Mxis2O9T8lozx+YRODmsE
         n5sicYDN/wjKkPJqWL8yHq40s/MRviG7tE91R1bEneFY/odkXrvDBs93VsTJWmGddlNa
         1lnm8vfANMVf8Ci4qCf3X1ew5TejNMCfqoIY1KDw3oE1+wkvCDpNHy15B6Ek5CR5jBEu
         9+gA==
X-Gm-Message-State: AOJu0YyMSzbixHQr6d/NgMN0ULMTHqWCAhIudJLkBirwFI1FkLsOuNL/
	GGmd31t22BUDCbGkGyLM0xEbcG0ukBU27RWkfIvpghwY1acd
X-Google-Smtp-Source: AGHT+IHiwtbfJ/arwx77x/WBmptDnn6/xe3Nl8FvasT6WVkWm4tJ8ZA+a/aOx62z/xtMbpWI5VRW2xOW5A0UYYFf9PKjyDDciCaU
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:2311:b0:1cf:91d4:2908 with SMTP id
 d17-20020a170903231100b001cf91d42908mr1086162plh.1.1700908460669; Sat, 25 Nov
 2023 02:34:20 -0800 (PST)
Date: Sat, 25 Nov 2023 02:34:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009800de060af79c8f@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_mb_release_inode_pa
From: syzbot <syzbot+64f520f6fe02b8947407@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11583b58e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aec35c1281ec0aaf
dashboard link: https://syzkaller.appspot.com/bug?extid=64f520f6fe02b8947407
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163a9768e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b60687e82ad4/disk-98b1cc82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29477f0b04df/vmlinux-98b1cc82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9aab12888a60/bzImage-98b1cc82.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9009db42dccd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64f520f6fe02b8947407@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:5300!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10719 Comm: syz-executor.1 Not tainted 6.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:ext4_mb_release_inode_pa.isra.0+0xa30/0xb80 fs/ext4/mballoc.c:5300
Code: b5 fb ff ff e8 a1 1a 50 ff 90 0f 0b e8 99 1a 50 ff 31 ff 44 89 ee e8 ff 15 50 ff 45 85 ed 0f 84 81 f8 ff ff e8 81 1a 50 ff 90 <0f> 0b e8 69 e7 a5 ff e9 e5 f6 ff ff 48 89 d7 e8 5c e7 a5 ff e9 4a
RSP: 0018:ffffc9000a1af690 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffe428 RCX: ffffffff823665c1
RDX: ffff88802b52a1c0 RSI: ffffffff823665cf RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000005 R12: ffff88806442ac08
R13: 0000000000000002 R14: 1ffff92001435ee1 R15: ffff88806440c868
FS:  00007fbecfbfe6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020027040 CR3: 000000007c40e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_discard_preallocations+0x796/0xfb0 fs/ext4/mballoc.c:5581
 ext4_truncate+0xd27/0x1310 fs/ext4/inode.c:4166
 ext4_truncate_failed_write fs/ext4/truncate.h:22 [inline]
 ext4_write_end+0xa8a/0xed0 fs/ext4/inode.c:1323
 ext4_da_write_end+0x926/0x1170 fs/ext4/inode.c:3019
 generic_perform_write+0x32f/0x600 mm/filemap.c:3929
 ext4_buffered_write_iter+0x11f/0x3c0 fs/ext4/file.c:299
 ext4_file_write_iter+0x819/0x1950 fs/ext4/file.c:696
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x64f/0xdf0 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fbed087cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbecfbfe0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbed099bf80 RCX: 00007fbed087cae9
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007fbed08c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbed099bf80 R15: 00007ffd459e66e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_release_inode_pa.isra.0+0xa30/0xb80 fs/ext4/mballoc.c:5300
Code: b5 fb ff ff e8 a1 1a 50 ff 90 0f 0b e8 99 1a 50 ff 31 ff 44 89 ee e8 ff 15 50 ff 45 85 ed 0f 84 81 f8 ff ff e8 81 1a 50 ff 90 <0f> 0b e8 69 e7 a5 ff e9 e5 f6 ff ff 48 89 d7 e8 5c e7 a5 ff e9 4a
RSP: 0018:ffffc9000a1af690 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffe428 RCX: ffffffff823665c1
RDX: ffff88802b52a1c0 RSI: ffffffff823665cf RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000005 R12: ffff88806442ac08
R13: 0000000000000002 R14: 1ffff92001435ee1 R15: ffff88806440c868
FS:  00007fbecfbfe6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020027040 CR3: 000000007c40e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

