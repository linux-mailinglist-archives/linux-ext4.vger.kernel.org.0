Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703036E8798
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Apr 2023 03:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDTBrx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Apr 2023 21:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTBrw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Apr 2023 21:47:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40410FD
        for <linux-ext4@vger.kernel.org>; Wed, 19 Apr 2023 18:47:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b60366047so463130b3a.1
        for <linux-ext4@vger.kernel.org>; Wed, 19 Apr 2023 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681955258; x=1684547258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyurZ/3V3e/TfJ64+oQeFZRXuRpGYngRPpwbALjOBlU=;
        b=OCgRfiXCuStjsazsK/NTRG8oGDsxx2kymbqOUtb5DkGOo4AaKoAVfks39i/pw3VtlW
         HpuCWlh+CByxmIJ1yPC8mnj0TEsEbjqKGq34F7DWBd1qrLUQEDifZ5lUmgOXKP6GrnNy
         Mdb+rAAbOF5E5UOc9S1Z3pCK9q/A1P2p4iX2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681955258; x=1684547258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyurZ/3V3e/TfJ64+oQeFZRXuRpGYngRPpwbALjOBlU=;
        b=Uxhr2a+lN10DEWyPHCh+mkpjghBxZazpD7b/HzAbFzRs8ZoD9lTAzCd/qQnyiOe3aH
         mdhYAhzJiBbUcpNpD2ZyI9lysKgFNX4ah7i+q4D7jT/v0nPlF5PbffsDdqbPcDjvgOhL
         KnZ5Zgxd/219cfDcOGcOdLB0RSmImf9eHF0qwaAB1GZ1xYGhZ9SEXUSntjLPEMs8N3li
         3QDwo9COyTzoJjMGDSgfaraluXAQhHdLw6vHaAjE3FomCl5gXdf92bqjv4xfTo6nblX8
         1yzfH5Ea3ydCO0KRF1U5aigX2s87kYhND2SyKVFU0P5PNMLN38vCAwNtC2WSLp8fatu7
         m5iw==
X-Gm-Message-State: AAQBX9f0pkVaL9rCqYtPa9bxeLE4DCWVHSTOqeIkxmYXY0zEhKDc19rw
        ESLF3eWF3fMa1Y9RZGbvtbS4iw==
X-Google-Smtp-Source: AKy350azF3Q2VfJRGkzUywFfeQrYRuuCXsZ99E9a6W8nqlVd2cwXSPd2Fqy1TX8MhR0Y0U2TO1ZDXA==
X-Received: by 2002:a05:6a00:1489:b0:63d:3aed:44fb with SMTP id v9-20020a056a00148900b0063d3aed44fbmr6882651pfu.21.1681955258324;
        Wed, 19 Apr 2023 18:47:38 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:402e:4c2e:4e90:d79d])
        by smtp.gmail.com with ESMTPSA id y4-20020a62ce04000000b006363690dddasm60753pfg.5.2023.04.19.18.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 18:47:37 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v5-fix 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Wed, 19 Apr 2023 18:47:34 -0700
Message-ID: <20230420014734.302304-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230420004850.297045-2-sarthakkukreti@chromium.org>
References: <20230420004850.297045-2-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Only call truncate_bdev_range() if the fallocate mode is
supported. This fixes a bug where data in the pagecache
could be invalidated if the fallocate() was called on the
block device with an invalid mode.

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..d359254c645d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -648,26 +648,37 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		goto fail;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL,
-					     BLKDEV_ZERO_NOUNMAP);
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (!error)
+			error = blkdev_issue_zeroout(bdev,
+						     start >> SECTOR_SHIFT,
+						     len >> SECTOR_SHIFT,
+						     GFP_KERNEL,
+						     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL,
-					     BLKDEV_ZERO_NOFALLBACK);
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (!error)
+			error = blkdev_issue_zeroout(bdev,
+						     start >> SECTOR_SHIFT,
+						     len >> SECTOR_SHIFT,
+						     GFP_KERNEL,
+						     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL);
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (!error)
+			error = blkdev_issue_discard(bdev,
+						     start >> SECTOR_SHIFT,
+						     len >> SECTOR_SHIFT,
+						     GFP_KERNEL);
 		break;
 	default:
 		error = -EOPNOTSUPP;
-- 
2.40.0.634.g4ca3ef3211-goog

