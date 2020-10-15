Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0993F28FA32
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgJOUiT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732649AbgJOUiR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 16:38:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BDC0613D2
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t18so22172plo.1
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Spte1N7BvFS7FvdQ3wemJ19QUNM2n1LAxYMnv2Iyzuw=;
        b=UyjOlKhHjYEe3DKuzKqROH8qH7VA0iHhUpia93aetPv18j9PkJCurNqZjClVkli9Y2
         A4CSIjfEGLvXsm1LwBVghikIDod5o54hLM7ogDxuUqcy2bJ/U0wkumDTyDej1426e5ZO
         74aENtBaAwDtC22auoUJ9REYdEmbrGs8RXpHaxcjkHvAOfV8O70PwBoB9icHT+9aujXd
         6F6KcNahxh+VGzHEuDEuYvGFIW1flzXpx0zeM7DmwVvGWM4O59ynyIGGDrzfP6ek7khh
         gS6nsuGrTLvrxkt4K9BNwzOKUXauPVE0yurSRTXBB1Dwt4auMUt2057T2/3Z8b4trVkl
         T0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Spte1N7BvFS7FvdQ3wemJ19QUNM2n1LAxYMnv2Iyzuw=;
        b=UQW2lNJ7gssFEzwd1LX7t5V+2YWEtKLPNloH1zPtw7f1f1/w33VS0MUuC0KIRGt+2a
         U0vUVxYQtiPLzRh8eSkSPyOX14c5xtBaDRLrjOgD0SNpM8RYk5s8lqmIh6JAQoalMyPv
         XTU42KoyIwkvaO18sXnnmsVCv5zs9tjHsv2TeG/EGIC1yYunweys/e2aAUz1LxXNdLH5
         VXG33guEayirMufp4JTL+8QkDfwh0+7aEUv9EPcYlLAPq6CN4urRsoxQUBF1Zx5FHQcO
         wyoJAuglG+7ergqFkw58TWaXtaJjLTe2MBaN8BBqtwlgyNq5xJpNSAy/R/rOXdjRkqXN
         L8hQ==
X-Gm-Message-State: AOAM530dgTO6WHpsXQuf9qVGA2/zfAQTYEdA/YuP2/TX/rzQvo1Vvi1p
        kPcnlqbFcFvebyGVxot7I+z5oZKOCSg=
X-Google-Smtp-Source: ABdhPJy2SHw2NufA7SHPe5GcK2cw/HPyt+YeHC9bchM0jBi7mQMDUU0XqW2mdkO2yiS8EKs3WV/6Mg==
X-Received: by 2002:a17:902:8306:b029:d5:bc88:3118 with SMTP id bd6-20020a1709028306b02900d5bc883118mr527961plb.16.1602794296504;
        Thu, 15 Oct 2020 13:38:16 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id j8sm136860pfr.121.2020.10.15.13.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:38:15 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v10 6/9] jbd2: fast commit recovery path
Date:   Thu, 15 Oct 2020 13:37:58 -0700
Message-Id: <20201015203802.3597742-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds fast commit recovery support in JBD2.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 15 ++++++++++++
 fs/jbd2/recovery.c    | 57 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/jbd2.h  | 20 +++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index e0fa3bd18346..32ed4495f9c6 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1177,8 +1177,23 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
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
index 5f61ce83e940..b9c734b34e26 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -35,7 +35,6 @@ struct recovery_info
 	int		nr_revoke_hits;
 };
 
-enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
 static int scan_revoke_records(journal_t *, struct buffer_head *,
@@ -225,10 +224,51 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	if (var >= (journal)->j_last)					\
-		var -= ((journal)->j_last - (journal)->j_first);	\
+	unsigned long _wrap_last =					\
+		jbd2_has_feature_fast_commit(journal) ?			\
+			(journal)->j_fc_last : (journal)->j_last;	\
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
+	int err = 0;
+
+	next_fc_block = journal->j_fc_first;
+	if (!journal->j_fc_replay_callback)
+		return 0;
+
+	while (next_fc_block <= journal->j_fc_last) {
+		jbd_debug(3, "Fast commit replay: next block %ld",
+			  next_fc_block);
+		err = jread(&bh, journal, next_fc_block);
+		if (err) {
+			jbd_debug(3, "Fast commit replay: read error");
+			break;
+		}
+
+		jbd_debug(3, "Processing fast commit blk with seq %d");
+		err = journal->j_fc_replay_callback(journal, bh, pass,
+					next_fc_block - journal->j_fc_first,
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
@@ -472,7 +512,9 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block,
+			  jbd2_has_feature_fast_commit(journal) ?
+			  journal->j_fc_last : journal->j_last);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -832,6 +874,13 @@ static int do_one_pass(journal_t *journal,
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
index a009d9b9c620..fb3d71ad6eea 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -751,6 +751,11 @@ jbd2_time_diff(unsigned long start, unsigned long end)
 
 #define JBD2_NR_BATCH	64
 
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
+#define JBD2_FC_REPLAY_STOP	0
+#define JBD2_FC_REPLAY_CONTINUE	1
+
 /**
  * struct journal_s - The journal_s type is the concrete type associated with
  *     journal_t.
@@ -1248,6 +1253,21 @@ struct journal_s
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
2.29.0.rc1.297.gfa9743e501-goog

