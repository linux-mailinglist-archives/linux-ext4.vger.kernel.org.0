Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D48196F7B
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgC2Swi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Mar 2020 14:52:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62250 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgC2Swh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Mar 2020 14:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585507957; x=1617043957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=05JY57+vr0SrsUskgHQR1csYgRUE6wQfg/2+cRnfOhU=;
  b=Td3xLvW40tIQnn1vppnQ0mOe1HB7CQusB75ykBhqt/FAYHh17P0BZwET
   nXGj5PWixQPZWp8hkRBQnu1WkjIMKH4TMTxEzg7+tY+XFexFa5s2YQpEd
   UD7sJWsjr2ivbjwjZxBT9SfVyKlwVnhwkijYx5PXW15Uhvo098palsnz1
   bur6HimQg92YWw+kXh6lWtr3xsT73dJKeit7aF7IM0BR34H/27mFp2bto
   fM66Pf5ynSeVJWymHA1NaXbZYCYuvveNOUkAPW1DmBYj10zBJWzkSDyvk
   ujYTm3ZWT05o38oNFoMjTB9NN/V2yZ1BY5nK/pyTl8hSe9m6yZhpD36zv
   g==;
IronPort-SDR: n0ff/wBbNLt5TRm6I6EgSFKaKWgs5nKGtpNHtd71mxYScIPayGuOQ9oiJBEYcgZ2XUHiA90upc
 7or3cOc/r+RVyk4WpYtNRQ3dX5CIcyF7SfZQ+Nc4pnSB3+VCFV8l+b+oqRLTX46nq55iWTiHZ9
 Z3p3gb2xrNkXFum9FSac+ZAYFe8/81paw8jhO/R5otZoY7OhKyYu1BaSLoyJ5jZlm9WgShq0ei
 0DudW3d5/Oy3lNbZl6IQCI4uXDHqxUHRvO9nGK4lLIt2Zj8kIBp3lL5rgjUMi5yUOeeCL+SjCG
 A0M=
X-IronPort-AV: E=Sophos;i="5.72,321,1580745600"; 
   d="scan'208";a="242357230"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 02:52:36 +0800
IronPort-SDR: Udvl/hNzWq4G25+oflrH+SzuFYAzBK5LxgYsANOqpbsMYlIl5fnCAWO7zHAhPA/Sy/ZiYld8AN
 SAdpuJr4uTHrJ/v6Wl2+mbKdrCLSWUOgWrikMxbkoKml2dmNuPymxbjO1yfXnho+cASzhj62m2
 AuEn0Tq9dSrXRiFO3PeDINH8LjSECEm5akZqD0IoVbxptLZ2ZEL70uduqdpNm3WwVechFIzzR+
 N9VCAbSSEX5iHdlzmArIcC+HunDuMWmei8lTddfc7n+puHCLLyIu27OzsAZO9SMtX+PnT8oZza
 Ee38Q3WSJtt71TDJwEkcRTns
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 11:44:07 -0700
IronPort-SDR: za/ClNiktC67+y3+KLO2gFFjeC7phi+D1fP25OJVcyCF4ZcsE1bYgjGEhNEWOFQk4p9894mSpO
 CN6LxQnv7a5TvF8urEYIfc3uenKrWDLKcp+LgiYuMqHK82rKMsiV5ndeLK+gOQUceS1wbKxQAM
 xrWSE9r6D5EzuwLlxPo+C+75I3UCLRB/YRu7mK/q5f3Bp2zNyziSSroyNB1JWEtTtleLsqOHOp
 mnV+9yJFDe5bIJ34L7y6UqdMjh/OpgwRMUavFLnJ3abQqrP9+2ok3jZByH77L9dwcQLhh1EV8Z
 oNE=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2020 11:52:36 -0700
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
Subject: [PATCH 1/4] block: create payloadless issue bio helper
Date:   Sun, 29 Mar 2020 10:47:11 -0700
Message-Id: <20200329174714.32416-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

