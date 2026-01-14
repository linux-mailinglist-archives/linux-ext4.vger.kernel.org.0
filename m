Return-Path: <linux-ext4+bounces-12845-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6672AD20DA0
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 19:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E38CD305913E
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9033508B;
	Wed, 14 Jan 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqTQzZyJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfh8TS+s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fqTQzZyJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfh8TS+s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08423285CAD
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415337; cv=none; b=IuO4VhuKohZU/GK0qg9Qugw4dmOUNb0Js5H7SLerUUcPehf/nvK6Zc0X1AzqVmPgpW5CCjXa5b1TniQm6kbNgnR1PHpI3nMTGQEYuJ4ZaGMiESC+fTPgPYEdCgYjys0cy0aW4CX5rSpAjEtuKcoii+i6JPxnh2UX/hsfv+PDwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415337; c=relaxed/simple;
	bh=eXakz/thPLI0PILG+pVwu/A/pNSdQiO2wh0taE+N76U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICZZrUnv1wrhTbP8ldFOTGcYjGTaS2u/exzgi6CbMFFuGXHlMgY4jSZQJ6x4+c7jvjLAzfj/YhQnhGCa5GO0J92cIHLf5uLmkcawqbOFbFBecLRdj3Ja0OrunIRCQO0ErCKKrq+11QTLaUITdxC5cCfu5e0G0E3VbLZc41DFbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqTQzZyJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfh8TS+s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fqTQzZyJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfh8TS+s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C3805D15F;
	Wed, 14 Jan 2026 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768415328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VmwWz8JM9E/NOMZLG9p7pdhytC1cYWAvDxQhUMlBQ4=;
	b=fqTQzZyJBxd9p0beC5VTiow54um0lMF0TifjKfMSbjA3Esm8uPG7rHeR6QlYV6JjgbuEU2
	03xBM0KZtnUEWCLI0H/QnD37TeZcLgX7kL79EqJg/K//MlRX9LVBoyUzWiFexM+IVzNDIb
	7+/QyL0VCw8FYHCseg/bdu5Y7rzQZ5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768415328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VmwWz8JM9E/NOMZLG9p7pdhytC1cYWAvDxQhUMlBQ4=;
	b=yfh8TS+sqSWUnuM382vrAR0yVdDXy8BtgV/j8jPXee0xt4CnD+rTwFlI1hALAJjti0nlmu
	NHoK8uUfARF4oGAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fqTQzZyJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yfh8TS+s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768415328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VmwWz8JM9E/NOMZLG9p7pdhytC1cYWAvDxQhUMlBQ4=;
	b=fqTQzZyJBxd9p0beC5VTiow54um0lMF0TifjKfMSbjA3Esm8uPG7rHeR6QlYV6JjgbuEU2
	03xBM0KZtnUEWCLI0H/QnD37TeZcLgX7kL79EqJg/K//MlRX9LVBoyUzWiFexM+IVzNDIb
	7+/QyL0VCw8FYHCseg/bdu5Y7rzQZ5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768415328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VmwWz8JM9E/NOMZLG9p7pdhytC1cYWAvDxQhUMlBQ4=;
	b=yfh8TS+sqSWUnuM382vrAR0yVdDXy8BtgV/j8jPXee0xt4CnD+rTwFlI1hALAJjti0nlmu
	NHoK8uUfARF4oGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10E5F3EA65;
	Wed, 14 Jan 2026 18:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMwaBGDgZ2k6QAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 14 Jan 2026 18:28:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2591A0C40; Wed, 14 Jan 2026 19:28:43 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH 1/2] ext4: always allocate blocks only from groups inode can use
Date: Wed, 14 Jan 2026 19:28:18 +0100
Message-ID: <20260114182836.14120-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114182333.7287-1-jack@suse.cz>
References: <20260114182333.7287-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3718; i=jack@suse.cz; h=from:subject; bh=eXakz/thPLI0PILG+pVwu/A/pNSdQiO2wh0taE+N76U=; b=kA0DAAgBnJ2qBz9kQNkByyZiAGln4FShQ7iErl486pMG7GGvFSczA4wn01KTQlFcS6G/UV/yy IkBMwQAAQgAHRYhBKtZ0SvWnjKKtVUoHJydqgc/ZEDZBQJpZ+BUAAoJEJydqgc/ZEDZPawH/1Od Kjt61rIMTWpgfFuzlpGdNCkPIZYjIrO+vCPM3QlQXd8oa8xJd3QqzxKwMeAm6VOLPHmnfXqXE8V yYowcTGwxrWU3nDIpAa25CF5fquR+r1rErj6juKOxUEATnQ7RAMI3uOP/HiLmWo4Lsy8X6cDKjP rB1YNohJ2WJQffpkwEAIauQ3ctoKdpCKiNZ7yw9EptZFJk90AdYmwoTxcnXkc6ESoCGBGlcRwM+ eW/uzkeMgTzwTGTWDjx32vkah07k7/WjOQR36SBjvxGOTYkM1G63SAbmJCLyLD2bl9hJDtFuKRk +bdcbZiY7ZmLKe5xIhJbjnLtjtCtXuJu4gM5nDY=
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 1C3805D15F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

For filesystems with more than 2^32 blocks inodes using indirect block
based format cannot use blocks beyond the 32-bit limit.
ext4_mb_scan_groups_linear() takes care to not select these unsupported
groups for such inodes however other functions selecting groups for
allocation don't. So far this is harmless because the other selection
functions are used only with mb_optimize_scan and this is currently
disabled for inodes with indirect blocks however in the following patch
we want to enable mb_optimize_scan regardless of inode format.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 56d50fd3310b..a88fbaa4f5f4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -892,6 +892,21 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
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
+	/* Pairs with smp_wmb() in ext4_update_super() */
+	smp_rmb();
+
+	return ngroups;
+}
+
 static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
 					struct xarray *xa,
 					ext4_group_t start, ext4_group_t end)
@@ -899,7 +914,7 @@ static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
 	struct super_block *sb = ac->ac_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	enum criteria cr = ac->ac_criteria;
-	ext4_group_t ngroups = ext4_get_groups_count(sb);
+	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
 	unsigned long group = start;
 	struct ext4_group_info *grp;
 
@@ -951,7 +966,7 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
 	ext4_group_t start, end;
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
 		ret = ext4_mb_scan_groups_largest_free_order_range(ac, i,
@@ -1001,7 +1016,7 @@ static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
 	ext4_group_t start, end;
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
 	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
@@ -1083,7 +1098,7 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
 		min_order = fls(ac->ac_o_ex.fe_len);
 
 	start = group;
-	end = ext4_get_groups_count(ac->ac_sb);
+	end = ext4_get_allocation_groups_count(ac);
 wrap_around:
 	for (i = order; i >= min_order; i--) {
 		int frag_order;
@@ -1182,11 +1197,7 @@ static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
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


