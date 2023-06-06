Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC6172451A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjFFOAO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbjFFN7p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 09:59:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AA10EB
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 06:59:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbBtL3vHBz4f3wtn
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 21:59:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+XBO39kUFbyKw--.11143S10;
        Tue, 06 Jun 2023 21:59:39 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v3 6/6] jbd2: remove __journal_try_to_free_buffer()
Date:   Tue,  6 Jun 2023 21:59:28 +0800
Message-Id: <20230606135928.434610-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXB+XBO39kUFbyKw--.11143S10
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1DXw47Zr4rKrWDuw4xCrg_yoW8ZF4Dpr
        yak3y7Zryqva48Zr18XF4rArWjqa1jvryUGrZru3Z3ta15AwsIv347tr1IqryDtFWSga15
        Xr1UC3s8Cw4jy3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

__journal_try_to_free_buffer() has only one caller and it's logic is
much simple now, so just remove it and open code in
jbd2_journal_try_to_free_buffers().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 6ef5022949c4..4d1fda1f7143 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2099,29 +2099,6 @@ void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
 	__brelse(bh);
 }
 
-/*
- * Called from jbd2_journal_try_to_free_buffers().
- *
- * Called under jh->b_state_lock
- */
-static void
-__journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
-{
-	struct journal_head *jh;
-
-	jh = bh2jh(bh);
-
-	if (jh->b_next_transaction != NULL || jh->b_transaction != NULL)
-		return;
-
-	spin_lock(&journal->j_list_lock);
-	/* Remove written-back checkpointed metadata buffer */
-	if (jh->b_cp_transaction != NULL)
-		jbd2_journal_try_remove_checkpoint(jh);
-	spin_unlock(&journal->j_list_lock);
-	return;
-}
-
 /**
  * jbd2_journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
@@ -2179,7 +2156,13 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
 			continue;
 
 		spin_lock(&jh->b_state_lock);
-		__journal_try_to_free_buffer(journal, bh);
+		if (!jh->b_transaction && !jh->b_next_transaction) {
+			spin_lock(&journal->j_list_lock);
+			/* Remove written-back checkpointed metadata buffer */
+			if (jh->b_cp_transaction != NULL)
+				jbd2_journal_try_remove_checkpoint(jh);
+			spin_unlock(&journal->j_list_lock);
+		}
 		spin_unlock(&jh->b_state_lock);
 		jbd2_journal_put_journal_head(jh);
 		if (buffer_jbd(bh))
-- 
2.31.1

