Return-Path: <linux-ext4+bounces-12703-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E398DD08BD9
	for <lists+linux-ext4@lfdr.de>; Fri, 09 Jan 2026 11:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA14330486AE
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jan 2026 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB6339B3C;
	Fri,  9 Jan 2026 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ddq2IjY5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tL2Yq/4n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PzwFZvCf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bAAJygQd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C533985A
	for <linux-ext4@vger.kernel.org>; Fri,  9 Jan 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956047; cv=none; b=T2wfMvT2RtpM/w2eymDloA4zw/FQs0yHqSCmV1OE/Fsy5crNju1XtuJqo9wCeCoYPOB+fZfkFNm/4/ryfmP1wVQVSRREtQIzeD24hOnF/er/t+2GkWk7zBLuXj4tE1LQsuXAv8RyxahrzfcY+XcRX70fhJJTmpwKHO4vaGa60ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956047; c=relaxed/simple;
	bh=1rXtUATUqiMsqCB2ibBgEENASEXWt5A5IbC8rCm24RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chB0HQjHagd4LHggrIy+3V4df08lMJkJWk0w7aUpbAgXUGygJ9oCviIZSsTM1g35ceCtQ0XsOTDs72hx9a1CeqZtiAN6jDNlc9iPGJKkEstxeivEEvMh2ntRKOzprt9670hkAwk0HaA0Nmw9wouSOtePxBgXM+N6rO98Gkh7wDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ddq2IjY5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tL2Yq/4n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PzwFZvCf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bAAJygQd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F183833995;
	Fri,  9 Jan 2026 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767956038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XNpdhXNgZlTR/wWJxB7zNPnPPZh/8oBh/kwNuquHNE=;
	b=Ddq2IjY58TExZkqzifCzmKI+1B1p4x+QmTBVyxaY8PWAQbU61sWOvOxp+AymUlUMhjBgeZ
	CQoy2ST0DebhkGOAjI+9ZCTbsd/EPrcqZvKpbVco4XZz4Lhep3B8YtP+ZJ3q/fwikdTRyb
	1D6UKuIqbs4WaqDMA720seoBT65Jvh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767956038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XNpdhXNgZlTR/wWJxB7zNPnPPZh/8oBh/kwNuquHNE=;
	b=tL2Yq/4nwMnJmudeWCchw+tD8HW1HqgsxgP8d7Vq/Pl6+Wu19Xj0M1FzunaK90OLC2DvNP
	+N/oH5ank8+OD3DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767956037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XNpdhXNgZlTR/wWJxB7zNPnPPZh/8oBh/kwNuquHNE=;
	b=PzwFZvCfYOwI2BemT1PrMEipFILwBR2HcGjEN+m8z/MOGdl4mj9GZr0ZRZGySn1Qd1tG+x
	f6NWimm8LLDPdZmF2mvBYgosOvgjHz16CEvAYQNypI6cOErwVq0UY37IWGKPW9pnOdsxuN
	JIC1sPcsFr6ZFfpqBezYsZuMfKT/S2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767956037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XNpdhXNgZlTR/wWJxB7zNPnPPZh/8oBh/kwNuquHNE=;
	b=bAAJygQdffuFWJL6kD8gnkK6AKE9xDrt3gkio1E73ueEUTe2hBdiz6gl7YsboGvVeESTON
	nNQgy8zG0qQsQLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E42223EA66;
	Fri,  9 Jan 2026 10:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KYlJN0XeYGlIVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Jan 2026 10:53:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9834AA08E3; Fri,  9 Jan 2026 11:53:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: always allocate blocks only from groups inode can use
Date: Fri,  9 Jan 2026 11:53:37 +0100
Message-ID: <20260109105354.16008-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109105007.27673-1-jack@suse.cz>
References: <20260109105007.27673-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553; i=jack@suse.cz; h=from:subject; bh=1rXtUATUqiMsqCB2ibBgEENASEXWt5A5IbC8rCm24RQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpYN5Csc57WXIKc3JX/linpwcPRJlU6BnYJt+Ci raGCSTLnk+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaWDeQgAKCRCcnaoHP2RA 2bl7CACcc3H6QY2L/I9u8UKT6ndpo1pcj1Kj0Gshra//xdDK44ZhE/sSAEBUsVdfqdJZPnVpi0r UxSQLTx0qGnzGItk0BytJmz7njcpMKU/HVZaeT/QP8Zd2sQyVkoF12vrGGzPC2t1SLUuDWBOK3N kUBx36O5nsS/+siC6TxSGTtEpHFfH3uWWyNJVw8ZjAuFRbCAz97dJi/AKiyXvcD9aywn4oPfAH0 zv80xOf8y7R0JT1vK0NrWmWmQ7HEZPqD12wDTRSvkd7oiLZKEAtVxs2E0DiEkoAnsFvtTAFTBxu PLF8uz7P3ncLz7Qa3Zt20q89B+s95q7mZ/fwUFmcheDFOBr+
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

For filesystems with more than 2^32 blocks inodes using indirect block
based format cannot use blocks beyond the 32-bit limit.
ext4_mb_scan_groups_linear() takes care to not select these unsupported
groups for such inodes however other functions selecting groups for
allocation don't. So far this is harmless because the other selection
functions are used only with mb_optimize_scan and this is currently
disabled for inodes with indirect blocks however in the following patch
we want to enable mb_optimize_scan regardless of inode format.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 56d50fd3310b..f0e07bf11a93 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -892,6 +892,18 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	}
 }
 
+static ext4_group_t ext4_get_allocation_groups_count(
+				struct ext4_allocation_context *ac)
+{
+	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
+
+	/* non-extent files are limited to low blocks/groups */
+	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
+		ngroups = EXT4_SB(ac->ac_sb)->s_blockfile_groups;
+
+	return ngroups;
+}
+
 static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
 					struct xarray *xa,
 					ext4_group_t start, ext4_group_t end)
@@ -899,7 +911,7 @@ static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
 	struct super_block *sb = ac->ac_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	enum criteria cr = ac->ac_criteria;
-	ext4_group_t ngroups = ext4_get_groups_count(sb);
+	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
 	unsigned long group = start;
 	struct ext4_group_info *grp;
 
@@ -951,7 +963,7 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
 	ext4_group_t start, end;
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
 		ret = ext4_mb_scan_groups_largest_free_order_range(ac, i,
@@ -1001,7 +1013,7 @@ static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
 	ext4_group_t start, end;
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
@@ -1083,7 +1095,7 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 		min_order = fls(ac->ac_o_ex.fe_len);
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
@@ -1182,11 +1194,7 @@ static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
 	int ret = 0;
 	ext4_group_t start;
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
-	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
-
-	/* non-extent files are limited to low blocks/groups */
-	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
-		ngroups = sbi->s_blockfile_groups;
+	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
 
 	/* searching for the right group start from the goal value specified */
 	start = ac->ac_g_ex.fe_group;
-- 
2.51.0


