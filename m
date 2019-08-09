Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DF487044
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405193AbfHIDqd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41672 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405160AbfHIDqb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so34799619pgg.8
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEIK6eOdIhxu0EqtgKItuoTZsy4oa4Lp3C968BFlQw0=;
        b=WYa2FHHzRlPGn1HLWQapugk3IUij+LveBo014tvtaMTbnKOw1xcnzh3cVsAkaTC/jq
         2FQ+4a0NxCKhNXXTtNmBeN3xrvwjiAIqzNoQfbq41DptZJnRlIgNUyq0OYGr2+06zhuL
         k5K1BFAGTIyGfYlIE1qfv4NX7s7LtiCk3XDqWd4H9RMM/NY+N1ZMoy7MPl40CrfqrJPY
         8Hz5G6rO8b8WsYvmqOoLvUfWuSpbPZuUz6604gU1gp5m7W8MBmWWOkJXGfNIxKx7a25L
         sMBOpVHaRNKVMJnJoapU7/DDGz8jtwH8bFRwttQMbIwYqowHahgwF/gTO92oFuEad9sM
         eDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEIK6eOdIhxu0EqtgKItuoTZsy4oa4Lp3C968BFlQw0=;
        b=W7A59ZrEJuB6Smb1IplOFiIHold/w5ljDmFxYXfQA6uehjYinZMHmp0QFwRBVNpp48
         cK4rOXIsuKabuKgADVEmDjNIHwRzugf/AkjmY1a3qRDKd5FFhVYbVk2HAbSaeCntntm1
         M0sNQBIiVOd+sDuZ1JUn+W6zutNZ7Vl/TeCS6wXHbkbk3ihrfaTG0FzQ+2t9lLz+PTJ+
         Dk+OahFPEugjK9eQTsm/q7tWrqFOgrh+YdZ8+FWtKFox9Nuf68XOW0CnTR4HTwEz4GSr
         GhbWGVdYjRguxP1KIbtG05UUrA+lq6KtVAwjoiywEKEzUj1NgQ9LKNIzOPeBYDyBOrtZ
         5d4g==
X-Gm-Message-State: APjAAAXlbP13pcK/tXQl+CBaauJz9mN5vqj2HzRxWc+hvYHG7WdSqgua
        wA6Kk2cK5JNRZuCaZeqxMGr+FUmc
X-Google-Smtp-Source: APXvYqzdzyJZxaHSuqJTEqJqFQpKJsqhqdB8AXQjcZ3kLm7or91yf7Yz7JGsGwK97A0fQAte9U4o3Q==
X-Received: by 2002:a17:90a:bc0c:: with SMTP id w12mr6970820pjr.111.1565322390279;
        Thu, 08 Aug 2019 20:46:30 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:29 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 03/12] jbd2: fast commit setup and enable
Date:   Thu,  8 Aug 2019 20:45:43 -0700
Message-Id: <20190809034552.148629-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
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

Changelog:

V2: No changes since V1
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
index 9a750b732241..153840b422cc 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1476,7 +1476,7 @@ extern int	   jbd2_journal_set_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern void	   jbd2_journal_clear_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
-extern int	   jbd2_journal_load       (journal_t *journal);
+extern int	   jbd2_journal_load(journal_t *journal, bool enable_fc);
 extern int	   jbd2_journal_destroy    (journal_t *);
 extern int	   jbd2_journal_recover    (journal_t *journal);
 extern int	   jbd2_journal_wipe       (journal_t *, int);
-- 
2.23.0.rc1.153.gdeed80330f-goog

