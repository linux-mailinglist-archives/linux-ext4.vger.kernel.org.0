Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F2E747301
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 15:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGDNoL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGDNoG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 09:44:06 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A8E6E
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 06:44:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QwPCP2MQQz4f3mJp
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 21:44:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLASIqRk9WjENA--.31120S13;
        Tue, 04 Jul 2023 21:44:03 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH 09/12] jbd2: drop useless error tag in jbd2_journal_wipe()
Date:   Tue,  4 Jul 2023 21:42:30 +0800
Message-Id: <20230704134233.110812-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLASIqRk9WjENA--.31120S13
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrWry3GrWUGF15Zr4xJFb_yoWfZFXEqa
        10v3yxW39xtr47A3yrC3yUursY9rs7ur1kWw1ftw4DKrWUJ3ZIqFn7tryjqryxuw1kKrW7
        X39Fkr40qa9rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl2NtUUUUU=
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

no_recovery is redundant, just drop it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 065b5e789299..cc344b8d7476 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2506,12 +2506,12 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 
 int jbd2_journal_wipe(journal_t *journal, int write)
 {
-	int err = 0;
+	int err;
 
 	J_ASSERT (!(journal->j_flags & JBD2_LOADED));
 
 	if (!journal->j_tail)
-		goto no_recovery;
+		return 0;
 
 	printk(KERN_WARNING "JBD2: %s recovery information on journal\n",
 		write ? "Clearing" : "Ignoring");
@@ -2524,7 +2524,6 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
- no_recovery:
 	return err;
 }
 
-- 
2.39.2

