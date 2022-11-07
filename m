Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D120361F300
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiKGMZQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiKGMZA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:00 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A1E1B1C1
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p21so10900701plr.7
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caV4R+OWTjHvOPUyveUfpCTXxcmng8ZhQguB5J9grQE=;
        b=OQoMrQ0i6opj6kTmNXcce/l92K59Fb4sRo0kSWE3wwxHHiTH19bWHOAzC3vVhpeczS
         AT6C2p/GQWcsA/D2XYVvEEABkevsnMN3gOp4yk3mnGJ6rgoLlZXtQYZGw0u7W2C47arn
         hqu+nWMC46vHVIso98QTAr2fTgF/bkLnPGZpwe2b/shii0JuKpBZ7bWrGe4cU0YugQOL
         CWUlXpB4YV8iF8XUSbFR5N6SgFz10/LJQ22SLKS8Maau8cMdaC3TxLMTdHpMaL7Tcax7
         KVJhJRcA8kLzNQCLXq+opu2S2rWqGar72zywnOzXSNMpnrpJ/JojL3fmqEKQjvtlUtzS
         PWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caV4R+OWTjHvOPUyveUfpCTXxcmng8ZhQguB5J9grQE=;
        b=crbQySqcl4MnAQrIU9vaOAiXkY/HqdfMTcHiQnjLgudb5yck4GBgwt5dzGULmmdDag
         Bz5hcJhNPoEgf2BOdgFJ+qw8iFE7YZq2zFNQWxSStYK2u835pjkK7Ul+WBkpt/XfmOuy
         JXr/YyPjUEFMtc3OjOLZEvDQk/v9VxpaXFKsP8114hyRKSI0c3f6UkH1ikH6oXfVPrwD
         SQwLTDGDn6F6JJ1uaD3im3ZVbAATkn44FRONHdp3hbjtCRK7EOthy/O6IRlnqK9ItZ9r
         Ts0dT7GDN0OgdxNbfnFuZX8ztXhgCQ6Hvmt15q0R1jGVMTI2ngohHGNDK4LST951lmZg
         sdZQ==
X-Gm-Message-State: ANoB5plRoJ1GORDxUCJYakekAjxUP7IJvIQie0t523TTFa+SOi0VWXxm
        7rak/tL++MuM2c+9sEA4bEY=
X-Google-Smtp-Source: AA0mqf6uQbGc6rfCXRR5e+S0I2IjcCh1khsCtPRs7wW1ZaPhh/olMI+pJNykgHPApT1SuhjQf4ONjQ==
X-Received: by 2002:a17:903:247:b0:188:88be:4fb1 with SMTP id j7-20020a170903024700b0018888be4fb1mr220789plh.34.1667823898003;
        Mon, 07 Nov 2022 04:24:58 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b0018157b415dbsm4889228plg.63.2022.11.07.04.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:57 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 25/72] e2fsck: Add e2fsck_pass1_thread_join return value
Date:   Mon,  7 Nov 2022 17:51:13 +0530
Message-Id: <44270897e6bf20bdb883d3e3cab43a83806e696c.1667822611.git.ritesh.list@gmail.com>
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

This adds the return value to e2fsck_pass1_thread_join() to check for
any error in pass1 threads join operation.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 596096d1..4b165600 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2174,8 +2174,9 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	return 0;
 }
 
-static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
+	errcode_t retval = 0;
 	int flags = global_ctx->flags;
 	FILE *global_logf = global_ctx->logf;
 	FILE *global_problem_logf = global_ctx->problem_logf;
@@ -2195,6 +2196,14 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	global_ctx->fs->priv_data = global_ctx;
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
+	return retval;
+}
+
+static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	errcode_t retval;
+
+	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
 	if (thread_ctx->problem_logf) {
@@ -2202,7 +2211,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 		fclose(thread_ctx->problem_logf);
 	}
 	ext2fs_free_mem(&thread_ctx);
-	return 0;
+	return retval;
 }
 
 static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
@@ -2226,7 +2235,13 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 			if (ret == 0)
 				ret = rc;
 		}
-		e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
+		rc = e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
+		if (rc) {
+			com_err(global_ctx->program_name, rc,
+				_("while joining pass1 thread\n"));
+			if (ret == 0)
+				ret = rc;
+		}
 	}
 	free(infos);
 
-- 
2.37.3

