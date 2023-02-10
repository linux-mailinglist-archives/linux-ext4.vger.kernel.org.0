Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A96916ED
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Feb 2023 03:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBJC5J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 21:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBJC5F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 21:57:05 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25381663D2;
        Thu,  9 Feb 2023 18:57:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PCdgH3YWsz4f3nTL;
        Fri, 10 Feb 2023 10:56:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR96suVjIkgqDA--.35208S7;
        Fri, 10 Feb 2023 10:57:01 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 3/6] jbd2: do extra handle when do journal recovery
Date:   Fri, 10 Feb 2023 11:20:41 +0800
Message-Id: <20230210032044.146115-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230210032044.146115-1-yebin@huaweicloud.com>
References: <20230210032044.146115-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR96suVjIkgqDA--.35208S7
X-Coremail-Antispam: 1UD129KBjvJXoW7urWfWr1fuw4xtr4rWF4UArb_yoW8Xw13pw
        15Cr95KrWqvr17A3Z3JwsFgFWaqr4FyFWUGFsI93Zayay5trZFk3yxtwn0gFW8Jr15K3yr
        JF15J3y8KwnYkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2PEfUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Ext4 file system's super block in journal maybe not uptodate, when
file system has error, we need set error information when do recover
uper block.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 8286a9ec122f..83b1a9689984 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -309,6 +309,15 @@ int jbd2_journal_recover(journal_t *journal)
 		return 0;
 	}
 
+	if (journal->j_replay_prepare_callback) {
+		err = journal->j_replay_prepare_callback(journal);
+		if (err) {
+			jbd2_debug(1, "JBD2: failed to prepare replay %d",
+				   err);
+			return err;
+		}
+	}
+
 	err = do_one_pass(journal, &info, PASS_SCAN);
 	if (!err)
 		err = do_one_pass(journal, &info, PASS_REVOKE);
@@ -335,6 +344,10 @@ int jbd2_journal_recover(journal_t *journal)
 		if (!err)
 			err = err2;
 	}
+
+	if (journal->j_replay_end_callback)
+		journal->j_replay_end_callback(journal);
+
 	return err;
 }
 
@@ -687,6 +700,20 @@ static int do_one_pass(journal_t *journal,
 						*((__be32 *)nbh->b_data) =
 						cpu_to_be32(JBD2_MAGIC_NUMBER);
 					}
+					if (unlikely(journal->j_replay_callback)) {
+						err = journal->j_replay_callback(
+							journal, nbh);
+						if (err) {
+							printk(KERN_ERR
+							       "JBD2: replay "
+							       "call back "
+							       "failed.\n");
+							unlock_buffer(nbh);
+							brelse(obh);
+							brelse(nbh);
+							goto failed;
+						}
+					}
 
 					BUFFER_TRACE(nbh, "marking dirty");
 					set_buffer_uptodate(nbh);
-- 
2.31.1

