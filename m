Return-Path: <linux-ext4+bounces-3857-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D995AB1B
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE555286A93
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6816A94A;
	Thu, 22 Aug 2024 02:40:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2A3BBCF;
	Thu, 22 Aug 2024 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294445; cv=none; b=GYOk78BySMHtAfKNXTikdUKyLGJyFjRCOC2yyZT2/W1lFPaaxEfnOTvgRrTNO0X+oO3wGgsVcTS5oe/ab5Xa66AQ8/f8iefzHqwubq2+FI0izNcbdZ6V6gwHBM30EjjANKe5rt9fP1/fOJa6pDqhK+wQY9Bg2OAYyE8XFiUXYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294445; c=relaxed/simple;
	bh=uyZ3FYr7ZoBhS407YrkIj8yFJgcL6li6gnYnpZPBzuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gq9D2r/ZvcfCwnBVlR7Jgc0wvIJSFKI+30lrnMiuObKvZSlyvcfPP0FxCmIeqcZMdPkE6OzcinKtgc8Mdmww/+3875suCcI270QHd2mpdM2lB+Ygc+1cXQqRuvC8Jgvf0RHnOV0iAzm5R0CYNjkPZxa9rLnzEgzk7mNupCI1ims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r74YGJz4f3jsL;
	Thu, 22 Aug 2024 10:40:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D635A1A1122;
	Thu, 22 Aug 2024 10:40:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S18;
	Thu, 22 Aug 2024 10:40:37 +0800 (CST)
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
Subject: [PATCH v2 14/25] ext4: get rid of ppath in ext4_ext_insert_extent()
Date: Thu, 22 Aug 2024 10:35:34 +0800
Message-Id: <20240822023545.1994557-15-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S18
X-Coremail-Antispam: 1UD129KBjvJXoW3tr48WF45Ar18Jr4DJr4fXwb_yoWDCw4kpF
	ZakF1kCr15ta9ruFZ7Xa1UZr1a9a15G3yUGrWfG34FkFy2qF1FgFyft3WYvFW5WFW8Wa4a
	vFWrt34UGa47KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DdwADsI

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_ext_insert_extent(), the following is done
here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.
 * Free path when npath is used, free npath when it is not used.
 * The got_allocated_blocks label in ext4_ext_map_blocks() does not
   update err now, so err is updated to 0 if the err returned by
   ext4_ext_search_right() is greater than 0 and is about to enter
   got_allocated_blocks.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h        |  7 ++--
 fs/ext4/extents.c     | 88 ++++++++++++++++++++++++-------------------
 fs/ext4/fast_commit.c |  8 ++--
 fs/ext4/migrate.c     |  5 ++-
 4 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ad3c7532fa72..c51584bc3f8c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3710,9 +3710,10 @@ extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
-extern int ext4_ext_insert_extent(handle_t *, struct inode *,
-				  struct ext4_ext_path **,
-				  struct ext4_extent *, int);
+extern struct ext4_ext_path *ext4_ext_insert_extent(
+				handle_t *handle, struct inode *inode,
+				struct ext4_ext_path *path,
+				struct ext4_extent *newext, int gb_flags);
 extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
 					      struct ext4_ext_path *,
 					      int flags);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a11a5144fd96..2d435062c1d3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1975,16 +1975,15 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
  * inserts requested extent as new one into the tree,
  * creating new leaf in the no-space case.
  */
-int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
-				struct ext4_ext_path **ppath,
-				struct ext4_extent *newext, int gb_flags)
+struct ext4_ext_path *
+ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
+		       struct ext4_ext_path *path,
+		       struct ext4_extent *newext, int gb_flags)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_extent_header *eh;
 	struct ext4_extent *ex, *fex;
 	struct ext4_extent *nearex; /* nearest extent */
-	struct ext4_ext_path *npath = NULL;
-	int depth, len, err;
+	int depth, len, err = 0;
 	ext4_lblk_t next;
 	int mb_flags = 0, unwritten;
 
@@ -1992,14 +1991,16 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		mb_flags |= EXT4_MB_DELALLOC_RESERVED;
 	if (unlikely(ext4_ext_get_actual_len(newext) == 0)) {
 		EXT4_ERROR_INODE(inode, "ext4_ext_get_actual_len(newext) == 0");
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto errout;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
 	eh = path[depth].p_hdr;
 	if (unlikely(path[depth].p_hdr == NULL)) {
 		EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto errout;
 	}
 
 	/* try to insert block into found extent and return */
@@ -2037,7 +2038,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 			err = ext4_ext_get_access(handle, inode,
 						  path + depth);
 			if (err)
-				return err;
+				goto errout;
 			unwritten = ext4_ext_is_unwritten(ex);
 			ex->ee_len = cpu_to_le16(ext4_ext_get_actual_len(ex)
 					+ ext4_ext_get_actual_len(newext));
@@ -2062,7 +2063,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 			err = ext4_ext_get_access(handle, inode,
 						  path + depth);
 			if (err)
-				return err;
+				goto errout;
 
 			unwritten = ext4_ext_is_unwritten(ex);
 			ex->ee_block = newext->ee_block;
@@ -2087,21 +2088,26 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (le32_to_cpu(newext->ee_block) > le32_to_cpu(fex->ee_block))
 		next = ext4_ext_next_leaf_block(path);
 	if (next != EXT_MAX_BLOCKS) {
+		struct ext4_ext_path *npath;
+
 		ext_debug(inode, "next leaf block - %u\n", next);
-		BUG_ON(npath != NULL);
 		npath = ext4_find_extent(inode, next, NULL, gb_flags);
-		if (IS_ERR(npath))
-			return PTR_ERR(npath);
+		if (IS_ERR(npath)) {
+			err = PTR_ERR(npath);
+			goto errout;
+		}
 		BUG_ON(npath->p_depth != path->p_depth);
 		eh = npath[depth].p_hdr;
 		if (le16_to_cpu(eh->eh_entries) < le16_to_cpu(eh->eh_max)) {
 			ext_debug(inode, "next leaf isn't full(%d)\n",
 				  le16_to_cpu(eh->eh_entries));
+			ext4_free_ext_path(path);
 			path = npath;
 			goto has_space;
 		}
 		ext_debug(inode, "next leaf has no free space(%d,%d)\n",
 			  le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
+		ext4_free_ext_path(npath);
 	}
 
 	/*
@@ -2112,12 +2118,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		mb_flags |= EXT4_MB_USE_RESERVED;
 	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
 					path, newext);
-	if (IS_ERR(path)) {
-		*ppath = NULL;
-		err = PTR_ERR(path);
-		goto cleanup;
-	}
-	*ppath = path;
+	if (IS_ERR(path))
+		return path;
 	depth = ext_depth(inode);
 	eh = path[depth].p_hdr;
 
@@ -2126,7 +2128,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 
 	err = ext4_ext_get_access(handle, inode, path + depth);
 	if (err)
-		goto cleanup;
+		goto errout;
 
 	if (!nearex) {
 		/* there is no extent in this leaf, create first one */
@@ -2184,17 +2186,20 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
 		ext4_ext_try_to_merge(handle, inode, path, nearex);
 
-
 	/* time to correct all indexes above */
 	err = ext4_ext_correct_indexes(handle, inode, path);
 	if (err)
-		goto cleanup;
+		goto errout;
 
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
+	if (err)
+		goto errout;
 
-cleanup:
-	ext4_free_ext_path(npath);
-	return err;
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 static int ext4_fill_es_cache_info(struct inode *inode,
@@ -3249,24 +3254,29 @@ static int ext4_split_extent_at(handle_t *handle,
 	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
 		ext4_ext_mark_unwritten(ex2);
 
-	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
+	if (!IS_ERR(path)) {
+		*ppath = path;
 		goto out;
+	}
+	*ppath = NULL;
+	err = PTR_ERR(path);
+	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+		return err;
 
 	/*
-	 * Update path is required because previous ext4_ext_insert_extent()
-	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
-	 * guarantees that ext4_find_extent() will not return -ENOMEM,
-	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
-	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
-	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
+	 * Get a new path to try to zeroout or fix the extent length.
+	 * Using EXT4_EX_NOFAIL guarantees that ext4_find_extent()
+	 * will not return -ENOMEM, otherwise -ENOMEM will cause a
+	 * retry in do_writepages(), and a WARN_ON may be triggered
+	 * in ext4_da_update_reserve_space() due to an incorrect
+	 * ee_len causing the i_reserved_data_blocks exception.
 	 */
-	path = ext4_find_extent(inode, ee_block, *ppath,
+	path = ext4_find_extent(inode, ee_block, NULL,
 				flags | EXT4_EX_NOFAIL);
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		*ppath = NULL;
 		return PTR_ERR(path);
 	}
 	depth = ext_depth(inode);
@@ -3325,7 +3335,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 out:
-	ext4_ext_show_leaf(inode, *ppath);
+	ext4_ext_show_leaf(inode, path);
 	return err;
 }
 
@@ -4314,6 +4324,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
+		err = 0;
 		goto got_allocated_blocks;
 	}
 
@@ -4386,8 +4397,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 	}
 
-	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
-	if (err) {
+	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
+	if (IS_ERR(path)) {
+		err = PTR_ERR(path);
 		if (allocated_clusters) {
 			int fb_flags = 0;
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..52e42cb02f39 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1783,12 +1783,12 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			if (ext4_ext_is_unwritten(ex))
 				ext4_ext_mark_unwritten(&newex);
 			down_write(&EXT4_I(inode)->i_data_sem);
-			ret = ext4_ext_insert_extent(
-				NULL, inode, &path, &newex, 0);
+			path = ext4_ext_insert_extent(NULL, inode,
+						      path, &newex, 0);
 			up_write((&EXT4_I(inode)->i_data_sem));
-			ext4_free_ext_path(path);
-			if (ret)
+			if (IS_ERR(path))
 				goto out;
+			ext4_free_ext_path(path);
 			goto next;
 		}
 
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index d98ac2af8199..0f68b8a14560 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -37,7 +37,6 @@ static int finish_range(handle_t *handle, struct inode *inode,
 	path = ext4_find_extent(inode, lb->first_block, NULL, 0);
 	if (IS_ERR(path)) {
 		retval = PTR_ERR(path);
-		path = NULL;
 		goto err_out;
 	}
 
@@ -53,7 +52,9 @@ static int finish_range(handle_t *handle, struct inode *inode,
 	retval = ext4_datasem_ensure_credits(handle, inode, needed, needed, 0);
 	if (retval < 0)
 		goto err_out;
-	retval = ext4_ext_insert_extent(handle, inode, &path, &newext, 0);
+	path = ext4_ext_insert_extent(handle, inode, path, &newext, 0);
+	if (IS_ERR(path))
+		retval = PTR_ERR(path);
 err_out:
 	up_write((&EXT4_I(inode)->i_data_sem));
 	ext4_free_ext_path(path);
-- 
2.39.2


