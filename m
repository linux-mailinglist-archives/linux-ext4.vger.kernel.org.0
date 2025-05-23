Return-Path: <linux-ext4+bounces-8175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDFAC1AD0
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 05:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B303A3A4CAD
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 03:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5322129A;
	Fri, 23 May 2025 03:51:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772781749
	for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 03:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972289; cv=none; b=WBEgBBDU+cJZuJe5pnjQpCkQDu1v/iMDpGpnDF0zrlJEiCZZI5hXg8mPKdnwMJnKJVk2NDz2HFTlsMW8ps0+0LBASu6zgJJpD2JylyG5l8zyubZBz+dyoe5VO1rDC10WqBQI3jVjZf4/1hKhcmBEKjglyf/qbGZWBuszFw7B0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972289; c=relaxed/simple;
	bh=5V/v29AfF/oWEweCO4X3mm3g0/wdGwy1d38n6PJCkXQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GYnCYUX49uVQ5XMo66DMF3LjO94wzyMjgPmC7rBIvRBmmZaY8RO7XPJFhaMAhO/49fTwN1BUzpJRQYwJq27TaFqx0oBN3ZbYKC4+G41Md3ihfQgsUmll9JZ67uttxx5NfQYhXtITEuHmUN1JwUH87xF7yklDj2m8YzZMVqt0Z9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b3827969dso849276339f.1
        for <linux-ext4@vger.kernel.org>; Thu, 22 May 2025 20:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747972287; x=1748577087;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqnhaG3SiKjwXI2wuYgoRoxgP4ldO82mcCzA8FggHsM=;
        b=QPCUILPp2cqmgZWwt53/b06NaJv2n4ijcSR1tChW77vQGT5cxZ6J9AEgYsXO4zxNE5
         H12NnvF8AU9IXDp6OQW4b4HBAzKnNJEh+WsmZni6MYwq9oYzp6zqkW56mSj3/x1hqLmJ
         MYlwe3TzTN6yo+1KzqJJnkXn0yiDyXRiSu1ruTk4NQrXrz+DGIEmWuBrbec4oIF4LM22
         4mTKFdwlvB8d9NcLa/WKXJDzFP0hCCiMbbguVxxdVl/B1RyMSxJ5xRyB5AvZVKqtItSD
         64DOnEWScLfesyFSmUJFkvtaONhDP+H8ZTOlLts7JRmITVohmopaYkS9uluwObRfCXbx
         jVlA==
X-Forwarded-Encrypted: i=1; AJvYcCV2vms6Qc+7cUm6MC8tNZATIXS/DrtpJQDGADcZDG+xQ/BQdf1e4gvF8upAIhAyld751z/JiGn8a64v@vger.kernel.org
X-Gm-Message-State: AOJu0YwzWXhcV3GCxKMxVSB0zXPUgYR3+fOp5asqmxqckqXgJ2lLIEpk
	r8uy0hGlqzfFbGLvCpmo2D8yySKo9RxI1cF/qvJBfBvCeGu2ksKfwkc96TeNvEA13NeW+Ttr/vQ
	QxeGvKSlQlCugLWQ5kaM/tt7/WqJYv60rdGLb1xg3yEkreXeZosbhODRUg0A=
X-Google-Smtp-Source: AGHT+IGVBDixPBnY4z8Nvzq8uDg7pM3vWgMWs2veQuVDfDjvB9zhVLbqbvRDssvsXJ6q0ojws/w38SvoZYwgWXwW49880a0e4crd
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2988:b0:85d:b054:6eb9 with SMTP id
 ca18e2360f4ac-86a2324e01amr3835142539f.14.1747972287025; Thu, 22 May 2025
 20:51:27 -0700 (PDT)
Date: Thu, 22 May 2025 20:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682ff0bf.a70a0220.1765ec.0148.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in lock_two_directories (4)
From: syzbot <syzbot+1bfacdf603474cfa86bd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, bp@alien8.de, casey@schaufler-ca.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5806cd506af Linux 6.15-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10defef4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3340af1a8845dd35
dashboard link: https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f292d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e29e70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/652000eacd92/disk-a5806cd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b445a74e31e/vmlinux-a5806cd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a4ef01f165f/bzImage-a5806cd5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6f80bf89f51a/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10f7c1f4580000)

The issue was bisected to:

commit e63d86b8b76437815fc040e8e65da257c28ba922
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu Nov 16 09:01:24 2023 +0000

    smack: Initialize the in-memory inode in smack_inode_init_security()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148852d4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168852d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=128852d4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1bfacdf603474cfa86bd@syzkaller.appspotmail.com
Fixes: e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inode_init_security()")

INFO: task syz-executor125:5853 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor125 state:D stack:28616 pid:5853  tgid:5847  ppid:5846   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_write_slowpath+0xbec/0x1030 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write_nested+0x1b5/0x200 kernel/locking/rwsem.c:1694
 inode_lock_nested include/linux/fs.h:902 [inline]
 lock_two_directories+0x16b/0x220 fs/namei.c:3236
 lock_rename fs/namei.c:3270 [inline]
 do_renameat2+0x38a/0xc50 fs/namei.c:5216
 __do_sys_rename fs/namei.c:5317 [inline]
 __se_sys_rename fs/namei.c:5315 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5315
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f58ce457489
RSP: 002b:00007f58ce3ea168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f58ce4de6b8 RCX: 00007f58ce457489
RDX: 0030656c69662f30 RSI: 00002000000001c0 RDI: 0000200000000000
RBP: 00007f58ce4de6b0 R08: 00007ffff522f7d7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f58ce4de6bc
R13: 000000000000006e R14: 00007ffff522f6f0 R15: 00007ffff522f7d8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
2 locks held by getty/5581:
 #0: ffff88814cb7c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900030062f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz-executor125/5849:
4 locks held by syz-executor125/5853:
 #0: ffff8880353d6420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:556
 #1: ffff8880353d6730 (&type->s_vfs_rename_key){+.+.}-{4:4}, at: lock_rename fs/namei.c:3269 [inline]
 #1: ffff8880353d6730 (&type->s_vfs_rename_key){+.+.}-{4:4}, at: do_renameat2+0x37f/0xc50 fs/namei.c:5216
 #2: ffff88807b085d60 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:902 [inline]
 #2: ffff88807b085d60 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: lock_two_directories+0x141/0x220 fs/namei.c:3235
 #3: ffff88807b329808 (&type->i_mutex_dir_key#3/5){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:902 [inline]
 #3: ffff88807b329808 (&type->i_mutex_dir_key#3/5){+.+.}-{4:4}, at: lock_two_directories+0x16b/0x220 fs/namei.c:3236

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:437
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5849 Comm: syz-executor125 Not tainted 6.15.0-rc7-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:get_current arch/x86/include/asm/current.h:25 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:245 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x8/0x90 kernel/kcov.c:321
Code: 48 89 44 11 20 c3 cc cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 08 a0 72 92 65 8b 15 58 aa b2 10 81 e2 00 01 ff 00
RSP: 0018:ffffc900044d6ef8 EFLAGS: 00000246
RAX: ffffffff826f434a RBX: 1ffff9200089adf8 RCX: ffffffff826f431d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900044d7090 R08: ffff8880778b39ff R09: 1ffff1100ef1673f
R10: dffffc0000000000 R11: ffffed100ef16740 R12: 000000000000000e
R13: 1ffff1100ef1673f R14: 000000000000601b R15: ffff8880778b39f8
FS:  00007f58ce40b6c0(0000) GS:ffff8881261f6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d3b19b24b0 CR3: 0000000034b24000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_buffer_uptodate fs/ext4/ext4.h:3842 [inline]
 __ext4_get_inode_loc+0x5aa/0x1040 fs/ext4/inode.c:4458
 ext4_get_inode_loc fs/ext4/inode.c:4583 [inline]
 ext4_reserve_inode_write+0x191/0x330 fs/ext4/inode.c:5889
 __ext4_mark_inode_dirty+0x15b/0x700 fs/ext4/inode.c:6066
 ext4_dirty_inode+0xd0/0x110 fs/ext4/inode.c:6103
 __mark_inode_dirty+0x2d1/0xdf0 fs/fs-writeback.c:2527
 mark_inode_dirty include/linux/fs.h:2545 [inline]
 dquot_alloc_space include/linux/quotaops.h:319 [inline]
 dquot_alloc_block include/linux/quotaops.h:336 [inline]
 ext4_xattr_block_set+0x12ca/0x2ac0 fs/ext4/xattr.c:2048
 ext4_xattr_set_handle+0xdfb/0x1590 fs/ext4/xattr.c:2447
 ext4_initxattrs+0x9f/0x110 fs/ext4/xattr_security.c:44
 security_inode_init_security+0x2a0/0x3f0 security/security.c:1852
 __ext4_new_inode+0x3257/0x3bd0 fs/ext4/ialloc.c:1326
 ext4_create+0x22d/0x460 fs/ext4/namei.c:2824
 lookup_open fs/namei.c:3701 [inline]
 open_last_lookups fs/namei.c:3800 [inline]
 path_openat+0x14f1/0x3830 fs/namei.c:4036
 do_filp_open+0x1fa/0x410 fs/namei.c:4066
 do_sys_openat2+0x121/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f58ce457489
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f58ce40b168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f58ce4de6a8 RCX: 00007f58ce457489
RDX: 0000000000101042 RSI: 0000200000000140 RDI: 00000000ffffff9c
RBP: 00007f58ce4de6a0 R08: 00007f58ce40b6c0 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f58ce4de6ac
R13: 0000000000000006 R14: 00007ffff522f6f0 R15: 00007ffff522f7d8
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.394 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

