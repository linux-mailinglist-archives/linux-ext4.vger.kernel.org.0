Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35734CDB8E
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbiCDSCM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbiCDSCH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A6C1B989D;
        Fri,  4 Mar 2022 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cqmk4RGtSaszMnquxc/oyP4l8w/hS4OYdIlhjeA7b+I=; b=U1Rgy9ymsIhudcOwIcRsW6TPER
        B5aghzwGY4dOoBAG/YwLNPSvd1UX0rCrr0WBkiHyO7In/L5oPLREx9/F71/TXI1ykQ336o6YIQw3w
        xqfzAIeNd8FW8Wa0I4PUk+SC8DxILJuUVIROwi0vGFxqR2AqqTIK8P/bvBur0VOVMivaxQ2gJtaY9
        P+6dLlEIIchOWLolT0/jtRd6YoJf5wKW4xyOa8vZ2qge3gZOvh1H8W8Ewj0ZULAgukcd4idHfhGnj
        3R0kGO28E6P+uTeSyKpIDnXDWqQMP/sEB+CpOco6tyimwoK13WeR5lbHBiOFDsNay7h8QAyV27hcU
        TUB/FbWw==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCEt-00BUlR-8F; Fri, 04 Mar 2022 18:01:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 03/10] pktcdvd: remove a pointless debug check in pkt_submit_bio
Date:   Fri,  4 Mar 2022 19:00:58 +0100
Message-Id: <20220304180105.409765-4-hch@lst.de>
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

->queuedata is set up in pkt_init_queue, so it can't be NULL here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 623df4141ff3f..a52bbedd2f33d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2400,18 +2400,11 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 
 static void pkt_submit_bio(struct bio *bio)
 {
-	struct pktcdvd_device *pd;
-	char b[BDEVNAME_SIZE];
+	struct pktcdvd_device *pd = bio->bi_bdev->bd_disk->queue->queuedata;
 	struct bio *split;
 
 	blk_queue_split(&bio);
 
-	pd = bio->bi_bdev->bd_disk->queue->queuedata;
-	if (!pd) {
-		pr_err("%s incorrect request queue\n", bio_devname(bio, b));
-		goto end_io;
-	}
-
 	pkt_dbg(2, pd, "start = %6llx stop = %6llx\n",
 		(unsigned long long)bio->bi_iter.bi_sector,
 		(unsigned long long)bio_end_sector(bio));
-- 
2.30.2

