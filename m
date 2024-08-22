Return-Path: <linux-ext4+bounces-3861-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA695AB25
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A61B1C244CF
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E107F17D374;
	Thu, 22 Aug 2024 02:40:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A381509A2;
	Thu, 22 Aug 2024 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294447; cv=none; b=NmW6zLSp22jn22ISov1NQqnfGlj6IMFyFewhEcN6Q6UiNOThh6IPuwZYMmDae6V9giWey5mJ6mwlcOdkuwZNQGx7jpQf2km86LaJ5ReUuPLfCuDqDkKu3jG6hTxJDZLiaKvmmaaO8ZOTZzlfIk8oBchJg0BmuXT5YtwW6qf8Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294447; c=relaxed/simple;
	bh=31YFK413P2p+uMOwqnKj4Ed0BCHi7txS3rRLOJOqfVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkwLswQOll7FehhZHuyP/yeJRAl1VM3IMRDQzvztFsu8rl76Tc11p+Mb9latTVEG88iwzL0GnGaLhiXWotX/22naq+ml5N7ux/ev5wA4GD6YpL5Y4vmR8JNwO+oYQpMU1gyQsIKhhPBsC7wri65hn45dFB6qYV/u6Ov2sM67UMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6rB74L8z4f3n69;
	Thu, 22 Aug 2024 10:40:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2044F1A1929;
	Thu, 22 Aug 2024 10:40:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S27;
	Thu, 22 Aug 2024 10:40:41 +0800 (CST)
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
Subject: [PATCH v2 23/25] ext4: refactor ext4_swap_extents() to reuse extents path
Date: Thu, 22 Aug 2024 10:35:43 +0800
Message-Id: <20240822023545.1994557-24-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S27
X-Coremail-Antispam: 1UD129KBjvJXoWxAr47Zw4rAw17GF1UXr43Wrg_yoWrCr18pF
	1a9Fn5GF93tFs8Kryaqw17Jw13Kw45GrWUGFZxWrn5Z3Z2vF4F9F1xt3WSyF4YgrZ5WFW3
	Zr1S9ry8uw1qqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEIQACs9

From: Baokun Li <libaokun1@huawei.com>

The ext4_find_extent() can update the extent path so it doesn't have to
allocate and free path repeatedly, thus reducing the consumption of memory
allocation and freeing in ext4_swap_extents().

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 48 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bc7b1dc13084..37b36b1abb16 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5699,25 +5699,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		int e1_len, e2_len, len;
 		int split = 0;
 
-		path1 = ext4_find_extent(inode1, lblk1, NULL, EXT4_EX_NOCACHE);
+		path1 = ext4_find_extent(inode1, lblk1, path1, EXT4_EX_NOCACHE);
 		if (IS_ERR(path1)) {
 			*erp = PTR_ERR(path1);
-			path1 = NULL;
-		finish:
-			count = 0;
-			goto repeat;
+			goto errout;
 		}
-		path2 = ext4_find_extent(inode2, lblk2, NULL, EXT4_EX_NOCACHE);
+		path2 = ext4_find_extent(inode2, lblk2, path2, EXT4_EX_NOCACHE);
 		if (IS_ERR(path2)) {
 			*erp = PTR_ERR(path2);
-			path2 = NULL;
-			goto finish;
+			goto errout;
 		}
 		ex1 = path1[path1->p_depth].p_ext;
 		ex2 = path2[path2->p_depth].p_ext;
 		/* Do we have something to swap ? */
 		if (unlikely(!ex2 || !ex1))
-			goto finish;
+			goto errout;
 
 		e1_blk = le32_to_cpu(ex1->ee_block);
 		e2_blk = le32_to_cpu(ex2->ee_block);
@@ -5739,7 +5735,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 				next2 = e2_blk;
 			/* Do we have something to swap */
 			if (next1 == EXT_MAX_BLOCKS || next2 == EXT_MAX_BLOCKS)
-				goto finish;
+				goto errout;
 			/* Move to the rightest boundary */
 			len = next1 - lblk1;
 			if (len < next2 - lblk2)
@@ -5749,7 +5745,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 			lblk1 += len;
 			lblk2 += len;
 			count -= len;
-			goto repeat;
+			continue;
 		}
 
 		/* Prepare left boundary */
@@ -5759,7 +5755,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 							   path1, lblk1, 0);
 			if (IS_ERR(path1)) {
 				*erp = PTR_ERR(path1);
-				goto finish;
+				goto errout;
 			}
 		}
 		if (e2_blk < lblk2) {
@@ -5768,13 +5764,13 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 							   path2, lblk2, 0);
 			if (IS_ERR(path2)) {
 				*erp = PTR_ERR(path2);
-				goto finish;
+				goto errout;
 			}
 		}
 		/* ext4_split_extent_at() may result in leaf extent split,
 		 * path must to be revalidated. */
 		if (split)
-			goto repeat;
+			continue;
 
 		/* Prepare right boundary */
 		len = count;
@@ -5789,7 +5785,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 							path1, lblk1 + len, 0);
 			if (IS_ERR(path1)) {
 				*erp = PTR_ERR(path1);
-				goto finish;
+				goto errout;
 			}
 		}
 		if (len != e2_len) {
@@ -5798,21 +5794,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 							path2, lblk2 + len, 0);
 			if (IS_ERR(path2)) {
 				*erp = PTR_ERR(path2);
-				goto finish;
+				goto errout;
 			}
 		}
 		/* ext4_split_extent_at() may result in leaf extent split,
 		 * path must to be revalidated. */
 		if (split)
-			goto repeat;
+			continue;
 
 		BUG_ON(e2_len != e1_len);
 		*erp = ext4_ext_get_access(handle, inode1, path1 + path1->p_depth);
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
 		*erp = ext4_ext_get_access(handle, inode2, path2 + path2->p_depth);
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
 
 		/* Both extents are fully inside boundaries. Swap it now */
 		tmp_ex = *ex1;
@@ -5830,7 +5826,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		*erp = ext4_ext_dirty(handle, inode2, path2 +
 				      path2->p_depth);
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
 		*erp = ext4_ext_dirty(handle, inode1, path1 +
 				      path1->p_depth);
 		/*
@@ -5840,17 +5836,17 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		 * aborted anyway.
 		 */
 		if (unlikely(*erp))
-			goto finish;
+			goto errout;
+
 		lblk1 += len;
 		lblk2 += len;
 		replaced_count += len;
 		count -= len;
-
-	repeat:
-		ext4_free_ext_path(path1);
-		ext4_free_ext_path(path2);
-		path1 = path2 = NULL;
 	}
+
+errout:
+	ext4_free_ext_path(path1);
+	ext4_free_ext_path(path2);
 	return replaced_count;
 }
 
-- 
2.39.2


