Return-Path: <linux-ext4+bounces-3160-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F992C996
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A0E1C23379
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D928287E;
	Wed, 10 Jul 2024 04:09:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EC4BAA6;
	Wed, 10 Jul 2024 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584559; cv=none; b=a9bEmPp7aKAyIiUjLybn9XwyP0RXBMTf8g/W6cYctxlANPs4bsKskepKQ4EJTq2JtcLoPnvxCaCgPECWb+kvxbOxV25DjkGj3/d9qkjwkbBDvqa62nySm27SxdcKQtKkrbs4XGyeZlkhyF/pI724gGkl8dbDwG5W3WWKeFyaOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584559; c=relaxed/simple;
	bh=Dj83D9OXUefnDnSK1/Jq3bZj56hYipewJ2TdXZISs5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KDxzdFm14BUhhVMLS2A9yx9hCDpodTzYPzdgJVNL/XNGJbYxl4q93vxTnJ2KH2/8qi945NelbkHWurbirhN9ZkI/00/i+dfhdMeTJZ16JtXq5ksZb5I4bFH1qnbyPt8hQhT2ryckE5Vwai6cV42ATVcT5JyN4KxGKqobo4ZquOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WJkr82hR5z4f3mJg;
	Wed, 10 Jul 2024 12:08:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 006CE1A0D00;
	Wed, 10 Jul 2024 12:09:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S12;
	Wed, 10 Jul 2024 12:09:07 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 08/20] ext4: get rid of ppath in ext4_find_extent()
Date: Wed, 10 Jul 2024 12:06:42 +0800
Message-Id: <20240710040654.1714672-9-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710040654.1714672-1-libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S12
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4rGw1DGFy5Kr18Kr1Utrb_yoWxKrWDpr
	4qyF1Fgw15XwsF9rZ7Wa17Zr13K3WUJr4UGFWfG3409Fyjqr1FgFyIy3WYyFWYgFW8Wa4a
	yr40yr1UGa47KrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbfcTJUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAABV1jkIPHmgABs1

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

Getting rid of ppath in ext4_find_extent() requires its caller to update
ppath. These ppaths will also be dropped later. No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/extents.c     | 52 +++++++++++++++++++++++--------------------
 fs/ext4/move_extent.c |  6 ++---
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8007abd4972d..cbe8d6062c52 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3714,7 +3714,7 @@ extern int ext4_ext_insert_extent(handle_t *, struct inode *,
 				  struct ext4_ext_path **,
 				  struct ext4_extent *, int);
 extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
-					      struct ext4_ext_path **,
+					      struct ext4_ext_path *,
 					      int flags);
 extern void ext4_free_ext_path(struct ext4_ext_path *);
 extern int ext4_ext_check_inode(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b1cfce5b57d2..5217e6f53467 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -884,11 +884,10 @@ void ext4_ext_tree_init(handle_t *handle, struct inode *inode)
 
 struct ext4_ext_path *
 ext4_find_extent(struct inode *inode, ext4_lblk_t block,
-		 struct ext4_ext_path **orig_path, int flags)
+		 struct ext4_ext_path *path, int flags)
 {
 	struct ext4_extent_header *eh;
 	struct buffer_head *bh;
-	struct ext4_ext_path *path = orig_path ? *orig_path : NULL;
 	short int depth, i, ppos = 0;
 	int ret;
 	gfp_t gfp_flags = GFP_NOFS;
@@ -909,7 +908,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		ext4_ext_drop_refs(path);
 		if (depth > path[0].p_maxdepth) {
 			kfree(path);
-			*orig_path = path = NULL;
+			path = NULL;
 		}
 	}
 	if (!path) {
@@ -964,8 +963,6 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 
 err:
 	ext4_free_ext_path(path);
-	if (orig_path)
-		*orig_path = NULL;
 	return ERR_PTR(ret);
 }
 
@@ -1430,7 +1427,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		/* refill path */
 		path = ext4_find_extent(inode,
 				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    ppath, gb_flags);
+				    path, gb_flags);
 		if (IS_ERR(path))
 			err = PTR_ERR(path);
 	} else {
@@ -1442,7 +1439,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		/* refill path */
 		path = ext4_find_extent(inode,
 				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    ppath, gb_flags);
+				    path, gb_flags);
 		if (IS_ERR(path)) {
 			err = PTR_ERR(path);
 			goto out;
@@ -1458,8 +1455,8 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 			goto repeat;
 		}
 	}
-
 out:
+	*ppath = IS_ERR(path) ? NULL : path;
 	return err;
 }
 
@@ -3260,11 +3257,12 @@ static int ext4_split_extent_at(handle_t *handle,
 	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
 	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
 	 */
-	path = ext4_find_extent(inode, ee_block, ppath,
+	path = ext4_find_extent(inode, ee_block, *ppath,
 				flags | EXT4_EX_NOFAIL);
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
+		*ppath = NULL;
 		return PTR_ERR(path);
 	}
 	depth = ext_depth(inode);
@@ -3379,9 +3377,12 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, ppath, flags);
-	if (IS_ERR(path))
+	path = ext4_find_extent(inode, map->m_lblk, *ppath, flags);
+	if (IS_ERR(path)) {
+		*ppath = NULL;
 		return PTR_ERR(path);
+	}
+	*ppath = path;
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
 	if (!ex) {
@@ -3767,9 +3768,12 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 						 EXT4_GET_BLOCKS_CONVERT);
 		if (err < 0)
 			return err;
-		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
-		if (IS_ERR(path))
+		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
+		if (IS_ERR(path)) {
+			*ppath = NULL;
 			return PTR_ERR(path);
+		}
+		*ppath = path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 	}
@@ -3825,9 +3829,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN);
 		if (err < 0)
 			return err;
-		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
-		if (IS_ERR(path))
+		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
+		if (IS_ERR(path)) {
+			*ppath = NULL;
 			return PTR_ERR(path);
+		}
+		*ppath = path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 		if (!ex) {
@@ -5224,7 +5231,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	* won't be shifted beyond EXT_MAX_BLOCKS.
 	*/
 	if (SHIFT == SHIFT_LEFT) {
-		path = ext4_find_extent(inode, start - 1, &path,
+		path = ext4_find_extent(inode, start - 1, path,
 					EXT4_EX_NOCACHE);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
@@ -5273,7 +5280,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	 * becomes NULL to indicate the end of the loop.
 	 */
 	while (iterator && start <= stop) {
-		path = ext4_find_extent(inode, *iterator, &path,
+		path = ext4_find_extent(inode, *iterator, path,
 					EXT4_EX_NOCACHE);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
@@ -5854,11 +5861,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 
 	/* search for the extent closest to the first block in the cluster */
 	path = ext4_find_extent(inode, EXT4_C2B(sbi, lclu), NULL, 0);
-	if (IS_ERR(path)) {
-		err = PTR_ERR(path);
-		path = NULL;
-		goto out;
-	}
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 
 	depth = ext_depth(inode);
 
@@ -5942,7 +5946,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 		if (ret)
 			goto out;
 
-		path = ext4_find_extent(inode, start, &path, 0);
+		path = ext4_find_extent(inode, start, path, 0);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
 		ex = path[path->p_depth].p_ext;
@@ -5956,7 +5960,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 			if (ret)
 				goto out;
 
-			path = ext4_find_extent(inode, start, &path, 0);
+			path = ext4_find_extent(inode, start, path, 0);
 			if (IS_ERR(path))
 				return PTR_ERR(path);
 			ex = path[path->p_depth].p_ext;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 204f53b23622..b0ab19a913bf 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -26,14 +26,14 @@ static inline int
 get_ext_path(struct inode *inode, ext4_lblk_t lblock,
 		struct ext4_ext_path **ppath)
 {
-	struct ext4_ext_path *path;
+	struct ext4_ext_path *path = *ppath;
 
-	path = ext4_find_extent(inode, lblock, ppath, EXT4_EX_NOCACHE);
+	*ppath = NULL;
+	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	if (path[ext_depth(inode)].p_ext == NULL) {
 		ext4_free_ext_path(path);
-		*ppath = NULL;
 		return -ENODATA;
 	}
 	*ppath = path;
-- 
2.39.2


