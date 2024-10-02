Return-Path: <linux-ext4+bounces-4438-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFC98D068
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 11:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6727E1C214A2
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2024 09:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD71E1A3F;
	Wed,  2 Oct 2024 09:48:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5012C49C
	for <linux-ext4@vger.kernel.org>; Wed,  2 Oct 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862505; cv=none; b=aWyRivLsyazPnu5EABwv5p8bFSGNQR5zRvDtpaxjIcab7HlEphPOfj+ikXu0Y6dz+vqm6GfxTkvKg51f1dIT7XO0y2lgIbpA2IWD7ddU5ZkRc+uN2qn/QVxvc8d+wIS2voEYLIDmAfjCYkE/GH8014YEw5TAZtL6auNyYaVP0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862505; c=relaxed/simple;
	bh=WXgY6WBdZL2BcL1HNThvdvjW9Iy2qB2Qu2vVp2/3ocw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dmM7QBQfFZdXZ7M8/xT+oP71bxfEHujHt3uHXVAtZc09qbbJt0g6d7iJzim5tMWJFkaDjSDydqGzbrAlQo793/vqTap0mWmt5Mx4+mh37I4j+aNaMG5pN0DzsP2QedrFjqGVOBlcITrVY8Pa40gEjiFPque3VXYwEPDSVoY9kUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso96488545ab.2
        for <linux-ext4@vger.kernel.org>; Wed, 02 Oct 2024 02:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862503; x=1728467303;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoAkR/Jgqq0X80W/ie3mehkK7240qeSZLyQLHMFJshg=;
        b=uem/7giK/QUMVpN0eL/vhGnKs6B3vkdfq4BbD0kDOt/nb3indrJFFeJOaZTipxtphr
         9P6SiaKFiJSKIk2UaYet77VUYO4JeG6chSxFeeAub1q1YaGWFfNjb5UhvXmTHiueGPFM
         +CFhQxWL9bOoD69/QHujm68DS7sH341Y6tTkkK70a/cmeby8sdIBSa16iMvCJi4SIAfA
         SoP9az09LBhr3jFItXrCVO+kw7B6rS84t1V6BftGdzIcjaYDBM6ATZkhs+A/DhWQF5bd
         ay1q8z04SEUGWNl082lqydKuliw0ZHCm1+FZw8LHRXfRGjm/Ct2UH5vOHC5NGqhVoesG
         +ZCg==
X-Forwarded-Encrypted: i=1; AJvYcCX0iG+tGs+EDRBtAPE/28vDQv8h33p+RrgWLAxGe5R+vMCGp9+/q3VzHr9sXRwj8CsxA89gSpj88F+O@vger.kernel.org
X-Gm-Message-State: AOJu0YzaE8is0sdaCEc+Lrw0buy9slzMZO8HSTP1yXWLMEN+ldTbN4KX
	YiBVxtyFaAbX3lV2Vzxefo3pwrcgM4H7YbBtpPK4BYnQ0ReFf/BgHB3Pq18UW+LOXaKikKtZie1
	UN5XKxNrD4cVj8NMqhLn85XGSJD3+qNLbyN5MeS9+GMjBbFaYoVIt7vs=
X-Google-Smtp-Source: AGHT+IHdU5rnsPYUDxwrHi7T0vhJarmkG+8lDxfsdBet2Hj98BI+jO9qK3zcMHT7C06BD8ds501VntH603DdP9P9BeCy2ZoomAqZ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e4:b0:3a0:9238:d38 with SMTP id
 e9e14a558f8ab-3a36591c74fmr24532105ab.10.1727862503231; Wed, 02 Oct 2024
 02:48:23 -0700 (PDT)
Date: Wed, 02 Oct 2024 02:48:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fd16e7.050a0220.f28ec.0505.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (6)
From: syzbot <syzbot+f5fadcee2108d2f0dd2d@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a6e927980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8445583625becf41
dashboard link: https://syzkaller.appspot.com/bug?extid=f5fadcee2108d2f0dd2d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a8ab0519b64e/disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f86df70153a/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93df43d11421/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5fadcee2108d2f0dd2d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0 Not tainted
------------------------------------------------------
syz.0.2834/27060 is trying to acquire lock:
ffff888078f3e3d8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
ffff888078f3e3d8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x159/0x1420 fs/ext4/xattr.c:2373

but task is already holding lock:
ffff88807dde6958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (jbd2_handle){++++}-{0:0}:
       start_this_handle+0xf92/0x1430 fs/jbd2/transaction.c:448
       jbd2__journal_start+0x394/0x6a0 fs/jbd2/transaction.c:505
       jbd2_journal_start+0x29/0x40 fs/jbd2/transaction.c:544
       ocfs2_start_trans+0x3b9/0x970 fs/ocfs2/journal.c:352
       ocfs2_modify_bh+0xbe/0x490 fs/ocfs2/quota_local.c:101
       ocfs2_local_read_info+0xd68/0x1610 fs/ocfs2/quota_local.c:771
       dquot_load_quota_sb+0x83d/0x1050 fs/quota/dquot.c:2458
       dquot_load_quota_inode fs/quota/dquot.c:2495 [inline]
       dquot_load_quota_inode+0x2a3/0x470 fs/quota/dquot.c:2487
       ocfs2_enable_quotas+0x28b/0x5a0 fs/ocfs2/super.c:926
       ocfs2_fill_super+0x23b4/0x4340 fs/ocfs2/super.c:1141
       mount_bdev+0x1e6/0x2d0 fs/super.c:1679
       legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
       vfs_get_tree+0x92/0x380 fs/super.c:1800
       do_new_mount fs/namespace.c:3507 [inline]
       path_mount+0x14e6/0x1f20 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4055 [inline]
       __se_sys_mount fs/namespace.c:4032 [inline]
       __x64_sys_mount+0x294/0x320 fs/namespace.c:4032
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&journal->j_trans_barrier){.+.+}-{3:3}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       ocfs2_start_trans+0x3ae/0x970 fs/ocfs2/journal.c:350
       ocfs2_modify_bh+0xbe/0x490 fs/ocfs2/quota_local.c:101
       ocfs2_local_read_info+0xd68/0x1610 fs/ocfs2/quota_local.c:771
       dquot_load_quota_sb+0x83d/0x1050 fs/quota/dquot.c:2458
       dquot_load_quota_inode fs/quota/dquot.c:2495 [inline]
       dquot_load_quota_inode+0x2a3/0x470 fs/quota/dquot.c:2487
       ocfs2_enable_quotas+0x28b/0x5a0 fs/ocfs2/super.c:926
       ocfs2_fill_super+0x23b4/0x4340 fs/ocfs2/super.c:1141
       mount_bdev+0x1e6/0x2d0 fs/super.c:1679
       legacy_get_tree+0x10c/0x220 fs/fs_context.c:662
       vfs_get_tree+0x92/0x380 fs/super.c:1800
       do_new_mount fs/namespace.c:3507 [inline]
       path_mount+0x14e6/0x1f20 fs/namespace.c:3834
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4055 [inline]
       __se_sys_mount fs/namespace.c:4032 [inline]
       __x64_sys_mount+0x294/0x320 fs/namespace.c:4032
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (sb_internal#5){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1716 [inline]
       sb_start_intwrite include/linux/fs.h:1899 [inline]
       ocfs2_start_trans+0x29d/0x970 fs/ocfs2/journal.c:348
       ocfs2_acquire_dquot+0x566/0xaf0 fs/ocfs2/quota_global.c:855
       dqget+0x694/0x1160 fs/quota/dquot.c:976
       __dquot_initialize+0x588/0xd50 fs/quota/dquot.c:1504
       ocfs2_get_init_inode+0xe8/0x1a0 fs/ocfs2/namei.c:202
       ocfs2_symlink+0xbae/0x3a00 fs/ocfs2/namei.c:1886
       vfs_symlink fs/namei.c:4615 [inline]
       vfs_symlink+0x3eb/0x660 fs/namei.c:4599
       do_symlinkat+0x263/0x310 fs/namei.c:4641
       __do_sys_symlink fs/namei.c:4662 [inline]
       __se_sys_symlink fs/namei.c:4660 [inline]
       __x64_sys_symlink+0x75/0x90 fs/namei.c:4660
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&ocfs2_quota_ip_alloc_sem_key){++++}-{3:3}:
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       ocfs2_create_local_dquot+0x158/0xb40 fs/ocfs2/quota_local.c:1231
       ocfs2_acquire_dquot+0x629/0xaf0 fs/ocfs2/quota_global.c:878
       dqget+0x694/0x1160 fs/quota/dquot.c:976
       __dquot_initialize+0x588/0xd50 fs/quota/dquot.c:1504
       ocfs2_get_init_inode+0xe8/0x1a0 fs/ocfs2/namei.c:202
       ocfs2_symlink+0xbae/0x3a00 fs/ocfs2/namei.c:1886
       vfs_symlink fs/namei.c:4615 [inline]
       vfs_symlink+0x3eb/0x660 fs/namei.c:4599
       do_symlinkat+0x263/0x310 fs/namei.c:4641
       __do_sys_symlink fs/namei.c:4662 [inline]
       __se_sys_symlink fs/namei.c:4660 [inline]
       __x64_sys_symlink+0x75/0x90 fs/namei.c:4660
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&dquot->dq_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       wait_on_dquot fs/quota/dquot.c:355 [inline]
       dqget+0x5f2/0x1160 fs/quota/dquot.c:971
       dquot_transfer+0x531/0x6a0 fs/quota/dquot.c:2153
       ext4_setattr+0x80b/0x2900 fs/ext4/inode.c:5368
       notify_change+0x6a9/0x1230 fs/attr.c:503
       chown_common+0x538/0x670 fs/open.c:793
       do_fchownat+0x1ac/0x200 fs/open.c:824
       __do_sys_fchownat fs/open.c:839 [inline]
       __se_sys_fchownat fs/open.c:836 [inline]
       __x64_sys_fchownat+0xbd/0x160 fs/open.c:836
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ei->xattr_sem){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       down_write+0x93/0x200 kernel/locking/rwsem.c:1577
       ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
       ext4_xattr_set_handle+0x159/0x1420 fs/ext4/xattr.c:2373
       __ext4_set_acl+0x366/0x5d0 fs/ext4/acl.c:217
       ext4_set_acl+0x3f9/0x5a0 fs/ext4/acl.c:259
       set_posix_acl+0x25f/0x320 fs/posix_acl.c:955
       vfs_set_acl+0x5ab/0x920 fs/posix_acl.c:1134
       do_set_acl+0xd9/0x1a0 fs/posix_acl.c:1279
       do_setxattr+0xeb/0x170 fs/xattr.c:626
       __do_sys_fsetxattr+0x2e4/0x350 fs/xattr.c:710
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ei->xattr_sem --> &journal->j_trans_barrier --> jbd2_handle

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(jbd2_handle);
                               lock(&journal->j_trans_barrier);
                               lock(jbd2_handle);
  lock(&ei->xattr_sem);

 *** DEADLOCK ***

3 locks held by syz.0.2834/27060:
 #0: ffff88807dde2420 (sb_writers#4){.+.+}-{0:0}, at: __do_sys_fsetxattr+0x230/0x350 fs/xattr.c:708
 #1: ffff888078f3e708 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff888078f3e708 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_set_acl+0x342/0x920 fs/posix_acl.c:1115
 #2: ffff88807dde6958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf6c/0x1430 fs/jbd2/transaction.c:448

stack backtrace:
CPU: 0 UID: 0 PID: 27060 Comm: syz.0.2834 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 down_write+0x93/0x200 kernel/locking/rwsem.c:1577
 ext4_write_lock_xattr fs/ext4/xattr.h:154 [inline]
 ext4_xattr_set_handle+0x159/0x1420 fs/ext4/xattr.c:2373
 __ext4_set_acl+0x366/0x5d0 fs/ext4/acl.c:217
 ext4_set_acl+0x3f9/0x5a0 fs/ext4/acl.c:259
 set_posix_acl+0x25f/0x320 fs/posix_acl.c:955
 vfs_set_acl+0x5ab/0x920 fs/posix_acl.c:1134
 do_set_acl+0xd9/0x1a0 fs/posix_acl.c:1279
 do_setxattr+0xeb/0x170 fs/xattr.c:626
 __do_sys_fsetxattr+0x2e4/0x350 fs/xattr.c:710
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbfbb57dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbfbc37e038 EFLAGS: 00000246 ORIG_RAX: 00000000000000be
RAX: ffffffffffffffda RBX: 00007fbfbb736130 RCX: 00007fbfbb57dff9
RDX: 0000000020000500 RSI: 0000000020000100 RDI: 0000000000000007
RBP: 00007fbfbb5f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000002c R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbfbb736130 R15: 00007ffdf99196e8
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

