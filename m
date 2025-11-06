Return-Path: <linux-ext4+bounces-11577-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 202F7C3D9FB
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EA0188C962
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6989033858F;
	Thu,  6 Nov 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgKmnd+K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF3337690
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468553; cv=none; b=XnmSDbe+xL3cmsf51Zed7HNgLbbkt3ukDSTzLvhsqXNHel9KgEc14lH1T+gGwKZA4hKqM/59owIj9Ca1tiByg299Wy817PyJAVC3WvhnStMFjQDx1dMTVx3YiI74tdNbRNtmaXVTBOx9mmnC5Xuxw6UO/ydmfiUWqymZSoS4h8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468553; c=relaxed/simple;
	bh=TkwTiX+Nnnm3hFYoHDSsXscVqok6ms3rm2cF6LC1KB4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8Z1Cn9hllQEdBvFmHs7vp9itla33CcdPuwHTVsogTCoqm9ltTU5tQ7EHiuED4qhS2f03DswNPKbcixFpfeFTgf321hHQE4mLSykBZq4FCXwewqDDnU7Sa5D96JpRHfShH/a6SdeaKjyZO7A4wh9JF4UIGEsi8/PhY4LfvtUDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgKmnd+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7972EC4CEF7;
	Thu,  6 Nov 2025 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468552;
	bh=TkwTiX+Nnnm3hFYoHDSsXscVqok6ms3rm2cF6LC1KB4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NgKmnd+KQIH55A47FbbiAFPn6mChehsgHjyeIbpWCFuWNBz27ncNJZQZCoPTBc1jj
	 UOubf95HO43RGk2kHPnU0lP2/mGvPwigS8uTTinnzv8kOkmsg6raZCgxZr3pdQCTW/
	 FPMjH+LhyQ/P9LELL2oHWoP3//Po9gvQsEiyO+jogkxu7TN3FxfUXUUXyzyzwDQ6qD
	 9WjpdeBV/gUZjuUCq86ummLuQAqbhjkeiQyK0kXAxBqTr8/C+GdGbJ1wTBBVJeIxE3
	 ZqQwYzFtqjm3VFvZ9Vhmy4A+1KiaOEJ2SgVkYTEzJzYrrfKImYEFRuxwNjCZtyLQoI
	 zRx4AvE7+tMYA==
Date: Thu, 06 Nov 2025 14:35:51 -0800
Subject: [PATCH 18/19] libsupport: add background thread manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793955.2862242.13813774537220961463.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add some simple code to manage a background thread that wakes up
periodically.  This will be needed for MMP in fuse2fs, among other
things.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/bthread.h   |   27 ++++++
 lib/support/Makefile.in |    6 +
 lib/support/bthread.c   |  201 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 lib/support/bthread.h
 create mode 100644 lib/support/bthread.c


diff --git a/lib/support/bthread.h b/lib/support/bthread.h
new file mode 100644
index 00000000000000..cb29a655b815e5
--- /dev/null
+++ b/lib/support/bthread.h
@@ -0,0 +1,27 @@
+/*
+ * bthread.h - Background thread manager
+ *
+ * Copyright (C) 2025 Oracle.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+#ifndef __BTHREAD_H__
+#define __BTHREAD_H__
+
+typedef void (*bthread_fn_t)(void *data);
+struct bthread;
+
+int bthread_create(const char *name, bthread_fn_t fn, void *data,
+		   unsigned int period, struct bthread **btp);
+void bthread_destroy(struct bthread **btp);
+
+int bthread_start(struct bthread *bt);
+void bthread_stop(struct bthread *bt);
+
+int bthread_cancel(struct bthread *bt);
+int bthread_cancelled(struct bthread *bt);
+
+#endif /* __BTHREAD_H__ */
diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index 3f26cd30172f51..6383816fd99cd4 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -13,7 +13,8 @@ MKDIR_P = @MKDIR_P@
 
 all::
 
-OBJS=		cstring.o \
+OBJS=		bthread.o \
+		cstring.o \
 		mkquota.o \
 		plausible.o \
 		profile.o \
@@ -28,6 +29,7 @@ OBJS=		cstring.o \
 		devname.o
 
 SRCS=		$(srcdir)/argv_parse.c \
+		$(srcdir)/bthread.c \
 		$(srcdir)/cstring.c \
 		$(srcdir)/mkquota.c \
 		$(srcdir)/parse_qtype.c \
@@ -108,6 +110,8 @@ $(OBJS):
 #
 argv_parse.o: $(srcdir)/argv_parse.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/argv_parse.h
+bthread.o: $(srcdir)/bthread.c $(top_builddir)/lib/config.h \
+ $(srcdir)/bthread.h
 cstring.o: $(srcdir)/cstring.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/cstring.h
 mkquota.o: $(srcdir)/mkquota.c $(top_builddir)/lib/config.h \
diff --git a/lib/support/bthread.c b/lib/support/bthread.c
new file mode 100644
index 00000000000000..f59fde976920f9
--- /dev/null
+++ b/lib/support/bthread.c
@@ -0,0 +1,201 @@
+/*
+ * bthread.c - Background thread manager
+ *
+ * Copyright (C) 2025 Oracle.
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+#include "config.h"
+#include <stdlib.h>
+#include <errno.h>
+#include <pthread.h>
+#include <string.h>
+
+#include "support/bthread.h"
+
+enum bthread_state {
+	/* waiting to be put in the running state */
+	BT_WAITING,
+	/* running */
+	BT_RUNNING,
+	/* cancelled */
+	BT_CANCELLED,
+};
+
+struct bthread {
+	enum bthread_state state;
+	pthread_t thread;
+	pthread_mutex_t lock;
+	pthread_cond_t cond;
+	bthread_fn_t fn;
+	void *data;
+	unsigned int period; /* seconds */
+	int can_join:1;
+};
+
+/* Wait for a signal or for the periodic interval */
+static inline int bthread_wait(struct bthread *bt)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_REALTIME, &ts);
+	ts.tv_sec += bt->period;
+	return pthread_cond_timedwait(&bt->cond, &bt->lock, &ts);
+}
+
+static void *bthread_run(void *arg)
+{
+	struct bthread *bt = arg;
+	int ret;
+
+	while (1) {
+		pthread_mutex_lock(&bt->lock);
+		ret = bthread_wait(bt);
+		switch (bt->state) {
+		case BT_WAITING:
+			/* waiting to be runnable, go around again */
+			pthread_mutex_unlock(&bt->lock);
+			break;
+		case BT_RUNNING:
+			/* running; call our function if we timed out */
+			pthread_mutex_unlock(&bt->lock);
+			if (ret == ETIMEDOUT)
+				bt->fn(bt->data);
+			break;
+		case BT_CANCELLED:
+			/* exit if we're cancelled */
+			pthread_mutex_unlock(&bt->lock);
+			return NULL;
+		}
+	}
+
+	return NULL;
+}
+
+/* Create background thread and have it wait to be started */
+int bthread_create(const char *name,  bthread_fn_t fn, void *data,
+		   unsigned int period, struct bthread **btp)
+{
+	struct bthread *bt;
+	int error;
+
+	if (!period)
+		return EINVAL;
+
+	bt = calloc(1, sizeof(struct bthread));
+	if (!bt)
+		return ENOMEM;
+	bt->state = BT_WAITING;
+	bt->fn = fn;
+	bt->data = data;
+	bt->period = period;
+	bt->can_join = 1;
+
+	bt->lock = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
+	bt->cond = (pthread_cond_t)PTHREAD_COND_INITIALIZER;
+
+	error = pthread_create(&bt->thread, NULL, bthread_run, bt);
+	if (error)
+		goto out_cond;
+
+	pthread_setname_np(bt->thread, name);
+
+	*btp = bt;
+	return 0;
+
+out_cond:
+	pthread_cond_destroy(&bt->cond);
+	pthread_mutex_destroy(&bt->lock);
+	free(bt);
+	return error;
+}
+
+/* Stop the thread (if running) and tear everything down */
+void bthread_destroy(struct bthread **btp)
+{
+	struct bthread *bt = *btp;
+
+	if (bt) {
+		bthread_stop(bt);
+
+		pthread_cond_destroy(&bt->cond);
+		pthread_mutex_destroy(&bt->lock);
+
+		free(bt);
+	}
+
+	*btp = NULL;
+}
+
+/* Start background thread, put it in waiting state */
+int bthread_start(struct bthread *bt)
+{
+	int err;
+
+	pthread_mutex_lock(&bt->lock);
+	bt->state = BT_RUNNING;
+	err = pthread_cond_signal(&bt->cond);
+	pthread_mutex_unlock(&bt->lock);
+
+	return err;
+}
+
+/* Has this thread been cancelled? */
+int bthread_cancelled(struct bthread *bt)
+{
+	int ret;
+
+	pthread_mutex_lock(&bt->lock);
+	ret = bt->state == BT_CANCELLED;
+	pthread_mutex_unlock(&bt->lock);
+
+	return ret;
+}
+
+/* Ask the thread to cancel itself, but don't wait */
+int bthread_cancel(struct bthread *bt)
+{
+	int err = 0;
+
+	pthread_mutex_lock(&bt->lock);
+	switch (bt->state) {
+	case BT_CANCELLED:
+		break;
+	case BT_WAITING:
+	case BT_RUNNING:
+		bt->state = BT_CANCELLED;
+		err = pthread_cond_signal(&bt->cond);
+		break;
+	}
+	pthread_mutex_unlock(&bt->lock);
+
+	return err;
+}
+
+/* Ask the thread to cancel itself and wait for it */
+void bthread_stop(struct bthread *bt)
+{
+	int need_join = 0;
+
+	pthread_mutex_lock(&bt->lock);
+	switch (bt->state) {
+	case BT_CANCELLED:
+		need_join = bt->can_join;
+		break;
+	case BT_WAITING:
+	case BT_RUNNING:
+		bt->state = BT_CANCELLED;
+		need_join = 1;
+		pthread_cond_signal(&bt->cond);
+		break;
+	}
+	if (need_join)
+		bt->can_join = 0;
+	pthread_mutex_unlock(&bt->lock);
+
+	if (need_join)
+		pthread_join(bt->thread, NULL);
+}


