Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FF947E8B8
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbhLWUWA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbhLWUV5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:21:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E99CC061401
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s15so6133699pfk.6
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++jTTVBZ8nceqk7gMO9HJsGkVa6mOBk7ZOIuQwlYOTs=;
        b=FdEYhr87NYZg0jmNjtrYbcr9dWVytCZnZahx964Vj236TwLRoTxbmym+HhvahU1f3p
         PPyzrC4cGwJ0s2tf4aA3jlxiNKA7YmwX9UqghNSxZqqozHFvo5gx76eCEa8o2Y05DYp6
         PlSyB9HSuDh/1m0gf+YvaWAdniRqqGXEc3ZNtTuwwgUWpD4yXep6YZHrj5SVwBAyK3mW
         mlgVw6hvOykfxst6ooguuGF2BY4kRYYqrboEqQNHoz7tJlf3BiPk3qL025Eeso6WNipj
         dmkRQUR2P11AVBpFU8+LwsrifPK57fJilhJ4yewFji6wMbpLQzHYXdL1kIS14U0OwRLa
         5qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++jTTVBZ8nceqk7gMO9HJsGkVa6mOBk7ZOIuQwlYOTs=;
        b=XCZhPCJxQF9Zx1fueHGuQzZx8MxMhRxu9QKeb6lbU0c/Wa8Azdxbe5Ehr29Q7DtXv0
         kz70DkKm7uLZkgYwRkHH7PLmdcLQPjW/e7e6pzpxr/NjGOhTLnieR0MKECxeQxy+R+ZX
         o04MtDpHz6LjRS1e1O4oOrHVzDC/gvDTDfHAKFv4uOGd6LTBkNiCFzRNkmoGIAGJT2lN
         tqrcXqREvFDPVHFY1MEehxoPZIwumOkEDvIqOipRD+Lt1lG6T0TJGbeaB4yi6Zs3FV2i
         PUJ47TeKAQKFli+Qh/uZ+rrFJtxDJXgrE3kvrnvRpAGsVAPrZnDt34d9M8Gs8IeZq/N3
         6dXQ==
X-Gm-Message-State: AOAM532D5SfR7TLwTjfZ8n1UVLHYiNdAyhfF/qbhN4aHxv51om1pXu3F
        zFP+YtHVzHO6opDhR2qAyoCQHZir0u0=
X-Google-Smtp-Source: ABdhPJw4FizFXkf6ZxPPgcfNvRBc0EzsasCEUSnwfP/IZhpFqjc0Mix1jrQm0yNH+m/JTmhndVhaYA==
X-Received: by 2002:a05:6a00:72c:b0:4ba:9a9e:b82b with SMTP id 12-20020a056a00072c00b004ba9a9eb82bmr3986248pfm.13.1640290916246;
        Thu, 23 Dec 2021 12:21:56 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:404a:8e2b:a329:bed6])
        by smtp.googlemail.com with ESMTPSA id lx8sm10351074pjb.18.2021.12.23.12.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 12:21:55 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 3/4] ext4: simplify updating of fast commit stats
Date:   Thu, 23 Dec 2021 12:21:39 -0800
Message-Id: <20211223202140.2061101-4-harshads@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211223202140.2061101-1-harshads@google.com>
References: <20211223202140.2061101-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Move fast commit stats updating logic to a separate function from
ext4_fc_commit(). This significantly improves readability of
ext4_fc_commit().

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  1 -
 fs/ext4/fast_commit.c | 99 +++++++++++++++++++++++--------------------
 fs/ext4/fast_commit.h | 27 ++++++------
 3 files changed, 68 insertions(+), 59 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d71485d53050..82fa51d6f145 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1747,7 +1747,6 @@ struct ext4_sb_info {
 	spinlock_t s_fc_lock;
 	struct buffer_head *s_fc_bh;
 	struct ext4_fc_stats s_fc_stats;
-	u64 s_fc_avg_commit_time;
 #ifdef CONFIG_EXT4_DEBUG
 	int s_fc_debug_max_replay;
 #endif
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 2771adefdba0..a37384054c9e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1075,6 +1075,32 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	return ret;
 }
 
+static void ext4_fc_update_stats(struct super_block *sb, int status,
+				 u64 commit_time, int nblks)
+{
+	struct ext4_fc_stats *stats = &EXT4_SB(sb)->s_fc_stats;
+
+	jbd_debug(1, "Fast commit ended with status = %d", status);
+	if (status == EXT4_FC_STATUS_OK) {
+		stats->fc_num_commits++;
+		stats->fc_numblks += nblks;
+		if (likely(stats->s_fc_avg_commit_time))
+			stats->s_fc_avg_commit_time =
+				(commit_time +
+				 stats->s_fc_avg_commit_time * 3) / 4;
+		else
+			stats->s_fc_avg_commit_time = commit_time;
+	} else if (status == EXT4_FC_STATUS_FAILED ||
+		   status == EXT4_FC_STATUS_INELIGIBLE) {
+		if (status == EXT4_FC_STATUS_FAILED)
+			stats->fc_failed_commits++;
+		stats->fc_ineligible_commits++;
+	} else {
+		stats->fc_skipped_commits++;
+	}
+	trace_ext4_fc_commit_stop(sb, nblks, status);
+}
+
 /*
  * The main commit entry point. Performs a fast commit for transaction
  * commit_tid if needed. If it's not possible to perform a fast commit
@@ -1087,7 +1113,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int nblks = 0, ret, bsize = journal->j_blocksize;
 	int subtid = atomic_read(&sbi->s_fc_subtid);
-	int reason = EXT4_FC_REASON_OK, fc_bufs_before = 0;
+	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
 	ktime_t start_time, commit_time;
 
 	trace_ext4_fc_commit_start(sb);
@@ -1104,69 +1130,52 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
 			commit_tid > journal->j_commit_sequence)
 			goto restart_fc;
-		reason = EXT4_FC_REASON_ALREADY_COMMITTED;
-		goto out;
+		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0);
+		return 0;
 	} else if (ret) {
-		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
-		reason = EXT4_FC_REASON_FC_START_FAILED;
-		goto out;
+		/*
+		 * Commit couldn't start. Just update stats and perform a
+		 * full commit.
+		 */
+		ext4_fc_update_stats(sb, EXT4_FC_STATUS_FAILED, 0, 0);
+		return jbd2_complete_transaction(journal, commit_tid);
 	}
+
 	/*
 	 * After establishing journal barrier via jbd2_fc_begin_commit(), check
 	 * if we are fast commit ineligible.
 	 */
 	if (ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE)) {
-		reason = EXT4_FC_REASON_INELIGIBLE;
-		goto out;
+		status = EXT4_FC_STATUS_INELIGIBLE;
+		goto fallback;
 	}
 
 	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
 	ret = ext4_fc_perform_commit(journal);
 	if (ret < 0) {
-		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
-		reason = EXT4_FC_REASON_FC_FAILED;
-		goto out;
+		status = EXT4_FC_STATUS_FAILED;
+		goto fallback;
 	}
 	nblks = (sbi->s_fc_bytes + bsize - 1) / bsize - fc_bufs_before;
 	ret = jbd2_fc_wait_bufs(journal, nblks);
 	if (ret < 0) {
-		sbi->s_fc_stats.fc_ineligible_reason_count[EXT4_FC_COMMIT_FAILED]++;
-		reason = EXT4_FC_REASON_FC_FAILED;
-		goto out;
+		status = EXT4_FC_STATUS_FAILED;
+		goto fallback;
 	}
 	atomic_inc(&sbi->s_fc_subtid);
-	jbd2_fc_end_commit(journal);
-out:
-	spin_lock(&sbi->s_fc_lock);
-	if (reason != EXT4_FC_REASON_OK &&
-		reason != EXT4_FC_REASON_ALREADY_COMMITTED) {
-		sbi->s_fc_stats.fc_ineligible_commits++;
-	} else {
-		sbi->s_fc_stats.fc_num_commits++;
-		sbi->s_fc_stats.fc_numblks += nblks;
-	}
-	spin_unlock(&sbi->s_fc_lock);
-	nblks = (reason == EXT4_FC_REASON_OK) ? nblks : 0;
-	trace_ext4_fc_commit_stop(sb, nblks, reason);
-	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
+	ret = jbd2_fc_end_commit(journal);
 	/*
-	 * weight the commit time higher than the average time so we don't
-	 * react too strongly to vast changes in the commit time
+	 * weight the commit time higher than the average time so we
+	 * don't react too strongly to vast changes in the commit time
 	 */
-	if (likely(sbi->s_fc_avg_commit_time))
-		sbi->s_fc_avg_commit_time = (commit_time +
-				sbi->s_fc_avg_commit_time * 3) / 4;
-	else
-		sbi->s_fc_avg_commit_time = commit_time;
-	jbd_debug(1,
-		"Fast commit ended with blks = %d, reason = %d, subtid - %d",
-		nblks, reason, subtid);
-	if (reason == EXT4_FC_REASON_FC_FAILED)
-		return jbd2_fc_end_commit_fallback(journal);
-	if (reason == EXT4_FC_REASON_FC_START_FAILED ||
-		reason == EXT4_FC_REASON_INELIGIBLE)
-		return jbd2_complete_transaction(journal, commit_tid);
-	return 0;
+	commit_time = ktime_to_ns(ktime_sub(ktime_get(), start_time));
+	ext4_fc_update_stats(sb, status, commit_time, nblks);
+	return ret;
+
+fallback:
+	ret = jbd2_fc_end_commit_fallback(journal);
+	ext4_fc_update_stats(sb, status, 0, 0);
+	return ret;
 }
 
 /*
@@ -2124,7 +2133,7 @@ int ext4_fc_info_show(struct seq_file *seq, void *v)
 		"fc stats:\n%ld commits\n%ld ineligible\n%ld numblks\n%lluus avg_commit_time\n",
 		   stats->fc_num_commits, stats->fc_ineligible_commits,
 		   stats->fc_numblks,
-		   div_u64(sbi->s_fc_avg_commit_time, 1000));
+		   div_u64(stats->s_fc_avg_commit_time, 1000));
 	seq_puts(seq, "Ineligible reasons:\n");
 	for (i = 0; i < EXT4_FC_REASON_MAX; i++)
 		seq_printf(seq, "\"%s\":\t%d\n", fc_ineligible_reasons[i],
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 937c381b4c85..083ad1cb705a 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -71,21 +71,19 @@ struct ext4_fc_tail {
 };
 
 /*
- * Fast commit reason codes
+ * Fast commit status codes
+ */
+enum {
+	EXT4_FC_STATUS_OK = 0,
+	EXT4_FC_STATUS_INELIGIBLE,
+	EXT4_FC_STATUS_SKIPPED,
+	EXT4_FC_STATUS_FAILED,
+};
+
+/*
+ * Fast commit ineligiblity reasons:
  */
 enum {
-	/*
-	 * Commit status codes:
-	 */
-	EXT4_FC_REASON_OK = 0,
-	EXT4_FC_REASON_INELIGIBLE,
-	EXT4_FC_REASON_ALREADY_COMMITTED,
-	EXT4_FC_REASON_FC_START_FAILED,
-	EXT4_FC_REASON_FC_FAILED,
-
-	/*
-	 * Fast commit ineligiblity reasons:
-	 */
 	EXT4_FC_REASON_XATTR = 0,
 	EXT4_FC_REASON_CROSS_RENAME,
 	EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
@@ -117,7 +115,10 @@ struct ext4_fc_stats {
 	unsigned int fc_ineligible_reason_count[EXT4_FC_REASON_MAX];
 	unsigned long fc_num_commits;
 	unsigned long fc_ineligible_commits;
+	unsigned long fc_failed_commits;
+	unsigned long fc_skipped_commits;
 	unsigned long fc_numblks;
+	u64 s_fc_avg_commit_time;
 };
 
 #define EXT4_FC_REPLAY_REALLOC_INCREMENT	4
-- 
2.34.1.307.g9b7440fafd-goog

