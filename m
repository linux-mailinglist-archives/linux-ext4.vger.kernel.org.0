Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5371FF6C6
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgFRP3c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbgFRP3a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8435C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v24so2571479plo.6
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgtaPHFfOuQ0NI1d6ktVRDSlN7X6jhPVwTQ8fK83BZk=;
        b=kw4+y8BgpZ4NwVYusS1idRgEY9oWjAxSvwK2MFdjN/YtnFGdbGrxc8Xu0ti03R9R+6
         JmjPdvVOylwFqngC7EVOBn5jny0mcg6WiH3r+ReJpmvM4gz8yrXXflHAuGresX1kHYCT
         VIi474d5QFNVM8zx/UGNy4tR8wuE1tK2ZwktoXWeIyhpzg7bDoLPmRy/tDT0RG44KVMi
         hfSlB1a6Uw1GqENTKbfljQK1ff7wh1eMkMifkNdC2ziMhsvugIutAilUtIkF9yWAVGEt
         xlz4piZk/9Pi0EUVlOpH97tnVGzOTG0jGzwmxm/V1wXtWbJ/WJtU+nSZ9P5nGRxZpvOU
         I2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lgtaPHFfOuQ0NI1d6ktVRDSlN7X6jhPVwTQ8fK83BZk=;
        b=hezRSgSCQXCcrNt6S+Piqn0W56EbdhO061f3c8N7NM+iKqjGZ7Vb5D2J66o5fTtAoL
         BOUor7kxxjlaRd4FtUr+RvZ6g8oxHvkpJX/XEX9o7KAYd+99mG/nnIh3fvxsXxzs3Ise
         06fnUULzDnEt5VDrZpETDtL8fdBGjia7cm9PPWQOa1HrWvE7zFSWvqT635uBZuam2wWN
         1LuyzpjLbXhGJfyzoumlim3biYT3W76tkr8Z1Hk4AAY1zrQ78K91QbXeNyuh0P6FqBIX
         V8kurj+DO2TzU3v9d0s8XdW1kd1IFMhTLgtyKaHMYy9ciK3mjOtRKHdGos2+Y2SbAI/B
         lzoQ==
X-Gm-Message-State: AOAM533oIHiMgbT8WgdhIPmH1FL8ioZOi0Jh3OzIZRvl5RrotZrPUZv7
        UGCNqoYYHVWdRmhuf4TtJVtDq/6tfa0=
X-Google-Smtp-Source: ABdhPJwjzfxFC0nBn6n0kjp7g1sxH0MP86Hr5pbMv+H5V+MpfbeRn4bVvsb57HairrBkxBLsBjC3PQ==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr4217810pll.103.1592494168922;
        Thu, 18 Jun 2020 08:29:28 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:28 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 32/51] e2fsck: split and merge quota context
Date:   Fri, 19 Jun 2020 00:27:35 +0900
Message-Id: <1592494074-28991-33-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Every threads calculate its own quota accounting,
merge them after threads finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c        | 23 +++++++++++++++++++++++
 lib/support/mkquota.c | 19 +++++++++++++++++++
 lib/support/quotaio.h |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 182e1cd8..645666cc 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -56,6 +56,7 @@
 #include <e2p/e2p.h>
 
 #include "problem.h"
+#include "support/dict.h"
 
 #ifdef NO_INLINE_FUNCS
 #define _INLINE_
@@ -2429,6 +2430,11 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 		log_out(thread_context, _("Scan group range [%d, %d)\n"),
 			tinfo->et_group_start, tinfo->et_group_end);
 	thread_context->fs = thread_fs;
+	retval = quota_init_context(&thread_context->qctx, thread_fs, 0);
+	if (retval) {
+		com_err(global_ctx->program_name, retval, "while init quota context");
+		goto out_fs;
+	}
 	*thread_ctx = thread_context;
 	return 0;
 out_fs:
@@ -2515,6 +2521,20 @@ static int e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx, e2fsck_t thread_
 	return retval;
 }
 
+static void e2fsck_pass1_merge_quota_ctx(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	dict_t *dict;
+	enum quota_type	qtype;
+
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		dict = thread_ctx->qctx->quota_dict[qtype];
+		if (dict)
+			quota_merge_and_update_usage(
+				global_ctx->qctx->quota_dict[qtype], dict);
+	}
+	quota_release_context(&thread_ctx->qctx);
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2557,6 +2577,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int dx_dir_info_size = global_ctx->dx_dir_info_size;
 	int dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
+	quota_ctx_t qctx = global_ctx->qctx;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2628,6 +2649,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		com_err(global_ctx->program_name, 0, _("while merging dirs to hash\n"));
 		return retval;
 	}
+	global_ctx->qctx = qctx;
+	e2fsck_pass1_merge_quota_ctx(global_ctx, thread_ctx);
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 6f7ae6d6..745106b0 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -639,6 +639,25 @@ out:
 	return err;
 }
 
+errcode_t quota_merge_and_update_usage(dict_t *dest, dict_t *src)
+{
+	dnode_t *n;
+	struct dquot *src_dq, *dest_dq;
+
+	for (n = dict_first(src); n; n = dict_next(src, n)) {
+		src_dq = dnode_get(n);
+		if (!src_dq)
+			continue;
+		dest_dq = get_dq(dest, src_dq->dq_id);
+		if (dest_dq == NULL)
+			return -ENOMEM;
+		dest_dq->dq_dqb.dqb_curspace += src_dq->dq_dqb.dqb_curspace;
+		dest_dq->dq_dqb.dqb_curinodes += src_dq->dq_dqb.dqb_curinodes;
+	}
+
+	return 0;
+}
+
 /*
  * Compares the measured quota in qctx->quota_dict with that in the quota inode
  * on disk and updates the limits in qctx->quota_dict. 'usage_inconsistent' is
diff --git a/lib/support/quotaio.h b/lib/support/quotaio.h
index 60689700..6077268a 100644
--- a/lib/support/quotaio.h
+++ b/lib/support/quotaio.h
@@ -40,6 +40,7 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
 #include "dqblk_v2.h"
+#include "support/dict.h"
 
 typedef int64_t qsize_t;	/* Type in which we store size limitations */
 
@@ -233,6 +234,7 @@ int quota_file_exists(ext2_filsys fs, enum quota_type qtype);
 void quota_set_sb_inum(ext2_filsys fs, ext2_ino_t ino, enum quota_type qtype);
 errcode_t quota_compare_and_update(quota_ctx_t qctx, enum quota_type qtype,
 				   int *usage_inconsistent);
+errcode_t quota_merge_and_update_usage(dict_t *dest, dict_t *src);
 int parse_quota_opts(const char *opts, int (*func)(char *));
 
 /* parse_qtype.c */
-- 
2.25.4

