Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05F778786
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjHKGgd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHKGg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:36:29 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602942D55
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:36:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RMYwR3zY9z4f3v7B
        for <linux-ext4@vger.kernel.org>; Fri, 11 Aug 2023 14:36:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6na1tVkKEbDAQ--.35746S9;
        Fri, 11 Aug 2023 14:36:26 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v3 05/12] jbd2: open code jbd2_verify_csum_type() helper
Date:   Fri, 11 Aug 2023 14:36:03 +0800
Message-Id: <20230811063610.2980059-6-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
References: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6na1tVkKEbDAQ--.35746S9
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxXry3Cr4UZF4xuF43trb_yoW8WFyUpr
        W3Ga48uryv9ry7A3W0yF4kAFWrZa1YkFWUWFsF93Z2vay7ZwnrJ345tr1rXa4FyFy8C3y0
        qF1rKws2k3Wjva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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

jbd2_verify_csum_type() helper check checksum type in the superblock for
v2 or v3 checksum feature, it always return true if these features are
not enabled, and it has only one user, so open code it is more clear.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d84f26b08315..46ab47b4439e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -115,14 +115,6 @@ void __jbd2_debug(int level, const char *file, const char *func,
 #endif
 
 /* Checksumming functions */
-static int jbd2_verify_csum_type(journal_t *j, journal_superblock_t *sb)
-{
-	if (!jbd2_journal_has_csum_v2or3_feature(j))
-		return 1;
-
-	return sb->s_checksum_type == JBD2_CRC32C_CHKSUM;
-}
-
 static __be32 jbd2_superblock_csum(journal_t *j, journal_superblock_t *sb)
 {
 	__u32 csum;
@@ -1429,13 +1421,13 @@ static int journal_get_superblock(journal_t *journal)
 		goto out;
 	}
 
-	if (!jbd2_verify_csum_type(journal, sb)) {
-		printk(KERN_ERR "JBD2: Unknown checksum type\n");
-		goto out;
-	}
-
 	/* Load the checksum driver */
 	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
+		if (sb->s_checksum_type != JBD2_CRC32C_CHKSUM) {
+			printk(KERN_ERR "JBD2: Unknown checksum type\n");
+			goto out;
+		}
+
 		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
 		if (IS_ERR(journal->j_chksum_driver)) {
 			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
-- 
2.34.3

