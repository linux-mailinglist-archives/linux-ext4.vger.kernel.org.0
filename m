Return-Path: <linux-ext4+bounces-3847-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7095AB08
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046B7285090
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9FF4436A;
	Thu, 22 Aug 2024 02:40:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33291D556;
	Thu, 22 Aug 2024 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294441; cv=none; b=JWK+LeshrjsirKyfMH/yC7eq+1YZ5kFNv7AoYyvdzO/zP0K4M6lreaUbS4qOL0LskmbNNz9ZSiEqLoLDcgKD7U1/pvoroC9CgRDU5ZOYGH2fg7MbSwfWicYD76eJPJ+MOKD+o4hcHnvaZnw1JXVPA6aGOAPFD/bwjR2ppCQAjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294441; c=relaxed/simple;
	bh=RgmNB8LuzxrYvh+yl33SHHehMeLOHf0XmS/yY93Pq7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R897sATUvXbmSsyZeNpwh0koOdepfRtFQFusi5aJ7Dy8iyCPXbdUeq5Pm3vSuyW1yG41iugIIyawQZzM+JOrVxvF6XhTjQ5r7fl0pg6bOQtf5FwD4yc3uACxWZNsLTvxRiCt3yQzpLcIB4VAGjagzZQnd91MdQxWO2XzRGHLGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r51pp9z4f3jY9;
	Thu, 22 Aug 2024 10:40:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 745A91A18EE;
	Thu, 22 Aug 2024 10:40:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S13;
	Thu, 22 Aug 2024 10:40:35 +0800 (CST)
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
Subject: [PATCH v2 09/25] ext4: add new ext4_ext_path_brelse() helper
Date: Thu, 22 Aug 2024 10:35:29 +0800
Message-Id: <20240822023545.1994557-10-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGr18uF1rKF1ftF17Xry3CFg_yoW5GF43pF
	4ayr1DurWrta9I9FZ2qr4UZw1Sy3WfC3y8JrWakr1v93W7Jr1FqFyxtF40vFyayFW8WFWa
	vFWjyw1Utr45taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYl19UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DdgABsL

From: Baokun Li <libaokun1@huawei.com>

Add ext4_ext_path_brelse() helper function to reduce duplicate code
and ensure that path->p_bh is set to NULL after it is released.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c4a4573440c1..5e760d1a0eff 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -106,6 +106,12 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 	return 0;
 }
 
+static inline void ext4_ext_path_brelse(struct ext4_ext_path *path)
+{
+	brelse(path->p_bh);
+	path->p_bh = NULL;
+}
+
 static void ext4_ext_drop_refs(struct ext4_ext_path *path)
 {
 	int depth, i;
@@ -113,10 +119,8 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
 	if (!path)
 		return;
 	depth = path->p_depth;
-	for (i = 0; i <= depth; i++, path++) {
-		brelse(path->p_bh);
-		path->p_bh = NULL;
-	}
+	for (i = 0; i <= depth; i++, path++)
+		ext4_ext_path_brelse(path);
 }
 
 void ext4_free_ext_path(struct ext4_ext_path *path)
@@ -635,8 +639,7 @@ int ext4_ext_precache(struct inode *inode)
 		 */
 		if ((i == depth) ||
 		    path[i].p_idx > EXT_LAST_INDEX(path[i].p_hdr)) {
-			brelse(path[i].p_bh);
-			path[i].p_bh = NULL;
+			ext4_ext_path_brelse(path + i);
 			i--;
 			continue;
 		}
@@ -1889,8 +1892,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
 		(path[1].p_ext - EXT_FIRST_EXTENT(path[1].p_hdr));
 	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
 
-	brelse(path[1].p_bh);
-	path[1].p_bh = NULL;
+	ext4_ext_path_brelse(path + 1);
 	ext4_free_blocks(handle, inode, NULL, blk, 1,
 			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 }
@@ -2959,8 +2961,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			err = ext4_ext_rm_leaf(handle, inode, path,
 					       &partial, start, end);
 			/* root level has p_bh == NULL, brelse() eats this */
-			brelse(path[i].p_bh);
-			path[i].p_bh = NULL;
+			ext4_ext_path_brelse(path + i);
 			i--;
 			continue;
 		}
@@ -3022,8 +3023,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				err = ext4_ext_rm_idx(handle, inode, path, i);
 			}
 			/* root level has p_bh == NULL, brelse() eats this */
-			brelse(path[i].p_bh);
-			path[i].p_bh = NULL;
+			ext4_ext_path_brelse(path + i);
 			i--;
 			ext_debug(inode, "return to level %d\n", i);
 		}
-- 
2.39.2


