Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83BA6A93A8
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 10:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCCJUE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 04:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCCJTx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 04:19:53 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC0734301;
        Fri,  3 Mar 2023 01:19:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSj9H1Ldtz4f3mJY;
        Fri,  3 Mar 2023 17:19:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGyuwFkFpqfEg--.45687S5;
        Fri, 03 Mar 2023 17:19:49 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 03/20] ext4: get correct ext4_group_info in ext4_mb_prefetch_fini
Date:   Sat,  4 Mar 2023 01:21:03 +0800
Message-Id: <20230303172120.3800725-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGyuwFkFpqfEg--.45687S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5Jw1fAr4kGrykCr45KFg_yoW8JFWxpw
        nxCF1UurW5Wr1DCw40k3y0q3Wxtw1Igry8XryfWw15urWxJrykXFy3KF18AF18JFZa9r1a
        vw1YvF13Cr1xC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRPEf5UUUUU
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

We always get ext4_group_desc with group + 1 and ext4_group_info with
group to check if we need do initialize ext4_group_info for the group.
Just get ext4_group_desc with group for ext4_group_info initialization
check.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6122278e91eb..d1c5b6ea57da 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2569,14 +2569,14 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 			   unsigned int nr)
 {
-	while (nr-- > 0) {
-		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
-								  NULL);
-		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
+	struct ext4_group_desc *gdp;
+	struct ext4_group_info *grp;
 
+	while (nr-- > 0) {
 		if (!group)
 			group = ext4_get_groups_count(sb);
 		group--;
+		gdp = ext4_get_group_desc(sb, group, NULL);
 		grp = ext4_get_group_info(sb, group);
 
 		if (EXT4_MB_GRP_NEED_INIT(grp) &&
-- 
2.30.0

