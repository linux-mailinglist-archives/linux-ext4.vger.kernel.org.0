Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED8786BF7
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbjHXJbI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240788AbjHXJat (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:49 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A0C198E
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9Y40l4z4f41Gl
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S10;
        Thu, 24 Aug 2023 17:30:42 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 06/16] ext4: move delalloc data reserve spcae updating into ext4_es_insert_extent()
Date:   Thu, 24 Aug 2023 17:26:09 +0800
Message-Id: <20230824092619.1327976-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S10
X-Coremail-Antispam: 1UD129KBjvJXoW3tw1UXw4ktFyfKF13tFW7twb_yoWkAFWUpr
        W3Kr13Jw15Xr1q9r4Iqw1UWr1Yga18trWUGrZ3tr18uFWrAF1S9F1ktF1rZFyUtrW8JFn0
        qFyY9w17ua1q9a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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

We update data reserved space for delalloc after allocating new blocks
in ext4_{ind|ext}_map_blocks(). If bigalloc feature is enabled, we also
need to query the extents_status tree to calculate the exact reserved
clusters. If we move it to ext4_es_insert_extent(), just after dropping
delalloc extents_status entry, it could become more simple because
__es_remove_extent() has done most of the work and we could remove
entire ext4_es_delayed_clu().

One important thing needs to take care of is that if bigalloc is
enabled, we should update data reserved count when first converting some
of the delayed only es entries of a caluster which has many other
delayed only entries left over.

  |                   one cluster                        |
  --------------------------------------------------------
  | da es 0 | .. | da es 1 | .. | da es 2 | .. | da es 3 |
  --------------------------------------------------------
  ^         ^
  |         | <- first allocating this delayed extent

The later allocations in that cluster will not count again. We could do
this by counting the new inserts pending clusters.

Another important thing is the quota claiming and i_blocks count, if
the delayed allocating has been raced by another no-delay allocating
(from fallocate, filemap, DIO...), we cannot claim quota as usual
because the racer have already done it. We could distinguish this case
easily through checking EXTENT_STATUS_DELAYED and the reserved only
blocks counted by __es_remove_extent(). If the EXTENT_STATUS_DELAYED is
set, it always means that the allocating is not from the delayed
allocating. But on the contrary, we can only get the opposite
conclusion if bigalloc is not enabled. If bigalloc is enabled, it could
be raced by another fallocate which is writing to other non-delayed
areas of the same cluster. In this case, the EXTENT_STATUS_DELAYED is
not set but we cannot claim quota again.

  |             one cluster                 |
  -------------------------------------------
  |                            | delayed es |
  -------------------------------------------
  ^           ^
  | fallocate |

So we also need to check the counted reserved only blocks, if it is zero
it means that the allocating is not from the delayed allocating, and we
should release reserved qutoa instead of claim it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c        |  37 -------------
 fs/ext4/extents_status.c | 115 +++++++++------------------------------
 fs/ext4/extents_status.h |   2 -
 fs/ext4/indirect.c       |   7 ---
 fs/ext4/inode.c          |   5 +-
 5 files changed, 30 insertions(+), 136 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e4115d338f10..592383effe80 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4323,43 +4323,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		goto out;
 	}
 
-	/*
-	 * Reduce the reserved cluster count to reflect successful deferred
-	 * allocation of delayed allocated clusters or direct allocation of
-	 * clusters discovered to be delayed allocated.  Once allocated, a
-	 * cluster is not included in the reserved count.
-	 */
-	if (test_opt(inode->i_sb, DELALLOC) && allocated_clusters) {
-		if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) {
-			/*
-			 * When allocating delayed allocated clusters, simply
-			 * reduce the reserved cluster count and claim quota
-			 */
-			ext4_da_update_reserve_space(inode, allocated_clusters,
-							1);
-		} else {
-			ext4_lblk_t lblk, len;
-			unsigned int n;
-
-			/*
-			 * When allocating non-delayed allocated clusters
-			 * (from fallocate, filemap, DIO, or clusters
-			 * allocated when delalloc has been disabled by
-			 * ext4_nonda_switch), reduce the reserved cluster
-			 * count by the number of allocated clusters that
-			 * have previously been delayed allocated.  Quota
-			 * has been claimed by ext4_mb_new_blocks() above,
-			 * so release the quota reservations made for any
-			 * previously delayed allocated clusters.
-			 */
-			lblk = EXT4_LBLK_CMASK(sbi, map->m_lblk);
-			len = allocated_clusters << sbi->s_cluster_bits;
-			n = ext4_es_delayed_clu(inode, lblk, len);
-			if (n > 0)
-				ext4_da_update_reserve_space(inode, (int) n, 0);
-		}
-	}
-
 	/*
 	 * Cache the extent and update transaction to commit on fdatasync only
 	 * when it is _not_ an unwritten extent.
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 62191c772b82..34164c2827f2 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -856,11 +856,14 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
 	int err1 = 0, err2 = 0, err3 = 0;
+	struct rsvd_info rinfo;
+	int pending = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct extent_status *es1 = NULL;
 	struct extent_status *es2 = NULL;
 	struct pending_reservation *pr = NULL;
 	bool revise_pending = false;
+	bool delayed = false;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
@@ -878,6 +881,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * data lose, and the extent has been written, it's safe to remove
 	 * the delayed flag even it's still delayed.
 	 */
+	delayed = status & EXTENT_STATUS_DELAYED;
 	if ((status & EXTENT_STATUS_DELAYED) &&
 	    (status & EXTENT_STATUS_WRITTEN))
 		status &= ~EXTENT_STATUS_DELAYED;
@@ -902,7 +906,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	err1 = __es_remove_extent(inode, lblk, end, &rinfo, es1);
 	if (err1 != 0)
 		goto error;
 	/* Free preallocated extent if it didn't get used. */
@@ -932,9 +936,30 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 			__free_pending(pr);
 			pr = NULL;
 		}
+		/*
+		 * In the first partial allocating some delayed extents of
+		 * one cluster, we also need to count the data cluster when
+		 * allocating delay only extent entries.
+		 */
+		pending = err3;
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	/*
+	 * If EXTENT_STATUS_DELAYED is not set and delayed only blocks is
+	 * not zero, we are allocating delayed allocated clusters, simply
+	 * reduce the reserved cluster count and claim quota.
+	 *
+	 * Otherwise, we aren't allocating delayed allocated clusters
+	 * (from fallocate, filemap, DIO, or clusters allocated when
+	 * delalloc has been disabled by ext4_nonda_switch()), reduce the
+	 * reserved cluster count by the number of allocated clusters that
+	 * have previously been delayed allocated. Quota has been claimed
+	 * by ext4_mb_new_blocks(), so release the quota reservations made
+	 * for any previously delayed allocated clusters.
+	 */
+	ext4_da_update_reserve_space(inode, rinfo.ndelonly_clu + pending,
+				     !delayed && rinfo.ndelonly_blk);
 	if (err1 || err2 || err3 < 0)
 		goto retry;
 
@@ -2146,94 +2171,6 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	return;
 }
 
-/*
- * __es_delayed_clu - count number of clusters containing blocks that
- *                    are delayed only
- *
- * @inode - file containing block range
- * @start - logical block defining start of range
- * @end - logical block defining end of range
- *
- * Returns the number of clusters containing only delayed (not delayed
- * and unwritten) blocks in the range specified by @start and @end.  Any
- * cluster or part of a cluster within the range and containing a delayed
- * and not unwritten block within the range is counted as a whole cluster.
- */
-static unsigned int __es_delayed_clu(struct inode *inode, ext4_lblk_t start,
-				     ext4_lblk_t end)
-{
-	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
-	struct extent_status *es;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	struct rb_node *node;
-	ext4_lblk_t first_lclu, last_lclu;
-	unsigned long long last_counted_lclu;
-	unsigned int n = 0;
-
-	/* guaranteed to be unequal to any ext4_lblk_t value */
-	last_counted_lclu = ~0ULL;
-
-	es = __es_tree_search(&tree->root, start);
-
-	while (es && (es->es_lblk <= end)) {
-		if (ext4_es_is_delonly(es)) {
-			if (es->es_lblk <= start)
-				first_lclu = EXT4_B2C(sbi, start);
-			else
-				first_lclu = EXT4_B2C(sbi, es->es_lblk);
-
-			if (ext4_es_end(es) >= end)
-				last_lclu = EXT4_B2C(sbi, end);
-			else
-				last_lclu = EXT4_B2C(sbi, ext4_es_end(es));
-
-			if (first_lclu == last_counted_lclu)
-				n += last_lclu - first_lclu;
-			else
-				n += last_lclu - first_lclu + 1;
-			last_counted_lclu = last_lclu;
-		}
-		node = rb_next(&es->rb_node);
-		if (!node)
-			break;
-		es = rb_entry(node, struct extent_status, rb_node);
-	}
-
-	return n;
-}
-
-/*
- * ext4_es_delayed_clu - count number of clusters containing blocks that
- *                       are both delayed and unwritten
- *
- * @inode - file containing block range
- * @lblk - logical block defining start of range
- * @len - number of blocks in range
- *
- * Locking for external use of __es_delayed_clu().
- */
-unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	ext4_lblk_t end;
-	unsigned int n;
-
-	if (len == 0)
-		return 0;
-
-	end = lblk + len - 1;
-	WARN_ON(end < lblk);
-
-	read_lock(&ei->i_es_lock);
-
-	n = __es_delayed_clu(inode, lblk, end);
-
-	read_unlock(&ei->i_es_lock);
-
-	return n;
-}
-
 /*
  * __revise_pending - makes, cancels, or leaves unchanged pending cluster
  *                    reservations for a specified block range depending
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index d9847a4a25db..7344667eb2cd 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -251,8 +251,6 @@ extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
 extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
 extern void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 					 bool allocated);
-extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
-					ext4_lblk_t len);
 extern void ext4_clear_inode_es(struct inode *inode);
 
 #endif /* _EXT4_EXTENTS_STATUS_H */
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index a9f3716119d3..448401e02c55 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -652,13 +652,6 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 	count = ar.len;
 
-	/*
-	 * Update reserved blocks/metadata blocks after successful block
-	 * allocation which had been deferred till now.
-	 */
-	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
-		ext4_da_update_reserve_space(inode, count, 1);
-
 got_it:
 	map->m_flags |= EXT4_MAP_MAPPED;
 	map->m_pblk = le32_to_cpu(chain[depth-1].key);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 82115d6656d3..546a3b09fd0a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -330,11 +330,14 @@ qsize_t *ext4_get_reserved_space(struct inode *inode)
  * ext4_discard_preallocations() from here.
  */
 void ext4_da_update_reserve_space(struct inode *inode,
-					int used, int quota_claim)
+				  int used, int quota_claim)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
+	if (!used)
+		return;
+
 	spin_lock(&ei->i_block_reservation_lock);
 	trace_ext4_da_update_reserve_space(inode, used, quota_claim);
 	if (unlikely(used > ei->i_reserved_data_blocks)) {
-- 
2.39.2

