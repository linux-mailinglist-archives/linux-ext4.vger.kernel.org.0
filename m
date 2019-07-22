Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD16F834
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfGVECZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43795 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfGVECX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so11559413pld.10
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQm2OaJGpGh+1/weCuMdCO5FNZ+IOMy6xGqtz3BnTCc=;
        b=Y57++0UpjdXeaBnrOVQLwnoabEZIDrNQnnRh02SQ0YaS6xI0odTrN6ASIH8RKBPzCy
         C66T8xVl2x/hccP3VE4s8sZOEEBipFP8kzR9oYS3JOIDorM+oZCanDwjGAXqei3r0/cu
         Ld9nWSrDVfAmmubZwyxcz5Dgy2pVFHSHEOc4ahmKbYXebF980uUsVT1gGIwut8Se4Wff
         c0lMjBD3sGGkWfCrFqCq0PcSI4/TAG30R9YD7pDvT6n8EGSO1lY0OWDR9oTjOY1qopHB
         cHl6bXmTCX+eBRT999jBBA6OIJRQg/PmX9N/SK/61sqnUALiL4H8yzvh01nNQDJZSlGu
         zPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQm2OaJGpGh+1/weCuMdCO5FNZ+IOMy6xGqtz3BnTCc=;
        b=TqOsZQzumeyTtOhrc4pyRQYmdKzImHfPoOOmSStireoZx/uiaTQJHnDvfMgUHOc5L3
         XKFgpolf4r0bdw+M0ATW3On87cTa9RTOrqFuG8IDH6tIlNNC6HitleF7njJcB96dJAkK
         rTH2Fdd6k04INXpxxgUNjPvngHGXz+BkSCDnmQBESG7wFG9D9jWWliuxmQc9NxKrwH7u
         pBOU6D/r+t5ybRJhJtTxIa7hP+zhX3X5I3hBcuBaCIVTXiCFy2Hs8iEKn985+Iu2GkVR
         nJnRHwfwlrjJd8k7tAVjxbIHGC8aa0nVUKh2ZpGBo5WeOSvRthmTLO8hiRHCUaHXdE9j
         n7Qg==
X-Gm-Message-State: APjAAAUDBBKWfsWNeughojlAundX/xRxi7gCvy3BRPvbMHkYhVGojftT
        TWzom5wJvlUTtZMcaogwzY/V7VPZ
X-Google-Smtp-Source: APXvYqxV2VIsKjRQvD7ah9EFDukMCjUZ0Vf8JlzFDNyTJ2dfaczWkpeEN9+EmGIwtLvX0p33UfH6Mw==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr63040805pla.33.1563768142157;
        Sun, 21 Jul 2019 21:02:22 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:21 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 10/11] ext4: fast-commit commit path changes
Date:   Sun, 21 Jul 2019 21:00:10 -0700
Message-Id: <20190722040011.18892-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch implements the actual commit path for fast commit. Based on
inodes tracked and their respective logical ranges remembered, this
patch adds code to create a fast commit block that stores extents
added to the inode. We use new JBD2 interfaces added in previous
patches in this series. The fast commit blocks that are created have
extents that _should_ be present in the file. It doesn't yet support
removing of extents, making operations such as truncate, delete fast
commit incompatible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  26 ++++++
 fs/ext4/extents.c |   8 +-
 fs/ext4/fsync.c   |   2 +-
 fs/ext4/inode.c   |   5 +-
 fs/ext4/super.c   | 213 +++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 246 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 92dc4432c7ed..5d92a2e4f0af 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2276,6 +2276,32 @@ struct mmpd_data {
  */
 #define EXT4_MMP_MAX_CHECK_INTERVAL	300UL
 
+/* Magic of fast commit header */
+#define EXT4_FC_MAGIC			0xE2540090
+
+struct ext4_fc_commit_hdr {
+	__le32 fc_magic;
+	/* JBD2 tid after which this fast commit should be applied */
+	__le32 fc_tid;
+	/* Sub transaction ID */
+	__le32 fc_subtid;
+	/* Length of this partial commit in terms of num blocks */
+	__le32 fc_len;
+	/* Inode number */
+	__le32 fc_ino;
+	/* ext4 inode on disk copy */
+	struct ext4_inode inode;
+	/* Csum(hdr+contents) */
+	__le32 fc_csum;
+};
+
+#define EXT4_FC_TAG_EXT		0x1	/* Extent */
+
+struct ext4_fc_tl {
+	__le16 fc_tag;
+	__le16 fc_len;
+};
+
 /*
  * Function prototypes
  */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index eb77e306a82b..66f7f4fb1612 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4899,10 +4899,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
-	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
-		ret = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
-						EXT4_I(inode)->i_sync_tid);
-	}
+	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal)
+		ret = jbd2_fc_complete_commit(
+		    EXT4_SB(inode->i_sb)->s_journal, EXT4_I(inode)->i_sync_tid,
+		    journal_current_handle()->h_journal->j_subtid);
 out:
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 5508baa11bb6..4f783f9723c5 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -151,7 +151,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
 		needs_barrier = true;
-	ret = jbd2_complete_transaction(journal, commit_tid);
+	ret = jbd2_fc_complete_commit(journal, commit_tid, journal->j_subtid);
 	if (needs_barrier) {
 	issue_flush:
 		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f79b185c013e..dd5d39a48363 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5476,8 +5476,9 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
 			return 0;
 
-		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
-						EXT4_I(inode)->i_sync_tid);
+		err = jbd2_fc_complete_commit(
+		    EXT4_SB(inode->i_sb)->s_journal, EXT4_I(inode)->i_sync_tid,
+		    EXT4_SB(inode->i_sb)->s_journal->j_subtid);
 	} else {
 		struct ext4_iloc iloc;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f6e820384ee0..a291d41b91de 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -437,6 +437,214 @@ static bool system_going_down(void)
 		|| system_state == SYSTEM_RESTART;
 }
 
+static void ext4_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
+{
+	struct buffer_head *orig_bh = bh->b_private;
+
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
+	if (orig_bh) {
+		clear_bit_unlock(BH_Shadow, &orig_bh->b_state);
+		/* Protect BH_Shadow bit in b_state */
+		smp_mb__after_atomic();
+		wake_up_bit(&orig_bh->b_state, BH_Shadow);
+	}
+	unlock_buffer(bh);
+}
+
+static int ext4_fc_write_inode(journal_t *journal, struct inode *inode,
+			       tid_t tid, tid_t subtid)
+{
+	loff_t old_blk_size, cur_lblk_off, new_blk_size;
+	struct super_block *sb = journal->j_private;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_map_blocks map;
+	struct ext4_iloc iloc;
+	struct ext4_fc_tl tl;
+	struct ext4_extent extent;
+	struct buffer_head *bh;
+	__u8 *cur, *end;
+	int ret;
+
+	if (tid != ei->i_fc.fc_tid || subtid != ei->i_fc.fc_subtid) {
+		jbd_debug(3,
+			  "File not modified. Modified %d:%d, expected %d:%d",
+			  ei->i_fc.fc_tid, ei->i_fc.fc_subtid, tid, subtid);
+		return 0;
+	}
+
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -ECANCELED;
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+	ret = jbd2_map_fc_buf(journal, &bh);
+	if (ret)
+		return -ENOMEM;
+
+	end = (__u8 *)bh->b_data + journal->j_blocksize;
+
+	old_blk_size = (ei->i_fc.fc_lblk_start + sb->s_blocksize - 1) >>
+		       inode->i_blkbits;
+	new_blk_size = ei->i_fc.fc_lblk_end >> inode->i_blkbits;
+
+	jbd_debug(3, "Committing as tid = %d, subtid = %d on buffer %lld\n",
+		  tid, subtid, bh->b_blocknr);
+
+	ei->i_fc.fc_lblk_start = ei->i_fc.fc_lblk_end;
+
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+			((__u8 *)bh->b_data + sizeof(journal_header_t));
+	fc_hdr->fc_magic = cpu_to_le32(EXT4_FC_MAGIC);
+	fc_hdr->fc_tid = cpu_to_le32(tid);
+	fc_hdr->fc_subtid = cpu_to_le32(subtid);
+	fc_hdr->fc_len = cpu_to_le32(0x1);
+	fc_hdr->fc_ino = cpu_to_le32(inode->i_ino);
+
+	memcpy(&fc_hdr->inode, ext4_raw_inode(&iloc), EXT4_INODE_SIZE(sb));
+	cur = (__u8 *)(fc_hdr + 1);
+
+	cur_lblk_off = old_blk_size;
+	while (cur_lblk_off <= new_blk_size) {
+		map.m_lblk = cur_lblk_off;
+		map.m_len = new_blk_size - cur_lblk_off + 1;
+		ret = ext4_map_blocks(NULL, inode, &map, 0);
+		if (!ret) {
+			cur_lblk_off += map.m_len;
+			continue;
+		}
+
+		if (map.m_flags & EXT4_MAP_UNWRITTEN)
+			return -ECANCELED;
+		extent.ee_block = cpu_to_le32(map.m_lblk);
+		cur_lblk_off += map.m_len;
+		if (cur + sizeof(struct ext4_extent) +
+		    sizeof(struct ext4_fc_tl) >= end)
+			return -ENOSPC;
+
+		tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_EXT);
+		tl.fc_len = cpu_to_le16(sizeof(struct ext4_extent));
+		extent.ee_len = cpu_to_le16(map.m_len);
+		ext4_ext_store_pblock(&extent, map.m_pblk);
+		if (map.m_flags & EXT4_MAP_UNWRITTEN)
+			ext4_ext_mark_unwritten(&extent);
+		else
+			ext4_ext_mark_initialized(&extent);
+		memcpy(cur, &tl, sizeof(struct ext4_fc_tl));
+		cur += sizeof(struct ext4_fc_tl);
+		memcpy(cur, &extent, sizeof(struct ext4_extent));
+		cur += sizeof(struct ext4_extent);
+	}
+
+	jbd_debug(3, "Created FC block for inode %ld with [%d, %d]",
+		  inode->i_ino, tid, subtid);
+
+	return 1;
+}
+
+static void ext4_journal_fc_cleanup_cb(journal_t *journal)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_inode_info *iter;
+	struct inode *inode;
+
+	mutex_lock(&sbi->s_fc_lock);
+	while (!list_empty(&sbi->s_fc_q)) {
+		iter = list_first_entry(&sbi->s_fc_q,
+				  struct ext4_inode_info, i_fc_list);
+		list_del_init(&iter->i_fc_list);
+		inode = &iter->vfs_inode;
+	}
+	INIT_LIST_HEAD(&sbi->s_fc_q);
+	sbi->s_fc_q_cnt = 0;
+	mutex_unlock(&sbi->s_fc_lock);
+}
+
+/*
+ * Fast-commit commit callback. There is contention between sbi->s_fc_lock and
+ * i_data_sem. Locking order is - i_data_sem then s_fc_lock
+ */
+static int ext4_journal_fc_commit_cb(journal_t *journal, tid_t tid,
+				     tid_t subtid)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct list_head *pos, *tmp;
+	struct ext4_inode_info *iter;
+	struct jbd2_inode *jinode;
+	int num_bufs = 0, ret;
+
+	sbi = sbi;
+	mutex_lock(&sbi->s_fc_lock);
+	if (!sbi->s_fc_eligible) {
+		sbi->s_fc_eligible = true;
+		mutex_unlock(&sbi->s_fc_lock);
+		return -ECANCELED;
+	}
+
+	list_for_each_safe(pos, tmp, &sbi->s_fc_q) {
+		struct inode *inode;
+
+		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		inode = &iter->vfs_inode;
+
+		mutex_unlock(&sbi->s_fc_lock);
+		/*
+		 * Release s_fc_lock here since fc_write_inode calls
+		 * ext4_map_blocks which needs i_data_sem.
+		 */
+		ret = ext4_fc_write_inode(journal, inode, tid, subtid);
+		if (ret < 0)
+			return ret;
+		mutex_lock(&sbi->s_fc_lock);
+
+		num_bufs += ret;
+	}
+
+	/* Submit data buffers first */
+	list_for_each(pos, &sbi->s_fc_q) {
+		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		jinode = iter->jinode;
+		ret = jbd2_submit_inode_data(journal, jinode);
+		if (ret) {
+			mutex_unlock(&sbi->s_fc_lock);
+			return ret;
+		}
+	}
+
+	if (num_bufs == 0) {
+		mutex_unlock(&sbi->s_fc_lock);
+		return 0;
+	}
+
+	/*
+	 * Before returning, check if s_fc_eligible was modified since we
+	 * started.
+	 */
+	if (!sbi->s_fc_eligible) {
+		mutex_unlock(&sbi->s_fc_lock);
+		return -ECANCELED;
+	}
+
+	mutex_unlock(&sbi->s_fc_lock);
+
+	jbd_debug(3, "%s: Journal blocks ready for fast commit\n", __func__);
+
+	return jbd2_submit_fc_bufs(journal, ext4_end_buffer_io_sync);
+}
+
 /* Deal with the reporting of failure conditions on a filesystem such as
  * inconsistencies detected or read IO failures.
  *
@@ -4723,7 +4931,10 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_commit_interval = sbi->s_commit_interval;
 	journal->j_min_batch_time = sbi->s_min_batch_time;
 	journal->j_max_batch_time = sbi->s_max_batch_time;
-
+	if (ext4_should_fast_commit(sb)) {
+		journal->j_fc_commit_callback = ext4_journal_fc_commit_cb;
+		journal->j_fc_cleanup_callback = ext4_journal_fc_cleanup_cb;
+	}
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
 		journal->j_flags |= JBD2_BARRIER;
-- 
2.22.0.657.g960e92d24f-goog

