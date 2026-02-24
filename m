Return-Path: <linux-ext4+bounces-13975-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB6fALNunWk9QAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13975-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:26:11 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F791848B1
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 10:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD868309623D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2B636B05E;
	Tue, 24 Feb 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="tJOqJMyi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC4369224;
	Tue, 24 Feb 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925162; cv=pass; b=TUuybatyCvei38LJTVslt0ZmWaelkP65v3BUP5dgQ+1mKC2tQLVZrKU04oM47G56XB0n9aEiD3yGq/cShIXRpTny3XbSbcbWnlp2M86QpSaDUqXky+/L0IiiJRm2i8Ck+c/fYlpeIptY3kQ2ua0U052ID5ky2u0CMHEQrFaTXdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925162; c=relaxed/simple;
	bh=6HnR2vQVyFMxEanvtrB7UYHlNmO1A2TCYspJNnFuYxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZhFJBjPYNfMKr5Jb7LwpfI5x7D+M2DsiQFjQ1+Bb8KaAuUP9d7/Dfc5QRZuJOmomb36kChAWeWzeRC2ijdkUkjvAujMlLwHzR7Md6GGQr9+1zde2t2vd+OqGIgmnT1gxEULO5HFRrrFJXFN5nKb91tFNO55ruI8E4EWP/RMF34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=tJOqJMyi; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1771925101; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gYKI749D5gnkusH9m4h5yE5lm+r0gaD9vups5gCzl+D/0udmui2IRtvOEOc/PeeOS2dddYCrxcQAL5cOjpC8U5Tp+XLW0A9ri/20CoPgHj5cROyoYVlnWUh+BK+wmhbtTn4ayin+OBVoZTHfo8Ufam8eAv7DWiKigyrCk26jFIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771925101; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i4ISv/Mq3feuc2xrr0ho5gyou48ed2HrxZS5FR03aSY=; 
	b=Ubp4CqatKC9rnHaHsrLKbacG0G2Mw3/mpIMnBQgaCJLa795/x5Rspmwwg2l3uaofSnGpr2dgNE+IHJiM//p5nFjhPpPi+v4qbZjeclG5a445ENhPXqxi90IPpkI+Q4qbVyGnV12IcaRQDjB6IUUA543s5ARLUIdQcnCfyb+WROE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771925101;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=i4ISv/Mq3feuc2xrr0ho5gyou48ed2HrxZS5FR03aSY=;
	b=tJOqJMyivEmJw9bor3La9WsQh/aRg3xYNTxDjvxMKhFW75uYx6wdI/qYG6ANr6Fv
	Tpsc5ioRiFvaKnaQbv0lxhAaqFNkAKq0VQt+HZX/aFCzO8JOP+opvlK5H6+nihAjewA
	c9dd3k1gG79p3KpeUrXY32YJqKzHfUTC6nNoQk4M=
Received: by mx.zohomail.com with SMTPS id 1771925100358315.28790750738244;
	Tue, 24 Feb 2026 01:25:00 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Mark Fasheh <mark@fasheh.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [PATCH v3 3/4] ocfs2: use jbd2 jinode dirty range accessor
Date: Tue, 24 Feb 2026 17:24:32 +0800
Message-ID: <20260224092434.202122-4-me@linux.beauty>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13975-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[linux.beauty:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email,linux.beauty:mid,linux.beauty:dkim,linux.beauty:email]
X-Rspamd-Queue-Id: 59F791848B1
X-Rspamd-Action: no action

ocfs2 journal commit callback reads jbd2_inode dirty range fields without
holding journal->j_list_lock.
Use jbd2_jinode_get_dirty_range() to get the range in bytes.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Li Chen <me@linux.beauty>
---
Changes since v2:
- Use jbd2_jinode_get_dirty_range() instead of direct i_dirty_* reads.
- Drop per-caller page->byte conversion (now handled by the accessor).

 fs/ocfs2/journal.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 85239807dec78..68c2f567e6e1b 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -902,8 +902,13 @@ int ocfs2_journal_alloc(struct ocfs2_super *osb)
 
 static int ocfs2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
-	return filemap_fdatawrite_range(jinode->i_vfs_inode->i_mapping,
-			jinode->i_dirty_start, jinode->i_dirty_end);
+	struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
+	loff_t range_start, range_end;
+
+	if (!jbd2_jinode_get_dirty_range(jinode, &range_start, &range_end))
+		return 0;
+
+	return filemap_fdatawrite_range(mapping, range_start, range_end);
 }
 
 int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
-- 
2.52.0

