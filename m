Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A61778789
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjHKGgg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjHKGga (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:36:30 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B5826A6
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:36:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMYwV3v5Tz4f3w0N
        for <linux-ext4@vger.kernel.org>; Fri, 11 Aug 2023 14:36:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6na1tVkKEbDAQ--.35746S13;
        Fri, 11 Aug 2023 14:36:27 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v3 09/12] jbd2: drop useless error tag in jbd2_journal_wipe()
Date:   Fri, 11 Aug 2023 14:36:07 +0800
Message-Id: <20230811063610.2980059-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
References: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6na1tVkKEbDAQ--.35746S13
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrWry3GF1xCFy8ur45ZFb_yoWDJrb_Xa
        10vrWxW39xJr47A3y5C3yUurs09rs7ur1kGw1xtw4DKryDJ3ZIqFn7try5tryxuw1kKrW7
        Ja9rKr4Svr9rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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

no_recovery is redundant, just drop it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 708d58d69592..061887368ad5 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2498,12 +2498,12 @@ int jbd2_journal_flush(journal_t *journal, unsigned int flags)
 
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
@@ -2516,7 +2516,6 @@ int jbd2_journal_wipe(journal_t *journal, int write)
 		mutex_unlock(&journal->j_checkpoint_mutex);
 	}
 
- no_recovery:
 	return err;
 }
 
-- 
2.34.3

