Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EE372F43B
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 07:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjFNFnI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjFNFnG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 01:43:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854919B6
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 22:43:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-50-124.bstnma.fios.verizon.net [108.7.50.124])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35E5gM5b005541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 01:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686721345; bh=xRv02yEdyEKnG0RcJGChi8JsDE+sSbSqRTCU+XrAUWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Kn7RkCBNMLjI3mF2zpbgd8LgNO+QTAq3TBGKTeh5ksydKymNHCJ+cWonb9pn4dqR7
         SHtpuWCkoUamLHAYMXBQAYc/r66JEjRfdrhS0ft5Dt+NotgzJ4AABx726zlLm7L3id
         9iTbXMSKXo/mqys5szYnYYkkC7wK2icRE5WE3eemg6qu34tDL4cpexXem6pVamwt5M
         DoLWfvLxX38urOkcyweVzgTg+7CN5TcUGPsLWe6iJK1T5VwBYISMZhHnNDANxj48Xw
         d4Z9gKxvODbZLpxpFNXQdo5sFV0pM8JMA0R+F5tVmUvLR+slvbIG12ANJzRxoAbpGU
         HgYb6sqR7lw7A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9CD6415C00B0; Wed, 14 Jun 2023 01:42:22 -0400 (EDT)
Date:   Wed, 14 Jun 2023 01:42:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
Message-ID: <20230614054222.GD51259@mit.edu>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-5-yi.zhang@huaweicloud.com>
 <20230613043120.GB1584772@mit.edu>
 <20002902-39c5-914b-75b0-5a21b5cee25c@huawei.com>
 <20230613172749.GA18303@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172749.GA18303@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

OK, some more updates.  First of all, the e2fsck hang in the ext4/adv
case is an inline_data bug in e2fsck/pass2.c:check_dir_block(); the
code is clearly buggy, and I'll be sending out a fix in the next day
or two.

I still don't understand why this patch series is changing the kernel
behaviour enough to change the resulting file system in such a way as
to unmask this bug.  The bug is triggered by file system corruption,
so the question is whether this patch series is somehow causing the
file system to be more corrupted than it otherwise would be.  I'm not
sure.

However, the ext4/ext3 hang *is* a real hang in the kernel space, and
generic/475 is not completing because the kernel seems to have ended
up deadlocking somehow.  With just the first patch in this patch
series ("jbd2: recheck chechpointing non-dirty buffer") we're getting
a kernel NULL pointer derefence:

[  310.447568] EXT4-fs error (device dm-7): ext4_check_bdev_write_error:223: comm fsstress: Error while async write back metadata
[  310.458038] EXT4-fs error (device dm-7): __ext4_get_inode_loc_noinmem:4467: inode #99400: block 393286: comm fsstress: unable to read itable block
[  310.458421] JBD2: IO error reading journal superblock
[  310.484755] EXT4-fs warning (device dm-7): ext4_end_bio:343: I/O error 10 writing to inode 36066 starting block 19083)
[  310.490956] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  310.490959] #PF: supervisor write access in kernel mode
[  310.490961] #PF: error_code(0x0002) - not-present page
[  310.490963] PGD 0 P4D 0 
[  310.490966] Oops: 0002 [#1] PREEMPT SMP PTI
[  310.490970] CPU: 1 PID: 15600 Comm: fsstress Not tainted 6.4.0-rc5-xfstests-00055-gd3ab1bca26b4 #190
[  310.490974] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
[  310.490976] RIP: 0010:jbd2_journal_set_features+0x13d/0x430
[  310.490985] Code: 0f 94 c0 44 20 e8 0f 85 e0 00 00 00 be 94 01 00 00 48 c7 c7 a1 33 59 b4 48 89 0c 24 4c 8b 7d 38 e8 a8 dc c5 ff 2e 2e 2e 31 c0 <f0> 49 0f ba 2f 02 48 8b 0c 24 0f 82 24 02 00 00 45 84 ed 8b 41 28
[  310.490988] RSP: 0018:ffffb9b441043b30 EFLAGS: 00010246
[  310.490990] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8edb447b8100
[  310.490993] RDX: 0000000000000000 RSI: 0000000000000194 RDI: ffffffffb45933a1
[  310.490994] RBP: ffff8edb45a62800 R08: ffffffffb460d6c0 R09: 0000000000000000
[  310.490996] R10: 204f49203a324442 R11: 4f49203a3244424a R12: 0000000000000000
[  310.490997] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
[  310.490999] FS:  00007f2940cca740(0000) GS:ffff8edc19500000(0000) knlGS:0000000000000000
[  310.491005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  310.491007] CR2: 0000000000000000 CR3: 000000012543e003 CR4: 00000000003706e0
[  310.491009] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  310.491011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  310.491012] Call Trace:
[  310.491016]  <TASK>
[  310.491019]  ? __die+0x23/0x60
[  310.491025]  ? page_fault_oops+0xa4/0x170
[  310.491029]  ? exc_page_fault+0x67/0x170
[  310.491032]  ? asm_exc_page_fault+0x26/0x30
[  310.491039]  ? jbd2_journal_set_features+0x13d/0x430
[  310.491043]  jbd2_journal_revoke+0x47/0x1e0
[  310.491046]  __ext4_forget+0xc3/0x1b0
[  310.491051]  ext4_free_blocks+0x214/0x2f0
[  310.491056]  ext4_free_branches+0xeb/0x270
[  310.491061]  ext4_ind_truncate+0x2bf/0x320
[  310.491065]  ext4_truncate+0x1e4/0x490
[  310.491069]  ext4_handle_inode_extension+0x1bd/0x2a0
[  310.491073]  ? iomap_dio_complete+0xaf/0x1d0
[  310.511141] ------------[ cut here ]------------
[  310.516121]  ext4_dio_write_iter+0x346/0x3e0
[  310.516132]  ? __handle_mm_fault+0x171/0x200
[  310.516135]  vfs_write+0x21a/0x3e0
[  310.516140]  ksys_write+0x6f/0xf0
[  310.516142]  do_syscall_64+0x3b/0x90
[  310.516147]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  310.516154] RIP: 0033:0x7f2940eb2fb3
[  310.516158] Code: 75 05 48 83 c4 58 c3 e8 cb 41 ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[  310.516161] RSP: 002b:00007ffe9a322cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  310.516165] RAX: ffffffffffffffda RBX: 0000000000003000 RCX: 00007f2940eb2fb3
[  310.516167] RDX: 0000000000003000 RSI: 0000556ba1e31000 RDI: 0000000000000003
[  310.516168] RBP: 0000000000000003 R08: 0000556ba1e31000 R09: 00007f2940e9bbe0
[  310.516170] R10: 0000556b9fedbf59 R11: 0000000000000246 R12: 0000000000000024
[  310.516172] R13: 00000000000cf000 R14: 0000556ba1e31000 R15: 0000000000000000
[  310.516174]  </TASK>
[  310.516178] CR2: 0000000000000000
[  310.516181] ---[ end trace 0000000000000000 ]---

This is then causing fsstress to wedge:

# ps -ax -o pid,user,wchan:20,args --sort pid
    PID USER     WCHAN                COMMAND
	...
  12860 root     do_wait              /bin/bash /root/xfstests/tests/generic/475
  13086 root     rescuer_thread       [kdmflush/253:7]
  15593 root     rescuer_thread       [ext4-rsv-conver]
  15598 root     jbd2_log_wait_commit ./ltp/fsstress -d /xt-vdc -n 999999 -p 4
  15600 root     ext4_release_file    [fsstress]
  15601 root     exit_aio             [fsstress]

So at this point, I'm going to drop this entire patch series from the
dev tree, since this *does* seem to be some kind of regression
triggered by the first patch in the patch series.

Regards,

					- Ted
