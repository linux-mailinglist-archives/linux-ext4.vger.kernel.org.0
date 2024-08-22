Return-Path: <linux-ext4+bounces-3863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A699995AB29
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F65287B8D
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE94181334;
	Thu, 22 Aug 2024 02:40:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC7176AA5;
	Thu, 22 Aug 2024 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294449; cv=none; b=lTxhiyZmiaOSDSg5DlcNqi50bokkuv3RD9yea3dUiyD5A3FGxQF3qyeql3PdBsv/2vSIwIqRyDk+QYKOwaVreUMr2OCl5RinM2OdHyzWWoKXObStslRmeTIwViMvZstLE0soozwJuxhUhZTqHBc8y8s1/bgHHXpt7FiO5N+2nNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294449; c=relaxed/simple;
	bh=mWjNdXa9ZQMCkYs9dLLQcfo9hALBsireYH9ACWkdKss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQwCsMe9knN5ilh4zAISu/QMzsC/RHaIiau4xypcvQ8Y+JPI7FHGcFFLJyPG7UG9NksIiGotpagoVA+YHICPZaGDJ3lech6qkxiF1LF3jwZR9MxlD4U/9ZaJNGme3bBgK9BjxTdAZ+ASJadCdZGi+3EytI6z3HyJEXPHkZBc4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wq6rD69DBz4f3jdl;
	Thu, 22 Aug 2024 10:40:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 159391A148B;
	Thu, 22 Aug 2024 10:40:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S29;
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
Subject: [PATCH v2 25/25] ext4: save unnecessary indentation in ext4_ext_create_new_leaf()
Date: Thu, 22 Aug 2024 10:35:45 +0800
Message-Id: <20240822023545.1994557-26-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S29
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xWry7Gw4rXF1xtw1DJrb_yoW8tF43pF
	s3ZF93Gr1q93yq9rZ3Wa1UZr13K3W8Wr4UJFWSyr9YvFy3ArsaqF93ta4rZFWrJFZ7Zay2
	qrW0qw13Jw12qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEIgAAs8

From: Baokun Li <libaokun1@huawei.com>

Save an indentation level in ext4_ext_create_new_leaf() by removing
unnecessary 'else'. Besides, the variable 'ee_block' is declared to
avoid line breaks. No functional changes.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca1f946514dd..45ddc0692673 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1403,6 +1403,7 @@ ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 {
 	struct ext4_ext_path *curp;
 	int depth, i, err = 0;
+	ext4_lblk_t ee_block = le32_to_cpu(newext->ee_block);
 
 repeat:
 	i = depth = ext_depth(inode);
@@ -1424,33 +1425,30 @@ ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 			goto errout;
 
 		/* refill path */
-		path = ext4_find_extent(inode,
-				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    path, gb_flags);
+		path = ext4_find_extent(inode, ee_block, path, gb_flags);
 		return path;
-	} else {
-		/* tree is full, time to grow in depth */
-		err = ext4_ext_grow_indepth(handle, inode, mb_flags);
-		if (err)
-			goto errout;
+	}
 
-		/* refill path */
-		path = ext4_find_extent(inode,
-				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    path, gb_flags);
-		if (IS_ERR(path))
-			return path;
+	/* tree is full, time to grow in depth */
+	err = ext4_ext_grow_indepth(handle, inode, mb_flags);
+	if (err)
+		goto errout;
 
-		/*
-		 * only first (depth 0 -> 1) produces free space;
-		 * in all other cases we have to split the grown tree
-		 */
-		depth = ext_depth(inode);
-		if (path[depth].p_hdr->eh_entries == path[depth].p_hdr->eh_max) {
-			/* now we need to split */
-			goto repeat;
-		}
+	/* refill path */
+	path = ext4_find_extent(inode, ee_block, path, gb_flags);
+	if (IS_ERR(path))
+		return path;
+
+	/*
+	 * only first (depth 0 -> 1) produces free space;
+	 * in all other cases we have to split the grown tree
+	 */
+	depth = ext_depth(inode);
+	if (path[depth].p_hdr->eh_entries == path[depth].p_hdr->eh_max) {
+		/* now we need to split */
+		goto repeat;
 	}
+
 	return path;
 
 errout:
-- 
2.39.2


