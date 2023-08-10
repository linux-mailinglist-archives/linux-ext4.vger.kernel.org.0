Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49E977736A
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbjHJIyl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 04:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjHJIyf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 04:54:35 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580E2123
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 01:54:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RM12D4m7xz4f3s6l
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 16:54:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqm6pdRkGjJ7AQ--.1500S8;
        Thu, 10 Aug 2023 16:54:31 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v2 04/12] jbd2: checking valid features early in journal_get_superblock()
Date:   Thu, 10 Aug 2023 16:54:09 +0800
Message-Id: <20230810085417.1501293-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
References: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqm6pdRkGjJ7AQ--.1500S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tw18Zw48AF18GF17CF1UGFg_yoW8Aw45pw
        1fAa4rZrykZry7u3Z3tFsrXFWrZw10yayUGrWku3W8Ka13Gwnrtw1jkFn5J34kAayUW3y8
        WF15GanrC34qv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUArcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

journal_get_superblock() is used to check validity of the jounal
supberblock, so move the features checks from jbd2_journal_load() to
journal_get_superblock().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c7cdb434966f..d84f26b08315 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1398,6 +1398,21 @@ static int journal_get_superblock(journal_t *journal)
 		goto out;
 	}
 
+	/*
+	 * If this is a V2 superblock, then we have to check the
+	 * features flags on it.
+	 */
+	if (!jbd2_format_support_feature(journal))
+		return 0;
+
+	if ((sb->s_feature_ro_compat &
+			~cpu_to_be32(JBD2_KNOWN_ROCOMPAT_FEATURES)) ||
+	    (sb->s_feature_incompat &
+			~cpu_to_be32(JBD2_KNOWN_INCOMPAT_FEATURES))) {
+		printk(KERN_WARNING "JBD2: Unrecognised features on journal\n");
+		goto out;
+	}
+
 	if (jbd2_has_feature_csum2(journal) &&
 	    jbd2_has_feature_csum3(journal)) {
 		/* Can't have checksum v2 and v3 at the same time! */
@@ -2059,21 +2074,6 @@ int jbd2_journal_load(journal_t *journal)
 	int err;
 	journal_superblock_t *sb = journal->j_superblock;
 
-	/*
-	 * If this is a V2 superblock, then we have to check the
-	 * features flags on it.
-	 */
-	if (jbd2_format_support_feature(journal)) {
-		if ((sb->s_feature_ro_compat &
-		     ~cpu_to_be32(JBD2_KNOWN_ROCOMPAT_FEATURES)) ||
-		    (sb->s_feature_incompat &
-		     ~cpu_to_be32(JBD2_KNOWN_INCOMPAT_FEATURES))) {
-			printk(KERN_WARNING
-				"JBD2: Unrecognised features on journal\n");
-			return -EINVAL;
-		}
-	}
-
 	/*
 	 * Create a slab for this blocksize
 	 */
-- 
2.34.3

