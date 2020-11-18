Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD052B80CA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgKRPkt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgKRPkt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:49 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CDC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:49 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h26so1677329qtm.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZnGtja/sj84oN6FfDg+4r0m87hM6YEhtSifoAfNEgoM=;
        b=afoHOGz7MaVLAy+GOsejvY11HQGdmyf5+LvejNyyQ5wymuYdcCK2w8TQSu5o8/Gi+V
         o6/HIYdE+anipOffQpOuKgaHRCdkXzioC9RoZ2yllN3dv6wCWYUM+qqcSw1RUcXHOlyd
         vYuM7vixkcoJ959ECK3+DrJ4YDVlztC/CLUCD6D5WmCk2Flcyqe/kERUJHSvYakaWuHY
         UZ5qtJOIH1k5tkWtU7RcGslCKoCgeC737VbDGDwl8CqB4aOi/tfm4ffqkAmHVKohUOgT
         uR9C9HProSYdr9VMX1e5fCfDcYf7yhVz8zcvRWr0OfDGYw4W0hy5qKSdSREdKWVPcYfe
         J5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZnGtja/sj84oN6FfDg+4r0m87hM6YEhtSifoAfNEgoM=;
        b=fyvhxL7t3gWQ5Rc/AYQx5HqCZ42GHlwyO6VaZCQEZL5KnFstIB1zk+eGSKrLbKQb4H
         e2emIMzqp9hRDbiRYdcehN+sLU60uTnkR3uhm9ObWcDwg4sfz6wPWeCxcZN9K9VwGijH
         tlljNB8ns7X+tE8XAyUnr76ZYwhgSP8sm+wrnFH5KZ5HzU4UJY/RkFWB1r6ACYgZA0Yq
         xGHLVc8bVgk2Q3iflhqteRpZmsGgd46P5kJRCr3j0WN42SMrkB255lLoM+lVLJfAPAf6
         zXr5nepNUYpxkjLDe4kZwxJbXsHyY883PuyHcJ84kFY0vCMQhknsI2r2bGJWMtMcgffP
         MfKw==
X-Gm-Message-State: AOAM533qRboRlIGkBImtEnRWMMyp6jtpTVptmAIVOC1y34NuX7x+D3Ml
        LQ75hPJsKzqv8AjpfjtUVTBMOM0ZP3z+HeTO+qMqRMv2mk7RIbUp77tnlhPxiSLQ4YSTj/k6jlk
        xX32t7OM/Y/D6LaxA6FD35gYSeA794Rzo/0zKTairL++PocBtOirAznE04vrAGmLGlRPFloM6vp
        Auw1pIGk8=
X-Google-Smtp-Source: ABdhPJyv/UBiUt2jpG+vPOw1wjZ37BDclwGekKpeALVXyXmv99GBYMb1gldHmCLJ2uMEZzbBlhifLf1EeHV2pYlFK+o=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:e0c9:: with SMTP id
 x9mr5478809qvk.56.1605714048142; Wed, 18 Nov 2020 07:40:48 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:58 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-13-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 12/61] e2fsck: split groups to different threads
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

The start/end groups of a thread is calculated according to the
thread number. But still, only one thread is used to check.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index bb32511f..fd354529 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2232,13 +2232,14 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
-					     int thread_index)
+					     int thread_index, int num_threads)
 {
 	errcode_t		retval;
 	e2fsck_t		thread_context;
 	ext2_filsys		thread_fs;
 	ext2_filsys		global_fs = global_ctx->fs;
 	struct e2fsck_thread	*tinfo;
+	dgrp_t			average_group;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2278,11 +2279,20 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	thread_context->thread_info.et_thread_index = thread_index;
 	set_up_logging(thread_context);
 
-	assert(thread_index == 0);
+	/*
+	 * Distribute work to multiple threads:
+	 * Each thread work on fs->group_desc_count / nthread groups.
+	 */
 	tinfo = &thread_context->thread_info;
-	tinfo->et_group_start = 0;
-	tinfo->et_group_next = 0;
-	tinfo->et_group_end = thread_fs->group_desc_count;
+	average_group = thread_fs->group_desc_count / num_threads;
+	if (average_group == 0)
+		average_group = 1;
+	tinfo->et_group_start = average_group * thread_index;
+	if (thread_index == num_threads - 1)
+		tinfo->et_group_end = thread_fs->group_desc_count;
+	else
+		tinfo->et_group_end = average_group * (thread_index + 1);
+	tinfo->et_group_next = tinfo->et_group_start;
 
 	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
@@ -2506,7 +2516,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
-		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx, i);
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx,
+						     i, num_threads);
 		if (retval) {
 			com_err(global_ctx->program_name, retval,
 				_("while preparing pass1 thread\n"));
-- 
2.29.2.299.gdc1121823c-goog

