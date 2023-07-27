Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74087643E3
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 04:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjG0Ciu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 22:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjG0Cir (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 22:38:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9297271B;
        Wed, 26 Jul 2023 19:38:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RBFLd5st1z4f44x9;
        Thu, 27 Jul 2023 10:38:17 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbCU2MFkVbuYOw--.15810S3;
        Thu, 27 Jul 2023 10:38:14 +0800 (CST)
Subject: Re: [dm-devel] Processes hung in "D" state in ext4, mm, md and
 dmcrypt
To:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, dm-devel@redhat.com,
        linux-ext4@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <4919.1690365747@warthog.procyon.org.uk>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <454e24e1-9713-f267-6332-d95f1273f378@huaweicloud.com>
Date:   Thu, 27 Jul 2023 10:38:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4919.1690365747@warthog.procyon.org.uk>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbCU2MFkVbuYOw--.15810S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr1kuF1kXFyxKr48XFyftFb_yoW7Cw4Upr
        yagFnxJr48J34UAa18Jw1vvryIva15Wry7Jr1fKF1fJa1rWw4UtF95t3Waqr98Cas7X3yU
        Way8GrZ8ua1DtF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

ÔÚ 2023/07/26 18:02, David Howells Ð´µÀ:
> Hi,
> 
> With 6.5-rc2 (6.5.0-0.rc2.20230721gitf7e3a1bafdea.20.fc39.x86_64), I'm seeing
> a bunch of processes getting stuck in the D state on my desktop after a few
> hours of reading email and compiling stuff.  It's happened every day this week
> so far and I managed to grab stack traces of the stuck processes this morning
> (see attached).
> 
> There are two blockdevs involved below, /dev/md2 and /dev/md3.  md3 is a raid1
> array with two partitions with an ext4 partition on it.  md2 is similar but
> it's dm-crypted and ext4 is on top of that.
> 
> David
> ---
> 
>     1015 ?        D      0:04 [md2_raid1]
>     1074 ?        D      0:00 [jbd2/sda6-8]
>     1138 ?        D      0:00 [jbd2/md3-8]
>     1167 ?        D      0:10 [dmcrypt_write/253:0]
>     1202 ?        D      0:03 [jbd2/dm-0-8]
>   117547 ?        D      5:12 [kworker/u16:8+flush-9:3]
>   121540 ?        D      0:46 [kworker/u16:10+flush-253:0]
>   125431 pts/2    Dl+    0:00 emacs .stgit-edit.txt
>   125469 ?        D      0:00 /usr/libexec/nmh/rcvstore +kernel
> 
> ===1015===
>      PID TTY      STAT   TIME COMMAND
>     1015 ?        D      0:04 [md2_raid1]
> [<0>] md_super_wait+0xa2/0xe0
> [<0>] md_bitmap_daemon_work+0x183/0x3b0
> [<0>] md_check_recovery+0x42/0x5a0
> [<0>] raid1d+0x87/0x16f0 [raid1]
> [<0>] md_thread+0xab/0x190
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30

This means either the io to write super_block is stuck in underlying
disks or writing super_block is broken, I think it's probably the
former case. You'll need to locate where this io is now. If it can
be sure that there is no io in underlying disks, then this problem
is related to raid.
> 
> ===1074===
>      PID TTY      STAT   TIME COMMAND
>     1074 ?        D      0:00 [jbd2/sda6-8]
> [<0>] jbd2_journal_commit_transaction+0x11a6/0x1a20
> [<0>] kjournald2+0xad/0x280
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30
> 
> ===1138===
>      PID TTY      STAT   TIME COMMAND
>     1138 ?        D      0:00 [jbd2/md3-8]
> [<0>] jbd2_journal_commit_transaction+0x162d/0x1a20
> [<0>] kjournald2+0xad/0x280
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30
> 
> ===1167===
>      PID TTY      STAT   TIME COMMAND
>     1167 ?        D      0:10 [dmcrypt_write/253:0]
> [<0>] md_super_wait+0xa2/0xe0
> [<0>] md_bitmap_unplug+0xad/0x120
> [<0>] flush_bio_list+0xf3/0x100 [raid1]
> [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> [<0>] __blk_flush_plug+0xd8/0x160
> [<0>] blk_finish_plug+0x29/0x40
> [<0>] dmcrypt_write+0x132/0x140 [dm_crypt]
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30
> 
> ===1202===
>      PID TTY      STAT   TIME COMMAND
>     1202 ?        D      0:03 [jbd2/dm-0-8]
> [<0>] jbd2_journal_commit_transaction+0x162d/0x1a20
> [<0>] kjournald2+0xad/0x280
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30
> 
> ===117547===
>      PID TTY      STAT   TIME COMMAND
>   117547 ?        D      5:12 [kworker/u16:8+flush-9:3]
> [<0>] blk_mq_get_tag+0x11e/0x2b0

Is this one of raid underlying disks? If so, this looks like io is stuck
in underlying disks.

Thanks,
Kuai

> [<0>] __blk_mq_alloc_requests+0x1bc/0x350
> [<0>] blk_mq_submit_bio+0x2c7/0x680
> [<0>] __submit_bio+0x8b/0x170
> [<0>] submit_bio_noacct_nocheck+0x159/0x370
> [<0>] __block_write_full_folio+0x1e1/0x400
> [<0>] writepage_cb+0x1a/0x70
> [<0>] write_cache_pages+0x144/0x3b0
> [<0>] do_writepages+0x164/0x1e0
> [<0>] __writeback_single_inode+0x3d/0x360
> [<0>] writeback_sb_inodes+0x1ed/0x4b0
> [<0>] __writeback_inodes_wb+0x4c/0xf0
> [<0>] wb_writeback+0x298/0x310
> [<0>] wb_workfn+0x35b/0x510
> [<0>] process_one_work+0x1de/0x3f0
> [<0>] worker_thread+0x51/0x390
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30
> 
> ===121540===
>      PID TTY      STAT   TIME COMMAND
>   121540 ?        D      0:46 [kworker/u16:10+flush-253:0]
> [<0>] folio_wait_bit_common+0x13d/0x350
> [<0>] mpage_prepare_extent_to_map+0x309/0x4d0
> [<0>] ext4_do_writepages+0x25d/0xc90
> [<0>] ext4_writepages+0xad/0x180
> [<0>] do_writepages+0xcf/0x1e0
> [<0>] __writeback_single_inode+0x3d/0x360
> [<0>] writeback_sb_inodes+0x1ed/0x4b0
> [<0>] __writeback_inodes_wb+0x4c/0xf0
> [<0>] wb_writeback+0x298/0x310
> [<0>] wb_workfn+0x35b/0x510
> [<0>] process_one_work+0x1de/0x3f0
> [<0>] worker_thread+0x51/0x390
> [<0>] kthread+0xe5/0x120
> [<0>] ret_from_fork+0x31/0x50
> [<0>] ret_from_fork_asm+0x1b/0x30
> 
> ===125431===
>      PID TTY      STAT   TIME COMMAND
>   125431 pts/2    Dl+    0:00 emacs .stgit-edit.txt
> [<0>] jbd2_log_wait_commit+0xd8/0x140
> [<0>] ext4_sync_file+0x1cc/0x380
> [<0>] __x64_sys_fsync+0x3b/0x70
> [<0>] do_syscall_64+0x5d/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> ===125469===
>      PID TTY      STAT   TIME COMMAND
>   125469 ?        D      0:00 /usr/libexec/nmh/rcvstore +kernel
> [<0>] folio_wait_bit_common+0x13d/0x350
> [<0>] folio_wait_writeback+0x2c/0x90
> [<0>] truncate_inode_partial_folio+0x5e/0x1a0
> [<0>] truncate_inode_pages_range+0x1da/0x400
> [<0>] truncate_pagecache+0x47/0x60
> [<0>] ext4_setattr+0x685/0xba0
> [<0>] notify_change+0x1e0/0x4a0
> [<0>] do_truncate+0x98/0xf0
> [<0>] do_sys_ftruncate+0x15c/0x1b0
> [<0>] do_syscall_64+0x5d/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
> .
> 

