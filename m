Return-Path: <linux-ext4+bounces-13768-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHW9I1dum2lNzgMAu9opvQ
	(envelope-from <linux-ext4+bounces-13768-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Feb 2026 22:00:07 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C293F170606
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Feb 2026 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AB44301015A
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Feb 2026 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD50B1F8691;
	Sun, 22 Feb 2026 20:59:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355A1A9F94
	for <linux-ext4@vger.kernel.org>; Sun, 22 Feb 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793976; cv=none; b=BnwkWrUyI9zEuhj9qFzB6zCftfzZ3SMaW8mss0BBPaRdKtf+nFX3d7sSxQHWMDvBd+M1u2GG1npeC8HNL+/7OL8ei5iKOOm2I6BGpGRFpUiwL+qfrl7a90R9CyQIEVseE3Woc9Flf8JhlWlhn5z6v+m+SGAFjc++k5PI0PrSk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793976; c=relaxed/simple;
	bh=gHbqcyWrnknI5+8IkEGauVFljz8Po3Uefy8XWruAvus=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nRnkfk6p3y3o7hND4CmOlu8BUC6nQ321SVnMhNyhqc+63fI0Rjc638C606xRVdbCYcHRCYN9nxjuJ776JwzalAC9fekk03iaIkZ/EtlSuhP0fdGJB38YTjoCJxZaE1fIzJiAVEUk8utoPjoPe//Q/W79VLw+tBIfpFZOvVM491M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679943693c0so65902309eaf.3
        for <linux-ext4@vger.kernel.org>; Sun, 22 Feb 2026 12:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771793974; x=1772398774;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INI28ToyaBl4GcejPixOElR+flAKJB27RmFL3KF/lzY=;
        b=h34mfW28gsTPnePCJZA9CiKNYiVyQoY4zbhKZw4jePd6Pwv4IZR+bkhfM8o7AfXWp1
         ecreqSRBbVma9p1pMaw9WWtjH+be/dOhAsTAa2K4tMsCdVbmGLEuRUr3dAQFpA+bLcOz
         ppvKQsH1oATEHEqk8LEv9AMRuxAkpTqA6uoCpGjvopdQqQfmCtxiqBvrqWRpNlgNd8Ui
         PQ3v/YczsKm499LFbpAWmsr1sOrvnlbTQdTQX0SEtAAxv3pQyK0TfgcvvhZhAisIYaFj
         N3VmZMDSW7ahF58gJIu67a0rY/+xoWQYURefCTkbyu2ZrwcJUgrjKwG8ljgmgNcrQ/Lg
         KL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3uNckbK5O1NiRAH6rK9tI+kfswcyb2jr9EeDzBugYWXumsokeBZ0TN31FNlr/fhbG2mA7zOuZcgsb@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Nbawo5C+O3x6FpVsKIUbkhG1+Qc4rR9f/gZWPRZ5rMQRjMk9
	pwS7cwoJd0CT+NPrUytUhikP3LntLLr8/hcA/K3/TUri6bMChjfLPalcoF+WtE9jmZyUCaQtIfA
	xCqHrzMdDOiWXopZVaWTh90jHPRda3k4aoXWtFpSsRh8U0veVLvgRyJidAqQ=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2285:b0:659:9a49:9047 with SMTP id
 006d021491bc7-679c4278245mr3416090eaf.18.1771793973977; Sun, 22 Feb 2026
 12:59:33 -0800 (PST)
Date: Sun, 22 Feb 2026 12:59:33 -0800
In-Reply-To: <6953bc09.050a0220.329c0f.0592.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699b6e35.a70a0220.2c38d7.0182.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in wait_transaction_locked (3)
From: syzbot <syzbot+5d19358d7eb30ffb0cc5@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=35a2f9886a9bccfa];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13768-lists,linux-ext4=lfdr.de,5d19358d7eb30ffb0cc5];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: C293F170606
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    32a92f8c8932 Convert more 'alloc_obj' cases to default GFP..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a7d95a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35a2f9886a9bccfa
dashboard link: https://syzkaller.appspot.com/bug?extid=5d19358d7eb30ffb0cc5
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1543055a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104f8006580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c446301a138/disk-32a92f8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/245be1b900af/vmlinux-32a92f8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16e0d6bc53db/bzImage-32a92f8c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1c55fb38005a/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14a3a55a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d19358d7eb30ffb0cc5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:11/1186 is trying to acquire lock:
ffff888036d5ebb0 (jbd2_handle){++++}-{0:0}, at: wait_transaction_locked+0x1a9/0x280 fs/jbd2/transaction.c:151

but task is already holding lock:
ffff888036d52c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
ffff888036d52c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1813 [inline]
ffff888036d52c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x205/0x3b0 fs/ext4/inode.c:3018

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sbi->s_writepages_rwsem){++++}-{0:0}:
       percpu_down_read_internal+0x48/0x1d0 include/linux/percpu-rwsem.h:53
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       ext4_writepages_down_read fs/ext4/ext4.h:1813 [inline]
       ext4_writepages+0x205/0x3b0 fs/ext4/inode.c:3018
       do_writepages+0x32e/0x550 mm/page-writeback.c:2554
       __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1749
       writeback_single_inode+0x488/0xd60 fs/fs-writeback.c:1868
       write_inode_now+0x1c2/0x290 fs/fs-writeback.c:2953
       iput_final fs/inode.c:1956 [inline]
       iput+0x8c1/0xe80 fs/inode.c:2015
       ext4_xattr_block_set+0x1fd4/0x2ad0 fs/ext4/xattr.c:2204
       ext4_xattr_move_to_block fs/ext4/xattr.c:2669 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2744 [inline]
       ext4_expand_extra_isize_ea+0x12cf/0x1ea0 fs/ext4/xattr.c:2832
       __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6297
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:6340 [inline]
       __ext4_mark_inode_dirty+0x45c/0x730 fs/ext4/inode.c:6418
       ext4_evict_inode+0x7a1/0xeb0 fs/ext4/inode.c:255
       evict+0x61e/0xb10 fs/inode.c:846
       ext4_orphan_cleanup+0xc38/0x1470 fs/ext4/orphan.c:472
       __ext4_fill_super fs/ext4/super.c:5668 [inline]
       ext4_fill_super+0x5a0b/0x6320 fs/ext4/super.c:5791
       get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
       vfs_get_tree+0x92/0x2a0 fs/super.c:1754
       fc_mount fs/namespace.c:1193 [inline]
       do_new_mount_fc fs/namespace.c:3760 [inline]
       do_new_mount+0x341/0xd30 fs/namespace.c:3836
       do_mount fs/namespace.c:4159 [inline]
       __do_sys_mount fs/namespace.c:4348 [inline]
       __se_sys_mount+0x31d/0x420 fs/namespace.c:4325
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ei->xattr_sem){++++}-{4:4}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1590
       ext4_write_lock_xattr fs/ext4/xattr.h:157 [inline]
       ext4_xattr_set_handle+0x19c/0x14c0 fs/ext4/xattr.c:2372
       ext4_initxattrs+0x9f/0x110 fs/ext4/xattr_security.c:44
       security_inode_init_security+0x296/0x3d0 security/security.c:1344
       __ext4_new_inode+0x332f/0x3d20 fs/ext4/ialloc.c:1324
       ext4_create+0x233/0x470 fs/ext4/namei.c:2820
       lookup_open fs/namei.c:4483 [inline]
       open_last_lookups fs/namei.c:4583 [inline]
       path_openat+0x13b4/0x38a0 fs/namei.c:4827
       do_file_open+0x23e/0x4a0 fs/namei.c:4859
       do_sys_openat2+0x113/0x200 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (jbd2_handle){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
       wait_transaction_locked+0x1c2/0x280 fs/jbd2/transaction.c:151
       add_transaction_credits fs/jbd2/transaction.c:222 [inline]
       start_this_handle+0x7dc/0x2290 fs/jbd2/transaction.c:403
       jbd2__journal_start+0x2c0/0x5b0 fs/jbd2/transaction.c:501
       __ext4_journal_start_sb+0x203/0x620 fs/ext4/ext4_jbd2.c:114
       __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
       ext4_do_writepages+0xf97/0x46e0 fs/ext4/inode.c:2907
       ext4_writepages+0x241/0x3b0 fs/ext4/inode.c:3019
       do_writepages+0x32e/0x550 mm/page-writeback.c:2554
       __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1749
       writeback_sb_inodes+0x944/0x1970 fs/fs-writeback.c:2040
       __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2117
       wb_writeback+0x46a/0xb70 fs/fs-writeback.c:2228
       wb_check_old_data_flush fs/fs-writeback.c:2332 [inline]
       wb_do_writeback fs/fs-writeback.c:2385 [inline]
       wb_workfn+0xb52/0xf60 fs/fs-writeback.c:2413
       process_one_work kernel/workqueue.c:3275 [inline]
       process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
       worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
       kthread+0x388/0x470 kernel/kthread.c:467
       ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  jbd2_handle --> &ei->xattr_sem --> &sbi->s_writepages_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->s_writepages_rwsem);
                               lock(&ei->xattr_sem);
                               lock(&sbi->s_writepages_rwsem);
  lock(jbd2_handle);

 *** DEADLOCK ***

4 locks held by kworker/u8:11/1186:
 #0: ffff88801f6af138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3250 [inline]
 #0: ffff88801f6af138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x9ea/0x1830 kernel/workqueue.c:3358
 #1: ffffc90006487c40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3251 [inline]
 #1: ffffc90006487c40 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0xa25/0x1830 kernel/workqueue.c:3358
 #2: ffff888036d540d0 (&type->s_umount_key#32){++++}-{4:4}, at: super_trylock_shared+0x20/0xf0 fs/super.c:565
 #3: ffff888036d52c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
 #3: ffff888036d52c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1813 [inline]
 #3: ffff888036d52c58 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x205/0x3b0 fs/ext4/inode.c:3018

stack backtrace:
CPU: 1 UID: 0 PID: 1186 Comm: kworker/u8:11 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 wait_transaction_locked+0x1c2/0x280 fs/jbd2/transaction.c:151
 add_transaction_credits fs/jbd2/transaction.c:222 [inline]
 start_this_handle+0x7dc/0x2290 fs/jbd2/transaction.c:403
 jbd2__journal_start+0x2c0/0x5b0 fs/jbd2/transaction.c:501
 __ext4_journal_start_sb+0x203/0x620 fs/ext4/ext4_jbd2.c:114
 __ext4_journal_start fs/ext4/ext4_jbd2.h:242 [inline]
 ext4_do_writepages+0xf97/0x46e0 fs/ext4/inode.c:2907
 ext4_writepages+0x241/0x3b0 fs/ext4/inode.c:3019
 do_writepages+0x32e/0x550 mm/page-writeback.c:2554
 __writeback_single_inode+0x133/0x11a0 fs/fs-writeback.c:1749
 writeback_sb_inodes+0x944/0x1970 fs/fs-writeback.c:2040
 __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2117
 wb_writeback+0x46a/0xb70 fs/fs-writeback.c:2228
 wb_check_old_data_flush fs/fs-writeback.c:2332 [inline]
 wb_do_writeback fs/fs-writeback.c:2385 [inline]
 wb_workfn+0xb52/0xf60 fs/fs-writeback.c:2413
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

