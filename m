Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EBA4CDB8A
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbiCDSCG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbiCDSCE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000811C57FA;
        Fri,  4 Mar 2022 10:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NWtAUb4gt6zNHPNza/nGMcjOF5pGzpcQM7yFjfrfEIo=; b=yExG+NqYNxRV9CC+/9fRZWr5nn
        TUvaUoTkY+ZhC+cpPLmwguOhjPac4SXuGE9YK/nvaU6rVuh0RvFtT8HKOGDIgQK4VUfzIdP+yUuoz
        gbr7m3o8aNElu2HEOqM9wp+iMRX69QGr1QAdLHX/OuseQsuSgm7C+vd2D6HErtfq2JuGNpR5FMALW
        kBVxenOoMbYd2CbaHU4rPQ/Uq7evIZc0l2LnCgyrTL7v8Q993LrQkxbdN/2ihIJb8qN0fRd0kgPn1
        758lDTvUi7Pb6g44ivxeEUMlep/VjImej67QDiJuMdZNZH0q4sor8h+VzL/5LbA+Y/owVYbngI5nk
        XAaKkQiQ==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCEq-00BUjX-Jo; Fri, 04 Mar 2022 18:01:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 02/10] block: remove handle_bad_sector
Date:   Fri,  4 Mar 2022 19:00:57 +0100
Message-Id: <20220304180105.409765-3-hch@lst.de>
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

Use the %pg format specifier instead of the stack hungry bdevname
function, and remove handle_bad_sector given that it is not pointless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 34e1b7fdb7c89..4d858fc08f8ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -540,17 +540,6 @@ bool blk_get_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_get_queue);
 
-static void handle_bad_sector(struct bio *bio, sector_t maxsector)
-{
-	char b[BDEVNAME_SIZE];
-
-	pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-			    "%s: rw=%d, want=%llu, limit=%llu\n",
-			    current->comm,
-			    bio_devname(bio, b), bio->bi_opf,
-			    bio_end_sector(bio), maxsector);
-}
-
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 
 static DECLARE_FAULT_ATTR(fail_make_request);
@@ -612,7 +601,11 @@ static inline int bio_check_eod(struct bio *bio)
 	if (nr_sectors && maxsector &&
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
-		handle_bad_sector(bio, maxsector);
+		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
+				    "%pg: rw=%d, want=%llu, limit=%llu\n",
+				    current->comm,
+				    bio->bi_bdev, bio->bi_opf,
+				    bio_end_sector(bio), maxsector);
 		return -EIO;
 	}
 	return 0;
-- 
2.30.2

