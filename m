Return-Path: <linux-ext4+bounces-8593-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3856AE3750
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 09:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4641894202
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9721E221299;
	Mon, 23 Jun 2025 07:47:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDBD21ADC5;
	Mon, 23 Jun 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664826; cv=none; b=qk9YdaK2Kz8+RGcBskHht/QqcXTEMpokNqh5k02OH0mSoi5Njo1ySd+b6Im5NhrcfNN/t2Q6PC4CnXtI7rjlh/3LcG9SRXMKZkFdKAH+wsvUyER1ZH7Xsn2ylxWFR8WC4YBP3kGuZ/EFPVd3U8twPA69DR2YcnFIrsl5S98sewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664826; c=relaxed/simple;
	bh=rKiQucLOQupOFyRbv7D8fr/aZluRofSEBdGCBVJ84Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJBmDZOOO6U8cEY4c7vq2bxM3YyFZIs97vNWarMoMPg/4gMSilfgnFIqcVHafdEfOktH5iBQGajiY4shbL9GbxNky3gFdmm9/k0GyikjtC43AT/eyq+ckfvMnc6x+mkb8SereHFMIp9qEKH3ij83Tq4cH8774eqz0VqP6cj/PKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bQg8L3Nb3z28fRg;
	Mon, 23 Jun 2025 15:44:34 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EA941401F2;
	Mon, 23 Jun 2025 15:47:01 +0800 (CST)
Received: from huawei.com (10.175.112.188) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Jun
 2025 15:47:00 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 08/16] ext4: merge freed extent with existing extents before insertion
Date: Mon, 23 Jun 2025 15:32:56 +0800
Message-ID: <20250623073304.3275702-9-libaokun1@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250623073304.3275702-1-libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

  new merge next and free new // no lock
  next merge into prev and free prev // hold lock

Performance test data follows:

Test: Running will-it-scale/fallocate2 on CPU-bound containers.
Observation: Average fallocate operations per container per second.

                   | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
 Disk: 960GB SSD   |-------------------------|-------------------------|
                   | base  |    patched      | base  |    patched      |
-------------------|-------|-----------------|-------|-----------------|
mb_optimize_scan=0 | 20982 | 21157 (+0.8%)   | 50629 | 50420 (-0.4%)   |
mb_optimize_scan=1 | 10703 | 12896 (+20.4%)  | 14856 | 17273 (+16.2%)  |

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 113 +++++++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 37 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5410fb3688ee..94950b07a577 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6298,28 +6298,63 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
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
@@ -6329,11 +6364,12 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
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
@@ -6369,27 +6405,30 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
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


