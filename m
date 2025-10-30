Return-Path: <linux-ext4+bounces-11376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3AC22917
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 23:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B3E3B4D78
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C0433BBA4;
	Thu, 30 Oct 2025 22:34:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02943331A6D
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863673; cv=none; b=Xcy6vJdFkEWMNhOKU1mXYfvdqGg4sam02OtCDXbCYtMBg9MQWPqmxaRsAvAqSJ34HSk0hksopPKWi5KxX6Nc5Id7h3om+fyKeuxxLUWDs9nxLAk3QCF537hlo/N5E9C/LOAKi0Obs4pQixydOfwq+HBT2V9I1I0fVxmlw1dRa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863673; c=relaxed/simple;
	bh=PDG+4R0bR+zUy5rnRXrobvWRNhVRznZikV2XejgbQgQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TIR6fpw7cum9scGvwrY6IxthwhZE4MyoBb7zgVkB4ZD1epYBuMzthe8Hv6fW3VXVx8OnWR47i8SY1cVwlHVYN0PavPRYiKWwGT2b9yaEVBXIS1pTwxHeNBHvE5CERSFkP1sVlKNTHdh5ZV6IZm4K1VfVrHbpg3jrYkJXTayorLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430e67e2427so21616665ab.2
        for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 15:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761863671; x=1762468471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIZ0Uu9MMshqp8xzh1+njbzcONq0p2voF8lI6LDP9wQ=;
        b=FNJHbryITJTo2lPU0VF396jFwnn0t5oY5Dte2ZqYBqHzoHuPvDMizSpoW8pht0ez17
         i8zoC9ofEml5acaidfzzgNWT3fY8odi5cV4ljeIVHdGFapKVJVUM6KkhaWKEqxZcsdaA
         sCTxOiJTXrQnJ9nDUpIA5L0njB8lSNnWMSUi3NUeSFTHf5IpJK6UAppxwOmCw+uPTBQ4
         iwsKKhenm9nwavdfYuRZ6ZubGwYhTnTUS5+0PZatYknaCh9HinQ61BKLX+hj/6LmQaHJ
         H7CCX9botCsv4zwbucQQ5UBEFSFrS0356dn4QwMtapyWMttABoR1VLvICeOPzsYi+1Cw
         pXCw==
X-Forwarded-Encrypted: i=1; AJvYcCWZVf9DbArfDUDSumZqq+Yachn3nNBNVujRXHXlgQGSNfLo8whmFfVBrmYABmT1nJunn2n4ArUmCU7i@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+fZkHtXnFLsfOhxI7pmCuCoTV8vVS+Vp7k0Fs9QWz38GejXI
	cAdYDDQMYhXto1QbYcWxCXtbts1kNycze+iq9e7zLub/Tdt4DWy7BJ5EhUx2NSwcxA+KR9HF+yp
	3Uuc51jbgvC9xfWevXmGIBAZErjBpjls5unIKdNx9M7K8TrY3b372c22CWv4=
X-Google-Smtp-Source: AGHT+IH8rbugZWseHZZude7SAZ+heAK7OUOj2rQDiXnDpnCyUA5qZGMVwJZAbrfFjmu+Ri0uTlGgSp3G2WYaQNW18sOVlKyezB3A
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1447:b0:430:b59b:5f2b with SMTP id
 e9e14a558f8ab-4330d1bec10mr20376375ab.16.1761863671070; Thu, 30 Oct 2025
 15:34:31 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:34:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6903e7f7.050a0220.3344a1.044c.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref (2)
From: syzbot <syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e53642b87a4f Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150aa32f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=76916a45d2294b551fd9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101f5f34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121dbe7c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e53642b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb13d82854da/vmlinux-e53642b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f3a72d29f243/bzImage-e53642b8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fb4c6b817064/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16191fe2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com

EXT4-fs warning (device loop0): ext4_xattr_inode_get:546: inode #11: comm syz.0.17: ea_inode file size=0 entry size=6
EXT4-fs warning (device loop0): ext4_expand_extra_isize_ea:2853: Unable to expand inode 15. Delete some EAs or run e2fsck.
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: CPU: 0 PID: 5496 at fs/ext4/xattr.c:1058 ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1056
Modules linked in:
CPU: 0 UID: 0 PID: 5496 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_xattr_inode_update_ref+0x51a/0x5b0 fs/ext4/xattr.c:1056
Code: 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 06 84 c0 0f 85 80 00 00 00 41 8b 17 48 c7 c7 80 1f 80 8b 4c 89 e6 e8 a7 1b f8 fe 90 <0f> 0b 90 90 4c 8b 6c 24 28 e9 59 fe ff ff e8 f3 0b bd 08 44 89 f9
RSP: 0018:ffffc90002847240 EFLAGS: 00010246
RAX: 96417f00249f1400 RBX: 0000000000000001 RCX: ffff88801f648000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90002847330 R08: ffff88801fe24293 R09: 1ffff11003fc4852
R10: dffffc0000000000 R11: ffffed1003fc4853 R12: 000000000000000b
R13: ffff8880121df630 R14: 1ffff1100243beb4 R15: ffff8880121df5a0
FS:  000055557b2d3500(0000) GS:ffff88808d733000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0e033d000 CR3: 000000004bac3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1081 [inline]
 ext4_xattr_inode_dec_ref_all+0x867/0xda0 fs/ext4/xattr.c:1223
 ext4_xattr_delete_inode+0xa4c/0xc10 fs/ext4/xattr.c:2947
 ext4_evict_inode+0xac9/0xee0 fs/ext4/inode.c:271
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:470
 __ext4_fill_super fs/ext4/super.c:5617 [inline]
 ext4_fill_super+0x5920/0x61e0 fs/ext4/super.c:5736
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0xa10 fs/namespace.c:3727
 do_mount fs/namespace.c:4050 [inline]
 __do_sys_mount fs/namespace.c:4238 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4215
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e5239076a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd45601928 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd456019b0 RCX: 00007f9e5239076a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffd45601970
RBP: 0000200000000180 R08: 00007ffd456019b0 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffd45601970 R14: 000000000000046c R15: 0000200000000680
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

