Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E561F32A
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiKGM2F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiKGM2B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:01 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB281B9C5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:58 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q71so10302147pgq.8
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNdDEX4CpPBN9MdYhG0WPzSQr4IM9bJjX2aLY1pgkWQ=;
        b=c0gv/aUwWBDsz+rpAhFK1OJM1ZyarjQ6j1OHF/XzR+8JxUx+64PbcMng9V+n31C5xv
         gbwpCos9lB0Uads3MgUnWl+J1QG0Py6M1Ue5QHGDFtaVYAf3+zVyr/YoNp6Xfh+ljUMk
         bk04gbJ9zhrGbIDaYYtu1TJqGvhXjFX0KTkhj+QUPbTqAyCVHEnvbXJJ8RewiTEWDlwg
         hd8NMjVGxuGPAncVGi5REoHMHaDyATKs3ObEPNi5TMmyYtkhkrNRuvQ1ZvYy6qoviyeX
         /ToxJbtNSz2g07SjTvkqP/mbkQpRtXXbjNYO3u1Kj0FURnVaz5OygElWTcoQNM6ARD8x
         /f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNdDEX4CpPBN9MdYhG0WPzSQr4IM9bJjX2aLY1pgkWQ=;
        b=4M8Fw+SDr6KR0Zh95LRiljOdtRKlqo/b7RkNv0s7rYERZUCBeLW31Ul+j27aX+fyN8
         S0+ENcNNFJtQGP/tydh6lL5ycblxYkCFavIrqA15QCySzoi+nzTj/adBHBr8/eKIhuV0
         3GlzxWtTVDV+HEaNDRhC0uY5Zsl5o7pxGJbEO4ai7cmvaAbjR7OGv+C+O2+opwZtvLam
         dn+ThO8At+hAjHzHZQH5U5dPmLafK41Q1Ak2vO/IkOMypk2QIlPFWSefS5yD+LPsNr2H
         fPpRIl9E3GTpV7jxM9U73oetHf9m4y9ZPGe5hKL/xndZ5GFKUd1kE1yibp9QoayCdJhp
         oOJg==
X-Gm-Message-State: ACrzQf2Br16T4Nq1D3/DiDfVreIK/g0Qrp/8B3WOoL+QfMOaXgtkH1rQ
        TdJ3xfmbx+0u5fcqDC+2EYr1ZYb7L0Q=
X-Google-Smtp-Source: AMsMyM7F4U2+iAhgn4j5mTtt4MHCIO5DhrXKbev7na2bMej6M5cpzzBqSARbvH901cKJw2bQLrz8ag==
X-Received: by 2002:a63:e10:0:b0:46f:9191:7672 with SMTP id d16-20020a630e10000000b0046f91917672mr40135327pgl.552.1667824078182;
        Mon, 07 Nov 2022 04:27:58 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y13-20020aa78f2d000000b0056babe4fb8asm4348001pfr.49.2022.11.07.04.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:57 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 55/72] e2fsck: set E2F_FLAG_ALLOC_OK after threads
Date:   Mon,  7 Nov 2022 17:51:43 +0530
Message-Id: <474758c68a19b0a2fa5d5647e81d047247a93f3e.1667822611.git.ritesh.list@gmail.com>
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

Only flag ALLOC OK after all threads finished without problem.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8e85f70f..a5dc6e44 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1385,9 +1385,12 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
 {
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
+	char *block_buf;
 
-	char *block_buf =
-		(char *)e2fsck_allocate_memory(ctx, ctx->fs->blocksize * 3,
+	if (e2fsck_should_abort(ctx))
+		return;
+
+	block_buf = (char *)e2fsck_allocate_memory(ctx, ctx->fs->blocksize * 3,
 					      "block interate buffer");
 	reserve_block_for_root_repair(ctx);
 	reserve_block_for_lnf_repair(ctx);
@@ -1465,6 +1468,8 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
 		ext2fs_free_mem(&block_buf);
 		ctx->flags &= ~E2F_FLAG_DUP_BLOCK;
 	}
+
+	ctx->flags |= E2F_FLAG_ALLOC_OK;
 }
 
 
@@ -2355,6 +2360,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	}
 
 	ctx->flags |= E2F_FLAG_ALLOC_OK;
+	ext2fs_free_mem(&inodes_to_process);
 endit:
 	e2fsck_use_inode_shortcuts(ctx, 0);
 	ext2fs_free_mem(&inodes_to_process);
-- 
2.37.3

