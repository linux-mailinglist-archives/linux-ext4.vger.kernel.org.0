Return-Path: <linux-ext4+bounces-3154-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062CE92C98E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A201F23AAC
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989B25A0F5;
	Wed, 10 Jul 2024 04:09:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE53F9EC;
	Wed, 10 Jul 2024 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584557; cv=none; b=tEi3TbwiDVA1unMJlRwax6QRQ7n0g8OiTN0B76cTGOrE6e8eACqU1VFS0JC+ix+C7Cnf4xDoHfVcvh4eoE74N9448adMEyMW/OlDtus93exgDykueVfBFywCl7xuccPlikg5mB5azXt0o7boW6dIPNlwdshmWHuuyEyhdebRshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584557; c=relaxed/simple;
	bh=bpDgBwlCisGlUCSLJiZf56AS4PsdoeU+BCn9dasP3xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtSCKi5gAiWMXukrcES9fgEEnYNTE34Yu9P9znOOBv+LYm8kwfwMfSqjaTOvgDw2MLlTYpb8VPChPwVK3O/xmzOmdJLgZn4Martxz5SEM0vosbkoxH3fGaBRLxRX2Q5a25MHV/QXw4oou7mEyP6YTVzqx/S3RovuPbrs1zBx24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJkrB4ktXz4f3kpB;
	Wed, 10 Jul 2024 12:08:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4D8581A0181;
	Wed, 10 Jul 2024 12:09:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S8;
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
Subject: [PATCH 04/20] ext4: add new ext4_ext_path_brelse() helper
Date: Wed, 10 Jul 2024 12:06:38 +0800
Message-Id: <20240710040654.1714672-5-libaokun@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S8
X-Coremail-Antispam: 1UD129KBjvJXoW7ArW3Cw45uFWkZr4fJw1xAFb_yoW5JrW8pF
	4ayrn8CrWrtayagFZ7Xr4UZw1Sy3Z3Cw48JrWSkryvk3WUJr1FqFyxtF40vFy3tFW8WFya
	vFW8tw1Utr45taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7VUbfcTJUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAABV1jkH7IIwABs9

From: Baokun Li <libaokun1@huawei.com>

Add ext4_ext_path_brelse() helper function to reduce duplicate code
and ensure that path->p_bh is set to NULL after it is released.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 657baf3991c1..6e5b5baf3aa6 100644
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
@@ -1887,8 +1890,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
 		(path[1].p_ext - EXT_FIRST_EXTENT(path[1].p_hdr));
 	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
 
-	brelse(path[1].p_bh);
-	path[1].p_bh = NULL;
+	ext4_ext_path_brelse(path + 1);
 	ext4_free_blocks(handle, inode, NULL, blk, 1,
 			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 }
@@ -2956,8 +2958,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			err = ext4_ext_rm_leaf(handle, inode, path,
 					       &partial, start, end);
 			/* root level has p_bh == NULL, brelse() eats this */
-			brelse(path[i].p_bh);
-			path[i].p_bh = NULL;
+			ext4_ext_path_brelse(path + i);
 			i--;
 			continue;
 		}
@@ -3019,8 +3020,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
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


