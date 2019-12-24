Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9B129ED2
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLXIOy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53663 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXIOx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:53 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so890565pjc.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WDIC74AW1ayrDwv4lHNnO+b9nYQSzHeexdgL3QkWAC8=;
        b=gvNSeCt/jLFQXA7Z4ZqM45iBEQzYHAo9AfzhgrbqlJRu63zx+I8uLptml2jPyWep3h
         vwhM4QIE1oz4KDVuisvxSBpRuqJK3ye+wkuuKDeDMclnU2RVAuK8IVbCnjCeFEbSgOAc
         uI3XXprB8uz8ccDXOtg5UnVfHP57cJAYyzYsQNQJ1oMbuouyR9RJUH/nh6LKkF97s+D4
         y2COVAoRYVz0Dx5heBwx06MRUHdLI8nzIMfj5Z8qYAHDlRPXrJiNNeCktGZhLbAiKaM6
         AlsnxGihRL6UD85CgojhEjE50Gb4PtXQWsPn9GEzEDZ7NDMPdyiPCJeVd4jKDX+fPKal
         sLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WDIC74AW1ayrDwv4lHNnO+b9nYQSzHeexdgL3QkWAC8=;
        b=M+lCd+nOerm93QPENKO7OnKLWe1VH3UP5YYrCJXf3uP/q2wwcpjP550TJkhPtD1kqw
         zuMelc1LWTPBla/Xy16qJ1TMBak2MhNazrkvtLl2imFROPnHG8qFNOlNHJV1Ush6Rl8H
         n1lsN7vpzwFhdCXV4LSao1hWd9sOhqrxg0ASyACJxWE9WP3aX+KA8YcwBVbPnOAwXbHT
         CSmPZsAmT+uRB1eFD7YigGxjvJ6LXql24qDTKnr3YWvS7Vr9mw4ow2QmdJLME6/yFPdN
         xs9vdTd8HE/WkHwDRq+8wzfi2OgRRhxCy+vBhEkA/x9g99sQtxb7smOwXw6EKy9aOi8D
         zf/A==
X-Gm-Message-State: APjAAAWx0XjCW5XR7+Mx9wmZ8gwJ0KsUzgevBOl9YftJ0lRTDbDf9cnk
        iy11LpMH7j8fA2VmwrCKLvnPElKW
X-Google-Smtp-Source: APXvYqyYShcV7Q/CAfdXvW18hA4gJJmJolAtK0LKgXKyMD21SdhNFyptQ8kA8tYZp/g4EhEIKNVIHw==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr4340072pjb.49.1577175292395;
        Tue, 24 Dec 2019 00:14:52 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:51 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 03/20] ext4, jbd2: add fast commit initialization routines
Date:   Tue, 24 Dec 2019 00:13:07 -0800
Message-Id: <20191224081324.95807-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
index 9339eb6bf9b0..16ffe6ed9e74 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1685,6 +1685,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_COMPAT_RESIZE_INODE	0x0010
 #define EXT4_FEATURE_COMPAT_DIR_INDEX		0x0020
 #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2	0x0200
+#define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT4_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
@@ -1786,6 +1787,7 @@ EXT4_FEATURE_COMPAT_FUNCS(xattr,		EXT_ATTR)
 EXT4_FEATURE_COMPAT_FUNCS(resize_inode,		RESIZE_INODE)
 EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
+EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
 EXT4_FEATURE_RO_COMPAT_FUNCS(large_file,	LARGE_FILE)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7c70b08d104c..c2ae21f5049b 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -330,3 +330,9 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
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
index ef8fcf7d0d3b..e5bd95a088e8 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -378,6 +378,17 @@ static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
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
@@ -459,4 +470,6 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+#define EXT4_NUM_FC_BLKS		128
+void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d635040f21b9..28675cd78813 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3759,6 +3759,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
 	set_opt(sb, POSIX_ACL);
 #endif
+	if (ext4_has_feature_fast_commit(sb))
+		set_opt2(sb, JOURNAL_FAST_COMMIT);
+
 	/* don't forget to enable journal_csum when metadata_csum is enabled. */
 	if (ext4_has_metadata_csum(sb))
 		set_opt(sb, JOURNAL_CHECKSUM);
@@ -4376,6 +4379,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
 		goto no_journal;
@@ -4734,6 +4738,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_commit_interval = sbi->s_commit_interval;
 	journal->j_min_batch_time = sbi->s_min_batch_time;
 	journal->j_max_batch_time = sbi->s_max_batch_time;
+	ext4_init_fast_commit(sb, journal);
 
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1c58859aa592..fa22bdb7d952 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1181,6 +1181,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
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
@@ -1682,6 +1690,9 @@ int jbd2_journal_load(journal_t *journal)
 		return -EFSCORRUPTED;
 	}
 
+	if (journal->j_fc_wbufsize > 0)
+		jbd2_journal_set_features(journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 603fbc4e2f70..3495fe1e2c36 100644
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
 
@@ -1059,6 +1061,12 @@ struct journal_s
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
@@ -1066,6 +1074,13 @@ struct journal_s
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
@@ -1235,6 +1250,7 @@ JBD2_FEATURE_INCOMPAT_FUNCS(64bit,		64BIT)
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
2.24.1.735.g03f4e72817-goog

