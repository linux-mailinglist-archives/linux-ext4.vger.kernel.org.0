Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033F0C2E5C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbfJAHmL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43231 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733121AbfJAHmK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id v27so8986147pgk.10
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPEYFQogYMEqLHR322kSougE11dIMMHohDqztBq/tBk=;
        b=FdtKKXRabUC5TzXYf7W+Tnyz20+T03y7ICX71bemrmq9s+h194UgyLv+4y+pQ8XdxW
         dPVvfRy01l8E4w6ozvhKsEdE6HyWlkli9hFzTdk4zZ4Ij+BfENWUfHxovvsiKwgQNQ9p
         67aZ0ZFRekSRO9CuDKx64HlJdhc8swK5xzuhCEvq4K2s+QRaFUnwf0pl3YP6uYIJHehO
         lMDnF7A2aMQK6BvCpWWsHihDFNciksjB0njqpQE5q0KmzRj9LY/V6SATsIeqqto53mDI
         QcmBWFd0Qxj2GzN05FrI3D4tRxirT/6jiYGFI6pTZqnPrgb0n27YTC/8D4ZgbopmdHv7
         xOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPEYFQogYMEqLHR322kSougE11dIMMHohDqztBq/tBk=;
        b=PPs7vXo5vQE8ucx63MloYTtNflVsCPeQKuKSmBgSZD+yJnyU1sp6j7FJkG6wB14Lta
         zFxKnqbjRo5qkA1SFWEpTmV4WG/NCSr9ht8whXoDUWVZQjhfAE3v2+mVKc871bpHEmxH
         JUSlgrXYjh5dL4EXh27W0lFijoTKn/sVxc/N8Da+IodfIGr18PnnfimMSMdm8EmrYtk8
         9CDQ9KFfqKUKHR9J1XX2cw/j720rGQeCXEYTFUmWPJysftojiY3ZUx/e1ii/w5CrYSsp
         RC4Gy9p9sB3aVU4hIZUPZPuQd40j8aFOhmyN1vJytDVHxvNrb8A+tOBJZjtUVDjKNvlP
         3PUQ==
X-Gm-Message-State: APjAAAVa1Xy5uEAHuheNRmZx10QHx823tG0zOFiGJ/JgyiFRjtvnP2Ix
        1EzEpv6BSV8nzopeLSFxVwpGwwwv/7s=
X-Google-Smtp-Source: APXvYqxjiZ1UbCkNTEhz+lZpkwm1l39S3am7h35wt6rKgnAgcpxBiH8bViIhabK/tcRIFI6muOlHOg==
X-Received: by 2002:a63:408:: with SMTP id 8mr29275411pge.334.1569915727661;
        Tue, 01 Oct 2019 00:42:07 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:07 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 09/13] ext4: fast-commit commit path changes
Date:   Tue,  1 Oct 2019 00:40:58 -0700
Message-Id: <20191001074101.256523-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch implements the actual commit path for fast commit. Based on
inodes tracked and their respective changes remembered, this
patch adds code to create a fast commit block that stores extents
added as well as dentrys created for the inode. We use new JBD2
interfaces added in previous patches in this series. The fast commit
blocks that are created have extents that _should_ be present in the
file. It doesn't yet support removing of extents, making operations
such as truncate, delete fast commit incompatible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c         | 309 ++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h         |  50 +++++-
 fs/ext4/extents.c           |   8 +-
 fs/ext4/inode.c             |  22 ++-
 fs/ext4/super.c             |  11 ++
 include/trace/events/ext4.h |  39 +++++
 6 files changed, 429 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0bb8de2139a5..fd7740372438 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -4,6 +4,7 @@
  */
 
 #include "ext4_jbd2.h"
+#include "ext4_extents.h"
 
 #include <trace/events/ext4.h>
 
@@ -480,3 +481,311 @@ bool ext4_is_inode_fc_new(struct inode *inode)
 
 	return ret;
 }
+
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
+static inline u8 *fc_add_tag(u8 *dst, u16 tag, u16 len, u8 *val)
+{
+	struct ext4_fc_tl tl;
+
+	tl.fc_tag = cpu_to_le16(tag);
+	tl.fc_len = cpu_to_le16(len);
+	memcpy(dst, &tl, sizeof(tl));
+	memcpy(dst + sizeof(tl), val, len);
+
+	return dst + sizeof(tl) + len;
+}
+
+int ext4_fc_write_inode(journal_t *journal, struct buffer_head *bh,
+			struct inode *inode, tid_t tid, tid_t subtid,
+			int is_last, struct dentry *dentry)
+{
+	ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
+	struct super_block *sb = journal->j_private;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_map_blocks map;
+	struct ext4_iloc iloc;
+	struct ext4_extent extent;
+	struct inode *parent;
+	__u32 dummy_csum = 0, csum;
+	__u8 *start, *cur, *end;
+	__u16 num_tlvs = 0;
+	int ret;
+
+	read_lock(&ei->i_fc.fc_lock);
+	if (tid != ei->i_fc.fc_tid) {
+		jbd_debug(3,
+			  "File not modified. Modified %d, expected %d",
+			  ei->i_fc.fc_tid, tid);
+		read_unlock(&ei->i_fc.fc_lock);
+		return 0;
+	}
+	read_unlock(&ei->i_fc.fc_lock);
+
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -ECANCELED;
+
+	if (ext4_is_inode_fc_new(inode)) {
+		parent = d_inode(dentry->d_parent);
+		if (parent && ext4_is_inode_fc_ineligible(parent))
+			return -ECANCELED;
+	}
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+	end = (__u8 *)bh->b_data + journal->j_blocksize;
+
+	write_lock(&ei->i_fc.fc_lock);
+	old_blk_size = (ei->i_fc.fc_lblk_start + sb->s_blocksize - 1) >>
+		       inode->i_blkbits;
+	new_blk_size = ei->i_fc.fc_lblk_end >> inode->i_blkbits;
+	ei->i_fc.fc_lblk_start = ei->i_fc.fc_lblk_end;
+	write_unlock(&ei->i_fc.fc_lock);
+
+	jbd_debug(3, "Committing as tid = %d, subtid = %d on buffer %lld\n",
+		  tid, subtid, bh->b_blocknr);
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
+	if (ext4_is_inode_fc_new(inode)) {
+		__le32 parent_ino;
+
+		read_lock(&ei->i_fc.fc_lock);
+		parent_ino = cpu_to_le32(ei->i_fc.fc_parent_ino);
+		read_unlock(&ei->i_fc.fc_lock);
+
+		if (!dentry)
+			return -ECANCELED;
+
+		cur = fc_add_tag(cur, EXT4_FC_TAG_PARENT_INO,
+				      sizeof(parent_ino), (u8 *)&parent_ino);
+		cur = fc_add_tag(cur, EXT4_FC_TAG_DNAME,
+				 dentry->d_name.len,
+				 (u8 *)dentry->d_name.name);
+		num_tlvs = 2;
+	}
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
+		extent.ee_len = cpu_to_le16(map.m_len);
+		ext4_ext_store_pblock(&extent, map.m_pblk);
+		ext4_ext_mark_initialized(&extent);
+		cur = fc_add_tag(cur, EXT4_FC_TAG_EXT,
+				 sizeof(struct ext4_extent),
+				 (u8 *)&extent);
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
+	sbi->s_fc_eligible = true;
+}
+
+/*
+ * Fast-commit commit callback. There is contention between sbi->s_fc_lock and
+ * i_data_sem. Locking order is - i_data_sem then s_fc_lock
+ */
+static int ext4_journal_fc_commit_cb(journal_t *journal, tid_t tid,
+			      tid_t subtid,
+			      struct transaction_run_stats_s *stats)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct list_head *pos, *tmp;
+	struct ext4_inode_info *iter;
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
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "ineligible");
+		return -ECANCELED;
+	}
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb)))) {
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "shutdown");
+		return -EIO;
+	}
+
+	stats->rs_flushing = jiffies;
+	/* Submit data buffers first */
+	list_for_each(pos, &sbi->s_fc_q) {
+		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+		ret = jbd2_submit_inode_data(journal, iter->jinode);
+		if (ret) {
+			spin_unlock(&sbi->s_fc_lock);
+			trace_ext4_journal_fc_commit_cb_stop(sb, 0,
+							     "data_commit");
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
+		if (ret) {
+			trace_ext4_journal_fc_commit_cb_stop(sb, 0,
+							     "map_fc_buf");
+			return -ENOMEM;
+		}
+
+		/*
+		 * Release s_fc_lock here since fc_write_inode calls
+		 * ext4_map_blocks which needs i_data_sem.
+		 */
+		ret = ext4_fc_write_inode(journal, bh, inode, tid, subtid,
+					  is_last, NULL);
+		if (ret < 0) {
+			trace_ext4_journal_fc_commit_cb_stop(sb, 0,
+							     "fc_write_inode");
+			return ret;
+		}
+		lock_buffer(bh);
+		clear_buffer_dirty(bh);
+		set_buffer_uptodate(bh);
+		bh->b_end_io = ext4_end_buffer_io_sync;
+		submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+		spin_lock(&sbi->s_fc_lock);
+
+		num_bufs++;
+	}
+
+	stats->rs_logging = jbd2_time_diff(stats->rs_logging, jiffies);
+	if (num_bufs == 0) {
+		spin_unlock(&sbi->s_fc_lock);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "no_data");
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
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "ineligible2");
+		return -ECANCELED;
+	}
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb)))) {
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "shutdown2");
+		return -EIO;
+	}
+
+	spin_unlock(&sbi->s_fc_lock);
+
+	jbd_debug(3, "%s: Journal blocks ready for fast commit\n", __func__);
+
+	stats->rs_blocks_logged = num_bufs;
+
+	trace_ext4_journal_fc_commit_cb_stop(sb, num_bufs, "success");
+
+	return jbd2_wait_on_fc_bufs(journal, num_bufs);
+}
+
+void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
+{
+	if (ext4_should_fast_commit(sb)) {
+		journal->j_fc_commit_callback = ext4_journal_fc_commit_cb;
+		journal->j_fc_cleanup_callback = ext4_journal_fc_cleanup_cb;
+	}
+}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 2cb7e7e1f025..acb9533068c4 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -397,8 +397,14 @@ static inline void ext4_update_inode_fsync_trans(handle_t *handle,
 
 	if (ext4_handle_valid(handle) && !is_handle_aborted(handle)) {
 		ei->i_sync_tid = handle->h_transaction->t_tid;
-		if (datasync)
+		if (ext4_should_fast_commit(inode->i_sb))
+			ei->i_sync_subtid = handle->h_transaction->t_subtid;
+		if (datasync) {
 			ei->i_datasync_tid = handle->h_transaction->t_tid;
+			if (ext4_should_fast_commit(inode->i_sb))
+				ei->i_datasync_subtid =
+						handle->h_transaction->t_subtid;
+		}
 	}
 }
 
@@ -470,6 +476,47 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 	return 1;
 }
 
+/* Ext4 fast commit related info */
+
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
+#define EXT4_FC_TAG_DNAME	0x2
+#define EXT4_FC_TAG_PARENT_INO	0x3
+
+struct ext4_fc_tl {
+	__le16 fc_tag;
+	__le16 fc_len;
+};
+
 void ext4_init_inode_fc_info(struct inode *inode);
 extern void ext4_fc_enqueue_inode(handle_t *handle, struct inode *inode);
 extern void ext4_fc_del(struct inode *inode);
@@ -507,4 +554,5 @@ void ext4_fc_update_commit_range(struct inode *inode, ext4_lblk_t start,
 void ext4_fc_mark_new(struct inode *inode);
 bool ext4_is_inode_fc_ineligible(struct inode *inode);
 bool ext4_is_inode_fc_new(struct inode *inode);
+void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b30f6175eb71..dea4c2632272 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4898,10 +4898,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
-	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
-		ret = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
-						EXT4_I(inode)->i_sync_tid);
-	}
+	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal)
+		ret = jbd2_fc_complete_commit(
+		    EXT4_SB(inode->i_sb)->s_journal, EXT4_I(inode)->i_sync_tid,
+		    EXT4_I(inode)->i_sync_subtid);
 out:
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ea039e3e1a4d..cbfa1ec858a1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5039,20 +5039,25 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	 */
 	if (journal) {
 		transaction_t *transaction;
-		tid_t tid;
+		tid_t tid, subtid;
 
 		read_lock(&journal->j_state_lock);
 		if (journal->j_running_transaction)
 			transaction = journal->j_running_transaction;
 		else
 			transaction = journal->j_committing_transaction;
-		if (transaction)
+		if (transaction) {
 			tid = transaction->t_tid;
-		else
+			subtid = transaction->t_subtid;
+		} else {
 			tid = journal->j_commit_sequence;
+			subtid = journal->j_fc_sequence;
+		}
 		read_unlock(&journal->j_state_lock);
 		ei->i_sync_tid = tid;
 		ei->i_datasync_tid = tid;
+		ei->i_sync_subtid = subtid;
+		ei->i_datasync_subtid = subtid;
 	}
 
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
@@ -5475,8 +5480,9 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
 			return 0;
 
-		err = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
-						EXT4_I(inode)->i_sync_tid);
+		err = jbd2_fc_complete_commit(
+		    EXT4_SB(inode->i_sb)->s_journal, EXT4_I(inode)->i_sync_tid,
+		    EXT4_I(inode)->i_sync_subtid);
 	} else {
 		struct ext4_iloc iloc;
 
@@ -5628,6 +5634,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		if (attr->ia_valid & ATTR_GID)
 			inode->i_gid = attr->ia_gid;
 		error = ext4_mark_inode_dirty(handle, inode);
+		ext4_fc_enqueue_inode(handle, inode);
 		ext4_journal_stop(handle);
 	}
 
@@ -5688,6 +5695,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 				inode->i_mtime = current_time(inode);
 				inode->i_ctime = inode->i_mtime;
 			}
+			ext4_fc_enqueue_inode(handle, inode);
 			down_write(&EXT4_I(inode)->i_data_sem);
 			EXT4_I(inode)->i_disksize = attr->ia_size;
 			rc = ext4_mark_inode_dirty(handle, inode);
@@ -5732,6 +5740,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (!error) {
 		setattr_copy(inode, attr);
+		ext4_fc_enqueue_inode(ext4_journal_current_handle(),
+						   inode);
 		mark_inode_dirty(inode);
 	}
 
@@ -6144,6 +6154,7 @@ void ext4_dirty_inode(struct inode *inode, int flags)
 		goto out;
 
 	ext4_mark_inode_dirty(handle, inode);
+	ext4_fc_enqueue_inode(handle, inode);
 
 	ext4_journal_stop(handle);
 out:
@@ -6229,6 +6240,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
+	ext4_fc_mark_ineligible(inode);
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_handle_sync(handle);
 	ext4_journal_stop(handle);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 3e9570ea9748..208c57b5ac80 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1129,6 +1129,16 @@ static void ext4_destroy_inode(struct inode *inode)
 				true);
 		dump_stack();
 	}
+	if (!list_empty(&(EXT4_I(inode)->i_fc_list))) {
+#ifdef EXT4FS_DEBUG
+		if (EXT4_SB(inode->i_sb)->s_fc_eligible) {
+			pr_warn("%s: INODE %ld in FC List with FC allowd",
+				__func__, inode->i_ino);
+			dump_stack();
+		}
+#endif
+		ext4_fc_del(inode);
+	}
 }
 
 static void init_once(void *foo)
@@ -4713,6 +4723,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	journal->j_commit_interval = sbi->s_commit_interval;
 	journal->j_min_batch_time = sbi->s_min_batch_time;
 	journal->j_max_batch_time = sbi->s_max_batch_time;
+	ext4_init_fast_commit(sb, journal);
 
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d68e9e536814..9c24b1c5239f 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2703,6 +2703,45 @@ TRACE_EVENT(ext4_error,
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
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->nblks = nblks;
+		__entry->reason = reason;
+	),
+
+	TP_printk("fast_commit done on dev %d,%d, nblks %d, reason %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->nblks, __entry->reason)
+);
+
 #endif /* _TRACE_EXT4_H */
 
 /* This part must be outside protection */
-- 
2.23.0.444.g18eeb5a265-goog

