Return-Path: <linux-ext4+bounces-1584-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F0877B06
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 07:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157D71C20F6C
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F8EF9E8;
	Mon, 11 Mar 2024 06:45:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0B847B;
	Mon, 11 Mar 2024 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139553; cv=none; b=uR3aCPTDu9HrqDDMZr5Asa5rbx/52yMMrBC3YkCjrgAWWUqOHmvBXcR6vzjdeCxgXAc9HqdLV6IVN2eghXI4M0igC6h8Nidj+j/zopm5bf1mZjoNTuiymOTM1BBvHNxpW7Q/Pq2hCD3Eg2UfsPQ0vQLKBGD+By/wLbxN+C8Eiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139553; c=relaxed/simple;
	bh=qwUigW6kMoBBuAgnR9zbfhElpFowdlZsrFb+xFIqyEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N7GiOaW8q7i86OTlk1XUVDcuDVq7SPINqwxArtmrOsoJa5vF0QGaISqB7EVaHNI6iG2HDGapayRYbFfv/pQ2oaQ0n0SRJRbNe1lkTKWZvWltFhEoWYEblFZ+GHs5CdWb3bQW+/PV3lg6/KB7icS1Xe4mhoaSXoLWp0kNyxv+2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TtS0706VZzwPPW;
	Mon, 11 Mar 2024 14:43:19 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BA421141376;
	Mon, 11 Mar 2024 14:45:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Mar
 2024 14:45:41 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH RFC] ext4: Validate inode pa before using preallocation blocks
Date: Mon, 11 Mar 2024 14:38:43 +0800
Message-ID: <20240311063843.2431708-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

In ext4 continue & no-journal mode, physical blocks could be allocated
more than once (caused by writing extent entries failed & reclaiming
extent cache) in preallocation process, which could trigger a BUG_ON
(pa->pa_free < len) in ext4_mb_use_inode_pa().

 kernel BUG at fs/ext4/mballoc.c:4681!
 invalid opcode: 0000 [#1] PREEMPT SMP
 CPU: 3 PID: 97 Comm: kworker/u8:3 Not tainted 6.8.0-rc7
 RIP: 0010:ext4_mb_use_inode_pa+0x1b6/0x1e0
 Call Trace:
  ext4_mb_use_preallocated.constprop.0+0x19e/0x540
  ext4_mb_new_blocks+0x220/0x1f30
  ext4_ext_map_blocks+0xf3c/0x2900
  ext4_map_blocks+0x264/0xa40
  ext4_do_writepages+0xb15/0x1400
  do_writepages+0x8c/0x260
  writeback_sb_inodes+0x224/0x720
  wb_writeback+0xd8/0x580
  wb_workfn+0x148/0x820

Details are shown as following:

0. Given a file with i_size=4096 with one mapped block
1. Write block no 1, blocks 1~3 are preallocated.
   ext4_ext_map_blocks
    ext4_mb_normalize_request
     size = 16 * 1024
     size = end - start // Allocate 3 blocks (bs = 4096)
    ext4_mb_regular_allocator
     ext4_mb_regular_allocator
     ext4_mb_regular_allocator
     ext4_mb_use_inode_pa
      pa->pa_free -= len // 3 - 1 = 2
2. Extent buffer head is written failed, es cache and buffer head are
   reclaimed.
3. Write blocks 1~3
   ext4_ext_map_blocks
    newex.ee_len = 3
    ext4_ext_check_overlap // Find nothing, there should have been block 1
    allocated = map->m_len  // 3
    ext4_mb_new_blocks
     ext4_mb_use_preallocated
      ext4_mb_use_inode_pa
       BUG_ON(pa->pa_free < len) // 2 < 3!

Fix it by adding validation checking for inode pa. If invalid pa is
detected, stop using inode preallocation, drop invalid pa to avoid it
being used again, mark group block bitmap as corrupted to avoid allocating
from the erroneous group.

Fetch a reproducer in Link.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218576
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/mballoc.c | 128 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e4f7cf9d89c4..baedbc604b89 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -423,6 +423,9 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 			       ext4_group_t group, enum criteria cr);
 
+static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
+			struct super_block *sb, struct ext4_prealloc_space *pa);
+
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks);
@@ -4768,6 +4771,79 @@ ext4_mb_pa_goal_check(struct ext4_allocation_context *ac,
 	return true;
 }
 
+/*
+ * check if found pa is valid
+ */
+static bool ext4_mb_pa_is_valid(struct ext4_allocation_context *ac,
+				struct ext4_prealloc_space *pa)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	ext4_fsblk_t start;
+	ext4_fsblk_t end;
+	int len;
+
+	if (unlikely(pa->pa_free == 0)) {
+		/*
+		 * We found a valid overlapping pa but couldn't use it because
+		 * it had no free blocks. This should ideally never happen
+		 * because:
+		 *
+		 * 1. When a new inode pa is added to rbtree it must have
+		 *    pa_free > 0 since otherwise we won't actually need
+		 *    preallocation.
+		 *
+		 * 2. An inode pa that is in the rbtree can only have it's
+		 *    pa_free become zero when another thread calls:
+		 *      ext4_mb_new_blocks
+		 *       ext4_mb_use_preallocated
+		 *        ext4_mb_use_inode_pa
+		 *
+		 * 3. Further, after the above calls make pa_free == 0, we will
+		 *    immediately remove it from the rbtree in:
+		 *      ext4_mb_new_blocks
+		 *       ext4_mb_release_context
+		 *        ext4_mb_put_pa
+		 *
+		 * 4. Since the pa_free becoming 0 and pa_free getting removed
+		 * from tree both happen in ext4_mb_new_blocks, which is always
+		 * called with i_data_sem held for data allocations, we can be
+		 * sure that another process will never see a pa in rbtree with
+		 * pa_free == 0.
+		 */
+		ext4_msg(ac->ac_sb, KERN_ERR, "invalid pa, free is 0");
+		return false;
+	}
+
+	start = pa->pa_pstart + (ac->ac_o_ex.fe_logical - pa->pa_lstart);
+	end = min(pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len),
+		  start + EXT4_C2B(sbi, ac->ac_o_ex.fe_len));
+	len = EXT4_NUM_B2C(sbi, end - start);
+
+	if (unlikely(start < pa->pa_pstart)) {
+		ext4_msg(ac->ac_sb, KERN_ERR,
+			 "invalid pa, start(%llu) < pa_pstart(%llu)",
+			 start, pa->pa_pstart);
+		return false;
+	}
+	if (unlikely(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len))) {
+		ext4_msg(ac->ac_sb, KERN_ERR,
+			 "invalid pa, end(%llu) > pa_pstart(%llu) + pa_len(%d)",
+			 end, pa->pa_pstart, EXT4_C2B(sbi, pa->pa_len));
+		return false;
+	}
+	if (unlikely(pa->pa_free < len)) {
+		ext4_msg(ac->ac_sb, KERN_ERR,
+			 "invalid pa, pa_free(%d) < len(%d)", pa->pa_free, len);
+		return false;
+	}
+	if (unlikely(len <= 0)) {
+		ext4_msg(ac->ac_sb, KERN_ERR, "invalid pa, len(%d) <= 0", len);
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * search goal blocks in preallocated space
  */
@@ -4891,45 +4967,37 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 		goto try_group_pa;
 	}
 
-	if (tmp_pa->pa_free && likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
+	if (unlikely(!ext4_mb_pa_is_valid(ac, tmp_pa))) {
+		ext4_group_t group;
+
+		tmp_pa->pa_free = 0;
+		atomic_inc(&tmp_pa->pa_count);
+		spin_unlock(&tmp_pa->pa_lock);
+		read_unlock(&ei->i_prealloc_lock);
+
+		ext4_mb_put_pa(ac, ac->ac_sb, tmp_pa);
+		group = ext4_get_group_number(ac->ac_sb, tmp_pa->pa_pstart);
+		ext4_lock_group(ac->ac_sb, group);
+		ext4_mark_group_bitmap_corrupted(ac->ac_sb, group,
+						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		ext4_unlock_group(ac->ac_sb, group);
+		ext4_error(ac->ac_sb, "drop pa and mark group %u block bitmap corrupted",
+			   group);
+		WARN_ON_ONCE(1);
+		goto try_group_pa_unlocked;
+	}
+
+	if (likely(ext4_mb_pa_goal_check(ac, tmp_pa))) {
 		atomic_inc(&tmp_pa->pa_count);
 		ext4_mb_use_inode_pa(ac, tmp_pa);
 		spin_unlock(&tmp_pa->pa_lock);
 		read_unlock(&ei->i_prealloc_lock);
 		return true;
-	} else {
-		/*
-		 * We found a valid overlapping pa but couldn't use it because
-		 * it had no free blocks. This should ideally never happen
-		 * because:
-		 *
-		 * 1. When a new inode pa is added to rbtree it must have
-		 *    pa_free > 0 since otherwise we won't actually need
-		 *    preallocation.
-		 *
-		 * 2. An inode pa that is in the rbtree can only have it's
-		 *    pa_free become zero when another thread calls:
-		 *      ext4_mb_new_blocks
-		 *       ext4_mb_use_preallocated
-		 *        ext4_mb_use_inode_pa
-		 *
-		 * 3. Further, after the above calls make pa_free == 0, we will
-		 *    immediately remove it from the rbtree in:
-		 *      ext4_mb_new_blocks
-		 *       ext4_mb_release_context
-		 *        ext4_mb_put_pa
-		 *
-		 * 4. Since the pa_free becoming 0 and pa_free getting removed
-		 * from tree both happen in ext4_mb_new_blocks, which is always
-		 * called with i_data_sem held for data allocations, we can be
-		 * sure that another process will never see a pa in rbtree with
-		 * pa_free == 0.
-		 */
-		WARN_ON_ONCE(tmp_pa->pa_free == 0);
 	}
 	spin_unlock(&tmp_pa->pa_lock);
 try_group_pa:
 	read_unlock(&ei->i_prealloc_lock);
+try_group_pa_unlocked:
 
 	/* can we use group allocation? */
 	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
-- 
2.39.2


