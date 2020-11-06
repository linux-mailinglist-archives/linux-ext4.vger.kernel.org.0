Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53C2A8DD7
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKFD7a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:30 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1227C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:29 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r10so2920093pgb.10
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrCAsD6sTsZKCbWwui6UiRuhNmDp9/3At7qA5SSP80U=;
        b=ux23eq84RMvnJ+9nRa2yxNVwP5U/s7+o3hnZdy5Ks5OZKzccjZivjeu7x8L6/6raEh
         KSERhq4DBN+xPA1S4N6G2+yabfTH/Pqwu0unZMp4Ze4wPxopHex6MYhMRV02RYS9vj1b
         +3+yY4JlrgfZhQznJ+pCp/YY1uqStU7gQ40Ox5n7RpfkOIsuMSSmqS5/Bk1NkkfYMw6d
         4s6QaOERo19ZkPr03YG+tgv+J5bcPr5vfKyLHrDluG3LghY3bOWuBewbCS3BJq4l0Qgf
         05MG3TMwSMsUzvb0Ac/fOAat82uDPXW3Ip6shJb0hvkC4MRt9sPVhF2XlIjCNDv01uNE
         70EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrCAsD6sTsZKCbWwui6UiRuhNmDp9/3At7qA5SSP80U=;
        b=RKWFExOLxs+pzac2pvq7q9gjMvyvVT9XO8zksO61ZvGA8HNbV12DqTKiyRXg8PyzXh
         rroqx200XgE14gSJXpaZ57FLurvMbeyxhXDiVtz1tYbALJ2wyWvgJs+Vu07W/9cbJEB0
         x6rOUPvZeuqa7+E6QVOgYxenyWBmb9fNUm+ladZkNSPQaCeA2aizK+21L5XV1iD6Dk17
         +DyN2gJUYMtB6+xD9SOw3UJhOwRBS066KW/+xzv8jxvkUznYISF3oYOIHuCZhhRhiaW6
         kNrDYvu5/9fyjuqJtTI1gf5/ifj443HeclANBsuWXh3JopuHiMdbSEx24xjp5IuiCN/q
         SiUA==
X-Gm-Message-State: AOAM530s70wbU3NITTtC+tF8suO2Xe85+VdMt2ZGEq3Iz+9l/IzfgMRO
        afjKetJWN31BGhDtXMDlbRH1FrabkZs=
X-Google-Smtp-Source: ABdhPJyq8bi5uwjS1yzI5denmLgm2E4XOm0mcW/7z5jzVowAEJTg9NEcfMZkhfPNT9wgHbXOrUjFMg==
X-Received: by 2002:aa7:8d05:0:b029:18b:6f5f:1ea with SMTP id j5-20020aa78d050000b029018b6f5f01eamr91408pfe.38.1604635169072;
        Thu, 05 Nov 2020 19:59:29 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:27 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 05/22] jbd2: rename j_maxlen to j_total_len and add jbd2_journal_max_txn_bufs
Date:   Thu,  5 Nov 2020 19:58:54 -0800
Message-Id: <20201106035911.1942128-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The on-disk superblock field sb->s_maxlen represents the total size of
the journal including the fast commit area and is no more the max
number of blocks available for a transaction. The maximum number of
blocks available to a transaction is reduced by the number of fast
commit blocks. So, this patch renames j_maxlen to j_total_len to
better represent its intent. Also, it adds a function to calculate max
number of bufs available for a transaction.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fsmap.c      |  2 +-
 fs/ext4/super.c      |  2 +-
 fs/jbd2/commit.c     |  2 +-
 fs/jbd2/journal.c    | 12 ++++++------
 fs/jbd2/recovery.c   |  6 +++---
 fs/ocfs2/journal.c   |  2 +-
 include/linux/jbd2.h |  9 +++++++--
 7 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index b232c2767534..4c2a9fe30067 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -280,7 +280,7 @@ static int ext4_getfsmap_logdev(struct super_block *sb, struct ext4_fsmap *keys,
 
 	/* Fabricate an rmap entry for the external log device. */
 	irec.fmr_physical = journal->j_blk_offset;
-	irec.fmr_length = journal->j_maxlen;
+	irec.fmr_length = journal->j_total_len;
 	irec.fmr_owner = EXT4_FMR_OWN_LOG;
 	irec.fmr_flags = 0;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 804f9fc5bdbd..49982c230401 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3976,7 +3976,7 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 * loaded or not
 	 */
 	if (sbi->s_journal && !sbi->s_journal_bdev)
-		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
+		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_total_len);
 	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
 		/* j_inum for internal journal is non-zero */
 		j_inode = ext4_get_journal_inode(sb, j_inum);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index fa688e163a80..ec516490cb35 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -801,7 +801,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (first_block < journal->j_tail)
 			freed += journal->j_last - journal->j_first;
 		/* Update tail only if we free significant amount of space */
-		if (freed < journal->j_maxlen / 4)
+		if (freed < jbd2_journal_get_max_txn_bufs(journal))
 			update_tail = 0;
 	}
 	J_ASSERT(commit_transaction->t_state == T_COMMIT);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 0c7c42bd530f..c3c768248527 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1348,7 +1348,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_dev = bdev;
 	journal->j_fs_dev = fs_dev;
 	journal->j_blk_offset = start;
-	journal->j_maxlen = len;
+	journal->j_total_len = len;
 	/* We need enough buffers to write out full descriptor block. */
 	n = journal->j_blocksize / jbd2_min_tag_size();
 	journal->j_wbufsize = n;
@@ -1531,7 +1531,7 @@ static int journal_reset(journal_t *journal)
 	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
 	journal->j_commit_request = journal->j_commit_sequence;
 
-	journal->j_max_transaction_buffers = journal->j_maxlen / 4;
+	journal->j_max_transaction_buffers = jbd2_journal_get_max_txn_bufs(journal);
 
 	/*
 	 * As a special case, if the on-disk copy is already marked as needing
@@ -1792,15 +1792,15 @@ static int journal_get_superblock(journal_t *journal)
 		goto out;
 	}
 
-	if (be32_to_cpu(sb->s_maxlen) < journal->j_maxlen)
-		journal->j_maxlen = be32_to_cpu(sb->s_maxlen);
-	else if (be32_to_cpu(sb->s_maxlen) > journal->j_maxlen) {
+	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
+		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
+	else if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
 		printk(KERN_WARNING "JBD2: journal file too short\n");
 		goto out;
 	}
 
 	if (be32_to_cpu(sb->s_first) == 0 ||
-	    be32_to_cpu(sb->s_first) >= journal->j_maxlen) {
+	    be32_to_cpu(sb->s_first) >= journal->j_total_len) {
 		printk(KERN_WARNING
 			"JBD2: Invalid start block of journal: %u\n",
 			be32_to_cpu(sb->s_first));
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index eb2606133cd8..dc0694fcfcd1 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -74,8 +74,8 @@ static int do_readahead(journal_t *journal, unsigned int start)
 
 	/* Do up to 128K of readahead */
 	max = start + (128 * 1024 / journal->j_blocksize);
-	if (max > journal->j_maxlen)
-		max = journal->j_maxlen;
+	if (max > journal->j_total_len)
+		max = journal->j_total_len;
 
 	/* Do the readahead itself.  We'll submit MAXBUF buffer_heads at
 	 * a time to the block device IO layer. */
@@ -134,7 +134,7 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 
 	*bhp = NULL;
 
-	if (offset >= journal->j_maxlen) {
+	if (offset >= journal->j_total_len) {
 		printk(KERN_ERR "JBD2: corrupted journal superblock\n");
 		return -EFSCORRUPTED;
 	}
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index b9a9d69dde7e..db52e843002a 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -877,7 +877,7 @@ int ocfs2_journal_init(struct ocfs2_journal *journal, int *dirty)
 		goto done;
 	}
 
-	trace_ocfs2_journal_init_maxlen(j_journal->j_maxlen);
+	trace_ocfs2_journal_init_maxlen(j_journal->j_total_len);
 
 	*dirty = (le32_to_cpu(di->id1.journal1.ij_flags) &
 		  OCFS2_JOURNAL_DIRTY_FL);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 1d5566af48ac..e0b6b53eae64 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -988,9 +988,9 @@ struct journal_s
 	struct block_device	*j_fs_dev;
 
 	/**
-	 * @j_maxlen: Total maximum capacity of the journal region on disk.
+	 * @j_total_len: Total maximum capacity of the journal region on disk.
 	 */
-	unsigned int		j_maxlen;
+	unsigned int		j_total_len;
 
 	/**
 	 * @j_reserved_credits:
@@ -1624,6 +1624,11 @@ int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
 int jbd2_fc_release_bufs(journal_t *journal);
 
+static inline int jbd2_journal_get_max_txn_bufs(journal_t *journal)
+{
+	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
+}
+
 /*
  * is_journal_abort
  *
-- 
2.29.1.341.ge80a0c044ae-goog

