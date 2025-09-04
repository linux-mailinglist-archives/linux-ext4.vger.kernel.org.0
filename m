Return-Path: <linux-ext4+bounces-9815-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC8B43769
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 11:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1393B602C
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF462F747F;
	Thu,  4 Sep 2025 09:44:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC52C159A
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979075; cv=none; b=VIk96dkI8R5VALtkrIFpU7nNMvBIdrnFz/J1dw7ashS4KyeK0og9e7PpfZnFrbL8dYi6AOpoaOKaI64gG96QLun+/2hiDIB2VsC5IroqfgNDVMt27qjThSl0iqmpfnaUMmcqYPMxbF20FSwvY4hCGBeIe4HuiFvhPUCofBjuj44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979075; c=relaxed/simple;
	bh=I0cHwtwiC4CVO3CbjQzwhcxi/NP8fwyFAaAKjPKgWAk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PuaQe2tYJR9X4ESsbdkWdONCnAr4j85zOjd+a3F3K66nOFQgfB7Jz7oGFPZZ7dfnHlKvSRtAZQq/H1ewb3Qn459yXTWmiGM6GKV7fT44ABSR3slj1NvMQ/mbCcA8b3ck/PDGd+X9YVMkceo8989r9nGNbxiAWmBBmEYID6YZ+ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-887427eeefbso86968939f.3
        for <linux-ext4@vger.kernel.org>; Thu, 04 Sep 2025 02:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979073; x=1757583873;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZCqnhVKlIT0yix9BnegbQAPDYx9vgbyjeNE9iouGjg=;
        b=RFqpwUjy5Al21hyDcKGiP73lMqeJ0OlwOPYkHO+jvujl0IIZOGIhND6PcyD93WVck1
         SBjXaOLb6lDyv+/lbm8xY3sKtVsFJOlqPenFrlGww3WTVKI+ZzimVvKlvekvIZr5aDBS
         55iW3kSlriHm7GwJM1U8+VCEBE5J7PHgjfzJqv8YtDLiN9zdcidhOtPnx1qYTYFdT+Ta
         VCGPCj7DMS2Rh53GQb8BTF6pxj7ziURhRrmFZ5jX4sDIhuQbOSWYZ4YgUl0sNnTGyCuA
         wLE5qTFtxdBC8dmxrKw/6Zu596AOp8WjY/NlDal60sCbX59Hc/L40WwbH7KVmVE9mCZ3
         EzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWopJUksDw/HEMX1b+0c6g8IxNll5PL8P86FCn17tjCKzzcdY4usX78h2g2BRk7XaapcMOThNfsdUCo@vger.kernel.org
X-Gm-Message-State: AOJu0YymKRJNP3Ngl7lpN5T29YYhqjOTGHESFSKmpeSU7WgDmQsmGCWj
	CfkowCa4mNXZEwJubhATJF+T/44yDzHjCNVdIkiuB918SBeZ0l13u594S6KU3sLgQHO8+nWiz13
	8PGB8e4rE7Y5JbH55c3RhNadDk84fpqrGEZPuJ/s7ZPICI5aBftHxmtWzbRU=
X-Google-Smtp-Source: AGHT+IE2D9Z5LS8p2NXwDjiPEUV3z/oUuCEDJPoSDv9Dob4WLLhjpsvB2XMHuuHLftVlAxGtK0D0mTPtAg0nVPni2PprzFOqgxnw
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd0:b0:881:8a58:3bc2 with SMTP id
 ca18e2360f4ac-8871f421d98mr3303805839f.6.1756979073032; Thu, 04 Sep 2025
 02:44:33 -0700 (PDT)
Date: Thu, 04 Sep 2025 02:44:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b95f81.a00a0220.eb3d.0001.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (3)
From: syzbot <syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec299e4dc21e Merge tag 'bitmap-for-6.17-rc5' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1092a312580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=385d836f07b5a70d
dashboard link: https://syzkaller.appspot.com/bug?extid=038b7bf43423e132b308
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d1fe34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f8de62580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ec299e4d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d15022189f21/vmlinux-ec299e4d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d73fbb71b816/bzImage-ec299e4d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e1c7d8ef0b25/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=17a49e62580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com

EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:1012!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5527 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_es_cache_extent+0x698/0x700 fs/ext4/extents_status.c:1012
Code: ff df 80 3c 08 00 74 08 48 89 df e8 62 b0 b3 ff 48 8b 3b 48 8b 74 24 28 48 8d 54 24 60 e8 00 c3 0d 00 eb 14 e8 69 c0 4e ff 90 <0f> 0b e8 61 c0 4e ff eb 28 e8 5a c0 4e ff 31 f6 65 ff 0d 81 32 30
RSP: 0018:ffffc900028ff420 EFLAGS: 00010293
RAX: ffffffff8270fd97 RBX: 00000000ffffffff RCX: ffff8880330fc880
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000000072ce
RBP: ffffc900028ff528 R08: ffffffff8fa3b637 R09: 1ffffffff1f476c6
R10: dffffc0000000000 R11: fffffbfff1f476c7 R12: 00000000000072d0
R13: 0000000000000008 R14: 00000000000072ce R15: dffffc0000000000
FS:  000055556eaf2500(0000) GS:ffff88808d20d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32463fff CR3: 0000000056f56000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ext4_cache_extents fs/ext4/extents.c:544 [inline]
 ext4_find_extent+0x482/0xcc0 fs/ext4/extents.c:928
 ext4_get_verity_descriptor_location fs/ext4/verity.c:292 [inline]
 ext4_get_verity_descriptor+0x102/0x590 fs/ext4/verity.c:346
 fsverity_get_descriptor+0x8d/0x4b0 fs/verity/open.c:323
 ensure_verity_info fs/verity/open.c:363 [inline]
 __fsverity_file_open+0xd7/0x1f0 fs/verity/open.c:384
 fsverity_file_open include/linux/fsverity.h:300 [inline]
 ext4_file_open+0x32d/0xa40 fs/ext4/file.c:909
 do_dentry_open+0x953/0x13f0 fs/open.c:965
 vfs_open+0x3b/0x340 fs/open.c:1095
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5a5878ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa6498b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f5a589c5fa0 RCX: 00007f5a5878ebe9
RDX: 0000000000000000 RSI: 0000200000000100 RDI: ffffffffffffff9c
RBP: 00007f5a58811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5a589c5fa0 R14: 00007f5a589c5fa0 R15: 0000000000000004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_cache_extent+0x698/0x700 fs/ext4/extents_status.c:1012
Code: ff df 80 3c 08 00 74 08 48 89 df e8 62 b0 b3 ff 48 8b 3b 48 8b 74 24 28 48 8d 54 24 60 e8 00 c3 0d 00 eb 14 e8 69 c0 4e ff 90 <0f> 0b e8 61 c0 4e ff eb 28 e8 5a c0 4e ff 31 f6 65 ff 0d 81 32 30
RSP: 0018:ffffc900028ff420 EFLAGS: 00010293
RAX: ffffffff8270fd97 RBX: 00000000ffffffff RCX: ffff8880330fc880
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000000072ce
RBP: ffffc900028ff528 R08: ffffffff8fa3b637 R09: 1ffffffff1f476c6
R10: dffffc0000000000 R11: fffffbfff1f476c7 R12: 00000000000072d0
R13: 0000000000000008 R14: 00000000000072ce R15: dffffc0000000000
FS:  000055556eaf2500(0000) GS:ffff88808d20d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32463fff CR3: 0000000056f56000 CR4: 0000000000352ef0


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

