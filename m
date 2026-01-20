Return-Path: <linux-ext4+bounces-13105-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIwAFxsbcGkEVwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13105-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 01:17:31 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC754E6B6
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 01:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B39D80A907
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E140421EF2;
	Tue, 20 Jan 2026 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="XIBEbRyj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6C4218B2;
	Tue, 20 Jan 2026 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908450; cv=pass; b=j0FGIAXBUZOUB/qhB0MTTf7QOg6M3ibYDjnXnQCrsWg7U6FuORsIpa/5DXKldfYJLcqY4Y0LIadZyX/NBcOlHnoUIbpLyde+GY3IZBwtheOESQkxRLEb5X3RrW4DnAUHsljXxahQ7RYo8cb+YeMDcwdYQ9fcH6hYRPsjkX8AeRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908450; c=relaxed/simple;
	bh=MJX5r+RqV2JBRvBdytNIqdlKYHDtEqETVJGe6io+E54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8SIdAvUxOd9axlj9iLPWZT71CxysQ7k6mE530QjzhjF3iXf55GewcoJwylviWmGvbPKyLf22lIVFSCiVFeuY0HfHJ/Kw5G1ttW/+OK+WS3Azdfx0rDn4NC60fY6GzaQS0VcL2O0EJGaAEoVt9i7OEL7BFSdOcGdl9h9URFkpAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=XIBEbRyj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768908387; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=inIPHrFcQ+l0fKrEjStOIVYXF/xFf3WuNflCiokn6UVIUUiGl2wHN11wQn4distjAETi5HzQ/6LcvRbcbk/RKNA+TlYvRYeiU5tGR2PLH9Ba51hnIBmaT4FpCTwylBIM4vBMO0p5RA11JpZMNq92fJAMn/xopKeV762ZGve4PjI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768908387; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0JeeBma15cKEwonm5lTmW/eQs9kXnesOb28Hero5tiU=; 
	b=BjJMcPjtsugJxUl+l4AkiJ21ya4lKwRF6KV2b96B93mnMFUP8H654vloThWgEHpT7VBdZEY1VEk+w3Q1yBR6nQKaFjKeRK28tnUnqwDKkOlMplOOlKvBfIzt8nWldcn59cgZDk9jSo3qM4/femqjJWk1WbgoTOdtoTQJCt2H6VE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768908387;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0JeeBma15cKEwonm5lTmW/eQs9kXnesOb28Hero5tiU=;
	b=XIBEbRyjJ3AcbMclFVi+OUE0jgjOBY3zSsf8OjUSY/x+QqEizUJOMxaxOAS22jKR
	bKy8vgp2dkqSEuhIHUG/NadJOXtHggUtjzRIVHwgfbyOgtfCa4nGKtWL0g4b52CBkzS
	WVzGbjFL5vi5Ol8SS6Yd46Qaet5TTpjNg5e01eps=
Received: by mx.zohomail.com with SMTPS id 1768908383548197.09377499300263;
	Tue, 20 Jan 2026 03:26:23 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v4 7/7] ext4: fast commit: export snapshot stats in fc_info
Date: Tue, 20 Jan 2026 19:25:36 +0800
Message-ID: <20260120112538.132774-8-me@linux.beauty>
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
	TAGGED_FROM(0.00)[bounces-13105-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,iloc.bh:url]
X-Rspamd-Queue-Id: BFC754E6B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Snapshot-based fast commit can fall back when the commit-time snapshot
cannot be built (e.g. extent status cache misses). It is useful to
quantify the updates-locked window and to see why snapshotting failed.

Add best-effort snapshot counters to the ext4 superblock and extend
/proc/fs/ext4/<sb_id>/fc_info to report the number of snapshotted
inodes and ranges, snapshot failure reasons, and the average/max time
spent with journal updates locked.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ext4.h        | 31 ++++++++++++++++++++++
 fs/ext4/fast_commit.c | 61 ++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/super.c       |  1 +
 3 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 68a64fa0be92..e4d0ec9aad74 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1551,6 +1551,36 @@ struct ext4_orphan_info {
 						 * file blocks */
 };
 
+/*
+ * Ext4 fast commit snapshot statistics.
+ *
+ * These are best-effort counters intended for debugging / performance
+ * introspection; they are not exact under concurrent updates.
+ */
+struct ext4_fc_snap_stats {
+	u64 lock_updates_ns_total;
+	u64 lock_updates_ns_max;
+	u64 lock_updates_samples;
+
+	u64 snap_inodes;
+	u64 snap_ranges;
+
+	u64 snap_fail_es_miss;
+	u64 snap_fail_es_delayed;
+	u64 snap_fail_es_other;
+
+	u64 snap_fail_inodes_cap;
+	u64 snap_fail_ranges_cap;
+	u64 snap_fail_nomem;
+	u64 snap_fail_inode_loc;
+
+	/*
+	 * Missing inode snapshots during log writing should never happen.
+	 * Keep this counter to help catch unexpected regressions.
+	 */
+	u64 snap_fail_no_snap;
+};
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1822,6 +1852,7 @@ struct ext4_sb_info {
 	struct mutex s_fc_lock;
 	struct buffer_head *s_fc_bh;
 	struct ext4_fc_stats s_fc_stats;
+	struct ext4_fc_snap_stats s_fc_snap_stats;
 	tid_t s_fc_ineligible_tid;
 #ifdef CONFIG_EXT4_DEBUG
 	int s_fc_debug_max_replay;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index d266eb2a4219..f1e441cd7c04 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -905,13 +905,17 @@ static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
 	int inode_len;
 	int ret;
 
-	if (!snap)
+	if (!snap) {
+		EXT4_SB(inode->i_sb)->s_fc_snap_stats.snap_fail_no_snap++;
 		return -ECANCELED;
+	}
 
 	src = snap->inode_buf;
 	inode_len = snap->inode_len;
-	if (!src || inode_len == 0)
+	if (!src || inode_len == 0) {
+		EXT4_SB(inode->i_sb)->s_fc_snap_stats.snap_fail_no_snap++;
 		return -ECANCELED;
+	}
 
 	fc_inode.fc_ino = cpu_to_le32(inode->i_ino);
 	tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_INODE);
@@ -946,8 +950,10 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	struct ext4_extent *ex;
 	struct ext4_fc_range *range;
 
-	if (!snap)
+	if (!snap) {
+		EXT4_SB(inode->i_sb)->s_fc_snap_stats.snap_fail_no_snap++;
 		return -ECANCELED;
+	}
 
 	list_for_each_entry(range, &snap->data_list, list) {
 		if (range->tag == EXT4_FC_TAG_DEL_RANGE) {
@@ -1008,6 +1014,8 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 				       int *snap_err)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_fc_snap_stats *stats =
+		&EXT4_SB(inode->i_sb)->s_fc_snap_stats;
 	ext4_lblk_t start_lblk, end_lblk, cur_lblk;
 	unsigned int nr_ranges = 0;
 
@@ -1033,11 +1041,13 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 		ext4_lblk_t len;
 
 		if (!ext4_es_lookup_extent(inode, cur_lblk, NULL, &es, NULL)) {
+			stats->snap_fail_es_miss++;
 			ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_ES_MISS);
 			return -EAGAIN;
 		}
 
 		if (ext4_es_is_delayed(&es)) {
+			stats->snap_fail_es_delayed++;
 			ext4_fc_set_snap_err(snap_err,
 					     EXT4_FC_SNAP_ERR_ES_DELAYED);
 			return -EAGAIN;
@@ -1052,6 +1062,7 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 		}
 
 		if (nr_ranges_total + nr_ranges >= EXT4_FC_SNAPSHOT_MAX_RANGES) {
+			stats->snap_fail_ranges_cap++;
 			ext4_fc_set_snap_err(snap_err,
 					     EXT4_FC_SNAP_ERR_RANGES_CAP);
 			return -E2BIG;
@@ -1059,6 +1070,7 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 
 		range = kmem_cache_alloc(ext4_fc_range_cachep, GFP_NOFS);
 		if (!range) {
+			stats->snap_fail_nomem++;
 			ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_NOMEM);
 			return -ENOMEM;
 		}
@@ -1086,6 +1098,7 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 				range->len = max;
 		} else {
 			kmem_cache_free(ext4_fc_range_cachep, range);
+			stats->snap_fail_es_other++;
 			ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_ES_OTHER);
 			return -EAGAIN;
 		}
@@ -1106,6 +1119,8 @@ static int ext4_fc_snapshot_inode(struct inode *inode,
 				  unsigned int *nr_rangesp, int *snap_err)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_fc_snap_stats *stats =
+		&EXT4_SB(inode->i_sb)->s_fc_snap_stats;
 	struct ext4_fc_inode_snap *snap;
 	int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
 	struct ext4_iloc iloc;
@@ -1116,6 +1131,7 @@ static int ext4_fc_snapshot_inode(struct inode *inode,
 
 	ret = ext4_get_inode_loc_noio(inode, &iloc);
 	if (ret) {
+		stats->snap_fail_inode_loc++;
 		ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_INODE_LOC);
 		return ret;
 	}
@@ -1127,6 +1143,7 @@ static int ext4_fc_snapshot_inode(struct inode *inode,
 
 	snap = kmalloc(struct_size(snap, inode_buf, inode_len), GFP_NOFS);
 	if (!snap) {
+		stats->snap_fail_nomem++;
 		ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_NOMEM);
 		brelse(iloc.bh);
 		return -ENOMEM;
@@ -1151,6 +1168,8 @@ static int ext4_fc_snapshot_inode(struct inode *inode,
 	list_splice_tail_init(&ranges, &snap->data_list);
 	ext4_fc_unlock(inode->i_sb, alloc_ctx);
 
+	stats->snap_inodes++;
+	stats->snap_ranges += nr_ranges;
 	if (nr_rangesp)
 		*nr_rangesp = nr_ranges;
 	return 0;
@@ -1260,6 +1279,7 @@ static int ext4_fc_snapshot_inodes(journal_t *journal, struct inode **inodes,
 	alloc_ctx = ext4_fc_lock(sb);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		if (i >= inodes_size) {
+			sbi->s_fc_snap_stats.snap_fail_inodes_cap++;
 			ext4_fc_set_snap_err(snap_err,
 					     EXT4_FC_SNAP_ERR_INODES_CAP);
 			ret = -E2BIG;
@@ -1285,6 +1305,7 @@ static int ext4_fc_snapshot_inodes(journal_t *journal, struct inode **inodes,
 			continue;
 
 		if (i >= inodes_size) {
+			sbi->s_fc_snap_stats.snap_fail_inodes_cap++;
 			ext4_fc_set_snap_err(snap_err,
 					     EXT4_FC_SNAP_ERR_INODES_CAP);
 			ret = -E2BIG;
@@ -1328,6 +1349,7 @@ static int ext4_fc_perform_commit(journal_t *journal, tid_t commit_tid)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_snap_stats *snap_stats = &sbi->s_fc_snap_stats;
 	struct ext4_inode_info *iter;
 	struct ext4_fc_head head;
 	struct inode *inode;
@@ -1390,8 +1412,13 @@ static int ext4_fc_perform_commit(journal_t *journal, tid_t commit_tid)
 		return ret;
 
 	ret = ext4_fc_alloc_snapshot_inodes(sb, &inodes, &inodes_size);
-	if (ret)
+	if (ret) {
+		if (ret == -E2BIG)
+			snap_stats->snap_fail_inodes_cap++;
+		else if (ret == -ENOMEM)
+			snap_stats->snap_fail_nomem++;
 		return ret;
+	}
 
 	/* Step 4: Mark all inodes as being committed. */
 	jbd2_journal_lock_updates(journal);
@@ -1413,6 +1440,10 @@ static int ext4_fc_perform_commit(journal_t *journal, tid_t commit_tid)
 				      &snap_inodes, &snap_ranges, &snap_err);
 	jbd2_journal_unlock_updates(journal);
 	locked_ns = ktime_to_ns(ktime_sub(ktime_get(), lock_start));
+	snap_stats->lock_updates_ns_total += locked_ns;
+	snap_stats->lock_updates_samples++;
+	if (locked_ns > snap_stats->lock_updates_ns_max)
+		snap_stats->lock_updates_ns_max = locked_ns;
 	trace_ext4_fc_lock_updates(sb, commit_tid, locked_ns, snap_inodes,
 				   snap_ranges, ret, snap_err);
 	kvfree(inodes);
@@ -2709,11 +2740,17 @@ int ext4_fc_info_show(struct seq_file *seq, void *v)
 {
 	struct ext4_sb_info *sbi = EXT4_SB((struct super_block *)seq->private);
 	struct ext4_fc_stats *stats = &sbi->s_fc_stats;
+	struct ext4_fc_snap_stats *snap_stats = &sbi->s_fc_snap_stats;
+	u64 lock_avg_ns = 0;
 	int i;
 
 	if (v != SEQ_START_TOKEN)
 		return 0;
 
+	if (snap_stats->lock_updates_samples)
+		lock_avg_ns = div_u64(snap_stats->lock_updates_ns_total,
+				      snap_stats->lock_updates_samples);
+
 	seq_printf(seq,
 		"fc stats:\n%ld commits\n%ld ineligible\n%ld numblks\n%lluus avg_commit_time\n",
 		   stats->fc_num_commits, stats->fc_ineligible_commits,
@@ -2724,6 +2761,22 @@ int ext4_fc_info_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "\"%s\":\t%d\n", fc_ineligible_reasons[i],
 			stats->fc_ineligible_reason_count[i]);
 
+	seq_printf(seq,
+		   "Snapshot stats:\n%llu inodes\n%llu ranges\n%lluus lock_updates_avg\n%lluus lock_updates_max\n",
+		   snap_stats->snap_inodes, snap_stats->snap_ranges,
+		   div_u64(lock_avg_ns, 1000),
+		   div_u64(snap_stats->lock_updates_ns_max, 1000));
+	seq_printf(seq,
+		   "Snapshot failures:\n%llu es_miss\n%llu es_delayed\n%llu es_other\n%llu inodes_cap\n%llu ranges_cap\n%llu nomem\n%llu inode_loc\n%llu no_snap\n",
+		   snap_stats->snap_fail_es_miss,
+		   snap_stats->snap_fail_es_delayed,
+		   snap_stats->snap_fail_es_other,
+		   snap_stats->snap_fail_inodes_cap,
+		   snap_stats->snap_fail_ranges_cap,
+		   snap_stats->snap_fail_nomem,
+		   snap_stats->snap_fail_inode_loc,
+		   snap_stats->snap_fail_no_snap);
+
 	return 0;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4f5f0c21d436..3afcaf9d8007 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4500,6 +4500,7 @@ static void ext4_fast_commit_init(struct super_block *sb)
 	sbi->s_fc_ineligible_tid = 0;
 	mutex_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
+	memset(&sbi->s_fc_snap_stats, 0, sizeof(sbi->s_fc_snap_stats));
 	sbi->s_fc_replay_state.fc_regions = NULL;
 	sbi->s_fc_replay_state.fc_regions_size = 0;
 	sbi->s_fc_replay_state.fc_regions_used = 0;
-- 
2.52.0

