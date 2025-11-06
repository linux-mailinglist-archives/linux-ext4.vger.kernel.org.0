Return-Path: <linux-ext4+bounces-11605-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FCFC3DA7C
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D681883683
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6234C80D;
	Thu,  6 Nov 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJLd96e0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373102F657E
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469000; cv=none; b=cisy2QJDNCofL+i7Tc6bHC4p7CCGE8spbB3eHQHtB1q+1jXnqbD6FTMQg6ZbfB4P0CKMIksctkr8rqMs24J66mFozGa9YL22USanJ0cC+z+5hDIMLUVTEOMqbJLLrRg/O83B6RXBWFSw9islZlZcw6yyqTRvO24m4EacDso53E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469000; c=relaxed/simple;
	bh=mqVT+J4s5W6pLtE6HK231dutWmugC8kzOL9yNhprJDU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs25+Ol9fF4TuYHkZGtR+lFNEfActFDGWiizNNWx/4RZSLEpATJfIz1xfeS+yA/ejGtWU/ysjGavJMVF9fs44TvyY/KRUAI1tNN5g6fDaHjlDJ6zM9wAjCMMRAmBI02TihDoOf9YuIn5z2Kf5suCRKsIKTCqwYL8ffrUgLXzUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJLd96e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE27DC116C6;
	Thu,  6 Nov 2025 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469000;
	bh=mqVT+J4s5W6pLtE6HK231dutWmugC8kzOL9yNhprJDU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PJLd96e0i2d7nWSfH3VWZkrRl7hzH+aclVu1qoZm4A9A34Sk7i0b85VtArR2pIbx4
	 l+uilZKtUsbQ5/cY5i/1lwWdJms9p9ktKS28VQnQ72EMSqufLRUTMuh0qevplbgvXI
	 YyCoQN6bkKo9/t2k1I4DKf6UxjSSJNFEllOlMWSGi9vRUP9oWcaHD1QQAR0xrunVHI
	 twX1hhl9ZbqZsPpAIrDZtdhRwD147ylXv8m55NBZiutkXXLUc9R1b6g8tZF0mH1rpa
	 SkSIOzueeB3bl/cAvcwLuhbWwgdeblp89noMIV6obiq8lFV3R9nXkEtVg/khSZgmtX
	 MYPMT3m6bN2pg==
Date: Thu, 06 Nov 2025 14:43:19 -0800
Subject: [PATCH 01/23] fuse2fs: separate libfuse3 and fuse2fs detection in
 configure
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795583.2864310.11201479798892316197.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Separate the detection of libfuse and fuse2fs so that we can add another
fuse server (fuse4fs) without tangling it up in --disable-fuse2fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure        |  301 +++++++++++++-----------------------------------------
 configure.ac     |   79 ++++++++------
 misc/Makefile.in |    6 +
 3 files changed, 116 insertions(+), 270 deletions(-)


diff --git a/configure b/configure
index 86c9bc77321eee..22031343f078ab 100755
--- a/configure
+++ b/configure
@@ -701,7 +701,7 @@ gcc_ranlib
 gcc_ar
 UNI_DIFF_OPTS
 SEM_INIT_LIB
-FUSE_CMT
+FUSE2FS_CMT
 FUSE_LIB
 fuse3_LIBS
 fuse3_CFLAGS
@@ -14052,214 +14052,8 @@ then :
 fi
 
 
-FUSE_CMT=
+
 FUSE_LIB=
-# Check whether --enable-fuse2fs was given.
-if test ${enable_fuse2fs+y}
-then :
-  enableval=$enable_fuse2fs;
-	if test "$enableval" = "no"
-	then
-		FUSE_CMT="#"
-		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling fuse2fs" >&5
-printf "%s\n" "Disabling fuse2fs" >&6; }
-	else
-		cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-#ifdef __linux__
-	#include <linux/fs.h>
-	#include <linux/falloc.h>
-	#include <linux/xattr.h>
-	#endif
-
-int
-main (void)
-{
-
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_cpp "$LINENO"
-then :
-
-else $as_nop
-  { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
-printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
-as_fn_error $? "Cannot find fuse2fs Linux headers.
-See \`config.log' for more details" "$LINENO" 5; }
-fi
-rm -f conftest.err conftest.i conftest.$ac_ext
-
-
-pkg_failed=no
-{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse3" >&5
-printf %s "checking for fuse3... " >&6; }
-
-if test -n "$fuse3_CFLAGS"; then
-    pkg_cv_fuse3_CFLAGS="$fuse3_CFLAGS"
- elif test -n "$PKG_CONFIG"; then
-    if test -n "$PKG_CONFIG" && \
-    { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"fuse3\""; } >&5
-  ($PKG_CONFIG --exists --print-errors "fuse3") 2>&5
-  ac_status=$?
-  printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
-  test $ac_status = 0; }; then
-  pkg_cv_fuse3_CFLAGS=`$PKG_CONFIG --cflags "fuse3" 2>/dev/null`
-		      test "x$?" != "x0" && pkg_failed=yes
-else
-  pkg_failed=yes
-fi
- else
-    pkg_failed=untried
-fi
-if test -n "$fuse3_LIBS"; then
-    pkg_cv_fuse3_LIBS="$fuse3_LIBS"
- elif test -n "$PKG_CONFIG"; then
-    if test -n "$PKG_CONFIG" && \
-    { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"fuse3\""; } >&5
-  ($PKG_CONFIG --exists --print-errors "fuse3") 2>&5
-  ac_status=$?
-  printf "%s\n" "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
-  test $ac_status = 0; }; then
-  pkg_cv_fuse3_LIBS=`$PKG_CONFIG --libs "fuse3" 2>/dev/null`
-		      test "x$?" != "x0" && pkg_failed=yes
-else
-  pkg_failed=yes
-fi
- else
-    pkg_failed=untried
-fi
-
-
-
-if test $pkg_failed = yes; then
-        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
-printf "%s\n" "no" >&6; }
-
-if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
-        _pkg_short_errors_supported=yes
-else
-        _pkg_short_errors_supported=no
-fi
-        if test $_pkg_short_errors_supported = yes; then
-                fuse3_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "fuse3" 2>&1`
-        else
-                fuse3_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "fuse3" 2>&1`
-        fi
-        # Put the nasty error message in config.log where it belongs
-        echo "$fuse3_PKG_ERRORS" >&5
-
-
-			{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
-printf %s "checking for fuse_main in -losxfuse... " >&6; }
-if test ${ac_cv_lib_osxfuse_fuse_main+y}
-then :
-  printf %s "(cached) " >&6
-else $as_nop
-  ac_check_lib_save_LIBS=$LIBS
-LIBS="-losxfuse  $LIBS"
-cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-/* Override any GCC internal prototype to avoid an error.
-   Use char because int might match the return type of a GCC
-   builtin and then its argument prototype would still apply.  */
-char fuse_main ();
-int
-main (void)
-{
-return fuse_main ();
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_link "$LINENO"
-then :
-  ac_cv_lib_osxfuse_fuse_main=yes
-else $as_nop
-  ac_cv_lib_osxfuse_fuse_main=no
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.beam \
-    conftest$ac_exeext conftest.$ac_ext
-LIBS=$ac_check_lib_save_LIBS
-fi
-{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_osxfuse_fuse_main" >&5
-printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
-if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
-then :
-  FUSE_LIB=-losxfuse
-else $as_nop
-  { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
-printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
-as_fn_error $? "Cannot find fuse library.
-See \`config.log' for more details" "$LINENO" 5; }
-fi
-
-
-elif test $pkg_failed = untried; then
-        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
-printf "%s\n" "no" >&6; }
-
-			{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
-printf %s "checking for fuse_main in -losxfuse... " >&6; }
-if test ${ac_cv_lib_osxfuse_fuse_main+y}
-then :
-  printf %s "(cached) " >&6
-else $as_nop
-  ac_check_lib_save_LIBS=$LIBS
-LIBS="-losxfuse  $LIBS"
-cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
-
-/* Override any GCC internal prototype to avoid an error.
-   Use char because int might match the return type of a GCC
-   builtin and then its argument prototype would still apply.  */
-char fuse_main ();
-int
-main (void)
-{
-return fuse_main ();
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_link "$LINENO"
-then :
-  ac_cv_lib_osxfuse_fuse_main=yes
-else $as_nop
-  ac_cv_lib_osxfuse_fuse_main=no
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.beam \
-    conftest$ac_exeext conftest.$ac_ext
-LIBS=$ac_check_lib_save_LIBS
-fi
-{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_osxfuse_fuse_main" >&5
-printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
-if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
-then :
-  FUSE_LIB=-losxfuse
-else $as_nop
-  { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
-printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
-as_fn_error $? "Cannot find fuse library.
-See \`config.log' for more details" "$LINENO" 5; }
-fi
-
-
-else
-        fuse3_CFLAGS=$pkg_cv_fuse3_CFLAGS
-        fuse3_LIBS=$pkg_cv_fuse3_LIBS
-        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-printf "%s\n" "yes" >&6; }
-        FUSE_LIB=-lfuse3
-fi
-		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs" >&5
-printf "%s\n" "Enabling fuse2fs" >&6; }
-	fi
-
-else $as_nop
-
 
 pkg_failed=no
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse3" >&5
@@ -14320,7 +14114,7 @@ fi
         echo "$fuse3_PKG_ERRORS" >&5
 
 
-		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
+	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
 printf %s "checking for fuse_main in -losxfuse... " >&6; }
 if test ${ac_cv_lib_osxfuse_fuse_main+y}
 then :
@@ -14358,8 +14152,6 @@ printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
 if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
 then :
   FUSE_LIB=-losxfuse
-else $as_nop
-  FUSE_CMT="#"
 fi
 
 
@@ -14367,7 +14159,7 @@ elif test $pkg_failed = untried; then
         { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
 printf "%s\n" "no" >&6; }
 
-		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
+	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
 printf %s "checking for fuse_main in -losxfuse... " >&6; }
 if test ${ac_cv_lib_osxfuse_fuse_main+y}
 then :
@@ -14405,8 +14197,6 @@ printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
 if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
 then :
   FUSE_LIB=-losxfuse
-else $as_nop
-  FUSE_CMT="#"
 fi
 
 
@@ -14417,15 +14207,6 @@ else
 printf "%s\n" "yes" >&6; }
         FUSE_LIB=-lfuse3
 fi
-	if test -z "$FUSE_CMT"
-	then
-		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs by default." >&5
-printf "%s\n" "Enabling fuse2fs by default." >&6; }
-	fi
-
-
-fi
-
 
 
 if test -n "$FUSE_LIB"
@@ -14437,12 +14218,7 @@ then
 do :
   as_ac_Header=`printf "%s\n" "ac_cv_header_$ac_header" | $as_tr_sh`
 ac_fn_c_check_header_compile "$LINENO" "$ac_header" "$as_ac_Header" "#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 314
-#ifdef __linux__
-#include <linux/fs.h>
-#include <linux/falloc.h>
-#include <linux/xattr.h>
-#endif
+#define FUSE_USE_VERSION	314
 "
 if eval test \"x\$"$as_ac_Header"\" = x"yes"
 then :
@@ -14453,7 +14229,7 @@ _ACEOF
 else $as_nop
   { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
 printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
-as_fn_error $? "Cannot find fuse3 fuse2fs headers.
+as_fn_error $? "Cannot build against fuse3 headers
 See \`config.log' for more details" "$LINENO" 5; }
 fi
 
@@ -14466,6 +14242,71 @@ printf "%s\n" "#define FUSE_USE_VERSION $FUSE_USE_VERSION" >>confdefs.h
 
 fi
 
+FUSE2FS_CMT=
+# Check whether --enable-fuse2fs was given.
+if test ${enable_fuse2fs+y}
+then :
+  enableval=$enable_fuse2fs;
+	if test "$enableval" = "no"
+	then
+		FUSE2FS_CMT="#"
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling fuse2fs" >&5
+printf "%s\n" "Disabling fuse2fs" >&6; }
+	else
+		cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+#ifdef __linux__
+	#include <linux/fs.h>
+	#include <linux/falloc.h>
+	#include <linux/xattr.h>
+	#endif
+
+int
+main (void)
+{
+
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_cpp "$LINENO"
+then :
+
+else $as_nop
+  { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "Cannot find fuse2fs Linux headers
+See \`config.log' for more details" "$LINENO" 5; }
+fi
+rm -f conftest.err conftest.i conftest.$ac_ext
+
+		if test -z "$FUSE_USE_VERSION"
+		then
+			{ { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "Cannot find fuse library.
+See \`config.log' for more details" "$LINENO" 5; }
+		fi
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs" >&5
+printf "%s\n" "Enabling fuse2fs" >&6; }
+	fi
+
+else $as_nop
+
+	if test -n "$FUSE_USE_VERSION"
+	then
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs by default" >&5
+printf "%s\n" "Enabling fuse2fs by default" >&6; }
+	else
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling fuse2fs by default" >&5
+printf "%s\n" "Disabling fuse2fs by default" >&6; }
+	fi
+
+
+fi
+
+
+
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for PR_SET_IO_FLUSHER" >&5
 printf %s "checking for PR_SET_IO_FLUSHER... " >&6; }
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
diff --git a/configure.ac b/configure.ac
index bf1b57377cd848..b40ed1456d1515 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1366,18 +1366,48 @@ dnl Check to see if librt is required for clock_gettime() (glibc < 2.17)
 dnl
 AC_CHECK_LIB(rt, clock_gettime, [CLOCK_GETTIME_LIB=-lrt])
 AC_SUBST(CLOCK_GETTIME_LIB)
+
 dnl
 dnl Check to see if the FUSE library is -lfuse3 or -losxfuse
 dnl
-FUSE_CMT=
 FUSE_LIB=
 dnl osxfuse.dylib supersedes fuselib.dylib
+PKG_CHECK_MODULES([fuse3], [fuse3], [FUSE_LIB=-lfuse3],
+[
+	AC_CHECK_LIB(osxfuse, fuse_main, [FUSE_LIB=-losxfuse])
+])
+AC_SUBST(FUSE_LIB)
+
+dnl
+dnl Set FUSE_USE_VERSION, which is how fuse servers build against a particular
+dnl libfuse ABI.  Currently we link against the libfuse 3.14 ABI (hence 314)
+dnl
+if test -n "$FUSE_LIB"
+then
+	FUSE_USE_VERSION=314
+	CFLAGS="$fuse3_CFLAGS $CFLAGS"
+	FUSE_LIB="$fuse3_LIBS"
+	AC_CHECK_HEADERS([pthread.h fuse.h], [],
+		[AC_MSG_FAILURE([Cannot build against fuse3 headers])],
+[#define _FILE_OFFSET_BITS	64
+#define FUSE_USE_VERSION	314])
+fi
+if test -n "$FUSE_USE_VERSION"
+then
+	AC_DEFINE_UNQUOTED(FUSE_USE_VERSION, $FUSE_USE_VERSION,
+		[Define to the version of FUSE to use])
+fi
+
+dnl
+dnl Check if fuse2fs is actually built.
+dnl
+FUSE2FS_CMT=
 AC_ARG_ENABLE([fuse2fs],
 AS_HELP_STRING([--disable-fuse2fs],[do not build fuse2fs]),
 [
 	if test "$enableval" = "no"
 	then
-		FUSE_CMT="#"
+		FUSE2FS_CMT="#"
 		AC_MSG_RESULT([Disabling fuse2fs])
 	else
 		AC_PREPROC_IFELSE(
@@ -1386,49 +1416,24 @@ AS_HELP_STRING([--disable-fuse2fs],[do not build fuse2fs]),
 	#include <linux/falloc.h>
 	#include <linux/xattr.h>
 	#endif
-	]], [])], [], [AC_MSG_FAILURE([Cannot find fuse2fs Linux headers.])])
+	]], [])], [], [AC_MSG_FAILURE([Cannot find fuse2fs Linux headers])])
 
-		PKG_CHECK_MODULES([fuse3], [fuse3], [FUSE_LIB=-lfuse3],
-		[
-			AC_CHECK_LIB(osxfuse, fuse_main, [FUSE_LIB=-losxfuse],
-				[AC_MSG_FAILURE([Cannot find fuse library.])])
-		])
+		if test -z "$FUSE_USE_VERSION"
+		then
+			AC_MSG_FAILURE([Cannot find fuse library.])
+		fi
 		AC_MSG_RESULT([Enabling fuse2fs])
 	fi
 ], [
-	PKG_CHECK_MODULES([fuse3], [fuse3], [FUSE_LIB=-lfuse3],
-	[
-		AC_CHECK_LIB(osxfuse, fuse_main, [FUSE_LIB=-losxfuse],
-			[FUSE_CMT="#"])
-	])
-	if test -z "$FUSE_CMT"
+	if test -n "$FUSE_USE_VERSION"
 	then
-		AC_MSG_RESULT([Enabling fuse2fs by default.])
+		AC_MSG_RESULT([Enabling fuse2fs by default])
+	else
+		AC_MSG_RESULT([Disabling fuse2fs by default])
 	fi
 ]
 )
-AC_SUBST(FUSE_LIB)
-AC_SUBST(FUSE_CMT)
-if test -n "$FUSE_LIB"
-then
-	FUSE_USE_VERSION=314
-	CFLAGS="$fuse3_CFLAGS $CFLAGS"
-	FUSE_LIB="$fuse3_LIBS"
-	AC_CHECK_HEADERS([pthread.h fuse.h], [],
-		[AC_MSG_FAILURE([Cannot find fuse3 fuse2fs headers.])],
-[#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 314
-#ifdef __linux__
-#include <linux/fs.h>
-#include <linux/falloc.h>
-#include <linux/xattr.h>
-#endif])
-fi
-if test -n "$FUSE_USE_VERSION"
-then
-	AC_DEFINE_UNQUOTED(FUSE_USE_VERSION, $FUSE_USE_VERSION,
-		[Define to the version of FUSE to use])
-fi
+AC_SUBST(FUSE2FS_CMT)
 
 dnl
 dnl see if PR_SET_IO_FLUSHER exists
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 0e3bed66dcb63d..b63a0424b19fec 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -34,7 +34,7 @@ MKDIR_P = @MKDIR_P@
 @BLKID_CMT@FINDFS_LINK= findfs
 @BLKID_CMT@FINDFS_MAN= findfs.8
 
-@FUSE_CMT@FUSE_PROG= fuse2fs
+@FUSE2FS_CMT@FUSE2FS_PROG= fuse2fs
 
 SPROGS=		mke2fs badblocks tune2fs dumpe2fs $(BLKID_PROG) logsave \
 			$(E2IMAGE_PROG) @FSCK_PROG@ e2undo
@@ -47,9 +47,9 @@ SMANPAGES=	tune2fs.8 mklost+found.8 mke2fs.8 dumpe2fs.8 badblocks.8 \
 			e2mmpstatus.8
 FMANPAGES=	mke2fs.conf.5 ext4.5
 
-UPROGS=		chattr lsattr $(FUSE_PROG) @UUID_CMT@ uuidgen
+UPROGS=		chattr lsattr $(FUSE2FS_PROG) @UUID_CMT@ uuidgen
 UMANPAGES=	chattr.1 lsattr.1 @UUID_CMT@ uuidgen.1
-UMANPAGES+=	@FUSE_CMT@ fuse2fs.1
+UMANPAGES+=	@FUSE2FS_CMT@ fuse2fs.1
 
 LPROGS=		@E2INITRD_PROG@
 


