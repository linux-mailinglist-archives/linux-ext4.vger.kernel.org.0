Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595F52B80E5
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgKRPlf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRPlf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:35 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CDC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:33 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id 100so1653347qtf.14
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iMZrbO0dmf4V31EW7iI98HkF+2Wa62X/z0L1CLIakiA=;
        b=Ct6JKe4IPdiP637C3/6PucYEq4uzAc/Oyhj/EAg9bNa6XOQ55HkM5yfVfUVEzblFPX
         TAyFecKuJYBAp5rz/EnjKXqei/aHadIosmmV+W+rKArUpV15K+8cs61BCZi1SnUimKy5
         TtC7NrdSHVQ6kZ5pBk7y3j7eHEshvzdqoLrcUWuPgGMxXdQ21dx0MtCsG7PtiJURh9o4
         6rbzapg2+/75F6u9HMh2Ux7ySy6mtURB987xlbpufG6zCreyMQwaiq56CtLVe64ei7ki
         wwrL/Fk1JoascAVr+L6MHww/1xaaRuq3cEa/ukADtfjS85J3qUiLQrgiY55dlGnkGiT/
         UBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iMZrbO0dmf4V31EW7iI98HkF+2Wa62X/z0L1CLIakiA=;
        b=jllsJotA99eJrH18jDWLW74TtDtQo12doJx/hO+NnLri646dfWbiCHhNE0QlEvE7Qr
         bvAgVb6n+3OmovCuM/UsAAtvHTK+s0in8z9MFwOgAAyXjx+lUrPEgj/3UN69kCVSqv1b
         QBTnfBfgp4o5CA0UmA0rPXWY4Plh9lEwqMOqLeENO4Vphj7nrAq5UGLTFMFYjsvaSL7J
         DY//kjh34B5iZPeaO1ksBCaoeq33pvh5GscoHnSv9qpHrIyvSXp/lFpHrOf2800UecDx
         3VvQgvpDA8onga9dhZxNBNiEu1V7qhDGZdlm0Tmo1iNMFx287KC0u2JzhZsIsZBhg1f4
         J0Nw==
X-Gm-Message-State: AOAM532Ek747lqCNqML6j4blxFuJMvGpAtlbxPxm8U+WC0HT5+OUNR1H
        q2I5i//P8kIaGKin2h9THtWJm9n7spUqamCFA193t0PXp7dwNXvPNVTMmvNmIQ3zVKvbVLhJplN
        5gv8ST7Th347q4YVKFf7WedHiQSdz7iy/hbKcCQZyjpMH1ooRfVfRBqcw5qfbNLOIYPv0Y4s13P
        a8j0F2E8w=
X-Google-Smtp-Source: ABdhPJzmnBNAWIEnBtQLGe2cva5+ZBHqgYEYStyTskraz/j0iHWF/k2kI1tSj9+CsIkFd6GvX9amFDLLM7t+uVJMaUM=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:9e65:: with SMTP id
 z37mr5049609qve.39.1605714092824; Wed, 18 Nov 2020 07:41:32 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:22 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-37-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 36/61] e2fsck: fix readahead for pfsck of pass1
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
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
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index e2387fe3..ad3bd8be 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1093,16 +1093,19 @@ out:
 static void pass1_readahead(e2fsck_t ctx, dgrp_t *group, ext2_ino_t *next_ino)
 {
 	ext2_ino_t inodes_in_group = 0, inodes_per_block, inodes_per_buffer;
-	dgrp_t start = *group, grp;
+	dgrp_t start = *group, grp, grp_end = ctx->fs->group_desc_count;
 	blk64_t blocks_to_read = 0;
 	errcode_t err = EXT2_ET_INVALID_ARGUMENT;
 
+#ifdef CONFIG_PFSCK
+	grp_end = ctx->thread_info.et_group_end;
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
@@ -1295,12 +1298,25 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 {
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
+	unsigned long long readahead_kb;
 
 	init_ext2_max_sizes();
-#ifdef	CONFIG_PFSCK
+#ifdef CONFIG_PFSCK
 	e2fsck_pass1_set_thread_num(ctx);
 #endif
+	/* If we can do readahead, figure out how many groups to pull in. */
+	if (!e2fsck_can_readahead(ctx->fs))
+		ctx->readahead_kb = 0;
+	else if (ctx->readahead_kb == ~0ULL)
+		ctx->readahead_kb = e2fsck_guess_readahead(ctx->fs);
 
+#ifdef CONFIG_PFSCK
+	/* don't use more than 1/10 of memory for threads checking */
+	readahead_kb = get_memory_size() / (10 * ctx->fs_num_threads);
+	/* maybe better disable RA if this is too small? */
+	if (ctx->readahead_kb > readahead_kb)
+		ctx->readahead_kb = readahead_kb;
+#endif
 	clear_problem_context(&pctx);
 	if (!(ctx->options & E2F_OPT_PREEN))
 		fix_problem(ctx, PR_1_PASS_HEADER, &pctx);
@@ -1477,13 +1493,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
2.29.2.299.gdc1121823c-goog

