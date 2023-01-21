Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68197676949
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAUUgu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjAUUgn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE7234F0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC32F60B07
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E13C4339E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333399;
        bh=usC3ErxE65Df7UPBOXOdQN0qOu+GA9KnpST6HfshhsU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ab3AdBBPVh1dsiy8OsFFrTlfB0uqpHZHiHUdNzVrphJC7XHhBjVu26GAIvKvMNqKN
         JkGEkddjPPL8QlUAY5TDPz5qU4d3OIZvJHfszHN+Pgt/fZITUzV+pkmW+oU8fMODjk
         ogbHtKsDpjmdPPUESudD9pu3nh0LOXUe3sZonYrientH+CyxIFXqapUOv7gz6ESM0U
         NukITAu6hOKGCXp/en+iKu6o7m3Sos7LgYpY57gc74c591htWu8+Z4AaaQqBqlfL4o
         JTiD/JYRFcrAPSVHng/zyzLFghJ0hgClNxCN8dxBTz7FimgG7b2AbQTwyaNZSN3VAC
         5uYzRShoNFWkQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 04/38] configure: regenerate
Date:   Sat, 21 Jan 2023 12:31:56 -0800
Message-Id: <20230121203230.27624-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Run autoreconf.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 aclocal.m4      | 180 ++++++++++++++++++++++++++----------------------
 configure       | 105 +++++++++++++++++++++-------
 lib/config.h.in | 100 ++++++++++++++++++++++-----
 3 files changed, 262 insertions(+), 123 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index bd5778d57..af10b6afe 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -535,7 +535,7 @@ fi
 AC_LANG_POP
 ])dnl AX_PTHREAD
 
-# gettext.m4 serial 71 (gettext-0.20.2)
+# gettext.m4 serial 72 (gettext-0.21.1)
 dnl Copyright (C) 1995-2014, 2016, 2018-2020 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
@@ -592,22 +592,22 @@ dnl
 AC_DEFUN([AM_GNU_GETTEXT],
 [
   dnl Argument checking.
-  ifelse([$1], [], , [ifelse([$1], [external], , [ifelse([$1], [use-libtool], ,
+  m4_if([$1], [], , [m4_if([$1], [external], , [m4_if([$1], [use-libtool], ,
     [errprint([ERROR: invalid first argument to AM_GNU_GETTEXT
 ])])])])
-  ifelse(ifelse([$1], [], [old])[]ifelse([$1], [no-libtool], [old]), [old],
+  m4_if(m4_if([$1], [], [old])[]m4_if([$1], [no-libtool], [old]), [old],
     [errprint([ERROR: Use of AM_GNU_GETTEXT without [external] argument is no longer supported.
 ])])
-  ifelse([$2], [], , [ifelse([$2], [need-ngettext], , [ifelse([$2], [need-formatstring-macros], ,
+  m4_if([$2], [], , [m4_if([$2], [need-ngettext], , [m4_if([$2], [need-formatstring-macros], ,
     [errprint([ERROR: invalid second argument to AM_GNU_GETTEXT
 ])])])])
   define([gt_included_intl],
-    ifelse([$1], [external], [no], [yes]))
+    m4_if([$1], [external], [no], [yes]))
   gt_NEEDS_INIT
   AM_GNU_GETTEXT_NEED([$2])
 
   AC_REQUIRE([AM_PO_SUBDIRS])dnl
-  ifelse(gt_included_intl, yes, [
+  m4_if(gt_included_intl, yes, [
     AC_REQUIRE([AM_INTL_SUBDIR])dnl
   ])
 
@@ -625,7 +625,7 @@ AC_DEFUN([AM_GNU_GETTEXT],
   dnl - Invoke AM_ICONV_LINKFLAGS_BODY here, outside any 'if'.
   dnl - Control the expansions in more detail using AC_PROVIDE_IFELSE.
   dnl Since AC_PROVIDE_IFELSE is not documented, we avoid it.
-  ifelse(gt_included_intl, yes, , [
+  m4_if(gt_included_intl, yes, , [
     AC_REQUIRE([AM_ICONV_LINKFLAGS_BODY])
   ])
 
@@ -635,7 +635,7 @@ AC_DEFUN([AM_GNU_GETTEXT],
   dnl Set USE_NLS.
   AC_REQUIRE([AM_NLS])
 
-  ifelse(gt_included_intl, yes, [
+  m4_if(gt_included_intl, yes, [
     BUILD_INCLUDED_LIBINTL=no
     USE_INCLUDED_LIBINTL=no
   ])
@@ -655,7 +655,7 @@ AC_DEFUN([AM_GNU_GETTEXT],
   dnl If we use NLS figure out what method
   if test "$USE_NLS" = "yes"; then
     gt_use_preinstalled_gnugettext=no
-    ifelse(gt_included_intl, yes, [
+    m4_if(gt_included_intl, yes, [
       AC_MSG_CHECKING([whether included gettext is requested])
       AC_ARG_WITH([included-gettext],
         [  --with-included-gettext use the GNU gettext library included here],
@@ -711,7 +711,7 @@ return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRESSION
 
         if { eval "gt_val=\$$gt_func_gnugettext_libc"; test "$gt_val" != "yes"; }; then
           dnl Sometimes libintl requires libiconv, so first search for libiconv.
-          ifelse(gt_included_intl, yes, , [
+          m4_if(gt_included_intl, yes, , [
             AM_ICONV_LINK
           ])
           dnl Search for libintl and define LIBINTL, LTLIBINTL and INCINTL
@@ -798,7 +798,7 @@ return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRESSION
           INCINTL=
         fi
 
-    ifelse(gt_included_intl, yes, [
+    m4_if(gt_included_intl, yes, [
         if test "$gt_use_preinstalled_gnugettext" != "yes"; then
           dnl GNU gettext is not found in the C library.
           dnl Fall back on included GNU gettext library.
@@ -810,8 +810,8 @@ return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRESSION
         dnl Mark actions used to generate GNU NLS library.
         BUILD_INCLUDED_LIBINTL=yes
         USE_INCLUDED_LIBINTL=yes
-        LIBINTL="ifelse([$3],[],\${top_builddir}/intl,[$3])/libintl.la $LIBICONV $LIBTHREAD"
-        LTLIBINTL="ifelse([$3],[],\${top_builddir}/intl,[$3])/libintl.la $LTLIBICONV $LTLIBTHREAD"
+        LIBINTL="m4_if([$3],[],\${top_builddir}/intl,[$3])/libintl.la $LIBICONV $LIBTHREAD"
+        LTLIBINTL="m4_if([$3],[],\${top_builddir}/intl,[$3])/libintl.la $LTLIBICONV $LTLIBTHREAD"
         LIBS=`echo " $LIBS " | sed -e 's/ -lintl / /' -e 's/^ //' -e 's/ $//'`
       fi
 
@@ -878,7 +878,7 @@ return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRESSION
     POSUB=po
   fi
 
-  ifelse(gt_included_intl, yes, [
+  m4_if(gt_included_intl, yes, [
     dnl In GNU gettext we have to set BUILD_INCLUDED_LIBINTL to 'yes'
     dnl because some of the testsuite requires it.
     BUILD_INCLUDED_LIBINTL=yes
@@ -922,8 +922,8 @@ AC_DEFUN([AM_GNU_GETTEXT_VERSION], [])
 dnl Usage: AM_GNU_GETTEXT_REQUIRE_VERSION([gettext-version])
 AC_DEFUN([AM_GNU_GETTEXT_REQUIRE_VERSION], [])
 
-# host-cpu-c-abi.m4 serial 13
-dnl Copyright (C) 2002-2020 Free Software Foundation, Inc.
+# host-cpu-c-abi.m4 serial 15
+dnl Copyright (C) 2002-2022 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1135,7 +1135,7 @@ changequote([,])dnl
          # be generating 64-bit code.
          AC_COMPILE_IFELSE(
            [AC_LANG_SOURCE(
-              [[#if defined __powerpc64__ || defined _ARCH_PPC64
+              [[#if defined __powerpc64__ || defined __LP64__
                  int ok;
                 #else
                  error fail
@@ -1306,6 +1306,9 @@ EOF
 #ifndef __ia64__
 #undef __ia64__
 #endif
+#ifndef __loongarch64__
+#undef __loongarch64__
+#endif
 #ifndef __m68k__
 #undef __m68k__
 #endif
@@ -1529,7 +1532,7 @@ changequote([,])dnl
            # be generating 64-bit code.
            AC_COMPILE_IFELSE(
              [AC_LANG_SOURCE(
-                [[#if defined __powerpc64__ || defined _ARCH_PPC64
+                [[#if defined __powerpc64__ || defined __LP64__
                    int ok;
                   #else
                    error fail
@@ -1598,8 +1601,8 @@ changequote([,])dnl
   HOST_CPU_C_ABI_32BIT="$gl_cv_host_cpu_c_abi_32bit"
 ])
 
-# iconv.m4 serial 21
-dnl Copyright (C) 2000-2002, 2007-2014, 2016-2020 Free Software Foundation,
+# iconv.m4 serial 24
+dnl Copyright (C) 2000-2002, 2007-2014, 2016-2022 Free Software Foundation,
 dnl Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
@@ -1607,6 +1610,12 @@ dnl with or without modifications, as long as this notice is preserved.
 
 dnl From Bruno Haible.
 
+AC_PREREQ([2.64])
+
+dnl Note: AM_ICONV is documented in the GNU gettext manual
+dnl <https://www.gnu.org/software/gettext/manual/html_node/AM_005fICONV.html>.
+dnl Don't make changes that are incompatible with that documentation!
+
 AC_DEFUN([AM_ICONV_LINKFLAGS_BODY],
 [
   dnl Prerequisites of AC_LIB_LINKFLAGS_BODY.
@@ -1686,8 +1695,9 @@ AC_DEFUN([AM_ICONV_LINK],
 #endif
              ]],
              [[int result = 0;
-  /* Test against AIX 5.1 bug: Failures are not distinguishable from successful
-     returns.  */
+  /* Test against AIX 5.1...7.2 bug: Failures are not distinguishable from
+     successful returns.  This is even documented in
+     <https://www.ibm.com/support/knowledgecenter/ssw_aix_72/i_bostechref/iconv.html> */
   {
     iconv_t cd_utf8_to_88591 = iconv_open ("ISO8859-1", "UTF-8");
     if (cd_utf8_to_88591 != (iconv_t)(-1))
@@ -1825,8 +1835,7 @@ AC_DEFUN([AM_ICONV_LINK],
   AC_SUBST([LTLIBICONV])
 ])
 
-dnl Define AM_ICONV using AC_DEFUN_ONCE for Autoconf >= 2.64, in order to
-dnl avoid warnings like
+dnl Define AM_ICONV using AC_DEFUN_ONCE, in order to avoid warnings like
 dnl "warning: AC_REQUIRE: `AM_ICONV' was expanded before it was required".
 dnl This is tricky because of the way 'aclocal' is implemented:
 dnl - It requires defining an auxiliary macro whose name ends in AC_DEFUN.
@@ -1834,61 +1843,50 @@ dnl   Otherwise aclocal's initial scan pass would miss the macro definition.
 dnl - It requires a line break inside the AC_DEFUN_ONCE and AC_DEFUN expansions.
 dnl   Otherwise aclocal would emit many "Use of uninitialized value $1"
 dnl   warnings.
-m4_define([gl_iconv_AC_DEFUN],
-  m4_version_prereq([2.64],
-    [[AC_DEFUN_ONCE(
-        [$1], [$2])]],
-    [m4_ifdef([gl_00GNULIB],
-       [[AC_DEFUN_ONCE(
-           [$1], [$2])]],
-       [[AC_DEFUN(
-           [$1], [$2])]])]))
-gl_iconv_AC_DEFUN([AM_ICONV],
+AC_DEFUN_ONCE([AM_ICONV],
 [
   AM_ICONV_LINK
   if test "$am_cv_func_iconv" = yes; then
-    AC_MSG_CHECKING([for iconv declaration])
-    AC_CACHE_VAL([am_cv_proto_iconv], [
-      AC_COMPILE_IFELSE(
-        [AC_LANG_PROGRAM(
-           [[
+    AC_CACHE_CHECK([whether iconv is compatible with its POSIX signature],
+      [gl_cv_iconv_nonconst],
+      [AC_COMPILE_IFELSE(
+         [AC_LANG_PROGRAM(
+            [[
 #include <stdlib.h>
 #include <iconv.h>
 extern
 #ifdef __cplusplus
 "C"
 #endif
-#if defined(__STDC__) || defined(_MSC_VER) || defined(__cplusplus)
 size_t iconv (iconv_t cd, char * *inbuf, size_t *inbytesleft, char * *outbuf, size_t *outbytesleft);
-#else
-size_t iconv();
-#endif
-           ]],
-           [[]])],
-        [am_cv_proto_iconv_arg1=""],
-        [am_cv_proto_iconv_arg1="const"])
-      am_cv_proto_iconv="extern size_t iconv (iconv_t cd, $am_cv_proto_iconv_arg1 char * *inbuf, size_t *inbytesleft, char * *outbuf, size_t *outbytesleft);"])
-    am_cv_proto_iconv=`echo "[$]am_cv_proto_iconv" | tr -s ' ' | sed -e 's/( /(/'`
-    AC_MSG_RESULT([
-         $am_cv_proto_iconv])
+            ]],
+            [[]])],
+         [gl_cv_iconv_nonconst=yes],
+         [gl_cv_iconv_nonconst=no])
+      ])
   else
     dnl When compiling GNU libiconv on a system that does not have iconv yet,
     dnl pick the POSIX compliant declaration without 'const'.
-    am_cv_proto_iconv_arg1=""
+    gl_cv_iconv_nonconst=yes
   fi
-  AC_DEFINE_UNQUOTED([ICONV_CONST], [$am_cv_proto_iconv_arg1],
+  if test $gl_cv_iconv_nonconst = yes; then
+    iconv_arg1=""
+  else
+    iconv_arg1="const"
+  fi
+  AC_DEFINE_UNQUOTED([ICONV_CONST], [$iconv_arg1],
     [Define as const if the declaration of iconv() needs const.])
   dnl Also substitute ICONV_CONST in the gnulib generated <iconv.h>.
   m4_ifdef([gl_ICONV_H_DEFAULTS],
     [AC_REQUIRE([gl_ICONV_H_DEFAULTS])
-     if test -n "$am_cv_proto_iconv_arg1"; then
+     if test $gl_cv_iconv_nonconst != yes; then
        ICONV_CONST="const"
      fi
     ])
 ])
 
 # intlmacosx.m4 serial 8 (gettext-0.20.2)
-dnl Copyright (C) 2004-2014, 2016, 2019-2020 Free Software Foundation, Inc.
+dnl Copyright (C) 2004-2014, 2016, 2019-2022 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1953,8 +1951,8 @@ AC_DEFUN([gt_INTL_MACOSX],
   AC_SUBST([INTL_MACOSX_LIBS])
 ])
 
-# lib-ld.m4 serial 9
-dnl Copyright (C) 1996-2003, 2009-2020 Free Software Foundation, Inc.
+# lib-ld.m4 serial 10
+dnl Copyright (C) 1996-2003, 2009-2022 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -2077,7 +2075,7 @@ else
       *-*-aix*)
         AC_COMPILE_IFELSE(
           [AC_LANG_SOURCE(
-             [[#if defined __powerpc64__ || defined _ARCH_PPC64
+             [[#if defined __powerpc64__ || defined __LP64__
                 int ok;
                #else
                 error fail
@@ -2122,8 +2120,8 @@ fi
 AC_LIB_PROG_LD_GNU
 ])
 
-# lib-link.m4 serial 31
-dnl Copyright (C) 2001-2020 Free Software Foundation, Inc.
+# lib-link.m4 serial 33
+dnl Copyright (C) 2001-2022 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -2320,8 +2318,8 @@ AC_DEFUN([AC_LIB_LINKFLAGS_BODY],
     eval additional_libdir3=\"$exec_prefix/$acl_libdirstem3\"
   ])
   AC_ARG_WITH(PACK[-prefix],
-[[  --with-]]PACK[[-prefix[=DIR]  search for ]PACKLIBS[ in DIR/include and DIR/lib
-  --without-]]PACK[[-prefix     don't search for ]PACKLIBS[ in includedir and libdir]],
+[[  --with-]]PACK[[-prefix[=DIR]  search for ]]PACKLIBS[[ in DIR/include and DIR/lib
+  --without-]]PACK[[-prefix     don't search for ]]PACKLIBS[[ in includedir and libdir]],
 [
     if test "X$withval" = "Xno"; then
       use_additional=no
@@ -2755,7 +2753,20 @@ AC_DEFUN([AC_LIB_LINKFLAGS_BODY],
                     ;;
                   -l*)
                     dnl Handle this in the next round.
-                    names_next_round="$names_next_round "`echo "X$dep" | sed -e 's/^X-l//'`
+                    dnl But on GNU systems, ignore -lc options, because
+                    dnl   - linking with libc is the default anyway,
+                    dnl   - linking with libc.a may produce an error
+                    dnl     "/usr/bin/ld: dynamic STT_GNU_IFUNC symbol `strcmp' with pointer equality in `/usr/lib/libc.a(strcmp.o)' can not be used when making an executable; recompile with -fPIE and relink with -pie"
+                    dnl     or may produce an executable that always crashes, see
+                    dnl     <https://lists.gnu.org/archive/html/grep-devel/2020-09/msg00052.html>.
+                    dep=`echo "X$dep" | sed -e 's/^X-l//'`
+                    if test "X$dep" != Xc \
+                       || case $host_os in
+                            linux* | gnu* | k*bsd*-gnu) false ;;
+                            *)                          true ;;
+                          esac; then
+                      names_next_round="$names_next_round $dep"
+                    fi
                     ;;
                   *.la)
                     dnl Handle this in the next round. Throw away the .la's
@@ -2923,8 +2934,8 @@ AC_DEFUN([AC_LIB_LINKFLAGS_FROM_LIBS],
   AC_SUBST([$1])
 ])
 
-# lib-prefix.m4 serial 17
-dnl Copyright (C) 2001-2005, 2008-2020 Free Software Foundation, Inc.
+# lib-prefix.m4 serial 20
+dnl Copyright (C) 2001-2005, 2008-2022 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -3099,14 +3110,14 @@ AC_DEFUN([AC_LIB_PREPARE_MULTILIB],
 
   AC_CACHE_CHECK([for ELF binary format], [gl_cv_elf],
     [AC_EGREP_CPP([Extensible Linking Format],
-       [#ifdef __ELF__
+       [#if defined __ELF__ || (defined __linux__ && defined __EDG__)
         Extensible Linking Format
         #endif
        ],
        [gl_cv_elf=yes],
        [gl_cv_elf=no])
-     ])
-  if test $gl_cv_elf; then
+    ])
+  if test $gl_cv_elf = yes; then
     # Extract the ELF class of a file (5th byte) in decimal.
     # Cf. https://en.wikipedia.org/wiki/Executable_and_Linkable_Format#File_header
     if od -A x < /dev/null >/dev/null 2>/dev/null; then
@@ -3123,20 +3134,23 @@ AC_DEFUN([AC_LIB_PREPARE_MULTILIB],
         echo
       }
     fi
+    # Use 'expr', not 'test', to compare the values of func_elfclass, because on
+    # Solaris 11 OpenIndiana and Solaris 11 OmniOS, the result is 001 or 002,
+    # not 1 or 2.
 changequote(,)dnl
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
@@ -3245,7 +3259,7 @@ changequote([,])dnl
 ])
 
 # nls.m4 serial 6 (gettext-0.20.2)
-dnl Copyright (C) 1995-2003, 2005-2006, 2008-2014, 2016, 2019-2020 Free
+dnl Copyright (C) 1995-2003, 2005-2006, 2008-2014, 2016, 2019-2022 Free
 dnl Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
@@ -3621,8 +3635,8 @@ AS_IF([test "$AS_TR_SH([with_]m4_tolower([$1]))" = "yes"],
         [AC_DEFINE([HAVE_][$1], 1, [Enable ]m4_tolower([$1])[ support])])
 ])dnl PKG_HAVE_DEFINE_WITH_MODULES
 
-# po.m4 serial 31 (gettext-0.20.2)
-dnl Copyright (C) 1995-2014, 2016, 2018-2020 Free Software Foundation, Inc.
+# po.m4 serial 32 (gettext-0.21.1)
+dnl Copyright (C) 1995-2014, 2016, 2018-2022 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -3802,7 +3816,9 @@ changequote([,])dnl
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
@@ -4002,7 +4018,9 @@ changequote([,])dnl
         #      presentlang can be used as a fallback for messages
         #      which are not translated in the desiredlang catalog).
         case "$desiredlang" in
-          "$presentlang"*) useit=yes;;
+          "$presentlang" | "$presentlang"_* | "$presentlang".* | "$presentlang"@*)
+            useit=yes
+            ;;
         esac
       done
       if test $useit = yes; then
@@ -4072,8 +4090,8 @@ AC_DEFUN([AM_XGETTEXT_OPTION],
   XGETTEXT_EXTRA_OPTIONS="$XGETTEXT_EXTRA_OPTIONS $1"
 ])
 
-# progtest.m4 serial 8 (gettext-0.20.2)
-dnl Copyright (C) 1996-2003, 2005, 2008-2020 Free Software Foundation, Inc.
+# progtest.m4 serial 9 (gettext-0.21.1)
+dnl Copyright (C) 1996-2003, 2005, 2008-2022 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -4090,7 +4108,7 @@ dnl They are *not* in the public domain.
 dnl Authors:
 dnl   Ulrich Drepper <drepper@cygnus.com>, 1996.
 
-AC_PREREQ([2.50])
+AC_PREREQ([2.53])
 
 # Search path for a program which passes the given test.
 
@@ -4135,7 +4153,7 @@ AC_CACHE_VAL([ac_cv_path_$1],
     ;;
   *)
     ac_save_IFS="$IFS"; IFS=$PATH_SEPARATOR
-    for ac_dir in ifelse([$5], , $PATH, [$5]); do
+    for ac_dir in m4_if([$5], , $PATH, [$5]); do
       IFS="$ac_save_IFS"
       test -z "$ac_dir" && ac_dir=.
       for ac_exec_ext in '' $ac_executable_extensions; do
@@ -4151,12 +4169,12 @@ AC_CACHE_VAL([ac_cv_path_$1],
     IFS="$ac_save_IFS"
 dnl If no 4th arg is given, leave the cache variable unset,
 dnl so AC_PATH_PROGS will keep looking.
-ifelse([$4], , , [  test -z "[$]ac_cv_path_$1" && ac_cv_path_$1="$4"
+m4_if([$4], , , [  test -z "[$]ac_cv_path_$1" && ac_cv_path_$1="$4"
 ])dnl
     ;;
 esac])dnl
 $1="$ac_cv_path_$1"
-if test ifelse([$4], , [-n "[$]$1"], ["[$]$1" != "$4"]); then
+if test m4_if([$4], , [-n "[$]$1"], ["[$]$1" != "$4"]); then
   AC_MSG_RESULT([$][$1])
 else
   AC_MSG_RESULT([no])
diff --git a/configure b/configure
index 493542367..eaeb3d305 100755
--- a/configure
+++ b/configure
@@ -7956,31 +7956,47 @@ fi
 # Check whether --enable-tdb was given.
 if test ${enable_tdb+y}
 then :
-  enableval=$enable_tdb; if test "$enableval" = "no"
+  enableval=$enable_tdb;
+if test "$enableval" = "no"
 then
 	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling tdb support" >&5
 printf "%s\n" "Disabling tdb support" >&6; }
-	TDB_CMT="#"
-	TDB_MAN_COMMENT='.\"'
+	CONFIG_TDB=0
 else
 	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling tdb support" >&5
 printf "%s\n" "Enabling tdb support" >&6; }
-	printf "%s\n" "#define CONFIG_TDB 1" >>confdefs.h
-
-	TDB_CMT=""
-	TDB_MAN_COMMENT=""
+	CONFIG_TDB=1
 fi
 
+
 else $as_nop
-  { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling mmp support by default" >&5
-printf "%s\n" "Enabling mmp support by default" >&6; }
-printf "%s\n" "#define CONFIG_TDB 1" >>confdefs.h
 
-TDB_CMT=""
-TDB_MAN_COMMENT=""
+case "$host_os" in
+mingw*)
+	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Disabling tdb support by default" >&5
+printf "%s\n" "Disabling tdb support by default" >&6; }
+	CONFIG_TDB=0
+	;;
+*)
+	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: Enabling tdb support by default" >&5
+printf "%s\n" "Enabling tdb support by default" >&6; }
+	CONFIG_TDB=1
+	;;
+esac
+
 
 fi
 
+if test "$CONFIG_TDB" = "1"
+then
+	printf "%s\n" "#define CONFIG_TDB 1" >>confdefs.h
+
+	TDB_CMT=""
+	TDB_MAN_COMMENT=""
+else
+	TDB_CMT="#"
+	TDB_MAN_COMMENT='.\"'
+fi
 
 
 
@@ -8660,7 +8676,7 @@ else $as_nop
       *-*-aix*)
         cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
-#if defined __powerpc64__ || defined _ARCH_PPC64
+#if defined __powerpc64__ || defined __LP64__
                 int ok;
                #else
                 error fail
@@ -8951,7 +8967,7 @@ rm -f core conftest.err conftest.$ac_objext conftest.beam conftest.$ac_ext
            # be generating 64-bit code.
            cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
-#if defined __powerpc64__ || defined _ARCH_PPC64
+#if defined __powerpc64__ || defined __LP64__
                    int ok;
                   #else
                    error fail
@@ -9058,7 +9074,7 @@ then :
 else $as_nop
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
-#ifdef __ELF__
+#if defined __ELF__ || (defined __linux__ && defined __EDG__)
         Extensible Linking Format
         #endif
 
@@ -9076,7 +9092,7 @@ rm -rf conftest*
 fi
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: $gl_cv_elf" >&5
 printf "%s\n" "$gl_cv_elf" >&6; }
-  if test $gl_cv_elf; then
+  if test $gl_cv_elf = yes; then
     # Extract the ELF class of a file (5th byte) in decimal.
     # Cf. https://en.wikipedia.org/wiki/Executable_and_Linkable_Format#File_header
     if od -A x < /dev/null >/dev/null 2>/dev/null; then
@@ -9093,19 +9109,22 @@ printf "%s\n" "$gl_cv_elf" >&6; }
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
@@ -9635,7 +9654,14 @@ fi
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
@@ -9997,8 +10023,9 @@ int
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
@@ -10580,7 +10607,14 @@ fi
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
@@ -12117,6 +12151,22 @@ then :
 
 fi
 
+case "$host_os" in
+mingw*)
+	# The above checks only detect system headers, not the headers in
+	# ./include/mingw/, so explicitly define them to be available.
+	printf "%s\n" "#define HAVE_LINUX_TYPES_H 1" >>confdefs.h
+
+	printf "%s\n" "#define HAVE_SYS_STAT_H 1" >>confdefs.h
+
+	printf "%s\n" "#define HAVE_SYS_SYSMACROS_H 1" >>confdefs.h
+
+	printf "%s\n" "#define HAVE_SYS_TYPES_H 1" >>confdefs.h
+
+	printf "%s\n" "#define HAVE_UNISTD_H 1" >>confdefs.h
+
+	;;
+esac
 { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for a dd(1) program that supports iflag=fullblock" >&5
 printf %s "checking for a dd(1) program that supports iflag=fullblock... " >&6; }
 DD=
@@ -14963,6 +15013,11 @@ fi
 if test -n "$WITH_DIET_LIBC" ; then
 	INCLUDES="$INCLUDES -D_REENTRANT"
 fi
+case "$host_os" in
+mingw*)
+	INCLUDES=$INCLUDES' -I$(top_srcdir)/include/mingw'
+	;;
+esac
 
 if test $cross_compiling = no; then
    BUILD_CFLAGS="$CFLAGS $CPPFLAGS $INCLUDES -DHAVE_CONFIG_H"
@@ -15268,7 +15323,7 @@ fi
 
 OS_IO_FILE=""
 case "$host_os" in
-  cigwin*|mingw*|msys*)
+  mingw*)
     OS_IO_FILE=windows_io
   ;;
   *)
@@ -16692,7 +16747,9 @@ printf "%s\n" "$as_me: executing $ac_file commands" >&6;}
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
diff --git a/lib/config.h.in b/lib/config.h.in
index b5856bb57..cba347b49 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -220,12 +220,12 @@
 /* Define to 1 if you have the `memalign' function. */
 #undef HAVE_MEMALIGN
 
-/* Define to 1 if you have the <memory.h> header file. */
-#undef HAVE_MEMORY_H
-
 /* Define to 1 if you have the `mempcpy' function. */
 #undef HAVE_MEMPCPY
 
+/* Define to 1 if you have the <minix/config.h> header file. */
+#undef HAVE_MINIX_CONFIG_H
+
 /* Define to 1 if you have the `mmap' function. */
 #undef HAVE_MMAP
 
@@ -343,6 +343,9 @@
 /* Define to 1 if you have the <stdint.h> header file. */
 #undef HAVE_STDINT_H
 
+/* Define to 1 if you have the <stdio.h> header file. */
+#undef HAVE_STDIO_H
+
 /* Define to 1 if you have the <stdlib.h> header file. */
 #undef HAVE_STDLIB_H
 
@@ -478,6 +481,9 @@
 /* Define to 1 if you have the `vprintf' function. */
 #undef HAVE_VPRINTF
 
+/* Define to 1 if you have the <wchar.h> header file. */
+#undef HAVE_WCHAR_H
+
 /* Define to 1 if you have the `__secure_getenv' function. */
 #undef HAVE___SECURE_GETENV
 
@@ -524,7 +530,9 @@
 /* The size of `time_t', as computed by sizeof. */
 #undef SIZEOF_TIME_T
 
-/* Define to 1 if you have the ANSI C header files. */
+/* Define to 1 if all of the C90 standard headers exist (not just the ones
+   required in a freestanding environment). This macro is provided for
+   backward compatibility; new code need not use it. */
 #undef STDC_HEADERS
 
 /* If the compiler supports a TLS storage class define it to that here */
@@ -534,21 +542,87 @@
 #ifndef _ALL_SOURCE
 # undef _ALL_SOURCE
 #endif
+/* Enable general extensions on macOS.  */
+#ifndef _DARWIN_C_SOURCE
+# undef _DARWIN_C_SOURCE
+#endif
+/* Enable general extensions on Solaris.  */
+#ifndef __EXTENSIONS__
+# undef __EXTENSIONS__
+#endif
 /* Enable GNU extensions on systems that have them.  */
 #ifndef _GNU_SOURCE
 # undef _GNU_SOURCE
 #endif
-/* Enable threading extensions on Solaris.  */
+/* Enable X/Open compliant socket functions that do not require linking
+   with -lxnet on HP-UX 11.11.  */
+#ifndef _HPUX_ALT_XOPEN_SOCKET_API
+# undef _HPUX_ALT_XOPEN_SOCKET_API
+#endif
+/* Identify the host operating system as Minix.
+   This macro does not affect the system headers' behavior.
+   A future release of Autoconf may stop defining this macro.  */
+#ifndef _MINIX
+# undef _MINIX
+#endif
+/* Enable general extensions on NetBSD.
+   Enable NetBSD compatibility extensions on Minix.  */
+#ifndef _NETBSD_SOURCE
+# undef _NETBSD_SOURCE
+#endif
+/* Enable OpenBSD compatibility extensions on NetBSD.
+   Oddly enough, this does nothing on OpenBSD.  */
+#ifndef _OPENBSD_SOURCE
+# undef _OPENBSD_SOURCE
+#endif
+/* Define to 1 if needed for POSIX-compatible behavior.  */
+#ifndef _POSIX_SOURCE
+# undef _POSIX_SOURCE
+#endif
+/* Define to 2 if needed for POSIX-compatible behavior.  */
+#ifndef _POSIX_1_SOURCE
+# undef _POSIX_1_SOURCE
+#endif
+/* Enable POSIX-compatible threading on Solaris.  */
 #ifndef _POSIX_PTHREAD_SEMANTICS
 # undef _POSIX_PTHREAD_SEMANTICS
 #endif
+/* Enable extensions specified by ISO/IEC TS 18661-5:2014.  */
+#ifndef __STDC_WANT_IEC_60559_ATTRIBS_EXT__
+# undef __STDC_WANT_IEC_60559_ATTRIBS_EXT__
+#endif
+/* Enable extensions specified by ISO/IEC TS 18661-1:2014.  */
+#ifndef __STDC_WANT_IEC_60559_BFP_EXT__
+# undef __STDC_WANT_IEC_60559_BFP_EXT__
+#endif
+/* Enable extensions specified by ISO/IEC TS 18661-2:2015.  */
+#ifndef __STDC_WANT_IEC_60559_DFP_EXT__
+# undef __STDC_WANT_IEC_60559_DFP_EXT__
+#endif
+/* Enable extensions specified by ISO/IEC TS 18661-4:2015.  */
+#ifndef __STDC_WANT_IEC_60559_FUNCS_EXT__
+# undef __STDC_WANT_IEC_60559_FUNCS_EXT__
+#endif
+/* Enable extensions specified by ISO/IEC TS 18661-3:2015.  */
+#ifndef __STDC_WANT_IEC_60559_TYPES_EXT__
+# undef __STDC_WANT_IEC_60559_TYPES_EXT__
+#endif
+/* Enable extensions specified by ISO/IEC TR 24731-2:2010.  */
+#ifndef __STDC_WANT_LIB_EXT2__
+# undef __STDC_WANT_LIB_EXT2__
+#endif
+/* Enable extensions specified by ISO/IEC 24747:2009.  */
+#ifndef __STDC_WANT_MATH_SPEC_FUNCS__
+# undef __STDC_WANT_MATH_SPEC_FUNCS__
+#endif
 /* Enable extensions on HP NonStop.  */
 #ifndef _TANDEM_SOURCE
 # undef _TANDEM_SOURCE
 #endif
-/* Enable general extensions on Solaris.  */
-#ifndef __EXTENSIONS__
-# undef __EXTENSIONS__
+/* Enable X/Open extensions.  Define to 500 only if necessary
+   to make mbstate_t available.  */
+#ifndef _XOPEN_SOURCE
+# undef _XOPEN_SOURCE
 #endif
 
 
@@ -573,14 +647,4 @@
 /* Define to 1 if Apple Darwin libintl workaround is needed */
 #undef _INTL_REDIRECT_MACROS
 
-/* Define to 1 if on MINIX. */
-#undef _MINIX
-
-/* Define to 2 if the system does not provide POSIX.1 features except with
-   this defined. */
-#undef _POSIX_1_SOURCE
-
-/* Define to 1 if you need to in order for `stat' and other things to work. */
-#undef _POSIX_SOURCE
-
 #include <dirpaths.h>
-- 
2.39.0

