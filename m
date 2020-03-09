Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A463517D991
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgCIHGK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:10 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53686 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgCIHGJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:09 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so1178924pjb.3
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KmNY2gSmRQyn8xKZllLl+Vxg9TecD6Q2SHx0pNCF20=;
        b=Piw+NHdFd7GoQumV+okvFOLiLUbbUJTr6uMTVaOJNbDFpihOVF9t86dhgiY6jhtb8a
         SRghkbThyU3Cs4bZdn2WyM8VEultHIShj/4jzOP5ZGanE0aT0O+LCaDh1jWmI8pS1QPA
         KIAOF2Q1V6VpGdSLI5oMi1p1RJg9tsODOp4tCpRnBAQhAGwi8FIF41EAaaZrFTUq83Uu
         LBvxGjZexjcVe50yX9WKMgmXHMaGimvZOdRdtq69yOlyykb27LGXnpQOJBFU7lQLgiVg
         LXUPPzpz6fL9I/Hnjb95HAmuL0DTIVIlFFrzGpZSlXA1zb6ZyuJwgxXbcisADPMDM1vI
         AENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KmNY2gSmRQyn8xKZllLl+Vxg9TecD6Q2SHx0pNCF20=;
        b=Hq+kj17SIjmqWvG1AS677eijA9SB3eD53/UAihAL3DPdD8xHEEHhsmsKgHBAted6ub
         1o1wG+2+At9OVhVrquv9N0ytIotOdgUUXzqMydA0F7Hl3je563mZergohofIMUOq6Slx
         PMd6Li8Me0pCC1mgxeYsbII0C22CgSpthLQ/ww+iM4oVbpquO7qby+hV1tN65jVm1b6i
         kBz/bEtMkSKxGEgkBESG9QOXWcLDnS9h92COSENnh8a0G1/bcpUkFYXKtsIxq2nNCXcB
         q26CpQXY8uHv7+eXyWl7mnCMXYbcKXKtZsvqqxPA/bH74KkB7lXzhi4ZsfOZ7s6P+GNR
         nmHg==
X-Gm-Message-State: ANhLgQ3MLhylOPQ/EfiZJ45Zhs6CPfxOvojkNM+pqTLg1ukwiM1B1D3D
        uKJgXQsXuAIIVRDrzRoKXzUEykgK
X-Google-Smtp-Source: ADFU+vv5wm94mw103hXrTcBxdhcWyUIp5n2wb2UWYMEEJqFOn4wYRMYIcAT6kr4pRXVOyBQSPKlJlQ==
X-Received: by 2002:a17:90b:2301:: with SMTP id mt1mr17415723pjb.76.1583737566606;
        Mon, 09 Mar 2020 00:06:06 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:06 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 15/20] jbd2: add fast commit recovery path support
Date:   Mon,  9 Mar 2020 00:05:21 -0700
Message-Id: <20200309070526.218202-15-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
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
2.25.1.481.gfbce0eb801-goog

