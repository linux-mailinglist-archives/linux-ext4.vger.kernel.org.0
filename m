Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699262B80C7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgKRPkp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKRPkp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:45 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B25C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:45 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id e3so1526019pgu.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=P3/DkTQEeAEAiK7t+V7JXoxL995b7e7MUdppOZEGWyo=;
        b=F1dqzJThGny0hiWI8nsEagdaOL9EpQNJ62M09v4GAihrwAQqx20gjHydUOOT4YVHju
         ZaOLrGWW0iR+P8RE1yKxhVw35513WZydJ4tEGYLrSSNbDe4+kGG+Mlmy7qW+5UlldJI8
         dS3p1kJRfQXxHtxXnPPRVs2GI1zeCz/mavh1fxObuU6Be5MP8zbFjruH6lEaNXk5wuxr
         Z4POdnimDytoDBwBd7WaqOWUthow07HACHSR7MU9crRm90+KP5YvuH4XiEzLQ7TTRp1N
         DTANaMNratTPL07cFNOhMfM/exi/qGVLyB/MeEoQ1x3VO4m5Xt+8HaNc0cmbjmiHXYPf
         gP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P3/DkTQEeAEAiK7t+V7JXoxL995b7e7MUdppOZEGWyo=;
        b=K/FYof8HuPFSkkjm1E2XcJMtPJqOZJ723dPWyCowNnZdpvwrgZ5y3FhaU5g03GzlVp
         GlSyMkZJMyRAykKDgXJbUpYmZbFHIKKVvj3y3AJRPvoS/+rs+DbFSWacDrm2mvrHCQq4
         ItPt8x6Ti+UfTc3Vqz7yBaepzla9lE/rHQQDVtX5+daS5VCljT7D11L55cCj/Q41KDxW
         Ry2fGxFd7iHtrXQQcjzLMmpTcN9PT/A0khW0G9NX0UHdwMEKwGaNTpOIA0foHIFojDej
         kW3YwkJAH6smoS29phJONHFz7y1D2txnHnLr2hQ+zcH1Z/blX1Izcs3kNh+dck0N/neg
         hJgg==
X-Gm-Message-State: AOAM530imdsdDjs54K/Ilq7qgfArEvwsXlXB16n2HYxe/MRRnOOuGDjV
        IfogULG550H7Ln/5linJmdp9Ipj2gne68DgpTqVdW2gCvq7L3P/n5omg+YG4XNFS6iB6Vt+E+a5
        jr0MztONcqTUD6eO55ZdY6Btsbx5BjaPejGsXH7P+owTPH4Sk949Lr2NVtvZZWVK93xa78le1Bd
        s2015UtKA=
X-Google-Smtp-Source: ABdhPJzfr65oHwiIVXp2YciIyMJoEoUgWnS/zZIA99FbT0DctAa4cckAz53Aq7B6Kn/AIWNwbRNPTCkqjBiBlEMhqGA=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:aa7:8052:0:b029:196:4dbb:99fe with
 SMTP id y18-20020aa780520000b02901964dbb99femr5073047pfm.11.1605714044582;
 Wed, 18 Nov 2020 07:40:44 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:56 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-11-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 10/61] e2fsck: optionally configure one pfsck thread
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch creates only one thread to do pass1 check. The same
codes can be used to create multiple threads, but other functions
need to be modified to get ready for that.

pfsck support will be enabled with if configured with
--enable-pfsck option.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 configure         |  81 +++++++++++++++++++-----
 configure.ac      |  19 ++++++
 e2fsck/e2fsck.h   |  13 ++++
 e2fsck/logfile.c  |   2 +
 e2fsck/pass1.c    | 153 ++++++++++++++++++++++++++++++++++++++++------
 e2fsck/unix.c     |  10 +++
 lib/config.h.in   |   3 +
 tests/test_one.in |   8 +++
 8 files changed, 256 insertions(+), 33 deletions(-)

diff --git a/configure b/configure
index d90188af..1bb7a325 100755
--- a/configure
+++ b/configure
@@ -755,6 +755,7 @@ SET_MAKE
 VERSION
 PACKAGE
 GETTEXT_PACKAGE
+PTHREAD_LIB
 TDB_MAN_COMMENT
 TDB_CMT
 UUIDD_CMT
@@ -847,7 +848,6 @@ infodir
 docdir
 oldincludedir
 includedir
-runstatedir
 localstatedir
 sharedstatedir
 sysconfdir
@@ -912,6 +912,7 @@ enable_mmp
 enable_tdb
 enable_bmap_stats
 enable_bmap_stats_ops
+enable_pfsck
 enable_nls
 enable_threads
 with_gnu_ld
@@ -984,7 +985,6 @@ datadir='${datarootdir}'
 sysconfdir='${prefix}/etc'
 sharedstatedir='${prefix}/com'
 localstatedir='${prefix}/var'
-runstatedir='${localstatedir}/run'
 includedir='${prefix}/include'
 oldincludedir='/usr/include'
 docdir='${datarootdir}/doc/${PACKAGE}'
@@ -1237,15 +1237,6 @@ do
   | -silent | --silent | --silen | --sile | --sil)
     silent=yes ;;
 
-  -runstatedir | --runstatedir | --runstatedi | --runstated \
-  | --runstate | --runstat | --runsta | --runst | --runs \
-  | --run | --ru | --r)
-    ac_prev=runstatedir ;;
-  -runstatedir=* | --runstatedir=* | --runstatedi=* | --runstated=* \
-  | --runstate=* | --runstat=* | --runsta=* | --runst=* | --runs=* \
-  | --run=* | --ru=* | --r=*)
-    runstatedir=$ac_optarg ;;
-
   -sbindir | --sbindir | --sbindi | --sbind | --sbin | --sbi | --sb)
     ac_prev=sbindir ;;
   -sbindir=* | --sbindir=* | --sbindi=* | --sbind=* | --sbin=* \
@@ -1383,7 +1374,7 @@ fi
 for ac_var in	exec_prefix prefix bindir sbindir libexecdir datarootdir \
 		datadir sysconfdir sharedstatedir localstatedir includedir \
 		oldincludedir docdir infodir htmldir dvidir pdfdir psdir \
-		libdir localedir mandir runstatedir
+		libdir localedir mandir
 do
   eval ac_val=\$$ac_var
   # Remove trailing slashes.
@@ -1536,7 +1527,6 @@ Fine tuning of the installation directories:
   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
-  --runstatedir=DIR       modifiable per-process data [LOCALSTATEDIR/run]
   --libdir=DIR            object code libraries [EPREFIX/lib]
   --includedir=DIR        C header files [PREFIX/include]
   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
@@ -1599,6 +1589,7 @@ Optional Features:
   --disable-tdb           disable tdb support
   --disable-bmap-stats    disable collection of bitmap stats.
   --enable-bmap-stats-ops enable collection of additional bitmap stats
+  --enable-pfsck     enable parallel e2fsck
   --disable-nls           do not use Native Language Support
   --enable-threads={posix|solaris|pth|windows}
                           specify multithreading API
@@ -6121,6 +6112,68 @@ $as_echo "Disabling additional bitmap statistics by default" >&6; }
 
 fi
 
+PTHREAD_LIB=''
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for pthread_join in -lpthread" >&5
+$as_echo_n "checking for pthread_join in -lpthread... " >&6; }
+if ${ac_cv_lib_pthread_pthread_join+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  ac_check_lib_save_LIBS=$LIBS
+LIBS="-lpthread  $LIBS"
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+/* Override any GCC internal prototype to avoid an error.
+   Use char because int might match the return type of a GCC
+   builtin and then its argument prototype would still apply.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+char pthread_join ();
+int
+main ()
+{
+return pthread_join ();
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_link "$LINENO"; then :
+  ac_cv_lib_pthread_pthread_join=yes
+else
+  ac_cv_lib_pthread_pthread_join=no
+fi
+rm -f core conftest.err conftest.$ac_objext \
+    conftest$ac_exeext conftest.$ac_ext
+LIBS=$ac_check_lib_save_LIBS
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_pthread_pthread_join" >&5
+$as_echo "$ac_cv_lib_pthread_pthread_join" >&6; }
+if test "x$ac_cv_lib_pthread_pthread_join" = xyes; then :
+  PTHREAD_LIB=-pthread
+fi
+
+
+# Check whether --enable-pfsck was given.
+if test "${enable_pfsck+set}" = set; then :
+  enableval=$enable_pfsck; if test "$enableval" = "no" || test -z "PTHREAD_LIB"
+then
+	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: Disabling parallel e2fsck" >&5
+$as_echo "Disabling parallel e2fsck" >&6; }
+else
+
+$as_echo "#define CONFIG_PFSCK 1" >>confdefs.h
+
+	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: Enabling parallel e2fsck" >&5
+$as_echo "Enabling parallel e2fsck" >&6; }
+fi
+
+else
+  { $as_echo "$as_me:${as_lineno-$LINENO}: result: Disabling parallel e2fsck" >&5
+$as_echo "Disabling parallel e2fsck" >&6; }
+
+fi
+
 MAKEFILE_LIBRARY=$srcdir/lib/Makefile.library
 
 GETTEXT_PACKAGE=e2fsprogs
@@ -7338,8 +7391,6 @@ main ()
     if (*(data + i) != *(data3 + i))
       return 14;
   close (fd);
-  free (data);
-  free (data3);
   return 0;
 }
 _ACEOF
diff --git a/configure.ac b/configure.ac
index 7d921074..e73dbf50 100644
--- a/configure.ac
+++ b/configure.ac
@@ -877,6 +877,25 @@ fi
 AC_MSG_RESULT([Disabling additional bitmap statistics by default])
 )
 dnl
+dnl handle --enable-pfsck
+dnl
+PTHREAD_LIB=''
+AC_CHECK_LIB(pthread,pthread_join,PTHREAD_LIB=-pthread)
+AC_SUBST(PTHREAD_LIB)
+AC_ARG_ENABLE([pfsck],
+[  --enable-pfsck     enable parallel e2fsck],
+if test "$enableval" = "no" || test -z "PTHREAD_LIB"
+then
+	AC_MSG_RESULT([Disabling parallel e2fsck])
+else
+	AC_DEFINE(CONFIG_PFSCK, 1,
+		[Define to 1 if parallel e2fsck is enabled])
+	AC_MSG_RESULT([Enabling parallel e2fsck])
+fi
+,
+AC_MSG_RESULT([Disabling parallel e2fsck])
+)
+dnl
 dnl
 dnl
 MAKEFILE_LIBRARY=$srcdir/lib/Makefile.library
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 5ad0fe93..ccb66ae7 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -426,6 +426,19 @@ struct e2fsck_struct {
 	char *undo_file;
 };
 
+#ifdef CONFIG_PFSCK
+struct e2fsck_thread_info {
+	/* ID returned by pthread_create() */
+	pthread_t		 eti_thread_id;
+	/* Application-defined thread index */
+	int			 eti_thread_index;
+	/* Thread has been started */
+	int			 eti_started;
+	/* Context used for this thread */
+	e2fsck_t		 eti_thread_ctx;
+};
+#endif
+
 /* Data structures to evaluate whether an extent tree needs rebuilding. */
 struct extent_tree_level {
 	unsigned int	num_extents;
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index c5505d27..8bda6b81 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -310,11 +310,13 @@ static FILE *set_up_log_file(e2fsck_t ctx, const char *key, const char *fn)
 		goto out;
 
 	expand_logfn(ctx, log_fn, &s);
+#ifdef CONFIG_PFSCK
 	if (ctx->global_ctx) {
 		sprintf(string_index, "%d", ctx->thread_index);
 		append_string(&s, ".", 1);
 		append_string(&s, string_index, 0);
 	}
+#endif
 
 	if ((log_fn[0] == '/') || !log_dir || !log_dir[0])
 		s0 = s.s;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index bae47a7f..0d0fe366 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -47,6 +47,9 @@
 #include <errno.h>
 #endif
 #include <assert.h>
+#ifdef CONFIG_PFSCK
+#include <pthread.h>
+#endif
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -1162,7 +1165,7 @@ static int e2fsck_should_abort(e2fsck_t ctx)
 	return 0;
 }
 
-void e2fsck_pass1_thread(e2fsck_t ctx)
+void e2fsck_pass1_run(e2fsck_t ctx)
 {
 	int	i;
 	__u64	max_sizes;
@@ -2087,6 +2090,7 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
+#ifdef CONFIG_PFSCK
 static errcode_t e2fsck_pass1_copy_bitmap(ext2_filsys fs, ext2fs_generic_bitmap *src,
 					  ext2fs_generic_bitmap *dest)
 {
@@ -2392,18 +2396,38 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	return retval;
 }
 
-void e2fsck_pass1_multithread(e2fsck_t ctx)
+static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
+				      int num_threads, e2fsck_t global_ctx)
 {
-	errcode_t	retval;
-	e2fsck_t	thread_ctx;
+	errcode_t			 rc;
+	errcode_t			 ret = 0;
+	int				 i;
+	struct e2fsck_thread_info	*pinfo;
 
-	retval = e2fsck_pass1_thread_prepare(ctx, &thread_ctx);
-	if (retval) {
-		com_err(ctx->program_name, 0,
-			_("while preparing pass1 thread\n"));
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
+	for (i = 0; i < num_threads; i++) {
+		pinfo = &infos[i];
+
+		if (!pinfo->eti_started)
+			continue;
+
+		rc = pthread_join(pinfo->eti_thread_id, NULL);
+		if (rc) {
+			com_err(global_ctx->program_name, rc,
+				_("while joining thread\n"));
+			if (ret == 0)
+				ret = rc;
+		}
+		e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
 	}
+	free(infos);
+
+	return ret;
+}
+
+static void *e2fsck_pass1_thread(void *arg)
+{
+	struct e2fsck_thread_info	*info = arg;
+	e2fsck_t			 thread_ctx = info->eti_thread_ctx;
 
 #ifdef HAVE_SETJMP_H
 	/*
@@ -2414,25 +2438,118 @@ void e2fsck_pass1_multithread(e2fsck_t ctx)
 	 */
 	if (setjmp(thread_ctx->abort_loc)) {
 		thread_ctx->flags &= ~E2F_FLAG_SETJMP_OK;
-		e2fsck_pass1_thread_join(ctx, thread_ctx);
-		return;
+		goto out;
 	}
 	thread_ctx->flags |= E2F_FLAG_SETJMP_OK;
 #endif
 
-	e2fsck_pass1_thread(thread_ctx);
-	retval = e2fsck_pass1_thread_join(ctx, thread_ctx);
+	e2fsck_pass1_run(thread_ctx);
+
+out:
+	return NULL;
+}
+
+static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
+				      int num_threads, e2fsck_t global_ctx)
+{
+	struct e2fsck_thread_info	*infos;
+	pthread_attr_t			 attr;
+	errcode_t			 retval;
+	errcode_t			 ret;
+	struct e2fsck_thread_info	*tmp_pinfo;
+	int				 i;
+	e2fsck_t			 thread_ctx;
+
+	retval = pthread_attr_init(&attr);
 	if (retval) {
-		com_err(ctx->program_name, 0,
-			_("while joining pass1 thread\n"));
-		ctx->flags |= E2F_FLAG_ABORT;
-		return;
+		com_err(global_ctx->program_name, retval,
+			_("while setting pthread attribute\n"));
+		return retval;
 	}
+
+	infos = calloc(num_threads, sizeof(struct e2fsck_thread_info));
+	if (infos == NULL) {
+		retval = -ENOMEM;
+		com_err(global_ctx->program_name, retval,
+			_("while allocating memory for threads\n"));
+		pthread_attr_destroy(&attr);
+		return retval;
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		tmp_pinfo = &infos[i];
+		tmp_pinfo->eti_thread_index = i;
+		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx);
+		if (retval) {
+			com_err(global_ctx->program_name, retval,
+				_("while preparing pass1 thread\n"));
+			break;
+		}
+		tmp_pinfo->eti_thread_ctx = thread_ctx;
+
+		retval = pthread_create(&tmp_pinfo->eti_thread_id, &attr,
+					&e2fsck_pass1_thread, tmp_pinfo);
+		if (retval) {
+			com_err(global_ctx->program_name, retval,
+				_("while creating thread\n"));
+			e2fsck_pass1_thread_join(global_ctx, thread_ctx);
+			break;
+		}
+
+		tmp_pinfo->eti_started = 1;
+	}
+
+	/* destroy the thread attribute object, since it is no longer needed */
+	ret = pthread_attr_destroy(&attr);
+	if (ret) {
+		com_err(global_ctx->program_name, ret,
+			_("while destroying thread attribute\n"));
+		if (retval == 0)
+			retval = ret;
+	}
+
+	if (retval) {
+		e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+		return retval;
+	}
+	*pinfo = infos;
+	return 0;
+}
+
+static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
+{
+	struct e2fsck_thread_info	*infos = NULL;
+	int				 num_threads = 1;
+	errcode_t			 retval;
+
+	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			_("while starting pass1 threads\n"));
+		goto out_abort;
+	}
+
+	retval = e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			_("while joining pass1 threads\n"));
+		goto out_abort;
+	}
+	return;
+out_abort:
+	global_ctx->flags |= E2F_FLAG_ABORT;
+	return;
 }
+#endif
 
 void e2fsck_pass1(e2fsck_t ctx)
 {
+
+#ifdef CONFIG_PFSCK
 	e2fsck_pass1_multithread(ctx);
+#else
+	e2fsck_pass1_run(ctx);
+#endif
 }
 
 #undef FINISH_INODE_LOOP
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index f973af62..30c2bf31 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -82,7 +82,9 @@ static void usage(e2fsck_t ctx)
 
 	fprintf(stderr, "%s", _("\nEmergency help:\n"
 		" -p                   Automatic repair (no questions)\n"
+#ifdef CONFIG_PFSCK
 		" -m                   multiple threads to speedup fsck\n"
+#endif
 		" -n                   Make no changes to the filesystem\n"
 		" -y                   Assume \"yes\" to all questions\n"
 		" -c                   Check for bad blocks and add them to the badblock list\n"
@@ -849,7 +851,11 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	phys_mem_kb = get_memory_size() / 1024;
 	ctx->readahead_kb = ~0ULL;
 
+#ifdef CONFIG_PFSCK
 	while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+#else
+	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+#endif
 		switch (c) {
 		case 'C':
 			ctx->progress = e2fsck_update_progress;
@@ -890,9 +896,11 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			}
 			ctx->options |= E2F_OPT_PREEN;
 			break;
+#ifdef CONFIG_PFSCK
 		case 'm':
 			ctx->options |= E2F_OPT_MULTITHREAD;
 			break;
+#endif
 		case 'n':
 			if (ctx->options & (E2F_OPT_YES|E2F_OPT_PREEN))
 				goto conflict_opt;
@@ -1011,6 +1019,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			_("The -n and -l/-L options are incompatible."));
 		fatal_error(ctx, 0);
 	}
+#ifdef CONFIG_PFSCK
 	if (ctx->options & E2F_OPT_MULTITHREAD) {
 		if ((ctx->options & (E2F_OPT_YES|E2F_OPT_NO|E2F_OPT_PREEN)) == 0) {
 			com_err(ctx->program_name, 0, "%s",
@@ -1023,6 +1032,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			fatal_error(ctx, 0);
 		}
 	}
+#endif
 	if (ctx->options & E2F_OPT_NO)
 		ctx->options |= E2F_OPT_READONLY;
 
diff --git a/lib/config.h.in b/lib/config.h.in
index b448482c..21efda62 100644
--- a/lib/config.h.in
+++ b/lib/config.h.in
@@ -18,6 +18,9 @@
 /* Define to 1 to enable mmp support */
 #undef CONFIG_MMP
 
+/* Define to 1 if parallel e2fsck is enabled */
+#undef CONFIG_PFSCK
+
 /* Define to 1 to enable tdb support */
 #undef CONFIG_TDB
 
diff --git a/tests/test_one.in b/tests/test_one.in
index 5d7607ad..c0a0b4fd 100644
--- a/tests/test_one.in
+++ b/tests/test_one.in
@@ -27,6 +27,7 @@ esac
 
 test_dir=$1
 cmd_dir=$SRCDIR
+pfsck_enabled="no"
 
 if test "$TEST_CONFIG"x = x; then
 	TEST_CONFIG=$SRCDIR/test_config
@@ -52,6 +53,13 @@ else
 	test_description=
 fi
 
+$FSCK --help 2>&1 | grep -q -w -- -m && pfsck_enabled=yes
+if [ "$pfsck_enabled" != "yes" ] ; then
+	echo "$test_dir" | grep -q multithread &&
+	echo "$test_name: $test_description: skipped (pfsck disabled)" &&
+	exit 0
+fi
+
 if [ -n "$SKIP_SLOW_TESTS" -a -f $test_dir/is_slow_test ]; then
     echo "$test_name: $test_description: skipped (slow test)"
     exit 0
-- 
2.29.2.299.gdc1121823c-goog

