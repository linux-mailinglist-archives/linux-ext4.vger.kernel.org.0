Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF01351853
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 19:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhDARpl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbhDARiO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 13:38:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832CEC0319CD
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so1929733pfn.6
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMyC4jaaT6AKUFB5WVyM4jAER9YxPH8F73aAvw9asJ0=;
        b=EQrAB6oknCmPd/d29cc/6sPju1H13Dp/EKkjcEweJiUfSc/ftktRh+QiUqQlm211EH
         URMLhjgwTmxWfu/EPC7pupU7HBB0FbnNeqKeMFo1bG0fp2NPYWPuu2C5HK6cTGuf7jMU
         jlgel5SW54kSc99dYWeritkEel52hqUXl18M5H0Iu2n2ZA+XKanrinubK8/4zeMgfSs0
         9VVYhQVkA7b8j0ovg+2WYi1+Z47/eT03Eo4JE6jyM8puAMgDV7F/8EOKDrdUa7Y7EA8g
         2edTHx9q0c/khaPOSd7/ekDRTYoM8bZ/VG+vjpSr0TlxGIJk8NxNakm0+1veNmXZ4VCX
         Z+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMyC4jaaT6AKUFB5WVyM4jAER9YxPH8F73aAvw9asJ0=;
        b=HxGkDHDlRJJoYIK8vdFDYKX6KKC8WBkZ5BiPucE2EI6KqAr/L6E6JnGwwqZoiIHaV0
         zqP0gSM1U4AEzx8Y/HXHCMcvBabFenL8Rin465j1YlBNAwpLyYNH/Ty/nE4tLKf37rn6
         21QGj+Fw/qPnAQIjLKfS4tbkdOC7K9DQq1BOXNEZqOYbtHBlwEpYLt6CA9tx8XsNsUcJ
         fc0gEK+YmVlha8DjNHh8B16GRhRXTuJltc0qCis36HxHx+KRd0Vm833Y7JWKohZDjjP3
         vShT+y6wQNORDumkp/iWvZa3e13RIZD3jJ1RpeLXLycsSSyq4XHLaJqIitiiP08v3gCh
         W4ng==
X-Gm-Message-State: AOAM532qRc37Wb0OscUHe2ib+kC2ZaJR+Dwoilex5d370kqLIoVeBrG5
        09tgbSKAgLmbAAeLC4m1M4y6ZLCPDQo=
X-Google-Smtp-Source: ABdhPJz0EHkn8yyfMs389FJiaA76lMPFPI2KX4JXuLLKWquZWlyN59t892ELpRKw2rBkSf9MnwvZUQ==
X-Received: by 2002:a65:5584:: with SMTP id j4mr8416237pgs.356.1617297702660;
        Thu, 01 Apr 2021 10:21:42 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:41 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v6 4/7] ext4: add MB_NUM_ORDERS macro
Date:   Thu,  1 Apr 2021 10:21:26 -0700
Message-Id: <20210401172129.189766-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
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
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 19 ++++++++++---------
 fs/ext4/mballoc.h |  5 +++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a4b71c9c1e66..15127d815461 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -756,7 +756,7 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 
 	grp->bb_largest_free_order = -1; /* uninit */
 
-	bits = sb->s_blocksize_bits + 1;
+	bits = MB_NUM_ORDERS(sb) - 1;
 	for (i = bits; i >= 0; i--) {
 		if (grp->bb_counters[i] > 0) {
 			grp->bb_largest_free_order = i;
@@ -957,7 +957,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 			grinfo->bb_fragments = 0;
 			memset(grinfo->bb_counters, 0,
 			       sizeof(*grinfo->bb_counters) *
-				(sb->s_blocksize_bits+2));
+			       (MB_NUM_ORDERS(sb)));
 			/*
 			 * incore got set to the group block bitmap below
 			 */
@@ -1928,7 +1928,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 	int max;
 
 	BUG_ON(ac->ac_2order <= 0);
-	for (i = ac->ac_2order; i <= sb->s_blocksize_bits + 1; i++) {
+	for (i = ac->ac_2order; i < MB_NUM_ORDERS(sb); i++) {
 		if (grp->bb_counters[i] == 0)
 			continue;
 
@@ -2107,7 +2107,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 		if (free < ac->ac_g_ex.fe_len)
 			return false;
 
-		if (ac->ac_2order > ac->ac_sb->s_blocksize_bits+1)
+		if (ac->ac_2order >= MB_NUM_ORDERS(ac->ac_sb))
 			return true;
 
 		if (grp->bb_largest_free_order < ac->ac_2order)
@@ -2315,13 +2315,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
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
@@ -2873,7 +2873,7 @@ int ext4_mb_init(struct super_block *sb)
 	unsigned max;
 	int ret;
 
-	i = (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_offsets);
+	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
 
 	sbi->s_mb_offsets = kmalloc(i, GFP_KERNEL);
 	if (sbi->s_mb_offsets == NULL) {
@@ -2881,7 +2881,7 @@ int ext4_mb_init(struct super_block *sb)
 		goto out;
 	}
 
-	i = (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_maxs);
+	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_maxs);
 	sbi->s_mb_maxs = kmalloc(i, GFP_KERNEL);
 	if (sbi->s_mb_maxs == NULL) {
 		ret = -ENOMEM;
@@ -2907,7 +2907,8 @@ int ext4_mb_init(struct super_block *sb)
 		offset_incr = offset_incr >> 1;
 		max = max >> 1;
 		i++;
-	} while (i <= sb->s_blocksize_bits + 1);
+	} while (i < MB_NUM_ORDERS(sb));
+
 
 	spin_lock_init(&sbi->s_md_lock);
 	sbi->s_mb_free_pending = 0;
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index e75b4749aa1c..68111a10cfee 100644
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
2.31.0.291.g576ba9dcdaf-goog

