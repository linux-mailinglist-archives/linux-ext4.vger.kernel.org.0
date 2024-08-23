Return-Path: <linux-ext4+bounces-3877-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1269495C52B
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 08:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358E21C23A66
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B9473467;
	Fri, 23 Aug 2024 06:10:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8B57CA6
	for <linux-ext4@vger.kernel.org>; Fri, 23 Aug 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393449; cv=none; b=M0aZIvJEvn3agfYQQzp58qoGqREMvqLRx+DKhDBBxLFt5zqsbStq3Im1yoPgA0lvR6/sfR8vKOdVs4MyIiW+cb+PsI8qMud/f7PuUaZ6kehnxvAGniKOwnHE/pXbD7Rslr5P98ClGW3dqFAIi3RQSyHLi9xmveRcf0RjtTzgzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393449; c=relaxed/simple;
	bh=+5lmNl7aMWz13x0ieT8dlUqLPZ3WYUHqnShhxf6Nlcc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6vJEqy+NicAFQXLwIN8YKoOlKjrfdlbSpN7tcH30SZ6uv1yITnJP++YQxeT0nL+UaG/qdpdI5hYIR47AjIPCgrUjmBw2aQc/DzpyulMfl2a4XtB/VXxEVzahsBVAcRdk5cONG5uqsOkPouiYOtC3YdbfB1fbm9vZP9R/qGcTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqqNc73hQz1HGty;
	Fri, 23 Aug 2024 14:07:28 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AA991A016C;
	Fri, 23 Aug 2024 14:10:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 14:10:42 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lizetao1@huawei.com>, <linux-ext4@vger.kernel.org>
Subject: [PATCH -next 1/3] ext4: Use scoped()/scoped_guard() to drop read_lock()/unlock pair
Date: Fri, 23 Aug 2024 14:18:22 +0800
Message-ID: <20240823061824.3323522-2-lizetao1@huawei.com>
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

A read_lock() and read_unlock() pair can be replaced by a
scope-based resource management function scoped() or scoped_guard()
which can make the code more readable and safer.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ext4/extents_status.c | 41 +++++++---------------------
 fs/ext4/fast_commit.c    |  3 +--
 fs/ext4/inode.c          | 11 ++++----
 fs/ext4/mballoc.c        | 58 ++++++++++++++++++----------------------
 4 files changed, 42 insertions(+), 71 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 17dcf13adde2..407447819864 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -317,9 +317,8 @@ void ext4_es_find_extent_range(struct inode *inode,
 
 	trace_ext4_es_find_extent_range_enter(inode, lblk);
 
-	read_lock(&EXT4_I(inode)->i_es_lock);
-	__es_find_extent_range(inode, matching_fn, lblk, end, es);
-	read_unlock(&EXT4_I(inode)->i_es_lock);
+	scoped_guard(read_lock, &EXT4_I(inode)->i_es_lock)
+		__es_find_extent_range(inode, matching_fn, lblk, end, es);
 
 	trace_ext4_es_find_extent_range_exit(inode, es);
 }
@@ -363,16 +362,11 @@ bool ext4_es_scan_range(struct inode *inode,
 			int (*matching_fn)(struct extent_status *es),
 			ext4_lblk_t lblk, ext4_lblk_t end)
 {
-	bool ret;
-
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return false;
 
-	read_lock(&EXT4_I(inode)->i_es_lock);
-	ret = __es_scan_range(inode, matching_fn, lblk, end);
-	read_unlock(&EXT4_I(inode)->i_es_lock);
-
-	return ret;
+	guard(read_lock)(&EXT4_I(inode)->i_es_lock);
+	return __es_scan_range(inode, matching_fn, lblk, end);
 }
 
 /*
@@ -409,16 +403,11 @@ bool ext4_es_scan_clu(struct inode *inode,
 		      int (*matching_fn)(struct extent_status *es),
 		      ext4_lblk_t lblk)
 {
-	bool ret;
-
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return false;
 
-	read_lock(&EXT4_I(inode)->i_es_lock);
-	ret = __es_scan_clu(inode, matching_fn, lblk);
-	read_unlock(&EXT4_I(inode)->i_es_lock);
-
-	return ret;
+	guard(read_lock)(&EXT4_I(inode)->i_es_lock);
+	return __es_scan_clu(inode, matching_fn, lblk);
 }
 
 static void ext4_es_list_add(struct inode *inode)
@@ -2044,13 +2033,9 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	bool ret;
 
-	read_lock(&ei->i_es_lock);
-	ret = (bool)(__get_pending(inode, EXT4_B2C(sbi, lblk)) != NULL);
-	read_unlock(&ei->i_es_lock);
-
-	return ret;
+	guard(read_lock)(&ei->i_es_lock);
+	return __get_pending(inode, EXT4_B2C(sbi, lblk)) != NULL;
 }
 
 /*
@@ -2232,7 +2217,6 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	ext4_lblk_t end;
-	unsigned int n;
 
 	if (len == 0)
 		return 0;
@@ -2240,13 +2224,8 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 	end = lblk + len - 1;
 	WARN_ON(end < lblk);
 
-	read_lock(&ei->i_es_lock);
-
-	n = __es_delayed_clu(inode, lblk, end);
-
-	read_unlock(&ei->i_es_lock);
-
-	return n;
+	guard(read_lock)(&ei->i_es_lock);
+	return __es_delayed_clu(inode, lblk, end);
 }
 
 /*
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..e2a773221523 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -347,10 +347,9 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 	if (handle && !IS_ERR(handle))
 		tid = handle->h_transaction->t_tid;
 	else {
-		read_lock(&sbi->s_journal->j_state_lock);
+		guard(read_lock)(&sbi->s_journal->j_state_lock);
 		tid = sbi->s_journal->j_running_transaction ?
 				sbi->s_journal->j_running_transaction->t_tid : 0;
-		read_unlock(&sbi->s_journal->j_state_lock);
 	}
 	spin_lock(&sbi->s_fc_lock);
 	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03374dc215d1..2c978d8ff3ba 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4919,7 +4919,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		transaction_t *transaction;
 		tid_t tid;
 
-		read_lock(&journal->j_state_lock);
+		guard(read_lock)(&journal->j_state_lock);
 		if (journal->j_running_transaction)
 			transaction = journal->j_running_transaction;
 		else
@@ -4928,7 +4928,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			tid = transaction->t_tid;
 		else
 			tid = journal->j_commit_sequence;
-		read_unlock(&journal->j_state_lock);
 		ei->i_sync_tid = tid;
 		ei->i_datasync_tid = tid;
 	}
@@ -5303,10 +5302,10 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 		if (ret != -EBUSY)
 			return;
 		commit_tid = 0;
-		read_lock(&journal->j_state_lock);
-		if (journal->j_committing_transaction)
-			commit_tid = journal->j_committing_transaction->t_tid;
-		read_unlock(&journal->j_state_lock);
+		scoped_guard(read_lock, &journal->j_state_lock)
+			if (journal->j_committing_transaction)
+				commit_tid = journal->j_committing_transaction->t_tid;
+
 		if (commit_tid)
 			jbd2_log_wait_commit(journal, commit_tid);
 	}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..db35148cc84a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -887,23 +887,22 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
 		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
 			continue;
-		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
-		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
-			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
-			continue;
-		}
-		list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
-				    bb_largest_free_order_node) {
-			if (sbi->s_mb_stats)
-				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
-			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
-				*group = iter->bb_group;
-				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
-				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
-				return;
+		scoped_guard(read_lock, &sbi->s_mb_largest_free_orders_locks[i]) {
+			if (list_empty(&sbi->s_mb_largest_free_orders[i]))
+				continue;
+			list_for_each_entry(iter, &sbi->s_mb_largest_free_orders[i],
+						bb_largest_free_order_node) {
+				if (sbi->s_mb_stats)
+					atomic64_inc(
+                                         &sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
+				if (likely(ext4_mb_good_group(ac, iter->bb_group,
+                                        CR_POWER2_ALIGNED))) {
+					*group = iter->bb_group;
+					ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
+					return;
+				}
 			}
 		}
-		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
 	}
 
 	/* Increment cr and search again if no group is found */
@@ -924,11 +923,10 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
 
 	if (list_empty(frag_list))
 		return NULL;
-	read_lock(frag_list_lock);
-	if (list_empty(frag_list)) {
-		read_unlock(frag_list_lock);
+	guard(read_lock)(frag_list_lock);
+	if (list_empty(frag_list))
 		return NULL;
-	}
+
 	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
 		if (sbi->s_mb_stats)
 			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
@@ -937,7 +935,6 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
 			break;
 		}
 	}
-	read_unlock(frag_list_lock);
 	return grp;
 }
 
@@ -3236,11 +3233,10 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 			seq_puts(seq, "avg_fragment_size_lists:\n");
 
 		count = 0;
-		read_lock(&sbi->s_mb_avg_fragment_size_locks[position]);
-		list_for_each_entry(grp, &sbi->s_mb_avg_fragment_size[position],
-				    bb_avg_fragment_size_node)
-			count++;
-		read_unlock(&sbi->s_mb_avg_fragment_size_locks[position]);
+		scoped_guard(read_lock, &sbi->s_mb_avg_fragment_size_locks[position])
+			list_for_each_entry(grp, &sbi->s_mb_avg_fragment_size[position],
+						bb_avg_fragment_size_node)
+				count++;
 		seq_printf(seq, "\tlist_order_%u_groups: %u\n",
 					(unsigned int)position, count);
 		return 0;
@@ -3252,11 +3248,10 @@ static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
 		seq_puts(seq, "max_free_order_lists:\n");
 	}
 	count = 0;
-	read_lock(&sbi->s_mb_largest_free_orders_locks[position]);
-	list_for_each_entry(grp, &sbi->s_mb_largest_free_orders[position],
-			    bb_largest_free_order_node)
-		count++;
-	read_unlock(&sbi->s_mb_largest_free_orders_locks[position]);
+	scoped_guard(read_lock, &sbi->s_mb_largest_free_orders_locks[position])
+		list_for_each_entry(grp, &sbi->s_mb_largest_free_orders[position],
+					bb_largest_free_order_node)
+			count++;
 	seq_printf(seq, "\tlist_order_%u_groups: %u\n",
 		   (unsigned int)position, count);
 
@@ -4251,7 +4246,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 	loff_t tmp_pa_end;
 	struct rb_node *iter;
 
-	read_lock(&ei->i_prealloc_lock);
+	guard(read_lock)(&ei->i_prealloc_lock);
 	for (iter = ei->i_prealloc_node.rb_node; iter;
 	     iter = ext4_mb_pa_rb_next_iter(start, tmp_pa_start, iter)) {
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
@@ -4264,7 +4259,6 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
 		spin_unlock(&tmp_pa->pa_lock);
 	}
-	read_unlock(&ei->i_prealloc_lock);
 }
 
 /*
-- 
2.34.1


