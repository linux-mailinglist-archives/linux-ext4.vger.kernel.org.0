Return-Path: <linux-ext4+bounces-4479-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648BA990B1A
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 20:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2259A2819E4
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB6A21BB14;
	Fri,  4 Oct 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex6clfrX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31721BB06;
	Fri,  4 Oct 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065937; cv=none; b=XmC432twABoZWBkrkjQSDW1mMPhFubAWXyPLhVzqjXEEa/oOcjnwnR6bjvmVWw67ZfIUrHWVKTHZuBPEmNXcRKxs2AXyP6cyMTSVTLpNzlaHQwrT35PItkuuz9c4sgexTznAwYZXMoi/xAwSXWZ1bBbOV5WieIUnA0adKw0ZUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065937; c=relaxed/simple;
	bh=qV10pYNv7syiV6tMPKAsmwgbw/vRDmoYrfNdxL/g03A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZVEdCYiDoXZjtlpfrArY8Ca98BzjsN4RPp0Rlu2woUSIolF7wxHrrEreGAQgyW379R9EHuMVVz2bhqksi6jD8OPqWNeU+D6rxfq3PXYo2gvpy/5Pl3gd9pw50E0WiXeVXN3jQ2W+bSUBdkSnE8dJomZO5ABPjaUts4FDU22XU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex6clfrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16024C4CEC6;
	Fri,  4 Oct 2024 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065936;
	bh=qV10pYNv7syiV6tMPKAsmwgbw/vRDmoYrfNdxL/g03A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ex6clfrXDnVpJ/rvisZaIrJqT/IEybRPSzzbxzPwSJo5wZFUZSK05YUwxG8e2o6po
	 Q1ihFF2n06n6ZbCJnFjZPVX6TIhqoBcTptn+JvCkGKhyA6K7VUaru6p26KGD/XRWAs
	 yMiG4oUUKUxGDWp58R4sCLnu7bNkkdpTcWloU+Erh9tXkc/NkpdU2K2b3bYqSk7BV3
	 uLlSwD9muWGw0vlGveww1ljjQuuk9SkkaRQNGz1CSqr524ruH9MDk1q8U5MlOmsv1c
	 g/mKtWlFwJsr4rkC6dvgxGYwMBvAfGgWr+Kzv7AE/NAtW9BNcz3iwjRXxcjJDD8v/0
	 oB8s62XCBb4nw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 16/76] ext4: nested locking for xattr inode
Date: Fri,  4 Oct 2024 14:16:33 -0400
Message-ID: <20241004181828.3669209-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Wojciech Gładysz <wojciech.gladysz@infogain.com>

[ Upstream commit d1bc560e9a9c78d0b2314692847fc8661e0aeb99 ]

Add nested locking with I_MUTEX_XATTR subclass to avoid lockdep warning
while handling xattr inode on file open syscall at ext4_xattr_inode_iget.

Backtrace
EXT4-fs (loop0): Ignoring removed oldalloc option
======================================================
WARNING: possible circular locking dependency detected
5.10.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor543/2794 is trying to acquire lock:
ffff8880215e1a48 (&ea_inode->i_rwsem#7/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:782 [inline]
ffff8880215e1a48 (&ea_inode->i_rwsem#7/1){+.+.}-{3:3}, at: ext4_xattr_inode_iget+0x42a/0x5c0 fs/ext4/xattr.c:425

but task is already holding lock:
ffff8880215e3278 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x136d/0x19c0 fs/ext4/inode.c:5559

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem/3){++++}-{3:3}:
       lock_acquire+0x197/0x480 kernel/locking/lockdep.c:5566
       down_write+0x93/0x180 kernel/locking/rwsem.c:1564
       ext4_update_i_disksize fs/ext4/ext4.h:3267 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1390 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1538 [inline]
       ext4_xattr_set_entry+0x331a/0x3d80 fs/ext4/xattr.c:1662
       ext4_xattr_ibody_set+0x124/0x390 fs/ext4/xattr.c:2228
       ext4_xattr_set_handle+0xc27/0x14e0 fs/ext4/xattr.c:2385
       ext4_xattr_set+0x219/0x390 fs/ext4/xattr.c:2498
       ext4_xattr_user_set+0xc9/0xf0 fs/ext4/xattr_user.c:40
       __vfs_setxattr+0x404/0x450 fs/xattr.c:177
       __vfs_setxattr_noperm+0x11d/0x4f0 fs/xattr.c:208
       __vfs_setxattr_locked+0x1f9/0x210 fs/xattr.c:266
       vfs_setxattr+0x112/0x2c0 fs/xattr.c:283
       setxattr+0x1db/0x3e0 fs/xattr.c:548
       path_setxattr+0x15a/0x240 fs/xattr.c:567
       __do_sys_setxattr fs/xattr.c:582 [inline]
       __se_sys_setxattr fs/xattr.c:578 [inline]
       __x64_sys_setxattr+0xc5/0xe0 fs/xattr.c:578
       do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
       entry_SYSCALL_64_after_hwframe+0x61/0xcb

-> #0 (&ea_inode->i_rwsem#7/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2988 [inline]
       check_prevs_add kernel/locking/lockdep.c:3113 [inline]
       validate_chain+0x1695/0x58f0 kernel/locking/lockdep.c:3729
       __lock_acquire+0x12fd/0x20d0 kernel/locking/lockdep.c:4955
       lock_acquire+0x197/0x480 kernel/locking/lockdep.c:5566
       down_write+0x93/0x180 kernel/locking/rwsem.c:1564
       inode_lock include/linux/fs.h:782 [inline]
       ext4_xattr_inode_iget+0x42a/0x5c0 fs/ext4/xattr.c:425
       ext4_xattr_inode_get+0x138/0x410 fs/ext4/xattr.c:485
       ext4_xattr_move_to_block fs/ext4/xattr.c:2580 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2682 [inline]
       ext4_expand_extra_isize_ea+0xe70/0x1bb0 fs/ext4/xattr.c:2774
       __ext4_expand_extra_isize+0x304/0x3f0 fs/ext4/inode.c:5898
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5941 [inline]
       __ext4_mark_inode_dirty+0x591/0x810 fs/ext4/inode.c:6018
       ext4_setattr+0x1400/0x19c0 fs/ext4/inode.c:5562
       notify_change+0xbb6/0xe60 fs/attr.c:435
       do_truncate+0x1de/0x2c0 fs/open.c:64
       handle_truncate fs/namei.c:2970 [inline]
       do_open fs/namei.c:3311 [inline]
       path_openat+0x29f3/0x3290 fs/namei.c:3425
       do_filp_open+0x20b/0x450 fs/namei.c:3452
       do_sys_openat2+0x124/0x460 fs/open.c:1207
       do_sys_open fs/open.c:1223 [inline]
       __do_sys_open fs/open.c:1231 [inline]
       __se_sys_open fs/open.c:1227 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1227
       do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
       entry_SYSCALL_64_after_hwframe+0x61/0xcb

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/3);
                               lock(&ea_inode->i_rwsem#7/1);
                               lock(&ei->i_data_sem/3);
  lock(&ea_inode->i_rwsem#7/1);

 *** DEADLOCK ***

5 locks held by syz-executor543/2794:
 #0: ffff888026fbc448 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x4a/0x2a0 fs/namespace.c:365
 #1: ffff8880215e3488 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:782 [inline]
 #1: ffff8880215e3488 (&sb->s_type->i_mutex_key#7){++++}-{3:3}, at: do_truncate+0x1cf/0x2c0 fs/open.c:62
 #2: ffff8880215e3310 (&ei->i_mmap_sem){++++}-{3:3}, at: ext4_setattr+0xec4/0x19c0 fs/ext4/inode.c:5519
 #3: ffff8880215e3278 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x136d/0x19c0 fs/ext4/inode.c:5559
 #4: ffff8880215e30c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
 #4: ffff8880215e30c8 (&ei->xattr_sem){++++}-{3:3}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:5938 [inline]
 #4: ffff8880215e30c8 (&ei->xattr_sem){++++}-{3:3}, at: __ext4_mark_inode_dirty+0x4fb/0x810 fs/ext4/inode.c:6018

stack backtrace:
CPU: 1 PID: 2794 Comm: syz-executor543 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x177/0x211 lib/dump_stack.c:118
 print_circular_bug+0x146/0x1b0 kernel/locking/lockdep.c:2002
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2123
 check_prev_add kernel/locking/lockdep.c:2988 [inline]
 check_prevs_add kernel/locking/lockdep.c:3113 [inline]
 validate_chain+0x1695/0x58f0 kernel/locking/lockdep.c:3729
 __lock_acquire+0x12fd/0x20d0 kernel/locking/lockdep.c:4955
 lock_acquire+0x197/0x480 kernel/locking/lockdep.c:5566
 down_write+0x93/0x180 kernel/locking/rwsem.c:1564
 inode_lock include/linux/fs.h:782 [inline]
 ext4_xattr_inode_iget+0x42a/0x5c0 fs/ext4/xattr.c:425
 ext4_xattr_inode_get+0x138/0x410 fs/ext4/xattr.c:485
 ext4_xattr_move_to_block fs/ext4/xattr.c:2580 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2682 [inline]
 ext4_expand_extra_isize_ea+0xe70/0x1bb0 fs/ext4/xattr.c:2774
 __ext4_expand_extra_isize+0x304/0x3f0 fs/ext4/inode.c:5898
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5941 [inline]
 __ext4_mark_inode_dirty+0x591/0x810 fs/ext4/inode.c:6018
 ext4_setattr+0x1400/0x19c0 fs/ext4/inode.c:5562
 notify_change+0xbb6/0xe60 fs/attr.c:435
 do_truncate+0x1de/0x2c0 fs/open.c:64
 handle_truncate fs/namei.c:2970 [inline]
 do_open fs/namei.c:3311 [inline]
 path_openat+0x29f3/0x3290 fs/namei.c:3425
 do_filp_open+0x20b/0x450 fs/namei.c:3452
 do_sys_openat2+0x124/0x460 fs/open.c:1207
 do_sys_open fs/open.c:1223 [inline]
 __do_sys_open fs/open.c:1231 [inline]
 __se_sys_open fs/open.c:1227 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1227
 do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7f0cde4ea229
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd81d1c978 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0030656c69662f30 RCX: 00007f0cde4ea229
RDX: 0000000000000089 RSI: 00000000000a0a00 RDI: 00000000200001c0
RBP: 2f30656c69662f2e R08: 0000000000208000 R09: 0000000000208000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd81d1c9c0
R13: 00007ffd81d1ca00 R14: 0000000000080000 R15: 0000000000000003
EXT4-fs error (device loop0): ext4_expand_extra_isize_ea:2730: inode #13: comm syz-executor543: corrupted in-inode xattr

Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
Link: https://patch.msgid.link/20240801143827.19135-1-wojciech.gladysz@infogain.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9d..a6bc9a22a8afc 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -458,7 +458,7 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 		ext4_set_inode_state(inode, EXT4_STATE_LUSTRE_EA_INODE);
 		ext4_xattr_inode_set_ref(inode, 1);
 	} else {
-		inode_lock(inode);
+		inode_lock_nested(inode, I_MUTEX_XATTR);
 		inode->i_flags |= S_NOQUOTA;
 		inode_unlock(inode);
 	}
@@ -1039,7 +1039,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	s64 ref_count;
 	int ret;
 
-	inode_lock(ea_inode);
+	inode_lock_nested(ea_inode, I_MUTEX_XATTR);
 
 	ret = ext4_reserve_inode_write(handle, ea_inode, &iloc);
 	if (ret)
-- 
2.43.0


