Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1430369E062
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 13:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjBUM3H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 07:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjBUM3D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 07:29:03 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE6E3B5;
        Tue, 21 Feb 2023 04:28:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PLdqs2tqlz4f3qjH;
        Tue, 21 Feb 2023 20:28:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+n5uPRj1aP2Dw--.36592S4;
        Tue, 21 Feb 2023 20:28:43 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com, linfeilong@huawei.com
Subject: [PATCH 2/4] ext4: remove unused group parameter in ext4_inode_bitmap_csum_set
Date:   Wed, 22 Feb 2023 04:30:25 +0800
Message-Id: <20230221203027.2359920-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+n5uPRj1aP2Dw--.36592S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXF47Cr4DGr1DAF1rKr48Zwb_yoW5Zr4Up3
        4DtF1UGr4rZFnF9rWxKry0v3WkKwn5GwsrWFyS9r15CF9xXwnaqF18KFyjy3WayFWkXFnI
        vr1Yk3yUuw13WrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNVbyUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unused group parameter in ext4_inode_bitmap_csum_set.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/bitmap.c | 2 +-
 fs/ext4/ext4.h   | 2 +-
 fs/ext4/ialloc.c | 6 +++---
 fs/ext4/resize.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index 3bb28fad624f..0186b894f5b3 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -38,7 +38,7 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 	return provided == calculated;
 }
 
-void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
+void ext4_inode_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh, int sz)
 {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index db2476daebd2..aa6948d12ede 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2676,7 +2676,7 @@ struct mmpd_data {
 
 /* bitmap.c */
 extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
-void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
+void ext4_inode_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh, int sz);
 int ext4_inode_bitmap_csum_verify(struct super_block *sb,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7e388340f588..b86756c57c0b 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -327,7 +327,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 		if (percpu_counter_initialized(&sbi->s_dirs_counter))
 			percpu_counter_dec(&sbi->s_dirs_counter);
 	}
-	ext4_inode_bitmap_csum_set(sb, block_group, gdp, bitmap_bh,
+	ext4_inode_bitmap_csum_set(sb, gdp, bitmap_bh,
 				   EXT4_INODES_PER_GROUP(sb) / 8);
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
@@ -852,7 +852,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 
 	ext4_free_inodes_set(sb, gdp, ext4_free_inodes_count(sb, gdp) - 1);
 	if (ext4_has_group_desc_csum(sb)) {
-		ext4_inode_bitmap_csum_set(sb, group, gdp, inode_bitmap_bh,
+		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh,
 					   EXT4_INODES_PER_GROUP(sb) / 8);
 		ext4_group_desc_csum_set(sb, group, gdp);
 	}
@@ -1222,7 +1222,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		}
 	}
 	if (ext4_has_group_desc_csum(sb)) {
-		ext4_inode_bitmap_csum_set(sb, group, gdp, inode_bitmap_bh,
+		ext4_inode_bitmap_csum_set(sb, gdp, inode_bitmap_bh,
 					   EXT4_INODES_PER_GROUP(sb) / 8);
 		ext4_group_desc_csum_set(sb, group, gdp);
 	}
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 6b91443d6bf3..607a1af00665 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1318,7 +1318,7 @@ static int ext4_set_bitmap_checksums(struct super_block *sb,
 	bh = ext4_get_bitmap(sb, group_data->inode_bitmap);
 	if (!bh)
 		return -EIO;
-	ext4_inode_bitmap_csum_set(sb, group, gdp, bh,
+	ext4_inode_bitmap_csum_set(sb, gdp, bh,
 				   EXT4_INODES_PER_GROUP(sb) / 8);
 	brelse(bh);
 
-- 
2.30.0

