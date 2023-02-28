Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140316A51F2
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 04:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjB1DmF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Feb 2023 22:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjB1Dlj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Feb 2023 22:41:39 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF9D2449A;
        Mon, 27 Feb 2023 19:41:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQjpQ3MWnz4f3wQk;
        Tue, 28 Feb 2023 11:41:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrod_1jpDeZEQ--.58449S18;
        Tue, 28 Feb 2023 11:41:36 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 16/20] ext4: remove unnecessary count2 in ext4_free_data_in_buddy
Date:   Tue, 28 Feb 2023 19:43:02 +0800
Message-Id: <20230228114306.3328235-17-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
References: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrod_1jpDeZEQ--.58449S18
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWkWFW8JFWrJr1rXr1UJrb_yoW8GF1rpa
        s8Ca4Uurs5Wr1kuanrCayvqw1Iq3929Fy7try5ur1fJFy3Jr9YqFn3tryruFy8tFZ2yr1a
        vFWj9ryUC3W3G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

count2 is always 1 in mb_debug, just remove unnecessary count2.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1175c81f8e2d..977f89856aed 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3590,7 +3590,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 {
 	struct ext4_buddy e4b;
 	struct ext4_group_info *db;
-	int err, count = 0, count2 = 0;
+	int err, count = 0;
 
 	mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
 		 entry->efd_count, entry->efd_group, entry);
@@ -3606,7 +3606,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	db = e4b.bd_info;
 	/* there are blocks to put in buddy to make them really free */
 	count += entry->efd_count;
-	count2++;
 	ext4_lock_group(sb, entry->efd_group);
 	/* Take it out of per group rb tree */
 	rb_erase(&entry->efd_node, &(db->bb_free_root));
@@ -3631,8 +3630,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	ext4_unlock_group(sb, entry->efd_group);
 	ext4_mb_unload_buddy(&e4b);
 
-	mb_debug(sb, "freed %d blocks in %d structures\n", count,
-		 count2);
+	mb_debug(sb, "freed %d blocks in 1 structures\n", count);
 }
 
 /*
-- 
2.30.0

