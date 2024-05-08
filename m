Return-Path: <linux-ext4+bounces-2360-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEEA8BF61D
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B6F1F23796
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2024 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A13A29B;
	Wed,  8 May 2024 06:22:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680C1803A;
	Wed,  8 May 2024 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149367; cv=none; b=UJEYZRulvb5/YYP+EkztjQ8WDuCoTGyQLlSGISduwxmrl2VTjDBapdEQtkFHR9gHDhMgQ2jTxXi8ULlcX08v2Pj9KzxcdqJoUrWoPYZgh1znBrG4Cg/GxjkSBM7PGSAcRWYmIstcaFidd8yuByIrJQZK8ffCR31Y8L2eLzSvw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149367; c=relaxed/simple;
	bh=UAQXO2H/MvimmOjIhkQjSDMQ6f11fAXGXPCR6bolI9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdxJo1A6u4oZiWs+x5tjEcYgcz4et435YV/i+ixAFSIFCxyfOMpWLQynMY7rIpdm+EJkmZqfqUVOh6WWR3OhOluzNre6XxAbYHpFluf8VyrpmHxm9d+HGlAfxdyFOWN1pueC5FYRE14ciUqedrqIpV07pKViwFFtaOZS4WFDbqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZ4nS64pSz4f3jjs;
	Wed,  8 May 2024 14:22:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 28BE81A058D;
	Wed,  8 May 2024 14:22:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6REbGjtm9_1NMA--.61952S13;
	Wed, 08 May 2024 14:22:42 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 09/10] ext4: make ext4_insert_delayed_block() insert multi-blocks
Date: Wed,  8 May 2024 14:12:19 +0800
Message-Id: <20240508061220.967970-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6REbGjtm9_1NMA--.61952S13
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1DuF47Zw13JF13CF1Utrb_yoWrJw45pr
	Z8CF1fJrWYgr92gFsaqr1DXr1aga1ktFWDJFZIg3WrZrWfJF1fKF1DtF13XF1SkrWkJa1Y
	vFWYy347uan0ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Rename ext4_insert_delayed_block() to ext4_insert_delayed_blocks(),
pass length parameter to make it insert multiple delalloc blocks at a
time. For non-bigalloc case, just reserve len blocks and insert delalloc
extent. For bigalloc case, we can ensure that the clusters in the middle
of a extent must be unallocated, we only need to check whether the start
and end clusters are delayed/allocated. We should subtract the space for
the start and/or end block(s) if they are allocated.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6e418d3f8e87..c56386d1b10d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1678,24 +1678,29 @@ static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
 }
 
 /*
- * ext4_insert_delayed_block - adds a delayed block to the extents status
- *                             tree, incrementing the reserved cluster/block
- *                             count or making a pending reservation
- *                             where needed
+ * ext4_insert_delayed_blocks - adds a multiple delayed blocks to the extents
+ *                              status tree, incrementing the reserved
+ *                              cluster/block count or making pending
+ *                              reservations where needed
  *
  * @inode - file containing the newly added block
- * @lblk - logical block to be added
+ * @lblk - start logical block to be added
+ * @len - length of blocks to be added
  *
  * Returns 0 on success, negative error code on failure.
  */
-static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
+static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
+				      ext4_lblk_t len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
-	bool allocated = false;
+	bool lclu_allocated = false;
+	bool end_allocated = false;
+	ext4_lblk_t resv_clu;
+	ext4_lblk_t end = lblk + len - 1;
 
 	/*
-	 * If the cluster containing lblk is shared with a delayed,
+	 * If the cluster containing lblk or end is shared with a delayed,
 	 * written, or unwritten extent in a bigalloc file system, it's
 	 * already been accounted for and does not need to be reserved.
 	 * A pending reservation must be made for the cluster if it's
@@ -1706,21 +1711,36 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	 * extents status tree doesn't get a match.
 	 */
 	if (sbi->s_cluster_ratio == 1) {
-		ret = ext4_da_reserve_space(inode, 1);
+		ret = ext4_da_reserve_space(inode, len);
 		if (ret != 0)   /* ENOSPC */
 			return ret;
 	} else {   /* bigalloc */
-		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
+		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) + 1;
+
+		ret = ext4_da_check_clu_allocated(inode, lblk, &lclu_allocated);
 		if (ret < 0)
 			return ret;
-		if (ret > 0) {
-			ret = ext4_da_reserve_space(inode, 1);
+		if (ret == 0)
+			resv_clu--;
+
+		if (EXT4_B2C(sbi, lblk) != EXT4_B2C(sbi, end)) {
+			ret = ext4_da_check_clu_allocated(inode, end,
+							  &end_allocated);
+			if (ret < 0)
+				return ret;
+			if (ret == 0)
+				resv_clu--;
+		}
+
+		if (resv_clu) {
+			ret = ext4_da_reserve_space(inode, resv_clu);
 			if (ret != 0)   /* ENOSPC */
 				return ret;
 		}
 	}
 
-	ext4_es_insert_delayed_extent(inode, lblk, 1, allocated, false);
+	ext4_es_insert_delayed_extent(inode, lblk, len, lclu_allocated,
+				      end_allocated);
 	return 0;
 }
 
@@ -1825,7 +1845,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
 		}
 	}
 
-	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval;
-- 
2.39.2


