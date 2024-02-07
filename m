Return-Path: <linux-ext4+bounces-1166-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A572484D554
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 23:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82CD1C25934
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C27146493;
	Wed,  7 Feb 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sS1Gh+tY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52614648A;
	Wed,  7 Feb 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341270; cv=none; b=hG7O9TPx629bGK1pykkEu3ybPVVSpIWuh6FW0Xcfu86OqFRaYu3IWOYBRG87RZ9i6SO0l6S7YCG0MG+0lN/AEsUTh9RXunEcbVjIoDJgrk5ifaqjDxX4QUVldq5CcRkaoLZ/W6StfvfGwljR1I+HIWp7Ue8ss1yTNiWqYgG+nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341270; c=relaxed/simple;
	bh=5un39WipYhd5C/IiDz/ejM1fr4dDqQJ/rd8BJ5YIENw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B88PNERFLbSSfAt6O1DnoeKOmgu9l6B/eLlUS1rZiW9dz2so09XKtDk/LFPwg2uOHYVrPFNIzE7+1dVYetkukZ4Z3SJuOXBnV6ZOtCPASQXQPoz7TzlRNItFqZpRreJYcrnNbBXXAyYzshqfg+BZLKzYMpJvTFioe6Uuj9ES6J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sS1Gh+tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F99DC433C7;
	Wed,  7 Feb 2024 21:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341270;
	bh=5un39WipYhd5C/IiDz/ejM1fr4dDqQJ/rd8BJ5YIENw=;
	h=From:To:Cc:Subject:Date:From;
	b=sS1Gh+tY1Q9Wk7V8YWOxTaCRoZGgrOwF5YzL2gnjvtc+BL2E5b+jjf68LIqRgj0o7
	 dGwv1iLotVUVUODUJFhjkDvSiShf4tiS6mCsyZrJ5lyOEqOl36QStEVGXwh1zeO1rn
	 Ncf/kOT1/Nm1zwPTh/6bqYmYPlAY/nD+h1TKmnaQ5/nu+KeGV7yiH5YgE3jfWgbX7L
	 oOaQ1BTR/ZWDu03Wgtf71yUOrzGQ3mioAHjRLWxLWUTV7FBD51Z4ebGQBLsFr+FlO/
	 OKhcXq2BkWEvTEb4WWZknT9zJNGtLVvzsuRqrk3BhV2XYmOXbPKTMcT+Idr5IHgZ1E
	 FtPQi5r296itw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/3] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
Date: Wed,  7 Feb 2024 16:27:45 -0500
Message-ID: <20240207212747.4783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index 8875fac9f958..cf034a38e8ba 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1802,6 +1802,9 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return err;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -1809,6 +1812,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


