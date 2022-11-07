Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1661F346
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiKGMay (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiKGMag (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:30:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661371B9D2
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso10125795pjc.5
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mCTw1xNENoPySQjpxJulxZ+cgE3/DtDrhwZ00hou64=;
        b=Z5a0TsZ6akgVS5InsU+efI070jXFge2KncXT0iqgNNdAvRawfnCumcq52lAe793gWR
         81MiIJctZ7WyoIBRzQxsaCdoL+Ct93pXL/qDoBST60CfwPyrPn0zvIWmD87L6Z7ZyUKY
         em/0x2yaDxmq/1BHUC9ZiMUEjqvi8IPJDisjpE2xBBLdi6HilMcnvSRjNEX07Yi/Wp3p
         y7KNkG/NOMB+F52TDZFVRoMGz78xEGAnIGdLTs3E5jd0ODvjiqakS0VixeyVrmVrc9fN
         vvC677Hh1WfYe9tjN4XCUQnoo3Gqjszui7FuVzHwQ43awyTLLDfTuaIure+i+yZ/YVoO
         4iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mCTw1xNENoPySQjpxJulxZ+cgE3/DtDrhwZ00hou64=;
        b=7FDKHtWnqYRvDqR0oGPQI9mlGSAdiz3Mpo3G6UPPjb4VCsY083u2DUIgTgBcEbZoe6
         pqp1arGLBj3nKS/FvTPgdW5Qnb4Gb3ZstmmXVXu/GVBtG2xxyAXpIYhA4vrnKZ/Q+40H
         ik9IJ6FGf52nrMpNetl9xcO5t36rdM6yT1xMj9bRf6N+dbEczVnu2v1DPcQZ/flBke5E
         ZEd9NrVwqKHN1SJAONMrnobPqstIAF++LMDDMYKup3FWAqNWpr8fDrMHEWHWF9D7+Au9
         OkMf0QEA3f2k0QjEEWJNG2cJxBMHDvnU1+KGPfT9X7Fec3aSIGZ7hr4DeHnPjwLdiG8u
         OG+g==
X-Gm-Message-State: ACrzQf0yBbg+drtCgrY+LH2jMTVmxP+FyDY7MWTh3tayFwsMSGfzXLuM
        us+Y346gjbrr08Hh+683mEz6N7f2ZtM=
X-Google-Smtp-Source: AMsMyM7vVzHUZVeTbOMwSivZ8sak45p3GRBoovd8VcmGTzUmu068MhJGZ/6A/PSkhP8l0eVa23dUhw==
X-Received: by 2002:a17:90a:a415:b0:20a:f813:83a3 with SMTP id y21-20020a17090aa41500b0020af81383a3mr51751288pjp.238.1667824170932;
        Mon, 07 Nov 2022 04:29:30 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id o22-20020a170902779600b0018668bee7cdsm4877440pll.77.2022.11.07.04.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:30 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 70/72] e2fsck: Fix and simplify update_mmp in case of pfsck
Date:   Mon,  7 Nov 2022 17:51:58 +0530
Message-Id: <846558b5f837ed2d32246a072d3b97f584573c7d.1667822612.git.ritesh.list@gmail.com>
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

This adds pass1_update_mmp_enter() & pass1_update_mmp_exit() routines
to update mmp block. This also fixes a data race reported by threadsan
because of reading and writing to mmp_update_thread variable.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 97 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 34 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 4168a45d..2ff83fcb 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1097,6 +1097,66 @@ out:
 	return 0;
 }
 
+static void pass1_update_mmp_enter(e2fsck_t ctx, ext2_ino_t	ino)
+{
+	ext2_filsys fs = ctx->fs;
+	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
+	int check_mmp = 0;
+	int set_mmp = 0;
+
+#ifdef HAVE_PTHREAD
+	/* only one active thread could update mmp block. */
+	e2fsck_pass1_block_map_r_lock(ctx);
+	if (!global_ctx->mmp_update_thread)
+		set_mmp = 1;
+	if (global_ctx->mmp_update_thread == ctx->thread_info.et_thread_index + 1)
+		check_mmp = 1;
+	e2fsck_pass1_block_map_r_unlock(ctx);
+
+	if (!check_mmp && !set_mmp)
+		return;
+
+	if (set_mmp) {
+		e2fsck_pass1_block_map_w_lock(ctx);
+		if (!global_ctx->mmp_update_thread) {
+			global_ctx->mmp_update_thread =
+				ctx->thread_info.et_thread_index + 1;
+			check_mmp = 1;
+		}
+		e2fsck_pass1_block_map_w_unlock(ctx);
+	}
+#else
+	check_mmp = 1;
+#endif
+
+	if (check_mmp && (ino % (fs->super->s_inodes_per_group * 4) == 1)) {
+		if (e2fsck_mmp_update(fs))
+			fatal_error(ctx, 0);
+	}
+}
+
+static void pass1_update_mmp_exit(e2fsck_t ctx)
+{
+	ext2_filsys fs = ctx->fs;
+	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
+	int set_mmp = 0;
+
+#ifdef HAVE_PTHREAD
+	e2fsck_pass1_block_map_r_lock(ctx);
+	if (global_ctx->mmp_update_thread == ctx->thread_info.et_thread_index + 1)
+		set_mmp = 1;
+	e2fsck_pass1_block_map_r_unlock(ctx);
+
+	if (!set_mmp)
+		return;
+
+	/* reset update_thread after this thread exit */
+	e2fsck_pass1_block_map_w_lock(ctx);
+	global_ctx->mmp_update_thread = 0;
+	e2fsck_pass1_block_map_w_unlock(ctx);
+#endif
+}
+
 static void pass1_readahead(e2fsck_t ctx, dgrp_t *group, ext2_ino_t *next_ino)
 {
 	ext2_ino_t inodes_in_group = 0, inodes_per_block, inodes_per_buffer;
@@ -1511,7 +1571,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	dgrp_t		ra_group = 0;
 	struct ea_quota	ea_ibody_quota;
 	struct process_inode_block *inodes_to_process;
-	int process_inode_count, check_mmp;
+	int process_inode_count;
 	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	init_resource_track(&rtrack, ctx->fs->io);
@@ -1675,33 +1735,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 #endif
 
 	while (1) {
-		check_mmp = 0;
 		e2fsck_pass1_check_lock(ctx);
-#ifdef	HAVE_PTHREAD
-		if (!global_ctx->mmp_update_thread) {
-			e2fsck_pass1_block_map_w_lock(ctx);
-			if (!global_ctx->mmp_update_thread) {
-				global_ctx->mmp_update_thread =
-					ctx->thread_info.et_thread_index + 1;
-				check_mmp = 1;
-			}
-			e2fsck_pass1_block_map_w_unlock(ctx);
-		}
-
-		/* only one active thread could update mmp block. */
-		e2fsck_pass1_block_map_r_lock(ctx);
-		if (global_ctx->mmp_update_thread ==
-		    ctx->thread_info.et_thread_index + 1)
-			check_mmp = 1;
-		e2fsck_pass1_block_map_r_unlock(ctx);
-#else
-		check_mmp = 1;
-#endif
-
-		if (check_mmp && (ino % (fs->super->s_inodes_per_group * 4) == 1)) {
-			if (e2fsck_mmp_update(fs))
-				fatal_error(ctx, 0);
-		}
+		pass1_update_mmp_enter(ctx, ino);
 		old_op = ehandler_operation(eop_next_inode);
 		pctx.errcode = ext2fs_get_next_inode_full(scan, &ino,
 							  inode, inode_size);
@@ -2458,13 +2493,7 @@ endit:
 		print_resource_track(ctx, _("Pass 1"), &rtrack, ctx->fs->io);
 	else
 		ctx->invalid_bitmaps++;
-#ifdef	HAVE_PTHREAD
-	/* reset update_thread after this thread exit */
-	e2fsck_pass1_block_map_w_lock(ctx);
-	if (check_mmp)
-		global_ctx->mmp_update_thread = 0;
-	e2fsck_pass1_block_map_w_unlock(ctx);
-#endif
+	pass1_update_mmp_exit(ctx);
 }
 
 #ifdef HAVE_PTHREAD
-- 
2.37.3

