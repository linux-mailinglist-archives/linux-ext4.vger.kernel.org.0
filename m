Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8FCD17D985
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCIHGA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:00 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50958 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIHGA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:00 -0400
Received: by mail-pj1-f65.google.com with SMTP id u10so2328540pjy.0
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWGNfcLsHEfKeNQsp0zhJk4reDjnv5Gm5ANknkk8Mxg=;
        b=SU73onJm7ynrzrKV7qFeN69ZGawwegJACzlLTTwgIA3seVSJMaS5PTmp2Ejlvadwe1
         1ptmIXANhldtuLQ53svoI5T7nkDx9ozAcTaTDm0dgBzDvJmoNdhuPlspJywTjtJbqDD8
         YODm5X9efcENAa7UapEQX+2cpNTIvFw71qO7MnJPRGi2XeMOJ1dm2yEs8SSaQVBq3VIY
         MdkAqMA6N9At2930LbbTUWsT07TsNOTsdD+1Sw6sUQWI3/xp2gL2U79Onf0e+FxYH2dz
         286ZMvEXI6uhTpzBehY7qntLQzryvlt5TSW1q6LtcpqPiZK+7raA0xSMnQyPckSYvgTi
         XvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWGNfcLsHEfKeNQsp0zhJk4reDjnv5Gm5ANknkk8Mxg=;
        b=E8gkfGDUhbEvFoLEN/ZjqVN2sVxu8sERT4Y0xLOaM0mcIGMgC0kGDwEFF8XrK9KD1C
         t/gSJQOxiLbQ1byqvQLTo+qEZGEFF0KJKLLVpy7IMTIeTl5ek9OFbEoGLayGrvD+Gn67
         Bmr2uinGsJYL92XhUmA1x3Y0NzTj3bQELrjJXilp44s2XdQVWrNPGjYGYsOvuNWn3hoK
         WzTbUoop1h15KgFKbl1dzSH7yoB/3BeFUpvisVJ0IwqoziFsmkSOBG6eJmxRTftl0GuD
         qX7rMHLiPt1Egz+tnS7+LstuPYMR+KG1GfS9SnPBP5Wujztdv2YuFxWoG4ewQEnm2Hlt
         cWsw==
X-Gm-Message-State: ANhLgQ36G2ujN7b9edKQRRjLQzO2w0B/deZhyDBTLHQvCisUsuk9+cQX
        bY3H07K2dCsPVbVongQ7VrKtyob+
X-Google-Smtp-Source: ADFU+vtEzv66LJDQYx+yLztbV0GlXhPUaK5KjWp5JSnToTrB20jA6FN76bnYZDnCSxgBtspLdL09ZA==
X-Received: by 2002:a17:902:bc8a:: with SMTP id bb10mr14609806plb.102.1583737558271;
        Mon, 09 Mar 2020 00:05:58 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:05:57 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 03/20] ext4, jbd2: add fast commit initialization routines
Date:   Mon,  9 Mar 2020 00:05:09 -0700
Message-Id: <20200309070526.218202-3-harshadshirwadkar@gmail.com>
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
index f96a672232a1..7a69235ea7b2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1771,6 +1771,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
@@ -1873,6 +1874,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 1f53d64e42a5..fd9d138b19c8 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -371,3 +371,9 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
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
index 7ea4f6fa173b..9813efec4b37 100644
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
@@ -515,4 +526,6 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+#define EXT4_NUM_FC_BLKS		128
+void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 00571de3390b..67ea93532af4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3804,6 +3804,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
+
 	/* don't forget to enable journal_csum when metadata_csum is enabled. */
 	if (ext4_has_metadata_csum(sb))
 		set_opt(sb, JOURNAL_CHECKSUM);
@@ -4454,6 +4457,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
 		goto no_journal;
@@ -4812,6 +4816,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
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
2.25.1.481.gfbce0eb801-goog

