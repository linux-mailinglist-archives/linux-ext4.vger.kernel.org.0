Return-Path: <linux-ext4+bounces-4642-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F579A50B9
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Oct 2024 22:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1717D28455B
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Oct 2024 20:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF5191F8F;
	Sat, 19 Oct 2024 20:27:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976B18E37C
	for <linux-ext4@vger.kernel.org>; Sat, 19 Oct 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729369653; cv=none; b=B7fdTQeeL9sWAYsAqLGnTrmMEJeZBw8iSHHoRpBt0svc/tZjfz4gQZ+yGJ/6S6qfdQEnNeTPcwkE2x738tHT9HR0vVGiJ/+5YMMFbcNU/RxMxxDlL3xFThphAhwKuA0uRaEwHiBc2b21ny0za3oVCEJKgwxgcwUPfOFPvqVB/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729369653; c=relaxed/simple;
	bh=5o2QfaCf+mSg7l1AsBszPfL7kHeznFFnHfd40nozz+4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MUSd5hm/KjqfWsDUPwqdcuuW+WuMoIi0H8VjImeyBibrKBDrLWCshlm1nJ/ggK1folfx9SHt5M8h+GAP8lvtso2fQ0U1OQjttWay3J1VXcjiY5JVrG4jd/ehI00toCGFeKkjiKb4JgimELc5CmPS7of5XTBUYsU/vJgQCcYah6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c38d2b91so30274465ab.3
        for <linux-ext4@vger.kernel.org>; Sat, 19 Oct 2024 13:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729369649; x=1729974449;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igEmI4D2p4ePfRy2gbQyXhCB1yEGzxceUUzURWwvRVc=;
        b=WYdahQ+Z36NDBjKouH8GNoX/tkGcwgWyZutGWi2ewRO1X+88wiErbx9pk/l5+42ky1
         XE9hhbUmASJB+7ylON4lKmasdXVgHiXqjUJf5XtOSArju0M6fP75GtHAB9BsINURSuH8
         3kisXORT8WI/Q6ff2HLV6dvIfgPK9gwXzF170cpESwCyqyWpR1J9B2wfroBgUyeuK3Po
         shbvMcXwIGuyzsTk1iPfN22IU+JiCpAewn+X+1wV6VzfjdFEsNR40zjpL/tNKtV6B2Y4
         jxi8lN9ulxsDoL5dLltLqbr4dK8g/uXDLq4Tmr0Evu2dnOSpdpAC9qhJq4vSEdkKy4Y9
         WD3A==
X-Forwarded-Encrypted: i=1; AJvYcCVJuLFw17NU/7MUF9ZHftMi5L9EgaegbZepW5pXxvtrGmQkhDcrcKE1j3OVs/czO3K7bA7G2cFSJW+r@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZB5lm7vx7sa+VH/Io2ic98uVVc33wJneDgdU2HfTjQqBhAAL
	ioF2/6SEGw0YWjLVX4VY2j9w68OmIDnlC6RRCBsvB8HILJtVFwMLN+4ZgWtrF823W2v9DF+HMOH
	Kt0WEgVS/nPqp9D1sp7Yoj8qPC6o663z64reAeeUmG1sBaa0/Rq/MNp0=
X-Google-Smtp-Source: AGHT+IELBPfUw2hxSu/tbCLXTmDeBVZ5vvcvsBe3IKu6znJfDLUgiezsBzZhuFso98UAdEiCkhUyKr3SSBjSkeCJAEIj9AxRp2mH
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a3f4073bcdmr63469795ab.14.1729369649626; Sat, 19 Oct 2024
 13:27:29 -0700 (PDT)
Date: Sat, 19 Oct 2024 13:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67141631.050a0220.1e4b4d.002e.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_writepages (2)
From: syzbot <syzbot+eb5b4ef634a018917f3c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f87d0916ce0 Merge tag 'trace-ringbuffer-v6.12-rc3' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10279f67980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f487443bc3bb/disk-2f87d091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5cebceae528/vmlinux-2f87d091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9c1ca67e7e7/bzImage-2f87d091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb5b4ef634a018917f3c@syzkaller.appspotmail.com

EXT4-fs (loop4): Free/Dirty block details
EXT4-fs (loop4): free_blocks=2415919104
EXT4-fs (loop4): dirty_blocks=16
EXT4-fs (loop4): Block reservation details
EXT4-fs (loop4): i_reserved_data_blocks=1
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc3-syzkaller-00044-g2f87d0916ce0 #0 Not tainted
------------------------------------------------------
syz.4.962/11197 is trying to acquire lock:
ffff8880256c6b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1772 [inline]
ffff8880256c6b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2812

but task is already holding lock:
ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:860 [inline]
ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: swap_inode_boot_loader fs/ext4/ioctl.c:408 [inline]
ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: __ext4_ioctl fs/ext4/ioctl.c:1436 [inline]
ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_ioctl+0x3c1e/0x5590 fs/ext4/ioctl.c:1626

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (mapping.invalidate_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:870 [inline]
       ext4_page_mkwrite+0x217/0xdf0 fs/ext4/inode.c:6104
       do_page_mkwrite+0x198/0x480 mm/memory.c:3162
       wp_page_shared mm/memory.c:3563 [inline]
       do_wp_page+0x23d3/0x52d0 mm/memory.c:3713
       handle_pte_fault+0x10e3/0x6800 mm/memory.c:5767
       __handle_mm_fault mm/memory.c:5894 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6062
       do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #4 (sb_pagefaults){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
       __sb_start_write include/linux/fs.h:1716 [inline]
       sb_start_pagefault include/linux/fs.h:1881 [inline]
       ext4_page_mkwrite+0x1ef/0xdf0 fs/ext4/inode.c:6101
       do_page_mkwrite+0x198/0x480 mm/memory.c:3162
       do_shared_fault mm/memory.c:5358 [inline]
       do_fault mm/memory.c:5420 [inline]
       do_pte_missing mm/memory.c:3965 [inline]
       handle_pte_fault+0x11fa/0x6800 mm/memory.c:5751
       __handle_mm_fault mm/memory.c:5894 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6062
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #3 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __might_fault+0xc6/0x120 mm/memory.c:6700
       _inline_copy_to_user include/linux/uaccess.h:183 [inline]
       _copy_to_user+0x2a/0xb0 lib/usercopy.c:26
       copy_to_user include/linux/uaccess.h:216 [inline]
       fiemap_fill_next_extent+0x235/0x410 fs/ioctl.c:145
       ocfs2_fiemap+0x9f1/0xf80 fs/ocfs2/extent_map.c:796
       ioctl_fiemap fs/ioctl.c:220 [inline]
       do_vfs_ioctl+0x1bf8/0x2e40 fs/ioctl.c:841
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ocfs2_quota_ip_alloc_sem_key){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ocfs2_create_local_dquot+0x1de/0x1d70 fs/ocfs2/quota_local.c:1231
       ocfs2_acquire_dquot+0x833/0xb80 fs/ocfs2/quota_global.c:878
       dqget+0x770/0xeb0 fs/quota/dquot.c:976
       ocfs2_setattr+0xe70/0x1f50 fs/ocfs2/file.c:1230
       notify_change+0xbca/0xe90 fs/attr.c:503
       chown_common+0x501/0x850 fs/open.c:793
       do_fchownat+0x16a/0x240 fs/open.c:824
       __do_sys_lchown fs/open.c:849 [inline]
       __se_sys_lchown fs/open.c:847 [inline]
       __x64_sys_lchown+0x85/0xa0 fs/open.c:847
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dquot->dq_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       wait_on_dquot fs/quota/dquot.c:355 [inline]
       dqget+0x6e6/0xeb0 fs/quota/dquot.c:971
       __dquot_initialize+0x2e3/0xec0 fs/quota/dquot.c:1504
       __ext4_new_inode+0x852/0x4380 fs/ext4/ialloc.c:991
       ext4_ext_migrate+0x6c1/0x13e0 fs/ext4/migrate.c:456
       ext4_ioctl_setflags fs/ext4/ioctl.c:702 [inline]
       ext4_fileattr_set+0xecf/0x16e0 fs/ext4/ioctl.c:1021
       vfs_fileattr_set+0x8ff/0xd50 fs/ioctl.c:697
       ioctl_setflags fs/ioctl.c:729 [inline]
       do_vfs_ioctl+0x207a/0x2e40 fs/ioctl.c:870
       __do_sys_ioctl fs/ioctl.c:905 [inline]
       __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
       percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
       ext4_writepages_down_read fs/ext4/ext4.h:1772 [inline]
       ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2812
       do_writepages+0x35d/0x870 mm/page-writeback.c:2683
       filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
       __filemap_fdatawrite_range mm/filemap.c:431 [inline]
       filemap_write_and_wait_range+0x192/0x280 mm/filemap.c:685
       filemap_write_and_wait include/linux/pagemap.h:68 [inline]
       swap_inode_boot_loader fs/ext4/ioctl.c:409 [inline]
       __ext4_ioctl fs/ext4/ioctl.c:1436 [inline]
       ext4_ioctl+0x3c55/0x5590 fs/ext4/ioctl.c:1626
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->s_writepages_rwsem --> sb_pagefaults --> mapping.invalidate_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock);
                               lock(sb_pagefaults);
                               lock(mapping.invalidate_lock);
  rlock(&sbi->s_writepages_rwsem);

 *** DEADLOCK ***

4 locks held by syz.4.962/11197:
 #0: ffff888026aee420 (sb_writers#4){++++}-{0:0}, at: mnt_want_write_file+0x5e/0x200 fs/namespace.c:559
 #1: ffff888060670de0 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888060670de0 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: lock_two_nondirectories+0xe1/0x170 fs/inode.c:1211
 #2: ffff888060675338 (&sb->s_type->i_mutex_key#7/4){+.+.}-{3:3}, at: swap_inode_boot_loader fs/ext4/ioctl.c:391 [inline]
 #2: ffff888060675338 (&sb->s_type->i_mutex_key#7/4){+.+.}-{3:3}, at: __ext4_ioctl fs/ext4/ioctl.c:1436 [inline]
 #2: ffff888060675338 (&sb->s_type->i_mutex_key#7/4){+.+.}-{3:3}, at: ext4_ioctl+0x24a1/0x5590 fs/ext4/ioctl.c:1626
 #3: ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:860 [inline]
 #3: ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: swap_inode_boot_loader fs/ext4/ioctl.c:408 [inline]
 #3: ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: __ext4_ioctl fs/ext4/ioctl.c:1436 [inline]
 #3: ffff888060670f80 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_ioctl+0x3c1e/0x5590 fs/ext4/ioctl.c:1626

stack backtrace:
CPU: 0 UID: 0 PID: 11197 Comm: syz.4.962 Not tainted 6.12.0-rc3-syzkaller-00044-g2f87d0916ce0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 percpu_down_read+0x44/0x1b0 include/linux/percpu-rwsem.h:51
 ext4_writepages_down_read fs/ext4/ext4.h:1772 [inline]
 ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2812
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:398
 __filemap_fdatawrite_range mm/filemap.c:431 [inline]
 filemap_write_and_wait_range+0x192/0x280 mm/filemap.c:685
 filemap_write_and_wait include/linux/pagemap.h:68 [inline]
 swap_inode_boot_loader fs/ext4/ioctl.c:409 [inline]
 __ext4_ioctl fs/ext4/ioctl.c:1436 [inline]
 ext4_ioctl+0x3c55/0x5590 fs/ext4/ioctl.c:1626
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44b937dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f44ba10a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f44b9535f80 RCX: 00007f44b937dff9
RDX: 0000000000000000 RSI: 0000000000006611 RDI: 0000000000000004
RBP: 00007f44b93f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f44b9535f80 R15: 00007fffc7835df8
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

