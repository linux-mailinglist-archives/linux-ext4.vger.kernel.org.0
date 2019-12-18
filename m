Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21BBD124F9B
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2019 18:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfLRRoq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Dec 2019 12:44:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:51902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfLRRoq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Dec 2019 12:44:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 25A8EB1B3;
        Wed, 18 Dec 2019 17:44:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F6F91E0B38; Wed, 18 Dec 2019 18:44:38 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Optimize ext4 DIO overwrites
Date:   Wed, 18 Dec 2019 18:44:33 +0100
Message-Id: <20191218174433.19380-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently we start transaction for mapping every extent for writing
using direct IO. This is unnecessary when we know we are overwriting
already allocated blocks and the overhead of starting a transaction can
be significant especially for multithreaded workloads doing small writes.
Use iomap operations that avoid starting a transaction for direct IO
overwrites.

This improves throughput of 4k random writes - fio jobfile:
[global]
rw=randrw
norandommap=1
invalidate=0
bs=4k
numjobs=16
time_based=1
ramp_time=30
runtime=120
group_reporting=1
ioengine=psync
direct=1
size=16G
filename=file1.0.0:file1.0.1:file1.0.2:file1.0.3:file1.0.4:file1.0.5:file1.0.6:file1.0.7:file1.0.8:file1.0.9:file1.0.10:file1.0.11:file1.0.12:file1.0.13:file1.0.14:file1.0.15:file1.0.16:file1.0.17:file1.0.18:file1.0.19:file1.0.20:file1.0.21:file1.0.22:file1.0.23:file1.0.24:file1.0.25:file1.0.26:file1.0.27:file1.0.28:file1.0.29:file1.0.30:file1.0.31
file_service_type=random
nrfiles=32

from 3018MB/s to 4059MB/s in my test VM running test against simulated
pmem device (note that before iomap conversion, this workload was able
to achieve 3708MB/s because old direct IO path avoided transaction start
for overwrites as well). For dax, the win is even larger improving
throughput from 3042MB/s to 4311MB/s.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/file.c  |  4 +++-
 fs/ext4/inode.c | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f8578caba40d..e31fc5749a19 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3390,6 +3390,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
 }
 
 extern const struct iomap_ops ext4_iomap_ops;
+extern const struct iomap_ops ext4_iomap_overwrite_ops;
 extern const struct iomap_ops ext4_iomap_report_ops;
 
 static inline int ext4_buffer_uptodate(struct buffer_head *bh)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6a7293a5cda2..f8e4af72d64d 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -370,6 +370,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t offset;
 	handle_t *handle;
 	struct inode *inode = file_inode(iocb->ki_filp);
+	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
 	bool extend = false, overwrite = false, unaligned_aio = false;
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -415,6 +416,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
 	    ext4_should_dioread_nolock(inode)) {
 		overwrite = true;
+		iomap_ops = &ext4_iomap_overwrite_ops;
 		downgrade_write(&inode->i_rwsem);
 	}
 
@@ -435,7 +437,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_journal_stop(handle);
 	}
 
-	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
+	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   is_sync_kiocb(iocb) || unaligned_aio || extend);
 
 	if (extend)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 28f28de0c1b6..e1eb4493aacc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3448,6 +3448,22 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	int ret;
+
+	/*
+	 * Even for writes we don't need to allocate blocks, so just pretend
+	 * we are reading to save overhead of starting a transaction.
+	 */
+	flags &= ~IOMAP_WRITE;
+	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
+	return ret;
+}
+
 static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 			  ssize_t written, unsigned flags, struct iomap *iomap)
 {
@@ -3469,6 +3485,11 @@ const struct iomap_ops ext4_iomap_ops = {
 	.iomap_end		= ext4_iomap_end,
 };
 
+const struct iomap_ops ext4_iomap_overwrite_ops = {
+	.iomap_begin		= ext4_iomap_overwrite_begin,
+	.iomap_end		= ext4_iomap_end,
+};
+
 static bool ext4_iomap_is_delalloc(struct inode *inode,
 				   struct ext4_map_blocks *map)
 {
-- 
2.16.4

