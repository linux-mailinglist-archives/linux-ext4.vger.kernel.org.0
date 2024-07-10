Return-Path: <linux-ext4+bounces-3166-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39D92C9A4
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C6B2302B
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FBB12C465;
	Wed, 10 Jul 2024 04:09:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB624679E5;
	Wed, 10 Jul 2024 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584561; cv=none; b=oyISzFI3wqEr7xfz6pOCHMk/ZF69yokhiZ+sNOjzJ8ltXRvDhbUhVNuN8RBlDYzXJc6JYf44eFo3eUT9NjEVcr3diwCeNX4eUuVM9TIO1yNhBDudT/gAE2CgJJZYXHZI7+vNNnXGtJocUn3sFK782qzAS9zE9S4x4oeJ/TNQb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584561; c=relaxed/simple;
	bh=h7WaqXVeQnk6U1fKBr3xAO1Vc51WGwoJwbuSPTD3Yoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oi+iKXh5ucBJQ8DYQxD8B5bADA4UnHhCXrqx1hdLx41QbkNifYIo+wnVhfMfEXWWZ8B2dw/jsX/GSIX6mDIXof93W/09dv0JLM9dl7l/+jsxKZT+syXgYTmw20DE7Tkzbe3P2fD30BFR5ki4jKGV5Prz1BHJyk8MvstXeocPFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WJkrB3SMxz4f3mJc;
	Wed, 10 Jul 2024 12:08:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 186F71A0181;
	Wed, 10 Jul 2024 12:09:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S17;
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
Subject: [PATCH 13/20] ext4: get rid of ppath in ext4_force_split_extent_at()
Date: Wed, 10 Jul 2024 12:06:47 +0800
Message-Id: <20240710040654.1714672-14-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S17
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1kKF1xuFyUuF4rtFy8Grg_yoW3JFy5pF
	129F1DGr95tF90gryIqw17Xr1aka15GrWUGF93Gas5A3Wqqr1Y9F1xt3WSyF45KrWrWaya
	yr4S9ry5uw1DX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAABV1jkH7IKgAAs1

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_force_split_extent_at(), the following is
done here:

 * The ext4_find_extent() can update the extent path so it doesn't have to
   allocate and free path repeatedly, thus reducing the consumption of
   memory allocation and freeing in ext4_swap_extents().

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 117 ++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 57 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c86b1bb7720f..0bd068ed324f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -328,27 +328,20 @@ static inline int ext4_ext_space_root_idx(struct inode *inode, int check)
 	return size;
 }
 
-static inline int
+static inline struct ext4_ext_path *
 ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
-			   struct ext4_ext_path **ppath, ext4_lblk_t lblk,
+			   struct ext4_ext_path *path, ext4_lblk_t lblk,
 			   int nofail)
 {
-	struct ext4_ext_path *path = *ppath;
 	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
 	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
 
 	if (nofail)
 		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
-	path = ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
+	return ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
 			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
 			flags);
-	if (IS_ERR(path)) {
-		*ppath = NULL;
-		return PTR_ERR(path);
-	}
-	*ppath = path;
-	return 0;
 }
 
 static int
@@ -2906,11 +2899,12 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 * fail removing space due to ENOSPC so try to use
 			 * reserved block if that happens.
 			 */
-			err = ext4_force_split_extent_at(handle, inode, &path,
-							 end + 1, 1);
-			if (err < 0)
+			path = ext4_force_split_extent_at(handle, inode, path,
+							  end + 1, 1);
+			if (IS_ERR(path)) {
+				err = PTR_ERR(path);
 				goto out;
-
+			}
 		} else if (sbi->s_cluster_ratio > 1 && end >= ex_end &&
 			   partial.state == initial) {
 			/*
@@ -5707,25 +5701,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		int e1_len, e2_len, len;
 		int split = 0;
 
-		path1 = ext4_find_extent(inode1, lblk1, NULL, EXT4_EX_NOCACHE);
+		path1 = ext4_find_extent(inode1, lblk1, path1, EXT4_EX_NOCACHE);
 		if (IS_ERR(path1)) {
 			*erp = PTR_ERR(path1);
-			path1 = NULL;
-		finish:
-			count = 0;
-			goto repeat;
+			goto errout;
 		}
-		path2 = ext4_find_extent(inode2, lblk2, NULL, EXT4_EX_NOCACHE);
+		path2 = ext4_find_extent(inode2, lblk2, path2, EXT4_EX_NOCACHE);
 		if (IS_ERR(path2)) {
 			*erp = PTR_ERR(path2);
-			path2 = NULL;
-			goto finish;
+			goto errout;
 		}
 		ex1 = path1[path1->p_depth].p_ext;
 		ex2 = path2[path2->p_depth].p_ext;
 		/* Do we have something to swap ? */
 		if (unlikely(!ex2 || !ex1))
-			goto finish;
+			goto errout;
 
 		e1_blk = le32_to_cpu(ex1->ee_block);
 		e2_blk = le32_to_cpu(ex2->ee_block);
@@ -5747,7 +5737,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 				next2 = e2_blk;
 			/* Do we have something to swap */
 			if (next1 == EXT_MAX_BLOCKS || next2 == EXT_MAX_BLOCKS)
-				goto finish;
+				goto errout;
 			/* Move to the rightest boundary */
 			len = next1 - lblk1;
 			if (len < next2 - lblk2)
@@ -5757,28 +5747,32 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 			lblk1 += len;
 			lblk2 += len;
 			count -= len;
-			goto repeat;
+			continue;
 		}
 
 		/* Prepare left boundary */
 		if (e1_blk < lblk1) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode1,
-						&path1, lblk1, 0);
-			if (unlikely(*erp))
-				goto finish;
+			path1 = ext4_force_split_extent_at(handle, inode1,
+							   path1, lblk1, 0);
+			if (IS_ERR(path1)) {
+				*erp = PTR_ERR(path1);
+				goto errout;
+			}
 		}
 		if (e2_blk < lblk2) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode2,
-						&path2,  lblk2, 0);
-			if (unlikely(*erp))
-				goto finish;
+			path2 = ext4_force_split_extent_at(handle, inode2,
+							   path2, lblk2, 0);
+			if (IS_ERR(path2)) {
+				*erp = PTR_ERR(path2);
+				goto errout;
+			}
 		}
 		/* ext4_split_extent_at() may result in leaf extent split,
 		 * path must to be revalidated. */
 		if (split)
-			goto repeat;
+			continue;
 
 		/* Prepare right boundary */
 		len = count;
@@ -5789,30 +5783,34 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 
 		if (len != e1_len) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode1,
-						&path1, lblk1 + len, 0);
-			if (unlikely(*erp))
-				goto finish;
+			path1 = ext4_force_split_extent_at(handle, inode1,
+							path1, lblk1 + len, 0);
+			if (IS_ERR(path1)) {
+				*erp = PTR_ERR(path1);
+				goto errout;
+			}
 		}
 		if (len != e2_len) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode2,
-						&path2, lblk2 + len, 0);
-			if (*erp)
-				goto finish;
+			path2 = ext4_force_split_extent_at(handle, inode2,
+							path2, lblk2 + len, 0);
+			if (IS_ERR(path2)) {
+				*erp = PTR_ERR(path2);
+				goto errout;
+			}
 		}
 		/* ext4_split_extent_at() may result in leaf extent split,
 		 * path must to be revalidated. */
 		if (split)
-			goto repeat;
+			continue;
 
 		BUG_ON(e2_len != e1_len);
 		*erp = ext4_ext_get_access(handle, inode1, path1 + path1->p_depth);
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
 		*erp = ext4_ext_get_access(handle, inode2, path2 + path2->p_depth);
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
 
 		/* Both extents are fully inside boundaries. Swap it now */
 		tmp_ex = *ex1;
@@ -5830,7 +5828,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		*erp = ext4_ext_dirty(handle, inode2, path2 +
 				      path2->p_depth);
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
 		*erp = ext4_ext_dirty(handle, inode1, path1 +
 				      path1->p_depth);
 		/*
@@ -5840,17 +5838,17 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		 * aborted anyway.
 		 */
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
+
 		lblk1 += len;
 		lblk2 += len;
 		replaced_count += len;
 		count -= len;
-
-	repeat:
-		ext4_free_ext_path(path1);
-		ext4_free_ext_path(path2);
-		path1 = path2 = NULL;
 	}
+
+errout:
+	ext4_free_ext_path(path1);
+	ext4_free_ext_path(path2);
 	return replaced_count;
 }
 
@@ -5965,24 +5963,29 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 		ext4_ext_get_actual_len(ex) != len) {
 		/* We need to split this extent to match our extent first */
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ret = ext4_force_split_extent_at(NULL, inode, &path, start, 1);
+		path = ext4_force_split_extent_at(NULL, inode, path, start, 1);
 		up_write(&EXT4_I(inode)->i_data_sem);
-		if (ret)
+		if (IS_ERR(path)) {
+			ret = PTR_ERR(path);
 			goto out;
+		}
 
 		path = ext4_find_extent(inode, start, path, 0);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
+
 		ex = path[path->p_depth].p_ext;
 		WARN_ON(le32_to_cpu(ex->ee_block) != start);
 
 		if (ext4_ext_get_actual_len(ex) != len) {
 			down_write(&EXT4_I(inode)->i_data_sem);
-			ret = ext4_force_split_extent_at(NULL, inode, &path,
-							 start + len, 1);
+			path = ext4_force_split_extent_at(NULL, inode, path,
+							  start + len, 1);
 			up_write(&EXT4_I(inode)->i_data_sem);
-			if (ret)
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
 				goto out;
+			}
 
 			path = ext4_find_extent(inode, start, path, 0);
 			if (IS_ERR(path))
-- 
2.39.2


