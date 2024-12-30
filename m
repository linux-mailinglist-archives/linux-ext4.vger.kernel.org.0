Return-Path: <linux-ext4+bounces-5863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740CC9FEA87
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 21:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C38B161999
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9ED19992E;
	Mon, 30 Dec 2024 20:06:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77688173
	for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735589190; cv=none; b=tGEAungExM8jFqDn/RMnk3kGqR/ESLAdzy4QuuvuhFCaDB/WWKO3KstPZQIYEk1vkO59S/nK5b2GtPOwL5mNnIJr+3i4oMsh7tH8PjSTI1mLw5mRAAhiGqzItUFB/gSDav86pRWqaLGPS6yug+cLb4YT5SyEd90w39kCdtTVuGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735589190; c=relaxed/simple;
	bh=TD2ediClizWO2GB18PXxfJRWGI6x2gpEz/uA9mXibKA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SUi4k24SA/gWF8x1DTENpM5SgCRxd0XJ9efFwcc1o0djgMij95ApIYIEmB8pJD+Of0GHhQZRUr/Xc0Jc976MCqaXN5DyIn7g0Px2Ocr3SWiBPFrwdirQtvHRJumPwWzkNtkrjI5gEXPacfg5IRcusInHJg6xL9DPnibPn3wVC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so168232255ab.3
        for <linux-ext4@vger.kernel.org>; Mon, 30 Dec 2024 12:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735589187; x=1736193987;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJRoQa5IiWNROrCo0hfrCJRkNsB3LCvoc2t8kX+k6OM=;
        b=OMi4i9ifJxN0DkHWZjIpT5pyKPUxt++soWkE0lBzv/YmFNcMZxnzo5m4Po8oV9VPuv
         P+0AMDyzyfWQpmaeapNnelSXKqf5nJNifCZxqep3EqxYdROCB3C8QKLsiZ/GLfVNy6wK
         0qUyDaqNrc4NcE4P7aD52tkezP2KYboa1ZIEtUyvx3cJtO2h8UqoUAqRkMejggtBlEce
         WbFwo69QpZZ3kme7zVaORANZWyqFD5gZaMOT14zeAtaTMr7gs5Vhf/SQs962JU+Uq3MS
         kVqdjPfTozBX2DBh0qLCil+zIX4zsNQkpHqz9lzQMMf8ceD0/jsKwK0Jl1RWx6ff+cmx
         IDcA==
X-Forwarded-Encrypted: i=1; AJvYcCUme5O/8khmVnS3CyN3g49+nTwbKL4peeBnDdCwDts8dKN7oByJh8UCzwxdF+3Fcwm4wHNj7g8liz27@vger.kernel.org
X-Gm-Message-State: AOJu0YxefWRDZ5aEIDyAtm/XH5lM+OPkIVRtzFNYVV4a/uM9TkYirI8R
	Dfjg8ooZk1Fd2i2mAXX3duVOGN1qGiAgbLMxpr2Cd6I1B5ceSeFJ634VH1ppy8VMfAqCQa7xwR+
	rdupEgIG2sfAlbelAVJVt7g3vxvyhtkZdPfs7jAZoJ+pVBXxfHlatQFU=
X-Google-Smtp-Source: AGHT+IFhQm/zGWGkRVinVM6wSIbEAnsGVXVmnLFLcDtAsiYHm8+QQIss4oy041lOK4Mdw0/RimC558eIlj6YMco/+WfGwsYrGXqH
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3c2d65e508dmr297248995ab.24.1735589187626; Mon, 30 Dec 2024
 12:06:27 -0800 (PST)
Date: Mon, 30 Dec 2024 12:06:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6772fd43.050a0220.2f3838.04cd.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent (4)
From: syzbot <syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    573067a5a685 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=136d1018580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7202b56d469648
dashboard link: https://syzkaller.appspot.com/bug?extid=ee60e584b5c6bb229126
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1790a0b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee82c4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9d3b5c855aa0/disk-573067a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c06fc1ead83/vmlinux-573067a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3390e59b9e4b/Image-573067a5.gz.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/ef6b4e51a02a/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1e15bbc4371d/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee60e584b5c6bb229126@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch fs/ext4/extents.c:840 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0x94c/0xb0c fs/ext4/extents.c:955
Read of size 4 at addr ffff0000e2d145a0 by task kworker/u8:4/45

CPU: 1 UID: 0 PID: 45 Comm: kworker/u8:4 Not tainted 6.13.0-rc3-syzkaller-g573067a5a685 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-7:0)
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x198/0x538 mm/kasan/report.c:489
 kasan_report+0xd8/0x138 mm/kasan/report.c:602
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 ext4_ext_binsearch fs/ext4/extents.c:840 [inline]
 ext4_find_extent+0x94c/0xb0c fs/ext4/extents.c:955
 ext4_ext_map_blocks+0x2b0/0x6600 fs/ext4/extents.c:4205
 ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
 ext4_map_blocks+0x710/0x15d0 fs/ext4/inode.c:702
 mpage_map_one_extent fs/ext4/inode.c:2219 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2272 [inline]
 ext4_do_writepages+0x195c/0x318c fs/ext4/inode.c:2735
 ext4_writepages+0x198/0x308 fs/ext4/inode.c:2824
 do_writepages+0x304/0x7d0 mm/page-writeback.c:2702
 __writeback_single_inode+0x15c/0x15a4 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x650/0x1088 fs/fs-writeback.c:1976
 wb_writeback+0x3e0/0xe9c fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x38c/0x1048 fs/fs-writeback.c:2343
 process_one_work+0x7a8/0x15cc kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3391
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff9b78a pfn:0x122d14
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000ffff9b78a 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000e2d14480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000e2d14500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff0000e2d14580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff0000e2d14600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000e2d14680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

