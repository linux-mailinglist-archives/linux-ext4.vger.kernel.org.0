Return-Path: <linux-ext4+bounces-3859-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB4B95AB20
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7931C2427F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC8146D42;
	Thu, 22 Aug 2024 02:40:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF013B7AE;
	Thu, 22 Aug 2024 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294446; cv=none; b=mfbSMY9ishkijG5FsxtnTblxuSHoI4h9I5PYjUtI5+Od2xON/GJORHOStgekNeF+vq/upP/Gg3TaaH8dkkD71qZ4KMdssyb2RNUrVsSj/afqOv0jNsKLY2kV8CldjGg1hx7prFotuV39T12+6zpDDxTvnCGUsnLdTkrcJQV5tWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294446; c=relaxed/simple;
	bh=pM4CXXSAJENACNsHfPS5WeOmXxeigHSMuVwkggpyQtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUmahQPULaXGOjSb6rJe/jD8fQFfeLdJGShIRZAMPkYHH57IMtJQFoEEclqvgACb6ZV78OynKkxSCsL+ddMSOQoVnZVRE13xpXO6yuFQ0KUnz4dDuW7cMMV08aRI+D3Ul9uedYIB12uhYO/j4j6+lBJh+4ZwJaLPN9ioNutdwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6rH3Xddz4f3jtC;
	Thu, 22 Aug 2024 10:40:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3033F1A0359;
	Thu, 22 Aug 2024 10:40:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S25;
	Thu, 22 Aug 2024 10:40:40 +0800 (CST)
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
Subject: [PATCH v2 21/25] ext4: get rid of ppath in ext4_ext_handle_unwritten_extents()
Date: Thu, 22 Aug 2024 10:35:41 +0800
Message-Id: <20240822023545.1994557-22-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S25
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47Gry8Cr4xKF43Jw1UZFb_yoW7CFyDpF
	WayF15Kr45Way2grWvva1UZryaka1rGay7CrWIqry5ua42qF1Fga4rt3WFqFWrJFWxua43
	XFW0yFyUAa43uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYl19UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEIAAAs+

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_ext_handle_unwritten_extents(), the
following is done here:

 * Free the extents path when an error is encountered.
 * The 'allocated' is changed from passing a value to passing an address.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 82 +++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index efc078c2124e..dd2dd880dd8d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3888,18 +3888,18 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	return 0;
 }
 
-static int
+static struct ext4_ext_path *
 ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			struct ext4_map_blocks *map,
-			struct ext4_ext_path **ppath, int flags,
-			unsigned int allocated, ext4_fsblk_t newblock)
+			struct ext4_ext_path *path, int flags,
+			unsigned int *allocated, ext4_fsblk_t newblock)
 {
 	int err = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len, flags,
-		  allocated);
-	ext4_ext_show_leaf(inode, *ppath);
+		  *allocated);
+	ext4_ext_show_leaf(inode, path);
 
 	/*
 	 * When writing into unwritten space, we should not fail to
@@ -3908,40 +3908,34 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL;
 
 	trace_ext4_ext_handle_unwritten_extents(inode, map, flags,
-						    allocated, newblock);
+						*allocated, newblock);
 
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
-		*ppath = ext4_split_convert_extents(handle, inode, map, *ppath,
-				flags | EXT4_GET_BLOCKS_CONVERT, &allocated);
-		if (IS_ERR(*ppath)) {
-			err = PTR_ERR(*ppath);
-			*ppath = NULL;
-			goto out2;
-		}
+		path = ext4_split_convert_extents(handle, inode, map, path,
+				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
+		if (IS_ERR(path))
+			return path;
 		/*
 		 * shouldn't get a 0 allocated when splitting an extent unless
 		 * m_len is 0 (bug) or extent has been corrupted
 		 */
-		if (unlikely(allocated == 0)) {
+		if (unlikely(*allocated == 0)) {
 			EXT4_ERROR_INODE(inode,
 					 "unexpected allocated == 0, m_len = %u",
 					 map->m_len);
 			err = -EFSCORRUPTED;
-			goto out2;
+			goto errout;
 		}
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 		goto out;
 	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
-		*ppath = ext4_convert_unwritten_extents_endio(handle, inode,
-							      map, *ppath);
-		if (IS_ERR(*ppath)) {
-			err = PTR_ERR(*ppath);
-			*ppath = NULL;
-			goto out2;
-		}
+		path = ext4_convert_unwritten_extents_endio(handle, inode,
+							    map, path);
+		if (IS_ERR(path))
+			return path;
 		ext4_update_inode_fsync_trans(handle, inode, 1);
 		goto map_out;
 	}
@@ -3973,23 +3967,20 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	 * For buffered writes, at writepage time, etc.  Convert a
 	 * discovered unwritten extent to written.
 	 */
-	*ppath = ext4_ext_convert_to_initialized(handle, inode, map, *ppath,
-						 flags, &allocated);
-	if (IS_ERR(*ppath)) {
-		err = PTR_ERR(*ppath);
-		*ppath = NULL;
-		goto out2;
-	}
+	path = ext4_ext_convert_to_initialized(handle, inode, map, path,
+					       flags, allocated);
+	if (IS_ERR(path))
+		return path;
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	/*
 	 * shouldn't get a 0 allocated when converting an unwritten extent
 	 * unless m_len is 0 (bug) or extent has been corrupted
 	 */
-	if (unlikely(allocated == 0)) {
+	if (unlikely(*allocated == 0)) {
 		EXT4_ERROR_INODE(inode, "unexpected allocated == 0, m_len = %u",
 				 map->m_len);
 		err = -EFSCORRUPTED;
-		goto out2;
+		goto errout;
 	}
 
 out:
@@ -3998,12 +3989,15 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	map->m_flags |= EXT4_MAP_MAPPED;
 out1:
 	map->m_pblk = newblock;
-	if (allocated > map->m_len)
-		allocated = map->m_len;
-	map->m_len = allocated;
-	ext4_ext_show_leaf(inode, *ppath);
-out2:
-	return err ? err : allocated;
+	if (*allocated > map->m_len)
+		*allocated = map->m_len;
+	map->m_len = *allocated;
+	ext4_ext_show_leaf(inode, path);
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 /*
@@ -4200,7 +4194,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	struct ext4_extent newex, *ex, ex2;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_fsblk_t newblock = 0, pblk;
-	int err = 0, depth, ret;
+	int err = 0, depth;
 	unsigned int allocated = 0, offset = 0;
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
@@ -4274,13 +4268,11 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 				goto out;
 			}
 
-			ret = ext4_ext_handle_unwritten_extents(
-				handle, inode, map, &path, flags,
-				allocated, newblock);
-			if (ret < 0)
-				err = ret;
-			else
-				allocated = ret;
+			path = ext4_ext_handle_unwritten_extents(
+				handle, inode, map, path, flags,
+				&allocated, newblock);
+			if (IS_ERR(path))
+				err = PTR_ERR(path);
 			goto out;
 		}
 	}
-- 
2.39.2


