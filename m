Return-Path: <linux-ext4+bounces-3150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BCF92C987
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 06:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289D31F24075
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2024 04:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5D4D8C0;
	Wed, 10 Jul 2024 04:09:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82F3C092;
	Wed, 10 Jul 2024 04:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584556; cv=none; b=YsbtfZKYlPpqqdGnD8yHRrBk6jpB6k2kU7q/4E5jXMH7mHyplyTyUZxl/4zMsrmraX/Z7n5qp7TrdQr7njJgEgEm1J8p7tTqcQj7RldjzRFbOsJnBR0zLITlY66y/DqbACKLfF8ZwAcuNtam5szjibVTNniu8/Xl/YswDUPxzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584556; c=relaxed/simple;
	bh=ykysJ0jIu2v2r6KTy4ZJ2qVAlIx9thwidx8uspBQ5RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpI6bV2GX1D4J0KqKnt5ZIH2fnH8yol0lztofYnnXg5vZEf77yWva6KMejaTob92VTuKfMRi8npi/zN99ri8bC6Ueqkl9EB/n1+gX2H60bt8H/dme1S4/nJAQ7yZj+cdk4fKdaW1PZZe7IrS7R3+//Ocz02TEthVya3KtjfY//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WJkr41RP3z4f3m7Y;
	Wed, 10 Jul 2024 12:08:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0E9111A0181;
	Wed, 10 Jul 2024 12:09:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIZdCY5mkoy3Bg--.14986S5;
	Wed, 10 Jul 2024 12:09:04 +0800 (CST)
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
Subject: [PATCH 01/20] ext4: refactor ext4_ext_rm_idx() to index 'path'
Date: Wed, 10 Jul 2024 12:06:35 +0800
Message-Id: <20240710040654.1714672-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710040654.1714672-1-libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAIZdCY5mkoy3Bg--.14986S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43GFy7tryrWr18Jw48tFb_yoW5WrWkpF
	1ayrn5Cr4jgrWj9FZ7GF47Ar1293W2934xGrWSk34ruFyxXrnYqFyxtFZYyFWfAFWrWaya
	qFWrt3W5t342y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjfUe9N3UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAABV1jkH7IIQAAs+

From: Baokun Li <libaokun1@huawei.com>

As suggested by Honza in Link，modify ext4_ext_rm_idx() to leave 'path'
alone and just index it like ext4_ext_correct_indexes() does it. This
facilitates adding error handling later. No functional changes.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/all/20230216130305.nrbtd42tppxhbynn@quack3/
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..bff3666c891a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2279,27 +2279,26 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 {
 	int err;
 	ext4_fsblk_t leaf;
+	int k = depth - 1;
 
 	/* free index block */
-	depth--;
-	path = path + depth;
-	leaf = ext4_idx_pblock(path->p_idx);
-	if (unlikely(path->p_hdr->eh_entries == 0)) {
-		EXT4_ERROR_INODE(inode, "path->p_hdr->eh_entries == 0");
+	leaf = ext4_idx_pblock(path[k].p_idx);
+	if (unlikely(path[k].p_hdr->eh_entries == 0)) {
+		EXT4_ERROR_INODE(inode, "path[%d].p_hdr->eh_entries == 0", k);
 		return -EFSCORRUPTED;
 	}
-	err = ext4_ext_get_access(handle, inode, path);
+	err = ext4_ext_get_access(handle, inode, path + k);
 	if (err)
 		return err;
 
-	if (path->p_idx != EXT_LAST_INDEX(path->p_hdr)) {
-		int len = EXT_LAST_INDEX(path->p_hdr) - path->p_idx;
+	if (path[k].p_idx != EXT_LAST_INDEX(path[k].p_hdr)) {
+		int len = EXT_LAST_INDEX(path[k].p_hdr) - path[k].p_idx;
 		len *= sizeof(struct ext4_extent_idx);
-		memmove(path->p_idx, path->p_idx + 1, len);
+		memmove(path[k].p_idx, path[k].p_idx + 1, len);
 	}
 
-	le16_add_cpu(&path->p_hdr->eh_entries, -1);
-	err = ext4_ext_dirty(handle, inode, path);
+	le16_add_cpu(&path[k].p_hdr->eh_entries, -1);
+	err = ext4_ext_dirty(handle, inode, path + k);
 	if (err)
 		return err;
 	ext_debug(inode, "index is empty, remove it, free block %llu\n", leaf);
@@ -2308,15 +2307,14 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
 	ext4_free_blocks(handle, inode, NULL, leaf, 1,
 			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 
-	while (--depth >= 0) {
-		if (path->p_idx != EXT_FIRST_INDEX(path->p_hdr))
+	while (--k >= 0) {
+		if (path[k + 1].p_idx != EXT_FIRST_INDEX(path[k + 1].p_hdr))
 			break;
-		path--;
-		err = ext4_ext_get_access(handle, inode, path);
+		err = ext4_ext_get_access(handle, inode, path + k);
 		if (err)
 			break;
-		path->p_idx->ei_block = (path+1)->p_idx->ei_block;
-		err = ext4_ext_dirty(handle, inode, path);
+		path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
+		err = ext4_ext_dirty(handle, inode, path + k);
 		if (err)
 			break;
 	}
-- 
2.39.2


