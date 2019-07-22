Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F036F82C
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfGVECS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37925 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfGVECS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so8172868pgu.5
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iv4e1fGEQVCg8Fe8xEPIEwzrTA6lfy7LglgtR80lJPM=;
        b=NoPWHzIOYX41Ttq44jNNKn4DzmXBaefa+8Pmj5BsGTjBlMoTX2JMKJERf/skP8GWqC
         IPhOtrMUZFxZhoD+Gn1Qhi9RtRbzJT8w8ivz0SBuaaxg1aBrrif7FZC4d8mmgHYIMHX4
         O2QCWNn7pcZkkykTozYCBp9owcOD080DXzsGqXQQUGyGDr9JVfc/f1U06TgqPPSVu5P3
         BYR4vzWHQLp8H26E4SQeckaMIq8Pvgt7J8Itf5HzYKLcBJRxf0qe2kC4JE0zJUCunNPN
         3EEk++tOOJPvfUTIaLyJMMV+lF2Ep+BqvZdQdPbyiOQBNafyqEywNn4+GWbuZpXduZdn
         UxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iv4e1fGEQVCg8Fe8xEPIEwzrTA6lfy7LglgtR80lJPM=;
        b=TVTzjD8iGIOCEsRVWJ1hm7yBSbAESprtkAp+RjXeT/P2KkWRr272TIJ0i4bwyZC7NX
         9cOY1ps80hLTX+4/nJFtfw9aJ4x1YGZFxwR/aJeqm2Uzvwj4kOvwkDxepqz4ScJiJaET
         BlYx17hSS7sPHVFPWy1W+mH1WqnMOL4xluh3L5GRFxd23ZorcdO2rYuTEFBCStUBpsKa
         F3xZsiWW1UA8LizETHgcwn2y6IREFTc2DdapHrEJcaxIY/u6dipKOu8MgY3UdULGQ2mt
         AAqlJVAE/ZhK4JAJ/QknekOWzSpzczDzWCiP/oUE6AVdrWd+NPaTczS0qEJ74qukw4Zc
         H4CQ==
X-Gm-Message-State: APjAAAX0hC45hriEW8vXNkgMKwgikmXalXfZLNm943Uvo7U6Caz897XG
        sW22bmRDYjy4aalnldi/zOKHQ8qS
X-Google-Smtp-Source: APXvYqx+S39V/KxwGwZjNKPd0Mq3TfgKrse07MtP8jScN16eyGglc50lc9jgfSI+dBZifpGVVzIwAA==
X-Received: by 2002:a17:90a:29c5:: with SMTP id h63mr71576369pjd.83.1563768136809;
        Sun, 21 Jul 2019 21:02:16 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:16 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 03/11] jbd2: fast commit setup and enable
Date:   Sun, 21 Jul 2019 21:00:03 -0700
Message-Id: <20190722040011.18892-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch allows file systems to turn fast commits on and thereby
restrict the normal journalling space to total journal blocks minus
JBD2_FAST_COMMIT_BLOCKS. Fast commits are not actually performed, just
the interface to turn fast commits on is opened.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/super.c      |  3 ++-
 fs/jbd2/journal.c    | 39 ++++++++++++++++++++++++++++++++-------
 fs/ocfs2/journal.c   |  4 ++--
 include/linux/jbd2.h |  2 +-
 4 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e376ac040cce..81c3ec165822 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4933,7 +4933,8 @@ static int ext4_load_journal(struct super_block *sb,
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
-		err = jbd2_journal_load(journal);
+		err = jbd2_journal_load(journal,
+					test_opt2(sb, JOURNAL_FAST_COMMIT));
 		if (save)
 			memcpy(((char *) es) + EXT4_S_ERR_START,
 			       save, EXT4_S_ERR_LEN);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 953990eb70a9..59ad709154a3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1159,12 +1159,15 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_blk_offset = start;
 	journal->j_maxlen = len;
 	n = journal->j_blocksize / sizeof(journal_block_tag_t);
-	journal->j_wbufsize = n;
+	journal->j_wbufsize = n - JBD2_FAST_COMMIT_BLOCKS;
 	journal->j_wbuf = kmalloc_array(n, sizeof(struct buffer_head *),
 					GFP_KERNEL);
 	if (!journal->j_wbuf)
 		goto err_cleanup;
 
+	journal->j_fc_wbuf = &journal->j_wbuf[journal->j_wbufsize];
+	journal->j_fc_wbufsize = JBD2_FAST_COMMIT_BLOCKS;
+
 	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
 	if (!bh) {
 		pr_err("%s: Cannot get buffer for journal superblock\n",
@@ -1297,11 +1300,19 @@ static int journal_reset(journal_t *journal)
 	}
 
 	journal->j_first = first;
-	journal->j_last = last;
 
-	journal->j_head = first;
-	journal->j_tail = first;
-	journal->j_free = last - first;
+	if (jbd2_has_feature_fast_commit(journal)) {
+		journal->j_last_fc = last;
+		journal->j_last = last - JBD2_FAST_COMMIT_BLOCKS;
+		journal->j_first_fc = journal->j_last + 1;
+		journal->j_fc_off = 0;
+	} else {
+		journal->j_last = last;
+	}
+
+	journal->j_head = journal->j_first;
+	journal->j_tail = journal->j_first;
+	journal->j_free = journal->j_last - journal->j_first;
 
 	journal->j_tail_sequence = journal->j_transaction_sequence;
 	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
@@ -1626,9 +1637,17 @@ static int load_superblock(journal_t *journal)
 	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
 	journal->j_tail = be32_to_cpu(sb->s_start);
 	journal->j_first = be32_to_cpu(sb->s_first);
-	journal->j_last = be32_to_cpu(sb->s_maxlen);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
 
+	if (jbd2_has_feature_fast_commit(journal)) {
+		journal->j_last_fc = be32_to_cpu(sb->s_maxlen);
+		journal->j_last = journal->j_last_fc - JBD2_FAST_COMMIT_BLOCKS;
+		journal->j_first_fc = journal->j_last + 1;
+		journal->j_fc_off = 0;
+	} else {
+		journal->j_last = be32_to_cpu(sb->s_maxlen);
+	}
+
 	return 0;
 }
 
@@ -1641,7 +1660,7 @@ static int load_superblock(journal_t *journal)
  * a journal, read the journal from disk to initialise the in-memory
  * structures.
  */
-int jbd2_journal_load(journal_t *journal)
+int jbd2_journal_load(journal_t *journal, bool enable_fc)
 {
 	int err;
 	journal_superblock_t *sb;
@@ -1684,6 +1703,12 @@ int jbd2_journal_load(journal_t *journal)
 		return -EFSCORRUPTED;
 	}
 
+	if (enable_fc)
+		jbd2_journal_set_features(journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
+	else
+		jbd2_journal_clear_features(journal, 0, 0,
+					    JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 930e3d388579..3b4d91b16e8e 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1057,7 +1057,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
 
 	osb = journal->j_osb;
 
-	status = jbd2_journal_load(journal->j_journal);
+	status = jbd2_journal_load(journal->j_journal, false);
 	if (status < 0) {
 		mlog(ML_ERROR, "Failed to load journal!\n");
 		goto done;
@@ -1642,7 +1642,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 		goto done;
 	}
 
-	status = jbd2_journal_load(journal);
+	status = jbd2_journal_load(journal, false);
 	if (status < 0) {
 		mlog_errno(status);
 		if (!igrab(inode))
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 6133a0cd22da..389bc7cd2410 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1475,7 +1475,7 @@ extern int	   jbd2_journal_set_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern void	   jbd2_journal_clear_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
-extern int	   jbd2_journal_load       (journal_t *journal);
+extern int	   jbd2_journal_load(journal_t *journal, bool enable_fc);
 extern int	   jbd2_journal_destroy    (journal_t *);
 extern int	   jbd2_journal_recover    (journal_t *journal);
 extern int	   jbd2_journal_wipe       (journal_t *, int);
-- 
2.22.0.657.g960e92d24f-goog

