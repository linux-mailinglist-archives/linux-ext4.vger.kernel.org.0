Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D69403948
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351603AbhIHMAI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 08:00:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9406 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351517AbhIHMAH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Sep 2021 08:00:07 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H4LCf0RMSz8xt2;
        Wed,  8 Sep 2021 19:54:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 8 Sep
 2021 19:58:58 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH 1/3] ext4: check for out-of-order index extents in ext4_valid_extent_entries()
Date:   Wed, 8 Sep 2021 20:08:48 +0800
Message-ID: <20210908120850.4012324-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908120850.4012324-1-yi.zhang@huawei.com>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After commit 5946d089379a ("ext4: check for overlapping extents in
ext4_valid_extent_entries()"), we can check out the overlapping extent
entry in leaf extent blocks. But the out-of-order extent entry in index
extent blocks could also trigger bad things if the filesystem is
inconsistent. So this patch add a check to figure out the out-of-order
index extents and return error.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c0de30f25185..4bb1153c01b3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -357,6 +357,9 @@ static int ext4_valid_extent_entries(struct inode *inode,
 				     ext4_fsblk_t *pblk, int depth)
 {
 	unsigned short entries;
+	ext4_lblk_t lblock = 0;
+	ext4_lblk_t prev = 0;
+
 	if (eh->eh_entries == 0)
 		return 1;
 
@@ -365,31 +368,35 @@ static int ext4_valid_extent_entries(struct inode *inode,
 	if (depth == 0) {
 		/* leaf entries */
 		struct ext4_extent *ext = EXT_FIRST_EXTENT(eh);
-		ext4_lblk_t lblock = 0;
-		ext4_lblk_t prev = 0;
-		int len = 0;
 		while (entries) {
 			if (!ext4_valid_extent(inode, ext))
 				return 0;
 
 			/* Check for overlapping extents */
 			lblock = le32_to_cpu(ext->ee_block);
-			len = ext4_ext_get_actual_len(ext);
 			if ((lblock <= prev) && prev) {
 				*pblk = ext4_ext_pblock(ext);
 				return 0;
 			}
+			prev = lblock + ext4_ext_get_actual_len(ext) - 1;
 			ext++;
 			entries--;
-			prev = lblock + len - 1;
 		}
 	} else {
 		struct ext4_extent_idx *ext_idx = EXT_FIRST_INDEX(eh);
 		while (entries) {
 			if (!ext4_valid_extent_idx(inode, ext_idx))
 				return 0;
+
+			/* Check for overlapping index extents */
+			lblock = le32_to_cpu(ext_idx->ei_block);
+			if ((lblock <= prev) && prev) {
+				*pblk = ext4_idx_pblock(ext_idx);
+				return 0;
+			}
 			ext_idx++;
 			entries--;
+			prev = lblock;
 		}
 	}
 	return 1;
-- 
2.31.1

