Return-Path: <linux-ext4+bounces-6213-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2321A19205
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 14:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F75163A54
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 13:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D478211A0D;
	Wed, 22 Jan 2025 13:06:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB71DF26F
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551185; cv=none; b=J35yMp1NucKr5ZT6H7KwW+qEfu3viifXdVaGMUWOqegkILzHpx0+liYOefB+E+gjx5CvxatxdOarc0ZyN1c2aEbgfWaVKfN49fkJ1KKxoO83czNznPYApYfEkVw6wGBmZ/0Evlfjl2/Oq4mM2cvmhGNQLf0d9Db7aoLK9naUcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551185; c=relaxed/simple;
	bh=yyjzZuzymCStMfVdWP4IuLqviNp9I4koz2OvlHVvBqg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G89muRVraTZk+JHC47RMgTlhMLA7ZdKmivrHS0h0RbmbjSea51lXshB2/jLnQ02M3Cpcd1XVPE4nuGpEiVMmCw+nADZEqa353kbZl81G6RTmpoaL8XoVaGzeBzgXa4/L6IJM3FpsKBT4P/tNjRPKWzod6PxLuddj+3R+UKum5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so120273825ab.0
        for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 05:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737551182; x=1738155982;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2T4TPHHciuTmKE4LeVibB+rD3ws+gjYDG0vdY1N2bE=;
        b=LPu8J5JB/5f438ACspSos7+l6xUF1NDURyQl89PH+pBY3YZHEMoFZsJ8XqVd8CdKE2
         VqkTlZQSy05baJ3f3q/BrHPq5pbhyi46G78ty9KqB9qpALu9Zc8dIEQsoCbzsH9Vrqam
         AHmrlLl0pNopCeRGtumFKF1KgpUIOpkd+qRZu20JjhGZpec13Nqyul4nrGRXCupyj2sH
         hxGGmLpEIeUTdHxtpYym11j7XQjZiTyOGUhjEKf9wA/BtC1XbsCMZv6whkLlS39N4wBs
         wUA22qyQRnLTMxiPiZK6SmRd8N5nhBHlIC8WdXZ4p/c/lZl4n0GsdYUygrAfl4hBkIFx
         EZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0hR3p64JnXZdbeBYDL9XqZVDbIKWifqaAIqi+5Ji+HsWW2dDQFBr1YRMc3/1KWjEHOEvby/ziN6No@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkG/AFVpLP+6qnSQ6fDfj1mbG1caG1nLIuEY/7uUXQqDPlI4H
	3E25XYY+DdAB3e1XHXGJtuP6SpxsU3Ei6CamCFKWu6lhMY/FAhNz68Ds4m0yDZeslNBbEntxops
	YizjM/sAhuGYLlEk3y0zTH347UIY0UNemysO8yKx28wca+g+nX59r7E8=
X-Google-Smtp-Source: AGHT+IHX1EX49xytbR+eAo6bSGa0eLevN6oEEY/ybYR7Q37eygFmFe8dBUkpCfIruQNpfjzNRVRmWNf5KOw2+2TUFBsH2o8paK96
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2602:b0:3cf:b39c:58e4 with SMTP id
 e9e14a558f8ab-3cfb39c5f9amr19165815ab.11.1737551182600; Wed, 22 Jan 2025
 05:06:22 -0800 (PST)
Date: Wed, 22 Jan 2025 05:06:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6790ed4e.050a0220.194594.0010.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in filldir64
From: syzbot <syzbot+1ef611e998bba0e8bdf0@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0b7958fa05d5 Merge tag 'for-6.13/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17594218580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=1ef611e998bba0e8bdf0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0b7958fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1af4eb8ec17e/vmlinux-0b7958fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/308c172f79c6/bzImage-0b7958fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ef611e998bba0e8bdf0@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
EXT4-fs: Ignoring removed i_version option
EXT4-fs: Quota format mount options ignored when QUOTA feature is enabled
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
EXT4-fs error (device loop0): ext4_xattr_ibody_find:2240: inode #15: comm syz.0.0: corrupted in-inode xattr: ea_inode specified without ea_inode feature enabled
EXT4-fs error (device loop0): ext4_xattr_ibody_find:2240: inode #15: comm syz.0.0: corrupted in-inode xattr: ea_inode specified without ea_inode feature enabled
loop0: detected capacity change from 1024 to 960
EXT4-fs error (device loop0): ext4_xattr_ibody_find:2240: inode #12: comm syz.0.0: corrupted in-inode xattr: bad magic number in in-inode xattr
==================================================================
BUG: KASAN: slab-out-of-bounds in memchr+0x5e/0x70 lib/string.c:802
Read of size 1 at addr ffff88803df4b7bc by task syz.0.0/5313

CPU: 0 UID: 0 PID: 5313 Comm: syz.0.0 Not tainted 6.13.0-rc6-syzkaller-00046-g0b7958fa05d5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 memchr+0x5e/0x70 lib/string.c:802
 verify_dirent_name fs/readdir.c:152 [inline]
 filldir64+0x5d/0x690 fs/readdir.c:355
 dir_emit include/linux/fs.h:3745 [inline]
 ext4_read_inline_dir+0xb4e/0xe60 fs/ext4/inline.c:1569
 ext4_readdir+0x475/0x3a60 fs/ext4/dir.c:159
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6225385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6226211038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f6225575fa0 RCX: 00007f6225385d29
RDX: 0000000000001000 RSI: 0000000020000f80 RDI: 000000000000000a
RBP: 00007f6225401b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6225575fa0 R15: 00007fff83a284e8
 </TASK>

Allocated by task 5313:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x285/0x4c0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 ext4_read_inline_dir+0x31f/0xe60 fs/ext4/inline.c:1478
 ext4_readdir+0x475/0x3a60 fs/ext4/dir.c:159
 iterate_dir+0x571/0x800 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:403 [inline]
 __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803df4b780
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes to the right of
 allocated 60-byte region [ffff88803df4b780, ffff88803df4b7bc)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3df4b
ksm flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801ac418c0 ffffea0000f02840 dead000000000003
raw: 0000000000000000 0000000080200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 17263111191, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kmalloc_array_noprof include/linux/slab.h:946 [inline]
 kobj_map+0x6b/0x550 drivers/base/map.c:44
 cdev_add+0x95/0x170 fs/char_dev.c:491
 __video_register_device+0x3ac3/0x4a50 drivers/media/v4l2-core/v4l2-dev.c:1045
 video_register_device include/media/v4l2-dev.h:384 [inline]
 vivid_create_devnodes+0x1f5f/0x2c90 drivers/media/test-drivers/vivid/vivid-core.c:1677
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:2040 [inline]
 vivid_probe+0x5858/0x7cf0 drivers/media/test-drivers/vivid/vivid-core.c:2093
 platform_probe+0x13a/0x1c0 drivers/base/platform.c:1404
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88803df4b680: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff88803df4b700: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88803df4b780: 00 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc
                                        ^
 ffff88803df4b800: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ffff88803df4b880: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
==================================================================


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

