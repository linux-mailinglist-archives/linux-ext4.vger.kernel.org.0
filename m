Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB82A1F562A
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jun 2020 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgFJNvj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 09:51:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5874 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbgFJNvi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Jun 2020 09:51:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4109B1ADA8F5DCDEDAA9;
        Wed, 10 Jun 2020 21:51:35 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 10 Jun 2020
 21:51:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <riteshh@linux.ibm.com>
CC:     YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ext4: mballoc: Disable preemption before getting per-CPU pointer
Date:   Wed, 10 Jun 2020 21:49:19 +0800
Message-ID: <20200610134919.73688-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u16:3/2181
caller is ext4_mb_new_blocks+0x388/0xed0
CPU: 2 PID: 2181 Comm: kworker/u16:3 Not tainted 5.7.0+ #182
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 dump_stack+0xb9/0xfc
 debug_smp_processor_id+0xc8/0xd0
 ext4_mb_new_blocks+0x388/0xed0
 ext4_ext_map_blocks+0xa92/0xff0
 ext4_map_blocks+0x34e/0x580
 ext4_writepages+0xa28/0x11b0
 do_writepages+0x46/0xe0
 __writeback_single_inode+0x5f/0x6b0
 writeback_sb_inodes+0x290/0x620
 __writeback_inodes_wb+0x62/0xb0
 wb_writeback+0x36c/0x520
 wb_workfn+0x319/0x680
 process_one_work+0x271/0x640
 worker_thread+0x3a/0x3a0
 kthread+0x14e/0x170
 ret_from_fork+0x27/0x40

Disable preemption before accessing discard_pa_seq.

Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ext4/mballoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a9083113a8c0..30b3bfb1e06a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4708,7 +4708,8 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	}
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
-	seq = *this_cpu_ptr(&discard_pa_seq);
+	seq = *get_cpu_ptr(&discard_pa_seq);
+	put_cpu_ptr(&discard_pa_seq);
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
-- 
2.20.1


