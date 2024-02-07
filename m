Return-Path: <linux-ext4+bounces-1161-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A800D84D516
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645F3283A00
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBD96D874;
	Wed,  7 Feb 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvOWwzVs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A86D860;
	Wed,  7 Feb 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341223; cv=none; b=ZsClm1AdQDjnwRLnRy0Wsg0OpONA4MkrOCUHYNvibFkPRLBNqPV/P55I4YfAqCHJntG7YJR8Seba+m8U3xfJDvic+mwSQG93NSToz8aUwdBmSJsTbKSGnk8NsPfW56wXnEraGC1Nb9trlQVDzBIk2Tbawj61vfq+2+O/aHvMsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341223; c=relaxed/simple;
	bh=MjEd8+cP7sRII+F/VCnFCl958GjFREUuy8bQleD4UYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8wA+1GDJqHzP4KO+qARKwmCVcCBB5MiO5I46NhatSspJy4hd3LmM4TCbXOel8X4clcOTqdCFszReHrpzzDGwV25m5PyRZQ0OmmQIYVlHOjImTG9iE4daL2vflk8hSqJvRmxNVwBK4E4Y3hqiR20bMTP3dfhtA+15/N1ODkuLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvOWwzVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB48C43390;
	Wed,  7 Feb 2024 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341223;
	bh=MjEd8+cP7sRII+F/VCnFCl958GjFREUuy8bQleD4UYo=;
	h=From:To:Cc:Subject:Date:From;
	b=jvOWwzVsiDhyJZ0+VaqnOqmrIVmIl7IvLqeLePvYhNfiUFr/ET++v7dw0A5p84Uib
	 iK4ooI9GYgjq9iahE2mk8WMnH4aFsbHIwtevOw7JfsJCIDbXYrqx9sT3oxmN79b/Hw
	 Io0uPspKH35XJX2LuNVbtOsk51fmorV/3He/si6IlW8CQfQ/SK0+N3ZEBzBZBkOKJ2
	 3J6Ym3QE1nXlJmAkGn6np5WHcRwizK+9fqQwlRuXxFTiT4wQsmE3pxoO1n+R+HYkbI
	 0/eyfgfNa7NVAQygZlPWNotdCZTf8ueqecp1fQ2HiR92Gg1ORPgXmpy/0EgrYJanOG
	 NTHQcLjlpaOLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/16] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
Date: Wed,  7 Feb 2024 16:26:41 -0500
Message-ID: <20240207212700.4287-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 3babc07ae613..d7724601f42b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1854,6 +1854,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -1861,6 +1864,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


