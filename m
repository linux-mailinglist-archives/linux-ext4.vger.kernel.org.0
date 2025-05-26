Return-Path: <linux-ext4+bounces-8198-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB82AC40A9
	for <lists+linux-ext4@lfdr.de>; Mon, 26 May 2025 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1894D167D73
	for <lists+linux-ext4@lfdr.de>; Mon, 26 May 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFFA1FFC46;
	Mon, 26 May 2025 13:47:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BFD1E1DE2
	for <linux-ext4@vger.kernel.org>; Mon, 26 May 2025 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267259; cv=none; b=X5gVes8eZgX9EFk9sQQTTceq0BvFVWyxZ/3Tm3NwwfZMgHlxEGc3GOAIw4y27Y8P8IVE/DxIwbboxK9YW187N7V+PMSdC0T8g66a3icy2LHC5DYp3E+a+F0p4lCNrKLV6XT0lhcWlDqk0mhVU/p44ui/V886jsYsWD4/EvMpoq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267259; c=relaxed/simple;
	bh=tgpJdsWgfx+eVVG0bcNwZcea+f0rX2pH0AfuaPYqCWQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZiT8tbIzI2Teo/9PDDPbTI5Ber+XgVDS6T3avZ5r4rzzTDhhORlsqMG6aa+w/XZ8m03IDld7+iOLcTpzmTjGkY4I+9AxbRUxVei7JWubdShGC61gZvcyqQEAWH4zC7YjQnXBa1dIYwPblkFE8teqMBdQLVnBM+FQiGaOZm8UJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-86a50b5f5bdso185184439f.0
        for <linux-ext4@vger.kernel.org>; Mon, 26 May 2025 06:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267257; x=1748872057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6h+kPtsipsL2l83ymIcp6QfVvVLFYNQseaLUjiA7AM=;
        b=TyWTfe816/gvcs+mX3DJEKVBvk77I+wrxCW+TD1Rxni9qodopeSfd1MtvRna2Xq2Hm
         Ci1cv2URL8kYrlxP/MwlJuJ19ZZzmzUE7bLTGbZWAgHS9v36dnkW4TbPF+TDQDR72uy0
         UXBsvvpLCR/VZQpn7W3WUpwtSwDEQwmrA9Gq7wGYWfHndGYr1m5LpvdirJIdWIwFfgzc
         faOoq1ZlaW2Bi3yD0LTjQPM9X9RE3c351H36XdfbqVQA/NWPN4DzzXMlVjxadvj8soHO
         L0HF7SNUH3ZlAxW/2RwF06o/BugH9NkTJzBUBaMA7e0A+RK+75uE1VC3HgLA0Js55uF8
         6a9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUic3+hPkxvRAiDT8zu+RJ7VXsfQxopYMCglU8pygxaRzWK5o2xJM97wlp/DmBeoxXJgLKRTGLBIUId@vger.kernel.org
X-Gm-Message-State: AOJu0YxKEvMs8icMcnZUnzhoixSdf5+yyTFDXQJ23sqnxrlG+iwE0PJX
	FNVKWPj8yMXjs5Ra/9JKgmhQ0xltS613BxUPV5yaXkkZQRsn6opYifOco5IARu2UgY0wijrhieR
	WfAFuJg+49/RTIJuVgJiFbObAk9DjrAwMxAqpA/5Ep7tIlNcYbU6ywY6kpaM=
X-Google-Smtp-Source: AGHT+IFTSMm6o4vNCyvEE4pSeQ/QNhwixfp8b0f+ZlUQOHr6x7eNuo7TarKfX6TlMJjtW4X9Tz2Q9XhPRzoQCmHybG6KwFjZ6Pli
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3684:b0:85e:a8db:fa10 with SMTP id
 ca18e2360f4ac-86cbb7b82bcmr853909639f.1.1748267257030; Mon, 26 May 2025
 06:47:37 -0700 (PDT)
Date: Mon, 26 May 2025 06:47:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683470f9.a70a0220.1765ec.0169.GAE@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_ext_correct_indexes
From: syzbot <syzbot+04c4e65cab786a2e5b7e@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0c22de9995b Merge tag 'input-for-v6.15-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cff5f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1de0d8596cea805
dashboard link: https://syzkaller.appspot.com/bug?extid=04c4e65cab786a2e5b7e
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158eb5f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109d1170580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf852e5656de/disk-d0c22de9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/761933abe01b/vmlinux-d0c22de9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/187857154891/bzImage-d0c22de9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/62e5a099f2de/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=122868e8580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04c4e65cab786a2e5b7e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in ext4_ext_correct_indexes+0x72/0x5b0 fs/ext4/extents.c:1710
Read of size 8 at addr ffff88807b361f50 by task syz-executor191/6954

CPU: 0 UID: 0 PID: 6954 Comm: syz-executor191 Not tainted 6.15.0-rc7-syzkaller-00152-gd0c22de9995b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 ext4_ext_correct_indexes+0x72/0x5b0 fs/ext4/extents.c:1710
 ext4_ext_insert_extent+0x1fdd/0x4af0 fs/ext4/extents.c:2186
 ext4_ext_map_blocks+0x179c/0x67c0 fs/ext4/extents.c:4400
 ext4_map_create_blocks fs/ext4/inode.c:520 [inline]
 ext4_map_blocks+0x807/0x1740 fs/ext4/inode.c:706
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:785
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:818
 ext4_block_write_begin+0x543/0x1290 fs/ext4/inode.c:1067
 ext4_write_begin+0x6f6/0x12c0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x33a/0xa60 fs/ext4/inode.c:2932
 generic_perform_write+0x2c4/0x910 mm/filemap.c:4103
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x54b/0xa90 fs/read_write.c:684
 ksys_pwrite64 fs/read_write.c:791 [inline]
 __do_sys_pwrite64 fs/read_write.c:799 [inline]
 __se_sys_pwrite64 fs/read_write.c:796 [inline]
 __x64_sys_pwrite64+0x193/0x220 fs/read_write.c:796
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcafd410be9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcafcbb4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007fcafd4984a8 RCX: 00007fcafd410be9
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007fcafd4984a0 R08: 00007fcafcbb46c0 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 00007fcafd4984ac
R13: 000000000000000b R14: 00007fff140f2480 R15: 00007fff140f2568
 </TASK>

Allocated by task 12:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 cfg80211_inform_single_bss_data+0x905/0x1ac0 net/wireless/scan.c:2339
 cfg80211_inform_bss_data+0x1fb/0x3b20 net/wireless/scan.c:3222
 cfg80211_inform_bss_frame_data+0x362/0x700 net/wireless/scan.c:3317
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1102 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1581 [inline]
 ieee80211_ibss_rx_queued_mgmt+0xa36/0x2ae0 net/mac80211/ibss.c:1608
 ieee80211_iface_process_skb net/mac80211/iface.c:1625 [inline]
 ieee80211_iface_work+0x806/0xfe0 net/mac80211/iface.c:1679
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:548
 kvfree_call_rcu+0xbb/0x410 mm/slab_common.c:1962
 cfg80211_update_known_bss+0x634/0x1330 net/wireless/scan.c:1925
 __cfg80211_bss_update+0x147/0x2120 net/wireless/scan.c:1972
 cfg80211_inform_single_bss_data+0xba9/0x1ac0 net/wireless/scan.c:2363
 cfg80211_inform_bss_data+0x1fb/0x3b20 net/wireless/scan.c:3222
 cfg80211_inform_bss_frame_data+0x362/0x700 net/wireless/scan.c:3317
 ieee80211_bss_info_update+0x746/0x9e0 net/mac80211/scan.c:226
 ieee80211_scan_rx+0x527/0x9b0 net/mac80211/scan.c:340
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5179 [inline]
 ieee80211_rx_list+0x22fc/0x2d80 net/mac80211/rx.c:5416
 ieee80211_rx_napi+0x1a8/0x3d0 net/mac80211/rx.c:5439
 ieee80211_rx include/net/mac80211.h:5179 [inline]
 ieee80211_handle_queued_frames+0xe8/0x1f0 net/mac80211/main.c:441
 tasklet_action_common+0x369/0x580 kernel/softirq.c:829
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff88807b361f00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 8 bytes to the right of
 allocated 72-byte region [ffff88807b361f00, ffff88807b361f48)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b361
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a041280 ffffea0000bd3a40 dead000000000002
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 36, tgid 36 (kworker/u8:2), ts 101928270930, free_ts 101772582052
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1714
 prep_new_page mm/page_alloc.c:1722 [inline]
 get_page_from_freelist+0x21c7/0x22a0 mm/page_alloc.c:3684
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4966
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2618
 new_slab mm/slub.c:2672 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3858
 __slab_alloc mm/slub.c:3948 [inline]
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4353
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:990 [inline]
 nsim_fib_event_nb+0x187/0x1080 drivers/net/netdevsim/fib.c:1043
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 call_fib_notifiers+0x31/0x60 net/core/fib_notifier.c:35
 call_fib6_entry_notifiers net/ipv6/ip6_fib.c:397 [inline]
 fib6_add_rt2node net/ipv6/ip6_fib.c:1231 [inline]
 fib6_add+0x1a78/0x4360 net/ipv6/ip6_fib.c:1488
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_ins_rt+0xc8/0x120 net/ipv6/route.c:1361
 __ipv6_ifa_notify+0x63f/0xac0 net/ipv6/addrconf.c:6286
 ipv6_ifa_notify net/ipv6/addrconf.c:6325 [inline]
 addrconf_dad_completed+0x180/0xd60 net/ipv6/addrconf.c:4324
 addrconf_dad_work+0xc36/0x14b0 net/ipv6/addrconf.c:-1
page last free pid 5847 tgid 5847 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1258 [inline]
 __free_frozen_pages+0xb05/0xcd0 mm/page_alloc.c:2721
 discard_slab mm/slub.c:2716 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3185
 put_cpu_partial+0x17c/0x250 mm/slub.c:3260
 __slab_free+0x2f7/0x400 mm/slub.c:4512
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_noprof+0x224/0x4f0 mm/slub.c:4339
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x28b/0x550 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x58d/0x5d0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x213/0x4b0 security/tomoyo/file.c:822
 tomoyo_path_unlink+0xa2/0xe0 security/tomoyo/tomoyo.c:162
 security_path_unlink+0x167/0x360 security/security.c:1965
 do_unlinkat+0x2de/0x560 fs/namei.c:4640
 __do_sys_unlink fs/namei.c:4689 [inline]
 __se_sys_unlink fs/namei.c:4687 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4687
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94

Memory state around the buggy address:
 ffff88807b361e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807b361e80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff88807b361f00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
                                                 ^
 ffff88807b361f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807b362000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


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

