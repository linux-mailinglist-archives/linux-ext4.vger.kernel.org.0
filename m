Return-Path: <linux-ext4+bounces-5392-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991079D7A2D
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 03:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24135162CA5
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2024 02:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890F914A8B;
	Mon, 25 Nov 2024 02:49:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F47539A
	for <linux-ext4@vger.kernel.org>; Mon, 25 Nov 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732502963; cv=none; b=iQphb0L3zEvsdHbTi8epi159n5oHCKikdPD3Vkk9V+CkjMzn8cfL9HsJajSol+xVo4hyu5Ok9FYZZQ/bkBk1hzP/ZYlunN4J+iUbISSRRPSEmk+YdnKstoTjwpfNGCtVdIMgZX8spRLws7cwRSjfIwpkmGe8J5yv5GTOerL/Ups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732502963; c=relaxed/simple;
	bh=1BXQMK2TshcPst43azJRFDcsyEglT7uGlN00Sp0ApCY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VQOUkqknN9iP1zG/SVtiNR3pBMA/7sNa6WhfbQia4EO4Zitu5bNTPRmPx59sCiy1Uu4lPJkVYYA7ZHVNbNkcAfyBbpIBT7fMUDs6j//LT6reyEU1xegvKMbb1Yan8by9GOZpDQAqn3f+Iv2u1JWn4EVl+pXL0wz/UuK+CSipSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8419aa46a87so52172939f.2
        for <linux-ext4@vger.kernel.org>; Sun, 24 Nov 2024 18:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732502960; x=1733107760;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tADKWwQ+ZIO08AuvmXO1BBaNjYoiJ4m+/SUde8w0dvU=;
        b=Wui/4NQLjKFuzsoyM31PCBIG4NyhEX8oU7YLIy5Z1+0eKKGPM3EgtFEM2mlkTf9ROq
         8exs+uxRMbiVl3hkDkDC678FQ6oONeh6d+l+haJpkgb0bhQfXJCCHfo93c/KouiiCqTB
         sw/xkdR7XUZVGXcqErEIBvs00FB9+ejnYVBR6WFfeCZqnOh0Xuz9/43LK+48dUzTgR0z
         XxNkz0Fj/+c0+p9JHMzjVFbvu2/v2IKgFPG2ZqdUUsw7ES5m0/ozCeZUocOjrFge7XdE
         ovAdmjkWaER0nLgKGIhoE7TZ03uQhqAgSKC5rl3dAYrMWJoxRRMOysiCIJMFeXyVTzg6
         utpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfKBgSxgzwKuS+K99s1gF3vtBiLLRHSkbg9pBE8OHj5ItykUuSwnpHdUhOKANHpIagsAL/QWlYjx2A@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mSkmK97W2a7hS3YXfiLTR2HYvl1TU7dJnfA6zfurI1/5gVig
	7mztCIP0RwyVccjTZ/uPiakDgmJjyS3dnEvmedLdhGx1ZwOwhwk11AFfmkf/wWappTZiXyfDdOT
	TUCLDkJADVVBuHd3F3c1p/keH1cDINzx/mwJpowCZ7rOGkOzkMPQYiM4=
X-Google-Smtp-Source: AGHT+IFBquSOhUk7V7yxiV8ihF4ZeKlK40Ii1Mg8eYTLDM5G/XL+XNdVDqa0zrO79BXxH+NpEf8gdU662zyEquu1dh5tZ49eQLrF
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:3a6:c86b:6d53 with SMTP id
 e9e14a558f8ab-3a79aff6416mr110442415ab.24.1732502959711; Sun, 24 Nov 2024
 18:49:19 -0800 (PST)
Date: Sun, 24 Nov 2024 18:49:19 -0800
In-Reply-To: <67290acb.050a0220.701a.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743e5af.050a0220.1cc393.0055.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in get_page_from_freelist
From: syzbot <syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1202a530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7393f07275e8e571
dashboard link: https://syzkaller.appspot.com/bug?extid=5abecb17ba9299033d79
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177ab75f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a4ab7536099/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a94d1bc43eff/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5abecb17ba9299033d79@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-syzkaller-09073-g9f16d5e6f220 #0 Not tainted
-----------------------------
sshd/5943 is trying to lock:
ffff88807ffd8298 (&zone->lock){..-.}-{3:3}, at: rmqueue_buddy mm/page_alloc.c:2907 [inline]
ffff88807ffd8298 (&zone->lock){..-.}-{3:3}, at: rmqueue mm/page_alloc.c:3080 [inline]
ffff88807ffd8298 (&zone->lock){..-.}-{3:3}, at: get_page_from_freelist+0xbbe/0x2f80 mm/page_alloc.c:3471
other info that might help us debug this:
context-{2:2}
3 locks held by sshd/5943:
 #0: ffff888022f8b148 (&vma->vm_lock->lock){++++}-{4:4}, at: vma_start_read include/linux/mm.h:716 [inline]
 #0: ffff888022f8b148 (&vma->vm_lock->lock){++++}-{4:4}, at: lock_vma_under_rcu+0x13e/0x980 mm/memory.c:6278
 #1: ffff88806a944c58 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #1: ffff88806a944c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3030 [inline]
 #1: ffff88806a944c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3074 [inline]
 #1: ffff88806a944c58 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3471
 #2: ffff88806a93ebd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
stack backtrace:
CPU: 3 UID: 0 PID: 5943 Comm: sshd Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x878/0x3c40 kernel/locking/lockdep.c:5176
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 rmqueue_buddy mm/page_alloc.c:2907 [inline]
 rmqueue mm/page_alloc.c:3080 [inline]
 get_page_from_freelist+0xbbe/0x2f80 mm/page_alloc.c:3471
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 stack_depot_save_flags+0x566/0x8f0 lib/stackdepot.c:627
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 task_work_add+0xc0/0x3b0 kernel/task_work.c:77
 task_tick_numa kernel/sched/fair.c:3607 [inline]
 task_tick_fair+0x524/0x8e0 kernel/sched/fair.c:13054
 sched_tick+0x1dd/0x4f0 kernel/sched/core.c:5652
 update_process_times+0x19c/0x2d0 kernel/time/timer.c:2524
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x376/0x530 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x5fb/0xae0 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:86 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0xfb/0x1a0 mm/kasan/generic.c:189
Code: d2 74 1e 41 83 e2 07 49 39 d1 75 0a 45 3a 11 b8 01 00 00 00 7c 0b 44 89 c2 e8 e1 ea ff ff 83 f0 01 5b 5d 41 5c c3 cc cc cc cc <48> 85 d2 74 4f 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 41 80 38 00
RSP: 0000:ffffc90003e97610 EFLAGS: 00000283
RAX: fffffbfff20beb82 RBX: fffffbfff20beb83 RCX: ffffffff816b64e9
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff905f5c10
RBP: fffffbfff20beb82 R08: 0000000000000000 R09: fffffbfff20beb82
R10: ffffffff905f5c17 R11: 0000000000000001 R12: ffff88806a944c58
R13: 0000000000000070 R14: dffffc0000000000 R15: ffff88807ffd7c80
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:570 [inline]
 cpu_online include/linux/cpumask.h:1117 [inline]
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0xa9/0x6f0 kernel/locking/lockdep.c:5860
 __raw_spin_unlock include/linux/spinlock_api_smp.h:141 [inline]
 _raw_spin_unlock+0x16/0x50 kernel/locking/spinlock.c:186
 spin_unlock include/linux/spinlock.h:391 [inline]
 rmqueue_pcplist mm/page_alloc.c:3044 [inline]
 rmqueue mm/page_alloc.c:3074 [inline]
 get_page_from_freelist+0x3df/0x2f80 mm/page_alloc.c:3471
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 folio_alloc_mpol_noprof+0x36/0xd0 mm/mempolicy.c:2283
 vma_alloc_folio_noprof+0xee/0x1b0 mm/mempolicy.c:2313
 folio_prealloc mm/memory.c:1060 [inline]
 alloc_anon_folio mm/memory.c:4752 [inline]
 do_anonymous_page mm/memory.c:4809 [inline]
 do_pte_missing+0x2021/0x3e70 mm/memory.c:3977
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault+0x103c/0x2a40 mm/memory.c:5944
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
 do_user_addr_fault+0x60d/0x13f0 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x558b31029823
Code: 4c 89 ed 4c 89 e7 f3 aa eb 48 4c 89 e7 e8 95 48 f7 ff 48 89 c5 48 85 c0 74 38 48 89 c7 4c 89 ee 4d 39 f4 76 11 4c 89 f1 31 c0 <f3> a4 4c 89 e1 4c 29 f1 f3 aa eb 05 4c 89 e1 f3 a4 4c 89 ef 48 83
RSP: 002b:00007ffc18dbe180 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000350000 RCX: 000000000011e010
RDX: 0000000000000002 RSI: 00007fa8c26db000 RDI: 00007fa8c238a000
RBP: 00007fa8c2160010 R08: 00007fa8c2160010 R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000350000
R13: 00007fa8c24b1010 R14: 0000000000348000 R15: 00007ffc18dbe338
 </TASK>
----------------
Code disassembly (best guess):
   0:	d2 74 1e 41          	shlb   %cl,0x41(%rsi,%rbx,1)
   4:	83 e2 07             	and    $0x7,%edx
   7:	49 39 d1             	cmp    %rdx,%r9
   a:	75 0a                	jne    0x16
   c:	45 3a 11             	cmp    (%r9),%r10b
   f:	b8 01 00 00 00       	mov    $0x1,%eax
  14:	7c 0b                	jl     0x21
  16:	44 89 c2             	mov    %r8d,%edx
  19:	e8 e1 ea ff ff       	call   0xffffeaff
  1e:	83 f0 01             	xor    $0x1,%eax
  21:	5b                   	pop    %rbx
  22:	5d                   	pop    %rbp
  23:	41 5c                	pop    %r12
  25:	c3                   	ret
  26:	cc                   	int3
  27:	cc                   	int3
  28:	cc                   	int3
  29:	cc                   	int3
* 2a:	48 85 d2             	test   %rdx,%rdx <-- trapping instruction
  2d:	74 4f                	je     0x7e
  2f:	48 01 ea             	add    %rbp,%rdx
  32:	eb 09                	jmp    0x3d
  34:	48 83 c0 01          	add    $0x1,%rax
  38:	48 39 d0             	cmp    %rdx,%rax
  3b:	74 41                	je     0x7e
  3d:	80 38 00             	cmpb   $0x0,(%rax)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

