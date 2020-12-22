Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6F22E0E2F
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 19:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgLVSYa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 13:24:30 -0500
Received: from tina.tse.jus.br ([187.4.152.236]:39280 "EHLO tse.jus.br"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbgLVSYa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Dec 2020 13:24:30 -0500
Received: from EXCH01.tse.gov.br (unknown [10.30.1.221])
        by Forcepoint Email with ESMTP id 1DCE3CCEFB84766E24CD;
        Tue, 22 Dec 2020 15:16:29 -0300 (-03)
Received: from tsesevinl73.tse.jus.br (10.30.32.51) by EXCH01.tse.gov.br
 (10.30.1.221) with Microsoft SMTP Server (TLS) id 14.2.347.0; Tue, 22 Dec
 2020 15:16:28 -0300
From:   <paulo.alvarez@tse.jus.br>
To:     <linux-ext4@vger.kernel.org>
CC:     Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: [PATCH 3/3] Compile the io implementation according to os
Date:   Tue, 22 Dec 2020 15:15:52 -0300
Message-ID: <20201222181552.11267-4-paulo.alvarez@tse.jus.br>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201222181552.11267-1-paulo.alvarez@tse.jus.br>
References: <20201222181552.11267-1-paulo.alvarez@tse.jus.br>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.30.32.51]
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Paulo Antonio Alvarez <pauloaalvarez@gmail.com>

In mingw and cygwin, compile the windows_io manager, compile the unix_io
everywhere else.
---
 configure              | 56 ++++++++++++++++++++++++++++++++++++++++--
 configure.ac           | 13 ++++++++++
 lib/ext2fs/Makefile.in | 13 +++++++---
 3 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index d90188af..655da228 100755
--- a/configure
+++ b/configure
@@ -625,6 +625,7 @@ gl_use_threads_default=
 ac_func_list=
 ac_subst_vars='LTLIBOBJS
 LIBOBJS
+OS_IO_FILE
 systemd_system_unit_dir
 have_systemd
 systemd_LIBS
@@ -7338,8 +7339,6 @@ main ()
     if (*(data + i) != *(data3 + i))
       return 14;
   close (fd);
-  free (data);
-  free (data3);
   return 0;
 }
 _ACEOF
@@ -13180,6 +13179,48 @@ if test "x$ac_cv_lib_blkid_blkid_probe_get_topology" = xyes; then :
 
 $as_echo "#define HAVE_BLKID_PROBE_GET_TOPOLOGY 1" >>confdefs.h
 
+fi
+
+  { $as_echo "$as_me:${as_lineno-$LINENO}: checking for blkid_topology_get_dax in -lblkid" >&5
+$as_echo_n "checking for blkid_topology_get_dax in -lblkid... " >&6; }
+if ${ac_cv_lib_blkid_blkid_topology_get_dax+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  ac_check_lib_save_LIBS=$LIBS
+LIBS="-lblkid  $LIBS"
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
+  ac_cv_lib_blkid_blkid_topology_get_dax=yes
+else
+  ac_cv_lib_blkid_blkid_topology_get_dax=no
+fi
+rm -f core conftest.err conftest.$ac_objext \
+    conftest$ac_exeext conftest.$ac_ext
+LIBS=$ac_check_lib_save_LIBS
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_blkid_blkid_topology_get_dax" >&5
+$as_echo "$ac_cv_lib_blkid_blkid_topology_get_dax" >&6; }
+if test "x$ac_cv_lib_blkid_blkid_topology_get_dax" = xyes; then :
+
+$as_echo "#define HAVE_BLKID_TOPOLOGY_GET_DAX 1" >>confdefs.h
+
 fi
 
   { $as_echo "$as_me:${as_lineno-$LINENO}: checking for blkid_probe_enable_partitions in -lblkid" >&5
@@ -14647,6 +14688,17 @@ fi
 
 
 
+OS_IO_FILE=""
+case "$host_os" in
+  cigwin*|mingw*|msys*)
+    OS_IO_FILE=windows_io
+  ;;
+  *)
+    OS_IO_FILE=unix_io
+  ;;
+esac
+
+
 test -d lib || mkdir lib
 test -d include || mkdir include
 test -d include/linux || mkdir include/linux
diff --git a/configure.ac b/configure.ac
index 7d921074..57eead0e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1756,6 +1756,19 @@ AS_IF([test "x${with_systemd_unit_dir}" != "xno"],
   ])
 AC_SUBST(have_systemd)
 AC_SUBST(systemd_system_unit_dir)
+dnl Adjust the compiled files if we are on windows vs everywhere else
+dnl
+
+OS_IO_FILE=""
+[case "$host_os" in
+  cigwin*|mingw*|msys*)
+    OS_IO_FILE=windows_io
+  ;;
+  *)
+    OS_IO_FILE=unix_io
+  ;;
+esac]
+AC_SUBST(OS_IO_FILE)
 
 dnl
 dnl Make our output files, being sure that we create the some miscellaneous 
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index f754b952..67957183 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -126,7 +126,7 @@ OBJS= $(DEBUGFS_LIB_OBJS) $(RESIZE_LIB_OBJS) $(E2IMAGE_LIB_OBJS) \
 	symlink.o \
 	$(TDB_OBJ) \
 	undo_io.o \
-	unix_io.o \
+	@OS_IO_FILE@.o \
 	sparse_io.o \
 	unlink.o \
 	valid_blk.o \
@@ -216,7 +216,7 @@ SRCS= ext2_err.c \
 	$(srcdir)/tst_getsize.c \
 	$(srcdir)/tst_iscan.c \
 	$(srcdir)/undo_io.c \
-	$(srcdir)/unix_io.c \
+	$(srcdir)/@OS_IO_FILE@.c \
 	$(srcdir)/sparse_io.c \
 	$(srcdir)/unlink.c \
 	$(srcdir)/valid_blk.c \
@@ -1150,8 +1150,13 @@ unix_io.o: $(srcdir)/unix_io.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
  $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
- $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
- $(srcdir)/ext2fsP.h
+ $(srcdir)/ext2_ext_attr.h $(srcdir)/bitops.h $(srcdir)/ext2fsP.h
+windows_io.o: $(srcdir)/windows_io.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
+ $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
+ $(srcdir)/ext2_fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
+ $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
+ $(srcdir)/ext2_ext_attr.h $(srcdir)/bitops.h $(srcdir)/ext2fsP.h
 sparse_io.o: $(srcdir)/sparse_io.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
-- 
2.17.1

