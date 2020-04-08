Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 257461A2B7D
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDHVzt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38223 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgDHVzt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so3036499plz.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvILr1IFcHUNBwIqs5oi3LTaooY1mIn9zz9BaeDPZLc=;
        b=CdKojDuPdKjG26IqIEcZczzx1BXet7R4Lz6lsT7AQwZBAM+U1oBACfDLqdTgjlPkaL
         bhS/u1Y6Q3RTkt21v4LhxkPGkmCX0tRC7tsoM2OQ7HN+kOT4NjbWIMPNgt4vBNgFxZp+
         YkMHTUfFNBko4hc4ln2ZovUMijYsEoy0hEZ02F6gMYJa2T30wDQJIJjroy74GM98Y/0B
         hdLcHjwu7Kn43RVTyxWpsl7zJ9pZ0Ew4LjKulFO014yrqR+jp2E74NxuqDd0TWYF968k
         U9vqonM8pRNOFtoFEIUzOwdRGVXOVI/TA7LYSeJqvq1r/TrEDtSj4XRrJp+wbmuztsw9
         lhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvILr1IFcHUNBwIqs5oi3LTaooY1mIn9zz9BaeDPZLc=;
        b=jh2zYwWeXnjpihrrjw5kOEQA+hsKM1a936Bj2wB9YCo72rR2o2JMytm1YQAW6i/JC1
         KKHKpziksZK8oPvcN094geC6/zg6w/WrIJdIBYF9iOQOZRQTmSLZKRlGpH6Upf9fC4PG
         xC6xjg+npBX6QZlXuy3a4RfOCQzspvqCLKjmNLpi4FcKVzj2kzopcO1/DOTJxiLyg9CM
         UNMmEIx9pjRCz8LtWvS/TxjBT0IJnn+/eg7q3pUJmiE7n4EjNYDcFet1BGwpI0yOpdQh
         x5DKZoHW94QEMdEbXOg/CbpeGa651YBivi4n57erQ2AfwTfJrzDVQeen2DNRyI/3mFUX
         tvpw==
X-Gm-Message-State: AGi0PuadcZb3xelop43XEhe6QB1aYE2ce5E7HfXQo0Hw0zXvmD072ICX
        gtFpAPr3MHaNGLzbtzMtUI379eDV
X-Google-Smtp-Source: APiQypJ0mymiZ5JFUPYrBYvt+08cvdg9Y+WI33xUEvCMqowJoqm+cMm4T/qCWzpeydDf+I4MXS7JRQ==
X-Received: by 2002:a17:90a:e016:: with SMTP id u22mr7530199pjy.65.1586382946810;
        Wed, 08 Apr 2020 14:55:46 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:46 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 03/20] ext4, jbd2: add fast commit initialization routines
Date:   Wed,  8 Apr 2020 14:55:13 -0700
Message-Id: <20200408215530.25649-3-harshads@google.com>
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

Define feature flags for fast commits and add routines to allow ext4 to
initialize fast commits. Note that we allow 128 blocks to be used for
fast commits. As of now, that's the default constant value.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h       |  2 ++
 fs/ext4/ext4_jbd2.c  |  6 ++++++
 fs/ext4/ext4_jbd2.h  | 13 +++++++++++++
 fs/ext4/super.c      |  5 +++++
 fs/jbd2/journal.c    | 11 +++++++++++
 include/linux/jbd2.h | 19 ++++++++++++++++++-
 6 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7c3d89007eca..57f8fd4fe6ad 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1770,6 +1770,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
@@ -1872,6 +1873,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7f16e1af8d5c..91d6437bc9b3 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -367,3 +367,9 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 		mark_buffer_dirty(bh);
 	return err;
 }
+void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
+{
+	if (!ext4_should_fast_commit(sb))
+		return;
+	jbd2_init_fast_commit(journal, EXT4_NUM_FC_BLKS);
+}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 4b9002f0e84c..b15cfa89cf1d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -440,6 +440,17 @@ static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
 	return 0;
 }
 
+static inline int ext4_should_fast_commit(struct super_block *sb)
+{
+	if (!ext4_has_feature_fast_commit(sb))
+		return 0;
+	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
+		return 0;
+	if (test_opt(sb, QUOTA))
+		return 0;
+	return 1;
+}
+
 static inline void ext4_update_inode_fsync_trans(handle_t *handle,
 						 struct inode *inode,
 						 int datasync)
@@ -518,4 +529,6 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+#define EXT4_NUM_FC_BLKS		128
+void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 70aaea283a63..0bfaf76200d2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3809,6 +3809,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
+
 	/* don't forget to enable journal_csum when metadata_csum is enabled. */
 	if (ext4_has_metadata_csum(sb))
 		set_opt(sb, JOURNAL_CHECKSUM);
@@ -4463,6 +4466,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
 		goto no_journal;
@@ -4821,6 +4825,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_commit_interval = sbi->s_commit_interval;
 	journal->j_min_batch_time = sbi->s_min_batch_time;
 	journal->j_max_batch_time = sbi->s_max_batch_time;
+	ext4_init_fast_commit(sb, journal);
 
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a49d0e670ddf..4e5d41d79b24 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1196,6 +1196,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	return NULL;
 }
 
+void jbd2_init_fast_commit(journal_t *journal, int num_fc_blks)
+{
+	journal->j_fc_wbufsize = num_fc_blks;
+	journal->j_wbufsize = journal->j_blocksize / sizeof(journal_block_tag_t)
+				- journal->j_fc_wbufsize;
+	journal->j_fc_wbuf = &journal->j_wbuf[journal->j_wbufsize];
+}
+
 /* jbd2_journal_init_dev and jbd2_journal_init_inode:
  *
  * Create a journal structure assigned some fixed set of disk blocks to
@@ -1722,6 +1730,9 @@ int jbd2_journal_load(journal_t *journal)
 	 */
 	journal->j_flags &= ~JBD2_ABORT;
 
+	if (journal->j_fc_wbufsize > 0)
+		jbd2_journal_set_features(journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f613d8529863..3bd1431cb222 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -288,6 +288,7 @@ typedef struct journal_superblock_s
 #define JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT	0x00000004
 #define JBD2_FEATURE_INCOMPAT_CSUM_V2		0x00000008
 #define JBD2_FEATURE_INCOMPAT_CSUM_V3		0x00000010
+#define JBD2_FEATURE_INCOMPAT_FAST_COMMIT	0x00000020
 
 /* See "journal feature predicate functions" below */
 
@@ -298,7 +299,8 @@ typedef struct journal_superblock_s
 					JBD2_FEATURE_INCOMPAT_64BIT | \
 					JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT | \
 					JBD2_FEATURE_INCOMPAT_CSUM_V2 | \
-					JBD2_FEATURE_INCOMPAT_CSUM_V3)
+					JBD2_FEATURE_INCOMPAT_CSUM_V3 | \
+					JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
 
 #ifdef __KERNEL__
 
@@ -1058,6 +1060,12 @@ struct journal_s
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
@@ -1065,6 +1073,13 @@ struct journal_s
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
@@ -1234,6 +1249,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		64BIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(async_commit,	ASYNC_COMMIT)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum2,		CSUM_V2)
 JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
+JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 
 /*
  * Journal flag definitions
@@ -1500,6 +1516,7 @@ void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
 extern int jbd2_cleanup_journal_tail(journal_t *);
 
+void jbd2_init_fast_commit(journal_t *journal, int num_fc_blks);
 /*
  * is_journal_abort
  *
-- 
2.26.0.110.g2183baf09c-goog

