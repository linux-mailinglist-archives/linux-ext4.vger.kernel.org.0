Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB5694BD7
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 16:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBMP4t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 10:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBMP4s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 10:56:48 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D91BFC
        for <linux-ext4@vger.kernel.org>; Mon, 13 Feb 2023 07:56:47 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id i23-20020a056e021d1700b003111192e89aso9568555ila.10
        for <linux-ext4@vger.kernel.org>; Mon, 13 Feb 2023 07:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMO3sspk7P+Mq1nipJz9biyunW+h9MSd0H8isba1l8w=;
        b=P+KZK3jM+2vvRshprtQZ0wYXlAQzVtxKX58v4Y82LwzB3LfVgYWcqhwG1zR26+kTEk
         CG6QzDWuGJfnF66f4yK9jvG71KNARhTWwoZBkBJO9V5ntbm3kcRZ6TvuYIGLlQQo7NBO
         WXIyHqVklIgb+SejAGK2XdSeobKRPRUHfqCKd+9vGMFiot+FV04eNQrJxWUGhBuv+OIb
         lGaNlpDNoQnQSPM1QkxMsbHsBPg2iNrgBFdSwSnCtFvzg5N8oUiHxf4scVCn7YiiG+Nm
         FBVUbAWN5jv6k7iv86PudjW5dpFbGosZnjaEBK48MoVSIL+NQo5URETW5PqaUP+QlJcI
         jwSg==
X-Gm-Message-State: AO0yUKVMpoReTrHKTlZL+u2aOekBWQ/g729FrnX75+guyJ+58FRBfiQm
        h9Zd0cURGe1GLpQP74OiEa4pckv17iLBWa295dcVmUtEB5v1
X-Google-Smtp-Source: AK7set8pPDCFvoxfzaoc+/l3Ansmw2opU4BSGcWSIiBnzk3W6ANAES7x+y/67tHoOkiOMpMr+oEjuTfevRf6TPONNzRRCU6elGkJ
MIME-Version: 1.0
X-Received: by 2002:a92:3f04:0:b0:310:efc8:49bf with SMTP id
 m4-20020a923f04000000b00310efc849bfmr2572917ila.5.1676303806719; Mon, 13 Feb
 2023 07:56:46 -0800 (PST)
Date:   Mon, 13 Feb 2023 07:56:46 -0800
In-Reply-To: <000000000000ece18705f3b20934@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef6cf905f496e40b@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_group_desc_csum
From:   syzbot <syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ceaa837f96ad Linux 6.2-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11727cc7480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42ba4da8e1e6af9f
dashboard link: https://syzkaller.appspot.com/bug?extid=8785e41224a3afd04321
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14392a4f480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88042f9b5fc8/disk-ceaa837f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9945b57ec9ee/vmlinux-ceaa837f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72ff118ed96b/bzImage-ceaa837f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dabec17b2679/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in crc16+0x1fb/0x280 lib/crc16.c:58
Read of size 1 at addr ffff88807de00000 by task syz-executor.1/5339

CPU: 1 PID: 5339 Comm: syz-executor.1 Not tainted 6.2.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x163/0x4f0 mm/kasan/report.c:417
 kasan_report+0x13a/0x170 mm/kasan/report.c:517
 crc16+0x1fb/0x280 lib/crc16.c:58
 ext4_group_desc_csum+0x90f/0xc50 fs/ext4/super.c:3187
 ext4_group_desc_csum_set+0x19b/0x240 fs/ext4/super.c:3210
 ext4_mb_clear_bb fs/ext4/mballoc.c:6027 [inline]
 ext4_free_blocks+0x1c57/0x3010 fs/ext4/mballoc.c:6173
 ext4_remove_blocks fs/ext4/extents.c:2527 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2710 [inline]
 ext4_ext_remove_space+0x289e/0x5270 fs/ext4/extents.c:2958
 ext4_ext_truncate+0x176/0x210 fs/ext4/extents.c:4416
 ext4_truncate+0xafa/0x1450 fs/ext4/inode.c:4342
 ext4_evict_inode+0xc40/0x1230 fs/ext4/inode.c:286
 evict+0x2a4/0x620 fs/inode.c:664
 do_unlinkat+0x4f1/0x930 fs/namei.c:4327
 __do_sys_unlink fs/namei.c:4368 [inline]
 __se_sys_unlink fs/namei.c:4366 [inline]
 __x64_sys_unlink+0x49/0x50 fs/namei.c:4366
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbc85a8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc86838168 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007fbc85babf80 RCX: 00007fbc85a8c0f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007fbc85ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd5743beaf R14: 00007fbc86838300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001f78000 refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x7de00
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001f86008 ffffea0001db2a08 0000000000000000
raw: 0000000000000000 0000000000000001 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4855, tgid 4855 (sshd), ts 43553490210, free_ts 58249059760
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x3449/0x35c0 mm/page_alloc.c:4283
 __alloc_pages+0x291/0x7e0 mm/page_alloc.c:5549
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
 kmem_cache_alloc_bulk+0x160/0x430 mm/slub.c:4026
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x381/0x640 lib/maple_tree.c:1257
 mas_node_count_gfp lib/maple_tree.c:1316 [inline]
 mas_preallocate+0x131/0x350 lib/maple_tree.c:5724
 vma_expand+0x277/0x850 mm/mmap.c:541
 mmap_region+0xc43/0x1fb0 mm/mmap.c:2592
 do_mmap+0x8c9/0xf70 mm/mmap.c:1411
 vm_mmap_pgoff+0x1ce/0x2e0 mm/util.c:520
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare mm/page_alloc.c:1496 [inline]
 free_unref_page_prepare+0xf3a/0x1040 mm/page_alloc.c:3369
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3464
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x15a/0x170 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook+0x68/0x390 mm/slab.h:761
 slab_alloc_node mm/slub.c:3452 [inline]
 kmem_cache_alloc_node+0x158/0x2c0 mm/slub.c:3497
 __alloc_skb+0xd6/0x2d0 net/core/skbuff.c:552
 alloc_skb include/linux/skbuff.h:1270 [inline]
 alloc_skb_with_frags+0xa8/0x750 net/core/skbuff.c:6194
 sock_alloc_send_pskb+0x919/0xa50 net/core/sock.c:2743
 unix_dgram_sendmsg+0x5b5/0x2050 net/unix/af_unix.c:1943
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 __sys_sendto+0x475/0x5f0 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xde/0xf0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807ddfff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807ddfff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807de00000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807de00080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807de00100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

