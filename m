Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50101FF6A6
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgFRP2g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgFRP21 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3EC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so2585341ple.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xkhsFkNTEDSDUDe+KDFdfS1BwQzKwE/dI75pP0jzuTc=;
        b=ms49urcveNHbKE+Df0WJE+7L/o4NotzSsHGLOB+YCMQAHqT3ZWKFQGrgjeHMzYKd5p
         DPb8tBAp8U3x7k/aYUFoU/ukMFRHqXbli8k4mVC596KQlplkHg5y+GpC54oFTTDfBPxr
         335/3Vj1y11ibL6NHTKJZC/yaQLrp19ObIR/Gh4JvfwbRBzNUiGoMx48/BgneNkz003K
         a/jV5wPstowJkCnUoO6aw7frrqa4XeaAXQcryVFJLwP1f5XLPaC6InkJoZGzhqhrjdna
         9n40XZL1va5Gk6dRIu/G4Ufl6g0C7aZgnkViyTX3OXyvLffAnYbWdpxMvWgH+iMMkkgi
         2BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xkhsFkNTEDSDUDe+KDFdfS1BwQzKwE/dI75pP0jzuTc=;
        b=Ea2oJugnXu0fJgvUzZMzlrQAPVwA7vTL+DAKg5fOjPjqs3vWnruWEFh4SYW8MzLX8S
         nNkv/0gl/G5tZiqfi2SKgnODF6lTkSbC4st5f7mwBkc4aH0i4PS4iTvdHQtEDzU5UhKx
         EtVd2QTFIpNms1NVTkxb+Ko8YBIp1kKrdShvd8kuaAmvHCPqiYJpXMqbd+aOuH28NcKn
         OHnmaAtpq2sLpII7b73O3NTYNPJmpc1G/Aj3ZxPxpCA84xXWwZR4erBfcZQIweTfnmmZ
         ICCy3VF2iPYiJ1bTBSpS/bwdCNwV3RBh1+Yzcqh+Bl/EjM4utyQRqfcBOrr9EFViwlBs
         R0wQ==
X-Gm-Message-State: AOAM531zkXjTbCIblK79mVdWU/jjqV8gK1aQE/RNpL/6+bl/GnqFDq/T
        AiDLg+CoTR9zGMhpKQIz9aWDExojZUY=
X-Google-Smtp-Source: ABdhPJxJ5/KoOXk91j8QjAQ2yzlpTMegs6gef5VnLGwK28sfJlRK8pwVr3jrt8ya6Er5u/RlpMK9GA==
X-Received: by 2002:a17:902:e989:: with SMTP id f9mr4379121plb.268.1592494104889;
        Thu, 18 Jun 2020 08:28:24 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:24 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 05/51] e2fsck: copy fs when using multi-thread fsck
Date:   Fri, 19 Jun 2020 00:27:08 +0900
Message-Id: <1592494074-28991-6-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
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
index a9244201..c0df4330 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -49,6 +49,8 @@
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
+/* todo remove this finally */
+#include <ext2fs/ext2fsP.h>
 #include <e2p/e2p.h>
 
 #include "problem.h"
@@ -2084,10 +2086,23 @@ endit:
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
@@ -2095,18 +2110,32 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
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
@@ -2118,7 +2147,11 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
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
2.25.4

