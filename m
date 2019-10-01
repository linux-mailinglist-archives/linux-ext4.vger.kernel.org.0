Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFBC2E53
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfJAHmE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46144 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJAHmE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so8972566pgm.13
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGqBedYLzZgUreszGDKD1/yH1H0MhImKzKjZTUiPsyc=;
        b=Z/CP4mk3S1ZRZup5pJYGSEmJ35y9fopeQEMYsEaFKg503JhkjzNsHkoYRT7D+w/pLq
         r8xi3fAPR0G7IYX0qo/vxVxjRgVvBHCRPS7YUX34mXlTbWBIIy5QEUuSe17+1xdj8YoH
         IUhsxZP+t3N3Ue1C7xK6yn+8xw4IpAxaPWYqBEd3CddJzj6QOTdYqkUROMCCwZL9NtRK
         V4FX5URSqYFYZcEu8DVTScJpZrJikEmRj6fo5G3eECNkiD+d07KOISVv5BWcPZmDRnl0
         S0wRby3Om5zEe0yc83tJxj0jC39ynORXhQHtBVLbzHjApjor+YeE4z1bc1n8/FS4vv//
         wZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGqBedYLzZgUreszGDKD1/yH1H0MhImKzKjZTUiPsyc=;
        b=cJsNcZYg8Km/aHtqGkvPcY/D7ptF6gAaXC6j4gOxeRcNr98RVpsm3SoVydMDgBN9pK
         ovtAZU5TRIVJMa5r49aIdAkmGMt6zspOBuyg0aXkxPE9eY29c0iDut3+jqautyvlgWlt
         I5/vTO0q7/jCXWSDtnsffehxCqoSchg6L6XnzQcZylxhJaCX+cTyE6MBf6nPxw3jaIcG
         CYBNu4K+EsHP47SfRd5YoELkA8RAJzx6q8akQjcEzq4fMIMY27FGI5BSJOqde135gUI7
         I0eYUGR7mGrH69H8rwdqUn4kHswmzWkSuYt9NfO2xPx+KvxuWowfPbumth/ODi9RM8gU
         Xp1Q==
X-Gm-Message-State: APjAAAXAEuzAzTz3jxCjhbZ1yc9PQwbnEEphKlDxKZ+G0sJmOY7TdKHo
        AkkuzjFfqCP3k1OxPAmaBfXvlIF64zg=
X-Google-Smtp-Source: APXvYqwVBVXCjahgXEAWnWCG9lt9GPt0iHB/KEDhZHxOI9F+qJHoTzUwM9KPxWjXqRFKpV8xkp6i2Q==
X-Received: by 2002:aa7:96b8:: with SMTP id g24mr7778057pfk.163.1569915722862;
        Tue, 01 Oct 2019 00:42:02 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:02 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 02/13] jbd2: fast commit setup and enable
Date:   Tue,  1 Oct 2019 00:40:51 -0700
Message-Id: <20191001074101.256523-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/super.c      |  5 +++-
 fs/jbd2/journal.c    | 68 +++++++++++++++++++++++++++++++++-----------
 include/linux/jbd2.h | 39 +++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e376ac040cce..7725eb2105f4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4933,7 +4933,10 @@ static int ext4_load_journal(struct super_block *sb,
 		if (save)
 			memcpy(save, ((char *) es) +
 			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
-		err = jbd2_journal_load(journal);
+		if (test_opt2(sb, JOURNAL_FAST_COMMIT))
+			err = jbd2_journal_load_with_fc(journal);
+		else
+			err = jbd2_journal_load(journal);
 		if (save)
 			memcpy(((char *) es) + EXT4_S_ERR_START,
 			       save, EXT4_S_ERR_LEN);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 953990eb70a9..7c13834873ad 100644
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
@@ -1626,22 +1637,21 @@ static int load_superblock(journal_t *journal)
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
 
-
-/**
- * int jbd2_journal_load() - Read journal from disk.
- * @journal: Journal to act on.
- *
- * Given a journal_t structure which tells us which disk blocks contain
- * a journal, read the journal from disk to initialise the in-memory
- * structures.
- */
-int jbd2_journal_load(journal_t *journal)
+static int __jbd2_journal_load(journal_t *journal, bool enable_fc)
 {
 	int err;
 	journal_superblock_t *sb;
@@ -1684,6 +1694,12 @@ int jbd2_journal_load(journal_t *journal)
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
@@ -1699,6 +1715,26 @@ int jbd2_journal_load(journal_t *journal)
 	return -EIO;
 }
 
+/**
+ * int jbd2_journal_load() - Read journal from disk.
+ * @journal: Journal to act on.
+ *
+ * Given a journal_t structure which tells us which disk blocks contain
+ * a journal, read the journal from disk to initialise the in-memory
+ * structures.
+ */
+int jbd2_journal_load(journal_t *journal)
+{
+	return __jbd2_journal_load(journal, false);
+}
+
+/* Same as above but also enables fast commits. */
+int jbd2_journal_load_with_fc(journal_t *journal)
+{
+	return __jbd2_journal_load(journal, true);
+}
+
+
 /**
  * void jbd2_journal_destroy() - Release a journal_t structure.
  * @journal: Journal to act on.
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b7eed49b8ecd..84d04e1f3d92 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -67,6 +67,7 @@ extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
+#define JBD2_FAST_COMMIT_BLOCKS 128
 
 #ifdef __KERNEL__
 
@@ -918,6 +919,30 @@ struct journal_s
 	 */
 	unsigned long		j_last;
 
+	/**
+	 * @j_first_fc:
+	 *
+	 * The block number of the first fast commit block in the journal
+	 * [j_state_lock].
+	 */
+	unsigned long		j_first_fc;
+
+	/**
+	 * @j_fc_off:
+	 *
+	 * Number of fast commit blocks currently allocated.
+	 * [j_state_lock].
+	 */
+	unsigned long		j_fc_off;
+
+	/**
+	 * @j_last_fc:
+	 *
+	 * The block number one beyond the last fast commit block in the journal
+	 * [j_state_lock].
+	 */
+	unsigned long		j_last_fc;
+
 	/**
 	 * @j_dev: Device where we store the journal.
 	 */
@@ -1061,6 +1086,12 @@ struct journal_s
 	 */
 	struct buffer_head	**j_wbuf;
 
+	/**
+	 * @j_fc_wbuf: Array of fast commit bhs for
+	 * jbd2_journal_commit_transaction.
+	 */
+	struct buffer_head	**j_fc_wbuf;
+
 	/**
 	 * @j_wbufsize:
 	 *
@@ -1068,6 +1099,13 @@ struct journal_s
 	 */
 	int			j_wbufsize;
 
+	/**
+	 * @j_fc_wbufsize:
+	 *
+	 * Size of @j_fc_wbuf array.
+	 */
+	int			j_fc_wbufsize;
+
 	/**
 	 * @j_last_sync_writer:
 	 *
@@ -1398,6 +1436,7 @@ extern int	   jbd2_journal_set_features
 extern void	   jbd2_journal_clear_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern int	   jbd2_journal_load       (journal_t *journal);
+extern int	   jbd2_journal_load_with_fc(journal_t *journal);
 extern int	   jbd2_journal_destroy    (journal_t *);
 extern int	   jbd2_journal_recover    (journal_t *journal);
 extern int	   jbd2_journal_wipe       (journal_t *, int);
-- 
2.23.0.444.g18eeb5a265-goog

