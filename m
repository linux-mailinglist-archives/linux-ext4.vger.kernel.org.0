Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21798348534
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 00:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhCXXUJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Mar 2021 19:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbhCXXTg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Mar 2021 19:19:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03761C06174A
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g15so76739pfq.3
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74UYMQrBUG1VGrFRPh9Pu0JsBw0pt0Wl8FFHrW4eh7k=;
        b=MEw2+hScXSQqNqKD8cpJEz7aur+AmYLuAvaj6VdekanY8fDtd8BjW3o//puhExVKAr
         TOcKO0GVvoIAXkRutuhz9tYI7RKIOwFNhk5i6PysqIXxM50RBOw6nn716zPY3nncbUOm
         WRquDMg5PdmMmyAX4WE4Bu23w3Mo/p2/tO6v2cdznp3Sezz8NQNFyL+0zt59/Co9ZmkK
         P/4fBWcu2MK3L+w/kN2Qa/UkXLLNZ+8PniWcQ8ooaKSPvkdBIH4tAW0NhV75zMZGDNKy
         I+zsNT0NBRkq4rEph0cpx1+nSU5QKZjBLj4shXxKYDqLrhGSWjVTcRvhbe415blRKBEp
         Atig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74UYMQrBUG1VGrFRPh9Pu0JsBw0pt0Wl8FFHrW4eh7k=;
        b=GNsieZ3dYS/eYKaBSqyhHL4SwFR1f9KD/7QrsO6mVIYvUzQCnIQZLuq5bCY7KCiLUr
         q8xm//MvxXQ2GyTKS97RpL3RIpJ1FtAi9bRdyN3oJ0ZK7tm3lH2bPEztuj90xg5ufU95
         s15MXjQnNr+YIG+vrVcDB15t3oADowfBFQlsi3oi1BKSO5q3sM+PPoCONG3VLMOrgId+
         6aGqjMb44G9O5NDHR80fo4IVbS47ov0uX0Xxqek0LnT4tCBKtu/baOT3AxeH2r5iqkR1
         L1GXXskUNnM3gSlexerSqOGVh2QezRQwR4rhFEmaqxvKwF2rBt6Il94KMLQAM5P+LoV6
         96VA==
X-Gm-Message-State: AOAM531BTPhfzxYOqBVhTQg3ZvkBKjLRLM+7wvFGJV4cIO5M1rntQEbU
        6AQj8qtbX4CZr/QZOGpTx/vAK0J9K/E=
X-Google-Smtp-Source: ABdhPJzhTNY17QZc3KeYz6dAyueADzPGOESpihrN0qEUTsgsMCZ0gcA3p9m6xtm7VVpopOShrbUHrQ==
X-Received: by 2002:a17:902:f242:b029:e4:6dfc:8c1f with SMTP id j2-20020a170902f242b02900e46dfc8c1fmr5899425plc.0.1616627975135;
        Wed, 24 Mar 2021 16:19:35 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:f8fe:8e5d:4c9f:edfd])
        by smtp.googlemail.com with ESMTPSA id z3sm3629928pff.40.2021.03.24.16.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:19:34 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v5 4/6] ext4: add MB_NUM_ORDERS macro
Date:   Wed, 24 Mar 2021 16:19:14 -0700
Message-Id: <20210324231916.2515824-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
References: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
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

