Return-Path: <linux-ext4+bounces-1151-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FDF84D427
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6F02851DC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ECD12D751;
	Wed,  7 Feb 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8dIoCAC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4D1419B4;
	Wed,  7 Feb 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341023; cv=none; b=KYlBRx8JFk9qjvZzygLB0SjN265kkwgjixr/RFbpG1Jfza0cpZ5Bym7P9Z/dwrlVOjLkJHgqg3r1Ft/QwJRgggCIdNRsBRot+hzp2X/mP3TDvnIBAG/JJgWJnuvZBu844R/5rUcElysODVxePDHVYEwoDp4NtVAjY4S92aCwTZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341023; c=relaxed/simple;
	bh=DfxVAaaNMm7kplyn2GrIJpPnh4uITqz4pspwqN6TQEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBPJHjDK1ybSloWJ3sOq1dWEomL8AGCfiw7W8Tu7jBpfuOVejdB3wPQJCiIAvMpRuiu6dOkuJiUdy9IRSXuv0VXK+MwT9Lrxv7xuVFPUkw5qm6bx16XCPsO+kkG+/iUl/UJEV19lrkcJi0TlPaykmkPX+of88ZYUS3QHi33h4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8dIoCAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1B4C433F1;
	Wed,  7 Feb 2024 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341023;
	bh=DfxVAaaNMm7kplyn2GrIJpPnh4uITqz4pspwqN6TQEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8dIoCAC4MndNAO17rGhIRjsGjqYEROT9ihWSm4863z9ViviGtguLTTje2+PQj2zJ
	 hnXOj6yIfGBETm8CzhpZXDXadkveWfj0xT1bmFJTOHcBGvTWkDRpSaoom7xD481M6K
	 OG5nRCSyjx+BCfvlZ9iO8qrw2LmkoKptIJ/7FQ9VRckukhcJ3lmeJVGSxdg7s5GqZv
	 SEowHZVdMd4Wh51mnQsiG6gAUJe1JttH+L5ewc3PGnNoZUFcXSNzX3i7Eb/u9NspAV
	 mvE9Z15PsHkT8fv8V+zhHZqLt1A5da74CFOxaH1hxhZTeoV3AWOAfuWZLqflwnZbOu
	 BUInTA+UBnEsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/38] ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
Date: Wed,  7 Feb 2024 16:22:49 -0500
Message-ID: <20240207212337.2351-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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
index 58d562c16164..c929a7fcb6cb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2318,12 +2318,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
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
@@ -2356,6 +2354,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


