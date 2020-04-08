Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06B1A1EF6
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgDHKqC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34557 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgDHKqC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id l14so3165897pgb.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Kqpghk4PVi+Y9uAXdJ0hkRRkzWpjcrImjeHsqLCbJk=;
        b=F4viFzu8sYdWaFmfECD22vwYGydCpNMAKHb1/2IEyW+vasDiRdt5yuHnXJ7tR9sCTi
         7KMoPzbe0irWz8j5ZknwPiKpVCNUJ19hea4Gw4olCZkipA0iEN91qusnfwV8b80pMPfo
         u85UeUPJLPxiJI6wUpZu9jnRzqXwdfx3XsjHdt8fddb1J24drLVFwHKRPHhpTwIBgkFc
         yUO3K2Gl3HIJBNBJ0bDHbN12kSguT0yCH+BlIkimWZGITvKnz5Ugln0YO9xHxp1LH5tW
         UJ6DfEp88rOZluSRNh71oqMyEV7h/4dXmZ3U6t8WmQpRl1O5e/1k3YAlTtDUDDcC0yb+
         fgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Kqpghk4PVi+Y9uAXdJ0hkRRkzWpjcrImjeHsqLCbJk=;
        b=pMih7X/yNFplb4PS894jgFrUCIU05OR85trEKT8y1dCHi0tEhPvxa91kFfDEgjCac+
         O9U3+fARknTJrqP7ehfbHPLlh1OP2aTYbJtqls28jyq9ytH63D6Cc8iqIofAeayIdl0V
         yd7zwPQqUTMJG8YJ5NlS6QciUWH7KECPhLbekD1a19MHsXiekO7Tv3zNnOB3DaDparU3
         RS1P7Pl65GhBiuP33mkHEZoBUnnNdcNuogZrpcx2i86Ivsw4zG/BJUN+wXqLm6pUpplk
         u6i6kszZIvdmiwHz241RanKeTzeE/aW8gYzEk5qrGrCJ185eY1yfqpHgQiOMbnjV5Sw7
         T2nQ==
X-Gm-Message-State: AGi0PuZAwQ/o3YwJPlvyGXxi6sIm0gaehot3f0cpzJ52Utm+sUkzzIa3
        yHT5ZXGQVb4xO2dvMyeqwerdumWMNhg=
X-Google-Smtp-Source: APiQypIf8k0HGhb6L6InVDDhTUS/iiL/HHF5tqYzsjrVFSjRnVCjZXxB8++5EaPy5EuIpwjxJEqLWA==
X-Received: by 2002:aa7:9a5d:: with SMTP id x29mr6695992pfj.284.1586342758741;
        Wed, 08 Apr 2020 03:45:58 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:58 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 12/46] e2fsck: create one thread to fsck
Date:   Wed,  8 Apr 2020 19:44:40 +0900
Message-Id: <1586342714-12536-13-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch creates only one thread to do pass1 check. The same
codes can be used to create multiple threads, but other functions
need to be modified to get ready for that.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 configure.ac    |   6 ++
 e2fsck/e2fsck.h |  11 ++++
 e2fsck/pass1.c  | 144 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 143 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index 18e434bc..a8d3784c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -107,6 +107,12 @@ if test "$GCC" = yes; then
 fi
 AC_PROG_CPP
 dnl
+dnl Add pthread to the CFLAGS/LDFLAGS
+dnl
+CFLAGS="$CFLAGS -pthread"
+LDFLAGS="$CFLAGS -pthread"
+LDFLAGS_STATIC="$LDFLAGS_STATIC -pthread"
+dnl
 dnl Alpha computers use fast and imprecise floating point code that may
 dnl miss exceptions by default. Force sane options if we're using GCC.
 AC_MSG_CHECKING(for additional special compiler flags)
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 25aaea20..7e00648e 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -433,6 +433,17 @@ struct e2fsck_struct {
 
 };
 
+struct e2fsck_thread_info {
+	/* ID returned by pthread_create() */
+	pthread_t		 eti_thread_id;
+	/* Application-defined thread index */
+	int			 eti_thread_index;
+	/* Thread has been started */
+	int			 eti_started;
+	/* Context used for this thread */
+	e2fsck_t		 eti_thread_ctx;
+};
+
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
 struct extent_tree_level {
 	unsigned int	num_extents;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index ed49b59b..890819f7 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -47,6 +47,7 @@
 #include <errno.h>
 #endif
 #include <assert.h>
+#include <pthread.h>
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -1172,7 +1173,7 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
-void e2fsck_pass1_thread(e2fsck_t ctx)
+void _e2fsck_pass1(e2fsck_t ctx)
 {
 	int	i;
 	__u64	max_sizes;
@@ -2421,18 +2422,38 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	return retval;
 }
 
-void e2fsck_pass1_multithread(e2fsck_t ctx)
+static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
+				      int num_threads, e2fsck_t global_ctx)
 {
-	errcode_t	retval;
-	e2fsck_t	thread_ctx;
+	errcode_t			 rc;
+	errcode_t			 ret = 0;
+	int				 i;
+	struct e2fsck_thread_info	*pinfo;
 
-	retval = e2fsck_pass1_thread_prepare(ctx, &thread_ctx);
-	if (retval) {
-		com_err(ctx->program_name, 0,
-			_("while preparing pass1 thread\n"));
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
+	for (i = 0; i < num_threads; i++) {
+		pinfo = &infos[i];
+
+		if (!pinfo->eti_started)
+			continue;
+
+		rc = pthread_join(pinfo->eti_thread_id, NULL);
+		if (rc) {
+			com_err(global_ctx->program_name, rc,
+				_("while joining thread\n"));
+			if (ret == 0)
+				ret = rc;
+		}
+		e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
 	}
+	free(infos);
+
+	return ret;
+}
+
+static void *e2fsck_pass1_thread(void *arg)
+{
+	struct e2fsck_thread_info	*info = arg;
+	e2fsck_t			 thread_ctx = info->eti_thread_ctx;
 
 #ifdef HAVE_SETJMP_H
 	/*
@@ -2443,20 +2464,107 @@ void e2fsck_pass1_multithread(e2fsck_t ctx)
 	 */
 	if (setjmp(thread_ctx->abort_loc)) {
 		thread_ctx->flags &= ~E2F_FLAG_SETJMP_OK;
-		e2fsck_pass1_thread_join(ctx, thread_ctx);
-		return;
+		goto out;
 	}
 	thread_ctx->flags |= E2F_FLAG_SETJMP_OK;
 #endif
 
-	e2fsck_pass1_thread(thread_ctx);
-	retval = e2fsck_pass1_thread_join(ctx, thread_ctx);
+	_e2fsck_pass1(thread_ctx);
+
+out:
+	return NULL;
+}
+
+static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
+				      int num_threads, e2fsck_t global_ctx)
+{
+	struct e2fsck_thread_info	*infos;
+	pthread_attr_t			 attr;
+	errcode_t			 retval;
+	errcode_t			 ret;
+	struct e2fsck_thread_info	*tmp_pinfo;
+	int				 i;
+	e2fsck_t			 thread_ctx;
+
+	retval = pthread_attr_init(&attr);
 	if (retval) {
-		com_err(ctx->program_name, 0,
-			_("while joining pass1 thread\n"));
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
+		com_err(global_ctx->program_name, retval,
+			_("while setting pthread attribute\n"));
+		return retval;
+	}
+
+	infos = calloc(num_threads, sizeof(struct e2fsck_thread_info));
+	if (infos == NULL) {
+		retval = -ENOMEM;
+		com_err(global_ctx->program_name, retval,
+			_("while allocating memory for threads\n"));
+		pthread_attr_destroy(&attr);
+		return retval;
 	}
+
+	for (i = 0; i < num_threads; i++) {
+		tmp_pinfo = &infos[i];
+		tmp_pinfo->eti_thread_index = i;
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx);
+		if (retval) {
+			com_err(global_ctx->program_name, retval,
+				_("while preparing pass1 thread\n"));
+			break;
+		}
+		tmp_pinfo->eti_thread_ctx = thread_ctx;
+
+		retval = pthread_create(&tmp_pinfo->eti_thread_id, &attr,
+					&e2fsck_pass1_thread, tmp_pinfo);
+		if (retval) {
+			com_err(global_ctx->program_name, retval,
+				_("while creating thread\n"));
+			e2fsck_pass1_thread_join(global_ctx, thread_ctx);
+			break;
+		}
+
+		tmp_pinfo->eti_started = 1;
+	}
+
+	/* destroy the thread attribute object, since it is no longer needed */
+	ret = pthread_attr_destroy(&attr);
+	if (ret) {
+		com_err(global_ctx->program_name, ret,
+			_("while destroying thread attribute\n"));
+		if (retval == 0)
+			retval = ret;
+	}
+
+	if (retval) {
+		e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+		return retval;
+	}
+	*pinfo = infos;
+	return 0;
+}
+
+static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
+{
+	struct e2fsck_thread_info	*infos = NULL;
+	int				 num_threads = 1;
+	errcode_t			 retval;
+
+	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			_("while starting pass1 threads\n"));
+		goto out_abort;
+	}
+
+	retval = e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			_("while joining pass1 threads\n"));
+		goto out_abort;
+	}
+	return;
+out_abort:
+	global_ctx->flags |= E2F_FLAG_ABORT;
+	return;
 }
 
 void e2fsck_pass1(e2fsck_t ctx)
-- 
2.25.2

