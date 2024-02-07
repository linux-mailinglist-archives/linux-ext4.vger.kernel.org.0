Return-Path: <linux-ext4+bounces-1147-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7484D3A4
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BA828DECB
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8424F12AAFE;
	Wed,  7 Feb 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taSd/LeO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C312A16D;
	Wed,  7 Feb 2024 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340909; cv=none; b=kkRa0+njo5s2MC6sD6sGRGmpCr/XA0ZUTz29otfAbR90Y2AFoEL7/RvrDN038KVFoTzZ4H5ccUI/4lJbTvawiid+6DckY/TP22Wvbb9hU9tqDnbSvM7+1GUQeciV/vuxc6lyRXqyzpXnDFj+CMUYIAiQRkTXjsQswIDsLHp1sJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340909; c=relaxed/simple;
	bh=zNNeeW21zAVVN3zs6CyJBitISlt9u9GDw6E3WcrWn3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUWLcdrG03sGwayQtHx5Muey7r1wHiOvaPQR6zfXjo2FoCEGgFYECMT5PhJyXttPZnkmhWf/jMrQd6sH3UFwwxNnyTMP+V1MUi3dfcdumxxuUEhcOrBdUSTd7IHDDkVRk19m3joLDsTxMTNXxY47+IRzEGF//gEPOOY07qoYr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taSd/LeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F259C433F1;
	Wed,  7 Feb 2024 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340908;
	bh=zNNeeW21zAVVN3zs6CyJBitISlt9u9GDw6E3WcrWn3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=taSd/LeOOMgXVnilrBzW6DWIYWY71yqPjNUNsgJfG3sL0Q6gfI9rFaI3Y4lwmaje5
	 P9x0Sm9X3cpRGg7apHBytiOpmK4Kl+U4m3sWM++XK6Rdnca46a6ID+ND8fhplL1i0t
	 ZfYp13beWDU4juD3ctHJD0pWj4d463u/LDhMGqER7oZ6wjMbOtU0p3j0dGF91xh73H
	 zoG44D80qV2NkTtpXrEZTlRcWUqnj55QDQkpi5mb4nEjcNcgC7ESizEYmwMKFY8aM0
	 UGdWRwaJc+lT6czdSauscanp6UqctQkq3lD/d73yWXMTPde8yKjgILLEhWSHVEiqxp
	 PgmGQ1R69QeEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 03/44] ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
Date: Wed,  7 Feb 2024 16:20:30 -0500
Message-ID: <20240207212142.1399-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 2541647ba5dd..7db1cabb672c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2319,12 +2319,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
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
@@ -2357,6 +2355,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


