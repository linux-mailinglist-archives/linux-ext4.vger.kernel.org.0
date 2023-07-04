Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947E1747304
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGDNoO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGDNoI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 09:44:08 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBFCE75
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 06:44:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwPCP4Xqlz4f3mVZ
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 21:44:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLASIqRk9WjENA--.31120S10;
        Tue, 04 Jul 2023 21:44:02 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH 06/12] jbd2: cleanup load_superblock()
Date:   Tue,  4 Jul 2023 21:42:27 +0800
Message-Id: <20230704134233.110812-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLASIqRk9WjENA--.31120S10
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1rXF1UWFy7XF47ur15Jwb_yoWxGr1kp3
        WayryrArWqvr1UZ3Z7tF4kJFWFq3y0yFy7Gr1DC3Z2kayUtrsrt34Dtr1FqFyvvrWUG348
        XF15C3ZrCa1vq3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoxhLUUUUU
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

Rename load_superblock() to journal_load_superblock(), move getting and
reading superblock from journal_init_common() and
journal_get_superblock() to this function, and also rename
journal_get_superblock() to journal_check_superblock(), make it a pure
check helper to check superblock validity from disk.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 95 +++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 52 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 46ab47b4439e..efdb8db3c06e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1340,46 +1340,33 @@ static void journal_fail_superblock(journal_t *journal)
 	journal->j_sb_buffer = NULL;
 }
 
-/*
- * Read the superblock for a given journal, performing initial
+/**
+ * journal_check_superblock()
+ * @journal: journal to act on.
+ *
+ * Check the superblock for a given journal, performing initial
  * validation of the format.
  */
-static int journal_get_superblock(journal_t *journal)
+static int journal_check_superblock(journal_t *journal)
 {
-	struct buffer_head *bh;
-	journal_superblock_t *sb;
-	int err;
-
-	bh = journal->j_sb_buffer;
-
-	J_ASSERT(bh != NULL);
-
-	err = bh_read(bh, 0);
-	if (err < 0) {
-		printk(KERN_ERR
-			"JBD2: IO error reading journal superblock\n");
-		goto out;
-	}
-
-	sb = journal->j_superblock;
-
-	err = -EINVAL;
+	journal_superblock_t *sb = journal->j_superblock;
+	int err = -EINVAL;
 
 	if (sb->s_header.h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
 	    sb->s_blocksize != cpu_to_be32(journal->j_blocksize)) {
 		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
-		goto out;
+		return err;
 	}
 
 	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
 	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
 		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
-		goto out;
+		return err;
 	}
 
 	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
 		printk(KERN_WARNING "JBD2: journal file too short\n");
-		goto out;
+		return err;
 	}
 
 	if (be32_to_cpu(sb->s_first) == 0 ||
@@ -1387,7 +1374,7 @@ static int journal_get_superblock(journal_t *journal)
 		printk(KERN_WARNING
 			"JBD2: Invalid start block of journal: %u\n",
 			be32_to_cpu(sb->s_first));
-		goto out;
+		return err;
 	}
 
 	/*
@@ -1402,7 +1389,7 @@ static int journal_get_superblock(journal_t *journal)
 	    (sb->s_feature_incompat &
 			~cpu_to_be32(JBD2_KNOWN_INCOMPAT_FEATURES))) {
 		printk(KERN_WARNING "JBD2: Unrecognised features on journal\n");
-		goto out;
+		return err;
 	}
 
 	if (jbd2_has_feature_csum2(journal) &&
@@ -1410,7 +1397,7 @@ static int journal_get_superblock(journal_t *journal)
 		/* Can't have checksum v2 and v3 at the same time! */
 		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
 		       "at the same time!\n");
-		goto out;
+		return err;
 	}
 
 	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
@@ -1418,14 +1405,14 @@ static int journal_get_superblock(journal_t *journal)
 		/* Can't have checksum v1 and v2 on at the same time! */
 		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
 		       "at the same time!\n");
-		goto out;
+		return err;
 	}
 
 	/* Load the checksum driver */
 	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
 		if (sb->s_checksum_type != JBD2_CRC32C_CHKSUM) {
 			printk(KERN_ERR "JBD2: Unknown checksum type\n");
-			goto out;
+			return err;
 		}
 
 		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
@@ -1433,20 +1420,17 @@ static int journal_get_superblock(journal_t *journal)
 			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
 			err = PTR_ERR(journal->j_chksum_driver);
 			journal->j_chksum_driver = NULL;
-			goto out;
+			return err;
 		}
 		/* Check superblock checksum */
 		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
 			printk(KERN_ERR "JBD2: journal checksum error\n");
 			err = -EFSBADCRC;
-			goto out;
+			return err;
 		}
 	}
-	return 0;
 
-out:
-	journal_fail_superblock(journal);
-	return err;
+	return 0;
 }
 
 static int journal_revoke_records_per_block(journal_t *journal)
@@ -1464,21 +1448,38 @@ static int journal_revoke_records_per_block(journal_t *journal)
 	return space / record_size;
 }
 
-/*
+/**
+ * journal_load_superblock()
+ * @journal: journal to act on.
+ *
  * Load the on-disk journal superblock and read the key fields into the
  * journal_t.
  */
-static int load_superblock(journal_t *journal)
+static int journal_load_superblock(journal_t *journal)
 {
 	int err;
+	struct buffer_head *bh;
 	journal_superblock_t *sb;
 	int num_fc_blocks;
 
-	err = journal_get_superblock(journal);
-	if (err)
-		return err;
+	bh = getblk_unmovable(journal->j_dev, journal->j_blk_offset,
+			      journal->j_blocksize);
+	if (bh)
+		err = bh_read(bh, 0);
+	if (!bh || err < 0) {
+		pr_err("%s: Cannot read journal superblock\n", __func__);
+		brelse(bh);
+		return -EIO;
+	}
 
-	sb = journal->j_superblock;
+	journal->j_sb_buffer = bh;
+	sb = (journal_superblock_t *)bh->b_data;
+	journal->j_superblock = sb;
+	err = journal_check_superblock(journal);
+	if (err) {
+		journal_fail_superblock(journal);
+		return err;
+	}
 
 	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
 	journal->j_tail = be32_to_cpu(sb->s_start);
@@ -1524,7 +1525,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	static struct lock_class_key jbd2_trans_commit_key;
 	journal_t *journal;
 	int err;
-	struct buffer_head *bh;
 	int n;
 
 	journal = kzalloc(sizeof(*journal), GFP_KERNEL);
@@ -1577,16 +1577,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal->j_wbuf)
 		goto err_cleanup;
 
-	bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
-	if (!bh) {
-		pr_err("%s: Cannot get buffer for journal superblock\n",
-			__func__);
-		goto err_cleanup;
-	}
-	journal->j_sb_buffer = bh;
-	journal->j_superblock = (journal_superblock_t *)bh->b_data;
-
-	err = load_superblock(journal);
+	err = journal_load_superblock(journal);
 	if (err)
 		goto err_cleanup;
 
-- 
2.39.2

