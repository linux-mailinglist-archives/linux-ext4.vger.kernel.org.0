Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8431E69E060
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjBUM3G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 07:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjBUM3D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 07:29:03 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21228D1F;
        Tue, 21 Feb 2023 04:28:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLdqt0lgHz4f456X;
        Tue, 21 Feb 2023 20:28:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+n5uPRj1aP2Dw--.36592S6;
        Tue, 21 Feb 2023 20:28:44 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com, linfeilong@huawei.com
Subject: [PATCH 4/4] ext4: remove unused group parameter in ext4_block_bitmap_csum_set
Date:   Wed, 22 Feb 2023 04:30:27 +0800
Message-Id: <20230221203027.2359920-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+n5uPRj1aP2Dw--.36592S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jry5Jry5ury7Xw4xZr1xuFg_yoWxGF1rp3
        4qyF1UCrs8Wr4q9a1Ik3yIva4xWw1kWw1kGryS9r15CFy3Jrn7JFy8KFyFvas0vFsrZ3Zr
        Zw1Y93y7ur13WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
        xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x0pRvJPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unused group parameter in ext4_block_bitmap_csum_set. After this,
group parameter in ext4_set_bitmap_checksums is also not used, just
remove it too.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/bitmap.c  |  2 +-
 fs/ext4/ext4.h    |  2 +-
 fs/ext4/ialloc.c  |  6 ++----
 fs/ext4/mballoc.c | 10 +++++-----
 fs/ext4/resize.c  |  5 ++---
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index 3b83d979a650..87c1c8ae9298 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -80,7 +80,7 @@ int ext4_block_bitmap_csum_verify(struct super_block *sb,
 	return 0;
 }
 
-void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
+void ext4_block_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh)
 {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 04447640b4f4..3051dc8584d8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2682,7 +2682,7 @@ void ext4_inode_bitmap_csum_set(struct super_block *sb,
 int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh, int sz);
-void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
+void ext4_block_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh);
 int ext4_block_bitmap_csum_verify(struct super_block *sb,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b86756c57c0b..e4bad4b5145c 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -813,8 +813,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
 			ext4_free_group_clusters_set(sb, gdp,
 				ext4_free_clusters_after_init(sb, group, gdp));
-			ext4_block_bitmap_csum_set(sb, group, gdp,
-						   block_bitmap_bh);
+			ext4_block_bitmap_csum_set(sb, gdp, block_bitmap_bh);
 			ext4_group_desc_csum_set(sb, group, gdp);
 		}
 		ext4_unlock_group(sb, group);
@@ -1165,8 +1164,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
 			ext4_free_group_clusters_set(sb, gdp,
 				ext4_free_clusters_after_init(sb, group, gdp));
-			ext4_block_bitmap_csum_set(sb, group, gdp,
-						   block_bitmap_bh);
+			ext4_block_bitmap_csum_set(sb, gdp, block_bitmap_bh);
 			ext4_group_desc_csum_set(sb, group, gdp);
 		}
 		ext4_unlock_group(sb, group);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37a8b80..0d69cd8c5fc3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3822,7 +3822,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 	}
 	len = ext4_free_group_clusters(sb, gdp) - ac->ac_b_ex.fe_len;
 	ext4_free_group_clusters_set(sb, gdp, len);
-	ext4_block_bitmap_csum_set(sb, ac->ac_b_ex.fe_group, gdp, bitmap_bh);
+	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
 	ext4_group_desc_csum_set(sb, ac->ac_b_ex.fe_group, gdp);
 
 	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
@@ -3929,7 +3929,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
 
 		ext4_free_group_clusters_set(sb, gdp, clen);
-		ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
+		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
 		ext4_group_desc_csum_set(sb, group, gdp);
 
 		ext4_unlock_group(sb, group);
@@ -5861,7 +5861,7 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 	ext4_free_group_clusters_set(
 		sb, gdp, ext4_free_group_clusters(sb, gdp) +
 		count - already_freed);
-	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
+	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
 	ext4_group_desc_csum_set(sb, group, gdp);
 	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
 	sync_dirty_buffer(bitmap_bh);
@@ -6023,7 +6023,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 
 	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
 	ext4_free_group_clusters_set(sb, gdp, ret);
-	ext4_block_bitmap_csum_set(sb, block_group, gdp, bitmap_bh);
+	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
 
@@ -6280,7 +6280,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 	free_clusters_count = clusters_freed +
 		ext4_free_group_clusters(sb, desc);
 	ext4_free_group_clusters_set(sb, desc, free_clusters_count);
-	ext4_block_bitmap_csum_set(sb, block_group, desc, bitmap_bh);
+	ext4_block_bitmap_csum_set(sb, desc, bitmap_bh);
 	ext4_group_desc_csum_set(sb, block_group, desc);
 	ext4_unlock_group(sb, block_group);
 	percpu_counter_add(&sbi->s_freeclusters_counter,
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 607a1af00665..0361c20910de 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1306,7 +1306,6 @@ static struct buffer_head *ext4_get_bitmap(struct super_block *sb, __u64 block)
 }
 
 static int ext4_set_bitmap_checksums(struct super_block *sb,
-				     ext4_group_t group,
 				     struct ext4_group_desc *gdp,
 				     struct ext4_new_group_data *group_data)
 {
@@ -1325,7 +1324,7 @@ static int ext4_set_bitmap_checksums(struct super_block *sb,
 	bh = ext4_get_bitmap(sb, group_data->block_bitmap);
 	if (!bh)
 		return -EIO;
-	ext4_block_bitmap_csum_set(sb, group, gdp, bh);
+	ext4_block_bitmap_csum_set(sb, gdp, bh);
 	brelse(bh);
 
 	return 0;
@@ -1363,7 +1362,7 @@ static int ext4_setup_new_descs(handle_t *handle, struct super_block *sb,
 		memset(gdp, 0, EXT4_DESC_SIZE(sb));
 		ext4_block_bitmap_set(sb, gdp, group_data->block_bitmap);
 		ext4_inode_bitmap_set(sb, gdp, group_data->inode_bitmap);
-		err = ext4_set_bitmap_checksums(sb, group, gdp, group_data);
+		err = ext4_set_bitmap_checksums(sb, gdp, group_data);
 		if (err) {
 			ext4_std_error(sb, err);
 			break;
-- 
2.30.0

