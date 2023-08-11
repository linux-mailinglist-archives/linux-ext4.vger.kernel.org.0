Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD477878B
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjHKGgi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjHKGgb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:36:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C626B2
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:36:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMYwW4BpCz4f3xsG
        for <linux-ext4@vger.kernel.org>; Fri, 11 Aug 2023 14:36:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6na1tVkKEbDAQ--.35746S14;
        Fri, 11 Aug 2023 14:36:27 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v3 10/12] jbd2: jbd2_journal_init_{dev,inode} return proper error return value
Date:   Fri, 11 Aug 2023 14:36:08 +0800
Message-Id: <20230811063610.2980059-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
References: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6na1tVkKEbDAQ--.35746S14
X-Coremail-Antispam: 1UD129KBjvJXoWxurWxKr4xKw45ZFWfKF4kZwb_yoWrCr1fpF
        yUGa48Cryjvr4Uuw1Ivr4UXFWj9a4Ikay7Gr1kuw1vqayUJrnrtw1Utr1UZFy0yFWUGw4r
        XF1UCa1xCwnrKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
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

Current jbd2_journal_init_{dev,inode} return NULL if some error
happens, make them to pass out proper error return value.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c    |  4 ++--
 fs/jbd2/journal.c  | 19 +++++++++----------
 fs/ocfs2/journal.c |  8 ++++----
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..ce2e02b139af 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5827,7 +5827,7 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 		return NULL;
 
 	journal = jbd2_journal_init_inode(journal_inode);
-	if (!journal) {
+	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "Could not load journal inode");
 		iput(journal_inode);
 		return NULL;
@@ -5906,7 +5906,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 
 	journal = jbd2_journal_init_dev(bdev, sb->s_bdev,
 					start, len, blocksize);
-	if (!journal) {
+	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
 		goto out_bdev;
 	}
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 061887368ad5..f9bcac3d637e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1531,7 +1531,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 
 	journal = kzalloc(sizeof(*journal), GFP_KERNEL);
 	if (!journal)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	journal->j_blocksize = blocksize;
 	journal->j_dev = bdev;
@@ -1576,6 +1576,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	 * journal descriptor can store up to n blocks, we need enough
 	 * buffers to write out full descriptor block.
 	 */
+	err = -ENOMEM;
 	n = journal->j_blocksize / jbd2_min_tag_size();
 	journal->j_wbufsize = n;
 	journal->j_fc_wbuf = NULL;
@@ -1607,7 +1608,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	jbd2_journal_destroy_revoke(journal);
 	journal_fail_superblock(journal);
 	kfree(journal);
-	return NULL;
+	return ERR_PTR(err);
 }
 
 /* jbd2_journal_init_dev and jbd2_journal_init_inode:
@@ -1640,8 +1641,8 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
 	journal_t *journal;
 
 	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
-	if (!journal)
-		return NULL;
+	if (IS_ERR(journal))
+		return ERR_CAST(journal);
 
 	snprintf(journal->j_devname, sizeof(journal->j_devname),
 		 "%pg", journal->j_dev);
@@ -1667,11 +1668,9 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 
 	blocknr = 0;
 	err = bmap(inode, &blocknr);
-
 	if (err || !blocknr) {
-		pr_err("%s: Cannot locate journal superblock\n",
-			__func__);
-		return NULL;
+		pr_err("%s: Cannot locate journal superblock\n", __func__);
+		return err ? ERR_PTR(err) : ERR_PTR(-EINVAL);
 	}
 
 	jbd2_debug(1, "JBD2: inode %s/%ld, size %lld, bits %d, blksize %ld\n",
@@ -1681,8 +1680,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
 			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
 			inode->i_sb->s_blocksize);
-	if (!journal)
-		return NULL;
+	if (IS_ERR(journal))
+		return ERR_CAST(journal);
 
 	journal->j_inode = inode;
 	snprintf(journal->j_devname, sizeof(journal->j_devname),
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 25d8072ccfce..f35a1bbf52e2 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -911,9 +911,9 @@ int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
 
 	/* call the kernels journal init function now */
 	j_journal = jbd2_journal_init_inode(inode);
-	if (j_journal == NULL) {
+	if (IS_ERR(j_journal)) {
 		mlog(ML_ERROR, "Linux journal layer error\n");
-		status = -EINVAL;
+		status = PTR_ERR(journal);
 		goto done;
 	}
 
@@ -1687,9 +1687,9 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 	}
 
 	journal = jbd2_journal_init_inode(inode);
-	if (journal == NULL) {
+	if (IS_ERR(journal)) {
 		mlog(ML_ERROR, "Linux journal layer error\n");
-		status = -EIO;
+		status = PTR_ERR(journal);
 		goto done;
 	}
 
-- 
2.34.3

