Return-Path: <linux-ext4+bounces-121-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE577F5F86
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A25E1C2100B
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9C24B20;
	Thu, 23 Nov 2023 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21BD47;
	Thu, 23 Nov 2023 04:52:05 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SbdKr4SVPz4f3jsV;
	Thu, 23 Nov 2023 20:52:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F8B21A021D;
	Thu, 23 Nov 2023 20:52:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S11;
	Thu, 23 Nov 2023 20:52:02 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 07/18] ext4: allow reserving multi-delayed blocks
Date: Thu, 23 Nov 2023 20:51:09 +0800
Message-Id: <20231123125121.4064694-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S11
X-Coremail-Antispam: 1UD129KBjvJXoW3GryxZw48WFW5tr15Kw4fuFg_yoWDGFyUpF
	Z8CF1UGrW3W34vgaySqr4UZr1Sga48trWUJr9Igr1fZFyrJFySgF1DtF15ZFyrtrZ5GFn0
	qFWYy34Uua1UKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new helper ext4_insert_delayed_blocks() to support adding
multi-delayed blocks into the extent status tree, it doesn't support
bigalloc feature yet. Also rename ext4_es_insert_delayed_block() to
ext4_es_insert_delayed_extent(), which matches the name style of other
ext4_es_{insert|remove}_extent() helpers.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c    | 20 +++++----
 fs/ext4/extents_status.h    |  4 +-
 fs/ext4/inode.c             | 82 ++++++++++++++++++++++++-------------
 include/trace/events/ext4.h | 12 +++---
 4 files changed, 74 insertions(+), 44 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 19a0cc904cd8..c8783b4009ec 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -2043,19 +2043,21 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
 }
 
 /*
- * ext4_es_insert_delayed_block - adds a delayed block to the extents status
- *                                tree, adding a pending reservation where
- *                                needed
+ * ext4_es_insert_delayed_extent - adds delayed blocks to the extents status
+ *                                 tree, adding a pending reservation where
+ *                                 needed
  *
  * @inode - file containing the newly added block
- * @lblk - logical block to be added
+ * @lblk - first logical block to be added
+ * @len - length of blocks to be added
  * @allocated - indicates whether a physical cluster has been allocated for
  *              the logical cluster that contains the block
  */
-void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-				  bool allocated)
+void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
+				   unsigned int len, bool allocated)
 {
 	struct extent_status newes;
+	ext4_lblk_t end = lblk + len - 1;
 	int err1 = 0;
 	int err2 = 0;
 	struct extent_status *es1 = NULL;
@@ -2068,9 +2070,9 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		 lblk, inode->i_ino);
 
 	newes.es_lblk = lblk;
-	newes.es_len = 1;
+	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
-	trace_ext4_es_insert_delayed_block(inode, &newes, allocated);
+	trace_ext4_es_insert_delayed_extent(inode, &newes, allocated);
 
 	ext4_es_insert_extent_check(inode, &newes);
 
@@ -2081,7 +2083,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		es2 = __es_alloc_extent(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4f69322dd626..4ccc965a9876 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -251,8 +251,8 @@ extern void ext4_exit_pending(void);
 extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
 extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
 extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
-extern void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
-					 bool allocated);
+extern void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
+					  unsigned int len, bool allocated);
 extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 					ext4_lblk_t len);
 extern void ext4_clear_inode_es(struct inode *inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 17fe2bd83617..e92b205b3b24 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1462,7 +1462,7 @@ static int ext4_journalled_write_end(struct file *file,
 /*
  * Reserve space for a single cluster
  */
-static int ext4_da_reserve_space(struct inode *inode)
+static int ext4_da_reserve_space(struct inode *inode, unsigned int len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -1473,18 +1473,18 @@ static int ext4_da_reserve_space(struct inode *inode)
 	 * us from metadata over-estimation, though we may go over by
 	 * a small amount in the end.  Here we just reserve for data.
 	 */
-	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, 1));
+	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, len));
 	if (ret)
 		return ret;
 
 	spin_lock(&ei->i_block_reservation_lock);
-	if (ext4_claim_free_clusters(sbi, 1, 0)) {
+	if (ext4_claim_free_clusters(sbi, len, 0)) {
 		spin_unlock(&ei->i_block_reservation_lock);
-		dquot_release_reservation_block(inode, EXT4_C2B(sbi, 1));
+		dquot_release_reservation_block(inode, EXT4_C2B(sbi, len));
 		return -ENOSPC;
 	}
-	ei->i_reserved_data_blocks++;
-	trace_ext4_da_reserve_space(inode);
+	ei->i_reserved_data_blocks += len;
+	trace_ext4_da_reserve_space(inode, len);
 	spin_unlock(&ei->i_block_reservation_lock);
 
 	return 0;       /* success */
@@ -1630,6 +1630,37 @@ static void ext4_print_free_blocks(struct inode *inode)
 	return;
 }
 
+
+/*
+ * ext4_insert_delayed_blocks - adds multi-delayed blocks to the extents
+ *                              status tree, incrementing the reserved
+ *                              cluster/block count or making a pending
+ *                              reservation where needed.
+ *
+ * @inode - file containing the newly added block
+ * @lblk - start logical block to be added
+ * @len - length of blocks to be added
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
+				      ext4_lblk_t len)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	int ret;
+
+	/* TODO: support bigalloc and replace ext4_insert_delayed_block(). */
+	if (sbi->s_cluster_ratio != 1)
+		return -EOPNOTSUPP;
+
+	ret = ext4_da_reserve_space(inode, len);
+	if (ret)   /* ENOSPC */
+		return ret;
+
+	ext4_es_insert_delayed_extent(inode, lblk, len, false);
+	return 0;
+}
+
 /*
  * ext4_insert_delayed_block - adds a delayed block to the extents status
  *                             tree, incrementing the reserved cluster/block
@@ -1647,10 +1678,13 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	int ret;
 	bool allocated = false;
 
+	if (sbi->s_cluster_ratio == 1)
+		return ext4_insert_delayed_blocks(inode, lblk, 1);
+
 	/*
-	 * If the cluster containing lblk is shared with a delayed,
-	 * written, or unwritten extent in a bigalloc file system, it's
-	 * already been accounted for and does not need to be reserved.
+	 * For bigalloc, if the cluster containing lblk is shared with a
+	 * delayed, written, or unwritten extent in a bigalloc file system,
+	 * it's already been accounted for and does not need to be reserved.
 	 * A pending reservation must be made for the cluster if it's
 	 * shared with a written or unwritten extent and doesn't already
 	 * have one.  Written and unwritten extents can be purged from the
@@ -1658,32 +1692,24 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	 * it's necessary to examine the extent tree if a search of the
 	 * extents status tree doesn't get a match.
 	 */
-	if (sbi->s_cluster_ratio == 1) {
-		ret = ext4_da_reserve_space(inode);
-		if (ret != 0)   /* ENOSPC */
-			return ret;
-	} else {   /* bigalloc */
-		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
-			if (!ext4_es_scan_clu(inode,
-					      &ext4_es_is_mapped, lblk)) {
-				ret = ext4_clu_mapped(inode,
-						      EXT4_B2C(sbi, lblk));
-				if (ret < 0)
+	if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
+		if (!ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk)) {
+			ret = ext4_clu_mapped(inode, EXT4_B2C(sbi, lblk));
+			if (ret < 0)
+				return ret;
+			if (ret == 0) {
+				ret = ext4_da_reserve_space(inode, 1);
+				if (ret != 0)   /* ENOSPC */
 					return ret;
-				if (ret == 0) {
-					ret = ext4_da_reserve_space(inode);
-					if (ret != 0)   /* ENOSPC */
-						return ret;
-				} else {
-					allocated = true;
-				}
 			} else {
 				allocated = true;
 			}
+		} else {
+			allocated = true;
 		}
 	}
 
-	ext4_es_insert_delayed_block(inode, lblk, allocated);
+	ext4_es_insert_delayed_extent(inode, lblk, 1, allocated);
 	return 0;
 }
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 84421cecec0b..6b871d42b259 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1249,14 +1249,15 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 );
 
 TRACE_EVENT(ext4_da_reserve_space,
-	TP_PROTO(struct inode *inode),
+	TP_PROTO(struct inode *inode, int reserved_blocks),
 
-	TP_ARGS(inode),
+	TP_ARGS(inode, reserved_blocks),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
+		__field(	int,	reserved_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	__u16,  mode			)
 	),
@@ -1265,16 +1266,17 @@ TRACE_EVENT(ext4_da_reserve_space,
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
+		__entry->reserved_blocks = reserved_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
+	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu reserved_blocks %u "
 		  "reserved_data_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->reserved_data_blocks)
+		  __entry->reserved_blocks, __entry->reserved_data_blocks)
 );
 
 TRACE_EVENT(ext4_da_release_space,
@@ -2509,7 +2511,7 @@ TRACE_EVENT(ext4_es_shrink,
 		  __entry->scan_time, __entry->nr_skipped, __entry->retried)
 );
 
-TRACE_EVENT(ext4_es_insert_delayed_block,
+TRACE_EVENT(ext4_es_insert_delayed_extent,
 	TP_PROTO(struct inode *inode, struct extent_status *es,
 		 bool allocated),
 
-- 
2.39.2


