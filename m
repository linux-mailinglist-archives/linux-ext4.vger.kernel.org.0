Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECA1A1F09
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgDHKql (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:41 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34093 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKqk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:40 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so2071319pje.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/3etSYCb49GIEUsMi08WiJoCwzgbOtVly/u/pEyahZI=;
        b=cFzp8UcNtVaIDfdyz4IiecdUmaGJ9a4XvIatZNG+eBymS8WAKou0asBh9RBGdAgoHQ
         4fGoKUr9mYkv+R3GIS1PNwF2vdA4t8gEREUlMIRxVKrshRO8sKSzftCX9wuTWdW1m3Ta
         bW1MDGDBDeOBPo8uOdvfgcY3NIg87ntuQsm9gcK/ui8VGNu13i6jA6rF8B42booF+Q3a
         Ct9NtJ1uaiUC5M8Gm40e7l6YXh28kWLBZJJDAiSjHDhmnvc9462mS4O6eeeo8EFf2zhz
         fOO4nZ4ZpReuoEYVohUa8caJWNAB4ImAnr93xxmyoXWKtnk7y03GEVKp+IGI438HNCpu
         Q5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/3etSYCb49GIEUsMi08WiJoCwzgbOtVly/u/pEyahZI=;
        b=af6hoj58kV++rfsGiVUcNsplyobPDN1U4ZKyg/gDHtLt0J2sw2gfrZpx2R94PHhpji
         HYACIFLZdag0PpvrY/d7ciUVy3REagWpqYvHMlKZNEkIejtPrQIZ2fF01csmvtfUvTi2
         T4daHmWWZjUb2hv998n/gDTqyD6FtF0bpQ+W0PBjm84tKLqwaLmNNRZlapZLi8gxxL14
         CiapIsL/2UheGQBNkolLhRfEc8pMWXXcgJ6nEFERif1Ideyf+yn/Td9JIuPoh1KozvRx
         xIdJyRzgs2JLA1gvC1VMvhKlnwWlGUbZtbtuK5g9VZsppaFpzpbA3b89bKaFsu9PI3Aa
         94ow==
X-Gm-Message-State: AGi0PuZG8hjgNwIXUwaOEb57xwI85FMpSEL+J2B2lrxlZEsB0agc9RVb
        5+rdOqunokozOmxZQrBb6lfkqrcQQqE=
X-Google-Smtp-Source: APiQypLK1aG8hGol98gumfQH1T6sKnOMIeU05ByVdr5kHyEC2Dr7jur/XX2P5jys/2R+f3zV8mzoDw==
X-Received: by 2002:a17:902:eb13:: with SMTP id l19mr6605721plb.156.1586342799064;
        Wed, 08 Apr 2020 03:46:39 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:38 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 31/46] e2fsck: split and merge quota context
Date:   Wed,  8 Apr 2020 19:44:59 +0900
Message-Id: <1586342714-12536-32-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index eb102679..c7b9cf72 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -56,6 +56,7 @@
 #include <e2p/e2p.h>
 
 #include "problem.h"
+#include "support/dict.h"
 
 #ifdef NO_INLINE_FUNCS
 #define _INLINE_
@@ -2447,6 +2448,11 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
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
@@ -2533,6 +2539,20 @@ static int e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx, e2fsck_t thread_
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
@@ -2575,6 +2595,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int dx_dir_info_size = global_ctx->dx_dir_info_size;
 	int dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
+	quota_ctx_t qctx = global_ctx->qctx;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2645,6 +2666,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
2.25.2

