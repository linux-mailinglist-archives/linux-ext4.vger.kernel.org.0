Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3541E95B6
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Oct 2019 05:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3EXm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 00:23:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbfJ3EXl (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Oct 2019 00:23:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 92F56914FB7379F9428A;
        Wed, 30 Oct 2019 12:23:39 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 12:23:32 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] ext4: bio_alloc never fails
Date:   Wed, 30 Oct 2019 12:26:18 +0800
Message-ID: <20191030042618.124220-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Similar to [1] [2], it seems a trivial cleanup since
bio_alloc can handle memory allocation as mentioned in
fs/direct-io.c (also see fs/block_dev.c, fs/buffer.c, ..)

[1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
[2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/ext4/page-io.c  | 11 +++--------
 fs/ext4/readpage.c |  2 --
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 12ceadef32c5..f1f7b6601780 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -358,14 +358,12 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
 	io->io_end = NULL;
 }
 
-static int io_submit_init_bio(struct ext4_io_submit *io,
-			      struct buffer_head *bh)
+static void io_submit_init_bio(struct ext4_io_submit *io,
+			       struct buffer_head *bh)
 {
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
-	if (!bio)
-		return -ENOMEM;
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
@@ -373,7 +371,6 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
 	wbc_init_bio(io->io_wbc, bio);
-	return 0;
 }
 
 static int io_submit_add_bh(struct ext4_io_submit *io,
@@ -388,9 +385,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
 		ext4_io_submit(io);
 	}
 	if (io->io_bio == NULL) {
-		ret = io_submit_init_bio(io, bh);
-		if (ret)
-			return ret;
+		io_submit_init_bio(io, bh);
 		io->io_bio->bi_write_hint = inode->i_write_hint;
 	}
 	ret = bio_add_page(io->io_bio, page, bh->b_size, bh_offset(bh));
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index a30b203fa461..bfeb77b93f48 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -362,8 +362,6 @@ int ext4_mpage_readpages(struct address_space *mapping,
 
 			bio = bio_alloc(GFP_KERNEL,
 				min_t(int, nr_pages, BIO_MAX_PAGES));
-			if (!bio)
-				goto set_error_page;
 			ctx = get_bio_post_read_ctx(inode, bio, page->index);
 			if (IS_ERR(ctx)) {
 				bio_put(bio);
-- 
2.17.1

