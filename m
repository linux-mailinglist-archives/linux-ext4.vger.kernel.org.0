Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D010C786BF3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbjHXJbG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbjHXJav (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3AEE67
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9d1gFqz4f3q3h
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S18;
        Thu, 24 Aug 2023 17:30:45 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 14/16] ext4: reserve extent blocks for delalloc
Date:   Thu, 24 Aug 2023 17:26:17 +0800
Message-Id: <20230824092619.1327976-15-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S18
X-Coremail-Antispam: 1UD129KBjvAXoW3uw4xGr48ZrWrCF15Xr4xZwb_yoW8Gw45Ko
        WaqF47Xws8ZrWDKrZ7CFykAFyxua9xGrWfJw1Fvw43CFyfXrnrC347t3W7Za43Xa1F9r4q
        q3s3Xrn8GFZ7JrZ3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYp7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
        Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
        84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJV
        W0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Now ext4 only reserve data block for delalloc in ext4_da_reserve_space(),
and switch to no delalloc mode if the space if the free blocks is less
than 150% of dirty blocks or the watermark. In the meantime,
'27dd43854227 ("ext4: introduce reserved space")' reserve some of the
file system space (2% or 4096 clusters, whichever is smaller). Both of
them could make sure that space is not exhausted when mapping delalloc
entries as much as possible, but cannot guarantee (Under high concurrent
writes, ext4_ext4_nonda_switch() does not work because it only read the
count on current CPU, and reserved_clusters can also be exhausted
easily). So it could lead to infinite loop in ext4_do_writepages(),
think about we have only one free block left and want to allocate a data
block and a new extent block in ext4_writepages().

ext4_do_writepages()
 // <-- 1
 mpage_map_and_submit_extent()
  mpage_map_one_extent()
   ext4_map_blocks()
    ext4_ext_map_blocks()
     ext4_mb_new_blocks() //allocate the last block
     ext4_ext_insert_extent //allocate failed
     ext4_free_blocks() //free the data block just allocated
     return -ENOSPC;
  ext4_count_free_clusters() //is true
  return -ENOSPC;
 --> goto 1 and infinite loop

One more thing, it could also lead to data lost and trigger below error
message.

  EXT4-fs (sda): delayed block allocation failed for inode
                 X at logical offset X with max blocks X with error -28
  EXT4-fs (sda): This should not happen!!  Data will be lost

The best solution is try to calculate and reserve extent blocks
(metadata blocks) that could be allocated when mapping a delalloc es
entry. The reservation is very tricky and is related to the continuity
of physical blocks. An effective way is to reserve for the worst-case,
which means every block is discontinuous and costs an extent entry,
ext4_map_worst_ext_blocks() does this calculation. We have already count
the total delayed data blocks in the ext4_es_tree, so we could use it
calculate to the worst metadata blocks that should reserved, and save it
in the prepared ei->i_reserved_ext_blocks, once the delalloc entry
mapped, recalculate it and release the unused reservation.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h              |  6 ++++--
 fs/ext4/extents_status.c    | 29 +++++++++++++++++++-------
 fs/ext4/inode.c             | 41 ++++++++++++++++++++++++++++---------
 include/trace/events/ext4.h | 25 +++++++++++++++-------
 4 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 11813382fbcc..67b12f9ffc50 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2998,9 +2998,11 @@ extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
-extern void ext4_da_release_space(struct inode *inode, unsigned int data_len);
+extern void ext4_da_release_space(struct inode *inode, unsigned int data_len,
+				  unsigned int total_da_len, long da_len);
 extern void ext4_da_update_reserve_space(struct inode *inode,
-					unsigned int data_len, int quota_claim);
+				unsigned int data_len, unsigned int total_da_len,
+				long da_len, int quota_claim);
 extern int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_fsblk_t pblk, ext4_lblk_t len);
 
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index b098c3316189..8e0dec27f967 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -789,17 +789,20 @@ static inline void ext4_es_insert_extent_check(struct inode *inode,
 #endif
 
 /*
- * Update total delay allocated extent length.
+ * Update and return total delay allocated extent length.
  */
-static inline void ext4_es_update_da_block(struct inode *inode, long es_len)
+static inline unsigned int ext4_es_update_da_block(struct inode *inode,
+						   long es_len)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 
 	if (!es_len)
-		return;
+		goto out;
 
 	tree->da_es_len += es_len;
 	es_debug("update da blocks %ld, to %u\n", es_len, tree->da_es_len);
+out:
+	return tree->da_es_len;
 }
 
 static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
@@ -870,6 +873,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
+	ext4_lblk_t da_blocks = 0;
 	int err1 = 0, err2 = 0, err3 = 0;
 	struct rsvd_info rinfo;
 	int pending = 0;
@@ -930,7 +934,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 			__es_free_extent(es1);
 		es1 = NULL;
 	}
-	ext4_es_update_da_block(inode, -rinfo.ndelonly_blk);
+	da_blocks = ext4_es_update_da_block(inode, -rinfo.ndelonly_blk);
 
 	err2 = __es_insert_extent(inode, &newes, es2);
 	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
@@ -975,6 +979,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * for any previously delayed allocated clusters.
 	 */
 	ext4_da_update_reserve_space(inode, rinfo.ndelonly_clu + pending,
+				     da_blocks, -rinfo.ndelonly_blk,
 				     !delayed && rinfo.ndelonly_blk);
 	if (err1 || err2 || err3 < 0)
 		goto retry;
@@ -1554,6 +1559,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			   ext4_lblk_t len)
 {
 	ext4_lblk_t end;
+	ext4_lblk_t da_blocks = 0;
 	struct rsvd_info rinfo;
 	int err = 0;
 	struct extent_status *es = NULL;
@@ -1587,13 +1593,14 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			__es_free_extent(es);
 		es = NULL;
 	}
-	ext4_es_update_da_block(inode, -rinfo.ndelonly_blk);
+	da_blocks = ext4_es_update_da_block(inode, -rinfo.ndelonly_blk);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err)
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	ext4_da_release_space(inode, rinfo.ndelonly_clu);
+	ext4_da_release_space(inode, rinfo.ndelonly_clu, da_blocks,
+			      -rinfo.ndelonly_blk);
 	return;
 }
 
@@ -2122,6 +2129,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 				  bool allocated)
 {
 	struct extent_status newes;
+	ext4_lblk_t da_blocks;
 	int err1 = 0, err2 = 0, err3 = 0;
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
@@ -2179,12 +2187,19 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		}
 	}
 
-	ext4_es_update_da_block(inode, newes.es_len);
+	da_blocks = ext4_es_update_da_block(inode, newes.es_len);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err1 || err2 || err3 < 0)
 		goto retry;
 
+	/*
+	 * New reserved meta space has been claimed for a single newly added
+	 * delayed block in ext4_da_reserve_space(), but most of the reserved
+	 * count of meta blocks could be merged, so recalculate it according
+	 * to latest total delayed blocks.
+	 */
+	ext4_da_update_reserve_space(inode, 0, da_blocks, newes.es_len, 0);
 	ext4_es_print_tree(inode);
 	ext4_print_pending_tree(inode);
 	return;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 38c47ce1333b..d714bf2e4171 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -332,6 +332,9 @@ static void __ext4_da_update_reserve_space(const char *where,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
+	if (!data_len && !ext_len)
+		return;
+
 	if (unlikely(data_len > ei->i_reserved_data_blocks ||
 		     ext_len > (long)ei->i_reserved_ext_blocks)) {
 		ext4_warning(inode->i_sb, "%s: ino %lu, clear %d,%d "
@@ -355,21 +358,30 @@ static void __ext4_da_update_reserve_space(const char *where,
  * ext4_discard_preallocations() from here.
  */
 void ext4_da_update_reserve_space(struct inode *inode, unsigned int data_len,
+				  unsigned int total_da_len, long da_len,
 				  int quota_claim)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	int ext_len = 0;
+	unsigned int new_ext_len;
+	int ext_len;
 
-	if (!data_len)
+	if (!data_len && !da_len)
 		return;
 
+	if (da_len)
+		new_ext_len = ext4_map_worst_ext_blocks(inode, total_da_len);
+
 	spin_lock(&ei->i_block_reservation_lock);
-	trace_ext4_da_update_reserve_space(inode, data_len, ext_len,
-					   quota_claim);
+	ext_len = da_len ? ei->i_reserved_ext_blocks - new_ext_len : 0;
+	trace_ext4_da_update_reserve_space(inode, data_len, total_da_len,
+					   ext_len, quota_claim);
 	__ext4_da_update_reserve_space(__func__, inode, data_len, ext_len);
 	spin_unlock(&ei->i_block_reservation_lock);
 
+	if (!data_len)
+		return;
+
 	/* Update quota subsystem for data blocks */
 	if (quota_claim)
 		dquot_claim_block(inode, EXT4_C2B(sbi, data_len));
@@ -1490,21 +1502,28 @@ static int ext4_da_reserve_space(struct inode *inode, unsigned int rsv_dlen,
 	return 0;       /* success */
 }
 
-void ext4_da_release_space(struct inode *inode, unsigned int data_len)
+void ext4_da_release_space(struct inode *inode, unsigned int data_len,
+			   unsigned int total_da_len, long da_len)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	int ext_len = 0;
+	unsigned int new_ext_len;
+	int ext_len;
 
-	if (!data_len)
+	if (!data_len && !da_len)
 		return;		/* Nothing to release, exit */
 
+	if (da_len)
+		new_ext_len = ext4_map_worst_ext_blocks(inode, total_da_len);
+
 	spin_lock(&ei->i_block_reservation_lock);
-	trace_ext4_da_release_space(inode, data_len, ext_len);
+	ext_len = da_len ? (ei->i_reserved_ext_blocks - new_ext_len) : 0;
+	trace_ext4_da_release_space(inode, data_len, total_da_len, ext_len);
 	__ext4_da_update_reserve_space(__func__, inode, data_len, ext_len);
 	spin_unlock(&ei->i_block_reservation_lock);
 
-	dquot_release_reservation_block(inode, EXT4_C2B(sbi, data_len));
+	if (data_len)
+		dquot_release_reservation_block(inode, EXT4_C2B(sbi, data_len));
 }
 
 /*
@@ -1629,6 +1648,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	unsigned int rsv_dlen = 1;
+	unsigned int rsv_extlen;
 	bool allocated = false;
 	int ret;
 
@@ -1662,7 +1682,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	ret = ext4_da_reserve_space(inode, rsv_dlen, 0);
+	rsv_extlen = ext4_map_worst_ext_blocks(inode, 1);
+	ret = ext4_da_reserve_space(inode, rsv_dlen, rsv_extlen);
 	if (ret)   /* ENOSPC */
 		return ret;
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index e1e9d7ead20f..6916b1c5dff6 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1216,16 +1216,18 @@ TRACE_EVENT(ext4_forget,
 TRACE_EVENT(ext4_da_update_reserve_space,
 	TP_PROTO(struct inode *inode,
 		 int data_blocks,
+		 unsigned int total_da_blocks,
 		 int meta_blocks,
 		 int quota_claim),
 
-	TP_ARGS(inode, data_blocks, meta_blocks, quota_claim),
+	TP_ARGS(inode, data_blocks, total_da_blocks, meta_blocks, quota_claim),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
 		__field(	int,	data_blocks		)
+		__field(	unsigned int, total_da_blocks	)
 		__field(	int,	meta_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	int,	reserved_ext_blocks	)
@@ -1238,6 +1240,7 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->data_blocks = data_blocks;
+		__entry->total_da_blocks = total_da_blocks;
 		__entry->meta_blocks = meta_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
@@ -1245,12 +1248,14 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu data_blocks %d meta_blocks %d "
+	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
+		  "data_blocks %d total_da_blocks %u meta_blocks %d "
 		  "reserved_data_blocks %d reserved_ext_blocks %d quota_claim %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->data_blocks, __entry->meta_blocks,
+		  __entry->data_blocks,
+		  __entry->total_da_blocks, __entry->meta_blocks,
 		  __entry->reserved_data_blocks, __entry->reserved_ext_blocks,
 		  __entry->quota_claim)
 );
@@ -1294,15 +1299,19 @@ TRACE_EVENT(ext4_da_reserve_space,
 );
 
 TRACE_EVENT(ext4_da_release_space,
-	TP_PROTO(struct inode *inode, int freed_blocks, int meta_blocks),
+	TP_PROTO(struct inode *inode,
+		 int freed_blocks,
+		 unsigned int total_da_blocks,
+		 int meta_blocks),
 
-	TP_ARGS(inode, freed_blocks, meta_blocks),
+	TP_ARGS(inode, freed_blocks, total_da_blocks, meta_blocks),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
 		__field(	int,	freed_blocks		)
+		__field(	unsigned int, total_da_blocks	)
 		__field(	int,	meta_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	int,	reserved_ext_blocks	)
@@ -1314,6 +1323,7 @@ TRACE_EVENT(ext4_da_release_space,
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->freed_blocks = freed_blocks;
+		__entry->total_da_blocks = total_da_blocks;
 		__entry->meta_blocks = meta_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
@@ -1321,12 +1331,13 @@ TRACE_EVENT(ext4_da_release_space,
 	),
 
 	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
-		  "freed_blocks %d meta_blocks %d"
+		  "freed_blocks %d total_da_blocks %u, meta_blocks %d"
 		  "reserved_data_blocks %d reserved_ext_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->freed_blocks, __entry->meta_blocks,
+		  __entry->freed_blocks,
+		  __entry->total_da_blocks, __entry->meta_blocks,
 		  __entry->reserved_data_blocks,
 		  __entry->reserved_ext_blocks)
 );
-- 
2.39.2

