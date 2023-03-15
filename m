Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAB16BAF20
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 12:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjCOLV0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCOLUn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 07:20:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FDB23A50
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y14so19043950ljq.4
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRjHvXYdzY6RBtzYq78wcB3v20K0fYO5Lj3dEieV5ms=;
        b=Zk5/OvPNEUGHZNzXPFS7SNxNeHRC+swL26wjcpKA4SeZortr3LkXkcgftDcBVXtvLB
         u/hJeXix0zwZnjbiWZYWYBkghvHBL5YzRrhiAlV59V1YZHbZp2qelFoLlFY5kgAZWgdH
         8JM7LgDcCSBaBLKg/Hw68F4QSJ69DUQRmIJT0AZ2onoRInB44ocRTZ8LbL4DGiHK7Edt
         t/MKTghgcARYiGzIhxh3KwCikfk4rSya0h2Rmd8HPtECXN/BggQoIZJR2mkvoaDGP8a9
         /opvsR1ejLoPN4GwKdJyrprV9SYvXIrALvfcmnQ2Rh0tpkmxUXQWMgJq7qJ7f77T01kB
         tMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRjHvXYdzY6RBtzYq78wcB3v20K0fYO5Lj3dEieV5ms=;
        b=KtNpPcU3PQzrwTA+X1ZAPXc+utvLpSMFxBipVNxVmc2qEz0APC1Avxjw85ikqsbIJX
         f+BkUPtg87Jqb5wTwWaShBrfF8f4vQwfMsSqrhB/EY1l3GTIvZozCyOSF6ghekHernpU
         pH3GlgyrNAp1XC1V+rqk5c30UglB9OWo03loA9G2ui7/kBEGsaLnrl4y1DTBgJwreZvD
         CpY3h0A1QPc46i3B96gILLoNVbOYTXvmkaD5Yy1/fgLQ8JCATWAKEqEfokq4GRklvYUS
         UYCu9mYXnqEulSWifbJ93b5FGd+OLaIedzNkZ4l0THi5DJC5N/zhEu0+I+Sn2wBngZmi
         cBog==
X-Gm-Message-State: AO0yUKWI99JysXIU5q87yKgX04VgiSv2oHMc4879V67jo0RDMYx0BaYG
        qt5ICVZIqIyQIZpEg545WSbJyw==
X-Google-Smtp-Source: AK7set9zGO7zsvAJEftiW/xAdoX2qB+imoDPktguVuYNRtCIguMHy+bE8WursDqHZzA2KC1V5mPgvg==
X-Received: by 2002:a05:651c:b07:b0:295:941c:7b2 with SMTP id b7-20020a05651c0b0700b00295941c07b2mr1001129ljr.12.1678879218115;
        Wed, 15 Mar 2023 04:20:18 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e92c2000000b00295da33c42dsm817410ljh.15.2023.03.15.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:20:17 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 3/5] ext4: fsmap: Consolidate fsmap_head checks
Date:   Wed, 15 Mar 2023 11:20:09 +0000
Message-Id: <20230315112011.927091-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315112011.927091-1-tudor.ambarus@linaro.org>
References: <20230315112011.927091-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The sanity checks on the user provided data were scattered in three
representations of the fsmap keys:
1/ the keys from struct fsmap_head in ext4_ioc_getfsmap() -> contain the
   data copied from the user.
2/ the keys from struct ext4_fsmap_head -> contain the ext4 internal
   representation of the keys. These are the same keys as in 1/ but with
   the fmr_physical and fmr_length shifted to right by
   sb->s_blocksize_bits, see ext4_fsmap_to_internal(). The sanity checks
   on these keys were done in ext4_getfsmap(), see where
   ext4_getfsmap_is_valid_device() and ext4_getfsmap_check_keys() are
   called.
3/ dkeys in ext4_getfsmap() -> local keys used to query the device. These
   are 2/ but with the low key bumped by fmr_length. The low key is
   bumped because userspace is allowed to use the last mapping from the
   previous call as the low key to the next. In consequence, the low key
   is incremented to ensure we return the next mapping. The low key
   from dkey was checked together with the high key fron 2/ by calling
   ext4_getfsmap_check_keys().

Having the sanity checks on user provided data scattered along these
three representations of the keys is not only difficult to follow but
also inefficient in case one of the checks returns an error because we
waste CPU cycles by copying data and preparing other local structures
that won't be used in case of errors.

Since 2/ and 3/ are just adapted copies of 1/, do all the checks
directly on 1/. Gather all the checks done on the user data in a single
method and call it immediately after copying the data from user. One may
notice that I introduced a local u64 l_fmr_phys in
ext4_getfsmap_check_keys() where I bumped the low key by fmr_length
in order to preserve the validation check that was done on the low key
from 3/.

With this we should have better clarity about the sanity checks and also
better efficiency in case the user provides bad data. No change in
functionality. Patch tested with the ext4 fsmap xfstests 027, 028, 029.
All passed.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v2:
- split patch for easier review
- rewrite commit message

 fs/ext4/fsmap.c | 48 ++++++++++++++++++++++++++++++++++++------------
 fs/ext4/fsmap.h |  2 ++
 fs/ext4/ioctl.c | 19 +++----------------
 3 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 7765293bfa5d..463e8165b1e9 100644
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
+					  struct fsmap *fm)
 {
 	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
 	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
@@ -583,17 +584,19 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
 }
 
 /* Ensure that the low key is less than the high key. */
-static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
-				     struct ext4_fsmap *high_key)
+static bool ext4_getfsmap_check_keys(struct fsmap *low_key,
+				     struct fsmap *high_key)
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
@@ -604,6 +607,34 @@ static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
 	return false;
 }
 
+int ext4_fsmap_check_head(struct super_block *sb, struct fsmap_head *head)
+{
+	const struct fsmap *l = &head->fmh_keys[0];
+	const struct fsmap *h = &head->fmh_keys[1];
+
+	if (head->fmh_iflags & ~FMH_IF_VALID)
+		return -EINVAL;
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
@@ -635,10 +666,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	int i;
 	int error = 0;
 
-	if (!ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[0]) ||
-	    !ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[1]))
-		return -EINVAL;
-
 	head->fmh_entries = 0;
 
 	/* Set up our device handlers. */
@@ -671,9 +698,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	dkeys[0].fmr_length = 0;
 	memset(&dkeys[1], 0xFF, sizeof(struct ext4_fsmap));
 
-	if (!ext4_getfsmap_check_keys(dkeys, &head->fmh_keys[1]))
-		return -EINVAL;
-
 	info.gfi_next_fsblk = head->fmh_keys[0].fmr_physical +
 			  head->fmh_keys[0].fmr_length;
 	info.gfi_formatter = formatter;
diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
index ac642be2302e..e7c510afd672 100644
--- a/fs/ext4/fsmap.h
+++ b/fs/ext4/fsmap.h
@@ -8,6 +8,7 @@
 #define	__EXT4_FSMAP_H__
 
 struct fsmap;
+struct fsmap_head;
 
 /* internal fsmap representation */
 struct ext4_fsmap {
@@ -32,6 +33,7 @@ void ext4_fsmap_from_internal(struct super_block *sb, struct fsmap *dest,
 		struct ext4_fsmap *src);
 void ext4_fsmap_to_internal(struct super_block *sb, struct ext4_fsmap *dest,
 		struct fsmap *src);
+int ext4_fsmap_check_head(struct super_block *sb, struct fsmap_head *head);
 
 /* fsmap to userspace formatter - copy to user & advance pointer */
 typedef int (*ext4_fsmap_format_t)(struct ext4_fsmap *, void *);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 77b0198a0f48..a1a11832f011 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -873,22 +873,9 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
 
 	if (copy_from_user(&head, arg, sizeof(struct fsmap_head)))
 		return -EFAULT;
-	if (head.fmh_iflags & ~FMH_IF_VALID)
-		return -EINVAL;
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
2.40.0.rc1.284.g88254d51c5-goog

