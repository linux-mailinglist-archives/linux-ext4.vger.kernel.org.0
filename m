Return-Path: <linux-ext4+bounces-3488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80893E3FE
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56971F2193A
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FA9DF5C;
	Sun, 28 Jul 2024 07:54:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7DB660
	for <linux-ext4@vger.kernel.org>; Sun, 28 Jul 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722153268; cv=none; b=mZkX+28w4U6qaV3mCwQ6DoCuvcWrUtW0WwKSs3J481PjNbBUDiYH1VQPk+1yDfu6NLKvKR95A85XcQpwl9F+22gQNsfOwTWGZ/8i4gaoLLMBOJxTk+98ZnJ2qqLCaQpFNhzMY8W8qlbY/LmQOpmF29F8WTVTtQaau1e8F9kHpmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722153268; c=relaxed/simple;
	bh=kcgTXQ3ksT3kQX2MNm4FHUC5QhHbMbx3nIv9zF+Hl+I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AJI8F0r4fehC5UCeyobWmiu1pi3GsuAZXLQS8GwBBA5QL31Rjw+2o7hUb5VkTAcYh+FC8A4yq/cK8scyerYd2iYSwfVzuHninnY3YTQNUlQZ3QEegVtdZCxuLEZRSvC/PfmSyRoBdZ5Lz/Z/M3gOcpZ4E/L6wKx+xKt3Pcmv5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f9612b44fso232720839f.2
        for <linux-ext4@vger.kernel.org>; Sun, 28 Jul 2024 00:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722153265; x=1722758065;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmD2retsie/O4j2fZQsePJKA5vLuuXflPmVKf9YI57E=;
        b=GiUr8YlaX+Y9AtT/rSmrfxknzy7mAZlNX3y6v/gEG73PWxf7TPhqXuLZsL1wYZbWpy
         Nf2/aa/mCO/hF1g4N97cJTY7qCWaS9XKlT7x7Jw4oCpHD0FZwx+35x9gsoobUXa3M8we
         CNeqArsTJg8XMMTLfXpfEoSe9c1Zdexo8a7zoM+QfI8Qt0xeHAOKG1PwAR57A9v86UDU
         k6UVQyFpwipJQehwYifN2NawsoccWGUE8E3HnxwUQdBHeRGTZACP5ZqqkrlPs54Lk8eC
         /VSFsN3uwpyNtq444gXEI+lmhcClqkyroht5N3UcpIZ7i/xbyKTTH0qgEknpPMLtlnjt
         /WXA==
X-Forwarded-Encrypted: i=1; AJvYcCWvARl4svqOQlNR3wjo//5rcHT7cbRe4bqlnuT1vpaQiKH5ZDGIQxYcrlhAUNn6rAf8wJxQqHpXgEZiUlG3ey/8l9JUR47PzYOYog==
X-Gm-Message-State: AOJu0YzvvUGGTQBrblsI/AAGow0ef4EabfIKKFDI/ixL8ag7NNI3t7oZ
	GrEwqQ3FodDQC6Yj9SL1C7SrqjCbGUYzqjMTEESsBpYUQ+JPXIs5c5UQWiUCI/AA3YYiVVEpdWW
	hw1TNk0l8PO8JNWfJYHBNbnscn6bM5z5LLCeqhSwCd62OEdhMXcqtgVQ=
X-Google-Smtp-Source: AGHT+IFado6zFZJuZ1WWyIxYZ4FKQB1T6qKCNAsZI6QafSibrz+J7eYpj9msnDTCE7GJh9QbZsDqdmwm81flnWLOdwikpwKLsmyj
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2395:b0:4c2:90d0:b311 with SMTP id
 8926c6da1cb9f-4c6442dbc4bmr166000173.3.1722153264847; Sun, 28 Jul 2024
 00:54:24 -0700 (PDT)
Date: Sun, 28 Jul 2024 00:54:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099a654061e4a0d97@google.com>
Subject: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_read_inline_dir
From: syzbot <syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    910bfc26d16d Merge tag 'rust-6.11' of https://github.com/R..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11989e55980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=ee5f6a9c86b42ed64fec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ddcb03980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cb739d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/863d9befadf0/disk-910bfc26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/431d0c4adec0/vmlinux-910bfc26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5be5e371ff13/bzImage-910bfc26.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e479ea98ade5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com

EXT4-fs error (device loop0): ext4_readdir:260: inode #2: block 16: comm syz-executor279: path /0/bus: bad entry in directory: rec_len is smaller than minimal - offset=980, inode=0, rec_len=0, size=1024 fake=0
==================================================================
BUG: KASAN: slab-use-after-free in ext4_read_inline_data fs/ext4/inline.c:209 [inline]
BUG: KASAN: slab-use-after-free in ext4_read_inline_dir+0x48b/0xdf0 fs/ext4/inline.c:1483
Read of size 68 at addr ffff88802a4e151a by task syz-executor279/5219

CPU: 0 UID: 0 PID: 5219 Comm: syz-executor279 Not tainted 6.10.0-syzkaller-12857-g910bfc26d16d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 ext4_read_inline_data fs/ext4/inline.c:209 [inline]
 ext4_read_inline_dir+0x48b/0xdf0 fs/ext4/inline.c:1483
 ext4_readdir+0x3bb/0x3500 fs/ext4/dir.c:158
 iterate_dir+0x57a/0x810 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:407 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe67f0194e3
Code: c1 66 0f 1f 44 00 00 48 83 c4 08 48 89 ef 5b 5d e9 72 2b fb ff 66 90 b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 b8 ff ff ff f7 d8
RSP: 002b:00007ffdc89962e8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000555584be0770 RCX: 00007fe67f0194e3
RDX: 0000000000008000 RSI: 0000555584be0770 RDI: 0000000000000005
RBP: 0000555584be0744 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000293 R12: ffffffffffffffb8
R13: 0000000000000016 R14: 0000555584be0740 R15: 0000000000000001
 </TASK>

Allocated by task 5211:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
 skb_clone+0x20c/0x390 net/core/skbuff.c:2071
 dev_queue_xmit_nit+0x419/0xc10 net/core/dev.c:2313
 xmit_one net/core/dev.c:3576 [inline]
 dev_hard_start_xmit+0x15f/0x7e0 net/core/dev.c:3596
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3809 [inline]
 __dev_queue_xmit+0x1a7f/0x3e90 net/core/dev.c:4389
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_write_xmit+0x18b4/0x6a10 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0x9b/0x360 net/ipv4/tcp_output.c:3014
 tcp_sendmsg_locked+0x43b1/0x4e10 net/ipv4/tcp.c:1322
 tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1354
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5211:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 packet_rcv+0x16e/0x13e0 net/packet/af_packet.c:2290
 dev_queue_xmit_nit+0xad4/0xc10 net/core/dev.c:2345
 xmit_one net/core/dev.c:3576 [inline]
 dev_hard_start_xmit+0x15f/0x7e0 net/core/dev.c:3596
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3809 [inline]
 __dev_queue_xmit+0x1a7f/0x3e90 net/core/dev.c:4389
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_write_xmit+0x18b4/0x6a10 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0x9b/0x360 net/ipv4/tcp_output.c:3014
 tcp_sendmsg_locked+0x43b1/0x4e10 net/ipv4/tcp.c:1322
 tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1354
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802a4e1500
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 26 bytes inside of
 freed 240-byte region [ffff88802a4e1500, ffff88802a4e15f0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a4e1
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff888017eba780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 5211, tgid 5211 (sshd), ts 82218906288, free_ts 82218584264
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4700
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
 skb_clone+0x20c/0x390 net/core/skbuff.c:2071
 dev_queue_xmit_nit+0x419/0xc10 net/core/dev.c:2313
 xmit_one net/core/dev.c:3576 [inline]
 dev_hard_start_xmit+0x15f/0x7e0 net/core/dev.c:3596
 sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:343
 __dev_xmit_skb net/core/dev.c:3809 [inline]
 __dev_queue_xmit+0x1a7f/0x3e90 net/core/dev.c:4389
 dev_queue_xmit include/linux/netdevice.h:3105 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0xd41/0x1390 net/ipv4/ip_output.c:235
 ip_local_out net/ipv4/ip_output.c:129 [inline]
 __ip_queue_xmit+0x118c/0x1b80 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x2544/0x3b30 net/ipv4/tcp_output.c:1466
page last free pid 5213 tgid 5213 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2612
 skb_free_frag include/linux/skbuff.h:3383 [inline]
 skb_free_head net/core/skbuff.c:1094 [inline]
 skb_release_data+0x6b2/0x880 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1188 [inline]
 __kfree_skb+0x55/0x70 net/core/skbuff.c:1202
 tcp_rcv_established+0x10a5/0x2020 net/ipv4/tcp_input.c:6135
 tcp_v4_do_rcv+0x96d/0xc70 net/ipv4/tcp_ipv4.c:1909
 tcp_v4_rcv+0x2dbd/0x37f0 net/ipv4/tcp_ipv4.c:2344
 ip_protocol_deliver_rcu+0x22b/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 ip_local_deliver net/ipv4/ip_input.c:254 [inline]
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish+0x3be/0x4f0 net/ipv4/ip_input.c:580
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x75d/0xab0 net/ipv4/ip_input.c:639
 ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5703 [inline]
 __netif_receive_skb_list_core+0x95a/0x980 net/core/dev.c:5751
 __netif_receive_skb_list net/core/dev.c:5803 [inline]
 netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5895
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x310/0x8e0 net/core/dev.c:6246
 virtqueue_napi_complete drivers/net/virtio_net.c:694 [inline]
 virtnet_poll+0x2c99/0x3870 drivers/net/virtio_net.c:2826

Memory state around the buggy address:
 ffff88802a4e1400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a4e1480: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>ffff88802a4e1500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802a4e1580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88802a4e1600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
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

