Return-Path: <linux-ext4+bounces-492-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D521817345
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 15:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E064F2896C4
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3525042390;
	Mon, 18 Dec 2023 14:14:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846213A1A0;
	Mon, 18 Dec 2023 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Sv1yW1C8Zz29g8n;
	Mon, 18 Dec 2023 22:13:39 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 29BC91402D0;
	Mon, 18 Dec 2023 22:14:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Dec
 2023 22:14:50 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<libaokun1@huawei.com>, Wei Chen <harperchen1110@gmail.com>, xingwei lee
	<xrivendell7@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/4] ext4: fix double-free of blocks due to wrong extents moved_len
Date: Mon, 18 Dec 2023 22:18:11 +0800
Message-ID: <20231218141814.1477338-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231218141814.1477338-1-libaokun1@huawei.com>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

In ext4_move_extents(), moved_len is only updated when all moves are
successfully executed, and only discards orig_inode and donor_inode
preallocations when moved_len is not zero. When the loop fails to exit
after successfully moving some extents, moved_len is not updated and
remains at 0, so it does not discard the preallocations.

If the moved extents overlap with the preallocated extents, the
overlapped extents are freed twice in ext4_mb_release_inode_pa() and
ext4_process_freed_data() (as described in commit 94d7c16cbbbd), and
bb_free is incremented twice. Hence when trim is executed, a zero-division
bug is triggered in mb_update_avg_fragment_size() because bb_free is not
zero and bb_fragments is zero.

Therefore, update move_len after each extent move to avoid the issue.

Reported-by: Wei Chen <harperchen1110@gmail.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Closes: https://lore.kernel.org/r/CAO4mrferzqBUnCag8R3m2zf897ts9UEuhjFQGPtODT92rYyR2Q@mail.gmail.com
Fixes: fcf6b1b729bc ("ext4: refactor ext4_move_extents code base")
CC: stable@vger.kernel.org # 3.18
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/move_extent.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 3aa57376d9c2..4b9b503c6346 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -672,7 +672,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		 */
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
 		/* Swap original branches with new branches */
-		move_extent_per_page(o_filp, donor_inode,
+		*moved_len += move_extent_per_page(o_filp, donor_inode,
 				     orig_page_index, donor_page_index,
 				     offset_in_page, cur_len,
 				     unwritten, &ret);
@@ -682,7 +682,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		o_start += cur_len;
 		d_start += cur_len;
 	}
-	*moved_len = o_start - orig_blk;
 	if (*moved_len > len)
 		*moved_len = len;
 
-- 
2.31.1


