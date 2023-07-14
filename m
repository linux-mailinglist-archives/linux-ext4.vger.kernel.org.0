Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9A752FA3
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jul 2023 04:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjGNC5c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jul 2023 22:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjGNC5b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jul 2023 22:57:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BF62D63
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jul 2023 19:57:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R2GNk231Nz4f3mWD
        for <linux-ext4@vger.kernel.org>; Fri, 14 Jul 2023 10:57:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbGJubBkNcexNw--.62721S6;
        Fri, 14 Jul 2023 10:57:26 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yang.lee@linux.alibaba.com,
        yukuai3@huawei.com
Subject: [PATCH 2/3] jbd2: Check 'jh->b_transaction' before remove it from checkpoint
Date:   Fri, 14 Jul 2023 10:55:27 +0800
Message-Id: <20230714025528.564988-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
References: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbGJubBkNcexNw--.62721S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr17tF4DAw47Kw1DXry7Jrb_yoW8Cr4xpa
        s3Ka40grWkCr1UCr1IqF4UArWUKF4DZry7GrWqk3Zavw4jgwnF9r9xKr90yr98CrZY9a15
        tF15CFn3Wa12kaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

Following process will corrupt ext4 image:
Step 1:
jbd2_journal_commit_transaction
 __jbd2_journal_insert_checkpoint(jh, commit_transaction)
 // Put jh into trans1->t_checkpoint_list
 journal->j_checkpoint_transactions = commit_transaction
 // Put trans1 into journal->j_checkpoint_transactions

Step 2:
do_get_write_access
 test_clear_buffer_dirty(bh) // clear buffer dirty，set jbd dirty
 __jbd2_journal_file_buffer(jh, transaction) // jh belongs to trans2

Step 3:
drop_cache
 journal_shrink_one_cp_list
  jbd2_journal_try_remove_checkpoint
   if (!trylock_buffer(bh))  // lock bh, true
   if (buffer_dirty(bh))     // buffer is not dirty
   __jbd2_journal_remove_checkpoint(jh)
   // remove jh from trans1->t_checkpoint_list

Step 4:
jbd2_log_do_checkpoint
 trans1 = journal->j_checkpoint_transactions
 // jh is not in trans1->t_checkpoint_list
 jbd2_cleanup_journal_tail(journal)  // trans1 is done

Step 5: Power cut, trans2 is not committed, jh is lost in next mounting.

Fix it by checking 'jh->b_transaction' before remove it from checkpoint.

Fixes: 46f881b5b175 ("jbd2: fix a race when checking checkpoint buffer busy")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/checkpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 936c6d758a65..f033ac807013 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -639,6 +639,8 @@ int jbd2_journal_try_remove_checkpoint(struct journal_head *jh)
 {
 	struct buffer_head *bh = jh2bh(jh);
 
+	if (jh->b_transaction)
+		return -EBUSY;
 	if (!trylock_buffer(bh))
 		return -EBUSY;
 	if (buffer_dirty(bh)) {
-- 
2.39.2

