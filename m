Return-Path: <linux-ext4+bounces-14032-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA5MGpgXoGmzfgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14032-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:51:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D23611A3C29
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 10:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF7383132F85
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980E314A77;
	Thu, 26 Feb 2026 09:36:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AD2ECD3A
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098587; cv=none; b=WGFFMrtybquhLs/3JxxXpv9gsvvd+S5BWb2CXphD7Nqa5hP5hyqs2vVTD9AalLW5GaV3ZtPMQpIFX+YDIgbWEjxycVdWUPIa6xllvTFMjtKEOhq3tNuvhaqEge390VYHpUQI9Q3q2/a3FeG0uESDGZkoQGRBbF5FGVV67yfH7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098587; c=relaxed/simple;
	bh=Sj2G2rYSSqUMQWXehdan4EOq1qABduhja6SpnRKxnL4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fc4BjSW4VoWKgObifXkKRQLzp7X+8XWWXEOPIcnGBb702RX55hrwOCeURrCSRE4vlv4QBsUgOsVoedH12lMgOb3x8Et20ZJcRQpAjTKMSEbb1r/D413iYSYUYObjiupTakjnBh6UhfyReeGMe9KUTQT6kGc+GP1WSNnsvNxLic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679dda090fbso14930935eaf.2
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 01:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098585; x=1772703385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cG+iJlJoFCAvmvNogdGvj7PlGIWRn8LNyAQZIF90xM=;
        b=Q4Agmpjn/Jb0v2+wiHFP5JB6DxXGOqVcXBpSaLNtoRJ9CvRvKqFkO2wQgiqtWj/pcx
         rQYBRtw1GbJkaYU1JvYcNrB3z8Bb6iqdZEw25iaOMqdnwcRG09XvBmeVml1aWDlFzVvg
         sTP6NFnIBYfTE+Gcn9I9vYMcDo4fTj0IcBFuclfjmqYNUFk25xN+EnokeB25EDEkkGOC
         B/CF4AMVzMx8M/Uh7/7x3K4kYaMd/Wdncz/iD1WN4iV9HU4sWewVs6tDEDKVf7V7hQ4G
         MJnDEZ9k7w4boliEnjqy35eV0yPa8AsFvSJqxvsf4Ee2kYfg+J1lXaqUCRXLW9DIdZlV
         sYXw==
X-Forwarded-Encrypted: i=1; AJvYcCWumAtZyNms6oL8e4kBxr5yVQCNdmoDPgERvHoJL0uCjohVGygi+fbSutRdkYuMQWzXmSZdoFAnZSdG@vger.kernel.org
X-Gm-Message-State: AOJu0YzQy+gMBy9gNozW4EJGUuJ+AZHlRE+BUS+B0U3RpSti4tD3aqq7
	0JtkIVZ9+RtmaigtAzS3lTt65y6NFVgc/CeyYfW3SeSpgCfkFIyACbOfh2IAjWkuDY/m1kzrl85
	jJXt+8xBpHd4Hogha0zomqPulJEI4+OlB2NZBsJuXnqm5DStvfMWxivbBVuI=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1808:b0:662:b5e0:e6d1 with SMTP id
 006d021491bc7-679ef7fdfbemr1745333eaf.16.1772098585238; Thu, 26 Feb 2026
 01:36:25 -0800 (PST)
Date: Thu, 26 Feb 2026 01:36:25 -0800
In-Reply-To: <698cb045.050a0220.2eeac1.009b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a01419.050a0220.2fcbed.0008.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in block_read_full_folio (3)
From: syzbot <syzbot+03afbb29537f0336b7ad@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=93740e6c6567fcec];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14032-lists,linux-ext4=lfdr.de,03afbb29537f0336b7ad];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: D23611A3C29
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    d9d32e5bd5a4 Merge tag 'ata-7.0-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105ac202580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93740e6c6567fcec
dashboard link: https://syzkaller.appspot.com/bug?extid=03afbb29537f0336b7ad
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151cc24a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1218a8d6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d223d806e90e/disk-d9d32e5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2d3e2c957ed/vmlinux-d9d32e5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db3a0620bab3/bzImage-d9d32e5b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0e3dce03880c/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1450755a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03afbb29537f0336b7ad@syzkaller.appspotmail.com

INFO: task udevd:5880 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:24960 pid:5880  tgid:5880  ppid:5186   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7831
 bit_wait_io+0x11/0xd0 kernel/sched/wait_bit.c:250
 __wait_on_bit_lock+0xec/0x4e0 kernel/sched/wait_bit.c:93
 out_of_line_wait_on_bit_lock+0x13b/0x190 kernel/sched/wait_bit.c:120
 wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
 __lock_buffer fs/buffer.c:72 [inline]
 lock_buffer include/linux/buffer_head.h:432 [inline]
 block_read_full_folio+0x38f/0x830 fs/buffer.c:2436
 filemap_read_folio+0x137/0x3b0 mm/filemap.c:2496
 filemap_update_page mm/filemap.c:2583 [inline]
 filemap_get_pages+0x1744/0x1f10 mm/filemap.c:2713
 filemap_read+0x447/0x1230 mm/filemap.c:2800
 blkdev_read_iter+0x30a/0x440 block/fops.c:855
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x582/0xa70 fs/read_write.c:574
 ksys_read+0x150/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f30023de407
RSP: 002b:00007ffef214d590 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f3002352880 RCX: 00007f30023de407
RDX: 0000000000000200 RSI: 00007f300234e000 RDI: 0000000000000009
RBP: 0000556fb2cd5c50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000018
R13: 0000000000001000 R14: 0000556fb2ce78f8 R15: 00007f30025f739c
 </TASK>
INFO: task syz.4.874:8117 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.874       state:D stack:25632 pid:8117  tgid:8117  ppid:5974   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 io_schedule+0x7f/0xd0 kernel/sched/core.c:7831
 folio_wait_bit_common+0x6d8/0xbc0 mm/filemap.c:1323
 folio_lock include/linux/pagemap.h:1170 [inline]
 __find_get_block_slow fs/buffer.c:206 [inline]
 find_get_block_common+0x34f/0xe10 fs/buffer.c:1405
 bdev_getblk+0x53/0x6e0 include/linux/gfp.h:-1
 __getblk include/linux/buffer_head.h:380 [inline]
 sb_getblk include/linux/buffer_head.h:386 [inline]
 __ext4_get_inode_loc+0x7d8/0xfa0 fs/ext4/inode.c:4812
 ext4_get_inode_loc fs/ext4/inode.c:4915 [inline]
 ext4_reserve_inode_write+0x18b/0x360 fs/ext4/inode.c:6235
 __ext4_mark_inode_dirty+0x14b/0x730 fs/ext4/inode.c:6413
 __ext4_new_inode+0x3383/0x3d20 fs/ext4/ialloc.c:1333
 ext4_mkdir+0x3da/0xbf0 fs/ext4/namei.c:3005
 vfs_mkdir+0x413/0x630 fs/namei.c:5233
 filename_mkdirat+0x285/0x510 fs/namei.c:5266
 __do_sys_mkdir fs/namei.c:5293 [inline]
 __se_sys_mkdir+0x34/0x150 fs/namei.c:5290
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f08d499c629
RSP: 002b:00007ffd2b703978 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007f08d4c15fa0 RCX: 00007f08d499c629
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000680
RBP: 00007f08d4a32b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f08d4c15fac R14: 00007f08d4c15fa0 R15: 00007f08d4c15fa0
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/13:
 #0: ffff88801fabd948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88801fabd948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc90000127c40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc90000127c40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
 #2: ffff88801b6f20e0 (&type->s_umount_key#41){.+.+}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:565
1 lock held by khungtaskd/32:
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by kworker/u8:5/127:
 #0: ffff8880b863ade0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x31/0x150 kernel/sched/core.c:647
 #1: ffff8880b8624588 (psi_seq){-.-.}-{0:0}, at: psi_task_switch+0x53/0x880 kernel/sched/psi.c:933
1 lock held by udevd/5186:
2 locks held by getty/5573:
 #0: ffff888032cfe0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000331e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13c0 drivers/tty/n_tty.c:2211
2 locks held by udevd/5880:
 #0: ffff888023452a28 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1043 [inline]
 #0: ffff888023452a28 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:854
 #1: ffff888023452bc8 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1093 [inline]
 #1: ffff888023452bc8 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_update_page mm/filemap.c:2549 [inline]
 #1: ffff888023452bc8 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_get_pages+0x991/0x1f10 mm/filemap.c:2713
1 lock held by syz-executor/5965:
 #0: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:343 [inline]
 #0: ffffffff8e766578 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x38d/0x770 kernel/rcu/tree_exp.h:961
1 lock held by syz-executor/5966:
4 locks held by udevd/6188:
2 locks held by syz.4.874/8117:
 #0: ffff88807bcaa420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:493
 #1: ffff88805b1d03e0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff88805b1d03e0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2923 [inline]
 #1: ffff88805b1d03e0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2934 [inline]
 #1: ffff88805b1d03e0 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: filename_create+0x200/0x370 fs/namei.c:4922
2 locks held by udevd/8626:
 #0: ffff888023451328 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1043 [inline]
 #0: ffff888023451328 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:854
 #1: ffff8880b873ade0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x31/0x150 kernel/sched/core.c:647
1 lock held by udevd/8653:
1 lock held by udevd/8654:
 #0: ffff888023454128 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1043 [inline]
 #0: ffff888023454128 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:854
2 locks held by syz.5.2965/13038:
1 lock held by syz.6.2966/13039:
1 lock held by syz.0.2964/13042:
1 lock held by kmmpd-loop0/13048:
 #0: ffff8880b873ade0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x31/0x150 kernel/sched/core.c:647

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 32 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
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
CPU: 1 UID: 0 PID: 6188 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:srso_alias_safe_ret+0x0/0x7 arch/x86/lib/retpoline.S:210
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <48> 8d 64 24 08 c3 cc e8 f4 ff ff ff 0f 0b cc cc cc cc cc cc cc cc
RSP: 0018:ffffc90002ed73d0 EFLAGS: 00000293
RAX: ffffffff8ba52031 RBX: ffff888036ffd900 RCX: ffff88801ef73c80
RDX: 0000000000000000 RSI: 0000000000000300 RDI: 0000000000000300
RBP: 0000000000000001 R08: ffff88801ef73c80 R09: 0000000000000004
R10: 0000000000000003 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880760d8800 R14: ffff8880595dbdc0 R15: ffffffffffffffff
FS:  00007f3002352880(0000) GS:ffff888125564000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f300234d000 CR3: 000000002c631000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 srso_alias_return_thunk+0x5/0xfbef5 arch/x86/lib/retpoline.S:220
 mt_locked lib/maple_tree.c:729 [inline]
 mt_slot lib/maple_tree.c:736 [inline]
 mas_next_slot+0x951/0xcf0 lib/maple_tree.c:4406
 mas_find+0xb0e/0xd30 lib/maple_tree.c:5622
 vma_next include/linux/mm.h:1323 [inline]
 validate_mm+0xfe/0x4c0 mm/vma.c:650
 mmap_region+0x1513/0x2240 mm/vma.c:2843
 do_mmap+0xc39/0x10c0 mm/mmap.c:559
 vm_mmap_pgoff+0x2c9/0x4f0 mm/util.c:581
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3002454822
Code: 00 00 00 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 3b 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 5b 5d c3 0f 1f 00 48 8b 05 a1 35 0d 00 64
RSP: 002b:00007ffef214d608 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3002454822
RDX: 0000000000000003 RSI: 0000000000000200 RDI: 0000000000000000
RBP: 0000000000000022 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000008000 R14: 0000556fb2cd30b0 R15: 0000000000004000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

