Return-Path: <linux-ext4+bounces-13434-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMqVGcIjfGnZKgIAu9opvQ
	(envelope-from <linux-ext4+bounces-13434-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 04:21:38 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141AB6CD0
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 04:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6156302C913
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 03:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C634AB19;
	Fri, 30 Jan 2026 03:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="BqtTZLPG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF4335564;
	Fri, 30 Jan 2026 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742800; cv=pass; b=Vh8TgrgeVKU7IRMmVRlwg+HH0gAhbXXfksqblShC08RFeLqUqf58c1gzVoeI9EyEMlhMI5zkKREwIRqqb30kSWrfEEALVhXbhKaKWGrfEfN/hX44keOBkPxsMIrJeOfHQ9Y4+K70ApovIz6o8GkI34c1KerO8YN4VjAUml7xHlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742800; c=relaxed/simple;
	bh=Ih/Yu+mlwJPfIPjUeTHwNZR8KkUMEJ4helas/CIo8IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MY+g5R+1CHP2GXqHfxxVmEP5GQO22GYPclarn0w2c0aSB5LKhHeyG/9/AWEh024MTHMT1BlX8kJ+sVdLNGaBb/geOyflsd0LRwg1tVZUPdsMdgBsjnDptjTlq5nVFzNg1REr5aFOMT4W8nMEQuAPwyMM6DjGwBP6RSfwX6UyGPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=BqtTZLPG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1769742778; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nv9ZtKaTMdQmEPld7A9ErB8HHEuiTYR5t7viN9zbFwNuXEXXpqp5ZOEaeSpau37WiN1oK70/2d34mT7pB8U4sS3Dtut+UiAi+Q7ld111HP+QacEgmt/3n+SKNRVU+RmWpJrpOGrzIFUQrJIvF63N4KsNgMKtUxiCFuP6Vr57X9g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769742778; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=flqovzkqjGriKlWs8tgUbIAnm7IIBuluTOQuNQzOASc=; 
	b=HPCoxWPB+TsgyIVmKsbFzUfjcUiH+Kn43z8YGG7OHLswiztiC97GN3L+zSI+EggvalBiRLsyKszWaleNStEfwETEI/3tVv9YRrqWQUxVw0/Br1zX0m10iI1PUsb5UkAPqfhslxkL6rsGSIg+2lr6O3Pui7IEfaCLXwmKRX17as8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769742778;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=flqovzkqjGriKlWs8tgUbIAnm7IIBuluTOQuNQzOASc=;
	b=BqtTZLPGaO5claLf1CBC1TambgYd8F3h8P56GlMmGLJcq6b5imWkesdGx0jGaDJb
	B44F0NSTlmS3mUgA7+nufY5xhfo1i9uKeG1pjCCksNr53TY6Et/ol2o+6uOuFr4T4zt
	xcw/CHiJO5o5mFlRgcIFy5RbUrmuEasOTjwinXQw=
Received: by mx.zohomail.com with SMTPS id 1769742772159561.7457286538283;
	Thu, 29 Jan 2026 19:12:52 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH 1/3] jbd2: use READ_ONCE for lockless jinode reads
Date: Fri, 30 Jan 2026 11:12:30 +0800
Message-ID: <20260130031232.60780-2-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130031232.60780-1-me@linux.beauty>
References: <20260130031232.60780-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[linux.beauty:email,linux.beauty:dkim,linux.beauty:mid];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[linux.beauty:s=zmail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13434-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux.beauty];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[linux.beauty:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.224];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,linux.beauty:dkim,linux.beauty:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 1141AB6CD0
X-Rspamd-Action: add header
X-Spam: Yes

jbd2_inode fields are updated under journal->j_list_lock, but some
paths read them without holding the lock (e.g. fast commit
helpers and the ordered truncate fast path).

Use READ_ONCE() for these lockless reads to correct the
concurrency assumptions.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/jbd2/commit.c      | 39 ++++++++++++++++++++++++++++++++-------
 fs/jbd2/transaction.c |  2 +-
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 7203d2d2624d..3347d75da2f8 100644
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
+	loff_t start, end;
+
+	if (!jinode)
+		return 0;
+
+	flags = READ_ONCE(jinode->i_flags);
+	if (!(flags & JI_WAIT_DATA))
+		return 0;
+
+	inode = READ_ONCE(jinode->i_vfs_inode);
+	if (!inode)
+		return 0;
+
+	mapping = inode->i_mapping;
+	start = READ_ONCE(jinode->i_dirty_start);
+	end = READ_ONCE(jinode->i_dirty_end);
+
+	if (!mapping)
 		return 0;
 	return filemap_fdatawait_range_keep_errors(
-		jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
-		jinode->i_dirty_end);
+		mapping, start, end);
 }
 EXPORT_SYMBOL(jbd2_wait_inode_data);
 
@@ -240,10 +264,11 @@ static int journal_submit_data_buffers(journal_t *journal,
 int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	loff_t start = READ_ONCE(jinode->i_dirty_start);
+	loff_t end = READ_ONCE(jinode->i_dirty_end);
 
 	return filemap_fdatawait_range_keep_errors(mapping,
-						   jinode->i_dirty_start,
-						   jinode->i_dirty_end);
+						   start, end);
 }
 
 /*
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index dca4b5d8aaaa..302b2090eea7 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2739,7 +2739,7 @@ int jbd2_journal_begin_ordered_truncate(journal_t *journal,
 	int ret = 0;
 
 	/* This is a quick check to avoid locking if not necessary */
-	if (!jinode->i_transaction)
+	if (!READ_ONCE(jinode->i_transaction))
 		goto out;
 	/* Locks are here just to force reading of recent values, it is
 	 * enough that the transaction was not committing before we started
-- 
2.52.0

