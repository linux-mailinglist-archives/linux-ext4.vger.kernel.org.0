Return-Path: <linux-ext4+bounces-11592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8F5C3DA3A
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA5AC4E4DC7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC232AAD4;
	Thu,  6 Nov 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkLPye38"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0833019A6
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468792; cv=none; b=tTWHl2bdREYNoCKKJjLMURMRfLBG7Q7A1mfAKRgZeilC7AjBePCjMDt4uTWxUYEGG60j3rIEveo9dyjf+W4OmNv+rvTBFLssRMeG2SG1/WmnqJ3kFgVE0XyFafEqn7k8X4kmR7tZZlbjQMxQt30l85tG8HaIPmiBgsLVagdzSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468792; c=relaxed/simple;
	bh=n8MyRkBaRik4CQdlHEATkVnbTeYzTzp+J7CTjX0uLno=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4VtwnI1F6vuYS47Dlf9kOaurd8YANlVDBMNcbF3/Jcrvf+g5qxrc3a216EjFdB2StnCFkm4b9vXfFxXTwpNz6kDLKRolO2Hny0Qo0cJljNObXtHa57+MtJzjz+QgnNYqENwQcRh9ABBkmdVWvIDca5rBh96Iz2G3IY+5YL8JnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkLPye38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A554C4CEFB;
	Thu,  6 Nov 2025 22:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468792;
	bh=n8MyRkBaRik4CQdlHEATkVnbTeYzTzp+J7CTjX0uLno=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QkLPye38iQrGpAMF/fMMcOGNN+EeGr/jUxCNlDZBKk1PUFXTIOdC0tLG87tQ6YCjQ
	 TDrcy2STnbzNNtMKnj4wMviYj04XD1RK6pe0cRIf6eyJW+ls8gJxnTCCsKOGN/5Njy
	 /fZuOm43KaU3vU0nuJAYkrasgKIFsLPJm6QNQVAy6HM0nWusephSBwt8LmrQRYoPI0
	 23kGwWJosfLTOMuzsNHZIXZwl/pGokghBbpDz8qTZaKD8eDYfzMd7EgoN+RGfTHTdN
	 Z9JzmKZVgrDs7jeIfI5y6FsAUBmGHOE4obbiXx3RNerxhNu+g8zbyf6PI+DgLpMbXO
	 EBkBigutUBe8g==
Date: Thu, 06 Nov 2025 14:39:51 -0800
Subject: [PATCH 2/3] fuse2fs: register as an IO flusher thread
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794686.2863550.10736715891210431372.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794639.2863550.14252706802579101303.stgit@frogsfrogsfrogs>
References: <176246794639.2863550.14252706802579101303.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse2fs is involved in the filesystem I/O path and can allocate memory
while processing I/O requests.  Therefore, we need to register that fact
with the kernel so that memory allocations done by libext2fs don't start
a round of filesystem memory reclaim, which could cause more writeout to
get dumped on fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure       |   37 +++++++++++++++++++++++++++++++++++++
 configure.ac    |   19 +++++++++++++++++++
 lib/config.h.in |    3 +++
 misc/fuse2fs.c  |   27 +++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)


diff --git a/configure b/configure
index ba2e5380f6d20b..356644beed651e 100755
--- a/configure
+++ b/configure
@@ -14725,6 +14725,43 @@ then
 printf "%s\n" "#define FUSE_USE_VERSION $FUSE_USE_VERSION" >>confdefs.h
 
 fi
+
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for PR_SET_IO_FLUSHER" >&5
+printf %s "checking for PR_SET_IO_FLUSHER... " >&6; }
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+#define _GNU_SOURCE
+#include <sys/prctl.h>
+
+int
+main (void)
+{
+
+prctl(PR_SET_IO_FLUSHER, 0, 0, 0, 0);
+
+  ;
+  return 0;
+}
+
+_ACEOF
+if ac_fn_c_try_link "$LINENO"
+then :
+  have_pr_set_io_flusher=yes
+   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+else $as_nop
+  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+if test "$have_pr_set_io_flusher" = yes; then
+
+printf "%s\n" "#define HAVE_PR_SET_IO_FLUSHER 1" >>confdefs.h
+
+fi
+
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for CLOCK_MONOTONIC" >&5
 printf %s "checking for CLOCK_MONOTONIC... " >&6; }
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
diff --git a/configure.ac b/configure.ac
index 051161c5848072..f065cd395cf33c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1452,6 +1452,25 @@ then
 	AC_DEFINE_UNQUOTED(FUSE_USE_VERSION, $FUSE_USE_VERSION,
 		[Define to the version of FUSE to use])
 fi
+
+dnl
+dnl see if PR_SET_IO_FLUSHER exists
+dnl
+AC_MSG_CHECKING(for PR_SET_IO_FLUSHER)
+AC_LINK_IFELSE(
+[	AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <sys/prctl.h>
+	]], [[
+prctl(PR_SET_IO_FLUSHER, 0, 0, 0, 0);
+	]])
+], have_pr_set_io_flusher=yes
+   AC_MSG_RESULT(yes),
+   AC_MSG_RESULT(no))
+if test "$have_pr_set_io_flusher" = yes; then
+  AC_DEFINE(HAVE_PR_SET_IO_FLUSHER, 1, [Define to 1 if PR_SET_IO_FLUSHER is present])
+fi
+
 dnl
 dnl see if CLOCK_MONOTONIC exists
 dnl
diff --git a/lib/config.h.in b/lib/config.h.in
index 364d6e865b7115..a4d8ce1c3765ed 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -70,6 +70,9 @@
 /* Define to 1 if you have the BSD-style 'qsort_r' function. */
 #undef HAVE_BSD_QSORT_R
 
+/* Define to 1 if PR_SET_IO_FLUSHER is present */
+#undef HAVE_PR_SET_IO_FLUSHER
+
 /* Define to 1 if you have the Mac OS X function
    CFLocaleCopyPreferredLanguages in the CoreFoundation framework. */
 #undef HAVE_CFLOCALECOPYPREFERREDLANGUAGES
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e0134834d342dd..86e0222a51369a 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -17,6 +17,7 @@
 # include <linux/fs.h>
 # include <linux/falloc.h>
 # include <linux/xattr.h>
+# include <sys/prctl.h>
 #endif
 #ifdef HAVE_SYS_XATTR_H
 #include <sys/xattr.h>
@@ -5483,6 +5484,30 @@ static void fuse2fs_compute_libfuse_args(struct fuse2fs *ff,
 	}
 }
 
+/*
+ * Try to register as a filesystem I/O server process so that our memory
+ * allocations don't cause fs reclaim.
+ */
+static void try_set_io_flusher(struct fuse2fs *ff)
+{
+#ifdef HAVE_PR_SET_IO_FLUSHER
+	int ret = prctl(PR_GET_IO_FLUSHER, 0, 0, 0, 0);
+
+	/*
+	 * positive ret means it's already set, negative means we can't even
+	 * look at the value so don't bother setting it
+	 */
+	if (ret)
+		return;
+
+	ret = prctl(PR_SET_IO_FLUSHER, 1, 0, 0, 0);
+	if (ret < 0)
+		err_printf(ff, "%s: %s.\n",
+ _("Could not register as IO flusher thread"),
+			   strerror(errno));
+#endif
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -5528,6 +5553,8 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	try_set_io_flusher(&fctx);
+
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE2FS_ALLOC_ALL_BLOCKS")) {
 		log_printf(&fctx, "%s\n",


