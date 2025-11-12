Return-Path: <linux-ext4+bounces-11811-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE22DC51413
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 10:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E0F3BCD56
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F392EE5FE;
	Wed, 12 Nov 2025 08:54:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC92FD7D3
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937676; cv=none; b=dMoQUdJijWwJOeyur3XYPjbNK22TDaOsk1zRA9c6hxLcvm7WNw8t1uhdv65BhkpZEIn1U65CQ/XYSsMZ7/f8gwyyFevZ3hoSowJepzVS6+a5ohwxCCwzwMXpNV3wPuKem8t8D9t/6bCCXUERgLAPWoqRlMasfB7YqN+unjXpwWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937676; c=relaxed/simple;
	bh=krBbr/hUOxMYPn7PsBR2s3hC6wVvENoFwA9CRWyVzX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=frxh1sMLC7LZpAt116Q6qfmROluUGK35EHx8+APgHtUClLdOh4R4dtMFGVRVEL76JmvxzORoWL9X2bVuTLU2bhFcZHY+UvbQBXRYifG2uER2pr8kEQdwicK8hs6hMSHclHeE9BL8M01BNfIco+y1/ofnDr5Gf5G4QDIWCHlJZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5xyx5xvWzYQvCF
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 16:54:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 002C71A08FC
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 16:54:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.129])
	by APP2 (Coremail) with SMTP id Syh0CgAHZXtASxRpyWXjAQ--.5900S5;
	Wed, 12 Nov 2025 16:54:29 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: yi.zhang@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v4 1/3] ext4: rename EXT4_GET_BLOCKS_PRE_IO
Date: Wed, 12 Nov 2025 16:45:36 +0800
Message-Id: <20251112084538.1658232-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251112084538.1658232-1-yangerkun@huawei.com>
References: <20251112084538.1658232-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAHZXtASxRpyWXjAQ--.5900S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4ktr4fur45uF1DGr48WFg_yoWxXFyrpr
	42vF1xJF4vqa4Uu3yxGF4jqr12vw1xGw4DAFWYg3yYkay5tryrtF1Yva4FkFyFgr4rZFn0
	vFWF934UKas3GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I
	0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ntx3UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

This flag has been generalized to split an unwritten extent when we do
dio or dioread_nolock writeback, or to avoid merge new extents which was
created by extents split. Update some related comments too.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/ext4/ext4.h              | 21 +++++++++++++++------
 fs/ext4/extents.c           | 16 ++++++++--------
 fs/ext4/inode.c             |  2 +-
 include/trace/events/ext4.h |  2 +-
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57087da6c7be..6ee0bc072589 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -694,13 +694,22 @@ enum {
 	/* Caller is from the delayed allocation writeout path
 	 * finally doing the actual allocation of delayed blocks */
 #define EXT4_GET_BLOCKS_DELALLOC_RESERVE	0x0004
-	/* caller is from the direct IO path, request to creation of an
-	unwritten extents if not allocated, split the unwritten
-	extent if blocks has been preallocated already*/
-#define EXT4_GET_BLOCKS_PRE_IO			0x0008
-#define EXT4_GET_BLOCKS_CONVERT			0x0010
-#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_PRE_IO|\
+	/*
+	 * This means that we cannot merge newly allocated extents, and if we
+	 * found an unwritten extent, we need to split it.
+	 */
+#define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
+	/*
+	 * Caller is from the dio or dioread_nolock buffered IO, reqest to
+	 * create an unwritten extent if it does not exist or split the
+	 * found unwritten extent. Also do not merge the newly created
+	 * unwritten extent, io end will convert unwritten to written,
+	 * and try to merge the written extent.
+	 */
+#define EXT4_GET_BLOCKS_IO_CREATE_EXT		(EXT4_GET_BLOCKS_SPLIT_NOMERGE|\
 					 EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT)
+	/* Convert unwritten extent to initialized. */
+#define EXT4_GET_BLOCKS_CONVERT			0x0010
 	/* Eventual metadata allocation (due to growing extent tree)
 	 * should not fail, so try to use reserved blocks for that.*/
 #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..241b5f5d29ad 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -333,7 +333,7 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 			   int nofail)
 {
 	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
-	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
+	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
 
 	if (nofail)
 		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
@@ -2002,7 +2002,7 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	}
 
 	/* try to insert block into found extent and return */
-	if (ex && !(gb_flags & EXT4_GET_BLOCKS_PRE_IO)) {
+	if (ex && !(gb_flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE)) {
 
 		/*
 		 * Try to see whether we should rather test the extent on
@@ -2181,7 +2181,7 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 
 merge:
 	/* try to merge extents */
-	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
+	if (!(gb_flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
 		ext4_ext_try_to_merge(handle, inode, path, nearex);
 
 	/* time to correct all indexes above */
@@ -3224,7 +3224,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 		else
 			ext4_ext_mark_initialized(ex);
 
-		if (!(flags & EXT4_GET_BLOCKS_PRE_IO))
+		if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
 			ext4_ext_try_to_merge(handle, inode, path, ex);
 
 		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
@@ -3368,7 +3368,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 
 	if (map->m_lblk + map->m_len < ee_block + ee_len) {
 		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
-		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
+		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
 		if (unwritten)
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
 				       EXT4_EXT_MARK_UNWRIT2;
@@ -3739,7 +3739,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 			      EXT4_EXT_MAY_ZEROOUT : 0;
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
 	}
-	flags |= EXT4_GET_BLOCKS_PRE_IO;
+	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
 	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
 				 allocated);
 }
@@ -3911,7 +3911,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 						*allocated, newblock);
 
 	/* get_block() before submitting IO, split the extent */
-	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
+	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
 				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
 		if (IS_ERR(path))
@@ -5618,7 +5618,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 			path = ext4_split_extent_at(handle, inode, path,
 					start_lblk, split_flag,
 					EXT4_EX_NOCACHE |
-					EXT4_GET_BLOCKS_PRE_IO |
+					EXT4_GET_BLOCKS_SPLIT_NOMERGE |
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
 		}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..05cf7768c4d7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -648,7 +648,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
 	 * If the extent has been zeroed out, we don't need to update
 	 * extent status tree.
 	 */
-	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
+	if (flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE &&
 	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		if (ext4_es_is_written(&es))
 			return retval;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a374e7ea7e57..ada2b9223df5 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -39,7 +39,7 @@ struct partial_cluster;
 	{ EXT4_GET_BLOCKS_CREATE,		"CREATE" },		\
 	{ EXT4_GET_BLOCKS_UNWRIT_EXT,		"UNWRIT" },		\
 	{ EXT4_GET_BLOCKS_DELALLOC_RESERVE,	"DELALLOC" },		\
-	{ EXT4_GET_BLOCKS_PRE_IO,		"PRE_IO" },		\
+	{ EXT4_GET_BLOCKS_SPLIT_NOMERGE,	"SPLIT_NOMERGE" },	\
 	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
 	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
 	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
-- 
2.39.2


