Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3017D98A
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgCIHGE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35051 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCIHGE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7so4296720pgr.2
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKq996CuGBciUxLBo4qW7GLSM2yO9kxHVXWV0c+i+7M=;
        b=eT9CiVIx+8mSp6kNAVDDM66meu8beP4pyjihdnSH5O6y0qY+Q5Jn8bG+XsNgSHVBVj
         871muqSoASAISy/8ImIPzjhr30ygth4gJXqm82ip3x17UFvQENr8ByIBHVFTk3VxWqcm
         lKp8Qaa2msXFftMjxmVpJ63imhIaGRvxpCBupcA41pvKwGGC4/6qlwGg9mR6srEFOihy
         8A8MrGkm7Wn65oW6cKHwqikGNCnGebMDVy/WHq/VYJbVznrOUHXDvSccbKRtsdahPnrp
         JoHKqE1v8yOIfo0iXSl9fdbkkBwNOPEPL2+MTBXq3Nv+l26MaJKn5QbBxn8KigLjMSox
         ub6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKq996CuGBciUxLBo4qW7GLSM2yO9kxHVXWV0c+i+7M=;
        b=bxiUz7Mqtg88JqRiNY4tnGkaskh1/PIQUreH/dJfhZlaVFt75ShepXtLq8bAuNPrrV
         Pr5QJO4FCOjhRtRUcV5niZcSzXitIAhhz+qRLcYLrSUObwVKcZUMruFiYQ6te9rWlMJj
         kVSd9sbOR6mRfQY52FfkTEMcdDVXGS95HEA2XbGIsUKgRwKfokvjC0WfE48OZdxBrIIj
         fTnYvnDsxR+ECACKCJiFGdA0swI0vGD23M/p1Y54uebhJM8Tp2lbiGPrUjSr97knpV5b
         Lc1YnaXqzllCekZ6SMxxcd10guWpjWN1TD0GKYe6Uoe2LKy4G76kYni+OiqHT2hrnKdf
         oqGQ==
X-Gm-Message-State: ANhLgQ3phPMxStOrA9ccJDIQHLwwSy7lVxVjmlSSrHyHrtDyGFD/ZT7G
        fPnpkYF3rYNClse3ZfNPhcAqJiU4
X-Google-Smtp-Source: ADFU+vvcgGAaN6Kq32n/+qmf6YjMz7SUuTOwA+hfNaxdkbfEfqunxQajrwewvAJwVz4rYui8z2sBQA==
X-Received: by 2002:a62:de83:: with SMTP id h125mr29530pfg.161.1583737560357;
        Mon, 09 Mar 2020 00:06:00 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:05:59 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 06/20] jbd2: fast commit main commit path changes
Date:   Mon,  9 Mar 2020 00:05:12 -0700
Message-Id: <20200309070526.218202-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add 3 new APIs jbd2_start_async_fc_nowait(),
jbd2_start_async_fc_wait() and jbd2_stop_async_fc(). These APIs can be
used by file systems to indicate to jbd2 that they are starting or
stopping a fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/commit.c     | 21 +++++++++++
 fs/jbd2/journal.c    | 85 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/jbd2.h | 21 +++++++++++
 3 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 27373f5792a4..869fe193fbe3 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -413,6 +413,23 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	J_ASSERT(journal->j_running_transaction != NULL);
 	J_ASSERT(journal->j_committing_transaction == NULL);
 
+	write_lock(&journal->j_state_lock);
+	journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
+	while (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_async_fc, &wait,
+				TASK_UNINTERRUPTIBLE);
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		write_lock(&journal->j_state_lock);
+		finish_wait(&journal->j_wait_async_fc, &wait);
+	}
+	write_unlock(&journal->j_state_lock);
+
+	if (journal->j_fc_cleanup_callback)
+		journal->j_fc_cleanup_callback(journal);
+
 	commit_transaction = journal->j_running_transaction;
 
 	trace_jbd2_start_commit(journal, commit_transaction);
@@ -420,6 +437,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 			commit_transaction->t_tid);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_fc_off = 0;
 	J_ASSERT(commit_transaction->t_state == T_RUNNING);
 	commit_transaction->t_state = T_LOCKED;
 
@@ -1124,6 +1142,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
@@ -1135,6 +1155,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	spin_unlock(&journal->j_list_lock);
 	write_unlock(&journal->j_state_lock);
 	wake_up(&journal->j_wait_done_commit);
+	wake_up(&journal->j_wait_async_fc);
 
 	/*
 	 * Calculate overall stats
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index f8f55d0814ea..d3897d155fb9 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -157,7 +157,9 @@ static void commit_timeout(struct timer_list *t)
  *
  * 1) COMMIT:  Every so often we need to commit the current state of the
  *    filesystem to disk.  The journal thread is responsible for writing
- *    all of the metadata buffers to disk.
+ *    all of the metadata buffers to disk. If a fast commit is ongoing
+ *    journal thread waits until it's done and then copntinues from
+ *    there on.
  *
  * 2) CHECKPOINT: We cannot reuse a used section of the log file until all
  *    of the data in that part of the log has been rewritten elsewhere on
@@ -714,6 +716,86 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
 	return err;
 }
 
+/*
+ * Returns 0 if async fc could be started. Returns -EINVAL if no full
+ * commit has been done yet. Returns -EALREADY if another fast /
+ * full commit is ongoing.
+ */
+int jbd2_start_async_fc_nowait(journal_t *journal, tid_t tid)
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
+	if (journal->j_flags &
+	    (JBD2_FAST_COMMIT_ONGOING | JBD2_FULL_COMMIT_ONGOING)) {
+		write_unlock(&journal->j_state_lock);
+		return -EALREADY;
+	}
+
+	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
+	write_unlock(&journal->j_state_lock);
+
+	return 0;
+}
+
+/*
+ * Same as above but waits for any ongoing fast commits to complete.
+ * If a full commit is ongoing, this function returns with
+ * -EALREADY.
+ */
+int jbd2_start_async_fc_wait(journal_t *journal, tid_t tid)
+{
+	int ret;
+
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
+restart:
+	if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING) {
+		ret = -EALREADY;
+	} else if (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_async_fc, &wait,
+				TASK_UNINTERRUPTIBLE);
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		write_lock(&journal->j_state_lock);
+		finish_wait(&journal->j_wait_async_fc, &wait);
+		goto restart;
+	} else {
+		journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
+		ret = 0;
+	}
+	write_unlock(&journal->j_state_lock);
+
+	return ret;
+}
+
+void jbd2_stop_async_fc(journal_t *journal, tid_t tid)
+{
+	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
+	write_unlock(&journal->j_state_lock);
+	wake_up(&journal->j_wait_async_fc);
+}
+
 /* Return 1 when transaction with given tid has already committed. */
 int jbd2_transaction_committed(journal_t *journal, tid_t tid)
 {
@@ -1140,6 +1222,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_commit);
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
+	init_waitqueue_head(&journal->j_wait_async_fc);
 	mutex_init(&journal->j_barrier);
 	mutex_init(&journal->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 1fc981cca479..0a4d9d484528 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -853,6 +853,13 @@ struct journal_s
 	 */
 	wait_queue_head_t	j_wait_reserved;
 
+	/**
+	 * @j_wait_async_fc:
+	 *
+	 * Wait queue to wait for completion of async fast commits.
+	 */
+	wait_queue_head_t	j_wait_async_fc;
+
 	/**
 	 * @j_checkpoint_mutex:
 	 *
@@ -1203,6 +1210,14 @@ struct journal_s
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
+	void (*j_fc_cleanup_callback)(struct journal_s *journal);
 };
 
 #define jbd2_might_wait_for_commit(j) \
@@ -1288,6 +1303,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 						 * data write error in ordered
 						 * mode */
 #define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
+#define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
+#define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
 
 /*
  * Function declarations for the journaling transaction and buffer
@@ -1540,6 +1557,10 @@ void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
 extern int jbd2_cleanup_journal_tail(journal_t *);
 
+/* Fast commit related APIs */
+int jbd2_start_async_fc_nowait(journal_t *journal, tid_t tid);
+int jbd2_start_async_fc_wait(journal_t *journal, tid_t tid);
+void jbd2_stop_async_fc(journal_t *journal, tid_t tid);
 void jbd2_init_fast_commit(journal_t *journal, int num_fc_blks);
 /*
  * is_journal_abort
-- 
2.25.1.481.gfbce0eb801-goog

