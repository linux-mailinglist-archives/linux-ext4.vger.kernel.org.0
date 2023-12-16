Return-Path: <linux-ext4+bounces-475-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87378155D1
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Dec 2023 02:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72855286952
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Dec 2023 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B49110E;
	Sat, 16 Dec 2023 01:05:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1710F1;
	Sat, 16 Dec 2023 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4SsSZK5xLpz2mGxd;
	Sat, 16 Dec 2023 09:05:45 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id E2B7E180027;
	Sat, 16 Dec 2023 09:05:50 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 16 Dec
 2023 09:05:50 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>, Ye Bin
	<yebin10@huawei.com>
Subject: [PATCH v2] ext4: fix inconsistent between segment fstrim and full fstrim
Date: Sat, 16 Dec 2023 09:09:19 +0800
Message-ID: <20231216010919.1995851-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)

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
---
 fs/ext4/mballoc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d72b5e3c92ec..d195461123d8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6753,13 +6753,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
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
@@ -6768,7 +6770,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
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
2.31.1


