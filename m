Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E372B80BF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKRPkc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgKRPkb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3DEC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a6so2978677ybi.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VU3wbpmS0ra35z7h/EvQ+ic9V44H3ZT9/pUw9x1+mBM=;
        b=Oo8jGrQioLK3FHqsas6FFxc5b7ARvAGYGzvN1aYd2YZ6wnqEEqQmfPk+9/UEN+NLnD
         P5Rs3il8HQ2rpNS83Tz6gToNCj5o07M6NAukRkcmnDXhKC5C4d8LrpHB3W77y/E8VhR4
         SeXvD+1zwfJmYOtTqLDYTqS+3srp/I6jrke1Kzou4B8zlHxvQVr1hrH0CovEqNC5zTei
         bpptOpQJS26sA3fpPEkyxZTIgzMFruhdpm0EifyGxpZojpQl3XEnKo3RYwZm8tdf6Jbj
         0iz4llvNQkPkfhq2Oe9l+BOXpRtm0Wue2XmvrbMmwEe6Za5lYYHKZCBTkc7weTy+Sa6O
         URVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VU3wbpmS0ra35z7h/EvQ+ic9V44H3ZT9/pUw9x1+mBM=;
        b=SrgQvGlYBvydkMtOiARjjwSaSJcHDKWEQH56GBhhrkMMIdixtNlu606DGEr5PB3f5i
         7vs5y1Nd3ADtzp/GJdD/c34FzUI/k10BhQ9TbRXYq9HjkD67bxtSJMoBBAXyvis/7Hr9
         YP5WBhSqiFLY7I73fhg4Mt6Ft2fV1S+AuEv6mmXSwlCl35iDtU8YnYGOCqLg8DNZOQV1
         WS3QmCKfi9s1jq993sQzTouYGlCqpKIUksMcEGu2Ji2nuteY6PNbPZYqZmhJrJbv/pKK
         VafB4n7+JvFw6bh4Ev7X6SR+Yq8nQ5T6wTycGULg73tbcTsyx1Hgml/xahqchy6+b7cz
         V+MA==
X-Gm-Message-State: AOAM531ylEjtMXWpMCIqScUs9o0fruuM0nzPITftyHYTrT/j1Yp9J17Y
        spyp9637HyLSsOt6IV1AsHt4YmWQ/LKDapCXeTXmW9GWblJg+NU1gsRvC4Y2fJr8wOvmUiDGLjR
        Lr3lzhURyC/6PV4h1P2dleEDaJrEV2AWsM3V1aOMCYGQdYJoLyEw97ERFKq60xklYDZnDP1zHU9
        IZKUwo1+Y=
X-Google-Smtp-Source: ABdhPJxU1V/1t1Uz/jDyb8n24XNzCRDa5KdVE3FI9gkI+TMJlo+zuuZ9JYvYmTNVrtnJByxw0kff0YTstvwbU/SZFDA=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:f512:: with SMTP id
 a18mr10468914ybe.159.1605714029381; Wed, 18 Nov 2020 07:40:29 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:48 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-3-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 02/61] e2fsck: copy context when using multi-thread fsck
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
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 114 +++++++++++++++++++++++++++++++++++++++++++++----
 e2fsck/unix.c  |   1 +
 2 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8eecd958..64d237d3 100644
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
@@ -1955,7 +1970,7 @@ void e2fsck_pass1(e2fsck_t ctx)
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
index 051b31a5..42f616e2 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1445,6 +1445,7 @@ int main (int argc, char *argv[])
 	}
 	reserve_stdio_fds();
 
+	ctx->global_ctx = NULL;
 	set_up_logging(ctx);
 	if (ctx->logf) {
 		int i;
-- 
2.29.2.299.gdc1121823c-goog

