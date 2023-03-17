Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9C66BE558
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCQJRr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 05:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCQJRo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 05:17:44 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3CA4B00
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 02:17:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PdJS63ndBz4f3lnm
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 17:17:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMcMBRkQ24kFg--.44440S7;
        Fri, 17 Mar 2023 17:17:28 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v2 3/3] debugfs/e2fsck: check bad s_head block number
Date:   Fri, 17 Mar 2023 17:17:16 +0800
Message-Id: <20230317091716.4150992-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317091716.4150992-1-yi.zhang@huaweicloud.com>
References: <20230317091716.4150992-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMcMBRkQ24kFg--.44440S7
X-Coremail-Antispam: 1UD129KBjvJXoW7uF47XryfKr47Jw1kJF4fXwb_yoW8Ww4DpF
        srGFyDAry09w4YqryfGw45JFWrZryqkFWUKrWDu3sayw4ag3Wfta4Ygw17ta4Duw4jgw10
        qrnYq3Z7Cw10gwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JULtxhUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Check s_head in the journal superblock and fix it if this value is out
of bounds.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 debugfs/journal.c | 5 +++++
 e2fsck/journal.c  | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 5bc7552d..1eef3bca 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -631,6 +631,11 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	else if (ntohl(jsb->s_maxlen) > journal->j_total_len)
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
+	if (jsb->s_head != 0 &&
+	    (ntohl(jsb->s_head) < ntohl(jsb->s_first) ||
+	     ntohl(jsb->s_head) >= journal->j_total_len))
+		return EXT2_ET_CORRUPT_JOURNAL_SB;
+
 	journal->j_tail_sequence = ntohl(jsb->s_sequence);
 	journal->j_transaction_sequence = journal->j_tail_sequence;
 	journal->j_tail = ntohl(jsb->s_start);
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 8950446f..4b9f00ce 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -1374,6 +1374,15 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 	}
 
+	if (jsb->s_head != 0 &&
+	    (ntohl(jsb->s_head) < ntohl(jsb->s_first) ||
+	     ntohl(jsb->s_head) >= journal->j_total_len)) {
+		com_err(ctx->program_name, EXT2_ET_CORRUPT_JOURNAL_SB,
+			_("%s, journal head out of bounds\n"),
+			ctx->device_name);
+		return EXT2_ET_CORRUPT_JOURNAL_SB;
+	}
+
 	journal->j_tail_sequence = ntohl(jsb->s_sequence);
 	journal->j_transaction_sequence = journal->j_tail_sequence;
 	journal->j_tail = ntohl(jsb->s_start);
-- 
2.31.1

