Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3D2B80C0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgKRPke (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgKRPkd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71BC0613D6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id n186so2891256ybg.17
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BUnSJiCRb7gKUFWssFlD1/YSL9ijQFMd0Y48Ctas5M4=;
        b=t8m018OgOok81vplOE4kgh6U8br+MQcy+WXVd4f8X9eGwHbzah3DN/UuKfnZxp2GH2
         6SJopazwnAZkjBi0q0lc6u7ZpayPEAjbKe8OeMuwvCQ3kvucRpeR3+hE4vg3vEMBa86x
         i/OuH08attkNNHAxRTlue5Pp79027MiQzOBwo+lQTp35zIr0Az7c9j5xtVBKHM7Lxidy
         gyUGRmxQ66GyGyYN23jHAupR6uXewwqFeXVrI71/luGwdp5C1eidQ2b0RvKcvQh26PMp
         zugKSHHcLoH9jbL7M/vCtj7FtdYFeO20doLH2VyyR1T4LKBfEZAmM8DmTDW9YEUvdbA/
         TTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BUnSJiCRb7gKUFWssFlD1/YSL9ijQFMd0Y48Ctas5M4=;
        b=LXPKzGGIuHEIOumoObIqj+vtHCQYyCwBU13Ebzqoa0melxVtKiGMz48ZA5whDO714t
         Yyr/Pdqv/E4hLp14fl8CwqnHk1t+sm/sCNMgFL0YwKVUdEOx7KNiWVSExqZZOFFCvUkW
         /HaX0maihZirama+Txu8HqKyIHW6v9VG/pdzKrwdFB7HNTcHoJunJtkANrg7VzZUy/BA
         e22GOj6n4xSGQjWxQgjU3C8qgoCkRpirSLvbgdcR6lejk4vxgcfc0e5hLFm1+rXU1NG4
         GjfPeBkykppvWyMP5ipyc/SintLCL0cJ5K6erDoKVNDD4fnffTsmCXf3jkyfK/rBYtgt
         s64A==
X-Gm-Message-State: AOAM533SXTyqJe9vqOpecxwe88pzoghlJfTxa5O+ZttliKVLz2Zp2V3V
        IMlhCOy1mWHyJwS3B1f23Q8zlyOeeqjJjIf+0kBmNxjLFkvvty3BccssYoFYDNoc6bOSAMvi4ES
        ftN4o0fnWe1M78tyrZKgxxXIgz0bwCzXvy4pwzxMKtQmWQ6vIDsABCiqmK1Q3wLS6dM82HcuIZj
        hqef18bco=
X-Google-Smtp-Source: ABdhPJzO4xDdAu+e5ySTHKflDYD2bwh/XQJIBEh/Rnxv7RuMDvnxVNlP4ssFQv95ItAHJa5XBNI8HyhxLfJmt6jfX9A=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a5b:74f:: with SMTP id
 s15mr7411466ybq.11.1605714031240; Wed, 18 Nov 2020 07:40:31 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:49 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-4-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 03/61] e2fsck: copy fs when using multi-thread fsck
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
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
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 64d237d3..5b4947b0 100644
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
2.29.2.299.gdc1121823c-goog

