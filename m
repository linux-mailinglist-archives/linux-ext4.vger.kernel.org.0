Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69336349B
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Apr 2021 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhDRK3T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 18 Apr 2021 06:29:19 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:37109 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhDRK3S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 18 Apr 2021 06:29:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVv.WOJ_1618741722;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UVv.WOJ_1618741722)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Apr 2021 18:28:47 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ext4: prevent the CPU from being 100% occupied in ext4_mb_discard_group_preallocations
Date:   Sun, 18 Apr 2021 18:28:34 +0800
Message-Id: <20210418102834.29589-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The kworker has occupied 100% of the CPU for several days:
PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11

And the stack obtained through sysrq is as follows:
[20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
[20613144.850427] RIP: 0010:[<ffffffffa0240743>] ^Ac
[<ffffffffa0240743>] ext4_mb_discard_group_preallocations+0x1b3/0x480 [ext4]
...
[20613144.850435] Stack:
[20613144.850435]  ffff881942d6a6e8^Ac ffff8813bb5f72d0^Ac 00000001a02427cf^Ac 0000000000000140^Ac
[20613144.850436]  ffff880f80618000^Ac 0000000000000000^Ac ffffc9001342f770^Ac ffffc9001342f770^Ac
[20613144.850437]  ffffea0056360dc0^Ac ffff88158d837000^Ac ffffea0045155f80^Ac ffff88114557e000^Ac
[20613144.850438] Call Trace:
[20613144.850439]  [<ffffffffa0244209>] ext4_mb_new_blocks+0x429/0x550 [ext4]
[20613144.850439]  [<ffffffffa02389ae>] ext4_ext_map_blocks+0xb5e/0xf30 [ext4]
[20613144.850440]  [<ffffffff811c0001>] ? numa_zonelist_order_handler+0xa1/0x1c0
[20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620 [ext4]
[20613144.850441]  [<ffffffffa020835d>] ? ext4_writepages+0x4cd/0xf00 [ext4]
[20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00 [ext4]
[20613144.850442]  [<ffffffff811c1410>] ? wb_position_ratio+0x1f0/0x1f0
[20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
[20613144.850444]  [<ffffffff81280265>] __writeback_single_inode+0x45/0x320
[20613144.850444]  [<ffffffff81280ab2>] writeback_sb_inodes+0x272/0x600
[20613144.850445]  [<ffffffff81280ed2>] __writeback_inodes_wb+0x92/0xc0
[20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
[20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
[20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
[20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
[20613144.850448]  [<ffffffff810a6060>] ? process_one_work+0x420/0x420
[20613144.850448]  [<ffffffff810ac696>] kthread+0xe6/0x100
[20613144.850449]  [<ffffffff810ac5b0>] ? kthread_park+0x60/0x60
[20613144.850450]  [<ffffffff81741dd9>] ret_from_fork+0x39/0x50

The thread that references this pa has been waiting for IO to return:
PID: 15140  TASK: ffff88004d6dc300  CPU: 16  COMMAND: "kworker/u64:1"
[ffffc900273e7518] __schedule at ffffffff8173ca3b
[ffffc900273e75a0] schedule at ffffffff8173cfb6
[ffffc900273e75b8] io_schedule at ffffffff810bb75a
[ffffc900273e75e0] bit_wait_io at ffffffff8173d8d1
[ffffc900273e75f8] __wait_on_bit_lock at ffffffff8173d4e9
[ffffc900273e7638] out_of_line_wait_on_bit_lock at ffffffff8173d742
[ffffc900273e76b0] __lock_buffer at ffffffff81288c32
[ffffc900273e76c8] do_get_write_access at ffffffffa00dd177 [jbd2]
[ffffc900273e7728] jbd2_journal_get_write_access at ffffffffa00dd3a3 [jbd2]
[ffffc900273e7750] __ext4_journal_get_write_access at ffffffffa023b37b [ext4]
[ffffc900273e7788] ext4_mb_mark_diskspace_used at ffffffffa0242a0b [ext4]
[ffffc900273e77f0] ext4_mb_new_blocks at ffffffffa0244100 [ext4]
[ffffc900273e7860] ext4_ext_map_blocks at ffffffffa02389ae [ext4]
[ffffc900273e7950] ext4_map_blocks at ffffffffa0204b52 [ext4]
[ffffc900273e79d0] ext4_writepages at ffffffffa0208675 [ext4]
[ffffc900273e7b30] do_writepages at ffffffff811c487e
[ffffc900273e7b40] __writeback_single_inode at ffffffff81280265
[ffffc900273e7b90] writeback_sb_inodes at ffffffff81280ab2
[ffffc900273e7c90] __writeback_inodes_wb at ffffffff81280ed2
[ffffc900273e7cd8] wb_writeback at ffffffff81281238
[ffffc900273e7d80] wb_workfn at ffffffff812819f4
[ffffc900273e7e18] process_one_work at ffffffff810a5dc9
[ffffc900273e7e60] worker_thread at ffffffff810a60ae
[ffffc900273e7ec0] kthread at ffffffff810ac696
[ffffc900273e7f50] ret_from_fork at ffffffff81741dd9

On the bare metal server, we will use multiple hard disks, the Linux
kernel will run on the system disk, and business programs will run on
several hard disks virtualized by the BM hypervisor. The reason why IO
has not returned here is that the process handling IO in the BM hypervisor
has failed.

The cpu resources of the cloud server are precious, and the server
cannot be restarted after running for a long time. So it's slightly
optimized here to prevent the CPU from being 100% occupied.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Baoyou Xie <baoyou.xie@alibaba-inc.com>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/ext4/mballoc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a02fadf..c73f212 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -351,6 +351,8 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
+static inline void ext4_mb_show_pa(struct super_block *sb);
+
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -4217,9 +4219,9 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 	struct ext4_prealloc_space *pa, *tmp;
 	struct list_head list;
 	struct ext4_buddy e4b;
+	int free_total = 0;
+	int busy, free;
 	int err;
-	int busy = 0;
-	int free, free_total = 0;
 
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
@@ -4247,6 +4249,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 
 	INIT_LIST_HEAD(&list);
 repeat:
+	busy = 0;
 	free = 0;
 	ext4_lock_group(sb, group);
 	list_for_each_entry_safe(pa, tmp,
@@ -4255,6 +4258,8 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 		if (atomic_read(&pa->pa_count)) {
 			spin_unlock(&pa->pa_lock);
 			busy = 1;
+			mb_debug(sb, "used pa while discarding for group %u\n", group);
+			ext4_mb_show_pa(sb);
 			continue;
 		}
 		if (pa->pa_deleted) {
@@ -4299,8 +4304,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 	/* if we still need more blocks and some PAs were used, try again */
 	if (free_total < needed && busy) {
 		ext4_unlock_group(sb, group);
-		cond_resched();
-		busy = 0;
+		schedule_timeout_uninterruptible(HZ/100);
 		goto repeat;
 	}
 	ext4_unlock_group(sb, group);
-- 
1.8.3.1

