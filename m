Return-Path: <linux-ext4+bounces-817-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FED82E76F
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 02:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA71A1F23204
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 01:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884A03FB27;
	Tue, 16 Jan 2024 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbT5OxFx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1752C3FB02;
	Tue, 16 Jan 2024 01:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BA2C433C7;
	Tue, 16 Jan 2024 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367313;
	bh=kgtaoDU5q++tSm21oc65+wt7bIqT+7Khy0PkNdWp0Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbT5OxFxp+PB7Rh7P1yumE2aD368WHa+Z4oC0TaGdQ0bCWxzR8p/4JnYd6zG/26wz
	 +CTCdcJrVkExGcWim0w/s0LC6qYmBJrvDW4qSSKw1nVMg8r37KstjWboCJG2xerUp9
	 15CPC7Or6XMdB4GVcXXOIuTXfk1/zhIX+qXQ4wguKVpe1nyhs7e2+xPk4/XqkK49Ew
	 H/dK1TtreVwmRb5J9HvE59VmHtsu+5Azkh8LlImpCf3IwGoM9at8klkCmo11prNpnj
	 JJJ+aOLfDpRQQJBH5mxAZL7DaHZBhZozUYj+2gvYlJ1cvt0Lo92EnFqzWPywCgq0DK
	 WLIlfGmCjtZ6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 6/9] ext4: fix inconsistent between segment fstrim and full fstrim
Date: Mon, 15 Jan 2024 20:08:12 -0500
Message-ID: <20240116010819.219701-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010819.219701-1-sashal@kernel.org>
References: <20240116010819.219701-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 68da4c44b994aea797eb9821acb3a4a36015293e ]

Suppose we issue two FITRIM ioctls for ranges [0,15] and [16,31] with
mininum length of trimmed range set to 8 blocks. If we have say a range of
blocks 10-22 free, this range will not be trimmed because it straddles the
boundary of the two FITRIM ranges and neither part is big enough. This is a
bit surprising to some users that call FITRIM on smaller ranges of blocks
to limit impact on the system. Also XFS trims all free space extents that
overlap with the specified range so we are inconsistent among filesystems.
Let's change ext4_try_to_trim_range() to consider for trimming the whole
free space extent that straddles the end of specified range, not just the
part of it within the range.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231216010919.1995851-1-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9e5aa625ab30..36e6e3de6c9c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5211,13 +5211,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count, free_count, last, origin_start;
 	bool set_trimmed = false;
 	void *bitmap;
 
+	last = ext4_last_grp_cluster(sb, e4b->bd_group);
 	bitmap = e4b->bd_bitmap;
-	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+	if (start == 0 && max >= last)
 		set_trimmed = true;
+	origin_start = start;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
@@ -5226,7 +5228,10 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
 			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		next = mb_find_next_bit(bitmap, last + 1, start);
+		if (origin_start == 0 && next >= last)
+			set_trimmed = true;
 
 		if ((next - start) >= minblocks) {
 			int ret = ext4_trim_extent(sb, start, next - start, e4b);
-- 
2.43.0


