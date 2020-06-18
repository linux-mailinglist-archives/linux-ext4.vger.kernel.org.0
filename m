Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BB1FF6A2
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgFRP2Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbgFRP2Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB8AC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so2960219pfb.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XWq9YFukLg+iIiUcMdvGUDWfST5fNQRtYVLWzyngHIk=;
        b=TuvHVzxYGRSjHGWuOUsvETJ91kt1jFimXSqVoOUvokpSTNw2bsG9PGrlR+0tttZcZh
         CIjCSCM8N0E4Tn6uGdzXz36KCsl23PxKGUItuI12M0fQO4sJvbQDNhuyj76UB/FHQ3cS
         2sUpGjcr6i3hngt7RZAnUkRvDFp4Tlp0Oe8Fu6KVjQiMAppU1qub+SzV90FrLjj0QrRT
         SRMKN5DuC7VhW29368nBjaCNJyHvAf6rKHqrsmK175/9jXzTseCVWeWB+lMsXRRpOTai
         MXvd8g/ZkuIAUzMQYroc1wdtU6zxBPahmoeoEX4OO+yodXUlYDlrtK9W9b0Czj9jjgQ7
         ieTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XWq9YFukLg+iIiUcMdvGUDWfST5fNQRtYVLWzyngHIk=;
        b=UBfF0keqCPm4AcoZEUefOUbyRvF2iZVoMALMmg0Em5byiwm/CIOWssh6KH02qtOIUK
         QylUZzZoKE4l1FCdDsZZF+ya97yg2lWWMvFIklpApnl4f7vuW5ZnEAQu2bb4bZfUCt1E
         acFQ1zkszq4/a4QQzB6MU4XIfsHVPkGlLHJLKve8G66rwwx8vwL3DiWahsA1GISAO2E3
         Qfh6FFZakmBbn26bDKIJNRlNb5afwVOJNyJa1KPH3GdWLo938QsKdvagMDPnovpgsydc
         Dr++YsIZTXRxi8g03dwfhlWM8FVDoOCvB4be9idIcAEMwJIZ7ICLgxbb3xSCJ1hX/zrZ
         ftPg==
X-Gm-Message-State: AOAM533dVRMaETMw+sG0I96iTlSRlQ1GXNrb5M8q51jmE6RfXd7/Up80
        TXCHMvIHF7/zF+Q5wuFE8GdkQFsLHc4=
X-Google-Smtp-Source: ABdhPJwivy8aL6jH82dO9enHSItSozXZjHHWZee7YtpM/qK2Q4tXFHKUBmie+Bjfy6bMxp1TOi2abw==
X-Received: by 2002:a62:1444:: with SMTP id 65mr4015403pfu.294.1592494102589;
        Thu, 18 Jun 2020 08:28:22 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:21 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 04/51] e2fsck: copy context when using multi-thread fsck
Date:   Fri, 19 Jun 2020 00:27:07 +0900
Message-Id: <1592494074-28991-5-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch only copy the context to a new one when -m is enabled.
It doesn't actually start any thread. When pass1 test finishes,
the new context is copied back to the original context.

Since the signal handler only changes the original context, so
add global_ctx in "struct e2fsck_struct" and use that to check
whether there is any signal of canceling.

This patch handles the long jump properly so that all the existing
tests can be passed even the context has been copied. Otherwise,
test f_expisize_ea_del would fail when aborting.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h |   2 +
 e2fsck/pass1.c  | 116 ++++++++++++++++++++++++++++++++++++++++++++----
 e2fsck/unix.c   |   1 +
 3 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 8b7e1276..46792c9b 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -229,6 +229,8 @@ typedef struct e2fsck_struct *e2fsck_t;
 
 struct e2fsck_struct {
 	/* ---- Following fields are never updated during the pass1 ---- */
+	/* Global context to get the cancel flag */
+	e2fsck_t		global_ctx;
 	const char		*program_name;
 	char			*filesystem_name;
 	char			*device_name;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8eecd958..a9244201 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1144,7 +1144,22 @@ static int quota_inum_is_reserved(ext2_filsys fs, ext2_ino_t ino)
 	return 0;
 }
 
-void e2fsck_pass1(e2fsck_t ctx)
+static int e2fsck_should_abort(e2fsck_t ctx)
+{
+	e2fsck_t global_ctx;
+
+	if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		return 1;
+
+	if (ctx->global_ctx) {
+		global_ctx = ctx->global_ctx;
+		if (global_ctx->flags & E2F_FLAG_SIGNAL_MASK)
+			return 1;
+	}
+	return 0;
+}
+
+void e2fsck_pass1_thread(e2fsck_t ctx)
 {
 	int	i;
 	__u64	max_sizes;
@@ -1360,7 +1375,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 		if (ino > ino_threshold)
 			pass1_readahead(ctx, &ra_group, &ino_threshold);
 		ehandler_operation(old_op);
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			goto endit;
 		if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
 			/*
@@ -1949,13 +1964,13 @@ void e2fsck_pass1(e2fsck_t ctx)
 
 		FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
 
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			goto endit;
 
 		if (process_inode_count >= ctx->process_inode_size) {
 			process_inodes(ctx, block_buf);
 
-			if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+			if (e2fsck_should_abort(ctx))
 				goto endit;
 		}
 	}
@@ -2068,6 +2083,89 @@ endit:
 	else
 		ctx->invalid_bitmaps++;
 }
+
+static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
+{
+	errcode_t	retval;
+	e2fsck_t	thread_context;
+
+	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
+	if (retval) {
+		com_err(global_ctx->program_name, retval, "while allocating memory");
+		return retval;
+	}
+	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
+	thread_context->fs->priv_data = thread_context;
+	thread_context->global_ctx = global_ctx;
+
+	*thread_ctx = thread_context;
+	return 0;
+}
+
+static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	int	flags = global_ctx->flags;
+#ifdef HAVE_SETJMP_H
+	jmp_buf	old_jmp;
+
+	memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
+#endif
+	memcpy(global_ctx, thread_ctx, sizeof(struct e2fsck_struct));
+#ifdef HAVE_SETJMP_H
+	memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
+#endif
+	/* Keep the global singal flags*/
+	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
+			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
+
+	global_ctx->fs->priv_data = global_ctx;
+	ext2fs_free_mem(&thread_ctx);
+	return 0;
+}
+
+void e2fsck_pass1_multithread(e2fsck_t ctx)
+{
+	errcode_t	retval;
+	e2fsck_t	thread_ctx;
+
+	retval = e2fsck_pass1_thread_prepare(ctx, &thread_ctx);
+	if (retval) {
+		com_err(ctx->program_name, 0,
+			_("while preparing pass1 thread\n"));
+		ctx->flags |= E2F_FLAG_ABORT;
+		return;
+	}
+
+#ifdef HAVE_SETJMP_H
+	/*
+	 * When fatal_error() happens, jump to here. The thread
+	 * context's flags will be saved, but its abort_loc will
+	 * be overwritten by original jump buffer for the later
+	 * tests.
+	 */
+	if (setjmp(thread_ctx->abort_loc)) {
+		thread_ctx->flags &= ~E2F_FLAG_SETJMP_OK;
+		e2fsck_pass1_thread_join(ctx, thread_ctx);
+		return;
+	}
+	thread_ctx->flags |= E2F_FLAG_SETJMP_OK;
+#endif
+
+	e2fsck_pass1_thread(thread_ctx);
+	retval = e2fsck_pass1_thread_join(ctx, thread_ctx);
+	if (retval) {
+		com_err(ctx->program_name, 0,
+			_("while joining pass1 thread\n"));
+		ctx->flags |= E2F_FLAG_ABORT;
+		return;
+	}
+}
+
+void e2fsck_pass1(e2fsck_t ctx)
+{
+	e2fsck_pass1_multithread(ctx);
+}
+
 #undef FINISH_INODE_LOOP
 
 /*
@@ -2130,7 +2228,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 		ehandler_operation(buf);
 		check_blocks(ctx, &pctx, block_buf,
 			     &inodes_to_process[i].ea_ibody_quota);
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			break;
 	}
 	ctx->stashed_inode = old_stashed_inode;
@@ -3300,7 +3398,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	inlinedata_fs = ext2fs_has_feature_inline_data(ctx->fs->super);
 
 	if (check_ext_attr(ctx, pctx, block_buf, &ea_block_quota)) {
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			goto out;
 		pb.num_blocks += EXT2FS_B2C(ctx->fs, ea_block_quota.blocks);
 	}
@@ -3355,7 +3453,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	}
 	end_problem_latch(ctx, PR_LATCH_BLOCK);
 	end_problem_latch(ctx, PR_LATCH_TOOBIG);
-	if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+	if (e2fsck_should_abort(ctx))
 		goto out;
 	if (pctx->errcode)
 		fix_problem(ctx, PR_1_BLOCK_ITERATE, pctx);
@@ -3836,7 +3934,7 @@ static int process_bad_block(ext2_filsys fs,
 				*block_nr = 0;
 				return BLOCK_CHANGED;
 			}
-			if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+			if (e2fsck_should_abort(ctx))
 				return BLOCK_ABORT;
 		} else
 			mark_block_used(ctx, blk);
@@ -3933,7 +4031,7 @@ static int process_bad_block(ext2_filsys fs,
 			*block_nr = 0;
 			return BLOCK_CHANGED;
 		}
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			return BLOCK_ABORT;
 		return 0;
 	}
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 0a027be6..83b62032 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1444,6 +1444,7 @@ int main (int argc, char *argv[])
 	}
 	reserve_stdio_fds();
 
+	ctx->global_ctx = NULL;
 	set_up_logging(ctx);
 	if (ctx->logf) {
 		int i;
-- 
2.25.4

