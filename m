Return-Path: <linux-ext4+bounces-8129-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2392AC0003
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D223A6DC8
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A772192E3;
	Wed, 21 May 2025 22:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbDKATUu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA021EA65
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867680; cv=none; b=X7v2sHkApX6q4HKt+aK+tYiYhzG+7//yNiuoUS676f91O5D51p6NjwXx8jVVWqRA0RMrWZO0ZXqY001dIKj78lChrfgtNcvUQ2zFKIY+JialfIn8gdSvbHlhRsMX6fpjFvHv/H+AczcT/IVX0i3hUjGASBN2ksgrU5vixTyovdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867680; c=relaxed/simple;
	bh=XWtnuTjCaBIPX6cia6zIaCEQ5m4RVHJgJiG4cDVMjbY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMtRVltVE6ST/0SyFvmauZwhgxKSXbW/ygYl5/5lmB+LeMqLHuVPhmG6AYCW/7xJD7qf55xLbrUVoEXjuVlpAZcHZW0+tctOqIw9q36nndBA4wLezfD36oAwVzg+GP3Vp4SEaLM7dro9SWl7jQfzKurR6hI8TCOGdhIRxewHoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbDKATUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DAFC4CEE4;
	Wed, 21 May 2025 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867680;
	bh=XWtnuTjCaBIPX6cia6zIaCEQ5m4RVHJgJiG4cDVMjbY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NbDKATUuIGI6JHq11OXTSXOuTVxgANGhFADk4ls2AI8JNxilSY6WdW9O/JfQkI8C7
	 YFqAM+oykJC/UQ76GHeVqJ5cOX8Yq8x40AFACRrR0J7tV2jaiSdpl+k0HUHCQWQ/Le
	 vBcvOeQ9j6uAZvIgBzM+pPimrD8Afi8hHy6Kk6Zzua+jM1em2fKPYz09aTrDc8t8Aj
	 hkWu1bh6hUx+iET244K/f6yAYg8s7u3+yDby72t5gciICZBEp8f3JBKsbQxxLF2vmQ
	 K8exbvZZ1CRYyjxAPaLXgApd/r7/p2N5baopHOHhIndA6DJUe52C4/MBfxw14V7nSi
	 o4PVZoXkmsRXw==
Date: Wed, 21 May 2025 15:47:59 -0700
Subject: [PATCH 1/4] fuse2fs: register as an IO flusher thread
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786679023.1385778.14264885297965601500.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678990.1385778.5352134289344525189.stgit@frogsfrogsfrogs>
References: <174786678990.1385778.5352134289344525189.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c  |   15 +++++++++++++++
 4 files changed, 74 insertions(+)


diff --git a/configure b/configure
index f9a7aa4e2e864c..dfc6bb4a5daa2e 100755
--- a/configure
+++ b/configure
@@ -14551,6 +14551,43 @@ then
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
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for optreset" >&5
 printf %s "checking for optreset... " >&6; }
 if test ${ac_cv_have_optreset+y}
diff --git a/configure.ac b/configure.ac
index 1f67604036b528..7f28701534a905 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1434,6 +1434,25 @@ then
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
 dnl See if optreset exists
 dnl
diff --git a/lib/config.h.in b/lib/config.h.in
index 819c4331379247..6cd9751baab9d1 100644
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
index 51f703267462b4..cbe9afd4ba1290 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -17,6 +17,7 @@
 # include <linux/fs.h>
 # include <linux/falloc.h>
 # include <linux/xattr.h>
+# include <sys/prctl.h>
 #endif
 #include <sys/ioctl.h>
 #include <unistd.h>
@@ -4792,6 +4793,20 @@ int main(int argc, char *argv[])
 		}
 	}
 
+#ifdef HAVE_PR_SET_IO_FLUSHER
+	/*
+	 * Register as a filesystem I/O server process so that our memory
+	 * allocations don't cause fs reclaim.
+	 */
+	ret = prctl(PR_SET_IO_FLUSHER, 1, 0, 0, 0);
+	if (ret < 0) {
+		err_printf(&fctx, "%s: %s.\n",
+ _("Could not register as IO flusher thread"),
+				strerror(errno));
+		ret = 0;
+	}
+#endif
+
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE2FS_ALLOC_ALL_BLOCKS")) {
 		log_printf(&fctx, "%s\n",


