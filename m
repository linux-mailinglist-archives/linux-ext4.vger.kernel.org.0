Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A55D22844D
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 17:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgGUPzp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 11:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgGUPzo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 11:55:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA85C061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 08:55:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l6so10432670plt.7
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ROGPEShlivA16/EUnPdC6N0B3J8xH2v3EZPJu2x8FoU=;
        b=qapIeqmN4obXnlkI7N4oomCGm/+3hsgeXF8XG3SFKz7LqzKaGGnp6z79Ywv2ZwebDf
         0vbBRvHlNo+IyaxFhKxQG7GHRck9mrYaVGOxLobcic3CT0/04ohOPzCq0ljbHnr/KMzq
         qTKvla5cNL1PA6ydaDMvFOArIY/092zPPHQhCt/weTR2yk3+e7Ef/KZwacXkEF4FETMY
         67/nafHxqOCr5ZZaoSwMjYjftOfOdXqYQ9LPTl5u3dsuPKgW5KpgjjLBCl4c4pLzM5j5
         SDDJoAsKznV/IGiTOXv23vEeSIFVith39iyb/gElJwHReKNEdLq1P8dkuifI59CPEjFi
         6b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROGPEShlivA16/EUnPdC6N0B3J8xH2v3EZPJu2x8FoU=;
        b=XvDn0rlCihfdIthBjxHvm+YNlu5eOP2zEy1RqGMRnuc9XKiKmVuM6ifjRu1ImBWiMZ
         R5oJ7U22FCm5E++xgcugUN4+a9InVunjJPgnQC1he8XbuxLChPSd8A9KK7GBMdSbgQ0+
         OBY0CBizRGFzAoR5SJsfpjLFU8+8D0wMXZz82qki56ucJfZzKGslvFAaG5FgkOxhcfz3
         s2fgCEznZnAzqtSqHdbILF6CykugQH9xbmRicq3R0YVSRi0HxrTAZgbSgFrf8N2QQOtR
         a1SpQsBJmFfwbHI/98mnL+GljirnNJ2l+5DMGujD+Bqp0slfI1KdGfwgsK+ElKESHy7e
         1e5w==
X-Gm-Message-State: AOAM530JLrXKUyfeMx5B9UlGfXiob1NGDbDrFo5j2ywa+an4d+b8dM/H
        nShnRGgphNKGNe98YJ/prfcYofXv
X-Google-Smtp-Source: ABdhPJwS9StLP9lz5TAghGgSaxqAYvVMBbwIP5HF7i/2zBPD2ZcvCwq8dT34HwPhOzMk2oJEF9CcAQ==
X-Received: by 2002:a17:90a:2367:: with SMTP id f94mr5722945pje.20.1595346943666;
        Tue, 21 Jul 2020 08:55:43 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b8sm3657824pjm.31.2020.07.21.08.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:55:42 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 6/7] jbd2: fast commit recovery path
Date:   Tue, 21 Jul 2020 08:54:54 -0700
Message-Id: <20200721155455.1364597-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200721155455.1364597-1-harshadshirwadkar@gmail.com>
References: <20200721155455.1364597-1-harshadshirwadkar@gmail.com>
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
index 4e366f4be5fc..7250fc0332b8 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1191,8 +1191,23 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
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

