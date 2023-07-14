Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B60752FA2
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jul 2023 04:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjGNC5c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jul 2023 22:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjGNC5b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jul 2023 22:57:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE9E2D5F
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jul 2023 19:57:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R2GNj6cJlz4f3kkY
        for <linux-ext4@vger.kernel.org>; Fri, 14 Jul 2023 10:57:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbGJubBkNcexNw--.62721S5;
        Fri, 14 Jul 2023 10:57:26 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yang.lee@linux.alibaba.com,
        yukuai3@huawei.com
Subject: [PATCH 1/3] jbd2: fix checkpoint cleanup performance regression
Date:   Fri, 14 Jul 2023 10:55:26 +0800
Message-Id: <20230714025528.564988-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
References: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbGJubBkNcexNw--.62721S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxJFyUWF17uw47AFyxXwb_yoWrGF4fpF
        ya934jyrZ5ur10krnavF48CFWFvF4kZryUWF9F9Fnaya1UGw4Iyry7try2gryUGr93Wa1a
        qr1UWrn8G3WYya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
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

From: Zhang Yi <yi.zhang@huawei.com>

journal_clean_one_cp_list() has been merged into
journal_shrink_one_cp_list(), but do chekpoint buffer cleanup from the
committing process is just a best effort, it should stop scan once it
meet a busy buffer, or else it will cause a lot of invalid buffer scan
and checks. We catch a performance regression when doing fs_mark tests
below.

Test cmd:
 ./fs_mark  -d  scratch  -s  1024  -n  10000  -t  1  -D  100  -N  100

Before merging checkpoint buffer cleanup:
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       8304.9            49033

After merging checkpoint buffer cleanup:
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       7649.0            50012
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       2107.1            50871

After merging checkpoint buffer cleanup, the total loop count in
journal_shrink_one_cp_list() could be up to 6,261,600+ (50,000+ ~
100,000+ in general), most of them are invalid. This patch fix it
through passing 'shrink_type' into journal_shrink_one_cp_list() and add
a new 'SHRINK_BUSY_STOP' to indicate it should stop once meet a busy
buffer. After fix, the loop count descending back to 10,000+.

After this fix:
 FSUse%        Count         Size    Files/sec     App Overhead
     95        10000         1024       8558.4            49109

Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/checkpoint.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 9ec91017a7f3..936c6d758a65 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -349,6 +349,8 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
+enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
+
 /*
  * journal_shrink_one_cp_list
  *
@@ -360,7 +362,8 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						bool destroy, bool *released)
+						enum shrink_type type,
+						bool *released)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
@@ -376,12 +379,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (destroy) {
+		if (type == SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
 		} else {
 			ret = jbd2_journal_try_remove_checkpoint(jh);
-			if (ret < 0)
-				continue;
+			if (ret < 0) {
+				if (type == SHRINK_BUSY_SKIP)
+					continue;
+				break;
+			}
 		}
 
 		nr_freed++;
@@ -445,7 +451,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		tid = transaction->t_tid;
 
 		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   false, &released);
+						   SHRINK_BUSY_SKIP, &released);
 		nr_freed += freed;
 		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
@@ -485,19 +491,21 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
+	enum shrink_type type;
 	bool released;
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
 		return;
 
+	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
 	last_transaction = transaction->t_cpprev;
 	next_transaction = transaction;
 	do {
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-					   destroy, &released);
+					   type, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if
-- 
2.39.2

