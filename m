Return-Path: <linux-ext4+bounces-11702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B01C42D4B
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 14:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C64E2680
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A521A3166;
	Sat,  8 Nov 2025 13:32:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681628E5
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762608750; cv=none; b=VS2cTZReItO+R+zCE1xD1TWkjV/jKO8cPC5RLt8CkyHBmZHhFhq7DapBYQ0iKj1zXl9LmyYLl6vq2EkBGWweaQS7E9R1kIlf1bL5YOVc5HwE12JS14b+Vi+y/ZLTE39B1oqflIqTNu/aCe1h7mx9gAhmoML5lSrvFe6IFT5/q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762608750; c=relaxed/simple;
	bh=tvyPpx2oKJCgMZ0OCvlfNSNK2yNzIZpotW4gFJ2ZgAA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kKU7ko/EQzelp0HIy+frqMsNV7qB3gjE6FB2MXb9NPBat8O9/V8enC8SEKPzYIT+wlwLtIbmUPd+T13mJXA2ahFaQmL3jZO4YB03i4bUyF6phGXG5ySEzQGLd+TnsyZXli7d9dAu24Ht5Mk26vsknKhaig1zMtqU4Ag27TdBjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-43322b98837so17941985ab.2
        for <linux-ext4@vger.kernel.org>; Sat, 08 Nov 2025 05:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762608748; x=1763213548;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrV43ErWe+VCsj3PED4WP6R1zksVrZQcOrd5/ODDNBY=;
        b=cW7vB9kSNtKnRC7v1offj/1FIeSlSwd2Ake1e4fz0vaFn74YbmfBo1hajNiGIXfcg2
         eMVZLy/NSGyqI7zZu5N7JoLcJuwpSg62FryGC9YDtxznifkUpvkp4cYOfYuO4qf3GOxx
         spI0gPr2KwrpEiIO3nFMFu7IaLvfGj/FfUiLAfclRnvYS+mdsIFE44U/xUn3eebUOJdR
         Xic2xOFdTG3Qat7897z1sxvRdkXXj40EKEffZ8AQj1TYykZvV8wneOjKfzTfqkLM684q
         R8KXtT0hCfmtITn/d9HZ6uDzWpIc6nidnZH7vZcN6N1EMH39cBld3bo6c4jrAGleE9LL
         AqBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWPbnXyNBLk/GLM6lY9p38+EZCst979eIWzekEIFTTIrEeIIJixLhpTjhQ/yR5i2BjB4AFDpxrOL29@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7O1bkTz78bDrIefrWZeGerOvJ8Y8gk784JK4xlx0TXGMs5F3O
	x+/uKbPLKzoitlDvx8nLYkVg41h4otaOKKJEJ1phI2ojp/Cft+4lyrF1LV6WA/1fw2I6Z6lMBQm
	oCUP/2aCyYAepoFXDrX/2BWB6+xBbaP32x1zd/zsOB8oTJiyVysT05N9DPAM=
X-Google-Smtp-Source: AGHT+IFb7G/aUo9IE5T/xFX1bwdFxBnGo66gqhmbGtcL2NZyA5TwvSnqsfDL6uv1af+6Sfc2/0Pnd97OgqL+feEqGu8y5oEPyo4z
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce85:0:b0:433:68ab:e2a with SMTP id
 e9e14a558f8ab-43368ab0ee1mr25840965ab.23.1762608747790; Sat, 08 Nov 2025
 05:32:27 -0800 (PST)
Date: Sat, 08 Nov 2025 05:32:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690f466b.a70a0220.22f260.0081.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_get (2)
From: syzbot <syzbot+5b61c1d24f8022b26f7d@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bb886cb8f3a Merge tag 'edac_urgent_for_v6.18_rc5' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ea2532580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=5b61c1d24f8022b26f7d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/addfade563b0/disk-8bb886cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1254c89ad16b/vmlinux-8bb886cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3123c5319b7e/bzImage-8bb886cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b61c1d24f8022b26f7d@syzkaller.appspotmail.com

ext4 filesystem being mounted at /86/bus supports timestamps until 2038-01-19 (0x7fffffff)
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.5.1778/13399 is trying to acquire lock:
ffff888047d9ba28 (&ei->xattr_sem){++++}-{4:4}, at: ext4_xattr_get+0x10a/0x6a0 fs/ext4/xattr.c:708

but task is already holding lock:
ffff88807a168b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1808 [inline]
ffff88807a168b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       percpu_down_read_internal+0x48/0x1c0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1796 [inline]
       ext4_writepages+0x1cc/0x350 fs/ext4/inode.c:3024
       do_writepages+0x32e/0x550 mm/page-writeback.c:2604
       __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1719
       writeback_single_inode+0x1f9/0x6a0 fs/fs-writeback.c:1840
       write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2903
       iput_final fs/inode.c:1901 [inline]
       iput+0x830/0xc50 fs/inode.c:1966
       ext4_xattr_block_set+0x1fce/0x2ac0 fs/ext4/xattr.c:2199
       ext4_xattr_move_to_block fs/ext4/xattr.c:2664 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2739 [inline]
       ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2827
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6364
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6407 [inline]
       __ext4_mark_inode_dirty+0x46c/0x700 fs/ext4/inode.c:6485
       ext4_evict_inode+0x80d/0xee0 fs/ext4/inode.c:254
       evict+0x504/0x9c0 fs/inode.c:810
       ext4_orphan_cleanup+0xc20/0x1460 fs/ext4/orphan.c:470
       __ext4_fill_super fs/ext4/super.c:5617 [inline]
       ext4_fill_super+0x5920/0x61e0 fs/ext4/super.c:5736
       get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1691
       vfs_get_tree+0x92/0x2b0 fs/super.c:1751
       fc_mount fs/namespace.c:1208 [inline]
       do_new_mount_fc fs/namespace.c:3651 [inline]
       do_new_mount+0x302/0xa10 fs/namespace.c:3727
       do_mount fs/namespace.c:4050 [inline]
       __do_sys_mount fs/namespace.c:4238 [inline]
       __se_sys_mount+0x313/0x410 fs/namespace.c:4215
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_read+0x46/0x2e0 kernel/locking/rwsem.c:1537
       ext4_xattr_get+0x10a/0x6a0 fs/ext4/xattr.c:708
       ext4_get_acl+0x84/0x930 fs/ext4/acl.c:165
       __get_acl+0x279/0x400 fs/posix_acl.c:159
       get_inode_acl fs/posix_acl.c:184 [inline]
       posix_acl_create+0x131/0x440 fs/posix_acl.c:646
       ext4_init_acl+0xb3/0x320 fs/ext4/acl.c:284
       __ext4_new_inode+0x3218/0x3cb0 fs/ext4/ialloc.c:1321
       ext4_ext_migrate+0x69f/0x1010 fs/ext4/migrate.c:456
       __ext4_ioctl fs/ext4/ioctl.c:1694 [inline]
       ext4_ioctl+0x204b/0x48e0 fs/ext4/ioctl.c:1923
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sbi->s_writepages_rwsem);
                               lock(&ei->xattr_sem);
                               lock(&sbi->s_writepages_rwsem);
  rlock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz.5.1778/13399:
 #0: ffff88807a16a420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write_file+0x60/0x200 fs/namespace.c:552
 #1: ffff888047d9c6d0 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #1: ffff888047d9c6d0 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: __ext4_ioctl fs/ext4/ioctl.c:1693 [inline]
 #1: ffff888047d9c6d0 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: ext4_ioctl+0x2043/0x48e0 fs/ext4/ioctl.c:1923
 #2: ffff88807a168b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1808 [inline]
 #2: ffff88807a168b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x2f3/0x1010 fs/ext4/migrate.c:438

stack backtrace:
CPU: 0 UID: 0 PID: 13399 Comm: syz.5.1778 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
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
 ext4_xattr_get+0x10a/0x6a0 fs/ext4/xattr.c:708
 ext4_get_acl+0x84/0x930 fs/ext4/acl.c:165
 __get_acl+0x279/0x400 fs/posix_acl.c:159
 get_inode_acl fs/posix_acl.c:184 [inline]
 posix_acl_create+0x131/0x440 fs/posix_acl.c:646
 ext4_init_acl+0xb3/0x320 fs/ext4/acl.c:284
 __ext4_new_inode+0x3218/0x3cb0 fs/ext4/ialloc.c:1321
 ext4_ext_migrate+0x69f/0x1010 fs/ext4/migrate.c:456
 __ext4_ioctl fs/ext4/ioctl.c:1694 [inline]
 ext4_ioctl+0x204b/0x48e0 fs/ext4/ioctl.c:1923
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f33aa18f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f33ab026038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f33aa3e5fa0 RCX: 00007f33aa18f6c9
RDX: 0000000000000000 RSI: 0000000000006609 RDI: 0000000000000006
RBP: 00007f33aa211f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f33aa3e6038 R14: 00007f33aa3e5fa0 R15: 00007ffcf65b20e8
 </TASK>
EXT4-fs error (device loop5): ext4_lookup:1787: inode #12: comm syz.5.1778: iget: bad i_size value: 2533274857506816
EXT4-fs error (device loop5): ext4_lookup:1787: inode #12: comm syz.5.1778: iget: bad i_size value: 2533274857506816


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

