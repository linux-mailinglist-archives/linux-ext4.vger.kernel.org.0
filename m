Return-Path: <linux-ext4+bounces-13099-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OARBgaRcGkaYgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13099-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 09:40:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0253B56
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 09:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0BFD6017BC
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50203A1CFF;
	Tue, 20 Jan 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="nFI+0Ux0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-e107.zoho.com (sender4-pp-e107.zoho.com [136.143.188.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361143A89C5;
	Tue, 20 Jan 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908383; cv=pass; b=pU3CC0D8WEUaorV35di66C1jakXBWRlZXuMQIBzIg2w4NL6fFEHeBnMsL0Ro0wFCLSvQUoioadSvgHBdfYubRcRaiHeok/oShsN4EXizRD+kmEeK/0OEuvA+vTp5pI29i38SVgPGREvXYNh1wkdx4vVASGl/SSATT8ycDtDLoHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908383; c=relaxed/simple;
	bh=sPvSlm93eDdGQexMGFxHRrS9VVgGNnGUly6YnQ53J50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqhXY2Gexch7b6LEQqbsGUzSJorsEhLpXa98CPYJ7Q25eIHFJNfiBKbMWhQrLVla9Xr97vca7FMdc9leHuL3h285UU0W3B9uQxBwcP6TFHt0a2Dhtcskt5p+7rVihlQ7YR4ouG4ISXX0Cc+1KcdGYeQBKOT81lzX0aXwH8VkNNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=nFI+0Ux0; arc=pass smtp.client-ip=136.143.188.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768908362; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SUk3qiuIN/O3YYcRoknJiia2cpQjMbNj51x4h+pJ0nutiNWkb5fVikdsU1DEZv3Z1T3yXDjpAjeRos7XmmAJnJYGI5yxnUEyC5PpYizg33rW1ii87x5EmF1UVrMb7d+EW+/2jZ6cLjSLa2F9RIOnK2y8nEa50uP8KQZBArI0xUo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768908362; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HbJGzhkFH+v05qw6iYZSFLHlnHT8VCkyaHpg3JIVdio=; 
	b=OjIW2gvVZIZVSd+gfHVaZ4P+RoTC0RjQgOQF1ewAGlt+mh97CjhxtQiYnQdsns11s9I3rsDGA7RjCqk0wPu+Y6kzx9u5nnk58l+08f/kAMzBUllw/F4AAwk+6cMMAPdpcfbtoXkMQ468cQURoBGOZ/PFFAT0JsrSHgGFlVnjV7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768908362;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HbJGzhkFH+v05qw6iYZSFLHlnHT8VCkyaHpg3JIVdio=;
	b=nFI+0Ux0iETGxCzzpXxdkCH7Zz9RoEpcPv2lWjSIbd498RUe5OUQ8E1bscQX2GPg
	ISZcUdCmrE5f8A+2R912PZanIHCCuyZ4CB1LTltqi2ihHaZVhsRFFPqQ1UXN24jeMyd
	rCbv5B9HugsM3M1C7BU5+AS0G0/SLhZOlJipUgXY=
Received: by mx.zohomail.com with SMTPS id 1768908359503711.1844079005059;
	Tue, 20 Jan 2026 03:25:59 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v4 1/7] ext4: fast commit: snapshot inode state before writing log
Date: Tue, 20 Jan 2026 19:25:30 +0800
Message-ID: <20260120112538.132774-2-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120112538.132774-1-me@linux.beauty>
References: <20260120112538.132774-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13099-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux.beauty];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 87D0253B56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fast commit writes inode metadata and data range updates after unlocking
journal updates. New handles can start at that point, so the log writing
path must not look at live inode state.

Add a commit-time per-inode snapshot and populate it while journal updates
are locked and existing handles are drained. Store the snapshot behind
ext4_inode_info->i_fc_snap so ext4_inode_info only grows by one pointer.
The snapshot contains a copy of the on-disk inode plus the data range
records needed for fast commit TLVs.

Snapshotting runs under jbd2_journal_lock_updates(). Avoid triggering I/O
there by using ext4_get_inode_loc_noio() and falling back to full commit
if the inode table block is not present or not uptodate.

Log writing then only serializes the snapshot, so it no longer needs to
call ext4_map_blocks() and take i_data_sem under s_fc_lock. The snapshot
is installed and freed under s_fc_lock and is released from fast commit
cleanup and inode eviction.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ext4.h        |  22 ++-
 fs/ext4/fast_commit.c | 330 +++++++++++++++++++++++++++++++++++-------
 fs/ext4/inode.c       |  51 +++++++
 3 files changed, 351 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1524276aeac7..bd30c24d4f94 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1033,6 +1033,7 @@ enum {
 	I_DATA_SEM_EA
 };
 
+struct ext4_fc_inode_snap;
 
 /*
  * fourth extended file system inode data in memory
@@ -1089,6 +1090,22 @@ struct ext4_inode_info {
 	/* End of lblk range that needs to be committed in this fast commit */
 	ext4_lblk_t i_fc_lblk_len;
 
+	/*
+	 * Commit-time fast commit snapshots.
+	 *
+	 * i_fc_snap is installed and freed under sbi->s_fc_lock. The fast
+	 * commit log writing path reads the snapshot under sbi->s_fc_lock while
+	 * serializing fast commit TLVs.
+	 *
+	 * The snapshot lifetime is bounded by EXT4_STATE_FC_COMMITTING and the
+	 * corresponding cleanup / eviction paths.
+	 *
+	 * i_fc_snap points to per-inode snapshot data for fast commit:
+	 * - a raw inode snapshot for EXT4_FC_TAG_INODE
+	 * - data range records for EXT4_FC_TAG_{ADD,DEL}_RANGE
+	 */
+	struct ext4_fc_inode_snap *i_fc_snap;
+
 	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
 
 	/* Fast commit wait queue for this inode */
@@ -3093,8 +3110,9 @@ extern int  ext4_file_getattr(struct mnt_idmap *, const struct path *,
 			      struct kstat *, u32, unsigned int);
 extern void ext4_dirty_inode(struct inode *, int);
 extern int ext4_change_inode_journal_flag(struct inode *, int);
-extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
-extern int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
+int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc);
+int ext4_get_inode_loc_noio(struct inode *inode, struct ext4_iloc *iloc);
+int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
 			  struct ext4_iloc *iloc);
 extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5bd57d7f921b..d5c28304e818 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -55,21 +55,23 @@
  *     deleted while it is being flushed.
  * [2] Flush data buffers to disk and clear "EXT4_STATE_FC_FLUSHING_DATA"
  *     state.
- * [3] Lock the journal by calling jbd2_journal_lock_updates. This ensures that
- *     all the exsiting handles finish and no new handles can start.
- * [4] Mark all the fast commit eligible inodes as undergoing fast commit
- *     by setting "EXT4_STATE_FC_COMMITTING" state.
- * [5] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
+ * [3] Lock the journal by calling jbd2_journal_lock_updates(). This ensures
+ *     that all the existing handles finish and no new handles can start.
+ * [4] Mark all the fast commit eligible inodes as undergoing fast commit by
+ *     setting "EXT4_STATE_FC_COMMITTING" state, and snapshot the inode state
+ *     needed for log writing.
+ * [5] Unlock the journal by calling jbd2_journal_unlock_updates(). This allows
  *     starting of new handles. If new handles try to start an update on
  *     any of the inodes that are being committed, ext4_fc_track_inode()
  *     will block until those inodes have finished the fast commit.
  * [6] Commit all the directory entry updates in the fast commit space.
- * [7] Commit all the changed inodes in the fast commit space and clear
- *     "EXT4_STATE_FC_COMMITTING" for these inodes.
+ * [7] Commit all the changed inodes in the fast commit space.
  * [8] Write tail tag (this tag ensures the atomicity, please read the following
  *     section for more details).
+ * [9] Clear "EXT4_STATE_FC_COMMITTING" and wake up waiters in
+ *     ext4_fc_cleanup().
  *
- * All the inode updates must be enclosed within jbd2_jounrnal_start()
+ * All the inode updates must be enclosed within jbd2_journal_start()
  * and jbd2_journal_stop() similar to JBD2 journaling.
  *
  * Fast Commit Ineligibility
@@ -199,6 +201,8 @@ static void ext4_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 	unlock_buffer(bh);
 }
 
+static void ext4_fc_free_inode_snap(struct inode *inode);
+
 static inline void ext4_fc_reset_inode(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -215,6 +219,7 @@ void ext4_fc_init_inode(struct inode *inode)
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	INIT_LIST_HEAD(&ei->i_fc_dilist);
+	ei->i_fc_snap = NULL;
 	init_waitqueue_head(&ei->i_fc_wait);
 }
 
@@ -240,6 +245,7 @@ void ext4_fc_del(struct inode *inode)
 
 	alloc_ctx = ext4_fc_lock(inode->i_sb);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
+		ext4_fc_free_inode_snap(inode);
 		ext4_fc_unlock(inode->i_sb, alloc_ctx);
 		return;
 	}
@@ -281,6 +287,7 @@ void ext4_fc_del(struct inode *inode)
 		}
 		finish_wait(wq, &wait.wq_entry);
 	}
+	ext4_fc_free_inode_snap(inode);
 	list_del_init(&ei->i_fc_list);
 
 	/*
@@ -845,6 +852,21 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 	return true;
 }
 
+struct ext4_fc_range {
+	struct list_head list;
+	u16 tag;
+	ext4_lblk_t lblk;
+	ext4_lblk_t len;
+	ext4_fsblk_t pblk;
+	bool unwritten;
+};
+
+struct ext4_fc_inode_snap {
+	struct list_head data_list;
+	unsigned int inode_len;
+	u8 inode_buf[];
+};
+
 /*
  * Writes inode in the fast commit space under TLV with tag @tag.
  * Returns 0 on success, error on failure.
@@ -852,21 +874,21 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
-	int ret;
-	struct ext4_iloc iloc;
+	struct ext4_fc_inode_snap *snap = ei->i_fc_snap;
 	struct ext4_fc_inode fc_inode;
 	struct ext4_fc_tl tl;
 	u8 *dst;
+	u8 *src;
+	int inode_len;
+	int ret;
 
-	ret = ext4_get_inode_loc(inode, &iloc);
-	if (ret)
-		return ret;
+	if (!snap)
+		return -ECANCELED;
 
-	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA))
-		inode_len = EXT4_INODE_SIZE(inode->i_sb);
-	else if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
-		inode_len += ei->i_extra_isize;
+	src = snap->inode_buf;
+	inode_len = snap->inode_len;
+	if (!src || inode_len == 0)
+		return -ECANCELED;
 
 	fc_inode.fc_ino = cpu_to_le32(inode->i_ino);
 	tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_INODE);
@@ -882,10 +904,9 @@ static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
 	dst += EXT4_FC_TAG_BASE_LEN;
 	memcpy(dst, &fc_inode, sizeof(fc_inode));
 	dst += sizeof(fc_inode);
-	memcpy(dst, (u8 *)ext4_raw_inode(&iloc), inode_len);
+	memcpy(dst, src, inode_len);
 	ret = 0;
 err:
-	brelse(iloc.bh);
 	return ret;
 }
 
@@ -895,12 +916,74 @@ static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
  */
 static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 {
-	ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_map_blocks map;
+	struct ext4_fc_inode_snap *snap = ei->i_fc_snap;
 	struct ext4_fc_add_range fc_ext;
 	struct ext4_fc_del_range lrange;
 	struct ext4_extent *ex;
+	struct ext4_fc_range *range;
+
+	if (!snap)
+		return -ECANCELED;
+
+	list_for_each_entry(range, &snap->data_list, list) {
+		if (range->tag == EXT4_FC_TAG_DEL_RANGE) {
+			lrange.fc_ino = cpu_to_le32(inode->i_ino);
+			lrange.fc_lblk = cpu_to_le32(range->lblk);
+			lrange.fc_len = cpu_to_le32(range->len);
+			if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_DEL_RANGE,
+					     sizeof(lrange), (u8 *)&lrange, crc))
+				return -ENOSPC;
+			continue;
+		}
+
+		fc_ext.fc_ino = cpu_to_le32(inode->i_ino);
+		ex = (struct ext4_extent *)&fc_ext.fc_ex;
+		ex->ee_block = cpu_to_le32(range->lblk);
+		ex->ee_len = cpu_to_le16(range->len);
+		ext4_ext_store_pblock(ex, range->pblk);
+		if (range->unwritten)
+			ext4_ext_mark_unwritten(ex);
+		else
+			ext4_ext_mark_initialized(ex);
+
+		if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_ADD_RANGE,
+				     sizeof(fc_ext), (u8 *)&fc_ext, crc))
+			return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static void ext4_fc_free_ranges(struct list_head *head)
+{
+	struct ext4_fc_range *range, *range_n;
+
+	list_for_each_entry_safe(range, range_n, head, list) {
+		list_del(&range->list);
+		kfree(range);
+	}
+}
+
+static void ext4_fc_free_inode_snap(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_fc_inode_snap *snap = ei->i_fc_snap;
+
+	if (!snap)
+		return;
+
+	ext4_fc_free_ranges(&snap->data_list);
+	kfree(snap);
+	ei->i_fc_snap = NULL;
+}
+
+static int ext4_fc_snapshot_inode_data(struct inode *inode,
+				       struct list_head *ranges)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	ext4_lblk_t start_lblk, end_lblk, cur_lblk;
+	struct ext4_map_blocks map;
 	int ret;
 
 	spin_lock(&ei->i_fc_lock);
@@ -908,18 +991,20 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 		spin_unlock(&ei->i_fc_lock);
 		return 0;
 	}
-	old_blk_size = ei->i_fc_lblk_start;
-	new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
+	start_lblk = ei->i_fc_lblk_start;
+	end_lblk = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
 	ei->i_fc_lblk_len = 0;
 	spin_unlock(&ei->i_fc_lock);
 
-	cur_lblk_off = old_blk_size;
-	ext4_debug("will try writing %d to %d for inode %ld\n",
-		   cur_lblk_off, new_blk_size, inode->i_ino);
+	cur_lblk = start_lblk;
+	ext4_debug("snapshot data ranges %u-%u for inode %lu\n",
+		   start_lblk, end_lblk, inode->i_ino);
+
+	while (cur_lblk <= end_lblk) {
+		struct ext4_fc_range *range;
 
-	while (cur_lblk_off <= new_blk_size) {
-		map.m_lblk = cur_lblk_off;
-		map.m_len = new_blk_size - cur_lblk_off + 1;
+		map.m_lblk = cur_lblk;
+		map.m_len = end_lblk - cur_lblk + 1;
 		ret = ext4_map_blocks(NULL, inode, &map,
 				      EXT4_GET_BLOCKS_IO_SUBMIT |
 				      EXT4_EX_NOCACHE);
@@ -927,17 +1012,21 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 			return -ECANCELED;
 
 		if (map.m_len == 0) {
-			cur_lblk_off++;
+			cur_lblk++;
 			continue;
 		}
 
+		range = kmalloc(sizeof(*range), GFP_NOFS);
+		if (!range)
+			return -ENOMEM;
+
+		range->lblk = map.m_lblk;
+		range->len = map.m_len;
+		range->pblk = 0;
+		range->unwritten = false;
+
 		if (ret == 0) {
-			lrange.fc_ino = cpu_to_le32(inode->i_ino);
-			lrange.fc_lblk = cpu_to_le32(map.m_lblk);
-			lrange.fc_len = cpu_to_le32(map.m_len);
-			if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_DEL_RANGE,
-					    sizeof(lrange), (u8 *)&lrange, crc))
-				return -ENOSPC;
+			range->tag = EXT4_FC_TAG_DEL_RANGE;
 		} else {
 			unsigned int max = (map.m_flags & EXT4_MAP_UNWRITTEN) ?
 				EXT_UNWRITTEN_MAX_LEN : EXT_INIT_MAX_LEN;
@@ -945,26 +1034,67 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 			/* Limit the number of blocks in one extent */
 			map.m_len = min(max, map.m_len);
 
-			fc_ext.fc_ino = cpu_to_le32(inode->i_ino);
-			ex = (struct ext4_extent *)&fc_ext.fc_ex;
-			ex->ee_block = cpu_to_le32(map.m_lblk);
-			ex->ee_len = cpu_to_le16(map.m_len);
-			ext4_ext_store_pblock(ex, map.m_pblk);
-			if (map.m_flags & EXT4_MAP_UNWRITTEN)
-				ext4_ext_mark_unwritten(ex);
-			else
-				ext4_ext_mark_initialized(ex);
-			if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_ADD_RANGE,
-					    sizeof(fc_ext), (u8 *)&fc_ext, crc))
-				return -ENOSPC;
+			range->tag = EXT4_FC_TAG_ADD_RANGE;
+			range->len = map.m_len;
+			range->pblk = map.m_pblk;
+			range->unwritten = !!(map.m_flags & EXT4_MAP_UNWRITTEN);
 		}
 
-		cur_lblk_off += map.m_len;
+		INIT_LIST_HEAD(&range->list);
+		list_add_tail(&range->list, ranges);
+
+		cur_lblk += map.m_len;
 	}
 
 	return 0;
 }
 
+static int ext4_fc_snapshot_inode(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_fc_inode_snap *snap;
+	int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
+	struct ext4_iloc iloc;
+	LIST_HEAD(ranges);
+	int ret;
+	int alloc_ctx;
+
+	ret = ext4_get_inode_loc_noio(inode, &iloc);
+	if (ret)
+		return ret;
+
+	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA))
+		inode_len = EXT4_INODE_SIZE(inode->i_sb);
+	else if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
+		inode_len += ei->i_extra_isize;
+
+	snap = kmalloc(struct_size(snap, inode_buf, inode_len), GFP_NOFS);
+	if (!snap) {
+		brelse(iloc.bh);
+		return -ENOMEM;
+	}
+	INIT_LIST_HEAD(&snap->data_list);
+	snap->inode_len = inode_len;
+
+	memcpy(snap->inode_buf, (u8 *)ext4_raw_inode(&iloc), inode_len);
+	brelse(iloc.bh);
+
+	ret = ext4_fc_snapshot_inode_data(inode, &ranges);
+	if (ret) {
+		kfree(snap);
+		ext4_fc_free_ranges(&ranges);
+		return ret;
+	}
+
+	alloc_ctx = ext4_fc_lock(inode->i_sb);
+	ext4_fc_free_inode_snap(inode);
+	ei->i_fc_snap = snap;
+	list_splice_tail_init(&ranges, &snap->data_list);
+	ext4_fc_unlock(inode->i_sb, alloc_ctx);
+
+	return 0;
+}
+
 
 /* Flushes data of all the inodes in the commit queue. */
 static int ext4_fc_flush_data(journal_t *journal)
@@ -1015,6 +1145,11 @@ static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
 		 */
 		if (list_empty(&fc_dentry->fcd_dilist))
 			continue;
+		/*
+		 * For EXT4_FC_TAG_CREAT, fcd_dilist is linked on the created
+		 * inode's i_fc_dilist list (kept singular), so we can recover the
+		 * inode through it.
+		 */
 		ei = list_first_entry(&fc_dentry->fcd_dilist,
 				struct ext4_inode_info, i_fc_dilist);
 		inode = &ei->vfs_inode;
@@ -1039,6 +1174,88 @@ static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
 	return 0;
 }
 
+static int ext4_fc_snapshot_inodes(journal_t *journal)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_inode_info *iter;
+	struct ext4_fc_dentry_update *fc_dentry;
+	struct inode **inodes;
+	unsigned int nr_inodes = 0;
+	unsigned int i = 0;
+	int ret = 0;
+	int alloc_ctx;
+
+	alloc_ctx = ext4_fc_lock(sb);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list)
+		nr_inodes++;
+
+	list_for_each_entry(fc_dentry, &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
+		struct ext4_inode_info *ei;
+
+		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT)
+			continue;
+		if (list_empty(&fc_dentry->fcd_dilist))
+			continue;
+
+		/* See the comment in ext4_fc_commit_dentry_updates(). */
+		ei = list_first_entry(&fc_dentry->fcd_dilist,
+				      struct ext4_inode_info, i_fc_dilist);
+		if (!list_empty(&ei->i_fc_list))
+			continue;
+
+		nr_inodes++;
+	}
+	ext4_fc_unlock(sb, alloc_ctx);
+
+	if (!nr_inodes)
+		return 0;
+
+	inodes = kvcalloc(nr_inodes, sizeof(*inodes), GFP_NOFS);
+	if (!inodes)
+		return -ENOMEM;
+
+	alloc_ctx = ext4_fc_lock(sb);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		inodes[i] = igrab(&iter->vfs_inode);
+		if (inodes[i])
+			i++;
+	}
+
+	list_for_each_entry(fc_dentry, &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
+		struct ext4_inode_info *ei;
+
+		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT)
+			continue;
+		if (list_empty(&fc_dentry->fcd_dilist))
+			continue;
+
+		/* See the comment in ext4_fc_commit_dentry_updates(). */
+		ei = list_first_entry(&fc_dentry->fcd_dilist,
+				      struct ext4_inode_info, i_fc_dilist);
+		if (!list_empty(&ei->i_fc_list))
+			continue;
+
+		inodes[i] = igrab(&ei->vfs_inode);
+		if (inodes[i])
+			i++;
+	}
+	ext4_fc_unlock(sb, alloc_ctx);
+
+	for (nr_inodes = 0; nr_inodes < i; nr_inodes++) {
+		ret = ext4_fc_snapshot_inode(inodes[nr_inodes]);
+		if (ret)
+			break;
+	}
+
+	for (nr_inodes = 0; nr_inodes < i; nr_inodes++) {
+		if (inodes[nr_inodes])
+			iput(inodes[nr_inodes]);
+	}
+	kvfree(inodes);
+	return ret;
+}
+
 static int ext4_fc_perform_commit(journal_t *journal)
 {
 	struct super_block *sb = journal->j_private;
@@ -1111,7 +1328,11 @@ static int ext4_fc_perform_commit(journal_t *journal)
 				     EXT4_STATE_FC_COMMITTING);
 	}
 	ext4_fc_unlock(sb, alloc_ctx);
+
+	ret = ext4_fc_snapshot_inodes(journal);
 	jbd2_journal_unlock_updates(journal);
+	if (ret)
+		return ret;
 
 	/*
 	 * Step 5: If file system device is different from journal device,
@@ -1308,6 +1529,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					struct ext4_inode_info,
 					i_fc_list);
 		list_del_init(&ei->i_fc_list);
+		ext4_fc_free_inode_snap(&ei->vfs_inode);
 		ext4_clear_inode_state(&ei->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
 		if (tid_geq(tid, ei->i_sync_tid)) {
@@ -1343,6 +1565,14 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					     struct ext4_fc_dentry_update,
 					     fcd_list);
 		list_del_init(&fc_dentry->fcd_list);
+		if (fc_dentry->fcd_op == EXT4_FC_TAG_CREAT &&
+		    !list_empty(&fc_dentry->fcd_dilist)) {
+			/* See the comment in ext4_fc_commit_dentry_updates(). */
+			ei = list_first_entry(&fc_dentry->fcd_dilist,
+					      struct ext4_inode_info,
+					      i_fc_dilist);
+			ext4_fc_free_inode_snap(&ei->vfs_inode);
+		}
 		list_del_init(&fc_dentry->fcd_dilist);
 
 		release_dentry_name_snapshot(&fc_dentry->fcd_name);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a1c81ffdca2b..385ff112d405 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4969,6 +4969,57 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 	return ret;
 }
 
+/*
+ * ext4_get_inode_loc_noio() is a best-effort variant of ext4_get_inode_loc().
+ * It looks up the inode table block in the buffer cache and returns -EAGAIN if
+ * the block is not present or not uptodate, without starting any I/O.
+ */
+int ext4_get_inode_loc_noio(struct inode *inode, struct ext4_iloc *iloc)
+{
+	struct super_block *sb = inode->i_sb;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *bh;
+	ext4_fsblk_t block;
+	int inodes_per_block, inode_offset;
+	unsigned long ino = inode->i_ino;
+
+	iloc->bh = NULL;
+	if (ino < EXT4_ROOT_INO ||
+	    ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
+		return -EFSCORRUPTED;
+
+	iloc->block_group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
+	gdp = ext4_get_group_desc(sb, iloc->block_group, NULL);
+	if (!gdp)
+		return -EIO;
+
+	/* Figure out the offset within the block group inode table. */
+	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
+	inode_offset = ((ino - 1) % EXT4_INODES_PER_GROUP(sb));
+	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
+
+	block = ext4_inode_table(sb, gdp);
+	if (block <= le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block) ||
+	    block >= ext4_blocks_count(EXT4_SB(sb)->s_es)) {
+		ext4_error(sb,
+			   "Invalid inode table block %llu in block_group %u",
+			   block, iloc->block_group);
+		return -EFSCORRUPTED;
+	}
+	block += inode_offset / inodes_per_block;
+
+	bh = sb_find_get_block(sb, block);
+	if (!bh)
+		return -EAGAIN;
+	if (!ext4_buffer_uptodate(bh)) {
+		brelse(bh);
+		return -EAGAIN;
+	}
+
+	iloc->bh = bh;
+	return 0;
+}
+
 
 int ext4_get_fc_inode_loc(struct super_block *sb, unsigned long ino,
 			  struct ext4_iloc *iloc)
-- 
2.52.0

