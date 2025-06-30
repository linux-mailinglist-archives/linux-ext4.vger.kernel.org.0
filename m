Return-Path: <linux-ext4+bounces-8720-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F2AEE5C6
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197D418973EA
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2BD2E1C54;
	Mon, 30 Jun 2025 17:28:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55228DEE5
	for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304519; cv=none; b=gl7gTY4ksMhTNqoiUJR16M/YL4fYLfgRGVGpjoaVidT3Z9WaHUbwG3gFGAJNpS8TUnxeD5Abt1sCbGQMRbEfcmb+9Jdb5xu3v3JM3pN+dM9CnKUff+KuqkaGxuYBtW0KnOHmIZrOSvF7whmjZrau4Q0IcLCBwPc/VDh7T+pLd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304519; c=relaxed/simple;
	bh=DvEt/ME2bVvlYYwFj2goBLZH0mw+U7nOOeWKccUHuXM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=No65NPgn4PCeOhaXSEftWJpVQmW5IWHFHy/FsiZpnGd/LrDtqa+8Oaw4Tb3sH5o6zG8c6Hftv7+blnjf4hqHvS187HijwmXq7zyptZxhqhzyoS1PilV4aw3K7WwzoAa2WkeX8RHvxZDYVLI3C5WfWnf7+8rakNRMiUkLNOXmeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddd5311fd3so22064945ab.3
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jun 2025 10:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751304515; x=1751909315;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqqXdLIuiWEuc9N8wVH05YmN19CxMNf+yhLVdonB7/4=;
        b=bvQ3oKvTsx+JVuFeuKK6tfcNIGbAhKMxlpAEnWyOvGh6/gHphPysGzIlfTZtsMv5/3
         WFnw2x77tq93xHXWfkoniTrWaOkfnHq6uI0bsjEi7RV4s5V3JfSr8UYfjUg267ADQEeE
         rM7C46Uw9kxmt4wC4xpvhSTJUEOorC6pNkgCKu18jSEd64wGCxT4wJPh8Skf+S6HcNQI
         EMHDcL3kZ9Ex0TaVV6XWBgkTrrogc9BsusCUKwRcG6Ipww8+Jn6EUTe+xEZC+rEqIWRn
         FG1e717YubRGq9V+9MwJTgVpm8AJIltqj+xQhzCFBcNFLvpGnU0MsEr6RYqpQuNDHOwA
         Nlkg==
X-Forwarded-Encrypted: i=1; AJvYcCWPRmatIdxCLMKqDylbJxTxPz9Z1gnVmfPAozhg2iJauqGlkvE2cZwvE4dMm2ZYjk6ZDBLGtx4uMNUR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iR6QU7FaL2RnoA818h9vSbQHQa/7HMpIXoGF3e6iUwC+zdEP
	N5sykDiCecgA/R6G7q+w22S1xrWTi+fPXIWeLHYtBLLnz8eO+j15VB+YJ1ETVaiF6yrLz8h19gL
	9tyA+eO3j0smqi2oA/5ugguvIc0Fj+ttQ0nR++D/tU1kS3Y4EBCA5ydjoApc=
X-Google-Smtp-Source: AGHT+IHEV4mwSFr4PsYOQjv4WFkE4agsYeeL7gfhiYNxhOaMur41YcDDozbQ19opL8QdfX5XKahIH1Ds2nxLvd0sZmckn0cWLfe1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca48:0:b0:3df:306f:3b25 with SMTP id
 e9e14a558f8ab-3df4abac665mr128663025ab.16.1751304514903; Mon, 30 Jun 2025
 10:28:34 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:28:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6862c942.a70a0220.2f4de1.002c.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-use-after-free Read in __ext4_check_dir_entry
From: syzbot <syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    afa9a6f4f574 Merge tag 'staging-6.16-rc4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1220a770580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28cc6f051378bb16
dashboard link: https://syzkaller.appspot.com/bug?extid=5322c5c260eb44d209ed
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c188c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/234fe6db1565/disk-afa9a6f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49ab9f2eb5dc/vmlinux-afa9a6f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e64db09b112/bzImage-afa9a6f4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7bfd5fd5e1c5/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=12c36982580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com

EXT4-fs warning (device loop1): dx_probe:801: inode #2: comm syz.1.21: Unrecognised inode hash code 4
EXT4-fs warning (device loop1): dx_probe:934: inode #2: comm syz.1.21: Corrupt directory, running e2fsck is recommended
==================================================================
BUG: KASAN: slab-use-after-free in __ext4_check_dir_entry+0x708/0x8a0 fs/ext4/dir.c:85
Read of size 2 at addr ffff8880601f4003 by task syz.1.21/6095

CPU: 0 UID: 0 PID: 6095 Comm: syz.1.21 Not tainted 6.16.0-rc3-syzkaller-00346-gafa9a6f4f574 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 __ext4_check_dir_entry+0x708/0x8a0 fs/ext4/dir.c:85
 ext4_readdir+0x1299/0x3b60 fs/ext4/dir.c:262
 iterate_dir+0x5af/0x770 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2ff398e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2ff48d9038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f2ff3bb5fa0 RCX: 00007f2ff398e929
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007f2ff3a10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2ff3bb5fa0 R15: 00007ffd14fba298
 </TASK>

Allocated by task 6097:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x28b/0x550 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x58d/0x5d0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1c1/0x3b0 security/tomoyo/file.c:771
 security_file_open+0xb1/0x270 security/security.c:3114
 do_dentry_open+0x35e/0x1970 fs/open.c:941
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6097:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 tomoyo_check_open_permission+0x2c2/0x3b0 security/tomoyo/file.c:786
 security_file_open+0xb1/0x270 security/security.c:3114
 do_dentry_open+0x35e/0x1970 fs/open.c:941
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880601f4000
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 3 bytes inside of
 freed 32-byte region [ffff8880601f4000, ffff8880601f4020)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x601f4
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a441780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6097, tgid 6097 (modprobe), ts 96501120570, free_ts 85677675649
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21d5/0x22b0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x28b/0x550 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x58d/0x5d0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x1c1/0x3b0 security/tomoyo/file.c:771
 security_file_open+0xb1/0x270 security/security.c:3114
 do_dentry_open+0x35e/0x1970 fs/open.c:941
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3896 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4055
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
page last free pid 5877 tgid 5877 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc65/0xe60 mm/page_alloc.c:2706
 vfree+0x25a/0x400 mm/vmalloc.c:3426
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6b5/0x22e0 kernel/exit.c:964
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1105
 get_signal+0x125e/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x75/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880601f3f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880601f3f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880601f4000: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff8880601f4080: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff8880601f4100: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
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

