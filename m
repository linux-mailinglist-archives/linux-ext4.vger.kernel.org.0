Return-Path: <linux-ext4+bounces-13974-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOjrB21vnWk9QAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13974-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:29:17 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C09618499F
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 231D33064508
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A66636AB60;
	Tue, 24 Feb 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="lZXyTNJ6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23B36A025;
	Tue, 24 Feb 2026 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925142; cv=pass; b=TAeJMcagbkl6ncSDzAJYURYC0RYXW9eXNC0LE5TkUXjCIXO3ZS6UNl4NAJm6qUqwgs71XZ671Ry3IFBAlL/D+dCj6QyHHj8PsBGpiwZiCV6WTDzgCY0PP9E1P65A33LyY00yNlQdPbMeAUkBfOzmHbLpuDK/XPznUlsN0CUGHUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925142; c=relaxed/simple;
	bh=CQW0igxcf9n9v2dCJkH8vis1p2lZETpilQkNiluJmik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHj6jnwRw/ztTD1No+a6ztfIKbQkQToeywwEhbglrZjkhY9+BF4aS2dfDW1DoFKgQAaSc+BBXRz02ZiyJnQRklS9uQFtn3TPt/FO9Ump7TDpNLBnsx7vbZetwRjCLisf5x8hI2VrFEng5UEaLxZGnqbqDspAtJGB0lDok1FriTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=lZXyTNJ6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771925097; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FlQZGYJAuLJvDKHlAfa3WADLm9r3gZPTWMgsQV9KefSbOvEPx/5ZhTVe+dZnm9XM0jZT/UtH6BSsKWuSsGIubwoCjc0cXlzraEJaWZ3sme6q+rClZdkdNuHzPUWVywCGAA21hgJYY5ZKUXFYAKaAzaLCkTwIOw+DXk9hTg9ZwjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771925097; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qR07NRDiS2TOSpshOs9qkZFMh9a2Nuyr9nJUWIMzm8Y=; 
	b=acL4ZMQD7CuL22qeXEKdUW6aFu0Km6A577jGU3N6DlNCZkUiGHZIf4ObkZqIaz6K75ffLAiJ/trOB/UmEtEbP11+zg6ZhqvAEEfv+ppDzhAMWwyZuaWSrsMorvux8ZUSik3gyezLeqeljW59ZiFx/xiIAh4IHcuBJN0/twyuMns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771925097;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qR07NRDiS2TOSpshOs9qkZFMh9a2Nuyr9nJUWIMzm8Y=;
	b=lZXyTNJ6ewhXorM82zbKOtgpOv3BlBBoM07Ih6AsjSyyE3u6QWPXiy/TSdV8ffaK
	/A9Z/332Al1ScRU4ckdiGMDbbkHrjQ7YTl7nGSIM3HIJ5rHaZYpZKznlwGBA0T8RFLL
	LnLjBAHVqkgz8PN6+XqXn5Ugn8RPInRwtH4SjJAE=
Received: by mx.zohomail.com with SMTPS id 1771925096510453.38075459274626;
	Tue, 24 Feb 2026 01:24:56 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v3 2/4] ext4: use jbd2 jinode dirty range accessor
Date: Tue, 24 Feb 2026 17:24:31 +0800
Message-ID: <20260224092434.202122-3-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224092434.202122-1-me@linux.beauty>
References: <20260224092434.202122-1-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13974-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:mid,linux.beauty:dkim,linux.beauty:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 4C09618499F
X-Rspamd-Action: no action

ext4 journal commit callbacks access jbd2_inode dirty range fields without
holding journal->j_list_lock.
Use jbd2_jinode_get_dirty_range() to get the range in bytes, and read
i_transaction with READ_ONCE() in the redirty check.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v2:
- Use jbd2_jinode_get_dirty_range() instead of direct i_dirty_* reads.
- Drop per-caller page->byte conversion (now handled by the accessor).

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
2.52.0

