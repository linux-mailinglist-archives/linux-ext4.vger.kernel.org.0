Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A29730DC4
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 05:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbjFODzk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 23:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243266AbjFODzG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 23:55:06 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753652D4E
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 20:54:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QhT1j30czz4f3tP0
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 11:54:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCXaK9mi4pk8VfzLg--.12807S4;
        Thu, 15 Jun 2023 11:54:18 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH] jbd2: skip reading super block if it has been verified
Date:   Thu, 15 Jun 2023 11:49:41 +0800
Message-Id: <20230615034941.2335484-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCXaK9mi4pk8VfzLg--.12807S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CryrZF13Cry3Cw1kJr1fWFg_yoW5JFW7pr
        y3KFy8CrWvvr1UCa18tFsrAFWUZa1jyFyUGr4kCwn7Zay3Jrnxtr9rtr45XF98JFWkua40
        qF4DKayrKw4q9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
bh_read().

Fixes: d9eafe0afafa ("jbd2: factor out journal initialization from journal_get_superblock()")
Reported-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b5e57735ab3f..0cabce7b31bf 100644
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
-- 
2.39.2

