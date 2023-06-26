Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5373D890
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFZHdt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jun 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFZHdr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jun 2023 03:33:47 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C2102
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 00:33:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QqKMk4v8cz4f3qRc
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 15:33:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgBnVuRCP5lkKJjyMQ--.19897S4;
        Mon, 26 Jun 2023 15:33:38 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        harshadshirwadkar@gmail.com, yi.zhang@huawei.com,
        yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH] jbd2: correct the end of the journal recovery scan range
Date:   Mon, 26 Jun 2023 15:33:22 +0800
Message-Id: <20230626073322.3956567-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnVuRCP5lkKJjyMQ--.19897S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kCw17tFy8uF4DuF4Uurg_yoW5Ww1rpF
        43JryftFWDAr1UXFs3Jr4UJFW0qayqyFWUWrn0kw1vyr1Yyrn2kwn7tr1fJFyUArW09348
        tF1UA34UKw1Yka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

We got a filesystem inconsistency issue below while running generic/475
I/O failure pressure test with fast_commit feature enabled.

 Symlink /p3/d3/d1c/d6c/dd6/dce/l101 (inode #132605) is invalid.

If fast_commit feature is enabled, a special fast_commit journal area is
appended to the end of the normal journal area. The journal->j_last
point to the first unused block behind the normal journal area instead
of the whole log area, and the journal->j_fc_last point to the first
unused block behind the fast_commit journal area. While doing journal
recovery, do_one_pass(PASS_SCAN) should first scan the normal journal
area and turn around to the first block once it meet journal->j_last,
but the wrap() macro misuse the journal->j_fc_last, so the recovering
could not read the next magic block (commit block perhaps) and would end
early mistakenly and missing tN and every transaction after it in the
following example. Finally, it could lead to filesystem inconsistency.

 | normal journal area                             | fast commit area |
 +-------------------------------------------------+------------------+
 | tN(rere) | tN+1 |~| tN-x |...| tN-1 | tN(front) |       ....       |
 +-------------------------------------------------+------------------+
                     /                             /                  /
                start               journal->j_last journal->j_fc_last

This patch fix it by use the correct ending journal->j_last.

Fixes: 5b849b5f96b4 ("jbd2: fast commit recovery path")
Reported-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/linux-ext4/20230613043120.GB1584772@mit.edu/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/recovery.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 0184931d47f7..c269a7d29a46 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -230,12 +230,8 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	unsigned long _wrap_last =					\
-		jbd2_has_feature_fast_commit(journal) ?			\
-			(journal)->j_fc_last : (journal)->j_last;	\
-									\
-	if (var >= _wrap_last)						\
-		var -= (_wrap_last - (journal)->j_first);		\
+	if (var >= (journal)->j_last)					\
+		var -= ((journal)->j_last - (journal)->j_first);	\
 } while (0)
 
 static int fc_do_one_pass(journal_t *journal,
@@ -524,9 +520,7 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd2_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block,
-			  jbd2_has_feature_fast_commit(journal) ?
-			  journal->j_fc_last : journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
-- 
2.31.1

