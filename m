Return-Path: <linux-ext4+bounces-9287-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F82B1EE24
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Aug 2025 20:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257AB5624B2
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Aug 2025 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F971E5B91;
	Fri,  8 Aug 2025 18:02:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4351DA3D
	for <linux-ext4@vger.kernel.org>; Fri,  8 Aug 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676156; cv=none; b=r3k425kz5Z6Y8TUdGarItJhC5Bj5J/+fkkP0kTWmBkWC68xeErT+29iRYn9ClDn8IeublYnVUAk7/zGlO9fKPdlhF/MEqvHpC1zZQlPu0QT540tIyv3HJs6QY4vVmRSPV9bFCwn8KHvvX8qeLCuviQResKpxCW5ovoSn00hLrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676156; c=relaxed/simple;
	bh=gw2jOQCWAcIcU+5gv60t1ajIUnP+RYkcz2dUTqcMhvI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lSadsTNWYBW7Vmm5LJ8iGeXUWmeVbE95gqDnbZwCVwgVh6q+42PjaIwbks8/NNqkMWMBelAtca0UTS6MdogVS8heHCf2DV/wnD9pfKIDhfjSsoLSZ/RxzGEwG+BqsflIlAvN7b5wJllE6FBqPeSmK2fXpwIk2CqADi+xfra06TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-881a214c747so265673839f.0
        for <linux-ext4@vger.kernel.org>; Fri, 08 Aug 2025 11:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754676154; x=1755280954;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/oObUrgrbo0bauhVu60Atre0exUWDb5T7WIQ+bwbfw=;
        b=wxr3dmXh32LUx63B/4Uy6l436OFiBIn98Rwm1wXxBT2J4wSPueEeLMhWVxIf/k6GMN
         aBIsMPwbl/ykTetyf+rFEZ6DUSb/sAblxdXmu+8sG24tVRLqW0i2YLmHEDVaPSbzrcGE
         kzMJEKllOyOZP8plpb3pjt9fDSqnKbffdIw2GzKKZMP9WPcwUOaosokSWeeFJYMCq935
         j2OMlsjKqD+xM2rlCSUrWaS+eIsW7tUJnBbztgIYURUJ4pht4P7TTSb1GZIqZDyB9iW7
         DtEamPl5BHFUWcxjryzKZ5mCZ1KamRcACNgGs44Nk/wXJYCbfcIatiI5tFvpDOid95uw
         DUHg==
X-Forwarded-Encrypted: i=1; AJvYcCUwLE7pw0KAEYkP0vHli8LkUaQzsdNEMFI2fVO2vHwaB/qqCCNUzJFtx5Ni6zv0DoUzUJGeLkmcqaJ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrx4PJcUB1kWkoLmctdnb/sRVglYZP66ys9nH4kgIVsH8CS6Ze
	Go3/lZBKna4cAudKZnWsYCWC3XFlusw7AF3hzSXeeNUqCiubQH5YUfKMf6kpw7qkfLXlG48+K7U
	evcJe5eXoeNwjfRrhxq3EfGVOuW39hgnPxlav1LZ5t9aDYn3VvDMvIu1pA/M=
X-Google-Smtp-Source: AGHT+IG3AwqUCDwmN+4NiYzZzZHFL8pzvK9vLtXzO+d/AlXTI2s17/NRIDSn0B6q+nkPxD0rNCpn9o5yXQJ8MjO6jBXthcBiwHDH
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3812:b0:3df:3ad6:bfb2 with SMTP id
 e9e14a558f8ab-3e5331ab4cbmr64173505ab.17.1754676153763; Fri, 08 Aug 2025
 11:02:33 -0700 (PDT)
Date: Fri, 08 Aug 2025 11:02:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68963bb9.050a0220.7f033.0085.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_readpage_inline (2)
From: syzbot <syzbot+8721ec072bbbb6adcb01@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d2eedaa3909b Merge tag 'rtc-6.17' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112cc042580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=8721ec072bbbb6adcb01
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3435b26b899d/disk-d2eedaa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/531223373575/vmlinux-d2eedaa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e82f9030b8d5/bzImage-d2eedaa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8721ec072bbbb6adcb01@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-syzkaller-11489-gd2eedaa3909b #0 Not tainted
------------------------------------------------------
syz.9.1907/11934 is trying to acquire lock:
ffff8880543c80c8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_readpage_inline+0x36/0x6a0 fs/ext4/inline.c:531

but task is already holding lock:
ffff8880543c8580 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:934 [inline]
ffff8880543c8580 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_create_folio mm/filemap.c:2539 [inline]
ffff8880543c8580 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_get_pages+0xc29/0x1ea0 mm/filemap.c:2609

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (mapping.invalidate_lock#2){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
       filemap_invalidate_lock_shared include/linux/fs.h:934 [inline]
       page_cache_ra_unbounded+0x129/0x7b0 mm/readahead.c:228
       do_async_mmap_readahead mm/filemap.c:3332 [inline]
       filemap_fault+0x5a0/0x1200 mm/filemap.c:3431
       __do_fault+0x138/0x390 mm/memory.c:5152
       do_read_fault mm/memory.c:5573 [inline]
       do_fault mm/memory.c:5707 [inline]
       do_pte_missing mm/memory.c:4234 [inline]
       handle_pte_fault mm/memory.c:6052 [inline]
       __handle_mm_fault+0x3611/0x5440 mm/memory.c:6195
       handle_mm_fault+0x40a/0x8e0 mm/memory.c:6364
       faultin_page mm/gup.c:1144 [inline]
       __get_user_pages+0x1699/0x2ce0 mm/gup.c:1446
       __get_user_pages_locked mm/gup.c:1712 [inline]
       get_dump_page+0x1ac/0x3f0 mm/gup.c:2212
       dump_user_range+0x1de/0xc90 fs/coredump.c:1364
       elf_core_dump+0x337b/0x3990 fs/binfmt_elf.c:2085
       coredump_write+0x1169/0x1900 fs/coredump.c:1049
       vfs_coredump+0x1a4b/0x2ab0 fs/coredump.c:1168
       get_signal+0x1109/0x1340 kernel/signal.c:3019
       arch_do_signal_or_restart+0x9a/0x750 arch/x86/kernel/signal.c:337
       exit_to_user_mode_loop kernel/entry/common.c:40 [inline]
       exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
       irqentry_exit_to_user_mode+0x81/0x120 kernel/entry/common.c:73
       exc_page_fault+0x9f/0xf0 arch/x86/mm/fault.c:1535
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __might_fault+0xcc/0x130 mm/memory.c:6958
       _inline_copy_to_user include/linux/uaccess.h:192 [inline]
       _copy_to_user+0x2c/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:225 [inline]
       fiemap_fill_next_extent+0x1c0/0x390 fs/ioctl.c:145
       ocfs2_fiemap+0x888/0xc90 fs/ocfs2/extent_map.c:806
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1173/0x1430 fs/ioctl.c:532
       __do_sys_ioctl fs/ioctl.c:596 [inline]
       __se_sys_ioctl+0x82/0x170 fs/ioctl.c:584
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ocfs2_quota_ip_alloc_sem_key){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1590
       ocfs2_create_local_dquot+0x19d/0x1a40 fs/ocfs2/quota_local.c:1227
       ocfs2_acquire_dquot+0x80f/0xb30 fs/ocfs2/quota_global.c:883
       dqget+0x7b1/0xf10 fs/quota/dquot.c:977
       ocfs2_setattr+0xd72/0x1b40 fs/ocfs2/file.c:1233
       notify_change+0xb36/0xe40 fs/attr.c:552
       chown_common+0x40c/0x5c0 fs/open.c:791
       vfs_fchown fs/open.c:859 [inline]
       ksys_fchown+0xea/0x160 fs/open.c:871
       __do_sys_fchown fs/open.c:876 [inline]
       __se_sys_fchown fs/open.c:874 [inline]
       __x64_sys_fchown+0x7a/0x90 fs/open.c:874
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dquot->dq_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x187/0x1360 kernel/locking/mutex.c:760
       wait_on_dquot fs/quota/dquot.c:354 [inline]
       dqget+0x72a/0xf10 fs/quota/dquot.c:972
       dquot_transfer+0x4b8/0x6d0 fs/quota/dquot.c:2154
       ext4_setattr+0x865/0x1bc0 fs/ext4/inode.c:5902
       notify_change+0xb36/0xe40 fs/attr.c:552
       ovl_do_notify_change fs/overlayfs/overlayfs.h:203 [inline]
       ovl_setattr+0x3a3/0x550 fs/overlayfs/inode.c:82
       notify_change+0xb36/0xe40 fs/attr.c:552
       chown_common+0x40c/0x5c0 fs/open.c:791
       do_fchownat+0x161/0x270 fs/open.c:822
       __do_sys_chown fs/open.c:842 [inline]
       __se_sys_chown fs/open.c:840 [inline]
       __x64_sys_chown+0x82/0xa0 fs/open.c:840
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
       ext4_readpage_inline+0x36/0x6a0 fs/ext4/inline.c:531
       ext4_read_folio+0x16c/0x320 fs/ext4/inode.c:3390
       filemap_read_folio+0x117/0x380 mm/filemap.c:2413
       filemap_create_folio mm/filemap.c:2548 [inline]
       filemap_get_pages+0xd4e/0x1ea0 mm/filemap.c:2609
       filemap_read+0x3f6/0x11a0 mm/filemap.c:2712
       __kernel_read+0x46c/0x8c0 fs/read_write.c:530
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x85e/0x16f0 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x428/0x8e0 security/integrity/ima/ima_api.c:293
       process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:405
       ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:633
       security_file_post_open+0xbb/0x290 security/security.c:3160
       do_open fs/namei.c:3889 [inline]
       path_openat+0x2f26/0x3830 fs/namei.c:4046
       do_filp_open+0x1fa/0x410 fs/namei.c:4073
       do_sys_openat2+0x121/0x1c0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> &mm->mmap_lock --> mapping.invalidate_lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(mapping.invalidate_lock#2);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock#2);
  rlock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz.9.1907/11934:
 #0: ffff88805ebb2428 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:557
 #1: ffff88804df9d398 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x74b/0x1a40 security/integrity/ima/ima_main.c:299
 #2: ffff8880543c8580 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:934 [inline]
 #2: ffff8880543c8580 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_create_folio mm/filemap.c:2539 [inline]
 #2: ffff8880543c8580 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_get_pages+0xc29/0x1ea0 mm/filemap.c:2609

stack backtrace:
CPU: 1 UID: 0 PID: 11934 Comm: syz.9.1907 Not tainted 6.16.0-syzkaller-11489-gd2eedaa3909b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
 ext4_readpage_inline+0x36/0x6a0 fs/ext4/inline.c:531
 ext4_read_folio+0x16c/0x320 fs/ext4/inode.c:3390
 filemap_read_folio+0x117/0x380 mm/filemap.c:2413
 filemap_create_folio mm/filemap.c:2548 [inline]
 filemap_get_pages+0xd4e/0x1ea0 mm/filemap.c:2609
 filemap_read+0x3f6/0x11a0 mm/filemap.c:2712
 __kernel_read+0x46c/0x8c0 fs/read_write.c:530
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:480 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x85e/0x16f0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x428/0x8e0 security/integrity/ima/ima_api.c:293
 process_measurement+0x1121/0x1a40 security/integrity/ima/ima_main.c:405
 ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:633
 security_file_post_open+0xbb/0x290 security/security.c:3160
 do_open fs/namei.c:3889 [inline]
 path_openat+0x2f26/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1461
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb8d038eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb8ce1f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fb8d05b6160 RCX: 00007fb8d038eb69
RDX: 0000000000000242 RSI: 0000200000000040 RDI: ffffffffffffff9c
RBP: 00007fb8d0411df1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fb8d05b6160 R15: 00007ffd6d60aa88
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

