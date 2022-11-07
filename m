Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BCC61F312
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiKGM0c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKGM0a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:30 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB94863CE
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l2so10877941pld.13
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMGXvG1b324hpwzPRf+YBXbWO6uEyoN1PX4ENEuZ1So=;
        b=EUnB7qhirjezjPUL+3O+R6BraDB1jOsINu1bfn7cFMcI70xWZfnRynr3GYojz0XptY
         8E100U5sFJWYZeJOpOTWc6w4+/WfhoAJjjYzHpmQ7GVT/a7WGE4klaAOS2Fv/tKipZBN
         QUQ7tu+/FBNEpIGii0qQVX9R3gVWIkI5woRWoC1ikUGtlEfceKDt/djyJlBXC/vmK1Ol
         lR6mb4dJumiyoRCfMonCg7wxl6RQRHpQNmMZJILfG3RzTdaitMn4tjUjIw2ju6u3MspN
         ngqfgCBXs9TSSMg19hC0oIJEJ+ZE7EFeErCgJ3/8vS0MgwTqKQ6R9CryFkKfx7/7gXhC
         HHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMGXvG1b324hpwzPRf+YBXbWO6uEyoN1PX4ENEuZ1So=;
        b=BtBRSGf3WbV/CyYubMw31G+kcnHlGt6RpiJzP58bshocLSGvd22DjkSGpJisg7ByU0
         VVS5vR2JdKpUf6u77Rm9bP4qdCvTIeCeYHdnifTzbcKpvyG+QB+U8zZPPcD+V0k4MgUi
         4ppX54H3e/ezIixa9CYqbbXAkAWwP2UzE3vLIYS56vCsuqSjJK8xXqHc/wC4+kB35YCY
         HQ9AuIv7CwXnHut71JVnUTfny+151ylaanEAbPpE8JHQLerSMehQTzYnI9lvkeLxpegz
         AwKDB4fC1amsze+/GXM/LDVjsofeO8v5wMQnQFSyf2/00/S6l3LJOwZl58qOygn2Ayky
         x3qA==
X-Gm-Message-State: ACrzQf3OvbnUAJzzdcGFwFRv74L6iPcy55dEJ1iGYzQLyuP7HNbt0nXD
        t45kPOr9YxLb032IGFkqw2w=
X-Google-Smtp-Source: AMsMyM57vICXvl+iGs4xiQSQiDX+aZiJAG1+Fik+37QICwgfWrreVqoGpn0WIvzPVKC/7XntkBjgkA==
X-Received: by 2002:a17:90a:c78a:b0:212:e56b:2b17 with SMTP id gn10-20020a17090ac78a00b00212e56b2b17mr51603830pjb.51.1667823989453;
        Mon, 07 Nov 2022 04:26:29 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b0018863dbf3b0sm372713plh.45.2022.11.07.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:28 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 40/72] e2fsck: merge dirs_to_hash when threads finish
Date:   Mon,  7 Nov 2022 17:51:28 +0530
Message-Id: <12bb27f0b59e176a599fd9f065f7f25633d8571e.1667822611.git.ritesh.list@gmail.com>
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

@dirs_to_hash list need be merged after threads finish,
test covered by t_dangerous.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index f998590e..a3f13402 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2392,6 +2392,25 @@ static errcode_t e2fsck_pass1_merge_icounts(e2fsck_t global_ctx, e2fsck_t thread
 	return ret;
 }
 
+static errcode_t e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx,
+						 e2fsck_t thread_ctx)
+{
+	errcode_t retval = 0;
+
+	if (!thread_ctx->dirs_to_hash)
+		return 0;
+
+	if (!global_ctx->dirs_to_hash)
+		retval = ext2fs_badblocks_copy(thread_ctx->dirs_to_hash,
+					       &global_ctx->dirs_to_hash);
+	else
+		retval = ext2fs_badblocks_merge(thread_ctx->dirs_to_hash,
+						global_ctx->dirs_to_hash);
+
+	return retval;
+}
+
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t retval = 0;
@@ -2434,6 +2453,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32 large_files = global_ctx->large_files;
 	ext2_ino_t dx_dir_info_size = global_ctx->dx_dir_info_size;
 	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
+	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
@@ -2504,6 +2524,14 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
 		return retval;
 	}
+	global_ctx->dirs_to_hash = dirs_to_hash;
+	retval = e2fsck_pass1_merge_dirs_to_hash(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging dirs to hash\n"));
+		return retval;
+	}
+
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
 				&thread_ctx->inode_used_map,
 				&global_ctx->inode_used_map);
@@ -2583,6 +2611,8 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
+	if (thread_ctx->dirs_to_hash)
+		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
 
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
-- 
2.37.3

