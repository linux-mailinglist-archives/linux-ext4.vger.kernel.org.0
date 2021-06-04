Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03739C1E6
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jun 2021 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhFDVLI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Jun 2021 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhFDVLH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Jun 2021 17:11:07 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F1C06178B
        for <linux-ext4@vger.kernel.org>; Fri,  4 Jun 2021 14:09:20 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ea18-20020ad458b20000b0290215c367b5d3so3969996qvb.3
        for <linux-ext4@vger.kernel.org>; Fri, 04 Jun 2021 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XCMW74I69DeN8Z3kX5iYnnwjp70fgDZ7aIjMCwTUzeM=;
        b=Mw++crRiYfOUuxBBsYJaIjEa2wzFZ7uIymgYyHPMmfqTENGSHY2XJFEFHfB0uF7oKU
         q+30l4Moqzicat/BsS7qK98HMHFB/NLzIAJndkfQNTeAD2gynzn1R3KcC6ecx+103TBP
         GDOBRtGgHEnAavWAyXnjadC5RjL1xZKdJoiqVP9LX+Baz1NH8ZskxxPR83N7wSzYmGmy
         AzR1MNMkb9T8NXWXKltKXehqDno9ArTvpLAmBtZwsBDFWHY2DN8mTuZF85xYugPqWMzK
         yDR3nmN38QXxX3Feu5LZLFS1lswICuDdid9tBrfJEby3qDOgFQZQYjh0Whmxpid95T2Z
         py5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XCMW74I69DeN8Z3kX5iYnnwjp70fgDZ7aIjMCwTUzeM=;
        b=M7yDW3uT/YGDb1GhHB071qa3baUGJfMoGMeDr7UmO2mAfxvaNCZsXpO+bu1tNqDtDW
         o9UStaqsjNlgbUHCC6fp+wVvMtGmirPTnj0P4gehViznIm4cr3o4j8TB+7UaJX1R2jx/
         BZNRUMV2Mmlw0BRFsdTO/GRZt4uXnFnsp4b0iUqMITiewezEOgCt1X49tAwUmUwvGS8s
         3ZePMbvauln3QcXQeKDCx8ZZQ1xRHhp52MNM/a90pXSfDb4gs80yLOMv5DmxYbXC8fLy
         aDhEvXMcBpU+pSYhbNH6CYEsWh5/pFy7bJ5xnaqaJnZJU/XWkfSHYGiAfxEeksep3ljU
         JXoA==
X-Gm-Message-State: AOAM530A4ZJXrK858OLOlBW+RhPwXqaKtCEzlGtwRodjDS6b0E5z6SJN
        C7uKqPD8yMYFsm55eOaYJYcmpB6sF8g=
X-Google-Smtp-Source: ABdhPJxiSLZqcPqUF+AidxN8J2rs3GJOT86onesJOcAIexrEcLNAzcay/hdWehQRGDOJrX95PrTmEboMFxw=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:2aa3:: with SMTP id
 js3mr6751098qvb.56.1622840959831; Fri, 04 Jun 2021 14:09:19 -0700 (PDT)
Date:   Fri,  4 Jun 2021 21:09:04 +0000
In-Reply-To: <20210604210908.2105870-1-satyat@google.com>
Message-Id: <20210604210908.2105870-6-satyat@google.com>
Mime-Version: 1.0
References: <20210604210908.2105870-1-satyat@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v9 5/9] block: Make bio_iov_iter_get_pages() respect bio_required_sector_alignment()
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Previously, bio_iov_iter_get_pages() wasn't used with bios that could have
an encryption context. However, direct I/O support using blk-crypto
introduces this possibility, so this function must now respect
bio_required_sector_alignment() (otherwise, xfstests like generic/465 with
ext4 will fail).

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/bio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 32f75f31bb5c..99c510f706e2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1099,7 +1099,8 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * The function tries, but does not guarantee, to pin as many pages as
  * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
- * is returned only if 0 pages could be pinned.
+ * is returned only if 0 pages could be pinned. It also ensures that the number
+ * of sectors added to the bio is aligned to bio_required_sector_alignment().
  *
  * It's intended for direct IO, so doesn't do PSI tracking, the caller is
  * responsible for setting BIO_WORKINGSET if necessary.
@@ -1107,6 +1108,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	int ret = 0;
+	unsigned int aligned_sectors;
 
 	if (iov_iter_is_bvec(iter)) {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
@@ -1121,6 +1123,15 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 			ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
+	/*
+	 * Ensure that number of sectors in bio is aligned to
+	 * bio_required_sector_align()
+	 */
+	aligned_sectors = round_down(bio_sectors(bio),
+				     bio_required_sector_alignment(bio));
+	iov_iter_revert(iter, (bio_sectors(bio) - aligned_sectors) << SECTOR_SHIFT);
+	bio_truncate(bio, aligned_sectors << SECTOR_SHIFT);
+
 	/* don't account direct I/O as memory stall */
 	bio_clear_flag(bio, BIO_WORKINGSET);
 	return bio->bi_vcnt ? 0 : ret;
-- 
2.32.0.rc1.229.g3e70b5a671-goog

