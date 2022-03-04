Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF64CDB98
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiCDSC0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbiCDSCY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92811C8861;
        Fri,  4 Mar 2022 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FG7ZP/ghVPa2lKPUR2l6I91okITwu/uLFXi8KaHWabo=; b=QzGD5bJuCRbXT2tw/3aWebtOiC
        /Hb40K/YrsOSWkIcp9OG9pQPiUEeYHZAvWV7iPmeR5/oNsyx/W+G9zx3DQheTYyN04itzCBv9vZcq
        XATIpnXem/DZqsM+y4jypiWOCPY4FiwrPBGt3oZvi0ZluI5J2dcLYyETSK7+YjfxtE0N1FGdiF1Y0
        hnBVBRxjLM2ivbsduEf6g503/b/lbyHYN0J1DpI/jyIsxnB4cvGIjGj/Zz9iqsK9PZacxj4SLzCcS
        5csWZoy9iFL8Ozl/rVRikm9PTPJjDUdWBmzbeoavMjgQLWkm8ceHLl0pPxGTZCJRx6ranK3x0CDNV
        /0+QyPaw==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCF4-00BUtw-JU; Fri, 04 Mar 2022 18:01:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 07/10] raid1: stop using bio_devname
Date:   Fri,  4 Mar 2022 19:01:02 +0100
Message-Id: <20220304180105.409765-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304180105.409765-1-hch@lst.de>
References: <20220304180105.409765-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use the %pg format specifier to save on stack consuption and code size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c180c188da574..97574575ad0b4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2069,15 +2069,14 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 		} while (!success && d != r1_bio->read_disk);
 
 		if (!success) {
-			char b[BDEVNAME_SIZE];
 			int abort = 0;
 			/* Cannot read from anywhere, this block is lost.
 			 * Record a bad block on each device.  If that doesn't
 			 * work just disable and interrupt the recovery.
 			 * Don't fail devices as that won't really help.
 			 */
-			pr_crit_ratelimited("md/raid1:%s: %s: unrecoverable I/O read error for block %llu\n",
-					    mdname(mddev), bio_devname(bio, b),
+			pr_crit_ratelimited("md/raid1:%s: %pg: unrecoverable I/O read error for block %llu\n",
+					    mdname(mddev), bio->bi_bdev,
 					    (unsigned long long)r1_bio->sector);
 			for (d = 0; d < conf->raid_disks * 2; d++) {
 				rdev = conf->mirrors[d].rdev;
-- 
2.30.2

