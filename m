Return-Path: <linux-ext4+bounces-3850-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3F95AB0E
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57FA1F2444F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF1D7CF16;
	Thu, 22 Aug 2024 02:40:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82A36139;
	Thu, 22 Aug 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294442; cv=none; b=UvfmorDzcEEkLNb7YOZGENoF2gvC+x8GF7T8wy5IFsvbd5A0SiZ/7tdQ/ZIPeQf7btOjvNh+sd90MWKOVBp68v8ZHBs2+h8XgYCCJTew2VyUvpk8Ye6HtSW/ATp1PnRVua3JeIwZmGkUHwNeGhadJCrtUF3x9p1H1JncAyOhP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294442; c=relaxed/simple;
	bh=nz2PkK2aUHWoQeBNhlOvUjPJMZ8ruiQ2YDRhmunEpko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcwXtKvNFycJT3TzkYF+veid9zVT4sPaZBtUtmIXNOIKiaIMAQPOIY5sh61w+VpRL0QJSl81dEqsTgR+WDkzR//+HUk8gE9JS0TKDC/2VFUXZ+UsnRTq+8gFtCljYgPYaVLwUoN7nLnT4WHN1VuzFI1pU7/pfwV1HiJJKHzY/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r61lXhz4f3n6d;
	Thu, 22 Aug 2024 10:40:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F7191A06D7;
	Thu, 22 Aug 2024 10:40:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S17;
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
Subject: [PATCH v2 13/25] ext4: get rid of ppath in ext4_ext_create_new_leaf()
Date: Thu, 22 Aug 2024 10:35:33 +0800
Message-Id: <20240822023545.1994557-14-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S17
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DAr4rCF13Gw4rKr1kuFg_yoW5Zw4kpF
	WSyFy8K3W5JasF9rWIqa1UZr1ak3W8G3yUGFW3Gr9YkFy2vFnYqFyft3WFyFW5JFW8ua4a
	qF40yw1UWw12g3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DdwABsK

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_ext_create_new_leaf(), the following is
done here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index adedf2d1e67e..a11a5144fd96 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1397,13 +1397,12 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
  * finds empty index and adds new leaf.
  * if no free index is found, then it requests in-depth growing.
  */
-static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
-				    unsigned int mb_flags,
-				    unsigned int gb_flags,
-				    struct ext4_ext_path **ppath,
-				    struct ext4_extent *newext)
+static struct ext4_ext_path *
+ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
+			 unsigned int mb_flags, unsigned int gb_flags,
+			 struct ext4_ext_path *path,
+			 struct ext4_extent *newext)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_ext_path *curp;
 	int depth, i, err = 0;
 
@@ -1424,28 +1423,25 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		 * entry: create all needed subtree and add new leaf */
 		err = ext4_ext_split(handle, inode, mb_flags, path, newext, i);
 		if (err)
-			goto out;
+			goto errout;
 
 		/* refill path */
 		path = ext4_find_extent(inode,
 				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
 				    path, gb_flags);
-		if (IS_ERR(path))
-			err = PTR_ERR(path);
+		return path;
 	} else {
 		/* tree is full, time to grow in depth */
 		err = ext4_ext_grow_indepth(handle, inode, mb_flags);
 		if (err)
-			goto out;
+			goto errout;
 
 		/* refill path */
 		path = ext4_find_extent(inode,
 				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
 				    path, gb_flags);
-		if (IS_ERR(path)) {
-			err = PTR_ERR(path);
-			goto out;
-		}
+		if (IS_ERR(path))
+			return path;
 
 		/*
 		 * only first (depth 0 -> 1) produces free space;
@@ -1457,9 +1453,11 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 			goto repeat;
 		}
 	}
-out:
-	*ppath = IS_ERR(path) ? NULL : path;
-	return err;
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 /*
@@ -2112,11 +2110,14 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	 */
 	if (gb_flags & EXT4_GET_BLOCKS_METADATA_NOFAIL)
 		mb_flags |= EXT4_MB_USE_RESERVED;
-	err = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
-				       ppath, newext);
-	if (err)
+	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
+					path, newext);
+	if (IS_ERR(path)) {
+		*ppath = NULL;
+		err = PTR_ERR(path);
 		goto cleanup;
-	path = *ppath;
+	}
+	*ppath = path;
 	depth = ext_depth(inode);
 	eh = path[depth].p_hdr;
 
-- 
2.39.2


