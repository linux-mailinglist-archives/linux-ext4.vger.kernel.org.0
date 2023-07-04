Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC040747307
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 15:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGDNoS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGDNoI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 09:44:08 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4607AE7E
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 06:44:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwPCR67kgz4f457Y
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 21:44:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLASIqRk9WjENA--.31120S16;
        Tue, 04 Jul 2023 21:44:04 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH 12/12] ext4: ext4_get_{dev}_journal return proper error value
Date:   Tue,  4 Jul 2023 21:42:33 +0800
Message-Id: <20230704134233.110812-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLASIqRk9WjENA--.31120S16
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4ktr4Dur1kAr4UWry8Krg_yoW7Kw4fpF
        15GFyfZrWj9r1Du3y8Jr4UAFWYg3WIyay8Gr97uwnYyayUtr1IqF1UJr1UtFy8tFWUGw13
        JF4UJa17Cw17K37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
        AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl2NtUUUUU=
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

ext4_get_journal() and ext4_get_dev_journal() return NULL if they failed
to init journal, making them return proper error value instead, also
rename them to ext4_open_{inode,dev}_journal().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 51 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 25ae536a370f..ae8a964e493d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5752,18 +5752,18 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 	journal_inode = ext4_iget(sb, journal_inum, EXT4_IGET_SPECIAL);
 	if (IS_ERR(journal_inode)) {
 		ext4_msg(sb, KERN_ERR, "no journal found");
-		return NULL;
+		return ERR_CAST(journal_inode);
 	}
 	if (!journal_inode->i_nlink) {
 		make_bad_inode(journal_inode);
 		iput(journal_inode);
 		ext4_msg(sb, KERN_ERR, "journal inode is deleted");
-		return NULL;
+		return ERR_PTR(-EFSCORRUPTED);
 	}
 	if (!S_ISREG(journal_inode->i_mode) || IS_ENCRYPTED(journal_inode)) {
 		ext4_msg(sb, KERN_ERR, "invalid journal inode");
 		iput(journal_inode);
-		return NULL;
+		return ERR_PTR(-EFSCORRUPTED);
 	}
 
 	ext4_debug("Journal inode found at %p: %lld bytes\n",
@@ -5793,21 +5793,21 @@ static int ext4_journal_bmap(journal_t *journal, sector_t *block)
 	return 0;
 }
 
-static journal_t *ext4_get_journal(struct super_block *sb,
-				   unsigned int journal_inum)
+static journal_t *ext4_open_inode_journal(struct super_block *sb,
+					  unsigned int journal_inum)
 {
 	struct inode *journal_inode;
 	journal_t *journal;
 
 	journal_inode = ext4_get_journal_inode(sb, journal_inum);
-	if (!journal_inode)
-		return NULL;
+	if (IS_ERR(journal_inode))
+		return ERR_CAST(journal_inode);
 
 	journal = jbd2_journal_init_inode(journal_inode);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "Could not load journal inode");
 		iput(journal_inode);
-		return NULL;
+		return ERR_CAST(journal);
 	}
 	journal->j_private = sb;
 	journal->j_bmap = ext4_journal_bmap;
@@ -5825,6 +5825,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
 	ext4_fsblk_t sb_block;
 	unsigned long offset;
 	struct ext4_super_block *es;
+	int errno;
 
 	bdev = blkdev_get_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE, sb,
 				 &ext4_holder_ops);
@@ -5832,7 +5833,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
 		ext4_msg(sb, KERN_ERR,
 			 "failed to open journal device unknown-block(%u,%u) %ld",
 			 MAJOR(j_dev), MINOR(j_dev), PTR_ERR(bdev));
-		return NULL;
+		return ERR_CAST(bdev);
 	}
 
 	blocksize = sb->s_blocksize;
@@ -5840,6 +5841,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
 	if (blocksize < hblock) {
 		ext4_msg(sb, KERN_ERR,
 			"blocksize too small for journal device");
+		errno = -EINVAL;
 		goto out_bdev;
 	}
 
@@ -5850,6 +5852,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
 	if (!bh) {
 		ext4_msg(sb, KERN_ERR, "couldn't read superblock of "
 		       "external journal");
+		errno = -EINVAL;
 		goto out_bdev;
 	}
 
@@ -5858,6 +5861,7 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
 	    !(le32_to_cpu(es->s_feature_incompat) &
 	      EXT4_FEATURE_INCOMPAT_JOURNAL_DEV)) {
 		ext4_msg(sb, KERN_ERR, "external journal has bad superblock");
+		errno = -EFSCORRUPTED;
 		goto out_bh;
 	}
 
@@ -5865,11 +5869,13 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
 	     EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) &&
 	    es->s_checksum != ext4_superblock_csum(sb, es)) {
 		ext4_msg(sb, KERN_ERR, "external journal has corrupt superblock");
+		errno = -EFSCORRUPTED;
 		goto out_bh;
 	}
 
 	if (memcmp(EXT4_SB(sb)->s_es->s_journal_uuid, es->s_uuid, 16)) {
 		ext4_msg(sb, KERN_ERR, "journal UUID does not match");
+		errno = -EFSCORRUPTED;
 		goto out_bh;
 	}
 
@@ -5882,31 +5888,34 @@ static struct block_device *ext4_get_journal_dev(struct super_block *sb,
 	brelse(bh);
 out_bdev:
 	blkdev_put(bdev, sb);
-	return NULL;
+	return ERR_PTR(errno);
 }
 
-static journal_t *ext4_get_dev_journal(struct super_block *sb,
-				       dev_t j_dev)
+static journal_t *ext4_open_dev_journal(struct super_block *sb,
+					dev_t j_dev)
 {
 	journal_t *journal;
 	ext4_fsblk_t j_start;
 	ext4_fsblk_t j_len;
 	struct block_device *journal_bdev;
+	int errno = 0;
 
 	journal_bdev = ext4_get_journal_dev(sb, j_dev, &j_start, &j_len);
-	if (!journal_bdev)
-		return NULL;
+	if (IS_ERR(journal_bdev))
+		return ERR_CAST(journal_bdev);
 
 	journal = jbd2_journal_init_dev(journal_bdev, sb->s_bdev, j_start,
 					j_len, sb->s_blocksize);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
+		errno = PTR_ERR(journal);
 		goto out_bdev;
 	}
 	if (be32_to_cpu(journal->j_superblock->s_nr_users) != 1) {
 		ext4_msg(sb, KERN_ERR, "External journal has more than one "
 					"user (unsupported) - %d",
 			be32_to_cpu(journal->j_superblock->s_nr_users));
+		errno = -EINVAL;
 		goto out_journal;
 	}
 	journal->j_private = sb;
@@ -5918,7 +5927,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	jbd2_journal_destroy(journal);
 out_bdev:
 	blkdev_put(journal_bdev, sb);
-	return NULL;
+	return ERR_PTR(errno);
 }
 
 static int ext4_load_journal(struct super_block *sb,
@@ -5950,13 +5959,13 @@ static int ext4_load_journal(struct super_block *sb,
 	}
 
 	if (journal_inum) {
-		journal = ext4_get_journal(sb, journal_inum);
-		if (!journal)
-			return -EINVAL;
+		journal = ext4_open_inode_journal(sb, journal_inum);
+		if (IS_ERR(journal))
+			return PTR_ERR(journal);
 	} else {
-		journal = ext4_get_dev_journal(sb, journal_dev);
-		if (!journal)
-			return -EINVAL;
+		journal = ext4_open_dev_journal(sb, journal_dev);
+		if (IS_ERR(journal))
+			return PTR_ERR(journal);
 	}
 
 	journal_dev_ro = bdev_read_only(journal->j_dev);
-- 
2.39.2

