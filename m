Return-Path: <linux-ext4+bounces-1165-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933984D544
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 23:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5EB1C24F56
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E25613666E;
	Wed,  7 Feb 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm3A1jZm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB1144B51;
	Wed,  7 Feb 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341257; cv=none; b=Olx1wQIIq4cGxFgPG8W1wanXfsiTmogfiofWm5WyvvYhpKfGXOHzbqPAmVtprP34VkF8mo7W0e6tMjsXMW0DZibsGKmIyuCQ82OuU/o8WbB6/O3ebXmxCQNirdBbu03zrL6/ZtcuJU7KEwTAQP1IBzascPdgkjtcO9Ftm9kmIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341257; c=relaxed/simple;
	bh=fMax8Mbznl3cS82Uj8tLcORi2Ov0a6y+a85D2OklQUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAwJIEVI4K2qnUghi7xyp75z6XyCaGTQSD5wBXtNw7YDSHSh1tpECsx26M2AAkE+90oo5mppizl7lmN9eeZnZVjH9SWiw5uSwmth2ogxNqNkZiVBq/YhQS0a6KuerXkBvc7tRObwbrJqYaiuG9MPcIwtQP+FFbqXXhEiG+5ceQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm3A1jZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D943EC433F1;
	Wed,  7 Feb 2024 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341256;
	bh=fMax8Mbznl3cS82Uj8tLcORi2Ov0a6y+a85D2OklQUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qm3A1jZm1/s42GkFk/uLpDYSy6pU+tVybIGcGXuLZwhDoDd6416p26xFB/bIpB2NL
	 jemPNROiiHpBO/2Tgq1f0FR/NhsZRkC/R2F/M+pCct/Ula9hi8D8QLfcsvirlJiph0
	 BhCbPbBKZK1Hp7CbOTUr90vWf0xLQeoqaYTKvLlMrlhByzJzPaGYPF5tnCAB1D7My3
	 86X/vrjUSFQBTo8brWtG76Cf8R+Xq7qot6+q83E7jUMT4U9SMn0e+KRL6PP6hS/OkO
	 abcqEOFW+18lXV9AUAdAEizWJthVl+QVSfr7sm0KVnkYAUwm3sqPoKqPH7SpTMXbNr
	 H9fs193RwJMjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/7] ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
Date: Wed,  7 Feb 2024 16:27:26 -0500
Message-ID: <20240207212732.4627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212732.4627-1-sashal@kernel.org>
References: <20240207212732.4627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index c1af95898aa4..3acc76b1ac91 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1839,12 +1839,10 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
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
@@ -1877,6 +1875,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 		ac->ac_b_ex = ex;
 		ext4_mb_use_best_found(ac, e4b);
 	}
+out:
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
 
-- 
2.43.0


