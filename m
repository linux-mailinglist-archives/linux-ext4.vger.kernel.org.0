Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28E28FA30
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgJOUiS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 16:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbgJOUiQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 16:38:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79723C0613D3
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so104391pjr.3
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XsQY8wRB1tPgge7no2XDUZ9MO6qTw6rvzdX9cl9suyQ=;
        b=j/bVNoHFEgmj21M9WpWWqgCijzUDS9xXIirIDeKgu4EJIW5qxtZbeZpkdgqm9vuipa
         ashreGcvT5x9Bs8DjI4pq9dc97vvGbgzirSYw5Zk+Kd4Ouip2FX8XEQiwtFpNeeayhKw
         ljjCyEkTBQGvuLUoNl2deY/TL3MmQxU+coFoomuGfZKJIQYiLB4j4cVQD8oQLmPIUhRW
         LIH+2egyaMPUwuBUHSB93WDcaJkgwNHYrz0EgRkEKhzLJ0XDIDAmzVYn3yKuZM2o3k95
         DHQ/ZDJkIDxBWcEHVbZyFVrIkprIuPoSMOCzcjqvRPRAuCMPLPikWlJKedsdNh+7KTKQ
         NQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsQY8wRB1tPgge7no2XDUZ9MO6qTw6rvzdX9cl9suyQ=;
        b=iPjVf7k41jNRI6/eQkbm/3chCD2MAn9NF2+M3Mnqkt7YDKgTmf+peKImGqKV7shnvD
         DMrHmXPO0MSdBtLIEU9XveDYXVFOFkhxDg0/OR2ySuVCNAZt7NiNdbbFuoN/n5u3crbW
         ar+z/dXmhTQoEIHIYBN54fPhoEIY3tIIde7DAP4B/6bEvJNrR+7T3VNj+zzfzB2DAInv
         iopHz57TqkecTYhGMfDdpZMcNYHxoKvPqQgqvXF6pQ2sOToJ1SKaHH4/v44hyJoOA/Y7
         KD1Ul21xRldKCdmsTtcPbkmLXQrI/o/m8LuPAB81/4hZ/ZF20gXE16rouWQy9sI5By2n
         YWhw==
X-Gm-Message-State: AOAM530PJHOmSL0mCqNvM6IM0XmczOYfbykdCcneSKChlo1tWcvPtHea
        GIn1fpNRfFI88fggkjLOK8Jvv3r42QI=
X-Google-Smtp-Source: ABdhPJyt8vbiQaTbpcJWyj9vOX4A3IHUyrRCNGo18ir558phlrPwIY/dshz7g2rr4rVTaSMyvlic1A==
X-Received: by 2002:a17:902:9302:b029:d3:9c6b:9c00 with SMTP id bc2-20020a1709029302b02900d39c6b9c00mr297025plb.77.1602794293204;
        Thu, 15 Oct 2020 13:38:13 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id j8sm136860pfr.121.2020.10.15.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:38:12 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v10 3/9] ext4 / jbd2: add fast commit initialization
Date:   Thu, 15 Oct 2020 13:37:55 -0700
Message-Id: <20201015203802.3597742-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds fast commit area trackers in the journal_t
structure. These are initialized via the jbd2_fc_init() routine that
this patch adds. This patch also adds ext4/fast_commit.c and
ext4/fast_commit.h files for fast commit code that will be added in
subsequent patches in this series.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/Makefile      |  2 +-
 fs/ext4/ext4.h        |  4 ++++
 fs/ext4/fast_commit.c | 20 ++++++++++++++++
 fs/ext4/fast_commit.h |  9 ++++++++
 fs/ext4/super.c       |  1 +
 fs/jbd2/journal.c     | 53 +++++++++++++++++++++++++++++++++++++++----
 include/linux/jbd2.h  | 39 +++++++++++++++++++++++++++++++
 7 files changed, 122 insertions(+), 6 deletions(-)
 create mode 100644 fs/ext4/fast_commit.c
 create mode 100644 fs/ext4/fast_commit.h

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 2e42f47a7f98..49e7af6cc93f 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -10,7 +10,7 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
 		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
 		super.o symlink.o sysfs.o xattr.o xattr_hurd.o xattr_trusted.o \
-		xattr_user.o
+		xattr_user.o fast_commit.o
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 02d7dc378505..2c412d32db0f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -963,6 +963,7 @@ do {									       \
 #endif /* defined(__KERNEL__) || defined(__linux__) */
 
 #include "extents_status.h"
+#include "fast_commit.h"
 
 /*
  * Lock subclasses for i_data_sem in the ext4_inode_info structure.
@@ -2678,6 +2679,9 @@ extern int ext4_init_inode_table(struct super_block *sb,
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
index 70256a240442..23bf55057fc2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5170,6 +5170,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_commit_interval = sbi->s_commit_interval;
 	journal->j_min_batch_time = sbi->s_min_batch_time;
 	journal->j_max_batch_time = sbi->s_max_batch_time;
+	ext4_fc_init(sb, journal);
 
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c0600405e7a2..4497bfbac527 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1181,6 +1181,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
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
@@ -1194,11 +1202,23 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
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
+EXPORT_SYMBOL(jbd2_fc_init);
+
 /* jbd2_journal_init_dev and jbd2_journal_init_inode:
  *
  * Create a journal structure assigned some fixed set of disk blocks to
@@ -1316,11 +1336,20 @@ static int journal_reset(journal_t *journal)
 	}
 
 	journal->j_first = first;
-	journal->j_last = last;
 
-	journal->j_head = first;
-	journal->j_tail = first;
-	journal->j_free = last - first;
+	if (jbd2_has_feature_fast_commit(journal) &&
+	    journal->j_fc_wbufsize > 0) {
+		journal->j_fc_last = last;
+		journal->j_last = last - journal->j_fc_wbufsize;
+		journal->j_fc_first = journal->j_last + 1;
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
@@ -1665,9 +1694,18 @@ static int load_superblock(journal_t *journal)
 	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
 	journal->j_tail = be32_to_cpu(sb->s_start);
 	journal->j_first = be32_to_cpu(sb->s_first);
-	journal->j_last = be32_to_cpu(sb->s_maxlen);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
 
+	if (jbd2_has_feature_fast_commit(journal) &&
+	    journal->j_fc_wbufsize > 0) {
+		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
+		journal->j_last = journal->j_fc_last - journal->j_fc_wbufsize;
+		journal->j_fc_first = journal->j_last + 1;
+		journal->j_fc_off = 0;
+	} else {
+		journal->j_last = be32_to_cpu(sb->s_maxlen);
+	}
+
 	return 0;
 }
 
@@ -1728,6 +1766,9 @@ int jbd2_journal_load(journal_t *journal)
 	 */
 	journal->j_flags &= ~JBD2_ABORT;
 
+	if (journal->j_fc_wbufsize > 0)
+		jbd2_journal_set_features(journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
@@ -1811,6 +1852,8 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	if (journal->j_chksum_driver)
 		crypto_free_shash(journal->j_chksum_driver);
+	if (journal->j_fc_wbufsize > 0)
+		kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
 	kfree(journal);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 0685cc95e501..008629b4d615 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -918,6 +918,30 @@ struct journal_s
 	 */
 	unsigned long		j_last;
 
+	/**
+	 * @j_fc_first:
+	 *
+	 * The block number of the first fast commit block in the journal
+	 * [j_state_lock].
+	 */
+	unsigned long		j_fc_first;
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
+	 * @j_fc_last:
+	 *
+	 * The block number one beyond the last fast commit block in the journal
+	 * [j_state_lock].
+	 */
+	unsigned long		j_fc_last;
+
 	/**
 	 * @j_dev: Device where we store the journal.
 	 */
@@ -1068,6 +1092,12 @@ struct journal_s
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
@@ -1075,6 +1105,13 @@ struct journal_s
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
@@ -1535,6 +1572,8 @@ void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
 extern int jbd2_cleanup_journal_tail(journal_t *);
 
+/* Fast commit related APIs */
+int jbd2_fc_init(journal_t *journal, int num_fc_blks);
 /*
  * is_journal_abort
  *
-- 
2.29.0.rc1.297.gfa9743e501-goog

