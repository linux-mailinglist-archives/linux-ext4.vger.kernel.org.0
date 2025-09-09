Return-Path: <linux-ext4+bounces-9889-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC1B5093B
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 01:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6572B1C640DA
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FB92874FB;
	Tue,  9 Sep 2025 23:28:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA60286438
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460513; cv=none; b=ckDYUDBxejy4Vo5p445Y9LmAqDlzSHJDGaIe1G73TIBnbUD4bKphvxi4+XtKklFf7VeqzNXF7ciEHj7TEqbiHX2wEm94yCEqErrE7Rq8lU371BBYk7HnYZUEIa/UJVZpcm3FCnsUYrOUfJmKGIJuYIQ/qouuwYoWa0Ft7wNceW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460513; c=relaxed/simple;
	bh=XYdbb9nmUlQUvNNDXRfpZJfu0TpFI9113iwpehoN4wA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gNSrAdqvDjYJfJMOlzFzj97z2UgEyjuj3ZRm9SSZKO1VMO6YpA7ZsKDYCAlOqdU2Adc46alesCPw195d7LXrE1cN/H0om1M10ukMP/jIFDhskr+IjZNPckvdUjJZVV8KQPvrMws6rGdnuJoS/w0sVFafoR/gY8EluYETYxuJIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-886e347d2afso573134739f.3
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 16:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460510; x=1758065310;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W2feQOR5gNEXOhepVFqzjcj+EcGYJbm2sxtlA9GecCs=;
        b=cQi9TRxkyPiP+uTYFN5z3xk+Iop+kSCRXP3BG7fv6Q40OhPb/cIhJ0+vn/G2rZrnbb
         M55Wcc7I0rq2XpZzLnKh4vKYh91Wr1icidyirLpbYFjNkZTt68KmBRgYsR6bmBgTwYQ4
         IQDaSngx5IYJUQz2mGe7OTxWcsR34jltD5rTUIBNSkNWXB5GJ7VmS7sjQWcUu2fpqdhe
         9Kh2lqeRIwd8bj+gM1bDmYfx499HQA4UFHJXZyoeADBTCehlK5jdokXbCGRnHRteGRrR
         B77HJBOvbzT5J/fGQtn/e8t3i/OxCwCVmSQ8UuqngNfVpVVjjfHrRPPCtocEukSNiU+v
         b6Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV8VuWPL5BeO8gfKLz1yMo60DE6tn7DnETXK2mo7HhnVBdz2hZfAHr2HPdRXTQCHf4lek7hlxBCXCiI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+ctm1jtk/kx/4pYqwlj7vUHNRNk8egUrxEDor4ewp688fQu9
	P6exff3ZORTDNUCD09RLYhAJvTrmTgJKpIBEPHosSo+u1WD1O1wqUQwYLsuTJTmuNFKiIVn22vb
	y3Y0S3E7sbjYQdjGg6gS0IsDrGxtSs7kbDUD/34Oyyd4aO/ELluWKRvSI8NI=
X-Google-Smtp-Source: AGHT+IF2SITyfvOR/ctH8XHk4vnY6mOF5CEchuMfb9FFsahjvxz+GpbWzaYEdO2LbaCpio3hLGgPieSJ1TA9jpxZvQI2tdsQrwtU
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:414:a64f:8194 with SMTP id
 e9e14a558f8ab-414a64f836cmr39122985ab.12.1757460510549; Tue, 09 Sep 2025
 16:28:30 -0700 (PDT)
Date: Tue, 09 Sep 2025 16:28:30 -0700
In-Reply-To: <67141631.050a0220.1e4b4d.002e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0b81e.050a0220.3c6139.0015.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_writepages (2)
From: syzbot <syzbot+eb5b4ef634a018917f3c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9dd1835ecda5 Merge tag 'dma-mapping-6.17-2025-09-09' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f94b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e4d62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160f6d62580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63dc392685dc/disk-9dd1835e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3dfcfb97806e/vmlinux-9dd1835e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddb10128aeb8/bzImage-9dd1835e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0b26d5f09478/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14aab562580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb5b4ef634a018917f3c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6097 is trying to acquire lock:
ffff88803dfbec58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
ffff88803dfbec58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
ffff88803dfbec58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024

but task is already holding lock:
ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6425 [inline]
ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x3eb/0x700 fs/ext4/inode.c:6506

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->xattr_sem){++++}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2362
       ext4_initxattrs+0x9f/0x110 fs/ext4/xattr_security.c:44
       security_inode_init_security+0x29d/0x3f0 security/security.c:1852
       __ext4_new_inode+0x3314/0x3cb0 fs/ext4/ialloc.c:1325
       ext4_create+0x22d/0x460 fs/ext4/namei.c:2822
       lookup_open fs/namei.c:3708 [inline]
       open_last_lookups fs/namei.c:3807 [inline]
       path_openat+0x14fd/0x3840 fs/namei.c:4043
       do_filp_open+0x1fa/0x410 fs/namei.c:4073
       do_sys_openat2+0x121/0x1c0 fs/open.c:1435
       do_sys_open fs/open.c:1450 [inline]
       __do_sys_openat fs/open.c:1466 [inline]
       __se_sys_openat fs/open.c:1461 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1461
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (jbd2_handle){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       start_this_handle+0x1fa7/0x21c0 fs/jbd2/transaction.c:444
       jbd2__journal_start+0x2c1/0x5b0 fs/jbd2/transaction.c:501
       __ext4_journal_start_sb+0x227/0x5c0 fs/ext4/ext4_jbd2.c:115
       __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
       ext4_do_writepages+0xf6f/0x4600 fs/ext4/inode.c:2913
       ext4_writepages+0x205/0x350 fs/ext4/inode.c:3025
       do_writepages+0x32b/0x550 mm/page-writeback.c:2634
       __writeback_single_inode+0x145/0x1000 fs/fs-writeback.c:1680
       writeback_sb_inodes+0x6b7/0xf60 fs/fs-writeback.c:1976
       __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
       wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
       wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
       wb_do_writeback fs/fs-writeback.c:2315 [inline]
       wb_workfn+0xaf4/0xf00 fs/fs-writeback.c:2343
       process_one_work kernel/workqueue.c:3236 [inline]
       process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
       kthread+0x70e/0x8a0 kernel/kthread.c:463
       ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal+0x48/0x1d0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
       ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
       do_writepages+0x32b/0x550 mm/page-writeback.c:2634
       __writeback_single_inode+0x145/0x1000 fs/fs-writeback.c:1680
       writeback_single_inode+0x1d5/0x640 fs/fs-writeback.c:1801
       write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2864
       iput_final fs/inode.c:1884 [inline]
       iput+0x5b9/0x9d0 fs/inode.c:1923
       ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2194
       ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
       ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
       __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6506
       ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
       evict+0x504/0x9c0 fs/inode.c:810
       ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5609 [inline]
       ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
       get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
       do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
       do_mount fs/namespace.c:4136 [inline]
       __do_sys_mount fs/namespace.c:4347 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4324
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sbi->s_writepages_rwsem --> jbd2_handle --> &ei->xattr_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->xattr_sem);
                               lock(jbd2_handle);
                               lock(&ei->xattr_sem);
  rlock(&sbi->s_writepages_rwsem);

 *** DEADLOCK ***

3 locks held by syz.0.17/6097:
 #0: ffff88803dfbc0d0 (&type->s_umount_key#26/1){+.+.}-{4:4}, at: alloc_super+0x204/0x990 fs/super.c:345
 #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1799 [inline]
 #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs.h:1982 [inline]
 #1: ffff88803dfbc778 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x2d6/0xee0 fs/ext4/inode.c:215
 #2: ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
 #2: ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6425 [inline]
 #2: ffff88823bf82560 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x3eb/0x700 fs/ext4/inode.c:6506

stack backtrace:
CPU: 1 UID: 0 PID: 6097 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
 percpu_down_read_internal+0x48/0x1d0 include/linux/percpu-rwsem.h:53
 percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 ext4_writepages_down_read fs/ext4/ext4.h:1786 [inline]
 ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
 do_writepages+0x32b/0x550 mm/page-writeback.c:2634
 __writeback_single_inode+0x145/0x1000 fs/fs-writeback.c:1680
 writeback_single_inode+0x1d5/0x640 fs/fs-writeback.c:1801
 write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2864
 iput_final fs/inode.c:1884 [inline]
 iput+0x5b9/0x9d0 fs/inode.c:1923
 ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2194
 ext4_xattr_move_to_block fs/ext4/xattr.c:2659 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x12d5/0x1ea0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
 __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6506
 ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5609 [inline]
 ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fefaad0038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb287c378 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdb287c400 RCX: 00007fefaad0038a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffdb287c3c0
RBP: 0000200000000180 R08: 00007ffdb287c400 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffdb287c3c0 R14: 0000000000000473 R15: 0000200000000680
 </TASK>
------------[ cut here ]------------
EA inode 11 i_nlink=2
WARNING: CPU: 1 PID: 6097 at fs/ext4/xattr.c:1053 ext4_xattr_inode_update_ref+0x534/0x5d0 fs/ext4/xattr.c:1051
Modules linked in:
CPU: 1 UID: 0 PID: 6097 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:ext4_xattr_inode_update_ref+0x534/0x5d0 fs/ext4/xattr.c:1051
Code: 00 00 00 00 00 fc ff df 41 0f b6 44 05 00 84 c0 0f 85 86 00 00 00 41 8b 14 24 48 c7 c7 60 6d 1f 8b 4c 89 fe e8 1d 9a 07 ff 90 <0f> 0b 90 90 48 bb 00 00 00 00 00 fc ff df e9 bb fd ff ff e8 a4 2b
RSP: 0018:ffffc900041bf1a0 EFLAGS: 00010246
RAX: 3b7a600244a15000 RBX: dffffc0000000000 RCX: ffff88803cfa3b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900041bf298 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1017124863 R12: ffff888049711b30
R13: 1ffff110092e2366 R14: 00000000ffffffff R15: 000000000000000b
FS:  000055556e3f9500(0000) GS:ffff8881269bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f24cdec2e9c CR3: 000000002c16a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_xattr_inode_dec_ref fs/ext4/xattr.c:1076 [inline]
 ext4_xattr_set_entry+0xabb/0x1e20 fs/ext4/xattr.c:1714
 ext4_xattr_ibody_set+0x254/0x6a0 fs/ext4/xattr.c:2263
 ext4_xattr_move_to_block fs/ext4/xattr.c:2666 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x13a8/0x1ea0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6385
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
 __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6506
 ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
 evict+0x504/0x9c0 fs/inode.c:810
 ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5609 [inline]
 ext4_fill_super+0x57fa/0x60b0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fefaad0038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb287c378 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdb287c400 RCX: 00007fefaad0038a
RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007ffdb287c3c0
RBP: 0000200000000180 R08: 00007ffdb287c400 R09: 0000000000800700
R10: 0000000000800700 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffdb287c3c0 R14: 0000000000000473 R15: 0000200000000680
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

