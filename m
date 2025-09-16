Return-Path: <linux-ext4+bounces-10090-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF206B588BB
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623551635D1
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104962AD02;
	Tue, 16 Sep 2025 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrsmvYxp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4343E571
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980884; cv=none; b=Ed4Ofvz7f2oPycXMvl/2vz/pff0/g722oH/UTvuVp1L1rFSFOH3T++1YG9UQ1f8ARiQe3b0qZiefBlxc+UXrvNBuIWImCDvpgCeC061WKUUoyG2+8URywoknPp/sbDds5qwhVe3zXEOYjkT0Xn5JiuvB+c8l5VeJdGdvUqFoXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980884; c=relaxed/simple;
	bh=N9mTWu4YeR3ZGKH06fdUfjnv4LhB23kjbobraueoAYg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6a+T4gW+NZxypbN8O7DjLw4jIRgjF4LKr9ohBHC1c1/4BuXoyrDJnIv2hTNbnXy/VR2Xb+tQzve6XskFZIJcfuH0hHGUZw6F6FG/OPywcAceb5PiWcVqSAigjAWvH1bdguAasS3jnrjO8Sfxjh4fkTwdt7QewOFiHlKaM3LdV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrsmvYxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A50C4CEF1;
	Tue, 16 Sep 2025 00:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980884;
	bh=N9mTWu4YeR3ZGKH06fdUfjnv4LhB23kjbobraueoAYg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TrsmvYxp3mEAPr3iTJKAZH2WH4ornNvjvmiolRnyfT6v4VpJ6NMJdVoRlqXVjYiJx
	 EqTGZuNb5MAgx9cwSvhoYaaqg3vwZCMePpm5yd7SSsTpcWpe8CCAOV0EKHv/K9D3gz
	 DnQmmwLhe5m91BDf7AR8S4E6LqOd6sAv+0gE6tODsF2c07rDqXeohT9yS42xn60IxD
	 kL/XIL3r94zOdKAZJmXizP+yvtYzNSCBPwI4f18KW2vKD81gb2qiVLEE6xsyvKsSM9
	 /KtXSd9oE10vYWtG77/Zz9rbAd+k7jT2+4TPTa0o1ZSZ8E1A2eg12tjAU8D5FJc6y5
	 PtrKhmnhk1kcA==
Date: Mon, 15 Sep 2025 17:01:23 -0700
Subject: [PATCH 9/9] fuse2fs: collect runtime of various operations
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064257.349283.117227515811491401.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
References: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
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
 configure       |   37 +++++++++++++++++++++++++++++++
 configure.ac    |   19 ++++++++++++++++
 lib/config.h.in |    3 +++
 misc/fuse2fs.c  |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)


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
index 23420c23be240c..6255d960bd802f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -165,6 +165,12 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
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
@@ -240,6 +246,13 @@ struct fuse2fs {
 	unsigned int next_generation;
 	unsigned long long cache_size;
 	char *lockfile;
+#ifdef HAVE_CLOCK_MONOTONIC
+	struct timespec lock_start_time;
+	struct timespec op_start_time;
+
+	/* options set by fuse_opt_parse must be of type int */
+	int timing;
+#endif
 };
 
 #define FUSE2FS_CHECK_HANDLE(ff, fh) \
@@ -456,15 +469,64 @@ fuse2fs_set_handle(struct fuse_file_info *fp, struct fuse2fs_file_handle *fh)
 	fp->fh = (uintptr_t)fh;
 }
 
+#ifdef HAVE_CLOCK_MONOTONIC
 static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
 {
+	struct timespec lock_time;
+	int ret;
+
+	if (ff->timing)
+		clock_gettime(CLOCK_MONOTONIC, &lock_time);
+
 	pthread_mutex_lock(&ff->bfl);
+	if (ff->timing) {
+		ret = clock_gettime(CLOCK_MONOTONIC, &ff->op_start_time);
+		if (ret)
+			ff->timing = 0;
+		ff->lock_start_time = lock_time;
+	}
 	return ff->fs;
 }
 
+static inline double ms_from_timespec(const struct timespec *ts)
+{
+	return ((double)ts->tv_sec * 1000) + ((double)ts->tv_nsec / 1000000);
+}
+
+static inline void fuse2fs_finish_timing(struct fuse2fs *ff, const char *func)
+{
+	struct timespec now;
+	double lockf, startf, nowf;
+	int ret;
+
+	if (!ff->timing)
+		return;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &now);
+	if (ret) {
+		ff->timing = 0;
+		return;
+	}
+
+	lockf = ms_from_timespec(&ff->lock_start_time);
+	startf = ms_from_timespec(&ff->op_start_time);
+	nowf = ms_from_timespec(&now);
+	timing_printf(ff, "%s: lock=%.2fms elapsed=%.2fms\n", func,
+		      startf - lockf, nowf - startf);
+}
+#else
+static inline ext2_filsys fuse2fs_start(struct fuse2fs *ff)
+{
+	pthread_mutex_lock(&ff->bfl);
+	return ff->fs;
+}
+# define fuse2fs_finish_timing(...)	((void)0)
+#endif
+
 static inline void __fuse2fs_finish(struct fuse2fs *ff, int ret,
 				    const char *func)
 {
+	fuse2fs_finish_timing(ff, func);
 	if (ret)
 		dbg_printf(ff, "%s: libfuse ret=%d\n", func, ret);
 	pthread_mutex_unlock(&ff->bfl);
@@ -4687,6 +4749,9 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("acl",		acl,			1),
 	FUSE2FS_OPT("noacl",		acl,			0),
 	FUSE2FS_OPT("lockfile=%s",	lockfile,		0),
+#ifdef HAVE_CLOCK_MONOTONIC
+	FUSE2FS_OPT("timing",		timing,			1),
+#endif
 
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),


