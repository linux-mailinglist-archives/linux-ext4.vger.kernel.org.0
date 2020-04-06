Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940B81A01AD
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 01:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDFX1a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 19:27:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11157 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFX13 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 19:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586215650; x=1617751650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLufMfBuafTsOsgZRWCOzz1hnQIhXhPktfVVzf122Gs=;
  b=XbqukBCtBgKCRd3XbGQ+j5Wx+/ZezNN9K+O/PhRSWkwSucJednbjCBCZ
   lJs2hghyz5eVGtpzpp2ipmKPf4HNBc2xw6aXr3yL1gBRZEv2s+H+GDsG4
   9FqtUa5ynQh919DFXWyE9hluIl5PnLySw305EwINZq5BYbYc4A0WPznXa
   ZseTl+qHoUBjV9Tw0Ue2XpjLrRJKHYDkk2CuDwNbLBfOWnsJLvEtnAoQQ
   +uGTo5/meS1wTk9lIAH6cYGICjfPOX6Fn9xbsbp4AFSW83oiSqCfUWHLC
   2wRnuJT7xpUk4bpTssO/ML5h6ku6fdcUrgQuuTHaai+77tg+jcFM/wbMc
   A==;
IronPort-SDR: puGp2KKxxG4wDY7Vbk4EbH5bYj1YxcIv5XqeMKLw1lhUM7nzD3XYUn/y6TyNvmIBqu5Xpbvdbs
 rkv9ZU/i8XjjNC1JnkzAuVBDFJ54jSygBC4QfnqBZslpuE2NTRGBIra8A6Kfm7IFwQkrXAxLI/
 XYw7OpgcRwD4Yr0f0YEk2EvUeLMJlZ91pSCH6kJm7UB7VMwPOTggRB82ed7ls0wfpAY9Vfpmcr
 YS/QEuzZ9L0NqeEt6R67TsVR6pEO9WRSJTMRB+x88qmY/pjixZkazmcQZQzlkl7m0RbjPDYc9p
 e/s=
X-IronPort-AV: E=Sophos;i="5.72,352,1580745600"; 
   d="scan'208";a="136175346"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2020 07:27:29 +0800
IronPort-SDR: wgTJBWPCX5mI58pY+M1IsOpsvYqdR3uNVyJavdM2vyrY4MyHS2eYzuWzEIiQq5R8Wa0chZ8Grb
 dxTLyFsBPLEoIACZq6jQhw4rfmyUCr2HZ02bFg3hRZqnPdKWB3RcVYeg0Vl2vQIDnrVHI+Uozr
 e2m1tk+l9+JwO62q2Ek/PDNorrAl7cwpZ12EoEND/Dms4G+kkeX8xcz0pwhLjuI4QvPlfCGaja
 t1h5aLrLIYLoiByX/J8ysr5WJrtJnZgIpPIMrBk1TrvSYt+wTkdrNio198k+ivhdfw6tHBKe9H
 LYJJovRFp1bbXeTCUTS46XUQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 16:18:12 -0700
IronPort-SDR: T7sb2phKrFU5qlHwGa7UaVpnHTZmyMY+FEnb505WU4w3Ny22yi2dgoDJTFu6VnRIgTt8UekJt0
 CkrMSkMRVVaYYdKk2fXwtMMD6JBcMP0ffXneA+Rtb/NDqrnOzbx4mmTfHILWSm9kEwhqvWkrK1
 ERGB3PSo9ozxrdOqXvve2Y37DzZaRAufCZIEIiY9lcnvXuIMWSUnl6EKH7ygn2BQuaPDkvVgGr
 iXesfi6wJ+TIW9j/ib0DGLvAfjANtQ/X74UwFVe5YZkitfLK36I8xTlcPEBUviF4BERrICLYr9
 Gxo=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Apr 2020 16:27:29 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     hch@lst.de, martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        ktkhai@virtuozzo.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH V2 2/4] block: Add support for REQ_OP_ALLOCATE
Date:   Mon,  6 Apr 2020 15:21:46 -0700
Message-Id: <20200406222148.28365-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
References: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

This operation allows to notify a device about the fact, that some
sectors range was chosen by a filesystem as a single extent, and
the device should try its best to reflect that (keep the range as a
single hunk in its internals, or represent the range as minimal set of
hunks). Speaking directly, the operation is for forwarding fallocate(0)
requests into an essence, on which the device is based.

This may be useful for some distributed network filesystems, providing
block device interface, for optimization of their blocks placement over
the cluster nodes.

Also, block devices mapping a file (like loop) are users of that, since
this allows to allocate more continuous extents and since this batches
blocks allocation requests. In addition, hypervisors like QEMU may use
this for better blocks placement.

This patch adds a new blkdev_issue_allocate() primitive, which is
rather similar to existing blkdev_issue_{*} api. Also, a new queue
limit.max_allocate_sectors is added.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-core.c          |  5 +++
 block/blk-lib.c           | 64 +++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         | 21 +++++++++++++
 block/blk-settings.c      | 19 ++++++++++++
 block/blk-zoned.c         |  1 +
 block/bounce.c            |  1 +
 include/linux/bio.h       |  9 ++++--
 include/linux/blk_types.h |  2 ++
 include/linux/blkdev.h    | 55 +++++++++++++++++++++++++--------
 9 files changed, 162 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7e4a1da0715e..3c22197728a4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -137,6 +137,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_FINISH),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(ALLOCATE),
 	REQ_OP_NAME(SCSI_IN),
 	REQ_OP_NAME(SCSI_OUT),
 	REQ_OP_NAME(DRV_IN),
@@ -958,6 +959,10 @@ generic_make_request_checks(struct bio *bio)
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_ALLOCATE:
+		if (!q->limits.max_allocate_sectors)
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 8e53e393703c..d16c09c19010 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -414,3 +414,67 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
+
+static int __blkdev_issue_allocate(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop)
+{
+	unsigned int max_allocate_sectors;
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!q)
+		return -ENXIO;
+
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	max_allocate_sectors = bdev_allocate_sectors(bdev);
+
+	if (max_allocate_sectors == 0)
+		return -EOPNOTSUPP;
+
+	__blkdev_issue_payloadless(bdev, REQ_OP_ALLOCATE, sector, nr_sects,
+			gfp_mask, biop, 0, max_allocate_sectors);
+	return 0;
+}
+
+/**
+ * __blkdev_issue_allocate - generate number of allocate bios
+ * @bdev:	blockdev to issue
+ * @sector:	start sector
+ * @nr_sects:	number of sectors to write
+ * @gfp_mask:	memory allocation flags (for bio_alloc)
+ * @biop:	pointer to anchor bio
+ *
+ * Description:
+ *  Assign a block range for batched allocation requests. Useful in stacking
+ *  block device on the top of the file system.
+ *
+ */
+int blkdev_issue_allocate(struct block_device *bdev, sector_t sector,
+			sector_t nr_sects, gfp_t gfp_mask)
+{
+	int ret = 0;
+	sector_t bs_mask;
+	struct blk_plug plug;
+	struct bio *bio = NULL;
+
+	if (bdev_allocate_sectors(bdev) == 0)
+		return 0;
+
+	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+
+	blk_start_plug(&plug);
+	ret = __blkdev_issue_allocate(bdev, sector, nr_sects,
+					  gfp_mask, &bio);
+	if (ret == 0 && bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_allocate);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1534ed736363..4ed5f103a18d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -116,6 +116,22 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *blk_bio_allocate_split(struct request_queue *q,
+					      struct bio *bio,
+					      struct bio_set *bs,
+					      unsigned *nsegs)
+{
+	*nsegs = 0;
+
+	if (!q->limits.max_allocate_sectors)
+		return NULL;
+
+	if (bio_sectors(bio) <= q->limits.max_allocate_sectors)
+		return NULL;
+
+	return bio_split(bio, q->limits.max_allocate_sectors, GFP_NOIO, bs);
+}
+
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio *bio,
 					    struct bio_set *bs,
@@ -308,6 +324,10 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
 				nr_segs);
 		break;
+	case REQ_OP_ALLOCATE:
+		split = blk_bio_allocate_split(q, *bio, &q->bio_split,
+				nr_segs);
+		break;
 	case REQ_OP_WRITE_SAME:
 		split = blk_bio_write_same_split(q, *bio, &q->bio_split,
 				nr_segs);
@@ -386,6 +406,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ALLOCATE:
 		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 14397b4c4b53..3f8f55e27b9a 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
 	lim->max_write_zeroes_sectors = 0;
+	lim->max_allocate_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
 	lim->discard_granularity = 0;
@@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_same_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_allocate_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -221,6 +223,21 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
+/**
+ * blk_queue_max_allocate_sectors - set max sectors for a single
+ *                                      allocate
+ *
+ * @q:  the request queue for the device
+ * @max_allocate_sectors: maximum number of sectors to allocate per
+ *                            command
+ **/
+void blk_queue_max_allocate_sectors(struct request_queue *q,
+		unsigned int max_allocate_sectors)
+{
+	q->limits.max_allocate_sectors = max_allocate_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_allocate_sectors);
+
 /**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
@@ -470,6 +487,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_same_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_allocate_sectors = min(t->max_allocate_sectors,
+				    b->max_allocate_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f87956e0dcaf..348eef082bc7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -73,6 +73,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 
 	switch (req_op(rq)) {
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ALLOCATE:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE:
 		return blk_rq_zone_is_seq(rq);
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..112349dfc235 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -257,6 +257,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ALLOCATE:
 		break;
 	case REQ_OP_WRITE_SAME:
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c1c0f9ea4e63..09daf514fd23 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -64,7 +64,8 @@ static inline bool bio_has_data(struct bio *bio)
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
+	    bio_op(bio) != REQ_OP_ALLOCATE)
 		return true;
 
 	return false;
@@ -75,7 +76,8 @@ static inline bool bio_no_advance_iter(struct bio *bio)
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
 	       bio_op(bio) == REQ_OP_WRITE_SAME ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
+	       bio_op(bio) == REQ_OP_ALLOCATE;
 }
 
 static inline bool bio_mergeable(struct bio *bio)
@@ -178,7 +180,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	struct bvec_iter iter;
 
 	/*
-	 * We special case discard/write same/write zeroes, because they
+	 * We special case discard/write same/write zeroes/allocate, because
 	 * interpret bi_size differently:
 	 */
 
@@ -186,6 +188,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ALLOCATE:
 		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..ef8268c37f93 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -296,6 +296,8 @@ enum req_opf {
 	REQ_OP_ZONE_CLOSE	= 11,
 	/* Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= 12,
+	/* Allocate a sector range */
+	REQ_OP_ALLOCATE	= 15,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e..6b85973bf2ff 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_allocate_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -747,6 +748,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
 		return false;
 
+	if (req_op(rq) == REQ_OP_ALLOCATE)
+		return false;
+
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
 	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
@@ -1004,6 +1008,10 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
+	if (unlikely(op == REQ_OP_ALLOCATE))
+		return min(q->limits.max_allocate_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
+
 	return q->limits.max_sectors;
 }
 
@@ -1080,6 +1088,8 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_allocate_sectors(struct request_queue *q,
+		unsigned int max_allocate_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
@@ -1227,25 +1237,36 @@ extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
 
+#define SECT_FROM_SB_BLK(sb, blk) ((blk) << ((sb)->s_blocksize_bits - 9))
+#define NSECTS_FROM_SB_NBLK(sb, nblk) ((nblk) << ((sb)->s_blocksize_bits - 9))
+
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
 {
-	return blkdev_issue_discard(sb->s_bdev,
-				    block << (sb->s_blocksize_bits -
-					      SECTOR_SHIFT),
-				    nr_blocks << (sb->s_blocksize_bits -
-						  SECTOR_SHIFT),
-				    gfp_mask, flags);
+	sector_t sect = SECT_FROM_SB_BLK(sb, block);
+	sector_t nsects = NSECTS_FROM_SB_NBLK(sb, nr_blocks);
+
+	return blkdev_issue_discard(sb->s_bdev, sect, nsects, gfp_mask, flags);
 }
 static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask)
 {
-	return blkdev_issue_zeroout(sb->s_bdev,
-				    block << (sb->s_blocksize_bits -
-					      SECTOR_SHIFT),
-				    nr_blocks << (sb->s_blocksize_bits -
-						  SECTOR_SHIFT),
-				    gfp_mask, 0);
+	sector_t sect = SECT_FROM_SB_BLK(sb, block);
+	sector_t nsects = NSECTS_FROM_SB_NBLK(sb, nr_blocks);
+
+	return blkdev_issue_zeroout(sb->s_bdev, sect, nsects, gfp_mask, 0);
+}
+
+extern int blkdev_issue_allocate(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
+
+static inline int sb_issue_allocate(struct super_block *sb, sector_t block,
+		sector_t nr_blocks, gfp_t gfp_mask)
+{
+	sector_t sect = SECT_FROM_SB_BLK(sb, block);
+	sector_t nsects = NSECTS_FROM_SB_NBLK(sb, nr_blocks);
+
+	return blkdev_issue_allocate(sb->s_bdev, sect, nsects, gfp_mask);
 }
 
 extern int blk_verify_command(unsigned char *cmd, fmode_t mode);
@@ -1429,6 +1450,16 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_allocate_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return q->limits.max_allocate_sectors;
+
+	return 0;
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.22.0

