Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74431A2BA4
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgDHV4g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:56:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34435 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDHVzv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id a23so3049222plm.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mvj8takKlh+auL4njKXthM3ts4E4u4tf8ZoUI6zM4LQ=;
        b=oSHi90jY29kXojlSaBfR9QFjURYIOGtAZIPUZqLXI9jxUwvT2RvgzN2cXX1vWnU4KR
         aZJ41nNFEhSlCYgv5wquAbiV/E7rJeKc5h3rKySzmFknj2Bpx0z7T13khNWcFbVDNKFu
         sGl5QtlbL7NQtLCKXu8rL5m8KEYvAPoywP+Gr87zpwLP292l9Hf2HPXuZ+9Bpv2ciDU5
         zJ5p7OUmTroxqTMDZPPrzT5LX/vYe/0xqz3hlRuDtGMKZC/aA4jH30CTrkX3gdIcRTtR
         P/HLNvRAuqHO+wH+gPE0JRs3eZQTy2f1gWCErjrsFEw1xvRbMwB31WsISJniQKhnG7uK
         I1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mvj8takKlh+auL4njKXthM3ts4E4u4tf8ZoUI6zM4LQ=;
        b=efmrZiSZAyXnrOo1g66ysuEqxrjvpx1rcFrEfsjn+w0QWozC/2tojIBgJoBErvSbtE
         SMD7V6cUSM6ujNCIafjaYcCS9rZ4sN/UCpPx8WKy/yeS7nL3OulWw4tV8yq25Pi06ac4
         7UX4Bgx6RioZgSjaIZe7px1wO6VIs0WJseZ4kYC3YK6UlBgffUV7PpSTaLrpbm2AGlkA
         0Tpf+mHCJe1d+DArxay/N5Qg1pcJW4jFQq/xBQExPdAuUzGc+TESbRyyY2N/hk6aO3cf
         cIYQy+Uydw4bW4xrSQ0SppsBt7zRDkVVFRyKyOl+R1f1Aj17rpDLNGHW5ENoTWpaklq2
         WXGA==
X-Gm-Message-State: AGi0PuZSAxLB9slPGu6xcNFIHGV5BqKh7QvCTHXqwOq8eEc/phs/QbyE
        RIhHxyzrSzwi7DJcfEtbzkVOZVzI
X-Google-Smtp-Source: APiQypKF20TlVf7v0tSSprLlXdWXF7GejMKBUgfJ42ri6tp158oArnss16DlfsvSQFdiJHlufwNn7Q==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr7490303pju.169.1586382949089;
        Wed, 08 Apr 2020 14:55:49 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:48 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 06/20] jbd2: fast commit main commit path changes
Date:   Wed,  8 Apr 2020 14:55:16 -0700
Message-Id: <20200408215530.25649-6-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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
index e855d8260433..280d11591bcb 100644
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
 
@@ -1125,6 +1143,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
@@ -1136,6 +1156,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
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
2.26.0.110.g2183baf09c-goog

