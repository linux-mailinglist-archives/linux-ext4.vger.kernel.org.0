Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F339C1E9
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jun 2021 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhFDVLK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Jun 2021 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhFDVLI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Jun 2021 17:11:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFEC061789
        for <linux-ext4@vger.kernel.org>; Fri,  4 Jun 2021 14:09:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p2-20020a2599820000b02905394c6727easo13382578ybo.13
        for <linux-ext4@vger.kernel.org>; Fri, 04 Jun 2021 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RT0RrB/jxKMI6YW+PFYA3ymIrlH2UsJVKGU6y0kBnOw=;
        b=IlZOZ7kDYPui8ADSyBSgg53Xoy729/anXoL9HE6GnxaUrhX/OSd1UbLB0u1F+7d9Td
         JVxj6n9wuW+E0OZ7vDRXrTfbCD6XuwNVY9v22kKfJVNYb9WY404LeKW4yQ2tpPmzigpm
         V+j0KbaKVIPgWl/XtyfWFGvYkgLJlkemDaCQc25sAFQeYkHSg34+XxpgajWSGIfj4/be
         V52CdBnBn4uGgdqBlgjFpwgA4zIXigOLYYLcck1Ox7vAMAb0YTWh94/lpF9I2Q7F7RI/
         gPD6HaFeiyqVyFUYSb1DYREYy6u9CegrBeWpsXNHM9mK3f2L+mshA5baEf6Ew6vzjwfA
         VpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RT0RrB/jxKMI6YW+PFYA3ymIrlH2UsJVKGU6y0kBnOw=;
        b=MZ1pU8r2tfUCXMACz+86qHkoF+UoyHBlWoXb0Swg9adZNQsY/0PmL4AF4psDZfnDID
         vuHfm8k6uOop/n/sJOxAEX8c7K16uvJjWrcUhz0pPEVCAeY3iH5/n/L7meXs8xRicyKU
         U+oKWkxq3Up6Fdhe2R+J/5JdPpIokYf9We/n4dUmu8MsuU6SOTCGa1dDfF/XPTQwfMzh
         INz4u76wx6rpWUTIGVSjljYCzse/0pwrtViqkCyUptS6K6E0OrQsSAIoaV3kiBrgmFgr
         mXsCHoU62Buqv9zrjrPHf+5GXaTyqwEb6H+YNC5CYcofHy93LYwi8dUyGRqfUOfKk5xy
         KXPg==
X-Gm-Message-State: AOAM533iTZ1So855OKZtO7kpT6h5NJ33Wlo86+VDPpAznGKnovQwvwnl
        FrFwmfNvIiEeonru6MMKWN6BwxLglSE=
X-Google-Smtp-Source: ABdhPJzJE4zslyGfGvcDlz07boMQ5nRjs8yyzCWvA2MMz8AlycCO4TqXJ8BnIMpWw/eg+X7rMUBks6idOm4=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a25:8185:: with SMTP id p5mr7728654ybk.54.1622840961400;
 Fri, 04 Jun 2021 14:09:21 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:05 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-7-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 6/9] iomap: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Set bio crypt contexts on bios by calling into fscrypt when required.
No DUN contiguity checks are done - callers are expected to set up the
iomap correctly to ensure that each bio submitted by iomap will not have
blocks with incontiguous DUNs by calling fscrypt_limit_io_blocks()
appropriately.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..1c825deb36a9 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/iomap.h>
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
@@ -185,11 +186,14 @@ static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
+	struct inode *inode = file_inode(dio->iocb->ki_filp);
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
+	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 	bio->bi_private = dio;
@@ -306,6 +310,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
-- 
2.32.0.rc1.229.g3e70b5a671-goog

