Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE869E05F
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjBUM3E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 07:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjBUM3B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 07:29:01 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9874028D13;
        Tue, 21 Feb 2023 04:28:47 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLdqs6LpDz4f41Gs;
        Tue, 21 Feb 2023 20:28:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAXC+n5uPRj1aP2Dw--.36592S5;
        Tue, 21 Feb 2023 20:28:43 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com, linfeilong@huawei.com
Subject: [PATCH 3/4] ext4: remove unused group parameter in ext4_block_bitmap_csum_verify
Date:   Wed, 22 Feb 2023 04:30:26 +0800
Message-Id: <20230221203027.2359920-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXC+n5uPRj1aP2Dw--.36592S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW5ZFW5Wr1xCr13WF4fuFg_yoW8ZF1kp3
        Z0yF1Uur43urnrua17Kry0v3WIgw1kKrykGryF9345WFW7Jwn7WFykKF1DAa4YqFZxXFnr
        ZF1Yy34UWw1fWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
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
        RNiiSUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove unused group parameter in ext4_block_bitmap_csum_verify.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c | 3 +--
 fs/ext4/bitmap.c | 2 +-
 fs/ext4/ext4.h   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 689edfed231a..49fdb758b0e4 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -385,8 +385,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 	ext4_lock_group(sb, block_group);
 	if (buffer_verified(bh))
 		goto verified;
-	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
-						    desc, bh) ||
+	if (unlikely(!ext4_block_bitmap_csum_verify(sb, desc, bh) ||
 		     ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_CRC))) {
 		ext4_unlock_group(sb, block_group);
 		ext4_error(sb, "bg %u: bad block bitmap checksum", block_group);
diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index 0186b894f5b3..3b83d979a650 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -54,7 +54,7 @@ void ext4_inode_bitmap_csum_set(struct super_block *sb,
 		gdp->bg_inode_bitmap_csum_hi = cpu_to_le16(csum >> 16);
 }
 
-int ext4_block_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
+int ext4_block_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh)
 {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index aa6948d12ede..04447640b4f4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2685,7 +2685,7 @@ int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh);
-int ext4_block_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
+int ext4_block_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh);
 
-- 
2.30.0

