Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE21A1F00
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgDHKqV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:21 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51853 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:21 -0400
Received: by mail-pj1-f66.google.com with SMTP id n4so1004559pjp.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wKveNAyEUA5dlR6L+7rclZEcmVj1eEMaTYNtMs1Jm60=;
        b=JHcKOGJVrjG8eW5YqhQLr9lHQ+02LEKUKb88jjc8REcOCuc4RvO6yZUcXGQsYI2+0J
         zBLgDO8yCpBgtl0iOu8IH187UMzbigJ5GgRPI3RA0X1DUnAptcpnlKrdoJcmuCyCCW2O
         FpyPj+u39LkZfg3HiNKSZzD50iNJdOYjXxZKf29FcL83hzRda23LN3V0MjlknOlL7TpU
         j1fUAEdkM7rXgwMehPfV5iYDbLaqv1QBes+djWIk27cPAYZMU2e7dMOlz7m+P2c38vtH
         VKXUk5UqIa8DNYvSJJEsAPqsdYhwxlYc/BTUUueoN2iyK5Lk5u23H25DHXDqO+YBZVC9
         lEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wKveNAyEUA5dlR6L+7rclZEcmVj1eEMaTYNtMs1Jm60=;
        b=gyEd8zqYLja6Y4ni3sQO7oii5NCtRHJQPyHwVeF5eIDRWR7lstuOuJ2Snr/cEA0KqP
         AlxqAJqc5Rj6//jSOKqqZxwRwn80TagyC2uUjsClB3RjPGBjexI4GL2+IvegJxFgx/ZO
         UQh7vyVEOsVAVjVxLorRdRdkr8kSSaXGoMkV7tpJB4MwiXJeTvL4Cr0dAaShb5PiCyB7
         0kS1xHWihYiiSTZmQkBrY2UrYgVwbjXYZ4rFYnbTTfvavfyPJMmjbO+XZv9Gc6+dHoKB
         sumCawKcpka41PEbWSXmTG3OegHHzcmyRbHQXi1YfFdiaz6QPINIoWEfhRvRo0ynHi9r
         7bbA==
X-Gm-Message-State: AGi0PubtkL3w0i0g2O/QJ0S8hR79JRRowcCpPVbDQRGpMxVbp70ZJiVB
        TSAPMwlyNuSfijk9gmx+7TdxfB0dGDg=
X-Google-Smtp-Source: APiQypI8SnIxt+s/6dzYbeqVznqvVoTtz+2s3B6oswS/BaaO91ROekF2phd2ab/BiE4P9ir7pabVuA==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr6852672pls.324.1586342780077;
        Wed, 08 Apr 2020 03:46:20 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:19 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 22/46] e2fsck: merge icounts after thread finishes
Date:   Wed,  8 Apr 2020 19:44:50 +0900
Message-Id: <1586342714-12536-23-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/pass1.c      |  35 +++++++++++++++-
 lib/ext2fs/ext2fs.h |   1 +
 lib/ext2fs/icount.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 79a9eddf..3501e2f7 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2453,6 +2453,28 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2472,7 +2494,9 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2fs_block_bitmap block_metadata_map = global_ctx->block_metadata_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
-	
+	ext2_icount_t inode_count = global_ctx->inode_count;
+	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
+
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
 
@@ -2495,6 +2519,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_metadata_map = block_metadata_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	global_ctx->inode_count = inode_count;
+	global_ctx->inode_link_info = inode_link_info;
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
@@ -2510,6 +2536,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
 	global_ctx->global_ctx = NULL;
+	retval = e2fsck_pass1_merge_icounts(global_ctx, thread_ctx);
+	if (retval) {
+	com_err(global_ctx->program_name, 0, _("while merging icounts\n"));
+		return retval;
+	}
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -2551,6 +2582,8 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_dup_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_metadata_map);
+	ext2fs_free_icount(thread_ctx->inode_count);
+	ext2fs_free_icount(thread_ctx->inode_link_info);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 1404e14a..d4f6031a 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1507,6 +1507,7 @@ extern errcode_t ext2fs_icount_decrement(ext2_icount_t icount, ext2_ino_t ino,
 					 __u16 *ret);
 extern errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
 				     __u16 count);
+extern errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest);
 extern ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount);
 errcode_t ext2fs_icount_validate(ext2_icount_t icount, FILE *);
 
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 888a90b2..a72b53b3 100644
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
@@ -701,6 +702,105 @@ errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
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
+	int			 size = src->size + dest->size;
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
2.25.2

