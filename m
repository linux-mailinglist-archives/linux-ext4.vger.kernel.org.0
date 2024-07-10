Return-Path: <linux-ext4+bounces-3168-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DDE92C9AA
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D331C2406D
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757D43F9EC;
	Wed, 10 Jul 2024 04:09:23 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3E84A57;
	Wed, 10 Jul 2024 04:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584562; cv=none; b=O78r2ztTTjzsFstkARxtQhZFJLz9/58ry2THaQZKoI45R1yOMi9MaHfv/nGv3kk2LtA6ek0M1XXNxAWNAZOZ4krD6TV5uZyIwXTnyuNdH3k6bQJn1UK2GSlsL3MfbE5uczHSd8y6yKF8h9Dlg8ajoLU6itFtEaf4c4w8DSp8Xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584562; c=relaxed/simple;
	bh=8ZfGKLzMFIrhZZIh3wI01lMUhrgGrAIn2dIQ1DvX3mE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wdbv6L5Tn8k3GF/OZyiuLWGdgTAQN1xP3LUtV2nAJm1ZqrnUuAFy+PBzD30mYNV065nmU3kdJB6jiBUb+jWXVyyjUoTv7kATdzOBsYGq11DplzCQk5gtxXJhMbPBr+sTTpWk1k0hiTA1nnCvZg6vIObfEN3iVkaILgCYqCwmQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WJkrD6Khvz4f3mJf;
	Wed, 10 Jul 2024 12:09:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7D7091A0D24;
	Wed, 10 Jul 2024 12:09:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S23;
	Wed, 10 Jul 2024 12:09:12 +0800 (CST)
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
Subject: [PATCH 19/20] ext4: get rid of ppath in convert_initialized_extent()
Date: Wed, 10 Jul 2024 12:06:53 +0800
Message-Id: <20240710040654.1714672-20-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S23
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DKF45Wr43tF4fXryrZwb_yoW5ZFyUpF
	ySyr1rCr1Yg39FgrZ7Ja1UZryak3W5Gw4UCrWfG34Fk3WIvr1FgFy8t3WSyFWrtay8Wa4a
	vFW0yr1UC3W7CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAABV1jkIPHoQAIsH

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in convert_initialized_extent(), the following is
done here:

 * Free the extents path when an error is encountered.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index badadcd64e66..737432bb316e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3810,13 +3810,12 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 	return ERR_PTR(err);
 }
 
-static int
+static struct ext4_ext_path *
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
-			   struct ext4_ext_path **ppath,
+			   struct ext4_ext_path *path,
 			   unsigned int *allocated)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_extent *ex;
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
@@ -3841,29 +3840,25 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
 				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
-		if (IS_ERR(path)) {
-			*ppath = NULL;
-			return PTR_ERR(path);
-		}
+		if (IS_ERR(path))
+			return path;
 
 		path = ext4_find_extent(inode, map->m_lblk, path, 0);
-		if (IS_ERR(path)) {
-			*ppath = NULL;
-			return PTR_ERR(path);
-		}
-		*ppath = path;
+		if (IS_ERR(path))
+			return path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 		if (!ex) {
 			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
 					 (unsigned long) map->m_lblk);
-			return -EFSCORRUPTED;
+			err = -EFSCORRUPTED;
+			goto errout;
 		}
 	}
 
 	err = ext4_ext_get_access(handle, inode, path + depth);
 	if (err)
-		return err;
+		goto errout;
 	/* first mark the extent as unwritten */
 	ext4_ext_mark_unwritten(ex);
 
@@ -3875,7 +3870,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	/* Mark modified extent as dirty */
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
 	if (err)
-		return err;
+		goto errout;
 	ext4_ext_show_leaf(inode, path);
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
@@ -3884,7 +3879,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	if (*allocated > map->m_len)
 		*allocated = map->m_len;
 	map->m_len = *allocated;
-	return 0;
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 static struct ext4_ext_path *
@@ -4254,8 +4253,10 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			 */
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
-				err = convert_initialized_extent(handle,
-					inode, map, &path, &allocated);
+				path = convert_initialized_extent(handle,
+					inode, map, path, &allocated);
+				if (IS_ERR(path))
+					err = PTR_ERR(path);
 				goto out;
 			} else if (!ext4_ext_is_unwritten(ex)) {
 				map->m_flags |= EXT4_MAP_MAPPED;
-- 
2.39.2


