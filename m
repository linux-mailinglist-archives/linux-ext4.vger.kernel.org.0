Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902CF27098F
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 02:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgISAzS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 20:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISAzQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Sep 2020 20:55:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498CC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so4420350pgm.11
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7K5YtC0JjRBsQRwr9OTdUvML1HR+6ltsn+GL5Apl4S8=;
        b=KkUCJ2S9pjL1M9tNMGunXoxoOcXdE0+MV1ff307uv06yo1xoQt6ifvNIP6UAi+tRnm
         mirGJu2Tx0anmUVh3X2xnbj18PX4Oy3o14MAiZhYpe50nLWnmN13XtAZ3xFBg6Tf2w8E
         DFAUkGqnF8QeNVGog2BJDmodnv+nQmhGhwyoLxv0YedNNLbj34DGrPTVxJDgTt0mQM7T
         uAyOHepjqHVIij2pS6B+ULGCrViRmMcqA6S0vPlHpsIJ2nhR1OyAPcbHmQ77nbSfrxN7
         8oC2Eso33z/hN8jg7mlLASHB+MErIn0zi8AGABLUXH24gc2kvm5tJKgohd/kmN8xQ5vC
         Uyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K5YtC0JjRBsQRwr9OTdUvML1HR+6ltsn+GL5Apl4S8=;
        b=ic/JRdRfPKwcS/I16C9uqX4M5E0Jk2oYqQ/RO36/jlTTkacB7vD+6gPX37ZFmK3Myg
         1euae029iCUslmtePLUKsjW3ZZ46Em+5Nh0pFNevpgZiVlRpBgmjFEe9VcPyQ5CqvJ8x
         AFGTFPY0cHu6ocePapMSQG4o6cgmmyXoA8+JLqqpD4XoHepkWaWQiF/LFrT0Jj3rUkDs
         mIBbUagMeAfkfGo6BzRe4ZE/qeGjG4MfaX9bg2r3R69UwEkOrxtRSDFgTzcIBW4VaE93
         UoSyMGDc6EO3BR/yvxMCSH2QeKsMvB00IYfTMWYWawGzk0FchJrkuPCbHw6MHgZMzsvL
         6/xQ==
X-Gm-Message-State: AOAM533MK0D8XCyq1BdrW5Jw/P9RRya9mHqc2vYTSRWxCT0apJ17jnLD
        3yckcvj5OzmAVR0fQIHV90p7FheKvrw=
X-Google-Smtp-Source: ABdhPJxHvtwFZIYDdcb7Wsv5NUzwcyHBEXp0yOCbyViuVhrkII6N/wnAgzehSzzQG3QxL5jtvO0iTw==
X-Received: by 2002:a63:5c5c:: with SMTP id n28mr28628924pgm.198.1600476915333;
        Fri, 18 Sep 2020 17:55:15 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f28sm4621953pfq.191.2020.09.18.17.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:55:14 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 6/9] jbd2: fast commit recovery path
Date:   Fri, 18 Sep 2020 17:54:48 -0700
Message-Id: <20200919005451.3899779-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds fast commit recovery support in JBD2.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 15 +++++++++++
 fs/jbd2/recovery.c    | 59 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/jbd2.h  | 20 +++++++++++++++
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 1c3e5f39d643..6e251b5682b4 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1214,8 +1214,23 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
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
index faa97d748474..6c6107c8df96 100644
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
@@ -777,6 +821,13 @@ static int do_one_pass(journal_t *journal,
 				success = -EIO;
 		}
 	}
+
+	if (jbd2_has_feature_fast_commit(journal) &&  pass != PASS_REVOKE) {
+		err = fc_do_one_pass(journal, info, pass);
+		if (err)
+			success = err;
+	}
+
 	if (block_error && success == 0)
 		success = -EIO;
 	return success;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 11c4ec967662..8e1849d81a7f 100644
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
@@ -1224,6 +1229,21 @@ struct journal_s
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
2.28.0.681.g6f77f65b4e-goog

