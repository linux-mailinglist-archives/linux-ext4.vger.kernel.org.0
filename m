Return-Path: <linux-ext4+bounces-1283-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF285A9A4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B592845C2
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C7446AD;
	Mon, 19 Feb 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d45RFPsu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/daxwwh5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d45RFPsu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/daxwwh5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5F3F8DA
	for <linux-ext4@vger.kernel.org>; Mon, 19 Feb 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362644; cv=none; b=ZDjbwl3WrzFnN9NmuV/0pzXZPYglS9iBhVWSvxsUg/bCqpq9a6z7A1VEOER3Ees5bDoAuvf+1EwfZow6EVeNZVsYBS4RVPXbL1+SLmzCSDLuBZwe1+38fieRYbM0kUXrmob3rV1htejIwFTVtPQ2Hqz37T45Br/3ouwkplbe7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362644; c=relaxed/simple;
	bh=WKFiFr64CUB/1NasbChOmjnE/kI1Szel06Fw0y9b3l4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLcLWsYYS+2io4QePT2L99RaWXlYcOkmRD6To0nzO/1y3+DlFLb/KqTBDWnx4gUlLAU9h8wZP029sG2wt8DlPNVZpKTQT7WmbzRiYhpwZpd2AFsOXXl6SnIMFTz6kNNclHegbrBgGPY+Vf03WpA4mc5nxUDKxevJ6caTuLAoiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d45RFPsu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/daxwwh5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d45RFPsu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/daxwwh5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85F2F21F68;
	Mon, 19 Feb 2024 17:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708362639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iJ+/nNmhztD2mxNSusR0IJsWj0+7uBy6vvC4GbPwuWQ=;
	b=d45RFPsuSWbxcqJRSgx0V1IwRo91wuipQpFGJS4+c8oeFdr3OzLR2AY5JKPswKocWKNxFK
	NawpNosH9BdQsW9/avKmtgZmuTit+6C8P7fs2sQy8Cbu29FHh+gmiqtcIIi2CbdEWwv/t6
	i/1wCRjVq+3tP27r5AMgDYWYHmF6B7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708362639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iJ+/nNmhztD2mxNSusR0IJsWj0+7uBy6vvC4GbPwuWQ=;
	b=/daxwwh55SbZF++FFxRkeITg+96/LrCNGsPSCOlEAdvv2q+DUT9rsbuwQ7aKDF/m+Cz8+q
	d2IdT9jCbxPrtRCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708362639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iJ+/nNmhztD2mxNSusR0IJsWj0+7uBy6vvC4GbPwuWQ=;
	b=d45RFPsuSWbxcqJRSgx0V1IwRo91wuipQpFGJS4+c8oeFdr3OzLR2AY5JKPswKocWKNxFK
	NawpNosH9BdQsW9/avKmtgZmuTit+6C8P7fs2sQy8Cbu29FHh+gmiqtcIIi2CbdEWwv/t6
	i/1wCRjVq+3tP27r5AMgDYWYHmF6B7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708362639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iJ+/nNmhztD2mxNSusR0IJsWj0+7uBy6vvC4GbPwuWQ=;
	b=/daxwwh55SbZF++FFxRkeITg+96/LrCNGsPSCOlEAdvv2q+DUT9rsbuwQ7aKDF/m+Cz8+q
	d2IdT9jCbxPrtRCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 70A06139C6;
	Mon, 19 Feb 2024 17:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1+N+G4+L02ULOQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 17:10:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1652AA0807; Mon, 19 Feb 2024 18:10:35 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2] ext4: Verify s_clusters_per_group even without bigalloc
Date: Mon, 19 Feb 2024 18:10:33 +0100
Message-Id: <20240219171033.22882-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; i=jack@suse.cz; h=from:subject; bh=WKFiFr64CUB/1NasbChOmjnE/kI1Szel06Fw0y9b3l4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBl04tzaDbKExYHf1lB0mzxBCe7oguVUBOSsAZgQiut tgU4ESmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZdOLcwAKCRCcnaoHP2RA2ScLCA CaWPwXteu3o6+QR/jo7/r4NrhPAd1GzqSRJ8ntaLzHEDgxf3OYX1qX7P2ekKpZ1n5U0oYNmYgXtYw+ VP3rKBHd2UqcEbMZPlCK4JCwlteBXIymPk4OQIM7Aa2feX/aQJSNyBFW/tt70v/dmgndPyGlot97pY Zx7P0p/rh869dhY0osNhcG+EaR+XtU9WFjO4eTwt8vivgH59U8x0JpgfQPL/CSiY/ixCX1nG1oZ93Y AzhAYDtBp1otgzoNOxDb6da4PICYRcFVxrTfMrqw3yCEkgr9IQ+RYQmIaH5djWiTEw0S4ouZOB7gVA KfHY9tYRizs/GA4/g+89SyBBBYrbp0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.69
X-Spamd-Result: default: False [3.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[51.08%]
X-Spam-Flag: NO

Currently we ignore s_clusters_per_group field in the on-disk superblock
if bigalloc feature is not enabled. However e2fsprogs don't even open
the filesystem if s_clusters_per_group is invalid. This results in an
odd state where kernel happily works with the filesystem while even
e2fsck refuses to touch it. Verify that s_clusters_per_group is valid
even if bigalloc feature is not enabled to make things consistent. Due
to current e2fsprogs behavior it is unlikely there are filesystems out
in the wild (except for intentionally fuzzed ones) with invalid
s_clusters_per_group counts.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

Changes since v1:
* share code checking s_clusters_per_group for !bigalloc & bigalloc configs

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..0a34e0b23541 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4422,22 +4422,6 @@ static int ext4_handle_clustersize(struct super_block *sb)
 		}
 		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
 			le32_to_cpu(es->s_log_block_size);
-		sbi->s_clusters_per_group =
-			le32_to_cpu(es->s_clusters_per_group);
-		if (sbi->s_clusters_per_group > sb->s_blocksize * 8) {
-			ext4_msg(sb, KERN_ERR,
-				 "#clusters per group too big: %lu",
-				 sbi->s_clusters_per_group);
-			return -EINVAL;
-		}
-		if (sbi->s_blocks_per_group !=
-		    (sbi->s_clusters_per_group * (clustersize / sb->s_blocksize))) {
-			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
-				 "clusters per group (%lu) inconsistent",
-				 sbi->s_blocks_per_group,
-				 sbi->s_clusters_per_group);
-			return -EINVAL;
-		}
 	} else {
 		if (clustersize != sb->s_blocksize) {
 			ext4_msg(sb, KERN_ERR,
@@ -4451,9 +4435,21 @@ static int ext4_handle_clustersize(struct super_block *sb)
 				 sbi->s_blocks_per_group);
 			return -EINVAL;
 		}
-		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
 		sbi->s_cluster_bits = 0;
 	}
+	sbi->s_clusters_per_group = le32_to_cpu(es->s_clusters_per_group);
+	if (sbi->s_clusters_per_group > sb->s_blocksize * 8) {
+		ext4_msg(sb, KERN_ERR, "#clusters per group too big: %lu",
+			 sbi->s_clusters_per_group);
+		return -EINVAL;
+	}
+	if (sbi->s_blocks_per_group !=
+	    (sbi->s_clusters_per_group * (clustersize / sb->s_blocksize))) {
+		ext4_msg(sb, KERN_ERR,
+			 "blocks per group (%lu) and clusters per group (%lu) inconsistent",
+			 sbi->s_blocks_per_group, sbi->s_clusters_per_group);
+		return -EINVAL;
+	}
 	sbi->s_cluster_ratio = clustersize / sb->s_blocksize;
 
 	/* Do we have standard group size of clustersize * 8 blocks ? */
-- 
2.35.3


