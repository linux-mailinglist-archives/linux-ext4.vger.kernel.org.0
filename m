Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE82B80E0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgKRPl0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgKRPl0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788A4C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so2922397ybj.14
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ah/XmUUyjFZp1jiQfzR6JQ8mjXk0RTYLoGUqXyyD6vI=;
        b=VGT6lZbySZI/nnLx13YxQ9osEpSJrRfznaD8bDKv9FNHt+HiNKp+mDwqXNNN/tz/HA
         rzL01A51MF12D/B/WiI0D8WuBdERWveSe0Z0rKJJQ8KqGNw7cIiFGXWPH/mdw+0a85YY
         W+zAewQ4PVSuDp7Y5tgUVrnvI9zYzgsvbPwy7d63vf56kbc5yRmp2zNMb4LrLnQHmMX9
         VPzlLwaPu3iGnNojzvQR6P/0io092IHCNE9XFVrGskT30fbd0vcHFZ+ppK9bGQ4W19ug
         3F9bS096KtxGQHS6MAi6EvWZinB6pNU0BgtDQgiLiix2dhiuCad3Z1oviTojrQRHsaYo
         BNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ah/XmUUyjFZp1jiQfzR6JQ8mjXk0RTYLoGUqXyyD6vI=;
        b=MWc8rxngWAunnRpDapmG571TUYj7glcscqR/W0YL08EJWXjdNxINpfvYF8GmmOROs5
         OVt15wShNr7HpW6QL60MmnVuQPxggo3aTlZpki6Lo08X7+MZ5Qa7KstRUnReKLqhtlcn
         8WcGB9fufzAiIC1TgRHejRGrGlgIixaZpTcIzlAXNHqKCaWEJO+ecftvJ1GOUeEIpYKC
         wGVy5KQpOJZ2oNcpTqlVMrpk6142YRwAsMJuikI+0NicJP6c5MDiyflOg5vTfmhWSyoM
         YJnyeeuBX+JvmSplaBiuMmmA5XC7aYrOZyRNVOshpEBl6OS833noqRuY21Bmxg5/A2dR
         jwlw==
X-Gm-Message-State: AOAM531jRGcVq5KDekXmU31/YKDbFL1O0rvfOuXp1djpeJYcs/MAGamF
        62CLYzBLg9sWPAVU/YsRfcddFaPZeOI5cryJPN33xi4JoffkmQyTaJzq/Sx2bG0wSt46fYEtPI0
        999UssgD/WZ6HwyYJY2tc6Po2QWFawwzeUNrw2R4L0+/kWyllb2lDz/Dyu4Yrj4PVbSKuVqAlIs
        8iX59F17M=
X-Google-Smtp-Source: ABdhPJy0at4wlUgRbMtvX6WvkzouiiJ07TfPe5XiFNMKspgV5vGqGCPJP65eXGm6JoCjX9r1Yoi1coFzy20U6bzCbgk=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:3614:: with SMTP id
 d20mr2751607yba.415.1605714083648; Wed, 18 Nov 2020 07:41:23 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:17 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-32-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 31/61] e2fsck: split and merge invalid bitmaps
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Invalid bitmaps are splitted per thread, and we
should merge them after thread finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 49bdba21..29954e88 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2379,6 +2379,62 @@ out:
 	return retval;
 }
 
+static void e2fsck_pass1_copy_invalid_bitmaps(e2fsck_t global_ctx,
+					      e2fsck_t thread_ctx)
+{
+	dgrp_t i, j;
+	dgrp_t grp_start = thread_ctx->thread_info.et_group_start;
+	dgrp_t grp_end = thread_ctx->thread_info.et_group_end;
+	dgrp_t total = grp_end - grp_start;
+
+	thread_ctx->invalid_inode_bitmap_flag =
+			e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
+						"invalid_inode_bitmap");
+	thread_ctx->invalid_block_bitmap_flag =
+			e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
+					       "invalid_block_bitmap");
+	thread_ctx->invalid_inode_table_flag =
+			e2fsck_allocate_memory(global_ctx, sizeof(int) * total,
+					       "invalid_inode_table");
+
+	memcpy(thread_ctx->invalid_block_bitmap_flag,
+	       &global_ctx->invalid_block_bitmap_flag[grp_start],
+	       total * sizeof(int));
+	memcpy(thread_ctx->invalid_inode_bitmap_flag,
+	       &global_ctx->invalid_inode_bitmap_flag[grp_start],
+	       total * sizeof(int));
+	memcpy(thread_ctx->invalid_inode_table_flag,
+	       &global_ctx->invalid_inode_table_flag[grp_start],
+	       total * sizeof(int));
+
+	thread_ctx->invalid_bitmaps = 0;
+	for (i = grp_start, j = 0; i < grp_end; i++, j++) {
+		if (thread_ctx->invalid_block_bitmap_flag[j])
+			thread_ctx->invalid_bitmaps++;
+		if (thread_ctx->invalid_inode_bitmap_flag[j])
+			thread_ctx->invalid_bitmaps++;
+		if (thread_ctx->invalid_inode_table_flag[j])
+			thread_ctx->invalid_bitmaps++;
+	}
+}
+
+static void e2fsck_pass1_merge_invalid_bitmaps(e2fsck_t global_ctx,
+					       e2fsck_t thread_ctx)
+{
+	dgrp_t i, j;
+	dgrp_t grp_start = thread_ctx->thread_info.et_group_start;
+	dgrp_t grp_end = thread_ctx->thread_info.et_group_end;
+	dgrp_t total = grp_end - grp_start;
+
+	memcpy(&global_ctx->invalid_block_bitmap_flag[grp_start],
+	       thread_ctx->invalid_block_bitmap_flag, total * sizeof(int));
+	memcpy(&global_ctx->invalid_inode_bitmap_flag[grp_start],
+	       thread_ctx->invalid_inode_bitmap_flag, total * sizeof(int));
+	memcpy(&global_ctx->invalid_inode_table_flag[grp_start],
+	       thread_ctx->invalid_inode_table_flag, total * sizeof(int));
+	global_ctx->invalid_bitmaps += thread_ctx->invalid_bitmaps;
+}
+
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
 					     int thread_index, int num_threads)
 {
@@ -2455,6 +2511,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		goto out_fs;
 	}
 	*thread_ctx = thread_context;
+	e2fsck_pass1_copy_invalid_bitmaps(global_ctx, thread_context);
 	return 0;
 out_fs:
 	ext2fs_free_mem(&thread_fs);
@@ -2589,6 +2646,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 	quota_ctx_t qctx = global_ctx->qctx;
+	int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
+	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
+	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
+	int invalid_bitmaps = global_ctx->invalid_bitmaps;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2667,6 +2728,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 					      thread_ctx->qctx);
 	if (retval)
 		return retval;
+	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
+	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
+	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
+	global_ctx->invalid_bitmaps = invalid_bitmaps;
+	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
 
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
 				&thread_ctx->inode_used_map,
@@ -2739,6 +2805,9 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	if (thread_ctx->dirs_to_hash)
 		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
 	quota_release_context(&thread_ctx->qctx);
+	ext2fs_free_mem(&thread_ctx->invalid_block_bitmap_flag);
+	ext2fs_free_mem(&thread_ctx->invalid_inode_bitmap_flag);
+	ext2fs_free_mem(&thread_ctx->invalid_inode_table_flag);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
@@ -2752,6 +2821,8 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 	int				 i;
 	struct e2fsck_thread_info	*pinfo;
 
+	/* merge invalid bitmaps will recalculate it */
+	global_ctx->invalid_bitmaps = 0;
 	for (i = 0; i < num_threads; i++) {
 		pinfo = &infos[i];
 
-- 
2.29.2.299.gdc1121823c-goog

