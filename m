Return-Path: <linux-ext4+bounces-3848-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71DD95AB0C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBAF1C23092
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FDD56766;
	Thu, 22 Aug 2024 02:40:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E84123749;
	Thu, 22 Aug 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294441; cv=none; b=CvrVMef9bIRXRjfuqGNImyW4JHtpy1vUIDqnwUq6ts5djb0YdOPsLbk0SeHe43BCrAP0C5lOU4bittxBPMYCUkH+NfcZVwRil+lTYaMQdGJU9Nv487GDKTFePN4p1fd9Jdf46BPGIiAO4ApOt3TJOhIIXt2wMr5CY8mjft9aSYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294441; c=relaxed/simple;
	bh=KjoptiB8YFsajfZc1HROqZinW0V3khdk7NU5WSuF2sI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQoQYErBe/6G2nWBKIh4omDH1AXiECy5WyXeNm8igZP/DoogdDCfKzD8DYCYRudhpfleTMrGz9a9Z5TueGW9xWyOyxprSObxxTqF+h9TLZDJEmMMxMICOuZwuuMX90NWKlsJvMHQ7x3l+ZRsa9W9oZ8KN7bHiRo1gE8Ocx20u+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r61f7Hz4f3jsG;
	Thu, 22 Aug 2024 10:40:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6FB951A0359;
	Thu, 22 Aug 2024 10:40:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S15;
	Thu, 22 Aug 2024 10:40:36 +0800 (CST)
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
Subject: [PATCH v2 11/25] ext4: get rid of ppath in ext4_find_extent()
Date: Thu, 22 Aug 2024 10:35:31 +0800
Message-Id: <20240822023545.1994557-12-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S15
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47Gr4xZFWrJF43JFW8Zwb_yoW3XFWDpr
	WDAF1Fgw15XwsF9rZ2ga17Zr13Ka1UGr4UGFWfGryv9Fyqqr1FgFyxt3WYvFW5KFW8Wa4a
	yr40yr1UGa47KrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEGgAAsE

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

Getting rid of ppath in ext4_find_extent() requires its caller to update
ppath. These ppaths will also be dropped later. No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/extents.c     | 55 +++++++++++++++++++++++--------------------
 fs/ext4/move_extent.c |  7 +++---
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c3429b664b8d..ad3c7532fa72 100644
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
index 1c1c7c39ceaa..32d2f9c86ab2 100644
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
@@ -960,14 +959,10 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 
 	ext4_ext_show_path(inode, path);
 
-	if (orig_path)
-		*orig_path = path;
 	return path;
 
 err:
 	ext4_free_ext_path(path);
-	if (orig_path)
-		*orig_path = NULL;
 	return ERR_PTR(ret);
 }
 
@@ -1432,7 +1427,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		/* refill path */
 		path = ext4_find_extent(inode,
 				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    ppath, gb_flags);
+				    path, gb_flags);
 		if (IS_ERR(path))
 			err = PTR_ERR(path);
 	} else {
@@ -1444,7 +1439,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		/* refill path */
 		path = ext4_find_extent(inode,
 				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    ppath, gb_flags);
+				    path, gb_flags);
 		if (IS_ERR(path)) {
 			err = PTR_ERR(path);
 			goto out;
@@ -1460,8 +1455,8 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 			goto repeat;
 		}
 	}
-
 out:
+	*ppath = IS_ERR(path) ? NULL : path;
 	return err;
 }
 
@@ -3263,15 +3258,17 @@ static int ext4_split_extent_at(handle_t *handle,
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
 	ex = path[depth].p_ext;
+	*ppath = path;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
@@ -3381,9 +3378,12 @@ static int ext4_split_extent(handle_t *handle,
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
@@ -3769,9 +3769,12 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
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
@@ -3827,9 +3830,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
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
@@ -5226,7 +5232,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	* won't be shifted beyond EXT_MAX_BLOCKS.
 	*/
 	if (SHIFT == SHIFT_LEFT) {
-		path = ext4_find_extent(inode, start - 1, &path,
+		path = ext4_find_extent(inode, start - 1, path,
 					EXT4_EX_NOCACHE);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
@@ -5275,7 +5281,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	 * becomes NULL to indicate the end of the loop.
 	 */
 	while (iterator && start <= stop) {
-		path = ext4_find_extent(inode, *iterator, &path,
+		path = ext4_find_extent(inode, *iterator, path,
 					EXT4_EX_NOCACHE);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
@@ -5857,11 +5863,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 
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
 
@@ -5945,7 +5948,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 		if (ret)
 			goto out;
 
-		path = ext4_find_extent(inode, start, &path, 0);
+		path = ext4_find_extent(inode, start, path, 0);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
 		ex = path[path->p_depth].p_ext;
@@ -5959,7 +5962,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 			if (ret)
 				goto out;
 
-			path = ext4_find_extent(inode, start, &path, 0);
+			path = ext4_find_extent(inode, start, path, 0);
 			if (IS_ERR(path))
 				return PTR_ERR(path);
 			ex = path[path->p_depth].p_ext;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index c95e3e526390..b0ab19a913bf 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -26,16 +26,17 @@ static inline int
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
+	*ppath = path;
 	return 0;
 }
 
-- 
2.39.2


