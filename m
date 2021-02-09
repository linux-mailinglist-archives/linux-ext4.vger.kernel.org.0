Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AFE3157E6
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 21:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhBIUoO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 15:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhBIUhA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 15:37:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A6C0698D5
        for <linux-ext4@vger.kernel.org>; Tue,  9 Feb 2021 12:29:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gx20so2370617pjb.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Feb 2021 12:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vo4q+8O2vAkuEJMBuosHNPgWOrCpbN9Drl+Ko4u9Ik0=;
        b=hehygPpglKj3xIcft9TC3O9uKKrrzF0OS9OzXgodEMmoMS4db0k+FQwlyUticB12GQ
         sYosDLBwe0TdNf0b9tSE1mC5gYjFyb2FxGhbmtk5vwuQg56iez7Sts0eOFYC1IkKJrfy
         Y24TwI3cFIgWb1LM50pNAQD6Si2Cq2M6HwqI6dOvr1VybcMJjKIl2B12sY30Mh34AkKt
         VBavbR2nkDRsTpVAyHgrKyCtQPhVmXyrZiJVxNGceXH6hV3rw1aQgXXMIX+jEFmwzI4B
         pcVjuoiQDVEeRoHGvoZPaI+iknULLUX/72oOoDeJCyOF+rMa67U7M463xbCdpm0y8IC0
         NVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vo4q+8O2vAkuEJMBuosHNPgWOrCpbN9Drl+Ko4u9Ik0=;
        b=TjxzWvViQ5R3JPiag0KbjMCYch4GAnwRHs0TQoTvFpHM5rFJQa/b2NbCV4Utuo9Jmw
         Kbumqxpxv1ZAruoT4uEhSZYP26MSOGV4SW70ZgEP0RqQ0kCpv5AbqGIJnsgcQtirBb9F
         OJZXD53nupwHQkgDLZZNHZOGPtM8sbFslWAHiecVzUKG6LMyQlC1vf3mkCVzCrH3jXrO
         /KbjHzlT733nYqaiAtbFoeoI6eFo3ky3W1/Lq6F9g3an4/XmwGabdDXZ+onTAXUfJdsA
         1ipaPftsYEfUdbF9TV6NQ4VOgR/iupWK0/jai6mA6k2YBkKG+6pxGLOIf50kcL6jdjug
         zF/g==
X-Gm-Message-State: AOAM531UBCguqNrxv9ESgm5Ei5fEjdIZPdfaDWHAhBSRADZ2fMRQi+8w
        EyFmv7ecAuU0PoyJR9FvV3/5WAenexM=
X-Google-Smtp-Source: ABdhPJx4LsS7+65Dom5WhjZ1vno21EPNtwWFU6Ffv3h7mFHiybE7XVD4fFrinzaljOEiwA+MnEKwZQ==
X-Received: by 2002:a17:90a:8906:: with SMTP id u6mr5754030pjn.223.1612902548089;
        Tue, 09 Feb 2021 12:29:08 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1d7c:b2d9:c196:949c])
        by smtp.googlemail.com with ESMTPSA id p12sm3325827pju.35.2021.02.09.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:29:07 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, bzzz@whamcloud.com, artem.blagodarenko@gmail.com,
        sihara@ddn.com, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 3/5] ext4: add MB_NUM_ORDERS macro
Date:   Tue,  9 Feb 2021 12:28:55 -0800
Message-Id: <20210209202857.4185846-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A few arrays in mballoc.c use the total number of valid orders as
their size. Currently, this value is set as "sb->s_blocksize_bits +
2". This makes code harder to read. So, instead add a new macro
MB_NUM_ORDERS(sb) to make the code more readable.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/mballoc.c | 15 ++++++++-------
 fs/ext4/mballoc.h |  5 +++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fffd0770e930..b7f25120547d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -756,7 +756,7 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 
 	grp->bb_largest_free_order = -1; /* uninit */
 
-	bits = sb->s_blocksize_bits + 1;
+	bits = MB_NUM_ORDERS(sb) - 1;
 	for (i = bits; i >= 0; i--) {
 		if (grp->bb_counters[i] > 0) {
 			grp->bb_largest_free_order = i;
@@ -1928,7 +1928,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 	int max;
 
 	BUG_ON(ac->ac_2order <= 0);
-	for (i = ac->ac_2order; i <= sb->s_blocksize_bits + 1; i++) {
+	for (i = ac->ac_2order; i < MB_NUM_ORDERS(sb); i++) {
 		if (grp->bb_counters[i] == 0)
 			continue;
 
@@ -2314,13 +2314,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	 * We also support searching for power-of-two requests only for
 	 * requests upto maximum buddy size we have constructed.
 	 */
-	if (i >= sbi->s_mb_order2_reqs && i <= sb->s_blocksize_bits + 2) {
+	if (i >= sbi->s_mb_order2_reqs && i <= MB_NUM_ORDERS(sb)) {
 		/*
 		 * This should tell if fe_len is exactly power of 2
 		 */
 		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) == 0)
 			ac->ac_2order = array_index_nospec(i - 1,
-							   sb->s_blocksize_bits + 2);
+							   MB_NUM_ORDERS(sb));
 	}
 
 	/* if stream allocation is enabled, use global goal */
@@ -2850,7 +2850,7 @@ int ext4_mb_init(struct super_block *sb)
 	unsigned max;
 	int ret;
 
-	i = (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_offsets);
+	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
 
 	sbi->s_mb_offsets = kmalloc(i, GFP_KERNEL);
 	if (sbi->s_mb_offsets == NULL) {
@@ -2858,7 +2858,7 @@ int ext4_mb_init(struct super_block *sb)
 		goto out;
 	}
 
-	i = (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_maxs);
+	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_maxs);
 	sbi->s_mb_maxs = kmalloc(i, GFP_KERNEL);
 	if (sbi->s_mb_maxs == NULL) {
 		ret = -ENOMEM;
@@ -2884,7 +2884,8 @@ int ext4_mb_init(struct super_block *sb)
 		offset_incr = offset_incr >> 1;
 		max = max >> 1;
 		i++;
-	} while (i <= sb->s_blocksize_bits + 1);
+	} while (i < MB_NUM_ORDERS(sb));
+
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 7597330dbdf8..02861406932f 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -78,6 +78,11 @@
  */
 #define MB_DEFAULT_MAX_INODE_PREALLOC	512
 
+/*
+ * Number of valid buddy orders
+ */
+#define MB_NUM_ORDERS(sb)		((sb)->s_blocksize_bits + 2)
+
 struct ext4_free_data {
 	/* this links the free block information from sb_info */
 	struct list_head		efd_list;
-- 
2.30.0.478.g8a0d178c01-goog

