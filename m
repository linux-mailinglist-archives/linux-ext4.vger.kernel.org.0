Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7611261F313
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiKGM0h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKGM0g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A68F63D5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b11so10418304pjp.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GiE7/SSqwiXyofETS8k0nS3VBbJtMpqt7PMfrdEg6o=;
        b=Hizxj3SPxzgX8XTngOYeCurItcgtV8ptFWuPbMpr+VHoZiBoklVadqx0g27S+RVoJV
         nuP4sQdblC4yG1zWMtL67c+lwJ5rLa/1/Mnwx5fIUZSiS/1ptdCcM7PtXoM/r6dT7LF5
         aDTno8+zuiIBAWlX/GyLkNyWxAAAXjnFgXadcn16TPWdmese4MdTaDIEGac0IP8DZheK
         p7rJ6TETuqnamCUgeAlwrZLBVAGzI3rHqA7Z+XzRnjPUaOV2DFa1CRGxyUuJ3IKmEbOn
         KBEJajj3PVd5CADiJIzBCoaPu1PN1x+lI+cbm0ei4DW6Qym/jEPp2O+fOgdrJIgtfj3u
         PKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GiE7/SSqwiXyofETS8k0nS3VBbJtMpqt7PMfrdEg6o=;
        b=74d9nZua0rxyWdeVK8u0YaE0iYMFyjeChbp6TSj5GZuF3QgQYClTfH6KacbHVNTx5Z
         Dw5fuW3WVSs3FI5HiZ4t6yxuYVEn52wOoZUVH8YOtJkdFCitIBV0gC6eP9+EgfBVSqRl
         0gDHzGt3fxV0tKO+YBTqAJ0pXMkXgTuLSekhnik7yk3FicpPz/M2y6Uq9VDtRNvGN5je
         PREwqTEnaigZlLciX1i2EyShXkQtQyF0XWxxJ7kGO1jnd/J8+T6DCTAu+5ktO86GvPCU
         pMgc8V2V7YtFeWw89ALxyjjJAj8esqB1w4xRufM3DTZoa9aAMr1KrAbGA/PhEa+9qcfO
         1bnA==
X-Gm-Message-State: ACrzQf1Q3QkjE7aakRinkmNIJeolz5U3KyTYPv4uXquAekgqgthJ9CFk
        HHahA/DwPNpswvBD7cIL0GyjULEtwAs=
X-Google-Smtp-Source: AMsMyM7teKx7x97UysYRyCYTlrhFi0/u0BakBtEPxJ/GffP69Bx78+hO9Sn+7ppRDXDnQYIXX9xCOw==
X-Received: by 2002:a17:902:ec01:b0:186:748f:e8b6 with SMTP id l1-20020a170902ec0100b00186748fe8b6mr49851371pld.131.1667823995643;
        Mon, 07 Nov 2022 04:26:35 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090311d200b00179f370dbe7sm4821165plh.287.2022.11.07.04.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:34 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 41/72] e2fsck: merge context flags properly
Date:   Mon,  7 Nov 2022 17:51:29 +0530
Message-Id: <be50145f6012029a9ecdfedf3779807cd3b60969.1667822611.git.ritesh.list@gmail.com>
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

e2fsck might restart after pass1, so we should keep
flags if possible, this patch try to fix f_illitable_flexbg failure

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index a3f13402..7e167189 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2502,9 +2502,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->fs_fragmented_dir += fs_fragmented_dir;
 	global_ctx->large_files += large_files;
 
-	/* Keep the global singal flags*/
-	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
-			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
+	global_ctx->flags |= flags;
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
 	global_ctx->global_ctx = NULL;
-- 
2.37.3

