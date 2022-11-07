Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A8661F322
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiKGM1o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiKGM1g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C441A817
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso14465028pjc.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81vBt7uHuryaeGLS3/KgcqL9AcD3bdCb+FwgpUv3UgU=;
        b=HNn/5cFgF4ITAXweRUF6fpM0A0ibNMQFy3oAmFHBr0QfPIPbMFLtvmUR0WZF3/NrW9
         JObKGaAB7jIsjthgQxWWhsO7P9gfvXU0sCf7ZxZAOfBmG5K/L1BIyXkhFYzyweGiVVrT
         zqtNMCUWjIA/gDqrWmF0m71VuV4OwRUFJI36lb9RMF01tqm3+TK3lMmodiX2Le0Pgar6
         S75WUoiev+kiAGAMaiHzz5RK4qJiBWhpwuUDSNQ5NXIl2PjaH9yfj5rqmli6R2Ec7BvM
         JctLzxok+4B7qXf484CcL+Afdq3oE5YpDeVJoV2YNys+7YLzg9+7BHURNoZX6pSZ6KAt
         LfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81vBt7uHuryaeGLS3/KgcqL9AcD3bdCb+FwgpUv3UgU=;
        b=zfyH3vXMTTS6WbSWTLJpE5Bd3lO8N16u5vrmiwb2AWoA2dRB6VKsvbSmmsJsTvJ46E
         VasGk2LC8lgR5Drr8JLTnH5SmrcwTZujNDyoRKWDJoQvoMdOaIyn2w/RaOmDiBzSBGyb
         lMbesCMOStVzRLdtC+VuzjcFQOMxhnEBA0tySz3aIEymFlU/KmwncTSGz3019Hoz8k++
         rAJ+PPbgQyOlZqEQ32RNZ7uPKdq/ll07lpgQ0oPrsQS+5xAUMkZCkOUf8tDsmTAYZczb
         +JljRaOTOGiJu+Ew37LJEdJjO1fSi0WYp+mXc9un9wG4TebOWO3s1NXaxZfSvkyuJ7Er
         PIPw==
X-Gm-Message-State: ACrzQf0e9KZ9B8T70nk7yAbeiklQR/anUtbow0hHXF6IfyTO9qSjsbRv
        eEdyBSTw14BLlWuohRZjEwI=
X-Google-Smtp-Source: AMsMyM49Mxhbt01KxqeMHTBK0VTij6Rw7bHGHDTM1zqgN4Dn4bDNPdu7Fzf0+6MTd3mXyjaqhFWhPw==
X-Received: by 2002:a17:90a:7061:b0:213:da75:f149 with SMTP id f88-20020a17090a706100b00213da75f149mr43493265pjk.85.1667824055315;
        Mon, 07 Nov 2022 04:27:35 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id v1-20020a622f01000000b0056be55df0c8sm4376744pfv.116.2022.11.07.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:34 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 51/72] e2fsck: merge options after threads finish
Date:   Mon,  7 Nov 2022 17:51:39 +0530
Message-Id: <162e7927ff2cb9a94f9ed812477765c6ead16754.1667822611.git.ritesh.list@gmail.com>
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

It will be possible that threads might append E2F_OPT_YES,
so we need merge options to global, test f_yesall cover this.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 5d07daec..59ff888f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2866,6 +2866,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
 	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
 	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
+	int options = global_ctx->options;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
@@ -2918,7 +2919,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->fs_fragmented += fs_fragmented;
 	global_ctx->fs_fragmented_dir += fs_fragmented_dir;
 	global_ctx->large_files += large_files;
-
+	/* threads might enable E2F_OPT_YES */
+	global_ctx->options |= options;
 	global_ctx->flags |= flags;
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
@@ -2954,6 +2956,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 					      thread_ctx->qctx);
 	if (retval)
 		return retval;
+
 	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
 	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
 	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
-- 
2.37.3

