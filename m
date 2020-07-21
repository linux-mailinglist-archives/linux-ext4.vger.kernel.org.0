Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E9E228880
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGUSp3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgGUSpY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 14:45:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E3C0619DB
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so12353343pgb.6
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IxHkVFeeyFakVpsu5ZmEWBMYRQJDvnqbpPP0b11S0+U=;
        b=nAPyjx54HIWHBsxtsVCSZX7AZZA5TP5j6fDGQIAWjDOPsBJn4pvu8D+6Ejypfkf0Xp
         uKwe1b9+6MQZFxB/UIYU8XSr3uJjfM0nBM+e/vbtAaigQ9K7UwH2Zv+/2gnGP9ojAi68
         f+3wXujXiCrs+6iZbBchEDlpeEPdxmmikxZgh6yhRR9Jik9a+F5ZtLmlqQyQ6DtY0sU9
         TTjDDFJ9Mtgk45ENGXB5CXLLyRmYSA5wLaAwYG2F+nWq3yhLLf+hk4URh3lzqUa8zvj+
         rgaw8VDH6MY9taJGsqHwoe58JeSLYtfdb6PjVVL2uhGJcv/erXJ5UvuL4Pz4I+ZlGUXd
         AdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IxHkVFeeyFakVpsu5ZmEWBMYRQJDvnqbpPP0b11S0+U=;
        b=ki41chDmPG0SHX77M97I/1jcC3vDBLvJke0b07gj89JXMXS9jPpwV2zkTyAhWqxX8w
         0lyo0WwV/tWsR1yn5Z7zUeoY8J4Mj0Cfl7ioaRBKbJRc+04+l4/Y4gF/B3RFROL45365
         gb20/1nRFXLph6o+XV36jw0JYjRlaHqRGhoxjUaShBuD8ochOaQcCUszVL2xDjwP99Ar
         FWjOqUeNf7ndq+Co79St0p6FWjUdOOR0D7p27EC+4lTmPXxP3Fiakzq9tuRav5MmQXr1
         v3QGpxfkvKzItIpl26tCVnPKERiGySkgrmmkr4OcDcDhLG+7Rg60XAqdiHejaZpqvV0Z
         Yg5w==
X-Gm-Message-State: AOAM533g/bC0xj3OZr6NcxKn8YCbtTDXWte3XGnD7DttM6rZ25mg6w31
        Y5wjVsMJJcD9aQtvbC6I7pZQZWmE
X-Google-Smtp-Source: ABdhPJwCueBHkPXncxhu+bOXyGMRiaDDhDcy/p3rXum8xOIZzz+XaEOIY5U6LQYeIKFKMwxU7QXbew==
X-Received: by 2002:a63:6c5:: with SMTP id 188mr23551222pgg.33.1595357123539;
        Tue, 21 Jul 2020 11:45:23 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b13sm4179890pjl.7.2020.07.21.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:45:22 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 6/7] jbd2: fast commit recovery path
Date:   Tue, 21 Jul 2020 11:43:54 -0700
Message-Id: <20200721184355.1616986-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
References: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds fast commit recovery support in JBD2.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 15 ++++++++++++
 fs/jbd2/recovery.c    | 56 +++++++++++++++++++++++++++++++++++++++----
 include/linux/jbd2.h  | 20 ++++++++++++++++
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index ee3695ce69a1..62673f251e5c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1188,8 +1188,23 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
 	trace_ext4_fc_stats(sb);
 }
 
+/*
+ * Main recovery path entry point.
+ */
+static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
+				enum passtype pass, int off, tid_t expected_tid)
+{
+	return 0;
+}
+
 void ext4_fc_init(struct super_block *sb, journal_t *journal)
 {
+	/*
+	 * We set replay callback even if fast commit disabled because we may
+	 * could still have fast commit blocks that need to be replayed even if
+	 * fast commit has now been turned off.
+	 */
+	journal->j_fc_replay_callback = ext4_fc_replay;
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return;
 	journal->j_fc_cleanup_callback = ext4_fc_cleanup;
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..49b8197d26c5 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -35,7 +35,6 @@ struct recovery_info
 	int		nr_revoke_hits;
 };
 
-enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
 static int scan_revoke_records(journal_t *, struct buffer_head *,
@@ -225,10 +224,53 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	if (var >= (journal)->j_last)					\
-		var -= ((journal)->j_last - (journal)->j_first);	\
+	unsigned long _wrap_last =					\
+		jbd2_has_feature_fast_commit(journal) ?			\
+			(journal)->j_last_fc : (journal)->j_last;	\
+									\
+	if (var >= _wrap_last)						\
+		var -= (_wrap_last - (journal)->j_first);		\
 } while (0)
 
+static int fc_do_one_pass(journal_t *journal,
+			  struct recovery_info *info, enum passtype pass)
+{
+	unsigned int expected_commit_id = info->end_transaction;
+	unsigned long next_fc_block;
+	struct buffer_head *bh;
+	unsigned int seq;
+	int err = 0;
+
+	next_fc_block = journal->j_first_fc;
+	if (!journal->j_fc_replay_callback)
+		return 0;
+
+	while (next_fc_block <= journal->j_last_fc) {
+		jbd_debug(3, "Fast commit replay: next block %ld",
+			  next_fc_block);
+		err = jread(&bh, journal, next_fc_block);
+		if (err) {
+			jbd_debug(3, "Fast commit replay: read error");
+			break;
+		}
+
+		jbd_debug(3, "Processing fast commit blk with seq %d",
+			  seq);
+		err = journal->j_fc_replay_callback(journal, bh, pass,
+					next_fc_block - journal->j_first_fc,
+					expected_commit_id);
+		next_fc_block++;
+		if (err < 0 || err == JBD2_FC_REPLAY_STOP)
+			break;
+		err = 0;
+	}
+
+	if (err)
+		jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
+
+	return err;
+}
+
 /**
  * jbd2_journal_recover - recovers a on-disk journal
  * @journal: the journal to recover
@@ -470,7 +512,9 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block,
+			  jbd2_has_feature_fast_commit(journal) ?
+			  journal->j_last_fc : journal->j_last);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -799,6 +843,10 @@ static int do_one_pass(journal_t *journal,
 				success = -EIO;
 		}
 	}
+
+	if (jbd2_has_feature_fast_commit(journal) && pass != PASS_REVOKE)
+		fc_do_one_pass(journal, info, pass);
+
 	if (block_error && success == 0)
 		success = -EIO;
 	return success;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 0f9aa2f79791..a7b193eef784 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -748,6 +748,11 @@ jbd2_time_diff(unsigned long start, unsigned long end)
 
 #define JBD2_NR_BATCH	64
 
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
+#define JBD2_FC_REPLAY_STOP	0
+#define JBD2_FC_REPLAY_CONTINUE	1
+
 /**
  * struct journal_s - The journal_s type is the concrete type associated with
  *     journal_t.
@@ -1219,6 +1224,21 @@ struct journal_s
 	 */
 	void (*j_fc_cleanup_callback)(struct journal_s *journal, int);
 
+	/*
+	 * @j_fc_replay_callback:
+	 *
+	 * File-system specific function that performs replay of a fast
+	 * commit. JBD2 calls this function for each fast commit block found in
+	 * the journal. This function should return JBD2_FC_REPLAY_CONTINUE
+	 * to indicate that the block was processed correctly and more fast
+	 * commit replay should continue. Return value of JBD2_FC_REPLAY_STOP
+	 * indicates the end of replay (no more blocks remaining). A negative
+	 * return value indicates error.
+	 */
+	int (*j_fc_replay_callback)(struct journal_s *journal,
+				    struct buffer_head *bh,
+				    enum passtype pass, int off,
+				    tid_t expected_commit_id);
 };
 
 #define jbd2_might_wait_for_commit(j) \
-- 
2.28.0.rc0.105.gf9edc3c819-goog

