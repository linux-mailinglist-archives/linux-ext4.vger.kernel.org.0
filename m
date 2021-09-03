Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246993FFA4E
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 08:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346196AbhICGSp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 02:18:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19005 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344368AbhICGSo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 02:18:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H16tf1kFqzbl9Y;
        Fri,  3 Sep 2021 14:13:46 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 14:17:42 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 3 Sep 2021 14:17:42 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 2/3] ext4: ensure enough credits in ext4_ext_shift_path_extents
Date:   Fri, 3 Sep 2021 14:27:47 +0800
Message-ID: <20210903062748.4118886-3-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903062748.4118886-1-yangerkun@huawei.com>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Like ext4_ext_rm_leaf, we can ensure enough credits before every call
that will consume credits. This can remove ext4_access_path which only
used in ext4_ext_shift_path_extents. It's a prepare patch for the next
bugfix patch.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/extents.c | 49 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 7ae32078b48f..a6fb0350f062 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4974,36 +4974,6 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return ext4_fill_es_cache_info(inode, start_blk, len_blks, fieinfo);
 }
 
-/*
- * ext4_access_path:
- * Function to access the path buffer for marking it dirty.
- * It also checks if there are sufficient credits left in the journal handle
- * to update path.
- */
-static int
-ext4_access_path(handle_t *handle, struct inode *inode,
-		struct ext4_ext_path *path)
-{
-	int credits, err;
-
-	if (!ext4_handle_valid(handle))
-		return 0;
-
-	/*
-	 * Check if need to extend journal credits
-	 * 3 for leaf, sb, and inode plus 2 (bmap and group
-	 * descriptor) for each block group; assume two block
-	 * groups
-	 */
-	credits = ext4_writepage_trans_blocks(inode);
-	err = ext4_datasem_ensure_credits(handle, inode, 7, credits, 0);
-	if (err < 0)
-		return err;
-
-	err = ext4_ext_get_access(handle, inode, path);
-	return err;
-}
-
 /*
  * ext4_ext_shift_path_extents:
  * Shift the extents of a path structure lying between path[depth].p_ext
@@ -5018,6 +4988,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 	int depth, err = 0;
 	struct ext4_extent *ex_start, *ex_last;
 	bool update = false;
+	int credits, restart_credits;
 	depth = path->p_depth;
 
 	while (depth >= 0) {
@@ -5027,13 +4998,23 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 				return -EFSCORRUPTED;
 
 			ex_last = EXT_LAST_EXTENT(path[depth].p_hdr);
+			/* leaf + sb + inode */
+			credits = 3;
+			if (ex_start == EXT_FIRST_EXTENT(path[depth].p_hdr)) {
+				update = true;
+				/* extent tree + sb + inode */
+				credits = depth + 2;
+			}
 
-			err = ext4_access_path(handle, inode, path + depth);
+			restart_credits = ext4_writepage_trans_blocks(inode);
+			err = ext4_datasem_ensure_credits(handle, inode, credits,
+					restart_credits, 0);
 			if (err)
 				goto out;
 
-			if (ex_start == EXT_FIRST_EXTENT(path[depth].p_hdr))
-				update = true;
+			err = ext4_ext_get_access(handle, inode, path + depth);
+			if (err)
+				goto out;
 
 			while (ex_start <= ex_last) {
 				if (SHIFT == SHIFT_LEFT) {
@@ -5064,7 +5045,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 		}
 
 		/* Update index too */
-		err = ext4_access_path(handle, inode, path + depth);
+		err = ext4_ext_get_access(handle, inode, path + depth);
 		if (err)
 			goto out;
 
-- 
2.31.1

