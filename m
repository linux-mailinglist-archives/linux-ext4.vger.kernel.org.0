Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91B4CDB9F
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiCDSC2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbiCDSCY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9841CFA12;
        Fri,  4 Mar 2022 10:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BaIHIZlLazxRYvfXMbsewKFh2wR3b0EOd5xjfmUnWbk=; b=Vg9argHFmqvLJAjvcusF4BWl6D
        sCOKpJ5ArqMM94ijLAYBUPCe9oW+EWq4QJCkqQbHA1fyCW8dCg2YHTpUaaQ+tn4uf7qoe+2cVM0uT
        ZKG2vfrkQ9sPTof1RZVgw5hNRV/QZw0KRtCm8qIZp85DEPQnnjFk2axIPoSgInwJh2i+Aa8410OnJ
        m6EWlnKZ6OIqSthmRJ0EoE7pyVBBRITaMlDz0k2FY86oXKSAE3FA6lEE+8tZlJJlOK03xbilRwZ0O
        IXmhwk4BXur05kEi9MP9MUfL2Gd06zpusFnp2Yl2uVXurxLj5lsYsiA2Xl+p4cQZrj6Qk1+uSETfS
        +tSdF14A==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCF7-00BUwa-6Z; Fri, 04 Mar 2022 18:01:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 08/10] raid5-ppl: stop using bio_devname
Date:   Fri,  4 Mar 2022 19:01:03 +0100
Message-Id: <20220304180105.409765-9-hch@lst.de>
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
 drivers/md/raid5-ppl.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 93d9364a930e3..845db0ba7c17f 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -416,12 +416,10 @@ static void ppl_log_endio(struct bio *bio)
 
 static void ppl_submit_iounit_bio(struct ppl_io_unit *io, struct bio *bio)
 {
-	char b[BDEVNAME_SIZE];
-
-	pr_debug("%s: seq: %llu size: %u sector: %llu dev: %s\n",
+	pr_debug("%s: seq: %llu size: %u sector: %llu dev: %pg\n",
 		 __func__, io->seq, bio->bi_iter.bi_size,
 		 (unsigned long long)bio->bi_iter.bi_sector,
-		 bio_devname(bio, b));
+		 bio->bi_bdev);
 
 	submit_bio(bio);
 }
@@ -589,9 +587,8 @@ static void ppl_flush_endio(struct bio *bio)
 	struct ppl_log *log = io->log;
 	struct ppl_conf *ppl_conf = log->ppl_conf;
 	struct r5conf *conf = ppl_conf->mddev->private;
-	char b[BDEVNAME_SIZE];
 
-	pr_debug("%s: dev: %s\n", __func__, bio_devname(bio, b));
+	pr_debug("%s: dev: %pg\n", __func__, bio->bi_bdev);
 
 	if (bio->bi_status) {
 		struct md_rdev *rdev;
@@ -634,7 +631,6 @@ static void ppl_do_flush(struct ppl_io_unit *io)
 
 		if (bdev) {
 			struct bio *bio;
-			char b[BDEVNAME_SIZE];
 
 			bio = bio_alloc_bioset(bdev, 0, GFP_NOIO,
 					       REQ_OP_WRITE | REQ_PREFLUSH,
@@ -642,8 +638,7 @@ static void ppl_do_flush(struct ppl_io_unit *io)
 			bio->bi_private = io;
 			bio->bi_end_io = ppl_flush_endio;
 
-			pr_debug("%s: dev: %s\n", __func__,
-				 bio_devname(bio, b));
+			pr_debug("%s: dev: %ps\n", __func__, bio->bi_bdev);
 
 			submit_bio(bio);
 			flushed_disks++;
-- 
2.30.2

