Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAAF2B80DA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgKRPlP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgKRPlO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:14 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E5C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:13 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id q25so1748481qkm.17
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LVEJhiemBDfRK4/0xdGtq4GMglkRsz7xq1OFu8Mg2Gg=;
        b=CCbQAK18qIB+sQgSHh7h2sIhSicHFU2l2lPavQFnWKvWRNM6GnW1zR4bxSGApdr4JI
         SOrZb7FOORcQZpz5RWdybc3vgyHdZ3sXi94kO8c7p5MAu5uUJOaHtHRSvPwzF6aXHzqg
         DK1UBMg0LXIypAYipyoZdgL8E8dbOXlJMVtTC0XyFE66qwe7R384bXSBlekTJ8azEpJX
         H3QIIeehdpIP0bT51P3fJneOy7vqWIYPPvfcZdYCNWndAsgTCzw1guydz9APegUfqAtU
         MRREQQEALLfak/rWUkF5D/LV39sxF2aS4Rw110yCneOlI1q7opRTMc9e6AhjLxd4PQkp
         DPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LVEJhiemBDfRK4/0xdGtq4GMglkRsz7xq1OFu8Mg2Gg=;
        b=N7i3opmGtP93VXUH3ndVl9DfkfFoCaj5OVnvsk5hkPGpL1IUwGFYGT7kWEZhpS62oy
         VgE7NDSP5IpwCMTPpRaPqvw6Sg02bmrYbdNnwZhoE/fOAP+jFUBUCW/tINAC8NXW94Ct
         fZYqihMDxPyPh75As/rL1OeGZhgLFTrHSZIH5ipC21mGPvyS3+ceXttg0lvXSziR1ZgF
         SltJ9TlEuTfkPvb5YoOiMYCpkUQMuULcLWA8cpn+XNR1pH5Dbra6zRXtMEEaC6WZDX5u
         ybSi/p/K13QZBVcDVEnE4QbPMcQsxZPbrqtwpzsUY4Ydws2orUt4uCH5GQDvZYe+5Kmh
         mfoA==
X-Gm-Message-State: AOAM531WZ7D8QHUw9qthXzlkMCzrYT2GG62upKppS6STE4/hon8cDpAf
        VqM5uUU2osfRkj7Zv/cyTieDaaIDUlu6WabhO6Kp3jWvWQF9HdATPxzwdol7oZDfvBA0b/e0hpU
        4nAb0lzDmwDoLopC2eD4G9VcUB0FYFNVFUsEZeCMGdwbMYh0Gpj11ZpvBd8lIdBUkB0ICIX6J3m
        dDjlxsAw4=
X-Google-Smtp-Source: ABdhPJwPcLz+gbYDMTTaYzvjBvF6DpuZns+LROSsZLP0NGCPRyeeSjJ56EIklA8TQr9UUQU96YZSC3dRyQVMR9SYTBQ=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:b181:: with SMTP id
 v1mr5593598qvd.36.1605714072316; Wed, 18 Nov 2020 07:41:12 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:11 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-26-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 25/61] e2fsck: merge dx_dir_info after threads finish
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Merge properly.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/dx_dirinfo.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 e2fsck/e2fsck.h     |  1 +
 e2fsck/pass1.c      | 23 ++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index caca3e30..91954572 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -5,6 +5,7 @@
  * under the terms of the GNU Public License.
  */
 
+#include <assert.h>
 #include "config.h"
 #include "e2fsck.h"
 
@@ -79,6 +80,69 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
 				       "dx_block info array");
 }
 
+/*
+ * Merge two sorted dir info to @dest
+ */
+void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	struct dx_dir_info *src_array = thread_ctx->dx_dir_info;
+	struct dx_dir_info *dest_array = global_ctx->dx_dir_info;
+	size_t size_dx_info = sizeof(struct dx_dir_info);
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
+	 * would be more complex. And if the groups distributed to each
+	 * thread are strided, this implementation won't be too bad
+	 * comparing to the optimiztion.
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
+			assert(src_array[src_index].ino >
+			       dest_array[dest_index].ino);
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
index 972c8410..c3b0af34 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -539,6 +539,7 @@ extern int e2fsck_dir_info_get_parent(e2fsck_t ctx, ext2_ino_t ino,
 				      ext2_ino_t *parent);
 extern int e2fsck_dir_info_get_dotdot(e2fsck_t ctx, ext2_ino_t ino,
 				      ext2_ino_t *dotdot);
+extern void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx);
 
 /* dx_dirinfo.c */
 extern void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino,
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 783e14f0..7095e8b4 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2412,6 +2412,22 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
 			      global_ctx->dir_info);
 }
 
+static void e2fsck_pass1_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	if (thread_ctx->dx_dir_info == NULL)
+		return;
+
+	if (global_ctx->dx_dir_info == NULL) {
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
 static inline errcode_t
 e2fsck_pass1_merge_icount(ext2_icount_t *dest_icount,
 			  ext2_icount_t *src_icount)
@@ -2457,6 +2473,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	FILE		*global_problem_logf = global_ctx->problem_logf;
 	ext2fs_inode_bitmap inode_bad_map = global_ctx->inode_bad_map;
 	struct dir_info_db *dir_info = global_ctx->dir_info;
+	struct dx_dir_info *dx_dir_info = global_ctx->dx_dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2486,6 +2503,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32 fs_fragmented = global_ctx->fs_fragmented;
 	__u32 fs_fragmented_dir = global_ctx->fs_fragmented_dir;
 	__u32 large_files = global_ctx->large_files;
+	ext2_ino_t dx_dir_info_size = global_ctx->dx_dir_info_size;
+	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2510,6 +2529,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_metadata_map = block_metadata_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	global_ctx->dx_dir_info = dx_dir_info;
+	global_ctx->dx_dir_info_count = dx_dir_info_count;
+	global_ctx->dx_dir_info_size = dx_dir_info_size;
+	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	global_ctx->inode_count = inode_count;
 	global_ctx->inode_link_info = inode_link_info;
 	global_ctx->fs_directory_count += fs_directory_count;
-- 
2.29.2.299.gdc1121823c-goog

