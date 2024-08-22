Return-Path: <linux-ext4+bounces-3853-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B895AB15
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686BF1C2363E
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106214B957;
	Thu, 22 Aug 2024 02:40:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635347F53;
	Thu, 22 Aug 2024 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294444; cv=none; b=A2iIVjjplQHjuCBpMnhhEDv3VT1A3GUzJu++GfINBtscP3gYMeG3v8MstdDs5qLoPzoSlCiB8/zy1gpdk34PLbOZI7CCCv4cGrIJhp/N3EKqMfvFEG90IGBxYnwZq+Wl9VwX+xHvltza9YCCXmCvbx1uYZ1OtQxwe4CyNETF4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294444; c=relaxed/simple;
	bh=GNwKrDndhc2RDfS2zrLtBnfQi31jvo914pRqecOBT18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CvzHOo1vSwyZitjUzBbQSaPG72Gke1OPrU5XixGpy5wQZdxNQIkoHFwmiLg8+l4IPJt0fxc7RA1Uw2lAn4S8ffXAyCMxh3D6ScozVvFqjXmlVy+3yBUp2WjJzhhPhM9JKbo/bdwd9+g9QhV8LLnvAZf7eCQ172y8ALMLAR5+HNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r84VmXz4f3jsQ;
	Thu, 22 Aug 2024 10:40:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CE8C41A0359;
	Thu, 22 Aug 2024 10:40:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S20;
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
Subject: [PATCH v2 16/25] ext4: get rid of ppath in ext4_force_split_extent_at()
Date: Thu, 22 Aug 2024 10:35:36 +0800
Message-Id: <20240822023545.1994557-17-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S20
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kAF47trWxAw1rKF4UJwb_yoW7Jryxpr
	13CFn7Gr95Kas0grZ2q3W7Zr1aka18KrWUGr97Gas5KF1qqw1F9F17t3WrtFW5trW8ua4a
	yr4Fkr15W3W5ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DdwAGsN

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_force_split_extent_at(), the following is
done here:

 * Free the extents path when an error is encountered.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 69 ++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index cf4ce3304780..c64f87b53efb 100644
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
@@ -2907,11 +2900,12 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
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
@@ -5764,17 +5758,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		/* Prepare left boundary */
 		if (e1_blk < lblk1) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode1,
-						&path1, lblk1, 0);
-			if (unlikely(*erp))
+			path1 = ext4_force_split_extent_at(handle, inode1,
+							   path1, lblk1, 0);
+			if (IS_ERR(path1)) {
+				*erp = PTR_ERR(path1);
 				goto finish;
+			}
 		}
 		if (e2_blk < lblk2) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode2,
-						&path2,  lblk2, 0);
-			if (unlikely(*erp))
+			path2 = ext4_force_split_extent_at(handle, inode2,
+							   path2, lblk2, 0);
+			if (IS_ERR(path2)) {
+				*erp = PTR_ERR(path2);
 				goto finish;
+			}
 		}
 		/* ext4_split_extent_at() may result in leaf extent split,
 		 * path must to be revalidated. */
@@ -5790,17 +5788,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 
 		if (len != e1_len) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode1,
-						&path1, lblk1 + len, 0);
-			if (unlikely(*erp))
+			path1 = ext4_force_split_extent_at(handle, inode1,
+							path1, lblk1 + len, 0);
+			if (IS_ERR(path1)) {
+				*erp = PTR_ERR(path1);
 				goto finish;
+			}
 		}
 		if (len != e2_len) {
 			split = 1;
-			*erp = ext4_force_split_extent_at(handle, inode2,
-						&path2, lblk2 + len, 0);
-			if (*erp)
+			path2 = ext4_force_split_extent_at(handle, inode2,
+							path2, lblk2 + len, 0);
+			if (IS_ERR(path2)) {
+				*erp = PTR_ERR(path2);
 				goto finish;
+			}
 		}
 		/* ext4_split_extent_at() may result in leaf extent split,
 		 * path must to be revalidated. */
@@ -5966,24 +5968,29 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
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


