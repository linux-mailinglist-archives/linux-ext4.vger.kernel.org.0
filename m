Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64AF77736D
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjHJIyo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 04:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjHJIyg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 04:54:36 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C052115
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 01:54:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RM12H3kPLz4f41Rx
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 16:54:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqm6pdRkGjJ7AQ--.1500S11;
        Thu, 10 Aug 2023 16:54:32 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v2 07/12] jbd2: add fast_commit space check
Date:   Thu, 10 Aug 2023 16:54:12 +0800
Message-Id: <20230810085417.1501293-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
References: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqm6pdRkGjJ7AQ--.1500S11
X-Coremail-Antispam: 1UD129KBjvJXoW7KF18JF17JF1ktF15Xr43KFg_yoW5JFWUpa
        y7GryfurWDZrW7Z3Z7tF4DJFWFva4jyFWUGrsakwnaka1Utrnxtw1DJr15J3WqyFW5u340
        qF15Gw17Cw18K3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18BUUUUU
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

If JBD2_FEATURE_INCOMPAT_FAST_COMMIT bit is set, it means the journal
have fast commit records need to recover, so the fast commit size
should not be too large, and the leftover normal journal size should
never less than JBD2_MIN_JOURNAL_BLOCKS. If it happens, the
journal->j_last is likely to be wrong and will probably lead to
incorrect journal recovery. So add a check into the
journal_check_superblock(), and drop the pointless check when
initializing the fastcommit parameters.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a8d17070073b..5e2206e7a5ba 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1347,6 +1347,7 @@ static void journal_fail_superblock(journal_t *journal)
 static int journal_check_superblock(journal_t *journal)
 {
 	journal_superblock_t *sb = journal->j_superblock;
+	int num_fc_blks;
 	int err = -EINVAL;
 
 	if (sb->s_header.h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
@@ -1389,6 +1390,14 @@ static int journal_check_superblock(journal_t *journal)
 		return err;
 	}
 
+	num_fc_blks = jbd2_has_feature_fast_commit(journal) ?
+				jbd2_journal_get_num_fc_blks(sb) : 0;
+	if (be32_to_cpu(sb->s_maxlen) < JBD2_MIN_JOURNAL_BLOCKS + num_fc_blks) {
+		printk(KERN_ERR "JBD2: journal file too short %u,%d\n",
+		       be32_to_cpu(sb->s_maxlen), num_fc_blks);
+		return err;
+	}
+
 	if (jbd2_has_feature_csum2(journal) &&
 	    jbd2_has_feature_csum3(journal)) {
 		/* Can't have checksum v2 and v3 at the same time! */
@@ -1454,7 +1463,6 @@ static int journal_load_superblock(journal_t *journal)
 	int err;
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
-	int num_fc_blocks;
 
 	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
 			      journal->j_blocksize);
@@ -1492,9 +1500,8 @@ static int journal_load_superblock(journal_t *journal)
 
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
-		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
-			journal->j_last = journal->j_fc_last - num_fc_blocks;
+		journal->j_last = journal->j_fc_last -
+				  jbd2_journal_get_num_fc_blks(sb);
 		journal->j_fc_first = journal->j_last + 1;
 		journal->j_fc_off = 0;
 	}
-- 
2.34.3

