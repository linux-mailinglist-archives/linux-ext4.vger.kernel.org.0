Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F415E68655B
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 12:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjBALXK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 06:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjBALXC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 06:23:02 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFF449E;
        Wed,  1 Feb 2023 03:22:59 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P6KKB1KlDz4f3mJX;
        Wed,  1 Feb 2023 19:22:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+NS9pj_j45Cg--.57546S7;
        Wed, 01 Feb 2023 19:22:56 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH 3/5] ext4: fix error flag covered by journal recovery
Date:   Wed,  1 Feb 2023 19:46:49 +0800
Message-Id: <20230201114651.4090446-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230201114651.4090446-1-yebin@huaweicloud.com>
References: <20230201114651.4090446-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+NS9pj_j45Cg--.57546S7
X-Coremail-Antispam: 1UD129KBjvJXoWxur43Jw15Cw4kCw1fCr45Wrg_yoW5CFy5pr
        WrCrySyFWqvr17Awn3JF4DWFWYg340yFWUGrnF93Zayay5Jrn2v3y8t3WrtFy0qrWrKa4r
        JF1UJ3yUCw15KrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Super block in journal maybe not uptodate, when file system has
error, we need set error information when do recover super block.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c    | 38 ++++++++++++++++----------------------
 fs/jbd2/recovery.c | 14 ++++++++++++++
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea0fea04907c..ab136d08d93d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5887,7 +5887,7 @@ static int ext4_load_journal(struct super_block *sb,
 		ext4_msg(sb, KERN_ERR,
 			 "journal device read-only, try mounting with '-o ro'");
 		err = -EROFS;
-		goto err_out;
+		goto out;
 	}
 
 	/*
@@ -5904,7 +5904,7 @@ static int ext4_load_journal(struct super_block *sb,
 					"unavailable, cannot proceed "
 					"(try mounting with noload)");
 				err = -EROFS;
-				goto err_out;
+				goto out;
 			}
 			ext4_msg(sb, KERN_INFO, "write access will "
 			       "be enabled during recovery");
@@ -5917,29 +5917,21 @@ static int ext4_load_journal(struct super_block *sb,
 	if (!ext4_has_feature_journal_needs_recovery(sb))
 		err = jbd2_journal_wipe(journal, !really_read_only);
 	if (!err) {
-		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
-		if (save)
-			memcpy(save, ((char *) es) +
-			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
-		err = jbd2_journal_load(journal);
-		if (save)
-			memcpy(((char *) es) + EXT4_S_ERR_START,
-			       save, EXT4_S_ERR_LEN);
-		kfree(save);
+		if (journal->j_replay_prepare_callback)
+			err = journal->j_replay_prepare_callback(journal);
+		if (!err)
+			err = jbd2_journal_load(journal);
 	}
 
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "error loading journal");
-		goto err_out;
+		goto out;
 	}
 
 	EXT4_SB(sb)->s_journal = journal;
 	err = ext4_clear_journal_err(sb, es);
-	if (err) {
-		EXT4_SB(sb)->s_journal = NULL;
-		jbd2_journal_destroy(journal);
-		return err;
-	}
+	if (err)
+		goto out;
 
 	if (!really_read_only && journal_devnum &&
 	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
@@ -5948,11 +5940,13 @@ static int ext4_load_journal(struct super_block *sb,
 		/* Make sure we flush the recovery flag to disk. */
 		ext4_commit_super(sb);
 	}
-
-	return 0;
-
-err_out:
-	jbd2_journal_destroy(journal);
+out:
+	if (unlikely(journal->j_replay_end_callback))
+		journal->j_replay_end_callback(journal);
+	if (err) {
+		EXT4_SB(sb)->s_journal = NULL;
+		jbd2_journal_destroy(journal);
+	}
 	return err;
 }
 
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 8286a9ec122f..8175d0a8d5f7 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -687,6 +687,20 @@ static int do_one_pass(journal_t *journal,
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

