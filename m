Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA22A1A6E
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgJaUFr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgJaUFq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3F6C0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t22so4690262plr.9
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVRI2X5aEPsIi6w5YLhArQYyxBVr01gAKnoRjVfQuDU=;
        b=VIAQ6J0bHlVGKEo2wAFQvq/xiPHFEnsroiwBlR3mJB34WhAdl4T7fikiAT+X2dBO23
         WAJUKuyL3N21PPY3LPLxPs/zfwxLHuFI6AROyUUQ2jWpr9DzflLErYZup81eXgaRw1gL
         lRia9lInX8rCN0IqTPL5HTqoqjXIHuGdFcvuiJ49eheWqFI9c6Cgp4QwB9ESmnPvPwKq
         jUeTJhw+GSD4HYSK7GPJkTt1NFxR2O9B5HfDbw6N0zMvNs0klnDOtb5ziH0rHdPxLtv9
         oBNgqsSsVvhTm15cZkcm/nrKBFRrsIhheWQ9rtVn+QRE2pMrjCZUFWnQCvEI73x7QBsS
         8IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVRI2X5aEPsIi6w5YLhArQYyxBVr01gAKnoRjVfQuDU=;
        b=ij4/fPKhZdVSCQKOnxQJjS+Gog2Lj8cPzCnDmmhT6rOwbst97MDQt6PsT3wkH9PPeW
         XxHwbCbvd4mvO7sha22D9Xf+9KSUdJc34TeO1jtzDonJuMG5z8Yh2MCKJwiuFtUV/Qtd
         sLb4sAu+lkmW2dUk1NLPqOtDVOPpM6UFKuWPaJCvBefcRH2H0286DmnBVwr+ZYl3fHiG
         zKsI6GgcxW8FmmPIDix7VHrRWk0OZ/cu+ELZrZv4j9Au6KWobxnTNPhP+FuqFs6aB7We
         cn00IUH4IgZfsimAq2x3WNTYxXvW3cbX/Ndm1ffHXv2caquIiSFdtArFDQ1grqqt8vA7
         ZqVA==
X-Gm-Message-State: AOAM531WUyPB6xC2z30exI0RMLdm3iu1AdU/2Xs5vifmki0MrgZ43crO
        Q09u8W0FdjWuLbwYpfYQ58MG9CqzRkc=
X-Google-Smtp-Source: ABdhPJxzQucC7smkshEe2ZlnPUYNTNj3KgOqyxBzLZkHK1qpHrRxIY/VXD805JVoGG3Rvqs+2veizg==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr9888769pjb.137.1604174745849;
        Sat, 31 Oct 2020 13:05:45 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:44 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 05/10] jbd2: fix fast commit journalling APIs
Date:   Sat, 31 Oct 2020 13:05:13 -0700
Message-Id: <20201031200518.4178786-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds a few misc fixes for jbd2 fast commit functions.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c |  2 +-
 fs/jbd2/commit.c      |  9 +++++++++
 fs/jbd2/journal.c     | 28 +++++++++++++---------------
 include/linux/jbd2.h  | 10 +++++++---
 4 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 1b62d82b9622..b1ca55c7d32a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1134,7 +1134,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 		"Fast commit ended with blks = %d, reason = %d, subtid - %d",
 		nblks, reason, subtid);
 	if (reason == EXT4_FC_REASON_FC_FAILED)
-		return jbd2_fc_end_commit_fallback(journal, commit_tid);
+		return jbd2_fc_end_commit_fallback(journal);
 	if (reason == EXT4_FC_REASON_FC_START_FAILED ||
 		reason == EXT4_FC_REASON_INELIGIBLE)
 		return jbd2_complete_transaction(journal, commit_tid);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 353534403769..2444414ad89e 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -450,6 +450,15 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		schedule();
 		write_lock(&journal->j_state_lock);
 		finish_wait(&journal->j_fc_wait, &wait);
+		/*
+		 * TODO: by blocking fast commits here, we are increasing
+		 * fsync() latency slightly. Strictly speaking, we don't need
+		 * to block fast commits until the transaction enters T_FLUSH
+		 * state. So an optimization is possible where we block new fast
+		 * commits here and wait for existing ones to complete
+		 * just before we enter T_FLUSH. That way, the existing fast
+		 * commits and this full commit can proceed parallely.
+		 */
 	}
 	write_unlock(&journal->j_state_lock);
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index ea15f55aff5c..368727ef3912 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -734,10 +734,12 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	if (!journal->j_stats.ts_tid)
 		return -EINVAL;
 
-	if (tid <= journal->j_commit_sequence)
+	write_lock(&journal->j_state_lock);
+	if (tid <= journal->j_commit_sequence) {
+		write_unlock(&journal->j_state_lock);
 		return -EALREADY;
+	}
 
-	write_lock(&journal->j_state_lock);
 	if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 	    (journal->j_flags & JBD2_FAST_COMMIT_ONGOING)) {
 		DEFINE_WAIT(wait);
@@ -777,13 +779,19 @@ static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 
 int jbd2_fc_end_commit(journal_t *journal)
 {
-	return __jbd2_fc_end_commit(journal, 0, 0);
+	return __jbd2_fc_end_commit(journal, 0, false);
 }
 EXPORT_SYMBOL(jbd2_fc_end_commit);
 
-int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid)
+int jbd2_fc_end_commit_fallback(journal_t *journal)
 {
-	return __jbd2_fc_end_commit(journal, tid, 1);
+	tid_t tid;
+
+	read_lock(&journal->j_state_lock);
+	tid = journal->j_running_transaction ?
+		journal->j_running_transaction->t_tid : 0;
+	read_unlock(&journal->j_state_lock);
+	return __jbd2_fc_end_commit(journal, tid, true);
 }
 EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
 
@@ -865,7 +873,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	int fc_off;
 
 	*bh_out = NULL;
-	write_lock(&journal->j_state_lock);
 
 	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
 		fc_off = journal->j_fc_off;
@@ -874,7 +881,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	} else {
 		ret = -EINVAL;
 	}
-	write_unlock(&journal->j_state_lock);
 
 	if (ret)
 		return ret;
@@ -887,11 +893,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (!bh)
 		return -ENOMEM;
 
-	lock_buffer(bh);
 
-	clear_buffer_uptodate(bh);
-	set_buffer_dirty(bh);
-	unlock_buffer(bh);
 	journal->j_fc_wbuf[fc_off] = bh;
 
 	*bh_out = bh;
@@ -909,9 +911,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
 	struct buffer_head *bh;
 	int i, j_fc_off;
 
-	read_lock(&journal->j_state_lock);
 	j_fc_off = journal->j_fc_off;
-	read_unlock(&journal->j_state_lock);
 
 	/*
 	 * Wait in reverse order to minimize chances of us being woken up before
@@ -939,9 +939,7 @@ int jbd2_fc_release_bufs(journal_t *journal)
 	struct buffer_head *bh;
 	int i, j_fc_off;
 
-	read_lock(&journal->j_state_lock);
 	j_fc_off = journal->j_fc_off;
-	read_unlock(&journal->j_state_lock);
 
 	/*
 	 * Wait in reverse order to minimize chances of us being woken up before
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 9b4e87a0068b..df1285da7276 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -946,7 +946,9 @@ struct journal_s
 	 * @j_fc_off:
 	 *
 	 * Number of fast commit blocks currently allocated.
-	 * [j_state_lock].
+	 * [j_state_lock]. During the commit path, this variable is not
+	 * protected by j_state_lock since only one process performs commit
+	 * at a time.
 	 */
 	unsigned long		j_fc_off;
 
@@ -1110,7 +1112,9 @@ struct journal_s
 
 	/**
 	 * @j_fc_wbuf: Array of fast commit bhs for
-	 * jbd2_journal_commit_transaction.
+	 * jbd2_journal_commit_transaction. During the commit path, this
+	 * variable is not protected by j_state_lock since only one process
+	 * performs commit at a time.
 	 */
 	struct buffer_head	**j_fc_wbuf;
 
@@ -1618,7 +1622,7 @@ extern int jbd2_cleanup_journal_tail(journal_t *);
 int jbd2_fc_init(journal_t *journal);
 int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
 int jbd2_fc_end_commit(journal_t *journal);
-int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid);
+int jbd2_fc_end_commit_fallback(journal_t *journal);
 int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
 int jbd2_submit_inode_data(struct jbd2_inode *jinode);
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
-- 
2.29.1.341.ge80a0c044ae-goog

