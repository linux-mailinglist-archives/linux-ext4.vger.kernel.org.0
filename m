Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECEE6C1315
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 14:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjCTNSv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 09:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjCTNSV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 09:18:21 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20371B567;
        Mon, 20 Mar 2023 06:18:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PgFfV63n2z4f3jY9;
        Mon, 20 Mar 2023 21:18:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrEQXRhkWTLvFg--.47360S2;
        Mon, 20 Mar 2023 21:18:10 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     error27@gmail.com, jack@suse.cz, shikemeng@huaweicloud.com
Subject: [PATCH] ext4: avoid to access uninitialized block_cluster
Date:   Tue, 21 Mar 2023 05:21:06 +0800
Message-Id: <20230320212106.4164212-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrEQXRhkWTLvFg--.47360S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFy7JF4UCr4fJw1DKF4fAFb_yoW8Jr48pw
        sIy3W5GrW5ur1qga1fJr97Xw4rGw18Kr17Ja43Cr13WFZrXw4xJF95tFs0vF1j9rZrCF9I
        vr129rWUu3s5G37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If inode bitmap block and block bitmap block are in different group,
there is a risk to access uninitialized block_cluster in
ext4_num_overhead_clusters. Initialize block_cluster to -1 to fix this.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202303171446.eLEhZzAu-lkp@intel.com/
Fixes: e3c70113e2cb ("ext4: improve inode table blocks counting in ext4_num_overhead_clusters")
---
 fs/ext4/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 49fdb758b0e4..094269488183 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -89,7 +89,7 @@ static unsigned ext4_num_overhead_clusters(struct super_block *sb,
 					   struct ext4_group_desc *gdp)
 {
 	unsigned base_clusters, num_clusters;
-	int block_cluster, inode_cluster;
+	int block_cluster = -1, inode_cluster;
 	int itbl_cluster_start = -1, itbl_cluster_end = -1;
 	ext4_fsblk_t start = ext4_group_first_block_no(sb, block_group);
 	ext4_fsblk_t end = start + EXT4_BLOCKS_PER_GROUP(sb) - 1;
-- 
2.30.0

