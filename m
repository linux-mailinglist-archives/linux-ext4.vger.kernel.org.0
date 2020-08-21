Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93D024C9BC
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgHUB4B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgHUBzk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43682C061343
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so178281plp.4
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7iIRNguo7tU3fAQgSA+TJ9RVxJTULM3GQNAS+Z/n/U=;
        b=Jl0DsrM/C8FX9KcVPY5JsVzGCFlI1tz8DbDwmbCGVWbhcAX7EWIQ/pH4eU8q/9BCuN
         IDZOagNs0K58B694Z3faKZ9/xUMJWnuf6ctTxEto8Mm6cpWYm31bNxO/FMbIdzo9UmaM
         EQRHJjyA2H0idYGXzhKRfkDPdq5Fss5/pIk9BWh22HcjTJ8hBg8fR0ZRKrdzrLDdvkHQ
         YztNRPLKT7IZoAHP6Ei+ZcuKgVlr+MRi4f182Nxt5IG4NlSuM8trOt3WWeY0X5+RIKBz
         ETHUn+/kNz+xIExRTTdeihCjpptGJk/P9atKB+ggixyDT30z0FGebTXedFIky3ATuNxX
         h1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7iIRNguo7tU3fAQgSA+TJ9RVxJTULM3GQNAS+Z/n/U=;
        b=j0BGNxnelplhg9TLfcRO3gOZkiBLGnIVglvGr3xayT4MY1eEg+LqMPSBRtUqILozKf
         nx8VeJcWB5OC+61b90zbwOJ5coCqmNun+tTsdS4BxPXkCPuKNMzCJdzIIifLRUve8K7R
         5jOn6/cPbiCAJkKQyefe/LzWwORw6mIs/AGtqEsF1uDkXDbC1jGdNLThERaGYc+abElS
         iIEcFdgy1q6dCng+VLnhzhTT/L2bd5ZUan8RFYZAt0cAEyYhkhvve6lLBn6604orbK00
         w0021ShIbcBllGP8zw8a9BWd8qoReIs4kbpND8aFTwfMm+DRCBOBuUa3YC721iKT4Lya
         vXHQ==
X-Gm-Message-State: AOAM533iBByrFXgZVtdSHVnp6J24BNU+4Nla+7FjiwPsbzfMKvMNDXNd
        v1af7UikjguJa9pWZFvTWEIbuJSqD5U=
X-Google-Smtp-Source: ABdhPJyxfwGaIKUHmcObXg1rJY2Mfhm8VGMbH+nZtzI/NZUa+3fcKd3T/XlUt83IBTpNODCokC7DTA==
X-Received: by 2002:a17:902:9009:: with SMTP id a9mr505786plp.252.1597974939324;
        Thu, 20 Aug 2020 18:55:39 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:38 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v2 8/9] ext4: add tracepoints for free space trees
Date:   Thu, 20 Aug 2020 18:55:22 -0700
Message-Id: <20200821015523.1698374-9-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821015523.1698374-1-harshads@google.com>
References: <20200821015523.1698374-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch adds a few trace points to track the flow of allocation
requests with free space trees.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |   1 +
 fs/ext4/mballoc.c           |   9 +++
 fs/ext4/mballoc.h           |   3 +-
 include/trace/events/ext4.h | 112 ++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 64d0dbbcd517..22850763c5a8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1661,6 +1661,7 @@ struct ext4_sb_info {
 	atomic_t s_mb_num_fragments;
 	u32 s_mb_frsp_mem_limit;
 	struct ext4_mb_frsp_lru s_mb_frsp_lru;
+	atomic_t s_mb_ac_id;
 
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index aea0eb8d28da..eb99e2fb9a68 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -945,6 +945,7 @@ void ext4_mb_frsp_free_tree(struct super_block *sb, struct ext4_frsp_tree *tree)
 	tree->frsp_len_root = RB_ROOT_CACHED;
 out:
 	mutex_unlock(&tree->frsp_lock);
+	trace_ext4_mb_frsp_free_tree(sb, tree->frsp_index);
 }
 
 /*
@@ -1476,6 +1477,7 @@ int ext4_mb_frsp_optimize(struct ext4_allocation_context *ac, int *tree_idx)
 	mb_debug(ac->ac_sb,
 		"Optimizer suggestion: found = %d, tree = %d, len = %d, cr = %d\n",
 		found, *tree_idx, better_len, ac->ac_criteria);
+	trace_ext4_mb_frsp_optimize(ac, found, cache_more_trees, *tree_idx);
 	return ret;
 }
 
@@ -1546,6 +1548,11 @@ ext4_mb_tree_allocator(struct ext4_allocation_context *ac)
 		ac->ac_groups_scanned++;
 		tree_idx = (j % sbi->s_mb_num_frsp_trees);
 
+		trace_ext4_mb_tree_allocator(ac, tree_idx,
+				sbi->s_mb_num_frsp_trees,
+				atomic_read(&sbi->s_mb_num_frsp_trees_cached),
+				atomic_read(&sbi->s_mb_num_fragments) *
+				sizeof(struct ext4_frsp_node));
 		ret = ext4_mb_load_allocator(sb,
 				tree_idx * ext4_flex_bg_size(sbi), &e4b, 0);
 		if (ret)
@@ -1655,6 +1662,7 @@ int ext4_mb_init_freespace_trees(struct super_block *sb)
 	if (sbi->s_mb_frsp_mem_limit < EXT4_MB_FRSP_MEM_MIN(sb))
 		sbi->s_mb_frsp_mem_limit = EXT4_MB_FRSP_MEM_MIN(sb);
 	atomic_set(&sbi->s_mb_frsp_lru.frsp_active_fragments, 0);
+	atomic_set(&sbi->s_mb_ac_id, 0);
 
 	return 0;
 }
@@ -5794,6 +5802,7 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 	ext4_get_group_no_and_offset(sb, goal, &group, &block);
 
 	/* set up allocation goals */
+	ac->ac_id = atomic_inc_return(&sbi->s_mb_ac_id);
 	ac->ac_b_ex.fe_logical = EXT4_LBLK_CMASK(sbi, ar->logical);
 	ac->ac_status = AC_STATUS_CONTINUE;
 	ac->ac_sb = sb;
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 6cfb228e4da2..e734c05572b6 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -171,7 +171,6 @@ struct ext4_tree_extent {
 };
 
 struct ext4_allocation_context {
-	__u32	ac_id;
 	struct inode *ac_inode;
 	struct super_block *ac_sb;
 
@@ -206,6 +205,8 @@ struct ext4_allocation_context {
 				 * N > 0, the field stores N, otherwise 0 */
 	__u8 ac_num_optimizations;
 	__u8 ac_op;		/* operation, for history only */
+	__u8 ac_id;		/* allocation ID for tracking purpose */
+
 	struct page *ac_bitmap_page;
 	struct page *ac_buddy_page;
 	struct ext4_prealloc_space *ac_pa;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 4c8b99ec8606..e5b4c1576097 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -874,6 +874,118 @@ TRACE_EVENT(ext4_allocate_blocks,
 		  __entry->pleft, __entry->pright)
 );
 
+TRACE_EVENT(ext4_mb_frsp_free_tree,
+	TP_PROTO(struct super_block *sb, int tree),
+
+	TP_ARGS(sb, tree),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	int,	tree			)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->tree	= tree;
+	),
+
+	TP_printk("dev %d,%d tree %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),  __entry->tree)
+);
+
+TRACE_EVENT(ext4_mb_frsp_optimize,
+	TP_PROTO(struct ext4_allocation_context *ac, int found,
+		 int cache_more_trees, int tree),
+
+	TP_ARGS(ac, found, cache_more_trees, tree),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	ino_t,	ino			)
+		__field(	unsigned int, len		)
+		__field(	unsigned int, flags		)
+		__field(	int,	found			)
+		__field(	int,	tree			)
+		__field(	int,	num_found		)
+		__field(	int,	attempts		)
+		__field(	int,	ac_id			)
+		__field(	int,	ac_criteria		)
+		__field(	int,	ac_groups_scanned	)
+		__field(	int,	cache_more_trees	)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= ac->ac_sb->s_dev;
+		__entry->ino	= ac->ac_inode->i_ino;
+		__entry->len	= ac->ac_b_tree_ex.te_len;
+		__entry->flags	= ac->ac_flags;
+		__entry->found	= found;
+		__entry->tree	= tree;
+		__entry->attempts = ac->ac_num_optimizations;
+		__entry->ac_id = ac->ac_id;
+		__entry->num_found = ac->ac_found;
+		__entry->ac_criteria = ac->ac_criteria;
+		__entry->ac_groups_scanned = ac->ac_groups_scanned;
+		__entry->cache_more_trees = cache_more_trees;
+	),
+
+	TP_printk("dev %d,%d ino %lu ac %d flags %s best-len %u num-found %d "
+		  "suggest-tree %d cache_more %d attempt %d status %d cr %d "
+		  "nflexgrps %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino, __entry->ac_id,
+		  show_mballoc_flags(__entry->flags),
+		  __entry->len, __entry->num_found, __entry->tree,
+		  __entry->cache_more_trees, __entry->attempts, __entry->found,
+		  __entry->ac_criteria, __entry->ac_groups_scanned)
+);
+
+TRACE_EVENT(ext4_mb_tree_allocator,
+	TP_PROTO(struct ext4_allocation_context *ac, int tree, int num_trees,
+		int num_trees_loaded, int bytes_usage),
+
+	TP_ARGS(ac, tree, num_trees, num_trees_loaded, bytes_usage),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	ino_t,	ino			)
+		__field(	unsigned int, len		)
+		__field(	unsigned int, flags		)
+		__field(	int,	num_trees		)
+		__field(	int,	num_trees_loaded	)
+		__field(	int,	tree			)
+		__field(	int,	ac_id			)
+		__field(	int,	ac_found		)
+		__field(	int,	ac_criteria		)
+		__field(	int,	ac_groups_scanned	)
+		__field(	int,	bytes_usage		)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= ac->ac_sb->s_dev;
+		__entry->ino	= ac->ac_inode->i_ino;
+		__entry->len	= ac->ac_b_tree_ex.te_len;
+		__entry->flags	= ac->ac_flags;
+		__entry->num_trees = num_trees;
+		__entry->num_trees_loaded	= num_trees_loaded;
+		__entry->tree = tree;
+		__entry->ac_id = ac->ac_id;
+		__entry->ac_found = ac->ac_found;
+		__entry->ac_criteria = ac->ac_criteria;
+		__entry->ac_groups_scanned = ac->ac_groups_scanned;
+		__entry->bytes_usage = bytes_usage;
+	),
+
+	TP_printk("dev %d,%d ino %lu ac %d flags %s best-len %u found %d current-tree %d "
+		  "num-trees %d num-trees-loaded %d cr %d nflexgrps %d mem_bytes %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino, __entry->ac_id,
+		  show_mballoc_flags(__entry->flags),
+		  __entry->len, __entry->ac_found, __entry->tree, __entry->num_trees,
+		  __entry->num_trees_loaded, __entry->ac_criteria,
+		  __entry->ac_groups_scanned, __entry->bytes_usage)
+);
+
 TRACE_EVENT(ext4_free_blocks,
 	TP_PROTO(struct inode *inode, __u64 block, unsigned long count,
 		 int flags),
-- 
2.28.0.297.g1956fa8f8d-goog

