Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D4F22CDFF
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGXSpM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jul 2020 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgGXSpL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jul 2020 14:45:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB3C0619E4
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 11:45:11 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id w2so6949751pfn.0
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 11:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=;
        b=cLH6fzkpbrIyelFo1byJfRWbdqDhF3ZuMGCQS4DuqoFfUVEI6AqUb/cLmCcnxe2DB/
         NuclTLQUseIGENpT7nSaTyqpx9/aizcWbC3NKqN5eALGkn02PLzSafBJR0zP+YtgRdjx
         iiqFAGrcWbXnR1oSAceanlMou1uN1NcKZaHO7V6Fq14CfHQBbuPffCJrhM+PHcdgXacy
         ZTIPrXi3DslzIjo4fnTej7bdyl7kq0p1qIzcLMEMzdaXiKnZj5yIvjZYQny4aGeAndIA
         PQZfy+PrHHJBs5Hj0M8Ccv3m4ELMXmcv4DxI8RLO/We8K9PWuYUCvp83BPAYwnWrSsLM
         6aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cZRHJd9vm6wSJv/XnptuJQLr+rxaeXJfolkFtRJQLFQ=;
        b=N+hKD9/Xdm5OjJo2HLe24ivtVbEeH4tskRAqXi/x66nLMvwQwb4VqnBx/LZ5N0doY4
         61teDO0n0KjuLgyZP28ffWc/3GWEF00pKrLxamQVhYXYPtY0eS97uWvcYlfhGOx2OgHv
         RM2SWsj5ze4rGYVZ5OThJAWyVmvYsoJsbfIR+gVey/H8x3isZtAaJRcI8mUJipVKmEdA
         HM905uyRifNsVBoVs3bSYTRfFvEcWj9qUFKQNAyG1j3zxMB9gyvy0havmPmLL4lYfoYg
         QdKFa9+L0hfJICZVvqf275Q4MRBvJ1u6zq50XjyKpKi3XcnpB3dZfRaFCo5Izv1N37la
         byhA==
X-Gm-Message-State: AOAM532BaOr029ueHXLRp3jZ/M/qVQ0lePQbtgmLp+6Su7IffUcQR8BV
        /PV5Oxi+HaRTxgvuGT6BMS/SNUPj0KM=
X-Google-Smtp-Source: ABdhPJw8fcIvmjHR7H+eb8aZqwFTcCm45Bq/Yx+3nVsrxPL6bXnXqOMUT4Dox/jUn8rhKVdlkFqNAmoD0JI=
X-Received: by 2002:a62:1acc:: with SMTP id a195mr9957629pfa.32.1595616311087;
 Fri, 24 Jul 2020 11:45:11 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:57 +0000
In-Reply-To: <20200724184501.1651378-1-satyat@google.com>
Message-Id: <20200724184501.1651378-4-satyat@google.com>
Mime-Version: 1.0
References: <20200724184501.1651378-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v6 3/7] iomap: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
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
index ec7b78e6feca..a8785bffdc7c 100644
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
@@ -183,11 +184,14 @@ static void
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
@@ -270,6 +274,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
-- 
2.28.0.rc0.142.g3c755180ce-goog

