Return-Path: <linux-ext4+bounces-3858-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E86F95AB1E
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433431C23D9C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB2B171E69;
	Thu, 22 Aug 2024 02:40:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60449139CF6;
	Thu, 22 Aug 2024 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294445; cv=none; b=OqftV9OqlZEO1/Fep8uaA51ma2Hzw8GJkqgMnzXH9Mr0EphrOt25zrxSHVTsF302bgca0O+KhnBjyfiUjU7Q+SOwlOATlBYmWmX0tNy2qUhiCHSyeWg0je8M9G59C0d8LnvOMj+o8hTSRfSvhwq8+PwdhvUPreuAXJq9wcMNzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294445; c=relaxed/simple;
	bh=9FBZtFctC5QEZbuSDw3iJ3HGI+2vlzyju2NSlWyJPGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8reTBNhRMiEHRFzF16pTrBpnM5OWP54fKKPLm44mkBRpnuAmYfjdkQK1KsVl3EJ+PVFyVgWUfAFfbkzaYg+AC6vnRh4R2BQyyHgMyMVDaCUziLAc3aIMGgGfIJvY2sNrkHoyLJmkCSYJs2wj3ymJNrZC9imt/TEUy/T1fgTa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r949K4z4f3nJT;
	Thu, 22 Aug 2024 10:40:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B105C1A0359;
	Thu, 22 Aug 2024 10:40:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S24;
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
Subject: [PATCH v2 20/25] ext4: get rid of ppath in ext4_ext_convert_to_initialized()
Date: Thu, 22 Aug 2024 10:35:40 +0800
Message-Id: <20240822023545.1994557-21-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S24
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar47Gry8CF4rCw1UJr43ZFb_yoWxuF43pF
	yYvrn8Grn0q3sFgFZ7ta1UZr1293WrCa4jkrW3KryrZr92qr1fWa4fta4FqFWrtFW8ZF15
	tFW8Ar18GwnxAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DewACsF

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_ext_convert_to_initialized(), the following
is done here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.
 * The 'allocated' is changed from passing a value to passing an address.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 73 +++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f0c9c53452d2..efc078c2124e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3438,13 +3438,11 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
  *    that are allocated and initialized.
  *    It is guaranteed to be >= map->m_len.
  */
-static int ext4_ext_convert_to_initialized(handle_t *handle,
-					   struct inode *inode,
-					   struct ext4_map_blocks *map,
-					   struct ext4_ext_path **ppath,
-					   int flags)
+static struct ext4_ext_path *
+ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
+			struct ext4_map_blocks *map, struct ext4_ext_path *path,
+			int flags, unsigned int *allocated)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_sb_info *sbi;
 	struct ext4_extent_header *eh;
 	struct ext4_map_blocks split_map;
@@ -3454,7 +3452,6 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	unsigned int ee_len, depth, map_len = map->m_len;
 	int err = 0;
 	int split_flag = EXT4_EXT_DATA_VALID2;
-	int allocated = 0;
 	unsigned int max_zeroout = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
@@ -3495,6 +3492,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	 *  - L2: we only attempt to merge with an extent stored in the
 	 *    same extent tree node.
 	 */
+	*allocated = 0;
 	if ((map->m_lblk == ee_block) &&
 		/* See if we can merge left */
 		(map_len < ee_len) &&		/*L1*/
@@ -3524,7 +3522,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 			(prev_len < (EXT_INIT_MAX_LEN - map_len))) {	/*C4*/
 			err = ext4_ext_get_access(handle, inode, path + depth);
 			if (err)
-				goto out;
+				goto errout;
 
 			trace_ext4_ext_convert_to_initialized_fastpath(inode,
 				map, ex, abut_ex);
@@ -3539,7 +3537,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 			abut_ex->ee_len = cpu_to_le16(prev_len + map_len);
 
 			/* Result: number of initialized blocks past m_lblk */
-			allocated = map_len;
+			*allocated = map_len;
 		}
 	} else if (((map->m_lblk + map_len) == (ee_block + ee_len)) &&
 		   (map_len < ee_len) &&	/*L1*/
@@ -3570,7 +3568,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 		    (next_len < (EXT_INIT_MAX_LEN - map_len))) {	/*C4*/
 			err = ext4_ext_get_access(handle, inode, path + depth);
 			if (err)
-				goto out;
+				goto errout;
 
 			trace_ext4_ext_convert_to_initialized_fastpath(inode,
 				map, ex, abut_ex);
@@ -3585,18 +3583,20 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 			abut_ex->ee_len = cpu_to_le16(next_len + map_len);
 
 			/* Result: number of initialized blocks past m_lblk */
-			allocated = map_len;
+			*allocated = map_len;
 		}
 	}
-	if (allocated) {
+	if (*allocated) {
 		/* Mark the block containing both extents as dirty */
 		err = ext4_ext_dirty(handle, inode, path + depth);
 
 		/* Update path to point to the right extent */
 		path[depth].p_ext = abut_ex;
+		if (err)
+			goto errout;
 		goto out;
 	} else
-		allocated = ee_len - (map->m_lblk - ee_block);
+		*allocated = ee_len - (map->m_lblk - ee_block);
 
 	WARN_ON(map->m_lblk < ee_block);
 	/*
@@ -3623,21 +3623,21 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	split_map.m_lblk = map->m_lblk;
 	split_map.m_len = map->m_len;
 
-	if (max_zeroout && (allocated > split_map.m_len)) {
-		if (allocated <= max_zeroout) {
+	if (max_zeroout && (*allocated > split_map.m_len)) {
+		if (*allocated <= max_zeroout) {
 			/* case 3 or 5 */
 			zero_ex1.ee_block =
 				 cpu_to_le32(split_map.m_lblk +
 					     split_map.m_len);
 			zero_ex1.ee_len =
-				cpu_to_le16(allocated - split_map.m_len);
+				cpu_to_le16(*allocated - split_map.m_len);
 			ext4_ext_store_pblock(&zero_ex1,
 				ext4_ext_pblock(ex) + split_map.m_lblk +
 				split_map.m_len - ee_block);
 			err = ext4_ext_zeroout(inode, &zero_ex1);
 			if (err)
 				goto fallback;
-			split_map.m_len = allocated;
+			split_map.m_len = *allocated;
 		}
 		if (split_map.m_lblk - ee_block + split_map.m_len <
 								max_zeroout) {
@@ -3655,27 +3655,24 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 
 			split_map.m_len += split_map.m_lblk - ee_block;
 			split_map.m_lblk = ee_block;
-			allocated = map->m_len;
+			*allocated = map->m_len;
 		}
 	}
 
 fallback:
 	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
 				 flags, NULL);
-	if (IS_ERR(path)) {
-		err = PTR_ERR(path);
-		*ppath = NULL;
-		goto out;
-	}
-	err = 0;
-	*ppath = path;
+	if (IS_ERR(path))
+		return path;
 out:
 	/* If we have gotten a failure, don't zero out status tree */
-	if (!err) {
-		ext4_zeroout_es(inode, &zero_ex1);
-		ext4_zeroout_es(inode, &zero_ex2);
-	}
-	return err ? err : allocated;
+	ext4_zeroout_es(inode, &zero_ex1);
+	ext4_zeroout_es(inode, &zero_ex2);
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 /*
@@ -3897,7 +3894,6 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path **ppath, int flags,
 			unsigned int allocated, ext4_fsblk_t newblock)
 {
-	int ret = 0;
 	int err = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
@@ -3977,23 +3973,24 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	 * For buffered writes, at writepage time, etc.  Convert a
 	 * discovered unwritten extent to written.
 	 */
-	ret = ext4_ext_convert_to_initialized(handle, inode, map, ppath, flags);
-	if (ret < 0) {
-		err = ret;
+	*ppath = ext4_ext_convert_to_initialized(handle, inode, map, *ppath,
+						 flags, &allocated);
+	if (IS_ERR(*ppath)) {
+		err = PTR_ERR(*ppath);
+		*ppath = NULL;
 		goto out2;
 	}
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	/*
-	 * shouldn't get a 0 return when converting an unwritten extent
+	 * shouldn't get a 0 allocated when converting an unwritten extent
 	 * unless m_len is 0 (bug) or extent has been corrupted
 	 */
-	if (unlikely(ret == 0)) {
-		EXT4_ERROR_INODE(inode, "unexpected ret == 0, m_len = %u",
+	if (unlikely(allocated == 0)) {
+		EXT4_ERROR_INODE(inode, "unexpected allocated == 0, m_len = %u",
 				 map->m_len);
 		err = -EFSCORRUPTED;
 		goto out2;
 	}
-	allocated = ret;
 
 out:
 	map->m_flags |= EXT4_MAP_NEW;
-- 
2.39.2


