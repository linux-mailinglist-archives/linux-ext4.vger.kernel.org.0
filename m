Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B261F61F331
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiKGM2S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiKGM2O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540521A817
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so9571991pjs.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj8svmfV5V0dXHS0bF642t6Ke/oNORK33zioqZN2lqI=;
        b=DCab9Ze1Fawpsj5UwqXhTUzrLqBzRb5CD82N01XKLOeTcJY5DAAq9MpmcCgpjLNRaz
         eP7vpJGsj690vzoyNsyfQzrZio3LePBbBO1OEK/Ri2Ang76YL1H4pXBLf+ZKsmLtIkCf
         xFeSbP1IuRcJbUte11CxsBGB5w3Znp/JjXnCXcxoquVXxaONayOH4JntiXmbrC/KDBXu
         qC15oMEaF0Nc6LwSDRGbeEM8rjLcA6JnfFnkkT0ZzKCYWqX9LEhAiiCpSwfgE+P4s+NT
         4gXLVs94/IGXbt5Lq0Xs6HTKGGo/MjL7QEtSEz6WRQmW8Ll3srBvbJ/lPwrDB/HmTNYO
         pqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj8svmfV5V0dXHS0bF642t6Ke/oNORK33zioqZN2lqI=;
        b=gfKaEKP8OWWQ6348F9Jw5/HzlVDZB2vL0GzA3V02m6t+l5S9YUIpWvLFcYyS5vNwEg
         BZ9SkmrSiPafXbDwjhs23GcluywoZOaSlnlJk5f2GmX4klNL+AepKakhUnT1i0NH8E4f
         G/NQ8++onOv/fMeOd+19yYHCyaJiCqHTxCdH+77Z/o8xr0HYmofm+azKieU0QvgAgKAt
         gFM9j4EJuD/rjGF04+T0HD+ZIHBR+ypG6Pg0UqMIdQMCjW3d0UXGXGJ6e2r/NOadou0W
         iaG1sVyeftMpoUjXuBBVJTDGhfBSqzQK9/yse7SXeG4XvrP5C4mjHppojwzRq9lIc0R9
         jmcQ==
X-Gm-Message-State: ANoB5pk8oCRwbOGM3rQa3rGNpuiyhCiHZAXt5KtqUUSYFGTdOHDTdRZ7
        p82FvSZA37Q0ZjqBn3xW9CU=
X-Google-Smtp-Source: AA0mqf6AL7gV0QwRz7kaI/sos0Vc6HJUiP/p3Q3hk3qUOQ9fxQ6z0XjF2umnwNc+p4Gm2+0ZOPM+PA==
X-Received: by 2002:a17:902:bf0a:b0:188:6862:cc3d with SMTP id bi10-20020a170902bf0a00b001886862cc3dmr16798966plb.17.1667824089777;
        Mon, 07 Nov 2022 04:28:09 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id k64-20020a17090a3ec600b00205f013f275sm6059853pjc.22.2022.11.07.04.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:09 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 57/72] e2fsck: cleanup e2fsck_pass1_thread_join()
Date:   Mon,  7 Nov 2022 17:51:45 +0530
Message-Id: <52955ad12afbc737db46adcbc1963706b2d002ff.1667822611.git.ritesh.list@gmail.com>
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

Use e2fsck_reset_context() to free memory to simpify
codes.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 29333acf..93cff80e 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3008,39 +3008,20 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	errcode_t retval;
 
 	retval = e2fsck_pass1_merge_context(global_ctx, thread_ctx);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_used_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_bad_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_dir_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_bb_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_imagic_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_reg_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inodes_to_rebuild);
-	e2fsck_pass1_free_bitmap(&thread_ctx->block_found_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
-	if (thread_ctx->refcount)
-		ea_refcount_free(thread_ctx->refcount);
-	if (thread_ctx->refcount_extra)
-		ea_refcount_free(thread_ctx->refcount_extra);
-	if (thread_ctx->ea_inode_refs)
-		ea_refcount_free(thread_ctx->ea_inode_refs);
-	if (thread_ctx->refcount_orig)
-		ea_refcount_free(thread_ctx->refcount_orig);
-	e2fsck_free_dir_info(thread_ctx);
-	ext2fs_free_icount(thread_ctx->inode_count);
-	ext2fs_free_icount(thread_ctx->inode_link_info);
-	if (thread_ctx->dirs_to_hash)
-		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
-	quota_release_context(&thread_ctx->qctx);
-	ext2fs_free_mem(&thread_ctx->invalid_block_bitmap_flag);
-	ext2fs_free_mem(&thread_ctx->invalid_inode_bitmap_flag);
-	ext2fs_free_mem(&thread_ctx->invalid_inode_table_flag);
 
+	/*
+	 * @block_metadata_map and @block_dup_map are
+	 * shared, so we don't free them.
+	 */
+	thread_ctx->block_metadata_map = NULL;
+	thread_ctx->block_dup_map = NULL;
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
 	if (thread_ctx->problem_logf) {
 		fputs("</problem_log>\n", thread_ctx->problem_logf);
 		fclose(thread_ctx->problem_logf);
 	}
+	e2fsck_reset_context(thread_ctx);
 	ext2fs_free_mem(&thread_ctx);
 	return retval;
 }
-- 
2.37.3

