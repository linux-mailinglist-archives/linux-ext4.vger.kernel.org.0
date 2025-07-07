Return-Path: <linux-ext4+bounces-8841-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F4AFAAA9
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jul 2025 07:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16036179A1E
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jul 2025 05:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5A1C5485;
	Mon,  7 Jul 2025 05:01:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B823594C
	for <linux-ext4@vger.kernel.org>; Mon,  7 Jul 2025 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751864490; cv=none; b=DAp60h+r4bQ4xde4gtF66Hpvxec8DDgOVhrQdy9BXm0XcbSi/A1C7BzgMfxcBc7bXTh0PTHLRFQsy4BsrFP02U14O1e4BDnpeRdBhkZzPqLY0GAwHV3aj+79OFqv2/wEeP4KqQFSF0Ehb8HZeRQzanJ7nNEj+aSEJgfq2LJn8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751864490; c=relaxed/simple;
	bh=420HxGI0LBtBs5jQqceU4Q+fIw6yy9YUndiQcPVc6QU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I7UnKdx2kK0rDi0dJUrlFTfKNps/uKC+/T+0km+pDAhQtKujbDcnldo41hwJjWe3dNA9NcezrkcukJHx32F+4oXknfEgyfJ3CstTsHVd7NToBRBeP5zHEUWq8yOmd90sNPAQowy6z/OLw1L5CKKMEJDgRC81XjLZ5K+oU4iu2/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-87313ccba79so556830239f.2
        for <linux-ext4@vger.kernel.org>; Sun, 06 Jul 2025 22:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751864486; x=1752469286;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzuIHo13XX1cGLBZyheOl7WSxR7YYsmSm/51i+mgb5A=;
        b=o0cQv0GA0KfqpVytvGf/xfziK140twIIjHlZa3v3/jlEKxQBNDkAYetLQSVllWunMM
         m3BUigXYQFH638nCdlMPe4BBxVdr59O2IVcoWBkjwa9Dc+EWftjvGlicHl2P/snD7qEb
         RzwMGAPXgOmMVb6TqjrhD0ztFJr63ydA57SfzG6SUjVW/Z8H+E+x9cLiSEqxz2DfghaF
         yjfe4pyiM7cE/h55UCvY8vffB3tYm/XU9RPGNO7BrKh5ZmckWEZ82MiYgkiyBZEMvGTr
         JlN90U/3MUk7ElhjqcG9WNrjY0HJJU7ZeRHT/TtJiMT7B2ZSW3iC4Oy8Q5cnbak1Hdvh
         jaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3opnhfTH1wr3lbHwsoyPBWRzJaOWzFuhoH03pBiKJKdOtnH1I2valg2De1Ak5eTFrRoTg/YlvkA8n@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnkaQ6gCn/1zvxVYsstV7HW7b2tjbtg4c1DZoiPUeiXtF/S/a
	0wlWFG3LC4pqHxjrecEAG07cO2sU5xJRI7e9dlAdkiqT+WFEtTeGiu6/CDVFi1sC1gYMNuEWhDL
	Jof2eoCOJCvW16T5sQGaLrQURJTR7E2HoGO4lw/iguh27ZSrnJYXiWvcLCBY=
X-Google-Smtp-Source: AGHT+IG9eK1QOxUtDoFIFCmuZvWi5/+cM9w/MCo6wL7NVcw1RFDlkjAT3jwQsIV3kpZhhP7jbuBA5jlbHiSASxo5WRUtacpOv+jJ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388e:b0:864:4aa2:d796 with SMTP id
 ca18e2360f4ac-876e47b4e4emr1005644539f.8.1751864486533; Sun, 06 Jul 2025
 22:01:26 -0700 (PDT)
Date: Sun, 06 Jul 2025 22:01:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686b54a6.a00a0220.c7b3.0075.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_evict_inode (4)
From: syzbot <syzbot+1a921ddeed254c00100d@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D14234bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D72aa0474e3c3b9a=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1a921ddeed254c001=
00d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/605b3edeb031/disk-=
d7b8f8e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3cb6f3ea4a9/vmlinux-=
d7b8f8e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd9e0c6a9926/bzI=
mage-d7b8f8e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+1a921ddeed254c00100d@syzkaller.appspotmail.com

ext4 filesystem being mounted at /31/file0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa supports tim=
estamps until 2038-01-19 (0x7fffffff)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.16.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz.5.282/7960 is trying to acquire lock:
ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: percpu_down_read_freezable =
include/linux/percpu-rwsem.h:83 [inline]
ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/li=
nux/fs.h:1795 [inline]
ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/l=
inux/fs.h:1978 [inline]
ffff88807b0b8618 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x2d6/0xee=
0 fs/ext4/inode.c:215

but task is already holding lock:
ffff88805438cb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepage=
s_down_write fs/ext4/ext4.h:1816 [inline]
ffff88805438cb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migra=
te+0x2f3/0x1010 fs/ext4/migrate.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1804 [inline]
       ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:2952
       do_writepages+0x32b/0x550 mm/page-writeback.c:2636
       filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
       __filemap_fdatawrite_range mm/filemap.c:419 [inline]
       filemap_write_and_wait_range+0x217/0x310 mm/filemap.c:691
       ext4_collapse_range+0x2da/0x950 fs/ext4/extents.c:5426
       ext4_fallocate+0x58d/0xcd0 fs/ext4/extents.c:4786
       vfs_fallocate+0x6a3/0x830 fs/open.c:341
       ksys_fallocate fs/open.c:365 [inline]
       __do_sys_fallocate fs/open.c:370 [inline]
       __se_sys_fallocate fs/open.c:368 [inline]
       __x64_sys_fallocate+0xc0/0x110 fs/open.c:368
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (mapping.invalidate_lock#2){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:934 [inline]
       filemap_fault+0x546/0x1200 mm/filemap.c:3400
       __do_fault+0x138/0x390 mm/memory.c:5169
       do_read_fault mm/memory.c:5590 [inline]
       do_fault mm/memory.c:5724 [inline]
       do_pte_missing mm/memory.c:4251 [inline]
       handle_pte_fault mm/memory.c:6069 [inline]
       __handle_mm_fault+0x37ed/0x5620 mm/memory.c:6212
       handle_mm_fault+0x2d5/0x7f0 mm/memory.c:6381
       do_user_addr_fault+0x764/0x1390 arch/x86/mm/fault.c:1387
       handle_page_fault arch/x86/mm/fault.c:1476 [inline]
       exc_page_fault+0x76/0xf0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x8e/0x130 mm/gup.c:-1
       fault_in_iov_iter_readable+0x1b4/0x2f0 lib/iov_iter.c:94
       generic_perform_write+0x7cc/0x910 mm/filemap.c:4161
       ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
       ext4_dio_write_iter fs/ext4/file.c:613 [inline]
       ext4_file_write_iter+0x182a/0x1bc0 fs/ext4/file.c:721
       do_iter_readv_writev+0x56e/0x7f0 fs/read_write.c:-1
       vfs_writev+0x31a/0x960 fs/read_write.c:1057
       do_pwritev fs/read_write.c:1153 [inline]
       __do_sys_pwritev2 fs/read_write.c:1211 [inline]
       __se_sys_pwritev2+0x179/0x290 fs/read_write.c:1202
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __might_fault+0xcc/0x130 mm/memory.c:6971
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
       dqget+0x7b1/0xf10 fs/quota/dquot.c:977
       __dquot_initialize+0x3b3/0xcb0 fs/quota/dquot.c:1505
       ocfs2_get_init_inode+0x13b/0x1b0 fs/ocfs2/namei.c:202
       ocfs2_mknod+0x863/0x2050 fs/ocfs2/namei.c:310
       ocfs2_create+0x1a5/0x440 fs/ocfs2/namei.c:673
       lookup_open fs/namei.c:3717 [inline]
       open_last_lookups fs/namei.c:3816 [inline]
       path_openat+0x14f1/0x3830 fs/namei.c:4052
       do_filp_open+0x1fa/0x410 fs/namei.c:4082
       do_sys_openat2+0x121/0x1c0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dquot->dq_lock){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       __mutex_lock_common kernel/locking/mutex.c:602 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
       dquot_release+0x66/0x600 fs/quota/dquot.c:531
       ext4_release_dquot+0x3ee/0x6c0 fs/ext4/ext4_jbd2.h:-1
       quota_release_workfn+0x35f/0x610 fs/quota/dquot.c:840
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
       kthread+0x711/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1795 [inline]
       sb_start_intwrite include/linux/fs.h:1978 [inline]
       ext4_evict_inode+0x2d6/0xee0 fs/ext4/inode.c:215
       evict+0x504/0x9c0 fs/inode.c:810
       ext4_ext_migrate+0xd23/0x1010 fs/ext4/migrate.c:588
       __ext4_ioctl fs/ext4/ioctl.c:1402 [inline]
       ext4_ioctl+0x1b1a/0x3510 fs/ext4/ioctl.c:1626
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_internal --> mapping.invalidate_lock#2 --> &sbi->s_writepages_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_writepages_rwsem);
                               lock(mapping.invalidate_lock#2);
                               lock(&sbi->s_writepages_rwsem);
  rlock(sb_internal);

 *** DEADLOCK ***

3 locks held by syz.5.282/7960:
 #0: ffff88807b0b8428 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0=
x60/0x200 fs/namespace.c:601
 #1: ffff88805c5b2a20 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_l=
ock include/linux/fs.h:869 [inline]
 #1: ffff88805c5b2a20 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: __ext4_=
ioctl fs/ext4/ioctl.c:1401 [inline]
 #1: ffff88805c5b2a20 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: ext4_io=
ctl+0x1b12/0x3510 fs/ext4/ioctl.c:1626
 #2: ffff88805438cb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writ=
epages_down_write fs/ext4/ext4.h:1816 [inline]
 #2: ffff88805438cb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_=
migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

stack backtrace:
CPU: 1 UID: 0 PID: 7960 Comm: syz.5.282 Not tainted 6.16.0-rc5-syzkaller #0=
 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 05/07/2025
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
 percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1795 [inline]
 sb_start_intwrite include/linux/fs.h:1978 [inline]
 ext4_evict_inode+0x2d6/0xee0 fs/ext4/inode.c:215
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_ext_migrate+0xd23/0x1010 fs/ext4/migrate.c:588
 __ext4_ioctl fs/ext4/ioctl.c:1402 [inline]
 ext4_ioctl+0x1b1a/0x3510 fs/ext4/ioctl.c:1626
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec7c18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec79ff6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fec7c3b5fa0 RCX: 00007fec7c18e929
RDX: 0000000000000000 RSI: 0000000000006609 RDI: 0000000000000004
RBP: 00007fec7c210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fec7c3b5fa0 R15: 00007ffc144475c8
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

