Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA05223070
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 03:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGQBfh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jul 2020 21:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGQBfb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jul 2020 21:35:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D585C08C5DB
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jul 2020 18:35:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p4so5574817pls.16
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jul 2020 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+UBFxrt4pNJbQqfKhET/4plBmEv6gpLPjB+6J7RRg5k=;
        b=S9hUMdztXXvOY4ssFaJ9x50x8aFoXJPR1Ord6CgvNBpR6vnJ1HcxEp+eSdaGY2wu49
         f3fn0Te4kWifwbc6OZ2yWU1j5vyM+/dIh9NQBMQelj7AihRRtRxZWdcI+Qm/qQb+JSZ1
         4vatdj6y/6H9IPDw31RFvJBnXZAEWZbrTIeQ4n+CYYf5Ls9iTkaDeHulKw5UxKN3y0t7
         zfn3cXRsUyUuNwYuMX4HUH1SILLzTcAjK5hnXBz6/fju1dXdZTfC0wUHMfBLejmNNWiV
         2zSjQ0QinEPAhWayJplF9JFzkA1NeMZT/PHLH5AVbbg/wAeJA+k9Fp7jqWMsVvb0ahs1
         nmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+UBFxrt4pNJbQqfKhET/4plBmEv6gpLPjB+6J7RRg5k=;
        b=Y5Tr/ayyQmPFlgle5c8T/+XNS/LJqv0t9qAjBLtbRMQHNWIH2xd3AUdHAaqv8u4Zwc
         yu56yIhEWHOF8vhWXC7yx21cwM3KDWd7c18mSjgn+e7rRnF4Di8gg9S8u3/ZlgESKR77
         9EYxopcizZq4kOHlOctEC7rjtNpmzIrDeVYCR1Fd5Xh0ieuyIjnR5v7RuSnBn2MbntUM
         bSIEuOXXRE57lsuHa1cpElIMtElE4tjCNYSJn9fNNp2DwoLcYetvyuyXXA/yXC1vYxCU
         dEhHYvlwAVoxo9dWPwJcovvA8OZJrw1OFW31RexKv0FgCBVkBBfz8+gwVitlnO0zjiG6
         H1QA==
X-Gm-Message-State: AOAM532jNwO2f0d1cjp9L1Si7okugpB8dIJU6l48yjtjUbaHzyUZIwZf
        WAPTYENn6QESn8Q5X6yiXZhQKG/Wkbg=
X-Google-Smtp-Source: ABdhPJyUKbNKbPD52mHlMT2ZSrU8LempwbQ8BXLBZXihRGAVepOXrVcw0EfQ5Li0VQYXBx83T3iUPhq+8QI=
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr2171526pjz.1.1594949730708;
 Thu, 16 Jul 2020 18:35:30 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:35:14 +0000
In-Reply-To: <20200717013518.59219-1-satyat@google.com>
Message-Id: <20200717013518.59219-4-satyat@google.com>
Mime-Version: 1.0
References: <20200717013518.59219-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2 3/7] iomap: support direct I/O with fscrypt using blk-crypto
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

Wire up iomap direct I/O with the fscrypt additions for direct I/O,
and set bio crypt contexts on bios when appropriate.

Make iomap_dio_bio_actor() call fscrypt_limit_io_pages() to ensure that
DUNs remain contiguous within a bio, since it works directly with logical
ranges and can't call fscrypt_mergeable_bio() on each page.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/iomap/direct-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ec7b78e6feca..4507dc16dbe5 100644
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
@@ -253,6 +257,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		ret = nr_pages;
 		goto out;
 	}
+	nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
 
 	if (need_zeroout) {
 		/* zero out from the start of the block to the write offset */
@@ -270,6 +275,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
+					  GFP_KERNEL);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
@@ -307,6 +314,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+		nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
-- 
2.28.0.rc0.105.gf9edc3c819-goog

