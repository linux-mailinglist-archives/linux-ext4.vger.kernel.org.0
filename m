Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7D937ADB7
	for <lists+linux-ext4@lfdr.de>; Tue, 11 May 2021 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhEKSFk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 May 2021 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKSFj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 May 2021 14:05:39 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6D3C061574
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 11:04:32 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id j19so4233038vkj.0
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVtamO3R3pSh+7dOjQQJS7nUOtpWBEeg5kg3cmECbxM=;
        b=ZV8jUuyShQlzeLefnquyJadAvXCU/PNf2huy09e+0Qq9WdSjH/dhRFZSRJiWmCTzmO
         7HuWUyOSJ3L/V9Skl6UFIWY1b4Qdud/msDQk8Xj6XRSmtgXm4I6muyFho3Oq4b1gJHXb
         QxGu6YGkb/NFymYAx5pToKUNT8vQNXFjzmBDAMpk50bvIKV6qCsyp0r6xqm8xSPr+Ho/
         8McgK2TP9t79b1qDmYL4TvqSu1cZ5+2L8VPDTvQNtB6lWkR7u9GdV8w5FVoBkrA6Wb6F
         4fjRegcitgZC1gjR/vW6c7slkqrrMefcWJB3CkVrBziCoGP93sSAqfFNuVP5IRGfpYVa
         Ogig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVtamO3R3pSh+7dOjQQJS7nUOtpWBEeg5kg3cmECbxM=;
        b=A40E38p7OfqGaVV8Opfv5yVFSj225a9GxMdXajo+kIE9sSq2UXOyHaRv+1IZ4q8LGm
         z/2AuKfX9Bt9FJE0bvut/5nb0HpRuuTsX32DrWrvFlFcFjT734o0VwtHN1J7qKLV3ul2
         phZu6QSEuRdJMzG4QsEYbmzsO9+RjFx38eNBEGXbDBgkwdZznEYKOeY2yOmvX1FzWk4L
         /FpeUK5nP6NTQBM0e3thS7Gs2t5xgo7jKESeUZVaUtx8jCEgYz+ru+iu7hiPJGtpF36k
         KsyqVchwpdH0jL0IQrdNgqiAYjQxdo7PLn6hgd1mSEwY8DzViMY/UtYh2T0ss8rUwrAf
         pnOg==
X-Gm-Message-State: AOAM530XjCk6nCfk3Q7JYtaqVxxWf2AOQ7SclpvNnJWUtDVnxP/58cpQ
        KbKmRZHY38jGBw9vtcXnafiTL6JdNho=
X-Google-Smtp-Source: ABdhPJwzxcVMdd9PErX0KVKHShpIsTLEHS4Jx2Mq9YU/00Pe6c4d3/p7j/MSz9kqjQFp3KlHdi9WCw==
X-Received: by 2002:a1f:4d01:: with SMTP id a1mr18317016vkb.22.1620756270980;
        Tue, 11 May 2021 11:04:30 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id o35sm2166110uae.3.2021.05.11.11.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:04:30 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v4 1/3] ext4: add discard/zeroout flags to journal flush
Date:   Tue, 11 May 2021 18:04:26 +0000
Message-Id: <20210511180428.3358267-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
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
---
 fs/ext4/inode.c      |   4 +-
 fs/ext4/ioctl.c      |   6 +--
 fs/ext4/super.c      |   6 +--
 fs/jbd2/journal.c    | 112 ++++++++++++++++++++++++++++++++++++++++++-
 fs/ocfs2/alloc.c     |   2 +-
 fs/ocfs2/journal.c   |   8 ++--
 include/linux/jbd2.h |   2 +-
 7 files changed, 124 insertions(+), 16 deletions(-)

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
index 31627f7dc5cd..898705fc8d36 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -707,7 +707,7 @@ static long ext4_ioctl_group_add(struct file *file,
 	err = ext4_group_add(sb, input);
 	if (EXT4_SB(sb)->s_journal) {
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 	}
 	if (err == 0)
@@ -885,7 +885,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		}
 		if (err == 0)
@@ -1028,7 +1028,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (EXT4_SB(sb)->s_journal) {
 			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		}
 		if (err == 0)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7dc94f3e18e6..76c3bdb7e61d 100644
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
 
@@ -6376,7 +6376,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		 * otherwise be livelocked...
 		 */
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
-		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal);
+		err = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
 		if (err)
 			return err;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..f86929dbca3c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1686,6 +1686,106 @@ static void jbd2_mark_journal_empty(journal_t *journal, int write_op)
 	write_unlock(&journal->j_state_lock);
 }
 
+#define JBD2_ERASE_FLAG_DISCARD	1
+#define JBD2_ERASE_FLAG_ZEROOUT	2
+
+/**
+ * __jbd2_journal_erase() - Discard or zeroout journal blocks (excluding superblock)
+ * @journal: The journal to erase.
+ * @flags: A discard/zeroout request is sent for each physically contigous region
+ *	of the journal. Either JBD2_ERASE_FLAG_DISCARD or JBD2_ERASE_FLAG_ZEROOUT
+ *	must be set to decide which operation to perform.
+ *
+ * Note: JBD2_ERASE_FLAG_ZEROOUT attempts to use hardware offload. Zeroes will
+ * be explicitly written if no hardware offload is available, see
+ * blkdev_issue_zeroout for more details.
+ */
+static int __jbd2_journal_erase(journal_t *journal, unsigned long long flags)
+{
+	int err = 0;
+	unsigned long block, log_offset; /* logical */
+	unsigned long long phys_block, block_start, block_stop; /* physical */
+	loff_t byte_start, byte_stop, byte_count;
+	struct request_queue *q = bdev_get_queue(journal->j_dev);
+
+	/* flags must be set to either discard or zeroout */
+	if ((flags & JBD2_ERASE_FLAG_DISCARD & JBD2_ERASE_FLAG_ZEROOUT) || !flags)
+		return -EINVAL;
+
+	if (!q)
+		return -ENXIO;
+
+	if (JBD2_ERASE_FLAG_DISCARD & !blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	/*
+	 * lookup block mapping and issue discard/zeroout for each
+	 * contiguous region
+	 */
+	log_offset = be32_to_cpu(journal->j_superblock->s_first);
+
+	err = jbd2_journal_bmap(journal, log_offset, &block_start);
+	if (err) {
+		printk(KERN_ERR "JBD2: bad block at offset %lu", log_offset);
+		return err;
+	}
+
+	/*
+	 * use block_start - 1 to meet check for contiguous with previous region:
+	 * phys_block == block_stop + 1
+	 */
+	block_stop = block_start - 1;
+
+	for (block = log_offset; block < journal->j_total_len; block++) {
+		err = jbd2_journal_bmap(journal, block, &phys_block);
+		if (err) {
+			printk(KERN_ERR "JBD2: bad block at offset %lu", block);
+			return err;
+		}
+
+		if (block == journal->j_total_len - 1) {
+			block_stop = phys_block;
+		} else if (phys_block == block_stop + 1) {
+			block_stop++;
+			continue;
+		}
+
+		/*
+		 * not contiguous with prior physical block or this is last
+		 * block of journal, take care of the region
+		 */
+		byte_start = block_start * journal->j_blocksize;
+		byte_stop = block_stop * journal->j_blocksize;
+		byte_count = (block_stop - block_start + 1) *
+				journal->j_blocksize;
+
+		truncate_inode_pages_range(journal->j_dev->bd_inode->i_mapping,
+				byte_start, byte_stop);
+
+		if (flags & JBD2_ERASE_FLAG_DISCARD) {
+			err = blkdev_issue_discard(journal->j_dev,
+					byte_start >> SECTOR_SHIFT,
+					byte_count >> SECTOR_SHIFT,
+					GFP_NOFS, 0);
+		} else if (flags & JBD2_ERASE_FLAG_ZEROOUT) {
+			err = blkdev_issue_zeroout(journal->j_dev,
+					byte_start >> SECTOR_SHIFT,
+					byte_count >> SECTOR_SHIFT,
+					GFP_NOFS, 0);
+		}
+
+		if (unlikely(err != 0)) {
+			printk(KERN_ERR "JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
+					err, block_start, block_stop);
+			return err;
+		}
+
+		block_start = phys_block;
+		block_stop = phys_block;
+	}
+
+	return blkdev_issue_flush(journal->j_dev);
+}
 
 /**
  * jbd2_journal_update_sb_errno() - Update error in the journal.
@@ -2246,13 +2346,17 @@ EXPORT_SYMBOL(jbd2_journal_clear_features);
 /**
  * jbd2_journal_flush() - Flush journal
  * @journal: Journal to act on.
+ * @flags: optional operations on the journal blocks after the flush (see below)
  *
  * Flush all data for a given journal to disk and empty the journal.
  * Filesystems can use this when remounting readonly to ensure that
  * recovery does not need to happen on remount.
+ *
+ * flags:
+ *	EXT4_IOC_CHECKPOINT_FLAG_DISCARD: issues discards for the journal blocks
+ *	EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT: issues zeroouts for the journal blocks
  */
-
-int jbd2_journal_flush(journal_t *journal)
+int jbd2_journal_flush(journal_t *journal, unsigned long long flags)
 {
 	int err = 0;
 	transaction_t *transaction = NULL;
@@ -2306,6 +2410,10 @@ int jbd2_journal_flush(journal_t *journal)
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
index 78710788c237..5ff2c42cb46c 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6020,7 +6020,7 @@ int __ocfs2_flush_truncate_log(struct ocfs2_super *osb)
 	 * Then truncate log will be replayed resulting in cluster double free.
 	 */
 	jbd2_journal_lock_updates(journal->j_journal);
-	status = jbd2_journal_flush(journal->j_journal);
+	status = jbd2_journal_flush(journal->j_journal, false);
 	jbd2_journal_unlock_updates(journal->j_journal);
 	if (status < 0) {
 		mlog_errno(status);
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index db52e843002a..1c356b29c66d 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -310,7 +310,7 @@ static int ocfs2_commit_cache(struct ocfs2_super *osb)
 	}
 
 	jbd2_journal_lock_updates(journal->j_journal);
-	status = jbd2_journal_flush(journal->j_journal);
+	status = jbd2_journal_flush(journal->j_journal, false);
 	jbd2_journal_unlock_updates(journal->j_journal);
 	if (status < 0) {
 		up_write(&journal->j_trans_barrier);
@@ -1002,7 +1002,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 
 	if (ocfs2_mount_local(osb)) {
 		jbd2_journal_lock_updates(journal->j_journal);
-		status = jbd2_journal_flush(journal->j_journal);
+		status = jbd2_journal_flush(journal->j_journal, false);
 		jbd2_journal_unlock_updates(journal->j_journal);
 		if (status < 0)
 			mlog_errno(status);
@@ -1072,7 +1072,7 @@ int ocfs2_journal_load(struct ocfs2_journal *journal, int local, int replayed)
 
 	if (replayed) {
 		jbd2_journal_lock_updates(journal->j_journal);
-		status = jbd2_journal_flush(journal->j_journal);
+		status = jbd2_journal_flush(journal->j_journal, false);
 		jbd2_journal_unlock_updates(journal->j_journal);
 		if (status < 0)
 			mlog_errno(status);
@@ -1668,7 +1668,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 
 	/* wipe the journal */
 	jbd2_journal_lock_updates(journal);
-	status = jbd2_journal_flush(journal);
+	status = jbd2_journal_flush(journal, false);
 	jbd2_journal_unlock_updates(journal);
 	if (status < 0)
 		mlog_errno(status);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index db0e1920cb12..580d4e6a2f54 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1500,7 +1500,7 @@ extern int	 jbd2_journal_invalidatepage(journal_t *,
 				struct page *, unsigned int, unsigned int);
 extern int	 jbd2_journal_try_to_free_buffers(journal_t *journal, struct page *page);
 extern int	 jbd2_journal_stop(handle_t *);
-extern int	 jbd2_journal_flush (journal_t *);
+extern int	 jbd2_journal_flush(journal_t *journal, unsigned long long flags);
 extern void	 jbd2_journal_lock_updates (journal_t *);
 extern void	 jbd2_journal_unlock_updates (journal_t *);
 
-- 
2.31.1.607.g51e8a6a459-goog

