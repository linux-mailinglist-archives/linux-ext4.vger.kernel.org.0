Return-Path: <linux-ext4+bounces-14005-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMHyKR69nmnYXAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14005-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 10:13:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E35194B84
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 10:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5F1C30065DA
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885033815D5;
	Wed, 25 Feb 2026 09:12:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D73815DB
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010774; cv=none; b=gNIeoxrYtZN128YjdeprBOv/QCjwh/aZHb2Tv9LWx8Hs6s0+qii5HMFRVNOQ6djcGI6trYPBk5kgq5nk9nGPvpHzwG+KANlukFfkx6koyd6TNzFUxqWHc7u/wFATFtfhzXnYThARjXlRaXzR0OaMpyWGiQeSygD+/9RinIx6L3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010774; c=relaxed/simple;
	bh=Rj0WRPWI/1OZsyjrja5BPuIjb2XaIjOhtKO/MTD9LaU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I1rV5ChInWWkbgFoJWziqCXPTDl8TQqOchG+iRVt4B6QwdlAYWnzY9/3tjK1IpSGG/WkW3ox/F7WdcutC7Cd0Emp9G7lJjgvZkxz2A9gP/LiZgVPTi0Yzk0JXo6KjshvWFcOtjdmyFvXOWYVPtUWM+CJIGXGmOXWqH8fWptI1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4c14c60faso79783233a34.1
        for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 01:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772010769; x=1772615569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQefKd/FMJZjNkjcfOMqZE28IH7UDte/+y3dOHKHDNQ=;
        b=DkPiEh5rLvk7LTNqopehl5fFDFSMSFNClirdWzz9+kzjXOqsxaJjUIhxVO0vwqDQJt
         Z9zj9O0VRI5nsFTb0TbaC/Ogc32AG9+WiBKmllEN+9aHvZFXEJ8hvmL2Z+MDb5/rAulP
         zK3KD1vEFuqElm6BKnr7joBO1033NCMmbwu6dZsNrrm4A2NVDzH7a0SuJcJeFSWJy27Y
         aoXhUr+8nIPAVTz85UK/qS6FjPxRx2NPcjOg0S3tKwdXMe0pwfWxrgdzgNrH+Tw2Oud7
         mx9/SqfDO0F5d6WTTq2mIpe945phMBKRO3T7WTQx/AUXn2oxTrcPYpGo3LuGYKGkUS5N
         FjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz8qyyN6ia5ddaMyLJjmofVtvnYqUypNmFpL3XHz4EKIk0I3fOwSr38sMsunniXV2pmR605dqP+z5Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HTyP0EcSimcSndvv61iMxdnY7+KvNXA1Irx3P+vMLlXqZr+m
	6A23xCD1rxvJkgkQxnCU2swb7q2P58yT+OIKbqqIQozB2QjXhJcbcgSI/tJYWHie2b6+meMjdjH
	l9t+Rj0umFCbOcxvKBjTep/vmMtsB9qMd9fMU79MLVkcvGAe+fk1nA/dHpEE=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:edc9:0:b0:679:94c0:117f with SMTP id
 006d021491bc7-679c4267a48mr8234100eaf.23.1772010769450; Wed, 25 Feb 2026
 01:12:49 -0800 (PST)
Date: Wed, 25 Feb 2026 01:12:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699ebd11.a00a0220.21906d.0005.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in filename_unlinkat
From: syzbot <syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-14005-lists,linux-ext4=lfdr.de,1659aaaaa8d9d11265d7];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-ext4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,storage.googleapis.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 73E35194B84
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    a95f71ad3e2e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cfc55a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abe4fa590468dbfb
dashboard link: https://syzkaller.appspot.com/bug?extid=1659aaaaa8d9d11265d7
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11294eaa580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a47c02580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8676ab01a8b8/disk-a95f71ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3314e350353/vmlinux-a95f71ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e2905ccbd1e/bzImage-a95f71ad.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/94e3ac0ab12f/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=14a88152580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com

INFO: task syz.0.17:5995 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:29024 pid:5995  tgid:5990  ppid:5927   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x14fb/0x52c0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7285
 rt_mutex_slowlock_block kernel/locking/rtmutex.c:1647 [inline]
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked+0x1f8f/0x25c0 kernel/locking/rtmutex.c:1760
 rt_mutex_slowlock+0xbd/0x170 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 rwbase_write_lock+0x14d/0x730 kernel/locking/rwbase_rt.c:244
 inode_lock_nested include/linux/fs.h:1073 [inline]
 __start_dirop fs/namei.c:2923 [inline]
 start_dirop fs/namei.c:2934 [inline]
 filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
 __do_sys_unlink fs/namei.c:5575 [inline]
 __se_sys_unlink+0x2e/0x140 fs/namei.c:5572
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cd2b5c629
RSP: 002b:00007f6cd2195028 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f6cd2dd6090 RCX: 00007f6cd2b5c629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000180
RBP: 00007f6cd2bf2b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6cd2dd6128 R14: 00007f6cd2dd6090 R15: 00007ffd3df50108
 </TASK>

Showing all locks held in the system:
4 locks held by pr/legacy/17:
1 lock held by khungtaskd/38:
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8ddcd780 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u8:6/783:
3 locks held by kworker/u8:11/1173:
2 locks held by getty/5552:
 #0: ffff888036cdf0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e832e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x462/0x13c0 drivers/tty/n_tty.c:2211
7 locks held by syz.0.17/5991:
2 locks held by syz.0.17/5995:
 #0: ffff888034904480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888054ce9c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888054ce9c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888054ce9c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888054ce9c70 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
7 locks held by syz.1.18/6018:
2 locks held by syz.1.18/6022:
 #0: ffff8880294e6480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888044ea3430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888044ea3430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888044ea3430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888044ea3430 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
6 locks held by syz.2.19/6044:
2 locks held by syz.2.19/6048:
 #0: ffff8880247b0480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888044c92850 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888044c92850 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888044c92850 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888044c92850 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
3 locks held by syz.3.20/6075:
2 locks held by syz.3.20/6080:
 #0: ffff888034d36480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888054cee3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888054cee3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888054cee3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888054cee3b0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
7 locks held by syz.4.21/6113:
2 locks held by syz.4.21/6117:
 #0: ffff888035624480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888044c9cbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888044c9cbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888044c9cbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888044c9cbf0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
7 locks held by syz.5.22/6147:
2 locks held by syz.5.22/6151:
 #0: ffff88804c26c480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888044c96f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888044c96f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888044c96f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888044c96f90 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
7 locks held by syz.6.23/6185:
2 locks held by syz.6.23/6190:
 #0: ffff888025968480 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff888044e5c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888044e5c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff888044e5c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff888044e5c010 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_unlinkat+0x2ad/0x610 fs/namei.c:5521
3 locks held by udevd/6219:
5 locks held by syz.7.24/6221:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfd9/0x1030 kernel/hung_task.c:515
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 783 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: bat_events batadv_dat_purge
RIP: 0010:__local_bh_enable_ip+0x1c2/0x2b0 kernel/softirq.c:307
Code: f7 89 df e8 60 01 00 00 41 f7 c4 00 02 00 00 74 05 e8 52 60 44 00 9c 58 a9 00 02 00 00 75 23 41 f7 c4 00 02 00 00 74 01 fb 5b <41> 5c 41 5d 41 5e 41 5f 5d e9 c0 d7 9d 09 cc 90 0f 0b 90 e9 66 fe
RSP: 0018:ffffc900046ffa58 EFLAGS: 00000206
RAX: 0000000000000006 RBX: ffffffffffffffe8 RCX: 0000000000000046
RDX: 0000000000000006 RSI: ffffffff8d55b178 RDI: ffffffff8ba64380
RBP: 1ffff11004a23cc4 R08: ffffffff8f6a23b7 R09: 1ffffffff1ed4476
R10: dffffc0000000000 R11: fffffbfff1ed4477 R12: 0000000000000286
R13: dffffc0000000000 R14: ffff88802511e624 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888126442000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fb63fff CR3: 00000000354ae000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 spin_unlock_bh include/linux/spinlock_rt.h:116 [inline]
 __batadv_dat_purge+0x344/0x400 net/batman-adv/distributed-arp-table.c:185
 batadv_dat_purge+0x20/0x70 net/batman-adv/distributed-arp-table.c:204
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

