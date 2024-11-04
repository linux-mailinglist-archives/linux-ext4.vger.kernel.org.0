Return-Path: <linux-ext4+bounces-4945-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7369BBCAF
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 18:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FA57B22533
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D91C9B87;
	Mon,  4 Nov 2024 17:56:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEE1C8787
	for <linux-ext4@vger.kernel.org>; Mon,  4 Nov 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742990; cv=none; b=MXtDPWvY9NtsFFRST4Mb7K6mgCwKnix1QL58w/LqAXNVSSxOKA3Qk8BhP17RzFye5cArkUAmOsENMucyOBLPQjYZ2fDqunrD9nCVJ9Lp9HRS9CRjggslM5IGfysIR9LJtZHPVHx1N1zLvbJ7Bn9lLb3ILcDbnzJxjlNnGXeUh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742990; c=relaxed/simple;
	bh=lNtcmOfT4ccpstejHykEkfUBdMUN3ixJVRrgLzyJKi0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ifKSYT1eiODvZH2jTPusSlj7ZdZuIoOmU/30LxuWU3xFbt7f11rGUMuMd0g3ReeXbx0Hto/FwC0PBNOa6ZQg8etbPuN4rQFKbUjjNJiD0dOr/cOT8nAC8/4ArbsYH+09+AWUZUdZmeVooRAJFB9l2GhOay16ffmMxQoWAsRltxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so31644555ab.1
        for <linux-ext4@vger.kernel.org>; Mon, 04 Nov 2024 09:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742988; x=1731347788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8TPx3dxKuXTbG9hHgtxxd7PQYht3TX5xdoXUOaGlSM=;
        b=QK1pXOgFVaXQlhxerkgn8Kty5ttZVEO+S9kcjIWSm1tS4Zix3wAaEdk1167zC70bvz
         Fz+GRGKEV0N/nBehMy435Xc/54DJQqYDnKJ/9nkZxpVKKS6JJYZWUp7IRxkuWucWVF3a
         D3/2RrJXo229OhqMdnRHzDaCwICbemzpWWCLEQ1IKuZCPyTKbh/9/Hy6oy9pR3hwxG9b
         VG/sO7Bg6BNW+Tn2hM4hyE6k7N6Li00GtqrQSthlxuAzCILuj8dS9hrs0mDLtUDNL+Tn
         2gBmexztdwf1nzOjmKtQIlaMZa3pBSavIw2oUWmc9yfLNEap08llwlmp4jHKQ32V5OQP
         OsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Jx2aygYBGMVMB2I/MLd04pN7ZVWAwpXa9/QpXMap/kjrg6E7O25vtemGNXdoobda/VXJGHtgjkJa@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoqfT1LMcVb361OnbbsWbdMhksNgmx27mf57ubT+TA+zVcScV
	VXZxp7BrM1U88XCAkQtXCa/5hKbkEXme5fXgsc8Ulxd0ggbnMEA1BrqmEMRNQK3NOp6bPvaOSAu
	Xr4ErMYvPhM/Sr3mY08h4UyUYuPWq/QVInJjQ7vh7bA6O2FU1bzHPqQ0=
X-Google-Smtp-Source: AGHT+IEXrbFeMDvorzzwyU1/o9M+Fw4KN1EsgQeKrsVwozAqoufhO1A56dOWIPm4Nifi1sGG6wt+kY+Zeg4Eq9m7W32DtsSESE36
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2186:b0:3a6:b1b0:6799 with SMTP id
 e9e14a558f8ab-3a6b1b067ecmr127767015ab.10.1730742987892; Mon, 04 Nov 2024
 09:56:27 -0800 (PST)
Date: Mon, 04 Nov 2024 09:56:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67290acb.050a0220.701a.000f.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in get_page_from_freelist
From: syzbot <syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1306e55f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=5abecb17ba9299033d79
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-rc5-next-20241031-syzkaller #0 Not tainted
-----------------------------
syz.5.314/7533 is trying to lock:
ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: rmqueue_buddy mm/page_alloc.c:2928 [inline]
ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: rmqueue mm/page_alloc.c:3101 [inline]
ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: get_page_from_freelist+0xb60/0x3870 mm/page_alloc.c:3492
other info that might help us debug this:
context-{2:2}
3 locks held by syz.5.314/7533:
 #0: ffff88806324a420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88806366e708 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:852 [inline]
 #1: ffff88806366e708 (&type->i_mutex_dir_key#3/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4520
 #2: ffff8880b8644618 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #2: ffff8880b8644618 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3051 [inline]
 #2: ffff8880b8644618 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3095 [inline]
 #2: ffff8880b8644618 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x7e2/0x3870 mm/page_alloc.c:3492
stack backtrace:
CPU: 0 UID: 0 PID: 7533 Comm: syz.5.314 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 rmqueue_buddy mm/page_alloc.c:2928 [inline]
 rmqueue mm/page_alloc.c:3101 [inline]
 get_page_from_freelist+0xb60/0x3870 mm/page_alloc.c:3492
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4771
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
 kasan_save_stack+0x4f/0x60 mm/kasan/common.c:48
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 task_work_add+0xd9/0x490 kernel/task_work.c:77
 __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1219 [inline]
 run_posix_cpu_timers+0x6ac/0x810 kernel/time/posix-cpu-timers.c:1418
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x551/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1817
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 1e ca 31 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 53 9e 95 f5 65 8b 05 74 43 36 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000322e6c0 EFLAGS: 00000206
RAX: 17152d909170b000 RBX: 1ffff92000645cdc RCX: ffffffff8170c69a
RDX: dffffc0000000000 RSI: ffffffff8c0ad3a0 RDI: 0000000000000001
RBP: ffffc9000322e748 R08: ffffffff942cd847 R09: 1ffffffff2859b08
R10: dffffc0000000000 R11: fffffbfff2859b09 R12: dffffc0000000000
R13: 1ffff92000645cd8 R14: ffffc9000322e6e0 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 rmqueue_bulk mm/page_alloc.c:2347 [inline]
 __rmqueue_pcplist+0x22e8/0x2b70 mm/page_alloc.c:3022
 rmqueue_pcplist mm/page_alloc.c:3064 [inline]
 rmqueue mm/page_alloc.c:3095 [inline]
 get_page_from_freelist+0x895/0x3870 mm/page_alloc.c:3492
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4771
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 stack_depot_save_flags+0x666/0x830 lib/stackdepot.c:627
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x51/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4160
 mempool_alloc_noprof+0x197/0x5a0 mm/mempool.c:402
 bio_alloc_bioset+0x26f/0x1130 block/bio.c:554
 bio_alloc include/linux/bio.h:374 [inline]
 submit_bh_wbc+0x275/0x580 fs/buffer.c:2794
 ext4_read_bh_lock+0x8d/0xc0 fs/ext4/super.c:211
 ext4_bread_batch+0x24c/0x4e0 fs/ext4/inode.c:937
 __ext4_find_entry+0x1051/0x1b30 fs/ext4/namei.c:1627
 ext4_lookup_entry fs/ext4/namei.c:1729 [inline]
 ext4_lookup+0x15f/0x750 fs/ext4/namei.c:1797
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
 do_unlinkat+0x297/0x830 fs/namei.c:4521
 do_coredump+0x20e3/0x3100 fs/coredump.c:669
 get_signal+0x13fc/0x1740 kernel/signal.c:2869
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ce317e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6ce15f6038 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: 0000000000000000 RBX: 00007f6ce3335f80 RCX: 00007f6ce317e719
RDX: 00000000200000c0 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00007f6ce31f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6ce3335f80 R15: 00007ffdd07ea2b8
 </TASK>
----------------
Code disassembly (best guess):
   0:	9c                   	pushf
   1:	8f 44 24 20          	pop    0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 1e ca 31 f6       	call   0xf631ca32
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 52                	jne    0x6d
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 53 9e 95 f5       	call   0xf5959e82 <-- trapping instruction
  2f:	65 8b 05 74 43 36 74 	mov    %gs:0x74364374(%rip),%eax        # 0x743643aa
  36:	85 c0                	test   %eax,%eax
  38:	74 43                	je     0x7d
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


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

