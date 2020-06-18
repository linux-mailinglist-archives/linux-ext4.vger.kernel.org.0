Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D61FF6C2
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbgFRP3Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbgFRP3V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0CC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so2703531pjb.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Ptkto9eW6EpuFxELrn3zb88UhMwgJr19n9iU8/5Fe8=;
        b=tBt7lo5IHMQVkhZVleoeTspjsUhCYNBLwT7nLHlFr4ta4czJR1WEcmFKq0QR2watoy
         cLwKd10kM4/6HBX76OxKvCSMFI36dtioSe5TvtpRkCApLQnLzeNkfaxuF/LxjjF5NbIQ
         Fcpb6KIB/VrcVLoKqo4H3V8n5JAJZ06DWt5h9Ma3aW1+KarOYNCFmwpZtHDlzzeVnWFl
         XklJ/0pMVZO/nNWFyH6Vkiv9BjfTn2T6xe/eAWBvWPl2cn539L3xyjnAQv1ekwf4G+Ud
         nwrsftuudM4t52r4djrDCtyvrAV4pSsQvbiQ9MSvhRQtJPO35JwCETFBo8DuO/awbAVV
         uzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Ptkto9eW6EpuFxELrn3zb88UhMwgJr19n9iU8/5Fe8=;
        b=HvqWQLYIvI1mny5O7gsQDdRsjvW4XnQnXfcwaSxmNCtb0hz5/wiRNcO3bO0hX41e/i
         0Zwj3YjvNRA0DcUMBZVmLTbYCBcX/KdeEmoIeU/f9MBf/ZwBTBkBWAAe7SCG83x1ZPjQ
         LNj/M1i1vFaGqOek4eGPUlAgJKbqkpVd5hme6A4Il4fdPZJZNO8oVlkccNF3ocHft6mc
         OiNJmFU21IQObGDRyCqydsWcmjYuA6wn/fSBCoTWq/6OMxJxereHcXcWBA2bCepdlgCo
         fc+bP0//dXR4jHRHyLVCFoWhrCX1GQwWrWvjRcwgdqMi75n/yBo2qV3rGkXLp4d0NhmN
         VQJw==
X-Gm-Message-State: AOAM53398KmOATrDqrz673DoUoug0A43imilJeOdb2gMHQDMCSmM42kI
        taVQezrxJdk1fnojstSxZEuZ7dIYHtU=
X-Google-Smtp-Source: ABdhPJzqlMbMkz5uGPUqEZopl72RiktBIY53oMCgiwNYAGxyHYM2n8JfDk0qtt25hw4s4LXxkRtDjg==
X-Received: by 2002:a17:90b:e02:: with SMTP id ge2mr4317837pjb.205.1592494159504;
        Thu, 18 Jun 2020 08:29:19 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:18 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 28/51] e2fsck: merge dx_dir_info
Date:   Fri, 19 Jun 2020 00:27:31 +0900
Message-Id: <1592494074-28991-29-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Change-Id: I250de2d510e3c71974f6c853d5f6ff01229d5573
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/dx_dirinfo.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 e2fsck/e2fsck.h     |  1 +
 e2fsck/pass1.c      | 25 +++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index caca3e30..ed77271b 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -79,6 +79,71 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
 				       "dx_block info array");
 }
 
+/*
+ * Merge two sorted dir info to @dest
+ */
+void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	struct dx_dir_info *src_array = thread_ctx->dx_dir_info;
+	struct dx_dir_info *dest_array = global_ctx->dx_dir_info;
+	int size_dx_info = sizeof(struct dx_dir_info);
+	ext2_ino_t size = global_ctx->dx_dir_info_size;
+	ext2_ino_t src_count = thread_ctx->dx_dir_info_count;
+	ext2_ino_t dest_count = global_ctx->dx_dir_info_count;
+	ext2_ino_t total_count = src_count + dest_count;
+	struct dx_dir_info *array;
+	struct dx_dir_info *array_ptr;
+	ext2_ino_t src_index = 0, dest_index = 0;
+
+	if (thread_ctx->dx_dir_info_count == 0)
+		return;
+
+	if (size < total_count)
+		size = total_count;
+
+	array = e2fsck_allocate_memory(global_ctx, size * size_dx_info,
+				       "directory map");
+	array_ptr = array;
+	/*
+	 * This can be improved by binary search and memcpy, but codes
+	 * would be complexer. And if the groups distributed to each
+	 * thread are stided, this implementation won't be too bad comparing
+	 * to the optimiztion.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			memcpy(array_ptr, &dest_array[dest_index],
+			       (dest_count - dest_index) * size_dx_info);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_dx_info);
+			break;
+		}
+		if (src_array[src_index].ino < dest_array[dest_index].ino) {
+			*array_ptr = src_array[src_index];
+			src_index++;
+		} else {
+			/*
+			assert(src_array[src_index].ino >
+			       dest_array[dest_index].ino);
+			*/
+			*array_ptr = dest_array[dest_index];
+			dest_index++;
+		}
+		array_ptr++;
+	}
+
+	if (global_ctx->dx_dir_info)
+		ext2fs_free_mem(&global_ctx->dx_dir_info);
+	if (thread_ctx->dx_dir_info)
+		ext2fs_free_mem(&thread_ctx->dx_dir_info);
+	global_ctx->dx_dir_info = array;
+	global_ctx->dx_dir_info_size = size;
+	global_ctx->dx_dir_info_count = total_count;
+}
+
 /*
  * get_dx_dir_info() --- given an inode number, try to find the directory
  * information entry for it.
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index ec5b0fbc..8930e278 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -532,6 +532,7 @@ extern int e2fsck_dir_info_get_parent(e2fsck_t ctx, ext2_ino_t ino,
 				      ext2_ino_t *parent);
 extern int e2fsck_dir_info_get_dotdot(e2fsck_t ctx, ext2_ino_t ino,
 				      ext2_ino_t *dotdot);
+extern void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx);
 
 /* dx_dirinfo.c */
 extern void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino,
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 68b7ae26..c5107956 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2454,6 +2454,24 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
 			      global_ctx->dir_info);
 }
 
+static void e2fsck_pass1_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	if (thread_ctx->dx_dir_info == NULL)
+		return;
+
+	if (global_ctx->dx_dir_info == NULL) {
+		/* TODO: tdb needs to be handled properly */
+		global_ctx->dx_dir_info = thread_ctx->dx_dir_info;
+		global_ctx->dx_dir_info_size = thread_ctx->dx_dir_info_size;
+		global_ctx->dx_dir_info_count = thread_ctx->dx_dir_info_count;
+		thread_ctx->dx_dir_info = NULL;
+		return;
+	}
+
+	e2fsck_merge_dx_dir(global_ctx, thread_ctx);
+}
+
+
 #define PASS1_MERGE_CTX_ICOUNT(_dest, _src, _field)			\
 do {									\
     if (_src->_field) {							\
@@ -2485,6 +2503,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	FILE		*global_logf = global_ctx->logf;
 	FILE		*global_problem_logf = global_ctx->problem_logf;
 	struct dir_info_db *dir_info = global_ctx->dir_info;
+	struct dx_dir_info *dx_dir_info = global_ctx->dx_dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2514,6 +2533,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32	fs_fragmented = global_ctx->fs_fragmented;
 	__u32	fs_fragmented_dir = global_ctx->fs_fragmented_dir;
 	__u32	large_files = global_ctx->large_files;
+	int dx_dir_info_size = global_ctx->dx_dir_info_size;
+	int dx_dir_info_count = global_ctx->dx_dir_info_count;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2537,6 +2558,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_metadata_map = block_metadata_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	global_ctx->dx_dir_info = dx_dir_info;
+	global_ctx->dx_dir_info_count = dx_dir_info_count;
+	global_ctx->dx_dir_info_size = dx_dir_info_size;
+	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	global_ctx->inode_count = inode_count;
 	global_ctx->inode_link_info = inode_link_info;
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_directory_count);
-- 
2.25.4

