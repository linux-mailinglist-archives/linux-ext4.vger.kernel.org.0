Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D39DB81
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 04:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfH0CGB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 22:06:01 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:32863 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728457AbfH0CGB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 22:06:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TaZ5o.3_1566871553;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TaZ5o.3_1566871553)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 10:05:53 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
        Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/3] Revert "ext4: Allow parallel DIO reads"
Date:   Tue, 27 Aug 2019 10:05:52 +0800
Message-Id: <1566871552-60946-4-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
References: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This reverts commit 16c54688592c ("ext4: Allow parallel DIO reads").

This commit causes significant performance regression in mixed random
read/write scenario. As discussed, it is because current implementation
is incomplete. So revert it at present.

The following data are tested on Intel P3600 NVMe.

fio -name=parallel_dio_reads_test -filename=/mnt/nvme0n1/testfile
-direct=1 -iodepth=1 -thread -rw=randrw -ioengine=psync -bs=$bs
-size=20G -numjobs=8 -runtime=600 -group_reporting

w/ = with parallel dio reads
w/o =  reverting parallel dio reads

bs=4k:
------------------------------------------------------------
    |            READ           |           WRITE          |
------------------------------------------------------------
w/  | 30898KB/s,7724,555.00us   | 30875KB/s,7718,479.70us  |
------------------------------------------------------------
w/o | 117915KB/s,29478,248.18us | 117854KB/s,29463,21.91us |
------------------------------------------------------------

bs=16k:
------------------------------------------------------------
    |            READ           |           WRITE          |
------------------------------------------------------------
w/  | 58961KB/s,3685,835.28us   | 58877KB/s,3679,1335.98us |
------------------------------------------------------------
w/o | 218409KB/s,13650,554.46us | 218257KB/s,13641,29.22us |
------------------------------------------------------------

bs=64k
--------------------------------------------------------------
    |            READ            |           WRITE           |
--------------------------------------------------------------
w/  | 119396KB/s,1865,1759.38us  | 119159KB/s,1861,2532.26us |
--------------------------------------------------------------
w/o | 422815KB/s,6606,1146.05us  | 421619KB/s,6587,60.72us   |
--------------------------------------------,-----------------

bs=512k
--------------------------------------------------------------
    |            READ            |           WRITE           |
--------------------------------------------------------------
w/  | 392973KB/s,767,5046.35us   | 393165KB/s,767,5359.86us  |
--------------------------------------------------------------
w/o | 590266KB/s,1152,4312.01us  | 590554KB/s,1153,2606.82us |
--------------------------------------------------------------

bs=1M
--------------------------------------------------------------
    |            READ            |           WRITE           |
--------------------------------------------------------------
w/  | 487779KB/s,476,8058.55us   | 485592KB/s,474,8630.51us  |
--------------------------------------------------------------
w/o | 593927KB/s,580,7623.63us   | 591265KB/s,577,6163.42us  |
--------------------------------------------------------------

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ext4/inode.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 16077ec..e6b1740 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3863,25 +3863,32 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 
 static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	size_t count = iov_iter_count(iter);
+	int unlocked = 0;
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	ssize_t ret;
 
-	/*
-	 * Shared inode_lock is enough for us - it protects against concurrent
-	 * writes & truncates and since we take care of writing back page cache,
-	 * we are protected against page writeback as well.
-	 */
-	inode_lock_shared(inode);
-	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
-					   iocb->ki_pos + count);
-	if (ret)
-		goto out_unlock;
+	if (ext4_should_dioread_nolock(inode)) {
+		/*
+		 * Nolock dioread optimization may be dynamically disabled
+		 * via ext4_inode_block_unlocked_dio(). Check inode's state
+		 * while holding extra i_dio_count ref.
+		 */
+		inode_dio_begin(inode);
+		smp_mb();
+		if (unlikely(ext4_test_inode_state(inode,
+						   EXT4_STATE_DIOREAD_LOCK)))
+			inode_dio_end(inode);
+		else
+			unlocked = 1;
+	}
+
 	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
-				   iter, ext4_dio_get_block, NULL, NULL, 0);
-out_unlock:
-	inode_unlock_shared(inode);
+				   iter, ext4_dio_get_block,
+				   NULL, NULL,
+				   unlocked ? 0 : DIO_LOCKING);
+	if (unlocked)
+		inode_dio_end(inode);
+
 	return ret;
 }
 
-- 
1.8.3.1

