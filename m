Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C41FF6B0
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgFRP2z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbgFRP2u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8299DC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h10so3041791pgq.10
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUk8ZtFTjcF0YQxV/YZ+rPk/mhgum1784BHQzXwXuBk=;
        b=RMuWLgkc017Ppd+NH7J5rEIs/IC2SN++9OpDKUU9DwGIYDjR1DS7S1RY+kEMPjSHrp
         7wdhLT/rIOMG83zOj3eup6/V2e688XJtrOWih0Tuq1P6EM60t+mLsDqZuZPPCss9Qq43
         gi+ba4MKHVu0P/Q/tVJSL/B2QVnHLi3T8CkgeOW9P7EvvgD80Ti2pi/o0IEnV8+tFfMQ
         LVJtr0qEhVqP5KP/TWIR8qAmUMKvkGDylsfBrjkHMJkz5v7b88FXJzVFxrn+ibaMsz8Z
         y7EEidTn+bJUsTxEE27CC2ot/cmNtdHqb/lfRsMaKofRSsGKxSN1GpW4iigX+u7DUrE/
         5J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UUk8ZtFTjcF0YQxV/YZ+rPk/mhgum1784BHQzXwXuBk=;
        b=IslUlVx1OA6ta3ZRHP7lyNm3NzV4eHOi/0M2ieCVkps7qID4XJIxolYouHVae8fxsX
         qcBLfNn/ANwu25oM8bmmMxUiq03Rp0u31zraX0r9kpZzGRAgiL2SFGIm2kqrnaBkMjBZ
         V9++Vh8hxYCLiMo4a8++ChOo76HXIlm/xKSTcmgncaWGP7q6u5as440pv+lqwEZecjuX
         c1KiLEDx3mJEC5ADB7bobKHKL1B2X/+zqw2sORNJZUe4h7sbC4uqTteyVtmMvFix06Rb
         wWr6Bn+KUfx39mrnxy0+MGWoo01BICCyYKFfrZZ/1+UuB60e+0sW+tpnbVgBaX8GxDZX
         IZ0w==
X-Gm-Message-State: AOAM533b9uwVIxf0ayBL5A0CAz4kXx8gB+iCpzmHAR32SyZC5++ErTbw
        PnvL2fbRoTv5XoROMdUWRu2jdJDZ0/w=
X-Google-Smtp-Source: ABdhPJzufp1F7TTrxPDylZ9v0sltMEbUJ/e8CLBh1I1I9V6OAUZhGRMMSLguJR/FdzYI+v2vOJ4FPw==
X-Received: by 2002:a62:8487:: with SMTP id k129mr4145117pfd.296.1592494128744;
        Thu, 18 Jun 2020 08:28:48 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:48 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 15/51] e2fsck: split groups to different threads
Date:   Fri, 19 Jun 2020 00:27:18 +0900
Message-Id: <1592494074-28991-16-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

The start/end groups of a thread is calculated according to the
thread number. But still, only one thread is used to check.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 45915513..c676cbbc 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2301,13 +2301,15 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 					     e2fsck_t *thread_ctx,
-					     int thread_index)
+					     int thread_index,
+					     int num_threads)
 {
 	errcode_t		 retval;
 	e2fsck_t		 thread_context;
 	ext2_filsys		 thread_fs;
 	ext2_filsys		 global_fs = global_ctx->fs;
 	struct e2fsck_thread	*tinfo;
+	dgrp_t			 average_group;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2346,11 +2348,20 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
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
@@ -2511,7 +2522,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
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
2.25.4

