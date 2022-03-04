Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E850E4CDB9D
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiCDSC1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbiCDSCS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F1A1C65D0;
        Fri,  4 Mar 2022 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FfOImJllLJqmphH4LRFKDUX/RFMK65Kob49l+6sR3wE=; b=nKzOU/Cy42CV4CGN1okxM6keyy
        wcxMDRWNVQ5ygLlkQWYYVVPZIN/6LSKjfMFJmgWMn4IGLkT1Wz9w8LZOI+XLMrCX3KgzfytUR595A
        HJA2wz/7dNT+mGjb/M6iTmPu4zizZRj9ZHcoMBkBAjhI4eczNxztNTtSf7SXM/VRyr+xxwSb5Bzn7
        6IOeHRSPbLhtXBGf+7UUqEQs9WpKJj2aVzRsLEMnvB+BYeUuSP1GkJzRx0s3tAWkoyOL3YU0tlEBI
        vkhcK1I/krHbfAsnL0ZW787zKWN2YO3s8kattoGllWV6pBnSB8a4guY/K5STxdDtMZIkAvoBXZRve
        38xtOOUg==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCF1-00BUru-RD; Fri, 04 Mar 2022 18:01:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 06/10] md-multipath: stop using bio_devname
Date:   Fri,  4 Mar 2022 19:01:01 +0100
Message-Id: <20220304180105.409765-7-hch@lst.de>
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
 drivers/md/md-multipath.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index c056a7d707b09..bc38a6133cda3 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -294,7 +294,6 @@ static void multipathd(struct md_thread *thread)
 
 	md_check_recovery(mddev);
 	for (;;) {
-		char b[BDEVNAME_SIZE];
 		spin_lock_irqsave(&conf->device_lock, flags);
 		if (list_empty(head))
 			break;
@@ -306,13 +305,13 @@ static void multipathd(struct md_thread *thread)
 		bio->bi_iter.bi_sector = mp_bh->master_bio->bi_iter.bi_sector;
 
 		if ((mp_bh->path = multipath_map (conf))<0) {
-			pr_err("multipath: %s: unrecoverable IO read error for block %llu\n",
-			       bio_devname(bio, b),
+			pr_err("multipath: %pg: unrecoverable IO read error for block %llu\n",
+			       bio->bi_bdev,
 			       (unsigned long long)bio->bi_iter.bi_sector);
 			multipath_end_bh_io(mp_bh, BLK_STS_IOERR);
 		} else {
-			pr_err("multipath: %s: redirecting sector %llu to another IO path\n",
-			       bio_devname(bio, b),
+			pr_err("multipath: %pg: redirecting sector %llu to another IO path\n",
+			       bio->bi_bdev,
 			       (unsigned long long)bio->bi_iter.bi_sector);
 			*bio = *(mp_bh->master_bio);
 			bio->bi_iter.bi_sector +=
-- 
2.30.2

