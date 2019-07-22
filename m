Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A466F830
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfGVECW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44660 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfGVECU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so17001579pgl.11
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmlEew7X0/U/XFfporUebPKHddl8epkExUaJeZQqHFY=;
        b=UtbYdHCTFWxBhoTTFugwZ8BhWXAesxQaz6HTvAv/akpod1LiNKYkXAzBMkzYtmq8bn
         hk5a/VLZXJx7REtjylJjsDctcHQ6XAb0cMzpDuNCkf+5JXoNoZCiaB573cb9OV3Vds/2
         uRC9TF9kX3vu7467heHNGp8gta/vV5az9ZQM2thZbmxY6ujzra5KRfpndrgiw++A49Ma
         8vM7S+r9+k3xQfn3ifrT7UjTUjK2qoPEvP1KiGN65QbYgl6ovZ/9wJEcClI/t3042e6Q
         /1h6JO+UYXPk6CZ7rEF3GhORDj600kQXK6IwcnAym+TWIh74U4j/XjiUU1qHhEsd8BkP
         zylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmlEew7X0/U/XFfporUebPKHddl8epkExUaJeZQqHFY=;
        b=eZ6P0ewgtlUOPRAKp6ALLDT8Z99J+pSt91cghCRpWCglB2yUqGAExOV4F4C6iRh8RU
         Cv8uhVM1ydRwy3A+IYthFGUUU+lKQSSwHBtsXccvJ6wyy8s3glS9di8uMqizYvHCiIom
         ia2WpTfYk4/J0u4p5lsX1Dlqyw/YVFVrjI8LK3r0KsNtBSbXiEAeE53G4TkqalpnLyNR
         nr9RiQbClDQrS7/fvwwNE2rVl8oUCRuM6UWt1ILGoMaz1gMoMTe98juf/IBLLaWguUSR
         nWqVYwxirzHG6/vGxHYdK4DguIM0M0CLQI7F/Wj9Zy8O7ytOYEXG9cVdDt3VAjUwTfjv
         ahqA==
X-Gm-Message-State: APjAAAV/+RJGufpc5HbtxBPaqnImV5m16VvynmquT0SXgNLl2lfm0Nib
        c3fA9hUIWVppS8Ly0P7QOZ4Ydqwo
X-Google-Smtp-Source: APXvYqzijikYpk4oYwLQeIOpTt/ihnh4jorJ9GcKPiqX0D3wIt4wNyudEmCkylZX9S2y40ZLuwZUKw==
X-Received: by 2002:a63:36cc:: with SMTP id d195mr28831834pga.157.1563768138924;
        Sun, 21 Jul 2019 21:02:18 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:18 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 06/11] jbd2: fast-commit recovery path changes
Date:   Sun, 21 Jul 2019 21:00:06 -0700
Message-Id: <20190722040011.18892-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds fast-commit recovery path changes for JBD2. If we find
a fast commit block that is valid in our recovery phase call file
system specific routine to handle that block.

We also clear the fast commit flag in jbd2_mark_journal_empty() which
is called after successful recovery as well successful
checkpointing. This allows JBD2 journal to be compatible with older
versions when there are not fast commit blocks.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c  | 12 ++++++++++
 fs/jbd2/recovery.c | 60 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index cbe6e72a25e6..48214209714e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1608,6 +1608,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	bool had_fast_commit = false;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
@@ -1621,6 +1622,14 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
 	sb->s_start    = cpu_to_be32(0);
+	if (jbd2_has_feature_fast_commit(journal)) {
+		/*
+		 * When journal is clean, no need to commit fast commit flag and
+		 * make file system incompatible with older kernels.
+		 */
+		jbd2_clear_feature_fast_commit(journal);
+		had_fast_commit = true;
+	}
 
 	jbd2_write_superblock(journal, write_op);
 
@@ -1628,6 +1637,9 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
+
+	if (had_fast_commit)
+		jbd2_set_feature_fast_commit(journal);
 }
 
 
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..d900f7b1acff 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -225,8 +225,12 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
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
 
 /**
@@ -413,6 +417,50 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 		return tag->t_checksum == cpu_to_be16(csum32);
 }
 
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
+	while (next_fc_block != journal->j_last_fc) {
+		jbd_debug(3, "Fast commit replay: next block %lld",
+			  next_fc_block);
+		err = jread(&bh, journal, next_fc_block);
+		if (err)
+			break;
+
+		jhdr = (journal_header_t *)bh->b_data;
+		seq = be32_to_cpu(jhdr->h_sequence);
+		if (be32_to_cpu(jhdr->h_magic) != JBD2_MAGIC_NUMBER ||
+		    seq != expected_commit_id) {
+			break;
+		} else {
+			jbd_debug(3, "Processing fast commit blk with seq %d",
+				  seq);
+			if (pass == PASS_REPLAY &&
+			    journal->j_fc_replay_callback) {
+				err = journal->j_fc_replay_callback(journal,
+								    bh);
+				if (err)
+					break;
+			}
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
 static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
@@ -470,7 +518,7 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last_fc);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -768,6 +816,8 @@ static int do_one_pass(journal_t *journal,
 			if (err)
 				goto failed;
 			continue;
+		case JBD2_FC_BLOCK:
+			continue;
 
 		default:
 			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
@@ -799,6 +849,10 @@ static int do_one_pass(journal_t *journal,
 				success = -EIO;
 		}
 	}
+
+	if (jbd2_has_feature_fast_commit(journal) && pass == PASS_REPLAY)
+		fc_do_one_pass(journal, info, pass);
+
 	if (block_error && success == 0)
 		success = -EIO;
 	return success;
-- 
2.22.0.657.g960e92d24f-goog

