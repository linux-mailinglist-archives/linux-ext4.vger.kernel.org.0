Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968EB4CDB92
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Mar 2022 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiCDSCM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Mar 2022 13:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiCDSCJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Mar 2022 13:02:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD451C2DAD;
        Fri,  4 Mar 2022 10:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FfvqGUpQau2mUj9oxmV6eCym+RkFxYMrHcdaoyXdgWA=; b=VI6Tb4SbyJ/XidKlKBvh06zmZr
        MMqnFeVNFrvKsefXlYmQSBJL0R1zHfhumwVawoEQEFw5XEyE5O0u8URvvkDKqtC7sHBfw2VCq0k1N
        AhZV0btO/9uUbsYemruKfiu/uHs4VFkAsttMZvgod8wCuK+Z2e8xzHIu0Z4lGkgqT3ZHzqEys6uDj
        71JJsqxNp1e5PLUQDRa0cC4Sh8fWOEKm/hFqxNry7sVGk2TDL/N3icA8Sk65WtYQiMxCb/X+wMjM9
        LN1qQAVGXu42Yx2wiFznVGlLIe86SyOHFKJs9cXVkvIxVdMNnBgxrSd3jwXMxU+PjVkA05BNNfHap
        Xh1mJGQQ==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQCEw-00BUnE-81; Fri, 04 Mar 2022 18:01:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 04/10] dm-crypt: stop using bio_devname
Date:   Fri,  4 Mar 2022 19:00:59 +0100
Message-Id: <20220304180105.409765-5-hch@lst.de>
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
 drivers/md/dm-crypt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a5006cb6ee8ad..e2b0af4a2ee84 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1364,11 +1364,10 @@ static int crypt_convert_block_aead(struct crypt_config *cc,
 	}
 
 	if (r == -EBADMSG) {
-		char b[BDEVNAME_SIZE];
 		sector_t s = le64_to_cpu(*sector);
 
-		DMERR_LIMIT("%s: INTEGRITY AEAD ERROR, sector %llu",
-			    bio_devname(ctx->bio_in, b), s);
+		DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu",
+			    ctx->bio_in->bi_bdev, s);
 		dm_audit_log_bio(DM_MSG_PREFIX, "integrity-aead",
 				 ctx->bio_in, s, 0);
 	}
@@ -2169,11 +2168,10 @@ static void kcryptd_async_done(struct crypto_async_request *async_req,
 		error = cc->iv_gen_ops->post(cc, org_iv_of_dmreq(cc, dmreq), dmreq);
 
 	if (error == -EBADMSG) {
-		char b[BDEVNAME_SIZE];
 		sector_t s = le64_to_cpu(*org_sector_of_dmreq(cc, dmreq));
 
-		DMERR_LIMIT("%s: INTEGRITY AEAD ERROR, sector %llu",
-			    bio_devname(ctx->bio_in, b), s);
+		DMERR_LIMIT("%pg: INTEGRITY AEAD ERROR, sector %llu",
+			    ctx->bio_in->bi_bdev, s);
 		dm_audit_log_bio(DM_MSG_PREFIX, "integrity-aead",
 				 ctx->bio_in, s, 0);
 		io->error = BLK_STS_PROTECTION;
-- 
2.30.2

