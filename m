Return-Path: <linux-ext4+bounces-5962-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A763A0483D
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 18:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EC17A3AC3
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81331F2C3F;
	Tue,  7 Jan 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKzB15Hq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3771F4E4E
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270892; cv=none; b=Sk6sUR70eMTzt6EyTZ5SEMR/cUtaViyDNzNELp8/plFojsTF+m5Ct98A7tl93YeYTE0J13iShJpN4faHw6GcZ7m5INKohQ8Z/vaFU5dzWmT7Z2j2Lub1lir8w0KKHwhSAQDbEHCtS+R5Qu3U+u99xDMk99S3CxLT+gs8wvOy2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270892; c=relaxed/simple;
	bh=PeVtZ8Thqi8I1hu81OgW1l80ZkSDt3jmrK4Kl0MSVtA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gmX8ENJdqOWqA+haLtIi477wJ13XLLlc5XNSJk2EQo0v+aWCTX/Pdpx+AEESetRVAFqCNLnoFzVbg2OyCR2dN6/zy8Y+j0HH4s9QNExBXCVxgysNhWT+dhw0qh8cS2Ls6kPqUU/WhJ2bk/DqMqNG+/TUiOwh0tBdKTWJqUd2Mb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKzB15Hq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467725245a2so105209601cf.3
        for <linux-ext4@vger.kernel.org>; Tue, 07 Jan 2025 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736270888; x=1736875688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUA17CoLoWjbDqYui89j0dNXjOLvUPo6/2l7mVADFOQ=;
        b=IKzB15HqADBAVGEU4v0HqYhUdaHeOKMjP0t1oSHhn+3D+LL+W/NAKS2Wf0F7HU0FEZ
         TB/dMafPSJ/ECKas7NZ5nDFqwYLcY9Nax0fwuw7DGYvPcVvtzZezojxUtGzA5n0hDdrC
         3VjUa+wXYcROR0Xw4KRpYUNTJeQnDU6Y5ztu/VNWX6Wo6TZaMVE45QdZPJEl3/LRW5/2
         q7SGqhQ0DFCTOdo7GY2A+RLfPehXsVKURKgOYfG8mtD9nnu23Tg5atC7fxeMzjMg5gVu
         Im7nic+7/QZoU4ceM9BPXdbPNAok0fB40do9+pmJoaGGbCJs9MgDlQOhcrfr3xE1uvZj
         9EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270888; x=1736875688;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUA17CoLoWjbDqYui89j0dNXjOLvUPo6/2l7mVADFOQ=;
        b=n5rhj+FPawLkoKOuHtjMqvZZ4AP3ihMxjzUfUmlDQ0LalGAKHdfKk+8F5zPFQlYxWQ
         4WQolD6hGxDr8rg7Xwxa8/ba5URGLtCIaGOXum9rISS2IDV5cDaKlBAM0mMiPRRECDH8
         qszBnNHYooIHUHiEjdL8hw687cbOOSViesAhG8+u7TZs7mov5LHKWWEChMuQg1wqU7MD
         xtAp2dBpC3opYHDU3egg3uAqxuwaxqUHLQnlVC8IouJqx1R+Q4585uhrVwghlvGZlynv
         gZM5OHqHm0ex67hIjhYT/hLWj1RayC3AMx2ojU/AGem+Slqe8xnoZqZ+iRaHuBvw4wHi
         sM/g==
X-Gm-Message-State: AOJu0YyJyrlCOLylgos5D3p5H8vo9bI8Fpr5nTH4QfFxlybyb2CaBaaS
	NZ/ptvk8CYWHsY855mS7LGBVJ+gIs75q6xnE0qOSkMbJHV4hhzX3uRRWl1rupLO7oDFHrifz9D9
	fHBVrkiiFQ3Jo1smSOQDB+uDUPAX4oA==
X-Gm-Gg: ASbGnctClACtfvKuFit7SI0azFUfplmiW+Ge5LAATaOIoN16a+kHsJqOJJTmuRhqYyE
	489SbrKgFptgwNy0wnVMCGc+tMVYTE7N9TxXNl1XS
X-Google-Smtp-Source: AGHT+IF5JhORUbTJo9fOcxOj6ktprmbHL1JtvfzrO//Pdf7i9BLUQ/ldCxFlBOjGnjyARpFuTci0IrN9jA9LyCUhbfw=
X-Received: by 2002:ac8:5a42:0:b0:467:50d0:8869 with SMTP id
 d75a77b69052e-46a4a8df373mr1090710581cf.18.1736270888196; Tue, 07 Jan 2025
 09:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: reveliofuzzing <reveliofuzzing@gmail.com>
Date: Tue, 7 Jan 2025 12:27:57 -0500
X-Gm-Features: AbW1kva6BplpiUGTq8494clrab6NUf_O06G5wmXZJMOG4fw9yvx5_pkNmhmDIz8
Message-ID: <CA+-ZZ_g3QPWj5Mt7hh+L2LGynar05agxtYheeT9V7mGiFh8-Lg@mail.gmail.com>
Subject: KASAN: slab-use-after-free Read in ext4_search_dir
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following use-after-free bug in Linux kernel 6.12. A similar error
was reported before by Syzbot and was labeled as fixed, while it can still
happen in the latest kernel.

- Prior fix
Commit c6b72f5d82b1017bad80f9("ext4: avoid OOB when system.data xattr changes
underneath the filesystem")

- Prior report by syzbot
https://syzkaller.appspot.com/bug?extid=0c2508114d912a54ee79

- Latest bug report
loop0: detected capacity change from 1024 to 1023
==================================================================
EXT4-fs (loop4): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
writeback.
BUG: KASAN: slab-use-after-free in ext4_search_dir+0x22a/0x270
linux-6.12/fs/ext4/namei.c:1500
Read of size 1 at addr ffff88800ded820b by task syz.0.16/2629

CPU: 1 PID: 2629 Comm: syz.0.16 Not tainted 6.10.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack linux-6.12/lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x7d/0xa0 linux-6.12/lib/dump_stack.c:120
 print_address_description linux-6.12/mm/kasan/report.c:377 [inline]
 print_report+0xcf/0x610 linux-6.12/mm/kasan/report.c:488
 kasan_report+0xb5/0xe0 linux-6.12/mm/kasan/report.c:601
 ext4_search_dir+0x22a/0x270 linux-6.12/fs/ext4/namei.c:1500
 ext4_get_inline_xattr_pos linux-6.12/fs/ext4/inline.c:1058 [inline]
 ext4_find_inline_entry+0x3d1/0x4a0 linux-6.12/fs/ext4/inline.c:1708
 __ext4_find_entry+0x51e/0xdd0 linux-6.12/fs/ext4/namei.c:1575
 ext4_lookup_entry linux-6.12/fs/ext4/namei.c:1729 [inline]
 ext4_lookup+0x166/0x5a0 linux-6.12/fs/ext4/namei.c:1797
 __lookup_slow+0x19a/0x390 linux-6.12/fs/namei.c:1732
loop1: detected capacity change from 0 to 1024
 lookup_slow linux-6.12/fs/namei.c:1749 [inline]
 walk_component+0x2ef/0x520 linux-6.12/fs/namei.c:2053
 link_path_walk.part.0+0x53f/0xb90 linux-6.12/fs/namei.c:2403
 path_openat+0x233/0x3660 linux-6.12/fs/namei.c:3929
EXT4-fs: Ignoring removed nobh option
EXT4-fs: Journaled quota options ignored when QUOTA feature is enabled
 do_filp_open+0x1cc/0x2b0 linux-6.12/fs/namei.c:3960
 do_sys_openat2+0x477/0x510 linux-6.12/fs/open.c:1415
 do_sys_open+0xb6/0x130 linux-6.12/fs/open.c:1430
 do_syscall_x64 linux-6.12/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4b/0x110 linux-6.12/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fad3b550add
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc003a1798 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fad3b749fa0 RCX: 00007fad3b550add
RDX: 0000000000000000 RSI: f56121c52d8877ff RDI: 0000000020001d00
RBP: 00007fad3b5ceb8f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000cd0 R15: 00007fad3b749fa0
 </TASK>

Allocated by task 2564:
 kasan_save_stack+0x24/0x50 linux-6.12/mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 linux-6.12/mm/kasan/common.c:68
 unpoison_slab_object linux-6.12/mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x59/0x70 linux-6.12/mm/kasan/common.c:345
 slab_post_alloc_hook linux-6.12/mm/slub.c:4088 [inline]
 slab_alloc_node linux-6.12/mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0xde/0x230 linux-6.12/mm/slub.c:4141
 mt_alloc_one linux-6.12/lib/maple_tree.c:162 [inline]
 mas_alloc_nodes+0x47d/0x800 linux-6.12/lib/maple_tree.c:1241
 mas_node_count_gfp+0xbb/0x110 linux-6.12/lib/maple_tree.c:1321
 mas_start linux-6.12/lib/maple_tree.c:1374 [inline]
 mas_start linux-6.12/lib/maple_tree.c:1351 [inline]
 mas_wr_prealloc_setup linux-6.12/lib/maple_tree.c:4132 [inline]
 mas_preallocate+0x279/0x1210 linux-6.12/lib/maple_tree.c:5540
 __is_vma_write_locked linux-6.12/include/linux/mm.h:735 [inline]
 vma_start_write linux-6.12/include/linux/mm.h:754 [inline]
 vma_expand+0x351/0x17e0 linux-6.12/mm/vma.c:1018
 mmap_region+0x302/0x1e90 linux-6.12/mm/mmap.c:289
 do_mmap+0x64a/0xbd0 linux-6.12/mm/mmap.c:394
 vm_mmap_pgoff+0x19c/0x320 linux-6.12/mm/util.c:588
 ksys_mmap_pgoff+0x369/0x4b0 linux-6.12/mm/mmap.c:545
 __do_sys_mmap linux-6.12/arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap linux-6.12/arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x116/0x180 linux-6.12/arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 linux-6.12/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4b/0x110 linux-6.12/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 2565:
 kasan_save_stack+0x24/0x50 linux-6.12/mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 linux-6.12/mm/kasan/common.c:68
 kasan_save_free_info+0x3a/0x60 linux-6.12/mm/kasan/generic.c:579
 check_page_allocation linux-6.12/mm/kasan/common.c:293 [inline]
 check_page_allocation linux-6.12/mm/kasan/common.c:283 [inline]
 __kasan_slab_free+0x111/0x190 linux-6.12/mm/kasan/common.c:303
 kasan_slab_pre_free linux-6.12/include/linux/kasan.h:195 [inline]
 slab_free_hook linux-6.12/mm/slub.c:2287 [inline]
 slab_free linux-6.12/mm/slub.c:4579 [inline]
 kmem_cache_free+0xa1/0x350 linux-6.12/mm/slub.c:4681
 preempt_count linux-6.12/arch/x86/include/asm/preempt.h:26 [inline]
 rcu_do_batch linux-6.12/kernel/rcu/tree.c:2574 [inline]
 rcu_core+0x653/0x1980 linux-6.12/kernel/rcu/tree.c:2823
 handle_softirqs+0x162/0x520 linux-6.12/kernel/softirq.c:554
 __do_softirq linux-6.12/kernel/softirq.c:588 [inline]
 invoke_softirq linux-6.12/kernel/softirq.c:428 [inline]
 __irq_exit_rcu linux-6.12/kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x7f/0xb0 linux-6.12/kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt
linux-6.12/arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x6e/0x90
linux-6.12/arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
linux-6.12/arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x24/0x50 linux-6.12/mm/kasan/common.c:47
 __kasan_record_aux_stack+0x8c/0xa0 linux-6.12/mm/kasan/generic.c:541
 __call_rcu_common.constprop.0+0x6a/0x8b0 linux-6.12/kernel/rcu/tree.c:3086
 mas_parent_gap linux-6.12/lib/maple_tree.c:1621 [inline]
 mas_update_gap linux-6.12/lib/maple_tree.c:1674 [inline]
 mas_update_gap linux-6.12/lib/maple_tree.c:1655 [inline]
 mas_wr_node_store+0x91d/0x19d0 linux-6.12/lib/maple_tree.c:3862
 mas_wr_modify+0x6ba/0x27c0
 mas_wr_slot_store linux-6.12/lib/maple_tree.c:3899 [inline]
 mas_wr_store_entry+0x3ea/0x14c0 linux-6.12/lib/maple_tree.c:4075
 mas_store_prealloc+0xab/0x200 linux-6.12/lib/maple_tree.c:5506
 vma_merge_existing_range linux-6.12/mm/vma.c:766 [inline]
 __split_vma+0x1342/0x19d0 linux-6.12/mm/vma.c:1423
 do_vmi_align_munmap.constprop.0+0x228/0xee0
 do_vmi_munmap+0x1a3/0x380 linux-6.12/mm/vma.c:1402
 instrument_atomic_read_write
linux-6.12/include/linux/instrumented.h:96 [inline]
 atomic_inc_unless_negative
linux-6.12/include/linux/atomic/atomic-instrumented.h:1555 [inline]
 mapping_map_writable linux-6.12/include/linux/fs.h:569 [inline]
 mmap_region+0x159/0x1e90 linux-6.12/mm/mmap.c:1596
 do_mmap+0x64a/0xbd0 linux-6.12/mm/mmap.c:394
 vm_mmap_pgoff+0x19c/0x320 linux-6.12/mm/util.c:588
 ksys_mmap_pgoff+0x369/0x4b0 linux-6.12/mm/mmap.c:545
 __do_sys_mmap linux-6.12/arch/x86/kernel/sys_x86_64.c:86 [inline]
 __se_sys_mmap linux-6.12/arch/x86/kernel/sys_x86_64.c:79 [inline]
 __x64_sys_mmap+0x116/0x180 linux-6.12/arch/x86/kernel/sys_x86_64.c:79
 do_syscall_x64 linux-6.12/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4b/0x110 linux-6.12/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff88800ded8200
 which belongs to the cache maple_node of size 256
The buggy address is located 11 bytes inside of
 freed 256-byte region [ffff88800ded8200, ffff88800ded8300)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xded8
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x100000000000040(head|node=0|zone=1)
page_type: 0xffffefff(slab)
raw: 0100000000000040 ffff888006c4db40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 0100000000000040 ffff888006c4db40 dead000000000122 0000000000000000
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 0100000000000001 ffffea000037b601 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800ded8100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88800ded8180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88800ded8200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88800ded8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88800ded8300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

