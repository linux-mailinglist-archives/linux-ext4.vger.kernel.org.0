Return-Path: <linux-ext4+bounces-1162-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C388784D519
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 23:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F8B1F2364A
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49046D86C;
	Wed,  7 Feb 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iufrfc99"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7A6D87B;
	Wed,  7 Feb 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341225; cv=none; b=ui05G53pQYTNI5kvGqleqB5RrpJ4ImZo8+3fZT6n7nBeoSOF+YqHjT/9ByXKMZOqkqPl8mEIRyHi/k06OiyRrl+M9p2Sfut5lbBIljx9yBkj2wICfE2JsKoUcRq2MtNEfnXkqBEZsius2rhXtYPXds5Npm4o5hRA8CY5QzUUaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341225; c=relaxed/simple;
	bh=wSXq6+ypghM8GSvXsb1WdLAK3hWaXouBFWr5putC/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou/rbq6Y+GoPgK+KfWxFhaiuwFUAGZsvYqvMse2pTjlEuk3nfn0P4XcjTiH4abfn/ND3AFMoM6Pd8aNi9/0wdNLS+lKrxZ4XLDjnVREcjIBe1SL8m01RtmCa2DAx6WBqy9D+iO6p/uzFNWt05XSq+xqskHy9qpVJ+0CYDuqFP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iufrfc99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B21C433A6;
	Wed,  7 Feb 2024 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341224;
	bh=wSXq6+ypghM8GSvXsb1WdLAK3hWaXouBFWr5putC/8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iufrfc993wJvw6r2xZ6zDY9WrqOwgYBEf56GJOe6QzyQJoZ4ZQ9EgWpAYDDAqOr+e
	 QtO3/F2/4UoBGhB1YkmSWypALVgZTzKBUyOD7GQwenQ09xLEQsB6iC0GRqwmVW/8Wy
	 9U9WXyltInkqufp5iM2tvtsu3B52OMNObtdPlqgHf9vC82zgdTWRgCzoPJktASYcCB
	 vBLpd3TCLIBWDLF5oS+efFDZJ1kGatJs3uyOTeCCPjfIxmdnH1kZPynJ6/LbQlACRq
	 2v8HR7WNG2l4CBBDkyICZu7XVIplXxhjQzTXoQMkZHmsKV5t7MofNYtGdCHIO53Q0L
	 BeXYx6+pkZIKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/16] ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
Date: Wed,  7 Feb 2024 16:26:42 -0500
Message-ID: <20240207212700.4287-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
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
index d7724601f42b..e528ae0618fe 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1893,12 +1893,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
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
@@ -1931,6 +1929,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


