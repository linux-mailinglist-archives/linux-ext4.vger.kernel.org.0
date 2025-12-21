Return-Path: <linux-ext4+bounces-12457-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E5CD4407
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Dec 2025 19:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAD9B3003062
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Dec 2025 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2BD2475D0;
	Sun, 21 Dec 2025 18:39:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FD7FBA2
	for <linux-ext4@vger.kernel.org>; Sun, 21 Dec 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342373; cv=none; b=fiDFc8oGIStZQGRSpDeWh4hgsH0nr1nVx+rHxhmDAJFQEfLdxUKbaYHEM+ayffD5tr3IFLavWVQoOFtd73Wb8E4D8tTJbt4fZVLPAw+EUpVhA1uZbqrcEuxn2f2DW5imu8eHZpHsLMn2WlScTte0dznfHYp8LsZelkJ8ZaTtwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342373; c=relaxed/simple;
	bh=sgjxtXBhXSGRjcB+ELfHI47QJ+pReJPnFncNpYLH0eg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NnGwWiotSlTlhRzPTbX+2OUQSCSVoGgKp4aKLau1PYZSRPhEqhpESvag+ckF4QoIyxdBnAP8/n+VrIobEpdCaoFVgQOdHWmyE6+SNE/tElflUOlYSuHR27J7u3Y9JTqnwBSqG0o6nNOaaOHS6qJ5sxZzLUurMeJjeI2qy/ARisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65d12f446c2so4026051eaf.1
        for <linux-ext4@vger.kernel.org>; Sun, 21 Dec 2025 10:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766342371; x=1766947171;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMJJY+abtCtimm8CRJ4K6IUp2xD91YNTXJn30uWiyfk=;
        b=irC2pqlhzodMpsJIDXKICXUHBkt1k8qjTqOYjXjUi69n7LFDv1UwHlRwYdYxNAyCd/
         QzLycRUetPrLOTSR/FldE7zaEPdKdpYsyUxyROjuRvZ2AxrYcE9WSrscJRHtMXzOtP5w
         tRIQciZmQ33+AXgKfK+7AQApkWA7o858nYi5Hbm5RxrFlYP4jZoQwrg7eBrpdT9JLJ6A
         eDk8rVGBAw6YH28GtvAJPi9+76H5n+frWE0ekPfj1q27DhsBEUHH8wihdC6YnvkHWuRw
         /8CYjtiM8b/Kmjq7hczapxfcoejAhyTXRXNMpYxuPZ11ameayBLQN1I+9tvYRVdJlL33
         MtHg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4QU3HI1JZTP2bLAfyIWwqeh7/UGc7ByplKqrvv3lHeNuNbhAvrD0MNEqSlbOD6jb7lDvdk0kq4S2@vger.kernel.org
X-Gm-Message-State: AOJu0YylKIHZ4B2fu3t5H0EN+CdHdgDWrG2gLJQzmsddGMual6b0Eo9Y
	m3S+EZY+SZEfAhApeo/2SjGb4Ys7oxfjaRFj35BCnzu68889QlyjjP/UMcOhjPpM0aLoCz3/JZ3
	e+eT/SnHaC9KkuOptQ31yiqhO0pRG5cTMYrWkVWT7BsRYwowhSTaqhl5BqRU=
X-Google-Smtp-Source: AGHT+IGua4gla1I3yfajWDxv91DFvMkf4oysBAzpVfHQbxqk4hSVt/4212pFUlV3k118fc6/ckRetJjhLe0sQlPEN+HCjnH9kh7D
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4883:b0:65d:1ec0:300e with SMTP id
 006d021491bc7-65d1ec035cbmr1705606eaf.58.1766342370976; Sun, 21 Dec 2025
 10:39:30 -0800 (PST)
Date: Sun, 21 Dec 2025 10:39:30 -0800
In-Reply-To: <691591fd.a70a0220.3124cb.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69483ee2.a70a0220.25eec0.0075.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (7)
From: syzbot <syzbot+f0b58a1f5075a90dd9a5@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9094662f6707 Merge tag 'ata-6.19-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f35b1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=f0b58a1f5075a90dd9a5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14439392580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d7ab1a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1fb62303749d/disk-9094662f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4c24905e5fb/vmlinux-9094662f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/791494b6840b/bzImage-9094662f.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/43239235f79e/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10439392580000)
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/5757d87bd66a/mount_1.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=16d7ab1a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0b58a1f5075a90dd9a5@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 128
EXT4-fs (loop0): mounted filesystem 76b65be2-f6da-4727-8c75-0525a5b65a09 r/w without journal. Quota mode: writeback.
ext4 filesystem being mounted at /2/file1 supports timestamps until 2038-01-19 (0x7fffffff)
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.19/5970 is trying to acquire lock:
ffff888059addff8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
ffff888059addff8 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2371

but task is already holding lock:
ffff888034378c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1832 [inline]
ffff888034378c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_read_internal+0x48/0x1d0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1820 [inline]
       ext4_writepages+0x1ca/0x350 fs/ext4/inode.c:3025
       do_writepages+0x32e/0x550 mm/page-writeback.c:2598
       __writeback_single_inode+0x133/0x1240 fs/fs-writeback.c:1737
       writeback_single_inode+0x488/0xd60 fs/fs-writeback.c:1858
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
       ext4_fill_super+0x58ad/0x6170 fs/ext4/super.c:5777
       get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
       vfs_get_tree+0x92/0x2a0 fs/super.c:1751
       fc_mount fs/namespace.c:1199 [inline]
       do_new_mount_fc fs/namespace.c:3636 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3712
       do_mount fs/namespace.c:4035 [inline]
       __do_sys_mount fs/namespace.c:4224 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4201
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2371
       ext4_initxattrs+0x9f/0x110 fs/ext4/xattr_security.c:44
       security_inode_init_security+0x290/0x3d0 security/security.c:1344
       __ext4_new_inode+0x32f7/0x3c90 fs/ext4/ialloc.c:1324
       ext4_ext_migrate+0x69f/0x1010 fs/ext4/migrate.c:456
       __ext4_ioctl fs/ext4/ioctl.c:1688 [inline]
       ext4_ioctl+0x2053/0x4770 fs/ext4/ioctl.c:1917
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_writepages_rwsem);
                               lock(&ei->xattr_sem);
                               lock(&sbi->s_writepages_rwsem);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz.0.19/5970:
 #0: ffff88803cf08480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0x63/0x210 fs/namespace.c:543
 #1: ffff888059afb450 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #1: ffff888059afb450 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: __ext4_ioctl fs/ext4/ioctl.c:1687 [inline]
 #1: ffff888059afb450 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: ext4_ioctl+0x204b/0x4770 fs/ext4/ioctl.c:1917
 #2: ffff888034378c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1832 [inline]
 #2: ffff888034378c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

stack backtrace:
CPU: 1 UID: 0 PID: 5970 Comm: syz.0.19 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
 ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
 ext4_xattr_set_handle+0x165/0x1590 fs/ext4/xattr.c:2371
 ext4_initxattrs+0x9f/0x110 fs/ext4/xattr_security.c:44
 security_inode_init_security+0x290/0x3d0 security/security.c:1344
 __ext4_new_inode+0x32f7/0x3c90 fs/ext4/ialloc.c:1324
 ext4_ext_migrate+0x69f/0x1010 fs/ext4/migrate.c:456
 __ext4_ioctl fs/ext4/ioctl.c:1688 [inline]
 ext4_ioctl+0x2053/0x4770 fs/ext4/ioctl.c:1917
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xff/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f125b9bf749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2fb97128 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f125bc15fa0 RCX: 00007f125b9bf749
RDX: 0000000000000000 RSI: 0000000000006609 RDI: 0000000000000005
RBP: 00007f125ba43f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f125bc15fa0 R14: 00007f125bc15fa0 R15: 0000000000000002
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

