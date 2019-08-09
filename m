Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C68704B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405244AbfHIDqi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39766 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405213AbfHIDqg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so45147545pgi.6
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbThzPFT64mMkeZBQbJu0txXkO7wJjf6cZ45UHkMQk4=;
        b=A/0ilNT85egTaQy134Eiau62drKOeN7p2OGVGm7wibsVXQ21hfbQDPOmy/nGM9NO3Z
         STiOwf7ipjHBHWautZgnVjN0pM5KM1KgEH3eDNfJeUzSs713mxL2Iwhboi+PZiKTWlf3
         bwvY+N/9yea5+xX9ONvMDp0yTrDazDCacSz4tgl28UZ8Sg6OLLZdx2Ff1+lj/6GnRQtT
         VLtyb4UOptezxGZA4m6xejHZfhP40blUfpsybnFQSG7MporADNcpsh79FfsE754wegLi
         RmnBDHpcYGwzJB4nO8ygQ1gWPfpDSjwd6l8F6K2ruuobiE6Ck/dkvFeAJ+SIRE6yq91/
         O+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbThzPFT64mMkeZBQbJu0txXkO7wJjf6cZ45UHkMQk4=;
        b=uLxY2i1d+2w6o5Fef/p0V+P7mtjZHIXGq0sHx+xYkrMlUBTS1zmcjtySuHwFdjCkGJ
         sWbFpin1kw/Kww/2mb7CoGb2kSzZ3pnqjuMnTMaakhxmJmXmZQECovZpRsZ6B5t1d3nc
         rPquVyiqJA3fTR9mKyj0fj32idW0iGQXkESReHPSZ2NMczQCCiJrIQVIicgn4FTCtwCs
         +GI272u563dTd0nfcj873kTkV9/M543lhL4dE0BiUJpkwfPlHUmRYYZFmN/DVOvrK/8l
         Bl7RgxropMlL7dGuHb12jnU43tw98xwYz6gE6u29QOnwKJgWcnu9KvP1i3yMGDg3VVrv
         R2ow==
X-Gm-Message-State: APjAAAWx8y4wTARhn4oSU/AwlAcBo7FCpAFuZVOLoKDjjlJoOEjd4za+
        2lneIX5u0ACNuiIaY2YZFYixWaGN
X-Google-Smtp-Source: APXvYqyjN2oXsWHdXb4tSb7BIEXKnEFdqYAGExgShxeaUN0KdqzQKGWiruetWBl8gTtf51hGv1a9Ng==
X-Received: by 2002:a63:ec03:: with SMTP id j3mr16156070pgh.325.1565322395227;
        Thu, 08 Aug 2019 20:46:35 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:34 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 10/12] ext4: fast-commit commit path changes
Date:   Thu,  8 Aug 2019 20:45:50 -0700
Message-Id: <20190809034552.148629-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
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

Changelog:

V2: 1) Use jbd2_wait_on_fc_bufs() instead of jbd2_fc_submit_bufs(). This
       also implies that fast commit callback now submits relevant bhs by
       itself.
    2) Added tracepoints for commit path.
    3) Several changes to fast commit on disk format:
       - Removed fc_tid from the fast commit header. That's because we TID
         can be obtained from journal header that exists before fast commit
       	 header.
       - Removed fc_len since it's always 1.
       - Added fc_flags fields. We set "last" flag for the last block in a
       	 sub-transaction. This allows us to maintain atomicity of
       	 sub-transactions.
       - Added fc_features to indicate what fast commit features are used by
       	 this fast commit block. In future, we plan to add support for
       	 handling of file create and file truncate. fc_features can be used
       	 by future patches to indicate incompatibility of those fast commit
       	 blocks.
---
 fs/ext4/ext4.h              |  37 ++++++
 fs/ext4/extents.c           |   8 +-
 fs/ext4/fsync.c             |   2 +-
 fs/ext4/inode.c             |   5 +-
 fs/ext4/super.c             | 259 +++++++++++++++++++++++++++++++++++-
 include/trace/events/ext4.h |  37 ++++++
 6 files changed, 340 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0d15d4539dda..210bd4c86d4f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2276,6 +2276,43 @@ struct mmpd_data {
  */
 #define EXT4_MMP_MAX_CHECK_INTERVAL	300UL
 
+/* Magic of fast commit header */
+#define EXT4_FC_MAGIC			0xE2540090
+
+#define EXT4_FC_FL_LAST			0x00000001
+
+#define ext4_fc_is_last(__fc_hdr)	(((__fc_hdr)->fc_flags) &	\
+					 EXT4_FC_FL_LAST)
+
+#define ext4_fc_mark_last(__fc_hdr)	(((__fc_hdr)->fc_flags) |=	\
+					 EXT4_FC_FL_LAST)
+
+struct ext4_fc_commit_hdr {
+	/* Fast commit magic, should be EXT4_FC_MAGIC */
+	__le32 fc_magic;
+	/* Sub transaction ID */
+	__le32 fc_subtid;
+	/* Features used by this fast commit block */
+	__u8 fc_features;
+	/* Flags for this block. */
+	__u8 fc_flags;
+	/* Number of TLVs in this fast commmit block */
+	__le16 fc_num_tlvs;
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
index c7bb52bdaf6e..1191ebbb55c5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -437,6 +437,260 @@ static bool system_going_down(void)
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
+static int ext4_fc_write_inode(journal_t *journal, struct buffer_head *bh,
+			       struct inode *inode, tid_t tid, tid_t subtid,
+			       int is_last)
+{
+	loff_t old_blk_size, cur_lblk_off, new_blk_size;
+	struct super_block *sb = journal->j_private;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_map_blocks map;
+	struct ext4_iloc iloc;
+	struct ext4_fc_tl tl;
+	struct ext4_extent extent;
+	__u32 dummy_csum = 0, csum;
+	__u8 *start, *cur, *end;
+	__u16 num_tlvs = 0;
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
+	fc_hdr->fc_subtid = cpu_to_le32(subtid);
+	fc_hdr->fc_ino = cpu_to_le32(inode->i_ino);
+	fc_hdr->fc_features = 0;
+	fc_hdr->fc_flags = 0;
+
+	if (is_last)
+		ext4_fc_mark_last(fc_hdr);
+
+	memcpy(&fc_hdr->inode, ext4_raw_inode(&iloc), EXT4_INODE_SIZE(sb));
+	cur = (__u8 *)(fc_hdr + 1);
+	start = cur;
+	csum = 0;
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
+		num_tlvs++;
+	}
+
+	fc_hdr->fc_num_tlvs = cpu_to_le16(num_tlvs);
+	csum = ext4_chksum(sbi, csum, (__u8 *)fc_hdr,
+			   offsetof(struct ext4_fc_commit_hdr, fc_csum));
+	csum = ext4_chksum(sbi, csum, &dummy_csum, sizeof(dummy_csum));
+	csum = ext4_chksum(sbi, csum, start, cur - start);
+	fc_hdr->fc_csum = cpu_to_le32(csum);
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
+	spin_lock(&sbi->s_fc_lock);
+	while (!list_empty(&sbi->s_fc_q)) {
+		iter = list_first_entry(&sbi->s_fc_q,
+				  struct ext4_inode_info, i_fc_list);
+		list_del_init(&iter->i_fc_list);
+		inode = &iter->vfs_inode;
+	}
+	INIT_LIST_HEAD(&sbi->s_fc_q);
+	sbi->s_fc_q_cnt = 0;
+	spin_unlock(&sbi->s_fc_lock);
+}
+
+/*
+ * Fast-commit commit callback. There is contention between sbi->s_fc_lock and
+ * i_data_sem. Locking order is - i_data_sem then s_fc_lock
+ */
+static int ext4_journal_fc_commit_cb(journal_t *journal, tid_t tid,
+				     tid_t subtid,
+				     struct transaction_run_stats_s *stats)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct list_head *pos, *tmp;
+	struct ext4_inode_info *iter;
+	struct jbd2_inode *jinode;
+	int num_bufs = 0, ret;
+
+	memset(stats, 0, sizeof(*stats));
+
+	trace_ext4_journal_fc_commit_cb_start(sb);
+	sbi = sbi;
+	spin_lock(&sbi->s_fc_lock);
+	if (!sbi->s_fc_eligible) {
+		sbi->s_fc_eligible = true;
+		spin_unlock(&sbi->s_fc_lock);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0);
+		return -ECANCELED;
+	}
+
+	stats->rs_flushing = jiffies;
+	/* Submit data buffers first */
+	list_for_each(pos, &sbi->s_fc_q) {
+		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		jinode = iter->jinode;
+		ret = jbd2_submit_inode_data(journal, jinode);
+		if (ret) {
+			spin_unlock(&sbi->s_fc_lock);
+			trace_ext4_journal_fc_commit_cb_stop(sb, 0);
+			return ret;
+		}
+	}
+	stats->rs_logging = jiffies;
+	stats->rs_flushing = jbd2_time_diff(stats->rs_flushing,
+					    stats->rs_logging);
+
+	list_for_each_safe(pos, tmp, &sbi->s_fc_q) {
+		struct inode *inode;
+		struct buffer_head *bh;
+		int is_last;
+
+		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		inode = &iter->vfs_inode;
+
+		is_last = list_is_last(pos, &sbi->s_fc_q);
+		spin_unlock(&sbi->s_fc_lock);
+
+		ret = jbd2_map_fc_buf(journal, &bh);
+		if (ret)
+			return -ENOMEM;
+
+		/*
+		 * Release s_fc_lock here since fc_write_inode calls
+		 * ext4_map_blocks which needs i_data_sem.
+		 */
+		ret = ext4_fc_write_inode(journal, bh, inode, tid, subtid,
+					  is_last);
+		if (ret < 0) {
+			trace_ext4_journal_fc_commit_cb_stop(sb, 0);
+			return ret;
+		}
+		lock_buffer(bh);
+		clear_buffer_dirty(bh);
+		set_buffer_uptodate(bh);
+		bh->b_end_io = ext4_end_buffer_io_sync;
+		submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+
+		spin_lock(&sbi->s_fc_lock);
+
+		num_bufs += ret;
+	}
+
+	stats->rs_logging = jbd2_time_diff(stats->rs_logging, jiffies);
+	if (num_bufs == 0) {
+		spin_unlock(&sbi->s_fc_lock);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0);
+		stats->rs_blocks_logged = num_bufs;
+		return 0;
+	}
+
+	/*
+	 * Before returning, check if s_fc_eligible was modified since we
+	 * started.
+	 */
+	if (!sbi->s_fc_eligible) {
+		spin_unlock(&sbi->s_fc_lock);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0);
+		return -ECANCELED;
+	}
+
+	spin_unlock(&sbi->s_fc_lock);
+
+	jbd_debug(3, "%s: Journal blocks ready for fast commit\n", __func__);
+
+	stats->rs_blocks_logged = num_bufs;
+
+	trace_ext4_journal_fc_commit_cb_stop(sb, num_bufs);
+
+	return jbd2_wait_on_fc_bufs(journal, num_bufs);
+}
+
 /* Deal with the reporting of failure conditions on a filesystem such as
  * inconsistencies detected or read IO failures.
  *
@@ -4723,7 +4977,10 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
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
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d68e9e536814..8ef67b61d54a 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2703,6 +2703,43 @@ TRACE_EVENT(ext4_error,
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
+	    TP_PROTO(struct super_block *sb, int nblks),
+
+	TP_ARGS(sb, nblks),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, nblks)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->nblks = nblks;
+	),
+
+	TP_printk("fast_commit done on dev %d,%d, nblks %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->nblks)
+);
+
 #endif /* _TRACE_EXT4_H */
 
 /* This part must be outside protection */
-- 
2.23.0.rc1.153.gdeed80330f-goog

