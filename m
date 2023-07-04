Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85744747303
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGDNoM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjGDNoH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 09:44:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E5D11D
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 06:44:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QwPCN4BDxz4f3mJb
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 21:44:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLASIqRk9WjENA--.31120S11;
        Tue, 04 Jul 2023 21:44:02 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH 07/12] jbd2: add fast_commit space check
Date:   Tue,  4 Jul 2023 21:42:28 +0800
Message-Id: <20230704134233.110812-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLASIqRk9WjENA--.31120S11
X-Coremail-Antispam: 1UD129KBjvJXoW7KF18JF17JF1ktF15Ww4Durg_yoW8ury5pF
        W7GryakrW8ZrW7Z3WxJF4DJFWFva4jyFWUGr9ak3sYkw4UtwnIk34qqr15J3WqyFWj9340
        qFnIyw1UCw1rt3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

If JBD2_FEATURE_INCOMPAT_FAST_COMMIT bit is set, it means the journal
have fast commit records need to recover, so the fast commit size
should not be zero, and also the leftover normal journal size should
never less than JBD2_MIN_JOURNAL_BLOCKS. Add a check into the
journal_check_superblock() and drop the pointless branch when
initializing in-memory fastcommit parameters.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index efdb8db3c06e..210b532a3673 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1392,6 +1392,18 @@ static int journal_check_superblock(journal_t *journal)
 		return err;
 	}
 
+	if (jbd2_has_feature_fast_commit(journal)) {
+		int num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
+
+		if (!num_fc_blks ||
+		    (be32_to_cpu(sb->s_maxlen) - num_fc_blks <
+		     JBD2_MIN_JOURNAL_BLOCKS)) {
+			printk(KERN_ERR "JBD2: Invalid fast commit size %d\n",
+			       num_fc_blks);
+			return err;
+		}
+	}
+
 	if (jbd2_has_feature_csum2(journal) &&
 	    jbd2_has_feature_csum3(journal)) {
 		/* Can't have checksum v2 and v3 at the same time! */
@@ -1460,7 +1472,6 @@ static int journal_load_superblock(journal_t *journal)
 	int err;
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
-	int num_fc_blocks;
 
 	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
 			      journal->j_blocksize);
@@ -1498,9 +1509,8 @@ static int journal_load_superblock(journal_t *journal)
 
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
-		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
-			journal->j_last = journal->j_fc_last - num_fc_blocks;
+		journal->j_last = journal->j_fc_last -
+				  be32_to_cpu(sb->s_num_fc_blks);
 		journal->j_fc_first = journal->j_last + 1;
 		journal->j_fc_off = 0;
 	}
-- 
2.39.2

