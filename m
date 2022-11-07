Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DFA61F317
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiKGM1G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiKGM1B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6334C6405
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so14408467pjc.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=333vC0dW8Rw1b9p+EPFXewePT2jZKqjSdzIZxgfazzE=;
        b=n9m30imDnkpTUetumSqddSfkilD4PFWe0NK9k2bpqWTGPGf0PBcJSCdocXdDTiQ1cO
         MTuJlMssBLF3ozxr/A6Xc2u19iDxvbs5wCer4Me7Ofp9lUbaZHuWRz5v54VMCyAUBmiJ
         SqlK+/m8dbhOVWDOTEsNKH8VWgsYoxVLnXnGHNfvdGvgnp1SRXJ3iJ3VL0Eu0XY/GVQ9
         ksRPsa6rvbQQrCLUxG+MkgQ89tVdo057Pne7XQU3TA8u/FOkAjUil18DDAOIllPk2QM0
         ySQmAteE0eZjS+ai/IR+L8b8yuiFOO4ML/0TjtV/UTeMev7xLFAPOGCIHKcF23dLy/66
         g4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=333vC0dW8Rw1b9p+EPFXewePT2jZKqjSdzIZxgfazzE=;
        b=Vf30AHxFJ/DnOcnIOy+/TbRv2MkdKtXf64Imbimpo4crI3EDJiSxfLX8Hd8zR5PoYj
         L6eGw7HNZKdJFEF9Ftqhn12kFfz5wONYWA/XRLGdsn7uTuhEDQK+4kI1jRPJ5VpbcS4h
         b9wsgZ/JtCsNuTaAg6EMsFJpt3sosEoz8PC2L2emv9j9kYxAD6R5syrJRgJ+nSfqoA6d
         YhCAhjw9WJyLqRgW55oXnXxDREmhpTbuYZAzD3TkPJkPjZlKiZRSkcgNkS5LeXJi/lOI
         mQ41X//bnh3B3tSXH2KNqIqx+SvtFOFQHCQowFivAzq0mzU+Cevwq5ewuqjAnPd7zpVK
         yEOQ==
X-Gm-Message-State: ACrzQf0uboTx9X6+yMNppOE6j5fzO/1M4ol1aMQ53duNsqDdMcuqLXb1
        rcB05Z/l8hdWoQDfq5dG8Ls=
X-Google-Smtp-Source: AMsMyM7O/8CwMQC1Bov0068xZwKQ69YaLvDQ/zDcAIaFv25PBTwMb/xbU5A0Z2rgzsCtkV0nQ4n9YA==
X-Received: by 2002:a17:90a:6286:b0:213:b01e:4290 with SMTP id d6-20020a17090a628600b00213b01e4290mr48134128pjj.42.1667824019901;
        Mon, 07 Nov 2022 04:26:59 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902cec700b00186ff402525sm4892045plg.213.2022.11.07.04.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:59 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 45/72] e2fsck: split and merge invalid bitmaps
Date:   Mon,  7 Nov 2022 17:51:33 +0530
Message-Id: <f46742bb7e67f39de947f1cea5406892caabc221.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Invalid bitmaps are splitted per thread, and we
should merge them after thread finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index f156d4e1..e268441a 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2309,6 +2309,62 @@ static errcode_t e2fsck_open_channel_fs(ext2_filsys dest, e2fsck_t dest_context,
 	return 0;
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
@@ -2384,6 +2440,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		goto out_fs;
 	}
 	*thread_ctx = thread_context;
+	e2fsck_pass1_copy_invalid_bitmaps(global_ctx, thread_context);
 	return 0;
 out_fs:
 	ext2fs_merge_fs(&thread_fs);
@@ -2519,6 +2576,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 	quota_ctx_t qctx = global_ctx->qctx;
+	int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
+	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
+	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
+	int invalid_bitmaps = global_ctx->invalid_bitmaps;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
@@ -2598,6 +2659,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2663,6 +2729,9 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	if (thread_ctx->dirs_to_hash)
 		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
 	quota_release_context(&thread_ctx->qctx);
+	ext2fs_free_mem(&thread_ctx->invalid_block_bitmap_flag);
+	ext2fs_free_mem(&thread_ctx->invalid_inode_bitmap_flag);
+	ext2fs_free_mem(&thread_ctx->invalid_inode_table_flag);
 
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
@@ -2682,6 +2751,8 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 	int i;
 	struct e2fsck_thread_info *pinfo;
 
+	/* merge invalid bitmaps will recalculate it */
+	global_ctx->invalid_bitmaps = 0;
 	for (i = 0; i < num_threads; i++) {
 		pinfo = &infos[i];
 
-- 
2.37.3

