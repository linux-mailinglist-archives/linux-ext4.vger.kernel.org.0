Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F842A1A6D
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgJaUFp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgJaUFp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB8C0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a3so1127659pjh.1
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nt+4VGgjCfkjTVcj1yCMSxMjSVDW1JAndgvTTFGZxeg=;
        b=iXhLh/Tbs+QNY2NrMqZ2wf90n6qvgg67Ag9Qgvf+5/wbhHU03Uw+d+0cTXaKEsutBr
         SpFj+cF0eo+W/KicOsC/n3sHiQFx/Uu00L2AqBD6JYQrVR/z8EJMBoiJoYYfC5Yn/BOp
         wDHNuLHVUlS/jODHCFzA2p5Q7fYI1/bdq81nJT7LyIDhhVs/rvs6KAyeTfRaTD9IXxKU
         ql/j4LjWzofB2Op7R7/OUGrQ+/JZqdqoXnHoB35t9L6cu7bDrVRwaazKbuJyRxIDbaw+
         RA1dgL0AYEJaHYNJAXV5w8lSrx0XcSl+/2FoOze1yG1iOAv/ZgktbhhBrWCgFHLRIt4v
         AkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nt+4VGgjCfkjTVcj1yCMSxMjSVDW1JAndgvTTFGZxeg=;
        b=em4Wv1w6x8iat/PVVCEwawr81+hc6ptDsPfwb/XCj3bmUTwMnMrd5NB9S2m+UNmomn
         zcKXFPsR8dxbimh/BvGdBfCwUMy92cZvLRv5EkRLIH87aqD2veFsjWEMom3SA1VJH4Vw
         QVKQSpu1aO//IhNcajNMpJwaxrTPXfsbjX69YQReOSQpnND3+erbusx8HY8XQAB0yiBr
         hhvz0VZX+X32ZIBx4k6efGeTJ4yZiUrC4P5BkOQBihUSMCRXGrLTqfn2Xd4CGOh/jjVH
         kmXEuB56jYUEbxOobDbKCU/bn5T+HLqSB2UpHvZn86fdl97igbBxj3jyqb6K2sALpFdA
         Uv6w==
X-Gm-Message-State: AOAM530pFUDSq1f20EuLHnYQoCtvIS+mnc2pCdR3wCyav7/WbBZkCg24
        61NheETSTaQ4Jys7VSLEv+uWxK44cEI=
X-Google-Smtp-Source: ABdhPJxRamGWkoR8T1lZ//BPyuQmJQHGIJJK2oy3srddw4hXIC0HvMzOHvKanKgZXNEGTJaIoiRc/w==
X-Received: by 2002:a17:902:7088:b029:d6:8072:9ce1 with SMTP id z8-20020a1709027088b02900d680729ce1mr15091523plk.11.1604174744436;
        Sat, 31 Oct 2020 13:05:44 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:43 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 04/10] ext4: clean up the JBD2 API that initializes fast commits
Date:   Sat, 31 Oct 2020 13:05:12 -0700
Message-Id: <20201031200518.4178786-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch cleans up the jbd2_fc_init() API and its related functions
to simplify enabling fast commits and configuring the number of blocks
that fast commits will use. With this change, the number of fast
commit blocks to use is solely determined by the JBD2 layer. However,
whether or not to use fast commits is determined by the file
system. The file system just calls jbd2_fc_init() to tell the JBD2
layer that it is interested in enabling fast commits. JBD2 layer
determines how many blocks to use for fast commits (based on the value
found in the JBD2 superblock).

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 12 +-------
 fs/jbd2/commit.c      |  2 +-
 fs/jbd2/journal.c     | 66 +++++++++++++++++++++++++++----------------
 fs/jbd2/recovery.c    |  2 +-
 include/linux/jbd2.h  |  3 +-
 5 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5c3af472287a..1b62d82b9622 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2082,8 +2082,6 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 
 void ext4_fc_init(struct super_block *sb, journal_t *journal)
 {
-	int num_fc_blocks;
-
 	/*
 	 * We set replay callback even if fast commit disabled because we may
 	 * could still have fast commit blocks that need to be replayed even if
@@ -2093,15 +2091,7 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
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
+	if (jbd2_fc_init(journal)) {
 		pr_warn("Error while enabling fast commits, turning off.");
 		ext4_clear_feature_fast_commit(sb);
 	}
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index fa688e163a80..353534403769 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -801,7 +801,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (first_block < journal->j_tail)
 			freed += journal->j_last - journal->j_first;
 		/* Update tail only if we free significant amount of space */
-		if (freed < journal->j_maxlen / 4)
+		if (freed < (journal->j_maxlen - journal->j_fc_wbufsize) / 4)
 			update_tail = 0;
 	}
 	J_ASSERT(commit_transaction->t_state == T_COMMIT);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 0c7c42bd530f..ea15f55aff5c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1357,14 +1357,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
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
@@ -1378,19 +1370,21 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 err_cleanup:
 	kfree(journal->j_wbuf);
-	kfree(journal->j_fc_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	kfree(journal);
 	return NULL;
 }
 
-int jbd2_fc_init(journal_t *journal, int num_fc_blks)
+int jbd2_fc_init(journal_t *journal)
 {
-	journal->j_fc_wbufsize = num_fc_blks;
-	journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
-				sizeof(struct buffer_head *), GFP_KERNEL);
-	if (!journal->j_fc_wbuf)
-		return -ENOMEM;
+	/*
+	 * Only set j_fc_wbufsize here to indicate that the client file
+	 * system is interested in using fast commits. The actual number of
+	 * fast commit blocks is found inside jbd2_superblock and is only
+	 * valid if j_fc_wbufsize is non-zero. The real value of j_fc_wbufsize
+	 * gets set in journal_reset().
+	 */
+	journal->j_fc_wbufsize = JBD2_MIN_FC_BLOCKS;
 	return 0;
 }
 EXPORT_SYMBOL(jbd2_fc_init);
@@ -1500,7 +1494,7 @@ static void journal_fail_superblock(journal_t *journal)
 static int journal_reset(journal_t *journal)
 {
 	journal_superblock_t *sb = journal->j_superblock;
-	unsigned long long first, last;
+	unsigned long long first, last, num_fc_blocks;
 
 	first = be32_to_cpu(sb->s_first);
 	last = be32_to_cpu(sb->s_maxlen);
@@ -1513,6 +1507,28 @@ static int journal_reset(journal_t *journal)
 
 	journal->j_first = first;
 
+	/*
+	 * At this point, fast commit recovery has finished. Now, we solely
+	 * rely on the file system to decide whether it wants fast commits
+	 * or not. File system that wishes to use fast commits must have
+	 * already called jbd2_fc_init() before we get here.
+	 */
+	if (journal->j_fc_wbufsize > 0)
+		jbd2_journal_set_features(journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
+	else
+		jbd2_journal_clear_features(journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
+
+	/* If valid, prefer the value found in superblock over the default */
+	num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
+	if (num_fc_blocks > 0 && num_fc_blocks < last)
+		journal->j_fc_wbufsize = num_fc_blocks;
+
+	if (jbd2_has_feature_fast_commit(journal))
+		journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
+					sizeof(struct buffer_head *), GFP_KERNEL);
+
 	if (jbd2_has_feature_fast_commit(journal) &&
 	    journal->j_fc_wbufsize > 0) {
 		journal->j_fc_last = last;
@@ -1531,7 +1547,8 @@ static int journal_reset(journal_t *journal)
 	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
 	journal->j_commit_request = journal->j_commit_sequence;
 
-	journal->j_max_transaction_buffers = journal->j_maxlen / 4;
+	journal->j_max_transaction_buffers =
+		(journal->j_maxlen - journal->j_fc_wbufsize) / 4;
 
 	/*
 	 * As a special case, if the on-disk copy is already marked as needing
@@ -1872,6 +1889,7 @@ static int load_superblock(journal_t *journal)
 {
 	int err;
 	journal_superblock_t *sb;
+	int num_fc_blocks;
 
 	err = journal_get_superblock(journal);
 	if (err)
@@ -1884,10 +1902,12 @@ static int load_superblock(journal_t *journal)
 	journal->j_first = be32_to_cpu(sb->s_first);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
 
-	if (jbd2_has_feature_fast_commit(journal) &&
-	    journal->j_fc_wbufsize > 0) {
+	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		journal->j_last = journal->j_fc_last - journal->j_fc_wbufsize;
+		num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
+		if (!num_fc_blocks || num_fc_blocks >= journal->j_fc_last)
+			num_fc_blocks = JBD2_MIN_FC_BLOCKS;
+		journal->j_last = journal->j_fc_last - num_fc_blocks;
 		journal->j_fc_first = journal->j_last + 1;
 		journal->j_fc_off = 0;
 	} else {
@@ -1954,9 +1974,6 @@ int jbd2_journal_load(journal_t *journal)
 	 */
 	journal->j_flags &= ~JBD2_ABORT;
 
-	if (journal->j_fc_wbufsize > 0)
-		jbd2_journal_set_features(journal, 0, 0,
-					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
@@ -2040,8 +2057,7 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	if (journal->j_chksum_driver)
 		crypto_free_shash(journal->j_chksum_driver);
-	if (journal->j_fc_wbufsize > 0)
-		kfree(journal->j_fc_wbuf);
+	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
 	kfree(journal);
 
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index eb2606133cd8..822f16cbf9b3 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -134,7 +134,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 
 	*bhp = NULL;
 
-	if (offset >= journal->j_maxlen) {
+	if (offset >= journal->j_maxlen + journal->j_fc_wbufsize) {
 		printk(KERN_ERR "JBD2: corrupted journal superblock\n");
 		return -EFSCORRUPTED;
 	}
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 1d5566af48ac..9b4e87a0068b 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -68,6 +68,7 @@ extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
+#define JBD2_MIN_FC_BLOCKS	256
 
 #ifdef __KERNEL__
 
@@ -1614,7 +1615,7 @@ extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
 extern int jbd2_cleanup_journal_tail(journal_t *);
 
 /* Fast commit related APIs */
-int jbd2_fc_init(journal_t *journal, int num_fc_blks);
+int jbd2_fc_init(journal_t *journal);
 int jbd2_fc_begin_commit(journal_t *journal, tid_t tid);
 int jbd2_fc_end_commit(journal_t *journal);
 int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid);
-- 
2.29.1.341.ge80a0c044ae-goog

