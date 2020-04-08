Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320D91A1EF8
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDHKqE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39551 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgDHKqE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id k15so2229980pfh.6
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AqvRCs3ZlO4YydxJaPbgxf7EDC02H6wPxawH/CU/hrw=;
        b=QIHVm7KclOvjAmFAXVLTBxUEgbVKzfWUQE42/5dOMP6e7oJ88Y+sUcsZtODv6B+UVj
         x4duBRqZMa/j7J3bq8hPUIrAVatg7SMXTzJrz6VmrBkh/Y4V7m9j6mmkX/jg61OagKZc
         /M5kRPq7xVXxsXBl0UMhq6YE7kOSG5wxbdE64fpZeEEGxCp8SYAJHt6L0DVVNYtCYvE7
         bduwiFrs9ISYZG9nmbgr8boBNdiSIiZfIB6pDbt/n42oC+HMMNQmyftktB1D577bz6rQ
         6AbK89RANqKCtWBPNY1qi/HhRkaV7A+Nw701irabhQqaOVoyVhlQ7Kk6DbWG4aL+s46f
         ZaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AqvRCs3ZlO4YydxJaPbgxf7EDC02H6wPxawH/CU/hrw=;
        b=iqEb4uB5NMdsiI6a257TMRAhnn8ulePzlXWjGWKOFdwlwR+LFIQEWv+i3izD8ak1U6
         eRxp2ktQ2gk7fdNKIWcJ//DIRD6TxX6sEGYwA8Ncu0FbMalH6MXaTWs4xewf3dMtAYP5
         YXicV3+ZoqPCqfd8/4PqxPbU2TBBH8NdTd4oG/F/FIlq9AiSeNRmxzEmKKTEv9lvzK7R
         emZzdvpqZiHWwhjMBx9MaKqIye64nSd77EFr5wbBHRgtNI44AQIu1+cNO8uwtBjoZbQP
         j/0w2sXyJ1091nrfpwFgiPcpzPs7jQ6VMoTVtbkXXXCTAYNHtOLWyt+kpU6fMrpYqje5
         GQ+g==
X-Gm-Message-State: AGi0PuYvDtyBpEfciUiXE4bqeZ7Zz45uzvjN4rcriQrUdKZDVp0PCXnL
        kvvZHkFKMiMiwNrUAdnb/AV2UH09d9Y=
X-Google-Smtp-Source: APiQypJDf1FkojlMlxAeDXHecbbXhe6V/kmd/RieOegAG8Qrcb+j60U9FYNDFOu8sUhN70fnZ595EQ==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr7263007pfs.36.1586342763011;
        Wed, 08 Apr 2020 03:46:03 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:02 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 14/46] e2fsck: split groups to different threads
Date:   Wed,  8 Apr 2020 19:44:42 +0900
Message-Id: <1586342714-12536-15-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 811d3991..8147e944 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2319,13 +2319,15 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 
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
@@ -2364,11 +2366,20 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
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
@@ -2529,7 +2540,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
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
2.25.2

