Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E269F524
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Feb 2023 14:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjBVNMe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Feb 2023 08:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVNM1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Feb 2023 08:12:27 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD33B0CE
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 05:12:24 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a30so7844743ljr.0
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 05:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK0AQMNR90IXprBf0YC2HUcZwjPfMUnLVMauRW7h31s=;
        b=Amwg5UumUVioyg9RHsXp9Ky0ggwyvXUUex/yDlVHBYVKK4ZzERhOMjLnqmQDrXGUCJ
         AbDIrSuzxaB3L7YvGRen5J6uCTScsXQd4WQEBgxqFEE3RydANniKu3lvVYfZ2DHXdjZo
         y2yKTlu40cJm+MOTI/0E6PBOVFIA5ovuEeNOgCT3fpZgLSzYL9FzJEfOYgB0kHmPa+O1
         iVTVWiD1ZixelS8sz2qvOsGdUZU/ocr/hQFEA4Bp98cWzlkSHUGF6XOe3xIUQRq1m/58
         W6qPLP3vfy8qm7PdMa4z5S7i7pjCHXG1RMXjhpmI1upU1fNPpjpHXsrkDkhKAfFkf7lo
         G83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK0AQMNR90IXprBf0YC2HUcZwjPfMUnLVMauRW7h31s=;
        b=QmBNIa0nWl+lKarc0U/EYES7qjV+hkw4XIlHu+ZPEbdd99cW0OYmiJSVNoRvwdsAAE
         xYFuVcDA8eZAm5wJHgSyApe3yXLDv/4EZyuETrxB4y5vB7z+QhDKDTd/cT3Xm1cyo3xa
         /rubyYWTZa0PqSixTyVvEG0y3WvQsnl7Tin6PeNiXo99nveciU5NR9Ut8hMFJiR6v/1z
         9Mg8oLXdUWFQ62CQF7uEtojPgeG9R8bRd7LWbR3/hula4MjKMQDwcvO7BhCFWWzdzfsx
         8JO5nt56Rg0yTyYPnpkIUhxrfruE69ZT/DYlIycM0yGNSjxlg8lWep91x0IhQ2kHmvoH
         2/7g==
X-Gm-Message-State: AO0yUKV1i6jRSGVODswXrnCalSslP69B5T3XMu/7KL4sG5TmdbDO+Dqh
        ufBJMrXn/Rd46YgtSBEvBu2UXd7qIX62KCJALzo=
X-Google-Smtp-Source: AK7set9OguqdOHMphOq4bnKYWrOa0Li5fPVk1pMp9Hh9cW11sCJuRx0sM4JdGGb/FK+Qd77scgs/0w==
X-Received: by 2002:a2e:b8c4:0:b0:290:6e13:7674 with SMTP id s4-20020a2eb8c4000000b002906e137674mr4521593ljp.31.1677071542753;
        Wed, 22 Feb 2023 05:12:22 -0800 (PST)
Received: from ta1.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id y25-20020a2e7d19000000b0029335c12997sm564383ljc.58.2023.02.22.05.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:12:22 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, darrick.wong@oracle.com, djwong@kernel.org,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 2/3] ext4: fsmap: Consolidate fsmap_head checks
Date:   Wed, 22 Feb 2023 13:12:10 +0000
Message-Id: <20230222131211.3898066-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230222131211.3898066-1-tudor.ambarus@linaro.org>
References: <20230222131211.3898066-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sanity checks should be done the soonest possible to avoid superfluous
computations when user provides wrong data. Gather all the checks on
user provided data in a single method and call it immediately after
copying the data from user.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/fsmap.c | 52 ++++++++++++++++++++++++++++++++++++-------------
 fs/ext4/fsmap.h |  3 +++
 fs/ext4/ioctl.c | 17 +++-------------
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index b5289378a761..a27d9f0967b7 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -9,6 +9,7 @@
 #include "fsmap.h"
 #include "mballoc.h"
 #include <linux/sort.h>
+#include <linux/string.h>
 #include <linux/list_sort.h>
 #include <trace/events/ext4.h>
 
@@ -571,7 +572,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 
 /* Do we recognize the device? */
 static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
-					  struct ext4_fsmap *fm)
+					  const struct fsmap *fm)
 {
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
@@ -583,17 +584,19 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 }
 
 /* Ensure that the low key is less than the high key. */
-static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
-				     struct ext4_fsmap *high_key)
+static bool ext4_getfsmap_check_keys(const struct fsmap *low_key,
+				     const struct fsmap *high_key)
 {
+	u64 l_fmr_phys = low_key->fmr_physical + low_key->fmr_length;
+
 	if (low_key->fmr_device > high_key->fmr_device)
 		return false;
 	if (low_key->fmr_device < high_key->fmr_device)
 		return true;
 
-	if (low_key->fmr_physical > high_key->fmr_physical)
+	if (l_fmr_phys > high_key->fmr_physical)
 		return false;
-	if (low_key->fmr_physical < high_key->fmr_physical)
+	if (l_fmr_phys < high_key->fmr_physical)
 		return true;
 
 	if (low_key->fmr_owner > high_key->fmr_owner)
@@ -604,6 +607,36 @@ static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
 	return false;
 }
 
+int ext4_fsmap_check_head(struct super_block *sb,
+			  const struct fsmap_head *head)
+{
+	const struct fsmap *l = &head->fmh_keys[0];
+	const struct fsmap *h = &head->fmh_keys[1];
+
+	if (memchr_inv(head->fmh_reserved, 0, sizeof(head->fmh_reserved)) ||
+	    memchr_inv(l->fmr_reserved, 0, sizeof(l->fmr_reserved)) ||
+	    memchr_inv(h->fmr_reserved, 0, sizeof(h->fmr_reserved)))
+		return -EINVAL;
+	/*
+	 * ext4 doesn't report file extents at all, so the only valid
+	 * file offsets are the magic ones (all zeroes or all ones).
+	 */
+	if (l->fmr_offset || (h->fmr_offset != 0 && h->fmr_offset != -1ULL))
+		return -EINVAL;
+
+	if (head->fmh_iflags & ~FMH_IF_VALID)
+		return -EINVAL;
+
+	if (!ext4_getfsmap_is_valid_device(sb, l) ||
+	    !ext4_getfsmap_is_valid_device(sb, h))
+		return -EINVAL;
+
+	if (!ext4_getfsmap_check_keys(l, h))
+		return -EINVAL;
+
+	return 0;
+}
+
 #define EXT4_GETFSMAP_DEVS	2
 /*
  * Get filesystem's extents as described in head, and format for
@@ -635,12 +668,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	int i;
 	int error = 0;
 
-	if (head->fmh_iflags & ~FMH_IF_VALID)
-		return -EINVAL;
-	if (!ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[0]) ||
-	    !ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[1]))
-		return -EINVAL;
-
 	head->fmh_entries = 0;
 
 	/* Set up our device handlers. */
@@ -673,9 +700,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	dkeys[0].fmr_length = 0;
 	memset(&dkeys[1], 0xFF, sizeof(struct ext4_fsmap));
 
-	if (!ext4_getfsmap_check_keys(dkeys, &head->fmh_keys[1]))
-		return -EINVAL;
-
 	info.gfi_next_fsblk = head->fmh_keys[0].fmr_physical +
 			  head->fmh_keys[0].fmr_length;
 	info.gfi_formatter = formatter;
diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
index ac642be2302e..8325258def7b 100644
--- a/fs/ext4/fsmap.h
+++ b/fs/ext4/fsmap.h
@@ -8,6 +8,7 @@
 #define	__EXT4_FSMAP_H__
 
 struct fsmap;
+struct fsmap_head;
 
 /* internal fsmap representation */
 struct ext4_fsmap {
@@ -32,6 +33,8 @@ void ext4_fsmap_from_internal(struct super_block *sb, struct fsmap *dest,
 		struct ext4_fsmap *src);
 void ext4_fsmap_to_internal(struct super_block *sb, struct ext4_fsmap *dest,
 		struct fsmap *src);
+int ext4_fsmap_check_head(struct super_block *sb,
+			  const struct fsmap_head *head);
 
 /* fsmap to userspace formatter - copy to user & advance pointer */
 typedef int (*ext4_fsmap_format_t)(struct ext4_fsmap *, void *);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 8067ccda34e4..eb0ecb012e6a 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -874,20 +874,9 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
 
 	if (copy_from_user(&head, arg, sizeof(struct fsmap_head)))
 		return -EFAULT;
-	if (memchr_inv(head.fmh_reserved, 0, sizeof(head.fmh_reserved)) ||
-	    memchr_inv(head.fmh_keys[0].fmr_reserved, 0,
-		       sizeof(head.fmh_keys[0].fmr_reserved)) ||
-	    memchr_inv(head.fmh_keys[1].fmr_reserved, 0,
-		       sizeof(head.fmh_keys[1].fmr_reserved)))
-		return -EINVAL;
-	/*
-	 * ext4 doesn't report file extents at all, so the only valid
-	 * file offsets are the magic ones (all zeroes or all ones).
-	 */
-	if (head.fmh_keys[0].fmr_offset ||
-	    (head.fmh_keys[1].fmr_offset != 0 &&
-	     head.fmh_keys[1].fmr_offset != -1ULL))
-		return -EINVAL;
+	error = ext4_fsmap_check_head(sb, &head);
+	if (error)
+		return error;
 
 	xhead.fmh_iflags = head.fmh_iflags;
 	xhead.fmh_count = head.fmh_count;
-- 
2.39.2.637.g21b0678d19-goog

