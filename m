Return-Path: <linux-ext4+bounces-13746-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPEaD5/4lmn4swIAu9opvQ
	(envelope-from <linux-ext4+bounces-13746-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 12:48:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7815E69A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FE42300D0E0
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Feb 2026 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219D30B52C;
	Thu, 19 Feb 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="uHjDFTJC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0C2EFD86;
	Thu, 19 Feb 2026 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501724; cv=pass; b=Q+Noz7E4w/JxaIN2btNhfiL2Iqt9mPMfNM56LfqjfT73QU5aRyWs2kwnJLZb5e/MQWkawpXL5Nh1FBqcaGPwWYbaMGwdEgyIvaGHVAfsOMqO9+WEogpuqSzGWfdGSWAnWxGt+UX7Zbz+I0Jjkny/g+cD4T+eZvUA00fPDFYoAw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501724; c=relaxed/simple;
	bh=7uauTrROlWykBC94taT0BGToFqvysHQ/njaCYo9qwM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sntOvZKOnzdDUgFaiBpp/R9JG+hzVPpNK18nXTmyXZgIdcDB5AfdtHNgajbzDuKv6RtJvegz6vit0wT0mRK25Ys2MrVBYiAUf08QlP5hlJgX+t3kkHB6pvBXzZlziWUWFDb0E9jI0vwyZXj3oZBOEt+hNwxctmSwWq7GpOikTNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=uHjDFTJC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771501635; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gFmDLIurtCV9KCk1gesLCuIsfht03Sw5CnA1yZ8FRF7/uTK5V8FfgE/IarrGSowqoCDFFKFum7Rn3GwWsH1IWlI5Rgi2RE7MDa08Lm9BGeLpSDed9UBwD6xQP4ik+GhcJNK0TGJ6YOMUK2je91RwPs4a/ilnAHq36dIZee8UQpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771501635; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jHr6qDvYQBYJ6pu78kQ622LP38rOaq+qs2VRyLTnZ1Q=; 
	b=BFhpBeBvBQgy1uhUWIkEutQVn5cADLyHcs+YSafSKYC0JXd9hJzItpCfr1LYCdA3TeKxBlOi4/Vb8K3qOg5s8FgVFIRDu6brIAP2aspfdQPXzuoSrxUmjLGl7CmzYJklUxJz3XOWHtMk2jtnv1u8AQCGYHeIh/Hhgt8GNRdTCog=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771501635;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jHr6qDvYQBYJ6pu78kQ622LP38rOaq+qs2VRyLTnZ1Q=;
	b=uHjDFTJCD4QJ8SLZNMU1nUwd7V9rE4qSi7/EsyBl7rZ3O8lWs9d6KI781BPGBiYE
	FkbxsELUgy9DZY2i1ny2m3AjpWLgaJikES4f6MvqzF6sIhRVbZIkfy148Cr+PMdmxo/
	iKw7+TIGwkfVdqC/gmsEl/fxbideshZ9VkiJkr2I=
Received: by mx.zohomail.com with SMTPS id 1771501631889417.86051371374174;
	Thu, 19 Feb 2026 03:47:11 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v2 3/3] ocfs2: use READ_ONCE for lockless jinode reads
Date: Thu, 19 Feb 2026 19:46:44 +0800
Message-ID: <20260219114645.778338-4-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13746-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: D9A7815E69A
X-Rspamd-Action: no action

ocfs2 journal commit callback reads jbd2_inode dirty range fields without
holding journal->j_list_lock.

Use READ_ONCE() for these reads to match the lockless access pattern.
Convert the dirty range from PAGE_SIZE units back to byte offsets before
passing it to writeback.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v1:
- Convert the jinode dirty range from PAGE_SIZE units (pgoff_t) back to byte
  offsets before passing it to writeback.

 fs/ocfs2/journal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 85239807dec7..0b40383ebcdf 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -902,8 +902,17 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
 
 static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
-	return filemap_fdatawrite_range(jinode->i_vfs_inode->i_mapping,
-			jinode->i_dirty_start, jinode->i_dirty_end);
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	pgoff_t dirty_start = READ_ONCE(jinode->i_dirty_start);
+	pgoff_t dirty_end = READ_ONCE(jinode->i_dirty_end);
+	loff_t start_byte, end_byte;
+
+	if (dirty_end == JBD2_INODE_DIRTY_RANGE_NONE)
+		return 0;
+	start_byte = (loff_t)dirty_start << PAGE_SHIFT;
+	end_byte = ((loff_t)dirty_end << PAGE_SHIFT) + PAGE_SIZE - 1;
+
+	return filemap_fdatawrite_range(mapping, start_byte, end_byte);
 }
 
 int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
-- 
2.52.0

