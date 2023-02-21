Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7F69D9EE
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 04:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjBUD5r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Feb 2023 22:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjBUD5n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Feb 2023 22:57:43 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EED24CA3;
        Mon, 20 Feb 2023 19:57:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PLQV52Yqfz4f3wDH;
        Tue, 21 Feb 2023 11:57:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3q+ktQfRj8VfgDw--.30652S4;
        Tue, 21 Feb 2023 11:57:35 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 2/7] ext4: correct validation check of inode table in ext4_valid_block_bitmap
Date:   Tue, 21 Feb 2023 19:59:14 +0800
Message-Id: <20230221115919.1918161-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3q+ktQfRj8VfgDw--.30652S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF48Xw48WF17XF13Zr17trb_yoW8XF48p3
        98JF4jqr43Ar1DZw4ftF9Yqw1fGw1vgw47Grn3Wr13GrW2ga4SyF90kryag3WftFWDAry0
        v3sYv3y7Zw1rua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRcBMtUUUUU
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

1.Last valid cluster of inode table is EXT4_B2C(sbi, offset +
sbi->s_itb_per_group - 1). We should make sure last valid cluster is <
max_bit, i.e., EXT4_B2C(sbi, offset + sbi->s_itb_per_group - 1) is <
max_bit rather than EXT4_B2C(sbi, offset + sbi->s_itb_per_group) is
< max_bit.

2.Bit search length should be last valid cluster plus 1, i.e.,
EXT4_B2C(sbi, offset + sbi->s_itb_per_group - 1) + 1 rather than
EXT4_B2C(sbi, offset + sbi->s_itb_per_group).

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 10cab743e313..22be5cd70505 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -350,13 +350,13 @@ static ext4_fsblk_t ext4_valid_block_bitmap(struct super_block *sb,
 	blk = ext4_inode_table(sb, desc);
 	offset = blk - group_first_block;
 	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
-	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= max_bit)
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group - 1) >= max_bit)
 		return blk;
 	next_zero_bit = ext4_find_next_zero_bit(bh->b_data,
-			EXT4_B2C(sbi, offset + sbi->s_itb_per_group),
+			EXT4_B2C(sbi, offset + sbi->s_itb_per_group - 1) + 1,
 			EXT4_B2C(sbi, offset));
 	if (next_zero_bit <
-	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group))
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group - 1) + 1)
 		/* bad bitmap for inode tables */
 		return blk;
 	return 0;
-- 
2.30.0

