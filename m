Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB15777369
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 10:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHJIyg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 04:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjHJIyf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 04:54:35 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AFF2127
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 01:54:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RM12F3FRTz4f41Gl
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 16:54:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqm6pdRkGjJ7AQ--.1500S5;
        Thu, 10 Aug 2023 16:54:30 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v2 01/12] jbd2: move load_superblock() dependent functions
Date:   Thu, 10 Aug 2023 16:54:06 +0800
Message-Id: <20230810085417.1501293-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
References: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqm6pdRkGjJ7AQ--.1500S5
X-Coremail-Antispam: 1UD129KBjvJXoWfGryxGryUGw48Kw4xXw1fJFb_yoWkJryrpF
        y5GryfArWDZr43Zw1IyF4DJFWFqryjyFyUGr1DCasaka12ywnFy34Dtr15XFykC34qg340
        gF15G34UCw10q3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUHyIUUUUUU=
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

Move load_superblock() declaration and the functions it calls before
journal_init_common(). This is a preparation for moving a call to
load_superblock() from jbd2_journal_load() and jbd2_journal_wipe() to
journal_init_common(). No functional changes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 337 +++++++++++++++++++++++-----------------------
 1 file changed, 168 insertions(+), 169 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index fbce16fedaa4..48c44c7fccf4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1336,6 +1336,174 @@ static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
 	return count;
 }
 
+/*
+ * If the journal init or create aborts, we need to mark the journal
+ * superblock as being NULL to prevent the journal destroy from writing
+ * back a bogus superblock.
+ */
+static void journal_fail_superblock(journal_t *journal)
+{
+	struct buffer_head *bh = journal->j_sb_buffer;
+	brelse(bh);
+	journal->j_sb_buffer = NULL;
+}
+
+/*
+ * Read the superblock for a given journal, performing initial
+ * validation of the format.
+ */
+static int journal_get_superblock(journal_t *journal)
+{
+	struct buffer_head *bh;
+	journal_superblock_t *sb;
+	int err;
+
+	bh = journal->j_sb_buffer;
+
+	J_ASSERT(bh != NULL);
+	if (buffer_verified(bh))
+		return 0;
+
+	err = bh_read(bh, 0);
+	if (err < 0) {
+		printk(KERN_ERR
+			"JBD2: IO error reading journal superblock\n");
+		goto out;
+	}
+
+	sb = journal->j_superblock;
+
+	err = -EINVAL;
+
+	if (sb->s_header.h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
+	    sb->s_blocksize != cpu_to_be32(journal->j_blocksize)) {
+		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
+		goto out;
+	}
+
+	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
+	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
+		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
+		goto out;
+	}
+
+	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
+		printk(KERN_WARNING "JBD2: journal file too short\n");
+		goto out;
+	}
+
+	if (be32_to_cpu(sb->s_first) == 0 ||
+	    be32_to_cpu(sb->s_first) >= journal->j_total_len) {
+		printk(KERN_WARNING
+			"JBD2: Invalid start block of journal: %u\n",
+			be32_to_cpu(sb->s_first));
+		goto out;
+	}
+
+	if (jbd2_has_feature_csum2(journal) &&
+	    jbd2_has_feature_csum3(journal)) {
+		/* Can't have checksum v2 and v3 at the same time! */
+		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
+		       "at the same time!\n");
+		goto out;
+	}
+
+	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
+	    jbd2_has_feature_checksum(journal)) {
+		/* Can't have checksum v1 and v2 on at the same time! */
+		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
+		       "at the same time!\n");
+		goto out;
+	}
+
+	if (!jbd2_verify_csum_type(journal, sb)) {
+		printk(KERN_ERR "JBD2: Unknown checksum type\n");
+		goto out;
+	}
+
+	/* Load the checksum driver */
+	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
+		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
+		if (IS_ERR(journal->j_chksum_driver)) {
+			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
+			err = PTR_ERR(journal->j_chksum_driver);
+			journal->j_chksum_driver = NULL;
+			goto out;
+		}
+		/* Check superblock checksum */
+		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
+			printk(KERN_ERR "JBD2: journal checksum error\n");
+			err = -EFSBADCRC;
+			goto out;
+		}
+	}
+	set_buffer_verified(bh);
+	return 0;
+
+out:
+	journal_fail_superblock(journal);
+	return err;
+}
+
+static int journal_revoke_records_per_block(journal_t *journal)
+{
+	int record_size;
+	int space = journal->j_blocksize - sizeof(jbd2_journal_revoke_header_t);
+
+	if (jbd2_has_feature_64bit(journal))
+		record_size = 8;
+	else
+		record_size = 4;
+
+	if (jbd2_journal_has_csum_v2or3(journal))
+		space -= sizeof(struct jbd2_journal_block_tail);
+	return space / record_size;
+}
+
+/*
+ * Load the on-disk journal superblock and read the key fields into the
+ * journal_t.
+ */
+static int load_superblock(journal_t *journal)
+{
+	int err;
+	journal_superblock_t *sb;
+	int num_fc_blocks;
+
+	err = journal_get_superblock(journal);
+	if (err)
+		return err;
+
+	sb = journal->j_superblock;
+
+	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
+	journal->j_tail = be32_to_cpu(sb->s_start);
+	journal->j_first = be32_to_cpu(sb->s_first);
+	journal->j_errno = be32_to_cpu(sb->s_errno);
+	journal->j_last = be32_to_cpu(sb->s_maxlen);
+
+	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
+		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
+	/* Precompute checksum seed for all metadata */
+	if (jbd2_journal_has_csum_v2or3(journal))
+		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
+						   sizeof(sb->s_uuid));
+	journal->j_revoke_records_per_block =
+				journal_revoke_records_per_block(journal);
+
+	if (jbd2_has_feature_fast_commit(journal)) {
+		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
+		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
+		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
+			journal->j_last = journal->j_fc_last - num_fc_blocks;
+		journal->j_fc_first = journal->j_last + 1;
+		journal->j_fc_off = 0;
+	}
+
+	return 0;
+}
+
+
 /*
  * Management for journal control blocks: functions to create and
  * destroy journal_t structures, and to initialise and read existing
@@ -1521,18 +1689,6 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 	return journal;
 }
 
-/*
- * If the journal init or create aborts, we need to mark the journal
- * superblock as being NULL to prevent the journal destroy from writing
- * back a bogus superblock.
- */
-static void journal_fail_superblock(journal_t *journal)
-{
-	struct buffer_head *bh = journal->j_sb_buffer;
-	brelse(bh);
-	journal->j_sb_buffer = NULL;
-}
-
 /*
  * Given a journal_t structure, initialise the various fields for
  * startup of a new journaling session.  We use this both when creating
@@ -1889,163 +2045,6 @@ void jbd2_journal_update_sb_errno(journal_t *journal)
 }
 EXPORT_SYMBOL(jbd2_journal_update_sb_errno);
 
-static int journal_revoke_records_per_block(journal_t *journal)
-{
-	int record_size;
-	int space = journal->j_blocksize - sizeof(jbd2_journal_revoke_header_t);
-
-	if (jbd2_has_feature_64bit(journal))
-		record_size = 8;
-	else
-		record_size = 4;
-
-	if (jbd2_journal_has_csum_v2or3(journal))
-		space -= sizeof(struct jbd2_journal_block_tail);
-	return space / record_size;
-}
-
-/*
- * Read the superblock for a given journal, performing initial
- * validation of the format.
- */
-static int journal_get_superblock(journal_t *journal)
-{
-	struct buffer_head *bh;
-	journal_superblock_t *sb;
-	int err;
-
-	bh = journal->j_sb_buffer;
-
-	J_ASSERT(bh != NULL);
-	if (buffer_verified(bh))
-		return 0;
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
-
-	if (sb->s_header.h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
-	    sb->s_blocksize != cpu_to_be32(journal->j_blocksize)) {
-		printk(KERN_WARNING "JBD2: no valid journal superblock found\n");
-		goto out;
-	}
-
-	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
-	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
-		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
-		goto out;
-	}
-
-	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
-		printk(KERN_WARNING "JBD2: journal file too short\n");
-		goto out;
-	}
-
-	if (be32_to_cpu(sb->s_first) == 0 ||
-	    be32_to_cpu(sb->s_first) >= journal->j_total_len) {
-		printk(KERN_WARNING
-			"JBD2: Invalid start block of journal: %u\n",
-			be32_to_cpu(sb->s_first));
-		goto out;
-	}
-
-	if (jbd2_has_feature_csum2(journal) &&
-	    jbd2_has_feature_csum3(journal)) {
-		/* Can't have checksum v2 and v3 at the same time! */
-		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
-		       "at the same time!\n");
-		goto out;
-	}
-
-	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
-	    jbd2_has_feature_checksum(journal)) {
-		/* Can't have checksum v1 and v2 on at the same time! */
-		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
-		       "at the same time!\n");
-		goto out;
-	}
-
-	if (!jbd2_verify_csum_type(journal, sb)) {
-		printk(KERN_ERR "JBD2: Unknown checksum type\n");
-		goto out;
-	}
-
-	/* Load the checksum driver */
-	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
-		journal->j_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
-		if (IS_ERR(journal->j_chksum_driver)) {
-			printk(KERN_ERR "JBD2: Cannot load crc32c driver.\n");
-			err = PTR_ERR(journal->j_chksum_driver);
-			journal->j_chksum_driver = NULL;
-			goto out;
-		}
-		/* Check superblock checksum */
-		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
-			printk(KERN_ERR "JBD2: journal checksum error\n");
-			err = -EFSBADCRC;
-			goto out;
-		}
-	}
-	set_buffer_verified(bh);
-	return 0;
-
-out:
-	journal_fail_superblock(journal);
-	return err;
-}
-
-/*
- * Load the on-disk journal superblock and read the key fields into the
- * journal_t.
- */
-
-static int load_superblock(journal_t *journal)
-{
-	int err;
-	journal_superblock_t *sb;
-	int num_fc_blocks;
-
-	err = journal_get_superblock(journal);
-	if (err)
-		return err;
-
-	sb = journal->j_superblock;
-
-	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
-	journal->j_tail = be32_to_cpu(sb->s_start);
-	journal->j_first = be32_to_cpu(sb->s_first);
-	journal->j_errno = be32_to_cpu(sb->s_errno);
-	journal->j_last = be32_to_cpu(sb->s_maxlen);
-
-	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
-		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
-	/* Precompute checksum seed for all metadata */
-	if (jbd2_journal_has_csum_v2or3(journal))
-		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
-						   sizeof(sb->s_uuid));
-	journal->j_revoke_records_per_block =
-				journal_revoke_records_per_block(journal);
-
-	if (jbd2_has_feature_fast_commit(journal)) {
-		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
-		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
-		if (journal->j_last - num_fc_blocks >= JBD2_MIN_JOURNAL_BLOCKS)
-			journal->j_last = journal->j_fc_last - num_fc_blocks;
-		journal->j_fc_first = journal->j_last + 1;
-		journal->j_fc_off = 0;
-	}
-
-	return 0;
-}
-
-
 /**
  * jbd2_journal_load() - Read journal from disk.
  * @journal: Journal to act on.
-- 
2.34.3

