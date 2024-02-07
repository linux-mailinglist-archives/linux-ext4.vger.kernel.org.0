Return-Path: <linux-ext4+bounces-1158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517AB84D4D0
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF32E1F2305F
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE875164179;
	Wed,  7 Feb 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObVgyfFq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F1D164178;
	Wed,  7 Feb 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341176; cv=none; b=evOogOwjOmifNYSL6R4waXOFifEbCUm5Jd8byIZpEdFigwOgjU+ypMv0AvVNYFYLwTRgq9nCSjadGm/MY8cGtudw/yR+Y2Ps6SrdL3KNwIrPwqTZBB7+/m+0zAA39wMEv1CSvoYGrgkJf2gUy+btW5R0I9W4cZcUIoB9L8GP250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341176; c=relaxed/simple;
	bh=DO2+wv1cKo3aUBMp90WeMkYvS8ybYvyp0oFvycHzjrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSWePe+SSVSwS1SgbuJiTtUJbfGgwj6KRyrHTBJdASTj1CStrs5Q1yoEwGyETm05pqyPwsesSh/Cq/MRicGBhum/d+VTZ/uwVAYMVAgUwrOmHLGBdIiPCIeZIalZFvmrUdQT8sRUtrvWlyF2iNmXcxTZLNTFAXFC+WlsOlyKpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObVgyfFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A488C43390;
	Wed,  7 Feb 2024 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341175;
	bh=DO2+wv1cKo3aUBMp90WeMkYvS8ybYvyp0oFvycHzjrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ObVgyfFqdQNGufRG6PTZ31wgZq4/lojgUzevvNocLkjfqv6xuk4SljcQF0e46pppd
	 Tjxqt8HLKDrZnv0udYA+g06E+pw3xgOKEoGGEDdS2R3+oKRd1cRvBzFFs8rk0Q/Sn8
	 04y6EwmvR1E1B+QRlTuD3jJ470oaRfb3aa15beYl4qE1erBtTLB++xsoL1hUhbY7E3
	 qGzONcSc7VVtQfFVxAbK4yahgr3DU07SO5GXd4Pq8Bnq6Otq7hMV9guZQzBOpkkf/e
	 oR5ruURWK+okJp9uBMxpPQl+I5vILhe5qpEzOuG4dva9S+P/wSpv16KNFPJHNIZBCK
	 OSB69bW30WPqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/23] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
Date: Wed,  7 Feb 2024 16:25:43 -0500
Message-ID: <20240207212611.3793-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 4530b3660d396a646aad91a787b6ab37cf604b53 ]

Determine if the group block bitmap is corrupted before using ac_b_ex in
ext4_mb_try_best_found() to avoid allocating blocks from a group with a
corrupted block bitmap in the following concurrency and making the
situation worse.

ext4_mb_regular_allocator
  ext4_lock_group(sb, group)
  ext4_mb_good_group
   // check if the group bbitmap is corrupted
  ext4_mb_complex_scan_group
   // Scan group gets ac_b_ex but doesn't use it
  ext4_unlock_group(sb, group)
                           ext4_mark_group_bitmap_corrupted(group)
                           // The block bitmap was corrupted during
                           // the group unlock gap.
  ext4_mb_try_best_found
    ext4_lock_group(ac->ac_sb, group)
    ext4_mb_use_best_found
      mb_mark_used
      // Allocating blocks in block bitmap corrupted group

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-7-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3df3c3894f7b..d826579686f7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2197,6 +2197,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -2204,6 +2207,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


