Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6B1A1EFD
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgDHKqP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37902 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so2232142pfo.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HxQQPPzJURVVYK6dlJ1sxPLmKo7D3PdesZjlth/3VHg=;
        b=sPdbJH7h6jxD8bX8jOzCeA8SM3g66JBiHEWXUdvG0JqYAXLfmAmASKjaG+uA9B2jEz
         /fIrZqCShVbMXFyRfq3DMTvS8Ucdlx75D0TsO1GxZGEAzYfSNlhOtub3abdVpJiaLDWI
         JlXahdIgl4K0fagjF6WUYdsHRXmGO7H/0WGwyr8qRBeyZRHMQvPm4nGNuAundJN+GLUU
         AEijR7qtg5LQIHKTGIxNNm3lQnY4GI2hQoDE3/0nBR6cdQRtXWrSTI4r0O7cf+LSvOmB
         yN3V/VnOi7hQqLo81BgzFOnLI08abjHkNnOSuw0vQURZoTASkfXNo9+i9AywrA6J19ap
         TSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HxQQPPzJURVVYK6dlJ1sxPLmKo7D3PdesZjlth/3VHg=;
        b=gPFE9QiLWsVQmFRlm1CUfkAlcJsIzbtucA7s/PyhX8plhJL6pEGEIiF5sXQC4+LADK
         vNSiUZYeyZqHMWp6txKHc3+QNVZ9nh3hcEApO1DLURnK/JKzVnCnHN9G3Rax2Rmcv5CL
         48hG5TKyGyZVOJ6RcXUhjMYFgvRoL6VdGvinU9uhKroicwE6XKtG/iGdGvp+kwN6fqf4
         97vVxuPeghsHKWJmezrCWSP5J71yCcxJlnXajPwwEvV1/37p/BGgFl9WfQZ65EtMOLdN
         3mJLwcMkOeVTnL/1LWzZqcJabQR2KEPcuauQIsjLa71duyHbAwMCj27mGRNVal1P92vP
         obLA==
X-Gm-Message-State: AGi0Pua2Iuh6OfSBu+JiMTu/tsEh1p5NeCCXuehWWbkdLNgvmnF4EgBb
        8byqBov/uu1gFJfWK59H2cCQiEM4jPc=
X-Google-Smtp-Source: APiQypLgYppJS/EiybjTjZVfK0CmAVukRmWwRFJmkmeNUswDsYRjiKfPf+I8BSwuz5R0OSkCLL4RDg==
X-Received: by 2002:aa7:9104:: with SMTP id 4mr7254170pfh.168.1586342773787;
        Wed, 08 Apr 2020 03:46:13 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:13 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 19/46] e2fsck: merge dir_info after thread finishes
Date:   Wed,  8 Apr 2020 19:44:47 +0900
Message-Id: <1586342714-12536-20-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/pass1.c   | 19 ++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index c5183261..fab10d89 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -155,6 +155,72 @@ static int e2fsck_dir_info_min_larger_equal(struct dir_info_db *dir_info,
 	return index;
 }
 
+/*
+ * Merge two sorted dir info to @dest
+ */
+void e2fsck_merge_dir_info(e2fsck_t ctx, struct dir_info_db *src,
+			   struct dir_info_db *dest)
+{
+	int		 size_dir_info = sizeof(struct dir_info);
+	int		 size = dest->size;
+	struct dir_info	*src_array = src->array;
+	struct dir_info	*dest_array = dest->array;
+	int		 src_count = src->count;
+	int		 dest_count = dest->count;
+	int		 total_count = src_count + dest_count;
+	struct dir_info	*array;
+	struct dir_info	*array_ptr;
+	int		 src_index = 0;
+	int		 dest_index = 0;
+
+	if (src->count == 0)
+		return;
+
+	if (size < total_count)
+		size = total_count;
+
+	if (size < src->size)
+		size = size;
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
index 48afc8f3..f8e98f73 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -507,6 +507,8 @@ extern void read_bad_blocks_file(e2fsck_t ctx, const char *bad_blocks_file,
 
 /* dirinfo.c */
 extern void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent);
+void e2fsck_merge_dir_info(e2fsck_t ctx, struct dir_info_db *src,
+                           struct dir_info_db *dest);
 extern void e2fsck_free_dir_info(e2fsck_t ctx);
 extern int e2fsck_get_num_dirinfo(e2fsck_t ctx);
 extern struct dir_info_iter *e2fsck_dir_info_iter_begin(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 85d18c55..56004c9b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2431,6 +2431,22 @@ out_context:
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
@@ -2439,6 +2455,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_filsys	 global_fs = global_ctx->fs;
 	FILE		*global_logf = global_ctx->logf;
 	FILE		*global_problem_logf = global_ctx->problem_logf;
+	struct dir_info_db *dir_info = global_ctx->dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2470,6 +2487,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->block_metadata_map = block_metadata_map;
+	global_ctx->dir_info = dir_info;
+	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
-- 
2.25.2

