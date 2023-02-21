Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D4F69D9E9
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 04:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjBUD5n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Feb 2023 22:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjBUD5m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Feb 2023 22:57:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CCB244A2;
        Mon, 20 Feb 2023 19:57:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLQV52BB8z4f3wYl;
        Tue, 21 Feb 2023 11:57:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3q+ktQfRj8VfgDw--.30652S3;
        Tue, 21 Feb 2023 11:57:35 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 1/7] ext4: properly handle error of ext4_init_block_bitmap in ext4_read_block_bitmap_nowait
Date:   Tue, 21 Feb 2023 19:59:13 +0800
Message-Id: <20230221115919.1918161-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3q+ktQfRj8VfgDw--.30652S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1DAr43uw1kArWkJr17GFg_yoW8XrWfp3
        9IkFWDKrn8ur1qga17tr9Yq3W8Kw1kKr1UGFWrC343XFW7JrnruF97KF1DuF40qF42qFnx
        XF1ruFyxAr1xXrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRiDGYDUUUUU=
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

We mark buffer_head of bitmap successfully initialized even error occurs
in ext4_init_block_bitmap. Although we will return error, we will get a
invalid buffer_head of bitmap from next ext4_read_block_bitmap_nowait
which is marked buffer_verified but not successfully initialized actually
in previous ext4_read_block_bitmap_nowait.
Fix this by only marking buffer_head successfully initialized if
ext4_init_block_bitmap successes.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8ff4b9192a9f..10cab743e313 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -474,16 +474,18 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 			goto out;
 		}
 		err = ext4_init_block_bitmap(sb, bh, block_group, desc);
-		set_bitmap_uptodate(bh);
-		set_buffer_uptodate(bh);
-		set_buffer_verified(bh);
-		ext4_unlock_group(sb, block_group);
-		unlock_buffer(bh);
 		if (err) {
+			ext4_unlock_group(sb, block_group);
+			unlock_buffer(bh);
 			ext4_error(sb, "Failed to init block bitmap for group "
 				   "%u: %d", block_group, err);
 			goto out;
 		}
+		set_bitmap_uptodate(bh);
+		set_buffer_uptodate(bh);
+		set_buffer_verified(bh);
+		ext4_unlock_group(sb, block_group);
+		unlock_buffer(bh);
 		goto verify;
 	}
 	ext4_unlock_group(sb, block_group);
-- 
2.30.0

