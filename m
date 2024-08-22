Return-Path: <linux-ext4+bounces-3862-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169A95AB27
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F51A1C244DA
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF017E00C;
	Thu, 22 Aug 2024 02:40:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82918165F11;
	Thu, 22 Aug 2024 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294447; cv=none; b=d2yextpHvGD2uPudbETgDZk+P+XJYc1bC0C53HZGXaaN2uSA85M96ckXyu9URYh6vVYV4ThuwjzpgPfUyR/x+ceLBCnRiEHA30KEqdw2hkJwMTb5JK14m0XGwwgfzJ9Dk4fs0i4eyNyA9dAaKAHGeId/Hni/lvwQW+IUiEbmxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294447; c=relaxed/simple;
	bh=mXvtL3fite4bDNRyOxT5Mw60FRuY8QpPL96/wQRpLUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E53fmX1B8uh1tKShJX2xIgh6Ee7qoFg1LhxTS8By6MS35hhbPS+CF0KsLuw9lsGLDY+G8tx5rhEAX54+cy+FSuJt61rXVI7Of3UFiuZ0EQ552qKCoJqtP4HDAcFlgwvH8qMBL+s33e8MW2nZS3v9bMgVHQbc1nx/lvEPAvermuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6rJ6Y8gz4f3jtD;
	Thu, 22 Aug 2024 10:40:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 970791A0568;
	Thu, 22 Aug 2024 10:40:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S28;
	Thu, 22 Aug 2024 10:40:42 +0800 (CST)
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
Subject: [PATCH v2 24/25] ext4: make some fast commit functions reuse extents path
Date: Thu, 22 Aug 2024 10:35:44 +0800
Message-Id: <20240822023545.1994557-25-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S28
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7Jw15Xw4furWkWFW7Jwb_yoW7CFW3pF
	WayF1Ygr15JFsrCrZ2ga17Zw13K3W8Gw48GryfWw1kuasxJr1SgF17ta1rtFy8KFZ7WFWa
	vF18Kry8Gry7KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DfgAAsC

From: Baokun Li <libaokun1@huawei.com>

The ext4_find_extent() can update the extent path so that it does not have
to allocate and free the path repeatedly, thus reducing the consumption of
memory allocation and freeing in the following functions:

    ext4_ext_clear_bb
    ext4_ext_replay_set_iblocks
    ext4_fc_replay_add_range
    ext4_fc_set_bitmaps_and_counters

No functional changes. Note that ext4_find_extent() does not support error
pointers, so in this case set path to NULL first.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c     | 51 +++++++++++++++++++------------------------
 fs/ext4/fast_commit.c | 11 ++++++----
 2 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 37b36b1abb16..ca1f946514dd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6069,12 +6069,9 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	ex = path[path->p_depth].p_ext;
-	if (!ex) {
-		ext4_free_ext_path(path);
+	if (!ex)
 		goto out;
-	}
 	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
-	ext4_free_ext_path(path);
 
 	/* Count the number of data blocks */
 	cur = 0;
@@ -6100,32 +6097,28 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 	ret = skip_hole(inode, &cur);
 	if (ret < 0)
 		goto out;
-	path = ext4_find_extent(inode, cur, NULL, 0);
+	path = ext4_find_extent(inode, cur, path, 0);
 	if (IS_ERR(path))
 		goto out;
 	numblks += path->p_depth;
-	ext4_free_ext_path(path);
 	while (cur < end) {
-		path = ext4_find_extent(inode, cur, NULL, 0);
+		path = ext4_find_extent(inode, cur, path, 0);
 		if (IS_ERR(path))
 			break;
 		ex = path[path->p_depth].p_ext;
-		if (!ex) {
-			ext4_free_ext_path(path);
-			return 0;
-		}
+		if (!ex)
+			goto cleanup;
+
 		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
 					ext4_ext_get_actual_len(ex));
 		ret = skip_hole(inode, &cur);
-		if (ret < 0) {
-			ext4_free_ext_path(path);
+		if (ret < 0)
 			break;
-		}
-		path2 = ext4_find_extent(inode, cur, NULL, 0);
-		if (IS_ERR(path2)) {
-			ext4_free_ext_path(path);
+
+		path2 = ext4_find_extent(inode, cur, path2, 0);
+		if (IS_ERR(path2))
 			break;
-		}
+
 		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
 			cmp1 = cmp2 = 0;
 			if (i <= path->p_depth)
@@ -6137,13 +6130,14 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
 			if (cmp1 != cmp2 && cmp2 != 0)
 				numblks++;
 		}
-		ext4_free_ext_path(path);
-		ext4_free_ext_path(path2);
 	}
 
 out:
 	inode->i_blocks = numblks << (inode->i_sb->s_blocksize_bits - 9);
 	ext4_mark_inode_dirty(NULL, inode);
+cleanup:
+	ext4_free_ext_path(path);
+	ext4_free_ext_path(path2);
 	return 0;
 }
 
@@ -6164,12 +6158,9 @@ int ext4_ext_clear_bb(struct inode *inode)
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	ex = path[path->p_depth].p_ext;
-	if (!ex) {
-		ext4_free_ext_path(path);
-		return 0;
-	}
+	if (!ex)
+		goto out;
 	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
-	ext4_free_ext_path(path);
 
 	cur = 0;
 	while (cur < end) {
@@ -6179,16 +6170,16 @@ int ext4_ext_clear_bb(struct inode *inode)
 		if (ret < 0)
 			break;
 		if (ret > 0) {
-			path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
-			if (!IS_ERR_OR_NULL(path)) {
+			path = ext4_find_extent(inode, map.m_lblk, path, 0);
+			if (!IS_ERR(path)) {
 				for (j = 0; j < path->p_depth; j++) {
-
 					ext4_mb_mark_bb(inode->i_sb,
 							path[j].p_block, 1, false);
 					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
 							0, path[j].p_block, 1, 1);
 				}
-				ext4_free_ext_path(path);
+			} else {
+				path = NULL;
 			}
 			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
@@ -6197,5 +6188,7 @@ int ext4_ext_clear_bb(struct inode *inode)
 		cur = cur + map.m_len;
 	}
 
+out:
+	ext4_free_ext_path(path);
 	return 0;
 }
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 52e42cb02f39..7ab3290b49e3 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1772,7 +1772,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 		if (ret == 0) {
 			/* Range is not mapped */
-			path = ext4_find_extent(inode, cur, NULL, 0);
+			path = ext4_find_extent(inode, cur, path, 0);
 			if (IS_ERR(path))
 				goto out;
 			memset(&newex, 0, sizeof(newex));
@@ -1788,7 +1788,6 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			up_write((&EXT4_I(inode)->i_data_sem));
 			if (IS_ERR(path))
 				goto out;
-			ext4_free_ext_path(path);
 			goto next;
 		}
 
@@ -1836,6 +1835,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
 out:
+	ext4_free_ext_path(path);
 	iput(inode);
 	return 0;
 }
@@ -1936,12 +1936,13 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 				break;
 
 			if (ret > 0) {
-				path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
+				path = ext4_find_extent(inode, map.m_lblk, path, 0);
 				if (!IS_ERR(path)) {
 					for (j = 0; j < path->p_depth; j++)
 						ext4_mb_mark_bb(inode->i_sb,
 							path[j].p_block, 1, true);
-					ext4_free_ext_path(path);
+				} else {
+					path = NULL;
 				}
 				cur += ret;
 				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
@@ -1952,6 +1953,8 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 		}
 		iput(inode);
 	}
+
+	ext4_free_ext_path(path);
 }
 
 /*
-- 
2.39.2


