Return-Path: <linux-ext4+bounces-3163-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCA292C99C
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E320D1C2365A
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1584A28;
	Wed, 10 Jul 2024 04:09:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE25BAF0;
	Wed, 10 Jul 2024 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584560; cv=none; b=h7jTJTwLcmiU1TlF/5729j0GUUiKmGqsyvHxkUGMmnkYjf8qy14K06tI8VvfQUep5ninGZg4sJm4+ybzNgMU5kl3bHer0Rh5pGPBAh8x6SJHmEGXIE2eSv3UAOD+jTOVggmx8OTMEv2H7DTOz7OxI1zfP3A6CHn6GB+2gHfzhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584560; c=relaxed/simple;
	bh=lTT4gpcxKhfKcPamxYQl7cDONxRudh3LR6kF5uPuq48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7CvCgy/74gLO1d0Y6TFPNARIJLcJcnrm4t5amxSm2QnLq2Ag9zb7s69OsUz9XJFgdpjoCT6CpVMwXA4MpV8PI71vc18h8tUR+i2YxTtWZYm2xDuN9URMChiemcYotVVSHos1Ktrykjeplud5xRV54ghLx23pDV3VXX83SABEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJkrF4Bxdz4f3kpB;
	Wed, 10 Jul 2024 12:09:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 38E9C1A0D10;
	Wed, 10 Jul 2024 12:09:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S15;
	Wed, 10 Jul 2024 12:09:09 +0800 (CST)
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
Subject: [PATCH 11/20] ext4: get rid of ppath in ext4_ext_insert_extent()
Date: Wed, 10 Jul 2024 12:06:45 +0800
Message-Id: <20240710040654.1714672-12-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S15
X-Coremail-Antispam: 1UD129KBjvJXoW3tr48Ww4UZrWktw45urWDCFg_yoWDAFW7pF
	ZakF1kCr1YqanruFZ7Xa1UZr1a9a15G3yUGrWfG34FkFy2qF1FgFyft3WYvFW5WFW8Wa4a
	vFWrt34UGa47KaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUYGYpUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAABV1jkH7IJwAAs4

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
---
 fs/ext4/ext4.h        |  7 ++--
 fs/ext4/extents.c     | 88 ++++++++++++++++++++++++-------------------
 fs/ext4/fast_commit.c |  8 ++--
 fs/ext4/migrate.c     |  5 ++-
 4 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cbe8d6062c52..53b4c1f454e6 100644
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
index 0d6ce9e74b01..fc75390d591a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1974,16 +1974,15 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
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
 
@@ -1991,14 +1990,16 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
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
@@ -2036,7 +2037,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 			err = ext4_ext_get_access(handle, inode,
 						  path + depth);
 			if (err)
-				return err;
+				goto errout;
 			unwritten = ext4_ext_is_unwritten(ex);
 			ex->ee_len = cpu_to_le16(ext4_ext_get_actual_len(ex)
 					+ ext4_ext_get_actual_len(newext));
@@ -2061,7 +2062,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 			err = ext4_ext_get_access(handle, inode,
 						  path + depth);
 			if (err)
-				return err;
+				goto errout;
 
 			unwritten = ext4_ext_is_unwritten(ex);
 			ex->ee_block = newext->ee_block;
@@ -2086,21 +2087,26 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
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
@@ -2111,12 +2117,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
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
 
@@ -2125,7 +2127,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 
 	err = ext4_ext_get_access(handle, inode, path + depth);
 	if (err)
-		goto cleanup;
+		goto errout;
 
 	if (!nearex) {
 		/* there is no extent in this leaf, create first one */
@@ -2183,17 +2185,20 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
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
@@ -3248,24 +3253,29 @@ static int ext4_split_extent_at(handle_t *handle,
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
@@ -3324,7 +3334,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 out:
-	ext4_ext_show_leaf(inode, *ppath);
+	ext4_ext_show_leaf(inode, path);
 	return err;
 }
 
@@ -4313,6 +4323,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
+		err = 0;
 		goto got_allocated_blocks;
 	}
 
@@ -4385,8 +4396,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
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
index 87c009e0c59a..1dee40477727 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1777,12 +1777,12 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
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


