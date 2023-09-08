Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA51798758
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjIHMsf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjIHMsf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 08:48:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988741FC9
        for <linux-ext4@vger.kernel.org>; Fri,  8 Sep 2023 05:48:25 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rhwpc6Xrpz1M99S;
        Fri,  8 Sep 2023 20:46:32 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 8 Sep
 2023 20:48:22 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4: Fix potential data lost in recovering journal raced with synchronizing fs bdev
Date:   Fri, 8 Sep 2023 20:43:17 +0800
Message-ID: <20230908124317.2955345-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

JBD2 makes sure journal data is fallen on fs device by sync_blockdev(),
however, other process could intercept the EIO information from bdev's
mapping, which leads journal recovering successful even EIO occurs during
data written back to fs device.

We found this problem in our product, iscsi + multipath is chosen for block
device of ext4. Unstable network may trigger kpartx to rescan partitions in
device mapper layer. Detailed process is shown as following:

  mount          kpartx          irq
jbd2_journal_recover
 do_one_pass
  memcpy(nbh->b_data, obh->b_data) // copy data to fs dev from journal
  mark_buffer_dirty // mark bh dirty
         vfs_read
	  generic_file_read_iter // dio
	   filemap_write_and_wait_range
	    __filemap_fdatawrite_range
	     do_writepages
	      block_write_full_folio
	       submit_bh_wbc
	            >>  EIO occurs in disk  <<
	                     end_buffer_async_write
			      mark_buffer_write_io_error
			       mapping_set_error
			        set_bit(AS_EIO, &mapping->flags) // set!
	    filemap_check_errors
	     test_and_clear_bit(AS_EIO, &mapping->flags) // clear!
 err2 = sync_blockdev
  filemap_write_and_wait
   filemap_check_errors
    test_and_clear_bit(AS_EIO, &mapping->flags) // false
 err2 = 0

Filesystem is mounted successfully even data from journal is failed written
into disk, and ext4 could become corrupted.

Fix it by comparing 'sbi->s_bdev_wb_err' before loading journal and after
loading journal.

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217888
Cc: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 v1->v2: Checks wb_err from block device only in ext4.
 fs/ext4/super.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38217422f938..4dcaad2403be 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4907,6 +4907,14 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 	if (err)
 		return err;
 
+	err = errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+				       &sbi->s_bdev_wb_err);
+	if (err) {
+		ext4_msg(sb, KERN_ERR, "Background error %d when loading journal",
+			 err);
+		goto out;
+	}
+
 	if (ext4_has_feature_64bit(sb) &&
 	    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
 				       JBD2_FEATURE_INCOMPAT_64BIT)) {
@@ -5365,6 +5373,13 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount3a;
 	}
 
+	/*
+	 * Save the original bdev mapping's wb_err value which could be
+	 * used to detect the metadata async write error.
+	 */
+	spin_lock_init(&sbi->s_bdev_wb_lock);
+	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+				 &sbi->s_bdev_wb_err);
 	err = -EINVAL;
 	/*
 	 * The first inode we look at is the journal inode.  Don't try
@@ -5571,13 +5586,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	}
 #endif  /* CONFIG_QUOTA */
 
-	/*
-	 * Save the original bdev mapping's wb_err value which could be
-	 * used to detect the metadata async write error.
-	 */
-	spin_lock_init(&sbi->s_bdev_wb_lock);
-	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
-				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
 	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
-- 
2.39.2

