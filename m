Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B717BC3AD
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Oct 2023 03:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjJGB2k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 21:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbjJGB23 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 21:28:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80B5CA
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 18:28:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692eed30152so2304567b3a.1
        for <linux-ext4@vger.kernel.org>; Fri, 06 Oct 2023 18:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696642106; x=1697246906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQNnXBnSwzfsN2zrI7/k3aUY1SO1WpMoDwjEZpkrIxM=;
        b=Tkim1QONG/9kE53t1d6txbvvKmIc7Wh3I3WmMxd/izzCCouscolK1+hLMTvNI2JTHU
         YwgOP2Vu/g7xIlXGqixd4BJr7GHQARDHGU+UPnZDVuADEtEbBA84LE6nR9UlXw2ujStc
         RgerBIaeaG8VG4cR7KSNbu5p5UyQuLuOEvxUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696642106; x=1697246906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQNnXBnSwzfsN2zrI7/k3aUY1SO1WpMoDwjEZpkrIxM=;
        b=Trmlm+d9wXAA21dj3gpEQbKA6DbjZW+5Cl+k6cKyCWrjIhA3dAvz7avueVwySRyEbA
         gW0jq7KhxiWd0jt1yuNLP+7ttL8ZZdxtQkUJJJnN3S9cSYUpWCs3BG3pJ8m1z1TjauHc
         kG1vNeKvAVXgKiFB4vdgOnW4KcQ8CZIu6KMDtVHjzh8aThskhIslPliF3wN3G10RV1Gr
         EU5dZPrHJIZ7wGXw1quTwBfL5XxfHMZGmqGyZUx436yS4afja0+0dGqKHEhRVTQH3/bH
         JjhYOTPHOeiDtH3pqblZGyFXVtyFSFip51ANhU17+EqglQP+0EmXWvEyNma+RzJjz6Ev
         bY4Q==
X-Gm-Message-State: AOJu0Yze9lBPAUZCjmMlmgdSaCWM7kZE5YVMvB+Chs+DnUbA9/G7k9Y/
        1i2OnyQ8Ssclk1XMFsGOjsnVIw==
X-Google-Smtp-Source: AGHT+IFgSpdJXRlHpObTlC1ba3rWEGA93CD9bVltNHco7wy1/jSBrQ0keIe/jvsDstn28NxLhH5baA==
X-Received: by 2002:a05:6a20:9699:b0:161:2bed:6b36 with SMTP id hp25-20020a056a20969900b001612bed6b36mr8700355pzc.31.1696642106158;
        Fri, 06 Oct 2023 18:28:26 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:138c:8976:eb4a:a91c])
        by smtp.gmail.com with UTF8SMTPSA id kx14-20020a170902f94e00b001ab39cd875csm4580815plb.133.2023.10.06.18.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 18:28:25 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Fri,  6 Oct 2023 18:28:13 -0700
Message-ID: <20231007012817.3052558-2-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Cc: stable@vger.kernel.org
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..73e42742543f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -772,24 +772,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
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
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.42.0.609.gbb76f46606-goog

