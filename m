Return-Path: <linux-ext4+bounces-10218-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ECCB5A1DC
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 22:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3876C3BFD4A
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB132DE1E3;
	Tue, 16 Sep 2025 20:08:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC82DC775
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053312; cv=none; b=P67DvtJHz68TaWdLPesABcB7vyVn4xfkdtJeLsfTwAHrxjKJASFgXemK8xaBxwyraJyHaQi1Y74ov8TXC/r6r3i2Six3cq7SoNMZlhP6Q/lguf0PITm8UiAIKi5d9nUSBr2qvRoRf3Pq79OR+UbD6AO/aKVt+WLnqRk/UngtQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053312; c=relaxed/simple;
	bh=+VbOzmMwhChUFxAZ7NkPIust3f3E44H4BRbQcZAgMW0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ssdxsTg/hWhR8ZPPxgcaT+aKY3UbYnXo7FM2P/XKFnHrfjnhjLfBeki9J3T7g5dPEX6yWgDw4I5lK3677G6C88QEVOcSMsGJFVzKlTPgQzh1pFkLgg+PHEYvrpuH/Q8oG2z4F3HRpRA7ftEZRNu8pW4YQrJBnApXgYRMTvceOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4240cba0652so45874575ab.1
        for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 13:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053309; x=1758658109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJsA9OZjGr8DbvBujYNFSUu+r6i18upHMvEVi8Iu7o4=;
        b=u5bSNHFWvi0AF5Nj/K9dewUw5Evaij5lVIJ4wuybZeK2ZTandorFGW1wko0w4wbKRK
         Bq+o0UCXpYbQco65wMlJ0ji2B4Jul+bcECwlgUFP4cqNa6GfV9cEIsOXC/l+W49nRz4I
         qfCm9GUO13IBpQQPtFPGDRHmBIYYIAXqgLj8pcpvwju2x7/HUTA0qj5wyTHs7aw+cpdh
         V2jE7Hd4GgpInDA5xmKOmUMTirK1ByhF8TcBKqLHKgKxVfuusYsRmWXecHmzZuPnEfSv
         Vy+o0p/rIxqycmZKZHOuLAsELErp2D0JJzykGL2dV3GTzCKi0SKZde1vszpbl/rwk/Vz
         IkTw==
X-Forwarded-Encrypted: i=1; AJvYcCUaHcbm0tTCQvNZgu1DRxN+dw+RKG1IQiEg4OkgYGvTFkejQ5JavIK6+se6zwKKJ1oDUjOhLu2yKztZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYS/AoaBAnC4uy4tvbNCOfgnv1oGPi6kY17+RSyFFbDTX6Y8NJ
	HB65tJXgsLJ053sSuDHy0wI0AMwq+cphckcQXNjvBNebDVkWTKTO9wxCU4HtdxcWJR8aP7iG2E6
	ZAukJ0yvef3WhihPEadOYX0vkokzCORHfgGBVb2bQ4NMpmQxP54mRUW99ufE=
X-Google-Smtp-Source: AGHT+IED0AkiLTjhjufPfprbW49u9ynQdGZp++3d8CFWvG6ir58nhui1QCotT8b6s6wMU2y4Z5EdFBjI6G34x++CVH7FGnxvU5Ni
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1986:b0:410:f09a:28a6 with SMTP id
 e9e14a558f8ab-4209e64b594mr197212455ab.13.1758053309576; Tue, 16 Sep 2025
 13:08:29 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:08:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9c3bd.050a0220.3c6139.0e65.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: rcu detected stall in ext4_file_mmap_prepare
From: syzbot <syzbot+fc241a3fa60015afb3d1@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3067c2c3831 Add linux-next specific files for 20250915
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15464e42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e269dbc7717119a2
dashboard link: https://syzkaller.appspot.com/bug?extid=fc241a3fa60015afb3d1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d7b47c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d7b47c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/753ebccc7349/disk-c3067c2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62984b0c436c/vmlinux-c3067c2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301e0d2bfc64/bzImage-c3067c2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc241a3fa60015afb3d1@syzkaller.appspotmail.com

sched: DL replenish lagged too much
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 GPs behind) idle=3aa4/1/0x4000000000000000 softirq=15601/15602 fqs=59
rcu: 	(detected by 0, t=10505 jiffies, g=10297, q=397 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6042 Comm: sed Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__lock_acquire+0x870/0xd20 kernel/locking/lockdep.c:5232
Code: f0 41 89 cf 41 c1 c7 13 29 ce 41 31 f7 01 c1 44 29 f8 44 01 f9 41 c1 c7 04 41 31 c7 49 c1 e7 20 49 09 cf 83 3d e4 f0 26 0e 00 <0f> 85 36 02 00 00 48 83 7c 24 28 00 0f 84 bc 01 00 00 41 8b 46 f8
RSP: 0018:ffffc90000a08b70 EFLAGS: 00000046
RAX: 00000000d6871fb1 RBX: 0000000000000003 RCX: 0000000079909773
RDX: 00000000001caf3d RSI: 00000000afae91f8 RDI: ffff88802c3c3c80
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff81adbfa2
R10: dffffc0000000000 R11: fffffbfff1f88787 R12: 0000000000000073
R13: ffff88802c3c47b0 R14: ffff88802c3c4828 R15: 4346289379909773
FS:  0000000000000000(0000) GS:ffff888125ae0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc34ea224e8 CR3: 00000000720e8000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xa2/0xf0 kernel/locking/spinlock.c:170
 __run_hrtimer kernel/time/hrtimer.c:1781 [inline]
 __hrtimer_run_queues+0x602/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xa8/0x110 kernel/locking/spinlock.c:194
Code: 74 05 e8 db e5 40 f6 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f6 44 24 21 02 75 4f f7 c3 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> f3 7c 09 f6 65 8b 05 ac 68 3d 07 85 c0 74 40 48 c7 04 24 0e 36
RSP: 0018:ffffc90002ef6fa0 EFLAGS: 00000206
RAX: c40c4dc7bc3a9000 RBX: 0000000000000a02 RCX: c40c4dc7bc3a9000
RDX: 0000000000000007 RSI: ffffffff8dbc0fba RDI: 0000000000000001
RBP: ffffc90002ef7028 R08: ffffffff8fc43c37 R09: 1ffffffff1f88786
R10: dffffc0000000000 R11: fffffbfff1f88787 R12: dffffc0000000000
R13: 0000000000000d40 R14: ffffffff8eae95b0 R15: 1ffff920005dedf4
 stack_depot_save_flags+0x41b/0x860 lib/stackdepot.c:720
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x4f/0x80 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4927 [inline]
 slab_alloc_node mm/slub.c:5226 [inline]
 kmem_cache_alloc_noprof+0x367/0x6e0 mm/slub.c:5233
 journal_alloc_journal_head fs/jbd2/journal.c:2826 [inline]
 jbd2_journal_add_journal_head+0x95/0x4b0 fs/jbd2/journal.c:2894
 jbd2_journal_get_write_access+0x1c9/0x230 fs/jbd2/transaction.c:1237
 __ext4_journal_get_write_access+0x1c3/0x570 fs/ext4/ext4_jbd2.c:242
 ext4_reserve_inode_write+0x294/0x360 fs/ext4/inode.c:6326
 __ext4_mark_inode_dirty+0x15b/0x700 fs/ext4/inode.c:6501
 ext4_dirty_inode+0xd0/0x110 fs/ext4/inode.c:6538
 __mark_inode_dirty+0x2ec/0xe10 fs/fs-writeback.c:2567
 generic_update_time fs/inode.c:2087 [inline]
 inode_update_time fs/inode.c:2100 [inline]
 touch_atime+0x59b/0x6d0 fs/inode.c:2172
 file_accessed include/linux/fs.h:2675 [inline]
 ext4_file_mmap_prepare+0x24d/0x440 fs/ext4/file.c:828
 vfs_mmap_prepare include/linux/fs.h:2412 [inline]
 call_mmap_prepare mm/vma.c:2593 [inline]
 __mmap_region mm/vma.c:2671 [inline]
 mmap_region+0xb38/0x1c70 mm/vma.c:2764
 do_mmap+0xc45/0x10d0 mm/mmap.c:558
 vm_mmap_pgoff+0x2a6/0x4d0 mm/util.c:580
 ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:604
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc34ea53242
Code: 08 00 04 00 00 eb e2 90 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 33 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5e 5b 5d c3 0f 1f 00 c7 05 46 40 01 00 16 00
RSP: 002b:00007ffc758046c8 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007fc34e7ad000 RCX: 00007fc34ea53242
RDX: 0000000000000005 RSI: 000000000014e000 RDI: 00007fc34e7ad000
RBP: 0000000000000812 R08: 0000000000000003 R09: 0000000000028000
R10: 0000000000000812 R11: 0000000000000206 R12: 00007ffc75804718
R13: 00007fc34ea275f0 R14: 00007ffc75804f00 R15: 00000fff8eb008dc
 </TASK>
rcu: rcu_preempt kthread starved for 10210 jiffies! g10297 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26696 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5360 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6964
 __schedule_loop kernel/sched/core.c:7046 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7061
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 5873 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0xd33/0x12d0 kernel/smp.c:877
Code: 45 8b 2c 24 44 89 ee 83 e6 01 31 ff e8 e6 7f 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 91 7b 0b 00 eb 38 f3 90 <42> 0f b6 04 2b 84 c0 75 11 41 f7 04 24 01 00 00 00 74 1e e8 75 7b
RSP: 0000:ffffc900039f7700 EFLAGS: 00000293
RAX: ffffffff81b457ab RBX: 1ffff110170e8005 RCX: ffff88801ffb1e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900039f7880 R08: ffffffff8fc43c37 R09: 1ffffffff1f88786
R10: dffffc0000000000 R11: fffffbfff1f88787 R12: ffff8880b8740028
R13: dffffc0000000000 R14: ffff8880b863b240 R15: 0000000000000001
FS:  00007f45a83bc880(0000) GS:ffff8881259e0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005593b3898568 CR3: 000000007210a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1044
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x6b1/0x12d0 arch/x86/mm/tlb.c:1451
 flush_tlb_page arch/x86/include/asm/tlbflush.h:324 [inline]
 ptep_clear_flush+0x120/0x170 mm/pgtable-generic.c:101
 wp_page_copy mm/memory.c:3780 [inline]
 do_wp_page+0x1bc2/0x5800 mm/memory.c:4175
 handle_pte_fault mm/memory.c:6233 [inline]
 __handle_mm_fault+0x102e/0x5440 mm/memory.c:6360
 handle_mm_fault+0x40a/0x8e0 mm/memory.c:6529
 do_user_addr_fault+0xa81/0x1390 arch/x86/mm/fault.c:1336
 handle_page_fault arch/x86/mm/fault.c:1476 [inline]
 exc_page_fault+0x82/0x100 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x7f45a7cb5b69
Code: 10 48 81 f9 ff 03 00 00 76 28 48 8b 57 20 48 85 d2 74 1f 48 3b 7a 28 75 76 48 8b 4f 28 48 3b 79 20 75 6c 48 83 78 20 00 74 17 <48> 89 4a 28 48 89 51 20 48 83 c4 08 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffca257670 EFLAGS: 00010202
RAX: 00007f45a7df21d0 RBX: 00005593b3898540 RCX: 00005593b3898540
RDX: 00005593b3898540 RSI: 00007f45a7df21d0 RDI: 00005593b3898540
RBP: 00007f45a7df1ac0 R08: 0000000000002760 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000049c0
R13: 00005593b389cf00 R14: 0000000000002020 R15: 00007f45a7df1ac0
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

