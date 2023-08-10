Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CAD777EA8
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjHJQxt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 12:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjHJQxs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 12:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED588268E
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691686380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=627YhmbhhzdkWeREayk+YJxkQHLvz3Ddr4mZUxza6Tw=;
        b=Zbi5odm96+VJGZEtVQvNz71F+MbGmJDNU/qDy7JZM5EYPNdOE93ZIxXZIlBv8Pyx1UBEeo
        mh0tmgoBHOtefMvsbXQtJLDocR2YnqNqymJ9V6xBlv2X6x89OTUf4fAKwQYT/PZ84MHwZ4
        lSFHEfU7p+uH0Ah93+AaAIuODn/PyUM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-ujdtcV38Mei00LNCHn5yNA-1; Thu, 10 Aug 2023 12:52:54 -0400
X-MC-Unique: ujdtcV38Mei00LNCHn5yNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5C88011AD;
        Thu, 10 Aug 2023 16:52:54 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1119B492C3E;
        Thu, 10 Aug 2023 16:52:54 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Ritesh Harjani <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v2] ext4: drop dio overwrite only flag and associated warning
Date:   Thu, 10 Aug 2023 12:55:59 -0400
Message-ID: <20230810165559.946222-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The commit referenced below opened up concurrent unaligned dio under
shared locking for pure overwrites. In doing so, it enabled use of
the IOMAP_DIO_OVERWRITE_ONLY flag and added a warning on unexpected
-EAGAIN returns as an extra precaution, since ext4 does not retry
writes in such cases. The flag itself is advisory in this case since
ext4 checks for unaligned I/Os and uses appropriate locking up
front, rather than on a retry in response to -EAGAIN.

As it turns out, the warning check is susceptible to false positives
because there are scenarios where -EAGAIN can be expected from lower
layers without necessarily having IOCB_NOWAIT set on the iocb. For
example, one instance of the warning has been seen where io_uring
sets IOCB_HIPRI, which in turn results in REQ_POLLED|REQ_NOWAIT on
the bio. This results in -EAGAIN if the block layer is unable to
allocate a request, etc. [Note that there is an outstanding patch to
untangle REQ_POLLED and REQ_NOWAIT such that the latter relies on
IOCB_NOWAIT, which would also address this instance of the warning.]

Another instance of the warning has been reproduced by syzbot. A dio
write is interrupted down in __get_user_pages_locked() waiting on
the mm lock and returns -EAGAIN up the stack. If the iomap dio
iteration layer has made no progress on the write to this point,
-EAGAIN returns up to the filesystem and triggers the warning.

This use of the overwrite flag in ext4 is precautionary and
half-baked. I.e., ext4 doesn't actually implement overwrite checking
in the iomap callbacks when the flag is set, so the only extra
verification it provides are i_size checks in the generic iomap dio
layer. Combined with the tendency for false positives, the added
verification is not worth the extra trouble. Remove the flag,
associated warning, and update the comments to document when
concurrent unaligned dio writes are allowed and why said flag is not
used.

Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---

v2:
- Updated commit log description.
- Added Review/Reported-by tags.
v1: https://lore.kernel.org/linux-ext4/20230804182952.477247-1-bfoster@redhat.com/

 fs/ext4/file.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c457c8517f0f..73a4b711be02 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -476,6 +476,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 * required to change security info in file_modified(), for extending
 	 * I/O, any form of non-overwrite I/O, and unaligned I/O to unwritten
 	 * extents (as partial block zeroing may be required).
+	 *
+	 * Note that unaligned writes are allowed under shared lock so long as
+	 * they are pure overwrites. Otherwise, concurrent unaligned writes risk
+	 * data corruption due to partial block zeroing in the dio layer, and so
+	 * the I/O must occur exclusively.
 	 */
 	if (*ilock_shared &&
 	    ((!IS_NOSEC(inode) || *extend || !overwrite ||
@@ -492,21 +497,12 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 
 	/*
 	 * Now that locking is settled, determine dio flags and exclusivity
-	 * requirements. Unaligned writes are allowed under shared lock so long
-	 * as they are pure overwrites. Set the iomap overwrite only flag as an
-	 * added precaution in this case. Even though this is unnecessary, we
-	 * can detect and warn on unexpected -EAGAIN if an unsafe unaligned
-	 * write is ever submitted.
-	 *
-	 * Otherwise, concurrent unaligned writes risk data corruption due to
-	 * partial block zeroing in the dio layer, and so the I/O must occur
-	 * exclusively. The inode lock is already held exclusive if the write is
-	 * non-overwrite or extending, so drain all outstanding dio and set the
-	 * force wait dio flag.
+	 * requirements. We don't use DIO_OVERWRITE_ONLY because we enforce
+	 * behavior already. The inode lock is already held exclusive if the
+	 * write is non-overwrite or extending, so drain all outstanding dio and
+	 * set the force wait dio flag.
 	 */
-	if (*ilock_shared && unaligned_io) {
-		*dio_flags = IOMAP_DIO_OVERWRITE_ONLY;
-	} else if (!*ilock_shared && (unaligned_io || *extend)) {
+	if (!*ilock_shared && (unaligned_io || *extend)) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			goto out;
@@ -608,7 +604,6 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   dio_flags, NULL, 0);
-	WARN_ON_ONCE(ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT));
 	if (ret == -ENOTBLK)
 		ret = 0;
 
-- 
2.41.0

