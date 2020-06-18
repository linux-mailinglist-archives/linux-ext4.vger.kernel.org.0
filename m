Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0240B1FF6CC
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbgFRP3L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgFRP3J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A32C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so2561716plb.11
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G5ozTBAl0Nc2Seqb+1Z0zSPmpgJ1KFPacFYxKJ0OJFw=;
        b=vDev6Xci4wuCFpc5kJDBGBgJK30ysnuX8lu247wQzuh7Du7WMI2GAOg3rBCzJIv0cQ
         AM9PGJD3ZevkHHTlBzd3nYMX2yjvqKXE4a58STCTWhkD9VtVoNzvmQEqz+sgeWEgdbah
         cQTFBfSzkQeQik9+EkOInzyS3ego2JAU2E0OZUtSZjmrzEaf+GsiGBlnrMuwkc+yl/W5
         D0kLPoJu67NCM5/Q+F2RPSuqAvCNsT+1JD5pD+Z8ILAdbDk3FObBRp9obGRLnUjDAlZM
         BnKMGV5xNwn5alYnb83vf0M2G5lKa9zeZ+v3E/cYJB6xsG61I2DmbYXavAB+TcWEYeV7
         4EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G5ozTBAl0Nc2Seqb+1Z0zSPmpgJ1KFPacFYxKJ0OJFw=;
        b=Y6OI0tGQAc0Md2I2Cj3/hRA5I4Oqyu2mRGU9HJ6oSGi9YxsQ9G6C4q/CxJba4cbUNx
         Q18xlJzYrlDYnLCpK9897tRFv8duItEGunMxEd6YJsJuvobewSV8a6UhYtMrPzlqdp0+
         F4kC9/4jcRJ3A2FGy18yeP9nbjDSrHzh1GggPG2a9q/W5DCMTR8HM9GH1NrKE4wXLdVE
         xwsjI/2S2A+NNP111YIgMgFQBp3Bd1lcvV2SVbIEzpYuYrixsKMduZYHYAm5s92z5M/n
         Ad8UjkElOeXgO9XgpX4HosCFuZuBt28psdmv4xzEL4XvYD9A96S3U9mnuTMpqPTAm5P5
         TZ3g==
X-Gm-Message-State: AOAM530uSQSja1ZDMGbtQydOuqalc5ehCiU8HiCbhR4yIbKpA7qdA3GC
        6jV3ubwjoEaX/XDEdCWmIm/6JASU9WM=
X-Google-Smtp-Source: ABdhPJyOSRTwvy7VI2mJwFBJQdkqLsodC4zKXLZKid47Bg5v8yCqFyftYdc4thntfG7JktuFDMJx7w==
X-Received: by 2002:a17:90a:1781:: with SMTP id q1mr4594248pja.24.1592494147798;
        Thu, 18 Jun 2020 08:29:07 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:07 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 23/51] e2fsck: merge icounts after thread finishes
Date:   Fri, 19 Jun 2020 00:27:26 +0900
Message-Id: <1592494074-28991-24-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/pass1.c      |  36 +++++++++++++++-
 lib/ext2fs/ext2fs.h |   1 +
 lib/ext2fs/icount.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index e343ec00..3c04edfd 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2435,6 +2435,28 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
 			      global_ctx->dir_info);
 }
 
+#define PASS1_MERGE_CTX_ICOUNT(_dest, _src, _field)			\
+do {									\
+    if (_src->_field) {							\
+        if (_dest->_field == NULL) {					\
+            _dest->_field = _src->_field;				\
+            _src->_field = NULL;					\
+        } else {							\
+            errcode_t _ret;						\
+            _ret = ext2fs_icount_merge(_src->_field, _dest->_field);	\
+            if (_ret)							\
+                return _ret;						\
+        }								\
+    }									\
+} while (0)
+
+static errcode_t e2fsck_pass1_merge_icounts(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	PASS1_MERGE_CTX_ICOUNT(global_ctx, thread_ctx, inode_count);
+	PASS1_MERGE_CTX_ICOUNT(global_ctx, thread_ctx, inode_link_info);
+	return 0;
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2454,7 +2476,9 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2fs_block_bitmap block_metadata_map = global_ctx->block_metadata_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
-	
+	ext2_icount_t inode_count = global_ctx->inode_count;
+	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
+
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
 
@@ -2477,6 +2501,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_metadata_map = block_metadata_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	global_ctx->inode_count = inode_count;
+	global_ctx->inode_link_info = inode_link_info;
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
@@ -2492,6 +2518,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
 	global_ctx->global_ctx = NULL;
+	retval = e2fsck_pass1_merge_icounts(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging icounts\n"));
+		return retval;
+	}
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -2533,6 +2565,8 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_dup_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_metadata_map);
+	ext2fs_free_icount(thread_ctx->inode_count);
+	ext2fs_free_icount(thread_ctx->inode_link_info);
 	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_mem(&thread_ctx);
 
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index bdb72251..5a094da3 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1509,6 +1509,7 @@ extern errcode_t ext2fs_icount_decrement(ext2_icount_t icount, ext2_ino_t ino,
 					 __u16 *ret);
 extern errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
 				     __u16 count);
+extern errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest);
 extern ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount);
 errcode_t ext2fs_icount_validate(ext2_icount_t icount, FILE *);
 
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 888a90b2..729f993f 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -13,6 +13,7 @@
 #if HAVE_UNISTD_H
 #include <unistd.h>
 #endif
+#include <assert.h>
 #include <string.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -701,6 +702,106 @@ errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
 	return 0;
 }
 
+errcode_t ext2fs_icount_merge_full_map(ext2_icount_t src, ext2_icount_t dest)
+{
+	/* TODO: add the support for full map */
+	return EOPNOTSUPP;
+}
+
+errcode_t ext2fs_icount_merge_el(ext2_icount_t src, ext2_icount_t dest)
+{
+	int			 src_count = src->count;
+	int			 dest_count = dest->count;
+	int			 size = src_count + dest_count;
+	int			 size_entry = sizeof(struct ext2_icount_el);
+	struct ext2_icount_el	*array;
+	struct ext2_icount_el	*array_ptr;
+	struct ext2_icount_el	*src_array = src->list;
+	struct ext2_icount_el	*dest_array = dest->list;
+	int			 src_index = 0;
+	int			 dest_index = 0;
+	errcode_t		 retval;
+
+	if (src_count == 0)
+		return 0;
+
+	retval = ext2fs_get_array(size, size_entry, &array);
+	if (retval)
+		return retval;
+
+	array_ptr = array;
+	/*
+	 * This can be improved by binary search and memcpy, but codes would
+	 * be complexer. And if number of bad blocks is small, the optimization
+	 * won't improve performance a lot.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			memcpy(array_ptr, &dest_array[dest_index],
+			       (dest_count - dest_index) * size_entry);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_entry);
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
+	ext2fs_free_mem(&dest->list);
+	dest->list = array;
+	dest->count = src_count + dest_count;
+	dest->size = size;
+	dest->last_lookup = NULL;
+	return 0;
+}
+
+errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest)
+{
+	errcode_t	retval;
+
+	if (src->fullmap && !dest->fullmap)
+		return EINVAL;
+
+	if (!src->fullmap && dest->fullmap)
+		return EINVAL;
+
+	if (src->multiple && !dest->multiple)
+		return EINVAL;
+
+	if (!src->multiple && dest->multiple)
+		return EINVAL;
+
+	if (src->fullmap)
+		return ext2fs_icount_merge_full_map(src, dest);
+
+	retval = ext2fs_merge_bitmap(src->single, dest->single);
+	if (retval)
+		return retval;
+
+	if (src->multiple) {
+		retval = ext2fs_merge_bitmap(src->multiple, dest->multiple);
+		if (retval)
+			return retval;
+	}
+
+	retval = ext2fs_icount_merge_el(src, dest);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
 ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount)
 {
 	if (!icount || icount->magic != EXT2_ET_MAGIC_ICOUNT)
-- 
2.25.4

