Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95EA22887E
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgGUSp0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgGUSpV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 14:45:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F507C061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so12353276pgb.6
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ib0vVpoPihEcw5Z480oc1/xYUKQ7zNAZIkc3ggEc4xg=;
        b=iaY+Y0DZuVxbSvNdlRIIl9XpQvzkXUBA7YAqdKOJAF5HZuu8pudzG2auVn/Mcvpb/8
         T/W0Xrk6XyeHhRl8tPXqXRPXN3p/oPCFO1I0Y9cNZgutJbkAncOdqd8PL42qaWD8Avr8
         XF2f3kowK92p5Wk/QAyUq3XmhHBHS6seNk3A4fqvkj+o+GGxq7GZHbB+dmGx7+DlMs/I
         QbPo3nzMc2sFr/nmsWeeuHBJ52yNTnDbiVKtl69ihS/slG9Z3NPzecUZk+vhx8El3+4k
         4jTpCszVTEuylxe+l4zPVWVoVHY4U0hPJnlbpoM9V0Re+qpHWJhuppbI5L3Fd605s8qG
         llEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ib0vVpoPihEcw5Z480oc1/xYUKQ7zNAZIkc3ggEc4xg=;
        b=GVXwDlFuvyYNtbSDeG3ZaYkcbZAbiOF9J2ylu2h6tHwZzgmrv4o92JI65Y8QOhgWz6
         fcGOCHFQjJe5ZtccpcgyWKU5d84rWHhbxWcf6AZgO2ICU7UR8wY9uJuuzANQU2W8spse
         UZUK7KHfxXSw6P7EpkOM4p50rx1MUrHcTtUTTzS7mCU7hYVwOSpL2hOuZjgbC0c9moqX
         pDq1Aitn9W0Ga/PUOOB4uxocL1vt9zC5UzP6GqE1N5fNLsvigcEeZNgYlICX5rKoAdvh
         bTBiv9XBmaf0BE1RyXdUf1xKtADsrjPweiPCRi2kIcoMxFxcDJRNyOEbOry+/jK8lgGz
         /jdg==
X-Gm-Message-State: AOAM5337dEDMIUY6FAEzchtQH8GvxjppeDp17vFMVCVz8MA2qUmnOhKX
        ykPWG1l1cr88CBHlkxbT7sipo5hl
X-Google-Smtp-Source: ABdhPJzjaROd6nAjW0V1AEQBOAM6IBlqzWHhT18A1eNKHapmjAgkglpERLVGA0ZP9ivFcyzdmg1hvA==
X-Received: by 2002:a62:8096:: with SMTP id j144mr26090945pfd.78.1595357119887;
        Tue, 21 Jul 2020 11:45:19 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b13sm4179890pjl.7.2020.07.21.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:45:19 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 3/7] ext4 / jbd2: add fast commit initialization
Date:   Tue, 21 Jul 2020 11:43:51 -0700
Message-Id: <20200721184355.1616986-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
References: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds fast commit area trackers in the journal_t
structure. These are initialized via the jbd2_fc_init() routine that
this patch adds. This patch also adds ext4/fast_commit.c and
ext4/fast_commit.h files for fast commit code that will be added in
subsequent patches in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/Makefile      |  3 ++-
 fs/ext4/ext4.h        |  4 ++++
 fs/ext4/fast_commit.c | 20 +++++++++++++++++
 fs/ext4/fast_commit.h |  9 ++++++++
 fs/ext4/super.c       |  1 +
 fs/jbd2/journal.c     | 52 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/jbd2.h  | 39 ++++++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 6 deletions(-)
 create mode 100644 fs/ext4/fast_commit.c
 create mode 100644 fs/ext4/fast_commit.h

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 4ccb3c9189d8..ec33ca55acbb 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -9,7 +9,8 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 		extents_status.o file.o fsmap.o fsync.o hash.o ialloc.o \
 		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
 		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
-		super.o symlink.o sysfs.o xattr.o xattr_trusted.o xattr_user.o
+		super.o symlink.o sysfs.o xattr.o xattr_trusted.o xattr_user.o \
+		fast_commit.o
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 67419a045748..e688a61c4c58 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -926,6 +926,7 @@ do {									       \
 #endif /* defined(__KERNEL__) || defined(__linux__) */
 
 #include "extents_status.h"
+#include "fast_commit.h"
 
 /*
  * Lock subclasses for i_data_sem in the ext4_inode_info structure.
@@ -2620,6 +2621,9 @@ extern int ext4_init_inode_table(struct super_block *sb,
 				 ext4_group_t group, int barrier);
 extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
 
+/* fast_commit.c */
+
+void ext4_fc_init(struct super_block *sb, journal_t *journal);
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern long ext4_mb_stats;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
new file mode 100644
index 000000000000..0dad8bdb1253
--- /dev/null
+++ b/fs/ext4/fast_commit.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * fs/ext4/fast_commit.c
+ *
+ * Written by Harshad Shirwadkar <harshadshirwadkar@gmail.com>
+ *
+ * Ext4 fast commits routines.
+ */
+#include "ext4_jbd2.h"
+
+void ext4_fc_init(struct super_block *sb, journal_t *journal)
+{
+	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
+		return;
+	if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
+		pr_warn("Error while enabling fast commits, turning off.");
+		ext4_clear_feature_fast_commit(sb);
+	}
+}
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
new file mode 100644
index 000000000000..8362bf5e6e00
--- /dev/null
+++ b/fs/ext4/fast_commit.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __FAST_COMMIT_H__
+#define __FAST_COMMIT_H__
+
+/* Number of blocks in journal area to allocate for fast commits */
+#define EXT4_NUM_FC_BLKS		256
+
+#endif /* __FAST_COMMIT_H__ */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 37450c3a4b23..aab08cfb78e5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4819,6 +4819,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_commit_interval = sbi->s_commit_interval;
 	journal->j_min_batch_time = sbi->s_min_batch_time;
 	journal->j_max_batch_time = sbi->s_max_batch_time;
+	ext4_fc_init(sb, journal);
 
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a49d0e670ddf..494de5410076 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1178,6 +1178,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal->j_wbuf)
 		goto err_cleanup;
 
+	if (journal->j_fc_wbufsize > 0) {
+		journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
+					sizeof(struct buffer_head *),
+					GFP_KERNEL);
+		if (!journal->j_fc_wbuf)
+			goto err_cleanup;
+	}
+
 	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
 	if (!bh) {
 		pr_err("%s: Cannot get buffer for journal superblock\n",
@@ -1191,11 +1199,22 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 err_cleanup:
 	kfree(journal->j_wbuf);
+	kfree(journal->j_fc_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	kfree(journal);
 	return NULL;
 }
 
+int jbd2_fc_init(journal_t *journal, int num_fc_blks)
+{
+	journal->j_fc_wbufsize = num_fc_blks;
+	journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
+				sizeof(struct buffer_head *), GFP_KERNEL);
+	if (!journal->j_fc_wbuf)
+		return -ENOMEM;
+	return 0;
+}
+
 /* jbd2_journal_init_dev and jbd2_journal_init_inode:
  *
  * Create a journal structure assigned some fixed set of disk blocks to
@@ -1313,11 +1332,20 @@ static int journal_reset(journal_t *journal)
 	}
 
 	journal->j_first = first;
-	journal->j_last = last;
 
-	journal->j_head = first;
-	journal->j_tail = first;
-	journal->j_free = last - first;
+	if (jbd2_has_feature_fast_commit(journal) &&
+	    journal->j_fc_wbufsize > 0) {
+		journal->j_last_fc = last;
+		journal->j_last = last - journal->j_fc_wbufsize;
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
@@ -1659,9 +1687,18 @@ static int load_superblock(journal_t *journal)
 	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
 	journal->j_tail = be32_to_cpu(sb->s_start);
 	journal->j_first = be32_to_cpu(sb->s_first);
-	journal->j_last = be32_to_cpu(sb->s_maxlen);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
 
+	if (jbd2_has_feature_fast_commit(journal) &&
+	    journal->j_fc_wbufsize > 0) {
+		journal->j_last_fc = be32_to_cpu(sb->s_maxlen);
+		journal->j_last = journal->j_last_fc - journal->j_fc_wbufsize;
+		journal->j_first_fc = journal->j_last + 1;
+		journal->j_fc_off = 0;
+	} else {
+		journal->j_last = be32_to_cpu(sb->s_maxlen);
+	}
+
 	return 0;
 }
 
@@ -1722,6 +1759,9 @@ int jbd2_journal_load(journal_t *journal)
 	 */
 	journal->j_flags &= ~JBD2_ABORT;
 
+	if (journal->j_fc_wbufsize > 0)
+		jbd2_journal_set_features(journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
@@ -1805,6 +1845,8 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	if (journal->j_chksum_driver)
 		crypto_free_shash(journal->j_chksum_driver);
+	if (journal->j_fc_wbufsize > 0)
+		kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
 	kfree(journal);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index e86d1e6e274a..65b7107dcaa0 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -910,6 +910,30 @@ struct journal_s
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
@@ -1060,6 +1084,12 @@ struct journal_s
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
@@ -1067,6 +1097,13 @@ struct journal_s
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
@@ -1503,6 +1540,8 @@ void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
 extern int jbd2_cleanup_journal_tail(journal_t *);
 
+/* Fast commit related APIs */
+int jbd2_fc_init(journal_t *journal, int num_fc_blks);
 /*
  * is_journal_abort
  *
-- 
2.28.0.rc0.105.gf9edc3c819-goog

