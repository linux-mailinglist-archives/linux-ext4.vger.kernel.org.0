Return-Path: <linux-ext4+bounces-13104-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDDEGvRxcGktYAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13104-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 07:28:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD14520C5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 07:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87EF752A367
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9383EDABE;
	Tue, 20 Jan 2026 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="TeTrNHKd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02493D669E;
	Tue, 20 Jan 2026 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908442; cv=pass; b=qlKMrWWxtuwXO6aWQLpZ7+yXc0MltNl2FDFumNS7/Pct1Ye7lUZRIruvofwnt0W8941hxC0mdldD5woeaAsARD1gGb6OuWqP8fIKIhLTbj6UG4+YT/F4wlkt/G1vrryqT1GgSm8bZ5JnBOLRJZpWGi2c03B5dGS8+mpyXe3TlqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908442; c=relaxed/simple;
	bh=oWKDxPIb2khKjpqFB1hods/FuIUqRj7VoWuJWLh4il8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSCrZxiegAWvbfmnOCgYy9DYLRV021iloKuYOfC17N2YQ6QI+LuOuCuFU50z+RtqyhZ+10EBIsLh/qC5EBAPFJfNiwkKJHgXwbWI8pqupeIamjBO6pkPimmddCcwfyruxGW7DkREsp7ANH443ynRzq48v1Xi477A1GE4fr30KpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=TeTrNHKd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768908382; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l0RVpk0vdYCLCYZ+zCLfPI4m/RKFtCg50/oWJRkyakCEvV19qWbPcAneajFaxU+AEUD8tZy1XbV0UiDGJtj208KrBZoiN3GihklDbsjsNpt8vuwv3XfyF3oeA9LvOwYXHClanU6bGWzBgGU+/8HP8mpiesXb9WH6BaE6fDe8FOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768908382; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LvhCWF3FvvL6YDco3Bdp7x5v4DKlqw5hZmCYaXOmJc8=; 
	b=T4+hERsmlLh10kJBRyD3vUmUZn7iFNw4YV48jcdEQ0KfIgXVaGDsUAO09vnahzLkJlWMRmm2NorcKWNo9v4NCgBe1VuFpXao7yVtG18st6s44P6qUSmD0i7ID2p3Z+rxzRkbQJW0iC0EK/9XhEriIM6st6+W5ots9DLmTn0JUJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768908382;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LvhCWF3FvvL6YDco3Bdp7x5v4DKlqw5hZmCYaXOmJc8=;
	b=TeTrNHKdgZXlYhCnYF7hQ7JvtKVyghjg7aiv1WXMmp2Xz9QhMYlwAW29e9KzAzzA
	Kg+WRNvC1UQmpX262Wq/irl2dra50dH2eVig+0prlvv1c7gRp1UHr+HIpzkE4+LU+Yv
	HlTmZvTRbVzfa5KAyz5bPABIu/N8HODXTg5fBV88=
Received: by mx.zohomail.com with SMTPS id 1768908380099737.3273924208657;
	Tue, 20 Jan 2026 03:26:20 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v4 6/7] ext4: fast commit: add lock_updates tracepoint
Date: Tue, 20 Jan 2026 19:25:35 +0800
Message-ID: <20260120112538.132774-7-me@linux.beauty>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13104-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux.beauty];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1FD14520C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit-time fast commit snapshots run under jbd2_journal_lock_updates(),
so it is useful to quantify the time spent with updates locked and to
understand why snapshotting can fail.

Add a new tracepoint, ext4_fc_lock_updates, reporting the time spent in
the updates-locked window along with the number of snapshotted inodes
and ranges. Record the first snapshot failure reason in a stable snap_err
field for tooling.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c       | 86 ++++++++++++++++++++++++++++++-------
 include/trace/events/ext4.h | 33 ++++++++++++++
 2 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index d1eefee60912..d266eb2a4219 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -193,6 +193,27 @@ static struct kmem_cache *ext4_fc_range_cachep;
 #define EXT4_FC_SNAPSHOT_MAX_INODES	1024
 #define EXT4_FC_SNAPSHOT_MAX_RANGES	2048
 
+/*
+ * Snapshot failure reasons for ext4_fc_lock_updates tracepoint.
+ * Keep these stable for tooling.
+ */
+enum ext4_fc_snap_err {
+	EXT4_FC_SNAP_ERR_NONE = 0,
+	EXT4_FC_SNAP_ERR_ES_MISS,
+	EXT4_FC_SNAP_ERR_ES_DELAYED,
+	EXT4_FC_SNAP_ERR_ES_OTHER,
+	EXT4_FC_SNAP_ERR_INODES_CAP,
+	EXT4_FC_SNAP_ERR_RANGES_CAP,
+	EXT4_FC_SNAP_ERR_NOMEM,
+	EXT4_FC_SNAP_ERR_INODE_LOC,
+};
+
+static inline void ext4_fc_set_snap_err(int *snap_err, int err)
+{
+	if (snap_err && *snap_err == EXT4_FC_SNAP_ERR_NONE)
+		*snap_err = err;
+}
+
 static void ext4_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
 {
 	BUFFER_TRACE(bh, "");
@@ -983,11 +1004,12 @@ static void ext4_fc_free_inode_snap(struct inode *inode)
 static int ext4_fc_snapshot_inode_data(struct inode *inode,
 				       struct list_head *ranges,
 				       unsigned int nr_ranges_total,
-				       unsigned int *nr_rangesp)
+				       unsigned int *nr_rangesp,
+				       int *snap_err)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	unsigned int nr_ranges = 0;
 	ext4_lblk_t start_lblk, end_lblk, cur_lblk;
+	unsigned int nr_ranges = 0;
 
 	spin_lock(&ei->i_fc_lock);
 	if (ei->i_fc_lblk_len == 0) {
@@ -1010,11 +1032,16 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 		struct ext4_fc_range *range;
 		ext4_lblk_t len;
 
-		if (!ext4_es_lookup_extent(inode, cur_lblk, NULL, &es, NULL))
+		if (!ext4_es_lookup_extent(inode, cur_lblk, NULL, &es, NULL)) {
+			ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_ES_MISS);
 			return -EAGAIN;
+		}
 
-		if (ext4_es_is_delayed(&es))
+		if (ext4_es_is_delayed(&es)) {
+			ext4_fc_set_snap_err(snap_err,
+					     EXT4_FC_SNAP_ERR_ES_DELAYED);
 			return -EAGAIN;
+		}
 
 		len = es.es_len - (cur_lblk - es.es_lblk);
 		if (len > end_lblk - cur_lblk + 1)
@@ -1024,12 +1051,17 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 			continue;
 		}
 
-		if (nr_ranges_total + nr_ranges >= EXT4_FC_SNAPSHOT_MAX_RANGES)
+		if (nr_ranges_total + nr_ranges >= EXT4_FC_SNAPSHOT_MAX_RANGES) {
+			ext4_fc_set_snap_err(snap_err,
+					     EXT4_FC_SNAP_ERR_RANGES_CAP);
 			return -E2BIG;
+		}
 
 		range = kmem_cache_alloc(ext4_fc_range_cachep, GFP_NOFS);
-		if (!range)
+		if (!range) {
+			ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_NOMEM);
 			return -ENOMEM;
+		}
 		nr_ranges++;
 
 		range->lblk = cur_lblk;
@@ -1054,6 +1086,7 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 				range->len = max;
 		} else {
 			kmem_cache_free(ext4_fc_range_cachep, range);
+			ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_ES_OTHER);
 			return -EAGAIN;
 		}
 
@@ -1070,7 +1103,7 @@ static int ext4_fc_snapshot_inode_data(struct inode *inode,
 
 static int ext4_fc_snapshot_inode(struct inode *inode,
 				  unsigned int nr_ranges_total,
-				  unsigned int *nr_rangesp)
+				  unsigned int *nr_rangesp, int *snap_err)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_fc_inode_snap *snap;
@@ -1082,8 +1115,10 @@ static int ext4_fc_snapshot_inode(struct inode *inode,
 	int alloc_ctx;
 
 	ret = ext4_get_inode_loc_noio(inode, &iloc);
-	if (ret)
+	if (ret) {
+		ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_INODE_LOC);
 		return ret;
+	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_INLINE_DATA))
 		inode_len = EXT4_INODE_SIZE(inode->i_sb);
@@ -1092,6 +1127,7 @@ static int ext4_fc_snapshot_inode(struct inode *inode,
 
 	snap = kmalloc(struct_size(snap, inode_buf, inode_len), GFP_NOFS);
 	if (!snap) {
+		ext4_fc_set_snap_err(snap_err, EXT4_FC_SNAP_ERR_NOMEM);
 		brelse(iloc.bh);
 		return -ENOMEM;
 	}
@@ -1102,7 +1138,7 @@ static int ext4_fc_snapshot_inode(struct inode *inode,
 	brelse(iloc.bh);
 
 	ret = ext4_fc_snapshot_inode_data(inode, &ranges, nr_ranges_total,
-					  &nr_ranges);
+					  &nr_ranges, snap_err);
 	if (ret) {
 		kfree(snap);
 		ext4_fc_free_ranges(&ranges);
@@ -1203,7 +1239,10 @@ static int ext4_fc_alloc_snapshot_inodes(struct super_block *sb,
 					 unsigned int *nr_inodesp);
 
 static int ext4_fc_snapshot_inodes(journal_t *journal, struct inode **inodes,
-				   unsigned int inodes_size)
+				   unsigned int inodes_size,
+				   unsigned int *nr_inodesp,
+				   unsigned int *nr_rangesp,
+				   int *snap_err)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1221,6 +1260,8 @@ static int ext4_fc_snapshot_inodes(journal_t *journal, struct inode **inodes,
 	alloc_ctx = ext4_fc_lock(sb);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		if (i >= inodes_size) {
+			ext4_fc_set_snap_err(snap_err,
+					     EXT4_FC_SNAP_ERR_INODES_CAP);
 			ret = -E2BIG;
 			goto unlock;
 		}
@@ -1244,6 +1285,8 @@ static int ext4_fc_snapshot_inodes(journal_t *journal, struct inode **inodes,
 			continue;
 
 		if (i >= inodes_size) {
+			ext4_fc_set_snap_err(snap_err,
+					     EXT4_FC_SNAP_ERR_INODES_CAP);
 			ret = -E2BIG;
 			goto unlock;
 		}
@@ -1268,16 +1311,20 @@ static int ext4_fc_snapshot_inodes(journal_t *journal, struct inode **inodes,
 		unsigned int inode_ranges = 0;
 
 		ret = ext4_fc_snapshot_inode(inodes[idx], nr_ranges,
-					     &inode_ranges);
+					     &inode_ranges, snap_err);
 		if (ret)
 			break;
 		nr_ranges += inode_ranges;
 	}
 
+	if (nr_inodesp)
+		*nr_inodesp = i;
+	if (nr_rangesp)
+		*nr_rangesp = nr_ranges;
 	return ret;
 }
 
-static int ext4_fc_perform_commit(journal_t *journal)
+static int ext4_fc_perform_commit(journal_t *journal, tid_t commit_tid)
 {
 	struct super_block *sb = journal->j_private;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1286,10 +1333,15 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	struct inode *inode;
 	struct inode **inodes;
 	unsigned int inodes_size;
+	unsigned int snap_inodes = 0;
+	unsigned int snap_ranges = 0;
+	int snap_err = EXT4_FC_SNAP_ERR_NONE;
 	struct blk_plug plug;
 	int ret = 0;
 	u32 crc = 0;
 	int alloc_ctx;
+	ktime_t lock_start;
+	u64 locked_ns;
 
 	/*
 	 * Step 1: Mark all inodes on s_fc_q[MAIN] with
@@ -1337,13 +1389,13 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	if (ret)
 		return ret;
 
-
 	ret = ext4_fc_alloc_snapshot_inodes(sb, &inodes, &inodes_size);
 	if (ret)
 		return ret;
 
 	/* Step 4: Mark all inodes as being committed. */
 	jbd2_journal_lock_updates(journal);
+	lock_start = ktime_get();
 	/*
 	 * The journal is now locked. No more handles can start and all the
 	 * previous handles are now drained. Snapshotting happens in this
@@ -1357,8 +1409,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	}
 	ext4_fc_unlock(sb, alloc_ctx);
 
-	ret = ext4_fc_snapshot_inodes(journal, inodes, inodes_size);
+	ret = ext4_fc_snapshot_inodes(journal, inodes, inodes_size,
+				      &snap_inodes, &snap_ranges, &snap_err);
 	jbd2_journal_unlock_updates(journal);
+	locked_ns = ktime_to_ns(ktime_sub(ktime_get(), lock_start));
+	trace_ext4_fc_lock_updates(sb, commit_tid, locked_ns, snap_inodes,
+				   snap_ranges, ret, snap_err);
 	kvfree(inodes);
 	if (ret)
 		return ret;
@@ -1563,7 +1619,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 		journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
 	set_task_ioprio(current, journal_ioprio);
 	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
-	ret = ext4_fc_perform_commit(journal);
+	ret = ext4_fc_perform_commit(journal, commit_tid);
 	if (ret < 0) {
 		if (ret == -EAGAIN || ret == -E2BIG || ret == -ECANCELED)
 			status = EXT4_FC_STATUS_INELIGIBLE;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index fd76d14c2776..a1493971821d 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2812,6 +2812,39 @@ TRACE_EVENT(ext4_fc_commit_stop,
 		  __entry->num_fc_ineligible, __entry->nblks_agg, __entry->tid)
 );
 
+TRACE_EVENT(ext4_fc_lock_updates,
+	    TP_PROTO(struct super_block *sb, tid_t commit_tid, u64 locked_ns,
+		     unsigned int nr_inodes, unsigned int nr_ranges, int err,
+		     int snap_err),
+
+	TP_ARGS(sb, commit_tid, locked_ns, nr_inodes, nr_ranges, err, snap_err),
+
+	TP_STRUCT__entry(/* entry */
+		__field(dev_t, dev)
+		__field(tid_t, tid)
+		__field(u64, locked_ns)
+		__field(unsigned int, nr_inodes)
+		__field(unsigned int, nr_ranges)
+		__field(int, err)
+		__field(int, snap_err)
+	),
+
+	TP_fast_assign(/* assign */
+		__entry->dev = sb->s_dev;
+		__entry->tid = commit_tid;
+		__entry->locked_ns = locked_ns;
+		__entry->nr_inodes = nr_inodes;
+		__entry->nr_ranges = nr_ranges;
+		__entry->err = err;
+		__entry->snap_err = snap_err;
+	),
+
+	TP_printk("dev %d,%d tid %u locked_ns %llu nr_inodes %u nr_ranges %u err %d snap_err %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->tid,
+		  __entry->locked_ns, __entry->nr_inodes, __entry->nr_ranges,
+		  __entry->err, __entry->snap_err)
+);
+
 #define FC_REASON_NAME_STAT(reason)					\
 	show_fc_reason(reason),						\
 	__entry->fc_ineligible_rc[reason]
-- 
2.52.0

