Return-Path: <linux-ext4+bounces-10099-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF9EB588C9
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF7B188CE87
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A13F1F5EA;
	Tue, 16 Sep 2025 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtvtpCyV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E89F507
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981026; cv=none; b=PNXHLvwIK2wqSlT1mCQ+TmeMD03Avy9Sn3Mx5SWhJ1CENk0P7KHecfW9jQfNOi/95HHaybQgoviG38WdQQ9LrVjiwqkoZC7LwKzYdeCb/F/xSCpLTKLHXIFTt/i9n61ssqvIA629WxxirVYeT6zXsmcMLHymm/ybGJDCZ+0F0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981026; c=relaxed/simple;
	bh=n3sucTDWX/MLlvNkSkikaDIPMLqf0QVud24vojnk7Zs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYvO8Hs+m9W+rgmS1XTkcuLWgdRq96gMyUn75yQYGvFLaZTtck+AXwLg8p5oqYtZ7nbgP1q2I9g0FqqIvrX0YEp5mk+dFZBxrQ/mgNyIs4FgJ2f0GzeSJgcJYkjho7FKP8LlSz4aYxVQTzk+FfTfvytle/m0KVABKEYL4DiZWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtvtpCyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11517C4CEF1;
	Tue, 16 Sep 2025 00:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981026;
	bh=n3sucTDWX/MLlvNkSkikaDIPMLqf0QVud24vojnk7Zs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mtvtpCyVL5N/0opTffZ2lZQTmx2yTBUQxDknEd7d+M8GfhI6b7+EUVroJBUxRWfqn
	 QAg7GMQiUzhOs1FVtVn5E6njzUU4W63fhrGKbxP33Xx+HfXzf/3+Ini+SGdBkY3zAi
	 S7MrbiWZOoNn5zl7lViHN4w9AKETcSBuXG32UPzxof1LmH6d+HZ89OoxTFAXZEDgPa
	 Ezdtz1FdVsoRFZltTfZYetUHwuLivazGznCxmqBk0AujC6wNwBrhosdmTchKHwc52j
	 aHDzfwmVhEeNADej8JvDoN3zrxyjolWVKdD+7g0+sZpZmiZj4H7fw8QDdTBp9WtSsq
	 c49Akh0Qo12oA==
Date: Mon, 15 Sep 2025 17:03:45 -0700
Subject: [PATCH 1/5] fuse2fs: register as an IO flusher thread
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064950.350149.13468735424117061402.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
References: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c  |   18 ++++++++++++++++++
 4 files changed, 77 insertions(+)


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
index 8cd4dc600888b9..1789fbf86c7578 100644
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
@@ -5212,6 +5213,23 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+#ifdef HAVE_PR_SET_IO_FLUSHER
+	/*
+	 * Register as a filesystem I/O server process so that our memory
+	 * allocations don't cause fs reclaim.
+	 */
+	ret = prctl(PR_GET_IO_FLUSHER, 0, 0, 0, 0);
+	if (ret == 0) {
+		ret = prctl(PR_SET_IO_FLUSHER, 1, 0, 0, 0);
+		if (ret < 0) {
+			err_printf(&fctx, "%s: %s.\n",
+ _("Could not register as IO flusher thread"),
+					strerror(errno));
+			ret = 0;
+		}
+	}
+#endif
+
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE2FS_ALLOC_ALL_BLOCKS")) {
 		log_printf(&fctx, "%s\n",


