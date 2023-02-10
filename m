Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391EC69214B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Feb 2023 15:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjBJO7q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Feb 2023 09:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBJO7f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Feb 2023 09:59:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E05774D
        for <linux-ext4@vger.kernel.org>; Fri, 10 Feb 2023 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676041109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P6uxgCNaoi4a43ku7EnfQmdTGr/dbz7HRgUPH7ZPTz0=;
        b=E5teFaqHqmYk6cjv9OLW0Kc3xgfn/1eBZWGRfP622yTRXEHqbOTGT+3XRV5+1x3rI45/6T
        t2brVR9YS56VtmlhXi4/nFdskM2nLqofEmRuJpSMJ3WUx6PrMmboVqc4/sVwSJ3GPLrrHR
        TcaArUMVGyQS853FnJWi6TRVrd8cGno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-7m4qfjWaPzyNs_w9YNNWrg-1; Fri, 10 Feb 2023 09:58:28 -0500
X-MC-Unique: 7m4qfjWaPzyNs_w9YNNWrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C95F858F09
        for <linux-ext4@vger.kernel.org>; Fri, 10 Feb 2023 14:58:28 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6E6E2166B29
        for <linux-ext4@vger.kernel.org>; Fri, 10 Feb 2023 14:58:27 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH RFC] ext4: allow concurrent unaligned dio overwrites
Date:   Fri, 10 Feb 2023 09:59:54 -0500
Message-Id: <20230210145954.277611-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

We've had a customer report a significant performance regression of
sub-block (unaligned) direct writes between a couple distro kernels
(that span a large range of upstream releases). I've not bisected
upstream to narrow down to specific commit(s), but the regression
appears to correspond with added concurrency restrictions of
unaligned dio in ext4. Obviously this user should ideally move to a
configuration that minimizes unaligned I/O, but while looking into
this we also observed that XFS performs noticeably better with the
same workload, even though it has the same general unaligned dio
constraints.

The difference appears to be the use of IOMAP_DIO_OVERWRITE_ONLY in
XFS, which allows optimistic concurrent submission of unaligned
direct I/O under shared locking. I.e., if the dio turns out to be
something other than a pure overwrite that may require block
zeroing, iomap kicks the request back with -EAGAIN so it can be
resubmitted with appropriate exclusivity.

I initially prototyped this same sort of logic on ext4, but on
further inspection realized that ext4 seems to already check for dio
overwrites in ext4_dio_write_checks(). Therefore ISTM that since
ext4 already knows when a dio is purely overwrite, it can safely
submit unaligned dios concurrently where it knows zeroing is not
required, and then fall back to exclusive submission otherwise.

This RFC prototypes something along those lines using ilock_shared
as a proxy for non-overwrite (since non-overwrite always means
non-shared locking). Based on the following fio test against a
prewritten (i.e. no unwritten extents) file, on an 8xcpu kvm guest,
using default ext4 options:

fio --name=test --ioengine=libaio --direct=1 --group_reporting
  --overwrite=1 --thread --size=10G --filename=/mnt/fio
  --readwrite=write --ramp_time=10s --runtime=60s --numjobs=8
  --blocksize=2k --iodepth=256 --allow_file_create=0

... performance goes from something like ~1350 iops / 2.7 MB/s on a
v6.1 kernel to +350k iops / +700MB/s on a patched v6.2.0-rc7 kernel.
The latter is much more closely aligned to what I see from the same
test against XFS.

This also survives an initial fstests regression run, though it does
leave at least a couple open questions I can think of:

1. Do we care to be explicit about overwrites and perhaps plumb
   through an 'overwrite' flag from ext4_dio_write_checks()?
2. Do we want to use DIO_OVERWRITE_ONLY and assume iomap will never
   kick back an overwrite only I/O, or perhaps include retry logic
   similar to XFS? That may be superfluous, but it's not much
   additional  code either.

Thoughts on any of this? If there's consensus I can followup with a v1
with a proper implementation, commit log, code comment updates, etc.

Not-Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/ext4/file.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 7ac0a81bd371..bb41520f89d0 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -493,15 +493,14 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
 	bool extend = false, unaligned_io = false;
 	bool ilock_shared = true;
+	unsigned int dio_flags = 0;
 
 	/*
 	 * We initially start with shared inode lock unless it is
 	 * unaligned IO which needs exclusive lock anyways.
 	 */
-	if (ext4_unaligned_io(inode, from, offset)) {
+	if (ext4_unaligned_io(inode, from, offset))
 		unaligned_io = true;
-		ilock_shared = false;
-	}
 	/*
 	 * Quick check here without any i_rwsem lock to see if it is extending
 	 * IO. A more reliable check is done in ext4_dio_write_checks() with
@@ -563,9 +562,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	 * below inode_dio_wait() may anyway become a no-op, since we start
 	 * with exclusive lock.
 	 */
-	if (unaligned_io)
-		inode_dio_wait(inode);
-
 	if (extend) {
 		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 		if (IS_ERR(handle)) {
@@ -582,11 +578,18 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_journal_stop(handle);
 	}
 
-	if (ilock_shared)
+	if (ilock_shared) {
 		iomap_ops = &ext4_iomap_overwrite_ops;
+		if (unaligned_io)
+			dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
+	} else if (unaligned_io || extend) {
+		dio_flags = IOMAP_DIO_FORCE_WAIT;
+		if (unaligned_io)
+			inode_dio_wait(inode);
+	}
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
-			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
-			   NULL, 0);
+			   dio_flags, NULL, 0);
+	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
 	if (ret == -ENOTBLK)
 		ret = 0;
 
-- 
2.39.1

