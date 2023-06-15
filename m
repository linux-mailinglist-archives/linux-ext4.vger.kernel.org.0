Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A004F731209
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 10:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbjFOIXD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 04:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbjFOIXC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 04:23:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29A1FC7
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 01:23:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QhZzh220yz4f4GfR
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 16:22:56 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP2 (Coremail) with SMTP id Syh0CgC3ltRayopkayutLg--.23024S3;
        Thu, 15 Jun 2023 16:22:52 +0800 (CST)
Subject: Re: [PATCH] jbd2: skip reading super block if it has been verified
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20230615034941.2335484-1-yi.zhang@huaweicloud.com>
 <20230615052654.GF51259@mit.edu>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <388f4a26-c689-3c0b-e1b4-45e68c245c6d@huaweicloud.com>
Date:   Thu, 15 Jun 2023 16:22:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230615052654.GF51259@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgC3ltRayopkayutLg--.23024S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww43Xr47Ww45Ww15JryrZwb_yoW3Aw4Upr
        yakFyUWrWvyr17J3y0yF4Utas5X3yDAay7Gr18ur4Iyay5WrnxtF1UGr4UtFyUur9rWw1j
        vF4DCw40gw4UtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
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

On 2023/6/15 13:26, Theodore Ts'o wrote:
> On Thu, Jun 15, 2023 at 11:49:41AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> We got a NULL pointer dereference issue below while running generic/475
>> I/O failure pressure test.
> 
> Have you been able to reproduce this failure without the "recheck
> checkpoint" series applied?  I have not, so like with the e2fsck bug
> fix, I can understand how the bug fix worked, but I still don't
> understand why I wasn't seeing until I tried to apply the "recheck
> chekcpoint" and the following patches in that patch series.

Yes, I can reproduce this failure without the "recheck
checkpoint" series applied, I reproduced it in ranges from about 5
minutes to 1 hour on your dev branch(just reset to the parent commit
5404e4738054 "ext4: refactoring to use the unified helper
ext4_quotas_off()") with below fstests config.

# ext4 regression fstests config
[ext4]
export FSTYP=ext4
export TEST_DEV=/dev/pmem0p1
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/pmem0p2
export SCRATCH_MNT=/mnt/scratch
export LOGWRITES_DEV=/dev/vdc1
export SCRATCH_LOGDEV=/dev/vdc2
export MKFS_OPTIONS="-O ^extents,^flex_bg,^uninit_bg,^64bit,^metadata_csum,^huge_file,^dir_nlink,^extra_isize"

[  315.435845] EXT4-fs (dm-0): previous I/O error to superblock detected
[  315.435877] EXT4-fs (dm-0): I/O error while writing superblock
[  315.435885] EXT4-fs (dm-0): Remounting filesystem read-only
[  315.438261] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  315.453689] #PF: supervisor write access in kernel mode
[  315.454884] #PF: error_code(0x0002) - not-present page
[  315.456048] PGD 139b3b067 P4D 139b3b067 PUD 1538ea067 PMD 0
[  315.456201] EXT4-fs error (device dm-0): __ext4_find_entry:1678: inode #131073: comm fsstress: reading directory lblock 0
[  315.457403] Oops: 0002 [#1] PREEMPT SMP
[  315.457411] CPU: 14 PID: 10107 Comm: fsstress Not tainted 6.4.0-rc5-00054-g5404e4738054 #214
[  315.457416] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
[  315.457418] RIP: 0010:jbd2_journal_set_features+0xf4/0x500
[  315.461326] EXT4-fs (dm-0): I/O error while writing superblock
[  315.462073] Code: 48 83 05 5e 32 90 0c 01 48 83 05 f6 05 90 0c 01 4d 8b 74 24 38 e8 dc 6c bc 00 48 83 05 ec 05 90 0c 01 48 83 05 bc 05 90 0c 01 <f0> 49 0f ba 2e 02 0f 92 c0 48 83 05 b3 05 90 0c 01 48 83 05 d5
[  315.462086] RSP: 0018:ffffc900116cbad8 EFLAGS: 00010212
[  315.462103] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[  315.462107] RDX: 0000000080000000 RSI: ffffffffafd25d54 RDI: 0000000000000001
[  315.462115] RBP: 0000000000000000 R08: ffffffffafd256f0 R09: 0000000000000000
[  315.468526] R10: 642820726f727265 R11: 2073662d34545845 R12: ffff88817e85e800
[  315.468535] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888126d93000
[  315.468548] FS:  00007fda46982b80(0000) GS:ffff888237980000(0000) knlGS:0000000000000000
[  315.468560] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  315.468568] CR2: 0000000000000000 CR3: 00000001398d0000 CR4: 00000000000006e0
[  315.487792] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  315.487798] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  315.491048] Call Trace:
[  315.491560]  <TASK>
[  315.494065]  ? show_regs+0x84/0x90
[  315.494089]  ? __die_body+0x22/0x90
[  315.494104]  ? __die+0x35/0x50
[  315.494121]  ? page_fault_oops+0x1d3/0x5e0
[  315.515211]  ? search_bpf_extables+0x85/0xc0
[  315.523168]  ? jbd2_journal_set_features+0xf4/0x500
[  315.524214]  ? search_exception_tables+0x7c/0x90
[  315.525211]  ? kernelmode_fixup_or_oops+0x140/0x1a0
[  315.526370]  ? __bad_area_nosemaphore+0x208/0x350
[  315.527475]  ? mt_find+0x2ab/0x3c0
[  315.528718]  ? __bad_area+0x88/0xc0
[  315.529936]  ? bad_area+0x1a/0x30
[  315.530696]  ? do_user_addr_fault+0xa6d/0xd00
[  315.531550]  ? exc_page_fault+0xe7/0x3b0
[  315.532339]  ? asm_exc_page_fault+0x22/0x30
[  315.533153]  ? jbd2_journal_set_features+0xf4/0x500
[  315.533922]  ? jbd2_journal_set_features+0xe4/0x500
[  315.534636]  jbd2_journal_revoke+0x43/0x330
[  315.535272]  __ext4_forget+0x112/0x2c0
[  315.535804]  ? __find_get_block+0x155/0x5a0
[  315.536443]  ext4_free_blocks+0xbd2/0xf20
[  315.537058]  ? ext4_free_data+0x140/0x210
[  315.538420]  ? ext4_free_branches+0x2d4/0x3a0
[  315.540534]  ext4_free_branches+0x1c9/0x3a0
[  315.542064]  ext4_ind_truncate+0x361/0x3f0
[  315.543304]  ? ext4_discard_preallocations+0x3c1/0x740
[  315.546111]  ext4_truncate+0x4a0/0x710
[  315.547623]  ext4_file_write_iter+0xb8d/0xe90
[  315.548940]  vfs_write+0x20e/0x590
[  315.549986]  ksys_write+0x77/0x160
[  315.552027]  __x64_sys_write+0x1d/0x30
[  315.553492]  do_syscall_64+0x68/0xf0
[  315.554711]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

I also try to accelerate reproduce in about 2 mins through add
delay in jbd2_write_superblock() either applied the "recheck
chekcpoint" patch series or not.

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b5e57735ab3f..90d78fe0fb33 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1623,6 +1623,7 @@ static int journal_reset(journal_t *journal)
  * This function expects that the caller will have locked the journal
  * buffer head, and will return with it unlocked
  */
+#include <linux/delay.h>
 static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 {
 	struct buffer_head *bh = journal->j_sb_buffer;
@@ -1659,6 +1660,7 @@ static int jbd2_write_superblock(journal_t *journal, blk_opf_t write_flags)
 	bh->b_end_io = end_buffer_write_sync;
 	submit_bh(REQ_OP_WRITE | write_flags, bh);
 	wait_on_buffer(bh);
+	msleep(10);
 	if (buffer_write_io_error(bh)) {
 		clear_buffer_write_io_error(bh);
 		set_buffer_uptodate(bh);

> 
>> If the journal super block had been read and verified, there is no need
>> to call bh_read() read it again even if it has been failed to written
>> out. So the fix could be simply move buffer_verified(bh) in front of
>> bh_read().
>>
>> Fixes: d9eafe0afafa ("jbd2: factor out journal initialization from journal_get_superblock()")
> 
> That works, but it's worth noting that commit d9eafe0afafa caused the
> failure by removing the check on j_journal_version to determine
> whether the superblock was read or not.  If the journal superblock had
> been previously read, j_journal_version would be either 1 or 2.  If it
> had been zero, then superblock was not read.  So from commit
> d9eafe0afafa:
> 
>  	/* Load journal superblock if it is not loaded yet. */
> -	if (journal->j_format_version == 0 &&
> -	    journal_get_superblock(journal) != 0)
> +	if (journal_get_superblock(journal))
>  		return 0;
>  	if (!jbd2_format_support_feature(journal))
>  		return 0;
> 
> 
> The comment "Load journal superblock if it is not loaded yet." should
> be removed, since it no longer makes sense once the
> "journal->j_format_version == 0" check was removed.

Yes.

> 
> I'll also note that a problem with d9eafe0afafa is that by removing
> the j_format_version check, every time we add a revoke header, and we
> call jbd2_journal_set_features(), this was causing an unconditional
> read of the journal superblock and that unnecessary I/O could slow
> down certain workloads.
> 

Yes, fortunately it is innocuous in general because the journal super
block buffer is always in memory and uptodate, therefore bh_read() does
not submit I/O. It's only affects the fault case about the window in
jbd2_write_superblock() which the journal super block has been failed
to write out and has not been restore to uptodate yet.

Thanks,
Yi.


