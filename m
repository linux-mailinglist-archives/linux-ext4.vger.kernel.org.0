Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD63830901A
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Jan 2021 23:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhA2Wa6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Jan 2021 17:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhA2Waw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Jan 2021 17:30:52 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8FEC061574
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o7so7626344pgl.1
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aoboxnj5WqsiQcKg0g2VI981APzucSJBjY9UVFTXo3Q=;
        b=IAWr+FjtbxOkIAJrFICboDp4O0XGdebfCwob+fNloPfStBxsra5wWDpl0EdMKGK6/l
         DLvyauyV9pF39Mx1pwOcs25JVuNT4uSGTrOueNjwKYo02jbugWEU9ecflIF+sjWti+Ky
         CLAkMeLjs4mDCWwysKZTPhL1hC8cnrsSlIjil+bPNVwPdABnXPblXWUoD0csNGEhArNv
         pwwMFpwD7uyFgyabiL46ngQ7LP7cJ/iF2lyFxVLOAiR1CIghLIvH+n2MgE3lsRq4nMY+
         mLKPlSVNOz+StnxlbQmhqBfrH9cg/SqBu9akWw8aBWNpYbFRVgUZR1El5PDIZvif1LmU
         X4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aoboxnj5WqsiQcKg0g2VI981APzucSJBjY9UVFTXo3Q=;
        b=ojwTONa97ghUKgpeKLadVKM6+MffInbLAB8g1dSVDH4vOvQr4nnQxXUD8k+gqGF0ti
         3MsZ69LCGovBKbwDpl+baR5mYnzFTtbai2DBqDFCD+C7UkAuEFprfYpJNdmMdQgLl4rJ
         UKWUB2qBD90CS3xEFEyg6IUiC10MeYd2LpLOyk4phORrkYjFeFfuS67PhSC/NAMP8268
         N1pvV3P6ARoq/Xo8A1SeNYlKbxbZJt2R7YrEjPnI6i0dJeO1GY5a+0heaRJEAtj8Y2lR
         pm85Fy9eQjRodH325YkY3WcJfNThulz0O4Fc/33nY3IkRTDhf7/F0C+/L/mEJpNs9tBT
         lLng==
X-Gm-Message-State: AOAM532Q2DX3dxtngXOVJ3S5vEye+8Pg4tO4yPljaUG2CYeB9w3rR30j
        NHTzA+g5nsVfgavc//KUsw1yfVoKxmY=
X-Google-Smtp-Source: ABdhPJzGqcEJGJYXJCBU9+YCwut9wiv1I0RVRHRIw0iZilk1h56DeFD9pg79aa4j9uNbpeRUr0wKMg==
X-Received: by 2002:aa7:9834:0:b029:1bc:8866:e270 with SMTP id q20-20020aa798340000b02901bc8866e270mr6298442pfl.17.1611959408534;
        Fri, 29 Jan 2021 14:30:08 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id d14sm9719358pfo.156.2021.01.29.14.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:30:07 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/4] ext4: add MB_NUM_ORDERS macro
Date:   Fri, 29 Jan 2021 14:29:28 -0800
Message-Id: <20210129222931.623008-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
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
---
 fs/ext4/mballoc.c | 15 ++++++++-------
 fs/ext4/mballoc.h |  5 +++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99bf091fee10..625242e5c683 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -756,7 +756,7 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
 
 	grp->bb_largest_free_order = -1; /* uninit */
 
-	bits = sb->s_blocksize_bits + 1;
+	bits = MB_NUM_ORDERS(sb) - 1;
 	for (i = bits; i >= 0; i--) {
 		if (grp->bb_counters[i] > 0) {
 			grp->bb_largest_free_order = i;
@@ -1930,7 +1930,7 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
 	int max;
 
 	BUG_ON(ac->ac_2order <= 0);
-	for (i = ac->ac_2order; i <= sb->s_blocksize_bits + 1; i++) {
+	for (i = ac->ac_2order; i < MB_NUM_ORDERS(sb); i++) {
 		if (grp->bb_counters[i] == 0)
 			continue;
 
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
@@ -2806,7 +2806,7 @@ int ext4_mb_init(struct super_block *sb)
 	unsigned max;
 	int ret;
 
-	i = (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_offsets);
+	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
 
 	sbi->s_mb_offsets = kmalloc(i, GFP_KERNEL);
 	if (sbi->s_mb_offsets == NULL) {
@@ -2814,7 +2814,7 @@ int ext4_mb_init(struct super_block *sb)
 		goto out;
 	}
 
-	i = (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_maxs);
+	i = MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_maxs);
 	sbi->s_mb_maxs = kmalloc(i, GFP_KERNEL);
 	if (sbi->s_mb_maxs == NULL) {
 		ret = -ENOMEM;
@@ -2840,7 +2840,8 @@ int ext4_mb_init(struct super_block *sb)
 		offset_incr = offset_incr >> 1;
 		max = max >> 1;
 		i++;
-	} while (i <= sb->s_blocksize_bits + 1);
+	} while (i < MB_NUM_ORDERS(sb));
+
 
 	spin_lock_init(&sbi->s_md_lock);
 	spin_lock_init(&sbi->s_bal_lock);
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
2.30.0.365.g02bc693789-goog

