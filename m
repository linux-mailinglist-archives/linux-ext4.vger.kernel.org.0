Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5997E3564B2
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Apr 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbhDGHCA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Apr 2021 03:02:00 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:38742 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243825AbhDGHB7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Apr 2021 03:01:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UUmC.cX_1617778902;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UUmC.cX_1617778902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 07 Apr 2021 15:01:48 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Wen Yang <simon.wy@alibaba-inc.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: add a configurable parameter to prevent endless loop in ext4_mb_discard_group_preallocations
Date:   Wed,  7 Apr 2021 15:01:41 +0800
Message-Id: <20210407070141.49253-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wen Yang <simon.wy@alibaba-inc.com>

The kworker has occupied 100% of the CPU for several days:
PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11

And the stack obtained through sysrq is as follows:
[20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
[20613144.850427] RIP: 0010:[<ffffffffa0240743>] ^Ac
[<ffffffffa0240743>] ext4_mb_discard_group_preallocations+0x1b3/0x480
[ext4]
[20613144.850428] RSP: 0018:ffffc9001342f740  EFLAGS: 00000246
[20613144.850428] RAX: 0000000000000000 RBX: ffff8813bb5f72f0 RCX:
0000000000000000
[20613144.850429] RDX: 0000000000000001 RSI: ffff880268291d78 RDI:
ffff880268291d98
[20613144.850430] RBP: ffffc9001342f7e8 R08: 00493b8bc070da84 R09:
0000000000000000
[20613144.850430] R10: 0000000000001800 R11: ffff880155e7c380 R12:
ffff880268291d98
[20613144.850431] R13: ffff8813bb5f72e0 R14: ffff880268291d78 R15:
ffff880268291d68
[20613144.850432] FS:  0000000000000000(0000) GS:ffff881fbf080000(0000)
knlGS:0000000000000000
[20613144.850432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[20613144.850433] CR2: 000000c000823010 CR3: 0000000001c08000 CR4:
00000000003606f0
[20613144.850434] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[20613144.850434] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
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

The cpu resources of the cloud server are precious, and the server
cannot be restarted after running for a long time, so a configuration
parameter is added to prevent this endless loop.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Baoyou Xie <baoyou.xie@alibaba-inc.com>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/mballoc.c | 19 +++++++++++++++----
 fs/ext4/mballoc.h |  2 ++
 fs/ext4/sysfs.c   |  2 ++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2866d24..c238fec 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1543,6 +1543,7 @@ struct ext4_sb_info {
 	unsigned long s_mb_last_start;
 	unsigned int s_mb_prefetch;
 	unsigned int s_mb_prefetch_limit;
+	unsigned long s_mb_max_retries_per_group;
 
 	/* stats for buddy allocator */
 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99bf091..c126b15 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2853,6 +2853,8 @@ int ext4_mb_init(struct super_block *sb)
 	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
 	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
 	sbi->s_mb_max_inode_prealloc = MB_DEFAULT_MAX_INODE_PREALLOC;
+	sbi->s_mb_max_retries_per_group = MB_DISCARD_RETRIES_FOREVER; 
+
 	/*
 	 * The default group preallocation is 512, which for 4k block
 	 * sizes translates to 2 megabytes.  However for bigalloc file
@@ -4206,6 +4208,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 					ext4_group_t group, int needed)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_prealloc_space *pa, *tmp;
 	struct list_head list;
@@ -4213,6 +4216,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 	int err;
 	int busy = 0;
 	int free, free_total = 0;
+	int discard_retries = 0;
 
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
@@ -4291,11 +4295,18 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 
 	/* if we still need more blocks and some PAs were used, try again */
 	if (free_total < needed && busy) {
-		ext4_unlock_group(sb, group);
-		cond_resched();
-		busy = 0;
-		goto repeat;
+		++discard_retries;
+		if (sbi && sbi->s_mb_max_retries_per_group < discard_retries) {
+			ext4_warning(sb, "The retry count has exceeded the limit: %lu",
+					sbi->s_mb_max_retries_per_group);
+		} else  {
+			ext4_unlock_group(sb, group);
+			cond_resched();
+			busy = 0;
+			goto repeat;
+		}
 	}
+
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 	put_bh(bitmap_bh);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index e75b474..fa5b5a3 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -78,6 +78,8 @@
  */
 #define MB_DEFAULT_MAX_INODE_PREALLOC	512
 
+#define MB_DISCARD_RETRIES_FOREVER	(-1UL)
+
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
 	struct list_head		efd_list;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 075aa3a..3549520 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -213,6 +213,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
+EXT4_RW_ATTR_SBI_UL(mb_max_retries_per_group, s_mb_max_retries_per_group);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
 EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
@@ -260,6 +261,7 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 	ATTR_LIST(mb_stream_req),
 	ATTR_LIST(mb_group_prealloc),
 	ATTR_LIST(mb_max_inode_prealloc),
+	ATTR_LIST(mb_max_retries_per_group),
 	ATTR_LIST(max_writeback_mb_bump),
 	ATTR_LIST(extent_max_zeroout_kb),
 	ATTR_LIST(trigger_fs_error),
-- 
1.8.3.1

