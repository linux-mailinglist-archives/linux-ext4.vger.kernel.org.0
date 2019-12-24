Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE1129EE0
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLXIPC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46370 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLXIPB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:15:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so10051143pgb.13
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pvf4lrzFlH3feksrHBh2Gkjqh5kbZMGQbEHsnjD3rkY=;
        b=EoejasqNaF/t4ObXucDq93UaPYvCGaVkLP0uOQ18i/+ItPmkIUtI26vjma8vbibnr4
         onkiP2MrB1idWn5tp6WxgHDwpc3nXrydXYG0/MODh9llirePKxI7sJgP12tdvzqku0dp
         hM943wA9iL/sxoBpetqVusewjG+pHVo1dq5tKkDH+2vAkxAOh/5t6fWlwWQDxIfUYshp
         /CGIU28ncTJg5aG3Y5YAXFv0J8Cs4NK5qP1kdE7r0ZosFJn6cdjOCVBXfb3IDecy18le
         CS0hERTcEtGXazdui7maqhn0lpmq0IXcw981JBKBc4TQi6ypUymMVf/G89ZovSjiKAo6
         vmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pvf4lrzFlH3feksrHBh2Gkjqh5kbZMGQbEHsnjD3rkY=;
        b=o7v4npPcKHRl0anHoIKSocQVU4MGlJOvo/FIG56OTq3Gx1fWclNtTRb3dgwslT6Tb6
         bG9KdKrO83V9pWiPWrObw0ViCsKq8r9kqpyDfOshLWdeKNdimyCCxlFlrlT5X2tBDXwB
         qjkgXDyMAZykVZBK6x5rNvjNblZzpJzzt+emv7JMTR43XUz0eh3BsXkLie1aUkiU4JN/
         2eilgOgHqUXk8tqLC24u6POyizZ3bqD2idv/07YFykqpd427x/fwkJEMcs9h/XU58txh
         F/n1p2TNlT+k5FjWy6tUr+kMUvjc9wzjycd6zDoHOhDFf3DqkBVl+wTz29qpLpoGrqHg
         v29g==
X-Gm-Message-State: APjAAAX4HzAMyO0/KSBPSRnUI4/Tc5Tr0tVIZFL2JAT4EtB9hnaBmYRV
        QltH0tGh9Ng1o2X4tI51lD4z3456
X-Google-Smtp-Source: APXvYqyuGd2UF1rCRujGmBqcFP4bZmKFN4R4iDHdqhe2Jz3hSYsyrjDCmjr5zWYWHKNj9mIDYN2rIA==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr36697523pgt.208.1577175299367;
        Tue, 24 Dec 2019 00:14:59 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:58 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 14/20] ext4: main commit routine for fast commits
Date:   Tue, 24 Dec 2019 00:13:18 -0800
Message-Id: <20191224081324.95807-14-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add main commit routine for fast commits to perform a fast commit.
Also, handle race between inode deletion which results in inode
being deleted from fast commit list and the commit routine. Add
commit routines for fast commit with hard consistency as well
as for soft consistency.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |   7 +
 fs/ext4/ext4_jbd2.c         | 563 ++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h         |   2 +
 fs/ext4/fsync.c             |   2 +-
 fs/ext4/inode.c             |   6 +-
 fs/ext4/migrate.c           |   1 +
 fs/ext4/super.c             |  12 +
 include/trace/events/ext4.h | 101 +++++++
 8 files changed, 691 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ede039a01bab..9c2f67c64b4f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1679,6 +1679,10 @@ enum {
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_ELIGIBLE,		/* File is Fast commit eligible */
+	EXT4_STATE_FC_DATA_SUBMIT,	/* File is going through fast commit */
+	EXT4_STATE_FC_MDATA_SUBMIT,	/* Fast commit block is
+					 * being submitted
+					 */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
@@ -2767,6 +2771,9 @@ extern int ext4_group_extend(struct super_block *sb,
 extern int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count);
 
 /* super.c */
+
+int ext4_fc_async_commit_inode(journal_t *journal, tid_t commit_tid,
+			       struct inode *inode);
 extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, int op_flags);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 9e34aa560ea1..f371f1f0f914 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -351,6 +351,8 @@ void ext4_init_inode_fc_info(struct inode *inode)
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
 	ext4_reset_inode_fc_info(inode);
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_DATA_SUBMIT);
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_MDATA_SUBMIT);
 	INIT_LIST_HEAD(&ei->i_fc_list);
 }
 
@@ -375,6 +377,43 @@ static inline tid_t get_running_txn_tid(struct super_block *sb)
 	return 0;
 }
 
+void ext4_fc_del(struct inode *inode)
+{
+	if (!ext4_should_fast_commit(inode->i_sb) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (list_empty(&EXT4_I(inode)->i_fc_list))
+		return;
+
+	ext4_fc_disable(inode->i_sb, EXT4_FC_REASON_DELETE);
+
+restart:
+	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	if (ext4_test_inode_state(inode, EXT4_STATE_FC_DATA_SUBMIT)) {
+		struct ext4_inode_info *ei = EXT4_I(inode);
+		wait_queue_head_t *wq;
+#if (BITS_PER_LONG < 64)
+		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+				EXT4_STATE_FC_DATA_SUBMIT);
+		wq = bit_waitqueue(&ei->i_state_flags,
+				   EXT4_STATE_FC_DATA_SUBMIT);
+#else
+		DEFINE_WAIT_BIT(wait, &ei->i_flags,
+				EXT4_STATE_FC_DATA_SUBMIT);
+		wq = bit_waitqueue(&ei->i_flags,
+				   EXT4_STATE_FC_DATA_SUBMIT);
+#endif
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+		schedule();
+		finish_wait(wq, &wait.wq_entry);
+		goto restart;
+	}
+	list_del_init(&EXT4_I(inode)->i_fc_list);
+	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+}
+
 static bool ext4_is_inode_fc_ineligible(struct inode *inode)
 {
 	if (get_running_txn_tid(inode->i_sb) == EXT4_I(inode)->i_fc_tid)
@@ -433,6 +472,7 @@ static int __ext4_fc_track_template(
 		return -EOPNOTSUPP;
 
 	write_lock(&ei->i_fc_lock);
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_MDATA_SUBMIT);
 	if (running_txn_tid == ei->i_fc_tid) {
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_ELIGIBLE)) {
 			write_unlock(&ei->i_fc_lock);
@@ -605,6 +645,21 @@ void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
 	trace_ext4_fc_track_range(inode, start, end, ret);
 }
 
+static void ext4_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+{
+	BUFFER_TRACE(bh, "");
+	if (uptodate) {
+		ext4_debug("%s: Block %lld up-to-date",
+			   __func__, bh->b_blocknr);
+		set_buffer_uptodate(bh);
+	} else {
+		ext4_debug("%s: Block %lld not up-to-date",
+			   __func__, bh->b_blocknr);
+		clear_buffer_uptodate(bh);
+	}
+
+	unlock_buffer(bh);
+}
 
 /*
  * Adds tag, length and value at memory pointed to by dst. Returns
@@ -767,10 +822,518 @@ static int fc_write_data(struct inode *inode, u8 *start, u8 *end,
 	return num_tlvs;
 }
 
+void submit_fc_bh(struct buffer_head *bh)
+{
+	lock_buffer(bh);
+	clear_buffer_dirty(bh);
+	set_buffer_uptodate(bh);
+	bh->b_end_io = ext4_end_buffer_io_sync;
+	submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+}
+
+static int fc_commit_data_inode(journal_t *journal, struct inode *inode)
+{
+	struct ext4_fc_commit_hdr *hdr;
+	struct buffer_head *bh;
+	u8 *start, *cur, *end;
+	int ret;
+	int num_tlvs = 0;
+
+	ret = jbd2_map_fc_buf(journal, &bh);
+	if (ret)
+		return -ECANCELED;
+
+	start = cur = ((__u8 *)bh->b_data + sizeof(journal_header_t));
+	end = (__u8 *)bh->b_data + journal->j_blocksize;
+	hdr = (struct ext4_fc_commit_hdr *)start;
+
+	ret = fc_write_hdr(inode, start, end, &cur);
+	if (ret < 0)
+		return ret;
+
+	ret = fc_write_data(inode, cur, end, &cur);
+	if (ret < 0)
+		return ret;
+	memset(cur, 0, end - cur);
+
+	hdr->fc_num_tlvs = cpu_to_le16(num_tlvs + ret);
+	hdr->fc_csum = 0;
+	hdr->fc_csum = cpu_to_le32(ext4_chksum(EXT4_SB(inode->i_sb),
+					       0, start, end - start));
+	submit_fc_bh(bh);
+	ext4_set_inode_state(inode, EXT4_STATE_FC_MDATA_SUBMIT);
+
+	return 1;
+}
+
+static int submit_all_inode_data(journal_t *journal)
+{
+	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_inode_info *iter;
+	struct list_head *pos;
+	int ret = 0;
+
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each(pos, &sbi->s_fc_q) {
+		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		ext4_set_inode_state(&iter->vfs_inode,
+				     EXT4_STATE_FC_DATA_SUBMIT);
+		spin_unlock(&sbi->s_fc_lock);
+		ret = jbd2_submit_inode_data(journal, iter->jinode);
+		if (ret)
+			return ret;
+		spin_lock(&sbi->s_fc_lock);
+	}
+	spin_unlock(&sbi->s_fc_lock);
+
+	return ret;
+}
+
+static int wait_all_inode_data(journal_t *journal)
+{
+	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_inode_info *pos, *n;
+	int ret = 0;
+
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each_entry_safe(pos, n, &sbi->s_fc_q, i_fc_list) {
+		if (!ext4_test_inode_state(&pos->vfs_inode,
+					   EXT4_STATE_FC_DATA_SUBMIT))
+			continue;
+		spin_unlock(&sbi->s_fc_lock);
+		ret = jbd2_wait_inode_data(journal, pos->jinode);
+		if (ret)
+			break;
+		spin_lock(&sbi->s_fc_lock);
+		list_safe_reset_next(pos, n, i_fc_list);
+		list_del_init(&pos->i_fc_list);
+
+		ext4_clear_inode_state(&pos->vfs_inode,
+				       EXT4_STATE_FC_DATA_SUBMIT);
+		/* Make sure DATA_SUBMIT bit is set before waking up */
+		smp_mb();
+#if (BITS_PER_LONG < 64)
+		wake_up_bit(&pos->i_state_flags, EXT4_STATE_FC_DATA_SUBMIT);
+#else
+		wake_up_bit(&pos->i_flags, EXT4_STATE_FC_DATA_SUBMIT);
+#endif
+	}
+	spin_unlock(&sbi->s_fc_lock);
+
+	return 0;
+}
+
+static int fc_inode_match(struct inode *inode, void *data)
+{
+	if (inode->i_ino != (long)data)
+		return 0;
+
+	if (inode->i_nlink)
+		return 1;
+
+	/*
+	 * Avoid returning a nearly dead inode (withi_nlink == 0).
+	 */
+	if (ext4_test_inode_state(inode,
+		EXT4_STATE_FC_DATA_SUBMIT)) {
+		/*
+		 * This is a tricky situation, after we
+		 * submitted data for this inode, someone
+		 * tried to free this. ext4_fc_del() is
+		 * waiting on FC_DATA_SUBMIT bit to clear.
+		 * Since we are never going to wait for data
+		 * just wake the sleeper.
+		 * TODO: Even in this case don't fallback to full commits
+		 *   and indicate the caller that this is a deleted inode.
+		 */
+		ext4_clear_inode_state(
+			inode, EXT4_STATE_FC_DATA_SUBMIT);
+		/* Make sure that data_submit bit is set */
+		smp_mb();
+#if (BITS_PER_LONG < 64)
+		wake_up_bit(&EXT4_I(inode)->i_state_flags,
+			EXT4_STATE_FC_DATA_SUBMIT);
+#else
+		wake_up_bit(&EXT4_I(inode)->i_flags,
+			EXT4_STATE_FC_DATA_SUBMIT);
+#endif
+	}
+	return 0;
+}
+
+/*
+ * Commits all the dentry updates and respective inodes till and
+ * including "last".
+ */
+static int fc_commit_dentry_updates(journal_t *journal,
+				    struct ext4_fc_dentry_update *last)
+{
+	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_commit_hdr *hdr;
+	struct ext4_fc_dentry_update *fc_dentry;
+	struct inode *inode;
+	struct buffer_head *bh;
+	u8 *start, *cur, *end;
+	int len, ret;
+	int nblks = 0;
+	int num_tlvs = 0;
+	bool is_last;
+
+	ret = jbd2_map_fc_buf(journal, &bh);
+	if (ret)
+		return -ECANCELED;
+
+	start = cur = ((__u8 *)bh->b_data + sizeof(journal_header_t));
+	end = (__u8 *)bh->b_data + journal->j_blocksize;
+	hdr = (struct ext4_fc_commit_hdr *)start;
+
+	spin_lock(&sbi->s_fc_lock);
+	while (!list_empty(&sbi->s_fc_dentry_q)) {
+		fc_dentry = list_first_entry(
+			&sbi->s_fc_dentry_q, struct ext4_fc_dentry_update,
+			fcd_list);
+		list_del_init(&fc_dentry->fcd_list);
+		spin_unlock(&sbi->s_fc_lock);
+		if (!fc_try_add_dentry_info_tlv(
+			    &cur, end, fc_dentry->fcd_op,
+			    fc_dentry->fcd_parent, fc_dentry->fcd_ino,
+			    fc_dentry->fcd_name.len,
+			    fc_dentry->fcd_name.name)) {
+			kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
+			return -ENOSPC;
+		}
+		num_tlvs++;
+		inode = ilookup5_nowait(sb, fc_dentry->fcd_ino, fc_inode_match,
+					(void *)(long)fc_dentry->fcd_ino);
+		/*
+		 * If this was the last metadata update for this inode, clear
+		 * since we are going to handle it now.
+		 */
+		if (inode && EXT4_I(inode)->i_fc_mdata_update == fc_dentry)
+			EXT4_I(inode)->i_fc_mdata_update = NULL;
+		if (fc_dentry != last &&
+		    fc_dentry->fcd_op != EXT4_FC_TAG_CREAT_DENTRY) {
+			if (inode)
+				iput(inode);
+			spin_lock(&sbi->s_fc_lock);
+			kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
+			continue;
+		}
+		is_last = (fc_dentry == last);
+		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
+		if (IS_ERR_OR_NULL(inode))
+			/*
+			 * Inode got evicted from memory for some
+			 * reason. it's possible that someone deleted
+			 * the inode after we started fast commit.
+			 * We just abort fast commits in this case.
+			 */
+			return -ECANCELED;
+
+		/*
+		 * It's either the last dentry update or it's inode
+		 * creation. Until now, we have written all the
+		 * directory entry updates since the beginning or
+		 * the last creation in current fast commit buf.
+		 * Move the contents towards the end of the block and
+		 * then write header first. We move it to the end
+		 * because header size is variable.
+		 */
+		len = cur - start;
+		memmove(end - len, start, len);
+		ret = fc_write_hdr(inode, start, end - len, &cur);
+		if (ret < 0) {
+			iput(inode);
+			return ret;
+		}
+		/*
+		 * Place directory entry updates right after the
+		 * header and the inode and write remaining
+		 * tags if any.
+		 */
+		memmove(cur, end - len, len);
+		cur = cur + len;
+		if (inode->i_nlink) {
+			ret = fc_write_data(inode, cur, end, &cur);
+			if (ret < 0) {
+				iput(inode);
+				return ret;
+			}
+		}
+		memset(cur, 0, end - cur);
+		hdr->fc_num_tlvs = cpu_to_le16(num_tlvs + ret);
+		hdr->fc_csum = cpu_to_le32(
+			ext4_chksum(sbi, 0, start, end - start));
+		submit_fc_bh(bh);
+		nblks++;
+		if (!inode->i_nlink) {
+			ext4_clear_inode_state(inode,
+				EXT4_STATE_FC_DATA_SUBMIT);
+			smp_mb(); /* Make sure data submit bit is set */
+#if (BITS_PER_LONG < 64)
+			wake_up_bit(&EXT4_I(inode)->i_state_flags,
+				EXT4_STATE_FC_DATA_SUBMIT);
+#else
+			wake_up_bit(&EXT4_I(inode)->i_flags,
+				EXT4_STATE_FC_DATA_SUBMIT);
+#endif
+		} else if (!ext4_test_inode_state(inode,
+				EXT4_STATE_FC_DATA_SUBMIT)) {
+			ret = jbd2_submit_inode_data(
+				journal, EXT4_I(inode)->jinode);
+			if (ret < 0)
+				return ret;
+			ext4_set_inode_state(inode,
+				EXT4_STATE_FC_DATA_SUBMIT);
+		}
+		ext4_set_inode_state(inode, EXT4_STATE_FC_MDATA_SUBMIT);
+		iput(inode);
+		if (is_last) {
+			bh = NULL;
+			goto skip_unlock;
+		}
+		ret = jbd2_map_fc_buf(journal, &bh);
+		if (ret < 0)
+			return ret;
+		start = cur = ((__u8 *)bh->b_data + sizeof(journal_header_t));
+		hdr = (struct ext4_fc_commit_hdr *)start;
+		end = (__u8 *)bh->b_data + journal->j_blocksize;
+		memset(start, 0, end - start);
+		spin_lock(&sbi->s_fc_lock);
+	}
+
+	spin_unlock(&sbi->s_fc_lock);
+skip_unlock:
+	WARN_ON(bh != NULL);
+	return nblks;
+}
+
+static void ext4_journal_fc_cleanup_cb(journal_t *journal)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_inode_info *iter;
+	struct ext4_fc_dentry_update *fc_dentry;
+
+	spin_lock(&sbi->s_fc_lock);
+	while (!list_empty(&sbi->s_fc_q)) {
+		iter = list_first_entry(&sbi->s_fc_q,
+				  struct ext4_inode_info, i_fc_list);
+		iter->i_fc_mdata_update = NULL;
+
+		list_del_init(&iter->i_fc_list);
+		ext4_clear_inode_state(&iter->vfs_inode,
+				       EXT4_STATE_FC_DATA_SUBMIT);
+		ext4_clear_inode_state(&iter->vfs_inode,
+				       EXT4_STATE_FC_MDATA_SUBMIT);
+		/* Make sure DATA_SUBMIT bit is set */
+		smp_mb();
+		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_DATA_SUBMIT);
+	}
+	INIT_LIST_HEAD(&sbi->s_fc_q);
+	while (!list_empty(&sbi->s_fc_dentry_q)) {
+		fc_dentry = list_first_entry(&sbi->s_fc_dentry_q,
+					     struct ext4_fc_dentry_update,
+					     fcd_list);
+		list_del_init(&fc_dentry->fcd_list);
+		spin_unlock(&sbi->s_fc_lock);
+
+		if (fc_dentry->fcd_name.name &&
+			fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
+			kfree(fc_dentry->fcd_name.name);
+		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
+		spin_lock(&sbi->s_fc_lock);
+	}
+	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
+	sbi->s_mount_state &= ~EXT4_FC_INELIGIBLE;
+	spin_unlock(&sbi->s_fc_lock);
+	trace_ext4_journal_fc_stats(sb);
+}
+
+int ext4_fc_perform_hard_commit(journal_t *journal)
+{
+	struct super_block *sb = (struct super_block *)(journal->j_private);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_inode_info *iter;
+	struct list_head *pos;
+	struct inode *inode;
+	int ret = 0, nblks = 0;
+
+	ret = submit_all_inode_data(journal);
+	if (ret < 0)
+		return ret;
+
+	if (!list_empty(&EXT4_SB(sb)->s_fc_dentry_q)) {
+		ret = fc_commit_dentry_updates(
+			journal, list_last_entry(
+				&EXT4_SB(sb)->s_fc_dentry_q,
+				struct ext4_fc_dentry_update,
+				fcd_list));
+		if (ret < 0)
+			return ret;
+		nblks = ret;
+	}
+
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each(pos, &sbi->s_fc_q) {
+		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		inode = &iter->vfs_inode;
+		if (ext4_test_inode_state(
+			    inode, EXT4_STATE_FC_MDATA_SUBMIT) ||
+		    !ext4_test_inode_state(
+			    inode, EXT4_STATE_FC_DATA_SUBMIT))
+			continue;
+
+		spin_unlock(&sbi->s_fc_lock);
+		ret = fc_commit_data_inode(journal, inode);
+		if (ret < 0)
+			return ret;
+		nblks += ret;
+		spin_lock(&sbi->s_fc_lock);
+	}
+	spin_unlock(&sbi->s_fc_lock);
+
+	ret = wait_all_inode_data(journal);
+	if (ret < 0)
+		return ret;
+
+	return nblks;
+}
+int ext4_fc_async_commit_inode(journal_t *journal, tid_t commit_tid,
+			       struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int nblks = 0, ret;
+	int start_jiffies;
+
+	trace_ext4_journal_fc_commit_cb_start(sb);
+	start_jiffies = jiffies;
+
+	if (!ext4_should_fast_commit(sb) ||
+	    (sbi->s_mount_state & EXT4_FC_INELIGIBLE)) {
+		sbi->s_fc_stats.fc_ineligible_commits++;
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "disabled");
+		trace_ext4_journal_fc_stats(sb);
+		return jbd2_complete_transaction(journal, commit_tid);
+	}
+
+	if (ext4_is_inode_fc_ineligible(inode)) {
+		sbi->s_fc_stats.fc_ineligible_commits++;
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "ineligible");
+		trace_ext4_journal_fc_stats(sb);
+		return jbd2_complete_transaction(journal, commit_tid);
+	}
+
+	/*
+	 * In case of soft consistency mode, we wait for any parallel
+	 * fast commits to complete. In case of hard consistency, if a
+	 * parallel fast commit is ongoing, it is going to take care
+	 * of us as well, so we don't wait.
+	 */
+	if (!test_opt2(sb, JOURNAL_FC_SOFT_CONSISTENCY))
+		ret = jbd2_start_async_fc_nowait(journal, commit_tid);
+	else
+		ret = jbd2_start_async_fc_wait(journal, commit_tid);
+	if (ret == -EALREADY) {
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "already");
+		trace_ext4_journal_fc_stats(sb);
+		return 0;
+	}
+
+	if (ret) {
+		sbi->s_fc_stats.fc_ineligible_commits++;
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "start");
+		trace_ext4_journal_fc_stats(sb);
+		return jbd2_complete_transaction(journal, commit_tid);
+	}
+
+	if (ext4_test_inode_state(inode, EXT4_STATE_FC_MDATA_SUBMIT)) {
+		jbd2_stop_async_fc(journal, commit_tid);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "committed");
+		trace_ext4_journal_fc_stats(sb);
+		return 0;
+	}
+
+	if (ei->i_fc_tid != commit_tid) {
+		jbd2_stop_async_fc(journal, commit_tid);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "stale");
+		trace_ext4_journal_fc_stats(sb);
+		return 0;
+	}
+
+	if (!test_opt2(sb, JOURNAL_FC_SOFT_CONSISTENCY)) {
+		ret = ext4_fc_perform_hard_commit(journal);
+		nblks = ret;
+	} else if (ei->i_fc_mdata_update) {
+		ret = submit_all_inode_data(journal);
+		if (ret < 0)
+			goto out;
+		nblks = fc_commit_dentry_updates(journal,
+					      ei->i_fc_mdata_update);
+		if (nblks < 0) {
+			ret = nblks;
+			goto out;
+		}
+		ret = wait_all_inode_data(journal);
+	} else if (!list_empty(&EXT4_I(inode)->i_fc_list)) {
+		ext4_set_inode_state(inode, EXT4_STATE_FC_DATA_SUBMIT);
+		ret = jbd2_submit_inode_data(journal, EXT4_I(inode)->jinode);
+		if (ret < 0)
+			goto out;
+		nblks = fc_commit_data_inode(journal, inode);
+		if (nblks < 0) {
+			ret = nblks;
+			goto out;
+		}
+		ext4_set_inode_state(inode, EXT4_STATE_FC_MDATA_SUBMIT);
+		ret = jbd2_wait_inode_data(journal, EXT4_I(inode)->jinode);
+		spin_lock(&sbi->s_fc_lock);
+
+		list_del_init(&EXT4_I(inode)->i_fc_list);
+		ext4_clear_inode_state(inode, EXT4_STATE_FC_DATA_SUBMIT);
+		smp_mb(); /* Make sure data submit bit is set */
+#if (BITS_PER_LONG < 64)
+		wake_up_bit(&EXT4_I(inode)->i_state_flags,
+			    EXT4_STATE_FC_DATA_SUBMIT);
+#else
+		wake_up_bit(&EXT4_I(inode)->i_flags,
+			    EXT4_STATE_FC_DATA_SUBMIT);
+#endif
+		spin_unlock(&sbi->s_fc_lock);
+	}
+
+out:
+	if (ret < 0) {
+		sbi->s_fc_stats.fc_ineligible_commits++;
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "fail1");
+		jbd2_stop_async_fc(journal, commit_tid);
+		trace_ext4_journal_fc_stats(sb);
+		sbi->s_mount_state &= ~EXT4_FC_REPLAY;
+		return jbd2_complete_transaction(journal, commit_tid);
+	}
+	jbd2_wait_on_fc_bufs(journal, nblks);
+	jbd2_stop_async_fc(journal, commit_tid);
+
+	EXT4_SB(sb)->s_fc_stats.fc_num_commits++;
+	EXT4_SB(sb)->s_fc_stats.fc_numblks += nblks;
+	trace_ext4_journal_fc_commit_cb_stop(sb,
+					     nblks < 0 ? 0 : nblks,
+					     nblks >= 0 ? "success" : "fail2");
+	trace_ext4_journal_fc_stats(sb);
+	sbi->s_mount_state &= ~EXT4_FC_REPLAY;
+	return 0;
+}
+
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
 {
 	if (!ext4_should_fast_commit(sb))
 		return;
+	journal->j_fc_cleanup_callback = ext4_journal_fc_cleanup_cb;
 	jbd2_init_fast_commit(journal, EXT4_NUM_FC_BLKS);
 }
 
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index d3a951d2e58d..4b6c179c02eb 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -527,5 +527,7 @@ int __init ext4_init_fc_dentry_cache(void);
 void ext4_fc_track_inode(struct inode *inode);
 void ext4_fc_mark_ineligible(struct inode *inode, int reason);
 void ext4_fc_disable(struct super_block *sb, int reason);
+void ext4_fc_del(struct inode *inode);
+
 
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 5508baa11bb6..4be3724d4f84 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -151,7 +151,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
 		needs_barrier = true;
-	ret = jbd2_complete_transaction(journal, commit_tid);
+	ret = ext4_fc_async_commit_inode(journal, commit_tid, inode);
 	if (needs_barrier) {
 	issue_flush:
 		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a61c3a31b74..c4cde431d5fa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5416,8 +5416,10 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
 			return 0;
 
-		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
-						EXT4_I(inode)->i_sync_tid);
+		err = ext4_fc_async_commit_inode(EXT4_SB(inode->i_sb)
+						 ->s_journal,
+						 EXT4_I(inode)->i_sync_tid,
+						 inode);
 	} else {
 		struct ext4_iloc iloc;
 
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index b1e4d359f73b..b995690d73ce 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -513,6 +513,7 @@ int ext4_ext_migrate(struct inode *inode)
 		 * work to orphan_list_cleanup()
 		 */
 		ext4_orphan_del(NULL, tmp_inode);
+		ext4_fc_del(inode);
 		retval = PTR_ERR(handle);
 		goto out;
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 23a194d871c6..bfd19a127188 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1111,6 +1111,11 @@ static int ext4_drop_inode(struct inode *inode)
 
 	if (!drop)
 		drop = fscrypt_drop_inode(inode);
+	if (drop) {
+		spin_unlock(&inode->i_lock);
+		ext4_fc_del(inode);
+		spin_lock(&inode->i_lock);
+	}
 
 	trace_ext4_drop_inode(inode, drop);
 	return drop;
@@ -1119,6 +1124,11 @@ static int ext4_drop_inode(struct inode *inode)
 static void ext4_free_in_core_inode(struct inode *inode)
 {
 	fscrypt_free_inode(inode);
+	if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
+		pr_warn("%s: inode %ld still in fc list",
+			__func__, inode->i_ino);
+		ext4_fc_del(inode);
+	}
 	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
 }
 
@@ -1133,6 +1143,8 @@ static void ext4_destroy_inode(struct inode *inode)
 				true);
 		dump_stack();
 	}
+	if (!list_empty(&(EXT4_I(inode)->i_fc_list)))
+		ext4_fc_del(inode);
 }
 
 static void init_once(void *foo)
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 0808b62ac108..e47059a02fec 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -75,6 +75,19 @@ struct partial_cluster;
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
 	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
 
+#define show_fc_reason(reason)						\
+	__print_symbolic(reason,					\
+		{ EXT4_FC_REASON_META_ALLOC,	"META_ALLOC"},		\
+		{ EXT4_FC_REASON_QUOTA,		"QUOTA"},		\
+		{ EXT4_FC_REASON_XATTR,		"XATTR"},		\
+		{ EXT4_FC_REASON_CROSS_RENAME,	"CROSS_RENAME"},	\
+		{ EXT4_FC_REASON_FALLOC_RANGE_OP,	"FALLOC_RANGE_OP"}, \
+		{ EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, "JOURNAL_FLAG_CHANGE"}, \
+		{ EXT4_FC_REASON_MEM,	"NO_MEM"},			\
+		{ EXT4_FC_REASON_SWAP_BOOT,	"SWAP_BOOT"},		\
+		{ EXT4_FC_REASON_RESIZE,	"RESIZE"},		\
+		{ EXT4_FC_REASON_RENAME_DIR,	"FALLOC_RANGE_OP"})
+
 
 TRACE_EVENT(ext4_other_inode_update_time,
 	TP_PROTO(struct inode *inode, ino_t orig_ino),
@@ -2703,6 +2716,94 @@ TRACE_EVENT(ext4_error,
 		  __entry->function, __entry->line)
 );
 
+TRACE_EVENT(ext4_journal_fc_commit_cb_start,
+	TP_PROTO(struct super_block *sb),
+
+	TP_ARGS(sb),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+	),
+
+	TP_printk("fast_commit started on dev %d,%d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev))
+);
+
+TRACE_EVENT(ext4_journal_fc_commit_cb_stop,
+	    TP_PROTO(struct super_block *sb, int nblks, const char *reason),
+
+	TP_ARGS(sb, nblks, reason),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, nblks)
+		__field(const char *, reason)
+		__field(int, num_fc)
+		__field(int, num_fc_ineligible)
+		__field(int, nblks_agg)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->nblks = nblks;
+		__entry->reason = reason;
+		__entry->num_fc = EXT4_SB(sb)->s_fc_stats.fc_num_commits;
+		__entry->num_fc_ineligible =
+			EXT4_SB(sb)->s_fc_stats.fc_ineligible_commits;
+		__entry->nblks_agg = EXT4_SB(sb)->s_fc_stats.fc_numblks;
+	),
+
+	TP_printk("fc on [%d,%d] nblks %d, reason %s, fc = %d, ineligible = %d, agg_nblks %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->nblks, __entry->reason, __entry->num_fc,
+		  __entry->num_fc_ineligible, __entry->nblks_agg)
+);
+
+#define FC_REASON_NAME_STAT(reason)					\
+	show_fc_reason(reason),						\
+	__entry->sbi->s_fc_stats.fc_ineligible_reason_count[reason]
+
+TRACE_EVENT(ext4_journal_fc_stats,
+	    TP_PROTO(struct super_block *sb),
+
+	    TP_ARGS(sb),
+
+	    TP_STRUCT__entry(
+		    __field(dev_t, dev)
+		    __field(struct ext4_sb_info *, sbi)
+		    __field(int, count)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->dev = sb->s_dev;
+		    __entry->sbi = EXT4_SB(sb);
+		    ),
+
+	    TP_printk("dev %d:%d fc ineligible reasons:\n"
+		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, "
+		      "%s:%d, %s:%d, %s:%d, %s:%d; "
+		      "num_commits:%d, ineligible: %d, numblks: %d",
+		      MAJOR(__entry->dev), MINOR(__entry->dev),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_META_ALLOC),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_QUOTA),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE_OP),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_MEM),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
+		      __entry->sbi->s_fc_stats.fc_num_commits,
+		      __entry->sbi->s_fc_stats.fc_ineligible_commits,
+		      __entry->sbi->s_fc_stats.fc_numblks)
+
+);
+
 #define DEFINE_TRACE_DENTRY_EVENT(__type)				\
 	TRACE_EVENT(ext4_fc_track_##__type,				\
 	    TP_PROTO(struct inode *inode, struct dentry *dentry, int ret), \
-- 
2.24.1.735.g03f4e72817-goog

