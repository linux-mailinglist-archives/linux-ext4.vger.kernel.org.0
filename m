Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9064C8A3A
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 12:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiCALCW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Mar 2022 06:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiCALCV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Mar 2022 06:02:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18C8C7D4
        for <linux-ext4@vger.kernel.org>; Tue,  1 Mar 2022 03:01:39 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K7Dm52dVmzBrKF;
        Tue,  1 Mar 2022 18:59:49 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Mar
 2022 19:01:37 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3] ext4: fix underflow in ext4_max_bitmap_size()
Date:   Tue, 1 Mar 2022 19:17:04 +0800
Message-ID: <20220301111704.2153829-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

when ext4 filesystem is created with 64k block size, ^extent and
^huge_file features. the upper_limit would underflow during the
computations in ext4_max_bitmap_size(). The problem is the size of block
index tree for such large block size is more than i_blocks can carry.
So fix the computation to count with this possibility. After this fix,
the 'res' cannot overflow loff_t on the extreme case of filesystem with
huge_files and 64K block size, so this patch also revert commit
75ca6ad408f4 ("ext4: fix loff_t overflow in ext4_max_bitmap_size()").

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v3->v2: rewrite change log and use ppb to compute 'res' blocks.
v2->v1: use DIV_ROUND_UP_ULL instead of DIV_ROUND_UP.

 fs/ext4/super.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5021ca0a28a..bfba62206a14 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3468,8 +3468,9 @@ static loff_t ext4_max_size(int blkbits, int has_huge_files)
  */
 static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
 {
-	unsigned long long upper_limit, res = EXT4_NDIR_BLOCKS;
+	loff_t upper_limit, res = EXT4_NDIR_BLOCKS;
 	int meta_blocks;
+	unsigned int ppb = 1 << (bits - 2);
 
 	/*
 	 * This is calculated to be the largest file size for a dense, block
@@ -3501,27 +3502,42 @@ static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
 
 	}
 
+	/* Compute how many blocks we can address by block tree */
+	res += ppb;
+	res += ppb * ppb;
+	res += ((loff_t)ppb) * ppb * ppb;
+	/* Compute how many metadata blocks are needed */
+	meta_blocks = 1;
+	meta_blocks += 1 + ppb;
+	meta_blocks += 1 + ppb + ppb * ppb;
+	/* Does block tree limit file size? */
+	if (res + meta_blocks <= upper_limit)
+		goto check_lfs;
+
+	res = upper_limit;
+	/* How many metadata blocks are needed for addressing upper_limit? */
+	upper_limit -= EXT4_NDIR_BLOCKS;
 	/* indirect blocks */
 	meta_blocks = 1;
+	upper_limit -= ppb;
 	/* double indirect blocks */
-	meta_blocks += 1 + (1LL << (bits-2));
-	/* tripple indirect blocks */
-	meta_blocks += 1 + (1LL << (bits-2)) + (1LL << (2*(bits-2)));
-
-	upper_limit -= meta_blocks;
-	upper_limit <<= bits;
-
-	res += 1LL << (bits-2);
-	res += 1LL << (2*(bits-2));
-	res += 1LL << (3*(bits-2));
+	if (upper_limit < ppb * ppb) {
+		meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb);
+		res -= meta_blocks;
+		goto check_lfs;
+	}
+	meta_blocks += 1 + ppb;
+	upper_limit -= ppb * ppb;
+	/* tripple indirect blocks for the rest */
+	meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb) +
+		DIV_ROUND_UP_ULL(upper_limit, ppb*ppb);
+	res -= meta_blocks;
+check_lfs:
 	res <<= bits;
-	if (res > upper_limit)
-		res = upper_limit;
-
 	if (res > MAX_LFS_FILESIZE)
 		res = MAX_LFS_FILESIZE;
 
-	return (loff_t)res;
+	return res;
 }
 
 static ext4_fsblk_t descriptor_loc(struct super_block *sb,
-- 
2.31.1

