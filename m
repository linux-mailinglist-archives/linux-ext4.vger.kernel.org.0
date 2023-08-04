Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2307707FE
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 20:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjHDSa4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Aug 2023 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjHDSaO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Aug 2023 14:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69D6182
        for <linux-ext4@vger.kernel.org>; Fri,  4 Aug 2023 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691173610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Buhu2Q8CcLtbdXqwBiObmG7nmTt19qZgkG/RC5XdQr4=;
        b=L24O5Cki5Zfrv9sx8UC9I0lcvireSSZICPswPbxMRTsIah5Nq1rZHalqaoMdJORpv7/YTp
        AK6xvAhFcs0/gUKqWt7/3FPhMsyHiybpxTlKnrNBVklMxB8PFbsBsFUtNARaXp5T2VJh9m
        nzhcgRATpvn35+ILKrg7ejo9NLrlQ88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-J1TXwZSZOJe-z-_ZnfL0Lg-1; Fri, 04 Aug 2023 14:26:47 -0400
X-MC-Unique: J1TXwZSZOJe-z-_ZnfL0Lg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2103856F66;
        Fri,  4 Aug 2023 18:26:46 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2276C5796B;
        Fri,  4 Aug 2023 18:26:46 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Ritesh Harjani <ritesh.list@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: drop dio overwrite only flag and associated warning
Date:   Fri,  4 Aug 2023 14:29:52 -0400
Message-ID: <20230804182952.477247-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
because there are scenarios where -EAGAIN is expected from the
storage layer without necessarily having IOCB_NOWAIT set on the
iocb. For example, io_uring can set IOCB_HIPRI, which the iomap/dio
layer turns into REQ_POLLED|REQ_NOWAIT on the bio, which then can
result in an -EAGAIN result if the block layer is unable to allocate
a request, etc. syzbot has also reported an instance of this warning
and while the source of the -EAGAIN in that case is not currently
known, it is confirmed that the iomap dio overwrite flag is also not
set.

Since this flag is precautionary, avoid the false positive warning
and future whack-a-mole games with -EAGAIN returns by removing it
and the associated warning. Update the comments to document when
concurrent unaligned dio writes are allowed and why the associated
flag is not used.

Reported-by: syzbot+5050ad0fb47527b1808a@syzkaller.appspotmail.com
Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

This addresses some false positives associated with the warning for the
recently merged patch. I considered leaving the flag and more tightly
associating the warning to it (instead of IOCB_NOWAIT), but ISTM that is
still flakey and I'd rather not play whack-a-mole when the assumption is
shown to be wrong.

I'm still waiting on a syzbot test of this patch, but local tests look
Ok and I'm away for a few days after today so wanted to get this on the
list. Thoughts, reviews, flames appreciated.

Brian

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

