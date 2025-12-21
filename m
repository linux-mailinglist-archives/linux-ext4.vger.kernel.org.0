Return-Path: <linux-ext4+bounces-12456-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B58CD3E54
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Dec 2025 11:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E84C300B2B4
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Dec 2025 10:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCF28688D;
	Sun, 21 Dec 2025 10:00:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D42848A1
	for <linux-ext4@vger.kernel.org>; Sun, 21 Dec 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766311226; cv=none; b=JALsnS0SqLHMqbddcPz/noVmHdU6KSWVU2ZLGPCq25/ny+07n1QLGCMIlKIlXRoiip6OARJyloOUQTmTGUZjVCna00D6ZShoU4aeTFT+3egx4wood7DIHrKH2iU/E2F7qEGnNDYA3l8sF8kNBQFL/ekzuUrhbbzvSq8lBmCrzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766311226; c=relaxed/simple;
	bh=WFj80kzp+nhchNGxnBspnxNIimb6PXfUhvQX2xv4YHE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AKREYWFxxKQPKm7Cf0o0tgK2oakD2rVQqy7qMy1K8GVewOpHaNihpvQdch5DuppNGgpyqCkwaoN6g3BNAalrF29Cmu0/1pLzBc1K9ticjEG5n2KxFVAhnIhYO/1mXYxzllCk8OFZgo66zAPP1bpbRoh+OmLoNdqHDF2o2VMTH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c7593b5c93so5561526a34.3
        for <linux-ext4@vger.kernel.org>; Sun, 21 Dec 2025 02:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766311223; x=1766916023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc8n2bNhPML2UHKcrQmEuXbAJ7a6+0gP4itOvJJ+j1g=;
        b=lb03GQ9x2qiWkj0pTs021eJSCiXGi3J365Zgv2p6Qroixt1+OdPARibaA5uvnwud9N
         pCsVZ0qQYWPIWEFUmd2Y3IMSSdwAtwcsQjxYzAP7lnZlUSdK9N1aJ1EyzGSosKFz2PE+
         gc1cjtvNebxN0cx1aJluTLvDsSQNXQnKu0wtixnDLiUp/REdGoBQSifdf0rIn/1p18b5
         n4NDz2R/T9K5SF8NSZa1VHnlDhNjIFhF7R1w0S3ETr2dEZxrCpLzP6f9CPIox50mgFUB
         898zgSNDne8pp5hWJbM+q72yq+xuv3r7LsfaqNofG5+m2A6FHx88j5CkgX4rhwB3Up6Q
         n+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUBliuDOLckf2ug4EZ83i17ipwjnu+cHjPt/0Y66ui3B2pNYFG6A9Fis/df8FQrSZgzd2Ci2UD2Zj8@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3TChHtciUywjSrRcfXLDDu/5bpmreh3q2iFQQXJcI6n0rRLw
	ebuqe4+BfanV+hWd2UaENfU/u/jInW11vMfqcrI0UAgsmuSL3TVC8jco1heEsx7XIkD044HpIM2
	M+WyeKnAgMgpTVZZFWYEpMPCJDu48Q//VmEU1DpY6cgBdqe+RWLcCmdp1LLI=
X-Google-Smtp-Source: AGHT+IGan9sM3tyKU7+723tgxCtVW7AxpGHlXf6C3X0gu692542hSgX8xDs176sd73Tn5mdkby0rkl4k/RRZCXSn06JRdMI2Pv+a
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ef89:0:b0:659:9a49:8f57 with SMTP id
 006d021491bc7-65d0e9a585dmr2259460eaf.28.1766311223598; Sun, 21 Dec 2025
 02:00:23 -0800 (PST)
Date: Sun, 21 Dec 2025 02:00:23 -0800
In-Reply-To: <690b37b1.050a0220.3d0d33.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6947c537.050a0220.1b4e0c.0028.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_evict_inode (5)
From: syzbot <syzbot+212e8f62790f8e0bc63b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    cc3aa43b44bd Add linux-next specific files for 20251219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16240584580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1bc82c6189c463
dashboard link: https://syzkaller.appspot.com/bug?extid=212e8f62790f8e0bc63b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113b83c2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17785db4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30bf539e6f28/disk-cc3aa43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2f8b08e342/vmlinux-cc3aa43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec7ee6ece11f/bzImage-cc3aa43b.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/6d38ae5229b4/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11ec9392580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/e5fc772dada1/mount_1.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=163b83c2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+212e8f62790f8e0bc63b@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.192/6440 is trying to acquire lock:
ffff88807d9c8610 (sb_internal){.+.+}-{0:0}, at: percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
ffff88807d9c8610 (sb_internal){.+.+}-{0:0}, at: __sb_start_write include/linux/fs/super.h:19 [inline]
ffff88807d9c8610 (sb_internal){.+.+}-{0:0}, at: sb_start_intwrite include/linux/fs/super.h:177 [inline]
ffff88807d9c8610 (sb_internal){.+.+}-{0:0}, at: ext4_evict_inode+0x26f/0xe60 fs/ext4/inode.c:214

but task is already holding lock:
ffff88802a6a8b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1832 [inline]
ffff88802a6a8b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
       ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025
       do_writepages+0x32e/0x550 mm/page-writeback.c:2598
       __writeback_single_inode+0x133/0x1240 fs/fs-writeback.c:1737
       writeback_single_inode+0x493/0xc70 fs/fs-writeback.c:1858
       write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2924
       iput_final fs/inode.c:1941 [inline]
       iput+0xa77/0x1030 fs/inode.c:2003
       ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2203
       ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
       ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2831
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6349
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
       __ext4_mark_inode_dirty+0x45c/0x6e0 fs/ext4/inode.c:6470
       ext4_evict_inode+0x79c/0xe60 fs/ext4/inode.c:253
       evict+0x5f4/0xae0 fs/inode.c:837
       ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:472
       __ext4_fill_super fs/ext4/super.c:5658 [inline]
       ext4_fill_super+0x58a1/0x6160 fs/ext4/super.c:5777
       get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
       vfs_get_tree+0x92/0x2a0 fs/super.c:1751
       fc_mount fs/namespace.c:1199 [inline]
       do_new_mount_fc fs/namespace.c:3636 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3712
       do_mount fs/namespace.c:4035 [inline]
       __do_sys_mount fs/namespace.c:4224 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4201
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_intwrite include/linux/fs/super.h:177 [inline]
       ext4_evict_inode+0x26f/0xe60 fs/ext4/inode.c:214
       evict+0x5f4/0xae0 fs/inode.c:837
       ext4_ext_migrate+0xd23/0x1010 fs/ext4/migrate.c:588
       __ext4_ioctl fs/ext4/ioctl.c:1688 [inline]
       ext4_ioctl+0x204a/0x4760 fs/ext4/ioctl.c:1917
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_writepages_rwsem);
                               lock(sb_internal);
                               lock(&sbi->s_writepages_rwsem);
  rlock(sb_internal);

 *** DEADLOCK ***

3 locks held by syz.4.192/6440:
 #0: ffff88807d9c8420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:543
 #1: ffff88805fc0b400 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: inode_lock include/linux/fs.h:1028 [inline]
 #1: ffff88805fc0b400 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: __ext4_ioctl fs/ext4/ioctl.c:1687 [inline]
 #1: ffff88805fc0b400 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: ext4_ioctl+0x2042/0x4760 fs/ext4/ioctl.c:1917
 #2: ffff88802a6a8b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1832 [inline]
 #2: ffff88802a6a8b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

stack backtrace:
CPU: 1 UID: 0 PID: 6440 Comm: syz.4.192 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
 percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_intwrite include/linux/fs/super.h:177 [inline]
 ext4_evict_inode+0x26f/0xe60 fs/ext4/inode.c:214
 evict+0x5f4/0xae0 fs/inode.c:837
 ext4_ext_migrate+0xd23/0x1010 fs/ext4/migrate.c:588
 __ext4_ioctl fs/ext4/ioctl.c:1688 [inline]
 ext4_ioctl+0x204a/0x4760 fs/ext4/ioctl.c:1917
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f273d38f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc40d3ab8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f273d5e5fa0 RCX: 00007f273d38f749
RDX: 0000000000000000 RSI: 0000000000006609 RDI: 0000000000000005
RBP: 00007f273d413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f273d5e5fa0 R14: 00007f273d5e5fa0 R15: 0000000000000002
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

