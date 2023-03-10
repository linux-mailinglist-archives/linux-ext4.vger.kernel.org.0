Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F76B3FB4
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCJMw6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 07:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCJMwz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 07:52:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F8C10C721;
        Fri, 10 Mar 2023 04:52:52 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PY5WR5MZhzHwTv;
        Fri, 10 Mar 2023 20:50:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 10 Mar
 2023 20:52:50 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 1/5] ext4: Fix reusing stale buffer heads from last failed mounting
Date:   Fri, 10 Mar 2023 20:52:02 +0800
Message-ID: <20230310125206.2867822-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230310125206.2867822-1-chengzhihao1@huawei.com>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Following process makes ext4 load stale buffer heads from last failed
mounting in a new mounting operation:
mount_bdev
 ext4_fill_super
 | ext4_load_and_init_journal
 |  ext4_load_journal
 |   jbd2_journal_load
 |    load_superblock
 |     journal_get_superblock
 |      set_buffer_verified(bh) // buffer head is verified
 |   jbd2_journal_recover // failed caused by EIO
 | goto failed_mount3a // skip 'sb->s_root' initialization
 deactivate_locked_super
  kill_block_super
   generic_shutdown_super
    if (sb->s_root)
    // false, skip ext4_put_super->invalidate_bdev->
    // invalidate_mapping_pages->mapping_evict_folio->
    // filemap_release_folio->try_to_free_buffers, which
    // cannot drop buffer head.
   blkdev_put
    blkdev_put_whole
     if (atomic_dec_and_test(&bdev->bd_openers))
     // false, systemd-udev happens to open the device. Then
     // blkdev_flush_mapping->kill_bdev->truncate_inode_pages->
     // truncate_inode_folio->truncate_cleanup_folio->
     // folio_invalidate->block_invalidate_folio->
     // filemap_release_folio->try_to_free_buffers will be skipped,
     // dropping buffer head is missed again.

Second mount:
ext4_fill_super
 ext4_load_and_init_journal
  ext4_load_journal
   ext4_get_journal
    jbd2_journal_init_inode
     journal_init_common
      bh = getblk_unmovable
       bh = __find_get_block // Found stale bh in last failed mounting
      journal->j_sb_buffer = bh
   jbd2_journal_load
    load_superblock
     journal_get_superblock
      if (buffer_verified(bh))
      // true, skip journal->j_format_version = 2, value is 0
    jbd2_journal_recover
     do_one_pass
      next_log_block += count_tags(journal, bh)
      // According to journal_tag_bytes(), 'tag_bytes' calculating is
      // affected by jbd2_has_feature_csum3(), jbd2_has_feature_csum3()
      // returns false because 'j->j_format_version >= 2' is not true,
      // then we get wrong next_log_block. The do_one_pass may exit
      // early whenoccuring non JBD2_MAGIC_NUMBER in 'next_log_block'.

The filesystem is corrupted here, journal is partially replayed, and
new journal sequence number actually is already used by last mounting.

The invalidate_bdev() can drop all buffer heads even racing with bare
reading block device(eg. systemd-udev), so we can fix it by invalidating
bdev in error handling path in __ext4_fill_super().

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217171
Cc: <stable@kernel.org>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ext4/super.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 88f7b8a88c76..7e990637bc48 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1126,6 +1126,12 @@ static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
 	struct block_device *bdev;
 	bdev = sbi->s_journal_bdev;
 	if (bdev) {
+		/*
+		 * Invalidate the journal device's buffers.  We don't want them
+		 * floating about in memory - the physical journal device may
+		 * hotswapped, and it breaks the `ro-after' testing code.
+		 */
+		invalidate_bdev(bdev);
 		ext4_blkdev_put(bdev);
 		sbi->s_journal_bdev = NULL;
 	}
@@ -1271,14 +1277,8 @@ static void ext4_put_super(struct super_block *sb)
 
 	sync_blockdev(sb->s_bdev);
 	invalidate_bdev(sb->s_bdev);
-	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
-		/*
-		 * Invalidate the journal device's buffers.  We don't want them
-		 * floating about in memory - the physical journal device may
-		 * hotswapped, and it breaks the `ro-after' testing code.
-		 */
+	if (sbi->s_journal_bdev) {
 		sync_blockdev(sbi->s_journal_bdev);
-		invalidate_bdev(sbi->s_journal_bdev);
 		ext4_blkdev_remove(sbi);
 	}
 
@@ -5610,6 +5610,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	brelse(sbi->s_sbh);
 	ext4_blkdev_remove(sbi);
 out_fail:
+	invalidate_bdev(sb->s_bdev);
 	sb->s_fs_info = NULL;
 	return err ? err : ret;
 }
-- 
2.31.1

