Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AAB4C05
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfIQKdG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 06:33:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbfIQKdG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 06:33:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HAWOoP120186
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 06:33:04 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2vd5c6ng-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 06:33:04 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 17 Sep 2019 11:33:02 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Sep 2019 11:32:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8HAWWlK27590976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 10:32:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD8AC42041;
        Tue, 17 Sep 2019 10:32:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A7254203F;
        Tue, 17 Sep 2019 10:32:56 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Sep 2019 10:32:55 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Cc:     david@fromorbit.com, hch@infradead.org, adilger@dilger.ca,
        riteshh@linux.ibm.com, mbobrowski@mbobrowski.org, rgoldwyn@suse.de
Subject: [RFC 2/2] ext4: Improve DIO writes locking sequence
Date:   Tue, 17 Sep 2019 16:02:49 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917103249.20335-1-riteshh@linux.ibm.com>
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0020-0000-0000-0000036E1382
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0021-0000-0000-000021C3B739
Message-Id: <20190917103249.20335-3-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170107
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Earlier there was no shared lock in DIO read path.
But this patch (16c54688592ce: ext4: Allow parallel DIO reads)
simplified some of the locking mechanism while still allowing
for parallel DIO reads by adding shared lock in inode DIO
read path.

But this created problem with mixed read/write workload.
It is due to the fact that in DIO path, we first start with
exclusive lock and only when we determine that it is a ovewrite
IO, we downgrade the lock. This causes the problem, since
with above patch we have shared locking in DIO reads.

So, this patch tries to fix this issue by starting with
shared lock and then switching to exclusive lock only
when required based on ext4_dio_write_checks().

Other than that, it also simplifies below cases:-

1. Simplified ext4_unaligned_aio API to
ext4_unaligned_io.
Previous API was abused in the sense that it was
not really checking for AIO anywhere also it used to
check for extending writes.
So this API was renamed and simplified to ext4_unaligned_io()
which actully only checks if the IO is really unaligned.

This is because in all other cases inode_dio_wait()
will anyway become a no-op. So no need to over complicate
by checking for every condition here.

2. Added ext4_extending_io API. This checks if the IO
is extending the file.

Now we only check for
unaligned_io, extend, dioread_nolock & overwrite.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 206 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 154 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index ce1cecbae932..45af2b7679ad 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -166,14 +166,11 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
  * threads are at work on the same unwritten block, they must be synchronized
  * or one thread will zero the other's data, causing corruption.
  */
-static int
-ext4_unaligned_aio(struct inode *inode, struct iov_iter *from, loff_t pos)
+static bool
+ext4_unaligned_io(struct inode *inode, struct iov_iter *from, loff_t pos)
 {
 	struct super_block *sb = inode->i_sb;
-	int blockmask = sb->s_blocksize - 1;
-
-	if (pos >= ALIGN(i_size_read(inode), sb->s_blocksize))
-		return 0;
+	unsigned long blockmask = sb->s_blocksize - 1;
 
 	if ((pos | iov_iter_alignment(from)) & blockmask)
 		return 1;
@@ -181,6 +178,15 @@ ext4_unaligned_aio(struct inode *inode, struct iov_iter *from, loff_t pos)
 	return 0;
 }
 
+static bool
+ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
+{
+	if (offset + len > i_size_read(inode) ||
+	    offset + len > EXT4_I(inode)->i_disksize)
+		return 1;
+	return 0;
+}
+
 /* Is IO overwriting allocated and initialized blocks? */
 static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
 {
@@ -204,7 +210,9 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
 	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
 }
 
-static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
+
+static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
@@ -216,10 +224,6 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (ret <= 0)
 		return ret;
 
-	ret = file_modified(iocb->ki_filp);
-	if (ret)
-		return 0;
-
 	/*
 	 * If we have encountered a bitmap-format file, the size limit
 	 * is smaller than s_maxbytes, which is for extent-mapped files.
@@ -231,9 +235,26 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 			return -EFBIG;
 		iov_iter_truncate(from, sbi->s_bitmap_maxbytes - iocb->ki_pos);
 	}
+
 	return iov_iter_count(from);
 }
 
+static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
+{
+	ssize_t ret;
+	ssize_t count;
+
+	count = ext4_generic_write_checks(iocb, from);
+	if (count <= 0)
+		return count;
+
+	ret = file_modified(iocb->ki_filp);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 					struct iov_iter *from)
 {
@@ -336,6 +357,83 @@ static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
 	return 0;
 }
 
+/*
+ * The intention here is to start with shared lock acquired
+ * (except in unaligned IO & extending writes case),
+ * then see if any condition requires an exclusive inode
+ * lock. If yes, then we restart the whole operation by
+ * releasing the shared lock and acquiring exclusive lock.
+ *
+ * - For unaligned_io we never take exclusive lock as it
+ *   may cause data corruption when two unaligned IO tries
+ *   to modify the same block.
+ *
+ * - For extending wirtes case we don't take
+ *   the exclusive lock, since it requires updating
+ *   inode i_disksize with exclusive lock.
+ *
+ * - shared locking will only be true mostly in case of
+ *   overwrites with dioread_nolock mode.
+ *   Otherwise we will switch to exclusive locking mode.
+ */
+static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
+				 unsigned int *iolock, bool *unaligned_io,
+				 bool *extend)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	loff_t offset = iocb->ki_pos;
+	loff_t final_size;
+	size_t count;
+	ssize_t ret;
+
+restart:
+	if (!ext4_dio_checks(inode)) {
+		ext4_iunlock(inode, *iolock);
+		return ext4_buffered_write_iter(iocb, from);
+	}
+
+	ret = ext4_generic_write_checks(iocb, from);
+	if (ret <= 0) {
+		ext4_iunlock(inode, *iolock);
+		return ret;
+	}
+
+	/* Recalculate since offset & count may change above. */
+	offset = iocb->ki_pos;
+	count = iov_iter_count(from);
+	final_size = offset + count;
+
+	if (ext4_unaligned_io(inode, from, offset))
+		*unaligned_io = true;
+
+	if (ext4_extending_io(inode, offset, count))
+		*extend = true;
+	/*
+	 * Determine whether the IO operation will overwrite allocated
+	 * and initialized blocks. If so, check to see whether it is
+	 * possible to take the dioread_nolock path.
+	 *
+	 * We need exclusive i_rwsem for changing security info
+	 * in file_modified().
+	 */
+	if (*iolock == EXT4_IOLOCK_SHARED &&
+	    (!IS_NOSEC(inode) || *unaligned_io || *extend ||
+	     !ext4_should_dioread_nolock(inode) ||
+	     !ext4_overwrite_io(inode, offset, count))) {
+		ext4_iunlock(inode, *iolock);
+		*iolock = EXT4_IOLOCK_EXCL;
+		ext4_ilock(inode, *iolock);
+		goto restart;
+	}
+
+	ret = file_modified(file);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 /*
  * For a write that extends the inode size, ext4_dio_write_iter() will
  * wait for the write to complete. Consequently, operations performed
@@ -371,64 +469,68 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 
 static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
+
 	ssize_t ret;
-	size_t count;
 	loff_t offset = iocb->ki_pos;
+	size_t count = iov_iter_count(from);
 	struct inode *inode = file_inode(iocb->ki_filp);
-	bool extend = false, overwrite = false, unaligned_aio = false;
-	unsigned int iolock = EXT4_IOLOCK_EXCL;
+	bool extend = false, unaligned_io = false;
+	unsigned int iolock = EXT4_IOLOCK_SHARED;
+
+	/*
+	 * We initially start with shared inode lock
+	 * unless it is unaligned IO which needs
+	 * exclusive lock anyways.
+	 */
+	if (ext4_unaligned_io(inode, from, offset)) {
+		unaligned_io = true;
+		iolock = EXT4_IOLOCK_EXCL;
+	}
+	/*
+	 * Extending writes need exclusive lock
+	 * to update
+	 */
+	if (ext4_extending_io(inode, offset, count)) {
+		extend = true;
+		iolock = EXT4_IOLOCK_EXCL;
+	}
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/*
+		 * unaligned IO may anyway require wait
+		 * at other places, so bail out.
+		 */
+		if (unaligned_io)
+			return -EAGAIN;
 		if (!ext4_ilock_nowait(inode, iolock))
 			return -EAGAIN;
 	} else {
 		ext4_ilock(inode, iolock);
 	}
 
-	if (!ext4_dio_checks(inode)) {
-		ext4_iunlock(inode, iolock);
-		/*
-		 * Fallback to buffered IO if the operation on the
-		 * inode is not supported by direct IO.
-		 */
-		return ext4_buffered_write_iter(iocb, from);
-	}
-
-	ret = ext4_write_checks(iocb, from);
-	if (ret <= 0) {
-		ext4_iunlock(inode, iolock);
+	ret = ext4_dio_write_checks(iocb, from, &iolock, &unaligned_io,
+				    &extend);
+	if (ret <= 0)
 		return ret;
-	}
-
 	/*
-	 * Unaligned direct AIO must be serialized among each other as
+	 * Unaligned direct IO must be serialized among each other as
 	 * the zeroing of partial blocks of two competing unaligned
-	 * AIOs can result in data corruption.
+	 * IOs can result in data corruption. This can mainly
+	 * happen since we may start with shared locking and for
+	 * dioread_nolock and overwrite case we may continue to be
+	 * in shared locking mode. In that case two parallel unaligned
+	 * IO may cause data corruption.
+	 *
+	 * So we make sure we don't allow any unaligned IO in flight.
+	 * For IOs where we need not wait (like unaligned non-AIO DIO),
+	 * below dio_wait may anyway become a no-op,
+	 * since we start take exclusive locks.
 	 */
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
-	    !is_sync_kiocb(iocb) && ext4_unaligned_aio(inode, from, offset)) {
-		unaligned_aio = true;
+	if (unaligned_io)
 		inode_dio_wait(inode);
-	}
-
-	/*
-	 * Determine whether the IO operation will overwrite allocated
-	 * and initialized blocks. If so, check to see whether it is
-	 * possible to take the dioread_nolock path.
-	 */
-	count = iov_iter_count(from);
-	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
-	    ext4_should_dioread_nolock(inode)) {
-		overwrite = true;
-		ext4_ilock_demote(inode, iolock);
-		iolock = EXT4_IOLOCK_SHARED;
-	}
 
-	if (offset + count > i_size_read(inode) ||
-	    offset + count > EXT4_I(inode)->i_disksize) {
+	if (extend)
 		ext4_update_i_disksize(inode, inode->i_size);
-		extend = true;
-	}
 
 	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, ext4_dio_write_end_io);
 
@@ -440,7 +542,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	 * routines in ext4_dio_write_end_io() are covered by the
 	 * inode_lock().
 	 */
-	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
+	if (ret == -EIOCBQUEUED && (unaligned_io || extend))
 		inode_dio_wait(inode);
 
 	ext4_iunlock(inode, iolock);
-- 
2.21.0

