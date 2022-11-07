Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D7A61F348
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiKGMbG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiKGMah (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:30:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA91B7AA
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so10172195pji.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brABaUCcI2WmtiC9btp4x4LzbwAmsKEEIExja+PubBU=;
        b=AKQtLeQj2gU9Cpx6Cgl1I3ItI9fra2tqkX4jvbMRiJfShMzSZNUbaAUatvx26N1kHt
         jRPTu1tsFWmPGn15HGxgUnS07OiQdDYrBDTnYZtCyRa8FvcstyQl563CaKdNHdzmbkxS
         fWD7WoqCFQRfPlFiGXyH0WyK9HAaW04+1prO6YGirCtBfFIuiDHfKNZCkO5FLfNbJQI+
         7W8/PkwGcMhYsYx6sFhbe9u7gDtaLZ7C/b5Ero3mAV3aHcQX16W/xnos3NQMyCSpfZAT
         lCcj1XSa2Fbm4Hg94v0dvtugcOhfSBm07JsOby5VxLrF8i9LIU2AB/Tc2RggZFVy2oHr
         j/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brABaUCcI2WmtiC9btp4x4LzbwAmsKEEIExja+PubBU=;
        b=6EtvtfQgc+b+qs+yowvQL0MdFZBJTQl3U3MgFPo96SRC2vrYlDdDB3UxmgVth6IBnA
         z7mm7CvaiJDzAcyqdUyKlGg50OsOCTcMoawYwGx38MlSNEGHFRY9fXJjvXeDWx0OWZSM
         e9v3aNtaYdya1KfXu0bFT1h7nmlEtq0yRDPt6me/tmprxuWP8hS09b9cLy2q3AEF6OrR
         9G+3miE/jVK6Xti5207aPbcvRYwsKmfjYcDwRNFJFpfAwg3w9Uxrq0RktDVR8oLqcd4V
         d52X5qxLLHpxhd6PxuRE5K5lu/AygKCpnmOVnhFH9ioRgo05WQeHpOTycPRID7bFioBi
         Am9Q==
X-Gm-Message-State: ACrzQf3dqmGNkfJz0KuwilKUER+GXDeIfpuGg//MMdkvn3VSwKnDxKip
        Kp59VLPdnpTgcGxYYqtSUY0=
X-Google-Smtp-Source: AMsMyM5xFatw0U4M8F8g/S4R3nOCTABfOUjCvzOEt0WFP4eF4xORPqgPDZBSdcGT4fRi2+JWVuaRGg==
X-Received: by 2002:a17:90a:20c:b0:213:1179:1fff with SMTP id c12-20020a17090a020c00b0021311791fffmr52845952pjc.23.1667824177086;
        Mon, 07 Nov 2022 04:29:37 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id fy14-20020a17090b020e00b002036006d65bsm4162096pjb.39.2022.11.07.04.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:36 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 71/72] e2fsck: Make threads call log_out after pthread_join
Date:   Mon,  7 Nov 2022 17:51:59 +0530
Message-Id: <6a1aa669f380236663941522f84acf840919aac0.1667822612.git.ritesh.list@gmail.com>
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

All fsck threads will call for log_out prints after the pass1 their
respective pass1 scanning is completed. This patch moves the log_out
print from to after the pthread_join operation.
This makes the threads always print the info in order.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 2ff83fcb..90adc419 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3112,6 +3112,12 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t retval;
 
+	log_out(thread_ctx,
+			_("Scanned group range [%u, %u), inodes %u\n"),
+			thread_ctx->thread_info.et_group_start,
+			thread_ctx->thread_info.et_group_end,
+			thread_ctx->thread_info.et_inode_number);
+
 	retval = e2fsck_pass1_merge_context(global_ctx, thread_ctx);
 
 	quota_release_context(&thread_ctx->qctx);
@@ -3203,13 +3209,6 @@ static void *e2fsck_pass1_thread(void *arg)
 	e2fsck_pass1_run(thread_ctx);
 
 out:
-	if (thread_ctx->options & E2F_OPT_MULTITHREAD)
-		log_out(thread_ctx,
-			_("Scanned group range [%u, %u), inodes %u\n"),
-			thread_ctx->thread_info.et_group_start,
-			thread_ctx->thread_info.et_group_end,
-			thread_ctx->thread_info.et_inode_number);
-
 #ifdef DEBUG_THREADS
 	pthread_mutex_lock(&thread_debug->etd_mutex);
 	thread_debug->etd_finished_threads++;
-- 
2.37.3

