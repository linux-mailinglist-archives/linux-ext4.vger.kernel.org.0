Return-Path: <linux-ext4+bounces-14258-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDhtAYKao2l4IAUAu9opvQ
	(envelope-from <linux-ext4+bounces-14258-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:46:42 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 910761CBAA4
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 02:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 916B83035890
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96572DCBFA;
	Sun,  1 Mar 2026 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4UvNbZH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DF29B795;
	Sun,  1 Mar 2026 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329323; cv=none; b=mUOhzIabk68LD0aCjFhmN6ODUKVFPY8QayO15d9VpM0Rbk8seMpQK6PrCupPe59DfK4zVUn9ilpjk+YujBiKxE/OUf/NadGnPso0z4KiNBdtMk7YIDtD4LqMdKKzaCZ83gFsErMzGzwhJGB6kR1DqLb3NBXzOGqICOy9gQLUtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329323; c=relaxed/simple;
	bh=tK/Z6uzqIGUGEBI2xpmH0wmW59rupbw35o8wTISOXSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cf6OSUr2ss10BPtEbVLbndWHm3m6UKIyjUGjERFPyDcSngBzFKcBJ66485kzVJKlhKQvVngnAgUem4TZognIO8ILCpKtQcdTiN4l68gHF+jZhY2TNj7UwJ0Y2CdDiVJRu3uJ7+g7J7MyDQNcWh/rzcYwIpVnpxPowgNJjPg2XbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4UvNbZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F7AC2BC87;
	Sun,  1 Mar 2026 01:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329323;
	bh=tK/Z6uzqIGUGEBI2xpmH0wmW59rupbw35o8wTISOXSc=;
	h=From:To:Cc:Subject:Date:From;
	b=h4UvNbZH2GJM4ELox/q74/aSEGilHLvb32evRmTbyy/INGA0EPtDD6hsBqop9bc1f
	 gwh6YfmMCI2TTqsPJ0WX+oies/fAPvgA8x3U+FAnbrLbKBcz+XfcGD1WqYZy2JvTTO
	 jgBwvId2WtUjJ/5CKFFxpTyDNJmx0qymsMKXsJLoq3k1/Np1Dju1LxTpPLeSXTv1sH
	 JD1hWMLjMH3uBTbn0gcCBSVwykPnT0AXaWgNjEOkmvFt2b9bTIZo5lj6nUpVLBwhpN
	 9BrkjX6vGpauUPn/ONpxk1zsF+0ineIIH4/z7Nz5zfX/7DHnqNoE3Hw4rOr2XpUNDU
	 gNmQbmJ05OZZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.zhang@huawei.com
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: FAILED: Patch "ext4: subdivide EXT4_EXT_DATA_VALID1" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:42:01 -0500
Message-ID: <20260301014201.1703796-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14258-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:email]
X-Rspamd-Queue-Id: 910761CBAA4
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22784ca541c0f01c5ebad14e8228298dc0a390ed Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 29 Nov 2025 18:32:33 +0800
Subject: [PATCH] ext4: subdivide EXT4_EXT_DATA_VALID1

When splitting an extent, if the EXT4_GET_BLOCKS_CONVERT flag is set and
it is necessary to split the target extent in the middle,
ext4_split_extent() first handles splitting the latter half of the
extent and passes the EXT4_EXT_DATA_VALID1 flag. This flag implies that
all blocks before the split point contain valid data; however, this
assumption is incorrect.

Therefore, subdivid EXT4_EXT_DATA_VALID1 into
EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_DATA_PARTIAL_VALID1, which
indicate that the first half of the extent is either entirely valid or
only partially valid, respectively. These two flags cannot be set
simultaneously.

This patch does not use EXT4_EXT_DATA_PARTIAL_VALID1, it only replaces
EXT4_EXT_DATA_VALID1 with EXT4_EXT_DATA_ENTIRE_VALID1 at the location
where it is set, no logical changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Cc: stable@kernel.org
Message-ID: <20251129103247.686136-2-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/extents.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2cf5759ba6894..8d5ca450aa5d2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -43,8 +43,13 @@
 #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
 #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
 
-#define EXT4_EXT_DATA_VALID1	0x8  /* first half contains valid data */
-#define EXT4_EXT_DATA_VALID2	0x10 /* second half contains valid data */
+/* first half contains valid data */
+#define EXT4_EXT_DATA_ENTIRE_VALID1	0x8   /* has entirely valid data */
+#define EXT4_EXT_DATA_PARTIAL_VALID1	0x10  /* has partially valid data */
+#define EXT4_EXT_DATA_VALID1		(EXT4_EXT_DATA_ENTIRE_VALID1 | \
+					 EXT4_EXT_DATA_PARTIAL_VALID1)
+
+#define EXT4_EXT_DATA_VALID2	0x20 /* second half contains valid data */
 
 static __le32 ext4_extent_block_csum(struct inode *inode,
 				     struct ext4_extent_header *eh)
@@ -3190,8 +3195,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 	unsigned int ee_len, depth;
 	int err = 0;
 
-	BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2)) ==
-	       (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
+	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) == EXT4_EXT_DATA_VALID1);
+	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
+	       (split_flag & EXT4_EXT_DATA_VALID2));
 
 	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
 
@@ -3373,7 +3379,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
-			split_flag1 |= EXT4_EXT_DATA_VALID1;
+			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
 		if (IS_ERR(path))
@@ -3728,7 +3734,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 
 	/* Convert to unwritten */
 	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
-		split_flag |= EXT4_EXT_DATA_VALID1;
+		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
 	/* Convert to initialized */
 	} else if (flags & EXT4_GET_BLOCKS_CONVERT) {
 		/*
-- 
2.51.0





