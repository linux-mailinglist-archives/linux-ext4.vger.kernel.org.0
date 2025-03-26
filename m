Return-Path: <linux-ext4+bounces-6988-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8995A726AE
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 23:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0251C18935D8
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105F263F2F;
	Wed, 26 Mar 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqCMYdlH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19818801A;
	Wed, 26 Mar 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029754; cv=none; b=UQUVhzS1Z6mEwr2cgmPWtHxtqgBGsoRTAAjXzWIchW2E8DuPhPW2L4i38XmqPOCYKMp6BXMBy4MFTBHBXBg9qFvHh+WwSKua5zrNBd7T44WV/Tzwp/JXZ5efwXLZspk+xqk6vGMYFNOnUYHHKNO/0qH9yUmlJGLfWTWDQnv8Lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029754; c=relaxed/simple;
	bh=ItoMvWidGT+0fiNTNyX78Fe5vybtTDqUWelw4ieMly4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dZJp3xs1r61d+MuRXLGhlbENCEPhavImiN+BzmxeBwZJ/heVxqoZKGF9BdkT7nGDO3ClsaACZ5Sdtwkk1Y56EbE5jfeZquJiTlQBuYwmU9319BlhpLJTsVX3z5LQ2eR2Z35CnQIk/bvmhatu3f6SX/+n60MnKVk0rZ4543lCwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqCMYdlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62103C4CEE2;
	Wed, 26 Mar 2025 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743029753;
	bh=ItoMvWidGT+0fiNTNyX78Fe5vybtTDqUWelw4ieMly4=;
	h=Date:From:To:Cc:Subject:From;
	b=IqCMYdlHSI2UPSepRzrgRx4+JdIBPTJ7tBSZxZPKwn6s/upaY3PH7h+try4hsD4su
	 9rZkMi7BA9GlXfk0DKjP5J8KqrjVMEhZh36ng5j0IYWNHOT1yntckym9VAeV+HCOth
	 kDRuPGOZF4plixcsJLvG36weWbkyS8qVxWkQWCQRBvO10e2SP85ZEAzim9pe4ih16U
	 ktcqJeWqRF1p1/aIlBVdYqWUvSI3PGvkGo7eT6iOn55i6PFrv7OrmxMxTjPhFtphT3
	 av7WHdbx7arG1YRXvhxL0doCFblTS0HKUtkXi+QqV7ujVCzA8juGjkxYd4/yfu2L5L
	 LDZ24Wosx4ZJA==
Date: Wed, 26 Mar 2025 16:55:51 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ext4: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <Z-SF97N3AxcIMlSi@kspp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

fs/ext4/mballoc.c:3041:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/ext4/mballoc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0d523e9fb3d5..f88424c28194 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3037,10 +3037,8 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	unsigned char blocksize_bits = min_t(unsigned char,
 					     sb->s_blocksize_bits,
 					     EXT4_MAX_BLOCK_LOG_SIZE);
-	struct sg {
-		struct ext4_group_info info;
-		ext4_grpblk_t counters[EXT4_MAX_BLOCK_LOG_SIZE + 2];
-	} sg;
+	DEFINE_RAW_FLEX(struct ext4_group_info, sg, bb_counters,
+			EXT4_MAX_BLOCK_LOG_SIZE + 2);
 
 	group--;
 	if (group == 0)
@@ -3048,7 +3046,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 			      " 2^0   2^1   2^2   2^3   2^4   2^5   2^6  "
 			      " 2^7   2^8   2^9   2^10  2^11  2^12  2^13  ]\n");
 
-	i = (blocksize_bits + 2) * sizeof(sg.info.bb_counters[0]) +
+	i = (blocksize_bits + 2) * sizeof(sg->bb_counters[0]) +
 		sizeof(struct ext4_group_info);
 
 	grinfo = ext4_get_group_info(sb, group);
@@ -3068,14 +3066,14 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	 * We care only about free space counters in the group info and
 	 * these are safe to access even after the buddy has been unloaded
 	 */
-	memcpy(&sg, grinfo, i);
-	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg.info.bb_free,
-			sg.info.bb_fragments, sg.info.bb_first_free);
+	memcpy(sg, grinfo, i);
+	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg->bb_free,
+			sg->bb_fragments, sg->bb_first_free);
 	for (i = 0; i <= 13; i++)
 		seq_printf(seq, " %-5u", i <= blocksize_bits + 1 ?
-				sg.info.bb_counters[i] : 0);
+				sg->bb_counters[i] : 0);
 	seq_puts(seq, " ]");
-	if (EXT4_MB_GRP_BBITMAP_CORRUPT(&sg.info))
+	if (EXT4_MB_GRP_BBITMAP_CORRUPT(sg))
 		seq_puts(seq, " Block bitmap corrupted!");
 	seq_putc(seq, '\n');
 	return 0;
-- 
2.43.0


