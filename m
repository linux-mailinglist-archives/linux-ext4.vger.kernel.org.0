Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF41786BEE
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbjHXJbC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbjHXJav (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:51 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B2172D
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9c0mCGz4f41SJ
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S17;
        Thu, 24 Aug 2023 17:30:45 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 13/16] ext4: calculate the worst extent blocks needed of a delalloc es entry
Date:   Thu, 24 Aug 2023 17:26:16 +0800
Message-Id: <20230824092619.1327976-14-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S17
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1fury3Jr1DurW3uF45ZFb_yoW5WF1Dpr
        9xZr15Gr43Ww129ayfCw48Zr1Fg3WxGrWUXrWfGryYqFW8Jr1xKFn8tFW2qFy0qFWfXa12
        vF45tryUGw4Y9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Add a new helper to calculate the worst case of extent blocks that
needed while mapping a new delalloc extent_status entry. In the worst
case, one delay data block consumes one extent enrty, the worst extent
blocks should be 'leaf blocks + index blocks + (max depth - depth
increasing costs)'. The detailed calculation formula is:

        / DIV_ROUND_UP(da_blocks, ext_per_block);  (i = 0)
 f(i) =
        \ DIV_ROUND_UP(f(i-1), idx_per_block);     (0 < i < max_depth)

 SUM = f(0) + .. + f(n) + max_depth - n - 1;  (0 <= n < max_depth, f(n) > 0)

For example:
On the default 4k block size, the default ext_per_block and
idx_per_block are 340. (1) If we map 50 length of blocks, the worst
entent block is DIV_ROUND_UP(50, 340) + EXT4_MAX_EXTENT_DEPTH - 1 = 5,
(2) if we map 500 length of blocks, the worst extent block is
DIV_ROUND_UP(500, 340) + DIV_ROUND_UP(DIV_ROUND_UP(500, 340), 340) +
EXT4_MAX_EXTENT_DEPTH - 2 = 6, and so on. It is a preparation for
reserving meta blocks of delalloc.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/extents.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3e0a39653469..11813382fbcc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3699,6 +3699,8 @@ extern int ext4_swap_extents(handle_t *handle, struct inode *inode1,
 			     ext4_lblk_t lblk2,  ext4_lblk_t count,
 			     int mark_unwritten,int *err);
 extern int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu);
+extern unsigned int ext4_map_worst_ext_blocks(struct inode *inode,
+					      unsigned int len);
 extern int ext4_datasem_ensure_credits(handle_t *handle, struct inode *inode,
 				       int check_cred, int restart_cred,
 				       int revoke_cred);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 592383effe80..43c251a42144 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5797,6 +5797,34 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	return err ? err : mapped;
 }
 
+/*
+ * Calculate the worst case of extents blocks needed while mapping 'len'
+ * data blocks.
+ */
+unsigned int ext4_map_worst_ext_blocks(struct inode *inode, unsigned int len)
+{
+	unsigned int ext_blocks = 0;
+	int max_entries;
+	int depth, max_depth;
+
+	if (!len)
+		return 0;
+
+	max_entries = ext4_ext_space_block(inode, 0);
+	max_depth = EXT4_MAX_EXTENT_DEPTH;
+
+	for (depth = 0; depth < max_depth; depth++) {
+		len = DIV_ROUND_UP(len, max_entries);
+		ext_blocks += len;
+		if (len == 1)
+			break;
+		if (depth == 0)
+			max_entries = ext4_ext_space_block_idx(inode, 0);
+	}
+
+	return ext_blocks + max_depth - depth - 1;
+}
+
 /*
  * Updates physical block address and unwritten status of extent
  * starting at lblk start and of len. If such an extent doesn't exist,
-- 
2.39.2

