Return-Path: <linux-ext4+bounces-3854-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447695AB16
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294371C23CDD
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187941531D2;
	Thu, 22 Aug 2024 02:40:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251461802E;
	Thu, 22 Aug 2024 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294444; cv=none; b=QUvkEfe84LkYFe/BnyM6l/xvttcyzBDqlsPxlvIkAoolj7yWlwP7dNuGjjqnB5cr9NFs+cK8TpE9EjpZzUGEraBCCNjZCyIwvX/L0lDdF3Waudc278S23lE45axJzjvpeleowdlsNyVw9xzzaqXxPiYGk9S6L/wAttlgTI6Jd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294444; c=relaxed/simple;
	bh=90BwtzhGP2HiJzRUrtH6142/opRMmOKvwndTL4ztcO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWknp06pJ2CnEvvXlY38FMrFWet+qKHOhsh8B40hdGFRHPEk3Ql78EyqhllerEePauMqmP1KMojZ6ZWCxGh0uyEo4YQT9NNIR8Tr0QlDH68JAH8FCTQTVcr4y7E/iRUKHkCYHv0G19wm5p+ASg3aNhvxmCvjrIzn6CEVn7PV9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6rF49v5z4f3kKn;
	Thu, 22 Aug 2024 10:40:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 46BDA1A1794;
	Thu, 22 Aug 2024 10:40:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S21;
	Thu, 22 Aug 2024 10:40:39 +0800 (CST)
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
Subject: [PATCH v2 17/25] ext4: get rid of ppath in ext4_split_extent()
Date: Thu, 22 Aug 2024 10:35:37 +0800
Message-Id: <20240822023545.1994557-18-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S21
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47Gry8CF18Gry8Kr1fXrb_yoW7XryUpr
	Z3ur1UKw1UKwnF9rWxJ3W8ur1aka1UGayUCFW3tr9Yv3ZFqa4YgFyxt3WFqFWrtrW8WFy3
	Ar40yry5Ca13JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEHgABsB

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_split_extent(), the following is done here:

 * The 'allocated' is changed from passing a value to passing an address.
 * Its caller needs to update ppath if it uses ppath.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 97 ++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c64f87b53efb..9bbb8def1958 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3346,21 +3346,18 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
  *   c> Splits in three extents: Somone is splitting in middle of the extent
  *
  */
-static int ext4_split_extent(handle_t *handle,
-			      struct inode *inode,
-			      struct ext4_ext_path **ppath,
-			      struct ext4_map_blocks *map,
-			      int split_flag,
-			      int flags)
+static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
+					       struct inode *inode,
+					       struct ext4_ext_path *path,
+					       struct ext4_map_blocks *map,
+					       int split_flag, int flags,
+					       unsigned int *allocated)
 {
-	struct ext4_ext_path *path = *ppath;
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex;
 	unsigned int ee_len, depth;
-	int err = 0;
 	int unwritten;
 	int split_flag1, flags1;
-	int allocated = map->m_len;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3378,33 +3375,25 @@ static int ext4_split_extent(handle_t *handle,
 			split_flag1 |= EXT4_EXT_DATA_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
-		if (IS_ERR(path)) {
-			err = PTR_ERR(path);
-			*ppath = NULL;
-			goto out;
+		if (IS_ERR(path))
+			return path;
+		/*
+		 * Update path is required because previous ext4_split_extent_at
+		 * may result in split of original leaf or extent zeroout.
+		 */
+		path = ext4_find_extent(inode, map->m_lblk, path, flags);
+		if (IS_ERR(path))
+			return path;
+		depth = ext_depth(inode);
+		ex = path[depth].p_ext;
+		if (!ex) {
+			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
+					(unsigned long) map->m_lblk);
+			ext4_free_ext_path(path);
+			return ERR_PTR(-EFSCORRUPTED);
 		}
-		*ppath = path;
-	} else {
-		allocated = ee_len - (map->m_lblk - ee_block);
-	}
-	/*
-	 * Update path is required because previous ext4_split_extent_at() may
-	 * result in split of original leaf or extent zeroout.
-	 */
-	path = ext4_find_extent(inode, map->m_lblk, path, flags);
-	if (IS_ERR(path)) {
-		*ppath = NULL;
-		return PTR_ERR(path);
-	}
-	*ppath = path;
-	depth = ext_depth(inode);
-	ex = path[depth].p_ext;
-	if (!ex) {
-		EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
-				 (unsigned long) map->m_lblk);
-		return -EFSCORRUPTED;
+		unwritten = ext4_ext_is_unwritten(ex);
 	}
-	unwritten = ext4_ext_is_unwritten(ex);
 
 	if (map->m_lblk >= ee_block) {
 		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
@@ -3415,17 +3404,18 @@ static int ext4_split_extent(handle_t *handle,
 		}
 		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk, split_flag1, flags);
-		if (IS_ERR(path)) {
-			err = PTR_ERR(path);
-			*ppath = NULL;
-			goto out;
-		}
-		*ppath = path;
+		if (IS_ERR(path))
+			return path;
 	}
 
+	if (allocated) {
+		if (map->m_lblk + map->m_len > ee_block + ee_len)
+			*allocated = ee_len - (map->m_lblk - ee_block);
+		else
+			*allocated = map->m_len;
+	}
 	ext4_ext_show_leaf(inode, path);
-out:
-	return err ? err : allocated;
+	return path;
 }
 
 /*
@@ -3670,10 +3660,15 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	}
 
 fallback:
-	err = ext4_split_extent(handle, inode, ppath, &split_map, split_flag,
-				flags);
-	if (err > 0)
-		err = 0;
+	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
+				 flags, NULL);
+	if (IS_ERR(path)) {
+		err = PTR_ERR(path);
+		*ppath = NULL;
+		goto out;
+	}
+	err = 0;
+	*ppath = path;
 out:
 	/* If we have gotten a failure, don't zero out status tree */
 	if (!err) {
@@ -3719,6 +3714,7 @@ static int ext4_split_convert_extents(handle_t *handle,
 	struct ext4_extent *ex;
 	unsigned int ee_len;
 	int split_flag = 0, depth;
+	unsigned int allocated = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len);
@@ -3746,7 +3742,14 @@ static int ext4_split_convert_extents(handle_t *handle,
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
-	return ext4_split_extent(handle, inode, ppath, map, split_flag, flags);
+	path = ext4_split_extent(handle, inode, path, map, split_flag, flags,
+				 &allocated);
+	if (IS_ERR(path)) {
+		*ppath = NULL;
+		return PTR_ERR(path);
+	}
+	*ppath = path;
+	return allocated;
 }
 
 static int ext4_convert_unwritten_extents_endio(handle_t *handle,
-- 
2.39.2


