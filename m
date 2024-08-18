Return-Path: <linux-ext4+bounces-3763-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68D3955ABC
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5622820A7
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F291CA64;
	Sun, 18 Aug 2024 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvUeUa5g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC9BE5E
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953861; cv=none; b=sTnx4FvXgK/ZpuM5opv/pSU9Cg1cAVBl0rwsX3Y+gqr+1jNNM4ZJ5fVCnywVasMJ4Xj6wrO2uMiXa4KK4j4sI4vIfGebda8p0D+SxYW+mBK6ZctHqHHTjv5KRFKWzGKMLCezrzVOcvduKLzFIPzdDIpCgb6ovsmHg35txxYFAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953861; c=relaxed/simple;
	bh=ZRH45/GbA/wj8spu6apiE/dpMkPI/4DyKU/COyP6xi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5MG7XS3eWf5cDiEDmb9Y5GQZyzGFnL0xPnmEFLj7r52fXKtV824UHlhcUMMOPpYpIb7Bvn5nKcI/sg3/FYLHZmDCMvr58+SMRKQ+/YJa2jeGv9y1yygISmHYWtEaAL0npuaKEwl5k5r7EwPwv3Ufy6MJpjSPSqZF8dyhBhk0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvUeUa5g; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20203988f37so19579275ad.1
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953859; x=1724558659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8we5Y9yOsqQhHQ7ujgA8sVjbv7NEZ4a8pm6eVEQ6OPo=;
        b=dvUeUa5gru4LWSdIJuYV7s9wUE4mMxrXTGIhfcbiFMj3IMGo81kMvdCeVl7g469NFd
         Bd/cLZdDzPLShOFxkY4ROOovhL5l+9fEKG3EMrboZdnmp7QfOlTt5Sdyahh4dtD4G+PP
         d7E/PNKoB72ScvCBOOnA9Itfb3WyFZl0X4ZAOsRgp5C/mAyxPVVqGM18KT132n+ywWoP
         sUTzJPUmLF3KUDtOyicNa/30ZBhxzXcTAxL6Nt4/SXVaNtCYtEiC2VOIajGr/fYYBLGR
         caFmooReWwjprPS0EUmSVFDZafe82mKXalY2ljUtydviUmMaTfAN8WerYQhiMcet9z53
         jnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953859; x=1724558659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8we5Y9yOsqQhHQ7ujgA8sVjbv7NEZ4a8pm6eVEQ6OPo=;
        b=bd9Szdnb6CaUhUniBe+MYADoKIQgnBGcHsOmVaafFX/fOzZL3iamM2DeD1GC8Kb24J
         hK/gmvNQ9NocdA3iEnbHsImKUXsIoYqxjhZUDe9kS09sKPoCJcuBpDnEZlDnWOeDklUI
         q23OfTg+q5Rz20xdyqSlDDXU4Hw/7iq7e4LTFDc3ZC/2z74KGmeyPfBG4sAKPPjDjXKt
         bY1BpX1q9gDFxtw/Hz0EZPuFWTgCH21X+UkoRaDZ9XThdsNFgMBGlprTKau1ptQwIgVn
         jh9C7ijbckDKAJ8dl/86LbOr9CU0BzcW42ER3dYo4jI0+vJmqSLxujd0/zMm46yYB61A
         PYYw==
X-Gm-Message-State: AOJu0YwGAiy96M7YHbXqtpqrieaeGo8vcjkQmro+abXSvLnHQnOYA5VE
	2lVZr7Pd8ry2xwFrGteFcFcdEIxKzjd/+y4jBehU82PMYUL5fEEM5R4vCxEYOEE=
X-Google-Smtp-Source: AGHT+IHzMAqv9o2HwfR0uj/nhEfBfVkiqxfOzFtGu+oqrcykjz3YTmK3B7GHO5b35KaGy3THZBwHNQ==
X-Received: by 2002:a17:903:2307:b0:1fd:d4c7:dc5 with SMTP id d9443c01a7336-20203e4f84cmr95597475ad.11.1723953859105;
        Sat, 17 Aug 2024 21:04:19 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:18 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 4/9] ext4: rework fast commit commit path
Date: Sun, 18 Aug 2024 04:03:51 +0000
Message-ID: <20240818040356.241684-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/fast_commit.c | 74 ++++++++++++++++++++++++++++---------------
 fs/jbd2/journal.c     |  2 --
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index dfa999913..7a35234ce 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -291,20 +291,30 @@ void ext4_fc_del(struct inode *inode)
 	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
-restart:
 	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
 		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 		return;
 	}
 
-	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		ext4_fc_wait_committing_inode(inode);
-		goto restart;
-	}
-
-	if (!list_empty(&ei->i_fc_list))
-		list_del_init(&ei->i_fc_list);
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
+	list_del_init(&ei->i_fc_list);
 
 	/*
 	 * Since this inode is getting removed, let's also remove all FC
@@ -327,8 +337,6 @@ void ext4_fc_del(struct inode *inode)
 		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
 		kfree(fc_dentry->fcd_name.name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-
-	return;
 }
 
 /*
@@ -1004,19 +1012,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
 	spin_lock(&sbi->s_fc_lock);
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
 		spin_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(journal, ei->jinode);
 		if (ret)
@@ -1129,6 +1124,19 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	int ret = 0;
 	u32 crc = 0;
 
+	/*
+	 * Wait for all the handles of the current transaction to complete
+	 * and then lock the journal.
+	 */
+	jbd2_journal_lock_updates(journal);
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		ext4_set_inode_state(&iter->vfs_inode,
+				     EXT4_STATE_FC_COMMITTING);
+	}
+	spin_unlock(&sbi->s_fc_lock);
+	jbd2_journal_unlock_updates(journal);
+
 	ret = ext4_fc_submit_inode_data_all(journal);
 	if (ret)
 		return ret;
@@ -1179,6 +1187,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		ret = ext4_fc_write_inode(inode, &crc);
 		if (ret)
 			goto out;
+		ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
+		/*
+		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
+		 * visible before we send the wakeup. Pairs with implicit
+		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
+		 */
+		smp_mb();
+#if (BITS_PER_LONG < 64)
+		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
+#else
+		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
+#endif
 		spin_lock(&sbi->s_fc_lock);
 	}
 	spin_unlock(&sbi->s_fc_lock);
@@ -1316,13 +1336,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
-		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
 		if (tid_geq(tid, iter->i_sync_tid))
 			ext4_fc_reset_inode(&iter->vfs_inode);
-		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
+		/*
+		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
+		 * visible before we send the wakeup. Pairs with implicit
+		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
+		 */
 		smp_mb();
+		list_del_init(&iter->i_fc_list);
 #if (BITS_PER_LONG < 64)
 		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
 #else
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1ebf2393b..ecd70b506 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -728,7 +728,6 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
-	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -740,7 +739,6 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
-	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);
-- 
2.46.0.184.g6999bdac58-goog


