Return-Path: <linux-ext4+bounces-9907-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF4B524E5
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 02:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FA9441C55
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 00:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321429A1;
	Thu, 11 Sep 2025 00:08:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D7635
	for <linux-ext4@vger.kernel.org>; Thu, 11 Sep 2025 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757549315; cv=none; b=PGtOi8kSDpPHBWuIaUB1ej5D4x3F7j1AZTHZHA+Ave5i8Uu58n9d7QzAT65m8RJZrmj6WgPDk+ljn4ghxjuueet9I0fs38wIG8GaWyStol4pdVqTePsEaCNut47xpkrTkv5U1/dvt9JrdirxUDn+xeXGQukD+s0ZY1iuEOxrFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757549315; c=relaxed/simple;
	bh=XI9C9h9K47/5TfFx5Vwvtyh+qxve7EjqUwejeCFjFoE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RgNbV82XQHdT6QrxUbaBUaxHAGt2jRHoUchIb0JivCiCOS5fuOWh7eCOqvVps84znb5GQqSU+55zaL2zs55dtLhI7ZsnJOHy+HoE1GgwjkOLn+7PdDQTD7LbXADLekWz9QfLr0ztbWPcfXO15KdubQslRYaTM9lAWofNuGCqXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-88dc85f09ddso18301339f.0
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 17:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757549313; x=1758154113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1I0EN3prULMItg0ARiBZXqqxTQs8EcDxdTq3aZDfvOE=;
        b=TaNvHuFfdjAzjW0zc7rn/xcGmAgYOC6kKZlk+qRxlHkzUGqG2MYs2RVx0uVyYY4v+X
         B5kY/zBY09FAUVB9qowbbSpYH8Uu6FR6hoT+OBAfgAFGhmDbxVIOZ4GqjTwY3zFXbPOp
         FFWS8Yzk5kzcCoKWV54YwSOHzfkH+9mc/yi5qp/b6+y336u+rUChYjO1ZrAjrMvyoleR
         jeeq29DgdJ5yBuig+oS4k0NTbLQXeq1ukAV607soRKj8x3a89eny9cxh1anS7cNNhnN+
         JS59z/XJU46EAaOcDZPsaTfqAGDTGPwHxvtF2zFvCo/hgMc2bXN8bnbz/Rd/5TcCFv1g
         3pGg==
X-Forwarded-Encrypted: i=1; AJvYcCVhoCngpCA0OFWVz2BgdYMhnYLx9gxYuBePWsnYWrruufi/oFVnehr7KpuRPcN/B89A+mvkB/TAd1YP@vger.kernel.org
X-Gm-Message-State: AOJu0YwRx9TuCTlkLyCyaaxQmvP6J9/r+nMFjSkTUFw2TNWN/Pw6jCAR
	wIkmDp3hHCK2+FMzPNECllhEGraOyUMKmzYc2cj2+k6lcloYGZbhF9TWinZ/0WjZFEC0Fd1G+hg
	U+L6f3LD5ef9q86/EQLP1HF8h1q5LdDFmt4iVcm5qUvdmVvIEeRTSxEOe5kA=
X-Google-Smtp-Source: AGHT+IEWi41sWfY1REAYdhBHr8dv/WnJUOhbTMPR1lz9qvElIeqf/nBWCAxeFbAvrE81G8GaaN37OAc3jcsUAMFjDzZY9Mf6Wvh5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:40f:3015:239f with SMTP id
 e9e14a558f8ab-40f301523a9mr132098245ab.6.1757549313109; Wed, 10 Sep 2025
 17:08:33 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:08:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c21301.050a0220.3c6139.0031.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e0f87c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=0be4f339a8218d2a5bb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1617c934580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eba642580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63dc392685dc/disk-9dd1835e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3dfcfb97806e/vmlinux-9dd1835e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddb10128aeb8/bzImage-9dd1835e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/39ec3165daa7/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16fecb12580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com

EXT4-fs warning (device loop0): ext4_xattr_inode_get:556: inode #11: comm syz.0.17: EA inode hash validation failed
EXT4-fs warning (device loop0): ext4_expand_extra_isize_ea:2848: Unable to expand inode 15. Delete some EAs or run e2fsck.
------------[ cut here ]------------
EA inode 11 ref_count=-1
WARNING: CPU: 1 PID: 6111 at fs/ext4/xattr.c:1048 ext4_xattr_inode_update_ref+0x44b/0x5d0 fs/ext4/xattr.c:1047
Modules linked in:
CPU: 1 UID: 0 PID: 6111 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x44b/0x5d0 fs/ext4/xattr.c:1047
Code: 78 40 4c 89 f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 e8 05 a2 ff 49 8b 37 48 c7 c7 20 6d 1f 8b 4c 89 ea e8 06 9b 07 ff 90 <0f> 0b 90 90 48 bb 00 00 00 00 00 fc ff df 4c 8b 74 24 20 4c 8b 6c
RSP: 0018:ffffc90003fef2e0 EFLAGS: 00010246
RAX: c3a43c61d4524a00 RBX: dffffc0000000000 RCX: ffff888056a79dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003fef3d0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: ffffc90003fef340
R13: ffffffffffffffff R14: 00000000ffffffff R15: ffff888042eaee10
FS:  0000555558b13500(0000) GS:ffff8881269bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f92c9cf3000 CR3: 0000000056d94000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1076 [inline]
 ext4_xattr_inode_dec_ref_all+0x867/0xda0 fs/ext4/xattr.c:1218
 ext4_xattr_delete_inode+0xa4c/0xc10 fs/ext4/xattr.c:2942
 ext4_evict_inode+0xac9/0xee0 fs/ext4/inode.c:271
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5609 [inline]
 ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f07d069034a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeedf2c668 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffeedf2c6f0 RCX: 00007f07d069034a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffeedf2c6b0
RBP: 0000200000000180 R08: 00007ffeedf2c6f0 R09: 000000000080078b
R10: 000000000080078b R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffeedf2c6b0 R14: 0000000000000473 R15: 0000200000000680
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

