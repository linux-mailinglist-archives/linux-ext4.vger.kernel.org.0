Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540EC27098D
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgISAzO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 20:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgISAzN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Sep 2020 20:55:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBBFC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so3882463pjb.0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kitbnrziLXg/5uuG0HWlXEqz0ETQbo12gTpW0r2SccQ=;
        b=asf8BXdpum19ZgXhRge26xKCiXP3GUSrEOMWSLTtKmh5+A38OEdrl6GEir05cSXAeL
         S8q8zCAodjoUkRbRpcVrIKsHXkJhwqHjWxoFWTsKpx3Bg+gOVmqlloEImbPRdyiU8PSx
         eRZfjtpB/JtbzKj1XafL3JpkwMpXJSaXiwO7ycw6RsHXsGGKWqWcE9KTuIMjYaq3rl8Q
         mvc9fBKVwACaeCUjzz3QHxmHopaQOfikvtcPzuL3H369JsFPA/7eGww2v3ME0k07OJkL
         218+R4zz2w02lCrL8rmmWx3Qh/z3uWYd8Wruifn99gR4HnhqYkC9Qn5DLsQdz7lHUUTT
         mFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kitbnrziLXg/5uuG0HWlXEqz0ETQbo12gTpW0r2SccQ=;
        b=SLHx8v+6+VBuJ6zsx8FBdyafU9+v5b+mfYc9sGc1jodhgu6Ts3UB3Wih2yayXS6+wO
         oSyrDgVjhRPKTIQU3xplGo41VuxCuFX/vA2xCMPgj89Q35SnxcSe6rwqo3ZGYIkrsePq
         J9J5mH5GfBEtqOigXCi0O0dJAFbTixrXAKrTQ0mfBLtnWrw0jeCmewRorp8rbVKAGluV
         9avUm8PnTAQkxMa6aju9Q7YLoGBbQMjsv0hCaWMGOHspamVJ59NICCE0PBf4WC1NNCfo
         qc6vqoxjpBISpZB+RcEYvfWkrRUCKcO5MsKXA172cQY1ujZo3l7gbq5t0KoJy3509uPa
         A5Rw==
X-Gm-Message-State: AOAM530jU/ybJIZt07A1NCF4zpJ8TZtK/wCf7VIkLTGOXo+VH11qswUO
        diDZjteIq7BDxDE2oLAfxdNsSR+WniI=
X-Google-Smtp-Source: ABdhPJz5N7/0a+R0HrWyPEFLQnQ4Uiie1iXQWzS1fB+THVHsN0OoVwlfGkl3bPQJixpNzMsWsIK95g==
X-Received: by 2002:a17:902:bb84:b029:d1:e5e7:bdd4 with SMTP id m4-20020a170902bb84b02900d1e5e7bdd4mr18143174pls.52.1600476912868;
        Fri, 18 Sep 2020 17:55:12 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f28sm4621953pfq.191.2020.09.18.17.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:55:11 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 4/9] jbd2: add fast commit machinery
Date:   Fri, 18 Sep 2020 17:54:46 -0700
Message-Id: <20200919005451.3899779-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 6d2da8ad0e6f..ba35ecb18616 100644
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
index 736a1736619f..17a30a2c38f9 100644
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
 	mutex_init(&journal->j_abort_mutex);
 	mutex_init(&journal->j_barrier);
 	mutex_init(&journal->j_checkpoint_mutex);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 36f65a818366..aad986a9f3ff 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -858,6 +858,13 @@ struct journal_s
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
@@ -1208,6 +1215,15 @@ struct journal_s
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
@@ -1292,6 +1308,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
 						 * data write error in ordered
 						 * mode */
+#define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
+#define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
 
 /*
  * Function declarations for the journaling transaction and buffer
@@ -1546,6 +1564,9 @@ extern int jbd2_cleanup_journal_tail(journal_t *);
 
 /* Fast commit related APIs */
 int jbd2_fc_init(journal_t *journal, int num_fc_blks);
+int jbd2_fc_start(journal_t *journal, tid_t tid);
+int jbd2_fc_stop(journal_t *journal);
+int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid);
 /*
  * is_journal_abort
  *
-- 
2.28.0.681.g6f77f65b4e-goog

