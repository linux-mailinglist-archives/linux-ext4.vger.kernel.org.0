Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0952B80FA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgKRPmT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgKRPmT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14CAC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:17 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 7so1327030pjm.3
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1P7rffJ7thv4qkZFeY0lM2jm0Zu/jaf+KpsPdqhTum0=;
        b=gJ2IzK5clZe7HMWQUhCGfcogPLtSwZLHJsrOM02Q+Gw6ruTBCe7RT+fbjyJnEzUBNx
         dpJAEhMzUb51oJceXvsqxV3VXONmqf6EMOiwpAWXNA1Qt9FUW6GqOO1/885mO5lLPWwN
         1eJXBdPaH5OoRA0VGPQkE1TBHsssYm+0KET3kVJeR/UBJ7GiDkWoJYcTHJbJdqMq0j+U
         r4zSvjAMRIvyquVoVYVIR4ODtlT8NBe+O6eYjB2VfKLt815SQmvNU00pK4UWpDfNPhfj
         4kHd+BI/nIGOOOiSIHR9aPORWz1WxsJXTt9bdOsiFVtTHwnGEoB/nnDqSnTyFcC/M3tt
         uLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1P7rffJ7thv4qkZFeY0lM2jm0Zu/jaf+KpsPdqhTum0=;
        b=E6RhyhGE/69aDu2Qkvd303sWGomw8xrzYAbwlLM9vP5+qovqqM5oGW19Iyfjgy0k1F
         Jt1s/HdtEYWQFEItc7HXDaqniySnhmT+fbMSs/MA6Ch8lHhk1usxY2fGyGnSQ8RU3uh8
         +ckc/VPitUp6T6aiR28+1r0u5j4J33YL6IXq9AZjbxhuXqgs0njHacsDkbpo+zMStY5C
         MgcwK/lKkZl8XWNiuPawn7SgtOhrqfnPbfFxlZse0DeSEYGC7KoN10uJKeEGgpUEFlO1
         VEAtXKz8HmEOg6hJk99p/YkuwxwTaKh5bWdb9pegAhUzCObAnGD5ltrtfeBuzCvW3a26
         2TCQ==
X-Gm-Message-State: AOAM5316b8nc5hhs5/5kywCXkfVEsRyERbfiNq8MCrPJ8SGM7IA55uHD
        8xl5XN0xZYFWBzl0JHIvLdf2oN+nW5MqAYXe02o0833dEK0wxbc3dKRRIl4XX/1QY9v9TmDWExn
        CAEwXQN70iK5XcrfGDHu4ppLZ4LJ/J7oTkN5VF8LXYHz/zVQkZn/ohJN2e4WOVkXziLoJ9KBmAl
        XNb/dS51U=
X-Google-Smtp-Source: ABdhPJzGs0m+TpJGTDHeg9e/hYdqtLqX7DbqHbVe9DDsewMMxerDMup+M4w0g+aR9555onHXatU5p8Yv0hM9tB+H2HI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a63:c00b:: with SMTP id
 h11mr8488387pgg.7.1605714137104; Wed, 18 Nov 2020 07:42:17 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:45 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-60-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 59/61] e2fsck: update mmp block race
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Update mmp block is only expected in one thread, @mmp_update_thread
is used to get/set active thread number, however this should
be set globally shared with different threads rather than be private
per thread.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8d4e2675..a51fe20f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1501,6 +1501,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	struct ea_quota	ea_ibody_quota;
 	struct process_inode_block *inodes_to_process;
 	int		process_inode_count, check_mmp;
+	e2fsck_t	global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
@@ -1652,14 +1653,11 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		check_mmp = 0;
 		e2fsck_pass1_check_lock(ctx);
 #ifdef	CONFIG_PFSCK
-		if (!ctx->mmp_update_thread) {
+		if (!global_ctx->mmp_update_thread) {
 			e2fsck_pass1_block_map_w_lock(ctx);
-			if (!ctx->mmp_update_thread) {
-				if (ctx->global_ctx)
-					ctx->mmp_update_thread =
-						ctx->thread_info.et_thread_index + 1;
-				else
-					ctx->mmp_update_thread = 1;
+			if (!global_ctx->mmp_update_thread) {
+				global_ctx->mmp_update_thread =
+					ctx->thread_info.et_thread_index + 1;
 				check_mmp = 1;
 			}
 			e2fsck_pass1_block_map_w_unlock(ctx);
@@ -1667,8 +1665,8 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 
 		/* only one active thread could update mmp block. */
 		e2fsck_pass1_block_map_r_lock(ctx);
-		if (!ctx->global_ctx || ctx->mmp_update_thread ==
-			(ctx->thread_info.et_thread_index + 1))
+		if (global_ctx->mmp_update_thread ==
+		    ctx->thread_info.et_thread_index + 1)
 			check_mmp = 1;
 		e2fsck_pass1_block_map_r_unlock(ctx);
 #else
@@ -2396,8 +2394,8 @@ endit:
 #ifdef	CONFIG_PFSCK
 	/* reset update_thread after this thread exit */
 	e2fsck_pass1_block_map_w_lock(ctx);
-	if (ctx->mmp_update_thread)
-		ctx->mmp_update_thread = 0;
+	if (check_mmp)
+		global_ctx->mmp_update_thread = 0;
 	e2fsck_pass1_block_map_w_unlock(ctx);
 #endif
 }
-- 
2.29.2.299.gdc1121823c-goog

