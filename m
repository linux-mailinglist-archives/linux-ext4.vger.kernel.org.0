Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E1E39C1E0
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jun 2021 23:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFDVLD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Jun 2021 17:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDVLC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Jun 2021 17:11:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28CC061766
        for <linux-ext4@vger.kernel.org>; Fri,  4 Jun 2021 14:09:15 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bl11-20020ad4564b0000b029021d1fdffd5aso7583754qvb.1
        for <linux-ext4@vger.kernel.org>; Fri, 04 Jun 2021 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=91peql34DHbFUki+AbIkoVzV6GEWt4wa1rjinU0Vj1o=;
        b=NWM6rSqjQWgBV4b0PQCeKKpM41Gh30JBudqV4IzVKloaLmDl/Elq/REtE98KKwRDDK
         RoyIta1OKr/9Zo6G9QXrLium4ej+9gKZTVPYUePqI1jhOJgobWyhOoEeUm6Z8HlMRjIr
         Qx4GLl9jime2jzklU9y2MF4l4VIiast22wwPkx8CULvJraclZ2P+a0Rou3l70zG/oHiq
         1UjT69ghMT/VyqfhLtg/Z6iCpGrigd9QganfvoleBrBwR0XeBn1h+LbhUsV4OYDFF6iX
         rkUigqHsbMPT6bWEOC6ezUgYqzhG+7kTT2s2TUnbwbfhC+8Z9agd+FqZP4QJKKf7EKS3
         yU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=91peql34DHbFUki+AbIkoVzV6GEWt4wa1rjinU0Vj1o=;
        b=SjbtylH88Phgax6yUC5SS5My6pETL6gK9RA3M3on9Y4KzTyCT1sZ93fXZy5+8NscgS
         44MtJGj4ERJN6y3ssyxItauIRD3sPN7jXR+UuLYg/bm5nsnOrxiGOOoybV19rKZ0ZtGm
         7e82gmv1M37OEjgvHbNWtWloCIx8AlyNC30n4PPGA/G90DzuCz/vLjbEhw/jiuFYQO7M
         5crSxCWJth2O3DsVXhF3gvko9n1MBbpCobq0pawuTiMJBkQm3Eh7KDr77gC+UlPKZo6z
         WOj7m4F3La4sPP0lIOlEbI2MHx+jbp16eDW8zkU4suW/H2PwWvIkLXgi9HhKFJyS6kOR
         I/ww==
X-Gm-Message-State: AOAM533uiCbM0OknpxBhNJ9A8W4enn1lGOgbLgtfUJ07RaiFicx9mzWR
        RvWtENQt9TehOSCbwbVgpMLedJwuKm4=
X-Google-Smtp-Source: ABdhPJyxZNAgaBzH8MB4R3w5D0FDEiNYSY0E6g3pRNVW4sq6jgFG0GaBevF/RjxS6fOw2/bE9D33hwV+eRU=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:428:: with SMTP id
 a8mr3037233qvy.3.1622840954643; Fri, 04 Jun 2021 14:09:14 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:01 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-3-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 2/9] block: blk-crypto: relax alignment requirements for
 bvecs in bios
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

blk-crypto only accepted bios whose bvecs' offsets and lengths were aligned
to the crypto data unit size, since blk-crypto-fallback required that to
work correctly.

Now that the blk-crypto-fallback has been updated to work without that
assumption, we relax the alignment requirement - blk-crypto now only needs
the total size of the bio to be aligned to the crypto data unit size.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/blk-crypto.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index c5bdaafffa29..06f81e64151d 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -200,22 +200,6 @@ bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
 	return !bc1 || bio_crypt_dun_is_contiguous(bc1, bc1_bytes, bc2->bc_dun);
 }
 
-/* Check that all I/O segments are data unit aligned. */
-static bool bio_crypt_check_alignment(struct bio *bio)
-{
-	const unsigned int data_unit_size =
-		bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size;
-	struct bvec_iter iter;
-	struct bio_vec bv;
-
-	bio_for_each_segment(bv, bio, iter) {
-		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
-			return false;
-	}
-
-	return true;
-}
-
 blk_status_t __blk_crypto_init_request(struct request *rq)
 {
 	return blk_ksm_get_slot_for_key(rq->q->ksm, rq->crypt_ctx->bc_key,
@@ -271,7 +255,8 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 		goto fail;
 	}
 
-	if (!bio_crypt_check_alignment(bio)) {
+	if (!IS_ALIGNED(bio->bi_iter.bi_size,
+			bc_key->crypto_cfg.data_unit_size)) {
 		bio->bi_status = BLK_STS_IOERR;
 		goto fail;
 	}
-- 
2.32.0.rc1.229.g3e70b5a671-goog

