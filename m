Return-Path: <linux-ext4+bounces-3851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E88095AB0F
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2940A2812B3
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2024 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B17E0E8;
	Thu, 22 Aug 2024 02:40:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8BA364A4;
	Thu, 22 Aug 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724294442; cv=none; b=vGe21iZLgizwIjOehsbcbOBNVNQUZIShAEOKZ+yzxPyY6NA0A13Ol5/AoNRCUpeXZD//Mj2KAqi7QO2SFopAfsADmD2s61wSOmLUdU1CkyFh46/UH8wxkDvEHAn47K7gnCjnivHuNgiQT5gT84kSFFKkDckoYQJRqvjAyODeUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724294442; c=relaxed/simple;
	bh=xc1admIHUgm6woBZQujD3hlMJFYg5pROu+RDX5I+iBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bWiMC7KjcRMePKbWbNZrHytNT9S420CwqrPl1opyrJSwM6Ur1K4oKbcCEjmc/xsgNRmH05uw6Oi0RLfrhY3TOoHJT6pAC+3Yqdp0v8OlJMw1DCkvbefCKy+C28NEYhp0kLMZfOqKJWbFchsH7xdJu25pSk6jfPOqbyyqBg97T/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wq6rC1f8Qz4f3jtF;
	Thu, 22 Aug 2024 10:40:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E37141A018D;
	Thu, 22 Aug 2024 10:40:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UapcZmqbd1CQ--.38129S16;
	Thu, 22 Aug 2024 10:40:36 +0800 (CST)
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
Subject: [PATCH v2 12/25] ext4: get rid of ppath in get_ext_path()
Date: Thu, 22 Aug 2024 10:35:32 +0800
Message-Id: <20240822023545.1994557-13-libaokun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCHr4UapcZmqbd1CQ--.38129S16
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kJrW7Kr48uw4xWw17Wrg_yoWrJrWDpF
	sayF1Ygr48XanFkrZ7Ka1UZr15Ka1rG3y7WryfGw1v9FW7Xr1F9F1Iy3WY9FyrKFW8WFWa
	vF4Fyr1UCa4UKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgADBWbFpZhEGwABsE

From: Baokun Li <libaokun1@huawei.com>

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

After getting rid of ppath in get_ext_path(), its caller may pass an error
pointer to ext4_free_ext_path(), so it needs to teach ext4_free_ext_path()
and ext4_ext_drop_refs() to skip the error pointer. No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c     |  5 +++--
 fs/ext4/move_extent.c | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 32d2f9c86ab2..adedf2d1e67e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -116,7 +116,7 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
 {
 	int depth, i;
 
-	if (!path)
+	if (IS_ERR_OR_NULL(path))
 		return;
 	depth = path->p_depth;
 	for (i = 0; i <= depth; i++, path++)
@@ -125,6 +125,8 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
 
 void ext4_free_ext_path(struct ext4_ext_path *path)
 {
+	if (IS_ERR_OR_NULL(path))
+		return;
 	ext4_ext_drop_refs(path);
 	kfree(path);
 }
@@ -4192,7 +4194,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	path = ext4_find_extent(inode, map->m_lblk, NULL, 0);
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
-		path = NULL;
 		goto out;
 	}
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b0ab19a913bf..a7186d63725a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -17,27 +17,23 @@
  * get_ext_path() - Find an extent path for designated logical block number.
  * @inode:	inode to be searched
  * @lblock:	logical block number to find an extent path
- * @ppath:	pointer to an extent path pointer (for output)
+ * @path:	pointer to an extent path
  *
- * ext4_find_extent wrapper. Return 0 on success, or a negative error value
- * on failure.
+ * ext4_find_extent wrapper. Return an extent path pointer on success,
+ * or an error pointer on failure.
  */
-static inline int
+static inline struct ext4_ext_path *
 get_ext_path(struct inode *inode, ext4_lblk_t lblock,
-		struct ext4_ext_path **ppath)
+	     struct ext4_ext_path *path)
 {
-	struct ext4_ext_path *path = *ppath;
-
-	*ppath = NULL;
 	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
 	if (IS_ERR(path))
-		return PTR_ERR(path);
+		return path;
 	if (path[ext_depth(inode)].p_ext == NULL) {
 		ext4_free_ext_path(path);
-		return -ENODATA;
+		return ERR_PTR(-ENODATA);
 	}
-	*ppath = path;
-	return 0;
+	return path;
 }
 
 /**
@@ -95,9 +91,11 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
 	int ret = 0;
 	ext4_lblk_t last = from + count;
 	while (from < last) {
-		*err = get_ext_path(inode, from, &path);
-		if (*err)
-			goto out;
+		path = get_ext_path(inode, from, path);
+		if (IS_ERR(path)) {
+			*err = PTR_ERR(path);
+			return ret;
+		}
 		ext = path[ext_depth(inode)].p_ext;
 		if (unwritten != ext4_ext_is_unwritten(ext))
 			goto out;
@@ -624,9 +622,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 		int offset_in_page;
 		int unwritten, cur_len;
 
-		ret = get_ext_path(orig_inode, o_start, &path);
-		if (ret)
+		path = get_ext_path(orig_inode, o_start, path);
+		if (IS_ERR(path)) {
+			ret = PTR_ERR(path);
 			goto out;
+		}
 		ex = path[path->p_depth].p_ext;
 		cur_blk = le32_to_cpu(ex->ee_block);
 		cur_len = ext4_ext_get_actual_len(ex);
-- 
2.39.2


