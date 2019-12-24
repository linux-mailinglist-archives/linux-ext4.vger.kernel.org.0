Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C7129ED6
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLXIOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36382 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXIOz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id k3so10072473pgc.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOUbD45uS2yE11vgovkM6cg38s0oDex/kXx+dGg7d4A=;
        b=lpn4pSeeqIA9GZQO8vedTiZ8dntPNmE9CBrha4qX3fHo74Sg+B+518C9IB6oU71X4a
         /UlA6aGOHRJgtWhlZPjM+aIf1QYTTzk0xSQIHT2v53rA++A8WvFuomwcoVJFmqvN4et6
         8E29BCVdOvyfVyjvaa1frD/3j+shSnZsgue4n6YVzj4BHqghLZkICfPuC4MjAUvULtvD
         a8Cm1VE7/2bsYIfTOFxxP/JV+zRh4nvUMv2iGuc9atFgk8CU0eQsKsx43SuDh5qlIYBF
         NDuCKA6huKaDVJ/ilnhL6xAyqqO3oWIb2L93g4rMifQLorPdg6eOd4OlEzlCnsrNplLt
         ENcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOUbD45uS2yE11vgovkM6cg38s0oDex/kXx+dGg7d4A=;
        b=T9Scopfh2bdqdktbba5HVzXeMBCGXmbyH9qbIfC+M2q/QP9JzO5V/4GFqobPGyOJHN
         f1KECXSPHsaOIoal65WN/+yI4dZMaQy1TW4m9x+Gqp4REQucKf+hmxmV+EX1mGG80AQ4
         5J8rwddfbyvdkM9+NRdlBXaKCUNwQZD2L4CWOun/3+I2WvAtYD5L+DczhT6hvF5Fhi+j
         Yf1t8x07fv6/3fLMLsLXanxDvgJncCjzt2tjSFHXznkMCvY2vGaVcBApiQSC3GOiHKSZ
         5ByFHox7FDYT1AX+/12+YWcY5CbwDBneD6uUU6PviY8aHgcjkk0TiUVDipMimvfEXlr7
         upeQ==
X-Gm-Message-State: APjAAAXN3SaELGFogheNRbr4uK5eG2sYwwXmiS5CYneBwdi0P4cP4B1p
        U5slY5OD+LSjGMycBQbzhv4tA6Zs
X-Google-Smtp-Source: APXvYqwfazBefIZhJvTmnlSk8cEuq9SW9nOjzdYW1asYJAIpFLm4HzN5wUPiP0zzQ5I1yGWAs96y3g==
X-Received: by 2002:a62:e215:: with SMTP id a21mr34397518pfi.3.1577175294161;
        Tue, 24 Dec 2019 00:14:54 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:53 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 06/20] jbd2: fast commit main commit path changes
Date:   Tue, 24 Dec 2019 00:13:10 -0800
Message-Id: <20191224081324.95807-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
index 132fb92098c7..ffbea070582c 100644
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
 
@@ -1114,6 +1132,8 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		  journal->j_commit_sequence, journal->j_tail_sequence);
 
 	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
+	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	spin_lock(&journal->j_list_lock);
 	commit_transaction->t_state = T_FINISHED;
 	/* Check if the transaction can be dropped now that we are finished */
@@ -1125,6 +1145,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	spin_unlock(&journal->j_list_lock);
 	write_unlock(&journal->j_state_lock);
 	wake_up(&journal->j_wait_done_commit);
+	wake_up(&journal->j_wait_async_fc);
 
 	/*
 	 * Calculate overall stats
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 7d91f5204366..bd6ab127f0d9 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -158,7 +158,9 @@ static void commit_timeout(struct timer_list *t)
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
@@ -715,6 +717,86 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
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
@@ -1126,6 +1208,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_commit);
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
+	init_waitqueue_head(&journal->j_wait_async_fc);
 	mutex_init(&journal->j_barrier);
 	mutex_init(&journal->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 7139626992f3..99b0f50ceb50 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -861,6 +861,13 @@ struct journal_s
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
@@ -1204,6 +1211,14 @@ struct journal_s
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
@@ -1289,6 +1304,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
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
2.24.1.735.g03f4e72817-goog

