Return-Path: <linux-ext4+bounces-14242-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFg7DVuWo2l7HQUAu9opvQ
	(envelope-from <linux-ext4+bounces-14242-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:28:59 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5411CAC20
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBAEA304B937
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614E126E710;
	Sun,  1 Mar 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URHHBYCZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECE2BD0B;
	Sun,  1 Mar 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328131; cv=none; b=o7kEisYLh8FqX/sKq+z7kO66ae4L9W9wJb33YTORWfRsqapMGWQhKqFmDG5I/5HOUIIEVTJZMXX/WSyQPfSvAuquXMu1ARadHLDDlGuLAKq6yAacW5zQYPFz2hUUoFB3Ku7mMSg00BWhUIN/pJZBqrSJPjwGsrfX4HrYOCJCrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328131; c=relaxed/simple;
	bh=rVktVtGBq8VIzmmoT+MNg8jwrx+bittI/kyLU1gJzJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TilQKg8floOsnRg4HaLtULt8NNQqvHUymwfHiFx14GEbmKf/MgWn5BdFMEQSw68BxJVBNc7bm1OKgBRnoJ6H7vZflRvWj1kICF3TeWEvGYl+E02LvD+H671HVGIzfL5lV6zh7QfzeXJcmFLqiV18flCVhtMbWTlzzLRWxK3kpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URHHBYCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF9C19421;
	Sun,  1 Mar 2026 01:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328130;
	bh=rVktVtGBq8VIzmmoT+MNg8jwrx+bittI/kyLU1gJzJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=URHHBYCZInrddBbC2hat4aJ4gmuNMpDKlivUvOCi0xmCI/cPEy+nAUmz/9hYEfiNA
	 ibEYt5No46ysGHIr+XZc2a4rgd7UjwRMK+HHKmsFR8Sp+qCV/ifCz01H5ubO2TKhYE
	 /JBdUgfbzZfGxAKGu9aLr2MGbGxzurJ7/tOD1Xt+vsPPagIuqYwHemNmZAkjbKn4xp
	 ba2YUOLq8+YI56ObV2Tssr6pItoMD9qTDHbbwszcsq/74eCynwlAUgXdzJG5WgnzKU
	 U76j4wl7hrZq6PuzARofjStuVydnY7PIhU9kzN+vWLztccLxQWGd0/VeqFqJSvlmGJ
	 zS7L2PSnj79Eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jack@suse.cz
Cc: Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Pedro Falcato <pfalcato@suse.de>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: always allocate blocks only from groups inode can use" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:22:08 -0500
Message-ID: <20260301012209.1678311-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14242-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,suse.de:email,huawei.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 6E5411CAC20
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4865c768b563deff1b6a6384e74a62f143427b42 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 14 Jan 2026 19:28:18 +0100
Subject: [PATCH] ext4: always allocate blocks only from groups inode can use

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
Acked-by: Pedro Falcato <pfalcato@suse.de>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20260114182836.14120-3-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mballoc.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index dd29558ad753b..910b454b4a21e 100644
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





