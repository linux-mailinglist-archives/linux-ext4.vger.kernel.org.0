Return-Path: <linux-ext4+bounces-7020-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1119A764D6
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Mar 2025 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015CE1888B5E
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Mar 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC841DF747;
	Mon, 31 Mar 2025 11:15:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD71E231F
	for <linux-ext4@vger.kernel.org>; Mon, 31 Mar 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743419724; cv=none; b=ny96qXkwtD+fvCePH2ppI4JRXzdVT3fbkhwXa8wBcX5uhsfVxD5PVHQi1gINlRhp8B2F7ssVpU0/vcgpfjwkqMMnknEwuTcNtGo032+U2o9a/9T75xSA4p+NFcL5W6kV87OulfXyxfH2irNNFfuvVfpi2SMmtp5FZsi77KaGFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743419724; c=relaxed/simple;
	bh=mZWlbNnWSXCza4ARHEaNz4tyDU3YEsnEcVojbHiTYHo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HtN03Kq4rnUNS/r4xErZkYw91+0S+Hl/mSSukWz4c9bmVUh36rzHBVNKCx85FJfE1t+WtAjkrSfdZ6km7no+S6Ct+8IQHkfMGhd4MNc8/q4j4qfEq2fEzMBZ4zZDm2J8UxfS3F/vP+9rlEMwvbRTLzGtpI8LOW1r1wuiHqnMUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d5b3819ff6so42186525ab.2
        for <linux-ext4@vger.kernel.org>; Mon, 31 Mar 2025 04:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743419721; x=1744024521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYJ2ayjHqCxYX5lTQl1r1YoFG3Bo+m2S/zYyovakDc4=;
        b=MldDHSC9lHMAl0ga1zyVFzfPrO0yU8UM7hiRLJWRusDs2tcPETRyw/kF+FZeYkaNRE
         NQb1ESMprbNZS9B0SycJAj1o8mx2bd/87ppYPDCAgmLxRni4/LcKpUtBczUjpdGNvWPJ
         Z5RsovGaIr1niWWHlCkv5cRCWfbBJGuNOlmsdPME+KB1orMcsA8C7J7WqdC/LG2mIJbw
         q/WrPlpXop0h91x5A56PHflsJWR4L/BUYvikh2H0IrW++/DEwbqjlqgxS9JqxQ6K1euN
         GY4oiZyI9U5X2H5ahK+KjJ+do1N0/6R+a9jbtM5NBlRgyD0e5O5AXKUSrlAUjJIb+JY8
         ipAw==
X-Forwarded-Encrypted: i=1; AJvYcCUlvv8rIdz2OGwLEhlZZXshpgRofqLvMrvHN98jxRhiwos3gcc0HNzUtgfSkEJtsRoDpwGk+FOSEhPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzaAQpA06t0W60xz2/rmfStCroghy5FmcPcw34neEIlDARaGBpO
	gY9sxxn5dicnLUCS6eMZHEpDqdVD3nJYHdXQTq8Qm2JdzAyrK2XVJ48AE2fFeMCvCe4lgASS5z8
	J+eMx7gNOu3cc8Tnh/k1Wz398F65HteeRW/e3oJf4Wikm383BQSiDOSQ=
X-Google-Smtp-Source: AGHT+IF4JVf1xAqVts+d4FiZy72adDDnUCZqxzUQ6FifEtl22wwJY6HB61PhdQ5EX5ZOg0/Tb/ym22blM7CEexluSXdhUom7skAq
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d81:b0:3ce:4b12:fa17 with SMTP id
 e9e14a558f8ab-3d5e0a0cfe7mr87228225ab.19.1743419721601; Mon, 31 Mar 2025
 04:15:21 -0700 (PDT)
Date: Mon, 31 Mar 2025 04:15:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ea7949.050a0220.1547ec.0137.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-use-after-free Read in ext4_ext_remove_space
From: syzbot <syzbot+b73703b873a33d8eb8f6@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a1c24ab82279 Merge branch 'for-next/el2-enable-feat-pmuv3p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17f953b8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6b108de97771157
dashboard link: https://syzkaller.appspot.com/bug?extid=b73703b873a33d8eb8f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9581dbc26f55/disk-a1c24ab8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50aec9ab8b8b/vmlinux-a1c24ab8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a018984f8f5/Image-a1c24ab8.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b73703b873a33d8eb8f6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ext4_ext_rm_leaf fs/ext4/extents.c:2623 [inline]
BUG: KASAN: slab-use-after-free in ext4_ext_remove_space+0x2ce0/0x4058 fs/ext4/extents.c:2961
Read of size 4 at addr ffff0000dae2c4c8 by task syz.3.297/8071

CPU: 0 UID: 0 PID: 8071 Comm: syz.3.297 Not tainted 6.14.0-rc3-syzkaller-ga1c24ab82279 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:489
 kasan_report+0xd8/0x138 mm/kasan/report.c:602
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 ext4_ext_rm_leaf fs/ext4/extents.c:2623 [inline]
 ext4_ext_remove_space+0x2ce0/0x4058 fs/ext4/extents.c:2961
 ext4_ext_truncate+0x134/0x1d4 fs/ext4/extents.c:4466
 ext4_truncate+0x9dc/0x10ac fs/ext4/inode.c:4217
 ext4_setattr+0xdc8/0x173c fs/ext4/inode.c:5542
 notify_change+0x9f0/0xca0 fs/attr.c:552
 do_truncate+0x1c0/0x28c fs/open.c:65
 handle_truncate fs/namei.c:3451 [inline]
 do_open fs/namei.c:3834 [inline]
 path_openat+0x249c/0x2b1c fs/namei.c:3989
 do_filp_open+0x1e8/0x404 fs/namei.c:4016
 do_sys_openat2+0x124/0x1b8 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1454
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Allocated by task 6060:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:562
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x74/0x8c mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x254/0x410 mm/slub.c:4171
 getname_flags+0xcc/0x4b4 fs/namei.c:139
 do_readlinkat+0xbc/0x4d4 fs/stat.c:563
 __do_sys_readlinkat fs/stat.c:595 [inline]
 __se_sys_readlinkat fs/stat.c:592 [inline]
 __arm64_sys_readlinkat+0x9c/0xb8 fs/stat.c:592
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

Freed by task 6060:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x64/0x8c mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x198/0x554 mm/slub.c:4711
 putname+0x130/0x184 fs/namei.c:296
 do_readlinkat+0x25c/0x4d4 fs/stat.c:584
 __do_sys_readlinkat fs/stat.c:595 [inline]
 __se_sys_readlinkat fs/stat.c:592 [inline]
 __arm64_sys_readlinkat+0x9c/0xb8 fs/stat.c:592
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

The buggy address belongs to the object at ffff0000dae2c400
 which belongs to the cache names_cache of size 4096
The buggy address is located 200 bytes inside of
 freed 4096-byte region [ffff0000dae2c400, ffff0000dae2d400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11ae28
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c18a88c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c18a88c0 dead000000000122 0000000000000000
head: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
head: 05ffc00000000003 fffffdffc36b8a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000dae2c380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000dae2c400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000dae2c480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff0000dae2c500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000dae2c580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

