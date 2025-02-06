Return-Path: <linux-ext4+bounces-6357-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7D2A2AE51
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B773A8647
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F92235363;
	Thu,  6 Feb 2025 17:01:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A01EDA08
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861286; cv=none; b=J8yJewHq619I1DuI1JmaydbDL8iUtNBFhi/8dOpBRRHn5HCbmn/MI1MmjQo7EdK27GUrUC7dFVmn+EA+5EfphZNFwM83PcTL707MJZO6VFM3KnYnh9AvHX/0+lWrgmm/YWGgqFfgF9lQyqGSRTr6JwpfyO5iGx7ZJEmdXPvrFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861286; c=relaxed/simple;
	bh=35j2mmdHtGPbna3dtlLGYBKk2u5qAlYpeQWSe1OFTu0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UwiTb4hWTdCP+c/YysvH4BHLe2751/pDUUzyMO3wJ1DsZk51UBOBzOFBK8YovfpR/C2WKQqfACvb5P1tf2RV2sb9UX33j9Ior1bdz7qEMHpATxaDESVeJApa+D29W0wAFV5EShx01OwOFSOT6JVQSHQmxdNYNIFd5u5t+ycF3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so23662595ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 06 Feb 2025 09:01:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861283; x=1739466083;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/hiCHJfcbDvdkipLSz1YoaD9QT2j2FRUXk5AghNWl8=;
        b=FYvwYC4N54C/7EYWFirhRXDGdiarZLsl36GUBkM1Xzca+MPG1jDIsG9/RPr9EcPaw/
         U/PV4khsGWd5C/GGyD/NnAgYMeqcV0BhY7iclFDRT2HqDB2jzDTY0xCxuzsybHM6aMf2
         PZIjFmcbmoOJdKF82t/Se+/djGYum6FQfXrOYfzU96AaPg8W2DF7cm1AokW81TKYuv/6
         XGkcmd5ISioUvksuccbfO6b1RErNmNj89hR3URdYVxNOxojZt5iuVb+fWphb0O3hWQx7
         rQh6Xo5pnP9e1W2Oz7Q2OkBSSquXfK8GOe/e2DFMhf9lZ3+NugwoZXfg8Dadk6PtTHMd
         jwjw==
X-Forwarded-Encrypted: i=1; AJvYcCU1e5RSoQ3gMmZss7EpDHyC19DXwI7L8Vn6QGYZlSdf7W2oEnqUuO+v6mVYj5o6BFLpI3a1ODS70oEa@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDTzME55GtNzkRXpZaXvm/fkkf6OzSt6g6eHcFjEFq/SnJXXa
	qbw5wtyf65NPHHVcaf98YjhGKZch19cZwK3vAuftVeOLGg/ycyrbfX9+RK/j1CB8gZlo7JHpwnP
	B7eG6w30I426RDEQJwBBqowIuRajQEV1b2xAbWR2MvAmcFAHDMGs5MNY=
X-Google-Smtp-Source: AGHT+IG3o8QswCxe6AjDj2dgxpf9xt+OpwHOkk/vmJ24sE8CTnOzkjTjjDFBMYmQnVBbA5G3PjiPX9/bfSj7CxtB6mpEfV37d+2e
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:3d0:4b0d:b22e with SMTP id
 e9e14a558f8ab-3d04f43459cmr68262885ab.10.1738861283396; Thu, 06 Feb 2025
 09:01:23 -0800 (PST)
Date: Thu, 06 Feb 2025 09:01:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a4eae3.050a0220.65602.0000.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in inode_set_cached_link
From: syzbot <syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    808eb958781e Add linux-next specific files for 20250206
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14a46df8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D88b25e5d30d576e=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2cca5ef7e5ed862c0=
799
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D161241b058000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16ee80e4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/493ef93f2e5f/disk-=
808eb958.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b41757cd41c9/vmlinux-=
808eb958.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24f456104aad/bzI=
mage-808eb958.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fb0901f433df=
/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com

EXT4-fs warning (device loop0): ext4_enable_quotas:7145: Failed to enable q=
uota tracking (type=3D1, err=3D-22, ino=3D4). Please run e2fsck to fix.
EXT4-fs (loop0): Cannot turn on quotas: error -22
------------[ cut here ]------------
bad length passed for symlink [
=EF=BF=BD=01] (got 9000, expected 3)
WARNING: CPU: 1 PID: 5832 at ./include/linux/fs.h:803 inode_set_cached_link=
+0xd0/0x110 include/linux/fs.h:802
Modules linked in:
CPU: 1 UID: 0 PID: 5832 Comm: syz-executor433 Not tainted 6.14.0-rc1-next-2=
0250206-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 12/27/2024
RIP: 0010:inode_set_cached_link+0xd0/0x110 include/linux/fs.h:802
Code: 41 5f 5d c3 cc cc cc cc e8 ed 1b 44 ff c6 05 b5 51 8a 0d 01 90 48 c7 =
c7 20 dc 1d 8c 4c 89 f6 44 89 fa 89 e9 e8 d1 c7 04 ff 90 <0f> 0b 90 90 e9 6=
a ff ff ff 89 f9 80 e1 07 80 c1 03 38 c1 7c a1 e8
RSP: 0018:ffffc90003967658 EFLAGS: 00010246
RAX: b92553c73f221b00 RBX: ffff88807b3a02b0 RCX: ffff88802ef89e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81803292 R09: fffffbfff1cfa5b8
R10: dffffc0000000000 R11: fffffbfff1cfa5b8 R12: ffff88807b3a02b0
R13: dffffc0000000000 R14: ffff88807b3a0000 R15: 0000000000002328
FS:  00005555558f7380(0000) GS:ffff8880b8700000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff832fc000 CR3: 0000000028d14000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_iget+0x2ea4/0x3f30 fs/ext4/inode.c:5000
 ext4_orphan_get+0x1bb/0x5f0 fs/ext4/ialloc.c:1389
 ext4_orphan_cleanup+0xa19/0x13d0 fs/ext4/orphan.c:467
 __ext4_fill_super fs/ext4/super.c:5602 [inline]
 ext4_fill_super+0x5dd5/0x6760 fs/ext4/super.c:5722
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3659
 do_mount fs/namespace.c:3999 [inline]
 __do_sys_mount fs/namespace.c:4210 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4187
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc90683b93a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff832fba58 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff832fba70 RCX: 00007fc90683b93a
RDX: 0000200000000080 RSI: 0000200000000000 RDI: 00007fff832fba70
RBP: 0000200000000000 R08: 00007fff832fbab0 R09: 00000000000004f5
R10: 000000000200801f R11: 0000000000000202 R12: 0000200000000080
R13: 0000000000000004 R14: 0000000000000003 R15: 00007fff832fbab0
 </TASK>


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

