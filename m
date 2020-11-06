Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B52A8DD8
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgKFD7b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:31 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53AC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id o129so117368pfb.1
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fwNDhGdv//4roZkSAw43VRISzu4dUK/cTfiUuUVoyY=;
        b=TvHtNbdMV03MVDvJTPn51zsjl9mH4DPVrcCnYIzxYS6MnaRuoJn70Tq8l5yTpG/qSp
         OdHc7oP4h9+6bhHCa3qW4qqLmXghfh/u71i5Q9pGAdeZNVX7e84zG4uCib8VG2jc657z
         Qp/pifGmf+T4zHDXGlnXcOE0D0fc7MuqP0yK2K8T658p7XFQcJewovQ54uBBWhFC5TG8
         ocLrccgxbv4GxLWo3/H6c/MDO0hUa+WHbi5AyUQ+UQrhz1mUoxc5W+oxpJyreK4j6GSe
         ksqplgwKp/s/BUwgFQ4OTa76Picd+mM8fFftxggmzQA/mE/1s8zqZ9eGJBWunSDd5Bin
         cC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fwNDhGdv//4roZkSAw43VRISzu4dUK/cTfiUuUVoyY=;
        b=kxotawMhZCUtFtJo0dkwuLzyI7UHXp2YX0nWNv8yPua0nUpd6ZjS2WvL8OnQqOQRyY
         /jkw7/0c90WLudTTTHIZwQ32KNnCuATteIlRzrMaCDmCY95Eg/gvfG+Y14Z+niaFJR3+
         jQyLtrNRdPUjn0Qm0+Xf1COcK3TrvyhVTYny3hayKjHDw5p6u19KmdmjvWkqem7ZZe0o
         q5L5qCr5NHgpPbSv68Kgf7+h+k+M6OGXQb4mvLuTHQ518jYM5OIF2zf6n95IGZc/Hm/p
         xN9QuX0jFtvj1qEtfC/gV+C72HYWHg0USNMM9foRPK88YXgTQRvUGMxJtVBmM524XepK
         IopA==
X-Gm-Message-State: AOAM531hgzbfxhf3I5pGI9oBIk2MC2QAVGKh6PidKU0lztAzrmNAipdh
        vicegDbvTKAlfrESl9dGKGqqFnAGNbQ=
X-Google-Smtp-Source: ABdhPJwLTuS5q6H5D28oh2yHBMqt0/CxSJPYTuqox47HN/Q2ojiM95f5JyF3n2PbBns+HTRXAsQseQ==
X-Received: by 2002:a17:90a:6882:: with SMTP id a2mr288487pjd.110.1604635170425;
        Thu, 05 Nov 2020 19:59:30 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:29 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 06/22] ext4: clean up the JBD2 API that initializes fast commits
Date:   Thu,  5 Nov 2020 19:58:55 -0800
Message-Id: <20201106035911.1942128-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch removes jbd2_fc_init() API and its related functions to
simplify enabling fast commits. With this change, the number of fast
commit blocks to use is solely determined by the JBD2 layer. So, we
move the default value for minimum number of fast commit blocks from
ext4/fast_commit.h to include/linux/jbd2.h. However, whether or not to
use fast commits is determined by the file system. The file system
just sets the fast commit feature using
jbd2_journal_set_features(). JBD2 layer then determines how many
blocks to use for fast commits (based on the value found in the JBD2
superblock).

Note that the JBD2 feature flag of fast commits is just an indication
that there are fast commit blocks present on disk. It doesn't tell
JBD2 layer about the intent of the file system of whether to it wants
to use fast commit or not. That's why, we blindly clear the fast
commit flag in journal_reset() after the recovery is done.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 14 -------
 fs/ext4/fast_commit.h |  3 --
 fs/ext4/super.c       |  8 ++++
 fs/jbd2/journal.c     | 96 +++++++++++++++++++++++++------------------
 include/linux/jbd2.h  |  2 +-
 5 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 9399e9cccb7e..bab60c5d5095 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2091,8 +2091,6 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 
 void ext4_fc_init(struct super_block *sb, journal_t *journal)
 {
-	int num_fc_blocks;
-
 	/*
 	 * We set replay callback even if fast commit disabled because we may
 	 * could still have fast commit blocks that need to be replayed even if
@@ -2102,18 +2100,6 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
 	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
 		return;
 	journal->j_fc_cleanup_callback = ext4_fc_cleanup;
-	if (!buffer_uptodate(journal->j_sb_buffer)
-		&& ext4_read_bh_lock(journal->j_sb_buffer, REQ_META | REQ_PRIO,
-					true)) {
-		ext4_msg(sb, KERN_ERR, "I/O error on journal");
-		return;
-	}
-	num_fc_blocks = be32_to_cpu(journal->j_superblock->s_num_fc_blks);
-	if (jbd2_fc_init(journal, num_fc_blocks ? num_fc_blocks :
-					EXT4_NUM_FC_BLKS)) {
-		pr_warn("Error while enabling fast commits, turning off.");
-		ext4_clear_feature_fast_commit(sb);
-	}
 }
 
 const char *fc_ineligible_reasons[] = {
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 140fbb6af19e..1d96e0ac8138 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -3,9 +3,6 @@
 #ifndef __FAST_COMMIT_H__
 #define __FAST_COMMIT_H__
 
-/* Number of blocks in journal area to allocate for fast commits */
-#define EXT4_NUM_FC_BLKS		256
-
 /* Fast commit tags */
 #define EXT4_FC_TAG_ADD_RANGE		0x0001
 #define EXT4_FC_TAG_DEL_RANGE		0x0002
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 49982c230401..9d2fbeb0c9ea 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4857,6 +4857,14 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount_wq;
 	}
 
+	if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
+		!jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT)) {
+		ext4_msg(sb, KERN_ERR,
+			"Failed to set fast commit journal feature");
+		goto failed_mount_wq;
+	}
+
 	/* We have now updated the journal if required, so we can
 	 * validate the data journaling mode. */
 	switch (test_opt(sb, DATA_FLAGS)) {
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c3c768248527..500152f0421a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1352,19 +1352,12 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	/* We need enough buffers to write out full descriptor block. */
 	n = journal->j_blocksize / jbd2_min_tag_size();
 	journal->j_wbufsize = n;
+	journal->j_fc_wbuf = NULL;
 	journal->j_wbuf = kmalloc_array(n, sizeof(struct buffer_head *),
 					GFP_KERNEL);
 	if (!journal->j_wbuf)
 		goto err_cleanup;
 
-	if (journal->j_fc_wbufsize > 0) {
-		journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
-					sizeof(struct buffer_head *),
-					GFP_KERNEL);
-		if (!journal->j_fc_wbuf)
-			goto err_cleanup;
-	}
-
 	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
 	if (!bh) {
 		pr_err("%s: Cannot get buffer for journal superblock\n",
@@ -1378,23 +1371,11 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 err_cleanup:
 	kfree(journal->j_wbuf);
-	kfree(journal->j_fc_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	kfree(journal);
 	return NULL;
 }
 
-int jbd2_fc_init(journal_t *journal, int num_fc_blks)
-{
-	journal->j_fc_wbufsize = num_fc_blks;
-	journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
-				sizeof(struct buffer_head *), GFP_KERNEL);
-	if (!journal->j_fc_wbuf)
-		return -ENOMEM;
-	return 0;
-}
-EXPORT_SYMBOL(jbd2_fc_init);
-
 /* jbd2_journal_init_dev and jbd2_journal_init_inode:
  *
  * Create a journal structure assigned some fixed set of disk blocks to
@@ -1512,16 +1493,7 @@ static int journal_reset(journal_t *journal)
 	}
 
 	journal->j_first = first;
-
-	if (jbd2_has_feature_fast_commit(journal) &&
-	    journal->j_fc_wbufsize > 0) {
-		journal->j_fc_last = last;
-		journal->j_last = last - journal->j_fc_wbufsize;
-		journal->j_fc_first = journal->j_last + 1;
-		journal->j_fc_off = 0;
-	} else {
-		journal->j_last = last;
-	}
+	journal->j_last = last;
 
 	journal->j_head = journal->j_first;
 	journal->j_tail = journal->j_first;
@@ -1533,6 +1505,13 @@ static int journal_reset(journal_t *journal)
 
 	journal->j_max_transaction_buffers = jbd2_journal_get_max_txn_bufs(journal);
 
+	/*
+	 * Now that journal recovery is done, turn fast commits off here. This
+	 * way, if fast commit was enabled before the crash but if now FS has
+	 * disabled it, we don't enable fast commits.
+	 */
+	jbd2_clear_feature_fast_commit(journal);
+
 	/*
 	 * As a special case, if the on-disk copy is already marked as needing
 	 * no recovery (s_start == 0), then we can safely defer the superblock
@@ -1872,6 +1851,7 @@ static int load_superblock(journal_t *journal)
 {
 	int err;
 	journal_superblock_t *sb;
+	int num_fc_blocks;
 
 	err = journal_get_superblock(journal);
 	if (err)
@@ -1883,15 +1863,17 @@ static int load_superblock(journal_t *journal)
 	journal->j_tail = be32_to_cpu(sb->s_start);
 	journal->j_first = be32_to_cpu(sb->s_first);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
+	journal->j_last = be32_to_cpu(sb->s_maxlen);
 
-	if (jbd2_has_feature_fast_commit(journal) &&
-	    journal->j_fc_wbufsize > 0) {
+	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		journal->j_last = journal->j_fc_last - journal->j_fc_wbufsize;
+		num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
+		if (!num_fc_blocks)
+			num_fc_blocks = JBD2_MIN_FC_BLOCKS;
+		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
+			journal->j_last = journal->j_fc_last - num_fc_blocks;
 		journal->j_fc_first = journal->j_last + 1;
 		journal->j_fc_off = 0;
-	} else {
-		journal->j_last = be32_to_cpu(sb->s_maxlen);
 	}
 
 	return 0;
@@ -1954,9 +1936,6 @@ int jbd2_journal_load(journal_t *journal)
 	 */
 	journal->j_flags &= ~JBD2_ABORT;
 
-	if (journal->j_fc_wbufsize > 0)
-		jbd2_journal_set_features(journal, 0, 0,
-					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
@@ -2040,8 +2019,7 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	if (journal->j_chksum_driver)
 		crypto_free_shash(journal->j_chksum_driver);
-	if (journal->j_fc_wbufsize > 0)
-		kfree(journal->j_fc_wbuf);
+	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
 	kfree(journal);
 
@@ -2116,6 +2094,37 @@ int jbd2_journal_check_available_features(journal_t *journal, unsigned long comp
 	return 0;
 }
 
+static int
+jbd2_journal_initialize_fast_commit(journal_t *journal)
+{
+	journal_superblock_t *sb = journal->j_superblock;
+	unsigned long long num_fc_blks;
+
+	num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
+	if (num_fc_blks == 0)
+		num_fc_blks = JBD2_MIN_FC_BLOCKS;
+	if (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS)
+		return -ENOSPC;
+
+	/* Are we called twice? */
+	WARN_ON(journal->j_fc_wbuf != NULL);
+	journal->j_fc_wbuf = kmalloc_array(num_fc_blks,
+				sizeof(struct buffer_head *), GFP_KERNEL);
+	if (!journal->j_fc_wbuf)
+		return -ENOMEM;
+
+	journal->j_fc_wbufsize = num_fc_blks;
+	journal->j_fc_last = journal->j_last;
+	journal->j_last = journal->j_fc_last - num_fc_blks;
+	journal->j_fc_first = journal->j_last + 1;
+	journal->j_fc_off = 0;
+	journal->j_free = journal->j_last - journal->j_first;
+	journal->j_max_transaction_buffers =
+		jbd2_journal_get_max_txn_bufs(journal);
+
+	return 0;
+}
+
 /**
  * int jbd2_journal_set_features() - Mark a given journal feature in the superblock
  * @journal: Journal to act on.
@@ -2159,6 +2168,13 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 
 	sb = journal->j_superblock;
 
+	if (incompat & JBD2_FEATURE_INCOMPAT_FAST_COMMIT) {
+		if (jbd2_journal_initialize_fast_commit(journal)) {
+			pr_err("JBD2: Cannot enable fast commits.\n");
+			return 0;
+		}
+	}
+
 	/* Load the checksum driver if necessary */
 	if ((journal->j_chksum_driver == NULL) &&
 	    INCOMPAT_FEATURE_ON(JBD2_FEATURE_INCOMPAT_CSUM_V3)) {
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index e0b6b53eae64..b2caf7bbd8e5 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -68,6 +68,7 @@ extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
+#define JBD2_MIN_FC_BLOCKS	256
 
 #ifdef __KERNEL__
 
@@ -1614,7 +1615,6 @@ extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
 extern int jbd2_cleanup_journal_tail(journal_t *);
 
 /* Fast commit related APIs */
-int jbd2_fc_init(journal_t *journal, int num_fc_blks);
 int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
 int jbd2_fc_end_commit(journal_t *journal);
 int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid);
-- 
2.29.1.341.ge80a0c044ae-goog

