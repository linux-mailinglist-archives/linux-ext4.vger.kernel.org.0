Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B96FB400
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 17:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjEHPmu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjEHPml (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 11:42:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C63E8A5A
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 08:42:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4efd6e26585so5293564e87.1
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683560558; x=1686152558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C65zGBFPLNFkVp/runw3DFG0fev35GhURpa6eUFcnx0=;
        b=lS7kGKZVzmjS1AsLR0asaenuwAAAoujI/myicSAo+9Q/8BJqyc4kjsVZFJ7bBCZNSs
         TTdlGZRPqdfVDsnLB7/tVG5llsOFHdKl8xCkvGNPoMEDxRxsC7KlrJieMWO+pScDGELc
         haOuapUw65E2wpn/VaQ3GruU7D1im7zadmD0LnpDDNso7QnUdlybgkICrYCC6JoKOwy2
         nbfChkeXdp6aac9436VKcTuWyFHS7m/KQV6/baFX4B3EVhRUIQWVC083jk+s4/iYSjAr
         GCag4zPbzVE1xOC8vjNYaz3O8t+9noY7jRpZldpv98THKO/O1mfL1ZizL+irBbVnK+jn
         PrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560558; x=1686152558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C65zGBFPLNFkVp/runw3DFG0fev35GhURpa6eUFcnx0=;
        b=MQGvashHUvD03hrB8Xhu58itEetJbZZTKVeBiuLmuszA/fO7AyvmP5iDmTnaZ1ZCpJ
         p0os9lxQskC/7KWiPecIXhAIWdrqmKHRDerUp/uUwylgkY811udEl6vMwdwZ9SBhWFC8
         Swftyb7YKZVR+YaT2Jkrl8JOjPQA45NtPdn0QRxQGIZR3diT+ZBkdsgzKh/+yrS6aub0
         gc/yJEoQeHSRrjIp4wYi3Nhnv++uCxLOeQLL17Uu4vnx+muLEKeleqHQba0Dpui2S/hy
         u1sBfNF7xiNEfPMcQhh8kyBkIP3nEbZ+n0l3M7noU5zKXWIYXKXzfxYfThdcNc55gEbQ
         6HLw==
X-Gm-Message-State: AC+VfDwvK9Ua6CQBVPsOz9f8pa81SIBkt8kNXJY/YT5D9q48lqM+YoEX
        j6DacdfAHJFDrVyQb34nGG3HxVSM+OvW85PmZvvxqg==
X-Google-Smtp-Source: ACHHUZ4JS1d2tzIliPVw1WY/z5z8bAjtfYFoRhcIHYt69sZZf/3BhTO828TW4UkWaGW/6cLIMXpy+g==
X-Received: by 2002:a2e:9f49:0:b0:2ac:8754:e534 with SMTP id v9-20020a2e9f49000000b002ac8754e534mr2920355ljk.6.1683560558429;
        Mon, 08 May 2023 08:42:38 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e9815000000b002ad9b741959sm17720ljj.76.2023.05.08.08.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:42:37 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v2 3/5] ext4: fsmap: Consolidate fsmap_head checks
Date:   Mon,  8 May 2023 15:42:28 +0000
Message-ID: <20230508154230.159654-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508154230.159654-1-tudor.ambarus@linaro.org>
References: <20230508154230.159654-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index a585d96567b5..11d83ee6ba89 100644
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
2.40.1.521.gf1e218fcd8-goog

