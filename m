Return-Path: <linux-ext4+bounces-2903-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFA90FC5E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 07:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A782E286668
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 05:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652FB383AE;
	Thu, 20 Jun 2024 05:55:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E162BAE1
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862921; cv=none; b=jsqmRpKKUk/LzrO4fLczLbY0RuayrG4qmvEpT645jOADuLg/tOy8VWo6JOoDjsA+I0QvqwplzB7+DjFt9Eub37MX47W/nkwls/nOYkJqVjv6Z56WhUm+SU8BWZfLgtuvsz5+7jRSquU8t8Lhi/gBx9CoM2RjgjBrE9M7yrXJz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862921; c=relaxed/simple;
	bh=KfNrI5U+yrc0W3TsmyCK88V2lAHD+5v/yZ1AIcRK0yc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GMdoNTE8lln4ddohIsSktBOYP4b91Q+XcBtGgu2tIP8KZvawaekkA8+MiTQiP8GPEcBsHdytMe3hXVxhDEXHNBbl4CmSFDKgTJYJEZXl+Qa/clDZCmmnwoRoMh8GOAKpGKaHEnlEAhjDv2NA8MHS9szwbkfD7BMvFs4FRKyUkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-37613924eefso6192925ab.1
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jun 2024 22:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718862919; x=1719467719;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eU/np16w0mVCT5fs5PoiYge8NpBeqUK6ellGX4rGzm4=;
        b=lw197rKYDa6svN3n1YDmuiZi7+pcoV1VBy7LZnMWYBbAY9VAuyinCTB4MruReJC71g
         TVZpMre7hKZQTn/rD0+CAHh4l8VwBlwmfNez+gsjV9SBsbkC7gZBSXMa+fCQfMV2EH/C
         fvuZGyoGh9SK/CiyOXCWYNET+ye9ocNpLJkg0APcwOyBndJKDhsIlsEAY2WGR1PHRYXD
         UnKBGBb8XEZC2OePccN0kgADbSTzQwuyJ5zmlbAbWpclYl2pdq9QjDXzSVN8Tc08biYl
         XoVky4BC7NFpGny59vJhUiLYUfHR+X/r7H+hhXR0kEkvq/3xCWIxOhkzArUQkfq4HbPS
         Q8ng==
X-Forwarded-Encrypted: i=1; AJvYcCVpKdP5+QrERj8u0IWlPuoaYZStYUGNGdFtJNoaRYgr2vsj4Yt4LbQKvW2O+XzbVSerPycPcxnvzIiKDrE9atdp5VeSzfkSgixwWw==
X-Gm-Message-State: AOJu0YxSxKoeKGg1hvGY0ziVNJDhzUaxveKskCTxC8xDkUujLaMsYTG6
	Giw9EWRAr1aXvtLdeHKGo65OUtzpVs2WNAqGWGojs6hOjk4+15u7tR8vsK/+qmPjegQkEjcG3h4
	lyi1U4gkQhWoQrKCixUAJeZDkKDQXr21n0oUavbjzT6/h5C9LCkrfWCU=
X-Google-Smtp-Source: AGHT+IEA0a0xV4ojjojs/Fji9abWvDKRZMTLt1zqMdok9LS1krTQZfyDXnlcTrIcJ1eOW4kaUS6L9GNJzar9H2mmF/jZdtQBVPZD
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:374:64df:681c with SMTP id
 e9e14a558f8ab-3761d751e2emr3473025ab.4.1718862918827; Wed, 19 Jun 2024
 22:55:18 -0700 (PDT)
Date: Wed, 19 Jun 2024 22:55:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1d03f061b4bf50b@google.com>
Subject: [syzbot] [ext4?] WARNING: ODEBUG bug in ext4_fill_super (4)
From: syzbot <syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fce146980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=59e0101c430934bc9a36
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1509be0e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff9156980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c40c1cd990d2/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2a94050804e/bzImage-2ccbdf43.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c0790076681f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59e0101c430934bc9a36@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object: ffff8880223846d8 object type: timer_list hint: print_daily_error_info+0x0/0x530 fs/ext4/super.c:799
WARNING: CPU: 0 PID: 5632 at lib/debugobjects.c:514 debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 5632 Comm: syz-executor976 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:debug_print_object+0x1a3/0x2b0 lib/debugobjects.c:514
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 54 48 8b 14 dd 80 18 90 8b 41 56 4c 89 e6 48 c7 c7 e0 0b 90 8b e8 1e 1f c6 fc 90 <0f> 0b 90 90 58 83 05 b5 c2 5a 0b 01 48 83 c4 18 5b 5d 41 5c 41 5d
RSP: 0018:ffffc90003d978c8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff81500069
RDX: ffff88802d7d2440 RSI: ffffffff81500076 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8b901280
R13: ffffffff8b2f2a60 R14: ffffffff82561a20 R15: ffffc90003d979d8
FS:  00007f8799e8a6c0(0000) GS:ffff88806b000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8791a3f000 CR3: 000000001a79c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x4b8/0x600 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2163 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x284/0x3b0 mm/slub.c:4558
 ext4_free_sbi fs/ext4/super.c:4298 [inline]
 ext4_fill_super+0x2f29/0xace0 fs/ext4/super.c:5701
 get_tree_bdev+0x36f/0x610 fs/super.c:1615
 vfs_get_tree+0x8f/0x380 fs/super.c:1780
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8799ed50ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8799e8a088 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8799e8a0a0 RCX: 00007f8799ed50ea
RDX: 00000000200000c0 RSI: 0000000020000500 RDI: 00007f8799e8a0a0
RBP: 0000000000000005 R08: 00007f8799e8a0e0 R09: 00000000000004bc
R10: 0000000000000084 R11: 0000000000000206 R12: 00007f8799e8a0e0
R13: 0000000000000084 R14: 0000000000000003 R15: 0000000000040000
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

