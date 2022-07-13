Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9F572DA8
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 07:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiGMFxl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 01:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGMFxj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 01:53:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCB388;
        Tue, 12 Jul 2022 22:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+oupOjpjN539hy7C7mOoKBMVZDA7YOt+U1a+XjhL5Ns=; b=SppXqYL9lOHjNHJFVIsh0T/5NK
        thTYqttsVuX9ral09ViQiJsG0BqI+m2Y6uMyPhwe2AVn+9jbprGRivJH9ddWe5e2zJpp3Uqj8X/qA
        h/p+Hima0jwo2ow4lUwnJfGygYuJ7ry7o19DW0r5NP0HfYsde0cnH77T5+Ad03RQFoqtOH8QYa4Rp
        KOMLvHbUs0O6xMh7bWvgY6cyW6WS9V9UjUrnbbsUmymRzVqe91SGDWq2itxqUTJXBR7JinVMSDJoA
        d2b+wMFDOmjP0AHja00eSStrbMdsyqy8MDxoDBE0tR8Jembbeu9Acs0rIrPBoHY4FqswpEbh65DTl
        J6OtNZLQ==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVJN-000NOa-LE; Wed, 13 Jul 2022 05:53:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Song Liu <song@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 2/9] block: stop using bdevname in __blkdev_issue_discard
Date:   Wed, 13 Jul 2022 07:53:10 +0200
Message-Id: <20220713055317.1888500-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Just use the %pg format specifier instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 09b7e1200c0f4..67e6dbc1ae817 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -48,10 +48,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 	/* In case the discard granularity isn't set by buggy device driver */
 	if (WARN_ON_ONCE(!bdev_discard_granularity(bdev))) {
-		char dev_name[BDEVNAME_SIZE];
-
-		bdevname(bdev, dev_name);
-		pr_err_ratelimited("%s: Error: discard_granularity is 0.\n", dev_name);
+		pr_err_ratelimited("%pg: Error: discard_granularity is 0.\n",
+				   bdev);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.30.2

