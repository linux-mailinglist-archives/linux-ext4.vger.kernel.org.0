Return-Path: <linux-ext4+bounces-186-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6677F99D4
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 07:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8C21C20A83
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Nov 2023 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDBAD27E;
	Mon, 27 Nov 2023 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F63CE;
	Sun, 26 Nov 2023 22:29:22 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sdwdf3Q83zWhsG;
	Mon, 27 Nov 2023 14:28:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 Nov
 2023 14:29:18 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>, <djwong@kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>, <stable@kernel.org>
Subject: [PATCH] ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS
Date: Mon, 27 Nov 2023 14:33:13 +0800
Message-ID: <20231127063313.3734294-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected

For files with logical blocks close to EXT_MAX_BLOCKS, the file size
predicted in ext4_mb_normalize_request() may exceed EXT_MAX_BLOCKS.
This can cause some blocks to be preallocated that will not be used.
And after [Fixes], the following issue may be triggered:

=========================================================
 kernel BUG at fs/ext4/mballoc.c:4653!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 CPU: 1 PID: 2357 Comm: xfs_io 6.7.0-rc2-00195-g0f5cc96c367f
 Hardware name: linux,dummy-virt (DT)
 pc : ext4_mb_use_inode_pa+0x148/0x208
 lr : ext4_mb_use_inode_pa+0x98/0x208
 Call trace:
  ext4_mb_use_inode_pa+0x148/0x208
  ext4_mb_new_inode_pa+0x240/0x4a8
  ext4_mb_use_best_found+0x1d4/0x208
  ext4_mb_try_best_found+0xc8/0x110
  ext4_mb_regular_allocator+0x11c/0xf48
  ext4_mb_new_blocks+0x790/0xaa8
  ext4_ext_map_blocks+0x7cc/0xd20
  ext4_map_blocks+0x170/0x600
  ext4_iomap_begin+0x1c0/0x348
=========================================================

Here is a calculation when adjusting ac_b_ex in ext4_mb_new_inode_pa():

	ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
	if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
		goto adjust_bex;

The problem is that when orig_goal_end is subtracted from ac_b_ex.fe_len
it is still greater than EXT_MAX_BLOCKS, which causes ex.fe_logical to
overflow to a very small value, which ultimately triggers a BUG_ON in
ext4_mb_new_inode_pa() because pa->pa_free < len.

The last logical block of an actual write request does not exceed
EXT_MAX_BLOCKS, so in ext4_mb_normalize_request() also avoids normalizing
the last logical block to exceed EXT_MAX_BLOCKS to avoid the above issue.

The test case in [Link] can reproduce the above issue with 64k block size.

Link: https://patchwork.kernel.org/project/fstests/list/?series=804003
Cc: stable@kernel.org # 6.4
Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 454d5612641e..d72b5e3c92ec 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4478,6 +4478,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
 			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
 
+	/* avoid unnecessary preallocation that may trigger assertions */
+	if (start + size > EXT_MAX_BLOCKS)
+		size = EXT_MAX_BLOCKS - start;
+
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
 		size -= ar->lleft + 1 - start;
-- 
2.31.1


