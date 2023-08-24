Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CF786BF5
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbjHXJbH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbjHXJas (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:48 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE110F
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9Z2Dnzz4f41Gv
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S12;
        Thu, 24 Aug 2023 17:30:43 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 08/16] ext4: refactor delalloc space reservation
Date:   Thu, 24 Aug 2023 17:26:11 +0800
Message-Id: <20230824092619.1327976-9-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S12
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy7uw1xGFykWw4xXF13Jwb_yoW8Cw4Upr
        W3CFsrKr4xW3s2kF4SqrnrXF1rKa92qrWUJFW29w1fZry3XFyfKF1qyF15ZF1fKrW8XF4Y
        qFWUJ34Uua1jka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Cleanup the delalloc reserve space calling, split it from the bigalloc
checks, call ext4_da_reserve_space() if it have unmapped block need to
reserve, no logical changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 546a3b09fd0a..861602903b4d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1623,8 +1623,9 @@ static void ext4_print_free_blocks(struct inode *inode)
 static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	int ret;
+	unsigned int rsv_dlen = 1;
 	bool allocated = false;
+	int ret;
 
 	/*
 	 * If the cluster containing lblk is shared with a delayed,
@@ -1637,11 +1638,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	 * it's necessary to examine the extent tree if a search of the
 	 * extents status tree doesn't get a match.
 	 */
-	if (sbi->s_cluster_ratio == 1) {
-		ret = ext4_da_reserve_space(inode);
-		if (ret != 0)   /* ENOSPC */
-			return ret;
-	} else {   /* bigalloc */
+	if (sbi->s_cluster_ratio > 1) {
+		rsv_dlen = 0;
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
 					      &ext4_es_is_mapped, lblk)) {
@@ -1649,19 +1647,22 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 						      EXT4_B2C(sbi, lblk));
 				if (ret < 0)
 					return ret;
-				if (ret == 0) {
-					ret = ext4_da_reserve_space(inode);
-					if (ret != 0)   /* ENOSPC */
-						return ret;
-				} else {
+				if (ret == 0)
+					rsv_dlen = 1;
+				else
 					allocated = true;
-				}
 			} else {
 				allocated = true;
 			}
 		}
 	}
 
+	if (rsv_dlen > 0) {
+		ret = ext4_da_reserve_space(inode);
+		if (ret)   /* ENOSPC */
+			return ret;
+	}
+
 	ext4_es_insert_delayed_block(inode, lblk, allocated);
 	return 0;
 }
-- 
2.39.2

