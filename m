Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA0135608
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgAIJpD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 04:45:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:37048 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgAIJpD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 04:45:03 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ipULw-0001FG-Ba; Thu, 09 Jan 2020 12:43:44 +0300
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "hare@suse.com" <hare@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        "ajay.joshi@wdc.com" <ajay.joshi@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
 <yq1woatc8zd.fsf@oracle.com>
 <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
 <yq1a77oc56s.fsf@oracle.com>
 <625c9ee4-bedb-ff60-845e-2d440c4f58aa@virtuozzo.com>
 <yq1pngh7blx.fsf@oracle.com>
 <405b9106-0a97-0821-c41d-58ab8d0e2d09@virtuozzo.com>
 <yq1o8vg2bl2.fsf@oracle.com>
 <d2835bd2-9579-74b5-4339-b576df79a9d5@virtuozzo.com>
 <yq1k1621x3x.fsf@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <eb6f3dde-6843-75d1-db35-bbf050fdd5ae@virtuozzo.com>
Date:   Thu, 9 Jan 2020 12:43:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq1k1621x3x.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 08.01.2020 05:49, Martin K. Petersen wrote:
> 
> Kirill,
> 
>>> Correct. We shouldn't go down this path unless a device is thinly
>>> provisioned (i.e. max_discard_sectors > 0).
>>
>> (I assumed it is a typo, and you mean max_allocate_sectors like bellow).
> 
> No, this was in the context of not having an explicit queue limit for
> allocation. If a device does not have max_discard_sectors > 0 then it is
> not thinly provisioned and therefore attempting allocation makes no
> sense.
> 
>>> I don't like "write_zeroes_can_allocate" because that makes assumptions
>>> about WRITE ZEROES being the command of choice. I suggest we call it
>>> "max_allocate_sectors" to mirror "max_discard_sectors". I.e. put
>>> emphasis on the semantic operation and not the plumbing.
>>  
>> Hm. Do you mean "bool max_allocate_sectors" or "unsigned int max_allocate_sectors"?
> 
> unsigned int. At least for SCSI we could have a device which would use
> UNMAP for discards and WRITE SAME for allocates. And therefore the range
> limit could be different for the two operations. Sadly.
> 
> I have a patch in the pipeline which deals with some problems in this
> department because some devices have a split brain wrt. their discard
> limits.
> 
>> In the second case we should make all the
>> q->limits.max_write_zeroes_sectors dereferencing as switches like the
>> below (this is a partial patch and only several of places are
>> converted to switches as examples):
> 
> Something like that, yes.
> 
> This is getting a bit messy :( However, I am not sure that scattering
> REQ_OP_ALLOCATE all over the I/O stack is particularly attractive
> either.

It looks like changing the second argument of blk_queue_get_max_write_zeroes_sectors()
gives almost clean code. All REQ_NOZERO checks become moved to helper.

> Both REQ_OP_DISCARD and REQ_OP_WRITE_SAME come with some storage
> protocol baggage that forces us to have special handling all over the
> stack. But REQ_OP_WRITE_ZEROES is fairly clean and simple and, except
> for the potentially different block count limit, an allocate operation
> would be a carbon copy of the plumbing for write zeroes. A lot of
> duplication.
> 
> So even through I'm increasingly torn on whether introducing separate
> REQ_OP_ALLOCATE plumbing throughout the stack or having a REQ_ALLOCATE
> flag for REQ_OP_WRITE_ZEROES is best, I still think I'm leaning towards
> the latter. That will also make it easier for me in the SCSI disk
> driver.

Yeah, this sounds good. Also, it looks the REQ_NOZERO patch is really
simpler, it is smaller even.

Below is complete patch for block core (I've excluded hunks for drivers/*,
since they require some cleanup patches for preparations). Please, let
me know whether I understood you correct and everything is OK. Thanks!

[PATCH] block: Add support for REQ_NOZERO

This adds support for REQ_NOZERO extension of REQ_OP_WRITE_ZEROES
operation, which encourages a block device driver to just allocate
blocks (or mark them allocated) instead of actual blocks zeroing.
REQ_NOZERO is aimed to be used for network filesystems providing
a block device interface. Also, block devices, which map a file
on other filesystem (like loop), may use this for less fragmentation
and batching fallocate() requests. Hypervisors like QEMU may
introduce optimizations of clusters allocations based on this.

BLKDEV_ZERO_ALLOCATE is a new corresponding flag for
blkdev_issue_zeroout().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 block/blk-core.c          |    6 +++---
 block/blk-lib.c           |   17 ++++++++++-------
 block/blk-merge.c         |    9 ++++++---
 block/blk-settings.c      |    4 ++++
 fs/block_dev.c            |    4 ++++
 include/linux/blk_types.h |    5 ++++-
 include/linux/blkdev.h    |   32 ++++++++++++++++++++++++--------
 7 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 50a5de025d5e..2edcd55624f1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -978,7 +978,7 @@ generic_make_request_checks(struct bio *bio)
 			goto not_supported;
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
+		if (!blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf))
 			goto not_supported;
 		break;
 	default:
@@ -1250,10 +1250,10 @@ EXPORT_SYMBOL(submit_bio);
 static int blk_cloned_rq_check_limits(struct request_queue *q,
 				      struct request *rq)
 {
-	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
+	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->cmd_flags)) {
 		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
 			__func__, blk_rq_sectors(rq),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			blk_queue_get_max_sectors(q, rq->cmd_flags));
 		return -EIO;
 	}
 
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..3e80279eb029 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -214,7 +214,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		struct bio **biop, unsigned flags)
 {
 	struct bio *bio = *biop;
-	unsigned int max_write_zeroes_sectors;
+	unsigned int max_write_zeroes_sectors, req_flags = 0;
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	if (!q)
@@ -224,18 +224,21 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		return -EPERM;
 
 	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
-	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev);
+	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, flags);
 
 	if (max_write_zeroes_sectors == 0)
 		return -EOPNOTSUPP;
 
+	if (flags & BLKDEV_ZERO_NOUNMAP)
+		req_flags |= REQ_NOUNMAP;
+	if (flags & BLKDEV_ZERO_ALLOCATE)
+		req_flags |= REQ_NOZERO|REQ_NOUNMAP;
+
 	while (nr_sects) {
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
-		bio->bi_opf = REQ_OP_WRITE_ZEROES;
-		if (flags & BLKDEV_ZERO_NOUNMAP)
-			bio->bi_opf |= REQ_NOUNMAP;
+		bio->bi_opf = REQ_OP_WRITE_ZEROES | req_flags;
 
 		if (nr_sects > max_write_zeroes_sectors) {
 			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
@@ -362,7 +365,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	sector_t bs_mask;
 	struct bio *bio;
 	struct blk_plug plug;
-	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
+	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, flags);
 
 	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 	if ((sector | nr_sects) & bs_mask)
@@ -391,7 +394,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			try_write_zeroes = false;
 			goto retry;
 		}
-		if (!bdev_write_zeroes_sectors(bdev)) {
+		if (!bdev_write_zeroes_sectors(bdev, flags)) {
 			/*
 			 * Zeroing offload support was indicated, but the
 			 * device reported ILLEGAL REQUEST (for some devices
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 347782a24a35..e3ce4b87bbaa 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -105,15 +105,18 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
 {
+	unsigned int max_sectors;
+
+	max_sectors = blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf);
 	*nsegs = 0;
 
-	if (!q->limits.max_write_zeroes_sectors)
+	if (!max_sectors)
 		return NULL;
 
-	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
+	if (bio_sectors(bio) <= max_sectors)
 		return NULL;
 
-	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
+	return bio_split(bio, max_sectors, GFP_NOIO, bs);
 }
 
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 5f6dcc7a47bd..09a2eeacfadd 100644
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
 
@@ -506,6 +508,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 					b->max_write_same_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
 					b->max_write_zeroes_sectors);
+	t->max_allocate_sectors = min(t->max_allocate_sectors,
+					b->max_allocate_sectors);
 	t->bounce_pfn = min_not_zero(t->bounce_pfn, b->bounce_pfn);
 
 	t->seg_boundary_mask = min_not_zero(t->seg_boundary_mask,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..1ffef894b3bd 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2122,6 +2122,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
 		break;
+	case FALLOC_FL_KEEP_SIZE:
+		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
+			GFP_KERNEL, BLKDEV_ZERO_ALLOCATE | BLKDEV_ZERO_NOFALLBACK);
+		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
 		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
 					     GFP_KERNEL, 0);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 70254ae11769..9ed166860099 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -335,7 +335,9 @@ enum req_flag_bits {
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
-
+	__REQ_NOZERO,		/* only notify about allocated blocks,
+				 * and do not actual zero them
+				 */
 	__REQ_HIPRI,
 
 	/* for driver use */
@@ -362,6 +364,7 @@ enum req_flag_bits {
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
+#define REQ_NOZERO		(1ULL << __REQ_NOZERO)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c45779f00cbd..7e388be625af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -336,6 +336,7 @@ struct queue_limits {
 	unsigned int		max_hw_discard_sectors;
 	unsigned int		max_write_same_sectors;
 	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_allocate_sectors;
 	unsigned int		discard_granularity;
 	unsigned int		discard_alignment;
 
@@ -988,9 +989,19 @@ static inline struct bio_vec req_bvec(struct request *rq)
 	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
 }
 
+static inline unsigned int blk_queue_get_max_write_zeroes_sectors(
+		struct request_queue *q, unsigned int op_flags)
+{
+	if (op_flags & REQ_NOZERO)
+		return q->limits.max_allocate_sectors;
+	return q->limits.max_write_zeroes_sectors;
+}
+
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     int op)
+						     unsigned int op_flags)
 {
+	int op = op_flags & REQ_OP_MASK;
+
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
@@ -999,7 +1010,7 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 		return q->limits.max_write_same_sectors;
 
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
-		return q->limits.max_write_zeroes_sectors;
+		return blk_queue_get_max_write_zeroes_sectors(q, op_flags);
 
 	return q->limits.max_sectors;
 }
@@ -1029,10 +1040,10 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
-		return blk_queue_get_max_sectors(q, req_op(rq));
+		return blk_queue_get_max_sectors(q, rq->cmd_flags);
 
 	return min(blk_max_size_offset(q, offset),
-			blk_queue_get_max_sectors(q, req_op(rq)));
+			blk_queue_get_max_sectors(q, rq->cmd_flags));
 }
 
 static inline unsigned int blk_rq_count_bios(struct request *rq)
@@ -1219,6 +1230,7 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
+#define BLKDEV_ZERO_ALLOCATE	(1 << 2)  /* allocate range of blocks */
 
 extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
@@ -1418,14 +1430,18 @@ static inline unsigned int bdev_write_same(struct block_device *bdev)
 	return 0;
 }
 
-static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
+static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev,
+						     unsigned int flags)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 
-	if (q)
+	if (!q)
+		return 0;
+
+	if (flags & BLKDEV_ZERO_ALLOCATE)
+		return q->limits.max_allocate_sectors;
+	else
 		return q->limits.max_write_zeroes_sectors;
-
-	return 0;
 }
 
 static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)

 

