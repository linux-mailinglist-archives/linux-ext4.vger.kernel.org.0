Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF56786BF0
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbjHXJbE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbjHXJav (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:51 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3AA10F9
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RWd9b0spMz4f3nqn
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S20;
        Thu, 24 Aug 2023 17:30:46 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 16/16] ext4: drop ext4_nonda_switch()
Date:   Thu, 24 Aug 2023 17:26:19 +0800
Message-Id: <20230824092619.1327976-17-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S20
X-Coremail-Antispam: 1UD129KBjvJXoWxWry8uF48CFWkKF4rArWDurg_yoWrXFWfpF
        W3Kw4fJr45Zr1DWrs3Xw1DZryFkayUKrWUKrW2gr18uF9xCr1S9F1DKF1FvFy2krWxJ3Z0
        qFWUC347uF9Ik3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Now that we have reserve enough metadata blocks for delalloc, the
ext4_nonda_switch() could be dropped, it's safe to keep on delalloc mode
for buffer write if the dirty space is high and free space is low, we
can make sure always successfully allocate the metadata block while
mapping delalloc entries in ext4_writepages().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c |  9 ++++-----
 fs/ext4/inode.c          | 39 ++-------------------------------------
 2 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 8e0dec27f967..954c6e49182e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -971,11 +971,10 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * reduce the reserved cluster count and claim quota.
 	 *
 	 * Otherwise, we aren't allocating delayed allocated clusters
-	 * (from fallocate, filemap, DIO, or clusters allocated when
-	 * delalloc has been disabled by ext4_nonda_switch()), reduce the
-	 * reserved cluster count by the number of allocated clusters that
-	 * have previously been delayed allocated. Quota has been claimed
-	 * by ext4_mb_new_blocks(), so release the quota reservations made
+	 * (from fallocate, filemap, DIO), reduce the reserved cluster
+	 * count by the number of allocated clusters that have previously
+	 * been delayed allocated. Quota has been claimed by
+	 * ext4_mb_new_blocks(), so release the quota reservations made
 	 * for any previously delayed allocated clusters.
 	 */
 	ext4_da_update_reserve_space(inode, rinfo.ndelonly_clu + pending,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d714bf2e4171..0a76c99ea8c6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2838,40 +2838,6 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	return ret;
 }
 
-static int ext4_nonda_switch(struct super_block *sb)
-{
-	s64 free_clusters, dirty_clusters;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-
-	/*
-	 * switch to non delalloc mode if we are running low
-	 * on free block. The free block accounting via percpu
-	 * counters can get slightly wrong with percpu_counter_batch getting
-	 * accumulated on each CPU without updating global counters
-	 * Delalloc need an accurate free block accounting. So switch
-	 * to non delalloc when we are near to error range.
-	 */
-	free_clusters =
-		percpu_counter_read_positive(&sbi->s_freeclusters_counter);
-	dirty_clusters =
-		percpu_counter_read_positive(&sbi->s_dirtyclusters_counter);
-	/*
-	 * Start pushing delalloc when 1/2 of free blocks are dirty.
-	 */
-	if (dirty_clusters && (free_clusters < 2 * dirty_clusters))
-		try_to_writeback_inodes_sb(sb, WB_REASON_FS_FREE_SPACE);
-
-	if (2 * free_clusters < 3 * dirty_clusters ||
-	    free_clusters < (dirty_clusters + EXT4_FREECLUSTERS_WATERMARK)) {
-		/*
-		 * free block count is less than 150% of dirty blocks
-		 * or free blocks is less than watermark
-		 */
-		return 1;
-	}
-	return 0;
-}
-
 static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			       loff_t pos, unsigned len,
 			       struct page **pagep, void **fsdata)
@@ -2886,7 +2852,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 
 	index = pos >> PAGE_SHIFT;
 
-	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode)) {
+	if (ext4_verity_in_progress(inode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(file, mapping, pos,
 					len, pagep, fsdata);
@@ -6117,8 +6083,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		goto retry_alloc;
 
 	/* Delalloc case is easy... */
-	if (test_opt(inode->i_sb, DELALLOC) &&
-	    !ext4_nonda_switch(inode->i_sb)) {
+	if (test_opt(inode->i_sb, DELALLOC)) {
 		do {
 			err = block_page_mkwrite(vma, vmf,
 						   ext4_da_get_block_prep);
-- 
2.39.2

