Return-Path: <linux-ext4+bounces-3855-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D06E95AB19
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4DDB233CA
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA8116BE0D;
	Thu, 22 Aug 2024 02:40:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BAF39FEB;
	Thu, 22 Aug 2024 02:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294445; cv=none; b=O4J40ZfBuxHycgJuuTGooDLi2ts9D3t00ihc9eHii1e/cvkP+Mk753S0i3EAuMUkGjMkfLahL5Erq5IROAyxREzdoWGESc3U0yJp0/feLBkIyWSuHsWHX8V3d4SHq7mcSuV5tWdTldSY9Ju3477bgOJE7gcG4gkwF8JpVltLCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294445; c=relaxed/simple;
	bh=bq8FsvPK0yTx31HzZy8fRnXsHomXpXK3qTZ/mqHSFmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=usZVcQxQjC4jOXJQriUFLTyK5sRTivIheb6bjBTHe5ZP2PSPPI4HBqEUFmQ4cc22MjxvoqAUPatDg+ubQPSGL6Bm8vnvbRU0jWfImledb9OB/E9XcCwtd0M7FCVaAabUT2qel1Xn6eLXtmv9Ei561urf1JX3OFzAZLS+/ojKw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r90mDFz4f3nJR;
	Thu, 22 Aug 2024 10:40:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A4E31A06D7;
	Thu, 22 Aug 2024 10:40:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S23;
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
Subject: [PATCH v2 19/25] ext4: get rid of ppath in ext4_convert_unwritten_extents_endio()
Date: Thu, 22 Aug 2024 10:35:39 +0800
Message-Id: <20240822023545.1994557-20-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S23
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kZFWfKw17CFyxtrykGrg_yoW5CFWDpF
	9akr1Fkr18KanI9FWxAa1UZryaka18GayUArZrJ3sY9asFvrnYqFy8K3WFyFWrtayxWa4a
	vrW0yryUua47CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEHwAAsB

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_convert_unwritten_extents_endio(), the
following is done here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4698f765b8e7..f0c9c53452d2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3746,12 +3746,11 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 				 allocated);
 }
 
-static int ext4_convert_unwritten_extents_endio(handle_t *handle,
-						struct inode *inode,
-						struct ext4_map_blocks *map,
-						struct ext4_ext_path **ppath)
+static struct ext4_ext_path *
+ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
+				     struct ext4_map_blocks *map,
+				     struct ext4_ext_path *path)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_extent *ex;
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
@@ -3781,24 +3780,19 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 #endif
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						EXT4_GET_BLOCKS_CONVERT, NULL);
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
 	}
 
 	err = ext4_ext_get_access(handle, inode, path + depth);
 	if (err)
-		goto out;
+		goto errout;
 	/* first mark the extent as initialized */
 	ext4_ext_mark_initialized(ex);
 
@@ -3809,9 +3803,15 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 
 	/* Mark modified extent as dirty */
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
-out:
+	if (err)
+		goto errout;
+
 	ext4_ext_show_leaf(inode, path);
-	return err;
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 static int
@@ -3939,10 +3939,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	}
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
-		err = ext4_convert_unwritten_extents_endio(handle, inode, map,
-							   ppath);
-		if (err < 0)
+		*ppath = ext4_convert_unwritten_extents_endio(handle, inode,
+							      map, *ppath);
+		if (IS_ERR(*ppath)) {
+			err = PTR_ERR(*ppath);
+			*ppath = NULL;
 			goto out2;
+		}
 		ext4_update_inode_fsync_trans(handle, inode, 1);
 		goto map_out;
 	}
-- 
2.39.2


