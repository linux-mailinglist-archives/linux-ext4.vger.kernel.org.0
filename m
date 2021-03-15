Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52033C49A
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 18:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhCORhu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 13:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhCORhd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 13:37:33 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38238C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v14so13951308pgq.2
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEI6ggn5SoW2/0KPFEbQjW0PF1J0Qkiw9pUTg7iLo2c=;
        b=alPPPMMy+lkVI511JSGTbglyv/aQp7N7q+uAh4JdL3jPDydeG11C9pmO+cQJ2tJg3z
         lK2OeB+Im0goYbc/JQTdMy25luG98xLjmiQShie8n5Q1XG8XuUrqdq6QO5Rxs+OtWStF
         1yOLCva0jtfgZsvz39NvEcdkUC8yZv1DpP5sqKV8+cFOpQX2KbV4qNQ1/WFH/1G70grO
         JYQSLt6rpc5bjAjfeMuk0XQDiswdWM/LJuV3/FfoyFTP1bz0gCmt40ApaC2i0HOT1JvQ
         1pCONM0S5Q/NMGOp9H9t3ytcSu1L28gukrBL+WIJfvZT3+/pW75br3dwlECQUsaJdrXK
         yWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEI6ggn5SoW2/0KPFEbQjW0PF1J0Qkiw9pUTg7iLo2c=;
        b=DxLrqk9n/7b/670A/+n7gdt1ZHk0u/pRJ8RKBbxaTSQVbjeJFS9jMetfnBJSsbSowa
         WskeUdeU9olHK2XnOmAkY2lySfpkI7AmWoQfLomiJtPLYVksV/U4+qtkTXLWSgnNEK5D
         cuqTSaPizPfOJ6lA2G/PfmM9zBcarleAJtK/MiPad9AN7ujm8Y8ag1qSxnCbPoF+gFNl
         6k8hxihr8VttSydoXTmtFYC9BA2MGLS6+yA1R7erZY33kEraF/NtoMm1fAZm6s+fcO/I
         02o+Rp2HnBn1HAViyRwAvZ9jG7Yb9w2pd/Xipn32yuD/IL/vFkeEgvlYg4WsVJnmNr/P
         TQwA==
X-Gm-Message-State: AOAM533w2HxSBgDZ/4JdE911AOEzjd80+pZd2LyGM72rf20GU+deZPzD
        GQUUAY0p1FyRjKT7rXXx8PwC079pUqE=
X-Google-Smtp-Source: ABdhPJz70tczMMJ3HPlfSDSVXNilRsOZFiLbn0K3Nqy53+G4x09v2425ofr9vaDhh6wcP+RDAz5QOw==
X-Received: by 2002:a63:fa4c:: with SMTP id g12mr200199pgk.205.1615829852369;
        Mon, 15 Mar 2021 10:37:32 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1025:7e5a:33cc:4e9c])
        by smtp.googlemail.com with ESMTPSA id p190sm13520178pga.78.2021.03.15.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:37:31 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v4 4/6] ext4: add MB_NUM_ORDERS macro
Date:   Mon, 15 Mar 2021 10:37:14 -0700
Message-Id: <20210315173716.360726-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
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
2.31.0.rc2.261.g7f71774620-goog

