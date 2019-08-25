Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8DC9C518
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Aug 2019 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfHYR2G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 13:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfHYR2G (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 25 Aug 2019 13:28:06 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B8920870;
        Sun, 25 Aug 2019 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754085;
        bh=jMZYD6bw/2BjWeUylfP6Fuw7XTXchSk7kbdnrrY3XhE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Qb+468DVQkmHQld6DizBkVe7EGeTgSbNCCJlj0ED4ihPMau6fyRjUAdN/C7G2pj/L
         UMbDNhWA1HZUBtvaKiIlD3wBj3sDbyUgtm1lqNRts8z+FrO2dQjLFTQSztULnZ+ZMo
         Pwg8uXq0SB6l6uNXMdubTnGWaifm2PmsMYyJRcI0=
Date:   Sun, 25 Aug 2019 10:28:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: change the type of ext4 cache stats to
 percpu_counter to improve performance
Message-ID: <20190825172803.GA9505@sol.localdomain>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <1566528454-13725-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190825032524.GD5163@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190825032524.GD5163@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 24, 2019 at 11:25:24PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Aug 23, 2019 at 10:47:34AM +0800, Shaokun Zhang wrote:
> > From: Yang Guo <guoyang2@huawei.com>
> > 
> > @es_stats_cache_hits and @es_stats_cache_misses are accessed frequently in
> > ext4_es_lookup_extent function, it would influence the ext4 read/write
> > performance in NUMA system.
> > Let's optimize it using percpu_counter, it is profitable for the
> > performance.
> > 
> > The test command is as below:
> > fio -name=randwrite -numjobs=8 -filename=/mnt/test1 -rw=randwrite
> > -ioengine=libaio -direct=1 -iodepth=64 -sync=0 -norandommap -group_reporting
> > -runtime=120 -time_based -bs=4k -size=5G
> > 
> > And the result is better 10% than the initial implement:
> > without the patch，IOPS=197k, BW=770MiB/s (808MB/s)(90.3GiB/120002msec)
> > with the patch,  IOPS=218k, BW=852MiB/s (894MB/s)(99.9GiB/120002msec)
> > 
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Signed-off-by: Yang Guo <guoyang2@huawei.com>
> > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> 
> Applied with some adjustments so it would apply.  I also changed the patch summary to:
> 
>     ext4: use percpu_counters for extent_status cache hits/misses
> 
>     	      		      	  		- Ted

This patch is causing the following.  Probably because there's no calls to
percpu_counter_destroy() for the new counters?

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0x168/0x180 lib/list_debug.c:51
Read of size 8 at addr ffff888063168fa8 by task umount/611

CPU: 1 PID: 611 Comm: umount Not tainted 5.3.0-rc4-00015-gcc08b68e62ec #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x86/0xca lib/dump_stack.c:113
 print_address_description+0x6e/0x2e7 mm/kasan/report.c:351
 __kasan_report.cold+0x1b/0x35 mm/kasan/report.c:482
 kasan_report+0x12/0x17 mm/kasan/common.c:612
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 __list_del_entry_valid+0x168/0x180 lib/list_debug.c:51
 __list_del_entry include/linux/list.h:131 [inline]
 list_del include/linux/list.h:139 [inline]
 percpu_counter_destroy+0x5d/0x230 lib/percpu_counter.c:157
 ext4_put_super+0x319/0xbb0 fs/ext4/super.c:1010
 generic_shutdown_super+0x128/0x320 fs/super.c:458
 kill_block_super+0x97/0xe0 fs/super.c:1310
 deactivate_locked_super+0x7b/0xd0 fs/super.c:331
 deactivate_super+0x138/0x150 fs/super.c:362
 cleanup_mnt+0x298/0x3f0 fs/namespace.c:1102
 __cleanup_mnt+0xd/0x10 fs/namespace.c:1109
 task_work_run+0x103/0x180 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x10b/0x130 arch/x86/entry/common.c:163
 prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
 do_syscall_64+0x343/0x450 arch/x86/entry/common.c:299
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f7caed23d77
Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 8
RSP: 002b:00007ffe960e7c98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000560c039e1060 RCX: 00007f7caed23d77
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000560c039e3c90
RBP: 0000560c039e3c90 R08: 0000560c039e2ec0 R09: 0000000000000014
R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f7caf225e64
R13: 0000000000000000 R14: 0000560c039e1240 R15: 00007ffe960e7f20

Allocated by task 596:
 save_stack mm/kasan/common.c:69 [inline]
 set_track mm/kasan/common.c:77 [inline]
 __kasan_kmalloc.part.0+0x41/0xb0 mm/kasan/common.c:487
 __kasan_kmalloc.constprop.0+0xba/0xc0 mm/kasan/common.c:468
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:501
 kmem_cache_alloc_trace+0x11e/0x2e0 mm/slab.c:3550
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:748 [inline]
 ext4_fill_super+0x111/0x80a0 fs/ext4/super.c:3610
 mount_bdev+0x286/0x350 fs/super.c:1283
 ext4_mount+0x10/0x20 fs/ext4/super.c:6007
 legacy_get_tree+0x101/0x1f0 fs/fs_context.c:661
 vfs_get_tree+0x86/0x2e0 fs/super.c:1413
 do_new_mount fs/namespace.c:2791 [inline]
 do_mount+0x1093/0x1b30 fs/namespace.c:3111
 ksys_mount+0x7d/0xd0 fs/namespace.c:3320
 __do_sys_mount fs/namespace.c:3334 [inline]
 __se_sys_mount fs/namespace.c:3331 [inline]
 __x64_sys_mount+0xb9/0x150 fs/namespace.c:3331
 do_syscall_64+0x8f/0x450 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 600:
 save_stack mm/kasan/common.c:69 [inline]
 set_track mm/kasan/common.c:77 [inline]
 __kasan_slab_free+0x127/0x1f0 mm/kasan/common.c:449
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:457
 __cache_free mm/slab.c:3425 [inline]
 kfree+0xc1/0x1e0 mm/slab.c:3756
 ext4_put_super+0x78c/0xbb0 fs/ext4/super.c:1061
 generic_shutdown_super+0x128/0x320 fs/super.c:458
 kill_block_super+0x97/0xe0 fs/super.c:1310
 deactivate_locked_super+0x7b/0xd0 fs/super.c:331
 deactivate_super+0x138/0x150 fs/super.c:362
 cleanup_mnt+0x298/0x3f0 fs/namespace.c:1102
 __cleanup_mnt+0xd/0x10 fs/namespace.c:1109
 task_work_run+0x103/0x180 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x10b/0x130 arch/x86/entry/common.c:163
 prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
 do_syscall_64+0x343/0x450 arch/x86/entry/common.c:299
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888063168980
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1576 bytes inside of
 4096-byte region [ffff888063168980, ffff888063169980)
The buggy address belongs to the page:
page:ffffea00015acec0 refcount:1 mapcount:0 mapping:ffff88806d000900 index:0x0 compound_mapcount: 0
flags: 0x100000000010200(slab|head)
raw: 0100000000010200 ffffea00015b9f08 ffffea0001749e58 ffff88806d000900
raw: 0000000000000000 ffff888063168980 0000000100000001
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888063168e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888063168f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888063168f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888063169000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888063169080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
