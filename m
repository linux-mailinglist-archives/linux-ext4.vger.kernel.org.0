Return-Path: <linux-ext4+bounces-1153-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717484D47F
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0801C21572
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBE315409E;
	Wed,  7 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaqvFf4/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AD13341F;
	Wed,  7 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341108; cv=none; b=tAdQCpLX0O5O2uv3idCgRl2zNKLVwiHg6+9l39SIx68AYjhWlBhfhJnqXYA4RvW4l86+dX+94Gks0HO6JQjnT39u52YIXbzkHeYUBEiPkQFXf34mU7K1RhmSI1CxbAH1nvtss0jT6XdqcQKD3VkCYirFFpGQ1ic81yekf6Sy3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341108; c=relaxed/simple;
	bh=g7u/qMn62pEOd+LB48m+zlQpkYBe2bD/cvBPLtjxmu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQxCHXT2da9RAaWGsoAmfP8IwI9hqGXbyrss1DMBf29QVPBa8T/T8cC9pqOYwcpRUbMDnHSRDlS9VdOUccvVpBSNvJHS0LC9WM5Y049Vw+2MFvwrRtqeSrLL43vwsE0fcVM/K0+wOd4y/CNqORHGOtogGE3ogAUaPgdPT3jk9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaqvFf4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141E8C433F1;
	Wed,  7 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341108;
	bh=g7u/qMn62pEOd+LB48m+zlQpkYBe2bD/cvBPLtjxmu4=;
	h=From:To:Cc:Subject:Date:From;
	b=aaqvFf4/gI5ufx92FdftOjUMk/zxw4VTEan4bSJg90Yg5YcF4qpaUmsahym6jdQmX
	 /4bvf5/oe6xgYXZton1ShuJtZbrDgqSZqeeckQYSxh777Y7B0GtKaQtOUowoi6FqIf
	 WWZMy6bELRDQcBpNR6n+6b+H3oJgB0hVvclIcRmhcUEa//6uetTku/OYDjBodU4YnF
	 Kr5xlPLXBoy2vKRlStEjQPSXarFT6qzMWj71YGUJ61SFX48VQ0AQRnZZ7yDyft2FR4
	 32xja9RzZLi+YIKX1k0zmNgw7myP9LW4m2vl15t0FIycO2KzllwV0ReX38ys53rZUq
	 Ebt8MRUGiGvEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/29] ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
Date: Wed,  7 Feb 2024 16:24:26 -0500
Message-ID: <20240207212505.3169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

[ Upstream commit 993bf0f4c393b3667830918f9247438a8f6fdb5b ]

Determine if bb_fragments is 0 instead of determining bb_free to eliminate
the risk of dividing by zero when the block bitmap is corrupted.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240104142040.2835097-6-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 33be702d6e38..779555925029 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -831,7 +831,7 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int new_order;
 
-	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
+	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_fragments == 0)
 		return;
 
 	new_order = mb_avg_fragment_size_order(sb,
-- 
2.43.0


