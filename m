Return-Path: <linux-ext4+bounces-12297-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF75CB610D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 106C6301501B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DC3148CD;
	Thu, 11 Dec 2025 13:41:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C83128AC
	for <linux-ext4@vger.kernel.org>; Thu, 11 Dec 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765460487; cv=none; b=RVVxmfVcIdJkvh5Bk7q+DtXqSqs+oVw+BRqMzZNljY4OMropra0x/hYHSo3MMg/UxpWKBmz8cQD35knehUjPzWo0WZRKslKYbwCQNsktcADiqAVpSkZpcb6hE6Fnnspf+l5GNidW3O6vMppWbeMluyyGn1LOKXaMwcoUaQqu4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765460487; c=relaxed/simple;
	bh=HZe4g9ruHX10D7uCX+1s9yHG0wDEJuqpdhn/oCLNUsM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qD+O428G1yh4mahEbNPM27zrTXxSy9LhaBSD+uu5eTnFgLSQTJ1Ci7hBMpOJjmt/Z+jyd/lb+jnM+Bte2ip+B553pCrQHez1uJs+NluVuwlcYazZadeHxae5aCf+LKsfCl9YaCu1XmVguaLDBbMdUjIkAZUD2cyQFJ9dSP2W7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c673f5f4b6so125422a34.1
        for <linux-ext4@vger.kernel.org>; Thu, 11 Dec 2025 05:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765460484; x=1766065284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e26r2lBSB9U9+iAS+sF7y0aqgor1MSsGTiqe7tt1Wmk=;
        b=wsIudFXw245tNBVmnwj/38xqKFxRDXU7hoeJ1M6jSpLEVmhT2EQbJQ+QEEC17iRUDo
         LT+0dQB8ULYLwp9oaznsBTewhLFzFcfbFEkoMEO0434lAeAPSplWfSRUZ9/VZ1hn1cwW
         xX23oB0aTAs34y0L9ZjBzR2jfsVQ4zjHGqhOhsQNIrtaw5pZa8W+4cQXcwP/eAa9zPLp
         Ad4eS7wNReEapg5mlbU9mi8YbI6Xbnf2GxQAklaM6miSr+/UYDlWR/GYxhKva3iQ8Mz2
         yE4gws7rqqY2rC2XzSip3R92qxFccTbn2HFuJA+sXhjJ2c1N2CSxFMFRN5ACzfNdCiIT
         JWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfEt5Ji7Cw8NmMTs2uqe3sxzyrKeOxJ8JGi8Ns36C3H2R/zElLYrLde0C3SEjgWQZGFm6Q0+ZwuP9O@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0Igw3b8WWzGK0fbsz95ueVNms3kckmvMX/dq2/uvoyEyxqAH
	EVnB+LSOqaNwMzM20sN7BMGhIOZvF3sQW8i/AdwWTg/erqEKVxe9t+vkmy1iYcCDx4Rni7jIslP
	CoZGehrHT1A6cseh5z67Ls1nW1Bz5gnxVC13xjUqTIc5fXk4C3WR2+y6xfbg=
X-Google-Smtp-Source: AGHT+IH6u5v5l78c4T6l7pXToAOHMAd7ydUGNbgDQnJPu4vOlgj+aRReDmZdXoFBTjErqq8rzyGmfYeFlSIq2/rzfZm1IWFkLgNB
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d0b:b0:656:b1fb:a8fd with SMTP id
 006d021491bc7-65b2ac6c264mr3405234eaf.1.1765460484415; Thu, 11 Dec 2025
 05:41:24 -0800 (PST)
Date: Thu, 11 Dec 2025 05:41:24 -0800
In-Reply-To: <68eda73d.a70a0220.b3ac9.0022.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693aca04.050a0220.4004e.0347.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: rcu detected stall in unwind_next_frame (5)
From: syzbot <syzbot+0f5d9b52b3f467f78d36@syzkaller.appspotmail.com>
To: bp@alien8.de, brauner@kernel.org, dave.hansen@linux.intel.com, 
	hpa@zytor.com, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5ce74bc1b7cb Add linux-next specific files for 20251211
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10fd91c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9f785244b836412
dashboard link: https://syzkaller.appspot.com/bug?extid=0f5d9b52b3f467f78d36
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a2261a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f00592580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e550c10060d5/disk-5ce74bc1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80331ba2b4cc/vmlinux-5ce74bc1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bcb4f82dfcf/bzImage-5ce74bc1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0f5d9b52b3f467f78d36@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5976/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=13301, q=280 ncpus=2)
task:kworker/u8:2    state:R  running task     stack:24320 pid:5976  tgid:5976  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: kvfree_rcu_reclaim kfree_rcu_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7190
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x16c/0x340 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 74 e0 24 11 <48> 3b 44 24 58 0f 85 e5 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003a772d8 EFLAGS: 00000206
RAX: a754b79da94c6400 RBX: 0000000000000000 RCX: a754b79da94c6400
RDX: 00000000c3648bbc RSI: ffffffff8dc8f224 RDI: ffffffff8be251e0
RBP: ffffffff81747f85 R08: ffffffff81747f85 R09: ffffffff8e341a60
R10: ffffc90003a77498 R11: ffffffff81ade980 R12: 0000000000000002
R13: ffffffff8e341a60 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xc2/0x23d0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free_freelist_hook mm/slub.c:2569 [inline]
 slab_free_bulk mm/slub.c:6703 [inline]
 kmem_cache_free_bulk+0x3fb/0xdb0 mm/slub.c:7390
 kfree_bulk include/linux/slab.h:830 [inline]
 kvfree_rcu_bulk+0xe5/0x1f0 mm/slab_common.c:1523
 kfree_rcu_work+0xed/0x170 mm/slab_common.c:1601
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: rcu_preempt kthread starved for 10543 jiffies! g13301 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27136 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 13 d0 22 00 f3 0f 1e fa fb f4 <e9> c8 ed 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: 77582282823a1b00 RBX: ffffffff8197d83a RCX: 77582282823a1b00
RDX: 0000000000000001 RSI: ffffffff8daa54ce RDI: ffffffff8be251e0
RBP: ffffc90000197f10 R08: ffff8880b87336db R09: 1ffff110170e66db
R10: dffffc0000000000 R11: ffffed10170e66dc R12: ffffffff8fc3cc70
R13: 1ffff11003adcb70 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125ae6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002200 CR3: 0000000075c16000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1ea/0x520 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

