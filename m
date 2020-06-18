Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B621FF6AD
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgFRP2s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbgFRP2p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02185C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so2834293pjf.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=64HK90qsCK4R9JfTeIDVgUgl5OZuAkZV7eaeNcklT04=;
        b=sI9qhKJuBV2bh5LTjGSoWBtFXZF7CIpLPERM1o/8RXHyOEbemcIAHNHXbah1VtleNM
         p0mRzvydc470RnIuMV+LiY1nzXMSMh9SbmO6gr9P5lEWmIONqUfy+7l2Bn4Q53aiWEG0
         PWTxh6/La5UrXey666q1fCxUWC3oU/TAHKCceDSgAh/NV5/DmxV9YyM69kPjI4XggKby
         oZa0kzaYhPbTt4JXho+YRdBNDUDOilthfgt5HwHuoZ9UdkC+3P96gzz0klowhtd5Z01T
         jdFoF98kwDDAHZTlP/0W8D6MKkdwv/mVkcgEE0pueCB14An3b0BK3xD97LhJ+t1T50jZ
         +geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=64HK90qsCK4R9JfTeIDVgUgl5OZuAkZV7eaeNcklT04=;
        b=XwOYm1mL+vCVtyp/6GLxRzywFqXvdxNdbS6iN/Ff1ddWCeZ1IElZdAQUX2wyD5um4d
         CxodH432eLYqrAv9LX4Ql/rT8ovR5OGX/2dUFZckGPgn0JiwOWE2htbN8cGdxab+xHaI
         jRZy+2hkAn2syY0I/WMkVxYH7uB8TmI3fBwvEt2DxaPpnubOP5LTigZXCyv1TGfPq6fD
         3QfYoJg/Lr2nOQVUQESnMZOPKe/FQ+VrfE1iMU2DAIbGAljDjQYC1HfuLR+IB1zlAK93
         uKayjpfAeWCbNlfDTxhcFaJBhgoULcg4Im9VCwhzd+F2+ogfDleYwEoexYxwoOKN9bG2
         i5pg==
X-Gm-Message-State: AOAM532wt3S38K/M01iYcg7Rsj53fGIko85jVY+6cWajKiIrhEq86TVK
        Ni+bVH//yzJQjWCvlXumOuZLYGYGfLo=
X-Google-Smtp-Source: ABdhPJzNvj+0husHsPQ7Y0drqygJoaLQLNUd667gho41T3UbVSzhPn7CXUTq5/2XV9/AMM+/w/H4Nw==
X-Received: by 2002:a17:902:8d87:: with SMTP id v7mr4068824plo.73.1592494124049;
        Thu, 18 Jun 2020 08:28:44 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:43 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 13/51] e2fsck: create one thread to fsck
Date:   Fri, 19 Jun 2020 00:27:16 +0900
Message-Id: <1592494074-28991-14-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
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
index b6cfcbb5..93387bd6 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -428,6 +428,17 @@ struct e2fsck_struct {
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
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
index bf843bb9..35806f29 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -47,6 +47,7 @@
 #include <errno.h>
 #endif
 #include <assert.h>
+#include <pthread.h>
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -1162,7 +1163,7 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
-void e2fsck_pass1_thread(e2fsck_t ctx)
+void _e2fsck_pass1(e2fsck_t ctx)
 {
 	int	i;
 	__u64	max_sizes;
@@ -2403,18 +2404,38 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
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
@@ -2425,20 +2446,107 @@ void e2fsck_pass1_multithread(e2fsck_t ctx)
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
2.25.4

