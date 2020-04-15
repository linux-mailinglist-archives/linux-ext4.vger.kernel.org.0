Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4F1A938C
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634948AbgDOGpj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 02:45:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:45838 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393624AbgDOGpf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 02:45:35 -0400
IronPort-SDR: UGb4e81i0vnVUAiaduEEkgRqv4PQUXXK6uoqsoGGtBi8p4HT5Px3Iwn7X6W5HGZO9Y/BJcZHKe
 OKgQxHY/7M7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 23:45:32 -0700
IronPort-SDR: nqVEJ0jM8WsGIa53f7GEW1WcutNEBH0y9zvfd6oQ3l4LmNVClCYmSnRTF6lk6TMyXP17ZUKVXC
 yaiU/9x11y0Q==
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="298916014"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 23:45:32 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V8 02/11] fs: Remove unneeded IS_DAX() check in io_is_direct()
Date:   Tue, 14 Apr 2020 23:45:14 -0700
Message-Id: <20200415064523.2244712-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415064523.2244712-1-ira.weiny@intel.com>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Remove the check because DAX now has it's own read/write methods and
file systems which support DAX check IS_DAX() prior to IOCB_DIRECT on
their own.  Therefore, it does not matter if the file state is DAX when
the iocb flags are created.

Also remove io_is_direct() as it is just a simple flag check.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v6:
	remove io_is_direct() as well.
	Remove Reviews since this is quite a bit different.

Changes from v3:
	Reword commit message.
	Reordered to be a 'pre-cleanup' patch
---
 drivers/block/loop.c | 6 +++---
 include/linux/fs.h   | 7 +------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..9a9af78974ac 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -631,8 +631,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 
 static inline void loop_update_dio(struct loop_device *lo)
 {
-	__loop_update_dio(lo, io_is_direct(lo->lo_backing_file) |
-			lo->use_dio);
+	__loop_update_dio(lo, (lo->lo_backing_file->f_flags & O_DIRECT) |
+				lo->use_dio);
 }
 
 static void loop_reread_partitions(struct loop_device *lo,
@@ -1006,7 +1006,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
-	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
+	if ((lo->lo_backing_file->f_flags & O_DIRECT) && inode->i_sb->s_bdev) {
 		/* In case of direct I/O, match underlying block size */
 		unsigned short bsize = bdev_logical_block_size(
 			inode->i_sb->s_bdev);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index abedbffe2c9e..a818ced22961 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3387,11 +3387,6 @@ extern void setattr_copy(struct inode *inode, const struct iattr *attr);
 
 extern int file_update_time(struct file *file);
 
-static inline bool io_is_direct(struct file *filp)
-{
-	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
-}
-
 static inline bool vma_is_dax(struct vm_area_struct *vma)
 {
 	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
@@ -3416,7 +3411,7 @@ static inline int iocb_flags(struct file *file)
 	int res = 0;
 	if (file->f_flags & O_APPEND)
 		res |= IOCB_APPEND;
-	if (io_is_direct(file))
+	if (file->f_flags & O_DIRECT)
 		res |= IOCB_DIRECT;
 	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
 		res |= IOCB_DSYNC;
-- 
2.25.1

