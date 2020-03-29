Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA17196F7D
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgC2Swq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Mar 2020 14:52:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50733 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2Swq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Mar 2020 14:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585507966; x=1617043966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+P2NZVNO/kU1vWsbiB7k/zNXL9wUMfnXtcr9uRJTo5E=;
  b=pXkbO4ksC5OKygJAe4ucl3kkbq+FKBya6eOXLqJTsFjVN1o/+zR6/o2h
   qFUUkbUB/1ySEoSeaypGcc1/tPNzUGYt9C5fftTLPlekWqZLr6S3x6jyX
   SkBZ3ix4VmVu/MBiKhGvhhiLd8ZUT5Sn7x34FmFdIlEOcSN1ThEDouB7b
   FhhOS46Q02KUSR2is6+vh8lYi3KHfP0fXnnRoPMRjZVbGL+XT6F75E+/X
   Ki/NflztbgtGrOtKpBXYG+aY/4dw6eHWJunYarlniEw9X1ACwFuM5IKji
   /BTiGM6+0ZbBqa8fmkRYOXX76JDL5rb9tO+TzenYChDhru+9zUTgelH0c
   w==;
IronPort-SDR: PR37Ae6+Aa23M4iI/gfMIgIBqhdvwbD5o39xjEeSquBepf1ZgzIIuR9+VpepK5RPT4onRQXHMO
 Pe32ZzRcLCCYE6sjYlBnF/DjwaORLlPJtCU6hhGgi1tkfrXC3LEpQ/LbB3PGGOgpeZ/hkq1JQ7
 UHVhMW1tWRhtlHedDUvelJPS/N5fusxO7fqlKD1In0x9EYlHbirw8eEzJcRLA/lRrMKH3OosmP
 cB0MufT1wlvWlrQ9NyZq9xaNY8eVo/mdso1dtZ5hzSk5kRHBVRSYCa/nKol/UF7vXih2exSFc5
 YrE=
X-IronPort-AV: E=Sophos;i="5.72,321,1580745600"; 
   d="scan'208";a="133811323"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 02:52:45 +0800
IronPort-SDR: gjX2eR3pgykqNN7HEGkCoulIJ3eJLmOqQieUXYrCjCkIEmSW7M4qBlEVyCRYNQJwyeHqanbYOf
 Bt+xmnCrDz3J5Say5Ir5Dqn8iVPwvlkxsn647bftz0ImUySa+R9hYmq4GUxVSaGNgfvmooFOwN
 R8xbRfRG9ZuEy9BfWHpIWT/Tep3xsrKCrLeqqLnlVq1YitGUjDN0QEyHPAv2njciXAC9Gy1sGr
 ORuRWrQXqAP+ujnmmbeZ3FHNvZc1AA/FhgZUIZZhoR4tTYKdZ7u+ojhtHQW7fqc9pgZ3rOvlIG
 aGNU2ZTjVdNOayCbmb/NHacb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 11:43:43 -0700
IronPort-SDR: 94X9fJhkV/CNsP77ZFq630Rfh623qRiY7o1yHcmtnPjvoap83wVEYAAsFHoEYeu0KJPmfNOKmV
 Hsaxft/jraZSGn+fXPtLFozQYPNqQZnsxG2QdUJSGk8CLCE0mYMzP39drUPQTsROIprNwDpPZo
 1YOjpW9MDNZFRBa1iHPtJ2tjMOlZV32ZA79+uRQx80QVK0LLDKBCgc3GYUGoOQCw1bCHX6LgxU
 b5at9qHaFwW2FW8S4MuGFo1ryzQmqo+q3kPZCCHFswbwfooMt33QjhNBwfMytC3OEJKiyJdwYd
 0U8=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2020 11:52:45 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     hch@lst.de, martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 2/4] block: Add support for REQ_OP_ASSIGN_RANGE
Date:   Sun, 29 Mar 2020 10:47:12 -0700
Message-Id: <20200329174714.32416-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
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

This patch adds a new blkdev_issue_assign_range() primitive, which is
rather similar to existing blkdev_issue_{*} api. Also, a new queue
limit.max_assign_range_sectors is added.

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
 include/linux/blkdev.h    | 34 +++++++++++++++++++++
 9 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 60dc9552ef8d..25165fa8fe46 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -137,6 +137,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_FINISH),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(ASSIGN_RANGE),
 	REQ_OP_NAME(SCSI_IN),
 	REQ_OP_NAME(SCSI_OUT),
 	REQ_OP_NAME(DRV_IN),
@@ -952,6 +953,10 @@ generic_make_request_checks(struct bio *bio)
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_ASSIGN_RANGE:
+		if (!q->limits.max_assign_range_sectors)
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 8e53e393703c..16dc9dbf6c79 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -414,3 +414,67 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
+
+static int __blkdev_issue_assign_range(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop)
+{
+	unsigned int max_assign_range_sectors;
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!q)
+		return -ENXIO;
+
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	max_assign_range_sectors = bdev_assign_range_sectors(bdev);
+
+	if (max_assign_range_sectors == 0)
+		return -EOPNOTSUPP;
+
+	__blkdev_issue_payloadless(bdev, REQ_OP_ASSIGN_RANGE, sector, nr_sects,
+			gfp_mask, biop, 0, max_assign_range_sectors);
+	return 0;
+}
+
+/**
+ * __blkdev_issue_assign_range - generate number of assign range bios
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
+int blkdev_issue_assign_range(struct block_device *bdev, sector_t sector,
+			sector_t nr_sects, gfp_t gfp_mask)
+{
+	int ret = 0;
+	sector_t bs_mask;
+	struct blk_plug plug;
+	struct bio *bio = NULL;
+
+	if (bdev_assign_range_sectors(bdev) == 0)
+		return 0;
+
+	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+
+	blk_start_plug(&plug);
+	ret = __blkdev_issue_assign_range(bdev, sector, nr_sects,
+					  gfp_mask, &bio);
+	if (ret == 0 && bio) {
+		ret = submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_assign_range);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1534ed736363..441d1620de03 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -116,6 +116,22 @@ static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *blk_bio_assign_range_split(struct request_queue *q,
+					      struct bio *bio,
+					      struct bio_set *bs,
+					      unsigned *nsegs)
+{
+	*nsegs = 0;
+
+	if (!q->limits.max_assign_range_sectors)
+		return NULL;
+
+	if (bio_sectors(bio) <= q->limits.max_assign_range_sectors)
+		return NULL;
+
+	return bio_split(bio, q->limits.max_assign_range_sectors, GFP_NOIO, bs);
+}
+
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
 					    struct bio *bio,
 					    struct bio_set *bs,
@@ -308,6 +324,10 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
 				nr_segs);
 		break;
+	case REQ_OP_ASSIGN_RANGE:
+		split = blk_bio_assign_range_split(q, *bio, &q->bio_split,
+				nr_segs);
+		break;
 	case REQ_OP_WRITE_SAME:
 		split = blk_bio_write_same_split(q, *bio, &q->bio_split,
 				nr_segs);
@@ -386,6 +406,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ASSIGN_RANGE:
 		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index c8eda2e7b91e..6beee0585580 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -48,6 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
 	lim->max_write_zeroes_sectors = 0;
+	lim->max_assign_range_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
 	lim->discard_granularity = 0;
@@ -83,6 +84,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_same_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
+	lim->max_assign_range_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
 
@@ -257,6 +259,21 @@ void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);
 
+/**
+ * blk_queue_max_assign_range_sectors - set max sectors for a single
+ *                                      assign_range
+ *
+ * @q:  the request queue for the device
+ * @max_assign_range_sectors: maximum number of sectors to assign range per
+ *                            command
+ **/
+void blk_queue_max_assign_range_sectors(struct request_queue *q,
+		unsigned int max_assign_range_sectors)
+{
+	q->limits.max_assign_range_sectors = max_assign_range_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_assign_range_sectors);
+
 /**
  * blk_queue_max_segments - set max hw segments for a request for this queue
  * @q:  the request queue for the device
@@ -506,6 +523,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_same_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_assign_range_sectors = min(t->max_assign_range_sectors,
+				    b->max_assign_range_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 05741c6f618b..14b1fbed40f6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -41,6 +41,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
 
 	switch (req_op(rq)) {
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ASSIGN_RANGE:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_WRITE:
 		return blk_rq_zone_is_seq(rq);
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..0eeb20b290ec 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -257,6 +257,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ASSIGN_RANGE:
 		break;
 	case REQ_OP_WRITE_SAME:
 		bio->bi_io_vec[bio->bi_vcnt++] = bio_src->bi_io_vec[0];
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 853d92ceee64..8617abfc6f78 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -64,7 +64,8 @@ static inline bool bio_has_data(struct bio *bio)
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
+	    bio_op(bio) != REQ_OP_ASSIGN_RANGE)
 		return true;
 
 	return false;
@@ -75,7 +76,8 @@ static inline bool bio_no_advance_iter(struct bio *bio)
 	return bio_op(bio) == REQ_OP_DISCARD ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
 	       bio_op(bio) == REQ_OP_WRITE_SAME ||
-	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
+	       bio_op(bio) == REQ_OP_WRITE_ZEROES ||
+	       bio_op(bio) == REQ_OP_ASSIGN_RANGE;
 }
 
 static inline bool bio_mergeable(struct bio *bio)
@@ -178,7 +180,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	struct bvec_iter iter;
 
 	/*
-	 * We special case discard/write same/write zeroes, because they
+	 * We special case discard/write same/write zeroes/assign range, because
 	 * interpret bi_size differently:
 	 */
 
@@ -186,6 +188,7 @@ static inline unsigned bio_segments(struct bio *bio)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ASSIGN_RANGE:
 		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..bef450026044 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -296,6 +296,8 @@ enum req_opf {
 	REQ_OP_ZONE_CLOSE	= 11,
 	/* Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= 12,
+	/* Assign a sector range */
+	REQ_OP_ASSIGN_RANGE	= 15,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f629d40c645c..3a63c14e2cbc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_assign_range_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -747,6 +748,9 @@ static inline bool rq_mergeable(struct request *rq)
 	if (req_op(rq) == REQ_OP_WRITE_ZEROES)
 		return false;
 
+	if (req_op(rq) == REQ_OP_ASSIGN_RANGE)
+		return false;
+
 	if (rq->cmd_flags & REQ_NOMERGE_FLAGS)
 		return false;
 	if (rq->rq_flags & RQF_NOMERGE_FLAGS)
@@ -1000,6 +1004,10 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
+	if (unlikely(op == REQ_OP_ASSIGN_RANGE))
+		return min(q->limits.max_assign_range_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
+
 	return q->limits.max_sectors;
 }
 
@@ -1077,6 +1085,8 @@ extern void blk_queue_max_write_same_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
 extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
 		unsigned int max_write_same_sectors);
+extern void blk_queue_max_assign_range_sectors(struct request_queue *q,
+		unsigned int max_assign_range_sectors);
 extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_physical_block_size(struct request_queue *, unsigned int);
 extern void blk_queue_alignment_offset(struct request_queue *q,
@@ -1246,6 +1256,20 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 				    gfp_mask, 0);
 }
 
+extern int blkdev_issue_assign_range(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
+
+static inline int sb_issue_assign_range(struct super_block *sb, sector_t block,
+		sector_t nr_blocks, gfp_t gfp_mask)
+{
+	return blkdev_issue_assign_range(sb->s_bdev,
+					 block << (sb->s_blocksize_bits -
+						   SECTOR_SHIFT),
+					 nr_blocks << (sb->s_blocksize_bits -
+						       SECTOR_SHIFT),
+					 gfp_mask);
+}
+
 extern int blk_verify_command(unsigned char *cmd, fmode_t mode);
 
 enum blk_default_limits {
@@ -1427,6 +1451,16 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_assign_range_sectors(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return q->limits.max_assign_range_sectors;
+
+	return 0;
+}
+
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.22.0

