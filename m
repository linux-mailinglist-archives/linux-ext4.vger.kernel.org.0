Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9257324FA
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 04:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjFPCAq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 22:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjFPCAp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 22:00:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CA62D55
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 19:00:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qj2Rt0t6Nz4f3jJF
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 10:00:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCHK583wotk1M05Lw--.53637S4;
        Fri, 16 Jun 2023 10:00:26 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH v2] jbd2: skip reading super block if it has been verified
Date:   Fri, 16 Jun 2023 09:55:47 +0800
Message-Id: <20230616015547.3155195-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHK583wotk1M05Lw--.53637S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45try5uF1kWrW7Jry8Grg_yoW5AFy5pr
        y3KFy8urWvvr15Aa18tFs7CFWUWay0yFyUGrn7uwn2yay8Xrnrtr9rKr15JF90yFW8Wa48
        tF4DKa9akw4qkwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

We got a NULL pointer dereference issue below while running generic/475
I/O failure pressure test.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: 0002 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 15600 Comm: fsstress Not tainted 6.4.0-rc5-xfstests-00055-gd3ab1bca26b4 #190
 RIP: 0010:jbd2_journal_set_features+0x13d/0x430
 ...
 Call Trace:
  <TASK>
  ? __die+0x23/0x60
  ? page_fault_oops+0xa4/0x170
  ? exc_page_fault+0x67/0x170
  ? asm_exc_page_fault+0x26/0x30
  ? jbd2_journal_set_features+0x13d/0x430
  jbd2_journal_revoke+0x47/0x1e0
  __ext4_forget+0xc3/0x1b0
  ext4_free_blocks+0x214/0x2f0
  ext4_free_branches+0xeb/0x270
  ext4_ind_truncate+0x2bf/0x320
  ext4_truncate+0x1e4/0x490
  ext4_handle_inode_extension+0x1bd/0x2a0
  ? iomap_dio_complete+0xaf/0x1d0

The root cause is the journal super block had been failed to write out
due to I/O fault injection, it's uptodate bit was cleared by
end_buffer_write_sync() and didn't reset yet in jbd2_write_superblock().
And it raced by journal_get_superblock()->bh_read(), unfortunately, the
read IO is also failed, so the error handling in
journal_fail_superblock() unexpectedly clear the journal->j_sb_buffer,
finally lead to above NULL pointer dereference issue.

If the journal super block had been read and verified, there is no need
to call bh_read() read it again even if it has been failed to written
out. So the fix could be simply move buffer_verified(bh) in front of
bh_read(). Also remove a stale comment left in
jbd2_journal_check_used_features().

Fixes: 51bacdba23d8 ("jbd2: factor out journal initialization from journal_get_superblock()")
Reported-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v1->v2:
 - Remove a stale comment left in jbd2_journal_check_used_features().

 fs/jbd2/journal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b5e57735ab3f..559242df0f9a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1919,6 +1919,9 @@ static int journal_get_superblock(journal_t *journal)
 	bh = journal->j_sb_buffer;
 
 	J_ASSERT(bh != NULL);
+	if (buffer_verified(bh))
+		return 0;
+
 	err = bh_read(bh, 0);
 	if (err < 0) {
 		printk(KERN_ERR
@@ -1926,9 +1929,6 @@ static int journal_get_superblock(journal_t *journal)
 		goto out;
 	}
 
-	if (buffer_verified(bh))
-		return 0;
-
 	sb = journal->j_superblock;
 
 	err = -EINVAL;
@@ -2229,7 +2229,6 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 
 	if (!compat && !ro && !incompat)
 		return 1;
-	/* Load journal superblock if it is not loaded yet. */
 	if (journal_get_superblock(journal))
 		return 0;
 	if (!jbd2_format_support_feature(journal))
-- 
2.39.2

