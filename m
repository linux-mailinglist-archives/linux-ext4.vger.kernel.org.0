Return-Path: <linux-ext4+bounces-10483-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1CBA8FDF
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FA57B21C9
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99AE2FFF9C;
	Mon, 29 Sep 2025 11:19:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDE2D4B5A
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144776; cv=none; b=LYeT5dShuwCyWsLIMp7G5G86Ssh2x6kOMETgIlr75ZIRJqLPNk3tCAq0b6sztrtW5ftZ7b9ZTLsgCffA9+VSMzXOxHA+tbfDnlsknj6gDi82XH4ujbZITo5An6cLLn6x5vQNx2/z4jSVsnnhhhYGKPWFo/VAUjvXmV2juHkuUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144776; c=relaxed/simple;
	bh=qsC8nmTNDWgfrSJczB2vM+JxEg6Io3xeF78OMelW4vE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WaMKUGOLScHK7IwmgpQtaKi3969dclR8SIcEpiyNx/EQZz38zvGe9mG+c4p54xUMCiiA2bbBxxm26oiQ7iWmPU18mT1ZTZLK6+PIzbCLIKCxF2hk5KF3rPzTgtF+AI8Cx6+esUB8TqeZgK3cHbP92Gi4bdhaYM3knRVKvDzM84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9201572ebfbso267839639f.3
        for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 04:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144774; x=1759749574;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08hGSZlHtga8CIS0a/iAlGFEPP1F0snL36igz9koUJw=;
        b=mU0S9wZKE/OOuM/1eB1SwqV4Hwn8pmPsBoNWdV9+Sb5hxz2mzbP1qpmSxpxmLfCSeA
         mTXpEzvImVIbLAzjIhPR9ZuQYnM7vrZP2boq3ZScwb5mETP/Vxbf8fguPPlju8ukWSfB
         jKXGUi2slGi9jB4HKHZuFAtn+DwwPP+HRBzLWPllPrRXXnKUDA4n6XKPQUQbzyLvGuQs
         Ig3fiKxA/wdVvIHC3N0QDbaS0nuWdXdsQEGWd3Llf4pF1jVN0B/8522FgwJM/9G40kX4
         ER3IN4b5RCBnBaEMTYsRu5xvS9rc5jvUfbiR6bgEpNcpknm210jY/GtpUqjYWqjB6x75
         VZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVQ0UFIsDwwVAl8Ct0bdoS8V5BbsPH0eXjIWDBD7saXZaKouBEfoaYwlb74NP8oqsiMspqW0JLz7LP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HWf1TU7H9lCQWfk6Up9ZPEs+iIdx+VENSDP7XbJE8XBmTnrt
	3i+GvLZ6Q1TPRr1hlsHthMu7Mr8RkPf0oSw1Jo+Umo/vfbc17SF37dZ22laWJZel2ysvyqx/l50
	FCgJ7sLCGehV/MViPpu1D5aKmnUeqWOf4DuwiTehW/mfAb4XdbOyW1F1Gh5g=
X-Google-Smtp-Source: AGHT+IHRTPuY7t1PvT96TXZpWYYUVd6O0WSzFdMb58XBM4n5LsHfW+1jd3nfEcaaxzeSSdIfSqKL5qhBY2NUx6QpyAarZHplYD0g
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:427:638b:f7b3 with SMTP id
 e9e14a558f8ab-42c735c6263mr18402065ab.22.1759144773950; Mon, 29 Sep 2025
 04:19:33 -0700 (PDT)
Date: Mon, 29 Sep 2025 04:19:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68da6b45.050a0220.1696c6.0015.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_xattr_inode_dec_ref_all
From: syzbot <syzbot+55cb5d2db550fbc52264@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5a4da2c459f Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12abed34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc64d939cce41d2
dashboard link: https://syzkaller.appspot.com/bug?extid=55cb5d2db550fbc52264
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/127c931e6696/disk-b5a4da2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf4957abd39e/vmlinux-b5a4da2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/860d3ac61bac/bzImage-b5a4da2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55cb5d2db550fbc52264@syzkaller.appspotmail.com

loop7: detected capacity change from 0 to 512
EXT4-fs warning (device loop7): ext4_xattr_inode_get:542: inode #11: comm syz.7.2381: ea_inode file size=0 entry size=6
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: fs/ext4/xattr.c:1053 at ext4_xattr_inode_update_ref+0x534/0x5d0 fs/ext4/xattr.c:1051, CPU#0: syz.7.2381/16796
Modules linked in:
CPU: 0 UID: 0 PID: 16796 Comm: syz.7.2381 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RAX: 13d1ab016548b300 RBX: dffffc0000000000 RCX: 0000000000080000
RDX: ffffc9000cc0d000 RSI: 0000000000008560 RDI: 0000000000008561
RBP: ffffc9000ba57390 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a65c R12: ffff8880546a1f90
R13: 1ffff1100a8d43f2 R14: 00000000ffffffff R15: 000000000000000b
FS:  00007f560bbf66c0(0000) GS:ffff888125a03000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fab211156c0 CR3: 000000005ffc2000 CR4: 00000000003526f0
DR0: 0000000000000008 DR1: 0000000000000002 DR2: 0000000000000081
DR3: ffffffffefffff14 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1076 [inline]
 ext4_xattr_inode_dec_ref_all+0x867/0xda0 fs/ext4/xattr.c:1218
 ext4_xattr_delete_inode+0xa4c/0xc10 fs/ext4/xattr.c:2942
 ext4_evict_inode+0xac9/0xee0 fs/ext4/inode.c:271
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5615 [inline]
 ext4_fill_super+0x57df/0x6090 fs/ext4/super.c:5734
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
 vfs_get_tree+0x92/0x2b0 fs/super.c:1751
 fc_mount fs/namespace.c:1208 [inline]
 do_new_mount_fc fs/namespace.c:3651 [inline]
 do_new_mount+0x302/0x9e0 fs/namespace.c:3725
 do_mount fs/namespace.c:4048 [inline]
 __do_sys_mount fs/namespace.c:4236 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4213
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f560d99066a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f560bbf5e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f560bbf5ef0 RCX: 00007f560d99066a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f560bbf5eb0
RBP: 0000200000000180 R08: 00007f560bbf5ef0 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007f560bbf5eb0 R14: 0000000000000473 R15: 0000200000000680
 </TASK>


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

