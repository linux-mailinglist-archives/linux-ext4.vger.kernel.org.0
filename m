Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B791A2BA2
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDHVz7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45998 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgDHVz5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id 128so1337370pge.12
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCaX8GE0MlE8nC+Xaw9bovnVH2hHLFL66j0y6tOc93Q=;
        b=OOKQ1Jv3WiPPzMr3b00CzuhiI4oS2TApu1RvcuxUdazT7SGp1UwRY2GpWfxdQAzu4f
         rpytg8sA8zCyi1MnC+4VlPb0UIhORFOKecQ944UThR7M7ad15L23o3wztgg3kjpoDAQ5
         pYF/S9bXhGViiuhZNU4aOIfXgoF6OX1wm7rHYfpkZKsCH6wHeOvZOgdBI981CCWC/Qeu
         7e54nf90pfiu08IjowAPhl9YyNwc10lNviei2sW8UnbAVgoqEGSb/N74OJ1p1uyqLI+V
         P+6bXihBPFkMa6Eg/Ec3V7uCOPcYxJhJlRHNW5/c3yzVM1dwTEuh0zzbV0cKsi5UvqiH
         Dm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCaX8GE0MlE8nC+Xaw9bovnVH2hHLFL66j0y6tOc93Q=;
        b=jyKcYEgekm04V+Fz7CgfFpx4HaEk++rSBRIYKF4a5efOjLjq01/WfGhAPFzT4wT09I
         THX78zNhu0EzkGvMLQUrkAkG4ClYGbpPQFlVcXNiXeq+yu2Tdp1iWv7liu3aOZZIoeGH
         5DjLNKcD6cDKGo+5L+Mh+FITOYQBAY8q+sv0hIpozfv1a+7rfCGq+RrdU12z3lz9l4XX
         WA+MYufIRwnLYR9ghg0YqYHpmKkl2tWqSjMcdgQNouC0YA+HwliUNcornIdblSs8DlJe
         QK4juR0LP7bbpiw5O01g4mPpwK08/NuijK/5iW+IdkCTYgxlf7kQje0gWEbPPxoopDx2
         DyTA==
X-Gm-Message-State: AGi0PuYJngYW8Q8Oq0ti4JCPzeyiq0EWtNqHYwmUbPlVIctLrLMXg/1b
        TvG7FtgG82dHRtMvlENx3f+tWyLx
X-Google-Smtp-Source: APiQypIsJGM+9mzJ0SrbXCPKhTC6ep0H/Rh0gWXUEDhTTZRNhP1I3J7imEl0iPK6xvooXXedb5hu5Q==
X-Received: by 2002:a65:424b:: with SMTP id d11mr8477450pgq.17.1586382955087;
        Wed, 08 Apr 2020 14:55:55 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:54 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 15/20] jbd2: add fast commit recovery path support
Date:   Wed,  8 Apr 2020 14:55:25 -0700
Message-Id: <20200408215530.25649-15-harshads@google.com>
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

Add fc_do_one_pass to invoke file system specific replay
callback and pass discovered fast commit blocks to let
file system handle those.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/recovery.c   | 67 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/jbd2.h | 13 +++++++++
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..09f069e59c36 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -35,7 +35,6 @@ struct recovery_info
 	int		nr_revoke_hits;
 };
 
-enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
 static int scan_revoke_records(journal_t *, struct buffer_head *,
@@ -225,10 +224,63 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
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
+	journal_header_t *jhdr;
+	int err = 0;
+
+	next_fc_block = journal->j_first_fc;
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
+		jhdr = (journal_header_t *)bh->b_data;
+		seq = be32_to_cpu(jhdr->h_sequence);
+		if (be32_to_cpu(jhdr->h_magic) != JBD2_MAGIC_NUMBER ||
+		    seq != expected_commit_id) {
+			jbd_debug(3, "Fast commit replay: magic / commitid error [%d / %d / %d]\n",
+				  be32_to_cpu(jhdr->h_magic), seq,
+				  expected_commit_id);
+			break;
+		}
+		jbd_debug(3, "Processing fast commit blk with seq %d",
+			  seq);
+		if (journal->j_fc_replay_callback) {
+			err = journal->j_fc_replay_callback(
+						journal, bh, pass,
+						next_fc_block -
+						journal->j_first_fc);
+			if (err)
+				break;
+		}
+		next_fc_block++;
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
@@ -470,7 +522,7 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last_fc);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -768,6 +820,9 @@ static int do_one_pass(journal_t *journal,
 			if (err)
 				goto failed;
 			continue;
+		case JBD2_FC_BLOCK:
+			pr_warn("Unexpectedly found fast commit block.\n");
+			continue;
 
 		default:
 			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
@@ -799,6 +854,10 @@ static int do_one_pass(journal_t *journal,
 				success = -EIO;
 		}
 	}
+
+	if (jbd2_has_feature_fast_commit(journal) && pass != PASS_REVOKE)
+		success = fc_do_one_pass(journal, info, pass);
+
 	if (block_error && success == 0)
 		success = -EIO;
 	return success;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 599113bef67f..01f6de8f6731 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -749,6 +749,8 @@ jbd2_time_diff(unsigned long start, unsigned long end)
 
 #define JBD2_NR_BATCH	64
 
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
 /**
  * struct journal_s - The journal_s type is the concrete type associated with
  *     journal_t.
@@ -1219,6 +1221,17 @@ struct journal_s
 	 * after every commit operation.
 	 */
 	void (*j_fc_cleanup_callback)(struct journal_s *journal);
+
+	/*
+	 * @j_fc_replay_callback:
+	 *
+	 * File-system specific function that performs replay of a fast
+	 * commit. JBD2 calls this function for each fast commit block found in
+	 * the journal.
+	 */
+	int (*j_fc_replay_callback)(struct journal_s *journal,
+				    struct buffer_head *bh,
+				    enum passtype pass, int off);
 };
 
 #define jbd2_might_wait_for_commit(j) \
-- 
2.26.0.110.g2183baf09c-goog

