Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A09786BF2
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjHXJbG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbjHXJar (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7293172D
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9Y1drzz4f3prY
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S7;
        Thu, 24 Aug 2023 17:30:41 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 03/16] ext4: let __revise_pending() return the number of new inserts pendings
Date:   Thu, 24 Aug 2023 17:26:06 +0800
Message-Id: <20230824092619.1327976-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45Xry5Xry7Aw4xuF1kGrg_yoWrKF1kp3
        ya9as8Ary8Xw1UWa1FyF4UZr1Yg3W8tFWDXrZakryfZFW8XFy5tF10yF1avF1FyrWxJw13
        XFWjk34UCa1jgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
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

Change __insert_pending() to return 1 on successful insertion a new
pending cluster, and then change __revise_pending() to return the number
of new inserts pendings.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index f4b50652f0cc..67ac09930541 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -892,7 +892,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if ((err1 || err2 || err3) && revise_pending && !pr)
+	if ((err1 || err2 || err3 < 0) && revise_pending && !pr)
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
@@ -920,7 +920,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if (revise_pending) {
 		err3 = __revise_pending(inode, lblk, len, &pr);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr) {
 			__free_pending(pr);
@@ -929,7 +929,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2 || err3)
+	if (err1 || err2 || err3 < 0)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -1935,7 +1935,7 @@ static struct pending_reservation *__get_pending(struct inode *inode,
  * @lblk - logical block in the cluster to be added
  * @prealloc - preallocated pending entry
  *
- * Returns 0 on successful insertion and -ENOMEM on failure.  If the
+ * Returns 1 on successful insertion and -ENOMEM on failure.  If the
  * pending reservation is already in the set, returns successfully.
  */
 static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
@@ -1979,6 +1979,7 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
 
 	rb_link_node(&pr->rb_node, parent, p);
 	rb_insert_color(&pr->rb_node, &tree->root);
+	ret = 1;
 
 out:
 	return ret;
@@ -2085,7 +2086,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 		es1 = __es_alloc_extent(true);
 	if ((err1 || err2) && !es2)
 		es2 = __es_alloc_extent(true);
-	if ((err1 || err2 || err3) && allocated && !pr)
+	if ((err1 || err2 || err3 < 0) && allocated && !pr)
 		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
@@ -2111,7 +2112,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	if (allocated) {
 		err3 = __insert_pending(inode, lblk, &pr);
-		if (err3 != 0)
+		if (err3 < 0)
 			goto error;
 		if (pr) {
 			__free_pending(pr);
@@ -2120,7 +2121,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-	if (err1 || err2 || err3)
+	if (err1 || err2 || err3 < 0)
 		goto retry;
 
 	ext4_es_print_tree(inode);
@@ -2230,7 +2231,9 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
  *
  * Used after a newly allocated extent is added to the extents status tree.
  * Requires that the extents in the range have either written or unwritten
- * status.  Must be called while holding i_es_lock.
+ * status.  Must be called while holding i_es_lock. Returns number of new
+ * inserts pending cluster on insert pendings, returns 0 on remove pendings,
+ * return -ENOMEM on failure.
  */
 static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			    ext4_lblk_t len,
@@ -2240,6 +2243,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t end = lblk + len - 1;
 	ext4_lblk_t first, last;
 	bool f_del = false, l_del = false;
+	int pendings = 0;
 	int ret = 0;
 
 	if (len == 0)
@@ -2267,6 +2271,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else {
 			last = EXT4_LBLK_CMASK(sbi, end) +
 			       sbi->s_cluster_ratio - 1;
@@ -2278,6 +2283,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 				ret = __insert_pending(inode, last, prealloc);
 				if (ret < 0)
 					goto out;
+				pendings += ret;
 			} else
 				__remove_pending(inode, last);
 		}
@@ -2290,6 +2296,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, first, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else
 			__remove_pending(inode, first);
 
@@ -2301,9 +2308,10 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			ret = __insert_pending(inode, last, prealloc);
 			if (ret < 0)
 				goto out;
+			pendings += ret;
 		} else
 			__remove_pending(inode, last);
 	}
 out:
-	return ret;
+	return (ret < 0) ? ret : pendings;
 }
-- 
2.39.2

