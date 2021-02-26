Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04C326784
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 20:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBZThS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 14:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhBZThI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 14:37:08 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC08C061786
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id h4so6791468pgf.13
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehztkei4gx4GJL4XqgE7HllgJw9diK2v2esb7YxIR+s=;
        b=RjAghWiOn4kFzVW57WhUfUtC/8NoCa72DrFBMXav+LYyX1d1MgQSrqbicZOgsYMG6l
         ewhRRFKBDZfACuL1aRDhjN7QYB8yx0XW2OB3X0tPrYE6UCsE25z6/r95kC2MmUQBhv8q
         gxxUcXblR1wEBmBKBVPEC2JE6NchpF5cSPx3KhA39DO/3DF/tkTEqRMR5I8uU+hbkhA0
         pJnvbzQ5xnLdPVJC3PstU95XXpDdzzYULdF+0WhcHPbMH5YzSLkBem5Ext5bGYgghVSK
         UP3M/2HQkeq/m5RIAtAwyJMF8Zp96u84LcSlPSQlzqBNt1vTLaijItCBcyEuaVtuZLUw
         HK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehztkei4gx4GJL4XqgE7HllgJw9diK2v2esb7YxIR+s=;
        b=PMb8HY6rZM4Dg4yZ+zFmerv0OcYSGD0WV7TxlLvdw1PTy/YYuFnfk68VJGyN6LphSK
         vogf4D+kKyu2RdF5lvyUriLnMRFM5HW7xzv2tuOtDSeRhgOs44OXL26kQvbUMeBwAuXF
         d/pA7+bxHcaN/wy7oyajoJh7SlKOy9Ej28gwXeehYlOS6wHQYydvL88JRbvK1wgKKYlt
         KtMGaWff4HEGzdTU++9SR6irYpUjoDZ5M6pGwyOarnhOPgXFycMMDi0+T+wklO/Z9Y28
         iieGCRr1CVMA8IImfKOfbweGk9o3cItaF0Raz23DYKNM0rK7Q7CVJLRNt+rKfWQYkHB8
         z8MQ==
X-Gm-Message-State: AOAM532fjHNGBFZwr/q+tsZeOTp6rB45lq871yD3pf484JDtO9KL7qGE
        HULla9U9+oOzbFiYLP42dTuKJ714cw0=
X-Google-Smtp-Source: ABdhPJxfhkuKQyzqae7BBPD1n9kqFYjthZB/qlE1SreSh5PQPNiHdVMQm9mvtdgllYJuHHl+Ze3t6w==
X-Received: by 2002:a63:5301:: with SMTP id h1mr4403053pgb.180.1614368187501;
        Fri, 26 Feb 2021 11:36:27 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:e88c:d103:27dc:612d])
        by smtp.googlemail.com with ESMTPSA id x129sm2935041pfc.96.2021.02.26.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:36:26 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 3/5] ext4: add MB_NUM_ORDERS macro
Date:   Fri, 26 Feb 2021 11:36:10 -0800
Message-Id: <20210226193612.1199321-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
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
index 92c4edaa1afc..161412070fef 100644
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
2.30.1.766.gb4fecdf3b7-goog

