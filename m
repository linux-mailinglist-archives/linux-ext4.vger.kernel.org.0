Return-Path: <linux-ext4+bounces-8195-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76EAC362D
	for <lists+linux-ext4@lfdr.de>; Sun, 25 May 2025 20:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96652163392
	for <lists+linux-ext4@lfdr.de>; Sun, 25 May 2025 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E0421129D;
	Sun, 25 May 2025 18:12:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4745D1F5619
	for <linux-ext4@vger.kernel.org>; Sun, 25 May 2025 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748196753; cv=none; b=aBN5Dr3zNlB70fUgetNrpwnwLVKH7X1cSdyBel/1mF5My2vwJf0PGEtlDujAy3P+NsEJig5loD4xphuqQtaYdrS5tz0YO2qqIFKCUWpIoxspOCkDcN83uGBM92jDT7BqN5FxwQaLGeUq2LQmjTZIuYD/Mpxu/XXMBezyuPXfBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748196753; c=relaxed/simple;
	bh=7+EGeOVt+awA8Qcmt7sVYuFn7og25339P/5pfCYMyxU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aRB6qYHY+5JOdzbKkJkntrP0PSxhGGrztwpunTwTpnAde8I6JzY8U88ay35LX6/B2lqoAZjqLBillCh1o9noV0cLUNh3R9h4TXR9HmzK6VruzMwX3Fmlmykm9dthjylHXuIXnz7HdnZO6vS4ym2n11MY0306xgohU1Rk51hiiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86184fa3d00so127052339f.3
        for <linux-ext4@vger.kernel.org>; Sun, 25 May 2025 11:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748196750; x=1748801550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRBYuR7BxLAms86jXHfoRGLoHlwaE9ASiyST8p3It54=;
        b=dqGNCnBKCmhvGc55ClqMCzmLMUOwZauD8hU0xxJfQAaiPXwoNoByh71V4VqoW0Ln5e
         GuH6h4hD3pMRTNs7hXu3yLB8bcLJxCF7b4JOyYrm/1svL/WmADxjWi4bNLk+mxGSh97v
         vSQ7MrntebjiYPmqiUBBib7UXRpDcHUePooc2v3AXMiXkGb7+oe1fXWGsbb/XmUgRs/W
         wck94vbCxqh83JZrj8e5xHOFX8ESG7ppSM3h0feLo5ZrW5YvrtZ9o0R/B/K9FyuxHrT5
         hCEwANI5EYsIZ66DEO+BKDt7/QCR+gsa6pKypWHB0R/RPT3X9tVNrBnwT+xJr8MN21CO
         PQNw==
X-Forwarded-Encrypted: i=1; AJvYcCVa6MoYbt9OuG9N4LTRXKvxKFgekSDEXTvsif/KuIF2yPWnI4j7alS9nHOe5qhtEyDeqFRxeMmDu5YK@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6r3YzGmNzW6qx4t+0dz0bmzAeVrZfpd2E9JZqBjc8jfQRz/g
	bFaHu7GujM/n9QZr5869lGHyzwSoLtFfoGFSY9/UhreWwDxjrSmcGAjOfuKzqDrh4b68RkYUT/o
	BR5Bef/atJhOFXLFl9XBVh5DuPJVE2yu0U116oJdGLYgctPkPw6n8yIlvXPo=
X-Google-Smtp-Source: AGHT+IGnfpjg3acimNhLF8pGU9P7AUa06LdV5HiTgawkRXdgM1Hbd+V260vuzRS6p9LJFhh01p4F1b7GG9nX2ukgJRFYtwhM+2Ph
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4011:b0:85b:3763:9551 with SMTP id
 ca18e2360f4ac-86cbb7f7928mr587337039f.7.1748196750433; Sun, 25 May 2025
 11:12:30 -0700 (PDT)
Date: Sun, 25 May 2025 11:12:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68335d8e.a70a0220.253bc2.008b.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_ext_insert_extent
From: syzbot <syzbot+9db318d6167044609878@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0c22de9995b Merge tag 'input-for-v6.15-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e00df4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1de0d8596cea805
dashboard link: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16931170580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14683ad4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf852e5656de/disk-d0c22de9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/761933abe01b/vmlinux-d0c22de9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/187857154891/bzImage-d0c22de9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/992dec4e0af9/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=151468e8580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ext4_ext_insert_extent+0x41b6/0x4af0 fs/ext4/extents.c:2084
Read of size 4 at addr ffff88802db31c18 by task syz-executor706/7034

CPU: 1 UID: 0 PID: 7034 Comm: syz-executor706 Not tainted 6.15.0-rc7-syzkaller-00152-gd0c22de9995b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 ext4_ext_insert_extent+0x41b6/0x4af0 fs/ext4/extents.c:2084
 ext4_ext_map_blocks+0x179c/0x67c0 fs/ext4/extents.c:4400
 ext4_map_create_blocks fs/ext4/inode.c:520 [inline]
 ext4_map_blocks+0x807/0x1740 fs/ext4/inode.c:706
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:785
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:818
 ext4_block_write_begin+0x543/0x1290 fs/ext4/inode.c:1067
 ext4_write_begin+0x6f6/0x12c0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x33a/0xa60 fs/ext4/inode.c:2932
 generic_perform_write+0x2c4/0x910 mm/filemap.c:4103
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x54b/0xa90 fs/read_write.c:684
 ksys_pwrite64 fs/read_write.c:791 [inline]
 __do_sys_pwrite64 fs/read_write.c:799 [inline]
 __se_sys_pwrite64 fs/read_write.c:796 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:796
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0078162e09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0078117218 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f00781ea6c8 RCX: 00007f0078162e09
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f00781ea6c0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 00007f00781b7630
R13: 0000200000000000 R14: 00002000000000c0 R15: 00007f00781b706b
 </TASK>

Allocated by task 5844:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4203
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2852 [inline]
 __do_sys_symlink fs/namei.c:4770 [inline]
 __se_sys_symlink fs/namei.c:4768 [inline]
 __x64_sys_symlink+0x6a/0x90 fs/namei.c:4768
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5844:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kmem_cache_free+0x192/0x3f0 mm/slub.c:4744
 do_symlinkat+0x39f/0x3f0 fs/namei.c:4757
 __do_sys_symlink fs/namei.c:4770 [inline]
 __se_sys_symlink fs/namei.c:4768 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4768
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802db31100
 which belongs to the cache names_cache of size 4096
The buggy address is located 2840 bytes inside of
 freed 4096-byte region [ffff88802db31100, ffff88802db32100)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2db30
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b2b8780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b2b8780 0000000000000000 dead000000000001
head: 0000000000000000 0000000000070007 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000b6cc01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5844, tgid 5844 (udevd), ts 111781614645, free_ts 111672478666
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1714
 prep_new_page mm/page_alloc.c:1722 [inline]
 get_page_from_freelist+0x21c7/0x22a0 mm/page_alloc.c:3684
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4966
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2618
 new_slab mm/slub.c:2672 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3858
 __slab_alloc mm/slub.c:3948 [inline]
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4203
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2852 [inline]
 __do_sys_symlink fs/namei.c:4770 [inline]
 __se_sys_symlink fs/namei.c:4768 [inline]
 __x64_sys_symlink+0x5d/0x90 fs/namei.c:4768
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5189 tgid 5189 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1258 [inline]
 __free_frozen_pages+0xb05/0xcd0 mm/page_alloc.c:2721
 discard_slab mm/slub.c:2716 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3185
 put_cpu_partial+0x17c/0x250 mm/slub.c:3260
 __slab_free+0x2f7/0x400 mm/slub.c:4512
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_noprof+0x224/0x4f0 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 tomoyo_realpath_from_path+0xe3/0x5d0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 security_inode_getattr+0x12f/0x330 security/security.c:2377
 vfs_getattr fs/stat.c:256 [inline]
 vfs_fstat fs/stat.c:278 [inline]
 __do_sys_newfstat fs/stat.c:546 [inline]
 __se_sys_newfstat fs/stat.c:543 [inline]
 __x64_sys_newfstat+0xfe/0x200 fs/stat.c:543
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802db31b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802db31b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802db31c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802db31c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802db31d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

