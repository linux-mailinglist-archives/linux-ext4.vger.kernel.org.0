Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54D661F333
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiKGM2h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiKGM2b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40691B9F6
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so10169204pji.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3+ch67cgLBbn0L6V94LJXJr3S/uxJxECMuGxF8cj5o=;
        b=BR1hUebDNKgjB1qq+Nzbo6U/Z67vJ78KT3DXNcHZ04c9ShwQ1NU212ueAoMYIc5tHX
         4FYBGCOZscEXARSdBHn75N8CsaVb69tGYj3UmyiEuwjSDdaa6u8hdQwpQWrnwQXef+EW
         Zqb9h0a1wfbHywGRH9xWVGxh17yHojwDJnXXqd0a8FlwmxBtz+lZHmbHfENcx73xocQ9
         sd6ezF4xVRG+AKWapDOvJCpRl5EHpJvYPdkfhj/LHf1z64x64rFdsoVqfeDwjV+0wpQg
         hzECqBNcTQQnqC265Rw6JH8y5Vm4LIDhv1XL3oUObd8msJ+uJ9VEoI/7GuSKv3+40iuf
         NGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3+ch67cgLBbn0L6V94LJXJr3S/uxJxECMuGxF8cj5o=;
        b=W7bOw0SNqPGRrKjHipVmPjpsKvC5RxgOXzxuXQNLssoXO9lNFcFI5xEyC5X5c4vZh/
         w8q91fqrRsElkkJE85HHjVM/7qjeEjVYrSbRDnS/Fh7kANWGV+vB9W27EE9qEz91Fvap
         TW/kGYbOX1dei3upuBJBlG3e+d/kVGlZjKl7ewY9FpIrOkzKgh5k/goE3hnQVRyENiPh
         6wbnB8SDEEjKCUlEujPSZ9zioFk+UmHfnb0se9muZCnN0QO2tyASe1tDQ4u02IfuR+6w
         RscWLWQ4t8TOOGEFFTQepLpv32brrzioAHLOY85b1ilveE+dCqFTr6e5ISa/ApTNaUNu
         R2WA==
X-Gm-Message-State: ACrzQf0u1jVHkB6AzWEzWT7Erd9uZa9jYcyMok0nuKUrCEhsGP+QSU0o
        CQBQSK4DZKzIdejfuUx5n8s=
X-Google-Smtp-Source: AMsMyM74V9jJLYodD/jnz6kQ5A0fU8Q9Y9QJR66D7NDw7GqtXncbVRIjPKuWNDUuzd2IKzxeGiXuEA==
X-Received: by 2002:a17:90b:19d1:b0:213:7030:6bd9 with SMTP id nm17-20020a17090b19d100b0021370306bd9mr51816168pjb.43.1667824101353;
        Mon, 07 Nov 2022 04:28:21 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001869f2120a5sm4854904plr.34.2022.11.07.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:20 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 59/72] e2fsck: update mmp block in one thread
Date:   Mon,  7 Nov 2022 17:51:47 +0530
Message-Id: <48d152d713a9af21eefbfa69b26a7dd417f0897c.1667822611.git.ritesh.list@gmail.com>
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

For multiple threads, different threads will try to
update mmp block at the same time, only allow one
thread to update it.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h |  1 +
 e2fsck/pass1.c  | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 01bd9d01..2dd7ba27 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -488,6 +488,7 @@ struct e2fsck_struct {
 
 #ifdef HAVE_PTHREAD
 	__u32			 fs_num_threads;
+	__u32			 mmp_update_thread;
 	int			 fs_need_locking;
 	/* serialize fix operation for multiple threads */
 	pthread_rwlock_t	 fs_fix_rwlock;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 93cff80e..ed4275c3 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1509,7 +1509,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	dgrp_t		ra_group = 0;
 	struct ea_quota	ea_ibody_quota;
 	struct process_inode_block *inodes_to_process;
-	int process_inode_count;
+	int process_inode_count, check_mmp;
+	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
@@ -1672,8 +1673,30 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 #endif
 
 	while (1) {
+		check_mmp = 0;
 		e2fsck_pass1_check_lock(ctx);
-		if (ino % (fs->super->s_inodes_per_group * 4) == 1) {
+#ifdef	HAVE_PTHREAD
+		if (!global_ctx->mmp_update_thread) {
+			e2fsck_pass1_block_map_w_lock(ctx);
+			if (!global_ctx->mmp_update_thread) {
+				global_ctx->mmp_update_thread =
+					ctx->thread_info.et_thread_index + 1;
+				check_mmp = 1;
+			}
+			e2fsck_pass1_block_map_w_unlock(ctx);
+		}
+
+		/* only one active thread could update mmp block. */
+		e2fsck_pass1_block_map_r_lock(ctx);
+		if (global_ctx->mmp_update_thread ==
+		    ctx->thread_info.et_thread_index + 1)
+			check_mmp = 1;
+		e2fsck_pass1_block_map_r_unlock(ctx);
+#else
+		check_mmp = 1;
+#endif
+
+		if (check_mmp && (ino % (fs->super->s_inodes_per_group * 4) == 1)) {
 			if (e2fsck_mmp_update(fs))
 				fatal_error(ctx, 0);
 		}
@@ -2437,6 +2460,13 @@ endit:
 		print_resource_track(ctx, _("Pass 1"), &rtrack, ctx->fs->io);
 	else
 		ctx->invalid_bitmaps++;
+#ifdef	HAVE_PTHREAD
+	/* reset update_thread after this thread exit */
+	e2fsck_pass1_block_map_w_lock(ctx);
+	if (check_mmp)
+		global_ctx->mmp_update_thread = 0;
+	e2fsck_pass1_block_map_w_unlock(ctx);
+#endif
 }
 
 #ifdef HAVE_PTHREAD
-- 
2.37.3

