Return-Path: <linux-ext4+bounces-1387-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3643D866BF8
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 09:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9151F2414D
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F41CAA2;
	Mon, 26 Feb 2024 08:19:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9B11C6BE;
	Mon, 26 Feb 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935584; cv=none; b=KSpwRVqV8Rwg6lqSYWIqhedlvVp4ewqBV6RgZ//RTGnpkwUYRtS85oV+t9ZInf9tBueJ/GJvyHToNIDpX34DsNgn5pCLDletBkczaBg8PsDT02oEYfgcupD370V0hSlveX6T6yaqklKFMjP3ZEwpNHXcbsm0WIfYV0f0vAbytb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935584; c=relaxed/simple;
	bh=7Cvdv+6m35PKTqou4Ax97tarJ+H1kTTmnj+72Mpfq0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i66LpJCJSHQ/HwvDqByJn2P1AJx0tO4HqIY6TJ76NEgMwueBsdn+qiY2nhy6fIEyrcLYu7jVYgA0p770CHcfWuHC9O+h4ex79T8pO56FX6DIkVnWi/9tsXGya8SfLRJGKCm3dh4Sb85XzmuZwjw5N9jLrZn3fC7MEvBwn7pT3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tjtl71np4z1h0fk;
	Mon, 26 Feb 2024 16:17:23 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 37B2D1A016C;
	Mon, 26 Feb 2024 16:19:36 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:19:35 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH] ext4: remove unused parameter biop in ext4_issue_discard()
Date: Mon, 26 Feb 2024 16:17:31 +0800
Message-ID: <20240226081731.3224470-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)

all caller of ext4_issue_discard() would set biop to NULL since
'commit 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread
contex")', it's unnecessary to keep this parameter any more.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 fs/ext4/mballoc.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d72b5e3c92ec..1590ee3f4603 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3807,8 +3807,7 @@ int ext4_mb_release(struct super_block *sb)
 }
 
 static inline int ext4_issue_discard(struct super_block *sb,
-		ext4_group_t block_group, ext4_grpblk_t cluster, int count,
-		struct bio **biop)
+		ext4_group_t block_group, ext4_grpblk_t cluster, int count)
 {
 	ext4_fsblk_t discard_block;
 
@@ -3817,13 +3816,8 @@ static inline int ext4_issue_discard(struct super_block *sb,
 	count = EXT4_C2B(EXT4_SB(sb), count);
 	trace_ext4_discard_blocks(sb,
 			(unsigned long long) discard_block, count);
-	if (biop) {
-		return __blkdev_issue_discard(sb->s_bdev,
-			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
-			(sector_t)count << (sb->s_blocksize_bits - 9),
-			GFP_NOFS, biop);
-	} else
-		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
+
+	return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
 }
 
 static void ext4_free_data_in_buddy(struct super_block *sb,
@@ -6475,7 +6469,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	} else {
 		if (test_opt(sb, DISCARD)) {
 			err = ext4_issue_discard(sb, block_group, bit,
-						 count_clusters, NULL);
+						 count_clusters);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%u block:%d count:%lu failed"
@@ -6726,7 +6720,7 @@ __acquires(bitlock)
 	 */
 	mb_mark_used(e4b, &ex);
 	ext4_unlock_group(sb, group);
-	ret = ext4_issue_discard(sb, group, start, count, NULL);
+	ret = ext4_issue_discard(sb, group, start, count);
 	ext4_lock_group(sb, group);
 	mb_free_blocks(NULL, e4b, start, ex.fe_len);
 	return ret;
-- 
2.32.0


