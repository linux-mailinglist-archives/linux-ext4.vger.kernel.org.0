Return-Path: <linux-ext4+bounces-11101-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042C9C0D9DC
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47E140445E
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FF3101C4;
	Mon, 27 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HzcGr6ns"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085B301716
	for <linux-ext4@vger.kernel.org>; Mon, 27 Oct 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568261; cv=none; b=sqyoq1JbgX1IiLnikKHQ9qwPNejXOBth+eMplXcKEZIQiYlu95hqR1LXRDF+6ODOezmzXfj0GG5GZVJqIJC0TA2KIBZms7X4wxZIGyQWVZIAx7o0hI5vwmnIdcod7QMoy+MgLy3S/ea0f+SKen3U6HbQ3ISJ+UdKy8A2OipJidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568261; c=relaxed/simple;
	bh=CFY1puFCq69gLHjykwMx+vg4VfBNHnhMHqyc1JzcVcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jY9R8899wAXqO8ol/KkNQGerAUQp06fDfmisw552VLJUq63RQq1udSgcqD7Ypm7LtsX+Ker0U9sqYOfunj5w96sK6SCHmKbJwvp+Klotk8ZPzPx6YjgyGVwUrl7yOAYqGTfGYgvcV2Wl2NLWnjffb0VwX9chk5+1pDbG3feMHtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HzcGr6ns; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=quIleMzgdA+w71XvYUxaOkrAh4q28mCMbUfCJJk6SwI=;
	b=HzcGr6nsG7lCeGLJq1ahJP7i6mS8wG8vbxoDKlcv204oPnUmAcV4NqHlwAZiKYsjzZxoqGI/q
	HYNrzs/gLjTnam4zaQzxON6p2gBt/kSgcSHwA0NVvCZDD2idkkRKSJVMHFLWcdCOCzPFIdr0j+n
	TtjMMqPBM/HHYRZ2Q78EWXs=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cwCWQ194hz1T4G8;
	Mon, 27 Oct 2025 20:29:54 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C0511402DA;
	Mon, 27 Oct 2025 20:30:55 +0800 (CST)
Received: from syn-076-053-033-115.biz.spectrum.com (10.50.87.129) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Oct 2025 20:30:54 +0800
From: Yang Erkun <yangerkun@huawei.com>
To: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>
CC: <yi.zhang@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<yangerkun@huaweicloud.com>
Subject: [PATCH 2/4] ext4: rename EXT4_GET_BLOCKS_PRE_IO
Date: Mon, 27 Oct 2025 20:23:01 +0800
Message-ID: <20251027122303.1146352-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20251027122303.1146352-1-yangerkun@huawei.com>
References: <20251027122303.1146352-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100006.china.huawei.com (7.202.181.220)

This flag has been generalized to split an unwritten extent when we do
dio or dioread_nolock writeback, or to avoid merge new extents which was
created by extents split. Update some related comments too.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/ext4/ext4.h              | 21 +++++++++++++++------
 fs/ext4/extents.c           | 16 ++++++++--------
 include/trace/events/ext4.h |  2 +-
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57087da6c7be..5a035d0e2761 100644
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
+	 * Means we cannot merge new allocated extent or split the unwritten
+	 * extent if we found one
+	 */
+#define EXT4_GET_BLOCKS_SPLIT_NOMERGE		0x0008
+	/*
+	 * Caller is from the dio or dioread_nolock buffer writeback,
+	 * request to creation of an unwritten extent if not exist or split
+	 * the found unwritten extent. Also do not merge the new create
+	 * unwritten extent, io end will convert unwritten to written, and
+	 * try to merge the written extent.
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


