Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4201786BF6
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbjHXJbI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbjHXJar (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E4198A
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9X5wL7z4f41Rw
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S8;
        Thu, 24 Aug 2023 17:30:41 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 04/16] ext4: count removed reserved blocks for delalloc only es entry
Date:   Thu, 24 Aug 2023 17:26:07 +0800
Message-Id: <20230824092619.1327976-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr1fur45ZF43GF1xZFW3trb_yoW7Xr4kpF
        ZxuF15Kw13X34I93yftw4DZr1Sga48KFWUJr9Ik34fuF4rArySvF18AF42vFyrKrW0gw4j
        qF4jk34Uua12ga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
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

Current __es_remove_extent() count reserved clusters if the removed es
entry is delalloc only, it's equal to blocks number if the bigalloc
feature is disabled, but we cannot get the blocks number if that feature
is enabled. So add a parameter to count the reserved blocks number, it
is not used in this patch now, it will be used to calculate reserved
meta blocks.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 67ac09930541..3a004ed04570 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -141,13 +141,18 @@
  *   -- Extent-level locking
  */
 
+struct rsvd_info {
+	int ndelonly_clu;	/* reserved clusters for delalloc es entry */
+	int ndelonly_blk;	/* reserved blocks for delalloc es entry */
+};
+
 static struct kmem_cache *ext4_es_cachep;
 static struct kmem_cache *ext4_pending_cachep;
 
 static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 			      struct extent_status *prealloc);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved,
+			      ext4_lblk_t end, struct rsvd_info *rinfo,
 			      struct extent_status *prealloc);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
@@ -1050,6 +1055,7 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 
 struct rsvd_count {
 	int ndelonly;
+	int ndelonly_blk;
 	bool first_do_lblk_found;
 	ext4_lblk_t first_do_lblk;
 	ext4_lblk_t last_do_lblk;
@@ -1076,6 +1082,7 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
 	struct rb_node *node;
 
 	rc->ndelonly = 0;
+	rc->ndelonly_blk = 0;
 
 	/*
 	 * for bigalloc, note the first delonly block in the range has not
@@ -1124,10 +1131,12 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
 
 	if (sbi->s_cluster_ratio == 1) {
 		rc->ndelonly += (int) len;
+		rc->ndelonly_blk = rc->ndelonly;
 		return;
 	}
 
 	/* bigalloc */
+	rc->ndelonly_blk += (int)len;
 
 	i = (lblk < es->es_lblk) ? es->es_lblk : lblk;
 	end = lblk + (ext4_lblk_t) len - 1;
@@ -1355,16 +1364,17 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * @inode - file containing range
  * @lblk - first block in range
  * @end - last block in range
- * @reserved - number of cluster reservations released
+ * @rinfo - reserved information collected, includes number of
+ *          block/cluster reservations released
  * @prealloc - pre-allocated es to avoid memory allocation failures
  *
- * If @reserved is not NULL and delayed allocation is enabled, counts
+ * If @rinfo is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
  * enabled cancels pending reservations as needed. Returns 0 on success,
  * error code on failure.
  */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved,
+			      ext4_lblk_t end, struct rsvd_info *rinfo,
 			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
@@ -1374,11 +1384,15 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t len1, len2;
 	ext4_fsblk_t block;
 	int err = 0;
-	bool count_reserved = true;
+	bool count_reserved = false;
 	struct rsvd_count rc;
 
-	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
-		count_reserved = false;
+	if (rinfo) {
+		rinfo->ndelonly_clu = 0;
+		rinfo->ndelonly_blk = 0;
+		if (test_opt(inode->i_sb, DELALLOC))
+			count_reserved = true;
+	}
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
@@ -1476,8 +1490,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 
 out_get_reserved:
-	if (count_reserved)
-		*reserved = get_rsvd(inode, end, es, &rc);
+	if (count_reserved) {
+		rinfo->ndelonly_clu = get_rsvd(inode, end, es, &rc);
+		rinfo->ndelonly_blk = rc.ndelonly_blk;
+	}
 out:
 	return err;
 }
@@ -1496,8 +1512,8 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			   ext4_lblk_t len)
 {
 	ext4_lblk_t end;
+	struct rsvd_info rinfo;
 	int err = 0;
-	int reserved = 0;
 	struct extent_status *es = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
@@ -1522,7 +1538,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	err = __es_remove_extent(inode, lblk, end, &rinfo, es);
 	/* Free preallocated extent if it didn't get used. */
 	if (es) {
 		if (!es->es_len)
@@ -1534,7 +1550,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	ext4_da_release_space(inode, reserved);
+	ext4_da_release_space(inode, rinfo.ndelonly_clu);
 	return;
 }
 
-- 
2.39.2

