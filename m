Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA9B4C04
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfIQKdF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 06:33:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbfIQKdF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 06:33:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8HAWkjw068931
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 06:33:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v2u2878br-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 06:33:03 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 17 Sep 2019 11:33:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Sep 2019 11:32:56 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8HAWu6j25952432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Sep 2019 10:32:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D292A42047;
        Tue, 17 Sep 2019 10:32:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3140D42049;
        Tue, 17 Sep 2019 10:32:54 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.57])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Sep 2019 10:32:54 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Cc:     david@fromorbit.com, hch@infradead.org, adilger@dilger.ca,
        riteshh@linux.ibm.com, mbobrowski@mbobrowski.org, rgoldwyn@suse.de
Subject: [RFC 1/2] ext4: Add ext4_ilock & ext4_iunlock API
Date:   Tue, 17 Sep 2019 16:02:48 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917103249.20335-1-riteshh@linux.ibm.com>
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091710-0012-0000-0000-0000034D14CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091710-0013-0000-0000-000021878E86
Message-Id: <20190917103249.20335-2-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=994 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909170107
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds ext4_ilock/iunlock types of APIs.
This is the preparation APIs to make shared
locking/unlocking & restarting with exclusive
locking/unlocking easier in next patch.

Along with above this also addresses the AIM7
regression problem which was only fixed for XFS
in,
commit 942491c9e6d6 ("xfs: fix AIM7 regression")

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h    | 33 +++++++++++++++++++++++++
 fs/ext4/extents.c | 16 ++++++------
 fs/ext4/file.c    | 63 +++++++++++++++++++++++++----------------------
 fs/ext4/inode.c   |  4 +--
 fs/ext4/ioctl.c   | 16 ++++++------
 fs/ext4/super.c   | 12 ++++-----
 fs/ext4/xattr.c   | 16 ++++++------
 7 files changed, 98 insertions(+), 62 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2ab91815f52d..9ffafbe6bc3f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2945,6 +2945,39 @@ static inline int ext4_update_inode_size(struct inode *inode, loff_t newsize)
 	return changed;
 }
 
+#define EXT4_IOLOCK_EXCL	(1 << 0)
+#define EXT4_IOLOCK_SHARED	(1 << 1)
+
+static inline void ext4_ilock(struct inode *inode, unsigned int iolock)
+{
+	if (iolock == EXT4_IOLOCK_EXCL)
+		inode_lock(inode);
+	else
+		inode_lock_shared(inode);
+}
+
+static inline void ext4_iunlock(struct inode *inode, unsigned int iolock)
+{
+	if (iolock == EXT4_IOLOCK_EXCL)
+		inode_unlock(inode);
+	else
+		inode_unlock_shared(inode);
+}
+
+static inline int ext4_ilock_nowait(struct inode *inode, unsigned int iolock)
+{
+	if (iolock == EXT4_IOLOCK_EXCL)
+		return inode_trylock(inode);
+	else
+		return inode_trylock_shared(inode);
+}
+
+static inline void ext4_ilock_demote(struct inode *inode, unsigned int iolock)
+{
+	BUG_ON(iolock != EXT4_IOLOCK_EXCL);
+	downgrade_write(&inode->i_rwsem);
+}
+
 int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 				      loff_t len);
 
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a869e206bd81..ef37f4d4ee7e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4680,7 +4680,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	else
 		max_blocks -= lblk;
 
-	inode_lock(inode);
+	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 
 	/*
 	 * Indirect files do not support unwritten extnets
@@ -4790,7 +4790,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	ext4_journal_stop(handle);
 out_mutex:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	return ret;
 }
 
@@ -4856,7 +4856,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (mode & FALLOC_FL_KEEP_SIZE)
 		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
 
-	inode_lock(inode);
+	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 
 	/*
 	 * We only support preallocation for extent-based files only
@@ -4887,7 +4887,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 						EXT4_I(inode)->i_sync_tid);
 	}
 out:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 	return ret;
 }
@@ -5387,7 +5387,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 			return ret;
 	}
 
-	inode_lock(inode);
+	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 	/*
 	 * There is no need to overlap collapse range with EOF, in which case
 	 * it is effectively a truncate operation
@@ -5486,7 +5486,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 out_mmap:
 	up_write(&EXT4_I(inode)->i_mmap_sem);
 out_mutex:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	return ret;
 }
 
@@ -5537,7 +5537,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 			return ret;
 	}
 
-	inode_lock(inode);
+	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 	/* Currently just for extent based files */
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		ret = -EOPNOTSUPP;
@@ -5664,7 +5664,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 out_mmap:
 	up_write(&EXT4_I(inode)->i_mmap_sem);
 out_mutex:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	return ret;
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d2ff383a8b9f..ce1cecbae932 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -57,14 +57,15 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	/*
 	 * Get exclusion from truncate and other inode operations.
 	 */
-	if (!inode_trylock_shared(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!ext4_ilock_nowait(inode, EXT4_IOLOCK_SHARED))
 			return -EAGAIN;
-		inode_lock_shared(inode);
+	} else {
+		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
 	}
 
 	if (!ext4_dio_checks(inode)) {
-		inode_unlock_shared(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
 		/*
 		 * Fallback to buffered IO if the operation being
 		 * performed on the inode is not supported by direct
@@ -77,7 +78,7 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	}
 
 	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL);
-	inode_unlock_shared(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
 
 	file_accessed(iocb->ki_filp);
 	return ret;
@@ -89,22 +90,23 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	if (!inode_trylock_shared(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!ext4_ilock_nowait(inode, EXT4_IOLOCK_SHARED))
 			return -EAGAIN;
-		inode_lock_shared(inode);
+	} else {
+		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
 	}
 	/*
 	 * Recheck under inode lock - at this point we are sure it cannot
 	 * change anymore
 	 */
 	if (!IS_DAX(inode)) {
-		inode_unlock_shared(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
 		/* Fallback to buffered IO in case we cannot support DAX */
 		return generic_file_read_iter(iocb, to);
 	}
 	ret = dax_iomap_rw(iocb, to, &ext4_iomap_ops);
-	inode_unlock_shared(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
 
 	file_accessed(iocb->ki_filp);
 	return ret;
@@ -241,7 +243,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	inode_lock(inode);
+	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
@@ -250,7 +252,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
 	current->backing_dev_info = NULL;
 out:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	if (likely(ret > 0)) {
 		iocb->ki_pos += ret;
 		ret = generic_write_sync(iocb, ret);
@@ -374,15 +376,17 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t offset = iocb->ki_pos;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	bool extend = false, overwrite = false, unaligned_aio = false;
+	unsigned int iolock = EXT4_IOLOCK_EXCL;
 
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!ext4_ilock_nowait(inode, iolock))
 			return -EAGAIN;
-		inode_lock(inode);
+	} else {
+		ext4_ilock(inode, iolock);
 	}
 
 	if (!ext4_dio_checks(inode)) {
-		inode_unlock(inode);
+		ext4_iunlock(inode, iolock);
 		/*
 		 * Fallback to buffered IO if the operation on the
 		 * inode is not supported by direct IO.
@@ -392,7 +396,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0) {
-		inode_unlock(inode);
+		ext4_iunlock(inode, iolock);
 		return ret;
 	}
 
@@ -416,7 +420,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
 	    ext4_should_dioread_nolock(inode)) {
 		overwrite = true;
-		downgrade_write(&inode->i_rwsem);
+		ext4_ilock_demote(inode, iolock);
+		iolock = EXT4_IOLOCK_SHARED;
 	}
 
 	if (offset + count > i_size_read(inode) ||
@@ -438,10 +443,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
 		inode_dio_wait(inode);
 
-	if (overwrite)
-		inode_unlock_shared(inode);
-	else
-		inode_unlock(inode);
+	ext4_iunlock(inode, iolock);
 
 	if (ret >= 0 && iov_iter_count(from))
 		return ext4_buffered_write_iter(iocb, from);
@@ -457,10 +459,11 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t offset;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!ext4_ilock_nowait(inode, EXT4_IOLOCK_EXCL))
 			return -EAGAIN;
-		inode_lock(inode);
+	} else {
+		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 	}
 
 	ret = ext4_write_checks(iocb, from);
@@ -480,7 +483,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (error)
 		ret = error;
 out:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
@@ -707,14 +710,14 @@ loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
 		return generic_file_llseek_size(file, offset, whence,
 						maxbytes, i_size_read(inode));
 	case SEEK_HOLE:
-		inode_lock_shared(inode);
+		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
 		offset = iomap_seek_hole(inode, offset, &ext4_iomap_ops);
-		inode_unlock_shared(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
 		break;
 	case SEEK_DATA:
-		inode_lock_shared(inode);
+		ext4_ilock(inode, EXT4_IOLOCK_SHARED);
 		offset = iomap_seek_data(inode, offset, &ext4_iomap_ops);
-		inode_unlock_shared(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_SHARED);
 		break;
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a4f0749527c7..2870699ee504 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3914,7 +3914,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 			return ret;
 	}
 
-	inode_lock(inode);
+	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 
 	/* No need to punch hole beyond i_size */
 	if (offset >= inode->i_size)
@@ -4021,7 +4021,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 out_dio:
 	up_write(&EXT4_I(inode)->i_mmap_sem);
 out_mutex:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	return ret;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 442f7ef873fc..c6ae48567207 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -787,13 +787,13 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (err)
 			return err;
 
-		inode_lock(inode);
+		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 		err = ext4_ioctl_check_immutable(inode,
 				from_kprojid(&init_user_ns, ei->i_projid),
 				flags);
 		if (!err)
 			err = ext4_ioctl_setflags(inode, flags);
-		inode_unlock(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 		mnt_drop_write_file(filp);
 		return err;
 	}
@@ -824,7 +824,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto setversion_out;
 		}
 
-		inode_lock(inode);
+		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
 		if (IS_ERR(handle)) {
 			err = PTR_ERR(handle);
@@ -839,7 +839,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		ext4_journal_stop(handle);
 
 unlock_out:
-		inode_unlock(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 setversion_out:
 		mnt_drop_write_file(filp);
 		return err;
@@ -958,9 +958,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * ext4_ext_swap_inode_data before we switch the
 		 * inode format to prevent read.
 		 */
-		inode_lock((inode));
+		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 		err = ext4_ext_migrate(inode);
-		inode_unlock((inode));
+		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 		mnt_drop_write_file(filp);
 		return err;
 	}
@@ -1150,7 +1150,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (err)
 			return err;
 
-		inode_lock(inode);
+		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 		ext4_fill_fsxattr(inode, &old_fa);
 		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 		if (err)
@@ -1165,7 +1165,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto out;
 		err = ext4_ioctl_setproject(filp, fa.fsx_projid);
 out:
-		inode_unlock(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 		mnt_drop_write_file(filp);
 		return err;
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605d437a..45519036de83 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2681,12 +2681,12 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 					__func__, inode->i_ino, inode->i_size);
 			jbd_debug(2, "truncating inode %lu to %lld bytes\n",
 				  inode->i_ino, inode->i_size);
-			inode_lock(inode);
+			ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 			truncate_inode_pages(inode->i_mapping, inode->i_size);
 			ret = ext4_truncate(inode);
 			if (ret)
 				ext4_std_error(inode->i_sb, ret);
-			inode_unlock(inode);
+			ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 			nr_truncates++;
 		} else {
 			if (test_opt(sb, DEBUG))
@@ -5763,7 +5763,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		 * files. If this fails, we return success anyway since quotas
 		 * are already enabled and this is not a hard failure.
 		 */
-		inode_lock(inode);
+		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 		handle = ext4_journal_start(inode, EXT4_HT_QUOTA, 1);
 		if (IS_ERR(handle))
 			goto unlock_inode;
@@ -5773,7 +5773,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 	unlock_inode:
-		inode_unlock(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	}
 	return err;
 }
@@ -5865,7 +5865,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	if (err || ext4_has_feature_quota(sb))
 		goto out_put;
 
-	inode_lock(inode);
+	ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 	/*
 	 * Update modification times of quota files when userspace can
 	 * start looking at them. If we fail, we return success anyway since
@@ -5880,7 +5880,7 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	ext4_mark_inode_dirty(handle, inode);
 	ext4_journal_stop(handle);
 out_unlock:
-	inode_unlock(inode);
+	ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 out_put:
 	lockdep_set_quota_inode(inode, I_DATA_SEM_NORMAL);
 	iput(inode);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 491f9ee4040e..dbe3e2900c24 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -422,9 +422,9 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 		ext4_set_inode_state(inode, EXT4_STATE_LUSTRE_EA_INODE);
 		ext4_xattr_inode_set_ref(inode, 1);
 	} else {
-		inode_lock(inode);
+		ext4_ilock(inode, EXT4_IOLOCK_EXCL);
 		inode->i_flags |= S_NOQUOTA;
-		inode_unlock(inode);
+		ext4_iunlock(inode, EXT4_IOLOCK_EXCL);
 	}
 
 	*ea_inode = inode;
@@ -1025,7 +1025,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 	u32 hash;
 	int ret;
 
-	inode_lock(ea_inode);
+	ext4_ilock(ea_inode, EXT4_IOLOCK_EXCL);
 
 	ret = ext4_reserve_inode_write(handle, ea_inode, &iloc);
 	if (ret)
@@ -1079,7 +1079,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 		ext4_warning_inode(ea_inode,
 				   "ext4_mark_iloc_dirty() failed ret=%d", ret);
 out:
-	inode_unlock(ea_inode);
+	ext4_iunlock(ea_inode, EXT4_IOLOCK_EXCL);
 	return ret;
 }
 
@@ -1400,10 +1400,10 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 		block += 1;
 	}
 
-	inode_lock(ea_inode);
+	ext4_ilock(ea_inode, EXT4_IOLOCK_EXCL);
 	i_size_write(ea_inode, wsize);
 	ext4_update_i_disksize(ea_inode, wsize);
-	inode_unlock(ea_inode);
+	ext4_iunlock(ea_inode, EXT4_IOLOCK_EXCL);
 
 	ext4_mark_inode_dirty(handle, ea_inode);
 
@@ -1452,9 +1452,9 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
 		 */
 		dquot_free_inode(ea_inode);
 		dquot_drop(ea_inode);
-		inode_lock(ea_inode);
+		ext4_ilock(ea_inode, EXT4_IOLOCK_EXCL);
 		ea_inode->i_flags |= S_NOQUOTA;
-		inode_unlock(ea_inode);
+		ext4_iunlock(ea_inode, EXT4_IOLOCK_EXCL);
 	}
 
 	return ea_inode;
-- 
2.21.0

