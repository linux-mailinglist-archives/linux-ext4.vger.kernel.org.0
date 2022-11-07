Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D22661F320
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiKGM1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiKGM1b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:31 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAE61AD9C
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id io19so10902582plb.8
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vXp8gmCs7RJtvSM1K3okUNxQLRdt0i4KzUMdrYIHMw=;
        b=ZY/uTqZrOX1BayaeCvfHJBmak+TKfUkEja263WJS+tgEqk0ZGqXUyfyFohSNWW6RSF
         +IGTjs+Oi/201H79RkHlse85j77kre8kn3NfXA2vOI77pHfHIaekNIdn2Ps1KDYLWIOh
         w5hP8WGcCMilBloH0m27Al4r0naAHOt2Rid+haClglASWYEy3tVCV2aC2foGUR7cBRGW
         pG5Ob2wfFFDRIBhY+sFpOC7gd+4eIlC4vwUKODZH+mTYAGqq+NU0Y0hB1an0sNe/Nk3g
         HtFhfp217opTyykG0wpz6gJtgljqc7i4x12xP8NI2md+GJ/wYniMtsKviZzxGXq64XEe
         vbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vXp8gmCs7RJtvSM1K3okUNxQLRdt0i4KzUMdrYIHMw=;
        b=dFSWwVc9C/HpSIwmJjCPXN+t2J2wrLSKRVoCwCpzQu9MmA3rzL7kuC8tsWhGNhLZ6J
         oa/c0puZhx6O+ddmLzK+GAPGR/haYks8OFntRfZJW8X1Pzqsu90xLsqdHHLtPpZlZPjJ
         eI3WCU+3sQIHbz2GWsDuBQ32Zqn5MLLwwLg2OEAn46dvfqdE0/RFrdsZjsqkbNUwv1Vj
         qKHKWwIbLR8wVjT+YApHm9K/HVtl5tce7OExmHlB8uB16Tpdw8q0gUPXu7y2G5NkdPvU
         UDqTYMDLK5vW84kmBzmZcG5g+Twj7crdGLib8helpkjdpyH4Ddd15EaFilBK5Qf3arDh
         Oj3w==
X-Gm-Message-State: ACrzQf1Rckt+4v9r21UI15QVQ2S2c+25uDPaX2ZNaksJzoQHIkfoXlRO
        2KltBY0rLjhAE2AGhTn1t1M=
X-Google-Smtp-Source: AMsMyM5Ae9XAhgp11eTyPnWSKe22pspMICLnwupLSoNxkwH+9c4sul9qH+BdHyFsr+gy8Q7A/cs6IQ==
X-Received: by 2002:a17:902:e8cd:b0:186:9efc:6790 with SMTP id v13-20020a170902e8cd00b001869efc6790mr50590382plg.91.1667824049651;
        Mon, 07 Nov 2022 04:27:29 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id h20-20020aa796d4000000b00560a25fae1fsm4325343pfq.206.2022.11.07.04.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:28 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 50/72] e2fsck: fix readahead for pfsck of pass1
Date:   Mon,  7 Nov 2022 17:51:38 +0530
Message-Id: <7fce79fc82c97b0ff5c9b7e81f3c2f343316c706.1667822611.git.ritesh.list@gmail.com>
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

Several improvments for this patch:

1) move readahead_kb detection to preparing phase.
2) inode readahead should be aware of thread block group
boundary.
3) make readahead_kb aware of multiple threads.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 1d4f576c..5d07daec 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1098,16 +1098,20 @@ out:
 static void pass1_readahead(e2fsck_t ctx, dgrp_t *group, ext2_ino_t *next_ino)
 {
 	ext2_ino_t inodes_in_group = 0, inodes_per_block, inodes_per_buffer;
-	dgrp_t start = *group, grp;
+	dgrp_t start = *group, grp, grp_end = ctx->fs->group_desc_count;
 	blk64_t blocks_to_read = 0;
 	errcode_t err = EXT2_ET_INVALID_ARGUMENT;
 
+#ifdef HAVE_PTHREAD
+	if (ctx->fs->fs_num_threads > 1)
+		grp_end = ctx->thread_info.et_group_end;
+#endif
 	if (ctx->readahead_kb == 0)
 		goto out;
 
 	/* Keep iterating groups until we have enough to readahead */
 	inodes_per_block = EXT2_INODES_PER_BLOCK(ctx->fs->super);
-	for (grp = start; grp < ctx->fs->group_desc_count; grp++) {
+	for (grp = start; grp < grp_end; grp++) {
 		if (ext2fs_bg_flags_test(ctx->fs, grp, EXT2_BG_INODE_UNINIT))
 			continue;
 		inodes_in_group = ctx->fs->super->s_inodes_per_group -
@@ -1300,12 +1304,25 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 {
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
+	unsigned long long readahead_kb;
 
 	init_ext2_max_sizes();
-#ifdef	HAVE_PTHREAD
+#ifdef HAVE_PTHREAD
 	e2fsck_pass1_set_thread_num(ctx);
 #endif
+	/* If we can do readahead, figure out how many groups to pull in. */
+	if (!e2fsck_can_readahead(ctx->fs))
+		ctx->readahead_kb = 0;
+	else if (ctx->readahead_kb == ~0ULL)
+		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
 
+#ifdef HAVE_PTHREAD
+	/* don't use more than 1/10 of memory for threads checking */
+	readahead_kb = get_memory_size() / (10 * ctx->fs_num_threads);
+	/* maybe better disable RA if this is too small? */
+	if (ctx->readahead_kb > readahead_kb)
+		ctx->readahead_kb = readahead_kb;
+#endif
 	clear_problem_context(&pctx);
 	if (!(ctx->options & E2F_OPT_PREEN))
 		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
@@ -1482,13 +1499,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
 
-	/* If we can do readahead, figure out how many groups to pull in. */
-	if (!e2fsck_can_readahead(ctx->fs))
-		ctx->readahead_kb = 0;
-	else if (ctx->readahead_kb == ~0ULL)
-		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
 	pass1_readahead(ctx, &ra_group, &ino_threshold);
-
 	if (ext2fs_has_feature_dir_index(fs->super) &&
 	    !(ctx->options & E2F_OPT_NO)) {
 		if (ext2fs_u32_list_create(&ctx->dirs_to_hash, 50))
-- 
2.37.3

