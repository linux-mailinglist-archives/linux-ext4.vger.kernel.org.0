Return-Path: <linux-ext4+bounces-3852-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B41795AB14
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0218D1F24FB8
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2649513BC38;
	Thu, 22 Aug 2024 02:40:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097F41C63;
	Thu, 22 Aug 2024 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294443; cv=none; b=TrDYOsH4B2JV17Ng4bdNkoPA8mAiVz1hZgnf6uhblD67M3lElSnylKcr+TSCoyZjDtaQv7r2Mfa4XY3vCf0qgvptAZzghjrurr0826CxEl7Lpsgp0TqpXeURUcWlTpde8mUKfRTrauh98t4OePu4O+caf7LIGRh37D+MBewmrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294443; c=relaxed/simple;
	bh=5ld0itvR7vZg3XCAWWtfUNNA/CYROG/YjYJN5PX+b44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IRg1URvh2XpRQf6Td7aWPeRYg3nFnozR6GysSdImiyHn9Lfj9sPaIhNaSKXhdITP3MWBL/+gkcIpTodfXzJL1cswQwPzseu5yB1dv7JyIq7qqtGxkf1y8UQjIr+EYhO+FqVjc4rOAUN3UcL9nistIEfyyY+77IXfyKga6qeDvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r8132hz4f3jXg;
	Thu, 22 Aug 2024 10:40:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5AB301A0568;
	Thu, 22 Aug 2024 10:40:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S19;
	Thu, 22 Aug 2024 10:40:38 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 15/25] ext4: get rid of ppath in ext4_split_extent_at()
Date: Thu, 22 Aug 2024 10:35:35 +0800
Message-Id: <20240822023545.1994557-16-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822023545.1994557-1-libaokun@huaweicloud.com>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S19
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47Gry8CrWrGw45ur13CFg_yoWxAw4xpr
	sI9F18Grn8GasF9rWxJanrZr1a9a1UG3yUGFW7G3sYk3WjqryYgF1xta45tFW5KFW8Wa43
	Ar4Fyry5Wa47J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYl19UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEHQAAsD

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_split_extent_at(), the following is done
here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.
 * Teach ext4_ext_show_leaf() to skip error pointer.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 85 ++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2d435062c1d3..cf4ce3304780 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -84,12 +84,11 @@ static void ext4_extent_block_csum_set(struct inode *inode,
 	et->et_checksum = ext4_extent_block_csum(inode, eh);
 }
 
-static int ext4_split_extent_at(handle_t *handle,
-			     struct inode *inode,
-			     struct ext4_ext_path **ppath,
-			     ext4_lblk_t split,
-			     int split_flag,
-			     int flags);
+static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
+						  struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t split,
+						  int split_flag, int flags);
 
 static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 {
@@ -341,9 +340,15 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 	if (nofail)
 		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
-	return ext4_split_extent_at(handle, inode, ppath, lblk, unwritten ?
+	path = ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
 			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
 			flags);
+	if (IS_ERR(path)) {
+		*ppath = NULL;
+		return PTR_ERR(path);
+	}
+	*ppath = path;
+	return 0;
 }
 
 static int
@@ -694,7 +699,7 @@ static void ext4_ext_show_leaf(struct inode *inode, struct ext4_ext_path *path)
 	struct ext4_extent *ex;
 	int i;
 
-	if (!path)
+	if (IS_ERR_OR_NULL(path))
 		return;
 
 	eh = path[depth].p_hdr;
@@ -3175,16 +3180,14 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
  *  a> the extent are splitted into two extent.
  *  b> split is not needed, and just mark the extent.
  *
- * return 0 on success.
+ * Return an extent path pointer on success, or an error pointer on failure.
  */
-static int ext4_split_extent_at(handle_t *handle,
-			     struct inode *inode,
-			     struct ext4_ext_path **ppath,
-			     ext4_lblk_t split,
-			     int split_flag,
-			     int flags)
+static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
+						  struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t split,
+						  int split_flag, int flags)
 {
-	struct ext4_ext_path *path = *ppath;
 	ext4_fsblk_t newblock;
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex, newex, orig_ex, zero_ex;
@@ -3255,14 +3258,12 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
-	if (!IS_ERR(path)) {
-		*ppath = path;
+	if (!IS_ERR(path))
 		goto out;
-	}
-	*ppath = NULL;
+
 	err = PTR_ERR(path);
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
-		return err;
+		return path;
 
 	/*
 	 * Get a new path to try to zeroout or fix the extent length.
@@ -3272,16 +3273,14 @@ static int ext4_split_extent_at(handle_t *handle,
 	 * in ext4_da_update_reserve_space() due to an incorrect
 	 * ee_len causing the i_reserved_data_blocks exception.
 	 */
-	path = ext4_find_extent(inode, ee_block, NULL,
-				flags | EXT4_EX_NOFAIL);
+	path = ext4_find_extent(inode, ee_block, NULL, flags | EXT4_EX_NOFAIL);
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		return PTR_ERR(path);
+		return path;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
-	*ppath = path;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
@@ -3333,10 +3332,13 @@ static int ext4_split_extent_at(handle_t *handle,
 	 * and err is a non-zero error code.
 	 */
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
-	return err;
 out:
+	if (err) {
+		ext4_free_ext_path(path);
+		path = ERR_PTR(err);
+	}
 	ext4_ext_show_leaf(inode, path);
-	return err;
+	return path;
 }
 
 /*
@@ -3380,10 +3382,14 @@ static int ext4_split_extent(handle_t *handle,
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
 			split_flag1 |= EXT4_EXT_DATA_VALID1;
-		err = ext4_split_extent_at(handle, inode, ppath,
+		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
-		if (err)
+		if (IS_ERR(path)) {
+			err = PTR_ERR(path);
+			*ppath = NULL;
 			goto out;
+		}
+		*ppath = path;
 	} else {
 		allocated = ee_len - (map->m_lblk - ee_block);
 	}
@@ -3391,7 +3397,7 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, *ppath, flags);
+	path = ext4_find_extent(inode, map->m_lblk, path, flags);
 	if (IS_ERR(path)) {
 		*ppath = NULL;
 		return PTR_ERR(path);
@@ -3413,13 +3419,17 @@ static int ext4_split_extent(handle_t *handle,
 			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
 						     EXT4_EXT_MARK_UNWRIT2);
 		}
-		err = ext4_split_extent_at(handle, inode, ppath,
+		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk, split_flag1, flags);
-		if (err)
+		if (IS_ERR(path)) {
+			err = PTR_ERR(path);
+			*ppath = NULL;
 			goto out;
+		}
+		*ppath = path;
 	}
 
-	ext4_ext_show_leaf(inode, *ppath);
+	ext4_ext_show_leaf(inode, path);
 out:
 	return err ? err : allocated;
 }
@@ -5616,22 +5626,21 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 			if (ext4_ext_is_unwritten(extent))
 				split_flag = EXT4_EXT_MARK_UNWRIT1 |
 					EXT4_EXT_MARK_UNWRIT2;
-			ret = ext4_split_extent_at(handle, inode, &path,
+			path = ext4_split_extent_at(handle, inode, path,
 					offset_lblk, split_flag,
 					EXT4_EX_NOCACHE |
 					EXT4_GET_BLOCKS_PRE_IO |
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
 		}
 
-		ext4_free_ext_path(path);
-		if (ret < 0) {
+		if (IS_ERR(path)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
+			ret = PTR_ERR(path);
 			goto out_stop;
 		}
-	} else {
-		ext4_free_ext_path(path);
 	}
 
+	ext4_free_ext_path(path);
 	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
 
 	/*
-- 
2.39.2


