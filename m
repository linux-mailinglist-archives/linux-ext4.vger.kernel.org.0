Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACD772FFF6
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjFNNZm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFNNZl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 09:25:41 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C1172A
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 06:25:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qh5lJ6By1z4f3tqM
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 21:25:32 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgAHruvIv4lkEVluLg--.13944S3;
        Wed, 14 Jun 2023 21:25:29 +0800 (CST)
Subject: Re: [PATCH v3 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
To:     Theodore Ts'o <tytso@mit.edu>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yukuai3@huawei.com
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-5-yi.zhang@huaweicloud.com>
 <20230613043120.GB1584772@mit.edu>
 <20002902-39c5-914b-75b0-5a21b5cee25c@huawei.com>
 <20230613172749.GA18303@mit.edu> <20230614054222.GD51259@mit.edu>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <1033cd3b-e41f-e4e0-c2ee-c4b23979208a@huaweicloud.com>
Date:   Wed, 14 Jun 2023 21:25:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230614054222.GD51259@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAHruvIv4lkEVluLg--.13944S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWrJr1kXw4Uur43WrWkXrb_yoWxZr4fpr
        15KF1kWr48tr18JrWxXr15JF17Jw18AF17Gw1I9rs7J3WrW3W7XrWUKr4UAryDurZ8WF12
        qr1DJw18Kr4DKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/14 13:42, Theodore Ts'o wrote:
> OK, some more updates.  First of all, the e2fsck hang in the ext4/adv
> case is an inline_data bug in e2fsck/pass2.c:check_dir_block(); the
> code is clearly buggy, and I'll be sending out a fix in the next day
> or two.
> 
> I still don't understand why this patch series is changing the kernel
> behaviour enough to change the resulting file system in such a way as
> to unmask this bug.  The bug is triggered by file system corruption,
> so the question is whether this patch series is somehow causing the
> file system to be more corrupted than it otherwise would be.  I'm not
> sure.
> 
> However, the ext4/ext3 hang *is* a real hang in the kernel space, and
> generic/475 is not completing because the kernel seems to have ended
> up deadlocking somehow.  With just the first patch in this patch
> series ("jbd2: recheck chechpointing non-dirty buffer") we're getting
> a kernel NULL pointer derefence:
> 
> [  310.447568] EXT4-fs error (device dm-7): ext4_check_bdev_write_error:223: comm fsstress: Error while async write back metadata
> [  310.458038] EXT4-fs error (device dm-7): __ext4_get_inode_loc_noinmem:4467: inode #99400: block 393286: comm fsstress: unable to read itable block
> [  310.458421] JBD2: IO error reading journal superblock
> [  310.484755] EXT4-fs warning (device dm-7): ext4_end_bio:343: I/O error 10 writing to inode 36066 starting block 19083)
> [  310.490956] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  310.490959] #PF: supervisor write access in kernel mode
> [  310.490961] #PF: error_code(0x0002) - not-present page
> [  310.490963] PGD 0 P4D 0 
> [  310.490966] Oops: 0002 [#1] PREEMPT SMP PTI
> [  310.490970] CPU: 1 PID: 15600 Comm: fsstress Not tainted 6.4.0-rc5-xfstests-00055-gd3ab1bca26b4 #190
> [  310.490974] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> [  310.490976] RIP: 0010:jbd2_journal_set_features+0x13d/0x430
> [  310.490985] Code: 0f 94 c0 44 20 e8 0f 85 e0 00 00 00 be 94 01 00 00 48 c7 c7 a1 33 59 b4 48 89 0c 24 4c 8b 7d 38 e8 a8 dc c5 ff 2e 2e 2e 31 c0 <f0> 49 0f ba 2f 02 48 8b 0c 24 0f 82 24 02 00 00 45 84 ed 8b 41 28
> [  310.490988] RSP: 0018:ffffb9b441043b30 EFLAGS: 00010246
> [  310.490990] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8edb447b8100
> [  310.490993] RDX: 0000000000000000 RSI: 0000000000000194 RDI: ffffffffb45933a1
> [  310.490994] RBP: ffff8edb45a62800 R08: ffffffffb460d6c0 R09: 0000000000000000
> [  310.490996] R10: 204f49203a324442 R11: 4f49203a3244424a R12: 0000000000000000
> [  310.490997] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> [  310.490999] FS:  00007f2940cca740(0000) GS:ffff8edc19500000(0000) knlGS:0000000000000000
> [  310.491005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  310.491007] CR2: 0000000000000000 CR3: 000000012543e003 CR4: 00000000003706e0
> [  310.491009] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  310.491011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  310.491012] Call Trace:
> [  310.491016]  <TASK>
> [  310.491019]  ? __die+0x23/0x60
> [  310.491025]  ? page_fault_oops+0xa4/0x170
> [  310.491029]  ? exc_page_fault+0x67/0x170
> [  310.491032]  ? asm_exc_page_fault+0x26/0x30
> [  310.491039]  ? jbd2_journal_set_features+0x13d/0x430
> [  310.491043]  jbd2_journal_revoke+0x47/0x1e0
> [  310.491046]  __ext4_forget+0xc3/0x1b0
> [  310.491051]  ext4_free_blocks+0x214/0x2f0
> [  310.491056]  ext4_free_branches+0xeb/0x270
> [  310.491061]  ext4_ind_truncate+0x2bf/0x320
> [  310.491065]  ext4_truncate+0x1e4/0x490
> [  310.491069]  ext4_handle_inode_extension+0x1bd/0x2a0
> [  310.491073]  ? iomap_dio_complete+0xaf/0x1d0
> [  310.511141] ------------[ cut here ]------------
> [  310.516121]  ext4_dio_write_iter+0x346/0x3e0
> [  310.516132]  ? __handle_mm_fault+0x171/0x200
> [  310.516135]  vfs_write+0x21a/0x3e0
> [  310.516140]  ksys_write+0x6f/0xf0
> [  310.516142]  do_syscall_64+0x3b/0x90
> [  310.516147]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [  310.516154] RIP: 0033:0x7f2940eb2fb3
> [  310.516158] Code: 75 05 48 83 c4 58 c3 e8 cb 41 ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> [  310.516161] RSP: 002b:00007ffe9a322cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  310.516165] RAX: ffffffffffffffda RBX: 0000000000003000 RCX: 00007f2940eb2fb3
> [  310.516167] RDX: 0000000000003000 RSI: 0000556ba1e31000 RDI: 0000000000000003
> [  310.516168] RBP: 0000000000000003 R08: 0000556ba1e31000 R09: 00007f2940e9bbe0
> [  310.516170] R10: 0000556b9fedbf59 R11: 0000000000000246 R12: 0000000000000024
> [  310.516172] R13: 00000000000cf000 R14: 0000556ba1e31000 R15: 0000000000000000
> [  310.516174]  </TASK>
> [  310.516178] CR2: 0000000000000000
> [  310.516181] ---[ end trace 0000000000000000 ]---
> 

Sorry about the regression, I found that this issue is not introduced
by the first patch in this patch series ("jbd2: recheck chechpointing
non-dirty buffer"), is d9eafe0afafa ("jbd2: factor out journal
initialization from journal_get_superblock()") [1] on your dev branch.

The problem is the journal super block had been failed to write out
due to IO fault, it's uptodate bit was cleared by
end_buffer_write_syn() and didn't reset yet in jbd2_write_superblock().
And it raced by jbd2_journal_revoke()->jbd2_journal_set_features()->
jbd2_journal_check_used_features()->journal_get_superblock()->bh_read(),
unfortunately, the read IO is also fail, so the error handling in
journal_fail_superblock() clear the journal->j_sb_buffer, finally lead
to above NULL pointer dereference issue.

I think the fix could be just move buffer_verified(bh) in front of
bh_read(). I can send out the fix after tests.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=d9eafe0afafaa519953735498c2a065d223c519b

Thanks,
Yi.

> This is then causing fsstress to wedge:
> 
> # ps -ax -o pid,user,wchan:20,args --sort pid
>     PID USER     WCHAN                COMMAND
> 	...
>   12860 root     do_wait              /bin/bash /root/xfstests/tests/generic/475
>   13086 root     rescuer_thread       [kdmflush/253:7]
>   15593 root     rescuer_thread       [ext4-rsv-conver]
>   15598 root     jbd2_log_wait_commit ./ltp/fsstress -d /xt-vdc -n 999999 -p 4
>   15600 root     ext4_release_file    [fsstress]
>   15601 root     exit_aio             [fsstress]
> 
> So at this point, I'm going to drop this entire patch series from the
> dev tree, since this *does* seem to be some kind of regression
> triggered by the first patch in the patch series.
> 
> Regards,
> 
> 					- Ted
> 

