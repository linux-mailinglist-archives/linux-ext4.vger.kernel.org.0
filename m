Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A053F2B80DD
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKRPlU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgKRPlU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A463C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e142so2927975ybf.16
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E9RqpHkCRIeJGjpoYdPThmM33eUrY9Rpw1GJZsh0IZI=;
        b=FQ5hyLP059Xu8NotXgLwrVVBbGazgOVOdnFeap+pf8Ct29G8dveLA658BcKtydTOzB
         An2m1hXBkixN/l9ERxayCaElInRjNi5XwUUHpeLNudI1m75dslta4Zki2HPHDSyIpoAT
         k2WyUJFrr4a/Iz1c5AKgASit1Iw5fZCTt8y8cdEiaHj0fhOz0zqIvNwBkVV5XKwCDDdw
         A1gNW6I3HHxbeYCChsg3l7JTfGc20t1EKeWb5uK2uXjWycq88Lnaw09a1l2jHktAZ9Lu
         jU7k+nGIbQ8Pqi+bc2J1rIHtiU2sfJbDrrUBLvraAWGdc1fXsListyXXICte6JAr8oOL
         xdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E9RqpHkCRIeJGjpoYdPThmM33eUrY9Rpw1GJZsh0IZI=;
        b=HZjjJ4R53wMvnmZLQ0n4VAb5sZ2v7kXzMDAnUB1NG30xj8Z+wUDY/QhkXF0T1yA+8y
         4NMB3pMp3aOXSHyN5+V7wtMx1zjh/D0nFN/0GLfQ7WNWR21iY7QVe3uA1cIO1778rUaq
         lFKkSxHK604yQ1vR+URlsX0CqeR5rL19Z37Yf937GehafK6lSncQT4pvT4rcj0JEH73C
         JXKRcAnze+rvkA/GZa1DFBy0CTVNubAbvY3X7KuoSDjd5Bcx+5UMuyQ2Z+k5x5TB/JvD
         Hfr/Kn2m/Ec1984kIChKT3PTZveIeEFPnznxuWnC647KuKJlTuymNNoDPUZGR+4UMxKp
         amqg==
X-Gm-Message-State: AOAM530XpHtdExcOCumnYuW9ecn5qUZJln0bdcwQ897+8IzU/VKTxaSR
        VE1dKn0WlUJ79r2YQhFFw7mBhHdEvVJ/2PRd6GZxke4gzH3vsvcUnM6HqwIJAt9pE9n19GhqGHI
        Y/YBZfUfNQLL1iFnLc5/B1nACbNy/5Q1/cJS180xGq0du0r4oY+GxBgcxfUe4Q1soEFgB5iESSt
        OLj1vO4FE=
X-Google-Smtp-Source: ABdhPJyEbWED0YBw0tmdxnunX52QAk0k1WlsqEdBCU/EyDDIGbuvNNkgbIi02umgvN4F/K3eLPar9aZATPw3XoAAj4Y=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:3792:: with SMTP id
 e140mr9586871yba.277.1605714077606; Wed, 18 Nov 2020 07:41:17 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:14 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-29-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 28/61] e2fsck: merge quota context after threads finish
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Every threads calculate its own quota accounting,
merge them after threads finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c        | 15 ++++++++++++++-
 lib/support/mkquota.c | 39 +++++++++++++++++++++++++++++++++++++++
 lib/support/quotaio.h |  3 +++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 35ab9cae..f2476261 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2388,6 +2388,12 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		log_out(thread_context, _("Scan group range [%d, %d)\n"),
 			tinfo->et_group_start, tinfo->et_group_end);
 	thread_context->fs = thread_fs;
+	retval = quota_init_context(&thread_context->qctx, thread_fs, 0);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			"while init quota context");
+		goto out_fs;
+	}
 	*thread_ctx = thread_context;
 	return 0;
 out_fs:
@@ -2481,7 +2487,6 @@ static errcode_t e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx,
 	return retval;
 }
 
-
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2525,6 +2530,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_ino_t dx_dir_info_size = global_ctx->dx_dir_info_size;
 	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
+	quota_ctx_t qctx = global_ctx->qctx;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2600,6 +2606,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		return retval;
 	}
 
+	global_ctx->qctx = qctx;
+	retval = quota_merge_and_update_usage(global_ctx->qctx,
+					      thread_ctx->qctx);
+	if (retval)
+		return retval;
+
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
 				&thread_ctx->inode_used_map,
 				&global_ctx->inode_used_map);
@@ -2688,6 +2700,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	ext2fs_free_icount(thread_ctx->inode_link_info);
 	if (thread_ctx->dirs_to_hash)
 		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
+	quota_release_context(&thread_ctx->qctx);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 6f7ae6d6..c16a3d0a 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -639,6 +639,45 @@ out:
 	return err;
 }
 
+static errcode_t merge_usage(dict_t *dest, dict_t *src)
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
+
+errcode_t quota_merge_and_update_usage(quota_ctx_t dest_qctx,
+					quota_ctx_t src_qctx)
+{
+	dict_t *dict;
+	enum quota_type	qtype;
+	errcode_t retval = 0;
+
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		dict = src_qctx->quota_dict[qtype];
+		if (!dict)
+			continue;
+		retval = merge_usage(dest_qctx->quota_dict[qtype], dict);
+		if (retval)
+			break;
+	}
+
+	return retval;
+}
+
 /*
  * Compares the measured quota in qctx->quota_dict with that in the quota inode
  * on disk and updates the limits in qctx->quota_dict. 'usage_inconsistent' is
diff --git a/lib/support/quotaio.h b/lib/support/quotaio.h
index 60689700..bca295a1 100644
--- a/lib/support/quotaio.h
+++ b/lib/support/quotaio.h
@@ -40,6 +40,7 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
 #include "dqblk_v2.h"
+#include "support/dict.h"
 
 typedef int64_t qsize_t;	/* Type in which we store size limitations */
 
@@ -233,6 +234,8 @@ int quota_file_exists(ext2_filsys fs, enum quota_type qtype);
 void quota_set_sb_inum(ext2_filsys fs, ext2_ino_t ino, enum quota_type qtype);
 errcode_t quota_compare_and_update(quota_ctx_t qctx, enum quota_type qtype,
 				   int *usage_inconsistent);
+errcode_t quota_merge_and_update_usage(quota_ctx_t dest_qctx,
+					quota_ctx_t src_qctx);
 int parse_quota_opts(const char *opts, int (*func)(char *));
 
 /* parse_qtype.c */
-- 
2.29.2.299.gdc1121823c-goog

