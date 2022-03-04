Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973D24CDB8C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiCDSCF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbiCDSCB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5DF1BD9BA;
        Fri,  4 Mar 2022 10:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vjzfcuVeqJ5gslcqLmqRcao85OHrZZrw3DMsoQUqsYs=; b=BiKgnhAmpHPz87EcWAzhrmMGp6
        JaGZlUMx1zQyrrO53wL2F8YQFToLKhXQl4HjSz2jIgTActUlh7rpAh3BdWhSXI/+4vtYujk7Jn0f4
        pzQ4BPjJxSPVLHJVWEzPcl4eu1PlbGAgAgwl/cCFF1TxLVoAKXFkjyUjSU5J1oUyIG9M2g+AfStNA
        r0ZK3Z/5osrm7jlU9061/F5XSpxy0G39YAXq+7yrRuJ0lZxSeIjfTQedaRT/liapUdpbjZW6JERr1
        DatQvFGwUVbQQH9EWGTI5vrTMCVHXEW8lAaao0PKa20ksSwa/e751hFgsK3pWqIr8wMJLQh0xXppG
        NlXju7tg==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCEn-00BUhb-V7; Fri, 04 Mar 2022 18:01:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 01/10] block: fix and cleanup bio_check_ro
Date:   Fri,  4 Mar 2022 19:00:56 +0100
Message-Id: <20220304180105.409765-2-hch@lst.de>
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

Don't use a WARN_ON when printing a potentially user triggered
condition.  Also don't print the partno when the block device name
already includes it, and use the %pg specifier to simplify printing
the block device name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 94bf37f8e61d2..34e1b7fdb7c89 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -580,14 +580,10 @@ late_initcall(fail_make_request_debugfs);
 static inline bool bio_check_ro(struct bio *bio)
 {
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
-		char b[BDEVNAME_SIZE];
-
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return false;
-
-		WARN_ONCE(1,
-		       "Trying to write to read-only block-device %s (partno %d)\n",
-			bio_devname(bio, b), bio->bi_bdev->bd_partno);
+		pr_warn("Trying to write to read-only block-device %pg\n",
+			bio->bi_bdev);
 		/* Older lvm-tools actually trigger this */
 		return false;
 	}
-- 
2.30.2

