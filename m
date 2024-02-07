Return-Path: <linux-ext4+bounces-1159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F984D4D3
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5EA1F23166
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975D16CE98;
	Wed,  7 Feb 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdK+2plY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CD164172;
	Wed,  7 Feb 2024 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341177; cv=none; b=ASiGeDkVSg/Ex7XnteIx3KhhEm+WtbRjyrWGNhjh9srN9JU8FBbD8EaGvEK0/oV+jUvRirTakwMDV8mZqIC0C6ljcMfhuAgNGRDVBVsy1AAoeSt//p25qEi/204YSZFS9B5QSoC1fyMyqoIgg8zMUmuhQofGT7ZQRXVErFTCnHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341177; c=relaxed/simple;
	bh=jnnzBDINcjaTb4ESVRpdZnaeniJMiM6jY5EHVhr9esU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE/pK1AeyN60A025mPGjq3LXQK0M0OUMvV/f4+uEyUEa2SY4i0qqsTsDsmzHAb1PLJYW1qbHI/bp6u/KkA0KVSm1XQHBk+t9/si9R2qp2yze8pp5CwRdTwb6FvKE8iKw0Oo9PaX4UKRnmEOfCMIkimMWH5BC/3V4FRXTZhl2jZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdK+2plY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F70C433A6;
	Wed,  7 Feb 2024 21:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341177;
	bh=jnnzBDINcjaTb4ESVRpdZnaeniJMiM6jY5EHVhr9esU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdK+2plYFsXUQswpnn3H++XJIowL6vzzojCPWMi+S+l3GpWcgYtNnuyrhYffgDPJt
	 kC2KlwBLb0YSf8qaWa+09t0huQzjmbtlEG9pvw0uY8HMDEeccE8tEgcwQa0aoU5g9q
	 ASyJ/yF5eFH0lTBZr97G27rTqJ62Q6IEru/CTqa1QKgXvBz8da34vo6XnvW+/KwerF
	 cygAIYImiPJnt3mWAy1+/BuxCRUFXoebUbc7oZj5AKhnjNZ8qGLjJtcWW6UaSfxF3d
	 CqFA6tfu7PS3QvyBi5xr9JLIddE5bc45ttN0Q3jiEblmCzRwuQAf3X3iSOwuzmmRzh
	 pzst+xyB4EvPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/23] ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
Date: Wed,  7 Feb 2024 16:25:44 -0500
Message-ID: <20240207212611.3793-3-sashal@kernel.org>
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

[ Upstream commit 832698373a25950942c04a512daa652c18a9b513 ]

Places the logic for checking if the group's block bitmap is corrupt under
the protection of the group lock to avoid allocating blocks from the group
with a corrupted block bitmap.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-8-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d826579686f7..e5ae9870d659 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2236,12 +2236,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (err)
 		return err;
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) {
-		ext4_mb_unload_buddy(e4b);
-		return 0;
-	}
-
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ac->ac_g_ex.fe_start,
 			     ac->ac_g_ex.fe_len, &ex);
 	ex.fe_logical = 0xDEADFA11; /* debug value */
@@ -2274,6 +2272,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


