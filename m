Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177AA18348A
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCLPUK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLPUK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NCEQUCe5Wa5475Lcg+ytHNQKS9TDeVw+NOmgA1JsCFU=; b=Jx1EWhGuI7KktdiPJYp631snYG
        bdVd/9SMaDIRvt8B/HtB+ytTHWUnnKJCr0mK1uZyl6k3z5nl2TZjTHiTinZBnvacBMz1/Vtdj5GtE
        rnXATkxUEUsGtGD4Ag8QXEIbn0cC32B/STTpI2+FfkrEq/HIdinxcmjI8v02KLQ3pmIvsnC2Rph05
        Tp/JGwoGFAWDamMzyqpHXUF8fA+pnMigv3uGnBG56luc1pTnr4RD2o/cCzXx64Y5S7WQgWz+27T1Q
        7buFmzvEm6KMWv9F/KAPkCK1YcHKUmWdeTPwavapVtLcyZjU6WlydF2+MNH4CHjmpawAa4vvspxLY
        h+ZTri7Q==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPd3-0007Ul-AD; Thu, 12 Mar 2020 15:20:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 09/21] block: unexport read_dev_sector and put_dev_sector
Date:   Thu, 12 Mar 2020 16:19:27 +0100
Message-Id: <20200312151939.645254-10-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312151939.645254-1-hch@lst.de>
References: <20200312151939.645254-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

read_dev_sector and put_dev_sector are now only used by the partition
parsing code.  Remove the export for read_dev_sector and merge it into
the only caller.  Clean the mess up a bit by using goto labels and
the SECTOR_SHIFT constant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partition-generic.c | 31 +++++++++++++++++++------------
 block/partitions/check.h  | 14 +++++++-------
 include/linux/blkdev.h    |  9 ---------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index a36ace0e2161..abab0109b69c 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -484,22 +484,29 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	return ret;
 }
 
-unsigned char *read_dev_sector(struct block_device *bdev, sector_t n, Sector *p)
+void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
 {
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	struct address_space *mapping = state->bdev->bd_inode->i_mapping;
 	struct page *page;
 
-	page = read_mapping_page(mapping, (pgoff_t)(n >> (PAGE_SHIFT-9)), NULL);
-	if (!IS_ERR(page)) {
-		if (PageError(page))
-			goto fail;
-		p->v = page;
-		return (unsigned char *)page_address(page) +  ((n & ((1 << PAGE_SECTORS_SHIFT) - 1)) << 9);
-fail:
-		put_page(page);
+	if (n >= get_capacity(state->bdev->bd_disk)) {
+		state->access_beyond_eod = true;
+		return NULL;
 	}
+
+	page = read_mapping_page(mapping,
+			(pgoff_t)(n >> PAGE_SECTORS_SHIFT), NULL);
+	if (IS_ERR(page))
+		goto out;
+	if (PageError(page))
+		goto out_put_page;
+
+	p->v = page;
+	return (unsigned char *)page_address(page) +
+			((n & ((1 << PAGE_SECTORS_SHIFT) - 1)) << SECTOR_SHIFT);
+out_put_page:
+	put_page(page);
+out:
 	p->v = NULL;
 	return NULL;
 }
-
-EXPORT_SYMBOL(read_dev_sector);
diff --git a/block/partitions/check.h b/block/partitions/check.h
index 6042f769471a..0fcf80117887 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -28,14 +28,14 @@ void free_partitions(struct parsed_partitions *state);
 struct parsed_partitions *
 check_partition(struct gendisk *, struct block_device *);
 
-static inline void *read_part_sector(struct parsed_partitions *state,
-				     sector_t n, Sector *p)
+typedef struct {
+	struct page *v;
+} Sector;
+
+void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p);
+static inline void put_dev_sector(Sector p)
 {
-	if (n >= get_capacity(state->bdev->bd_disk)) {
-		state->access_beyond_eod = true;
-		return NULL;
-	}
-	return read_dev_sector(state->bdev, n, p);
+	put_page(p.v);
 }
 
 static inline void
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8c2fe58db4fa..7852cf72edbf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1488,15 +1488,6 @@ static inline unsigned int block_size(struct block_device *bdev)
 	return bdev->bd_block_size;
 }
 
-typedef struct {struct page *v;} Sector;
-
-unsigned char *read_dev_sector(struct block_device *, sector_t, Sector *);
-
-static inline void put_dev_sector(Sector p)
-{
-	put_page(p.v);
-}
-
 int kblockd_schedule_work(struct work_struct *work);
 int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
-- 
2.24.1

