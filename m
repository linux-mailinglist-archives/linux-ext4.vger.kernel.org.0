Return-Path: <linux-ext4+bounces-13744-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO+IFoP4lmn4swIAu9opvQ
	(envelope-from <linux-ext4+bounces-13744-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 12:48:19 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05A15E691
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 12:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50FE93029E74
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974AF30B528;
	Thu, 19 Feb 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="IBDBCQBw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358B2EFD86;
	Thu, 19 Feb 2026 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501678; cv=pass; b=F1OgRRgvZOZymtfEJclQdpTFb7aDD6RrHwtdF66oHrzfhmEhM1+9STh/R1F5/geiIst9jEnnwr5+chmZ9XFJBieMrAvdL7M+4OJtj+S6LSYLsgb+bnRDhbAGAgJ5rqa4hGaVJLe+5ZX2OHxb218Uzl1TeBtUSR4/hCRtK4so/HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501678; c=relaxed/simple;
	bh=2jnKPNyXtWVMoxlYjpTp6vfnHR4MlArkFxehPYw08fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUvVEhsMjRUiGK3lqZOCutorK44lhEKoQ2W9I17nk8+n6794K02FpPY9fxbxZysa5nYzLfWhzeTxAEqkCJQrUpD4FHnq1U6yzF02bvVXaqVzmafuYyPVDMINWRDTbyOG2ylD2jgVeoB3kLI9gdpTCkC8a5i6IzNCYVKxNs06Hbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=IBDBCQBw; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771501627; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ppk4FyR/kI8wi6zJENcR7SsHq0y/GLJdaXieCYxbEiJUzpCE8EDlrbrqI0S7PYU/pj3ULKLM9y0SZVD2gvyDhTU1/SfLSCcAsV6HJR5R6CkjXgS7A9XfnFW+oshvSV/pRAyBKoWhAFmkWXtFueHixBT/0jyo4LpVl8HUEfZ+xc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771501627; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cx3WrzkDClvn7JkmLhU42Xsl09KwMYuZ02nSaGGQmyI=; 
	b=FZ11lon7dETY+yUTNJWheCzQPYjHytJKzAd9lLuMvHUvMjSw3ksFOCKs3CvCyVLaczzxlrczsN0tXEhkkhIoDUrfM422TR9ar7L7qdMJnaf/lYRe83Y59Z4yiNQndnYZgE9AGphpzWLplL3MYmgh52/5TfXQM1ZvHDphc0coswg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771501627;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Cx3WrzkDClvn7JkmLhU42Xsl09KwMYuZ02nSaGGQmyI=;
	b=IBDBCQBwnFbmdUqv7HX5oDbn1qwsd289OXboa3tkevjjm0/Fgtq32ch35OeY33C2
	9OwCtDOIjC8cYeYoVPdyXjUibtRheQQhm6jaPWOtD5YSdtmkjQWOh81J319bcsyFUs3
	8YxwGL6XbtbyPxc1Gm4sjgDgwME1SpsZ6gqghmHk=
Received: by mx.zohomail.com with SMTPS id 177150162461772.82110652436563;
	Thu, 19 Feb 2026 03:47:04 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v2 1/3] jbd2: store jinode dirty range in PAGE_SIZE units
Date: Thu, 19 Feb 2026 19:46:42 +0800
Message-ID: <20260219114645.778338-2-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219114645.778338-1-me@linux.beauty>
References: <20260219114645.778338-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13744-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: BB05A15E691
X-Rspamd-Action: no action

jbd2_inode fields are updated under journal->j_list_lock, but some paths
read them without holding the lock (e.g. fast commit helpers and ordered
truncate helpers).

READ_ONCE() alone is not sufficient for i_dirty_start/end as they are
loff_t and 32-bit platforms can observe torn loads. Store the dirty range
in PAGE_SIZE units as pgoff_t so lockless readers can take non-torn
snapshots.

Use READ_ONCE() on the read side and WRITE_ONCE() on the write side for
the dirty range and i_flags to match the existing lockless access pattern.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v1:
- Store i_dirty_start/end in PAGE_SIZE units (pgoff_t) to avoid torn loads on
  32-bit (pointed out by Matthew, suggested by Jan).
- Use WRITE_ONCE() for i_dirty_* / i_flags updates (per Jan).
- Drop pointless READ_ONCE() on i_vfs_inode in jbd2_wait_inode_data (per Jan).

 fs/jbd2/commit.c      | 65 ++++++++++++++++++++++++++++++++++---------
 fs/jbd2/journal.c     |  3 +-
 fs/jbd2/transaction.c | 20 ++++++++-----
 include/linux/jbd2.h  | 17 +++++++----
 4 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 7203d2d2624d..d98f4dbde695 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -180,7 +180,13 @@ static int journal_wait_on_commit_record(journal_t *journal,
 /* Send all the data buffers related to an inode */
 int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
 {
-	if (!jinode || !(jinode->i_flags & JI_WRITE_DATA))
+	unsigned long flags;
+
+	if (!jinode)
+		return 0;
+
+	flags = READ_ONCE(jinode->i_flags);
+	if (!(flags & JI_WRITE_DATA))
 		return 0;
 
 	trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
@@ -191,12 +197,35 @@ EXPORT_SYMBOL(jbd2_submit_inode_data);
 
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
 {
-	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
-		!jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
+	struct address_space *mapping;
+	struct inode *inode;
+	unsigned long flags;
+	pgoff_t start, end;
+	loff_t start_byte, end_byte;
+
+	if (!jinode)
+		return 0;
+
+	flags = READ_ONCE(jinode->i_flags);
+	if (!(flags & JI_WAIT_DATA))
+		return 0;
+
+	inode = jinode->i_vfs_inode;
+	if (!inode)
+		return 0;
+
+	mapping = inode->i_mapping;
+	start = READ_ONCE(jinode->i_dirty_start);
+	end = READ_ONCE(jinode->i_dirty_end);
+	if (end == JBD2_INODE_DIRTY_RANGE_NONE)
+		return 0;
+	start_byte = (loff_t)start << PAGE_SHIFT;
+	end_byte = ((loff_t)end << PAGE_SHIFT) + PAGE_SIZE - 1;
+
+	if (!mapping)
 		return 0;
 	return filemap_fdatawait_range_keep_errors(
-		jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
-		jinode->i_dirty_end);
+		mapping, start_byte, end_byte);
 }
 EXPORT_SYMBOL(jbd2_wait_inode_data);
 
@@ -218,7 +247,8 @@ static int journal_submit_data_buffers(journal_t *journal,
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
 		if (!(jinode->i_flags & JI_WRITE_DATA))
 			continue;
-		jinode->i_flags |= JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags,
+			   jinode->i_flags | JI_COMMIT_RUNNING);
 		spin_unlock(&journal->j_list_lock);
 		/* submit the inode data buffers. */
 		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
@@ -229,7 +259,8 @@ static int journal_submit_data_buffers(journal_t *journal,
 		}
 		spin_lock(&journal->j_list_lock);
 		J_ASSERT(jinode->i_transaction == commit_transaction);
-		jinode->i_flags &= ~JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags,
+			   jinode->i_flags & ~JI_COMMIT_RUNNING);
 		smp_mb();
 		wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
 	}
@@ -240,10 +271,17 @@ static int journal_submit_data_buffers(journal_t *journal,
 int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	pgoff_t start = READ_ONCE(jinode->i_dirty_start);
+	pgoff_t end = READ_ONCE(jinode->i_dirty_end);
+	loff_t start_byte, end_byte;
+
+	if (end == JBD2_INODE_DIRTY_RANGE_NONE)
+		return 0;
+	start_byte = (loff_t)start << PAGE_SHIFT;
+	end_byte = ((loff_t)end << PAGE_SHIFT) + PAGE_SIZE - 1;
 
 	return filemap_fdatawait_range_keep_errors(mapping,
-						   jinode->i_dirty_start,
-						   jinode->i_dirty_end);
+						   start_byte, end_byte);
 }
 
 /*
@@ -262,7 +300,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
 		if (!(jinode->i_flags & JI_WAIT_DATA))
 			continue;
-		jinode->i_flags |= JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags, jinode->i_flags | JI_COMMIT_RUNNING);
 		spin_unlock(&journal->j_list_lock);
 		/* wait for the inode data buffers writeout. */
 		if (journal->j_finish_inode_data_buffers) {
@@ -272,7 +310,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 		}
 		cond_resched();
 		spin_lock(&journal->j_list_lock);
-		jinode->i_flags &= ~JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags, jinode->i_flags & ~JI_COMMIT_RUNNING);
 		smp_mb();
 		wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
 	}
@@ -288,8 +326,9 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 				&jinode->i_transaction->t_inode_list);
 		} else {
 			jinode->i_transaction = NULL;
-			jinode->i_dirty_start = 0;
-			jinode->i_dirty_end = 0;
+			WRITE_ONCE(jinode->i_dirty_start, 0);
+			WRITE_ONCE(jinode->i_dirty_end,
+				   JBD2_INODE_DIRTY_RANGE_NONE);
 		}
 	}
 	spin_unlock(&journal->j_list_lock);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c973162d5b31..9a7477c54dcb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -3021,7 +3021,7 @@ void jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode)
 	jinode->i_vfs_inode = inode;
 	jinode->i_flags = 0;
 	jinode->i_dirty_start = 0;
-	jinode->i_dirty_end = 0;
+	jinode->i_dirty_end = JBD2_INODE_DIRTY_RANGE_NONE;
 	INIT_LIST_HEAD(&jinode->i_list);
 }
 
@@ -3178,4 +3178,3 @@ MODULE_DESCRIPTION("Generic filesystem journal-writing module");
 MODULE_LICENSE("GPL");
 module_init(journal_init);
 module_exit(journal_exit);
-
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index dca4b5d8aaaa..bbe47be6c73c 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2646,6 +2646,7 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
+	pgoff_t start, end;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -2654,15 +2655,20 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 	jbd2_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
 			transaction->t_tid);
 
+	start = (pgoff_t)(start_byte >> PAGE_SHIFT);
+	end = (pgoff_t)(end_byte >> PAGE_SHIFT);
+
 	spin_lock(&journal->j_list_lock);
-	jinode->i_flags |= flags;
+	WRITE_ONCE(jinode->i_flags, jinode->i_flags | flags);
 
-	if (jinode->i_dirty_end) {
-		jinode->i_dirty_start = min(jinode->i_dirty_start, start_byte);
-		jinode->i_dirty_end = max(jinode->i_dirty_end, end_byte);
+	if (jinode->i_dirty_end != JBD2_INODE_DIRTY_RANGE_NONE) {
+		WRITE_ONCE(jinode->i_dirty_start,
+			   min(jinode->i_dirty_start, start));
+		WRITE_ONCE(jinode->i_dirty_end,
+			   max(jinode->i_dirty_end, end));
 	} else {
-		jinode->i_dirty_start = start_byte;
-		jinode->i_dirty_end = end_byte;
+		WRITE_ONCE(jinode->i_dirty_start, start);
+		WRITE_ONCE(jinode->i_dirty_end, end);
 	}
 
 	/* Is inode already attached where we need it? */
@@ -2739,7 +2745,7 @@ int jbd2_journal_begin_ordered_truncate(journal_t *journal,
 	int ret = 0;
 
 	/* This is a quick check to avoid locking if not necessary */
-	if (!jinode->i_transaction)
+	if (!READ_ONCE(jinode->i_transaction))
 		goto out;
 	/* Locks are here just to force reading of recent values, it is
 	 * enough that the transaction was not committing before we started
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index a53a00d36228..81eb58ddc126 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -390,6 +390,8 @@ static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 /* Wait for outstanding data writes for this inode before commit */
 #define JI_WAIT_DATA (1 << __JI_WAIT_DATA)
 
+#define JBD2_INODE_DIRTY_RANGE_NONE	((pgoff_t)-1)
+
 /**
  * struct jbd2_inode - The jbd_inode type is the structure linking inodes in
  * ordered mode present in a transaction so that we can sync them during commit.
@@ -431,18 +433,23 @@ struct jbd2_inode {
 	/**
 	 * @i_dirty_start:
 	 *
-	 * Offset in bytes where the dirty range for this inode starts.
+	 * Dirty range start in PAGE_SIZE units.
+	 *
+	 * The dirty range is empty if @i_dirty_end is set to
+	 * %JBD2_INODE_DIRTY_RANGE_NONE.
+	 *
 	 * [j_list_lock]
 	 */
-	loff_t i_dirty_start;
+	pgoff_t i_dirty_start;
 
 	/**
 	 * @i_dirty_end:
 	 *
-	 * Inclusive offset in bytes where the dirty range for this inode
-	 * ends. [j_list_lock]
+	 * Dirty range end in PAGE_SIZE units (inclusive).
+	 *
+	 * [j_list_lock]
 	 */
-	loff_t i_dirty_end;
+	pgoff_t i_dirty_end;
 };
 
 struct jbd2_revoke_table_s;
-- 
2.52.0

