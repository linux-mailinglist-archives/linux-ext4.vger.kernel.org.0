Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901636C4109
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 04:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCVDbD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 23:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCVDa4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 23:30:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97451BDEB
        for <linux-ext4@vger.kernel.org>; Tue, 21 Mar 2023 20:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E956B81AD5
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBDFC4339C
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679455850;
        bh=cw5RBzMUlEwqqjKwBfwZrKOh4Rii+nYkRxH79teSk+M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oFmrTD3J7OuBeYBmDJfRByAgR6XklYbivPnDyx9AVUfOvlG+S75VDmUoMoel9cIbI
         nMeWbb95OjFImmSPrgulSeRdcWHmIxlmJgmflRztJlWCvjXcJm3xak6O8IOQFbOkxi
         8xssWMXV6LFpdlvAXKQr0KiLa3OaKMjWpnMIuTL0a4HHEQihAeeJBOsvGvJQb5/y2C
         DvLrxoViIth2vbFWiMfbSlv8s4QMS6zaQbvE5iGBk05rUkHUeErQjCKWURluwkbqbQ
         Gh4zfJxQPM29sU/NlgtztS+VzT2t6BTSpBKcqG94/F5pNuxrZ9n4BNbYfJnsWqe6Hh
         8bdn19rhAGNUA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] e2freefrag: don't use linux/fsmap.h when fsmap_sizeof() is missing
Date:   Tue, 21 Mar 2023 20:29:44 -0700
Message-Id: <20230322032945.31779-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322032945.31779-1-ebiggers@kernel.org>
References: <20230322032945.31779-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Work around an issue with the Android NDK where its copy of
linux/fsmap.h is missing the inline functions fsmap_sizeof() and
fsmap_advance().  This was causing an error when building e2fsprogs
using the Android NDK, using the autotools-based build system.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 configure         | 91 +++++++++++++++++++++++++++++++----------------
 configure.ac      |  6 ++++
 lib/config.h.in   |  3 ++
 misc/e2freefrag.c |  2 +-
 4 files changed, 70 insertions(+), 32 deletions(-)

diff --git a/configure b/configure
index b0e8d1bf8..72c39b4d3 100755
--- a/configure
+++ b/configure
@@ -8678,7 +8678,7 @@ else $as_nop
       *-*-aix*)
         cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
-#if defined __powerpc64__ || defined _ARCH_PPC64
+#if defined __powerpc64__ || defined __LP64__
                 int ok;
                #else
                 error fail
@@ -8969,7 +8969,7 @@ rm -f core conftest.err conftest.$ac_objext conftest.beam conftest.$ac_ext
            # be generating 64-bit code.
            cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
-#if defined __powerpc64__ || defined _ARCH_PPC64
+#if defined __powerpc64__ || defined __LP64__
                    int ok;
                   #else
                    error fail
@@ -9076,7 +9076,7 @@ then :
 else $as_nop
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
-#ifdef __ELF__
+#if defined __ELF__ || (defined __linux__ && defined __EDG__)
         Extensible Linking Format
         #endif
 
@@ -9094,7 +9094,7 @@ rm -rf conftest*
 fi
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $gl_cv_elf" >&5
 printf "%s\n" "$gl_cv_elf" >&6; }
-  if test $gl_cv_elf; then
+  if test $gl_cv_elf = yes; then
     # Extract the ELF class of a file (5th byte) in decimal.
     # Cf. https://en.wikipedia.org/wiki/Executable_and_Linkable_Format#File_header
     if od -A x < /dev/null >/dev/null 2>/dev/null; then
@@ -9111,19 +9111,22 @@ printf "%s\n" "$gl_cv_elf" >&6; }
         echo
       }
     fi
+    # Use 'expr', not 'test', to compare the values of func_elfclass, because on
+    # Solaris 11 OpenIndiana and Solaris 11 OmniOS, the result is 001 or 002,
+    # not 1 or 2.
     case $HOST_CPU_C_ABI_32BIT in
       yes)
         # 32-bit ABI.
         acl_is_expected_elfclass ()
         {
-          test "`func_elfclass | sed -e 's/[ 	]//g'`" = 1
+          expr "`func_elfclass | sed -e 's/[ 	]//g'`" = 1 > /dev/null
         }
         ;;
       no)
         # 64-bit ABI.
         acl_is_expected_elfclass ()
         {
-          test "`func_elfclass | sed -e 's/[ 	]//g'`" = 2
+          expr "`func_elfclass | sed -e 's/[ 	]//g'`" = 2 > /dev/null
         }
         ;;
       *)
@@ -9653,7 +9656,14 @@ fi
                     fi
                     ;;
                   -l*)
-                                        names_next_round="$names_next_round "`echo "X$dep" | sed -e 's/^X-l//'`
+                                                                                                                                                                dep=`echo "X$dep" | sed -e 's/^X-l//'`
+                    if test "X$dep" != Xc \
+                       || case $host_os in
+                            linux* | gnu* | k*bsd*-gnu) false ;;
+                            *)                          true ;;
+                          esac; then
+                      names_next_round="$names_next_round $dep"
+                    fi
                     ;;
                   *.la)
                                                                                 names_next_round="$names_next_round "`echo "X$dep" | sed -e 's,^X.*/,,' -e 's,^lib,,' -e 's,\.la$,,'`
@@ -10015,8 +10025,9 @@ int
 main (void)
 {
 int result = 0;
-  /* Test against AIX 5.1 bug: Failures are not distinguishable from successful
-     returns.  */
+  /* Test against AIX 5.1...7.2 bug: Failures are not distinguishable from
+     successful returns.  This is even documented in
+     <https://www.ibm.com/support/knowledgecenter/ssw_aix_72/i_bostechref/iconv.html> */
   {
     iconv_t cd_utf8_to_88591 = iconv_open ("ISO8859-1", "UTF-8");
     if (cd_utf8_to_88591 != (iconv_t)(-1))
@@ -10598,7 +10609,14 @@ fi
                     fi
                     ;;
                   -l*)
-                                        names_next_round="$names_next_round "`echo "X$dep" | sed -e 's/^X-l//'`
+                                                                                                                                                                dep=`echo "X$dep" | sed -e 's/^X-l//'`
+                    if test "X$dep" != Xc \
+                       || case $host_os in
+                            linux* | gnu* | k*bsd*-gnu) false ;;
+                            *)                          true ;;
+                          esac; then
+                      names_next_round="$names_next_round $dep"
+                    fi
                     ;;
                   *.la)
                                                                                 names_next_round="$names_next_round "`echo "X$dep" | sed -e 's,^X.*/,,' -e 's,^lib,,' -e 's,\.la$,,'`
@@ -12336,6 +12354,15 @@ then :
 
 printf "%s\n" "#define HAVE_LSEEK64_PROTOTYPE 1" >>confdefs.h
 
+fi
+
+ac_fn_check_decl "$LINENO" "fsmap_sizeof" "ac_cv_have_decl_fsmap_sizeof" "#include <linux/fsmap.h>
+" "$ac_c_undeclared_builtin_options" "CFLAGS"
+if test "x$ac_cv_have_decl_fsmap_sizeof" = xyes
+then :
+
+printf "%s\n" "#define HAVE_FSMAP_SIZEOF 1" >>confdefs.h
+
 fi
 # The cast to long int works around a bug in the HP C Compiler
 # version HP92453-01 B.11.11.23709.GP, which incorrectly rejects
@@ -14776,11 +14803,11 @@ if test x$ac_prog_cxx_stdcxx = xno
 then :
   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for $CXX option to enable C++11 features" >&5
 printf %s "checking for $CXX option to enable C++11 features... " >&6; }
-if test ${ac_cv_prog_cxx_cxx11+y}
+if test ${ac_cv_prog_cxx_11+y}
 then :
   printf %s "(cached) " >&6
 else $as_nop
-  ac_cv_prog_cxx_cxx11=no
+  ac_cv_prog_cxx_11=no
 ac_save_CXX=$CXX
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
@@ -14822,11 +14849,11 @@ if test x$ac_prog_cxx_stdcxx = xno
 then :
   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for $CXX option to enable C++98 features" >&5
 printf %s "checking for $CXX option to enable C++98 features... " >&6; }
-if test ${ac_cv_prog_cxx_cxx98+y}
+if test ${ac_cv_prog_cxx_98+y}
 then :
   printf %s "(cached) " >&6
 else $as_nop
-  ac_cv_prog_cxx_cxx98=no
+  ac_cv_prog_cxx_98=no
 ac_save_CXX=$CXX
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
@@ -15166,7 +15193,7 @@ fi
 
 
 if test $pkg_failed = yes; then
-        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+   	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
 printf "%s\n" "no" >&6; }
 
 if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
@@ -15175,25 +15202,25 @@ else
         _pkg_short_errors_supported=no
 fi
         if test $_pkg_short_errors_supported = yes; then
-                udev_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "udev" 2>&1`
+	        udev_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "udev" 2>&1`
         else
-                udev_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "udev" 2>&1`
+	        udev_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "udev" 2>&1`
         fi
-        # Put the nasty error message in config.log where it belongs
-        echo "$udev_PKG_ERRORS" >&5
+	# Put the nasty error message in config.log where it belongs
+	echo "$udev_PKG_ERRORS" >&5
 
 
 			with_udev_rules_dir=""
 
 elif test $pkg_failed = untried; then
-        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+     	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
 printf "%s\n" "no" >&6; }
 
 			with_udev_rules_dir=""
 
 else
-        udev_CFLAGS=$pkg_cv_udev_CFLAGS
-        udev_LIBS=$pkg_cv_udev_LIBS
+	udev_CFLAGS=$pkg_cv_udev_CFLAGS
+	udev_LIBS=$pkg_cv_udev_LIBS
         { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
 printf "%s\n" "yes" >&6; }
 
@@ -15335,7 +15362,7 @@ fi
 
 
 if test $pkg_failed = yes; then
-        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+   	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
 printf "%s\n" "no" >&6; }
 
 if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
@@ -15344,25 +15371,25 @@ else
         _pkg_short_errors_supported=no
 fi
         if test $_pkg_short_errors_supported = yes; then
-                systemd_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "systemd" 2>&1`
+	        systemd_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "systemd" 2>&1`
         else
-                systemd_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "systemd" 2>&1`
+	        systemd_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "systemd" 2>&1`
         fi
-        # Put the nasty error message in config.log where it belongs
-        echo "$systemd_PKG_ERRORS" >&5
+	# Put the nasty error message in config.log where it belongs
+	echo "$systemd_PKG_ERRORS" >&5
 
 
 			with_systemd_unit_dir=""
 
 elif test $pkg_failed = untried; then
-        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
+     	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
 printf "%s\n" "no" >&6; }
 
 			with_systemd_unit_dir=""
 
 else
-        systemd_CFLAGS=$pkg_cv_systemd_CFLAGS
-        systemd_LIBS=$pkg_cv_systemd_LIBS
+	systemd_CFLAGS=$pkg_cv_systemd_CFLAGS
+	systemd_LIBS=$pkg_cv_systemd_LIBS
         { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: yes" >&5
 printf "%s\n" "yes" >&6; }
 
@@ -17029,7 +17056,9 @@ printf "%s\n" "$as_me: executing $ac_file commands" >&6;}
                 #      presentlang can be used as a fallback for messages
                 #      which are not translated in the desiredlang catalog).
                 case "$desiredlang" in
-                  "$presentlang"*) useit=yes;;
+                  "$presentlang" | "$presentlang"_* | "$presentlang".* | "$presentlang"@*)
+                    useit=yes
+                    ;;
                 esac
               done
               if test $useit = yes; then
diff --git a/configure.ac b/configure.ac
index 017a96ffe..b905e9992 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1107,6 +1107,12 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
 		[#define _LARGEFILE_SOURCE
 		 #define _LARGEFILE64_SOURCE
 		 #include <unistd.h>])
+
+dnl The Android NDK has <linux/fsmap.h>, but it is missing the inline functions
+dnl fsmap_sizeof() and fsmap_advance().  Check whether this is the case.
+AC_CHECK_DECL(fsmap_sizeof,[AC_DEFINE(HAVE_FSMAP_SIZEOF, 1,
+			    [Define to 1 if fsmap_sizeof() is declared in linux/fsmap.h])],,
+		[#include <linux/fsmap.h>])
 dnl
 dnl Word sizes...
 dnl
diff --git a/lib/config.h.in b/lib/config.h.in
index ab38266f6..076c38235 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -109,6 +109,9 @@
 /* Define to 1 if you have the `fdatasync' function. */
 #undef HAVE_FDATASYNC
 
+/* Define to 1 if fsmap_sizeof() is declared in linux/fsmap.h */
+#undef HAVE_FSMAP_SIZEOF
+
 /* Define to 1 if you have the `fstat64' function. */
 #undef HAVE_FSTAT64
 
diff --git a/misc/e2freefrag.c b/misc/e2freefrag.c
index 49b6346e4..04f155b60 100644
--- a/misc/e2freefrag.c
+++ b/misc/e2freefrag.c
@@ -38,7 +38,7 @@ extern int optind;
 #include "e2freefrag.h"
 
 #if defined(HAVE_EXT2_IOCTLS) && !defined(DEBUGFS)
-# ifdef HAVE_LINUX_FSMAP_H
+# if defined(HAVE_LINUX_FSMAP_H) && defined(HAVE_FSMAP_SIZEOF)
 #  include <linux/fsmap.h>
 # endif
 # include "fsmap.h"
-- 
2.40.0

