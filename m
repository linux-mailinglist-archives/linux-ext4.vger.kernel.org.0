Return-Path: <linux-ext4+bounces-9598-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA38B339EA
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA844189EC5F
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E042BDC25;
	Mon, 25 Aug 2025 08:51:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC729E112
	for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111892; cv=none; b=DowZlb4+MX0JnF5V5LfJnSHfVe01hIXeE/3YinS5mV9ivee0MHIiceChVID3yYUMJ4PlqVnp356+b7pL4Z9D6kyGxfhSzhfZsf/bLHQ6kygRWCcqCVX5+RxvCqwab0/2SeLsVDOJ1uoc3kZJ5P9EZs9gJwEf09T3dxYjgOuNmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111892; c=relaxed/simple;
	bh=737pHUcbqavM/NYe5LkFjkuENOe+KqG8l78fhwWiOtM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FDnLRItRN42Y7whEHP4jsPl3n7rxgDGhlhCZ+yiXY/KVPlRwI74ynat3fF4C5UHIYcHOhIXgEmquCO9kxWizULnBKaNaQP9FMM97iBhjUzjWpGPUqZNDkczhQd/JxUYNLFHAQHNf728t9TCeXGRUS53mMaPoWitrNZpxF9LB+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432e1ea71so1108655239f.2
        for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 01:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111890; x=1756716690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SUGiyLybXFIGgebnjZWx+A6DBkt0GAu5fA8F5iMbSEA=;
        b=IF2+/ZAvBAGCpDV7kCO8ET1/SHMboAh53zzY5cN4DWNkfu8ALHf5QeRg83i9bPlhwl
         dYQ2FXDOsmIuT4EInuBjlhYueF09M0+3hCnMRtR80AvPvZ0Rp4dvwMFnf+wBONYM05+y
         M9/xNsHJHFdCy488eSqubKlQ/vKXHll1XbRCRlblV6Nl0qgVWO7a95IMZA4LJnFXj5jk
         Nv+pLcOg5z1YgJWtpvxhM79dkIyOXHsFplrUlTS6Y2uDnNTpYvmuR6Pv60cuElBV9G2i
         SxthqdAD3cGYBYaUmdaGeQ+pP+Jm9xMlqaL8FQUJFH9lCd62qIOc9D0LpaQtbVSFHEIQ
         RNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFkWcGSr/YJlMl/A+++jxJ36sdny1HbH+jcw7HqE9TU64NTpCoLq0gqVnH1oP9eLH6I5brdmIjgLw7@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEzB9UhgcoMjcTrDpNoWiUo8p4GBaBHm3giiMJUEUhevHKJT4
	/Z76mGYN1ogOpZCCy9MouKgsK1VllZdNMm4ZJt5/BCi645xYCnbZc3bnnqQ5+Eam+cusLjjGiOy
	dFY0XYKjo8KVxt/iACDIpc2xa7aNW1xhU80t02fsTib/ICD0XHT99rI1RdB0=
X-Google-Smtp-Source: AGHT+IFKBOmBvl27xsblvM7OKwhWGLo3t756oC5s3Kddkq7C9ib3+yMi8JmeP0QUxMSmTN55NitQFPxafz/4JgmkCJ0jKI2v6ZcI
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:3e5:4bc5:539a with SMTP id
 e9e14a558f8ab-3e921c50621mr179288905ab.19.1756111890383; Mon, 25 Aug 2025
 01:51:30 -0700 (PDT)
Date: Mon, 25 Aug 2025 01:51:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac2412.050a0220.37038e.0089.GAE@google.com>
Subject: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
From: syzbot <syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1654ac42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da02162f945f3311
dashboard link: https://syzkaller.appspot.com/bug?extid=c5c9c223a721d7353490
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d1cef0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f4e7bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cea3b9f96317/disk-8d245acc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edb55fcbe832/vmlinux-8d245acc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db6f85cd97c7/bzImage-8d245acc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d39971563b22/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=125fc862580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 1024
EXT4-fs: Ignoring removed nobh option
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.5.286/7060 is trying to acquire lock:
ffff888056de1590 (&ei->i_data_sem/3){++++}-{4:4}, at: ext4_truncate+0xddd/0x1210 fs/ext4/inode.c:4639

but task is already holding lock:
ffff888056de1f20 (&ei->i_data_sem/3){++++}-{4:4}, at: ext4_truncate+0xddd/0x1210 fs/ext4/inode.c:4639

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ei->i_data_sem/3);
  lock(&ei->i_data_sem/3);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz.5.286/7060:
 #0: ffff888022bfe428 (sb_writers#4){.+.+}-{0:0}, at: vfs_truncate+0x336/0x6e0 fs/open.c:96
 #1: ffff888056de2090 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: inode_lock_killable include/linux/fs.h:874 [inline]
 #1: ffff888056de2090 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: do_truncate+0x146/0x230 fs/open.c:63
 #2: ffff888056de2230 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock include/linux/fs.h:924 [inline]
 #2: ffff888056de2230 (mapping.invalidate_lock#2){++++}-{4:4}, at: ext4_setattr+0xe11/0x2ae0 fs/ext4/inode.c:5954
 #3: ffff888056de1f20 (&ei->i_data_sem/3){++++}-{4:4}, at: ext4_truncate+0xddd/0x1210 fs/ext4/inode.c:4639
 #4: ffff888056de1d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_write_trylock_xattr fs/ext4/xattr.h:164 [inline]
 #4: ffff888056de1d78 (&ei->xattr_sem){++++}-{4:4}, at: ext4_try_to_expand_extra_isize fs/ext4/inode.c:6425 [inline]
 #4: ffff888056de1d78 (&ei->xattr_sem){++++}-{4:4}, at: __ext4_mark_inode_dirty+0x4ba/0x870 fs/ext4/inode.c:6506

stack backtrace:
CPU: 1 UID: 0 PID: 7060 Comm: syz.5.286 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x1133/0x1ce0 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 down_write+0x92/0x200 kernel/locking/rwsem.c:1590
 ext4_truncate+0xddd/0x1210 fs/ext4/inode.c:4639
 ext4_evict_inode+0x7a8/0x18e0 fs/ext4/inode.c:261
 evict+0x3e6/0x920 fs/inode.c:810
 iput_final fs/inode.c:1897 [inline]
 iput fs/inode.c:1923 [inline]
 iput+0x521/0x880 fs/inode.c:1909
 ext4_xattr_set_entry+0x73c/0x1f00 fs/ext4/xattr.c:1839
 ext4_xattr_ibody_set+0x3d6/0x5d0 fs/ext4/xattr.c:2263
 ext4_xattr_move_to_block fs/ext4/xattr.c:2666 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2734 [inline]
 ext4_expand_extra_isize_ea+0x1487/0x1ab0 fs/ext4/xattr.c:2822
 __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:6385
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6428 [inline]
 __ext4_mark_inode_dirty+0x544/0x870 fs/ext4/inode.c:6506
 ext4_ext_truncate+0xa3/0x300 fs/ext4/extents.c:4475
 ext4_truncate+0xe3b/0x1210 fs/ext4/inode.c:4643
 ext4_setattr+0x19f3/0x2ae0 fs/ext4/inode.c:6044
 notify_change+0x6a9/0x1230 fs/attr.c:552
 do_truncate+0x1d7/0x230 fs/open.c:68
 vfs_truncate+0x5d6/0x6e0 fs/open.c:118
 do_sys_truncate fs/open.c:141 [inline]
 __do_sys_truncate fs/open.c:153 [inline]
 __se_sys_truncate fs/open.c:151 [inline]
 __x64_sys_truncate+0x172/0x1e0 fs/open.c:151
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f63ad98ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f63ae7fc038 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f63adbb5fa0 RCX: 00007f63ad98ebe9
RDX: 0000000000000000 RSI: 000000000000041a RDI: 00002000000000c0
RBP: 00007f63ada11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f63adbb6038 R14: 00007f63adbb5fa0 R15: 00007fff7f328758
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

