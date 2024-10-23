Return-Path: <linux-ext4+bounces-4724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0909ACBCB
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2024 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4FC1C214B9
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2024 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0061AC884;
	Wed, 23 Oct 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="otRh08XK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C281AC448
	for <linux-ext4@vger.kernel.org>; Wed, 23 Oct 2024 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692022; cv=none; b=ALg2PzNDdrYRjbidCdRIxiUZU0wuqG8Y8yTMpy14SVI0dR7Pi7/Iek7mtNgHgcwmx9HaBg79SQCbk7cqyWrY5I1aWmheF4uDFo8Vzjpii3kB+Xkh0w1FnfMx+XvO+lG3MX+w+e2jKuTXKJNVB/qoJvUezDB7Fpw7USVGVHocCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692022; c=relaxed/simple;
	bh=vDbJrXTeijbukn2oNGZfEfxI7Qlyp/pZawxkxi8AVPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2UHiY4INsFq51wtysYW+Sid4U2Lpbu+i94+oZAYa258XVAfCaGQwauAzgSLDLNcrgXsQkS7vjcsNiO9pc3UAyRTbDX/+mM6gTqGepkpQEz2jsqimqSXTpkdGB7janqaMMgcCCmg7uN0lFL2+oVN6CwDZ9qwiav1gXoH1BtoaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=otRh08XK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49NDxuL4002002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 09:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729691999; bh=RA4vklHLPC468pd27Ps0R0fpFKUURRyn19YtTDDSnok=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=otRh08XKSQdoHNLuf+0Sd8/DKlSdoQ+cKrBiopfLuCGigeeaGEoRjJOCZpvKzZBy0
	 6FpzNO5hDkLDEt/S7iyKGvMXdlwMlK51aX/OA8L3bHsgGLI7DFmULQPoTeDCmQVbWG
	 1sNXWTtx62fEo9+G6+pyl6WCJWtVZwio6+lVEn/U9eXTj+KsfmD5Gpsef7IPR/5PYd
	 SYcv0clRzhM5Al0DZBL4HtWEQuiqP6NvT5AwaHCrW4ZUp85lDUxiCu1VIedoX3YxEy
	 gFi17Dvt4G47coKc/NAMDbgPjmjd3HR1vSv8rgDt7helzrptoj1LgZBKUiFmwEFF6q
	 3FQan0ya98CbQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2533F15C02DB; Wed, 23 Oct 2024 09:59:56 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: fix FS_IOC_GETFSMAP handling
Date: Wed, 23 Oct 2024 09:59:49 -0400
Message-ID: <20241023135949.3745142-1-tytso@mit.edu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original implementation ext4's FS_IOC_GETFSMAP handling only
worked when the range of queried blocks included at least one free
(unallocated) block range.  This is because how the metadata blocks
were emitted was as a side effect of ext4_mballoc_query_range()
calling ext4_getfsmap_datadev_helper(), and that function was only
called when a free block range was identified.  As a result, this
caused generic/365 to fail.

Fix this by creating a new function ext4_getfsmap_meta_helper() which
gets called so that blocks before the first free block range in a
block group can get properly reported.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/fsmap.c   | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.c | 18 ++++++++++++----
 fs/ext4/mballoc.h |  1 +
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index df853c4d3a8c..383c6edea6dd 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -185,6 +185,56 @@ static inline ext4_fsblk_t ext4_fsmap_next_pblk(struct ext4_fsmap *fmr)
 	return fmr->fmr_physical + fmr->fmr_length;
 }
 
+static int ext4_getfsmap_meta_helper(struct super_block *sb,
+				     ext4_group_t agno, ext4_grpblk_t start,
+				     ext4_grpblk_t len, void *priv)
+{
+	struct ext4_getfsmap_info *info = priv;
+	struct ext4_fsmap *p;
+	struct ext4_fsmap *tmp;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_fsblk_t fsb, fs_start, fs_end;
+	int error;
+
+	fs_start = fsb = (EXT4_C2B(sbi, start) +
+			  ext4_group_first_block_no(sb, agno));
+	fs_end = fs_start + EXT4_C2B(sbi, len);
+
+	/* Return relevant extents from the meta_list */
+	list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
+		if (p->fmr_physical < info->gfi_next_fsblk) {
+			list_del(&p->fmr_list);
+			kfree(p);
+			continue;
+		}
+		if (p->fmr_physical <= fs_start ||
+		    p->fmr_physical + p->fmr_length <= fs_end) {
+			/* Emit the retained free extent record if present */
+			if (info->gfi_lastfree.fmr_owner) {
+				error = ext4_getfsmap_helper(sb, info,
+							&info->gfi_lastfree);
+				if (error)
+					return error;
+				info->gfi_lastfree.fmr_owner = 0;
+			}
+			error = ext4_getfsmap_helper(sb, info, p);
+			if (error)
+				return error;
+			fsb = p->fmr_physical + p->fmr_length;
+			if (info->gfi_next_fsblk < fsb)
+				info->gfi_next_fsblk = fsb;
+			list_del(&p->fmr_list);
+			kfree(p);
+			continue;
+		}
+	}
+	if (info->gfi_next_fsblk < fsb)
+		info->gfi_next_fsblk = fsb;
+
+	return 0;
+}
+
+
 /* Transform a blockgroup's free record into a fsmap */
 static int ext4_getfsmap_datadev_helper(struct super_block *sb,
 					ext4_group_t agno, ext4_grpblk_t start,
@@ -539,6 +589,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 		error = ext4_mballoc_query_range(sb, info->gfi_agno,
 				EXT4_B2C(sbi, info->gfi_low.fmr_physical),
 				EXT4_B2C(sbi, info->gfi_high.fmr_physical),
+				ext4_getfsmap_meta_helper,
 				ext4_getfsmap_datadev_helper, info);
 		if (error)
 			goto err;
@@ -560,7 +611,8 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 
 	/* Report any gaps at the end of the bg */
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster, 0, info);
+	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
+					     0, info);
 	if (error)
 		goto err;
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d73e38323879..92f49d7eb3c0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6999,13 +6999,14 @@ int
 ext4_mballoc_query_range(
 	struct super_block		*sb,
 	ext4_group_t			group,
-	ext4_grpblk_t			start,
+	ext4_grpblk_t			first,
 	ext4_grpblk_t			end,
+	ext4_mballoc_query_range_fn	meta_formatter,
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv)
 {
 	void				*bitmap;
-	ext4_grpblk_t			next;
+	ext4_grpblk_t			start, next;
 	struct ext4_buddy		e4b;
 	int				error;
 
@@ -7016,10 +7017,19 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = max(e4b.bd_info->bb_first_free, start);
+	start = max(e4b.bd_info->bb_first_free, first);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-
+	if (meta_formatter && start != first) {
+		if (start > end)
+			start = end;
+		ext4_unlock_group(sb, group);
+		error = meta_formatter(sb, group, first, start - first,
+				       priv);
+		if (error)
+			goto out_unload;
+		ext4_lock_group(sb, group);
+	}
 	while (start <= end) {
 		start = mb_find_next_zero_bit(bitmap, end + 1, start);
 		if (start > end)
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index d8553f1498d3..f8280de3e882 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -259,6 +259,7 @@ ext4_mballoc_query_range(
 	ext4_group_t			agno,
 	ext4_grpblk_t			start,
 	ext4_grpblk_t			end,
+	ext4_mballoc_query_range_fn	meta_formatter,
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 
-- 
2.45.2


