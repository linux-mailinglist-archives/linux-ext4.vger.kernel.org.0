Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA722887F
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbgGUSp2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 14:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUSpW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 14:45:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB0DC0619DA
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f16so2113716pjt.0
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrNBa/FY5qGEisbnrycz5NXw0ydh0mFKXYCiBw18JR0=;
        b=Ducizm4JP7W9+PgkrmS26JTDe5rLZYffnQTjeZCeC/s8d1e8+zX29XrM8vKps4IpJh
         PQ0x8TBodjKiqmCWmM49LC7x5m12fHG1y81EGp3ouJcrGkmRFaXw7lqyupz4L9iJBTcb
         iSN96LeGHfTSNuLVhbC/Y+HT9ck8TzbVyh4cwaJglgQDp8BwcRx3El8gSJ8LHEEStvw/
         wLQoFBPRO6AAchYOy1nx7IVGkBxbquKIXHEFZXL2oyT51nVlVGUHfkqC//OeJaMUoHUA
         qcYL6nRg0HCQEx3BnQ9x/Np0dSuwsnPLxEMWaNb7bItu9RaxILkYvZ2LJlmeYbAJmpt/
         RYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrNBa/FY5qGEisbnrycz5NXw0ydh0mFKXYCiBw18JR0=;
        b=ZUNtvAfqPjZRGi4IY8hGCYqlrn4CmoWsVGS3gH59wyPn7R4nOEg/4lnU3VFB2iGxEa
         LFzJNlhYxzbhQfacrLEyB+eidSBfR8XGK1hZcLwKrKMme7D1CBsgrdqjgYLTvqsNlSrj
         6UQ0KGsMXuEgkXjy6L6DqPrXddZT8kyZMC0zAqxlcukMhmF+9VDTkgkQtF/XCzEFZDiT
         7Xh8QFSchNYOtYAaX+R6+XRHGDF4iLbb0sPUMNQnK9+pxPiLmfeqqA0C+wNmUlQILj7j
         653lqZRD7rAcidgmmE2RW10BBBff8+JR0VmdGa9uah7+8D4PVK6NSv2sAUVSM7dFLZIG
         Zvvw==
X-Gm-Message-State: AOAM532b8XLQj8O7L9nmhgflw5OPHvqYZQjLr4xUDk3Gbjj9C/rhiQP+
        LvPN/35Q+SnE97Tinho/hAS9vVZ0
X-Google-Smtp-Source: ABdhPJxQSFrqQco7HJPuOrwYsXjTEgpoyoZVE3yjDdZ6kNenJcCJ17XEB5F3yW3uwu7Tb2QhNKATlA==
X-Received: by 2002:a17:902:d391:: with SMTP id e17mr22503177pld.219.1595357120868;
        Tue, 21 Jul 2020 11:45:20 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b13sm4179890pjl.7.2020.07.21.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:45:20 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 4/7] jbd2: add fast commit machinery
Date:   Tue, 21 Jul 2020 11:43:52 -0700
Message-Id: <20200721184355.1616986-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
References: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch implements following APIs in JBD2 to allow for fast
commits:

jbd2_fc_start(): Start a new fast commit. This function waits for any
existing fast commit or full commit to complete.

jbd2_fc_stop(): Stop fast commit. This function ends current fast
commit and wakes up either the journal thread or the other fast commit
waiting for current fast commit to complete.

jbd2_fc_stop_do_commit(): Stop fast commit and perform a full
commit. This is same as above but also performs a full commit.

This patch also adds a cleanup handler in journal_t that is called
after every full and fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c |  8 ++++++
 fs/jbd2/commit.c      | 19 ++++++++++++
 fs/jbd2/journal.c     | 67 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/jbd2.h  | 21 ++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0dad8bdb1253..f2d11b4c6b62 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -8,11 +8,19 @@
  * Ext4 fast commits routines.
  */
 #include "ext4_jbd2.h"
+/*
+ * Fast commit cleanup routine. This is called after every fast commit and
+ * full commit. full is true if we are called after a full commit.
+ */
+static void ext4_fc_cleanup(journal_t *journal, int full)
+{
+}
 
 void ext4_fc_init(struct super_block *sb, journal_t *journal)
 {
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return;
+	journal->j_fc_cleanup_callback = ext4_fc_cleanup;
 	if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
 		pr_warn("Error while enabling fast commits, turning off.");
 		ext4_clear_feature_fast_commit(sb);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index e855d8260433..e03f5183aae1 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -413,6 +413,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	J_ASSERT(journal->j_running_transaction != NULL);
 	J_ASSERT(journal->j_committing_transaction == NULL);
 
+	write_lock(&journal->j_state_lock);
+	journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
+	while (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_fc, &wait,
+				TASK_UNINTERRUPTIBLE);
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		write_lock(&journal->j_state_lock);
+		finish_wait(&journal->j_wait_fc, &wait);
+	}
+	write_unlock(&journal->j_state_lock);
+
 	commit_transaction = journal->j_running_transaction;
 
 	trace_jbd2_start_commit(journal, commit_transaction);
@@ -1119,12 +1133,16 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 	if (journal->j_commit_callback)
 		journal->j_commit_callback(journal, commit_transaction);
+	if (journal->j_fc_cleanup_callback)
+		journal->j_fc_cleanup_callback(journal, 1);
 
 	trace_jbd2_end_commit(journal, commit_transaction);
 	jbd_debug(1, "JBD2: commit %d complete, head %d\n",
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
@@ -1136,6 +1154,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	spin_unlock(&journal->j_list_lock);
 	write_unlock(&journal->j_state_lock);
 	wake_up(&journal->j_wait_done_commit);
+	wake_up(&journal->j_wait_fc);
 
 	/*
 	 * Calculate overall stats
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 494de5410076..0c068d66de7a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -714,6 +714,72 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	return err;
 }
 
+/*
+ * Start a fast commit. If there's an ongoing fast or full commit wait for
+ * it to complete. Returns 0 if a new fast commit was started. Returns -EALREADY
+ * if a fast commit is not needed, either because there's an already a commit
+ * going on or this tid has already been committed. Returns -EINVAL if no jbd2
+ * commit has yet been performed.
+ */
+int jbd2_fc_start(journal_t *journal, tid_t tid)
+{
+	/*
+	 * Fast commits only allowed if at least one full commit has
+	 * been processed.
+	 */
+	if (!journal->j_stats.ts_tid)
+		return -EINVAL;
+
+	if (tid <= journal->j_commit_sequence)
+		return -EALREADY;
+
+	write_lock(&journal->j_state_lock);
+	if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+	    (journal->j_flags & JBD2_FAST_COMMIT_ONGOING)) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_fc, &wait,
+				TASK_UNINTERRUPTIBLE);
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		finish_wait(&journal->j_wait_fc, &wait);
+		return -EALREADY;
+	}
+	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
+	write_unlock(&journal->j_state_lock);
+
+	return 0;
+}
+
+/*
+ * Stop a fast commit. If fallback is set, this function starts commit of
+ * TID tid before any other fast commit can start.
+ */
+static int __jbd2_fc_stop(journal_t *journal, tid_t tid, bool fallback)
+{
+	if (journal->j_fc_cleanup_callback)
+		journal->j_fc_cleanup_callback(journal, 0);
+	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
+	if (fallback)
+		journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
+	write_unlock(&journal->j_state_lock);
+	wake_up(&journal->j_wait_fc);
+	if (fallback)
+		return jbd2_complete_transaction(journal, tid);
+	return 0;
+}
+
+int jbd2_fc_stop(journal_t *journal)
+{
+	return __jbd2_fc_stop(journal, 0, 0);
+}
+
+int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid)
+{
+	return __jbd2_fc_stop(journal, tid, 1);
+}
+
 /* Return 1 when transaction with given tid has already committed. */
 int jbd2_transaction_committed(journal_t *journal, tid_t tid)
 {
@@ -1140,6 +1206,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_commit);
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
+	init_waitqueue_head(&journal->j_wait_fc);
 	mutex_init(&journal->j_barrier);
 	mutex_init(&journal->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 65b7107dcaa0..965e09d8819a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -853,6 +853,13 @@ struct journal_s
 	 */
 	wait_queue_head_t	j_wait_reserved;
 
+	/**
+	 * @j_wait_fc:
+	 *
+	 * Wait queue to wait for completion of async fast commits.
+	 */
+	wait_queue_head_t	j_wait_fc;
+
 	/**
 	 * @j_checkpoint_mutex:
 	 *
@@ -1203,6 +1210,15 @@ struct journal_s
 	 */
 	struct lockdep_map	j_trans_commit_map;
 #endif
+
+	/**
+	 * @j_fc_cleanup_callback:
+	 *
+	 * Clean-up after fast commit or full commit. JBD2 calls this function
+	 * after every commit operation.
+	 */
+	void (*j_fc_cleanup_callback)(struct journal_s *journal, int);
+
 };
 
 #define jbd2_might_wait_for_commit(j) \
@@ -1288,6 +1304,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 						 * data write error in ordered
 						 * mode */
 #define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
+#define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
+#define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
 
 /*
  * Function declarations for the journaling transaction and buffer
@@ -1542,6 +1560,9 @@ extern int jbd2_cleanup_journal_tail(journal_t *);
 
 /* Fast commit related APIs */
 int jbd2_fc_init(journal_t *journal, int num_fc_blks);
+int jbd2_fc_start(journal_t *journal, tid_t tid);
+int jbd2_fc_stop(journal_t *journal);
+int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid);
 /*
  * is_journal_abort
  *
-- 
2.28.0.rc0.105.gf9edc3c819-goog

