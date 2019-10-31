Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09EDEAC7B
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 10:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfJaJUp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 05:20:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfJaJUp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 31 Oct 2019 05:20:45 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1AFA291DC1FC5E986338;
        Thu, 31 Oct 2019 17:20:42 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 17:20:31 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] ext4: bio_alloc with __GFP_DIRECT_RECLAIM never fails
Date:   Thu, 31 Oct 2019 17:23:15 +0800
Message-ID: <20191031092315.139267-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030161244.GB3953@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191030161244.GB3953@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Similar to [1] [2], bio_alloc with __GFP_DIRECT_RECLAIM flags
guarantees bio allocation under some given restrictions, as
stated in block/bio.c and fs/direct-io.c So here it's ok to
not check for NULL value from bio_alloc().

[1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
[2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

changes since v1:
 - fix commit message and simplify logic as suggested by Ritesh;
 - add short messages ahead of bio_alloc suggested by Ted.

 fs/ext4/page-io.c  | 57 ++++++++++++++++++----------------------------
 fs/ext4/readpage.c |  6 +++--
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 12ceadef32c5..c92504c1b1ca 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -358,14 +358,16 @@ void ext4_io_submit_init(struct ext4_io_submit *io,
 	io->io_end = NULL;
 }
 
-static int io_submit_init_bio(struct ext4_io_submit *io,
-			      struct buffer_head *bh)
+static void io_submit_init_bio(struct ext4_io_submit *io,
+			       struct buffer_head *bh)
 {
 	struct bio *bio;
 
+	/*
+	 * bio_alloc will _always_ be able to allocate a bio if
+	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
+	 */
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
-	if (!bio)
-		return -ENOMEM;
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
@@ -373,13 +375,12 @@ static int io_submit_init_bio(struct ext4_io_submit *io,
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
 	wbc_init_bio(io->io_wbc, bio);
-	return 0;
 }
 
-static int io_submit_add_bh(struct ext4_io_submit *io,
-			    struct inode *inode,
-			    struct page *page,
-			    struct buffer_head *bh)
+static void io_submit_add_bh(struct ext4_io_submit *io,
+			     struct inode *inode,
+			     struct page *page,
+			     struct buffer_head *bh)
 {
 	int ret;
 
@@ -388,9 +389,7 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
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
@@ -398,7 +397,6 @@ static int io_submit_add_bh(struct ext4_io_submit *io,
 		goto submit_and_retry;
 	wbc_account_cgroup_owner(io->io_wbc, page, bh->b_size);
 	io->io_next_block++;
-	return 0;
 }
 
 int ext4_bio_write_page(struct ext4_io_submit *io,
@@ -491,8 +489,14 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 				gfp_flags |= __GFP_NOFAIL;
 				goto retry_encrypt;
 			}
-			bounce_page = NULL;
-			goto out;
+
+			printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
+			redirty_page_for_writepage(wbc, page);
+			do {
+				clear_buffer_async_write(bh);
+				bh = bh->b_this_page;
+			} while (bh != head);
+			goto unlock;
 		}
 	}
 
@@ -500,30 +504,13 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 	do {
 		if (!buffer_async_write(bh))
 			continue;
-		ret = io_submit_add_bh(io, inode, bounce_page ?: page, bh);
-		if (ret) {
-			/*
-			 * We only get here on ENOMEM.  Not much else
-			 * we can do but mark the page as dirty, and
-			 * better luck next time.
-			 */
-			break;
-		}
+		io_submit_add_bh(io, inode,
+				 bounce_page ? bounce_page : page, bh);
 		nr_submitted++;
 		clear_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 
-	/* Error stopped previous loop? Clean up buffers... */
-	if (ret) {
-	out:
-		fscrypt_free_bounce_page(bounce_page);
-		printk_ratelimited(KERN_ERR "%s: ret = %d\n", __func__, ret);
-		redirty_page_for_writepage(wbc, page);
-		do {
-			clear_buffer_async_write(bh);
-			bh = bh->b_this_page;
-		} while (bh != head);
-	}
+unlock:
 	unlock_page(page);
 	/* Nothing submitted - we have to end page writeback */
 	if (!nr_submitted)
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index a30b203fa461..fef7755300c3 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -360,10 +360,12 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		if (bio == NULL) {
 			struct bio_post_read_ctx *ctx;
 
+			/*
+			 * bio_alloc will _always_ be able to allocate a bio if
+			 * __GFP_DIRECT_RECLAIM is set, see bio_alloc_bioset().
+			 */
 			bio = bio_alloc(GFP_KERNEL,
 				min_t(int, nr_pages, BIO_MAX_PAGES));
-			if (!bio)
-				goto set_error_page;
 			ctx = get_bio_post_read_ctx(inode, bio, page->index);
 			if (IS_ERR(ctx)) {
 				bio_put(bio);
-- 
2.17.1

