Return-Path: <linux-ext4+bounces-12377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB815CC37C5
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1421E305FF3B
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7F3469EE;
	Tue, 16 Dec 2025 12:19:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043A345733
	for <linux-ext4@vger.kernel.org>; Tue, 16 Dec 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887548; cv=none; b=e112nbrIgrGwl/dhIiyl0901Yvi4XjJtw6OBXYvVZYC0drqoKAY5DhVCTrkbGHbdvo+fSA5CKjbwLIuuMYQaGU00Gh2weREKr+32c0Qtb/QC8jKCh57LiGMDXeqp8sW3D8SkCZ6euY2WD+CffWJzy+4j0mX0bAb9hUgSplnG8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887548; c=relaxed/simple;
	bh=CnIM4O9Vrm/4MGS3WXBOGgfYldNU7UmYa7dRl8k1FzU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=buav08HNq2G6Hy4PeXabo5wrcBFnhsvmwQJg3xRN0YVV/PUlYbKNSN/CF1mQc+LDjvOXQgpRh3IDkA46SyMnqzZdUPoyis0FNnD30bU+/8AIdYt3oo5btcBuKHoPPltpacqcFlW4EAQ/FFgHr1aDkMcDNTajinGjCmvVcEtwMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7c7046514a2so4424255a34.0
        for <linux-ext4@vger.kernel.org>; Tue, 16 Dec 2025 04:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765887545; x=1766492345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdJhXZEww5JI+SUXfrRczFqSgFbgygoMbU60L+eHlvA=;
        b=j7K8jnIL+Vy0EXRFa0nkVTlNqMW4PNtg68MMeQwFdkjDcpkYvuX+IDIEut1mhSmfLK
         pj3P8hu9gDIIk92i+r7X00dlyrj+oslj+jivKpOk0d1FcjVxwlTSBXoGzwNlpIaBspkn
         I8ARBuHBswAMJ4HpNU5smiBcJoaY1OFk//D+g6xqxW8balwYXrfsZtlveQ3PAZ7Y3Cb5
         kxqzQne4lq5F/IWfzFu4jhui7HqUTBSkRn2F17M3ErRdurbgHMVcrBF00f92zNT4eMnW
         AvjjkSRSf5+4Cz8q/0NvCiBA1KnwjAv7hGQa+PT5TPbBMLexscsUe1wA6xOgHI56w5ae
         9FUQ==
X-Gm-Message-State: AOJu0YxXIBxdNd+AAzVJGppcUJ8Z4WNTXXC7yw7x7jCFIxRkMFebwy0K
	luFZPMqr40k1xI2d8IimduSLIKpIQ8OlayOAMd7C4u88OuMeltrlH8q8PsrZq0VdEIWKC5a4mRx
	vyidBEmTjzJM822akF9XiL3LS1TNkvgX7oC6zqAShsHfVbp24vI2Ml9v2LW0=
X-Google-Smtp-Source: AGHT+IGf+W+BiJghypBLGTRkpoTrtq7DGiC4StsFb46P8GMh/8+Gxcex4JqPghQukXAVm1volp4Jgo1ZLIdt0W9pogw/zmZbv2Ur
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3083:b0:65b:3907:b360 with SMTP id
 006d021491bc7-65b4524c2aamr6532950eaf.62.1765887545153; Tue, 16 Dec 2025
 04:19:05 -0800 (PST)
Date: Tue, 16 Dec 2025 04:19:05 -0800
In-Reply-To: <aUFKeAcD6NeBbZ6O@ndev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69414e39.a70a0220.33cd7b.013b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in ext4_xattr_set_entry
From: syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wangjinchao600@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: out-of-bounds Read in ext4_xattr_set_entry

EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
==================================================================
BUG: KASAN: out-of-bounds in ext4_xattr_set_entry+0x8e9/0x1e20 fs/ext4/xattr.c:1782
Read of size 18446744073709551572 at addr ffff88800077a050 by task syz.0.17/5873

CPU: 0 UID: 0 PID: 5873 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x2b0/0x2c0 mm/kasan/generic.c:200
 __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
 ext4_xattr_set_entry+0x8e9/0x1e20 fs/ext4/xattr.c:1782
 ext4_xattr_block_set+0x872/0x2ac0 fs/ext4/xattr.c:2029
 ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2831
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6349
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
 __ext4_mark_inode_dirty+0x45c/0x6e0 fs/ext4/inode.c:6470
 __ext4_unlink+0x631/0xab0 fs/ext4/namei.c:3282
 ext4_unlink+0x206/0x590 fs/ext4/namei.c:3312
 vfs_unlink+0x380/0x640 fs/namei.c:5369
 do_unlinkat+0x2cf/0x560 fs/namei.c:5439
 __do_sys_unlink fs/namei.c:5474 [inline]
 __se_sys_unlink fs/namei.c:5472 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:5472
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff419d8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff41abdb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007ff419fe5fa0 RCX: 00007ff419d8f7c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000180
RBP: 00007ff419e13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff419fe6038 R14: 00007ff419fe5fa0 R15: 00007fff883d93a8
 </TASK>

Allocated by task 5873:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_node_track_caller_noprof+0x575/0x820 mm/slub.c:5764
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:765 [inline]
 ext4_xattr_block_set+0x781/0x2ac0 fs/ext4/xattr.c:1977
 ext4_xattr_move_to_block fs/ext4/xattr.c:2668 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2743 [inline]
 ext4_expand_extra_isize_ea+0x12da/0x1ea0 fs/ext4/xattr.c:2831
 __ext4_expand_extra_isize+0x30d/0x400 fs/ext4/inode.c:6349
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:6392 [inline]
 __ext4_mark_inode_dirty+0x45c/0x6e0 fs/ext4/inode.c:6470
 __ext4_unlink+0x631/0xab0 fs/ext4/namei.c:3282
 ext4_unlink+0x206/0x590 fs/ext4/namei.c:3312
 vfs_unlink+0x380/0x640 fs/namei.c:5369
 do_unlinkat+0x2cf/0x560 fs/namei.c:5439
 __do_sys_unlink fs/namei.c:5474 [inline]
 __se_sys_unlink fs/namei.c:5472 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:5472
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88800077a000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 80 bytes inside of
 1024-byte region [ffff88800077a000, ffff88800077a400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x778
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x7ff00000000040(head|node=0|zone=0|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 007ff00000000040 ffff88801a441dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 007ff00000000040 ffff88801a441dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 007ff00000000002 ffffea000001de01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 5873, tgid 5872 (syz.0.17), ts 160723892073, free_ts 160040949869
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3915
 __alloc_pages_slowpath+0x30b/0xce0 mm/page_alloc.c:4741
 __alloc_frozen_pages_noprof+0x319/0x370 mm/page_alloc.c:5223
 alloc_slab_page mm/slub.c:3077 [inline]
 allocate_slab+0x7a/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xf2b/0x1960 mm/slub.c:4656
 __slab_alloc+0x65/0x100 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_node_noprof+0x5d9/0x820 mm/slub.c:5663
 kmalloc_array_node_noprof include/linux/slab.h:1075 [inline]
 alloc_slab_obj_exts+0x3e/0x100 mm/slub.c:2123
 __memcg_slab_post_alloc_hook+0x330/0x730 mm/memcontrol.c:3197
 memcg_slab_post_alloc_hook mm/slub.c:2338 [inline]
 slab_post_alloc_hook mm/slub.c:4964 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __do_kmalloc_node mm/slub.c:5656 [inline]
 __kmalloc_node_track_caller_noprof+0x5f3/0x820 mm/slub.c:5764
 __kmemdup_nul mm/util.c:64 [inline]
 kstrdup+0x42/0x100 mm/util.c:84
 alloc_vfsmnt+0xeb/0x430 fs/namespace.c:302
 vfs_create_mount+0x69/0x320 fs/namespace.c:1184
 fc_mount fs/namespace.c:1202 [inline]
 do_new_mount_fc fs/namespace.c:3636 [inline]
 do_new_mount+0x390/0xa10 fs/namespace.c:3712
 do_mount fs/namespace.c:4035 [inline]
 __do_sys_mount fs/namespace.c:4224 [inline]
 __se_sys_mount+0x313/0x410 fs/namespace.c:4201
page last free pid 5862 tgid 5862 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc8/0xd30 mm/page_alloc.c:2943
 __slab_free+0x21b/0x2a0 mm/slub.c:6004
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x37d/0x710 mm/slub.c:5270
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2498 [inline]
 do_sys_openat2+0xbc/0x200 fs/open.c:1426
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888000779f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888000779f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88800077a000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                                 ^
 ffff88800077a080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88800077a100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         40fbbd64 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16918392580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72e765d013fc99c
dashboard link: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

