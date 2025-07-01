Return-Path: <linux-ext4+bounces-8739-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357C8AEF684
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 13:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF12446994
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 11:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28DA272E5F;
	Tue,  1 Jul 2025 11:27:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05D272E63
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369261; cv=none; b=gMNwYQoUDQl2g+JFFmw+WAZ3JeiVp+cnsNh7ZAKkqGuHJp+CMzxoPL/Wyfp6fRGqebMbiuAxyj0SQ5xZ9c4HUsZeL0sgKA4J354XsduuZGvMEHpN4McsnBhdtr2vzeK1IRdkS7KluT4ONo/2NuRxiKsMHovZLF7lm02qBS5NN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369261; c=relaxed/simple;
	bh=m93l+bvGg2rjYHEHbGAtIPkr/UgsGqs5SDumytl6Cgg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q47+cj84R3TU84AAd/uGrTmx+mPAA4UXxgO9KTYTlauGH5Hp1rE7Vm20hEYYDHzX4hYOKn5z0FpohenoTXd9BsvRMScVrkiABFGExMECZj0Huz8a+ehq2vy3bkTIrmjVkLZr6NN0aPFH8LAtnPNBEXjwNIljo/mjA+7g0vBo/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-875b6256041so534923039f.2
        for <linux-ext4@vger.kernel.org>; Tue, 01 Jul 2025 04:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751369257; x=1751974057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRzUcW8Yf8RHOZCGB5isk+xgXvs/iIQAaiR9udnAGRU=;
        b=s4z5dEdOPfkfCDIxCeDg4ZiYhMqrtgNbZtxk7RiJC/1vWc3xG0mIQ5HirapfKzdDXj
         Ebe6MfbvC2a5A783NcqJ5oz3cCZixWbt8aKu0sXeGmiRc24WNIztHHE3LfqQglNrR/E5
         GZ/Y1gxB/NUVkARDiPphp2rSP6WT5ZGr1MK/NyTzr6vycBXJh5fNxmxasQw8duuKg5Uu
         BsUhtdh6dlEE3T7m58QlOw4E24F7jXNA3HgAFgdo45fpgvOyqSVaA258VfLd9L6PnXyD
         GgmoTltG3+7V7sf3xmjGlJoWC1hnGN4gJ62DDxnEdEoVv1QrH6f1jHq5WbyMluU76pnO
         ZLAg==
X-Forwarded-Encrypted: i=1; AJvYcCVezNmeu4fLMXnKleEJNosJ30oM5S6SKsHObZlOmg57MzGo/Fb9904GFdcq+XyDGeCGETAY+vLKpHuK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4KCKzWvBkXVaRyTpYvMUf4ABjtK6DeetU2Ltzo0XDzFPQMzCW
	qyxWw4cedlHG6onVwzR7tbt7uopriRt3Fgwz0I7sTiaaVtoH4V3PauyzsQrcjgXgUXRL90ZkynH
	Z/M7iSOQA2SXvLLu6soAonQDIjt2IrI3c+GUZA47EqMGwyP/4ws8/Ec3hq2k=
X-Google-Smtp-Source: AGHT+IGGOrJcSPcBB2cddttZPIfQ3Ob85tvIKFOgx2kQQD7EqHNfPcAEK8I2TjPYwFeW1vwITjoSC1LSR/L/pXeN1UgGs9T8nt+H
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1491:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-876882b2239mr2135960839f.6.1751369257606; Tue, 01 Jul 2025
 04:27:37 -0700 (PDT)
Date: Tue, 01 Jul 2025 04:27:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6863c629.a70a0220.3b7e22.19d9.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_inline_data_truncate (4)
From: syzbot <syzbot+32ed484f0f32dcc41c43@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2aeda9592360 Add linux-next specific files for 20250627
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157b608c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f5c1d958b70bf47
dashboard link: https://syzkaller.appspot.com/bug?extid=32ed484f0f32dcc41c43
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d532560074a3/disk-2aeda959.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483001f76864/vmlinux-2aeda959.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f233cdc1c77/bzImage-2aeda959.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+32ed484f0f32dcc41c43@syzkaller.appspotmail.com

EXT4-fs: Ignoring removed orlov option
EXT4-fs: Ignoring removed nomblk_io_submit option
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc3-next-20250627-syzkaller #0 Not tainted
------------------------------------------------------
syz.0.4438/18397 is trying to acquire lock:
ffff8880565ef388 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
ffff8880565ef388 (&ei->xattr_sem){++++}-{4:4}, at: ext4_inline_data_truncate+0x1a9/0xad0 fs/ext4/inline.c:1872

but task is already holding lock:
ffff888067462618 (sb_internal){++++}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
ffff888067462618 (sb_internal){++++}-{0:0}, at: __sb_start_write include/linux/fs.h:1798 [inline]
ffff888067462618 (sb_internal){++++}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1981 [inline]
ffff888067462618 (sb_internal){++++}-{0:0}, at: ext4_evict_inode+0x2d6/0xee0 fs/ext4/inode.c:215

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (sb_internal){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       percpu_down_write+0x54/0x330 kernel/locking/percpu-rwsem.c:232
       sb_wait_write fs/super.c:1900 [inline]
       freeze_super+0x8b7/0x1130 fs/super.c:2183
       fs_bdev_freeze+0x1a3/0x310 fs/super.c:1529
       bdev_freeze+0xd8/0x220 block/bdev.c:298
       ext4_force_shutdown+0x322/0x560 fs/ext4/ioctl.c:822
       ext4_ioctl_shutdown fs/ext4/ioctl.c:857 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1587 [inline]
       ext4_ioctl+0x1d39/0x3510 fs/ext4/ioctl.c:1626
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (sb_pagefaults){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1798 [inline]
       sb_start_pagefault include/linux/fs.h:1963 [inline]
       ext4_page_mkwrite+0x1e3/0x1110 fs/ext4/inode.c:6575
       do_page_mkwrite+0x14a/0x310 mm/memory.c:3374
       do_shared_fault mm/memory.c:5662 [inline]
       do_fault mm/memory.c:5724 [inline]
       do_pte_missing mm/memory.c:4247 [inline]
       handle_pte_fault mm/memory.c:6065 [inline]
       __handle_mm_fault+0x1916/0x5440 mm/memory.c:6208
       handle_mm_fault+0x40a/0x8e0 mm/memory.c:6377
       do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __might_fault+0xcc/0x130 mm/memory.c:6967
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       fiemap_fill_next_extent+0x1c0/0x390 fs/ioctl.c:145
       ocfs2_fiemap+0x888/0xc90 fs/ocfs2/extent_map.c:806
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x16d0/0x1990 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x82/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ocfs2_quota_ip_alloc_sem_key){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       ocfs2_create_local_dquot+0x19d/0x1a40 fs/ocfs2/quota_local.c:1227
       ocfs2_acquire_dquot+0x80f/0xb30 fs/ocfs2/quota_global.c:883
       dqget+0x7ae/0xf10 fs/quota/dquot.c:977
       ocfs2_setattr+0xd72/0x1b40 fs/ocfs2/file.c:1233
       notify_change+0xb36/0xe40 fs/attr.c:552
       chown_common+0x40c/0x5c0 fs/open.c:790
       do_fchownat+0x161/0x270 fs/open.c:821
       __do_sys_lchown fs/open.c:846 [inline]
       __se_sys_lchown fs/open.c:844 [inline]
       __x64_sys_lchown+0x85/0xa0 fs/open.c:844
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dquot->dq_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
       wait_on_dquot fs/quota/dquot.c:354 [inline]
       dqget+0x72a/0xf10 fs/quota/dquot.c:972
       dquot_transfer+0x2f8/0x6d0 fs/quota/dquot.c:2140
       ext4_setattr+0x865/0x1bc0 fs/ext4/inode.c:5816
       notify_change+0xb36/0xe40 fs/attr.c:552
       chown_common+0x40c/0x5c0 fs/open.c:790
       do_fchownat+0x161/0x270 fs/open.c:821
       __do_sys_chown fs/open.c:841 [inline]
       __se_sys_chown fs/open.c:839 [inline]
       __x64_sys_chown+0x82/0xa0 fs/open.c:839
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_inline_data_truncate+0x1a9/0xad0 fs/ext4/inline.c:1872
       ext4_truncate+0x3b5/0x1100 fs/ext4/inode.c:4527
       ext4_evict_inode+0x8cf/0xee0 fs/ext4/inode.c:261
       evict+0x501/0x9c0 fs/inode.c:810
       __dentry_kill+0x209/0x660 fs/dcache.c:669
       dput+0x19f/0x2b0 fs/dcache.c:911
       do_renameat2+0x6de/0xa80 fs/namei.c:5280
       __do_sys_rename fs/namei.c:5325 [inline]
       __se_sys_rename fs/namei.c:5323 [inline]
       __x64_sys_rename+0x82/0x90 fs/namei.c:5323
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> sb_pagefaults --> sb_internal

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_internal);
                               lock(sb_pagefaults);
                               lock(sb_internal);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

5 locks held by syz.0.4438/18397:
 #0: ffff888067462428 (sb_writers#4){++++}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:557
 #1: ffff888067462738 (&type->s_vfs_rename_key#2){+.+.}-{4:4}, at: lock_rename fs/namei.c:3276 [inline]
 #1: ffff888067462738 (&type->s_vfs_rename_key#2){+.+.}-{4:4}, at: do_renameat2+0x364/0xa80 fs/namei.c:5224
 #2: ffff88803ed85060 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:914 [inline]
 #2: ffff88803ed85060 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: lock_two_directories+0x1a2/0x220 fs/namei.c:3252
 #3: ffff88803ed83d40 (&type->i_mutex_dir_key#3/5){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:914 [inline]
 #3: ffff88803ed83d40 (&type->i_mutex_dir_key#3/5){+.+.}-{4:4}, at: lock_two_directories+0x1cc/0x220 fs/namei.c:3253
 #4: ffff888067462618 (sb_internal){++++}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #4: ffff888067462618 (sb_internal){++++}-{0:0}, at: __sb_start_write include/linux/fs.h:1798 [inline]
 #4: ffff888067462618 (sb_internal){++++}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1981 [inline]
 #4: ffff888067462618 (sb_internal){++++}-{0:0}, at: ext4_evict_inode+0x2d6/0xee0 fs/ext4/inode.c:215

stack backtrace:
CPU: 0 UID: 0 PID: 18397 Comm: syz.0.4438 Not tainted 6.16.0-rc3-next-20250627-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1577
 ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
 ext4_inline_data_truncate+0x1a9/0xad0 fs/ext4/inline.c:1872
 ext4_truncate+0x3b5/0x1100 fs/ext4/inode.c:4527
 ext4_evict_inode+0x8cf/0xee0 fs/ext4/inode.c:261
 evict+0x501/0x9c0 fs/inode.c:810
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 do_renameat2+0x6de/0xa80 fs/namei.c:5280
 __do_sys_rename fs/namei.c:5325 [inline]
 __se_sys_rename fs/namei.c:5323 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5323
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f452478e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f452556f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f45249b5fa0 RCX: 00007f452478e929
RDX: 0000000000000000 RSI: 00002000000000c0 RDI: 0000200000000080
RBP: 00007f4524810b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f45249b5fa0 R15: 00007ffed20051f8
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

