Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27353387C2A
	for <lists+linux-ext4@lfdr.de>; Tue, 18 May 2021 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbhERPOu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 May 2021 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbhERPOt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 May 2021 11:14:49 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D5C061573
        for <linux-ext4@vger.kernel.org>; Tue, 18 May 2021 08:13:31 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id n7so2116884vkl.2
        for <linux-ext4@vger.kernel.org>; Tue, 18 May 2021 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21L7vfIf0vyTwrdsV9/Mra+yInuCttFOKQLYY213uVU=;
        b=am24Z51bK1i1G9ehE+6275XzFeUs+lZL8JPdbXa3WX5qOAowGVuwjCiuTE05AlMZqm
         rAF60ws5W4QDQts5gqHHQVyvzL29OFZTbYJoeWW7AnxYa96etKDlvAr45gbYFZnEa2OB
         eICZce54iaYmzwoB3dB2H27W1qGzOaUEtkZ54UPujTg0KQvxITA1MKr/vHH8niQF5r+Y
         kyQkm4AtO6oPetMTJjct5/uqUawumdRB5iSibLLzhETR6RiR+VT9m9umzC/sKyMcop89
         21nGMUxyLclDVfLrEzcaCZ0CPPYdTxbJ4qqsJWWRKU5ZsjrlpgINAUSlHyFcq/8FQkfu
         +SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21L7vfIf0vyTwrdsV9/Mra+yInuCttFOKQLYY213uVU=;
        b=ewrQ5GgIzFC/P5JKfC6e92wnoRKhw8iSelyDbrZsyCs1oiGNDJ2ai6C0XvMMzONd1z
         0j9nEbT2GLfKytFT7y/WAsCx90iaSDzTT1mbkMB2XtlpCNohXOyPyvSVflvmg3kPIzUG
         itUTuYdJ91vFOi8dKKpRQAxic4CUFeBwJI490NYRDT1Q5vHMTxC+8DGhIvlY3X+LvMJ/
         iR09AZCXRcKDlAFVL83Xj9HKNYGWp19K59RN8CryZo26Bf1+Hl0j76T3v3AK1t9MVab2
         ENjLJZ2trIcwYfx5E2L9gSg3nPRLrZexsGlWpGfpihEX1rcVSeUd2op7qrSMoZotq4tr
         m2EA==
X-Gm-Message-State: AOAM531BI5vnaxBcZ4Wi3NagstC7yCyN3IU0636DYxn0sxM5WRkj+zkd
        Qp/4g9Cxz77l+eQBPAS9oZx14FPqtkJw1w==
X-Google-Smtp-Source: ABdhPJxwQv/F3SkB8C+JW5BgVNnKHTbxtGWfN8tlWgQWgbq4y7SJ1NwZGrBQeSmLnDpnnBobkPQDVA==
X-Received: by 2002:a1f:9747:: with SMTP id z68mr6402767vkd.17.1621350810305;
        Tue, 18 May 2021 08:13:30 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id o63sm2765340vsc.22.2021.05.18.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:13:29 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v5 1/3] ext4: add discard/zeroout flags to journal flush
Date:   Tue, 18 May 2021 15:13:25 +0000
Message-Id: <20210518151327.130198-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a flags argument to jbd2_journal_flush to enable discarding or
zero-filling the journal blocks while flushing the journal.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Changes in v4:
- restructured code division between patches
- changed jbd2_journal_flush flags arg from bool to unsigned long long

Changes in v5:
- changed jbd2_journal_flush flags to unsigned int
- changed name of jbd2_journal_flush flags from JBD2_ERASE* to
JBD2_JOURNAL_FLUSH*
- cleaned up loop in jbd2_journal_erase which finds contiguous regions
- updated flag checking
---
 fs/ext4/inode.c      |   4 +-
 fs/ext4/ioctl.c      |   6 +--
 fs/ext4/super.c      |   6 +--
 fs/jbd2/journal.c    | 119 +++++++++++++++++++++++++++++++++++++++++--
 fs/ocfs2/alloc.c     |   2 +-
 fs/ocfs2/journal.c   |   8 +--
 include/linux/jbd2.h |   6 ++-
 7 files changed, 134 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fe6045a46599..f44800361a38 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3223,7 +3223,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 		ext4_clear_inode_state(inode, EXT4_STATE_JDATA);
 		journal = EXT4_JOURNAL(inode);
 		jbd2_journal_lock_updates(journal);
-		err = jbd2_journal_flush(journal);
+		err = jbd2_journal_flush(journal, 0);
 		jbd2_journal_unlock_updates(journal);
 
 		if (err)
@@ -6005,7 +6005,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	if (val)
 		ext4_set_inode_flag(inode, EXT4_INODE_JOURNAL_DATA);
 	else {
-		err = jbd2_journal_flush(journal);
+		err = jbd2_journal_flush(journal, 0);
 		if (err < 0) {
 			jbd2_journal_unlock_updates(journal);
 			percpu_up_write(&sbi->s_writepages_rwsem);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0796bfa72829..d5512e17a13f 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -762,7 +762,7 @@ static long ext4_ioctl_group_add(struct file *file,
 	err = ext4_group_add(sb, input);
 	if (EXT4_SB(sb)->s_journal) {
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 	}
 	if (err == 0)
@@ -945,7 +945,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		}
 		if (err == 0)
@@ -1088,7 +1088,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (EXT4_SB(sb)->s_journal) {
 			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		}
 		if (err == 0)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 886e0d518668..fe3ae750d83a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5639,7 +5639,7 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
 		return 0;
 	}
 	jbd2_journal_lock_updates(journal);
-	err = jbd2_journal_flush(journal);
+	err = jbd2_journal_flush(journal, 0);
 	if (err < 0)
 		goto out;
 
@@ -5781,7 +5781,7 @@ static int ext4_freeze(struct super_block *sb)
 		 * Don't clear the needs_recovery flag if we failed to
 		 * flush the journal.
 		 */
-		error = jbd2_journal_flush(journal);
+		error = jbd2_journal_flush(journal, 0);
 		if (error < 0)
 			goto out;
 
@@ -6379,7 +6379,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		 * otherwise be livelocked...
 		 */
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		if (err)
 			return err;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..521ce41c242c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1686,6 +1686,110 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 	write_unlock(&journal->j_state_lock);
 }
 
+/**
+ * __jbd2_journal_erase() - Discard or zeroout journal blocks (excluding superblock)
+ * @journal: The journal to erase.
+ * @flags: A discard/zeroout request is sent for each physically contigous
+ *	region of the journal. Either JBD2_JOURNAL_FLUSH_DISCARD or
+ *	JBD2_JOURNAL_FLUSH_ZEROOUT must be set to determine which operation
+ *	to perform.
+ *
+ * Note: JBD2_JOURNAL_FLUSH_ZEROOUT attempts to use hardware offload. Zeroes
+ * will be explicitly written if no hardware offload is available, see
+ * blkdev_issue_zeroout for more details.
+ */
+static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
+{
+	int err = 0;
+	unsigned long block, log_offset; /* logical */
+	unsigned long long phys_block, block_start, block_stop; /* physical */
+	loff_t byte_start, byte_stop, byte_count;
+	struct request_queue *q = bdev_get_queue(journal->j_dev);
+
+	/* flags must be set to either discard or zeroout */
+	if ((flags & ~JBD2_JOURNAL_FLUSH_VALID) || !flags ||
+			((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
+			(flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
+		return -EINVAL;
+
+	if (!q)
+		return -ENXIO;
+
+	if (JBD2_JOURNAL_FLUSH_DISCARD & !blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	/*
+	 * lookup block mapping and issue discard/zeroout for each
+	 * contiguous region
+	 */
+	log_offset = be32_to_cpu(journal->j_superblock->s_first);
+	block_start =  ~0ULL;
+	for (block = log_offset; block < journal->j_total_len; block++) {
+		err = jbd2_journal_bmap(journal, block, &phys_block);
+		if (err) {
+			pr_err("JBD2: bad block at offset %lu", block);
+			return err;
+		}
+
+		if (block_start == ~0ULL) {
+			block_start = phys_block;
+			block_stop = block_start - 1;
+		}
+
+		/*
+		 * last block not contiguous with current block,
+		 * process last contiguous region and return to this block on
+		 * next loop
+		 */
+		if (phys_block != block_stop + 1) {
+			block--;
+		} else {
+			block_stop++;
+			/*
+			 * if this isn't the last block of journal,
+			 * no need to process now because next block may also
+			 * be part of this contiguous region
+			 */
+			if (block != journal->j_total_len - 1)
+				continue;
+		}
+
+		/*
+		 * end of contiguous region or this is last block of journal,
+		 * take care of the region
+		 */
+		byte_start = block_start * journal->j_blocksize;
+		byte_stop = block_stop * journal->j_blocksize;
+		byte_count = (block_stop - block_start + 1) *
+				journal->j_blocksize;
+
+		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
+				byte_start, byte_stop);
+
+		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
+			err = blkdev_issue_discard(journal->j_dev,
+					byte_start >> SECTOR_SHIFT,
+					byte_count >> SECTOR_SHIFT,
+					GFP_NOFS, 0);
+		} else if (flags & JBD2_JOURNAL_FLUSH_ZEROOUT) {
+			err = blkdev_issue_zeroout(journal->j_dev,
+					byte_start >> SECTOR_SHIFT,
+					byte_count >> SECTOR_SHIFT,
+					GFP_NOFS, 0);
+		}
+
+		if (unlikely(err != 0)) {
+			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
+					err, block_start, block_stop);
+			return err;
+		}
+
+		/* reset start and stop after processing a region */
+		block_start = ~0ULL;
+	}
+
+	return blkdev_issue_flush(journal->j_dev);
+}
 
 /**
  * jbd2_journal_update_sb_errno() - Update error in the journal.
@@ -2246,13 +2350,18 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
 /**
  * jbd2_journal_flush() - Flush journal
  * @journal: Journal to act on.
+ * @flags: optional operation on the journal blocks after the flush (see below)
  *
  * Flush all data for a given journal to disk and empty the journal.
  * Filesystems can use this when remounting readonly to ensure that
- * recovery does not need to happen on remount.
+ * recovery does not need to happen on remount. Optionally, a discard or zeroout
+ * can be issued on the journal blocks after flushing.
+ *
+ * flags:
+ *	JBD2_JOURNAL_FLUSH_DISCARD: issues discards for the journal blocks
+ *	JBD2_JOURNAL_FLUSH_ZEROOUT: issues zeroouts for the journal blocks
  */
-
-int jbd2_journal_flush(journal_t *journal)
+int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 {
 	int err = 0;
 	transaction_t *transaction = NULL;
@@ -2306,6 +2415,10 @@ int jbd2_journal_flush(journal_t *journal)
 	 * commits of data to the journal will restore the current
 	 * s_start value. */
 	jbd2_mark_journal_empty(journal, REQ_SYNC | REQ_FUA);
+
+	if (flags)
+		err = __jbd2_journal_erase(journal, flags);
+
 	mutex_unlock(&journal->j_checkpoint_mutex);
 	write_lock(&journal->j_state_lock);
 	J_ASSERT(!journal->j_running_transaction);
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 78710788c237..1b41bf9f4a7e 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6020,7 +6020,7 @@ int __ocfs2_flush_truncate_log(struct ocfs2_super *osb)
 	 * Then truncate log will be replayed resulting in cluster double free.
 	 */
 	jbd2_journal_lock_updates(journal->j_journal);
-	status = jbd2_journal_flush(journal->j_journal);
+	status = jbd2_journal_flush(journal->j_journal, 0);
 	jbd2_journal_unlock_updates(journal->j_journal);
 	if (status < 0) {
 		mlog_errno(status);
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index db52e843002a..a1438548747e 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -310,7 +310,7 @@ static int ocfs2_commit_cache(struct ocfs2_super *osb)
 	}
 
 	jbd2_journal_lock_updates(journal->j_journal);
-	status = jbd2_journal_flush(journal->j_journal);
+	status = jbd2_journal_flush(journal->j_journal, 0);
 	jbd2_journal_unlock_updates(journal->j_journal);
 	if (status < 0) {
 		up_write(&journal->j_trans_barrier);
@@ -1002,7 +1002,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 
 	if (ocfs2_mount_local(osb)) {
 		jbd2_journal_lock_updates(journal->j_journal);
-		status = jbd2_journal_flush(journal->j_journal);
+		status = jbd2_journal_flush(journal->j_journal, 0);
 		jbd2_journal_unlock_updates(journal->j_journal);
 		if (status < 0)
 			mlog_errno(status);
@@ -1072,7 +1072,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
 
 	if (replayed) {
 		jbd2_journal_lock_updates(journal->j_journal);
-		status = jbd2_journal_flush(journal->j_journal);
+		status = jbd2_journal_flush(journal->j_journal, 0);
 		jbd2_journal_unlock_updates(journal->j_journal);
 		if (status < 0)
 			mlog_errno(status);
@@ -1668,7 +1668,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 
 	/* wipe the journal */
 	jbd2_journal_lock_updates(journal);
-	status = jbd2_journal_flush(journal);
+	status = jbd2_journal_flush(journal, 0);
 	jbd2_journal_unlock_updates(journal);
 	if (status < 0)
 		mlog_errno(status);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index db0e1920cb12..8543233b0388 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1370,6 +1370,10 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 						 * mode */
 #define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
 #define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
+#define JBD2_JOURNAL_FLUSH_DISCARD	0x0001
+#define JBD2_JOURNAL_FLUSH_ZEROOUT	0x0002
+#define JBD2_JOURNAL_FLUSH_VALID	(JBD2_JOURNAL_FLUSH_DISCARD | \
+					JBD2_JOURNAL_FLUSH_ZEROOUT)
 
 /*
  * Function declarations for the journaling transaction and buffer
@@ -1500,7 +1504,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
 				struct page *, unsigned int, unsigned int);
 extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
 extern int	 jbd2_journal_stop(handle_t *);
-extern int	 jbd2_journal_flush (journal_t *);
+extern int	 jbd2_journal_flush(journal_t *journal, unsigned int flags);
 extern void	 jbd2_journal_lock_updates (journal_t *);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
-- 
2.31.1.751.gd2f1c929bd-goog

