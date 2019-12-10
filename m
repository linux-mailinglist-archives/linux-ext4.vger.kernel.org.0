Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBF5E118E57
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfLJQ5L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Dec 2019 11:57:11 -0500
Received: from relay.sw.ru ([185.231.240.75]:36460 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbfLJQ5G (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Dec 2019 11:57:06 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ieinw-0006yh-6k; Tue, 10 Dec 2019 19:56:08 +0300
Subject: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE operation
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        ktkhai@virtuozzo.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, ajay.joshi@wdc.com, sagi@grimberg.me,
        dsterba@suse.com, chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
Date:   Tue, 10 Dec 2019 19:56:08 +0300
Message-ID: <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
In-Reply-To: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This operation allows to notify a device about the fact,
that some sectors range was choosen by a filesystem
as a single extent, and the device should try its best
to reflect that (keep the range as a single hunk in its
internals, or represent the range as minimal set of hunks).
Speaking directly, the operation is for forwarding
fallocate(0) requests into an essence, on which the device
is based.

This may be useful for some distributed network filesystems,
providing block device interface, for optimization of their
blocks placement over the cluster nodes.

Also, block devices mapping a file (like loop) are users
of that, since this allows to allocate more continuous
extents and since this batches blocks allocation requests.
In addition, hypervisors like QEMU may use this for better
blocks placement.

The patch adds a new blkdev_issue_assign_range() primitive,
which is rather similar to existing blkdev_issue_{*} api.
Also, a new queue limit.max_assign_range_sectors is added.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 block/blk-core.c          |    4 +++
 block/blk-lib.c           |   70 +++++++++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   21 ++++++++++++++
 block/bounce.c            |    1 +
 include/linux/bio.h       |    3 ++
 include/linux/blk_types.h |    2 +
 include/linux/blkdev.h    |   29 +++++++++++++++++++
 7 files changed, 130 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8d4db6e74496..060cc0ea1246 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -978,6 +978,10 @@ generic_make_request_checks(struct bio *bio)
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
index 5f2c429d4378..fbf780d3ea32 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -252,6 +252,46 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	return 0;
 }
 
+static int __blkdev_issue_assign_range(struct block_device *bdev,
+		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop, unsigned flags)
+{
+	struct bio *bio = *biop;
+	unsigned int max_sectors;
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (!q)
+		return -ENXIO;
+
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	max_sectors = bdev_assign_range_sectors(bdev);
+
+	if (max_sectors == 0)
+		return -EOPNOTSUPP;
+
+	while (nr_sects) {
+		bio = blk_next_bio(bio, 0, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio_set_dev(bio, bdev);
+		bio->bi_opf = REQ_OP_ASSIGN_RANGE;
+
+		if (nr_sects > max_sectors) {
+			bio->bi_iter.bi_size = max_sectors << 9;
+			nr_sects -= max_sectors;
+			sector += max_sectors;
+		} else {
+			bio->bi_iter.bi_size = nr_sects << 9;
+			nr_sects = 0;
+		}
+		cond_resched();
+	}
+
+	*biop = bio;
+	return 0;
+}
+
 /*
  * Convert a number of 512B sectors to a number of pages.
  * The result is limited to a number of pages that can fit into a BIO.
@@ -405,3 +445,33 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
+
+int blkdev_issue_assign_range(struct block_device *bdev, sector_t sector,
+			sector_t nr_sects, gfp_t gfp_mask, unsigned flags)
+{
+	int ret = 0;
+	sector_t bs_mask;
+	struct bio *bio;
+	struct blk_plug plug;
+
+	if (bdev_assign_range_sectors(bdev) == 0)
+		return 0;
+
+	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+
+	bio = NULL;
+	blk_start_plug(&plug);
+
+	ret = __blkdev_issue_assign_range(bdev, sector, nr_sects,
+					  gfp_mask, &bio, flags);
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
index d783bdc4559b..b2ae8b5acd72 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -102,6 +102,22 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 	return bio_split(bio, split_sectors, GFP_NOIO, bs);
 }
 
+static struct bio *blk_bio_assign_range_split(struct request_queue *q,
+					      struct bio *bio,
+					      struct bio_set *bs,
+					      unsigned *nsegs)
+{
+	*nsegs = 1;
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
 static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
 {
@@ -300,6 +316,10 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
 	case REQ_OP_SECURE_ERASE:
 		split = blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
 		break;
+	case REQ_OP_ASSIGN_RANGE:
+		split = blk_bio_assign_range_split(q, *bio, &q->bio_split,
+				nr_segs);
+		break;
 	case REQ_OP_WRITE_ZEROES:
 		split = blk_bio_write_zeroes_split(q, *bio, &q->bio_split,
 				nr_segs);
@@ -382,6 +402,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_ASSIGN_RANGE:
 		return 0;
 	case REQ_OP_WRITE_SAME:
 		return 1;
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..017bedba7b23 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -255,6 +255,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
+	case REQ_OP_ASSIGN_RANGE:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
 		break;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3cdb84cdc488..cf235c997e45 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -63,6 +63,7 @@ static inline bool bio_has_data(struct bio *bio)
 	if (bio &&
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
+	    bio_op(bio) != REQ_OP_ASSIGN_RANGE &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
 	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
 		return true;
@@ -73,6 +74,7 @@ static inline bool bio_has_data(struct bio *bio)
 static inline bool bio_no_advance_iter(struct bio *bio)
 {
 	return bio_op(bio) == REQ_OP_DISCARD ||
+	       bio_op(bio) == REQ_OP_ASSIGN_RANGE ||
 	       bio_op(bio) == REQ_OP_SECURE_ERASE ||
 	       bio_op(bio) == REQ_OP_WRITE_SAME ||
 	       bio_op(bio) == REQ_OP_WRITE_ZEROES;
@@ -184,6 +186,7 @@ static inline unsigned bio_segments(struct bio *bio)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
+	case REQ_OP_ASSIGN_RANGE:
 	case REQ_OP_SECURE_ERASE:
 	case REQ_OP_WRITE_ZEROES:
 		return 0;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..f03dcf25c831 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -296,6 +296,8 @@ enum req_opf {
 	REQ_OP_ZONE_CLOSE	= 11,
 	/* Transition a zone to full */
 	REQ_OP_ZONE_FINISH	= 12,
+	/* assign sector range */
+	REQ_OP_ASSIGN_RANGE	= 15,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3cd1853dbdac..9af70120fe57 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_assign_range_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -995,6 +996,10 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
 
+	if (unlikely(op == REQ_OP_ASSIGN_RANGE))
+		return min(q->limits.max_assign_range_sectors,
+			   UINT_MAX >> SECTOR_SHIFT);
+
 	if (unlikely(op == REQ_OP_WRITE_SAME))
 		return q->limits.max_write_same_sectors;
 
@@ -1028,6 +1033,7 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
+	    req_op(rq) == REQ_OP_ASSIGN_RANGE ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
 		return blk_queue_get_max_sectors(q, req_op(rq));
 
@@ -1225,6 +1231,8 @@ extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		unsigned flags);
 extern int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
+extern int blkdev_issue_assign_range(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, unsigned flags);
 
 static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask, unsigned long flags)
@@ -1247,6 +1255,17 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 				    gfp_mask, 0);
 }
 
+static inline int sb_issue_assign_range(struct super_block *sb, sector_t block,
+		sector_t nr_blocks, gfp_t gfp_mask)
+{
+	return blkdev_issue_assign_range(sb->s_bdev,
+					 block << (sb->s_blocksize_bits -
+						   SECTOR_SHIFT),
+					 nr_blocks << (sb->s_blocksize_bits -
+						       SECTOR_SHIFT),
+					 gfp_mask, 0);
+}
+
 extern int blk_verify_command(unsigned char *cmd, fmode_t mode);
 
 enum blk_default_limits {
@@ -1428,6 +1447,16 @@ static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
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


