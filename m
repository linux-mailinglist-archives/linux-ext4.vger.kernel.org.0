Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8155715FD6F
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Feb 2020 09:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgBOID5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 15 Feb 2020 03:03:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbgBOID5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 15 Feb 2020 03:03:57 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6A6FDF89487824C1C245;
        Sat, 15 Feb 2020 16:03:51 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Feb 2020
 16:03:44 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <luoshijie1@huawei.com>,
        <lutianxiong@huawei.com>
Subject: [PATCH] ext4: add cond_resched() to __ext4_find_entry()
Date:   Sat, 15 Feb 2020 03:02:06 -0500
Message-ID: <20200215080206.13293-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We tested a soft lockup problem in linux 4.19 which could also
be found in linux 5.x.

When dir inode takes up a large number of blocks, and if the
directory is growing when we are searching, it's possible the
restart branch could be called many times, and the do while loop
could hold cpu a long time.

Here is the call trace in linux 4.19.

[  473.756186] Call trace:
[  473.756196]  dump_backtrace+0x0/0x198
[  473.756199]  show_stack+0x24/0x30
[  473.756205]  dump_stack+0xa4/0xcc
[  473.756210]  watchdog_timer_fn+0x300/0x3e8
[  473.756215]  __hrtimer_run_queues+0x114/0x358
[  473.756217]  hrtimer_interrupt+0x104/0x2d8
[  473.756222]  arch_timer_handler_virt+0x38/0x58
[  473.756226]  handle_percpu_devid_irq+0x90/0x248
[  473.756231]  generic_handle_irq+0x34/0x50
[  473.756234]  __handle_domain_irq+0x68/0xc0
[  473.756236]  gic_handle_irq+0x6c/0x150
[  473.756238]  el1_irq+0xb8/0x140
[  473.756286]  ext4_es_lookup_extent+0xdc/0x258 [ext4]
[  473.756310]  ext4_map_blocks+0x64/0x5c0 [ext4]
[  473.756333]  ext4_getblk+0x6c/0x1d0 [ext4]
[  473.756356]  ext4_bread_batch+0x7c/0x1f8 [ext4]
[  473.756379]  ext4_find_entry+0x124/0x3f8 [ext4]
[  473.756402]  ext4_lookup+0x8c/0x258 [ext4]
[  473.756407]  __lookup_hash+0x8c/0xe8
[  473.756411]  filename_create+0xa0/0x170
[  473.756413]  do_mkdirat+0x6c/0x140
[  473.756415]  __arm64_sys_mkdirat+0x28/0x38
[  473.756419]  el0_svc_common+0x78/0x130
[  473.756421]  el0_svc_handler+0x38/0x78
[  473.756423]  el0_svc+0x8/0xc
[  485.755156] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [tmp:5149]

Add cond_resched() to avoid soft lockup and to provide a better
system responding.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
---
 fs/ext4/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 129d2ebae00d..9a1836632f51 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1511,6 +1511,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		/*
 		 * We deal with the read-ahead logic here.
 		 */
+		cond_resched();
 		if (ra_ptr >= ra_max) {
 			/* Refill the readahead buffer */
 			ra_ptr = 0;
-- 
2.19.1

