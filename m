Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8F1A1EEC
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgDHKpl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:41 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53124 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgDHKpl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:41 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so1002669pjb.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=31GUYr+hjKDs7YNLdUYhGFexT5oZx4Og0VokEOkoOJA=;
        b=f4fEqESC3OdE+P+AZsObq8SoWBmsgLAoHzTJ3Wb26Rv9Y7w2zfT85P4MygiWxMjqy4
         G3JEBnTo3m2BEkppn8dIvGkbUfT+nq2etI6ZiJDFPjtO9YRvqjbmRpaZ9NbRaqP9yUTd
         JkhYAHR72J79C/c+EM8vKdDCdfQ6+/1HXCFzQ/939RqUHnPSFeyyD6Cun1RsA2w5w4Nt
         T9ySRC/g9SFTt7u731lAcCA8JI3LufYfKHmaQoy8HAdEpia9bDXPRxWbwXfq9kJj7/+0
         bfAeD7RgN7Q4p0Yq5DhDw2waK7FMEbRtJg/xB1aT3wM7hruTqys2dsqNdEYnNw+ny73S
         v3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=31GUYr+hjKDs7YNLdUYhGFexT5oZx4Og0VokEOkoOJA=;
        b=Jq7kDKpmd7lBSxpv/PdNYA1oSYiyn6vfNvOhFHL0UFG6GBbVD4rSBRodBCCl8gZPxK
         ElTUTofQs+E5GCykTjM//0HWoO1jOxkIPbvG1Y9LibA3Ccb6CEunGBNaNnkzZN3fj4PD
         OKb6mXdZQH7BMaAH/8fpjRpn1JRXNZYKxfrZV3sn0GkpCmUCTIChC3ugKVN786Gopwsi
         ej02dwE43RcCiGpNeg5ljrkFsIkYmL4Y9ACQqQMOoGrN+///FMvFDTUdc2V+KIHV8rV9
         sBcyogP4u6l8h0CxZUMltdQ9bYPUiJ9zwUdv0Y3uP91Ni8T+ZlE70nGEroOBGSGXycnr
         cnKw==
X-Gm-Message-State: AGi0PuYFVon8l0TfSaEAOMKsBG5ZWn8A6z1/ebM0qSUxMrwpxrzqLl7f
        dWNk5qrluUJg/SH6sF6vd8F2zVWB4ao=
X-Google-Smtp-Source: APiQypKQKhk9wP83HFTbSxjeG30NXU8/o3en8HmPOCaPRhVgxfJKWLhZa1Y4dPhgBn/gRezHEDezYw==
X-Received: by 2002:a17:90a:368d:: with SMTP id t13mr1956425pjb.175.1586342739468;
        Wed, 08 Apr 2020 03:45:39 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:38 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 03/46] e2fsck: copy context when using multi-thread fsck
Date:   Wed,  8 Apr 2020 19:44:31 +0900
Message-Id: <1586342714-12536-4-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index b5b7d88f..c63b1852 100644
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
index a57c1c06..b093a734 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1154,7 +1154,22 @@ static int quota_inum_is_reserved(ext2_filsys fs, ext2_ino_t ino)
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
@@ -1370,7 +1385,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 		if (ino > ino_threshold)
 			pass1_readahead(ctx, &ra_group, &ino_threshold);
 		ehandler_operation(old_op);
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			goto endit;
 		if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
 			/*
@@ -1967,13 +1982,13 @@ void e2fsck_pass1(e2fsck_t ctx)
 
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
@@ -2086,6 +2101,89 @@ endit:
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
@@ -2148,7 +2246,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 		ehandler_operation(buf);
 		check_blocks(ctx, &pctx, block_buf,
 			     &inodes_to_process[i].ea_ibody_quota);
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			break;
 	}
 	ctx->stashed_inode = old_stashed_inode;
@@ -3318,7 +3416,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	inlinedata_fs = ext2fs_has_feature_inline_data(ctx->fs->super);
 
 	if (check_ext_attr(ctx, pctx, block_buf, &ea_block_quota)) {
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			goto out;
 		pb.num_blocks += EXT2FS_B2C(ctx->fs, ea_block_quota.blocks);
 	}
@@ -3373,7 +3471,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	}
 	end_problem_latch(ctx, PR_LATCH_BLOCK);
 	end_problem_latch(ctx, PR_LATCH_TOOBIG);
-	if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+	if (e2fsck_should_abort(ctx))
 		goto out;
 	if (pctx->errcode)
 		fix_problem(ctx, PR_1_BLOCK_ITERATE, pctx);
@@ -3854,7 +3952,7 @@ static int process_bad_block(ext2_filsys fs,
 				*block_nr = 0;
 				return BLOCK_CHANGED;
 			}
-			if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+			if (e2fsck_should_abort(ctx))
 				return BLOCK_ABORT;
 		} else
 			mark_block_used(ctx, blk);
@@ -3951,7 +4049,7 @@ static int process_bad_block(ext2_filsys fs,
 			*block_nr = 0;
 			return BLOCK_CHANGED;
 		}
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			return BLOCK_ABORT;
 		return 0;
 	}
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index c463d29e..8226aff7 100644
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
2.25.2

