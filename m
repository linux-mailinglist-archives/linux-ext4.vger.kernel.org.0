Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794E11A1F05
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgDHKqc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34370 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id v23so2880788pfm.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hhjg0I3z+KfU2knk+zX2J3FcwBTvj22ehCcd4jD/2U=;
        b=YWCPWCTpuXWqR66VLWnSx55kAHtzIshOPTfjgxXa1xix7Ejiz0FxINrbqdTcFHTJze
         yPV+0sqnamitC8CTmeB5lmgBF0lPegcGjresCraBzUxz4dr1gD2J5C7rj9Bx+Jh8HDc2
         C0PsJNoHnSRP6Ayqqpj8VgZLLLgRN0BLQm8kI44S39tAtwrrcaWD1pR6WaR6pVf5HvJ+
         soZX44Ylv7Zje8DMYYIcbFyC7f1waxrcRm+ca8bygus6PnvIBpiiTue1yW5o1FPY+TBp
         Sv6GtYQK7z+RQusI+9bG8w/s4R4qUDfr5gqTZaNo9TpnVftiHGgnWfUgT/f5rDQN8SnN
         XQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hhjg0I3z+KfU2knk+zX2J3FcwBTvj22ehCcd4jD/2U=;
        b=n3mcgsrOk/q3IeQYhQp1sARTuE4vLDnNvJhvS5v9j1SL0f1AaI4o45Atmiy5t9UltI
         KObu4IO+wTJBOLj6b9+y6jX7aDwZKxcukFxDhRVxI9nGMl7QjmFJ+DBDsRBpQcLopcYt
         7f+TvoPZYN85Cmj5gUBhR7Fq3odK3E7K5LTjTSv2hUZ81W/E1XD7yMrLJVJVKKxhYbpN
         SXeYPqJEq8cY1Pu8sweC+oE6q4vfUWtqmL3cyAQHcq6VhCBuVEnyBEUuRcfvP7OZKwLW
         bAs+paXvi+Zar8dOXPGb2uVH940i8fv6Xx/lYtgZ8taVezNXv3L+WyQHk/mmj++gwTGG
         ldGA==
X-Gm-Message-State: AGi0PuZhC6puSaH4Ru3wzM+g+5fxozruJAtpselFkQFE28KLHkT4GUZ+
        OrxqQbQPS81pbSL0z+MvRowI8sm0h5M=
X-Google-Smtp-Source: APiQypJuZBZHaas1Rk4jABvg0XkX7Bqocnc9dcssLVmhyIg7Zel9w13N1ATnXEcuNmVcU5zcsuR2eQ==
X-Received: by 2002:aa7:85c4:: with SMTP id z4mr7174377pfn.121.1586342790713;
        Wed, 08 Apr 2020 03:46:30 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:30 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 27/46] e2fsck: merge dx_dir_info
Date:   Wed,  8 Apr 2020 19:44:55 +0900
Message-Id: <1586342714-12536-28-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Change-Id: I250de2d510e3c71974f6c853d5f6ff01229d5573
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/dx_dirinfo.c | 67 +++++++++++++++++++++++++++++++++++++++++++++
 e2fsck/e2fsck.h     |  1 +
 e2fsck/pass1.c      | 25 +++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index c0b0e9a4..cf9849dc 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -80,6 +80,73 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
 
 }
 
+/*
+ * Merge two sorted dir info to @dest
+ */
+void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	struct dx_dir_info *src_array = thread_ctx->dx_dir_info;
+	struct dx_dir_info *dest_array = global_ctx->dx_dir_info;
+	int size_dx_info = sizeof(struct dx_dir_info);
+	int size = global_ctx->dx_dir_info_size;
+	int src_count = thread_ctx->dx_dir_info_count;
+	int dest_count = global_ctx->dx_dir_info_count;
+	int total_count = src_count + dest_count;
+	struct dx_dir_info *array;
+	struct dx_dir_info *array_ptr;
+	int src_index = 0, dest_index = 0;
+	int i;
+
+	if (thread_ctx->dx_dir_info_count == 0)
+		return;
+
+	if (size < total_count)
+		size = total_count;
+
+	if (size < thread_ctx->dx_dir_info_size > size)
+		size = size;
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
+	global_ctx->dx_dir_info = array;
+	global_ctx->dx_dir_info_size = size;
+	global_ctx->dx_dir_info_count = total_count;
+}
+
 /*
  * get_dx_dir_info() --- given an inode number, try to find the directory
  * information entry for it.
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 61761684..0b449b69 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -545,6 +545,7 @@ extern struct dx_dir_info *e2fsck_get_dx_dir_info(e2fsck_t ctx, ext2_ino_t ino);
 extern void e2fsck_free_dx_dir_info(e2fsck_t ctx);
 extern int e2fsck_get_num_dx_dirinfo(e2fsck_t ctx);
 extern struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx, int *control);
+extern void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx);
 
 /* ea_refcount.c */
 typedef __u64 ea_key_t;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 4bd1f8be..6789b701 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2472,6 +2472,24 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2503,6 +2521,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	FILE		*global_logf = global_ctx->logf;
 	FILE		*global_problem_logf = global_ctx->problem_logf;
 	struct dir_info_db *dir_info = global_ctx->dir_info;
+	struct dx_dir_info *dx_dir_info = global_ctx->dx_dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2532,6 +2551,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32	fs_fragmented = global_ctx->fs_fragmented;
 	__u32	fs_fragmented_dir = global_ctx->fs_fragmented_dir;
 	__u32	large_files = global_ctx->large_files;
+	int dx_dir_info_size = global_ctx->dx_dir_info_size;
+	int dx_dir_info_count = global_ctx->dx_dir_info_count;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2555,6 +2576,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
2.25.2

