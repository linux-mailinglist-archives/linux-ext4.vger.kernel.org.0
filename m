Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD09987047
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbfHIDqf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40165 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404804AbfHIDqd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so45270228pfp.7
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqweDCINfq7SD3bd+W+SfiaT2AiY7FPjQY2Mf2yBYaw=;
        b=NuQbZAuuxd29LssFWCIy0Meo7dqwrGV94+8VGKLgr+/GM54fIDBUbMT6VJjcl4BPxR
         p6Bmg8xakxYyd2MlVAJreWYnNXY4PaDIeWFU33SI78XsczG22SFZP6zZYLqOqk8ebra2
         vOf3E28eIH+j/F15ajS+eFzJBpPMkMveeAPdzpYD2+oky3ifJwwrgMzyumIgSCycBj6c
         uzvqIAqABk9SNFGrk1i5Gnv66XpP4zqi5CFDPq3LgQ8S0tcferYBgXfYKIv35xH0X5+z
         dmSyA4MbGCxQwria1wwOLUA7L1O4LhG4Ac+UQ4bFWopepS8GGt4pjXYhJXxcs0FSh0uq
         BvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqweDCINfq7SD3bd+W+SfiaT2AiY7FPjQY2Mf2yBYaw=;
        b=Y1wVCev7cGJbiZK5vzyQSjqCYhCXCcWDxKukpiMvm7cJ9xAqV5GAy1k7t3/q//3i5z
         54aNAykUVdV9aM1wFXPr3ie5bL1sbO+ClJadViQbfw6vbp2k4CCT5H6e6mKcgKNgbFcE
         XT3oBt9k2cHupFUlkMAZTEVjPOxbYZerE6MEn9ANif3viKKKhNRpmaBzA31DMgZrAr3J
         VLocBn6rC0P2Z+KCXjKHswBCK6fK0evzsiYNYQVoLl8NODBK423C9fOM8mrL1bLIe6An
         KRN/qow69NYJ3QFgAJ8WDBJpzqD+/UMj4N26Myo9FOZ2TwyvdMi9ZRfl2J5ShLxMDD7L
         0g0w==
X-Gm-Message-State: APjAAAV/OIIKDbxMYRaCoPwCmv6jaNlmXzWUagva2DMAVRkiXRQN7zPY
        5Wsc99gV5F4ryjjwXRgDNGk8sYL7
X-Google-Smtp-Source: APXvYqxGrrBUJ3RRiXvE/YbFnt5Vj1B4bX3Lga3mCEHiS0GRIkd07A4gQu1jv+RVC1MkglqmW0xjAw==
X-Received: by 2002:a63:4a04:: with SMTP id x4mr8398505pga.411.1565322392169;
        Thu, 08 Aug 2019 20:46:32 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:31 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 06/12] jbd2: fast-commit recovery path changes
Date:   Thu,  8 Aug 2019 20:45:46 -0700
Message-Id: <20190809034552.148629-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
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

Changelog:

V2: Fixed checkpatch error.
---
 fs/jbd2/journal.c  | 12 ++++++++++
 fs/jbd2/recovery.c | 59 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1e15804b2c3c..ae4584a60cc3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1604,6 +1604,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	bool had_fast_commit = false;
 
 	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
@@ -1617,6 +1618,14 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 
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
 
@@ -1624,6 +1633,9 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
+
+	if (had_fast_commit)
+		jbd2_set_feature_fast_commit(journal);
 }
 
 
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..3a6cd1497504 100644
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
@@ -413,6 +417,49 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
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
+		}
+		jbd_debug(3, "Processing fast commit blk with seq %d",
+			  seq);
+		if (pass == PASS_REPLAY &&
+		    journal->j_fc_replay_callback) {
+			err = journal->j_fc_replay_callback(journal,
+							    bh);
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
 static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
@@ -470,7 +517,7 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last_fc);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -768,6 +815,8 @@ static int do_one_pass(journal_t *journal,
 			if (err)
 				goto failed;
 			continue;
+		case JBD2_FC_BLOCK:
+			continue;
 
 		default:
 			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
@@ -799,6 +848,10 @@ static int do_one_pass(journal_t *journal,
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
2.23.0.rc1.153.gdeed80330f-goog

