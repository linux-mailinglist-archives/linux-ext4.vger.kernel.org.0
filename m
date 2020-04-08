Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38671A1EEE
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgDHKpo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:44 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37134 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKpo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:44 -0400
Received: by mail-pj1-f66.google.com with SMTP id k3so1001550pjj.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EtWMOQzTpeZ5k9wo+uBZU1UwKXRnzhThMrRrbpVkECI=;
        b=jPoO3xZELJh6NLXnMw3t+islapL4sHoZ19+s/l5SsA1jym2jiIixtvRRWy0gJ5+h9c
         lgIleM9po6FTLNoyKkYbmT0Zla8RH0jISfeR/5knkV1TRMNVfgzbR5gRJdDaLeM/BEbZ
         4MsJIl3sHyDCkMvnQ4n2fo8jjx3v7qoxnJvNNbNIeb/1g6fAISieshVJwsJcCvj3ytN9
         9RgupAR3NJTGL28vMqmnwbrMmj2hwSqH9iCU+9ht/zbQQRzKNcevNPjYPV6dtV/xMNe8
         fexd90AcZXVTHQWODLyg/rlTdEUvBMUdZ3EYvMXyQeKjQUq/XRIFfE8hSahbUddIbX5z
         lTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtWMOQzTpeZ5k9wo+uBZU1UwKXRnzhThMrRrbpVkECI=;
        b=eZ0k8t6pFuA4MCJX9FrPwQXdX5k0WTdyt5XDCEUwpWGBZAY3hke2NwhXo30gzhmASk
         +MM8yS7BGrlXqxji8HBXKyl46ygsKrhhK7yQltFsTRhqX4Ra7CAeW8cOu6UA1pFCwNtO
         uwYcaZibEPuv5a43Gl1V9MH3usG5D0qRVHvyaqdCCzXsk6mkM4FTBJMD2EkGDW+8baWb
         ajEwBALjHqwbwVMnwDGIrkJCGmVcrtIXGMb3Wl+7QxWoFqUPUrR+XzvRTkIq013mfP1U
         NsTciFsSski2hL2/y639XFTIzhE61WRHcxlONvapJI99m/qykhjNPR0w+SWIheuDJFjg
         +I8A==
X-Gm-Message-State: AGi0PubrLJpg5CQoH4koPJpy2QiUv56IRdVZ0SW8qF4I0+E0Nuqu2jih
        YxXdHWm3BHbMVCOCAe3sTBxzmj9n4rM=
X-Google-Smtp-Source: APiQypJF9u+EXpXuVgPsjZfcNmSXneQ/50HP5WZ3Quy+46gN2+P7t1vZwXOy43Oel8R/77YbgF9Csw==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr4785714pjv.61.1586342741595;
        Wed, 08 Apr 2020 03:45:41 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:41 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 04/46] e2fsck: copy fs when using multi-thread fsck
Date:   Wed,  8 Apr 2020 19:44:32 +0900
Message-Id: <1586342714-12536-5-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch only copy the fs to a new one when -m is enabled.
It doesn't actually start any thread. When pass1 test finishes,
the new fs is copied back to the original context.

This patch handles the fs fields in dblist, inode_map and block_map
properly.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index b093a734..2fcc466e 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -49,6 +49,8 @@
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
+/* todo remove this finally */
+#include <ext2fs/ext2fsP.h>
 #include <e2p/e2p.h>
 
 #include "problem.h"
@@ -2102,10 +2104,23 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
+static void e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
+{
+	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+	if (dest->dblist)
+		dest->dblist->fs = dest;
+	if (dest->inode_map)
+		dest->inode_map->fs = dest;
+	if (dest->block_map)
+		dest->block_map->fs = dest;
+}
+
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
 {
 	errcode_t	retval;
 	e2fsck_t	thread_context;
+	ext2_filsys	thread_fs;
+	ext2_filsys	global_fs = global_ctx->fs;
 
 	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
 	if (retval) {
@@ -2113,18 +2128,32 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		return retval;
 	}
 	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
-	thread_context->fs->priv_data = thread_context;
 	thread_context->global_ctx = global_ctx;
 
+	retval = ext2fs_get_mem(sizeof(struct struct_ext2_filsys), &thread_fs);
+	if (retval) {
+		com_err(global_ctx->program_name, retval, "while allocating memory");
+		goto out_context;
+	}
+
+	e2fsck_pass1_copy_fs(thread_fs, global_fs);
+	thread_fs->priv_data = thread_context;
+
+	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
 	return 0;
+out_context:
+	ext2fs_free_mem(&thread_context);
+	return retval;
 }
 
 static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
-	int	flags = global_ctx->flags;
+	int		flags = global_ctx->flags;
+	ext2_filsys	thread_fs = thread_ctx->fs;
+	ext2_filsys	global_fs = global_ctx->fs;
 #ifdef HAVE_SETJMP_H
-	jmp_buf	old_jmp;
+	jmp_buf		old_jmp;
 
 	memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
 #endif
@@ -2136,7 +2165,11 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 
-	global_ctx->fs->priv_data = global_ctx;
+	e2fsck_pass1_copy_fs(global_fs, thread_fs);
+	global_fs->priv_data = global_ctx;
+	global_ctx->fs = global_fs;
+
+	ext2fs_free_mem(&thread_ctx->fs);
 	ext2fs_free_mem(&thread_ctx);
 	return 0;
 }
-- 
2.25.2

