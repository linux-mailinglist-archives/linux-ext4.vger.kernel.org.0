Return-Path: <linux-ext4+bounces-12043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16223C8C4B9
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Nov 2025 00:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86DB234F3FF
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Nov 2025 23:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CFB2FE566;
	Wed, 26 Nov 2025 23:09:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6766218845
	for <linux-ext4@vger.kernel.org>; Wed, 26 Nov 2025 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198572; cv=none; b=I3ToIN0XOHXbPS3ztH834WFEnWU+C+pP95ebnjvjj2woyUrxEV24UUtkJ4RXkQYdpUyIle8S9Z23gsLb74SiJz2TLtazi5h4uX4vdp9gAgRrJ+x7a6rbQIwxtN9Kwb112ypdPuNNL1rb5GyNt+Jw5JeSGwSzGJEcCE/tP3Ec+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198572; c=relaxed/simple;
	bh=TsTxKTC25QO4tsGYLpDRzqI10NdgAACO+ajctYtRLjA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mh1NqUHg2336mz8Vn/A5uy2zB80hlYxFuIFcgarM7hoYulscDCqgOY2NL/czj809e+7JkEhrsMZnA2ziMyHe/sRIsMCpy12ylR12Zkq16XjODPoE45N/Y0y0yGANA9e9Fp83YPZmybN7/5w4KPay1iWz8ZBxT2FWoutc3X5MFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-435a04dace1so2939815ab.0
        for <linux-ext4@vger.kernel.org>; Wed, 26 Nov 2025 15:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764198570; x=1764803370;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1M0Z958mw30CkNu259X+iv6Lr1kHZiaRf15eYWXL5M=;
        b=BES8ea7WsGwDeDRN4ImD9+LXp2JOWGE/6FTzvKuCxRAXP59iLNjgdbRx2uXYuyVAvB
         jeYtoZn4yX3OTI/CC4FMVcmSrz3/uA9EM08IsZonbxQr5CdGcOrF2A7fE0sW5hmW/0pD
         4nuGrc8KZJRwd37nsREjgI3A4kGrmF1nFzK5N5is07vRSJrU+YJekuW/N+65OmqqaERg
         uStEd7j0DSpUFAvsNPBSps0i7K+MQNTX6oq2sZ/xwtCiuANCcPUcV7H/HiU1Yeq697+7
         xTCBa7g3g86/38qlLBe8DjS+6Bq8C+63RzNFj4jUfR6FPdWunt+mc59tDyGh1eppP8Do
         ma7g==
X-Forwarded-Encrypted: i=1; AJvYcCUyHiqFzz9AbhCJwMlhr5cS23PEGN7jSByS0NJPZ0qK6wrq2cgIBLcxBk+TP4s6aBvdqGpsLR0h0xqX@vger.kernel.org
X-Gm-Message-State: AOJu0YwKP7jhSiKTkfp9+MtC4wyOF41XDLAb9ChviZgDMOqzBN8eA0Lj
	Gldc3ODAM5rm51+W3XrhNYWkHLDha7duKrc7mViFt6RFvXehUgy+oWqrG0GmwXxbO1/0JK8UUE4
	89z1JSe9roISaWeK/pAffUEFvwikTmELtdGInZVGWa4dUwA+fBHz6mCX9AK0=
X-Google-Smtp-Source: AGHT+IHDHm0qfW9REafx484SpeW8eYNBReRQ9ygpOqwMQIuJonbxK1oyrfsI/CuebMfx7e0l7wzW7tIy1Pi1EI3yAdX90Xr8wxZZ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1986:b0:435:a467:b324 with SMTP id
 e9e14a558f8ab-435b9862f5bmr166492555ab.17.1764198569809; Wed, 26 Nov 2025
 15:09:29 -0800 (PST)
Date: Wed, 26 Nov 2025 15:09:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692788a9.a70a0220.d98e3.00e3.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in evict (4)
From: syzbot <syzbot+a30a00d3e694e4fa1315@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    30f09200cc4a Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15adee92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=884a6f5f4d7949fd
dashboard link: https://syzkaller.appspot.com/bug?extid=a30a00d3e694e4fa1315
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7eaf4b9ef160/disk-30f09200.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab7dc38c62bf/vmlinux-30f09200.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85299a9adb30/bzImage-30f09200.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a30a00d3e694e4fa1315@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.5384/26557 is trying to acquire lock:
ffff88805de42610 (sb_internal){.+.+}-{0:0}, at: evict+0x3e6/0x920 fs/inode.c:810

but task is already holding lock:
ffff88807c0ccb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1808 [inline]
ffff88807c0ccb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x39c/0x1ee0 fs/ext4/migrate.c:438

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1796 [inline]
       ext4_writepages+0x224/0x7d0 fs/ext4/inode.c:3024
       do_writepages+0x27a/0x600 mm/page-writeback.c:2604
       __writeback_single_inode+0x160/0xfb0 fs/fs-writeback.c:1719
       writeback_single_inode+0x2bc/0x550 fs/fs-writeback.c:1840
       write_inode_now+0x170/0x1e0 fs/fs-writeback.c:2903
       iput_final fs/inode.c:1901 [inline]
       iput.part.0+0x487/0xb00 fs/inode.c:1966
       iput+0x35/0x40 fs/inode.c:1929
       ext4_xattr_block_set+0x67c/0x3650 fs/ext4/xattr.c:2199
       ext4_xattr_move_to_block fs/ext4/xattr.c:2664 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2739 [inline]
       ext4_expand_extra_isize_ea+0x1442/0x1ab0 fs/ext4/xattr.c:2827
       __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6364
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6407 [inline]
       __ext4_mark_inode_dirty+0x544/0x870 fs/ext4/inode.c:6485
       ext4_evict_inode+0x74e/0x18e0 fs/ext4/inode.c:254
       evict+0x3e6/0x920 fs/inode.c:810
       iput_final fs/inode.c:1914 [inline]
       iput.part.0+0x6a9/0xb00 fs/inode.c:1966
       iput+0x35/0x40 fs/inode.c:1929
       ext4_orphan_cleanup+0x731/0x11e0 fs/ext4/orphan.c:470
       __ext4_fill_super fs/ext4/super.c:5617 [inline]
       ext4_fill_super+0x8db7/0xaf70 fs/ext4/super.c:5736
       get_tree_bdev_flags+0x38c/0x620 fs/super.c:1698
       vfs_get_tree+0x8e/0x340 fs/super.c:1758
       fc_mount fs/namespace.c:1199 [inline]
       do_new_mount_fc fs/namespace.c:3642 [inline]
       do_new_mount fs/namespace.c:3718 [inline]
       path_mount+0x7b9/0x23a0 fs/namespace.c:4028
       do_mount fs/namespace.c:4041 [inline]
       __do_sys_mount fs/namespace.c:4229 [inline]
       __se_sys_mount fs/namespace.c:4206 [inline]
       __x64_sys_mount+0x293/0x310 fs/namespace.c:4206
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_internal){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs.h:1916 [inline]
       sb_start_intwrite include/linux/fs.h:2099 [inline]
       ext4_evict_inode+0xe3e/0x18e0 fs/ext4/inode.c:215
       evict+0x3e6/0x920 fs/inode.c:810
       iput_final fs/inode.c:1914 [inline]
       iput.part.0+0x6a9/0xb00 fs/inode.c:1966
       iput+0x35/0x40 fs/inode.c:1929
       ext4_ext_migrate+0xc6f/0x1ee0 fs/ext4/migrate.c:588
       __ext4_ioctl+0x3178/0x4410 fs/ext4/ioctl.c:1694
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
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

3 locks held by syz.4.5384/26557:
 #0: ffff88805de42420 (sb_writers#4){.+.+}-{0:0}, at: __ext4_ioctl+0x3146/0x4410 fs/ext4/ioctl.c:1684
 #1: ffff888045cd0d70 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock include/linux/fs.h:980 [inline]
 #1: ffff888045cd0d70 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: __ext4_ioctl+0x3170/0x4410 fs/ext4/ioctl.c:1693
 #2: ffff88807c0ccb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1808 [inline]
 #2: ffff88807c0ccb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_ext_migrate+0x39c/0x1ee0 fs/ext4/migrate.c:438

stack backtrace:
CPU: 0 UID: 0 PID: 26557 Comm: syz.4.5384 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs.h:1916 [inline]
 sb_start_intwrite include/linux/fs.h:2099 [inline]
 ext4_evict_inode+0xe3e/0x18e0 fs/ext4/inode.c:215
 evict+0x3e6/0x920 fs/inode.c:810
 iput_final fs/inode.c:1914 [inline]
 iput.part.0+0x6a9/0xb00 fs/inode.c:1966
 iput+0x35/0x40 fs/inode.c:1929
 ext4_ext_migrate+0xc6f/0x1ee0 fs/ext4/migrate.c:588
 __ext4_ioctl+0x3178/0x4410 fs/ext4/ioctl.c:1694
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc21398f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc2148be038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc213be5fa0 RCX: 00007fc21398f749
RDX: 0000000000000000 RSI: 0000000000006609 RDI: 0000000000000004
RBP: 00007fc213a13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc213be6038 R14: 00007fc213be5fa0 R15: 00007ffc7410fa88
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

