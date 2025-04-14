Return-Path: <linux-ext4+bounces-7244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5085A88911
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34EB16CDA5
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A6289354;
	Mon, 14 Apr 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbTi7yNp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41C18AE2
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649689; cv=none; b=KlxGT/LOpKc5mFqtrpavyW3PzbeW4tltQtm3/p91VjW/ts9RzBbG8Su0lKoFqRR1XyO+iylchKpGQkVAQMcBepD4Yd0+dmM+ny6fg+BujOIDY1/jSA4gA1DfR7T8xurBK9rguqy49AVFrLxiQkB+rpTLcc8+tYSVPLsz2ek0p28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649689; c=relaxed/simple;
	bh=rgtz9r02EonuOsYm5OmWCKww+GWfiiFp2IAkZTa8wHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvQI8VwRTv9pWhlYRAu0gtAhKHPVcuKwGnV1H2+feHtzHjfxM/VKmFwIa5uw3JmyX0vr8CCsizJfBPtyXAJu5e3yj5bSxWoMyY1T8gwFm52Vi37Ijf8bYPEKBQxLYXLyzY3Ozos2GIB87RBfE2C8DpwcU2HgxKl+Sd2Yl2O5a9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbTi7yNp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b09c090c97eso517028a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649686; x=1745254486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvIY6vgCu8OjQhmGIuLEYkEXGrHwyRlF3xEVbDJNQJI=;
        b=dbTi7yNp1Kfn54E+41cT057SUiDFr8Qr4lu4bOgs3JNd0PUXwIc2Ks3tYdDaV3tsUI
         09kn87nHhbhqwxRvA6kL4uuAQtcaz1x+9seXQKZkOTFhXtGEzpu2USJCnfPBwXeRhJT3
         01j9mSwwokyx6G7PI/iuC16VCVtQhbrvlW9+S0HGJbLolTSdBFRECdpHFXRXIewJ0Gl3
         MpJlgYeb/q2igRmCdvjY/tjSt+FYws4/v8YVOlEXS6XmpYblZQ59vffBM2zI+Y11qctC
         jGoE9aE/XlqXEfNoySiCYAiwcYTF0/bZAfqncWTbaE4+Gnd1rvMKOH9Qzy1eBvyuamft
         yDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649686; x=1745254486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvIY6vgCu8OjQhmGIuLEYkEXGrHwyRlF3xEVbDJNQJI=;
        b=nzsKWU7I9jcJTnlrsUrbJjubLYYJAyLKxGv/0E0vKwbn4o9NO9cJlDEp2WIariYojT
         1SaHjQ75L8U9AtdFLjTXrq9XvPu7ndT+UcYrLo1IoaPm30C9r4OQYff+JAmtUpDO8J4M
         wUHHnuyafIJdkk3EZXMxgKlaXhtdi6zU9EVO4gUR1mx1Ng9sVM3TvuDXzz5TfFyxv0x0
         hfAkdOwg5rOz9cuJnnPlAT+qNdFYE+EvtOMfVQLmUDDrKBlp/h0IykERlKwPHm5UX4nw
         iihfwtbDuPdWOnhD2VkW8ATWf09s4j/EGdiMGGrDm81rkF5zCVJYzYhifPXdRMFgyFaC
         I6Hg==
X-Gm-Message-State: AOJu0Yzl+NXagKZJ6nYM/CvOqxrkB+yecQjPvnX0srL2wliugb0jv5vq
	ldUQ5RQYC34HFMe0Ru4S3OxsO/uWSZJ4GE+bI3YVMN06WrLGiuwTRnpMmbUHLQk=
X-Gm-Gg: ASbGnctR3rYPsMfcpG5GXUgQXxzx1kMFV6DC5XyQtMuxAO71vDlEV9WcqBsN9hMUSvt
	eRLQPZqQadcD+fzgMGr2bavQ4Ni/tNxl/DhNQ6aqR3WGvUnOPrDYGTDzP00Ek7JZKdTeVMxWPzx
	E/INcY+jCwmjp7UxMxPRox7MzESl+JTBQ8wAPA8HsInJgszqwIUBzWaSKFX4IOVxrNdQK4XVwVu
	qIQfnXUy9g8XePaEQbLTWeHsyKXR2beemyPAMb6mChQw+2xdtSklT/TPpVfF4t/tZE6xhNHDrk2
	tdI8eCaM4EaCmK4ybqR5cxzIilOm2wnYvUwvAjlK3wLfVlccwfrB1kubUyeXhyYTD21vGejhNvf
	+ZMnFIyvqWPh0pc00JIFA4t/S0DkPBvObfA==
X-Google-Smtp-Source: AGHT+IE8q252/zVPdx1XBgGVVMvU7v+JqpsEC9O+66It/NGQykLN+7Sdww8SZ7ksB3wSXCcl1bgO0A==
X-Received: by 2002:a17:90b:3850:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-3082377bff7mr20986568a91.10.1744649686067;
        Mon, 14 Apr 2025 09:54:46 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:45 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 4/9] ext4: rework fast commit commit path
Date: Mon, 14 Apr 2025 16:54:11 +0000
Message-ID: <20250414165416.1404856-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
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

Change since last review:

I have updated the ext4_fc_cleanup() to make it more readable. Could
you please take a look at it again?

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>

merge with rework
---
 fs/ext4/fast_commit.c | 94 +++++++++++++++++++++++++++----------------
 fs/jbd2/journal.c     |  2 -
 2 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index c4d3c71d5e6c..126df97944c0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -291,20 +291,30 @@ void ext4_fc_del(struct inode *inode)
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
@@ -325,8 +335,6 @@ void ext4_fc_del(struct inode *inode)
 
 	release_dentry_name_snapshot(&fc_dentry->fcd_name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-
-	return;
 }
 
 /*
@@ -998,19 +1006,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
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
@@ -1123,6 +1118,19 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1173,6 +1181,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1298,7 +1318,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_inode_info *iter, *iter_n;
+	struct ext4_inode_info *ei;
 	struct ext4_fc_dentry_update *fc_dentry;
 
 	if (full && sbi->s_fc_bh)
@@ -1308,13 +1328,15 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
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
@@ -1325,15 +1347,19 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
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
index a5ccba25ff47..82004a3439b4 100644
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
2.49.0.604.gff1f9ca942-goog


