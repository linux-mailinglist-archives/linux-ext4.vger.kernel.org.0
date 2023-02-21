Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B769E05D
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 13:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjBUM3D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 07:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjBUM3B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 07:29:01 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F0928D10;
        Tue, 21 Feb 2023 04:28:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PLdqs0nKlz4f3nqt;
        Tue, 21 Feb 2023 20:28:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+n5uPRj1aP2Dw--.36592S3;
        Tue, 21 Feb 2023 20:28:43 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com, linfeilong@huawei.com
Subject: [PATCH 1/4] ext4: remove unused group parameter in ext4_inode_bitmap_csum_verify
Date:   Wed, 22 Feb 2023 04:30:24 +0800
Message-Id: <20230221203027.2359920-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+n5uPRj1aP2Dw--.36592S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try3Xr4xtFWrKF48ur1UAwb_yoW8ur1rp3
        Z0yF1UCrW5ZFnF9ayIkryIv3W0g3Z3K3srGFySkry5GFZrJwn5XFykKFyUA3WFqFWDXFnF
        vF1Yk34Uuw1fWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR3PE3UUUUU
        =
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unused group parameter in ext4_inode_bitmap_csum_verify.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/bitmap.c | 2 +-
 fs/ext4/ext4.h   | 2 +-
 fs/ext4/ialloc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index f63e028c638c..3bb28fad624f 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -16,7 +16,7 @@ unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
 	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
 }
 
-int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
+int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh, int sz)
 {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6479146140d2..db2476daebd2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2679,7 +2679,7 @@ extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
 void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh, int sz);
-int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
+int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh, int sz);
 void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 63f9bb6e8851..7e388340f588 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -98,7 +98,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 	if (buffer_verified(bh))
 		goto verified;
 	blk = ext4_inode_bitmap(sb, desc);
-	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
+	if (!ext4_inode_bitmap_csum_verify(sb, desc, bh,
 					   EXT4_INODES_PER_GROUP(sb) / 8) ||
 	    ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_CRC)) {
 		ext4_unlock_group(sb, block_group);
-- 
2.30.0

