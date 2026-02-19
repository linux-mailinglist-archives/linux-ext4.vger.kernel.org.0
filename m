Return-Path: <linux-ext4+bounces-13745-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMa8Gaj4lmn4swIAu9opvQ
	(envelope-from <linux-ext4+bounces-13745-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 12:48:56 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 079CE15E6A8
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E79B303D2D8
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219C4334C05;
	Thu, 19 Feb 2026 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="eAFAeZ7n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ACA2EFD86;
	Thu, 19 Feb 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501702; cv=pass; b=uG2jDayJyHvaZHykKdAHNrMCfHCn4YpBv6hoJyLTjWEqY6jN9le3qq8BuNrNyp+y6xLgyTHoTbg97tsgCyx16I4wHZJdBQX8xdSWZgKUH/DBz2nTBfiPrwnKY6tb5izCFmkwiomQ3WkqpCJYdX1FTQVFxGXqeZKd5gyxJu5/h4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501702; c=relaxed/simple;
	bh=Ole/adKa/E4g2kQnOjK+SLIVG2KZQBU0gCHp48N2DBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/RKOqKFBoMAHaUkBb1svSHsedUTGhLoW74EoX/TanDi1tr9j7XXs50Bs7gs7OA9m2de6uhv3zHSjZjAQsee4wgcAJKp74lPA8sbil3JEQqq4KGSevHLi27sMVekUdTbx/WtBAsLv+hFtPfHMu6055OY/Tjlw0d29kqEngrLvow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=eAFAeZ7n; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771501631; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BLLjINCRcCrNf9rP94nXr8sycTIoyTwYEn0NWtyoa0fxMWFlddOCcgnB5si2ZTgfhQQSl7it20roIu691iqDwVQQ/GuSbj8uzCDnV+gs6+T8KKYLdVp+/yor4EetvQgvS+0MaIzVBo8aCuy9C5JzpBtURNbtBmYJIB+zj9kI2Rc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771501631; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IQX5SyqcG0wh5Bi5VE3B6d+bUgJTb51NNcjjNAFka70=; 
	b=Vq7kO7NhT5Z1XnDag9UVctdnIIQ6wCaDxQbCqUqpWSfWw4H6wo8+hCXIFaHMj0j9ZX6el8yql3+0yBkSk82j82Cc/UWZCStPhui50HLmKszP6xztPkgsilXaQH0EscCdkal+6r4i4UBkOZDw268AIEI4T/ltasCJf1SFuxnH6IQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771501631;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IQX5SyqcG0wh5Bi5VE3B6d+bUgJTb51NNcjjNAFka70=;
	b=eAFAeZ7n7qruS6FoC6n5Ua4W/5U5cfFQCVEo6vMjnjTjsXGlua06lIkPQFyTPAWM
	Pw92xUJig0NdVI2mZUhBSXd97sijZCR3k3cyfaR2OINFQCXQWhDkKO2EhC+AqBAxf8e
	S4qjUXQM81PepLLG7jP1FI3/QpT6vOqf9b7Q3S9w=
Received: by mx.zohomail.com with SMTPS id 1771501628192513.36154051907;
	Thu, 19 Feb 2026 03:47:08 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v2 2/3] ext4: use READ_ONCE for lockless jinode reads
Date: Thu, 19 Feb 2026 19:46:43 +0800
Message-ID: <20260219114645.778338-3-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13745-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: 079CE15E6A8
X-Rspamd-Action: no action

ext4 journal commit callbacks access jbd2_inode fields such as
i_transaction and i_dirty_start/end without holding journal->j_list_lock.

Use READ_ONCE() for these reads to match the lockless access pattern.
Convert the dirty range from PAGE_SIZE units back to byte offsets before
passing it to writeback.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v1:
- Convert the jinode dirty range from PAGE_SIZE units (pgoff_t) back to byte
  offsets before passing it to writeback.

 fs/ext4/inode.c | 12 ++++++++++--
 fs/ext4/super.c | 19 ++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d99296d7315f..5ec60580a2d0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3033,11 +3033,19 @@ static int ext4_writepages(struct address_space *mapping,
 
 int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
+	pgoff_t dirty_start = READ_ONCE(jinode->i_dirty_start);
+	pgoff_t dirty_end = READ_ONCE(jinode->i_dirty_end);
+	loff_t range_start, range_end;
+
+	if (dirty_end == JBD2_INODE_DIRTY_RANGE_NONE)
+		return 0;
+	range_start = (loff_t)dirty_start << PAGE_SHIFT;
+	range_end = ((loff_t)dirty_end << PAGE_SHIFT) + PAGE_SIZE - 1;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
+		.range_start = range_start,
+		.range_end = range_end,
 	};
 	struct mpage_da_data mpd = {
 		.inode = jinode->i_vfs_inode,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 69eb63dde983..27062c8ad60a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -521,6 +521,7 @@ static bool ext4_journalled_writepage_needs_redirty(struct jbd2_inode *jinode,
 {
 	struct buffer_head *bh, *head;
 	struct journal_head *jh;
+	transaction_t *trans = READ_ONCE(jinode->i_transaction);
 
 	bh = head = folio_buffers(folio);
 	do {
@@ -539,7 +540,7 @@ static bool ext4_journalled_writepage_needs_redirty(struct jbd2_inode *jinode,
 		 */
 		jh = bh2jh(bh);
 		if (buffer_dirty(bh) ||
-		    (jh && (jh->b_transaction != jinode->i_transaction ||
+		    (jh && (jh->b_transaction != trans ||
 			    jh->b_next_transaction)))
 			return true;
 	} while ((bh = bh->b_this_page) != head);
@@ -550,12 +551,20 @@ static bool ext4_journalled_writepage_needs_redirty(struct jbd2_inode *jinode,
 static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	pgoff_t dirty_start = READ_ONCE(jinode->i_dirty_start);
+	pgoff_t dirty_end = READ_ONCE(jinode->i_dirty_end);
+	loff_t range_start, range_end;
+
+	if (dirty_end == JBD2_INODE_DIRTY_RANGE_NONE)
+		return 0;
+	range_start = (loff_t)dirty_start << PAGE_SHIFT;
+	range_end = ((loff_t)dirty_end << PAGE_SHIFT) + PAGE_SIZE - 1;
 	struct writeback_control wbc = {
-		.sync_mode =  WB_SYNC_ALL,
+		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
-        };
+		.range_start = range_start,
+		.range_end = range_end,
+	};
 	struct folio *folio = NULL;
 	int error;
 
-- 
2.52.0

