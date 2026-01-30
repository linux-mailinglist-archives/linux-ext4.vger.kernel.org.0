Return-Path: <linux-ext4+bounces-13435-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MAGGb8jfGnJKgIAu9opvQ
	(envelope-from <linux-ext4+bounces-13435-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 04:21:35 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF057B6CB0
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 04:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10E98303C2BA
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jan 2026 03:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE06B34AAE4;
	Fri, 30 Jan 2026 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="RC0Gvuh4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FD2FDC5C;
	Fri, 30 Jan 2026 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742806; cv=pass; b=sEMoPeX+Dg6scb7X6MJjmNRmh7ZGldj7/GQ1sTHfGcmIX1toHpf4ohZjEwx9MRLQpCqr9gP1B6iSnfvp+HDu7XwzF5c6pq/UM+DeIWLPQp0FWifU1F0/bre2p9cv6+Bd6dmyCqnAMpVSlkpAQPZDnXQ0MloP9aUDBNx3niWU4ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742806; c=relaxed/simple;
	bh=j/7YFkVlx9cqucXzcCMuVijXkSl7DCvIHMyg6bKq/Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NExq14ZRfsYyL1YuQonHlEKu+J6yDVwFg+w3emWEGqEOZik36PkxSdU5wHnjd4S4mQ0PWjm7k0zvEl/+zIXAhj45UaDZPW/OivPLvBvVw6uCwZrlrJGQT1Qc9o5+eHu567P8f4SKMbQv3Ck072Yhyf9cMCMBRkBOxxc0czv5Y/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=RC0Gvuh4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1769742780; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Uy540XI0jTOgxnBzThN7hEL1F8VkpkpGY4ZMGEwvTGxBDKL9DoFG66nM/1ltiSjfjXE06Vho58d0MjqDiwN7GJ18FdgdTMsE8aioBbIiHY9FJiKbiBcHEudO8E+TGN/IG5x3K4GvArT5Pld0hjj9jij75IpaeQml4FBZ0Hd8Cso=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769742780; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=avd/AUZNm7D9+j9YRkdHx4VzxdkkFbvm2wfnuocDPVo=; 
	b=DBQdyvAU+x6sQtJWDPSOIpn36jh2HQGRhObqgLCGbYQZwYa+k+UvF4JQeCeDdOvXBmINr2w/b93/TkbQ0bm/4hHZ9O+GXxazdVA9vYdWVyACnsIMSjjWH0uZxnYzVU2sqNDYgwasfFKEV+rn2mWnS9WMkFfoQc2gRgzJiOCZhjM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769742780;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=avd/AUZNm7D9+j9YRkdHx4VzxdkkFbvm2wfnuocDPVo=;
	b=RC0Gvuh4MNWJZfwXsVBH5PbnA51XJddqMxkpo1mLYHfHRsbOTNmOnoFjkJ65AkIT
	sHsYaaCOe3tF+qlaZgDLq4vVk6x1b9CTD9UWno5GJ3qKNf4tmkuEago/cj8BmSOgFiV
	7Fn2GjQh8BX5yXOlUGJ8CBCI157pQloE3z8qP3Kg=
Received: by mx.zohomail.com with SMTPS id 1769742774598265.0356064896463;
	Thu, 29 Jan 2026 19:12:54 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>,
	Li Chen <me@linux.beauty>
Subject: [PATCH 2/3] ext4: use READ_ONCE for lockless jinode reads
Date: Fri, 30 Jan 2026 11:12:31 +0800
Message-ID: <20260130031232.60780-3-me@linux.beauty>
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
	TAGGED_FROM(0.00)[bounces-13435-lists,linux-ext4=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.270];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:email,linux.beauty:dkim,linux.beauty:mid]
X-Rspamd-Queue-Id: AF057B6CB0
X-Rspamd-Action: add header
X-Spam: Yes

ext4 journal commit callbacks access jbd2_inode fields such as
i_transaction and i_dirty_start/end without holding journal->j_list_lock.

Use READ_ONCE() for these reads to correct the concurrency assumptions.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/inode.c |  6 ++++--
 fs/ext4/super.c | 13 ++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d99296d7315f..2d451388e080 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3033,11 +3033,13 @@ static int ext4_writepages(struct address_space *mapping,
 
 int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
+	loff_t dirty_start = READ_ONCE(jinode->i_dirty_start);
+	loff_t dirty_end = READ_ONCE(jinode->i_dirty_end);
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
+		.range_start = dirty_start,
+		.range_end = dirty_end,
 	};
 	struct mpage_da_data mpd = {
 		.inode = jinode->i_vfs_inode,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5cf6c2b54bbb..acb2bc016fd4 100644
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
@@ -550,12 +551,14 @@ static bool ext4_journalled_writepage_needs_redirty(struct jbd2_inode *jinode,
 static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	loff_t dirty_start = READ_ONCE(jinode->i_dirty_start);
+	loff_t dirty_end = READ_ONCE(jinode->i_dirty_end);
 	struct writeback_control wbc = {
-		.sync_mode =  WB_SYNC_ALL,
+		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
-		.range_start = jinode->i_dirty_start,
-		.range_end = jinode->i_dirty_end,
-        };
+		.range_start = dirty_start,
+		.range_end = dirty_end,
+	};
 	struct folio *folio = NULL;
 	int error;
 
-- 
2.52.0

