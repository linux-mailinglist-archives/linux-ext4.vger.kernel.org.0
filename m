Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC6591121
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Aug 2022 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiHLNBt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 09:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbiHLNB3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 09:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20848DF64
        for <linux-ext4@vger.kernel.org>; Fri, 12 Aug 2022 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660309285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=diddRHfJPpyxGGm6/9uI2NylPyIFvnU3vGnRAsaYo24=;
        b=CUxek7zvwdXFJiQwJI1EyO0wNK6k5KcLr6bD8AJflWvT7/GbGQQGEVx6/Vvpt6jXGhZGKj
        r8+eq4KmtmRyCEtPGOpTXfPpuwllMUP+4I7Yaqoch4aXZUPG2dEVqo3qvlC2EduYFJJ+K9
        uKufKcCIByLz/4aLoQVR5gCn3dxLm50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-KidgmHORPnWyb-qZPiiwSA-1; Fri, 12 Aug 2022 09:01:24 -0400
X-MC-Unique: KidgmHORPnWyb-qZPiiwSA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB11B101A586;
        Fri, 12 Aug 2022 13:01:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12917492CA4;
        Fri, 12 Aug 2022 13:01:22 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Daniel Ng <danielng@google.com>
Subject: [PATCH v2] [PATCH] e2fsprogs: fix device name parsing to resolve names containing '='
Date:   Fri, 12 Aug 2022 15:01:22 +0200
Message-Id: <20220812130122.69468-1-lczerner@redhat.com>
In-Reply-To: <20220805094703.155967-1-lczerner@redhat.com>
References: <20220805094703.155967-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently in varisous e2fsprogs tools, most notably tune2fs and e2fsck
we will get the device name by passing the user provided string into
blkid_get_devname(). This library function however is primarily intended
for parsing "NAME=value" tokens. It will return the device matching the
specified token, NULL if nothing is found, or copy of the string if it's
not in "NAME=value" format.

However in case where we're passing in a file name that contains an
equal sign blkid_get_devname() will treat it as a token and will attempt
to find the device with the match. Likely finding nothing.

Fix it by checking existence of the file first and then attempt to call
blkid_get_devname(). In case of a collision, notify the user and
automatically prefer the one returned by blkid_get_devname(). Otherwise
return either the existing file, or NULL.

We do it this way to avoid some existing file in working directory (for
example LABEL=volume-name) masking an actual device containing the
matchin LABEL. User can specify full, or relative path (e.g.
./LABEL=volume-name) to make sure the file is used instead.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Daniel Ng <danielng@google.com>
---
v2: Move get_devname() into it's own file

 e2fsck/Makefile.in      |  3 +-
 e2fsck/unix.c           |  7 +++--
 lib/support/Makefile.in |  8 +++--
 lib/support/devname.c   | 66 +++++++++++++++++++++++++++++++++++++++++
 lib/support/devname.h   | 20 +++++++++++++
 misc/Makefile.in        | 17 ++++++-----
 misc/e2initrd_helper.c  |  5 ++--
 misc/fsck.c             |  5 ++--
 misc/tune2fs.c          |  5 ++--
 misc/util.c             |  3 +-
 10 files changed, 118 insertions(+), 21 deletions(-)
 create mode 100644 lib/support/devname.c
 create mode 100644 lib/support/devname.h

diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index 71ac3cf5..2112df57 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -465,7 +465,8 @@ unix.o: $(srcdir)/unix.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h $(srcdir)/jfs_user.h \
- $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h
+ $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h \
+ $(top_srcdir)/lib/support/devname.h
 dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index ae231f93..0154aa93 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -52,6 +52,7 @@ extern int optind;
 #include "e2p/e2p.h"
 #include "uuid/uuid.h"
 #include "support/plausible.h"
+#include "support/devname.h"
 #include "e2fsck.h"
 #include "problem.h"
 #include "jfs_user.h"
@@ -939,8 +940,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 				goto sscanf_err;
 			break;
 		case 'j':
-			ctx->journal_name = blkid_get_devname(ctx->blkid,
-							      optarg, NULL);
+			ctx->journal_name = get_devname(ctx->blkid,
+							optarg, NULL);
 			if (!ctx->journal_name) {
 				com_err(ctx->program_name, 0,
 					_("Unable to resolve '%s'"),
@@ -1019,7 +1020,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	ctx->io_options = strchr(argv[optind], '?');
 	if (ctx->io_options)
 		*ctx->io_options++ = 0;
-	ctx->filesystem_name = blkid_get_devname(ctx->blkid, argv[optind], 0);
+	ctx->filesystem_name = get_devname(ctx->blkid, argv[optind], 0);
 	if (!ctx->filesystem_name) {
 		com_err(ctx->program_name, 0, _("Unable to resolve '%s'"),
 			argv[optind]);
diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index f3c7981e..3dfec776 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -23,7 +23,8 @@ OBJS=		cstring.o \
 		quotaio.o \
 		quotaio_v2.o \
 		quotaio_tree.o \
-		dict.o
+		dict.o \
+		devname.o
 
 SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/cstring.c \
@@ -36,7 +37,8 @@ SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/quotaio.c \
 		$(srcdir)/quotaio_tree.c \
 		$(srcdir)/quotaio_v2.c \
-		$(srcdir)/dict.c
+		$(srcdir)/dict.c \
+		$(srcdir)/devname.c
 
 LIBRARY= libsupport
 LIBDIR= support
@@ -169,3 +171,5 @@ quotaio_v2.o: $(srcdir)/quotaio_v2.c $(top_builddir)/lib/config.h \
  $(srcdir)/quotaio_tree.h
 dict.o: $(srcdir)/dict.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/dict.h
+devname.o: $(srcdir)/devname.c $(top_builddir)/lib/config.h \
+ $(top_builddir)/lib/dirpaths.h $(srcdir)/nls-enable.h $(srcdir)/devname.h
diff --git a/lib/support/devname.c b/lib/support/devname.c
new file mode 100644
index 00000000..8c2349a3
--- /dev/null
+++ b/lib/support/devname.c
@@ -0,0 +1,66 @@
+/*
+ * devname.c --- Support function to translate a user provided string
+ * identifying a device to an actual device path
+ *
+ * Copyright (C) 2022 Red Hat, Inc., Lukas Czerner <lczerner@redhat.com>
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "config.h"
+#include "devname.h"
+#include "nls-enable.h"
+
+/*
+ *  blkid_get_devname() is primarily intended for parsing "NAME=value"
+ *  tokens. It will return the device matching the specified token, NULL if
+ *  nothing is found, or copy of the string if it's not in "NAME=value"
+ *  format.
+ *  get_devname() takes the same parameters and works the same way as
+ *  blkid_get_devname() except it can handle '=' in the file name.
+ */
+char *get_devname(blkid_cache cache, const char *token, const char *value)
+{
+	int is_file = 0;
+	char *ret = NULL;
+
+	if (!token)
+		goto out;
+
+	if (value) {
+		ret = blkid_get_devname(cache, token, value);
+		goto out;
+	}
+
+	if (access(token, F_OK) == 0)
+		is_file = 1;
+
+	ret = blkid_get_devname(cache, token, NULL);
+	if (ret) {
+		/*
+		 * In case of collision prefer the result from
+		 * blkid_get_devname() to avoid a file masking file system with
+		 * existing tag.
+		 */
+		if (is_file && (strcmp(ret, token) != 0)) {
+			fprintf(stderr,
+				_("Collision found: '%s' refers to both '%s' "
+				  "and a file '%s'. Using '%s'!\n"),
+				token, ret, token, ret);
+		}
+		goto out;
+	}
+
+out_strdup:
+	if (is_file)
+		ret = strdup(token);
+out:
+	return ret;
+}
diff --git a/lib/support/devname.h b/lib/support/devname.h
new file mode 100644
index 00000000..9d411512
--- /dev/null
+++ b/lib/support/devname.h
@@ -0,0 +1,20 @@
+/*
+ * devname.c --- Figure out if a pathname is ext* or something else.
+ *
+ * Copyright (C) 2022 Red Hat, Inc., Lukas Czerner <lczerner@redhat.com>
+ *
+ * %Begin-Header%
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ * %End-Header%
+ */
+
+#ifndef DEVNAME_H_
+#define DEVNAME_H_
+
+#include "blkid/blkid.h"
+
+char *get_devname(blkid_cache cache, const char *token, const char *value);
+
+#endif /* DEVNAME_H_ */
+
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 4db59cdf..96e36871 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -360,15 +360,15 @@ dumpe2fs.static: $(DUMPE2FS_OBJS) $(DEPLIBS) $(DEPLIBS_E2P) $(DEPLIBUUID) $(DEPL
 		$(STATIC_LIBS) $(STATIC_LIBE2P) $(STATIC_LIBUUID) \
 		$(LIBINTL) $(SYSLIBS) $(STATIC_LIBBLKID) $(LIBMAGIC)
 
-fsck: $(FSCK_OBJS) $(DEPLIBBLKID)
+fsck: $(FSCK_OBJS) $(DEPLIBBLKID) $(DEPLIBS)
 	$(E) "	LD $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) -o fsck $(FSCK_OBJS) $(LIBBLKID) \
-		$(LIBINTL) $(SYSLIBS)
+		$(LIBINTL) $(SYSLIBS) $(LIBS)
 
-fsck.profiled: $(FSCK_OBJS) $(PROFILED_DEPLIBBLKID)
+fsck.profiled: $(FSCK_OBJS) $(PROFILED_DEPLIBBLKID) $(PROFILED_DEPLIBS)
 	$(E) "	LD $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) -g -pg -o fsck.profiled $(PROFILED_FSCK_OBJS) \
-		$(PROFILED_LIBBLKID) $(LIBINTL) $(SYSLIBS)
+		$(PROFILED_LIBBLKID) $(LIBINTL) $(SYSLIBS) $(PROFILED_LIBS)
 
 badblocks: $(BADBLOCKS_OBJS) $(DEPLIBS)
 	$(E) "	LD $@"
@@ -736,8 +736,8 @@ tune2fs.o: $(srcdir)/tune2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h $(top_srcdir)/lib/support/plausible.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
- $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/e2p/e2p.h \
- $(srcdir)/util.h $(top_srcdir)/version.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/support/devname.h \
+ $(top_srcdir)/lib/e2p/e2p.h $(srcdir)/util.h $(top_srcdir)/version.h \
  $(top_srcdir)/lib/support/nls-enable.h
 mklost+found.o: $(srcdir)/mklost+found.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
@@ -799,7 +799,8 @@ badblocks.o: $(srcdir)/badblocks.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/nls-enable.h
 fsck.o: $(srcdir)/fsck.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/support/nls-enable.h $(srcdir)/fsck.h
+ $(top_srcdir)/lib/support/nls-enable.h $(top_srcdir)/lib/support/devname.h \
+ $(srcdir)/fsck.h
 util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/et/com_err.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
@@ -808,7 +809,7 @@ util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/nls-enable.h \
- $(srcdir)/util.h
+ $(srcdir)/util.h $(top_srcdir)/lib/support/devname.h
 uuidgen.o: $(srcdir)/uuidgen.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/support/nls-enable.h
 blkid.o: $(srcdir)/blkid.c $(top_builddir)/lib/config.h \
diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
index 436aab8c..b39fe15d 100644
--- a/misc/e2initrd_helper.c
+++ b/misc/e2initrd_helper.c
@@ -36,6 +36,7 @@ extern char *optarg;
 #include "ext2fs/ext2fs.h"
 #include "blkid/blkid.h"
 #include "support/nls-enable.h"
+#include "support/devname.h"
 
 #include "../version.h"
 
@@ -262,7 +263,7 @@ static int parse_fstab_line(char *line, struct fs_info *fs)
 	parse_escape(freq);
 	parse_escape(passno);
 
-	dev = blkid_get_devname(cache, device, NULL);
+	dev = get_devname(cache, device, NULL);
 	if (dev)
 		device = dev;
 
@@ -325,7 +326,7 @@ static void PRS(int argc, char **argv)
 	}
 	if (optind < argc - 1 || optind == argc)
 		usage();
-	device_name = blkid_get_devname(NULL, argv[optind], NULL);
+	device_name = get_devname(NULL, argv[optind], NULL);
 	if (!device_name) {
 		com_err(program_name, 0, _("Unable to resolve '%s'"),
 			argv[optind]);
diff --git a/misc/fsck.c b/misc/fsck.c
index 4efe10ec..1f6ec7d9 100644
--- a/misc/fsck.c
+++ b/misc/fsck.c
@@ -59,6 +59,7 @@
 #endif
 
 #include "../version.h"
+#include "support/devname.h"
 #include "support/nls-enable.h"
 #include "fsck.h"
 #include "blkid/blkid.h"
@@ -297,7 +298,7 @@ static int parse_fstab_line(char *line, struct fs_info **ret_fs)
 	parse_escape(freq);
 	parse_escape(passno);
 
-	dev = blkid_get_devname(cache, device, NULL);
+	dev = get_devname(cache, device, NULL);
 	if (dev)
 		device = dev;
 
@@ -1128,7 +1129,7 @@ static void PRS(int argc, char *argv[])
 					progname);
 				exit(EXIT_ERROR);
 			}
-			dev = blkid_get_devname(cache, arg, NULL);
+			dev = get_devname(cache, arg, NULL);
 			if (!dev && strchr(arg, '=')) {
 				/*
 				 * Check to see if we failed because
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6c162ba5..65e32711 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -62,6 +62,7 @@ extern int optind;
 #include "et/com_err.h"
 #include "support/plausible.h"
 #include "support/quotaio.h"
+#include "support/devname.h"
 #include "uuid/uuid.h"
 #include "e2p/e2p.h"
 #include "util.h"
@@ -1839,7 +1840,7 @@ static void parse_e2label_options(int argc, char ** argv)
 	io_options = strchr(argv[1], '?');
 	if (io_options)
 		*io_options++ = 0;
-	device_name = blkid_get_devname(NULL, argv[1], NULL);
+	device_name = get_devname(NULL, argv[1], NULL);
 	if (!device_name) {
 		com_err("e2label", 0, _("Unable to resolve '%s'"),
 			argv[1]);
@@ -2139,7 +2140,7 @@ static void parse_tune2fs_options(int argc, char **argv)
 	io_options = strchr(argv[optind], '?');
 	if (io_options)
 		*io_options++ = 0;
-	device_name = blkid_get_devname(NULL, argv[optind], NULL);
+	device_name = get_devname(NULL, argv[optind], NULL);
 	if (!device_name) {
 		com_err(program_name, 0, _("Unable to resolve '%s'"),
 			argv[optind]);
diff --git a/misc/util.c b/misc/util.c
index 48e623dc..e84ebab5 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -45,6 +45,7 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
 #include "support/nls-enable.h"
+#include "support/devname.h"
 #include "blkid/blkid.h"
 #include "util.h"
 
@@ -183,7 +184,7 @@ void parse_journal_opts(const char *opts)
 		       arg ? arg : "NONE");
 #endif
 		if (strcmp(token, "device") == 0) {
-			journal_device = blkid_get_devname(NULL, arg, NULL);
+			journal_device = get_devname(NULL, arg, NULL);
 			if (!journal_device) {
 				if (arg)
 					fprintf(stderr, _("\nCould not find "
-- 
2.37.1

