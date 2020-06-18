Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486A71FF6A9
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgFRP2k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgFRP2f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8FC0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 10so2933468pfx.8
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zqWGLwCaVb8gHs9h8JgL8rK08Ateb9uqXiw9UBsVBqo=;
        b=jxYFAIb16OUTHSb5vNnZzGoqnx7QZBHC8qanbgnvnKk1pgOPICfous9qkeJv63ArYR
         EIa+uaTC8u/Cv2oG2Imb+Cw/XN60oIv3MoWskQkpjBNIwe9xdOelFBG4kKcp2WlXyKhi
         95WlFc4voNa1ud0ZQQm4oABwg3WdbRhMqc8UkOTni765HU8giu3rg2WfB/Es9r+oWaR1
         2Mz1BDCoiQpOjznCfwLrCFLa/2lTMMUla+QADU3Gc2P9+CBpJt+8i3Q9NcxGXYxeSsuW
         hu7JUiyPutfFsyYce5x5Hx8yahzroIFZJyCOPQWvVG4NPMvRJLCzWhjacj8LB0i1ihlc
         uUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zqWGLwCaVb8gHs9h8JgL8rK08Ateb9uqXiw9UBsVBqo=;
        b=taOdK+bVq1eqrFf6M2c20/s/xVYMyzKCHHdxiQ1TOC/zrSPOl+Nv2sunV5qSsf89xB
         7fbVYQyT7I7PiS0jiU4TpOXwTaBI14X3q1NIrQKEDjQ6LqRfzJJ0bIyXOBgpHd90HdT2
         O1F20eDRmEvv2akuJtY7aaRAi8I5phATLrX5nXuOCGr6EfQOGEhY46XyqrS7UVImfULm
         EADZ1L4HPSmy9Iy3+jnt5A9De/v7iQQk5oWXFDaUA7qDGRe0CDSjCXcIvCD9RF3G7ltp
         oZ0Sjn22Hw0Loe2R45bS2Kwtl45qVhjPRlSpxFSWomS9xpaO74NtWjIZxzoZSZ07LFUt
         zSgw==
X-Gm-Message-State: AOAM533HDZlT0LnxFl7B9L6cyqMQLDAfgMzN+bNQYHxr8jvODQnZQ8+I
        IQn029bXfMzv4ly+cjQb+DO5cyNmyq0=
X-Google-Smtp-Source: ABdhPJy/23XE5Rr0FBeGx2Ee4y2IbdpR/dxWQ16eYMGW0ywKmyeXL0AB0CxH0YK717/EbKI9NdF7tg==
X-Received: by 2002:a63:da0e:: with SMTP id c14mr3648897pgh.377.1592494114338;
        Thu, 18 Jun 2020 08:28:34 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:33 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 09/51] e2fsck: copy bitmaps when copying context
Date:   Fri, 19 Jun 2020 00:27:12 +0900
Message-Id: <1592494074-28991-10-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch copies bitmap when the copying context. In the
multi-thread fsck, each thread use different bitmap that copied
from the glboal bitmap. And Bitmaps from multiple threads will
be merged into a global one after the pass1 finishes.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 121 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 98 insertions(+), 23 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 1ee6b5bc..b836e666 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2087,22 +2087,45 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
+#define PASS1_COPY_FS_BITMAP(_dest, _src, _map_filed)			\
+do {									\
+    errcode_t _ret;							\
+    if (_src->_map_filed) {						\
+        _ret = ext2fs_copy_bitmap(_src->_map_filed, &_dest->_map_filed);\
+        if (_ret)							\
+            return _ret;						\
+        _dest->_map_filed->fs = _dest;					\
+									\
+        ext2fs_free_generic_bmap(_src->_map_filed);			\
+        _src->_map_filed = NULL;					\
+    }									\
+} while (0)
+
+#define PASS1_COPY_CTX_BITMAP(_dest, _src, _map_filed)			\
+do {									\
+    errcode_t _ret;							\
+    if (_src->_map_filed) {						\
+        _ret = ext2fs_copy_bitmap(_src->_map_filed, &_dest->_map_filed);\
+        if (_ret)							\
+            return _ret;						\
+        _dest->_map_filed->fs = _dest->fs;				\
+									\
+        ext2fs_free_generic_bmap(_src->_map_filed);			\
+        _src->_map_filed = NULL;					\
+    }									\
+} while (0)
+
 static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 {
 	errcode_t	retval;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
-	if (dest->dblist) {
-		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
-		if (retval)
-			return retval;
-		/* The ext2fs_copy_dblist() uses the src->fs as the fs */
-		dest->dblist->fs = dest;
-	}
-	if (dest->inode_map)
-		dest->inode_map->fs = dest;
-	if (dest->block_map)
-		dest->block_map->fs = dest;
+	/*
+	 * PASS1_COPY_FS_BITMAP might return directly from this function,
+	 * so please do NOT leave any garbage behind after returning.
+	 */
+	PASS1_COPY_FS_BITMAP(dest, src, inode_map);
+	PASS1_COPY_FS_BITMAP(dest, src, block_map);
 
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	if (src->icache) {
@@ -2110,20 +2133,32 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 		src->icache = NULL;
 	}
 	dest->icache = NULL;
+
+	if (src->dblist) {
+		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
+		if (retval)
+			return retval;
+		/* The ext2fs_copy_dblist() uses the src->fs as the fs */
+		dest->dblist->fs = dest;
+
+		ext2fs_free_dblist(src->dblist);
+		src->dblist = NULL;
+	}
+
 	return 0;
 }
 
-static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 {
-	if (dest->dblist)
-		ext2fs_free_dblist(dest->dblist);
+	errcode_t	retval = 0;
+
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
-	if (dest->dblist)
-		dest->dblist->fs = dest;
-	if (dest->inode_map)
-		dest->inode_map->fs = dest;
-	if (dest->block_map)
-		dest->block_map->fs = dest;
+	/*
+	 * PASS1_COPY_FS_BITMAP might return directly from this function,
+	 * so please do NOT leave any garbage behind after returning.
+	 */
+	PASS1_COPY_FS_BITMAP(dest, src, inode_map);
+	PASS1_COPY_FS_BITMAP(dest, src, block_map);
 
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	if (src->icache) {
@@ -2131,6 +2166,18 @@ static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		src->icache = NULL;
 	}
 	dest->icache = NULL;
+
+	if (dest->dblist) {
+		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
+		if (retval == 0) {
+			/* The ext2fs_copy_dblist() uses the src->fs as the fs */
+			dest->dblist->fs = dest;
+		}
+
+		ext2fs_free_dblist(src->dblist);
+		src->dblist = NULL;
+	}
+	return retval;
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
@@ -2183,8 +2230,9 @@ out_context:
 	return retval;
 }
 
-static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
+	errcode_t	retval;
 	int		flags = global_ctx->flags;
 	ext2_filsys	thread_fs = thread_ctx->fs;
 	ext2_filsys	global_fs = global_ctx->fs;
@@ -2201,13 +2249,40 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 
-	e2fsck_pass1_merge_fs(global_fs, thread_fs);
+	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
+	if (retval) {
+		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
+		return retval;
+	}
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
 
+	/*
+	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
+	 * so please do NOT leave any garbage behind after returning.
+	 */
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_used_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_dir_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_bb_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_reg_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inodes_to_rebuild);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_found_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_dup_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
+	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_metadata_map);
+	return 0;
+}
+
+static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	errcode_t	retval;
+
+	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
 	ext2fs_free_mem(&thread_ctx->fs);
 	ext2fs_free_mem(&thread_ctx);
-	return 0;
+
+	return retval;
 }
 
 void e2fsck_pass1_multithread(e2fsck_t ctx)
-- 
2.25.4

