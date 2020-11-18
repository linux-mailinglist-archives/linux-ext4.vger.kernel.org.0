Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4F2B80C2
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKRPkg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgKRPkf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C8FC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r4so2036886ybs.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/Oov+Vw1l+3Sr5DeUikR0CL8hAZekIvYvpufHts8i7w=;
        b=aM6C83m8jGQG6S48nmVsHU8svt+eTfMCr4Cs117ZTMQVCC84LlyPTR5MYcxHdh0sf0
         EU9V21RI9QjRK6Taevrlc4cpQ81Gfks/KPOQGEn6JpQavjnJfIP5DZHsYBCZLFiLzrX4
         xzRnnQV0k7YMhdGXes9Y2vqjOUnG7skkPJC8H/l2/BisBSIVmLTpqcI78TGVYbUVG737
         MEqz5ij67Nx7LkHadP9bkPZL3lJ6t0Mxh/yeHDS09TlJj4E/jEDpstFJpBeqwEsGeksz
         KWvY0Zlamb5Jv5/RllIh7PgzWM4IxxNsrZ0SS6E7sym0RvMA0GiUOz3LwzZnefYZgEPk
         jlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Oov+Vw1l+3Sr5DeUikR0CL8hAZekIvYvpufHts8i7w=;
        b=W/1iCXDhFXDeEL6jL9/Wyr88d/p/JzcXKOJi0UrXs7rqe23qkeBu5P9RxU/WXURVlL
         1F0moVEPiXwg/svMnI0WdIAL6aI5INnBDrBzMUucK3O8q9XuPzJPCj2lYfp6zA3o8hYn
         xV0638Vrpza/qUMoyvn1/tKQYuGK4+qdzbYZQvFElTCFI6yyNfC36VF0wjiUbWvUeR9D
         cjmN9bjpU8owN/0z+5yxTILlkw+LPYiMgVN+lx81t6xZu/axzKYoXIfmwVBxNkPJ/UuO
         KeniFsocD4b8XvAJi0Vp3gwWCVSxDdWGtJVCu21GQn3ZwaAG7IjethybxqToq5d/kFLQ
         83zA==
X-Gm-Message-State: AOAM530NdaJIqFWJDe2Z40To6x2tejp3oxPEyN2xVlHgDeopjwiPiLMi
        Nj88dh8j8m24jmCju19DNo2CaWjSZpP3/UTwJefdfjsEcTs5F1VevhDoJJrkhByutSrZgjZO53v
        DnjIxnHcXG93XR6KwRHb0lUUwMtIp45obNQX/g/CooWdKLgOKvpyI8Y42RzpPhbQ5o2eoC257J+
        /Uq+/r7GM=
X-Google-Smtp-Source: ABdhPJwus0rqIKnu3vM1mrpH1nL5FJ8c/TiXm/fWjyQFCilXEqfwTNej2eNa9VkWPUs7Nhhrq3vdmjYLyU05ir3hYn4=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:2495:: with SMTP id
 k143mr1216635ybk.396.1605714034844; Wed, 18 Nov 2020 07:40:34 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:51 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-6-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 05/61] e2fsck: add assert when copying context
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

Adding the assert would simplify the copying of context.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index ba513d91..d16bedd3 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -46,6 +46,7 @@
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
+#include <assert.h>
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -2129,6 +2130,19 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	ext2_filsys	thread_fs;
 	ext2_filsys	global_fs = global_ctx->fs;
 
+	assert(global_ctx->inode_used_map == NULL);
+	assert(global_ctx->inode_dir_map == NULL);
+	assert(global_ctx->inode_bb_map == NULL);
+	assert(global_ctx->inode_imagic_map == NULL);
+	assert(global_ctx->inode_reg_map == NULL);
+	assert(global_ctx->inodes_to_rebuild == NULL);
+
+	assert(global_ctx->block_found_map == NULL);
+	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_ea_map == NULL);
+	assert(global_ctx->block_metadata_map == NULL);
+	assert(global_ctx->fs->dblist == NULL);
+
 	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while allocating memory");
-- 
2.29.2.299.gdc1121823c-goog

