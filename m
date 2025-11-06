Return-Path: <linux-ext4+bounces-11587-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED1C3DA1F
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6119E4E42A3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D12E0934;
	Thu,  6 Nov 2025 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDp3XaSg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FA2F6598
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468712; cv=none; b=bTZ0N81y4p33byqUvxZzV9T/3NezrYQoP0+o1D4s+fkP/h9LqSQcpVcL4j5ZQpFUmq651zE5qbk2sE/0wYyNXFyDN1tpTFWg8nCVKwNfSbyuFGqLy2bq0j8D4uOrEcwLC8DLT+mCGDJzy44pdNedA7i7YOq98NgiYZDcEj/g25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468712; c=relaxed/simple;
	bh=59MuZLzc4sFS7b6J74mD/dKUn25Pp9d0TvTWx0p8RKw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgHhcSkNc7aL4CusOwfOMLX3awtiqYo3DBXTBYyxmhCo7i49fomZnwcmZ15OQrkDSXPwOzkGrErzIGUR220gqcjFr/KqDH3UaDn1vp2lhdpgNn5/YBL8fDBaBXy0kesZTzBixERNJUb0XbzPlXQSoX4fKuhzqkRY9oLVsD4Ies8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDp3XaSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B27FC4CEF7;
	Thu,  6 Nov 2025 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468712;
	bh=59MuZLzc4sFS7b6J74mD/dKUn25Pp9d0TvTWx0p8RKw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZDp3XaSgjJbC51IwfEYtG/Q5nBRfecPDYvjTyjirDwWGkaOkYZMsEt9n2GqXWaq/g
	 Pp9AwO2eOJvvlSvYFe1P3sv6knEdH5XIqbRjWFFKwsaP11dUPZR8jWLJszNng0mB1S
	 cn44oXAZZt8Z2V06vtemTLdHtoYtXTNewv+tAkJg0ZLQLycfDO6XLJILoxoawBPYed
	 JyTUzq0u6VtcrlKG+2ksR9B7+Xf55RC3qGjCvoyUqZIrjIAHU3cYyE8mr6bZy7bC7h
	 yeoHXGkRJG6OsKtIkpuIKHKtoR1hIOf0z9g3SV09M0StdtPbBuJVWzg64/uaBxurJF
	 aNpK/Ga0qRkZA==
Date: Thu, 06 Nov 2025 14:38:31 -0800
Subject: [PATCH 9/9] fuse2fs: collect runtime of various operations
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794327.2862990.177650256432240806.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
References: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Collect the run time of various operations so that we can do some simple
profiling.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure       |   37 +++++++++++++++++++++++++++++++++++++
 configure.ac    |   19 +++++++++++++++++++
 lib/config.h.in |    3 +++
 misc/fuse2fs.c  |   43 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 101 insertions(+), 1 deletion(-)


diff --git a/configure b/configure
index 2ed61db3602dc9..ba2e5380f6d20b 100755
--- a/configure
+++ b/configure
@@ -14725,6 +14725,43 @@ then
 printf "%s\n" "#define FUSE_USE_VERSION $FUSE_USE_VERSION" >>confdefs.h
 
 fi
+{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for CLOCK_MONOTONIC" >&5
+printf %s "checking for CLOCK_MONOTONIC... " >&6; }
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+#define _GNU_SOURCE
+#include <time.h>
+
+int
+main (void)
+{
+
+struct timespec nuts;
+clock_gettime(CLOCK_MONOTONIC, &nuts);
+
+  ;
+  return 0;
+}
+
+_ACEOF
+if ac_fn_c_try_link "$LINENO"
+then :
+  have_clock_monotonic=yes
+   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+printf "%s\n" "yes" >&6; }
+else $as_nop
+  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+printf "%s\n" "no" >&6; }
+fi
+rm -f core conftest.err conftest.$ac_objext conftest.beam \
+    conftest$ac_exeext conftest.$ac_ext
+if test "$have_clock_monotonic" = yes; then
+
+printf "%s\n" "#define HAVE_CLOCK_MONOTONIC 1" >>confdefs.h
+
+fi
+
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for optreset" >&5
 printf %s "checking for optreset... " >&6; }
 if test ${ac_cv_have_optreset+y}
diff --git a/configure.ac b/configure.ac
index bdd5f1f69d267d..051161c5848072 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1452,6 +1452,25 @@ then
 	AC_DEFINE_UNQUOTED(FUSE_USE_VERSION, $FUSE_USE_VERSION,
 		[Define to the version of FUSE to use])
 fi
+dnl
+dnl see if CLOCK_MONOTONIC exists
+dnl
+AC_MSG_CHECKING(for CLOCK_MONOTONIC)
+AC_LINK_IFELSE(
+[	AC_LANG_PROGRAM([[
+#define _GNU_SOURCE
+#include <time.h>
+	]], [[
+struct timespec nuts;
+clock_gettime(CLOCK_MONOTONIC, &nuts);
+	]])
+], have_clock_monotonic=yes
+   AC_MSG_RESULT(yes),
+   AC_MSG_RESULT(no))
+if test "$have_clock_monotonic" = yes; then
+  AC_DEFINE(HAVE_CLOCK_MONOTONIC, 1, [Define to 1 if CLOCK_MONOTONIC is present])
+fi
+
 dnl
 dnl See if optreset exists
 dnl
diff --git a/lib/config.h.in b/lib/config.h.in
index 480717abd9b4be..364d6e865b7115 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -683,4 +683,7 @@
 /* Define for large files, on AIX-style hosts. */
 #undef _LARGE_FILES
 
+/* Define to 1 if CLOCK_MONOTONIC is present */
+#undef HAVE_CLOCK_MONOTONIC
+
 #include <dirpaths.h>
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9d50ebb6d08f8a..9db0b17af27438 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -166,6 +166,12 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 		fflush(stderr); \
 	} while (0)
 
+#define timing_printf(fuse2fs, format, ...) \
+	while ((fuse2fs)->timing) { \
+		printf("FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
+		break; \
+	}
+
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 # ifdef _IOR
 #  ifdef _IOW
@@ -246,6 +252,13 @@ struct fuse2fs {
 	struct bthread *mmp_thread;
 	unsigned int mmp_update_interval;
 #endif
+#ifdef HAVE_CLOCK_MONOTONIC
+	double lock_start_time;
+	double op_start_time;
+
+	/* options set by fuse_opt_parse must be of type int */
+	int timing;
+#endif
 };
 
 #define FUSE2FS_CHECK_HANDLE(ff, fh) \
@@ -494,13 +507,38 @@ static inline errcode_t fuse2fs_write_inode(ext2_filsys fs, ext2_ino_t ino,
 
 static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
 {
-	pthread_mutex_lock(&ff->bfl);
+	if (ff->timing) {
+		double lock_time = gettime_monotonic();
+
+		pthread_mutex_lock(&ff->bfl);
+
+		ff->op_start_time = gettime_monotonic();
+		ff->lock_start_time = lock_time;
+	} else {
+		pthread_mutex_lock(&ff->bfl);
+	}
+
 	return ff->fs;
 }
 
+static inline void fuse2fs_finish_timing(struct fuse2fs *ff, const char *func)
+{
+	double now;
+
+	if (!ff->timing)
+		return;
+
+	now = gettime_monotonic();
+
+	timing_printf(ff, "%s: lock=%.2fms elapsed=%.2fms\n", func,
+		      (ff->op_start_time - ff->lock_start_time) * 1000.0,
+		      (now - ff->op_start_time) * 1000.0);
+}
+
 static inline void __fuse2fs_finish(struct fuse2fs *ff, int ret,
 				    const char *func)
 {
+	fuse2fs_finish_timing(ff, func);
 	if (ret)
 		dbg_printf(ff, "%s: libfuse ret=%d\n", func, ret);
 	pthread_mutex_unlock(&ff->bfl);
@@ -4959,6 +4997,9 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("acl",		acl,			1),
 	FUSE2FS_OPT("noacl",		acl,			0),
 	FUSE2FS_OPT("lockfile=%s",	lockfile,		0),
+#ifdef HAVE_CLOCK_MONOTONIC
+	FUSE2FS_OPT("timing",		timing,			1),
+#endif
 
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),


