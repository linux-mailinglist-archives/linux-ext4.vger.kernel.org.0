Return-Path: <linux-ext4+bounces-3879-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429D095C52D
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 08:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6B62842E8
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2024 06:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95EE762EB;
	Fri, 23 Aug 2024 06:10:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349D481DA
	for <linux-ext4@vger.kernel.org>; Fri, 23 Aug 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393451; cv=none; b=U0mQRFflou5oCJhWB7nckFvzRx/oA2FNBtzqKziHLVnPJNzBmRf/kgrU3BnZT9d7Ulcuhn4dXcc4kZPTn6ZpQPkOqcCm4h+KyxnzyqnYVF4fXNgb4sDPBboHr39O8K1GuQ1oO42/di9haBHH91/lt+wITgFc8nw1yCSZAluS/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393451; c=relaxed/simple;
	bh=VoatHBcDpJy7/mNMSH5lhV7A5dUKcJ4reWXIPRJImSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZX3xBHvSHoqRwYX7qcZTGNN2mTWuz8Z0YOPBqBt3lnPtazuPLm8/wiPh/wRyGeznVeIgjLXPaNaMqzhV1geE3eWjbVyabJc4X3bfL60g7ouTFJ6Xh5rOcF/03xef+g8l/cDRQuRZPHCtsNrphgLQOTKmWkSEMFlhMdeWkpQE6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WqqSH08t0z2CnJ4;
	Fri, 23 Aug 2024 14:10:39 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id A0A66180042;
	Fri, 23 Aug 2024 14:10:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 23 Aug
 2024 14:10:43 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lizetao1@huawei.com>, <linux-ext4@vger.kernel.org>
Subject: [PATCH -next 3/3] ext4: Use scoped()/scoped_guard() to drop rcu_read_lock()/unlock pair
Date: Fri, 23 Aug 2024 14:18:24 +0800
Message-ID: <20240823061824.3323522-4-lizetao1@huawei.com>
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

A rcu_read_lock() and rcu_read_unlock() pair can be replaced by a
scope-based resource management function scoped(rcu) or scoped_guard(rcu)
which can make the code more readable and safer. In some functions, we
can remove the goto label which will release the lock, and return from
function directly.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ext4/block_validity.c | 27 +++++++++++++--------------
 fs/ext4/ext4.h           |  3 +--
 fs/ext4/inode.c          |  3 +--
 fs/ext4/mballoc.c        | 37 ++++++++++++++++---------------------
 fs/ext4/resize.c         | 20 ++++++++++----------
 fs/ext4/super.c          | 26 +++++++++++---------------
 6 files changed, 52 insertions(+), 64 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 87ee3a17bd29..962ee95017fd 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -130,17 +130,17 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 	int first = 1;
 
 	printk(KERN_INFO "System zones: ");
-	rcu_read_lock();
-	system_blks = rcu_dereference(sbi->s_system_blks);
-	node = rb_first(&system_blks->root);
-	while (node) {
-		entry = rb_entry(node, struct ext4_system_zone, node);
-		printk(KERN_CONT "%s%llu-%llu", first ? "" : ", ",
-		       entry->start_blk, entry->start_blk + entry->count - 1);
-		first = 0;
-		node = rb_next(node);
+	scoped_guard(rcu) {
+		system_blks = rcu_dereference(sbi->s_system_blks);
+		node = rb_first(&system_blks->root);
+		while (node) {
+			entry = rb_entry(node, struct ext4_system_zone, node);
+			printk(KERN_CONT "%s%llu-%llu", first ? "" : ", ",
+				entry->start_blk, entry->start_blk + entry->count - 1);
+			first = 0;
+			node = rb_next(node);
+		}
 	}
-	rcu_read_unlock();
 	printk(KERN_CONT "\n");
 }
 
@@ -311,10 +311,10 @@ int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
 	 * when doing a remount which inverse current "[no]block_validity"
 	 * mount option.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
 	system_blks = rcu_dereference(sbi->s_system_blks);
 	if (system_blks == NULL)
-		goto out_rcu;
+		return ret;
 
 	n = system_blks->root.rb_node;
 	while (n) {
@@ -330,8 +330,7 @@ int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
 			break;
 		}
 	}
-out_rcu:
-	rcu_read_unlock();
+
 	return ret;
 }
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 92a5e2d29599..13402929c757 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1809,9 +1809,8 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 #define sbi_array_rcu_deref(sbi, field, index)				   \
 ({									   \
 	typeof(*((sbi)->field)) _v;					   \
-	rcu_read_lock();						   \
+	guard(rcu)();						   \
 	_v = ((typeof(_v)*)rcu_dereference((sbi)->field))[index];	   \
-	rcu_read_unlock();						   \
 	_v;								   \
 })
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2c978d8ff3ba..1172b43dcc18 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5099,14 +5099,13 @@ static void ext4_update_other_inodes_time(struct super_block *sb,
 	 * (assuming 4k blocks and 256 byte inodes) is (n*16 + 1).
 	 */
 	ino = ((orig_ino - 1) & ~(inodes_per_block - 1)) + 1;
-	rcu_read_lock();
+	guard(rcu)();
 	for (i = 0; i < inodes_per_block; i++, ino++, buf += inode_size) {
 		if (ino == orig_ino)
 			continue;
 		__ext4_update_other_inode_time(sb, orig_ino, ino,
 					       (struct ext4_inode *)buf);
 	}
-	rcu_read_unlock();
 }
 
 /*
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e9bc4056ea94..905752a396c1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3291,12 +3291,12 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
 		ext4_msg(sb, KERN_ERR, "can't allocate buddy meta group");
 		return -ENOMEM;
 	}
-	rcu_read_lock();
-	old_groupinfo = rcu_dereference(sbi->s_group_info);
-	if (old_groupinfo)
-		memcpy(new_groupinfo, old_groupinfo,
-		       sbi->s_group_info_size * sizeof(*sbi->s_group_info));
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		old_groupinfo = rcu_dereference(sbi->s_group_info);
+		if (old_groupinfo)
+			memcpy(new_groupinfo, old_groupinfo,
+				sbi->s_group_info_size * sizeof(*sbi->s_group_info));
+	}
 	rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
 	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
 	if (old_groupinfo)
@@ -3331,9 +3331,8 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 				 "for a buddy group");
 			return -ENOMEM;
 		}
-		rcu_read_lock();
+		guard(rcu)();
 		rcu_dereference(sbi->s_group_info)[idx] = meta_group_info;
-		rcu_read_unlock();
 	}
 
 	meta_group_info = sbi_array_rcu_deref(sbi, s_group_info, idx);
@@ -3377,11 +3376,10 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	if (group % EXT4_DESC_PER_BLOCK(sb) == 0) {
 		struct ext4_group_info ***group_info;
 
-		rcu_read_lock();
+		guard(rcu)();
 		group_info = rcu_dereference(sbi->s_group_info);
 		kfree(group_info[idx]);
 		group_info[idx] = NULL;
-		rcu_read_unlock();
 	}
 	return -ENOMEM;
 } /* ext4_mb_add_groupinfo */
@@ -3462,16 +3460,15 @@ static int ext4_mb_init_backend(struct super_block *sb)
 			kmem_cache_free(cachep, grp);
 	}
 	i = sbi->s_group_info_size;
-	rcu_read_lock();
-	group_info = rcu_dereference(sbi->s_group_info);
-	while (i-- > 0)
-		kfree(group_info[i]);
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		group_info = rcu_dereference(sbi->s_group_info);
+		while (i-- > 0)
+			kfree(group_info[i]);
+	}
 	iput(sbi->s_buddy_cache);
 err_freesgi:
-	rcu_read_lock();
+	guard(rcu)();
 	kvfree(rcu_dereference(sbi->s_group_info));
-	rcu_read_unlock();
 	return -ENOMEM;
 }
 
@@ -3789,12 +3786,11 @@ void ext4_mb_release(struct super_block *sb)
 		num_meta_group_infos = (ngroups +
 				EXT4_DESC_PER_BLOCK(sb) - 1) >>
 			EXT4_DESC_PER_BLOCK_BITS(sb);
-		rcu_read_lock();
+		guard(rcu)();
 		group_info = rcu_dereference(sbi->s_group_info);
 		for (i = 0; i < num_meta_group_infos; i++)
 			kfree(group_info[i]);
 		kvfree(group_info);
-		rcu_read_unlock();
 	}
 	kfree(sbi->s_mb_avg_fragment_size);
 	kfree(sbi->s_mb_avg_fragment_size_locks);
@@ -4946,7 +4942,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	 * minimal distance from the goal block.
 	 */
 	for (i = order; i < PREALLOC_TB_SIZE; i++) {
-		rcu_read_lock();
+		guard(rcu)();
 		list_for_each_entry_rcu(tmp_pa, &lg->lg_prealloc_list[i],
 					pa_node.lg_list) {
 			spin_lock(&tmp_pa->pa_lock);
@@ -4958,7 +4954,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			}
 			spin_unlock(&tmp_pa->pa_lock);
 		}
-		rcu_read_unlock();
 	}
 	if (cpa) {
 		ext4_mb_use_group_pa(ac, cpa);
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 0ba9837d65ca..a72e0b1f6435 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -920,11 +920,11 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	}
 	brelse(dind);
 
-	rcu_read_lock();
-	o_group_desc = rcu_dereference(EXT4_SB(sb)->s_group_desc);
-	memcpy(n_group_desc, o_group_desc,
-	       EXT4_SB(sb)->s_gdb_count * sizeof(struct buffer_head *));
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		o_group_desc = rcu_dereference(EXT4_SB(sb)->s_group_desc);
+		memcpy(n_group_desc, o_group_desc,
+			EXT4_SB(sb)->s_gdb_count * sizeof(struct buffer_head *));
+	}
 	n_group_desc[gdb_num] = gdb_bh;
 	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
 	EXT4_SB(sb)->s_gdb_count++;
@@ -980,11 +980,11 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 		return err;
 	}
 
-	rcu_read_lock();
-	o_group_desc = rcu_dereference(EXT4_SB(sb)->s_group_desc);
-	memcpy(n_group_desc, o_group_desc,
-	       EXT4_SB(sb)->s_gdb_count * sizeof(struct buffer_head *));
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		o_group_desc = rcu_dereference(EXT4_SB(sb)->s_group_desc);
+		memcpy(n_group_desc, o_group_desc,
+			EXT4_SB(sb)->s_gdb_count * sizeof(struct buffer_head *));
+	}
 	n_group_desc[gdb_num] = gdb_bh;
 
 	BUFFER_TRACE(gdb_bh, "get_write_access");
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5ae7bc36eb78..4826b1689c53 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1249,12 +1249,11 @@ static void ext4_group_desc_free(struct ext4_sb_info *sbi)
 	struct buffer_head **group_desc;
 	int i;
 
-	rcu_read_lock();
+	guard(rcu)();
 	group_desc = rcu_dereference(sbi->s_group_desc);
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(group_desc[i]);
 	kvfree(group_desc);
-	rcu_read_unlock();
 }
 
 static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
@@ -1262,14 +1261,13 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
 	struct flex_groups **flex_groups;
 	int i;
 
-	rcu_read_lock();
+	guard(rcu)();
 	flex_groups = rcu_dereference(sbi->s_flex_groups);
 	if (flex_groups) {
 		for (i = 0; i < sbi->s_flex_groups_allocated; i++)
 			kvfree(flex_groups[i]);
 		kvfree(flex_groups);
 	}
-	rcu_read_unlock();
 }
 
 static void ext4_put_super(struct super_block *sb)
@@ -2892,14 +2890,13 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
 		seq_printf(seq, ",jqfmt=%s", fmtname);
 	}
 
-	rcu_read_lock();
+	guard(rcu)();
 	usr_qf_name = rcu_dereference(sbi->s_qf_names[USRQUOTA]);
 	grp_qf_name = rcu_dereference(sbi->s_qf_names[GRPQUOTA]);
 	if (usr_qf_name)
 		seq_show_option(seq, "usrjquota", usr_qf_name);
 	if (grp_qf_name)
 		seq_show_option(seq, "grpjquota", grp_qf_name);
-	rcu_read_unlock();
 #endif
 }
 
@@ -3140,13 +3137,13 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
 			return -ENOMEM;
 		}
 	}
-	rcu_read_lock();
-	old_groups = rcu_dereference(sbi->s_flex_groups);
-	if (old_groups)
-		memcpy(new_groups, old_groups,
-		       (sbi->s_flex_groups_allocated *
-			sizeof(struct flex_groups *)));
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		old_groups = rcu_dereference(sbi->s_flex_groups);
+		if (old_groups)
+			memcpy(new_groups, old_groups,
+				(sbi->s_flex_groups_allocated *
+				sizeof(struct flex_groups *)));
+	}
 	rcu_assign_pointer(sbi->s_flex_groups, new_groups);
 	sbi->s_flex_groups_allocated = size;
 	if (old_groups)
@@ -4851,9 +4848,8 @@ static int ext4_group_desc_init(struct super_block *sb,
 			sbi->s_gdb_count = i;
 			return PTR_ERR(bh);
 		}
-		rcu_read_lock();
+		guard(rcu)();
 		rcu_dereference(sbi->s_group_desc)[i] = bh;
-		rcu_read_unlock();
 	}
 	sbi->s_gdb_count = db_count;
 	if (!ext4_check_descriptors(sb, logical_sb_block, first_not_zeroed)) {
-- 
2.34.1


