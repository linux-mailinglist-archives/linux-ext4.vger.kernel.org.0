Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9900129355
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2019 09:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfLWIwq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Dec 2019 03:52:46 -0500
Received: from relay.sw.ru ([185.231.240.75]:58934 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfLWIwq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Dec 2019 03:52:46 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ijJR8-00019p-L7; Mon, 23 Dec 2019 11:51:34 +0300
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, ming.lei@redhat.com,
        osandov@fb.com, jthumshirn@suse.de, minwoo.im.dev@gmail.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, ajay.joshi@wdc.com, sagi@grimberg.me,
        dsterba@suse.com, chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
 <yq1woatc8zd.fsf@oracle.com>
 <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
 <yq1a77oc56s.fsf@oracle.com>
 <625c9ee4-bedb-ff60-845e-2d440c4f58aa@virtuozzo.com>
 <yq1pngh7blx.fsf@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <405b9106-0a97-0821-c41d-58ab8d0e2d09@virtuozzo.com>
Date:   Mon, 23 Dec 2019 11:51:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq1pngh7blx.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21.12.2019 21:54, Martin K. Petersen wrote:
> 
> Kirill,
> 
>> One more thing to discuss. The new REQ_NOZERO flag won't be supported
>> by many block devices (their number will be even less, than number of
>> REQ_OP_WRITE_ZEROES supporters). Will this be a good thing, in case of
>> we will be completing BLKDEV_ZERO_ALLOCATE bios in
>> __blkdev_issue_write_zeroes() before splitting? I mean introduction of
>> some flag in struct request_queue::limits.  Completion of them with
>> -EOPNOTSUPP in block devices drivers looks suboptimal for me.
> 
> We already have the NOFALLBACK flag to let the user make that decision.
> 
> If that flag is not specified, and I receive an allocate request for a
> SCSI device that does not support ANCHOR, my expectation would be that I
> would do a regular write same.
>
> If it's a filesystem that is the recipient of the operation and not a
> SCSI device, how to react would depend on how the filesystem handles
> unwritten extents, etc.

Ok, this case is clear for me, thanks.

But I also worry about NOFALLBACK case. There are possible block devices,
which support write zeroes, but they can't allocate blocks (block allocation
are just not appliable for them, say, these are all ordinary hdd).

Let's say, a user called fallocate(), and filesystem allocated range of blocks.
Then filesystem propagates the range to block device, and calls zeroout:

blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
		     GFP_NOIO, BLKDEV_ZERO_ALLOCATE|BLKDEV_ZERO_NOFALLBACK);

This case filesystem does not want zeroing blocks, it just wants to send a hint
to block device. So, in case of block device supports allocation, everything is OK.

But won't it be a good thing to return EOPNOTSUPP right from __blkdev_issue_write_zeroes()
in case of block device can't allocate blocks (q->limits.write_zeroes_can_allocate
in the patch below)? Here is just a way to underline block devices, which support
write zeroes, but allocation of blocks is meant nothing for them (wasting of time).

What do you think about the below?

Thanks
---
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..524b47905fd5 100644
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
@@ -229,13 +229,19 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	if (max_write_zeroes_sectors == 0)
 		return -EOPNOTSUPP;
 
+	if (flags & BLKDEV_ZERO_NOUNMAP)
+		req_flags |= REQ_NOUNMAP;
+	if (flags & BLKDEV_ZERO_ALLOCATE) {
+		if (!q->limits.write_zeroes_can_allocate)
+			return -EOPNOTSUPP;
+		req_flags |= REQ_NOZERO|REQ_NOUNMAP;
+	}
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
index c45779f00cbd..9e3cd3394dd6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -347,6 +347,7 @@ struct queue_limits {
 	unsigned char		misaligned;
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
+	bool			write_zeroes_can_allocate;
 	enum blk_zoned_model	zoned;
 };
 
@@ -1219,6 +1220,7 @@ extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
+#define BLKDEV_ZERO_ALLOCATE	(1 << 2)  /* allocate range of blocks */
 
 extern int __blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop,
