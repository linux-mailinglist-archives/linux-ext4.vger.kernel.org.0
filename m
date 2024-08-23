Return-Path: <linux-ext4+bounces-3878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA1195C52C
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 08:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985FA28450D
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F9B74BE1;
	Fri, 23 Aug 2024 06:10:50 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5455C3E
	for <linux-ext4@vger.kernel.org>; Fri, 23 Aug 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393450; cv=none; b=mG7z5bC0/DAw9YF/+Cgx0wVIJks4zSQfjmdnu4wF+D2bG4kd7n2Loyb+dfrP0FqPpB6UK5PbG5A+9TZ1XfqM3vPrniz+2HL/6Vr/wZBzKpcMwUGU5i523DHnVVvRhecFYfAAYmwvamciXmmQyXdZvHaYKrIXydpcIqbe5+6veQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393450; c=relaxed/simple;
	bh=HOiIdmRqZFdIGoEQzUwzkBWHDK3JftdJ7Od/rvbuIPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTAiwflnUAKzhaRjAiy7QO9pDsfDoS5OJFqwCWcWct9xpGIdg2VqD5zdzi0j9KimesWWjWWyZrk9H7BhsbKWVw2nWlgUyNoo/aJuFozEt/d6Jjx0nAx4wVkrUE70Z7lta4uiOhdwAxQo3J08jE7ovhnOY6lsMHF6FWnnfwKrxAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqqNd1z2cz1HGyR;
	Fri, 23 Aug 2024 14:07:29 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 507071A0188;
	Fri, 23 Aug 2024 14:10:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 14:10:42 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lizetao1@huawei.com>, <linux-ext4@vger.kernel.org>
Subject: [PATCH -next 2/3] ext4: Use scoped()/scoped_guard() to drop write_lock()/unlock pair
Date: Fri, 23 Aug 2024 14:18:23 +0800
Message-ID: <20240823061824.3323522-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823061824.3323522-1-lizetao1@huawei.com>
References: <20240823061824.3323522-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

A write_lock() and write_unlock() pair can be replaced by a
scope-based resource management function scoped() or scoped_guard()
which can make the code more readable and safer.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ext4/extents_status.c |  26 +++++----
 fs/ext4/mballoc.c        | 113 ++++++++++++++++++---------------------
 fs/ext4/super.c          |   3 +-
 3 files changed, 64 insertions(+), 78 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 407447819864..b65e857bc686 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -953,12 +953,11 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	BUG_ON(end < lblk);
 
-	write_lock(&EXT4_I(inode)->i_es_lock);
+	guard(write_lock)(&EXT4_I(inode)->i_es_lock);
 
 	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
 	if (!es || es->es_lblk > end)
 		__es_insert_extent(inode, &newes, NULL);
-	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
 /*
@@ -1512,15 +1511,16 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * so that we are sure __es_shrink() is done with the inode before it
 	 * is reclaimed.
 	 */
-	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved, es);
-	/* Free preallocated extent if it didn't get used. */
-	if (es) {
-		if (!es->es_len)
-			__es_free_extent(es);
-		es = NULL;
+	scoped_guard(write_lock, &EXT4_I(inode)->i_es_lock) {
+		err = __es_remove_extent(inode, lblk, end, &reserved, es);
+		/* Free preallocated extent if it didn't get used. */
+		if (es) {
+			if (!es->es_len)
+				__es_free_extent(es);
+			es = NULL;
+		}
 	}
-	write_unlock(&EXT4_I(inode)->i_es_lock);
+
 	if (err)
 		goto retry;
 
@@ -1835,7 +1835,7 @@ void ext4_clear_inode_es(struct inode *inode)
 	struct ext4_es_tree *tree;
 	struct rb_node *node;
 
-	write_lock(&ei->i_es_lock);
+	guard(write_lock)(&ei->i_es_lock);
 	tree = &EXT4_I(inode)->i_es_tree;
 	tree->cache_es = NULL;
 	node = rb_first(&tree->root);
@@ -1848,7 +1848,6 @@ void ext4_clear_inode_es(struct inode *inode)
 		}
 	}
 	ext4_clear_inode_state(inode, EXT4_STATE_EXT_PRECACHED);
-	write_unlock(&ei->i_es_lock);
 }
 
 #ifdef ES_DEBUG__
@@ -2014,9 +2013,8 @@ void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
-	write_lock(&ei->i_es_lock);
+	guard(write_lock)(&ei->i_es_lock);
 	__remove_pending(inode, lblk);
-	write_unlock(&ei->i_es_lock);
 }
 
 /*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index db35148cc84a..e9bc4056ea94 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -852,19 +852,15 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 		return;
 
 	if (grp->bb_avg_fragment_size_order != -1) {
-		write_lock(&sbi->s_mb_avg_fragment_size_locks[
+		guard(write_lock)(&sbi->s_mb_avg_fragment_size_locks[
 					grp->bb_avg_fragment_size_order]);
 		list_del(&grp->bb_avg_fragment_size_node);
-		write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
 	}
 	grp->bb_avg_fragment_size_order = new_order;
-	write_lock(&sbi->s_mb_avg_fragment_size_locks[
+	guard(write_lock)(&sbi->s_mb_avg_fragment_size_locks[
 					grp->bb_avg_fragment_size_order]);
 	list_add_tail(&grp->bb_avg_fragment_size_node,
 		&sbi->s_mb_avg_fragment_size[grp->bb_avg_fragment_size_order]);
-	write_unlock(&sbi->s_mb_avg_fragment_size_locks[
-					grp->bb_avg_fragment_size_order]);
 }
 
 /*
@@ -1160,20 +1156,16 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 	}
 
 	if (grp->bb_largest_free_order >= 0) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
+		guard(write_lock)(&sbi->s_mb_largest_free_orders_locks[
 					      grp->bb_largest_free_order]);
 		list_del_init(&grp->bb_largest_free_order_node);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
 	}
 	grp->bb_largest_free_order = i;
 	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
-		write_lock(&sbi->s_mb_largest_free_orders_locks[
+		guard(write_lock)(&sbi->s_mb_largest_free_orders_locks[
 					      grp->bb_largest_free_order]);
 		list_add_tail(&grp->bb_largest_free_order_node,
 		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
-		write_unlock(&sbi->s_mb_largest_free_orders_locks[
-					      grp->bb_largest_free_order]);
 	}
 }
 
@@ -5110,9 +5102,9 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
 	ext4_unlock_group(sb, grp);
 
 	if (pa->pa_type == MB_INODE_PA) {
-		write_lock(pa->pa_node_lock.inode_lock);
-		rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
-		write_unlock(pa->pa_node_lock.inode_lock);
+		scoped_guard(write_lock, pa->pa_node_lock.inode_lock)
+			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
+
 		ext4_mb_pa_free(pa);
 	} else {
 		spin_lock(pa->pa_node_lock.lg_lock);
@@ -5241,9 +5233,9 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 
 	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
 
-	write_lock(pa->pa_node_lock.inode_lock);
-	ext4_mb_pa_rb_insert(&ei->i_prealloc_node, &pa->pa_node.inode_node);
-	write_unlock(pa->pa_node_lock.inode_lock);
+	scoped_guard(write_lock, pa->pa_node_lock.inode_lock)
+		ext4_mb_pa_rb_insert(&ei->i_prealloc_node, &pa->pa_node.inode_node);
+
 	atomic_inc(&ei->i_prealloc_active);
 }
 
@@ -5472,10 +5464,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 			list_del_rcu(&pa->pa_node.lg_list);
 			spin_unlock(pa->pa_node_lock.lg_lock);
 		} else {
-			write_lock(pa->pa_node_lock.inode_lock);
+			guard(write_lock)(pa->pa_node_lock.inode_lock);
 			ei = EXT4_I(pa->pa_inode);
 			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
-			write_unlock(pa->pa_node_lock.inode_lock);
 		}
 
 		list_del(&pa->u.pa_tmp_list);
@@ -5532,54 +5523,52 @@ void ext4_discard_preallocations(struct inode *inode)
 
 repeat:
 	/* first, collect all pa's in the inode */
-	write_lock(&ei->i_prealloc_lock);
-	for (iter = rb_first(&ei->i_prealloc_node); iter;
-	     iter = rb_next(iter)) {
-		pa = rb_entry(iter, struct ext4_prealloc_space,
-			      pa_node.inode_node);
-		BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
+	scoped_guard(write_lock, &ei->i_prealloc_lock) {
+		for (iter = rb_first(&ei->i_prealloc_node); iter;
+			iter = rb_next(iter)) {
+			pa = rb_entry(iter, struct ext4_prealloc_space,
+					pa_node.inode_node);
+			BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
 
-		spin_lock(&pa->pa_lock);
-		if (atomic_read(&pa->pa_count)) {
-			/* this shouldn't happen often - nobody should
-			 * use preallocation while we're discarding it */
+			spin_lock(&pa->pa_lock);
+			if (atomic_read(&pa->pa_count)) {
+				/* this shouldn't happen often - nobody should
+				* use preallocation while we're discarding it */
+				spin_unlock(&pa->pa_lock);
+				ext4_msg(sb, KERN_ERR,
+					"uh-oh! used pa while discarding");
+				WARN_ON(1);
+				schedule_timeout_uninterruptible(HZ);
+				goto repeat;
+
+			}
+			if (pa->pa_deleted == 0) {
+				ext4_mb_mark_pa_deleted(sb, pa);
+				spin_unlock(&pa->pa_lock);
+				rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
+				list_add(&pa->u.pa_tmp_list, &list);
+				continue;
+			}
+
+			/* someone is deleting pa right now */
 			spin_unlock(&pa->pa_lock);
-			write_unlock(&ei->i_prealloc_lock);
-			ext4_msg(sb, KERN_ERR,
-				 "uh-oh! used pa while discarding");
-			WARN_ON(1);
+
+			/* we have to wait here because pa_deleted
+			* doesn't mean pa is already unlinked from
+			* the list. as we might be called from
+			* ->clear_inode() the inode will get freed
+			* and concurrent thread which is unlinking
+			* pa from inode's list may access already
+			* freed memory, bad-bad-bad */
+
+			/* XXX: if this happens too often, we can
+			* add a flag to force wait only in case
+			* of ->clear_inode(), but not in case of
+			* regular truncate */
 			schedule_timeout_uninterruptible(HZ);
 			goto repeat;
-
-		}
-		if (pa->pa_deleted == 0) {
-			ext4_mb_mark_pa_deleted(sb, pa);
-			spin_unlock(&pa->pa_lock);
-			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
-			list_add(&pa->u.pa_tmp_list, &list);
-			continue;
 		}
-
-		/* someone is deleting pa right now */
-		spin_unlock(&pa->pa_lock);
-		write_unlock(&ei->i_prealloc_lock);
-
-		/* we have to wait here because pa_deleted
-		 * doesn't mean pa is already unlinked from
-		 * the list. as we might be called from
-		 * ->clear_inode() the inode will get freed
-		 * and concurrent thread which is unlinking
-		 * pa from inode's list may access already
-		 * freed memory, bad-bad-bad */
-
-		/* XXX: if this happens too often, we can
-		 * add a flag to force wait only in case
-		 * of ->clear_inode(), but not in case of
-		 * regular truncate */
-		schedule_timeout_uninterruptible(HZ);
-		goto repeat;
 	}
-	write_unlock(&ei->i_prealloc_lock);
 
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7ac562fd50a0..5ae7bc36eb78 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5717,7 +5717,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_max_batch_time = sbi->s_max_batch_time;
 	ext4_fc_init(sb, journal);
 
-	write_lock(&journal->j_state_lock);
+	guard(write_lock)(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
 		journal->j_flags |= JBD2_BARRIER;
 	else
@@ -5731,7 +5731,6 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	 * records log transactions continuously between each mount.
 	 */
 	journal->j_flags |= JBD2_CYCLE_RECORD;
-	write_unlock(&journal->j_state_lock);
 }
 
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
-- 
2.34.1


