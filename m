Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7461F340
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiKGMat (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKGM3I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:29:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E93A186
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so10148326pjk.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nvBMel3mK2Mvtlci+Tq1QH/JT3NGu7C2JwIvGymT7Q=;
        b=ePJ+cziZfDJxFxKvbhpzfqF8URTyI6EmFSPGx3+aAJrdEAkraliTEn570uM8cuxJEH
         taNm/9liXM4MxlZViQS77Yf5b03lcsgcUOc1T0Fj4BwUuc+vAUurrouTAnVFIKsgxAXW
         JCaM+VqtsBTRBDi6DdOZZDMhQLM39gwWb044FEQ8Rm0dSrRXwzrUBfiw5EhsCG1Ia6VP
         SuT1kiTz2UP20S49rT6JL6N8cKsqZTWzwhQL5uexcFTCX17SKBU0/BR3STu3/iBtDkkN
         MaMsDl+XuMBSPMu7lJnEGmJdG+ushXK4kv4oie3E9YO4jS7dNdYNjMuQkAVulpppJM86
         B1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nvBMel3mK2Mvtlci+Tq1QH/JT3NGu7C2JwIvGymT7Q=;
        b=HvvL2KYae5ynmPpLX6DsafnCAFUuN6UKO/hHsFXH+9jDN9+CNM3tXrdASDKmEAcnGc
         YivCV+8lx1wou+2Fp3sorgFgxBRIIkBW4wce65eYHP2cxGNYT0oxnL5PZ4SGupFAMmmB
         34bzm8c7dogmlinKeOca0ikn88db6j6tBBcJSkqyCXzKd3TQGU3V4NeRCRABwJjnfYdN
         y2yLvw+mQIbyAIMgIEtlYQV/uWfKkZfX1XT4jqjRDZT8vwfEeAat/qhPi/9P5ZMRPLDb
         RIUbsPmbwLbNJkeemDmtAKrLTaKdpxAnvxxP8Dh9ogdMMgrA1AAj5JVknm2FNY84xtSW
         Nbmw==
X-Gm-Message-State: ANoB5pm4y5QHqr2+YDQf7U/FdIemAtc4fb8iioIaleSdEGtfp3zuU/1b
        cx5V5xirNZcTpK++WtM1HWk=
X-Google-Smtp-Source: AA0mqf6WIuLEIz+ZU0GRcWdutsJ6t8qFnTs4leRBJjZsnPj4BUdyYFeNVOaSt3rLfhtYP8AmLtxmjA==
X-Received: by 2002:a17:903:1209:b0:188:8239:8ee3 with SMTP id l9-20020a170903120900b0018882398ee3mr4423144plh.21.1667824147644;
        Mon, 07 Nov 2022 04:29:07 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b0046ece12f042sm4047214pgh.15.2022.11.07.04.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:06 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Li Dongyang <dongyangli@ddn.com>,
        Maloo <maloo@whamcloud.com>,
        Andreas Dilger <adilger@whamcloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 66/72] e2fsck: merge casefolded dir lists after thread finish
Date:   Mon,  7 Nov 2022 17:51:54 +0530
Message-Id: <8f798915e2322756a7c01126865997ee3c77cc78.1667822612.git.ritesh.list@gmail.com>
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

This is missed and should be done after threads finish.

Original commit:
18538b27 ("LU-8465 e2fsck: merge encrypted dir lists after thread finish")
Upstream is now using e2fsck_struct->casefolded_dirs instead of
encrypted_dirs.

Only for the correctness of pfsck, we won't use casefolded feature on
ldiskfs.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
Tested-by: Maloo <maloo@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8a6cdd8f..7345c96d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2614,6 +2614,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	}
 	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
 	thread_context->block_dup_map = NULL;
+	thread_context->casefolded_dirs = NULL;
 
 	retval = e2fsck_allocate_block_bitmap(global_ctx->fs,
 				_("in-use block map"), EXT2FS_BMAP64_RBTREE,
@@ -2905,6 +2906,24 @@ static errcode_t e2fsck_pass1_merge_ea_refcount(e2fsck_t global_ctx,
 	return retval;
 }
 
+static errcode_t e2fsck_pass1_merge_casefolded_dirs(e2fsck_t global_ctx,
+						   e2fsck_t thread_ctx)
+{
+	errcode_t retval = 0;
+
+	if (!thread_ctx->casefolded_dirs)
+		return 0;
+
+	if (!global_ctx->casefolded_dirs)
+		retval = ext2fs_badblocks_copy(thread_ctx->casefolded_dirs,
+					       &global_ctx->casefolded_dirs);
+	else
+		retval = ext2fs_badblocks_merge(thread_ctx->casefolded_dirs,
+						global_ctx->casefolded_dirs);
+
+	return retval;
+}
+
 static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 					    e2fsck_t thread_ctx)
 {
@@ -2971,6 +2990,13 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 	if (retval)
 		return retval;
 
+	retval = e2fsck_pass1_merge_casefolded_dirs(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging casefolded dirs\n"));
+		return retval;
+	}
+
 	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
 
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
-- 
2.37.3

