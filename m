Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9546B959D
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 14:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjCNNLL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCNNKv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 09:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906CACBB6
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678799177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Z65+nEMwhohasA18a2pfDv5kRTNded9Fp+0iT6nls0=;
        b=KCF9UPot1nNx0eypIW/6mkjoBB6ZQUep2AMrLaP0GYPJSxX+ZEoQd6g0M554fQ7iNmLmn0
        /b360TpiFfCisTV8PR8JYp9Dvpbi+t2guP6+3jLVbyKNQkLC/F1fF5ls1QKGtlLjehdE1s
        Hi4688xs4DjCyXjFpRom8cWucpBVPEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-GfY0f5aWPZSJQj9TqW2S0A-1; Tue, 14 Mar 2023 09:06:14 -0400
X-MC-Unique: GfY0f5aWPZSJQj9TqW2S0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE209803490;
        Tue, 14 Mar 2023 13:06:13 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C0B5202701E;
        Tue, 14 Mar 2023 13:06:13 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Ritesh Harjani <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2] ext4: allow concurrent unaligned dio overwrites
Date:   Tue, 14 Mar 2023 09:07:59 -0400
Message-Id: <20230314130759.642710-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We've had reports of significant performance regression of sub-block
(unaligned) direct writes due to the added exclusivity restrictions
in ext4. The purpose of the exclusivity requirement for unaligned
direct writes is to avoid data corruption caused by unserialized
partial block zeroing in the iomap dio layer across overlapping
writes.

XFS has similar requirements for the same underlying reasons, yet
doesn't suffer the extreme performance regression that ext4 does.
The reason for this is that XFS utilizes IOMAP_DIO_OVERWRITE_ONLY
mode, which allows for optimistic submission of concurrent unaligned
I/O and kicks back writes that require partial block zeroing such
that they can be submitted in a safe, exclusive context. Since ext4
already performs most of these checks pre-submission, it can support
something similar without necessarily relying on the iomap flag and
associated retry mechanism.

Update the dio write submission path to allow concurrent submission
of unaligned direct writes that are purely overwrite and so will not
require block zeroing. To improve readability of the various related
checks, move the unaligned I/O handling down into
ext4_dio_write_checks(), where the dio draining and force wait logic
can immediately follow the locking requirement checks. Finally, the
IOMAP_DIO_OVERWRITE_ONLY flag is set to enable a warning check as a
precaution should the ext4 overwrite logic ever become inconsistent
with the zeroing expectations of iomap dio.

The performance improvement of sub-block direct write I/O is shown
in the following fio test on a 64xcpu guest vm:

Test: fio --name=test --ioengine=libaio --direct=1 --group_reporting
--overwrite=1 --thread --size=10G --filename=/mnt/fio
--readwrite=write --ramp_time=10s --runtime=60s --numjobs=8
--blocksize=2k --iodepth=256 --allow_file_create=0

v6.2:		write: IOPS=4328, BW=8724KiB/s
v6.2 (patched):	write: IOPS=801k, BW=1565MiB/s

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

No real changes here, just resending as a ping. Thanks for the reviews!

Brian

v2:
- Rebased to 6.3-rc2, added review tags.
v1: https://lore.kernel.org/linux-ext4/20230223191626.263331-1-bfoster@redhat.com/
- Rebased on top of "ext4: dio take shared inode lock when overwriting
  preallocated blocks"
- Refactored to localize checks in ext4_dio_write_checks().
rfc: https://lore.kernel.org/linux-ext4/20230210145954.277611-1-bfoster@redhat.com/

 fs/ext4/file.c | 86 +++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0b8b4499e5ca..89ac92c1b416 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -444,13 +444,14 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
  */
 static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 				     bool *ilock_shared, bool *extend,
-				     bool *unwritten)
+				     bool *unwritten, int *dio_flags)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	loff_t offset;
 	size_t count;
 	ssize_t ret;
+	bool overwrite, unaligned_io;
 
 restart:
 	ret = ext4_generic_write_checks(iocb, from);
@@ -459,16 +460,20 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 
 	offset = iocb->ki_pos;
 	count = ret;
-	if (ext4_extending_io(inode, offset, count))
-		*extend = true;
+
+	unaligned_io = ext4_unaligned_io(inode, from, offset);
+	*extend = ext4_extending_io(inode, offset, count);
+	overwrite = ext4_overwrite_io(inode, offset, count, unwritten);
+
 	/*
-	 * Determine whether the IO operation will overwrite allocated
-	 * and initialized blocks.
-	 * We need exclusive i_rwsem for changing security info
-	 * in file_modified().
+	 * Determine whether we need to upgrade to an exclusive lock. This is
+	 * required to change security info in file_modified(), for extending
+	 * I/O, any form of non-overwrite I/O, and unaligned I/O to unwritten
+	 * extents (as partial block zeroing may be required).
 	 */
-	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
-	     !ext4_overwrite_io(inode, offset, count, unwritten))) {
+	if (*ilock_shared &&
+	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
+	     (unaligned_io && *unwritten)))) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			goto out;
@@ -479,6 +484,32 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 		goto restart;
 	}
 
+	/*
+	 * Now that locking is settled, determine dio flags and exclusivity
+	 * requirements. Unaligned writes are allowed under shared lock so long
+	 * as they are pure overwrites. Set the iomap overwrite only flag as an
+	 * added precaution in this case. Even though this is unnecessary, we
+	 * can detect and warn on unexpected -EAGAIN if an unsafe unaligned
+	 * write is ever submitted.
+	 *
+	 * Otherwise, concurrent unaligned writes risk data corruption due to
+	 * partial block zeroing in the dio layer, and so the I/O must occur
+	 * exclusively. The inode lock is already held exclusive if the write is
+	 * non-overwrite or extending, so drain all outstanding dio and set the
+	 * force wait dio flag.
+	 */
+	if (*ilock_shared && unaligned_io) {
+		*dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
+	} else if (!*ilock_shared && (unaligned_io || *extend)) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		if (unaligned_io && (!overwrite || *unwritten))
+			inode_dio_wait(inode);
+		*dio_flags = IOMAP_DIO_FORCE_WAIT;
+	}
+
 	ret = file_modified(file);
 	if (ret < 0)
 		goto out;
@@ -500,17 +531,10 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
 	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
-	bool extend = false, unaligned_io = false, unwritten = false;
+	bool extend = false, unwritten = false;
 	bool ilock_shared = true;
+	int dio_flags = 0;
 
-	/*
-	 * We initially start with shared inode lock unless it is
-	 * unaligned IO which needs exclusive lock anyways.
-	 */
-	if (ext4_unaligned_io(inode, from, offset)) {
-		unaligned_io = true;
-		ilock_shared = false;
-	}
 	/*
 	 * Quick check here without any i_rwsem lock to see if it is extending
 	 * IO. A more reliable check is done in ext4_dio_write_checks() with
@@ -543,16 +567,11 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ext4_buffered_write_iter(iocb, from);
 	}
 
-	ret = ext4_dio_write_checks(iocb, from,
-				    &ilock_shared, &extend, &unwritten);
+	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
+				    &unwritten, &dio_flags);
 	if (ret <= 0)
 		return ret;
 
-	/* if we're going to block and IOCB_NOWAIT is set, return -EAGAIN */
-	if ((iocb->ki_flags & IOCB_NOWAIT) && (unaligned_io || extend)) {
-		ret = -EAGAIN;
-		goto out;
-	}
 	/*
 	 * Make sure inline data cannot be created anymore since we are going
 	 * to allocate blocks for DIO. We know the inode does not have any
@@ -563,19 +582,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	offset = iocb->ki_pos;
 	count = ret;
 
-	/*
-	 * Unaligned direct IO must be serialized among each other as zeroing
-	 * of partial blocks of two competing unaligned IOs can result in data
-	 * corruption.
-	 *
-	 * So we make sure we don't allow any unaligned IO in flight.
-	 * For IOs where we need not wait (like unaligned non-AIO DIO),
-	 * below inode_dio_wait() may anyway become a no-op, since we start
-	 * with exclusive lock.
-	 */
-	if (unaligned_io)
-		inode_dio_wait(inode);
-
 	if (extend) {
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 		if (IS_ERR(handle)) {
@@ -595,8 +601,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (ilock_shared && !unwritten)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
-			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
-			   NULL, 0);
+			   dio_flags, NULL, 0);
+	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
 	if (ret == -ENOTBLK)
 		ret = 0;
 
-- 
2.39.2

