Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E758F61F301
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiKGMZS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiKGMZF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0A163C2
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14430909pji.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PkED8TboI7uLiO3M1yPjVn8xujKFFCJ9w9S0ClkL94=;
        b=cyDV/b0LX+Q7YRZuVCpIvO9Ov1aoqv8/Kw1PfCvZRyB9PHfNF3uXSABQDAw1WAWVbH
         yn1sbOXqQPuIbGghaofIiMIunum+wdkG+1+q4AISbpz3xIDNLisOs7l3ZLdkheKpIyy9
         0pxZv4YJ9B7BTNj7+5u4bu3eG3bgVmddZ+RlLFsCtNFzU4sNYnfhwdi0F9ucCwKnJRl+
         EZgomZNZmrUxXxcQOiyq0LZxViC2/H1jbC/yNs85UDKUA0auH63BMEN33xV//fvmUkIM
         mOAlwFd9SsNUpSabO6CoD/RPe+bMaAUTgEqKoDox97B0Sd7I0uUAn1bBJtBvHbz9j6mX
         x0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PkED8TboI7uLiO3M1yPjVn8xujKFFCJ9w9S0ClkL94=;
        b=GzHk3dBCdH702ezBKmPjSXAIcb7zQoBEp09l2/XBfo3CQmq8BBfWmOt6cbeqtb8WlU
         v2H8vCCWdobB7HU3WEkxy8fyD5fM9LltY7MjCPEe+8sL4TT7HgQDZZRTEK8IjWT86UPJ
         wKrW+pMP43eSgr3AZLZ/nLdQo7kqfMpyaCNg+uTAfJpKi7cva1MI+Qv0Iw5NFCMATH6r
         buBbqeU9JZMETEUW+XIW5TsURyhffoKFC7n6yZjlBlDZr6dPIJDcHpR9XANd/sQLD/WC
         bHnAG11gfwRi/3GQBKvt+43L7ncPlcB/cMkxHZ80egYNIGMTdwCnfIo0hwkoXQO5og7T
         Hy0g==
X-Gm-Message-State: ACrzQf1lyv915v5PrMifiHCYh7Vxa6PVd8uszUOnn4aNpYrFgzOC3Eaf
        NSSW1CUj0QIvvFmGdKMhKuo=
X-Google-Smtp-Source: AMsMyM6wlOQ78wzIAhI9mGLcVr6IRFb+xiRkaYNsDCKcjUno5B/w16gh2bMDKaUofuLxXYKSDMcsuA==
X-Received: by 2002:a17:902:db0e:b0:186:9b38:ad26 with SMTP id m14-20020a170902db0e00b001869b38ad26mr51684040plx.43.1667823904261;
        Mon, 07 Nov 2022 04:25:04 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902860400b001868d4600b8sm4894962plo.158.2022.11.07.04.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:03 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 26/72] e2fsck: Use merge/clone apis of libext2fs
Date:   Mon,  7 Nov 2022 17:51:14 +0530
Message-Id: <eb070428f9ba9e0ae53edb71bd453e05a3042183.1667822611.git.ritesh.list@gmail.com>
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

This patch makes use of libext2fs merge/clone apis in e2fsck to first
clone the global_fs based on the passed CLONE_FLAGS. Then once the parallel
e2fsck operation finishes, it calls for merge fs api which merges it into
parent fs.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 4b165600..040c58ce 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2154,10 +2154,36 @@ endit:
 }
 
 #ifdef HAVE_PTHREAD
+static errcode_t e2fsck_open_channel_fs(ext2_filsys dest, e2fsck_t dest_context, ext2_filsys src)
+{
+	errcode_t retval;
+
+	io_channel_flush_cleanup(src->io);
+	retval = dest->io->manager->open(dest->device_name,
+									 IO_FLAG_RW | IO_FLAG_THREADS, &dest->io);
+	if (retval)
+		return retval;
+	dest->image_io = dest->io;
+	dest->io->app_data = dest;
+	/* Block size might not be default */
+	io_channel_set_blksize(dest->io, src->io->block_size);
+	ehandler_init(dest->io);
+
+	dest->priv_data = dest_context;
+	dest_context->fs = dest;
+	/* The data should be written to disk immediately */
+	dest->io->flags |= CHANNEL_FLAGS_WRITETHROUGH;
+	/* icache will be rebuilt if needed, so do not copy from @src */
+	src->icache = NULL;
+	return 0;
+}
+
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
 {
 	errcode_t retval;
 	e2fsck_t thread_context;
+	ext2_filsys thread_fs;
+	ext2_filsys global_fs = global_ctx->fs;
 
 	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
 	if (retval) {
@@ -2165,13 +2191,30 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		return retval;
 	}
 	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
-	thread_context->fs->priv_data = thread_context;
 	thread_context->global_ctx = global_ctx;
+	retval = ext2fs_clone_fs(global_fs, &thread_fs,
+							 EXT2FS_CLONE_BLOCK | EXT2FS_CLONE_INODE |
+							 EXT2FS_CLONE_BADBLOCKS | EXT2FS_CLONE_DBLIST);
+	if (retval) {
+		com_err(global_ctx->program_name, retval, "while allocating memory");
+		goto out_context;
+	}
+
+	retval = e2fsck_open_channel_fs(thread_fs, thread_context, global_fs);
+	if (retval) {
+		com_err(global_ctx->program_name, retval, "while copying fs");
+		goto out_fs;
+	}
 
 	thread_context->thread_index = 0;
 	set_up_logging(thread_context);
 	*thread_ctx = thread_context;
 	return 0;
+out_fs:
+	ext2fs_merge_fs(&thread_fs);
+out_context:
+	ext2fs_free_mem(&thread_context);
+	return retval;
 }
 
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
@@ -2180,6 +2223,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int flags = global_ctx->flags;
 	FILE *global_logf = global_ctx->logf;
 	FILE *global_problem_logf = global_ctx->problem_logf;
+	ext2_filsys thread_fs = thread_ctx->fs;
+	ext2_filsys global_fs = global_ctx->fs;
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
 
@@ -2192,10 +2237,17 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
-
-	global_ctx->fs->priv_data = global_ctx;
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
+
+	global_fs->priv_data = global_ctx;
+	global_ctx->fs = global_fs;
+
+	retval = ext2fs_merge_fs(&(thread_ctx->fs));
+	if (retval) {
+		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
+		return retval;
+	}
 	return retval;
 }
 
-- 
2.37.3

