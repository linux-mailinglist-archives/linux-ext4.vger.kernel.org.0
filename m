Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EF24CDBA6
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241461AbiCDSCa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbiCDSCZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230A11D06E0;
        Fri,  4 Mar 2022 10:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YZfuEEYnhVbo8r/s4SQj/tw1f3BGsvg3FGGkCFbsay4=; b=PlV4dFSwZ3gvToZvQqdUYoTDMT
        QDi5Jmng39OdDzsyfY2Dy1gX1wRT+TyqvMM5jNjm4fa48l8btcuilcN2RgFfaI+8Fu9YC5LN4sxif
        2U4DTcSzbwhAlZ3zssvvA4dpLfJB35SBoEVp4fmy5VxZV/sax8ohnPqCX0W/+rO1lLXkNmaS1RlsS
        Q7aIJmtYkKCIJ9jUlf/4fXRSq1uG4LcI1/4OVB4uVCnl0dRFMvdTj2/V8uDDb8WN+wl1VeloFiq+3
        Kp7iO9pF5RtyheUVpwnvwINIq6fRsa0gfj/APaXl6YKPzgTnl7sxjeBtRwIBDKrrCmGAuolbPY+VH
        Kri+l+ig==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCF9-00BUyz-SA; Fri, 04 Mar 2022 18:01:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 09/10] ext4: stop using bio_devname
Date:   Fri,  4 Mar 2022 19:01:04 +0100
Message-Id: <20220304180105.409765-10-hch@lst.de>
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
 fs/ext4/page-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 1253982268730..18373fa529225 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -323,10 +323,9 @@ static void ext4_end_bio(struct bio *bio)
 {
 	ext4_io_end_t *io_end = bio->bi_private;
 	sector_t bi_sector = bio->bi_iter.bi_sector;
-	char b[BDEVNAME_SIZE];
 
-	if (WARN_ONCE(!io_end, "io_end is NULL: %s: sector %Lu len %u err %d\n",
-		      bio_devname(bio, b),
+	if (WARN_ONCE(!io_end, "io_end is NULL: %pg: sector %Lu len %u err %d\n",
+		      bio->bi_bdev,
 		      (long long) bio->bi_iter.bi_sector,
 		      (unsigned) bio_sectors(bio),
 		      bio->bi_status)) {
-- 
2.30.2

