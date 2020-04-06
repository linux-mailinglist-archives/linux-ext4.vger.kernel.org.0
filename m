Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F286B1A01AB
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 01:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDFX1T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 19:27:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39587 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFX1S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 19:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586215638; x=1617751638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=05JY57+vr0SrsUskgHQR1csYgRUE6wQfg/2+cRnfOhU=;
  b=bC3Pdqy93+2mO4Y3aD9LGtLnRG4AlAAU9wpj7gf+F9AQIlJI9u9MgCvh
   Kwij5jHvMvRIxUPR1FwQgiMC4fUQMTRxOtuYpzRoXPNExMdIZ47Sy1yVh
   rvcGoeO0HE12mvNgZL8zU+rZevFtv5wR+gYkHRiiH8a7U9QMcSrrHouG5
   PLQuZJmfnbc+h3x2grySe2VmNslXz8W9BWxKJZFD41B/L0BjleLE3Xs2b
   R4ddjzg5a+E3TtYGOkVZkbYHIQXevZGWE2wUZoZ4OL7e+02/LyJejv/en
   JpiQYoil/5gp9htZ6N8E4wNbge+n/Bqp9M9MqJujO4xWYxwLwrzrLCPWp
   A==;
IronPort-SDR: Litsa8TZF68kg9MfM8GgHvo7iw6wN3OQgsDWce3q27c0Id44Sm1r7AHlokbF7VFoLopdTA8VBU
 wvVKP8kvyiBhb7ZtLsVCfP1BLs/FHZapTqbvckU0P3DqpI331zN+oJinzEQiroyXnYkq51SmwV
 oPqQTmHjzIlQ7cZ4IgtxYBHfcbmdaaI8mtK/6a290QAgAyu8xTg3gtRUgF3hMAheQmsRKYgULs
 CqnRL5CCPLd10lzFUPb1Ionuci/7LcJCCL4vUAM0TFYL3z1NCSSz178Sz/tlk4MkpNLmoEzjUu
 QnI=
X-IronPort-AV: E=Sophos;i="5.72,352,1580745600"; 
   d="scan'208";a="134723760"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2020 07:27:18 +0800
IronPort-SDR: IF4w89O8kDR9h6xU08wtusTO1z7C+L9EBZIsyoN9VOxIxOIx7slRQYOI3ez5KKpSFTmJumAVPC
 /LDNePapaCD5FlXIG5DNZTUgIxFGGEw3NpgFyjO3iJQzCi8ScrRWlyJknIYNi3JMbpdzoq6P8Y
 cjooFKqOSJqg2O5Ej9mX8FUDiawCpaw29/MrlAAZyK5z09oI632rv9D2A/xwCQoDdkzk8JZreb
 BUaRbRyRGXkY6F6yC5qK4dT+jjZB+kvIPm5iMSHNn3zSfhn5za7+BO70zSwuosrKve/aG+k5lY
 p2OEs6mu8X3fzJ/1TJeKQ0Hy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 16:18:34 -0700
IronPort-SDR: SbOZodbwaJ9e0M2FKXdz7zGgvhm5wgbRlSbDTIpnpKpljsWzqjldBOHKYS55MnlWKs4B2S8J5v
 KXUmjBeaXrH/q5cVvc5JJX1jBF11r0/MNxeuW1TbGI4PM+o3CupWoiSQM6/lvRiR36ZRhIW56v
 bknGeRvyrpMp4Z6/rtjUu21CNfrFawdvRo23tDd9MLkMD2iKJZ+QPRkJl/LrK5BffEiIaBwl1q
 9I/rVlsYtWzYxZQtcnYwrOz2OYbxrIWoyVbRisQNjMZ7s5RCnVO43pjVB9LJjjnChGrArbXMS8
 96g=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Apr 2020 16:27:18 -0700
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
Subject: [PATCH V2 1/4] block: create payloadless issue bio helper
Date:   Mon,  6 Apr 2020 15:21:45 -0700
Message-Id: <20200406222148.28365-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
References: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a prep-patch that creates a helper to submit payloadless bio
with all the required arguments. This is needed to avoid the code
repetition in blk-lib,c so that new payloadless ops can use it.  

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c | 51 +++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 5f2c429d4378..8e53e393703c 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -209,13 +209,40 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
+static void __blkdev_issue_payloadless(struct block_device *bdev,
+		unsigned op, sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
+		struct bio **biop, unsigned bio_opf, unsigned int max_sectors)
+{
+	struct bio *bio = *biop;
+
+	while (nr_sects) {
+		bio = blk_next_bio(bio, 0, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+		bio_set_dev(bio, bdev);
+		bio->bi_opf = op;
+		bio->bi_opf |= bio_opf;
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
+}
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
 {
-	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
 	struct request_queue *q = bdev_get_queue(bdev);
+	unsigned int unmap = (flags & BLKDEV_ZERO_NOUNMAP) ? REQ_NOUNMAP : 0;
 
 	if (!q)
 		return -ENXIO;
@@ -229,26 +256,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 	if (max_write_zeroes_sectors == 0)
 		return -EOPNOTSUPP;
 
-	while (nr_sects) {
-		bio = blk_next_bio(bio, 0, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, bdev);
-		bio->bi_opf = REQ_OP_WRITE_ZEROES;
-		if (flags & BLKDEV_ZERO_NOUNMAP)
-			bio->bi_opf |= REQ_NOUNMAP;
-
-		if (nr_sects > max_write_zeroes_sectors) {
-			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
-			nr_sects -= max_write_zeroes_sectors;
-			sector += max_write_zeroes_sectors;
-		} else {
-			bio->bi_iter.bi_size = nr_sects << 9;
-			nr_sects = 0;
-		}
-		cond_resched();
-	}
-
-	*biop = bio;
+	__blkdev_issue_payloadless(bdev, REQ_OP_WRITE_ZEROES, sector, nr_sects,
+		       gfp_mask, biop, unmap, max_write_zeroes_sectors);
 	return 0;
 }
 
-- 
2.22.0

