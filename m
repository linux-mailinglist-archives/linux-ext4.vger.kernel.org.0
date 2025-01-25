Return-Path: <linux-ext4+bounces-6234-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC68A1C0EF
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2025 05:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE4E188B43C
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2025 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803AE207665;
	Sat, 25 Jan 2025 04:35:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A260205ABB
	for <linux-ext4@vger.kernel.org>; Sat, 25 Jan 2025 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737779727; cv=none; b=VUT4tu6J1uZ/osKtWvM2II0OzZ1gTUjvr+Ny4UWQpNNrt7n4k2/8PNjTstr2aJGQ9U6J6ijJiMRnz4NCjNDtCV8fTO0Lk8PTaEQylePgQ10COf+pNdw/7cffE3S5VyCYD9UK1W2KbLmF1k4+4chI+SLBFZBmk3U4dI+yfqUtFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737779727; c=relaxed/simple;
	bh=k0gATaVPQRp4MC+dwTc5/FayBiedGKTlvZ52KGmpgPM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L7DlUBeT2oz+4Ik/ujLbf7w9tFCn/BIoRP34PqznlMA/CoQ64RrBREdxUmCukUXlAmKvZdMT+w8c8mT70EUHVPbtyPTrn2zMzD0ioaqeYUXEwweQAeE66JqheUMV3tz3z43badXTeFQwSgO4iZ+5ksq2iWUULs1BYcgMb6gffZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso50128885ab.0
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jan 2025 20:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737779724; x=1738384524;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UhLPGDfILXYWH+W657+l+S/+kpRGHhilwMz00vr4dQ=;
        b=N0zWFjhPA9IO+jTq4T/3/q4PMm6KHjMsnEgg/sKRLPt7rYelcLttIVfoUQZwZknQdF
         H0bgM2yRTfaA2PgXkD8gn6iFpEOzoffiiXJdMhcH62hagFH6vuMSlDhg0HuZO7u33QBM
         kvXz+P1fXZSkBcLvOcWKB2QEcO5+cXJ121CeATHoh6NeuJV5VG3n+OPty1IPQrtv7gsa
         GRyX2mSvPHgEGWLiS2nH7pqBzmhsu1xA2U2T6B+NNJbXa8IU3kKTuF52SQqHlWV9NYbK
         VG7SmIGvDfrUOrZP3iQUqJK++ZpriDljNcwcgkj4xk8+MPIMxFDFzCo9f98TnjySrOGB
         yXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfY2+tmL5aD5PVEANFCJb2LcG3gcfctLttwNSF5Y08UQZVvlBSvn9fuA843gXm2p9TH7fAIPY612lP@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRZVMTb9pm8TAOI6+YgH239TRF6aHtvMQ3XTtygNMihKqGfYQ
	ksMWFyAb3gsB1i2BNeYTW3VtuUje6x3wrJdSs1/hYaC631RufQqzjC9z0qncop5IGLdGWtvYZmM
	T935UZHztpmZvxqDGNf877VjWUsbwSvf5pN0konKwPqsFKjEfSr5gXb0=
X-Google-Smtp-Source: AGHT+IHc6FIDw2wfSdyH7kxKh7Iet9eqqp218deiQilcF2Se4tEPjc/Sq25VCS4B8wBQ83PCnKR4kJlfu0YazjhVYvE2TlnXQLww
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3ce:8e89:90c2 with SMTP id
 e9e14a558f8ab-3cf7443c362mr275180785ab.13.1737779724627; Fri, 24 Jan 2025
 20:35:24 -0800 (PST)
Date: Fri, 24 Jan 2025 20:35:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67946a0c.050a0220.3ab881.0010.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: rcu detected stall in sys_mkdir (9)
From: syzbot <syzbot+21889604e13b9172a50b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, bp@alien8.de, davem@davemloft.net, hpa@zytor.com, 
	jhs@mojatatu.com, jiri@resnulli.us, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu, 
	vinicius.gomes@intel.com, x86@kernel.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    100ceb4817a2 Merge tag 'vfs-6.14-rc1.mount.v2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13afa824580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88da85736adb8c92
dashboard link: https://syzkaller.appspot.com/bug?extid=21889604e13b9172a50b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104509f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a2911ef47f9/disk-100ceb48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17629e04715c/vmlinux-100ceb48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f2225b0be5/bzImage-100ceb48.xz

The issue was bisected to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15358ab0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17358ab0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13358ab0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21889604e13b9172a50b@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (3 ticks this GP) idle=160c/1/0x4000000000000000 softirq=14358/14358 fqs=1
rcu: 	(detected by 0, t=12604 jiffies, g=9565, q=1150 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6070 Comm: syz-executor Not tainted 6.13.0-syzkaller-00164-g100ceb4817a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:mark_usage kernel/locking/lockdep.c:4616 [inline]
RIP: 0010:__lock_acquire+0xb2a/0x2100 kernel/locking/lockdep.c:5180
Code: 24 48 c7 c0 14 32 1a 90 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 fc 11 00 00 83 3d 05 6b 9f 0e 00 0f 84 17 09 00 00 83 7c 24 58 00 <48> 8b 6c 24 38 0f 84 f9 00 00 00 48 8b 5c 24 18 0f b6 04 13 84 c0
RSP: 0018:ffffc90000a188f0 EFLAGS: 00000002
RAX: 0000000000000002 RBX: ffffffff93c30ebe RCX: 0000000000000002
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff942b3888
RBP: 0000000000000002 R08: ffffffff942b388f R09: 1ffffffff2856711
R10: dffffc0000000000 R11: fffffbfff2856712 R12: ffff88802568a8c4
R13: ffff888025689e00 R14: 0000000000000005 R15: ffff88802568a9c8
FS:  000055557e8ff500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57424a56e8 CR3: 000000005a2f0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 debug_object_activate+0x17f/0x580 lib/debugobjects.c:818
 debug_hrtimer_activate kernel/time/hrtimer.c:428 [inline]
 debug_activate kernel/time/hrtimer.c:469 [inline]
 enqueue_hrtimer+0x30/0x3c0 kernel/time/hrtimer.c:1076
 __run_hrtimer kernel/time/hrtimer.c:1756 [inline]
 __hrtimer_run_queues+0x6cb/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:202
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 5a 0a ae f5 48 89 df e8 92 51 af f5 e8 cd 6c da f5 fb bf 01 00 00 00 <e8> 62 c4 a0 f5 65 8b 05 83 03 37 74 85 c0 74 06 5b c3 cc cc cc cc
RSP: 0018:ffffc900031272b0 EFLAGS: 00000282
RAX: ace9d390bb8c2800 RBX: ffff888028818370 RCX: ffffffff817b2e5a
RDX: dffffc0000000000 RSI: ffffffff8c0a9940 RDI: 0000000000000001
RBP: ffffc90003127470 R08: ffffffff942b392f R09: 1ffffffff2856725
R10: dffffc0000000000 R11: fffffbfff2856726 R12: 000000000000000c
R13: ffffc900031276d8 R14: ffff888072aa1680 R15: 1ffff92000624edb
 mark_inode_dirty include/linux/fs.h:2500 [inline]
 dquot_alloc_space include/linux/quotaops.h:319 [inline]
 dquot_alloc_block include/linux/quotaops.h:336 [inline]
 ext4_mb_new_blocks+0x2edb/0x4e00 fs/ext4/mballoc.c:6183
 ext4_ext_map_blocks+0x1be0/0x7d30 fs/ext4/extents.c:4379
 ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
 ext4_map_blocks+0x8bf/0x1990 fs/ext4/inode.c:702
 ext4_getblk+0x1fa/0x880 fs/ext4/inode.c:849
 ext4_bread+0x2e/0x180 fs/ext4/inode.c:912
 ext4_append+0x327/0x5c0 fs/ext4/namei.c:83
 ext4_init_new_dir+0x33e/0xa30 fs/ext4/namei.c:2988
 ext4_mkdir+0x4f7/0xcf0 fs/ext4/namei.c:3034
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4311
 do_mkdirat+0x264/0x3a0 fs/namei.c:4334
 __do_sys_mkdir fs/namei.c:4354 [inline]
 __se_sys_mkdir fs/namei.c:4352 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4352
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f57417b9997
Code: 44 00 00 48 8d 50 ff 83 c1 01 48 21 d0 75 f4 01 cf 48 83 c6 08 4c 39 c6 75 d9 89 f8 c3 31 ff 89 f8 c3 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff05fbbfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007fff05fbc132 RCX: 00007f57417b9997
RDX: 0000000011487a76 RSI: 00000000000001c0 RDI: 00007fff05fbc120
RBP: f49998db0aa753ff R08: 0000000000000004 R09: 0000000000000001
R10: 00007f57424cb038 R11: 0000000000000246 R12: 8421084210842109
R13: 00007fff05fbc132 R14: 00007f574183aca0 R15: 0000000011487a76
 </TASK>
rcu: rcu_preempt kthread starved for 10869 jiffies! g9565 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26264 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.13.0-syzkaller-00164-g100ceb4817a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events_power_efficient gc_worker
RIP: 0010:seqcount_lockdep_reader_access+0x1e0/0x220 include/linux/seqlock.h:75
Code: f7 4d 85 ed 75 16 e8 6f 61 be f7 eb 15 e8 68 61 be f7 e8 23 ec e8 01 4d 85 ed 74 ea e8 59 61 be f7 fb 48 c7 04 24 0e 36 e0 45 <4b> c7 04 3c 00 00 00 00 66 43 c7 44 3c 09 00 00 43 c6 44 3c 0b 00
RSP: 0018:ffffc900000d79a0 EFLAGS: 00000293
RAX: ffffffff89e123a7 RBX: 0000000000000000 RCX: ffff88801cafda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900000d7a50 R08: ffffffff89e1237d R09: 1ffffffff2856724
R10: dffffc0000000000 R11: fffffbfff2856725 R12: dffffc0000000000
R13: 0000000000000200 R14: 0000000000000046 R15: 1ffff9200001af34
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbdbffa66c0 CR3: 00000000277be000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 nf_conntrack_get_ht include/net/netfilter/nf_conntrack.h:345 [inline]
 gc_worker+0x30f/0x1530 net/netfilter/nf_conntrack_core.c:1534
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

