Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895C69D9F0
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 04:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjBUD5s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Feb 2023 22:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjBUD5n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Feb 2023 22:57:43 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491C24CAC;
        Mon, 20 Feb 2023 19:57:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PLQV56rBbz4f3tDj;
        Tue, 21 Feb 2023 11:57:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3q+ktQfRj8VfgDw--.30652S6;
        Tue, 21 Feb 2023 11:57:36 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH 4/7] ext4: remove unnecessary check in ext4_bg_num_gdb_nometa
Date:   Tue, 21 Feb 2023 19:59:16 +0800
Message-Id: <20230221115919.1918161-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3q+ktQfRj8VfgDw--.30652S6
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWUWr4xJF18KrykJFW5ZFb_yoWfArc_Ka
        y7XF1xua43Xw1fKa4xKws5K347Kr4vyr45XFn3try3ua48tayxA34DArs3ZayDuF47ArZ5
        Za4xu347tw4IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbgkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
        64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM2
        8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
        8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjTRQIDrUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We only call ext4_bg_num_gdb_nometa if there is no meta_bg feature or group
does not reach first_meta_bg, so group must not reside in meta group. Then
group has a global gdt if superblock exists. Just remove confusing branch
that meta_bg feature exists.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 9b8a32b90ddc..08f1692f7d2f 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -844,10 +844,7 @@ static unsigned long ext4_bg_num_gdb_nometa(struct super_block *sb,
 	if (!ext4_bg_has_super(sb, group))
 		return 0;
 
-	if (ext4_has_feature_meta_bg(sb))
-		return le32_to_cpu(EXT4_SB(sb)->s_es->s_first_meta_bg);
-	else
-		return EXT4_SB(sb)->s_gdb_count;
+	return EXT4_SB(sb)->s_gdb_count;
 }
 
 /**
-- 
2.30.0

