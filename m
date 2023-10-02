Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13947B5A91
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Oct 2023 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238764AbjJBSux (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Oct 2023 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJBSux (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Oct 2023 14:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EBD9B
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696272604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e3+4+tH9WCFrmcg+whaIAx9wiaXR2zBfEd/i2+cegpQ=;
        b=C1tugUHfesQ3qyFoJ1alhhVXqvwg6Dl8da4Yv/ZmRLP8i4Fzzo/LDq8nDJnOzSLXmyNkw1
        AObuHQiep6edGmPfX7OuLe3KDhlBOgbXNtw8aGaw+o88OrbeHH/HkS7+A6mHPciww5GmuQ
        AR+dNCwY4gFK+Iv7aRQBWE7ojMlBcHc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-RVsoGqeHNTeI8L5aLmEDww-1; Mon, 02 Oct 2023 14:50:02 -0400
X-MC-Unique: RVsoGqeHNTeI8L5aLmEDww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2D1F811E97
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 18:50:02 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 865F82026D4B
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 18:50:02 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: fix racy may inline data check in dio write
Date:   Mon,  2 Oct 2023 14:50:20 -0400
Message-ID: <20231002185020.531537-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot reports that the following warning from ext4_iomap_begin()
triggers as of the commit referenced below:

        if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
                return -ERANGE;

This occurs during a dio write, which is never expected to encounter
an inode with inline data. To enforce this behavior,
ext4_dio_write_iter() checks the current inline state of the inode
and clears the MAY_INLINE_DATA state flag to either fall back to
buffered writes, or enforce that any other writers in progress on
the inode are not allowed to create inline data.

The problem is that the check for existing inline data and the state
flag can span a lock cycle. For example, if the ilock is originally
locked shared and subsequently upgraded to exclusive, another writer
may have reacquired the lock and created inline data before the dio
write task acquires the lock and proceeds.

The commit referenced below loosens the lock requirements to allow
some forms of unaligned dio writes to occur under shared lock, but
AFAICT the inline data check was technically already racy for any
dio write that would have involved a lock cycle. Regardless, lift
clearing of the state bit to the same lock critical section that
checks for preexisting inline data on the inode to close the race.

Reported-by: syzbot+307da6ca5cb0d01d581a@syzkaller.appspotmail.com
Fixes: 310ee0902b8d ("ext4: allow concurrent unaligned dio overwrites")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

Obviously there's a few different ways to address this, but this seemed
most straightforward to me. Another option could be to push more of this
checking down into _write_checks() to retry the should_use_dio() bits
after a lock cycle, for example. Let me know if anybody has other
thoughts.

Otherwise, this addresses the syzbot report [1] (see the couple of debug
patch test runs) and survives an fstests regression run. Thanks.

Brian

[1] https://lore.kernel.org/linux-ext4/0000000000005697bd05fe4aea49@google.com/

 fs/ext4/file.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6830ea3a6c59..747c0378122d 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -569,18 +569,20 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ext4_buffered_write_iter(iocb, from);
 	}
 
+	/*
+	 * Prevent inline data from being created since we are going to allocate
+	 * blocks for DIO. We know the inode does not currently have inline data
+	 * because ext4_should_use_dio() checked for it, but we have to clear
+	 * the state flag before the write checks because a lock cycle could
+	 * introduce races with other writers.
+	 */
+	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+
 	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend,
 				    &unwritten, &dio_flags);
 	if (ret <= 0)
 		return ret;
 
-	/*
-	 * Make sure inline data cannot be created anymore since we are going
-	 * to allocate blocks for DIO. We know the inode does not have any
-	 * inline data now because ext4_dio_supported() checked for that.
-	 */
-	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
-
 	offset = iocb->ki_pos;
 	count = ret;
 
-- 
2.41.0

