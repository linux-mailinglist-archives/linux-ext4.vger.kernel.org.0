Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B072F569C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 02:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbhANBtv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 20:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbhANA2k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 19:28:40 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048BC06179F
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:27:59 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id n13so3016514qkn.2
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=bONez1YYjcL9M1MIsuU/cQ+zmt6KWK6fxXSmTNWPuCY=;
        b=mfenOg/ieRGIm+rMfsZccqf+OqdWR1/Nbtt9nSGUanhzD5AB8yuZPxzkS76dYfyaKc
         0on/sDfFJlXczpqM/AL7JqIhHRJHxzmJ1arDq3/P+6E8qCddpoIAjCEUqXdZbyB5Q+BV
         mrkfoCBgzTBOJNCK5rfFoQF9rDDUaPnh1w2pvK3GLpgtHIshhM8PhkeSj5MNrNe91z27
         YYlWQ1WMQa6ydPnd7ZTBJmYJ32YScAK2wK0LtlU7ShWla8c6YJoUgWuLFjUjJP/YAJ4m
         gxBtVzAe/knIV1roTc45KMgZNsshq/9GyF6/gizIdvhWGGJVSUgBP8+qyrnDeWI8yqEb
         hEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bONez1YYjcL9M1MIsuU/cQ+zmt6KWK6fxXSmTNWPuCY=;
        b=HoegR5X9rU2p5sKEzckCUd0VUSpAGypwhx0krqzy1V+TGr1ebEnypWpXvbS7NV41Q9
         FAx2iPo/j28s/kuydTPokmjS/vPcaachhriL02W6hOxNWpiduNldid3Qx7JQnfBT2XRB
         e+eD55ud6aeZBd5fAShA8TSXUPoNC74Eo7EH4YOpnDUrUwj2XFOnQSCSAXj3XxWD+L+l
         vu7zhP5Ih7hSFA839hpBt3CfWkA+g+EEi0iybWr+OYTqpdS9fQTm/0Jm72m6T72GLP7P
         u39peD0Qtmi+uFQo+cYNkbk77JG1c6n3oO6UYSsQ/8kgIWbmlxCay7ha6urZKlI2pFeH
         Qwqw==
X-Gm-Message-State: AOAM531cfaqniuzUcVzwguB8mvFJkTPSdsMgw+12KwnHxnZ9Y/smN+Of
        SUpEs+7rvhB0BnZPjv58ZlYToDosBSepmZG4zBuE8zGiYu/vYRB8s+PhRYlYVL5MNCspgwMZFya
        LQ93uDYhrujnkzjaHDuB5UF8prT8/2fYws9M/X8lY2T0KiBrUJZKLuDCiM5V0c1oec99zJXLlem
        3ZxhqH5Tk=
X-Google-Smtp-Source: ABdhPJxe+hjqkCaGVJnPYilYV/qGblt40uz4x5CCayMlux7N6eT0twG6iSfcUmsVWcd6r/FMOm18f23QYZbdtNOzmaY=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef5:75ee])
 (user=saranyamohan job=sendgmr) by 2002:a25:190b:: with SMTP id
 11mr6720072ybz.236.1610584078931; Wed, 13 Jan 2021 16:27:58 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:27:19 -0800
In-Reply-To: <20210114002723.643589-1-saranyamohan@google.com>
Message-Id: <20210114002723.643589-2-saranyamohan@google.com>
Mime-Version: 1.0
References: <20210114002723.643589-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v1 1/5] Add configure and build support for the pthreads library
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

Support for pthreads can be forcibly disabled by passing
"--without-pthread" to the configure script.

The actual changes in this commit are in configure.ac and MCONFIG.in;
the other files were generated as a result of running aclocal,
autoconf, and autoheader on a Debian testing system.

Note: the autoconf-archive package must now be installed before
rerunning aclocal, to supply the AX_PTHREAD macro.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 MCONFIG.in      |  12 +-
 aclocal.m4      | 560 +++++++++++++++++++++++++++++++-----------------
 configure       | 213 ++++++++++++++----
 configure.ac    |  24 +++
 lib/config.h.in |  83 +++++--
 5 files changed, 636 insertions(+), 256 deletions(-)

diff --git a/MCONFIG.in b/MCONFIG.in
index 0598f21b..69f30674 100644
--- a/MCONFIG.in
+++ b/MCONFIG.in
@@ -86,15 +86,17 @@ SYSTEMD_SYSTEM_UNIT_DIR =3D @systemd_system_unit_dir@
 SANITIZER_CFLAGS =3D @lto_cflags@ @ubsan_cflags@ @addrsan_cflags@ @threads=
an_cflags@
 SANITIZER_LDFLAGS =3D @lto_ldflags@ @ubsan_ldflags@ @addrsan_ldflags@ @thr=
eadsan_ldflags@
=20
-CC =3D @CC@
+CC =3D @PTHREAD_CC@
 BUILD_CC =3D @BUILD_CC@
+PTHREAD_CFLAGS =3D @PTHREAD_CFLAGS@
+PTHREAD_LIBS =3D @PTHREAD_LIBS@
 CFLAGS =3D @CFLAGS@
 CFLAGS_SHLIB =3D @CFLAGS_SHLIB@
 CFLAGS_STLIB =3D @CFLAGS_STLIB@
 CPPFLAGS =3D @INCLUDES@
-ALL_CFLAGS =3D $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS) $(CFLAGS_WARN) @D=
EFS@ $(LOCAL_CFLAGS)
-ALL_CFLAGS_SHLIB =3D $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_SHLIB) $(CFL=
AGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
-ALL_CFLAGS_STLIB =3D $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_STLIB) $(CFL=
AGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
+ALL_CFLAGS =3D $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS) $(PTHREAD_CFLAGS)=
 $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
+ALL_CFLAGS_SHLIB =3D $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_SHLIB) $(PTH=
READ_CFLAGS) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
+ALL_CFLAGS_STLIB =3D $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_STLIB) $(PTH=
READ_CFLAGS) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
 LDFLAGS =3D $(SANITIZER_LDFLAGS) @LDFLAGS@
 LDFLAGS_SHLIB =3D $(SANITIZER_LDFLAGS) @LDFLAGS_SHLIB@
 ALL_LDFLAGS =3D $(LDFLAGS) @LDFLAG_DYNAMIC@
@@ -139,7 +141,7 @@ LIBFUSE =3D @FUSE_LIB@
 LIBSUPPORT =3D $(LIBINTL) $(LIB)/libsupport@STATIC_LIB_EXT@
 LIBBLKID =3D @LIBBLKID@ @PRIVATE_LIBS_CMT@ $(LIBUUID)
 LIBINTL =3D @LIBINTL@
-SYSLIBS =3D @LIBS@
+SYSLIBS =3D @LIBS@ @PTHREAD_LIBS@
 DEPLIBSS =3D $(LIB)/libss@LIB_EXT@
 DEPLIBCOM_ERR =3D $(LIB)/libcom_err@LIB_EXT@
 DEPLIBUUID =3D @DEPLIBUUID@
diff --git a/aclocal.m4 b/aclocal.m4
index 394e90d2..af47cc8a 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -1,6 +1,6 @@
-# generated automatically by aclocal 1.14.1 -*- Autoconf -*-
+# generated automatically by aclocal 1.16.2 -*- Autoconf -*-
=20
-# Copyright (C) 1996-2013 Free Software Foundation, Inc.
+# Copyright (C) 1996-2020 Free Software Foundation, Inc.
=20
 # This file is free software; the Free Software Foundation
 # gives unlimited permission to copy and/or distribute it,
@@ -13,7 +13,8 @@
=20
 m4_ifndef([AC_CONFIG_MACRO_DIRS], [m4_defun([_AM_CONFIG_MACRO_DIRS], [])m4=
_defun([AC_CONFIG_MACRO_DIRS], [_AM_CONFIG_MACRO_DIRS($@)])])
 # codeset.m4 serial 5 (gettext-0.18.2)
-dnl Copyright (C) 2000-2002, 2006, 2008-2013 Free Software Foundation, Inc=
.
+dnl Copyright (C) 2000-2002, 2006, 2008-2014, 2016 Free Software Foundatio=
n,
+dnl Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -38,7 +39,7 @@ AC_DEFUN([AM_LANGINFO_CODESET],
=20
 dnl 'extern inline' a la ISO C99.
=20
-dnl Copyright 2012-2013 Free Software Foundation, Inc.
+dnl Copyright 2012-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -57,43 +58,75 @@ AC_DEFUN([gl_EXTERN_INLINE],
    'reference to static identifier "f" in extern inline function'.
    This bug was observed with Sun C 5.12 SunOS_i386 2011/11/16.
=20
-   Suppress the use of extern inline on Apple's platforms, as Libc at leas=
t
-   through Libc-825.26 (2013-04-09) is incompatible with it; see, e.g.,
-   <http://lists.gnu.org/archive/html/bug-gnulib/2012-12/msg00023.html>.
-   Perhaps Apple will fix this some day.  */
+   Suppress extern inline (with or without __attribute__ ((__gnu_inline__)=
))
+   on configurations that mistakenly use 'static inline' to implement
+   functions or macros in standard C headers like <ctype.h>.  For example,
+   if isdigit is mistakenly implemented via a static inline function,
+   a program containing an extern inline function that calls isdigit
+   may not work since the C standard prohibits extern inline functions
+   from calling static functions.  This bug is known to occur on:
+
+     OS X 10.8 and earlier; see:
+     http://lists.gnu.org/archive/html/bug-gnulib/2012-12/msg00023.html
+
+     DragonFly; see
+     http://muscles.dragonflybsd.org/bulk/bleeding-edge-potential/latest-p=
er-pkg/ah-tty-0.3.12.log
+
+     FreeBSD; see:
+     http://lists.gnu.org/archive/html/bug-gnulib/2014-07/msg00104.html
+
+   OS X 10.9 has a macro __header_inline indicating the bug is fixed for C=
 and
+   for clang but remains for g++; see <http://trac.macports.org/ticket/410=
33>.
+   Assume DragonFly and FreeBSD will be similar.  */
+#if (((defined __APPLE__ && defined __MACH__) \
+      || defined __DragonFly__ || defined __FreeBSD__) \
+     && (defined __header_inline \
+         ? (defined __cplusplus && defined __GNUC_STDC_INLINE__ \
+            && ! defined __clang__) \
+         : ((! defined _DONT_USE_CTYPE_INLINE_ \
+             && (defined __GNUC__ || defined __cplusplus)) \
+            || (defined _FORTIFY_SOURCE && 0 < _FORTIFY_SOURCE \
+                && defined __GNUC__ && ! defined __cplusplus))))
+# define _GL_EXTERN_INLINE_STDHEADER_BUG
+#endif
 #if ((__GNUC__ \
       ? defined __GNUC_STDC_INLINE__ && __GNUC_STDC_INLINE__ \
       : (199901L <=3D __STDC_VERSION__ \
          && !defined __HP_cc \
+         && !defined __PGI \
          && !(defined __SUNPRO_C && __STDC__))) \
-     && !defined __APPLE__)
+     && !defined _GL_EXTERN_INLINE_STDHEADER_BUG)
 # define _GL_INLINE inline
 # define _GL_EXTERN_INLINE extern inline
+# define _GL_EXTERN_INLINE_IN_USE
 #elif (2 < __GNUC__ + (7 <=3D __GNUC_MINOR__) && !defined __STRICT_ANSI__ =
\
-       && !defined __APPLE__)
-# if __GNUC_GNU_INLINE__
+       && !defined _GL_EXTERN_INLINE_STDHEADER_BUG)
+# if defined __GNUC_GNU_INLINE__ && __GNUC_GNU_INLINE__
    /* __gnu_inline__ suppresses a GCC 4.2 diagnostic.  */
 #  define _GL_INLINE extern inline __attribute__ ((__gnu_inline__))
 # else
 #  define _GL_INLINE extern inline
 # endif
 # define _GL_EXTERN_INLINE extern
+# define _GL_EXTERN_INLINE_IN_USE
 #else
 # define _GL_INLINE static _GL_UNUSED
 # define _GL_EXTERN_INLINE static _GL_UNUSED
 #endif
=20
-#if 4 < __GNUC__ + (6 <=3D __GNUC_MINOR__)
+/* In GCC 4.6 (inclusive) to 5.1 (exclusive),
+   suppress bogus "no previous prototype for 'FOO'"
+   and "no previous declaration for 'FOO'" diagnostics,
+   when FOO is an inline function in the header; see
+   <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D54113> and
+   <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63877>.  */
+#if __GNUC__ =3D=3D 4 && 6 <=3D __GNUC_MINOR__
 # if defined __GNUC_STDC_INLINE__ && __GNUC_STDC_INLINE__
 #  define _GL_INLINE_HEADER_CONST_PRAGMA
 # else
 #  define _GL_INLINE_HEADER_CONST_PRAGMA \
      _Pragma ("GCC diagnostic ignored \"-Wsuggest-attribute=3Dconst\"")
 # endif
-  /* Suppress GCC's bogus "no previous prototype for 'FOO'"
-     and "no previous declaration for 'FOO'"  diagnostics,
-     when FOO is an inline function in the header; see
-     <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D54113>.  */
 # define _GL_INLINE_HEADER_BEGIN \
     _Pragma ("GCC diagnostic push") \
     _Pragma ("GCC diagnostic ignored \"-Wmissing-prototypes\"") \
@@ -108,7 +141,7 @@ AC_DEFUN([gl_EXTERN_INLINE],
 ])
=20
 # fcntl-o.m4 serial 4
-dnl Copyright (C) 2006, 2009-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2006, 2009-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -242,19 +275,19 @@ AC_DEFUN([gl_FCNTL_O_FLAGS],
     [Define to 1 if O_NOFOLLOW works.])
 ])
=20
-# gettext.m4 serial 66 (gettext-0.18.2)
-dnl Copyright (C) 1995-2013 Free Software Foundation, Inc.
+# gettext.m4 serial 68 (gettext-0.19.8)
+dnl Copyright (C) 1995-2014, 2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
 dnl
-dnl This file can can be used in projects which are not available under
+dnl This file can be used in projects which are not available under
 dnl the GNU General Public License or the GNU Library General Public
 dnl License but which still want to provide support for the GNU gettext
 dnl functionality.
 dnl Please note that the actual code of the GNU gettext library is covered
 dnl by the GNU Library General Public License, and the rest of the GNU
-dnl gettext package package is covered by the GNU General Public License.
+dnl gettext package is covered by the GNU General Public License.
 dnl They are *not* in the public domain.
=20
 dnl Authors:
@@ -405,13 +438,18 @@ changequote([,])dnl
             [AC_LANG_PROGRAM(
                [[
 #include <libintl.h>
-$gt_revision_test_code
+#ifndef __GNU_GETTEXT_SUPPORTED_REVISION
 extern int _nl_msg_cat_cntr;
 extern int *_nl_domain_bindings;
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION (_nl_msg_cat_cntr + *_nl_domain_bi=
ndings)
+#else
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION 0
+#endif
+$gt_revision_test_code
                ]],
                [[
 bindtextdomain ("", "");
-return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_do=
main_bindings
+return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRE=
SSION
                ]])],
             [eval "$gt_func_gnugettext_libc=3Dyes"],
             [eval "$gt_func_gnugettext_libc=3Dno"])])
@@ -437,17 +475,22 @@ return * gettext ("")$gt_expression_test_code + _nl_m=
sg_cat_cntr + *_nl_domain_b
               [AC_LANG_PROGRAM(
                  [[
 #include <libintl.h>
-$gt_revision_test_code
+#ifndef __GNU_GETTEXT_SUPPORTED_REVISION
 extern int _nl_msg_cat_cntr;
 extern
 #ifdef __cplusplus
 "C"
 #endif
 const char *_nl_expand_alias (const char *);
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION (_nl_msg_cat_cntr + *_nl_expand_al=
ias (""))
+#else
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION 0
+#endif
+$gt_revision_test_code
                  ]],
                  [[
 bindtextdomain ("", "");
-return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_ex=
pand_alias ("")
+return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRE=
SSION
                  ]])],
               [eval "$gt_func_gnugettext_libintl=3Dyes"],
               [eval "$gt_func_gnugettext_libintl=3Dno"])
@@ -458,17 +501,22 @@ return * gettext ("")$gt_expression_test_code + _nl_m=
sg_cat_cntr + *_nl_expand_a
                 [AC_LANG_PROGRAM(
                    [[
 #include <libintl.h>
-$gt_revision_test_code
+#ifndef __GNU_GETTEXT_SUPPORTED_REVISION
 extern int _nl_msg_cat_cntr;
 extern
 #ifdef __cplusplus
 "C"
 #endif
 const char *_nl_expand_alias (const char *);
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION (_nl_msg_cat_cntr + *_nl_expand_al=
ias (""))
+#else
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION 0
+#endif
+$gt_revision_test_code
                    ]],
                    [[
 bindtextdomain ("", "");
-return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_ex=
pand_alias ("")
+return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRE=
SSION
                    ]])],
                 [LIBINTL=3D"$LIBINTL $LIBICONV"
                  LTLIBINTL=3D"$LTLIBINTL $LTLIBICONV"
@@ -644,8 +692,12 @@ AC_DEFUN([AM_GNU_GETTEXT_NEED],
 dnl Usage: AM_GNU_GETTEXT_VERSION([gettext-version])
 AC_DEFUN([AM_GNU_GETTEXT_VERSION], [])
=20
+
+dnl Usage: AM_GNU_GETTEXT_REQUIRE_VERSION([gettext-version])
+AC_DEFUN([AM_GNU_GETTEXT_REQUIRE_VERSION], [])
+
 # glibc2.m4 serial 3
-dnl Copyright (C) 2000-2002, 2004, 2008, 2010-2013 Free Software Foundatio=
n,
+dnl Copyright (C) 2000-2002, 2004, 2008, 2010-2016 Free Software Foundatio=
n,
 dnl Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
@@ -677,7 +729,7 @@ AC_DEFUN([gt_GLIBC2],
 )
=20
 # glibc21.m4 serial 5
-dnl Copyright (C) 2000-2002, 2004, 2008, 2010-2013 Free Software Foundatio=
n,
+dnl Copyright (C) 2000-2002, 2004, 2008, 2010-2016 Free Software Foundatio=
n,
 dnl Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
@@ -711,8 +763,8 @@ AC_DEFUN([gl_GLIBC21],
   ]
 )
=20
-# iconv.m4 serial 18 (gettext-0.18.2)
-dnl Copyright (C) 2000-2002, 2007-2013 Free Software Foundation, Inc.
+# iconv.m4 serial 19 (gettext-0.18.2)
+dnl Copyright (C) 2000-2002, 2007-2014, 2016 Free Software Foundation, Inc=
.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -785,27 +837,33 @@ AC_DEFUN([AM_ICONV_LINK],
       if test $am_cv_lib_iconv =3D yes; then
         LIBS=3D"$LIBS $LIBICONV"
       fi
-      AC_RUN_IFELSE(
-        [AC_LANG_SOURCE([[
+      am_cv_func_iconv_works=3Dno
+      for ac_iconv_const in '' 'const'; do
+        AC_RUN_IFELSE(
+          [AC_LANG_PROGRAM(
+             [[
 #include <iconv.h>
 #include <string.h>
-int main ()
-{
-  int result =3D 0;
+
+#ifndef ICONV_CONST
+# define ICONV_CONST $ac_iconv_const
+#endif
+             ]],
+             [[int result =3D 0;
   /* Test against AIX 5.1 bug: Failures are not distinguishable from succe=
ssful
      returns.  */
   {
     iconv_t cd_utf8_to_88591 =3D iconv_open ("ISO8859-1", "UTF-8");
     if (cd_utf8_to_88591 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\342\202\254"; /* EURO SIGN */
+        static ICONV_CONST char input[] =3D "\342\202\254"; /* EURO SIGN *=
/
         char buf[10];
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D strlen (input);
         char *outptr =3D buf;
         size_t outbytesleft =3D sizeof (buf);
         size_t res =3D iconv (cd_utf8_to_88591,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if (res =3D=3D 0)
           result |=3D 1;
@@ -818,14 +876,14 @@ int main ()
     iconv_t cd_ascii_to_88591 =3D iconv_open ("ISO8859-1", "646");
     if (cd_ascii_to_88591 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\263";
+        static ICONV_CONST char input[] =3D "\263";
         char buf[10];
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D strlen (input);
         char *outptr =3D buf;
         size_t outbytesleft =3D sizeof (buf);
         size_t res =3D iconv (cd_ascii_to_88591,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if (res =3D=3D 0)
           result |=3D 2;
@@ -837,14 +895,14 @@ int main ()
     iconv_t cd_88591_to_utf8 =3D iconv_open ("UTF-8", "ISO-8859-1");
     if (cd_88591_to_utf8 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\304";
+        static ICONV_CONST char input[] =3D "\304";
         static char buf[2] =3D { (char)0xDE, (char)0xAD };
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D 1;
         char *outptr =3D buf;
         size_t outbytesleft =3D 1;
         size_t res =3D iconv (cd_88591_to_utf8,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if (res !=3D (size_t)(-1) || outptr - buf > 1 || buf[1] !=3D (char=
)0xAD)
           result |=3D 4;
@@ -857,14 +915,14 @@ int main ()
     iconv_t cd_88591_to_utf8 =3D iconv_open ("utf8", "iso88591");
     if (cd_88591_to_utf8 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\304rger mit b\366sen B\374bchen oh=
ne Augenma\337";
+        static ICONV_CONST char input[] =3D "\304rger mit b\366sen B\374bc=
hen ohne Augenma\337";
         char buf[50];
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D strlen (input);
         char *outptr =3D buf;
         size_t outbytesleft =3D sizeof (buf);
         size_t res =3D iconv (cd_88591_to_utf8,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if ((int)res > 0)
           result |=3D 8;
@@ -884,17 +942,14 @@ int main ()
       && iconv_open ("utf8", "eucJP") =3D=3D (iconv_t)(-1))
     result |=3D 16;
   return result;
-}]])],
-        [am_cv_func_iconv_works=3Dyes],
-        [am_cv_func_iconv_works=3Dno],
-        [
-changequote(,)dnl
-         case "$host_os" in
-           aix* | hpux*) am_cv_func_iconv_works=3D"guessing no" ;;
-           *)            am_cv_func_iconv_works=3D"guessing yes" ;;
-         esac
-changequote([,])dnl
-        ])
+]])],
+          [am_cv_func_iconv_works=3Dyes], ,
+          [case "$host_os" in
+             aix* | hpux*) am_cv_func_iconv_works=3D"guessing no" ;;
+             *)            am_cv_func_iconv_works=3D"guessing yes" ;;
+           esac])
+        test "$am_cv_func_iconv_works" =3D no || break
+      done
       LIBS=3D"$am_save_LIBS"
     ])
     case "$am_cv_func_iconv_works" in
@@ -981,7 +1036,7 @@ size_t iconv();
 ])
=20
 # intdiv0.m4 serial 6 (gettext-0.18.2)
-dnl Copyright (C) 2002, 2007-2008, 2010-2013 Free Software Foundation, Inc=
.
+dnl Copyright (C) 2002, 2007-2008, 2010-2016 Free Software Foundation, Inc=
.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1020,7 +1075,7 @@ static void
 sigfpe_handler (int sig)
 {
   /* Exit with code 0 if SIGFPE, with code 1 if any other signal.  */
-  exit (sig !=3D SIGFPE);
+  _exit (sig !=3D SIGFPE);
 }
=20
 int x =3D 1;
@@ -1068,19 +1123,19 @@ changequote([,])dnl
     [Define if integer division by zero raises signal SIGFPE.])
 ])
=20
-# intl.m4 serial 25 (gettext-0.18.3)
-dnl Copyright (C) 1995-2013 Free Software Foundation, Inc.
+# intl.m4 serial 29 (gettext-0.19)
+dnl Copyright (C) 1995-2014, 2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
 dnl
-dnl This file can can be used in projects which are not available under
+dnl This file can be used in projects which are not available under
 dnl the GNU General Public License or the GNU Library General Public
 dnl License but which still want to provide support for the GNU gettext
 dnl functionality.
 dnl Please note that the actual code of the GNU gettext library is covered
 dnl by the GNU Library General Public License, and the rest of the GNU
-dnl gettext package package is covered by the GNU General Public License.
+dnl gettext package is covered by the GNU General Public License.
 dnl They are *not* in the public domain.
=20
 dnl Authors:
@@ -1113,6 +1168,7 @@ AC_DEFUN([AM_INTL_SUBDIR],
   AC_REQUIRE([gl_FCNTL_O_FLAGS])dnl
   AC_REQUIRE([gt_INTL_MACOSX])dnl
   AC_REQUIRE([gl_EXTERN_INLINE])dnl
+  AC_REQUIRE([gt_GL_ATTRIBUTE])dnl
=20
   dnl Support for automake's --enable-silent-rules.
   case "$enable_silent_rules" in
@@ -1301,6 +1357,12 @@ AC_DEFUN([gt_INTL_SUBDIR_CORE],
     stpcpy strcasecmp strdup strtoul tsearch uselocale argz_count \
     argz_stringify argz_next __fsetlocking])
=20
+  dnl Solaris 12 provides getlocalename_l, while Illumos doesn't have
+  dnl it nor the equivalent.
+  if test $ac_cv_func_uselocale =3D yes; then
+    AC_CHECK_FUNCS([getlocalename_l])
+  fi
+
   dnl Use the *_unlocked functions only if they are declared.
   dnl (because some of them were defined without being declared in Solaris
   dnl 2.5.1 but were removed in Solaris 2.6, whereas we want binaries buil=
t
@@ -1311,8 +1373,7 @@ AC_DEFUN([gt_INTL_SUBDIR_CORE],
=20
   dnl intl/plural.c is generated from intl/plural.y. It requires bison,
   dnl because plural.y uses bison specific features. It requires at least
-  dnl bison-1.26 because earlier versions generate a plural.c that doesn't
-  dnl compile.
+  dnl bison-2.7 for %define api.pure.
   dnl bison is only needed for the maintainer (who touches plural.y). But =
in
   dnl order to avoid separate Makefiles or --enable-maintainer-mode, we pu=
t
   dnl the rule in general Makefile. Now, some people carelessly touch the
@@ -1329,7 +1390,7 @@ changequote(<<,>>)dnl
     ac_prog_version=3D`$INTLBISON --version 2>&1 | sed -n 's/^.*GNU Bison.=
* \([0-9]*\.[0-9.]*\).*$/\1/p'`
     case $ac_prog_version in
       '') ac_prog_version=3D"v. ?.??, bad"; ac_verc_fail=3Dyes;;
-      1.2[6-9]* | 1.[3-9][0-9]* | [2-9].*)
+      2.[7-9]* | [3-9].*)
 changequote([,])dnl
          ac_prog_version=3D"$ac_prog_version, ok"; ac_verc_fail=3Dno;;
       *) ac_prog_version=3D"$ac_prog_version, bad"; ac_verc_fail=3Dyes;;
@@ -1341,19 +1402,45 @@ changequote([,])dnl
   fi
 ])
=20
+dnl Copies _GL_UNUSED and _GL_ATTRIBUTE_PURE definitions from
+dnl gnulib-common.m4 as a fallback, if the project isn't using Gnulib.
+AC_DEFUN([gt_GL_ATTRIBUTE], [
+  m4_ifndef([gl_[]COMMON],
+    AH_VERBATIM([gt_gl_attribute],
+[/* Define as a marker that can be attached to declarations that might not
+    be used.  This helps to reduce warnings, such as from
+    GCC -Wunused-parameter.  */
+#ifndef _GL_UNUSED
+# if __GNUC__ >=3D 3 || (__GNUC__ =3D=3D 2 && __GNUC_MINOR__ >=3D 7)
+#  define _GL_UNUSED __attribute__ ((__unused__))
+# else
+#  define _GL_UNUSED
+# endif
+#endif
+
+/* The __pure__ attribute was added in gcc 2.96.  */
+#ifndef _GL_ATTRIBUTE_PURE
+# if __GNUC__ > 2 || (__GNUC__ =3D=3D 2 && __GNUC_MINOR__ >=3D 96)
+#  define _GL_ATTRIBUTE_PURE __attribute__ ((__pure__))
+# else
+#  define _GL_ATTRIBUTE_PURE /* empty */
+# endif
+#endif
+]))])
+
 # intlmacosx.m4 serial 5 (gettext-0.18.2)
-dnl Copyright (C) 2004-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2004-2014, 2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
 dnl
-dnl This file can can be used in projects which are not available under
+dnl This file can be used in projects which are not available under
 dnl the GNU General Public License or the GNU Library General Public
 dnl License but which still want to provide support for the GNU gettext
 dnl functionality.
 dnl Please note that the actual code of the GNU gettext library is covered
 dnl by the GNU Library General Public License, and the rest of the GNU
-dnl gettext package package is covered by the GNU General Public License.
+dnl gettext package is covered by the GNU General Public License.
 dnl They are *not* in the public domain.
=20
 dnl Checks for special options needed on Mac OS X.
@@ -1399,7 +1486,7 @@ AC_DEFUN([gt_INTL_MACOSX],
 ])
=20
 # intmax.m4 serial 6 (gettext-0.18.2)
-dnl Copyright (C) 2002-2005, 2008-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2002-2005, 2008-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1436,7 +1523,7 @@ AC_DEFUN([gt_TYPE_INTMAX_T],
 ])
=20
 # inttypes-pri.m4 serial 7 (gettext-0.18.2)
-dnl Copyright (C) 1997-2002, 2006, 2008-2013 Free Software Foundation, Inc=
.
+dnl Copyright (C) 1997-2002, 2006, 2008-2016 Free Software Foundation, Inc=
.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1479,7 +1566,7 @@ char *p =3D PRId32;
 ])
=20
 # inttypes_h.m4 serial 10
-dnl Copyright (C) 1997-2004, 2006, 2008-2013 Free Software Foundation, Inc=
.
+dnl Copyright (C) 1997-2004, 2006, 2008-2016 Free Software Foundation, Inc=
.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1509,19 +1596,19 @@ AC_DEFUN([gl_AC_HEADER_INTTYPES_H],
 ])
=20
 # lcmessage.m4 serial 7 (gettext-0.18.2)
-dnl Copyright (C) 1995-2002, 2004-2005, 2008-2013 Free Software Foundation=
,
-dnl Inc.
+dnl Copyright (C) 1995-2002, 2004-2005, 2008-2014, 2016 Free Software
+dnl Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
 dnl
-dnl This file can can be used in projects which are not available under
+dnl This file can be used in projects which are not available under
 dnl the GNU General Public License or the GNU Library General Public
 dnl License but which still want to provide support for the GNU gettext
 dnl functionality.
 dnl Please note that the actual code of the GNU gettext library is covered
 dnl by the GNU Library General Public License, and the rest of the GNU
-dnl gettext package package is covered by the GNU General Public License.
+dnl gettext package is covered by the GNU General Public License.
 dnl They are *not* in the public domain.
=20
 dnl Authors:
@@ -1545,7 +1632,7 @@ AC_DEFUN([gt_LC_MESSAGES],
 ])
=20
 # lib-ld.m4 serial 6
-dnl Copyright (C) 1996-2003, 2009-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 1996-2003, 2009-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1665,7 +1752,7 @@ AC_LIB_PROG_LD_GNU
 ])
=20
 # lib-link.m4 serial 26 (gettext-0.18.2)
-dnl Copyright (C) 2001-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2001-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -1884,7 +1971,7 @@ AC_DEFUN([AC_LIB_LINKFLAGS_BODY],
     fi
 ])
   dnl Search the library and its dependencies in $additional_libdir and
-  dnl $LDFLAGS. Using breadth-first-search.
+  dnl $LDFLAGS. Using breadth-first-seach.
   LIB[]NAME=3D
   LTLIB[]NAME=3D
   INC[]NAME=3D
@@ -2443,7 +2530,7 @@ AC_DEFUN([AC_LIB_LINKFLAGS_FROM_LIBS],
 ])
=20
 # lib-prefix.m4 serial 7 (gettext-0.18)
-dnl Copyright (C) 2001-2005, 2008-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2001-2005, 2008-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -2668,7 +2755,7 @@ sixtyfour bits
 ])
=20
 # lock.m4 serial 13 (gettext-0.18.2)
-dnl Copyright (C) 2005-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2005-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -2711,7 +2798,7 @@ return !x;
 AC_DEFUN([gl_PREREQ_LOCK], [:])
=20
 # longlong.m4 serial 17
-dnl Copyright (C) 1999-2007, 2009-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 1999-2007, 2009-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -2825,19 +2912,19 @@ AC_DEFUN([_AC_TYPE_LONG_LONG_SNIPPET],
 ])
=20
 # nls.m4 serial 5 (gettext-0.18)
-dnl Copyright (C) 1995-2003, 2005-2006, 2008-2013 Free Software Foundation=
,
-dnl Inc.
+dnl Copyright (C) 1995-2003, 2005-2006, 2008-2014, 2016 Free Software
+dnl Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
 dnl
-dnl This file can can be used in projects which are not available under
+dnl This file can be used in projects which are not available under
 dnl the GNU General Public License or the GNU Library General Public
 dnl License but which still want to provide support for the GNU gettext
 dnl functionality.
 dnl Please note that the actual code of the GNU gettext library is covered
 dnl by the GNU Library General Public License, and the rest of the GNU
-dnl gettext package package is covered by the GNU General Public License.
+dnl gettext package is covered by the GNU General Public License.
 dnl They are *not* in the public domain.
=20
 dnl Authors:
@@ -2857,32 +2944,63 @@ AC_DEFUN([AM_NLS],
   AC_SUBST([USE_NLS])
 ])
=20
-# pkg.m4 - Macros to locate and utilise pkg-config.            -*- Autocon=
f -*-
-# serial 1 (pkg-config-0.24)
-#=20
-# Copyright =C2=A9 2004 Scott James Remnant <scott@netsplit.com>.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
, USA.
-#
-# As a special exception to the GNU General Public License, if you
-# distribute this file as part of a program that contains a
-# configuration script generated by Autoconf, you may include it under
-# the same distribution terms that you use for the rest of that program.
-
-# PKG_PROG_PKG_CONFIG([MIN-VERSION])
-# ----------------------------------
+# pkg.m4 - Macros to locate and utilise pkg-config.   -*- Autoconf -*-
+# serial 12 (pkg-config-0.29.2)
+
+dnl Copyright =C2=A9 2004 Scott James Remnant <scott@netsplit.com>.
+dnl Copyright =C2=A9 2012-2015 Dan Nicholson <dbn.lists@gmail.com>
+dnl
+dnl This program is free software; you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful, but
+dnl WITHOUT ANY WARRANTY; without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+dnl General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program; if not, write to the Free Software
+dnl Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+dnl 02111-1307, USA.
+dnl
+dnl As a special exception to the GNU General Public License, if you
+dnl distribute this file as part of a program that contains a
+dnl configuration script generated by Autoconf, you may include it under
+dnl the same distribution terms that you use for the rest of that
+dnl program.
+
+dnl PKG_PREREQ(MIN-VERSION)
+dnl -----------------------
+dnl Since: 0.29
+dnl
+dnl Verify that the version of the pkg-config macros are at least
+dnl MIN-VERSION. Unlike PKG_PROG_PKG_CONFIG, which checks the user's
+dnl installed version of pkg-config, this checks the developer's version
+dnl of pkg.m4 when generating configure.
+dnl
+dnl To ensure that this macro is defined, also add:
+dnl m4_ifndef([PKG_PREREQ],
+dnl     [m4_fatal([must install pkg-config 0.29 or later before running au=
toconf/autogen])])
+dnl
+dnl See the "Since" comment for each macro you use to see what version
+dnl of the macros you require.
+m4_defun([PKG_PREREQ],
+[m4_define([PKG_MACROS_VERSION], [0.29.2])
+m4_if(m4_version_compare(PKG_MACROS_VERSION, [$1]), -1,
+    [m4_fatal([pkg.m4 version $1 or higher is required but ]PKG_MACROS_VER=
SION[ found])])
+])dnl PKG_PREREQ
+
+dnl PKG_PROG_PKG_CONFIG([MIN-VERSION])
+dnl ----------------------------------
+dnl Since: 0.16
+dnl
+dnl Search for the pkg-config tool and set the PKG_CONFIG variable to
+dnl first found in the path. Checks that the version of pkg-config found
+dnl is at least MIN-VERSION. If MIN-VERSION is not specified, 0.9.0 is
+dnl used since that's the first version where most current features of
+dnl pkg-config existed.
 AC_DEFUN([PKG_PROG_PKG_CONFIG],
 [m4_pattern_forbid([^_?PKG_[A-Z_]+$])
 m4_pattern_allow([^PKG_CONFIG(_(PATH|LIBDIR|SYSROOT_DIR|ALLOW_SYSTEM_(CFLA=
GS|LIBS)))?$])
@@ -2904,18 +3022,19 @@ if test -n "$PKG_CONFIG"; then
 		PKG_CONFIG=3D""
 	fi
 fi[]dnl
-])# PKG_PROG_PKG_CONFIG
-
-# PKG_CHECK_EXISTS(MODULES, [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
-#
-# Check to see whether a particular set of modules exists.  Similar
-# to PKG_CHECK_MODULES(), but does not set variables or print errors.
-#
-# Please remember that m4 expands AC_REQUIRE([PKG_PROG_PKG_CONFIG])
-# only at the first occurrence in configure.ac, so if the first place
-# it's called might be skipped (such as if it is within an "if", you
-# have to call PKG_CHECK_EXISTS manually
-# --------------------------------------------------------------
+])dnl PKG_PROG_PKG_CONFIG
+
+dnl PKG_CHECK_EXISTS(MODULES, [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
+dnl -------------------------------------------------------------------
+dnl Since: 0.18
+dnl
+dnl Check to see whether a particular set of modules exists. Similar to
+dnl PKG_CHECK_MODULES(), but does not set variables or print errors.
+dnl
+dnl Please remember that m4 expands AC_REQUIRE([PKG_PROG_PKG_CONFIG])
+dnl only at the first occurence in configure.ac, so if the first place
+dnl it's called might be skipped (such as if it is within an "if", you
+dnl have to call PKG_CHECK_EXISTS manually
 AC_DEFUN([PKG_CHECK_EXISTS],
 [AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
 if test -n "$PKG_CONFIG" && \
@@ -2925,8 +3044,10 @@ m4_ifvaln([$3], [else
   $3])dnl
 fi])
=20
-# _PKG_CONFIG([VARIABLE], [COMMAND], [MODULES])
-# ---------------------------------------------
+dnl _PKG_CONFIG([VARIABLE], [COMMAND], [MODULES])
+dnl ---------------------------------------------
+dnl Internal wrapper calling pkg-config via PKG_CONFIG and setting
+dnl pkg_failed based on the result.
 m4_define([_PKG_CONFIG],
 [if test -n "$$1"; then
     pkg_cv_[]$1=3D"$$1"
@@ -2938,10 +3059,11 @@ m4_define([_PKG_CONFIG],
  else
     pkg_failed=3Duntried
 fi[]dnl
-])# _PKG_CONFIG
+])dnl _PKG_CONFIG
=20
-# _PKG_SHORT_ERRORS_SUPPORTED
-# -----------------------------
+dnl _PKG_SHORT_ERRORS_SUPPORTED
+dnl ---------------------------
+dnl Internal check to see if pkg-config supports short errors.
 AC_DEFUN([_PKG_SHORT_ERRORS_SUPPORTED],
 [AC_REQUIRE([PKG_PROG_PKG_CONFIG])
 if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
@@ -2949,26 +3071,24 @@ if $PKG_CONFIG --atleast-pkgconfig-version 0.20; th=
en
 else
         _pkg_short_errors_supported=3Dno
 fi[]dnl
-])# _PKG_SHORT_ERRORS_SUPPORTED
-
-
-# PKG_CHECK_MODULES(VARIABLE-PREFIX, MODULES, [ACTION-IF-FOUND],
-# [ACTION-IF-NOT-FOUND])
-#
-#
-# Note that if there is a possibility the first call to
-# PKG_CHECK_MODULES might not happen, you should be sure to include an
-# explicit call to PKG_PROG_PKG_CONFIG in your configure.ac
-#
-#
-# --------------------------------------------------------------
+])dnl _PKG_SHORT_ERRORS_SUPPORTED
+
+
+dnl PKG_CHECK_MODULES(VARIABLE-PREFIX, MODULES, [ACTION-IF-FOUND],
+dnl   [ACTION-IF-NOT-FOUND])
+dnl --------------------------------------------------------------
+dnl Since: 0.4.0
+dnl
+dnl Note that if there is a possibility the first call to
+dnl PKG_CHECK_MODULES might not happen, you should be sure to include an
+dnl explicit call to PKG_PROG_PKG_CONFIG in your configure.ac
 AC_DEFUN([PKG_CHECK_MODULES],
 [AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
 AC_ARG_VAR([$1][_CFLAGS], [C compiler flags for $1, overriding pkg-config]=
)dnl
 AC_ARG_VAR([$1][_LIBS], [linker flags for $1, overriding pkg-config])dnl
=20
 pkg_failed=3Dno
-AC_MSG_CHECKING([for $1])
+AC_MSG_CHECKING([for $2])
=20
 _PKG_CONFIG([$1][_CFLAGS], [cflags], [$2])
 _PKG_CONFIG([$1][_LIBS], [libs], [$2])
@@ -2978,11 +3098,11 @@ and $1[]_LIBS to avoid the need to call pkg-config.
 See the pkg-config man page for more details.])
=20
 if test $pkg_failed =3D yes; then
-   	AC_MSG_RESULT([no])
+        AC_MSG_RESULT([no])
         _PKG_SHORT_ERRORS_SUPPORTED
         if test $_pkg_short_errors_supported =3D yes; then
 	        $1[]_PKG_ERRORS=3D`$PKG_CONFIG --short-errors --print-errors --cf=
lags --libs "$2" 2>&1`
-        else=20
+        else
 	        $1[]_PKG_ERRORS=3D`$PKG_CONFIG --print-errors --cflags --libs "$2=
" 2>&1`
         fi
 	# Put the nasty error message in config.log where it belongs
@@ -2999,7 +3119,7 @@ installed software in a non-standard prefix.
 _PKG_TEXT])[]dnl
         ])
 elif test $pkg_failed =3D untried; then
-     	AC_MSG_RESULT([no])
+        AC_MSG_RESULT([no])
 	m4_default([$4], [AC_MSG_FAILURE(
 [The pkg-config script could not be found or is too old.  Make sure it
 is in your PATH or set the PKG_CONFIG environment variable to the full
@@ -3015,16 +3135,40 @@ else
         AC_MSG_RESULT([yes])
 	$3
 fi[]dnl
-])# PKG_CHECK_MODULES
+])dnl PKG_CHECK_MODULES
+
+
+dnl PKG_CHECK_MODULES_STATIC(VARIABLE-PREFIX, MODULES, [ACTION-IF-FOUND],
+dnl   [ACTION-IF-NOT-FOUND])
+dnl ---------------------------------------------------------------------
+dnl Since: 0.29
+dnl
+dnl Checks for existence of MODULES and gathers its build flags with
+dnl static libraries enabled. Sets VARIABLE-PREFIX_CFLAGS from --cflags
+dnl and VARIABLE-PREFIX_LIBS from --libs.
+dnl
+dnl Note that if there is a possibility the first call to
+dnl PKG_CHECK_MODULES_STATIC might not happen, you should be sure to
+dnl include an explicit call to PKG_PROG_PKG_CONFIG in your
+dnl configure.ac.
+AC_DEFUN([PKG_CHECK_MODULES_STATIC],
+[AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
+_save_PKG_CONFIG=3D$PKG_CONFIG
+PKG_CONFIG=3D"$PKG_CONFIG --static"
+PKG_CHECK_MODULES($@)
+PKG_CONFIG=3D$_save_PKG_CONFIG[]dnl
+])dnl PKG_CHECK_MODULES_STATIC
=20
=20
-# PKG_INSTALLDIR(DIRECTORY)
-# -------------------------
-# Substitutes the variable pkgconfigdir as the location where a module
-# should install pkg-config .pc files. By default the directory is
-# $libdir/pkgconfig, but the default can be changed by passing
-# DIRECTORY. The user can override through the --with-pkgconfigdir
-# parameter.
+dnl PKG_INSTALLDIR([DIRECTORY])
+dnl -------------------------
+dnl Since: 0.27
+dnl
+dnl Substitutes the variable pkgconfigdir as the location where a module
+dnl should install pkg-config .pc files. By default the directory is
+dnl $libdir/pkgconfig, but the default can be changed by passing
+dnl DIRECTORY. The user can override through the --with-pkgconfigdir
+dnl parameter.
 AC_DEFUN([PKG_INSTALLDIR],
 [m4_pushdef([pkg_default], [m4_default([$1], ['${libdir}/pkgconfig'])])
 m4_pushdef([pkg_description],
@@ -3035,16 +3179,18 @@ AC_ARG_WITH([pkgconfigdir],
 AC_SUBST([pkgconfigdir], [$with_pkgconfigdir])
 m4_popdef([pkg_default])
 m4_popdef([pkg_description])
-]) dnl PKG_INSTALLDIR
+])dnl PKG_INSTALLDIR
=20
=20
-# PKG_NOARCH_INSTALLDIR(DIRECTORY)
-# -------------------------
-# Substitutes the variable noarch_pkgconfigdir as the location where a
-# module should install arch-independent pkg-config .pc files. By
-# default the directory is $datadir/pkgconfig, but the default can be
-# changed by passing DIRECTORY. The user can override through the
-# --with-noarch-pkgconfigdir parameter.
+dnl PKG_NOARCH_INSTALLDIR([DIRECTORY])
+dnl --------------------------------
+dnl Since: 0.27
+dnl
+dnl Substitutes the variable noarch_pkgconfigdir as the location where a
+dnl module should install arch-independent pkg-config .pc files. By
+dnl default the directory is $datadir/pkgconfig, but the default can be
+dnl changed by passing DIRECTORY. The user can override through the
+dnl --with-noarch-pkgconfigdir parameter.
 AC_DEFUN([PKG_NOARCH_INSTALLDIR],
 [m4_pushdef([pkg_default], [m4_default([$1], ['${datadir}/pkgconfig'])])
 m4_pushdef([pkg_description],
@@ -3055,13 +3201,15 @@ AC_ARG_WITH([noarch-pkgconfigdir],
 AC_SUBST([noarch_pkgconfigdir], [$with_noarch_pkgconfigdir])
 m4_popdef([pkg_default])
 m4_popdef([pkg_description])
-]) dnl PKG_NOARCH_INSTALLDIR
+])dnl PKG_NOARCH_INSTALLDIR
=20
=20
-# PKG_CHECK_VAR(VARIABLE, MODULE, CONFIG-VARIABLE,
-# [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
-# -------------------------------------------
-# Retrieves the value of the pkg-config variable for the given module.
+dnl PKG_CHECK_VAR(VARIABLE, MODULE, CONFIG-VARIABLE,
+dnl [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
+dnl -------------------------------------------
+dnl Since: 0.28
+dnl
+dnl Retrieves the value of the pkg-config variable for the given module.
 AC_DEFUN([PKG_CHECK_VAR],
 [AC_REQUIRE([PKG_PROG_PKG_CONFIG])dnl
 AC_ARG_VAR([$1], [value of $3 for $2, overriding pkg-config])dnl
@@ -3070,21 +3218,21 @@ _PKG_CONFIG([$1], [variable=3D"][$3]["], [$2])
 AS_VAR_COPY([$1], [pkg_cv_][$1])
=20
 AS_VAR_IF([$1], [""], [$5], [$4])dnl
-])# PKG_CHECK_VAR
+])dnl PKG_CHECK_VAR
=20
-# po.m4 serial 21 (gettext-0.18.3)
-dnl Copyright (C) 1995-2013 Free Software Foundation, Inc.
+# po.m4 serial 24 (gettext-0.19)
+dnl Copyright (C) 1995-2014, 2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
 dnl
-dnl This file can can be used in projects which are not available under
+dnl This file can be used in projects which are not available under
 dnl the GNU General Public License or the GNU Library General Public
 dnl License but which still want to provide support for the GNU gettext
 dnl functionality.
 dnl Please note that the actual code of the GNU gettext library is covered
 dnl by the GNU Library General Public License, and the rest of the GNU
-dnl gettext package package is covered by the GNU General Public License.
+dnl gettext package is covered by the GNU General Public License.
 dnl They are *not* in the public domain.
=20
 dnl Authors:
@@ -3104,7 +3252,7 @@ AC_DEFUN([AM_PO_SUBDIRS],
=20
   dnl Release version of the gettext macros. This is used to ensure that
   dnl the gettext macros and po/Makefile.in.in are in sync.
-  AC_SUBST([GETTEXT_MACRO_VERSION], [0.18])
+  AC_SUBST([GETTEXT_MACRO_VERSION], [0.19])
=20
   dnl Perform the following tests also if --disable-nls has been given,
   dnl because they are needed for "make dist" to work.
@@ -3527,7 +3675,7 @@ AC_DEFUN([AM_XGETTEXT_OPTION],
 ])
=20
 # printf-posix.m4 serial 6 (gettext-0.18.2)
-dnl Copyright (C) 2003, 2007, 2009-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2003, 2007, 2009-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -3576,18 +3724,18 @@ int main ()
 ])
=20
 # progtest.m4 serial 7 (gettext-0.18.2)
-dnl Copyright (C) 1996-2003, 2005, 2008-2013 Free Software Foundation, Inc=
.
+dnl Copyright (C) 1996-2003, 2005, 2008-2016 Free Software Foundation, Inc=
.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
 dnl
-dnl This file can can be used in projects which are not available under
+dnl This file can be used in projects which are not available under
 dnl the GNU General Public License or the GNU Library General Public
 dnl License but which still want to provide support for the GNU gettext
 dnl functionality.
 dnl Please note that the actual code of the GNU gettext library is covered
 dnl by the GNU Library General Public License, and the rest of the GNU
-dnl gettext package package is covered by the GNU General Public License.
+dnl gettext package is covered by the GNU General Public License.
 dnl They are *not* in the public domain.
=20
 dnl Authors:
@@ -3668,7 +3816,7 @@ AC_SUBST([$1])dnl
 ])
=20
 # size_max.m4 serial 10
-dnl Copyright (C) 2003, 2005-2006, 2008-2013 Free Software Foundation, Inc=
.
+dnl Copyright (C) 2003, 2005-2006, 2008-2016 Free Software Foundation, Inc=
.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -3748,7 +3896,7 @@ m4_ifdef([AC_COMPUTE_INT], [], [
 ])
=20
 # stdint_h.m4 serial 9
-dnl Copyright (C) 1997-2004, 2006, 2008-2013 Free Software Foundation, Inc=
.
+dnl Copyright (C) 1997-2004, 2006, 2008-2016 Free Software Foundation, Inc=
.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -3775,8 +3923,8 @@ AC_DEFUN([gl_AC_HEADER_STDINT_H],
   fi
 ])
=20
-# threadlib.m4 serial 10 (gettext-0.18.2)
-dnl Copyright (C) 2005-2013 Free Software Foundation, Inc.
+# threadlib.m4 serial 11 (gettext-0.18.2)
+dnl Copyright (C) 2005-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -3799,7 +3947,7 @@ dnl libtool).
 dnl Sets the variables LIBMULTITHREAD and LTLIBMULTITHREAD similarly, for
 dnl programs that really need multithread functionality. The difference
 dnl between LIBTHREAD and LIBMULTITHREAD is that on platforms supporting w=
eak
-dnl symbols, typically LIBTHREAD=3D"" whereas LIBMULTITHREAD=3D"-lpthread"=
.
+dnl symbols, typically LIBTHREAD is empty whereas LIBMULTITHREAD is not.
 dnl Adds to CPPFLAGS the flag -D_REENTRANT or -D_THREAD_SAFE if needed for
 dnl multithread-safe programs.
=20
@@ -3939,15 +4087,31 @@ int main ()
         # Test whether both pthread_mutex_lock and pthread_mutexattr_init =
exist
         # in libc. IRIX 6.5 has the first one in both libc and libpthread,=
 but
         # the second one only in libpthread, and lock.c needs it.
-        AC_LINK_IFELSE(
-          [AC_LANG_PROGRAM(
-             [[#include <pthread.h>]],
-             [[pthread_mutex_lock((pthread_mutex_t*)0);
-               pthread_mutexattr_init((pthread_mutexattr_t*)0);]])],
-          [gl_have_pthread=3Dyes])
+        #
+        # If -pthread works, prefer it to -lpthread, since Ubuntu 14.04
+        # needs -pthread for some reason.  See:
+        # http://lists.gnu.org/archive/html/bug-gnulib/2014-09/msg00023.ht=
ml
+        save_LIBS=3D$LIBS
+        for gl_pthread in '' '-pthread'; do
+          LIBS=3D"$LIBS $gl_pthread"
+          AC_LINK_IFELSE(
+            [AC_LANG_PROGRAM(
+               [[#include <pthread.h>
+                 pthread_mutex_t m;
+                 pthread_mutexattr_t ma;
+               ]],
+               [[pthread_mutex_lock (&m);
+                 pthread_mutexattr_init (&ma);]])],
+            [gl_have_pthread=3Dyes
+             LIBTHREAD=3D$gl_pthread LTLIBTHREAD=3D$gl_pthread
+             LIBMULTITHREAD=3D$gl_pthread LTLIBMULTITHREAD=3D$gl_pthread])
+          LIBS=3D$save_LIBS
+          test -n "$gl_have_pthread" && break
+        done
+
         # Test for libpthread by looking for pthread_kill. (Not pthread_se=
lf,
         # since it is defined as a macro on OSF/1.)
-        if test -n "$gl_have_pthread"; then
+        if test -n "$gl_have_pthread" && test -z "$LIBTHREAD"; then
           # The program links fine without libpthread. But it may actually
           # need to link with libpthread in order to create multiple threa=
ds.
           AC_CHECK_LIB([pthread], [pthread_kill],
@@ -3962,7 +4126,7 @@ int main ()
                    [Define if the pthread_in_use() detection is hard.])
              esac
             ])
-        else
+        elif test -z "$gl_have_pthread"; then
           # Some library is needed. Try libpthread and libc_r.
           AC_CHECK_LIB([pthread], [pthread_kill],
             [gl_have_pthread=3Dyes
@@ -4103,6 +4267,8 @@ dnl Linux 2.4/glibc    posix      -lpthread       Y  =
    OK
 dnl
 dnl GNU Hurd/glibc     posix
 dnl
+dnl Ubuntu 14.04       posix      -pthread        Y      OK
+dnl
 dnl FreeBSD 5.3        posix      -lc_r           Y
 dnl                    posix      -lkse ?         Y
 dnl                    posix      -lpthread ?     Y
@@ -4148,7 +4314,7 @@ dnl   0.5 if the first test terminates OK but the sec=
ond one loops endlessly,
 dnl   0.0 if the first test already loops endlessly.
=20
 # uintmax_t.m4 serial 12
-dnl Copyright (C) 1997-2004, 2007-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 1997-2004, 2007-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -4179,7 +4345,7 @@ AC_DEFUN([gl_AC_TYPE_UINTMAX_T],
 ])
=20
 # visibility.m4 serial 5 (gettext-0.18.2)
-dnl Copyright (C) 2005, 2008, 2010-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2005, 2008, 2010-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -4257,7 +4423,7 @@ AC_DEFUN([gl_VISIBILITY],
 ])
=20
 # wchar_t.m4 serial 4 (gettext-0.18.2)
-dnl Copyright (C) 2002-2003, 2008-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2002-2003, 2008-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -4282,7 +4448,7 @@ AC_DEFUN([gt_TYPE_WCHAR_T],
 ])
=20
 # wint_t.m4 serial 5 (gettext-0.18.2)
-dnl Copyright (C) 2003, 2007-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2003, 2007-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
@@ -4315,7 +4481,7 @@ AC_DEFUN([gt_TYPE_WINT_T],
 ])
=20
 # xsize.m4 serial 5
-dnl Copyright (C) 2003-2004, 2008-2013 Free Software Foundation, Inc.
+dnl Copyright (C) 2003-2004, 2008-2016 Free Software Foundation, Inc.
 dnl This file is free software; the Free Software Foundation
 dnl gives unlimited permission to copy and/or distribute it,
 dnl with or without modifications, as long as this notice is preserved.
diff --git a/configure b/configure
index d90188af..194345bc 100755
--- a/configure
+++ b/configure
@@ -758,6 +758,7 @@ GETTEXT_PACKAGE
 TDB_MAN_COMMENT
 TDB_CMT
 UUIDD_CMT
+PTHREAD_CC
 E2INITRD_MAN
 E2INITRD_PROG
 FSCK_MAN
@@ -907,6 +908,7 @@ enable_defrag
 enable_fsck
 enable_e2initrd_helper
 enable_tls
+with_pthread
 enable_uuidd
 enable_mmp
 enable_tdb
@@ -1618,6 +1620,7 @@ Optional Packages:
   --with-ccopts           no longer supported, use CFLAGS=3D instead
   --with-ldopts           no longer supported, use LDFLAGS=3D instead
   --with-root-prefix=3DPREFIX override prefix variable for files to be pla=
ced in the root
+  --without-pthread       disable use of pthread support
   --with-gnu-ld           assume the C compiler uses GNU ld [default=3Dno]
   --with-libpth-prefix[=3DDIR]  search for libpth in DIR/include and DIR/l=
ib
   --without-libpth-prefix     don't search for libpth in includedir and li=
bdir
@@ -5988,6 +5991,34 @@ $as_echo "$ac_cv_tls" >&6; }
=20
 fi
=20
+# Check whether --with-pthread was given.
+if test "${with_pthread+set}" =3D set; then :
+  withval=3D$with_pthread; if test "$withval" =3D "no"
+then
+	try_pthread=3D""
+	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: Disabling pthread suppor=
t" >&5
+$as_echo "Disabling pthread support" >&6; }
+else
+	try_pthread=3D"yes"
+	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: Testing for pthread supp=
ort" >&5
+$as_echo "Testing for pthread support" >&6; }
+fi
+
+else
+  try_pthread=3D"yes"
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: Try testing for pthread s=
upport by default" >&5
+$as_echo "Try testing for pthread support by default" >&6; }
+
+fi
+
+if test "$try_pthread" =3D "yes"
+then
+AX_PTHREAD
+else
+test -n "$PTHREAD_CC" || PTHREAD_CC=3D"$CC"
+
+fi
+
 # Check whether --enable-uuidd was given.
 if test "${enable_uuidd+set}" =3D set; then :
   enableval=3D$enable_uuidd; if test "$enableval" =3D "no"
@@ -6392,7 +6423,7 @@ $as_echo "$USE_NLS" >&6; }
=20
=20
=20
-      GETTEXT_MACRO_VERSION=3D0.18
+      GETTEXT_MACRO_VERSION=3D0.19
=20
=20
=20
@@ -7404,7 +7435,7 @@ static void
 sigfpe_handler (int sig)
 {
   /* Exit with code 0 if SIGFPE, with code 1 if any other signal.  */
-  exit (sig !=3D SIGFPE);
+  _exit (sig !=3D SIGFPE);
 }
=20
 int x =3D 1;
@@ -8002,26 +8033,42 @@ fi
         # Test whether both pthread_mutex_lock and pthread_mutexattr_init =
exist
         # in libc. IRIX 6.5 has the first one in both libc and libpthread,=
 but
         # the second one only in libpthread, and lock.c needs it.
-        cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+        #
+        # If -pthread works, prefer it to -lpthread, since Ubuntu 14.04
+        # needs -pthread for some reason.  See:
+        # http://lists.gnu.org/archive/html/bug-gnulib/2014-09/msg00023.ht=
ml
+        save_LIBS=3D$LIBS
+        for gl_pthread in '' '-pthread'; do
+          LIBS=3D"$LIBS $gl_pthread"
+          cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
 #include <pthread.h>
+                 pthread_mutex_t m;
+                 pthread_mutexattr_t ma;
+
 int
 main ()
 {
-pthread_mutex_lock((pthread_mutex_t*)0);
-               pthread_mutexattr_init((pthread_mutexattr_t*)0);
+pthread_mutex_lock (&m);
+                 pthread_mutexattr_init (&ma);
   ;
   return 0;
 }
 _ACEOF
 if ac_fn_c_try_link "$LINENO"; then :
   gl_have_pthread=3Dyes
+             LIBTHREAD=3D$gl_pthread LTLIBTHREAD=3D$gl_pthread
+             LIBMULTITHREAD=3D$gl_pthread LTLIBMULTITHREAD=3D$gl_pthread
 fi
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
+          LIBS=3D$save_LIBS
+          test -n "$gl_have_pthread" && break
+        done
+
         # Test for libpthread by looking for pthread_kill. (Not pthread_se=
lf,
         # since it is defined as a macro on OSF/1.)
-        if test -n "$gl_have_pthread"; then
+        if test -n "$gl_have_pthread" && test -z "$LIBTHREAD"; then
           # The program links fine without libpthread. But it may actually
           # need to link with libpthread in order to create multiple threa=
ds.
           { $as_echo "$as_me:${as_lineno-$LINENO}: checking for pthread_ki=
ll in -lpthread" >&5
@@ -8075,7 +8122,7 @@ $as_echo "#define PTHREAD_IN_USE_DETECTION_HARD 1" >>=
confdefs.h
=20
 fi
=20
-        else
+        elif test -z "$gl_have_pthread"; then
           # Some library is needed. Try libpthread and libc_r.
           { $as_echo "$as_me:${as_lineno-$LINENO}: checking for pthread_ki=
ll in -lpthread" >&5
 $as_echo_n "checking for pthread_kill in -lpthread... " >&6; }
@@ -9426,36 +9473,42 @@ else
       if test $am_cv_lib_iconv =3D yes; then
         LIBS=3D"$LIBS $LIBICONV"
       fi
-      if test "$cross_compiling" =3D yes; then :
-
-         case "$host_os" in
-           aix* | hpux*) am_cv_func_iconv_works=3D"guessing no" ;;
-           *)            am_cv_func_iconv_works=3D"guessing yes" ;;
-         esac
-
+      am_cv_func_iconv_works=3Dno
+      for ac_iconv_const in '' 'const'; do
+        if test "$cross_compiling" =3D yes; then :
+  case "$host_os" in
+             aix* | hpux*) am_cv_func_iconv_works=3D"guessing no" ;;
+             *)            am_cv_func_iconv_works=3D"guessing yes" ;;
+           esac
 else
   cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
=20
 #include <iconv.h>
 #include <string.h>
-int main ()
+
+#ifndef ICONV_CONST
+# define ICONV_CONST $ac_iconv_const
+#endif
+
+int
+main ()
 {
-  int result =3D 0;
+int result =3D 0;
   /* Test against AIX 5.1 bug: Failures are not distinguishable from succe=
ssful
      returns.  */
   {
     iconv_t cd_utf8_to_88591 =3D iconv_open ("ISO8859-1", "UTF-8");
     if (cd_utf8_to_88591 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\342\202\254"; /* EURO SIGN */
+        static ICONV_CONST char input[] =3D "\342\202\254"; /* EURO SIGN *=
/
         char buf[10];
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D strlen (input);
         char *outptr =3D buf;
         size_t outbytesleft =3D sizeof (buf);
         size_t res =3D iconv (cd_utf8_to_88591,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if (res =3D=3D 0)
           result |=3D 1;
@@ -9468,14 +9521,14 @@ int main ()
     iconv_t cd_ascii_to_88591 =3D iconv_open ("ISO8859-1", "646");
     if (cd_ascii_to_88591 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\263";
+        static ICONV_CONST char input[] =3D "\263";
         char buf[10];
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D strlen (input);
         char *outptr =3D buf;
         size_t outbytesleft =3D sizeof (buf);
         size_t res =3D iconv (cd_ascii_to_88591,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if (res =3D=3D 0)
           result |=3D 2;
@@ -9487,14 +9540,14 @@ int main ()
     iconv_t cd_88591_to_utf8 =3D iconv_open ("UTF-8", "ISO-8859-1");
     if (cd_88591_to_utf8 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\304";
+        static ICONV_CONST char input[] =3D "\304";
         static char buf[2] =3D { (char)0xDE, (char)0xAD };
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D 1;
         char *outptr =3D buf;
         size_t outbytesleft =3D 1;
         size_t res =3D iconv (cd_88591_to_utf8,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if (res !=3D (size_t)(-1) || outptr - buf > 1 || buf[1] !=3D (char=
)0xAD)
           result |=3D 4;
@@ -9507,14 +9560,14 @@ int main ()
     iconv_t cd_88591_to_utf8 =3D iconv_open ("utf8", "iso88591");
     if (cd_88591_to_utf8 !=3D (iconv_t)(-1))
       {
-        static const char input[] =3D "\304rger mit b\366sen B\374bchen oh=
ne Augenma\337";
+        static ICONV_CONST char input[] =3D "\304rger mit b\366sen B\374bc=
hen ohne Augenma\337";
         char buf[50];
-        const char *inptr =3D input;
+        ICONV_CONST char *inptr =3D input;
         size_t inbytesleft =3D strlen (input);
         char *outptr =3D buf;
         size_t outbytesleft =3D sizeof (buf);
         size_t res =3D iconv (cd_88591_to_utf8,
-                            (char **) &inptr, &inbytesleft,
+                            &inptr, &inbytesleft,
                             &outptr, &outbytesleft);
         if ((int)res > 0)
           result |=3D 8;
@@ -9534,17 +9587,20 @@ int main ()
       && iconv_open ("utf8", "eucJP") =3D=3D (iconv_t)(-1))
     result |=3D 16;
   return result;
+
+  ;
+  return 0;
 }
 _ACEOF
 if ac_fn_c_try_run "$LINENO"; then :
   am_cv_func_iconv_works=3Dyes
-else
-  am_cv_func_iconv_works=3Dno
 fi
 rm -f core *.core core.conftest.* gmon.out bb.out conftest$ac_exeext \
   conftest.$ac_objext conftest.beam conftest.$ac_ext
 fi
=20
+        test "$am_cv_func_iconv_works" =3D no || break
+      done
       LIBS=3D"$am_save_LIBS"
=20
 fi
@@ -9677,6 +9733,20 @@ fi
 done
=20
=20
+      if test $ac_cv_func_uselocale =3D yes; then
+    for ac_func in getlocalename_l
+do :
+  ac_fn_c_check_func "$LINENO" "getlocalename_l" "ac_cv_func_getlocalename=
_l"
+if test "x$ac_cv_func_getlocalename_l" =3D xyes; then :
+  cat >>confdefs.h <<_ACEOF
+#define HAVE_GETLOCALENAME_L 1
+_ACEOF
+
+fi
+done
+
+  fi
+
           ac_fn_c_check_decl "$LINENO" "feof_unlocked" "ac_cv_have_decl_fe=
of_unlocked" "#include <stdio.h>
 "
 if test "x$ac_cv_have_decl_feof_unlocked" =3D xyes; then :
@@ -9703,7 +9773,7 @@ _ACEOF
=20
=20
=20
-                      for ac_prog in bison
+                    for ac_prog in bison
 do
   # Extract the first word of "$ac_prog", so it can be a program name with=
 args.
 set dummy $ac_prog; ac_word=3D$2
@@ -9753,7 +9823,7 @@ $as_echo_n "checking version of bison... " >&6; }
     ac_prog_version=3D`$INTLBISON --version 2>&1 | sed -n 's/^.*GNU Bison.=
* \([0-9]*\.[0-9.]*\).*$/\1/p'`
     case $ac_prog_version in
       '') ac_prog_version=3D"v. ?.??, bad"; ac_verc_fail=3Dyes;;
-      1.2[6-9]* | 1.[3-9][0-9]* | [2-9].*)
+      2.[7-9]* | [3-9].*)
          ac_prog_version=3D"$ac_prog_version, ok"; ac_verc_fail=3Dno;;
       *) ac_prog_version=3D"$ac_prog_version, bad"; ac_verc_fail=3Dyes;;
     esac
@@ -10399,6 +10469,8 @@ $as_echo "#define HAVE_CFLOCALECOPYCURRENT 1" >>con=
fdefs.h
=20
=20
=20
+
+
     case "$enable_silent_rules" in
     yes) INTL_DEFAULT_VERBOSITY=3D0;;
     no)  INTL_DEFAULT_VERBOSITY=3D1;;
@@ -10859,16 +10931,21 @@ else
 /* end confdefs.h.  */
=20
 #include <libintl.h>
-$gt_revision_test_code
+#ifndef __GNU_GETTEXT_SUPPORTED_REVISION
 extern int _nl_msg_cat_cntr;
 extern int *_nl_domain_bindings;
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION (_nl_msg_cat_cntr + *_nl_domain_bi=
ndings)
+#else
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION 0
+#endif
+$gt_revision_test_code
=20
 int
 main ()
 {
=20
 bindtextdomain ("", "");
-return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_do=
main_bindings
+return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRE=
SSION
=20
   ;
   return 0;
@@ -11362,20 +11439,25 @@ else
 /* end confdefs.h.  */
=20
 #include <libintl.h>
-$gt_revision_test_code
+#ifndef __GNU_GETTEXT_SUPPORTED_REVISION
 extern int _nl_msg_cat_cntr;
 extern
 #ifdef __cplusplus
 "C"
 #endif
 const char *_nl_expand_alias (const char *);
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION (_nl_msg_cat_cntr + *_nl_expand_al=
ias (""))
+#else
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION 0
+#endif
+$gt_revision_test_code
=20
 int
 main ()
 {
=20
 bindtextdomain ("", "");
-return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_ex=
pand_alias ("")
+return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRE=
SSION
=20
   ;
   return 0;
@@ -11394,20 +11476,25 @@ rm -f core conftest.err conftest.$ac_objext \
 /* end confdefs.h.  */
=20
 #include <libintl.h>
-$gt_revision_test_code
+#ifndef __GNU_GETTEXT_SUPPORTED_REVISION
 extern int _nl_msg_cat_cntr;
 extern
 #ifdef __cplusplus
 "C"
 #endif
 const char *_nl_expand_alias (const char *);
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION (_nl_msg_cat_cntr + *_nl_expand_al=
ias (""))
+#else
+#define __GNU_GETTEXT_SYMBOL_EXPRESSION 0
+#endif
+$gt_revision_test_code
=20
 int
 main ()
 {
=20
 bindtextdomain ("", "");
-return * gettext ("")$gt_expression_test_code + _nl_msg_cat_cntr + *_nl_ex=
pand_alias ("")
+return * gettext ("")$gt_expression_test_code + __GNU_GETTEXT_SYMBOL_EXPRE=
SSION
=20
   ;
   return 0;
@@ -13180,6 +13267,48 @@ if test "x$ac_cv_lib_blkid_blkid_probe_get_topolog=
y" =3D xyes; then :
=20
 $as_echo "#define HAVE_BLKID_PROBE_GET_TOPOLOGY 1" >>confdefs.h
=20
+fi
+
+  { $as_echo "$as_me:${as_lineno-$LINENO}: checking for blkid_topology_get=
_dax in -lblkid" >&5
+$as_echo_n "checking for blkid_topology_get_dax in -lblkid... " >&6; }
+if ${ac_cv_lib_blkid_blkid_topology_get_dax+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  ac_check_lib_save_LIBS=3D$LIBS
+LIBS=3D"-lblkid  $LIBS"
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+/* Override any GCC internal prototype to avoid an error.
+   Use char because int might match the return type of a GCC
+   builtin and then its argument prototype would still apply.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+char blkid_topology_get_dax ();
+int
+main ()
+{
+return blkid_topology_get_dax ();
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_link "$LINENO"; then :
+  ac_cv_lib_blkid_blkid_topology_get_dax=3Dyes
+else
+  ac_cv_lib_blkid_blkid_topology_get_dax=3Dno
+fi
+rm -f core conftest.err conftest.$ac_objext \
+    conftest$ac_exeext conftest.$ac_ext
+LIBS=3D$ac_check_lib_save_LIBS
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_blkid_blkid_to=
pology_get_dax" >&5
+$as_echo "$ac_cv_lib_blkid_blkid_topology_get_dax" >&6; }
+if test "x$ac_cv_lib_blkid_blkid_topology_get_dax" =3D xyes; then :
+
+$as_echo "#define HAVE_BLKID_TOPOLOGY_GET_DAX 1" >>confdefs.h
+
 fi
=20
   { $as_echo "$as_me:${as_lineno-$LINENO}: checking for blkid_probe_enable=
_partitions in -lblkid" >&5
@@ -14425,7 +14554,7 @@ fi
=20
=20
 if test $pkg_failed =3D yes; then
-   	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+        { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
 $as_echo "no" >&6; }
=20
 if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
@@ -14445,7 +14574,7 @@ fi
 			with_udev_rules_dir=3D""
=20
 elif test $pkg_failed =3D untried; then
-     	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+        { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
 $as_echo "no" >&6; }
=20
 			with_udev_rules_dir=3D""
@@ -14585,7 +14714,7 @@ fi
=20
=20
 if test $pkg_failed =3D yes; then
-   	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+        { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
 $as_echo "no" >&6; }
=20
 if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
@@ -14605,7 +14734,7 @@ fi
 			with_systemd_unit_dir=3D""
=20
 elif test $pkg_failed =3D untried; then
-     	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+        { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
 $as_echo "no" >&6; }
=20
 			with_systemd_unit_dir=3D""
diff --git a/configure.ac b/configure.ac
index 7d921074..bd0e06f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -773,6 +773,30 @@ fi
 dnl
 dnl
 dnl
+AC_ARG_WITH([pthread],
+[  --without-pthread       disable use of pthread support],
+[if test "$withval" =3D "no"
+then
+	try_pthread=3D""
+	AC_MSG_RESULT([Disabling pthread support])
+else
+	try_pthread=3D"yes"
+	AC_MSG_RESULT([Testing for pthread support])
+fi]
+,
+try_pthread=3D"yes"
+AC_MSG_RESULT([Try testing for pthread support by default])
+)
+if test "$try_pthread" =3D "yes"
+then
+AX_PTHREAD
+else
+test -n "$PTHREAD_CC" || PTHREAD_CC=3D"$CC"
+AC_SUBST([PTHREAD_CC])
+fi
+dnl
+dnl
+dnl
 AH_TEMPLATE([USE_UUIDD], [Define to 1 to build uuidd])
 AC_ARG_ENABLE([uuidd],
 [  --disable-uuidd         disable building the uuid daemon],
diff --git a/lib/config.h.in b/lib/config.h.in
index b448482c..f6e4b307 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -82,6 +82,9 @@
 /* Define to 1 if blkid has blkid_probe_get_topology */
 #undef HAVE_BLKID_PROBE_GET_TOPOLOGY
=20
+/* Define to 1 if blkid has blkid_topology_get_dax */
+#undef HAVE_BLKID_TOPOLOGY_GET_DAX
+
 /* Define to 1 if the compiler understands __builtin_expect. */
 #undef HAVE_BUILTIN_EXPECT
=20
@@ -195,6 +198,9 @@
 /* Define to 1 if you have the `gethostname' function. */
 #undef HAVE_GETHOSTNAME
=20
+/* Define to 1 if you have the `getlocalename_l' function. */
+#undef HAVE_GETLOCALENAME_L
+
 /* Define to 1 if you have the `getmntinfo' function. */
 #undef HAVE_GETMNTINFO
=20
@@ -798,43 +804,75 @@
    'reference to static identifier "f" in extern inline function'.
    This bug was observed with Sun C 5.12 SunOS_i386 2011/11/16.
=20
-   Suppress the use of extern inline on Apple's platforms, as Libc at leas=
t
-   through Libc-825.26 (2013-04-09) is incompatible with it; see, e.g.,
-   <http://lists.gnu.org/archive/html/bug-gnulib/2012-12/msg00023.html>.
-   Perhaps Apple will fix this some day.  */
+   Suppress extern inline (with or without __attribute__ ((__gnu_inline__)=
))
+   on configurations that mistakenly use 'static inline' to implement
+   functions or macros in standard C headers like <ctype.h>.  For example,
+   if isdigit is mistakenly implemented via a static inline function,
+   a program containing an extern inline function that calls isdigit
+   may not work since the C standard prohibits extern inline functions
+   from calling static functions.  This bug is known to occur on:
+
+     OS X 10.8 and earlier; see:
+     http://lists.gnu.org/archive/html/bug-gnulib/2012-12/msg00023.html
+
+     DragonFly; see
+     http://muscles.dragonflybsd.org/bulk/bleeding-edge-potential/latest-p=
er-pkg/ah-tty-0.3.12.log
+
+     FreeBSD; see:
+     http://lists.gnu.org/archive/html/bug-gnulib/2014-07/msg00104.html
+
+   OS X 10.9 has a macro __header_inline indicating the bug is fixed for C=
 and
+   for clang but remains for g++; see <http://trac.macports.org/ticket/410=
33>.
+   Assume DragonFly and FreeBSD will be similar.  */
+#if (((defined __APPLE__ && defined __MACH__) \
+      || defined __DragonFly__ || defined __FreeBSD__) \
+     && (defined __header_inline \
+         ? (defined __cplusplus && defined __GNUC_STDC_INLINE__ \
+            && ! defined __clang__) \
+         : ((! defined _DONT_USE_CTYPE_INLINE_ \
+             && (defined __GNUC__ || defined __cplusplus)) \
+            || (defined _FORTIFY_SOURCE && 0 < _FORTIFY_SOURCE \
+                && defined __GNUC__ && ! defined __cplusplus))))
+# define _GL_EXTERN_INLINE_STDHEADER_BUG
+#endif
 #if ((__GNUC__ \
       ? defined __GNUC_STDC_INLINE__ && __GNUC_STDC_INLINE__ \
       : (199901L <=3D __STDC_VERSION__ \
          && !defined __HP_cc \
+         && !defined __PGI \
          && !(defined __SUNPRO_C && __STDC__))) \
-     && !defined __APPLE__)
+     && !defined _GL_EXTERN_INLINE_STDHEADER_BUG)
 # define _GL_INLINE inline
 # define _GL_EXTERN_INLINE extern inline
+# define _GL_EXTERN_INLINE_IN_USE
 #elif (2 < __GNUC__ + (7 <=3D __GNUC_MINOR__) && !defined __STRICT_ANSI__ =
\
-       && !defined __APPLE__)
-# if __GNUC_GNU_INLINE__
+       && !defined _GL_EXTERN_INLINE_STDHEADER_BUG)
+# if defined __GNUC_GNU_INLINE__ && __GNUC_GNU_INLINE__
    /* __gnu_inline__ suppresses a GCC 4.2 diagnostic.  */
 #  define _GL_INLINE extern inline __attribute__ ((__gnu_inline__))
 # else
 #  define _GL_INLINE extern inline
 # endif
 # define _GL_EXTERN_INLINE extern
+# define _GL_EXTERN_INLINE_IN_USE
 #else
 # define _GL_INLINE static _GL_UNUSED
 # define _GL_EXTERN_INLINE static _GL_UNUSED
 #endif
=20
-#if 4 < __GNUC__ + (6 <=3D __GNUC_MINOR__)
+/* In GCC 4.6 (inclusive) to 5.1 (exclusive),
+   suppress bogus "no previous prototype for 'FOO'"
+   and "no previous declaration for 'FOO'" diagnostics,
+   when FOO is an inline function in the header; see
+   <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D54113> and
+   <https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63877>.  */
+#if __GNUC__ =3D=3D 4 && 6 <=3D __GNUC_MINOR__
 # if defined __GNUC_STDC_INLINE__ && __GNUC_STDC_INLINE__
 #  define _GL_INLINE_HEADER_CONST_PRAGMA
 # else
 #  define _GL_INLINE_HEADER_CONST_PRAGMA \
      _Pragma ("GCC diagnostic ignored \"-Wsuggest-attribute=3Dconst\"")
 # endif
-  /* Suppress GCC's bogus "no previous prototype for 'FOO'"
-     and "no previous declaration for 'FOO'"  diagnostics,
-     when FOO is an inline function in the header; see
-     <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D54113>.  */
 # define _GL_INLINE_HEADER_BEGIN \
     _Pragma ("GCC diagnostic push") \
     _Pragma ("GCC diagnostic ignored \"-Wmissing-prototypes\"") \
@@ -847,6 +885,27 @@
 # define _GL_INLINE_HEADER_END
 #endif
=20
+/* Define as a marker that can be attached to declarations that might not
+    be used.  This helps to reduce warnings, such as from
+    GCC -Wunused-parameter.  */
+#ifndef _GL_UNUSED
+# if __GNUC__ >=3D 3 || (__GNUC__ =3D=3D 2 && __GNUC_MINOR__ >=3D 7)
+#  define _GL_UNUSED __attribute__ ((__unused__))
+# else
+#  define _GL_UNUSED
+# endif
+#endif
+
+/* The __pure__ attribute was added in gcc 2.96.  */
+#ifndef _GL_ATTRIBUTE_PURE
+# if __GNUC__ > 2 || (__GNUC__ =3D=3D 2 && __GNUC_MINOR__ >=3D 96)
+#  define _GL_ATTRIBUTE_PURE __attribute__ ((__pure__))
+# else
+#  define _GL_ATTRIBUTE_PURE /* empty */
+# endif
+#endif
+
+
 /* Define to `__inline__' or `__inline' if that's what the C compiler
    calls it, or to nothing if 'inline' is not supported under any name.  *=
/
 #ifndef __cplusplus
--=20
2.30.0.284.gd98b1dd5eaa7-goog

