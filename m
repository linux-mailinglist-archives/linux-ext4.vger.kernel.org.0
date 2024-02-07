Return-Path: <linux-ext4+bounces-1154-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB3684D482
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D146D1F21C44
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57914154C01;
	Wed,  7 Feb 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OawKXG9X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE601154BF3;
	Wed,  7 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341109; cv=none; b=MyOKcMVc/ixo3dkJYys24Wc3sfeE4MjEpu2fD9hxVy/D35F925t3TLs8T/13RQtFtzT8ZBXUVyPS3XNICRxOxZu0JTStZMi1SYCwjW9SgFS/EdCPdOvImW/8YxLVDiof7SwfeQCBE7BSZIuq3GHjJEZUR2eG2WJZqaJYALf2Xx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341109; c=relaxed/simple;
	bh=mqvR0Uxe06W/a3H0KFK7WHpnjpkTLVd5Dod+onYWdgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNBIMbAEIdB51o5Y9Pv125VS7kae84vaWKKufA89rP7YqDdn3LcE3A8zvCcw7ylhrVoSf2kh6HjrkDGMVx6YmY6Y8i9zYI0tK5CqIFTbZMn1suI+lr+ypzYm9wxkk7WO4vPVgD7ehBXm0vcg9yoMB4MfxVd9n2jXeHf+4L3yR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OawKXG9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93925C43390;
	Wed,  7 Feb 2024 21:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341109;
	bh=mqvR0Uxe06W/a3H0KFK7WHpnjpkTLVd5Dod+onYWdgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OawKXG9Xmc4+IOPI0/8Bh0R4fXxIc6wPwnqRFyESBAaxrnJdiccuKuocN6P1WrLHZ
	 gGqeYjq6W3licSwTEIp3jr+NH3KFz2uSrIunBSvWSPff/AID6Tvl2KfwAB9E6yXtet
	 4ylvckwCX1xFn5LZvd+n0BChwpYxA1fYGjSx2pyMgf1TYzwF9EogfYRpo6G/ZwnBMT
	 XJ1VFV4wWNOlecIq92iGY09Y1+Ltj6DlZcfZUc9zWkRjgHg/NgpxjQWyNbuRD6tpeD
	 YTGv/8iqZsNSn52G/+uu7I7XpXWlpawmZGpIsjDPqRflF6/4rde8WvXIAmVY2lzomH
	 QglP31lIotvSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/29] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
Date: Wed,  7 Feb 2024 16:24:27 -0500
Message-ID: <20240207212505.3169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index 779555925029..83618cdfd6e9 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2153,6 +2153,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -2160,6 +2163,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


