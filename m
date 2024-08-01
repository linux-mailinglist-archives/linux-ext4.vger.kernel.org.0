Return-Path: <linux-ext4+bounces-3595-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4E944E2F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C1B1C20F62
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BCC1A4F38;
	Thu,  1 Aug 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="rIjEeupL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3F189B98
	for <linux-ext4@vger.kernel.org>; Thu,  1 Aug 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523149; cv=none; b=iqhZVCvcbzdAVYBzPF1118YDXdnP2yWOaia9jHOMhaHbX5c37S/nVKFgK+859AkKfcKsb4yJQ0akKmJbjIzk1WqQMETGwZae3SehBMNF3gmwCQUJ+Lyq9nuQUs6Neo0uQkKpZcFNKki8sSs5RluG4jEXRspV5jX13bgo7PuFukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523149; c=relaxed/simple;
	bh=cxb0uqdh31axH/cKN4VDKaqd5OG9AK2gmKD/3foMa5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oS7m1jsdmgDxZGKDX1Wm6VHKHtd9aEJXqEW/zRuYh0smEvEn5eixDzY1FP0ElapWa1+kXkjhiFWBqRmSzedl1VJLK/MK17IliyP3mTo1nQGaCfp6GWGOPrdrg8QGpmxSVDYn0cx70m+B863egISvTx18jdWj+URcatXuHmxQiQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=rIjEeupL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so600950866b.1
        for <linux-ext4@vger.kernel.org>; Thu, 01 Aug 2024 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1722523145; x=1723127945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HG2f4Kd2K4/9MIJAaucwbOj4OuPoS6yz1qIeQtu+inU=;
        b=rIjEeupLHv9fwX9pMGgxpsAo5iYm5CpvnKReQFpZpZOk2xx6et2L/21v6sxRbJmzrB
         JnN3IxW1GXk9zyIuB7zpNGhAY6FNNEGMPlbOqN31SwEXNI+GBKltHk0BPkXTgJj2ANGt
         K1iojNMjFHfRyYcWH3xNeVEFh7uIQT0iWH5thvYzStads7nUbg3UaYniDcV2TqRDrfMe
         lXsLS/ltQtDvOhkYo0GZSHiUgdnIU2uxyeFPGcgK539Q9N4TGBShnAFIOiOt1l1lodsl
         TzHZUiwaJwp9mej0dwUKnwx+TMcXtnLU5Et3+ZJ7UH8rHo60dfsrfaccfVHzvws790KM
         L04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523145; x=1723127945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG2f4Kd2K4/9MIJAaucwbOj4OuPoS6yz1qIeQtu+inU=;
        b=fFEfd1tos5HkioYXXV1ACifr0O6yNJ6sJKfWeXZOwoxD18Ld3bMVH7lBW6osh8smPs
         TPD4AbJUAg2lz9GT1JiN1ejVRDV8yIfQcjz/iR+xt8ieNaXA4Vvs1+Dt8MVt5L+Uhst3
         DQA3NSYHDIrPloxC/qcfJpmRUtHBAx526BukyBCU++HViuVHcleeeTgh7spqYHPC4qJ1
         nMqNWS2pDI0qSy557TUAcwhgGC0tD/n9pv/vHpE1HaQd8xgwoU+fABDbxME3nxlJ/zcl
         opx0KPGOJciUe2BB6durAkgq4U9a5HMC5I783aDgZD4jPiCR7Qj+c8FQf07VdLM+owyp
         Lgmw==
X-Forwarded-Encrypted: i=1; AJvYcCUQLaL2mNK4b+klsGr2oK4E71YEikfVUbrv/tTvnX7fxLs4Chh6WIE9McMonvtKRSyt6Ou2XxyfXjpj9QHhz7dggJ1aLefnStRPFg==
X-Gm-Message-State: AOJu0Yw91jXJT/M9jhH0PpwpstzPJrz3cj0enEoRy5iLEFyn6pKRxLKH
	FKGplN0oo7rniARWhkbJ/xwDASvm4hfRiBovV674YwrLx7qYp0fl8G8E2lcPJfmzdWNwG7eHzjM
	gE/Y=
X-Google-Smtp-Source: AGHT+IEYU+xzrcCJWLNpoBtj9pA19ybmUUKWgMMJqzDfViG3QzROmIlMFS1nzgzWerpKk2VDCIaW7g==
X-Received: by 2002:a17:907:d86:b0:a7a:a30b:7b94 with SMTP id a640c23a62f3a-a7dc4fa95ccmr32488266b.28.1722523144746;
        Thu, 01 Aug 2024 07:39:04 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-3-137.dynamic.gprs.plus.pl. [31.0.3.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad418f1sm902067666b.135.2024.08.01.07.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:39:04 -0700 (PDT)
From: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Subject: [PATCH] kernel/ext4: nested locking for xattr inode
Date: Thu,  1 Aug 2024 16:38:27 +0200
Message-Id: <20240801143827.19135-1-wojciech.gladysz@infogain.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 fs/ext4/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..a6bc9a22a8af 100644
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
2.35.3


