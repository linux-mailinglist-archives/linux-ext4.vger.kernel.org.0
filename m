Return-Path: <linux-ext4+bounces-12587-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF356CF837F
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 13:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E50AF300C36C
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 12:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D4325720;
	Tue,  6 Jan 2026 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="gy5TJwDQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-e105.zoho.com (sender4-pp-e105.zoho.com [136.143.188.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A8322B79;
	Tue,  6 Jan 2026 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767701203; cv=pass; b=IHBQYzxT9ctIdG88Y3QwUdgaY1o+RZWvvI7b/kxRA7g4KTHcZZZvJzLvXN8oOgF+biUYU6S3G5sK0NlxIL6Q6r13NgS+HTzZo79z4q/ij0HqV7rl5OrITd1hlMjzsZbZjHfmaiA2z5cUzADuV+3kXvRDFWZmSSgvlfeaSHhiC04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767701203; c=relaxed/simple;
	bh=ZCaY/TeFHxCFIInQU2Dok4zB1zYQta2W0E0U3wmGyGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNSEgZ4PB0wHfRnmki/yFQZSYaUBZfl2ym78H7vibrwS5BwP4uVJ9VDUK7qpoaVTbKeEfm6r0lx3NKYXmQtZzBJLqsh/jgAVKXEPB+/p5DlgO5qG2k/P5bKjS7azlVIABDShCArBvhuaUpP3mqZ9vSFv62XFsDKKSeZXr1nyedE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=gy5TJwDQ; arc=pass smtp.client-ip=136.143.188.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1767701193; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WG9rk+/WxrBqQ/SOva2aB5Dk2h5c+zs3BVXM5+AP9uqLBSoSkuq3PGlWMZT5Qne+e7mGRXrWCCiz88OHfSNC7M2dZIDCZN0NBpoUByUZZHkrgAQFNNUNoglcKpu5NRtTsytogc+4B/aaHt4oYzJqc+MksjUno8jEomVz6lfqce4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767701193; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gwJQRtVsFpnaGJrh1tJrF9j/gUldNpQSSDiq3hc3NzM=; 
	b=Re7R2aROXYU0YA+3Uo0xX7FMhSrKe9NUwO/uEWYULIIA2CNwDe/j90iu27H2KoUBswYqR0iM1+A35q9GORZqajH4C8sT4zdgRp/6PAfLj392fngMfcA5XwZWLcm4/b13N9i7v32dlxDt02NAiM7ghHIecgwzvwe2KUpwRB05UEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767701193;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gwJQRtVsFpnaGJrh1tJrF9j/gUldNpQSSDiq3hc3NzM=;
	b=gy5TJwDQiIWhlbjv9vB/0jUnQD+FeTuZ/8gJj4+AW9JFyMrmodBRpvoB3LS5aNTe
	V/XoNDlqp3wv/zWv4Ieryb8eqe3anGgFEPjNWh/ODQQgcTsRZ1S33j/61JE8FHo7Qhs
	zRMRNQsAzil98ZzTv9ZNx/+r+d5YLm/tDn87/V4Y=
Received: by mx.zohomail.com with SMTPS id 1767701190947332.03842567560923;
	Tue, 6 Jan 2026 04:06:30 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Jan Kara <jack@suse.cz>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH] ext4: fast commit: make s_fc_lock reclaim-safe
Date: Tue,  6 Jan 2026 20:06:21 +0800
Message-ID: <20260106120621.440126-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

s_fc_lock can be acquired from inode eviction and thus is
reclaim unsafe. Since the fast commit path holds s_fc_lock while writing
the commit log, allocations under the lock can enter reclaim and invert
the lock order with fs_reclaim. Add ext4_fc_lock()/ext4_fc_unlock()
helpers which acquire s_fc_lock under memalloc_nofs_save()/restore()
context and use them everywhere so allocations under the lock cannot
recurse into filesystem reclaim.

Fixes: 6593714d67ba ("ext4: hold s_fc_lock while during fast commit")
Signed-off-by: Li Chen <me@linux.beauty>
---

RFC->v1:  create helper functions for acquiring / releasing the lock as suggested by Jan Kara.

RFC: https://patchwork.ozlabs.org/project/linux-ext4/patch/20251223131342.287864-1-me@linux.beauty/

 fs/ext4/ext4.h        | 16 ++++++++++++++
 fs/ext4/fast_commit.c | 51 ++++++++++++++++++++++++-------------------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57087da6c7be..933297251f66 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1771,6 +1771,10 @@ struct ext4_sb_info {
 	 * Main fast commit lock. This lock protects accesses to the
 	 * following fields:
 	 * ei->i_fc_list, s_fc_dentry_q, s_fc_q, s_fc_bytes, s_fc_bh.
+	 *
+	 * s_fc_lock can be taken from reclaim context (inode eviction) and is
+	 * thus reclaim unsafe. Use ext4_fc_lock()/ext4_fc_unlock() helpers
+	 * when acquiring / releasing the lock.
 	 */
 	struct mutex s_fc_lock;
 	struct buffer_head *s_fc_bh;
@@ -1815,6 +1819,18 @@ static inline void ext4_writepages_up_write(struct super_block *sb, int ctx)
 	percpu_up_write(&EXT4_SB(sb)->s_writepages_rwsem);
 }
 
+static inline int ext4_fc_lock(struct super_block *sb)
+{
+	mutex_lock(&EXT4_SB(sb)->s_fc_lock);
+	return memalloc_nofs_save();
+}
+
+static inline void ext4_fc_unlock(struct super_block *sb, int ctx)
+{
+	memalloc_nofs_restore(ctx);
+	mutex_unlock(&EXT4_SB(sb)->s_fc_lock);
+}
+
 static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 {
 	return ino == EXT4_ROOT_INO ||
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5727ff4e9273..2f28a089fc7e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -231,16 +231,16 @@ static bool ext4_fc_disabled(struct super_block *sb)
 void ext4_fc_del(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_fc_dentry_update *fc_dentry;
 	wait_queue_head_t *wq;
+	int alloc_ctx;
 
 	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(inode->i_sb);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
-		mutex_unlock(&sbi->s_fc_lock);
+		ext4_fc_unlock(inode->i_sb, alloc_ctx);
 		return;
 	}
 
@@ -275,9 +275,9 @@ void ext4_fc_del(struct inode *inode)
 #endif
 		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 		if (ext4_test_inode_state(inode, EXT4_STATE_FC_FLUSHING_DATA)) {
-			mutex_unlock(&sbi->s_fc_lock);
+			ext4_fc_unlock(inode->i_sb, alloc_ctx);
 			schedule();
-			mutex_lock(&sbi->s_fc_lock);
+			alloc_ctx = ext4_fc_lock(inode->i_sb);
 		}
 		finish_wait(wq, &wait.wq_entry);
 	}
@@ -288,7 +288,7 @@ void ext4_fc_del(struct inode *inode)
 	 * dentry create references, since it is not needed to log it anyways.
 	 */
 	if (list_empty(&ei->i_fc_dilist)) {
-		mutex_unlock(&sbi->s_fc_lock);
+		ext4_fc_unlock(inode->i_sb, alloc_ctx);
 		return;
 	}
 
@@ -298,7 +298,7 @@ void ext4_fc_del(struct inode *inode)
 	list_del_init(&fc_dentry->fcd_dilist);
 
 	WARN_ON(!list_empty(&ei->i_fc_dilist));
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(inode->i_sb, alloc_ctx);
 
 	release_dentry_name_snapshot(&fc_dentry->fcd_name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
@@ -315,6 +315,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 	tid_t tid;
 	bool has_transaction = true;
 	bool is_ineligible;
+	int alloc_ctx;
 
 	if (ext4_fc_disabled(sb))
 		return;
@@ -329,12 +330,12 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 			has_transaction = false;
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(sb);
 	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	if (has_transaction && (!is_ineligible || tid_gt(tid, sbi->s_fc_ineligible_tid)))
 		sbi->s_fc_ineligible_tid = tid;
 	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(sb, alloc_ctx);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
@@ -358,6 +359,7 @@ static int ext4_fc_track_template(
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	tid_t tid = 0;
+	int alloc_ctx;
 	int ret;
 
 	tid = handle->h_transaction->t_tid;
@@ -373,14 +375,14 @@ static int ext4_fc_track_template(
 	if (!enqueue)
 		return ret;
 
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(inode->i_sb);
 	if (list_empty(&EXT4_I(inode)->i_fc_list))
 		list_add_tail(&EXT4_I(inode)->i_fc_list,
 				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
 				&sbi->s_fc_q[FC_Q_STAGING] :
 				&sbi->s_fc_q[FC_Q_MAIN]);
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(inode->i_sb, alloc_ctx);
 
 	return ret;
 }
@@ -402,6 +404,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	struct inode *dir = dentry->d_parent->d_inode;
 	struct super_block *sb = inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int alloc_ctx;
 
 	spin_unlock(&ei->i_fc_lock);
 
@@ -425,7 +428,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	take_dentry_name_snapshot(&node->fcd_name, dentry);
 	INIT_LIST_HEAD(&node->fcd_dilist);
 	INIT_LIST_HEAD(&node->fcd_list);
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(sb);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
 		list_add_tail(&node->fcd_list,
@@ -446,7 +449,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 		WARN_ON(!list_empty(&ei->i_fc_dilist));
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(sb, alloc_ctx);
 	spin_lock(&ei->i_fc_lock);
 
 	return 0;
@@ -1051,18 +1054,19 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	struct blk_plug plug;
 	int ret = 0;
 	u32 crc = 0;
+	int alloc_ctx;
 
 	/*
 	 * Step 1: Mark all inodes on s_fc_q[MAIN] with
 	 * EXT4_STATE_FC_FLUSHING_DATA. This prevents these inodes from being
 	 * freed until the data flush is over.
 	 */
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(sb);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&iter->vfs_inode,
 				     EXT4_STATE_FC_FLUSHING_DATA);
 	}
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(sb, alloc_ctx);
 
 	/* Step 2: Flush data for all the eligible inodes. */
 	ret = ext4_fc_flush_data(journal);
@@ -1072,7 +1076,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * any error from step 2. This ensures that waiters waiting on
 	 * EXT4_STATE_FC_FLUSHING_DATA can resume.
 	 */
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(sb);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_FLUSHING_DATA);
@@ -1089,7 +1093,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * prepare_to_wait() in ext4_fc_del().
 	 */
 	smp_mb();
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(sb, alloc_ctx);
 
 	/*
 	 * If we encountered error in Step 2, return it now after clearing
@@ -1106,12 +1110,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * previous handles are now drained. We now mark the inodes on the
 	 * commit queue as being committed.
 	 */
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(sb);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&iter->vfs_inode,
 				     EXT4_STATE_FC_COMMITTING);
 	}
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(sb, alloc_ctx);
 	jbd2_journal_unlock_updates(journal);
 
 	/*
@@ -1122,6 +1126,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		blkdev_issue_flush(journal->j_fs_dev);
 
 	blk_start_plug(&plug);
+	alloc_ctx = ext4_fc_lock(sb);
 	/* Step 6: Write fast commit blocks to disk. */
 	if (sbi->s_fc_bytes == 0) {
 		/*
@@ -1139,7 +1144,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	}
 
 	/* Step 6.2: Now write all the dentry updates. */
-	mutex_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
 	if (ret)
 		goto out;
@@ -1161,7 +1165,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	ret = ext4_fc_write_tail(sb, crc);
 
 out:
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(sb, alloc_ctx);
 	blk_finish_plug(&plug);
 	return ret;
 }
@@ -1295,6 +1299,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *ei;
 	struct ext4_fc_dentry_update *fc_dentry;
+	int alloc_ctx;
 
 	if (full && sbi->s_fc_bh)
 		sbi->s_fc_bh = NULL;
@@ -1302,7 +1307,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	trace_ext4_fc_cleanup(journal, full, tid);
 	jbd2_fc_release_bufs(journal);
 
-	mutex_lock(&sbi->s_fc_lock);
+	alloc_ctx = ext4_fc_lock(sb);
 	while (!list_empty(&sbi->s_fc_q[FC_Q_MAIN])) {
 		ei = list_first_entry(&sbi->s_fc_q[FC_Q_MAIN],
 					struct ext4_inode_info,
@@ -1361,7 +1366,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 
 	if (full)
 		sbi->s_fc_bytes = 0;
-	mutex_unlock(&sbi->s_fc_lock);
+	ext4_fc_unlock(sb, alloc_ctx);
 	trace_ext4_fc_stats(sb);
 }
 
-- 
2.52.0


