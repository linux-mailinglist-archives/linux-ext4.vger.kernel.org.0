Return-Path: <linux-ext4+bounces-8987-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E6B03F9A
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FAE4A0654
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DED25A2DA;
	Mon, 14 Jul 2025 13:18:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193A2571D7;
	Mon, 14 Jul 2025 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499122; cv=none; b=IQND6MEO38PFChAZRgvTgk5jseUKanu7iWlSLUwYjSV1Nxs+5CMtKAA0QuIXZL4oh8YLE0TcGoF8/Dx2s+C3xolnPnWdRTjMNy/VX0ViGmKA6UBFiHOlMPtI9An9NLHY1Ep38L5FKJAgn2NDd38Ip5M2DxudurV7NHNfWijqhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499122; c=relaxed/simple;
	bh=Zyb/YD7Y8CYqsp1QQt7pJhd5nqZD3H4+r0rysYiRtNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVx+fdGafOiYtFNQo115vgPk4KiG987Y0hYSWRs/XyQddP4JUO33YE8v0t5XXCS3EZRQf56BE1N00smGBUKv3VcoDGD9eSE81Ye44s2Mp4YxFB0d06i93PTSwtXLOxbmCqbC9cwf5CQgk+M4Ae7ory1Wtlhpdm/AYwXQIelwVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bgjW50Y3Pz29dns;
	Mon, 14 Jul 2025 21:16:01 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 93C3B140230;
	Mon, 14 Jul 2025 21:18:37 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:18:36 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <ojaswin@linux.ibm.com>,
	<julia.lawall@inria.fr>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<libaokun1@huawei.com>, <libaokun@huaweicloud.com>
Subject: [PATCH v3 09/17] ext4: merge freed extent with existing extents before insertion
Date: Mon, 14 Jul 2025 21:03:19 +0800
Message-ID: <20250714130327.1830534-10-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250714130327.1830534-1-libaokun1@huawei.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Attempt to merge ext4_free_data with already inserted free extents prior
to adding new ones. This strategy drastically cuts down the number of
times locks are held.

For example, if prev, new, and next extents are all mergeable, the existing
code (before this patch) requires acquiring the s_md_lock three times:

  prev merge into new and free prev // hold lock
  next merge into new and free next // hold lock
  insert new // hold lock

After the patch, it only needs to be acquired once:

  new merge into next and free new // no lock
  next merge into prev and free next // hold lock

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

|CPU: Kunpeng 920   |          P80           |            P1           |
|Memory: 512GB      |------------------------|-------------------------|
|960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 20043 | 20097 (+0.2%)  | 314331 | 316141 (+0.5%) |
|mb_optimize_scan=1 | 7290  | 13318 (+87.4%) | 324226 | 325273 (+0.3%) |

|CPU: AMD 9654 * 2  |          P96           |             P1          |
|Memory: 1536GB     |------------------------|-------------------------|
|960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
|-------------------|-------|----------------|--------|----------------|
|mb_optimize_scan=0 | 54999 | 53603 (-2.5%)  | 214380 | 214243 (-0.06%)|
|mb_optimize_scan=1 | 13497 | 20887 (+54.6%) | 216276 | 213632 (-1.2%) |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 113 +++++++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 37 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index ba3cdacbc9f9..6d98f2a5afc4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6307,28 +6307,63 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
  * are contiguous, AND the extents were freed by the same transaction,
  * AND the blocks are associated with the same group.
  */
-static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
-					struct ext4_free_data *entry,
-					struct ext4_free_data *new_entry,
-					struct rb_root *entry_rb_root)
+static inline bool
+ext4_freed_extents_can_be_merged(struct ext4_free_data *entry1,
+				 struct ext4_free_data *entry2)
 {
-	if ((entry->efd_tid != new_entry->efd_tid) ||
-	    (entry->efd_group != new_entry->efd_group))
-		return;
-	if (entry->efd_start_cluster + entry->efd_count ==
-	    new_entry->efd_start_cluster) {
-		new_entry->efd_start_cluster = entry->efd_start_cluster;
-		new_entry->efd_count += entry->efd_count;
-	} else if (new_entry->efd_start_cluster + new_entry->efd_count ==
-		   entry->efd_start_cluster) {
-		new_entry->efd_count += entry->efd_count;
-	} else
-		return;
+	if (entry1->efd_tid != entry2->efd_tid)
+		return false;
+	if (entry1->efd_start_cluster + entry1->efd_count !=
+	    entry2->efd_start_cluster)
+		return false;
+	if (WARN_ON_ONCE(entry1->efd_group != entry2->efd_group))
+		return false;
+	return true;
+}
+
+static inline void
+ext4_merge_freed_extents(struct ext4_sb_info *sbi, struct rb_root *root,
+			 struct ext4_free_data *entry1,
+			 struct ext4_free_data *entry2)
+{
+	entry1->efd_count += entry2->efd_count;
 	spin_lock(&sbi->s_md_lock);
-	list_del(&entry->efd_list);
+	list_del(&entry2->efd_list);
 	spin_unlock(&sbi->s_md_lock);
-	rb_erase(&entry->efd_node, entry_rb_root);
-	kmem_cache_free(ext4_free_data_cachep, entry);
+	rb_erase(&entry2->efd_node, root);
+	kmem_cache_free(ext4_free_data_cachep, entry2);
+}
+
+static inline void
+ext4_try_merge_freed_extent_prev(struct ext4_sb_info *sbi, struct rb_root *root,
+				 struct ext4_free_data *entry)
+{
+	struct ext4_free_data *prev;
+	struct rb_node *node;
+
+	node = rb_prev(&entry->efd_node);
+	if (!node)
+		return;
+
+	prev = rb_entry(node, struct ext4_free_data, efd_node);
+	if (ext4_freed_extents_can_be_merged(prev, entry))
+		ext4_merge_freed_extents(sbi, root, prev, entry);
+}
+
+static inline void
+ext4_try_merge_freed_extent_next(struct ext4_sb_info *sbi, struct rb_root *root,
+				 struct ext4_free_data *entry)
+{
+	struct ext4_free_data *next;
+	struct rb_node *node;
+
+	node = rb_next(&entry->efd_node);
+	if (!node)
+		return;
+
+	next = rb_entry(node, struct ext4_free_data, efd_node);
+	if (ext4_freed_extents_can_be_merged(entry, next))
+		ext4_merge_freed_extents(sbi, root, entry, next);
 }
 
 static noinline_for_stack void
@@ -6338,11 +6373,12 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	ext4_group_t group = e4b->bd_group;
 	ext4_grpblk_t cluster;
 	ext4_grpblk_t clusters = new_entry->efd_count;
-	struct ext4_free_data *entry;
+	struct ext4_free_data *entry = NULL;
 	struct ext4_group_info *db = e4b->bd_info;
 	struct super_block *sb = e4b->bd_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct rb_node **n = &db->bb_free_root.rb_node, *node;
+	struct rb_root *root = &db->bb_free_root;
+	struct rb_node **n = &root->rb_node;
 	struct rb_node *parent = NULL, *new_node;
 
 	BUG_ON(!ext4_handle_valid(handle));
@@ -6378,27 +6414,30 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		}
 	}
 
-	rb_link_node(new_node, parent, n);
-	rb_insert_color(new_node, &db->bb_free_root);
-
-	/* Now try to see the extent can be merged to left and right */
-	node = rb_prev(new_node);
-	if (node) {
-		entry = rb_entry(node, struct ext4_free_data, efd_node);
-		ext4_try_merge_freed_extent(sbi, entry, new_entry,
-					    &(db->bb_free_root));
+	atomic_add(clusters, &sbi->s_mb_free_pending);
+	if (!entry)
+		goto insert;
+
+	/* Now try to see the extent can be merged to prev and next */
+	if (ext4_freed_extents_can_be_merged(new_entry, entry)) {
+		entry->efd_start_cluster = cluster;
+		entry->efd_count += new_entry->efd_count;
+		kmem_cache_free(ext4_free_data_cachep, new_entry);
+		ext4_try_merge_freed_extent_prev(sbi, root, entry);
+		return;
 	}
-
-	node = rb_next(new_node);
-	if (node) {
-		entry = rb_entry(node, struct ext4_free_data, efd_node);
-		ext4_try_merge_freed_extent(sbi, entry, new_entry,
-					    &(db->bb_free_root));
+	if (ext4_freed_extents_can_be_merged(entry, new_entry)) {
+		entry->efd_count += new_entry->efd_count;
+		kmem_cache_free(ext4_free_data_cachep, new_entry);
+		ext4_try_merge_freed_extent_next(sbi, root, entry);
+		return;
 	}
+insert:
+	rb_link_node(new_node, parent, n);
+	rb_insert_color(new_node, root);
 
 	spin_lock(&sbi->s_md_lock);
 	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
-	atomic_add(clusters, &sbi->s_mb_free_pending);
 	spin_unlock(&sbi->s_md_lock);
 }
 
-- 
2.46.1


