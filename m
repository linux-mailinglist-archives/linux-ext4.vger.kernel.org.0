Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40281FF6B7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgFRP3H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbgFRP3C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769EC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a45so3492006pje.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XwGv29OSjpc0VxEzZsFXi1gc0oHOkGQ0HiDFcrZdgF4=;
        b=VVtYVeyoccCLdHYrYxSpM4sWOPxPUAv/IpkNRxYP527LsQK1IAvXfbk5SRHw7XrLdZ
         v4qjHVzKIz14pgH2hR/ztnaqV96i9kLToX1oxsPfnn7uln0t1G3FkeE/jXbFuPsJFxkx
         DBU+2GJdQZzRkv9XTURVPxZb2MBjsjqkPNgYduGl6HZZYfwgBivNmOkRTscAQ5/3AS7k
         JWetxfSTqAbnGFrx8nZF5jJc4AvO97SuHiovwFx1Fuz5zJI3lTxrdrRyzUoB8T2M7c8V
         +ibjH9nN8v/sfhFSAjVa2Vz6PMezme3qmKR2hGr9tGEVf2/FBqIwvHp/JomJ2Z+LuP/b
         TKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XwGv29OSjpc0VxEzZsFXi1gc0oHOkGQ0HiDFcrZdgF4=;
        b=PnLSDD+wtEM1TqUzQYWFAF2RzhacsNQvxIWkS+I5UPD0U3xuTvyugoB5KMok6KAfgg
         XQlVnO3w9nsMHB8g0QNxG7JPJT6ObnKEBtqVFOVlfyVVyhqpXwtB58q7K3xl9xKesD7+
         vZSEuxM4Juzoxsg82VtgaI6AdlSmLZx3zWf5jfovJps2qfwQJa0BIQfnsdiwphPIYgEn
         zJkdDX0WxPbmKTd6APwat3wRtqUBAt4N4Cj72HGN/4z2AGxcCfvfoOwcP/Z6Wa4vAo2W
         I8g0JZSZbdau36LmLastqbAwrly9sWp4Iirz+5aV8N3axCdjlUPGsLaJcmv/fg3ParX+
         V63g==
X-Gm-Message-State: AOAM532/OeFEQ2pTU4uW8zOjC/AClUgpNzca57JwdoFhifvm+FF8gS/t
        nBhrhYmtnOuIPkd4nA6QMMEUWDUS1KY=
X-Google-Smtp-Source: ABdhPJyucaN4Sd+pVjOWfvAN5yRK+0nkE5uHw4ZnFCzdaaJ91OZvNHSfG3kBCPgImGAqMILEsLMieA==
X-Received: by 2002:a17:90a:9d8b:: with SMTP id k11mr5010130pjp.10.1592494140737;
        Thu, 18 Jun 2020 08:29:00 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:00 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 20/51] e2fsck: merge dir_info after thread finishes
Date:   Fri, 19 Jun 2020 00:27:23 +0900
Message-Id: <1592494074-28991-21-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/dirinfo.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 e2fsck/e2fsck.h  |  2 ++
 e2fsck/pass1.c   | 20 +++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index f299620f..ea2fc75b 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -168,6 +168,72 @@ e2fsck_dir_info_min_larger_equal(struct dir_info_db *dir_info,
 	return -ENOENT;
 }
 
+/*
+ * Merge two sorted dir info to @dest
+ */
+void e2fsck_merge_dir_info(e2fsck_t ctx, struct dir_info_db *src,
+			   struct dir_info_db *dest)
+{
+	int		 size_dir_info = sizeof(struct dir_info);
+	ext2_ino_t	 size = dest->size;
+	struct dir_info	 *src_array = src->array;
+	struct dir_info	 *dest_array = dest->array;
+	ext2_ino_t	 src_count = src->count;
+	ext2_ino_t	 dest_count = dest->count;
+	ext2_ino_t	 total_count = src_count + dest_count;
+	struct dir_info	*array;
+	struct dir_info	*array_ptr;
+	ext2_ino_t	 src_index = 0;
+	ext2_ino_t	 dest_index = 0;
+
+	if (src->count == 0)
+		return;
+
+	if (size < total_count)
+		size = total_count;
+
+	if (size < src->size)
+		size = src->size;
+
+	array = e2fsck_allocate_memory(ctx, size * size_dir_info,
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
+			       (dest_count - dest_index) * size_dir_info);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_dir_info);
+			break;
+		}
+		if (src_array[src_index].ino < dest_array[dest_index].ino) {
+			*array_ptr = src_array[src_index];
+			src_index++;
+		} else {
+			assert(src_array[src_index].ino >
+			       dest_array[dest_index].ino);
+			*array_ptr = dest_array[dest_index];
+			dest_index++;
+		}
+		array_ptr++;
+	}
+
+	if (dest->array)
+		ext2fs_free_mem(&dest->array);
+	dest->array = array;
+	dest->size = size;
+	dest->count = total_count;
+}
+
 /*
  *
  * Insert an inode into the sorted array. The array should have at least one
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 121d1b9b..24f164a7 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -502,6 +502,8 @@ extern void read_bad_blocks_file(e2fsck_t ctx, const char *bad_blocks_file,
 
 /* dirinfo.c */
 extern void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent);
+void e2fsck_merge_dir_info(e2fsck_t ctx, struct dir_info_db *src,
+                           struct dir_info_db *dest);
 extern void e2fsck_free_dir_info(e2fsck_t ctx);
 extern int e2fsck_get_num_dirinfo(e2fsck_t ctx);
 extern struct dir_info_iter *e2fsck_dir_info_iter_begin(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 85444421..7a839d4b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2413,6 +2413,22 @@ out_context:
 	return retval;
 }
 
+static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	if (thread_ctx->dir_info == NULL)
+		return;
+
+	if (global_ctx->dir_info == NULL) {
+		/* TODO: tdb needs to be handled properly */
+		global_ctx->dir_info = thread_ctx->dir_info;
+		thread_ctx->dir_info = NULL;
+		return;
+	}
+
+	e2fsck_merge_dir_info(global_ctx, thread_ctx->dir_info,
+			      global_ctx->dir_info);
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2421,6 +2437,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_filsys	 global_fs = global_ctx->fs;
 	FILE		*global_logf = global_ctx->logf;
 	FILE		*global_problem_logf = global_ctx->problem_logf;
+	struct dir_info_db *dir_info = global_ctx->dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2452,6 +2469,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->block_metadata_map = block_metadata_map;
+	global_ctx->dir_info = dir_info;
+	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
@@ -2508,6 +2527,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_dup_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_metadata_map);
+	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
-- 
2.25.4

