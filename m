Return-Path: <linux-ext4+bounces-3158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8692C995
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD2E284E5C
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F88172D;
	Wed, 10 Jul 2024 04:09:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5841C92;
	Wed, 10 Jul 2024 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584558; cv=none; b=b0ir2KP1OO+HNlQ/nWBo1Y+G8M5XAja5/CP4lyw0Y6pX+NVJJMV8tJgdVXb1Uc0SXCokMgGzoi8ulahB7RBe9P5IKJ/BfifZqKNjuzQ7YaUoZmRgMKZ0IZTdHHEL2E42d0s5z1KxXG03JmbwtPUFfkHwXthpJCu6kXlF0y+Eq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584558; c=relaxed/simple;
	bh=7OuiPW9+jHiQ71uVr5UCY09AfFNkHTbSqOYdMWKBSKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwcVpNXSMEDewwBfpqeBMkTNk63ieIcspRJUEDQShCoC7/2geYEi7GrLCT3cp7OYlka3i0oe4KYELlo49xCzvkLhTn9JweKOXXEHBdEmMR1cC9KkZDEqd4NGExLtUtcpJTuNQ8DTwiY3YJn4JwABMxbq1EB5rjx7XEcPbVj1I+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WJkr73rD6z4f3mJY;
	Wed, 10 Jul 2024 12:08:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 278801A0199;
	Wed, 10 Jul 2024 12:09:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S10;
	Wed, 10 Jul 2024 12:09:06 +0800 (CST)
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
Subject: [PATCH 06/20] ext4: avoid use-after-free in ext4_ext_show_leaf()
Date: Wed, 10 Jul 2024 12:06:40 +0800
Message-Id: <20240710040654.1714672-7-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S10
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xAr48XryDJr4UGrykKrg_yoW5GFy7pw
	nxur1DKr45JanFgFWDXa1kAr12ka1UGr47GrW7Krya9FW5Ja4FgFyxt3WFvFWrXFW8Xasx
	trW8ta4UGa43CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbfcTJUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAABV1jkH7IJAABs6

From: Baokun Li <libaokun1@huawei.com>

In ext4_find_extent(), path may be freed by error or be reallocated, so
using a previously saved *ppath may have been freed and thus may trigger
use-after-free, as follows:

ext4_split_extent
  path = *ppath;
  ext4_split_extent_at(ppath)
  path = ext4_find_extent(ppath)
  ext4_split_extent_at(ppath)
    // ext4_find_extent fails to free path
    // but zeroout succeeds
  ext4_ext_show_leaf(inode, path)
    eh = path[depth].p_hdr
    // path use-after-free !!!

Similar to ext4_split_extent_at(), we use *ppath directly as an input to
ext4_ext_show_leaf(). Fix a spelling error by the way.

Same problem in ext4_ext_handle_unwritten_extents(). Since 'path' is only
used in ext4_ext_show_leaf(), remove 'path' and use *ppath directly.

This issue is triggered only when EXT_DEBUG is defined and therefore does
not affect functionality.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3a70a0739af8..1660434fbfc7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3328,7 +3328,7 @@ static int ext4_split_extent_at(handle_t *handle,
 }
 
 /*
- * ext4_split_extents() splits an extent and mark extent which is covered
+ * ext4_split_extent() splits an extent and mark extent which is covered
  * by @map as split_flags indicates
  *
  * It may result in splitting the extent into multiple extents (up to three)
@@ -3404,7 +3404,7 @@ static int ext4_split_extent(handle_t *handle,
 			goto out;
 	}
 
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 out:
 	return err ? err : allocated;
 }
@@ -3869,14 +3869,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path **ppath, int flags,
 			unsigned int allocated, ext4_fsblk_t newblock)
 {
-	struct ext4_ext_path __maybe_unused *path = *ppath;
 	int ret = 0;
 	int err = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len, flags,
 		  allocated);
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 
 	/*
 	 * When writing into unwritten space, we should not fail to
@@ -3973,7 +3972,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	if (allocated > map->m_len)
 		allocated = map->m_len;
 	map->m_len = allocated;
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 out2:
 	return err ? err : allocated;
 }
-- 
2.39.2


