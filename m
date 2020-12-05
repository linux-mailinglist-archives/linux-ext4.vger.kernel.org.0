Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5571A2CF95D
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Dec 2020 06:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgLEE7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 23:59:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50361 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727046AbgLEE7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 23:59:52 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B54wwti001984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 23:58:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 84CC2420127; Fri,  4 Dec 2020 23:58:58 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC 1/5] Add configure and build support for the pthreads library
Date:   Fri,  4 Dec 2020 23:58:52 -0500
Message-Id: <20201205045856.895342-2-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201205045856.895342-1-tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Support for pthreads can be forcibly disabled by passing
"--without-pthread" to the configure script.

The actual changes in this commit are in configure.ac and MCONFIG.in;
the other files were generated as a result of running aclocal,
autoconf, and autoheader on a Debian testing system.

Note: the autoconf-archive package must now be installed before
rerunning aclocal, to supply the AX_PTHREAD macro.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

 [ I've removed the diffs of the generated files since they would make
   the diff too large for the vger mailing lists.  --Ted ]

 MCONFIG.in      |  12 +-
 aclocal.m4      | 486 +++++++++++++++++++++++++++++
 configure       | 814 +++++++++++++++++++++++++++++++++++++++++++-----
 configure.ac    |  24 ++
 lib/config.h.in | 351 +--------------------
 5 files changed, 1271 insertions(+), 416 deletions(-)

diff --git a/MCONFIG.in b/MCONFIG.in
index 0598f21b7..69f30674e 100644
--- a/MCONFIG.in
+++ b/MCONFIG.in
@@ -86,15 +86,17 @@ SYSTEMD_SYSTEM_UNIT_DIR = @systemd_system_unit_dir@
 SANITIZER_CFLAGS = @lto_cflags@ @ubsan_cflags@ @addrsan_cflags@ @threadsan_cflags@
 SANITIZER_LDFLAGS = @lto_ldflags@ @ubsan_ldflags@ @addrsan_ldflags@ @threadsan_ldflags@
 
-CC = @CC@
+CC = @PTHREAD_CC@
 BUILD_CC = @BUILD_CC@
+PTHREAD_CFLAGS = @PTHREAD_CFLAGS@
+PTHREAD_LIBS = @PTHREAD_LIBS@
 CFLAGS = @CFLAGS@
 CFLAGS_SHLIB = @CFLAGS_SHLIB@
 CFLAGS_STLIB = @CFLAGS_STLIB@
 CPPFLAGS = @INCLUDES@
-ALL_CFLAGS = $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
-ALL_CFLAGS_SHLIB = $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_SHLIB) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
-ALL_CFLAGS_STLIB = $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_STLIB) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
+ALL_CFLAGS = $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS) $(PTHREAD_CFLAGS) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
+ALL_CFLAGS_SHLIB = $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_SHLIB) $(PTHREAD_CFLAGS) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
+ALL_CFLAGS_STLIB = $(CPPFLAGS) $(SANITIZER_CFLAGS) $(CFLAGS_STLIB) $(PTHREAD_CFLAGS) $(CFLAGS_WARN) @DEFS@ $(LOCAL_CFLAGS)
 LDFLAGS = $(SANITIZER_LDFLAGS) @LDFLAGS@
 LDFLAGS_SHLIB = $(SANITIZER_LDFLAGS) @LDFLAGS_SHLIB@
 ALL_LDFLAGS = $(LDFLAGS) @LDFLAG_DYNAMIC@
@@ -139,7 +141,7 @@ LIBFUSE = @FUSE_LIB@
 LIBSUPPORT = $(LIBINTL) $(LIB)/libsupport@STATIC_LIB_EXT@
 LIBBLKID = @LIBBLKID@ @PRIVATE_LIBS_CMT@ $(LIBUUID)
 LIBINTL = @LIBINTL@
-SYSLIBS = @LIBS@
+SYSLIBS = @LIBS@ @PTHREAD_LIBS@
 DEPLIBSS = $(LIB)/libss@LIB_EXT@
 DEPLIBCOM_ERR = $(LIB)/libcom_err@LIB_EXT@
 DEPLIBUUID = @DEPLIBUUID@
diff --git a/configure.ac b/configure.ac
index 6cb335d7d..d3d9ae07a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -773,6 +773,30 @@ fi
 dnl
 dnl
 dnl
+AC_ARG_WITH([pthread],
+[  --without-pthread       disable use of pthread support],
+[if test "$withval" = "no"
+then
+	try_pthread=""
+	AC_MSG_RESULT([Disabling pthread support])
+else
+	try_pthread="yes"
+	AC_MSG_RESULT([Testing for pthread support])
+fi]
+,
+try_pthread="yes"
+AC_MSG_RESULT([Try testing for pthread support by default])
+)
+if test "$try_pthread" = "yes"
+then
+AX_PTHREAD
+else
+test -n "$PTHREAD_CC" || PTHREAD_CC="$CC"
+AC_SUBST([PTHREAD_CC])
+fi
+dnl
+dnl
+dnl
 AH_TEMPLATE([USE_UUIDD], [Define to 1 to build uuidd])
 AC_ARG_ENABLE([uuidd],
 [  --disable-uuidd         disable building the uuid daemon],
-- 
2.28.0

