Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26364CDBA2
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiCDSCa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbiCDSCZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88B1D085D;
        Fri,  4 Mar 2022 10:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=h0tpXAQtNHEaCQzxgx/Ath7a0Cf/9SvtKG1WM6dabdU=; b=TiKY/kEa/u3/xm8OWEXU46s7wR
        yJijQAXgLHh2Ck/EQPg2L0OXen2Q0W+3MHyP5VlMHho0MReXms2D7IVM4yGlTHgEOLlg/7cBDJhfn
        TXn5gFqYi+/9qY9nlPK50TX/He0A4fOjlwrZdKafvat/OrWTEjNUrIUjdyJaSe+SxU/1ttpt1NM0J
        L6XGpQktw529TTktrVdk0BYgjt10P+W5+NU6GPnLYhCjMtCApr5DJWjvtrD+aALxnaDW/xxXJU/Fh
        Vvp050GDKfRCXB0dQTJozDja+PXFLqF6FgZKM4LTF9/BIMDPLv/qFZdUBEnPEtr9Nfvcz/DIBm0LL
        gO4K8jaA==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCFC-00BV1M-HL; Fri, 04 Mar 2022 18:01:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 10/10] block: remove bio_devname
Date:   Fri,  4 Mar 2022 19:01:05 +0100
Message-Id: <20220304180105.409765-11-hch@lst.de>
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

All callers are gone, so remove this wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 6 ------
 include/linux/bio.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b15f5466ce084..151cace2dbe16 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -807,12 +807,6 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 }
 EXPORT_SYMBOL(bio_init_clone);
 
-const char *bio_devname(struct bio *bio, char *buf)
-{
-	return bdevname(bio->bi_bdev, buf);
-}
-EXPORT_SYMBOL(bio_devname);
-
 /**
  * bio_full - check if the bio is full
  * @bio:	bio to check
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7523aba4ddf7c..4c21f6e69e182 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -491,8 +491,6 @@ static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 		__bio_release_pages(bio, mark_dirty);
 }
 
-extern const char *bio_devname(struct bio *bio, char *buffer);
-
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_bdev->bd_disk)
 
-- 
2.30.2

