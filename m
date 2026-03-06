Return-Path: <linux-ext4+bounces-14681-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAV0EKSaqmmbUQEAu9opvQ
	(envelope-from <linux-ext4+bounces-14681-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:13:08 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F5321DAEA
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D772C3016893
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBD033B6D2;
	Fri,  6 Mar 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="fUecrIVh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E764533A9CB;
	Fri,  6 Mar 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788383; cv=pass; b=OB0DzAVlVxkJgPYqmmWowrWk7iLKah82mZ21Zycxf40TKgsGJCV1Hsm/RGJ9cERRyAu4KnU7YUmJOdtWFvgeZHC/qj/kjTJDxhDnVKPWrvd8KXYqidTzRtXwPCo7xqiC9DU91PCCMqWgw2hymJbwv7n6EioSa5Xq6O6yrwP7W9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788383; c=relaxed/simple;
	bh=RIt/K3dbf/jCBmOegl2T65GE6fBo2ZoBdKGc4eUCYhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPGgDsEappyljHobq2wJqVsaCVvgjoKopbOzEmo7xDPCKdZEsoyHza8XHqZH21uLgGLnHGdi/ZGmcy8pMOTZjvWtahxPwKnMbY5tb8mkXyIxLaKiUfnHmanfNJMaUM1fMjZ4bwtCVl5LYPv3yJJMsFl9xU02H/KhvwHgr33hpm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=fUecrIVh; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772788374; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DQllaLyE4kOpyrUg5MDFGu9pZfm2BvG0bvJNsctmFTA699vMmLs8EOO9hLShntAfsNycgTSMO1nMFr+J8YSWDIAy61BAcHuh3ZN+ABuOVsnPqf1d7vA3STEsVqxrMca2i0S2/1LCexdjkKzMenf+pAuUaWOdxF0djmfDKLFtKCw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772788374; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UhaLQnxw6IYxJZMyMwnG0zOmGc8AkVob2k0lQF7GI3w=; 
	b=kZvU/Hy/GI/Imla6+iHQwkJ1OvrxPFkeKN70//rzXyV6rwl2R0qfIrlJ9i7rlOc+7XSIMPZypmljmzOl66a0U908RErR0KVV5jvyQT3GEV0DEeg2ohJ8djBu7d7YtDX7GobY4NMLmH1zZSbDOWQDXYHH4JWKuYtu6IbYF2TL7pU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772788374;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UhaLQnxw6IYxJZMyMwnG0zOmGc8AkVob2k0lQF7GI3w=;
	b=fUecrIVhMi8FWdtsnANomBJjdkYvQlXciigGoOgtgujA8tB0pmjzp/UzLIiXoI+4
	Yfpv8LWjdNRY71KVfo3JdkLvGCvhl7SrnYnwcpm7kzRNzhkqVwI7NDL57GMilil1x/G
	v7OrUMq14bsW3kuSj+Vl7Yc4aBAuuWLZ62GPEwqE=
Received: by mx.zohomail.com with SMTPS id 1772788372569154.52324977364003;
	Fri, 6 Mar 2026 01:12:52 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Jan Kara <jack@suse.com>,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v4 4/4] jbd2: store jinode dirty range in PAGE_SIZE units
Date: Fri,  6 Mar 2026 16:56:42 +0800
Message-ID: <20260306085643.465275-5-me@linux.beauty>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306085643.465275-1-me@linux.beauty>
References: <20260306085643.465275-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: C4F5321DAEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14681-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.beauty:dkim,linux.beauty:email,linux.beauty:mid,suse.cz:email]
X-Rspamd-Action: no action

jbd2_inode fields are updated under journal->j_list_lock, but some paths
read them without holding the lock (e.g. fast commit helpers and ordered
truncate helpers).

READ_ONCE() alone is not sufficient for the dirty range fields when they
are stored as loff_t because 32-bit platforms can observe torn loads.
Store the dirty range in PAGE_SIZE units as pgoff_t instead.

Represent the dirty range end as an exclusive end page. This avoids a
special sentinel value and keeps MAX_LFS_FILESIZE on 32-bit representable.

Publish a new dirty range by updating end_page before start_page, and
treat start_page >= end_page as empty in the accessor for robustness.

Use READ_ONCE() on the read side and WRITE_ONCE() on the write side for the
dirty range and i_flags to match the existing lockless access pattern.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v3:
- Store i_dirty_end_page as an exclusive end page and drop the sentinel.
- Publish end_page before start_page and treat start_page >= end_page as
  empty in the accessor.
- Document the empty-range encoding and publication ordering in comments.

Changes since v2:
- Rename i_dirty_start/end to i_dirty_start_page/end_page.
- Use jbd2_jinode_get_dirty_range() for byte conversions in commit paths.

 fs/jbd2/commit.c      | 55 +++++++++++++++++++++++++++++++++----------
 fs/jbd2/journal.c     |  5 ++--
 fs/jbd2/transaction.c | 21 +++++++++++------
 include/linux/jbd2.h  | 34 ++++++++++++++++----------
 4 files changed, 80 insertions(+), 35 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 7203d2d2624d7..8cf61e7185c44 100644
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
@@ -191,12 +197,30 @@ EXPORT_SYMBOL(jbd2_submit_inode_data);
 
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
 {
-	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
-		!jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
+	struct address_space *mapping;
+	struct inode *inode;
+	unsigned long flags;
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
+	if (!mapping)
+		return 0;
+
+	if (!jbd2_jinode_get_dirty_range(jinode, &start_byte, &end_byte))
 		return 0;
 	return filemap_fdatawait_range_keep_errors(
-		jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
-		jinode->i_dirty_end);
+		mapping, start_byte, end_byte);
 }
 EXPORT_SYMBOL(jbd2_wait_inode_data);
 
@@ -218,7 +242,8 @@ static int journal_submit_data_buffers(journal_t *journal,
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
 		if (!(jinode->i_flags & JI_WRITE_DATA))
 			continue;
-		jinode->i_flags |= JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags,
+			   jinode->i_flags | JI_COMMIT_RUNNING);
 		spin_unlock(&journal->j_list_lock);
 		/* submit the inode data buffers. */
 		trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
@@ -229,7 +254,8 @@ static int journal_submit_data_buffers(journal_t *journal,
 		}
 		spin_lock(&journal->j_list_lock);
 		J_ASSERT(jinode->i_transaction == commit_transaction);
-		jinode->i_flags &= ~JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags,
+			   jinode->i_flags & ~JI_COMMIT_RUNNING);
 		smp_mb();
 		wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
 	}
@@ -240,10 +266,13 @@ static int journal_submit_data_buffers(journal_t *journal,
 int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	loff_t start_byte, end_byte;
+
+	if (!jbd2_jinode_get_dirty_range(jinode, &start_byte, &end_byte))
+		return 0;
 
 	return filemap_fdatawait_range_keep_errors(mapping,
-						   jinode->i_dirty_start,
-						   jinode->i_dirty_end);
+						   start_byte, end_byte);
 }
 
 /*
@@ -262,7 +291,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 	list_for_each_entry(jinode, &commit_transaction->t_inode_list, i_list) {
 		if (!(jinode->i_flags & JI_WAIT_DATA))
 			continue;
-		jinode->i_flags |= JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags, jinode->i_flags | JI_COMMIT_RUNNING);
 		spin_unlock(&journal->j_list_lock);
 		/* wait for the inode data buffers writeout. */
 		if (journal->j_finish_inode_data_buffers) {
@@ -272,7 +301,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 		}
 		cond_resched();
 		spin_lock(&journal->j_list_lock);
-		jinode->i_flags &= ~JI_COMMIT_RUNNING;
+		WRITE_ONCE(jinode->i_flags, jinode->i_flags & ~JI_COMMIT_RUNNING);
 		smp_mb();
 		wake_up_bit(&jinode->i_flags, __JI_COMMIT_RUNNING);
 	}
@@ -288,8 +317,8 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 				&jinode->i_transaction->t_inode_list);
 		} else {
 			jinode->i_transaction = NULL;
-			jinode->i_dirty_start = 0;
-			jinode->i_dirty_end = 0;
+			WRITE_ONCE(jinode->i_dirty_start_page, 0);
+			WRITE_ONCE(jinode->i_dirty_end_page, 0);
 		}
 	}
 	spin_unlock(&journal->j_list_lock);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c973162d5b316..0bf09aa900277 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -3020,8 +3020,8 @@ void jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode)
 	jinode->i_next_transaction = NULL;
 	jinode->i_vfs_inode = inode;
 	jinode->i_flags = 0;
-	jinode->i_dirty_start = 0;
-	jinode->i_dirty_end = 0;
+	jinode->i_dirty_start_page = 0;
+	jinode->i_dirty_end_page = 0;
 	INIT_LIST_HEAD(&jinode->i_list);
 }
 
@@ -3178,4 +3178,3 @@ MODULE_DESCRIPTION("Generic filesystem journal-writing module");
 MODULE_LICENSE("GPL");
 module_init(journal_init);
 module_exit(journal_exit);
-
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index dca4b5d8aaaa3..17709ecdd22c0 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2646,6 +2646,7 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
+	pgoff_t start_page, end_page;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -2654,15 +2655,21 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 	jbd2_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
 			transaction->t_tid);
 
+	start_page = (pgoff_t)(start_byte >> PAGE_SHIFT);
+	end_page = (pgoff_t)(end_byte >> PAGE_SHIFT) + 1;
+
 	spin_lock(&journal->j_list_lock);
-	jinode->i_flags |= flags;
+	WRITE_ONCE(jinode->i_flags, jinode->i_flags | flags);
 
-	if (jinode->i_dirty_end) {
-		jinode->i_dirty_start = min(jinode->i_dirty_start, start_byte);
-		jinode->i_dirty_end = max(jinode->i_dirty_end, end_byte);
+	if (jinode->i_dirty_start_page != jinode->i_dirty_end_page) {
+		WRITE_ONCE(jinode->i_dirty_start_page,
+			   min(jinode->i_dirty_start_page, start_page));
+		WRITE_ONCE(jinode->i_dirty_end_page,
+			   max(jinode->i_dirty_end_page, end_page));
 	} else {
-		jinode->i_dirty_start = start_byte;
-		jinode->i_dirty_end = end_byte;
+		/* Publish a new non-empty range by making end visible first. */
+		WRITE_ONCE(jinode->i_dirty_end_page, end_page);
+		WRITE_ONCE(jinode->i_dirty_start_page, start_page);
 	}
 
 	/* Is inode already attached where we need it? */
@@ -2739,7 +2746,7 @@ int jbd2_journal_begin_ordered_truncate(journal_t *journal,
 	int ret = 0;
 
 	/* This is a quick check to avoid locking if not necessary */
-	if (!jinode->i_transaction)
+	if (!READ_ONCE(jinode->i_transaction))
 		goto out;
 	/* Locks are here just to force reading of recent values, it is
 	 * enough that the transaction was not committing before we started
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 64392baf5f4b4..7e785aa6d35d6 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -429,33 +429,43 @@ struct jbd2_inode {
 	unsigned long i_flags;
 
 	/**
-	 * @i_dirty_start:
+	 * @i_dirty_start_page:
+	 *
+	 * Dirty range start in PAGE_SIZE units.
+	 *
+	 * The dirty range is empty if @i_dirty_start_page is greater than or
+	 * equal to @i_dirty_end_page.
 	 *
-	 * Offset in bytes where the dirty range for this inode starts.
 	 * [j_list_lock]
 	 */
-	loff_t i_dirty_start;
+	pgoff_t i_dirty_start_page;
 
 	/**
-	 * @i_dirty_end:
+	 * @i_dirty_end_page:
+	 *
+	 * Dirty range end in PAGE_SIZE units (exclusive).
 	 *
-	 * Inclusive offset in bytes where the dirty range for this inode
-	 * ends. [j_list_lock]
+	 * [j_list_lock]
 	 */
-	loff_t i_dirty_end;
+	pgoff_t i_dirty_end_page;
 };
 
+/*
+ * Lockless readers treat start_page >= end_page as an empty range.
+ * Writers publish a new non-empty range by storing i_dirty_end_page before
+ * i_dirty_start_page.
+ */
 static inline bool jbd2_jinode_get_dirty_range(const struct jbd2_inode *jinode,
 					       loff_t *start, loff_t *end)
 {
-	loff_t start_byte = jinode->i_dirty_start;
-	loff_t end_byte = jinode->i_dirty_end;
+	pgoff_t start_page = READ_ONCE(jinode->i_dirty_start_page);
+	pgoff_t end_page = READ_ONCE(jinode->i_dirty_end_page);
 
-	if (!end_byte)
+	if (start_page >= end_page)
 		return false;
 
-	*start = start_byte;
-	*end = end_byte;
+	*start = (loff_t)start_page << PAGE_SHIFT;
+	*end = ((loff_t)end_page << PAGE_SHIFT) - 1;
 	return true;
 }
 
-- 
2.53.0

