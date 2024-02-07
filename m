Return-Path: <linux-ext4+bounces-1150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7384D424
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE391C21919
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E31419A8;
	Wed,  7 Feb 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw1HiN9G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C3512DDAE;
	Wed,  7 Feb 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341022; cv=none; b=qrJ+WauGQR8d60iebYaFxPbLw4hOFMKQUvcyW3eEDFR7t2y7HfAYJwXu24/SiVkL2NEdmFJHLHguWPbodkVIH1Hr55HfRxYX7GJBUwMTRkcm99gdmSZdOW0su4dKW/THjn7RBFFGbRhNuCGC9s61pDulkeIV4dWFYBo0A879jV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341022; c=relaxed/simple;
	bh=n4nwAbfMpZHzNwEnWAhQYeEfEEeu7FNxIeR8dUE+4cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+JU0rrMSnQdUBs3KpasvSDoQrt64bMuX3bvaE9VK1/yRq0H5Gl3dLLeFi2PgtgnXXCu9wDJ4F6S88U+JZFZuMZwMStFNloJbXqex8TN2dozrd3+rWVTXQiSbL2gfcPQWsu3viRz6dVX3SEyEhIGrLLopbSQ7n64kqq56PpUfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw1HiN9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C0EC43390;
	Wed,  7 Feb 2024 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341021;
	bh=n4nwAbfMpZHzNwEnWAhQYeEfEEeu7FNxIeR8dUE+4cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jw1HiN9GCJJE+a+DkdklHjPq2lVXNRuh3QY1c7eVwetrHuhhDbq3Ku6+DuZ+qpI7k
	 WGtTYsFOP3GI4qpNwmYefx/gpQYyC/pN9NOCeLskizTZ1SmRXVZcOaw1UxuEClTo0R
	 k9dXNO0/Y0GzizdOtBkKEdscphyMI5/secqjaLx6HpZLE05HF5sTx133dlqwY41IgN
	 LCDpxAMmgBczzM35eO4TXiFj8QNbimm7ScCdgpj/87n3CxTeEs36A9cRTPpkH+t2c/
	 icZHsjFvUvYv+CkL8fAiJ6SrPyA43kgJlEFNnLOQhrXGWFR8ENhXI8vpnG3/kk3nuI
	 Pwnu1dv4LFDZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/38] ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
Date: Wed,  7 Feb 2024 16:22:48 -0500
Message-ID: <20240207212337.2351-2-sashal@kernel.org>
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
index f74a8f144a66..58d562c16164 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2281,6 +2281,9 @@ void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		return;
 
 	ext4_lock_group(ac->ac_sb, group);
+	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
+		goto out;
+
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
 
 	if (max > 0) {
@@ -2288,6 +2291,7 @@ void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 		ext4_mb_use_best_found(ac, e4b);
 	}
 
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 }
-- 
2.43.0


