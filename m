Return-Path: <linux-ext4+bounces-10120-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15CB58A16
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEADF3BAAEA
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291F14B950;
	Tue, 16 Sep 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lprVBIz9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547D1CD2C
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983839; cv=none; b=cnQihBdYB4mDhQVyYAB9obIKscs1QlwyL5ealAOI79LEoHyr+WZG1KVdwnZe/kD4UnVNCgqae4Fspk7pC1YDuH6+cwR+mPGpzUUJazE9vuLZiQq2QqutJWiAS56Yone0AwgnwCrPlIuJKLtkQNVzl8OI0HdWgVS1wx+WNRq2VUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983839; c=relaxed/simple;
	bh=VbYv3itaGqtEbT/iKqRVqukbMrgyOSc2rFeauKdVwWs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHjFisWrQAictfm/TeG75APfSxHcKvCgH4G+75mB4rHPZuH7apAsE80okn5LgaX2wlJJDVX/117Hy9oXcQOhgXBSSRSyzQTnEOn7Cveue0QE5OKJxtSGy8PW3L/wrWG6WBZbivOzblAMFzPitCSOV+2Dl8dIc7d3i6BHOdIgAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lprVBIz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730F7C4CEF1;
	Tue, 16 Sep 2025 00:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983839;
	bh=VbYv3itaGqtEbT/iKqRVqukbMrgyOSc2rFeauKdVwWs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lprVBIz9lrJfvcopWtndS551fP/UZwTu2X0xGnlYM2Ayi+eQeB+F8xbendrIGyafx
	 6Slis5kwsCiZiqFYHprohmeb2u6ENsQwUr6P0Se4WD4X2/Gi6JKvvjkRnhqwmgEiTG
	 DTuoR7JtC/PW5Je3Bivh8bfHYikfmgamWe1a4jG53s26dmtS8M0zBP3k1Wjtq89/BF
	 S1yAJiDl9fGstUB+gkT8FzkMi2+Nz4+0oH+CqsFlKgSlc+kAwUgWSjCmPaFyXlhmul
	 Yk57/WuO3JjZx770ANFgTg3DNTEt6IuyTRRcXwzn3r3Du6oOTbCvAMgqH/liCMFGHo
	 ggUem2oK2RXtg==
Date: Mon, 15 Sep 2025 17:50:38 -0700
Subject: [PATCH 4/4] fuse2fs: drop fuse 2.x support code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, linux-ext4@vger.kernel.org
Message-ID: <175798160547.389044.2317848945710539691.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
References: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

We only enable fuse2fs if libfuse is from the 3.xx series and the lowlevel
libfuse API is present.  Drop support for 2.x.  This part is cribbed from Amir
who used an LLM aided conversion for fuse4fs, but the maintainer requested that
I apply it to fuse2fs as well.

Co-developed-by: Claude claude-4-sonnet
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure      |  314 +++++---------------------------------------------------
 configure.ac   |   81 +++++---------
 misc/fuse2fs.c |  219 ++++-----------------------------------
 3 files changed, 80 insertions(+), 534 deletions(-)


diff --git a/configure b/configure
index 71750b1a8ee972..86c9bc77321eee 100755
--- a/configure
+++ b/configure
@@ -1676,6 +1676,9 @@ Some influential environment variables:
               C compiler flags for ARCHIVE, overriding pkg-config
   ARCHIVE_LIBS
               linker flags for ARCHIVE, overriding pkg-config
+  fuse3_CFLAGS
+              C compiler flags for fuse3, overriding pkg-config
+  fuse3_LIBS  linker flags for fuse3, overriding pkg-config
   CXX         C++ compiler command
   CXXFLAGS    C++ compiler flags
   udev_CFLAGS C compiler flags for udev, overriding pkg-config
@@ -14054,19 +14057,20 @@ FUSE_LIB=
 # Check whether --enable-fuse2fs was given.
 if test ${enable_fuse2fs+y}
 then :
-  enableval=$enable_fuse2fs; if test "$enableval" = "no"
-then
-	FUSE_CMT="#"
-	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling fuse2fs" >&5
+  enableval=$enable_fuse2fs;
+	if test "$enableval" = "no"
+	then
+		FUSE_CMT="#"
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling fuse2fs" >&5
 printf "%s\n" "Disabling fuse2fs" >&6; }
-else
-	cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+	else
+		cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
 #ifdef __linux__
-#include <linux/fs.h>
-#include <linux/falloc.h>
-#include <linux/xattr.h>
-#endif
+	#include <linux/fs.h>
+	#include <linux/falloc.h>
+	#include <linux/xattr.h>
+	#endif
 
 int
 main (void)
@@ -14087,9 +14091,6 @@ See \`config.log' for more details" "$LINENO" 5; }
 fi
 rm -f conftest.err conftest.i conftest.$ac_ext
 
-	  fuse3_CFLAGS
-              C compiler flags for fuse3, overriding pkg-config
-  fuse3_LIBS  linker flags for fuse3, overriding pkg-config
 
 pkg_failed=no
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse3" >&5
@@ -14150,28 +14151,7 @@ fi
         echo "$fuse3_PKG_ERRORS" >&5
 
 
-		       for ac_header in pthread.h fuse.h
-do :
-  as_ac_Header=`printf "%s\n" "ac_cv_header_$ac_header" | $as_tr_sh`
-ac_fn_c_check_header_compile "$LINENO" "$ac_header" "$as_ac_Header" "#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 29
-"
-if eval test \"x\$"$as_ac_Header"\" = x"yes"
-then :
-  cat >>confdefs.h <<_ACEOF
-#define `printf "%s\n" "HAVE_$ac_header" | $as_tr_cpp` 1
-_ACEOF
-
-else $as_nop
-  { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
-printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
-as_fn_error $? "Cannot find fuse2fs headers.
-See \`config.log' for more details" "$LINENO" 5; }
-fi
-
-done
-
-		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
+			{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
 printf %s "checking for fuse_main in -losxfuse... " >&6; }
 if test ${ac_cv_lib_osxfuse_fuse_main+y}
 then :
@@ -14209,45 +14189,6 @@ printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
 if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
 then :
   FUSE_LIB=-losxfuse
-else $as_nop
-  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -lfuse" >&5
-printf %s "checking for fuse_main in -lfuse... " >&6; }
-if test ${ac_cv_lib_fuse_fuse_main+y}
-then :
-  printf %s "(cached) " >&6
-else $as_nop
-  ac_check_lib_save_LIBS=$LIBS
-LIBS="-lfuse  $LIBS"
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
-  ac_cv_lib_fuse_fuse_main=yes
-else $as_nop
-  ac_cv_lib_fuse_fuse_main=no
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.beam \
-    conftest$ac_exeext conftest.$ac_ext
-LIBS=$ac_check_lib_save_LIBS
-fi
-{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_fuse_fuse_main" >&5
-printf "%s\n" "$ac_cv_lib_fuse_fuse_main" >&6; }
-if test "x$ac_cv_lib_fuse_fuse_main" = xyes
-then :
-  FUSE_LIB=-lfuse
 else $as_nop
   { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
 printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
@@ -14255,35 +14196,12 @@ as_fn_error $? "Cannot find fuse library.
 See \`config.log' for more details" "$LINENO" 5; }
 fi
 
-fi
-
 
 elif test $pkg_failed = untried; then
         { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
 printf "%s\n" "no" >&6; }
 
-		       for ac_header in pthread.h fuse.h
-do :
-  as_ac_Header=`printf "%s\n" "ac_cv_header_$ac_header" | $as_tr_sh`
-ac_fn_c_check_header_compile "$LINENO" "$ac_header" "$as_ac_Header" "#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 29
-"
-if eval test \"x\$"$as_ac_Header"\" = x"yes"
-then :
-  cat >>confdefs.h <<_ACEOF
-#define `printf "%s\n" "HAVE_$ac_header" | $as_tr_cpp` 1
-_ACEOF
-
-else $as_nop
-  { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
-printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
-as_fn_error $? "Cannot find fuse2fs headers.
-See \`config.log' for more details" "$LINENO" 5; }
-fi
-
-done
-
-		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
+			{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
 printf %s "checking for fuse_main in -losxfuse... " >&6; }
 if test ${ac_cv_lib_osxfuse_fuse_main+y}
 then :
@@ -14321,45 +14239,6 @@ printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
 if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
 then :
   FUSE_LIB=-losxfuse
-else $as_nop
-  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -lfuse" >&5
-printf %s "checking for fuse_main in -lfuse... " >&6; }
-if test ${ac_cv_lib_fuse_fuse_main+y}
-then :
-  printf %s "(cached) " >&6
-else $as_nop
-  ac_check_lib_save_LIBS=$LIBS
-LIBS="-lfuse  $LIBS"
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
-  ac_cv_lib_fuse_fuse_main=yes
-else $as_nop
-  ac_cv_lib_fuse_fuse_main=no
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.beam \
-    conftest$ac_exeext conftest.$ac_ext
-LIBS=$ac_check_lib_save_LIBS
-fi
-{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_fuse_fuse_main" >&5
-printf "%s\n" "$ac_cv_lib_fuse_fuse_main" >&6; }
-if test "x$ac_cv_lib_fuse_fuse_main" = xyes
-then :
-  FUSE_LIB=-lfuse
 else $as_nop
   { { printf "%s\n" "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
 printf "%s\n" "$as_me: error: in \`$ac_pwd':" >&2;}
@@ -14367,24 +14246,21 @@ as_fn_error $? "Cannot find fuse library.
 See \`config.log' for more details" "$LINENO" 5; }
 fi
 
-fi
-
 
 else
         fuse3_CFLAGS=$pkg_cv_fuse3_CFLAGS
         fuse3_LIBS=$pkg_cv_fuse3_LIBS
         { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
 printf "%s\n" "yes" >&6; }
-
-		FUSE_LIB=-lfuse3
-
+        FUSE_LIB=-lfuse3
 fi
-	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs" >&5
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs" >&5
 printf "%s\n" "Enabling fuse2fs" >&6; }
-fi
+	fi
 
 else $as_nop
 
+
 pkg_failed=no
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse3" >&5
 printf %s "checking for fuse3... " >&6; }
@@ -14444,30 +14320,6 @@ fi
         echo "$fuse3_PKG_ERRORS" >&5
 
 
-	       for ac_header in pthread.h fuse.h
-do :
-  as_ac_Header=`printf "%s\n" "ac_cv_header_$ac_header" | $as_tr_sh`
-ac_fn_c_check_header_compile "$LINENO" "$ac_header" "$as_ac_Header" "#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 29
-#ifdef __linux__
-# include <linux/fs.h>
-# include <linux/falloc.h>
-# include <linux/xattr.h>
-#endif
-"
-if eval test \"x\$"$as_ac_Header"\" = x"yes"
-then :
-  cat >>confdefs.h <<_ACEOF
-#define `printf "%s\n" "HAVE_$ac_header" | $as_tr_cpp` 1
-_ACEOF
-
-else $as_nop
-  FUSE_CMT="#"
-fi
-
-done
-	if test -z "$FUSE_CMT"
-	then
 		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
 printf %s "checking for fuse_main in -losxfuse... " >&6; }
 if test ${ac_cv_lib_osxfuse_fuse_main+y}
@@ -14506,81 +14358,15 @@ printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
 if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
 then :
   FUSE_LIB=-losxfuse
-else $as_nop
-  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -lfuse" >&5
-printf %s "checking for fuse_main in -lfuse... " >&6; }
-if test ${ac_cv_lib_fuse_fuse_main+y}
-then :
-  printf %s "(cached) " >&6
-else $as_nop
-  ac_check_lib_save_LIBS=$LIBS
-LIBS="-lfuse  $LIBS"
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
-  ac_cv_lib_fuse_fuse_main=yes
-else $as_nop
-  ac_cv_lib_fuse_fuse_main=no
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.beam \
-    conftest$ac_exeext conftest.$ac_ext
-LIBS=$ac_check_lib_save_LIBS
-fi
-{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_fuse_fuse_main" >&5
-printf "%s\n" "$ac_cv_lib_fuse_fuse_main" >&6; }
-if test "x$ac_cv_lib_fuse_fuse_main" = xyes
-then :
-  FUSE_LIB=-lfuse
 else $as_nop
   FUSE_CMT="#"
 fi
 
-fi
-
-	fi
 
 elif test $pkg_failed = untried; then
         { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
 printf "%s\n" "no" >&6; }
 
-	       for ac_header in pthread.h fuse.h
-do :
-  as_ac_Header=`printf "%s\n" "ac_cv_header_$ac_header" | $as_tr_sh`
-ac_fn_c_check_header_compile "$LINENO" "$ac_header" "$as_ac_Header" "#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 29
-#ifdef __linux__
-# include <linux/fs.h>
-# include <linux/falloc.h>
-# include <linux/xattr.h>
-#endif
-"
-if eval test \"x\$"$as_ac_Header"\" = x"yes"
-then :
-  cat >>confdefs.h <<_ACEOF
-#define `printf "%s\n" "HAVE_$ac_header" | $as_tr_cpp` 1
-_ACEOF
-
-else $as_nop
-  FUSE_CMT="#"
-fi
-
-done
-	if test -z "$FUSE_CMT"
-	then
 		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -losxfuse" >&5
 printf %s "checking for fuse_main in -losxfuse... " >&6; }
 if test ${ac_cv_lib_osxfuse_fuse_main+y}
@@ -14619,73 +14405,30 @@ printf "%s\n" "$ac_cv_lib_osxfuse_fuse_main" >&6; }
 if test "x$ac_cv_lib_osxfuse_fuse_main" = xyes
 then :
   FUSE_LIB=-losxfuse
-else $as_nop
-  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for fuse_main in -lfuse" >&5
-printf %s "checking for fuse_main in -lfuse... " >&6; }
-if test ${ac_cv_lib_fuse_fuse_main+y}
-then :
-  printf %s "(cached) " >&6
-else $as_nop
-  ac_check_lib_save_LIBS=$LIBS
-LIBS="-lfuse  $LIBS"
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
-  ac_cv_lib_fuse_fuse_main=yes
-else $as_nop
-  ac_cv_lib_fuse_fuse_main=no
-fi
-rm -f core conftest.err conftest.$ac_objext conftest.beam \
-    conftest$ac_exeext conftest.$ac_ext
-LIBS=$ac_check_lib_save_LIBS
-fi
-{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_fuse_fuse_main" >&5
-printf "%s\n" "$ac_cv_lib_fuse_fuse_main" >&6; }
-if test "x$ac_cv_lib_fuse_fuse_main" = xyes
-then :
-  FUSE_LIB=-lfuse
 else $as_nop
   FUSE_CMT="#"
 fi
 
-fi
-
-	fi
 
 else
         fuse3_CFLAGS=$pkg_cv_fuse3_CFLAGS
         fuse3_LIBS=$pkg_cv_fuse3_LIBS
         { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
 printf "%s\n" "yes" >&6; }
-
-	FUSE_LIB=-lfuse3
-
+        FUSE_LIB=-lfuse3
 fi
-if test -z "$FUSE_CMT"
-then
-	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs by default." >&5
+	if test -z "$FUSE_CMT"
+	then
+		{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling fuse2fs by default." >&5
 printf "%s\n" "Enabling fuse2fs by default." >&6; }
-fi
+	fi
+
 
 fi
 
 
 
-if test "$FUSE_LIB" = "-lfuse3"
+if test -n "$FUSE_LIB"
 then
 	FUSE_USE_VERSION=314
 	CFLAGS="$fuse3_CFLAGS $CFLAGS"
@@ -14715,9 +14458,6 @@ See \`config.log' for more details" "$LINENO" 5; }
 fi
 
 done
-elif test -n "$FUSE_LIB"
-then
-	FUSE_USE_VERSION=29
 fi
 if test -n "$FUSE_USE_VERSION"
 then
diff --git a/configure.ac b/configure.ac
index 0591999b52b019..bf1b57377cd848 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1367,69 +1367,49 @@ dnl
 AC_CHECK_LIB(rt, clock_gettime, [CLOCK_GETTIME_LIB=-lrt])
 AC_SUBST(CLOCK_GETTIME_LIB)
 dnl
-dnl Check to see if the FUSE library is -lfuse3, -losxfuse, or -lfuse
+dnl Check to see if the FUSE library is -lfuse3 or -losxfuse
 dnl
 FUSE_CMT=
 FUSE_LIB=
 dnl osxfuse.dylib supersedes fuselib.dylib
 AC_ARG_ENABLE([fuse2fs],
 AS_HELP_STRING([--disable-fuse2fs],[do not build fuse2fs]),
-if test "$enableval" = "no"
-then
-	FUSE_CMT="#"
-	AC_MSG_RESULT([Disabling fuse2fs])
-else
-	AC_PREPROC_IFELSE(
-[AC_LANG_PROGRAM([[#ifdef __linux__
-#include <linux/fs.h>
-#include <linux/falloc.h>
-#include <linux/xattr.h>
-#endif
-]], [])], [], [AC_MSG_FAILURE([Cannot find fuse2fs Linux headers.])])
-
-	PKG_CHECK_MODULES([fuse3], [fuse3],
-	  [
-		FUSE_LIB=-lfuse3
-	  ], [
-		AC_CHECK_HEADERS([pthread.h fuse.h], [],
-			[AC_MSG_FAILURE([Cannot find fuse2fs headers.])],
-[#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 29])
+[
+	if test "$enableval" = "no"
+	then
+		FUSE_CMT="#"
+		AC_MSG_RESULT([Disabling fuse2fs])
+	else
+		AC_PREPROC_IFELSE(
+	[AC_LANG_PROGRAM([[#ifdef __linux__
+	#include <linux/fs.h>
+	#include <linux/falloc.h>
+	#include <linux/xattr.h>
+	#endif
+	]], [])], [], [AC_MSG_FAILURE([Cannot find fuse2fs Linux headers.])])
 
+		PKG_CHECK_MODULES([fuse3], [fuse3], [FUSE_LIB=-lfuse3],
+		[
+			AC_CHECK_LIB(osxfuse, fuse_main, [FUSE_LIB=-losxfuse],
+				[AC_MSG_FAILURE([Cannot find fuse library.])])
+		])
+		AC_MSG_RESULT([Enabling fuse2fs])
+	fi
+], [
+	PKG_CHECK_MODULES([fuse3], [fuse3], [FUSE_LIB=-lfuse3],
+	[
 		AC_CHECK_LIB(osxfuse, fuse_main, [FUSE_LIB=-losxfuse],
-			[AC_CHECK_LIB(fuse, fuse_main, [FUSE_LIB=-lfuse],
-				[AC_MSG_FAILURE([Cannot find fuse library.])])])
-	  ])
-	AC_MSG_RESULT([Enabling fuse2fs])
-fi
-,
-PKG_CHECK_MODULES([fuse3], [fuse3],
-  [
-	FUSE_LIB=-lfuse3
-  ], [
-	AC_CHECK_HEADERS([pthread.h fuse.h], [], [FUSE_CMT="#"], 
-[#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 29
-#ifdef __linux__
-# include <linux/fs.h>
-# include <linux/falloc.h>
-# include <linux/xattr.h>
-#endif])
+			[FUSE_CMT="#"])
+	])
 	if test -z "$FUSE_CMT"
 	then
-		AC_CHECK_LIB(osxfuse, fuse_main, [FUSE_LIB=-losxfuse],
-			[AC_CHECK_LIB(fuse, fuse_main, [FUSE_LIB=-lfuse],
-				[FUSE_CMT="#"])])
+		AC_MSG_RESULT([Enabling fuse2fs by default.])
 	fi
-  ])
-if test -z "$FUSE_CMT"
-then
-	AC_MSG_RESULT([Enabling fuse2fs by default.])
-fi
+]
 )
 AC_SUBST(FUSE_LIB)
 AC_SUBST(FUSE_CMT)
-if test "$FUSE_LIB" = "-lfuse3"
+if test -n "$FUSE_LIB"
 then
 	FUSE_USE_VERSION=314
 	CFLAGS="$fuse3_CFLAGS $CFLAGS"
@@ -1443,9 +1423,6 @@ then
 #include <linux/falloc.h>
 #include <linux/xattr.h>
 #endif])
-elif test -n "$FUSE_LIB"
-then
-	FUSE_USE_VERSION=29
 fi
 if test -n "$FUSE_USE_VERSION"
 then
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e3a350462f25f3..6290d22f2b9658 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -48,15 +48,6 @@
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-# define FUSE_PLATFORM_OPTS	""
-#else
-# ifdef __linux__
-#  define FUSE_PLATFORM_OPTS	",use_ino,big_writes"
-# else
-#  define FUSE_PLATFORM_OPTS	",use_ino"
-# endif
-#endif
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -171,11 +162,9 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 		break; \
 	}
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
-# ifdef _IOR
-#  ifdef _IOW
-#   define SUPPORT_I_FLAGS
-#  endif
+#ifdef _IOR
+# ifdef _IOW
+#  define SUPPORT_I_FLAGS
 # endif
 #endif
 
@@ -1311,11 +1300,8 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 }
 #endif
 
-static void *op_init(struct fuse_conn_info *conn
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_config *cfg EXT2FS_ATTR((unused))
-#endif
-			)
+static void *op_init(struct fuse_conn_info *conn,
+		     struct fuse_config *cfg EXT2FS_ATTR((unused)))
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
@@ -1347,13 +1333,11 @@ static void *op_init(struct fuse_conn_info *conn
 #ifdef FUSE_CAP_NO_EXPORT_SUPPORT
 	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
 #endif
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;
 	if (ff->debug)
 		cfg->debug = 1;
 	cfg->nullpath_ok = 1;
-#endif
 
 	if (ff->kernel) {
 		char uuid[UUID_STR_SIZE];
@@ -1434,9 +1418,7 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 }
 
 static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			      struct fuse_file_info *fp EXT2FS_ATTR((unused)),
-#endif
 			      ext2_ino_t *inop,
 			      const char *func,
 			      int line)
@@ -1444,7 +1426,6 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
 	ext2_filsys fs = ff->fs;
 	errcode_t err;
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (fp) {
 		struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
 
@@ -1455,7 +1436,7 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
 		dbg_printf(ff, "%s: get ino=%d\n", func, fh->ino);
 		return 0;
 	}
-#endif
+
 	dbg_printf(ff, "%s: get path=%s\n", func, path);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, inop);
 	if (err)
@@ -1464,19 +1445,11 @@ static int __fuse2fs_file_ino(struct fuse2fs *ff, const char *path,
 	return 0;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 # define fuse2fs_file_ino(ff, path, fp, inop) \
 	__fuse2fs_file_ino((ff), (path), (fp), (inop), __func__, __LINE__)
-#else
-# define fuse2fs_file_ino(ff, path, fp, inop) \
-	__fuse2fs_file_ino((ff), (path), NULL, (inop), __func__, __LINE__)
-#endif
 
-static int op_getattr(const char *path, struct stat *statbuf
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_getattr(const char *path, struct stat *statbuf,
+		      struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
@@ -2465,11 +2438,8 @@ static int update_dotdot_helper(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	return 0;
 }
 
-static int op_rename(const char *from, const char *to
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, unsigned int flags EXT2FS_ATTR((unused))
-#endif
-			)
+static int op_rename(const char *from, const char *to,
+		     unsigned int flags EXT2FS_ATTR((unused)))
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
@@ -2482,11 +2452,9 @@ static int op_rename(const char *from, const char *to
 	int flushed = 0;
 	int ret = 0;
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	/* renameat2 is not supported */
 	if (flags)
 		return -ENOSYS;
-#endif
 
 	FUSE2FS_CHECK_CONTEXT(ff);
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
@@ -2800,7 +2768,6 @@ static int op_link(const char *src, const char *dest)
 	return ret;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 /* Obtain group ids of the process that sent us a command(?) */
 static int get_req_groups(struct fuse2fs *ff, gid_t **gids, size_t *nr_gids)
 {
@@ -2879,19 +2846,8 @@ static int in_file_group(struct fuse_context *ctxt,
 	ext2fs_free_mem(&gids);
 	return ret;
 }
-#else
-static int in_file_group(struct fuse_context *ctxt,
-			 const struct ext2_inode_large *inode)
-{
-	return ctxt->gid == inode_gid(*inode);
-}
-#endif
 
-static int op_chmod(const char *path, mode_t mode
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = fuse2fs_get();
@@ -2958,11 +2914,8 @@ static int op_chmod(const char *path, mode_t mode
 	return ret;
 }
 
-static int op_chown(const char *path, uid_t owner, gid_t group
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_chown(const char *path, uid_t owner, gid_t group,
+		    struct fuse_file_info *fi)
 {
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = fuse2fs_get();
@@ -3100,11 +3053,7 @@ static int fuse2fs_truncate(struct fuse2fs *ff, ext2_ino_t ino, off_t new_size)
 	return 0;
 }
 
-static int op_truncate(const char *path, off_t len
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_truncate(const char *path, off_t len, struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_ino_t ino;
@@ -3834,9 +3783,7 @@ struct readdir_iter {
 	fuse_fill_dir_t func;
 
 	struct fuse2fs *ff;
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	enum fuse_readdir_flags flags;
-#endif
 	unsigned int nr;
 	off_t startpos;
 	off_t dirpos;
@@ -3888,44 +3835,29 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 		return 0;
 
 	dbg_printf(i->ff, "READDIR%s ino=%d %u offset=0x%llx\n",
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			i->flags == FUSE_READDIR_PLUS ? "PLUS" : "",
-#else
-			"",
-#endif
 			dir,
 			i->nr++,
 			(unsigned long long)i->dirpos);
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	if (i->flags == FUSE_READDIR_PLUS) {
 		ret = stat_inode(i->fs, dirent->inode, &stat);
 		if (ret)
 			return DIRENT_ABORT;
 	}
-#endif
 
 	memcpy(namebuf, dirent->name, dirent->name_len & 0xFF);
 	namebuf[dirent->name_len & 0xFF] = 0;
-	ret = i->func(i->buf, namebuf, &stat, i->dirpos
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, 0
-#endif
-			);
+	ret = i->func(i->buf, namebuf, &stat, i->dirpos , 0);
 	if (ret)
 		return DIRENT_ABORT;
 
 	return 0;
 }
 
-static int op_readdir(const char *path EXT2FS_ATTR((unused)),
-		      void *buf, fuse_fill_dir_t fill_func,
-		      off_t offset,
-		      struct fuse_file_info *fp
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, enum fuse_readdir_flags flags
-#endif
-			)
+static int op_readdir(const char *path EXT2FS_ATTR((unused)), void *buf,
+		      fuse_fill_dir_t fill_func, off_t offset,
+		      struct fuse_file_info *fp, enum fuse_readdir_flags flags)
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
@@ -3934,9 +3866,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		.ff = ff,
 		.dirpos = 0,
 		.startpos = offset,
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 		.flags = flags,
-#endif
 	};
 	int ret = 0;
 
@@ -4119,82 +4049,8 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	return ret;
 }
 
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
-			off_t len, struct fuse_file_info *fp)
-{
-	struct fuse2fs *ff = fuse2fs_get();
-	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
-	ext2_filsys fs;
-	ext2_file_t efp;
-	errcode_t err;
-	int ret = 0;
-
-	FUSE2FS_CHECK_CONTEXT(ff);
-	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, fh->ino,
-		   (intmax_t) len);
-	fs = fuse2fs_start(ff);
-	if (!fuse2fs_is_writeable(ff)) {
-		ret = -EROFS;
-		goto out;
-	}
-
-	err = ext2fs_file_open(fs, fh->ino, fh->open_flags, &efp);
-	if (err) {
-		ret = translate_error(fs, fh->ino, err);
-		goto out;
-	}
-
-	err = ext2fs_file_set_size2(efp, len);
-	if (err) {
-		ret = translate_error(fs, fh->ino, err);
-		goto out2;
-	}
-
-out2:
-	err = ext2fs_file_close(efp);
-	if (ret)
-		goto out;
-	if (err) {
-		ret = translate_error(fs, fh->ino, err);
-		goto out;
-	}
-
-	ret = update_mtime(fs, fh->ino, NULL);
-	if (ret)
-		goto out;
-
-out:
-	fuse2fs_finish(ff, ret);
-	return ret;
-}
-
-static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),
-		       struct stat *statbuf,
-		       struct fuse_file_info *fp)
-{
-	struct fuse2fs *ff = fuse2fs_get();
-	ext2_filsys fs;
-	struct fuse2fs_file_handle *fh = fuse2fs_get_handle(fp);
-	int ret = 0;
-
-	FUSE2FS_CHECK_CONTEXT(ff);
-	FUSE2FS_CHECK_HANDLE(ff, fh);
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	fs = fuse2fs_start(ff);
-	ret = stat_inode(fs, fh->ino, statbuf);
-	fuse2fs_finish(ff, ret);
-
-	return ret;
-}
-#endif /* FUSE_VERSION < FUSE_MAKE_VERSION(3, 0) */
-
-static int op_utimens(const char *path, const struct timespec ctv[2]
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, struct fuse_file_info *fi
-#endif
-			)
+static int op_utimens(const char *path, const struct timespec ctv[2],
+		      struct fuse_file_info *fi)
 {
 	struct fuse2fs *ff = fuse2fs_get();
 	struct timespec tv[2];
@@ -4626,13 +4482,8 @@ static int ioctl_shutdown(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	return 0;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 		    unsigned int cmd,
-#else
-		    int cmd,
-#endif
 		    void *arg EXT2FS_ATTR((unused)),
 		    struct fuse_file_info *fp,
 		    unsigned int flags EXT2FS_ATTR((unused)), void *data)
@@ -4683,7 +4534,6 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 
 	return ret;
 }
-#endif /* FUSE 28 */
 
 static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 		   uint64_t *idx)
@@ -4714,8 +4564,7 @@ static int op_bmap(const char *path, size_t blocksize EXT2FS_ATTR((unused)),
 	return ret;
 }
 
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
-# ifdef SUPPORT_FALLOCATE
+#ifdef SUPPORT_FALLOCATE
 static int fuse2fs_allocate_range(struct fuse2fs *ff,
 				  struct fuse2fs_file_handle *fh, int mode,
 				  off_t offset, off_t len)
@@ -4991,8 +4840,7 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 
 	return ret;
 }
-# endif /* SUPPORT_FALLOCATE */
-#endif /* FUSE 29 */
+#endif /* SUPPORT_FALLOCATE */
 
 static struct fuse_operations fs_ops = {
 	.init = op_init,
@@ -5025,34 +4873,15 @@ static struct fuse_operations fs_ops = {
 	.fsyncdir = op_fsync,
 	.access = op_access,
 	.create = op_create,
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-	.ftruncate = op_ftruncate,
-	.fgetattr = op_fgetattr,
-#endif
 	.utimens = op_utimens,
-#if (FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)) && (FUSE_VERSION < FUSE_MAKE_VERSION(3, 0))
-# if defined(UTIME_NOW) || defined(UTIME_OMIT)
-	.flag_utime_omit_ok = 1,
-# endif
-#endif
 	.bmap = op_bmap,
 #ifdef SUPERFLUOUS
 	.lock = op_lock,
 	.poll = op_poll,
 #endif
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 	.ioctl = op_ioctl,
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-	.flag_nullpath_ok = 1,
-#endif
-#endif
-#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 9)
-#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 0)
-	.flag_nopath = 1,
-#endif
-# ifdef SUPPORT_FALLOCATE
+#ifdef SUPPORT_FALLOCATE
 	.fallocate = op_fallocate,
-# endif
 #endif
 };
 
@@ -5416,7 +5245,7 @@ int main(int argc, char *argv[])
 
 	/* Set up default fuse parameters */
 	snprintf(extra_args, BUFSIZ, "-okernel_cache,subtype=%s,"
-		 "fsname=%s,attr_timeout=0" FUSE_PLATFORM_OPTS,
+		 "fsname=%s,attr_timeout=0",
 		 get_subtype(argv[0]),
 		 fctx.device);
 	if (fctx.no_default_opts == 0)


