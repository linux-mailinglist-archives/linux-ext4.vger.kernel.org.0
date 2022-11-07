Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884BA61F337
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiKGM2x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiKGM2q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:46 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C11A186
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k22so10458988pfd.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EkOIBNA7D1BIBwaIa8nmWutEc3lXF7Ye4dNCdSq3Zo=;
        b=Vb0c3YYyinSpocRDLeVPm3+j8BuhZZnwThaJg/Z3YlgMVJl7H0v49qd497i8qvoEix
         5cpnYrTqYBoqgJZQEgUU1kPg3/JHW9/qR8rudacymuNcnM4NmfZpkGgNM42wPYChKGUw
         OTmqWqdkQN3WARXBcH8ZIRxK39E3XRQIbCxYGgFi3YWiotuc35kGDeTf/Fw3a6Hd0Kmv
         13bcMeGkLltdAqXOY6IVPl3K63HoPAbDUf5rRidvFE+yibPUMreHt1ZH72go9QBElKaJ
         qvSkAiRoUMab/5UEDl0hITwnldwGTEagAkEnT03OHNUoWI1smQvKPESAmiNlTiLMmCVm
         vevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EkOIBNA7D1BIBwaIa8nmWutEc3lXF7Ye4dNCdSq3Zo=;
        b=ElN05yQWIRURD9z78IGcWDeO1VogHICA6t32QXM3iyvBXEQ0E4kjz5fcuDlFta9kws
         vtGzX89pHVgo3fn2w7yMxrx50KQCONsplHTnwNT/yJOqBYvcN7lhmHHHTxZauWQmd/mX
         KaQG2wk41MDEK8FFdO+GKevvG2C99gGplwhqb5WvxZAJ/1W57HOY4+2dIYenmYjaPmsh
         xRYPdR/vypTGYx8PGUKaRfoYvPLLPHZuM7VfX8CkfUSCTzp8bcpVIaq1vIdgyfGj+XXL
         A+hpoFpqSJSl4VdydkY26w/DLlZyoqEzNS1n3btQRflZQumpBZFtCumx33XMawRR9qjE
         SALA==
X-Gm-Message-State: ANoB5pm0NTFFuF4j0u2nwyh5kHmeba7EJCWoHq49WKiW5y9gHOYuBoOO
        NFie0eF54p4eZ5tN3q+v0ZIhPZVcn8E=
X-Google-Smtp-Source: AA0mqf6ySxtcbQxnbU+V1sGDTVtvrnqX1Dnf6LnvSXEtMBHOTEuN3zfEBcSnd6njyJl4cS9zD9EwgQ==
X-Received: by 2002:a63:e50d:0:b0:470:60a4:892b with SMTP id r13-20020a63e50d000000b0047060a4892bmr8384190pgh.148.1667824124613;
        Mon, 07 Nov 2022 04:28:44 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id c18-20020a63ea12000000b00462255f5aeasm4128183pgi.40.2022.11.07.04.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:43 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 62/72] e2fsck: fix memory leaks with pfsck enabled
Date:   Mon,  7 Nov 2022 17:51:50 +0530
Message-Id: <1a72168b983a877458d5fc20409620df31b6a619.1667822612.git.ritesh.list@gmail.com>
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

valgrind detected two memory leaks:

1) quota context is not released after merging.
2) @refcount_orig should be released

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.c | 4 ++++
 e2fsck/pass1.c  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 53af8905..db0a5059 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -106,6 +106,10 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ea_refcount_free(ctx->refcount_extra);
 		ctx->refcount_extra = 0;
 	}
+	if (ctx->refcount_orig) {
+		ea_refcount_free(ctx->refcount_orig);
+		ctx->refcount_orig = 0;
+	}
 	if (ctx->ea_block_quota_blocks) {
 		ea_refcount_free(ctx->ea_block_quota_blocks);
 		ctx->ea_block_quota_blocks = 0;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index ed4275c3..d745699d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3039,6 +3039,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 
 	retval = e2fsck_pass1_merge_context(global_ctx, thread_ctx);
 
+	quota_release_context(&thread_ctx->qctx);
 	/*
 	 * @block_metadata_map and @block_dup_map are
 	 * shared, so we don't free them.
-- 
2.37.3

