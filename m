Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52711A1EF2
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgDHKpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39983 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKpv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so2367542plk.7
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=irjlyi2cDB70rZmTo+0RxipBN5EBcB4b7jmEtTgHO6Q=;
        b=FvYbiFBceF83OOiKc4YOcaSdAJwjC6feKtshD4Pvyy19RFKpoaMdesfSIjIhrDEOJ5
         KZD6FW7AgSiKSqTmapBeC7j4LgvfbkWUcf982FZ4csnIfshYQjsB8bhmM0QU2pI2zvzJ
         /5NCMmo2NVI6XiRfki9KTn6kP0yw4jdDSkO/h6N24UTUn8TG32jRek1UexHcpjk4a0AK
         KKgY3OfjkCJ//pD276VxvqrTKFBVTu40NW4g9V0L1X+Xs/2WNP2BGqn39aDd9ASF36Ul
         qjWJzVcqIzPfkV4FmI4UjkDRXm0KcukESd3mdpQNs/3XAiWqYs0Um9VIfPrDeiLat73u
         yQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=irjlyi2cDB70rZmTo+0RxipBN5EBcB4b7jmEtTgHO6Q=;
        b=MVhkytLGXqJRzfoAyAOE5vaw1Fx/DSAHZp8lKosCpHib4iseBKD6JMp7hoRs89lX5F
         Uh/4hMl5DfwEXwCRrYB1Q51RTd/G4q7jWAeaPB4n81Vc7VR60vjb+uG24Fi67WsNifBJ
         2JvVC1hNCELKQJnsy3vCLuOKbHW5eiVlAMebb0wjhXxK2EjkFqo7Ka/137eCIWy/1VaB
         UEiKfe2NuVbpaoOaNfI9xEqf8ZJ/RgJN99QGThl0l85Ny8iQkDsUYwnEteAIu1tMxzqh
         lxahImW18O4sHU/ufMzjueHBa4gELPCmvcKKiyuNhVQ9IKYk5c+Aj+iMRy6BWbRxRAPV
         nA8Q==
X-Gm-Message-State: AGi0PuYyMp1ipKjvQ8e+mHpO9JoeglLFE1Az8xaBqmfnF6x1xg+RWyhf
        U5jjBWL4XMYcgWzVCIouClUS87lwBPM=
X-Google-Smtp-Source: APiQypJ6D+Qlmnf7zdu5knptewvmblkBNroFxxZHa6ebwbvJ/AehYpo1JLID4eaIvhroYEWMZVVPXw==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8mr6411617plr.95.1586342750015;
        Wed, 08 Apr 2020 03:45:50 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:49 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 08/46] e2fsck: copy bitmaps when copying context
Date:   Wed,  8 Apr 2020 19:44:36 +0900
Message-Id: <1586342714-12536-9-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 2fafeb38..f3337bde 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2105,22 +2105,45 @@ endit:
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
@@ -2128,20 +2151,32 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
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
@@ -2149,6 +2184,18 @@ static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
@@ -2201,8 +2248,9 @@ out_context:
 	return retval;
 }
 
-static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
+	errcode_t	retval;
 	int		flags = global_ctx->flags;
 	ext2_filsys	thread_fs = thread_ctx->fs;
 	ext2_filsys	global_fs = global_ctx->fs;
@@ -2219,13 +2267,40 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
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
2.25.2

