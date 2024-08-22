Return-Path: <linux-ext4+bounces-3838-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541CF95AAF8
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620D41C224A9
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247111B285;
	Thu, 22 Aug 2024 02:40:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F712B72;
	Thu, 22 Aug 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294437; cv=none; b=H7j9hyq+0Yl+9if7osOH6umwLwVdCv6BcMfBIxG8bR5hrunewjEb/qDw00nu3J7SnwDLu2gEiAAcPsvv6Xl9nvxsDxyFLFoZyjsqbxhTFae2sKw6+MjbYwjueCCj8VESwT2CvpGFIF8oCvMy3v4Yf2a92WnH2x6YgMthHlj6lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294437; c=relaxed/simple;
	bh=IuB90C0vb46EIzBLWUliWwWa/a73BEWv7iziLgVLfgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKsujntDqK4SuE4hFaf0c3GYhEp2SI9LrEFMBCNlzohsj78XZDYoE55IxVxfn9g/QXricxkHJ3/UyQPkwk50kvLcqFtSbwpm/joq3fdX/rO6ZALgaQ7sjGm5lgWJ1nodho/Sy8U9HAwnjepMcWcA2RTWRmjR9ygOXCT+mObRStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6r02f9Pz4f3n66;
	Thu, 22 Aug 2024 10:40:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 806DB1A1473;
	Thu, 22 Aug 2024 10:40:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S5;
	Thu, 22 Aug 2024 10:40:31 +0800 (CST)
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
Subject: [PATCH v2 01/25] ext4: refactor ext4_ext_rm_idx() to index 'path'
Date: Thu, 22 Aug 2024 10:35:21 +0800
Message-Id: <20240822023545.1994557-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822023545.1994557-1-libaokun@huaweicloud.com>
References: <20240822023545.1994557-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4xZFy7KryDuF4kKFW3KFg_yoW5AFy7pF
	1ayrn5CrW8KrWj9FyxJF47Ar1293W7u34xGrWSk345uFyxXrnYqFyxtFWFyFWfAFWrWaya
	qFWrtF15t342y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1ku4UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWbFpP9DcQAAsN

From: Baokun Li <libaokun1@huawei.com>

As suggested by Honza in Link，modify ext4_ext_rm_idx() to leave 'path'
alone and just index it like ext4_ext_correct_indexes() does it. This
facilitates adding error handling later. No functional changes.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/all/20230216130305.nrbtd42tppxhbynn@quack3/
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
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


