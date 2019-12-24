Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1FC129EDE
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLXIPC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38759 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfLXIPB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:15:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so10419915pfc.5
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9RngX34LDeZmMMgmNpZJ49nX/UFl1ytSa1Gai5v7dM=;
        b=iWV9YZuu063K6Y4butyTDM/8Gsy6vakdDU6yxcm8eoQvwwekbDIn7yP1FyKj4k0hms
         /I+z9AdjZDMgEClYQ8m4qoo+CiYAb9wBqFn+JUo+Sx90Gn849903UeKqG4YTfKccUVN8
         aEpBmMJ8fQUjNjvAf6OqsdGr1DOU1cMIJJ2/9M2m7hRuB+o5UbRJjf2wfFv/dVNhlHbK
         AQZT3/vi7yUN+JC7scPuRkPLQjkNbtIHYpwUL3JijjlE7MvcWEw+jVZ4Nncr6z0dlgrV
         /R+EpSglXmX2CRZno8jMOG0IfJHiJnKjcu5plcjwG8o9a0bAO6jqMP1tE+dkOIwisZIn
         yd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9RngX34LDeZmMMgmNpZJ49nX/UFl1ytSa1Gai5v7dM=;
        b=Je3kdSSAwXB9JXp03Gxqscjt5c2hc5C7aylHnOnKnbpNRMQjYP3ill4SIJCzVJZeta
         +ZTVJDA6Y/WikVjLADNz6IcA/0f3PQK8bUgaMjPLXR0FF8Mja1pZICJLrB5+jxdPuI2M
         A3yLLAg732k4p5Bg3MZaQeQ2myEdfmyIju539kR+ndQZs6tCCV3H0hLHRtNcCxnMEyOo
         i965NRkiv6peAw6CXx1UQpmjBqomI32eEZHqaqruNeNMnQKJlN3g7V+yfRDEwjpXhJVf
         3ixyQro0r2DbtTFrBotgfmlN3Jy3OEw+NZJRlkl1KbUY95Cw41Y8CEyn3NVog4gcwnO7
         JmmA==
X-Gm-Message-State: APjAAAVWuV/0zep0BqrQWrC+3YxORO1t6zOnL0kV6ng2zVyZqK26oB1y
        TA1nv7gzV+25Oorx2/GVlRERCRCp
X-Google-Smtp-Source: APXvYqzvD2EKHW9ZfsCAMqUmJAstc44IMuxm6WPcz+q2tRu7caz58f21QHz8SszU3CZM5rFhEtCAdA==
X-Received: by 2002:a63:1322:: with SMTP id i34mr36535629pgl.163.1577175299944;
        Tue, 24 Dec 2019 00:14:59 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:59 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 15/20] jbd2: add fast commit recovery path support
Date:   Tue, 24 Dec 2019 00:13:19 -0800
Message-Id: <20191224081324.95807-15-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
index d450dcb93e51..0b49c8ff0563 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -757,6 +757,8 @@ jbd2_time_diff(unsigned long start, unsigned long end)
 
 #define JBD2_NR_BATCH	64
 
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
 /**
  * struct journal_s - The journal_s type is the concrete type associated with
  *     journal_t.
@@ -1220,6 +1222,17 @@ struct journal_s
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
2.24.1.735.g03f4e72817-goog

