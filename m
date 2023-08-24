Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816EE786BFB
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbjHXJbK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240789AbjHXJat (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:49 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9067E67
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9Z4pfqz4f41SB
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S13;
        Thu, 24 Aug 2023 17:30:43 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 09/16] ext4: count reserved metadata blocks for delalloc per inode
Date:   Thu, 24 Aug 2023 17:26:12 +0800
Message-Id: <20230824092619.1327976-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S13
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww43Xry3Zr1DWw48WrW3KFg_yoWxGw4fp3
        WDAFy5WFy8Wr1DWayxXr42yr4fua4IgF4UtF4DWFy7ZFy3J3Z2qr1ktFyYvFyYkrZxKrsr
        Xa4ru34ru3WUWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add a new parameter ei->i_reserved_ext_blocks to prepare for reserving
metadata blocks for delalloc. This parameter will be used to count the
per inode's total reserved metadata blocks, this value should always be
zero when the inode is dieing. Also update the corresponding
tracepoints and debug interface.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h              |  1 +
 fs/ext4/inode.c             |  2 ++
 fs/ext4/super.c             | 10 +++++++---
 include/trace/events/ext4.h | 25 +++++++++++++++++--------
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 84618c46f239..ee2dbbde176e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1104,6 +1104,7 @@ struct ext4_inode_info {
 	/* allocation reservation info for delalloc */
 	/* In case of bigalloc, this refer to clusters rather than blocks */
 	unsigned int i_reserved_data_blocks;
+	unsigned int i_reserved_ext_blocks;
 
 	/* pending cluster reservations for bigalloc file systems */
 	struct ext4_pending_tree i_pending_tree;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 861602903b4d..dda17b3340ce 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1606,6 +1606,8 @@ static void ext4_print_free_blocks(struct inode *inode)
 	ext4_msg(sb, KERN_CRIT, "Block reservation details");
 	ext4_msg(sb, KERN_CRIT, "i_reserved_data_blocks=%u",
 		 ei->i_reserved_data_blocks);
+	ext4_msg(sb, KERN_CRIT, "i_reserved_ext_blocks=%u",
+		 ei->i_reserved_ext_blocks);
 	return;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bb42525de8d0..7bc7c8c0ed71 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1436,6 +1436,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_es_shk_nr = 0;
 	ei->i_es_shrink_lblk = 0;
 	ei->i_reserved_data_blocks = 0;
+	ei->i_reserved_ext_blocks = 0;
 	spin_lock_init(&(ei->i_block_reservation_lock));
 	ext4_init_pending_tree(&ei->i_pending_tree);
 #ifdef CONFIG_QUOTA
@@ -1487,11 +1488,14 @@ static void ext4_destroy_inode(struct inode *inode)
 		dump_stack();
 	}
 
-	if (EXT4_I(inode)->i_reserved_data_blocks)
+	if (EXT4_I(inode)->i_reserved_data_blocks ||
+	    EXT4_I(inode)->i_reserved_ext_blocks)
 		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
+			 "Inode %lu (%p): i_reserved_data_blocks (%u) or "
+			 "i_reserved_ext_blocks (%u) not cleared!",
 			 inode->i_ino, EXT4_I(inode),
-			 EXT4_I(inode)->i_reserved_data_blocks);
+			 EXT4_I(inode)->i_reserved_data_blocks,
+			 EXT4_I(inode)->i_reserved_ext_blocks);
 }
 
 static void ext4_shutdown(struct super_block *sb)
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 65029dfb92fb..115f96f444ff 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1224,6 +1224,7 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 		__field(	__u64,	i_blocks		)
 		__field(	int,	used_blocks		)
 		__field(	int,	reserved_data_blocks	)
+		__field(	int,	reserved_ext_blocks	)
 		__field(	int,	quota_claim		)
 		__field(	__u16,	mode			)
 	),
@@ -1233,18 +1234,19 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->used_blocks = used_blocks;
-		__entry->reserved_data_blocks =
-				EXT4_I(inode)->i_reserved_data_blocks;
+		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
+		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
 		__entry->quota_claim = quota_claim;
 		__entry->mode	= inode->i_mode;
 	),
 
 	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu used_blocks %d "
-		  "reserved_data_blocks %d quota_claim %d",
+		  "reserved_data_blocks %d reserved_ext_blocks %d quota_claim %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->used_blocks, __entry->reserved_data_blocks,
+		  __entry->used_blocks,
+		  __entry->reserved_data_blocks, __entry->reserved_ext_blocks,
 		  __entry->quota_claim)
 );
 
@@ -1258,6 +1260,7 @@ TRACE_EVENT(ext4_da_reserve_space,
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
 		__field(	int,	reserved_data_blocks	)
+		__field(	int,	reserved_ext_blocks	)
 		__field(	__u16,  mode			)
 	),
 
@@ -1266,15 +1269,17 @@ TRACE_EVENT(ext4_da_reserve_space,
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
+		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
 		__entry->mode	= inode->i_mode;
 	),
 
 	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
-		  "reserved_data_blocks %d",
+		  "reserved_data_blocks %d reserved_ext_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->reserved_data_blocks)
+		  __entry->reserved_data_blocks,
+		  __entry->reserved_ext_blocks)
 );
 
 TRACE_EVENT(ext4_da_release_space,
@@ -1288,6 +1293,7 @@ TRACE_EVENT(ext4_da_release_space,
 		__field(	__u64,	i_blocks		)
 		__field(	int,	freed_blocks		)
 		__field(	int,	reserved_data_blocks	)
+		__field(	int,	reserved_ext_blocks	)
 		__field(	__u16,  mode			)
 	),
 
@@ -1297,15 +1303,18 @@ TRACE_EVENT(ext4_da_release_space,
 		__entry->i_blocks = inode->i_blocks;
 		__entry->freed_blocks = freed_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
+		__entry->reserved_ext_blocks = EXT4_I(inode)->i_reserved_ext_blocks;
 		__entry->mode	= inode->i_mode;
 	),
 
 	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu freed_blocks %d "
-		  "reserved_data_blocks %d",
+		  "reserved_data_blocks %d reserved_ext_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->freed_blocks, __entry->reserved_data_blocks)
+		  __entry->freed_blocks,
+		  __entry->reserved_data_blocks,
+		  __entry->reserved_ext_blocks)
 );
 
 DECLARE_EVENT_CLASS(ext4__bitmap_load,
-- 
2.39.2

