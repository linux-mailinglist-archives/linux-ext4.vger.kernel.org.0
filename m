Return-Path: <linux-ext4+bounces-2717-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA28D4422
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2024 05:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1493B1C20E88
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2024 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23C5FBB1;
	Thu, 30 May 2024 03:27:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2CA5E22C
	for <linux-ext4@vger.kernel.org>; Thu, 30 May 2024 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039649; cv=none; b=AKcuXQ1NwqteeKIMmNQ2OI7HzdaeumWScu0kwnaJFXLMZVYwtSxG1ZqxWcr1NLzF8eQ/MUd6ULZxsL1dsDCbTeWdFrvUOxvqN/38pS0xoZhRgmz3LvTLjX1mzE80kv/6R+Wnw/0On43CVxG5fFIHZeXhE5dbx9x3UL2Ns6tQsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039649; c=relaxed/simple;
	bh=7a/xSj6Bw9SmdnvBtJMX6Pox1robAP5zojBoIdAmm1s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bw5QeidAm3uaGeeJu43/1iKGI39dXhlwMqDeOjwH87dd8BBlKbBhHdZ1ZZVV7s9JzdRs6/GfEdp0zckN1ydJmvytcbarHA9qtNucY6CJ7EutC+wO8TL86Ce13+XB828Hb6LA8Jr09efp7j2iKYYF8WbBmHycVl0ARpe+cc8FrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ead88dd1b1so47599239f.2
        for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 20:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039646; x=1717644446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CT+hTyVsp1eVBx/3obSkcYwWj9hSUF+8lrl5Nd9ZG1c=;
        b=m3mf96/L7Bc38nS+1YZh5Ev9USWXny4gjFJwONpIe64CtLyd+/mgPaKpSUJ3SF3tuk
         Rpc+taRfsH1NYxZXdmx+m2PnX94w+rVbjuezTksbAtgEPEqKpO3MpB62xUEe+Im1Ncc5
         gH37vZbGXSHOHLVZvXtCKzMw8uYc7hIxCE8yDess86TySxx5VLstASB1pOceWMm5gKMT
         KdQ/whhkOsEfWHYilgWRFVGOEt3XUbjt1gOx/CSPkn87HUsuL4l3S0pIxJtMG88mCcJh
         J+LNjvsG1QinLc+tt6UoCVpdSSOjrNQROU/21GCcu2erz9Sq8cVEl4xhWdXJmd2BOX6J
         lXGg==
X-Forwarded-Encrypted: i=1; AJvYcCX6GlyOY5XrOTo0Ipm7Z83H0bWruHftYe9MP6yvj7DsgBlbMAzDYZ9F1kCJwRXrkVBqRDddCIGW/hTN0LT97v6v8AZdwFkZLcrvcw==
X-Gm-Message-State: AOJu0YxcOSCvQ1yyvSS5kMtu5a5wX4cJ0pHG3RHdlzq+fQVLqMdATU99
	yhpS/cc820r509wAvjikheT9pLf18vA81PXc1eT+6rKUYMqATusfhybgBF4AobF4Xw5895vWge5
	gJxgsi4IlAIqouabbNBG/hqJQS4lHKPqijbZMgRvLGgUQf+tPirvYZGg=
X-Google-Smtp-Source: AGHT+IFDnv/Y5ORbAivNzhXEwdv1vf6X/ZyBm5WimnOKLJMkLoFmCwymlltqOwLtX3+p/rKIQ5lyMyibHxMO772YyKMJKZDWTu86
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8527:b0:488:75e3:f3df with SMTP id
 8926c6da1cb9f-4b1da649458mr48873173.0.1717039646566; Wed, 29 May 2024
 20:27:26 -0700 (PDT)
Date: Wed, 29 May 2024 20:27:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032fa460619a3725d@google.com>
Subject: [syzbot] [mm?] [ext4?] INFO: rcu detected stall in ext4_release_file (2)
From: syzbot <syzbot+9c703233282a4a1a6749@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e1297c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=966dbeb548ca6926
dashboard link: https://syzkaller.appspot.com/bug?extid=9c703233282a4a1a6749
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e7abe0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b23f6c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b73e9f1cca3d/disk-56fb6f92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/40cf1a36f076/vmlinux-56fb6f92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2cbaf91b77d8/bzImage-56fb6f92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c703233282a4a1a6749@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5118/1:b..l P5114/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=7317, q=59 ncpus=2)
task:syz-executor369 state:R  running task     stack:24768 pid:5114  tgid:5114  ppid:5103   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7067
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:folio_batch_add include/linux/pagevec.h:77 [inline]
RIP: 0010:filemap_get_folios_tag+0x3b5/0xb70 mm/filemap.c:2250
Code: 24 20 0f b6 29 8d 5d 01 40 80 fd 1e 88 19 0f 87 0d 07 00 00 48 8b 44 24 20 48 8d 7c e8 08 48 89 f8 48 c1 e8 03 42 80 3c 30 00 <0f> 85 e7 06 00 00 48 8b 44 24 20 89 de bf 1f 00 00 00 4c 89 6c e8
RSP: 0018:ffffc9000329f0c0 EFLAGS: 00000246
RAX: 1ffff92000653e74 RBX: 000000000000001e RCX: ffffc9000329f2b0
RDX: ffff88802868bc00 RSI: ffffffff81bf5256 RDI: ffffc9000329f3a0
RBP: 000000000000001d R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: ffffc9000329f290
R13: ffffea0001e61140 R14: dffffc0000000000 R15: ffff88801d9edb80
 mpage_prepare_extent_to_map+0x3d6/0x1470 fs/ext4/inode.c:2392
 ext4_do_writepages+0xdf7/0x3250 fs/ext4/inode.c:2677
 ext4_writepages+0x303/0x730 fs/ext4/inode.c:2768
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2634
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 ext4_alloc_da_blocks+0x202/0x2c0 fs/ext4/inode.c:3069
 ext4_release_file+0x17c/0x370 fs/ext4/file.c:169
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa9b/0x2ba0 kernel/exit.c:874
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1023
 get_signal+0x2616/0x2710 kernel/signal.c:2909
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0x139/0x280 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fa1302f449e
RSP: 002b:00007fff23f01688 EFLAGS: 00010287
RAX: 00007fff23f01690 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000003ff RSI: 0000000000000000 RDI: 00007fff23f01690
RBP: 00007fff23f01690 R08: 00000000000003ff R09: 00322e6364755f79
R10: 0000000000000000 R11: 0000000000000202 R12: 6666666666666667
R13: 0000000000050012 R14: 00007fff23f01adc R15: 00007fff23f01b10
 </TASK>
task:udevd           state:R  running task     stack:26768 pid:5118  tgid:5118  ppid:4533   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7067
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:write_comp_data+0x34/0x90 kernel/kcov.c:236
Code: 48 8b 15 0f fc 75 7e 65 8b 05 10 fc 75 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 1c 16 00 00 85 c0 74 4f 8b 82 f8 15 00 00 <83> f8 03 75 44 48 8b 82 00 16 00 00 8b 92 fc 15 00 00 48 8b 38 48
RSP: 0018:ffffc900032df6f0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 000000000000001e RCX: ffffffff843d8b14
RDX: ffff888026ea5a00 RSI: 000000000000001b RDI: 0000000000000005
RBP: ffff88802ab04000 R08: 0000000000000005 R09: 000000000000001b
R10: 000000000000001e R11: 0000000000000002 R12: 000000000000001e
R13: 0000000000000001 R14: 0000000000000000 R15: ffff88802aadc000
 sidtab_search_core security/selinux/ss/sidtab.c:247 [inline]
 sidtab_search_entry_force+0x34/0x1e0 security/selinux/ss/sidtab.c:265
 security_sid_to_context_core+0x3ae/0x640 security/selinux/ss/services.c:1358
 selinux_inode_init_security+0x465/0x670 security/selinux/hooks.c:2948
 security_inode_init_security+0x1a5/0x380 security/security.c:1728
 shmem_mknod+0xe9/0x240 mm/shmem.c:3275
 lookup_open.isra.0+0x10a1/0x13c0 fs/namei.c:3505
 open_last_lookups fs/namei.c:3574 [inline]
 path_openat+0x92f/0x29f0 fs/namei.c:3804
 do_filp_open+0x1dc/0x430 fs/namei.c:3834
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3206f169a4
RSP: 002b:00007ffedc380de0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f3206f169a4
RDX: 0000000000080241 RSI: 00007ffedc381328 RDI: 00000000ffffff9c
RBP: 00007ffedc381328 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000080241
R13: 00005634ba28c72e R14: 0000000000000001 R15: 00005634ba2a7160
 </TASK>
rcu: rcu_preempt kthread starved for 10578 jiffies! g7317 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27872 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7067
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x1f2/0x560 kernel/locking/lockdep.c:5722
Code: c1 05 9a af 96 7e 83 f8 01 0f 85 ea 02 00 00 9c 58 f6 c4 02 0f 85 d5 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc90000167910 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200002cf24 RCX: 00000000b755b505
RDX: 0000000000000001 RSI: ffffffff8b2caee0 RDI: ffffffff8b8ff140
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff284d458
R10: ffffffff9426a2c7 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: ffffffff8e658780 R15: 0000000000000000
 debug_objects_fill_pool lib/debugobjects.c:614 [inline]
 debug_object_assert_init+0x142/0x370 lib/debugobjects.c:893
 debug_timer_assert_init kernel/time/timer.c:846 [inline]
 debug_assert_init kernel/time/timer.c:891 [inline]
 __mod_timer+0xae/0xdc0 kernel/time/timer.c:1072
 schedule_timeout+0x131/0x2a0 kernel/time/timer.c:2580
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2000
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2202
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 PID: 5099 Comm: syz-executor369 Not tainted 6.9.0-syzkaller-12277-g56fb6f92854f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0xc/0x60 kernel/kcov.c:207
Code: c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 15 54 f5 75 7e <65> 8b 05 55 f5 75 7e a9 00 01 ff 00 48 8b 34 24 74 0f f6 c4 01 74
RSP: 0000:ffffc90000a185a0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffffc90000a18628 RCX: ffffc90000a1865c
RDX: ffff888029bd9e00 RSI: ffffffff813ccad9 RDI: ffffc90000a18668
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8880500c9280
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000001
FS:  0000555592b65380(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f32073a4d00 CR3: 000000006f8ac000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 unwind_next_frame+0x10f8/0x23a0 arch/x86/kernel/unwind_orc.c:664
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_node_noprof+0x153/0x310 mm/slub.c:4043
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:656
 skb_copy+0x17a/0x340 net/core/skbuff.c:2124
 mac80211_hwsim_tx_frame_no_nl.isra.0+0xb97/0x1310 drivers/net/wireless/virtual/mac80211_hwsim.c:1857
 mac80211_hwsim_tx_frame+0x1eb/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim.c:2206
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim.c:2223 [inline]
 mac80211_hwsim_beacon_tx+0x592/0xa00 drivers/net/wireless/virtual/mac80211_hwsim.c:2306
 __iterate_interfaces+0x2d2/0x580 net/mac80211/util.c:772
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:808
 mac80211_hwsim_beacon+0x105/0x200 drivers/net/wireless/virtual/mac80211_hwsim.c:2336
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1751
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1768
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:exit_to_user_mode_loop kernel/entry/common.c:101 [inline]
RIP: 0010:exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
RIP: 0010:irqentry_exit_to_user_mode+0x11a/0x280 kernel/entry/common.c:231
Code: 9c 58 fa f6 c4 02 0f 85 1b 01 00 00 e8 6f 0e 00 00 48 8b 5d 00 f7 c3 0e 30 02 00 0f 84 31 ff ff ff e8 4a a3 ad f6 fb f6 c3 08 <75> bd f6 c7 10 74 c2 4c 89 e7 e8 37 e2 d5 f6 f7 c3 04 00 02 00 74
RSP: 0000:ffffc900031aff38 EFLAGS: 00000246
RAX: 0000000000018a4b RBX: 0000000000000002 RCX: 1ffffffff1fc81f1
RDX: 0000000000000000 RSI: ffffffff8b2cabe0 RDI: ffffffff8b8ff140
RBP: ffff888029bd9e00 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe45217 R11: 0000000000000000 R12: ffffc900031aff58
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0033:0x7fa130323125
Code: 00 00 00 66 90 83 ff 03 74 7b 83 ff 02 b8 fa ff ff ff 49 89 ca 0f 44 f8 80 3d 5e 1f 05 00 00 74 14 b8 e6 00 00 00 0f 05 f7 d8 <c3> 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec 28 48 89 54 24 10 89 74
RSP: 002b:00007fff23f018f8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000016 RCX: 00007fa130323123
RDX: 00007fff23f01910 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000008e8e R09: 00007fa1302b5080
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff23f01adc
R13: 0000000000042269 R14: 00007fff23f01adc R15: 00007fff23f01b10
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

