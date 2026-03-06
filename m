Return-Path: <linux-ext4+bounces-14679-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAVWNYCZqmkxUQEAu9opvQ
	(envelope-from <linux-ext4+bounces-14679-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:08:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C721D9F7
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 10:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E80D30200D9
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50433B6F1;
	Fri,  6 Mar 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="aUKXf+Xx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB8342CBA;
	Fri,  6 Mar 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772788046; cv=pass; b=hA4nVzJpm6BaTLIfdijXiJyxiIGSZ/SjBC4WY9WYbZr1BSX0F+OinJ6p2w1xACesHqupZ1EkwlwOjRn+V0EzGqSnffBiuUZYEcZtq/OXYxNxEmaW3Fii8vPZ4BcEBN/0577hW3EwRVt3ePdRNDbCEQ8rhXEz67HIMmuRkY4dj1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772788046; c=relaxed/simple;
	bh=f9jxggpwBAEmah9F+c2UFiKDNg65LJVRMaIsD/Aw1Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Won1TSRJu/wEjXIqOfjOVIKYJ4KU2jyLAuD+quvYIdhWuBbD2h/gF6fBPy9FWYIjnBtNuIiK+MlPgmw4oBsIsp7w5iafCfCwNwlHZlkMWhjyI/zU8ZrW6ZKBR7zb177A4PbfR0SbvQ8Tk/urJIktuRl7Vap9QQtuIUIK69Q/Pq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=aUKXf+Xx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1772788034; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LjBNXEJaavu4lc/YXg4M3LzwIlwYXVnm7I6Qs8Ho8U6qaUfRBY1zUuIS0uaxWvfm0tXzRz6jUn0ZgbmDim7ajiXSar2dNZsbtcd6iHaTE6+qFDhiXtuqFhWPay/r7pyinwG/NhlYa7+rzoZDeq0LKa83D/ZJpWONV/FzOjD/JL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772788034; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hDeA288ntLPiXzKkk06WV0KTqSx6XHe/qQriCyB0UmM=; 
	b=WIzZgBYiYFJVaFYpPhqCVFtXu2TrYmxxD70GHi5LVSF5kBgKHDXnV5/2oJ+WcPbPc+XDRblvHmgc1L/trQlbzMs7UqjQ1iWjzCypTyD6eppFLY2eQZqJT0VZ6j39ywVy0Y41k3TG2l/JY/VhuWFcckyC/ir/JNlTjw4/K1qtrMM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772788034;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hDeA288ntLPiXzKkk06WV0KTqSx6XHe/qQriCyB0UmM=;
	b=aUKXf+XxseMzL3pxHOyYpi4o0TFaqzYwX2pYnq78s3EzX210Bibtl82LqDJ6Yjpj
	3IWzhPERRrk8hS8rm2USZtyeXci4bAw1yJwqdyMoJjJUIAExGg5jDxyVZtb1FhUMKJT
	b5KsVC37v9fgxIhfsyLD27O+lzq0722eRfOQIOm8=
Received: by mx.zohomail.com with SMTPS id 1772788032644582.3927587557158;
	Fri, 6 Mar 2026 01:07:12 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v4 2/4] ext4: use jbd2 jinode dirty range accessor
Date: Fri,  6 Mar 2026 16:56:40 +0800
Message-ID: <20260306085643.465275-3-me@linux.beauty>
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
X-Rspamd-Queue-Id: DA6C721D9F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.beauty,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14679-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.beauty:dkim,linux.beauty:email,linux.beauty:mid]
X-Rspamd-Action: no action

ext4 journal commit callbacks access jbd2_inode dirty range fields without
holding journal->j_list_lock.
Use jbd2_jinode_get_dirty_range() to get the range in bytes, and read
i_transaction with READ_ONCE() in the redirty check.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v3:
- No changes.

Changes since v2:
- Use jbd2_jinode_get_dirty_range() instead of direct i_dirty_* reads.
- Drop per-caller page->byte conversion (now handled by the accessor).

Changes since v1:
- Convert the jinode dirty range from PAGE_SIZE units (pgoff_t) back to byte
  offsets before passing it to writeback.

 fs/ext4/inode.c | 10 ++++++++--
 fs/ext4/super.c | 16 +++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index da96db5f23450..f87d35bda9276 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3031,17 +3031,23 @@ static int ext4_writepages(struct address_space *mapping,
 
 int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
+	loff_t range_start, range_end;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
 	};
 	struct mpage_da_data mpd = {
 		.inode = jinode->i_vfs_inode,
 		.wbc = &wbc,
 		.can_map = 0,
 	};
+
+	if (!jbd2_jinode_get_dirty_range(jinode, &range_start, &range_end))
+		return 0;
+
+	wbc.range_start = range_start;
+	wbc.range_end = range_end;
+
 	return ext4_do_writepages(&mpd);
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 69eb63dde9839..685951cd58394 100644
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
@@ -550,15 +551,20 @@ static bool ext4_journalled_writepage_needs_redirty(struct jbd2_inode *jinode,
 static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	loff_t range_start, range_end;
 	struct writeback_control wbc = {
-		.sync_mode =  WB_SYNC_ALL,
+		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
-        };
+	};
 	struct folio *folio = NULL;
 	int error;
 
+	if (!jbd2_jinode_get_dirty_range(jinode, &range_start, &range_end))
+		return 0;
+
+	wbc.range_start = range_start;
+	wbc.range_end = range_end;
+
 	/*
 	 * writeback_iter() already checks for dirty pages and calls
 	 * folio_clear_dirty_for_io(), which we want to write protect the
-- 
2.53.0

