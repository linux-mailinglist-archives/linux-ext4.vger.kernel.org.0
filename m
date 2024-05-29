Return-Path: <linux-ext4+bounces-2686-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F78D29DB
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EDE1C22431
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7870415AACA;
	Wed, 29 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+SK4L30"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D252B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945649; cv=none; b=Y9mFCTg4xhtmWmJgi3IhsRN2+ZtwYohtz66QW11eiO+gSDHO1TEUWhJLjG6xsdbIaTXciFDLQrH7BcBoAAmS/GH0wNf1ej9cK8Swy0+7TC/XbKfdZL6lCllhqukhhryM2fare2FZn76CxIWaKEh+pZroynwJH0K0tP1v0YmMqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945649; c=relaxed/simple;
	bh=H9H7TwY7QEtvysmUnwkRxxrHdFizlerwakv9M0DNQH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp6ljjMYokrYw3BStpYouTnhnuDVBQFOcDx7v7WnPvPVx6jIvd/HiULG1eWw+hHzoAD+la7552ePT5lANe1CIOS4mmHjxVcs0fOMBpMw6X/Hu99DdcBq74mdoyC6RGdzj2H27lgghHp0bCFBKrVx//uM+WL/DWFA+d4qnEZNtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+SK4L30; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-657a07878easo1291164a12.0
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945647; x=1717550447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KN0nAiO9ez93L/NVJUdKGcBM+CWxauy5ZWUl78F2fo=;
        b=O+SK4L30ZaBFBOajKzreS048PMWVfb1UdJnT63a53FRlCR984Me9mnf6d215WvH+P4
         tRB5zECTPswbg7OGrhw9Q13qeoLFS1//VbKos1Z8TeQxg1T4FdlsCP7KDtSObP1pULUZ
         BRvE5qlUqqLjCnTEMKtw9H1W1jMrOB3YA58ueWutAv53XmsRxlnETptFD3HOUA7eWcI6
         /v8TkUlEYUd77/9JauXauBVMOWQ8JrVGjwHp9/KSlwVdsyoYGKQKHl+4lGBAoHteb+SY
         fdf2u7+CB+3qenZZBnXD4CUs3ol4hxiomC/az6y1wIomYeARomvMjEeLtxXjpIjug/mU
         QL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945647; x=1717550447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KN0nAiO9ez93L/NVJUdKGcBM+CWxauy5ZWUl78F2fo=;
        b=W4MiH74K8L0dBtIaD8BTqkPPQYxQOWqCQYo7b+uunvecsTAR9o3foxJIB3JyhK3aAp
         9YHbJqif8oVzJ18k2H1d2+uZE3hdVUBR0dskPeSy3MPdh4eyLxg9/PJZt0cfTn9SfFI/
         Wa/xCh6MPlFSEHcUNbFrYSfsX9MYGcYChNdh79YXoiFPXPqU/RfrtetML/o6+dNhMnvD
         1OcZhS4rSfwXWJNpB6VekfcB11RkKQfZCCllmGJYq5nGkj+BG5N23kSBWRCM2gwsq3f+
         b+Xxljpzi1kbFQ+bx6+yMiDKpr9YdEHYi20UW6R3jWhrNn6Ckgj3x0pu+khzwBH5khkW
         ph2A==
X-Gm-Message-State: AOJu0YwyCjcJ6NAwBK69dYjUZ8067nFsuufth4Dw/oTZG+uHkmC4fJgE
	b7JCCIIOmxsZ4+ODpKRLAoXMiN7OPnuEO0h6Nt3nOaxjzBkiUDTHS6n6dZex
X-Google-Smtp-Source: AGHT+IG3TIeM7bG90Hl28kXJNIFnIxCO4OeIrROQcsA1/0Httr8NQjq6TK8elqpWezTXcekVm9EPeg==
X-Received: by 2002:a05:6a21:3417:b0:1ac:3b5d:a3eb with SMTP id adf61e73a8af0-1b212df0c63mr18391788637.39.1716945646514;
        Tue, 28 May 2024 18:20:46 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:46 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 04/10] ext4: rework fast commit commit path
Date: Wed, 29 May 2024 01:19:57 +0000
Message-ID: <20240529012003.4006535-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/fast_commit.c | 75 ++++++++++++++++++++++++++++---------------
 fs/jbd2/journal.c     |  3 +-
 fs/jbd2/transaction.c | 41 +++++++++++++++--------
 include/linux/jbd2.h  |  1 +
 4 files changed, 80 insertions(+), 40 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index fa93ce399440..3aca5b20aac5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -290,20 +290,30 @@ void ext4_fc_del(struct inode *inode)
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
@@ -326,8 +336,6 @@ void ext4_fc_del(struct inode *inode)
 		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
 		kfree(fc_dentry->fcd_name.name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-
-	return;
 }
 
 /*
@@ -999,19 +1007,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
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
@@ -1124,6 +1119,20 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	int ret = 0;
 	u32 crc = 0;
 
+	/*
+	 * Wait for all the handles of the current transaction to complete
+	 * and then lock the journal. Since this is essentially the commit
+	 * path, we don't need to wait for reserved handles.
+	 */
+	jbd2_journal_lock_updates_no_rsv(journal);
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
@@ -1174,6 +1183,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1311,13 +1332,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
-		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
 		if (iter->i_sync_tid <= tid)
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
index b6c114c11b97..7df1720f013b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -58,6 +58,7 @@ MODULE_PARM_DESC(jbd2_debug, "Debugging level for jbd2");
 EXPORT_SYMBOL(jbd2_journal_extend);
 EXPORT_SYMBOL(jbd2_journal_stop);
 EXPORT_SYMBOL(jbd2_journal_lock_updates);
+EXPORT_SYMBOL(jbd2_journal_lock_updates_no_rsv);
 EXPORT_SYMBOL(jbd2_journal_unlock_updates);
 EXPORT_SYMBOL(jbd2_journal_get_write_access);
 EXPORT_SYMBOL(jbd2_journal_get_create_access);
@@ -742,7 +743,6 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
-	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -754,7 +754,6 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
-	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..4361e5c56490 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -865,25 +865,15 @@ void jbd2_journal_wait_updates(journal_t *journal)
 	}
 }
 
-/**
- * jbd2_journal_lock_updates () - establish a transaction barrier.
- * @journal:  Journal to establish a barrier on.
- *
- * This locks out any further updates from being started, and blocks
- * until all existing updates have completed, returning only once the
- * journal is in a quiescent state with no updates running.
- *
- * The journal lock should not be held on entry.
- */
-void jbd2_journal_lock_updates(journal_t *journal)
+static void __jbd2_journal_lock_updates(journal_t *journal, bool wait_on_rsv)
 {
 	jbd2_might_wait_for_commit(journal);
 
 	write_lock(&journal->j_state_lock);
 	++journal->j_barrier_count;
 
-	/* Wait until there are no reserved handles */
-	if (atomic_read(&journal->j_reserved_credits)) {
+	if (wait_on_rsv && atomic_read(&journal->j_reserved_credits)) {
+		/* Wait until there are no reserved handles */
 		write_unlock(&journal->j_state_lock);
 		wait_event(journal->j_wait_reserved,
 			   atomic_read(&journal->j_reserved_credits) == 0);
@@ -904,6 +894,31 @@ void jbd2_journal_lock_updates(journal_t *journal)
 	mutex_lock(&journal->j_barrier);
 }
 
+/**
+ * jbd2_journal_lock_updates () - establish a transaction barrier.
+ * @journal:  Journal to establish a barrier on.
+ *
+ * This locks out any further updates from being started, and blocks
+ * until all existing updates have completed, returning only once the
+ * journal is in a quiescent state with no updates running.
+ *
+ * The journal lock should not be held on entry.
+ */
+void jbd2_journal_lock_updates(journal_t *journal)
+{
+	__jbd2_journal_lock_updates(journal, true);
+}
+
+/**
+ * jbd2_journal_lock_updates_no_rsv - same as above, but doesn't
+ * wait for reserved handles to finish.
+ * @journal: Journal to establish barrier on.
+ */
+void jbd2_journal_lock_updates_no_rsv(journal_t *journal)
+{
+	__jbd2_journal_lock_updates(journal, false);
+}
+
 /**
  * jbd2_journal_unlock_updates () - release barrier
  * @journal:  Journal to release the barrier on.
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 7479f64c0939..cfac287c0ad4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1531,6 +1531,7 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio);
 extern int	 jbd2_journal_stop(handle_t *);
 extern int	 jbd2_journal_flush(journal_t *journal, unsigned int flags);
 extern void	 jbd2_journal_lock_updates (journal_t *);
+extern void	 jbd2_journal_lock_updates_no_rsv(journal_t *journal);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
-- 
2.45.1.288.g0e0cd299f1-goog


