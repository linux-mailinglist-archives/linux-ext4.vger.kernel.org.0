Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69C61F2FD
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiKGMYv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiKGMYi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B681A817
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:37 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so10113965pjd.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75ylSXVoMs4uFH9hMkzh6UY1bNXGiCN2KHMFQvCqWvg=;
        b=aT/c3BpX3UY369B1qIAR6AeljKxd3qlPqTp3QEAADAag+pJqGuLXUdIRU/Q2UD4fYi
         yXRY9SDrGdAOVsZXjMgJpONXpnaijOOd6YZ6BggKSFWgEoq5ri+RxjOldNhBv+HMoWvv
         AZ3N+Gr5x0qQuSKCj9TMxbMdwaTfvyaTnGK3VcHTmcCBn5meV0MuBtcAMuqa+jDlcuvJ
         n4LPD/OYzXTxpe1FVjavYu8YrjE40T63m3+qlspktcS2w72BzpVRl9VJhgkOE1Qo+3me
         BBnEtvnSPP82lwZKr2tk7og3E047ubs6fpc+vGWi3aFWmrVWlLKba3CcqF+J4nRertfz
         H48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75ylSXVoMs4uFH9hMkzh6UY1bNXGiCN2KHMFQvCqWvg=;
        b=zqVQmm3SvSsRrQoQKi1tpTSw0S0SrjhhSikbF7nQmH4oziU5EAANwBkMoxc8oDDknB
         NTiXrPV/nI6ud2zX98PMdREfyrPq7wJ3QsA813iGKeS7xh7NZcr99LXuEv8qnapK+/Hp
         z6M4zdkw7KEfsSVmLgHXcGLJ6auXksm6B+RvdzIwMAClzCK+ffIqBi9rp/jEh1IGN61L
         D0svlahAL5B5PvqKrGX2jRuKPnQRGd31jACkNf9NHkPVjwqM5HhdOXUWEXhK7MErTuu1
         fzmi1XbE1ga4RdKJLvld9tCcaqANnEHByn/eWjc0Mcvn8iOTcl5zlrC0zx51Ts6Hie5d
         4wkA==
X-Gm-Message-State: ACrzQf0HdWPG+ZpRruRZ0oQ6T54mAKvjtXMDwu7idTVxIhrGRwc6L5Jh
        q9dK6PuIULSMng2pkmQnPbQ=
X-Google-Smtp-Source: AMsMyM4x+79ZcF3td5CkK6gg9mXRgv/wqJ8mezQNpndQs12plg2mHJzqwVWoPUAJFyy3FFikJ3QfDQ==
X-Received: by 2002:a17:90b:1a84:b0:213:e8b5:2d16 with SMTP id ng4-20020a17090b1a8400b00213e8b52d16mr41332943pjb.9.1667823876783;
        Mon, 07 Nov 2022 04:24:36 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001870dc3b4c0sm4871106plb.74.2022.11.07.04.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:36 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 22/72] e2fsck: copy context when using multi-thread fsck
Date:   Mon,  7 Nov 2022 17:51:10 +0530
Message-Id: <b755704dccb6ec80d36adefb0117b499288e2722.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h |   2 +
 e2fsck/pass1.c  | 117 ++++++++++++++++++++++++++++++++++++++++++++----
 e2fsck/unix.c   |   1 +
 3 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 35428717..f1259728 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -262,6 +262,8 @@ struct e2fsck_fc_replay_state {
 };
 
 struct e2fsck_struct {
+	/* Global context to get the cancel flag */
+	e2fsck_t global_ctx;
 	ext2_filsys fs;
 	const char *program_name;
 	char *filesystem_name;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 73909c39..972265b8 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1151,7 +1151,22 @@ static int quota_inum_is_reserved(ext2_filsys fs, ext2_ino_t ino)
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
@@ -1381,7 +1396,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 		if (ino > ino_threshold)
 			pass1_readahead(ctx, &ra_group, &ino_threshold);
 		ehandler_operation(old_op);
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			goto endit;
 		if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
 			/*
@@ -2008,7 +2023,7 @@ void e2fsck_pass1(e2fsck_t ctx)
 		if (process_inode_count >= ctx->process_inode_size) {
 			process_inodes(ctx, block_buf);
 
-			if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+			if (e2fsck_should_abort(ctx))
 				goto endit;
 		}
 	}
@@ -2134,6 +2149,92 @@ endit:
 	else
 		ctx->invalid_bitmaps++;
 }
+
+static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
+{
+	errcode_t retval;
+	e2fsck_t thread_context;
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
+	int flags = global_ctx->flags;
+#ifdef HAVE_SETJMP_H
+	jmp_buf old_jmp;
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
+	errcode_t retval;
+	e2fsck_t thread_ctx;
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
+	if (ctx->options & E2F_OPT_MULTITHREAD)
+		e2fsck_pass1_multithread(ctx);
+	else
+		e2fsck_pass1_thread(ctx);
+}
+
 #undef FINISH_INODE_LOOP
 
 /*
@@ -2196,7 +2297,7 @@ static void process_inodes(e2fsck_t ctx, char *block_buf)
 		ehandler_operation(buf);
 		check_blocks(ctx, &pctx, block_buf,
 			     &inodes_to_process[i].ea_ibody_quota);
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			break;
 	}
 	ctx->stashed_inode = old_stashed_inode;
@@ -3424,7 +3525,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	inlinedata_fs = ext2fs_has_feature_inline_data(ctx->fs->super);
 
 	if (check_ext_attr(ctx, pctx, block_buf, &ea_block_quota)) {
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			goto out;
 		pb.num_blocks += EXT2FS_B2C(ctx->fs, ea_block_quota.blocks);
 	}
@@ -3479,7 +3580,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	}
 	end_problem_latch(ctx, PR_LATCH_BLOCK);
 	end_problem_latch(ctx, PR_LATCH_TOOBIG);
-	if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+	if (e2fsck_should_abort(ctx))
 		goto out;
 	if (pctx->errcode)
 		fix_problem(ctx, PR_1_BLOCK_ITERATE, pctx);
@@ -3961,7 +4062,7 @@ static int process_bad_block(ext2_filsys fs,
 				*block_nr = 0;
 				return BLOCK_CHANGED;
 			}
-			if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+			if (e2fsck_should_abort(ctx))
 				return BLOCK_ABORT;
 		} else
 			mark_block_used(ctx, blk);
@@ -4058,7 +4159,7 @@ static int process_bad_block(ext2_filsys fs,
 			*block_nr = 0;
 			return BLOCK_CHANGED;
 		}
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx))
 			return BLOCK_ABORT;
 		return 0;
 	}
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 1ee27f6a..a77041b0 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1461,6 +1461,7 @@ int main (int argc, char *argv[])
 	}
 	reserve_stdio_fds();
 
+	ctx->global_ctx = NULL;
 	set_up_logging(ctx);
 	if (ctx->logf) {
 		int i;
-- 
2.37.3

