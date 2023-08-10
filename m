Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27B777371
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjHJIyt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjHJIyl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 04:54:41 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E52683
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 01:54:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RM12K4953z4f3kjg
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 16:54:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgD3hqm6pdRkGjJ7AQ--.1500S15;
        Thu, 10 Aug 2023 16:54:33 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v2 11/12] ext4: cleanup ext4_get_dev_journal() and ext4_get_journal()
Date:   Thu, 10 Aug 2023 16:54:16 +0800
Message-Id: <20230810085417.1501293-12-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
References: <20230810085417.1501293-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3hqm6pdRkGjJ7AQ--.1500S15
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWDtFWfZFy8tryDJr18Xwb_yoWxGFWUpF
        1UCFyfZryUur1Uua18Xw4UJFWYg3W0yayUGr97uwnYyayDtrn7t3WkJF1UtFy8tFWUWw1r
        XF4UK347Cw17K3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF18BUUUUU
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

Factor out a new helper form ext4_get_dev_journal() to get external
journal bdev and check validation of this device, drop ext4_blkdev_get()
helper, and also remove duplicate check of journal feature. It makes
ext4_get_dev_journal() more clear than before.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 109 ++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 60 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ce2e02b139af..2f71076f678a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1105,26 +1105,6 @@ static const struct blk_holder_ops ext4_holder_ops = {
 	.mark_dead		= ext4_bdev_mark_dead,
 };
 
-/*
- * Open the external journal device
- */
-static struct block_device *ext4_blkdev_get(dev_t dev, struct super_block *sb)
-{
-	struct block_device *bdev;
-
-	bdev = blkdev_get_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
-				 &ext4_holder_ops);
-	if (IS_ERR(bdev))
-		goto fail;
-	return bdev;
-
-fail:
-	ext4_msg(sb, KERN_ERR,
-		 "failed to open journal device unknown-block(%u,%u) %ld",
-		 MAJOR(dev), MINOR(dev), PTR_ERR(bdev));
-	return NULL;
-}
-
 /*
  * Release the journal device
  */
@@ -5780,14 +5760,14 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 		ext4_msg(sb, KERN_ERR, "journal inode is deleted");
 		return NULL;
 	}
-
-	ext4_debug("Journal inode found at %p: %lld bytes\n",
-		  journal_inode, journal_inode->i_size);
 	if (!S_ISREG(journal_inode->i_mode) || IS_ENCRYPTED(journal_inode)) {
 		ext4_msg(sb, KERN_ERR, "invalid journal inode");
 		iput(journal_inode);
 		return NULL;
 	}
+
+	ext4_debug("Journal inode found at %p: %lld bytes\n",
+		  journal_inode, journal_inode->i_size);
 	return journal_inode;
 }
 
@@ -5819,9 +5799,6 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 	struct inode *journal_inode;
 	journal_t *journal;
 
-	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
-		return NULL;
-
 	journal_inode = ext4_get_journal_inode(sb, journal_inum);
 	if (!journal_inode)
 		return NULL;
@@ -5838,25 +5815,25 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 	return journal;
 }
 
-static journal_t *ext4_get_dev_journal(struct super_block *sb,
-				       dev_t j_dev)
+static struct block_device *ext4_get_journal_dev(struct super_block *sb,
+					dev_t j_dev, ext4_fsblk_t *j_start,
+					ext4_fsblk_t *j_len)
 {
 	struct buffer_head *bh;
-	journal_t *journal;
-	ext4_fsblk_t start;
-	ext4_fsblk_t len;
+	struct block_device *bdev;
 	int hblock, blocksize;
 	ext4_fsblk_t sb_block;
 	unsigned long offset;
 	struct ext4_super_block *es;
-	struct block_device *bdev;
 
-	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
-		return NULL;
-
-	bdev = ext4_blkdev_get(j_dev, sb);
-	if (bdev == NULL)
+	bdev = blkdev_get_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
+				 &ext4_holder_ops);
+	if (IS_ERR(bdev)) {
+		ext4_msg(sb, KERN_ERR,
+			 "failed to open journal device unknown-block(%u,%u) %ld",
+			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev));
 		return NULL;
+	}
 
 	blocksize = sb->s_blocksize;
 	hblock = bdev_logical_block_size(bdev);
@@ -5869,7 +5846,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	sb_block = EXT4_MIN_BLOCK_SIZE / blocksize;
 	offset = EXT4_MIN_BLOCK_SIZE % blocksize;
 	set_blocksize(bdev, blocksize);
-	if (!(bh = __bread(bdev, sb_block, blocksize))) {
+	bh = __bread(bdev, sb_block, blocksize);
+	if (!bh) {
 		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
 		       "external journal");
 		goto out_bdev;
@@ -5879,56 +5857,67 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	if ((le16_to_cpu(es->s_magic) != EXT4_SUPER_MAGIC) ||
 	    !(le32_to_cpu(es->s_feature_incompat) &
 	      EXT4_FEATURE_INCOMPAT_JOURNAL_DEV)) {
-		ext4_msg(sb, KERN_ERR, "external journal has "
-					"bad superblock");
-		brelse(bh);
-		goto out_bdev;
+		ext4_msg(sb, KERN_ERR, "external journal has bad superblock");
+		goto out_bh;
 	}
 
 	if ((le32_to_cpu(es->s_feature_ro_compat) &
 	     EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) &&
 	    es->s_checksum != ext4_superblock_csum(sb, es)) {
-		ext4_msg(sb, KERN_ERR, "external journal has "
-				       "corrupt superblock");
-		brelse(bh);
-		goto out_bdev;
+		ext4_msg(sb, KERN_ERR, "external journal has corrupt superblock");
+		goto out_bh;
 	}
 
 	if (memcmp(EXT4_SB(sb)->s_es->s_journal_uuid, es->s_uuid, 16)) {
 		ext4_msg(sb, KERN_ERR, "journal UUID does not match");
-		brelse(bh);
-		goto out_bdev;
+		goto out_bh;
 	}
 
-	len = ext4_blocks_count(es);
-	start = sb_block + 1;
-	brelse(bh);	/* we're done with the superblock */
+	*j_start = sb_block + 1;
+	*j_len = ext4_blocks_count(es);
+	brelse(bh);
+	return bdev;
+
+out_bh:
+	brelse(bh);
+out_bdev:
+	blkdev_put(bdev, sb);
+	return NULL;
+}
+
+static journal_t *ext4_get_dev_journal(struct super_block *sb,
+				       dev_t j_dev)
+{
+	journal_t *journal;
+	ext4_fsblk_t j_start;
+	ext4_fsblk_t j_len;
+	struct block_device *journal_bdev;
+
+	journal_bdev = ext4_get_journal_dev(sb, j_dev, &j_start, &j_len);
+	if (!journal_bdev)
+		return NULL;
 
-	journal = jbd2_journal_init_dev(bdev, sb->s_bdev,
-					start, len, blocksize);
+	journal = jbd2_journal_init_dev(journal_bdev, sb->s_bdev, j_start,
+					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
 		goto out_bdev;
 	}
-	journal->j_private = sb;
-	if (ext4_read_bh_lock(journal->j_sb_buffer, REQ_META | REQ_PRIO, true)) {
-		ext4_msg(sb, KERN_ERR, "I/O error on journal device");
-		goto out_journal;
-	}
 	if (be32_to_cpu(journal->j_superblock->s_nr_users) != 1) {
 		ext4_msg(sb, KERN_ERR, "External journal has more than one "
 					"user (unsupported) - %d",
 			be32_to_cpu(journal->j_superblock->s_nr_users));
 		goto out_journal;
 	}
-	EXT4_SB(sb)->s_journal_bdev = bdev;
+	journal->j_private = sb;
+	EXT4_SB(sb)->s_journal_bdev = journal_bdev;
 	ext4_init_journal_params(sb, journal);
 	return journal;
 
 out_journal:
 	jbd2_journal_destroy(journal);
 out_bdev:
-	blkdev_put(bdev, sb);
+	blkdev_put(journal_bdev, sb);
 	return NULL;
 }
 
-- 
2.34.3

