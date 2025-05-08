Return-Path: <linux-ext4+bounces-7774-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BA0AB01F7
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 20:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA44C0A6F
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866F2874E1;
	Thu,  8 May 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrgt9fuD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57C286D5D
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727178; cv=none; b=XH0ffGeF2DlVkTZXbyOVTIIrMfyDH6DMcBReRoKx+90HSW+CtIQBfX60/WtZP9R+rF1cJw0pysohm18ngDZE5eTvluPCSGBfvx0eQyoLzSmL5Tts1V+Af2oudkx1xieFS/pYOMT2TMQQarVLqOWjFZ62buXZqLeYJR18RvpwW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727178; c=relaxed/simple;
	bh=fjFst4/ZwL9utROtErveJRaLhk2doxUaI3n4DjL/ivU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oft7NZQBnxJ+L/8qBk6iqn7f+zFSgnP+g5aq+r6mudUud9DsZ6DZOCOUPd6kW+YffzFOMRhHuv7vHQo8PFaIPl+lOIVstaUEts1GVtMV8tiNs+NgaUlq05M/ByiQ30NPmP3oHxeLfahBoU/um7LMmIDylyGpxiXTNQXoyVemt8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrgt9fuD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af5085f7861so862448a12.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727174; x=1747331974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87uznKkkSVtzO9DIjK4jjC6UUt+uP7TU1rrta1GizHs=;
        b=Yrgt9fuDpF2KqX5UMFbRVevxju0GhW+frxDFe+/4ZOtRrkWLxtE/P4LLN6jqT84hsj
         DuzeOniWjOosZtLyuHuq/YmFgcpdXnEboAVAmYVCoqE9xhhtVThlxlMbdRm0+Q7ElxYO
         Ux6ZmlO9xtLMAJcC9bBscob1xns96ahuw+sKW7oXx1dDS2WwnOt26l3UtP/f6oik0PnI
         OQfxxkfUeLXV5UPeb1tRMXh4LDpu19WhBkBJQ1Yl4gjPE5hGq9U6/8FnKIwKTVKIJl7I
         zgYDDOyoFvZ2e/y9eUTvC5bXzK/F9i5p62g/bLaKSvTufoNuA3X/5iyuk9MgTNrY2x2f
         ANXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727174; x=1747331974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87uznKkkSVtzO9DIjK4jjC6UUt+uP7TU1rrta1GizHs=;
        b=T3aMeMuzqAdh/8EomC4LKd4mpctd/Tufg3G9N8hOUOgU1BeDaXuw9uaLjcPKjbu/ES
         20Po7M8+zNARdFShe1Klcu7wY7BwuwrLh/nXtesGr39QpTvnozYLJwC3rHjN2Bk3K8OQ
         xQIlAmzFJUuNHbOi7RWpkPPxuH9zr8FrW17S1mTzywOufPy5RIUPAC9ep+6ydf3qeskk
         5OA0n+PaJ/5LFo6+nvLMq+G6sBsCuSLL93Kt69iqYrPDnKz08k1woAwoCOtJlpUYBICe
         qTzRMXCXskVL63yzrezVKbt+8Hf5su/FB2fdTkIz9/4W/tpKXr11lOXre3bi76ASnTd+
         g72Q==
X-Gm-Message-State: AOJu0Yy/80Y/L4M/5ZQDm+nhubfFgxJO7vu5vfXek6rBJpzP0erI2SwS
	PDoyfBbzjhSVj4ksJK9cEzfCaKL8X1+R4rRqXM75GBDH+nOvvXt45UVkrnt7S3Q=
X-Gm-Gg: ASbGncsVmiAGenouNx3diJhDaDJkoM9h7JcIFUykn7Wp2odtVut64yswTZvh266aweC
	sgKCHCYT9eBIuHrU7AxLRymPXUZff8KydIJR+TUk2r9/aVN0Pa9Es1fuEO5mCzmfFLtkNJLAsGA
	0pAvC+Sh87ewUE1APqFJiOCB4n0ckuO9EAq11HMusZiUAQK7j1sLEVnm5OH7y+OBkSKAkFCIQO8
	6cRk22aGPXXC2mj+5ZvfVqpfSiIquE/HsTaTJoLaLtU6mHOvOcieHAXJN5/mWAAHJBFwHvyEeBt
	a9HUf8dg5oDWnJhSPf5VbMUBsx3ANWtaMZ8R+hbPx6HUTU3nBYas9NYAvpSD4kLDUTjoXuz8Lsc
	pP4YaHKO5SMcXh5wlyTdBQykghnlF+4xdFvMM
X-Google-Smtp-Source: AGHT+IHf1Q7bXbhKMwLLNIMainBv2H17O3A0Xag7tx4ObSvyL1fej9B1eeyrjDt4cch7XBXdQSzLMg==
X-Received: by 2002:a17:903:1a2c:b0:224:c47:cb7 with SMTP id d9443c01a7336-22fc894ed3amr5356305ad.0.1746727174334;
        Thu, 08 May 2025 10:59:34 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:33 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 4/9] ext4: rework fast commit commit path
Date: Thu,  8 May 2025 17:59:03 +0000
Message-ID: <20250508175908.1004880-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reworks fast commit's commit path to remove locking the
journal for the entire duration of a fast commit. Instead, we only lock
the journal while marking all the eligible inodes as "committing". This
allows handles to make progress in parallel with the fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |   1 +
 fs/ext4/fast_commit.c | 199 ++++++++++++++++++++++++++----------------
 fs/jbd2/journal.c     |   2 -
 3 files changed, 126 insertions(+), 76 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 79dfb57a7..493d9ac7a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1916,6 +1916,7 @@ enum {
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
+	EXT4_STATE_FC_FLUSHING_DATA,	/* Fast commit flushing data */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
 };
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index c4d3c71d5..a2cb4d965 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -287,24 +287,55 @@ void ext4_fc_del(struct inode *inode)
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_fc_dentry_update *fc_dentry;
+	wait_queue_head_t *wq;
 
 	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
-restart:
 	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
 		spin_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
-	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		ext4_fc_wait_committing_inode(inode);
-		goto restart;
+	/*
+	 * Since ext4_fc_del is called from ext4_evict_inode while having a
+	 * handle open, there is no need for us to wait here even if a fast
+	 * commit is going on. That is because, if this inode is being
+	 * committed, ext4_mark_inode_dirty would have waited for inode commit
+	 * operation to finish before we come here. So, by the time we come
+	 * here, inode's EXT4_STATE_FC_COMMITTING would have been cleared. So,
+	 * we shouldn't see EXT4_STATE_FC_COMMITTING to be set on this inode
+	 * here.
+	 *
+	 * We may come here without any handles open in the "no_delete" case of
+	 * ext4_evict_inode as well. However, if that happens, we first mark the
+	 * file system as fast commit ineligible anyway. So, even in that case,
+	 * it is okay to remove the inode from the fc list.
+	 */
+	WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)
+		&& !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE));
+	while (ext4_test_inode_state(inode, EXT4_STATE_FC_FLUSHING_DATA)) {
+#if (BITS_PER_LONG < 64)
+		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+				EXT4_STATE_FC_FLUSHING_DATA);
+		wq = bit_waitqueue(&ei->i_state_flags,
+				   EXT4_STATE_FC_FLUSHING_DATA);
+#else
+		DEFINE_WAIT_BIT(wait, &ei->i_flags,
+				EXT4_STATE_FC_FLUSHING_DATA);
+		wq = bit_waitqueue(&ei->i_flags,
+				   EXT4_STATE_FC_FLUSHING_DATA);
+#endif
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_FLUSHING_DATA)) {
+			spin_unlock(&sbi->s_fc_lock);
+			schedule();
+			spin_lock(&sbi->s_fc_lock);
+		}
+		finish_wait(wq, &wait.wq_entry);
 	}
-
-	if (!list_empty(&ei->i_fc_list))
-		list_del_init(&ei->i_fc_list);
+	list_del_init(&ei->i_fc_list);
 
 	/*
 	 * Since this inode is getting removed, let's also remove all FC
@@ -325,8 +356,6 @@ void ext4_fc_del(struct inode *inode)
 
 	release_dentry_name_snapshot(&fc_dentry->fcd_name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-
-	return;
 }
 
 /*
@@ -590,9 +619,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
 		return;
 
-	if (!list_empty(&ei->i_fc_list))
-		return;
-
 	/*
 	 * If we come here, we may sleep while waiting for the inode to
 	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
@@ -988,61 +1014,25 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 }
 
 
-/* Submit data for all the fast commit inodes */
-static int ext4_fc_submit_inode_data_all(journal_t *journal)
+/* Flushes data of all the inodes in the commit queue. */
+static int ext4_fc_flush_data(journal_t *journal)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *ei;
 	int ret = 0;
 
-	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
-		while (atomic_read(&ei->i_fc_updates)) {
-			DEFINE_WAIT(wait);
-
-			prepare_to_wait(&ei->i_fc_wait, &wait,
-						TASK_UNINTERRUPTIBLE);
-			if (atomic_read(&ei->i_fc_updates)) {
-				spin_unlock(&sbi->s_fc_lock);
-				schedule();
-				spin_lock(&sbi->s_fc_lock);
-			}
-			finish_wait(&ei->i_fc_wait, &wait);
-		}
-		spin_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(journal, ei->jinode);
 		if (ret)
 			return ret;
-		spin_lock(&sbi->s_fc_lock);
 	}
-	spin_unlock(&sbi->s_fc_lock);
-
-	return ret;
-}
-
-/* Wait for completion of data for all the fast commit inodes */
-static int ext4_fc_wait_inode_data_all(journal_t *journal)
-{
-	struct super_block *sb = journal->j_private;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_inode_info *pos, *n;
-	int ret = 0;
 
-	spin_lock(&sbi->s_fc_lock);
-	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		if (!ext4_test_inode_state(&pos->vfs_inode,
-					   EXT4_STATE_FC_COMMITTING))
-			continue;
-		spin_unlock(&sbi->s_fc_lock);
-
-		ret = jbd2_wait_inode_data(journal, pos->jinode);
+	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		ret = jbd2_wait_inode_data(journal, ei->jinode);
 		if (ret)
 			return ret;
-		spin_lock(&sbi->s_fc_lock);
 	}
-	spin_unlock(&sbi->s_fc_lock);
 
 	return 0;
 }
@@ -1123,26 +1113,81 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	int ret = 0;
 	u32 crc = 0;
 
-	ret = ext4_fc_submit_inode_data_all(journal);
-	if (ret)
-		return ret;
+	/*
+	 * Step 1: Mark all inodes on s_fc_q[MAIN] with
+	 * EXT4_STATE_FC_FLUSHING_DATA. This prevents these inodes from being
+	 * freed until the data flush is over.
+	 */
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		ext4_set_inode_state(&iter->vfs_inode,
+				     EXT4_STATE_FC_FLUSHING_DATA);
+	}
+	spin_unlock(&sbi->s_fc_lock);
+
+	/* Step 2: Flush data for all the eligible inodes. */
+	ret = ext4_fc_flush_data(journal);
 
-	ret = ext4_fc_wait_inode_data_all(journal);
+	/*
+	 * Step 3: Clear EXT4_STATE_FC_FLUSHING_DATA flag, before returning
+	 * any error from step 2. This ensures that waiters waiting on
+	 * EXT4_STATE_FC_FLUSHING_DATA can resume.
+	 */
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		ext4_clear_inode_state(&iter->vfs_inode,
+				       EXT4_STATE_FC_FLUSHING_DATA);
+#if (BITS_PER_LONG < 64)
+		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_FLUSHING_DATA);
+#else
+		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_FLUSHING_DATA);
+#endif
+	}
+
+	/*
+	 * Make sure clearing of EXT4_STATE_FC_FLUSHING_DATA is visible before
+	 * the waiter checks the bit. Pairs with implicit barrier in
+	 * prepare_to_wait() in ext4_fc_del().
+	 */
+	smp_mb();
+	spin_unlock(&sbi->s_fc_lock);
+
+	/*
+	 * If we encountered error in Step 2, return it now after clearing
+	 * EXT4_STATE_FC_FLUSHING_DATA bit.
+	 */
 	if (ret)
 		return ret;
 
+
+	/* Step 4: Mark all inodes as being committed. */
+	jbd2_journal_lock_updates(journal);
 	/*
-	 * If file system device is different from journal device, issue a cache
-	 * flush before we start writing fast commit blocks.
+	 * The journal is now locked. No more handles can start and all the
+	 * previous handles are now drained. We now mark the inodes on the
+	 * commit queue as being committed.
+	 */
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		ext4_set_inode_state(&iter->vfs_inode,
+				     EXT4_STATE_FC_COMMITTING);
+	}
+	spin_unlock(&sbi->s_fc_lock);
+	jbd2_journal_unlock_updates(journal);
+
+	/*
+	 * Step 5: If file system device is different from journal device,
+	 * issue a cache flush before we start writing fast commit blocks.
 	 */
 	if (journal->j_fs_dev != journal->j_dev)
 		blkdev_issue_flush(journal->j_fs_dev);
 
 	blk_start_plug(&plug);
+	/* Step 6: Write fast commit blocks to disk. */
 	if (sbi->s_fc_bytes == 0) {
 		/*
-		 * Add a head tag only if this is the first fast commit
-		 * in this TID.
+		 * Step 6.1: Add a head tag only if this is the first fast
+		 * commit in this TID.
 		 */
 		head.fc_features = cpu_to_le32(EXT4_FC_SUPPORTED_FEATURES);
 		head.fc_tid = cpu_to_le32(
@@ -1154,6 +1199,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		}
 	}
 
+	/* Step 6.2: Now write all the dentry updates. */
 	spin_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
 	if (ret) {
@@ -1161,6 +1207,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		goto out;
 	}
 
+	/* Step 6.3: Now write all the changed inodes to disk. */
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		inode = &iter->vfs_inode;
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
@@ -1173,10 +1220,8 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		ret = ext4_fc_write_inode(inode, &crc);
 		if (ret)
 			goto out;
-		spin_lock(&sbi->s_fc_lock);
 	}
-	spin_unlock(&sbi->s_fc_lock);
-
+	/* Step 6.4: Finally write tail tag to conclude this fast commit. */
 	ret = ext4_fc_write_tail(sb, crc);
 
 out:
@@ -1298,7 +1343,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_inode_info *iter, *iter_n;
+	struct ext4_inode_info *ei;
 	struct ext4_fc_dentry_update *fc_dentry;
 
 	if (full && sbi->s_fc_bh)
@@ -1308,13 +1353,15 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	jbd2_fc_release_bufs(journal);
 
 	spin_lock(&sbi->s_fc_lock);
-	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
-				 i_fc_list) {
-		list_del_init(&iter->i_fc_list);
-		ext4_clear_inode_state(&iter->vfs_inode,
+	while (!list_empty(&sbi->s_fc_q[FC_Q_MAIN])) {
+		ei = list_first_entry(&sbi->s_fc_q[FC_Q_MAIN],
+					struct ext4_inode_info,
+					i_fc_list);
+		list_del_init(&ei->i_fc_list);
+		ext4_clear_inode_state(&ei->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (tid_geq(tid, iter->i_sync_tid)) {
-			ext4_fc_reset_inode(&iter->vfs_inode);
+		if (tid_geq(tid, ei->i_sync_tid)) {
+			ext4_fc_reset_inode(&ei->vfs_inode);
 		} else if (full) {
 			/*
 			 * We are called after a full commit, inode has been
@@ -1325,15 +1372,19 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 			 * time in that case (and tid doesn't increase so
 			 * tid check above isn't reliable).
 			 */
-			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+			list_add_tail(&ei->i_fc_list,
 				      &sbi->s_fc_q[FC_Q_STAGING]);
 		}
-		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
+		/*
+		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
+		 * visible before we send the wakeup. Pairs with implicit
+		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
+		 */
 		smp_mb();
 #if (BITS_PER_LONG < 64)
-		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
+		wake_up_bit(&ei->i_state_flags, EXT4_STATE_FC_COMMITTING);
 #else
-		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
+		wake_up_bit(&ei->i_flags, EXT4_STATE_FC_COMMITTING);
 #endif
 	}
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 743a1d763..bfaa14bb1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -728,7 +728,6 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
-	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -742,7 +741,6 @@ static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
-	jbd2_journal_unlock_updates(journal);
 	write_lock(&journal->j_state_lock);
 	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	if (fallback)
-- 
2.49.0.1045.g170613ef41-goog


