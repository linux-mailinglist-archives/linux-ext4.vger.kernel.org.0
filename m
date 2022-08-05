Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1307E58A900
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 11:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiHEJrL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbiHEJrK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 05:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28A0E76470
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659692828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8z2Kj3907lEXVZ9DLaFoKqri5ViNBbkkIHfStV+wjZo=;
        b=S/gBpu1YuNP0+JjWvLQJlgezDXXwnalUzQjzUm+o/VG8fhQWtP+h1f2d9UJbqL0CE0Y+nl
        YREqLJhamnSqBBz0gmpODgUlvdyDnfMKRBgRLUJPchRCrsAsDcoU6aMquPvWNBEakMYoG1
        LwRm8i9X6OYELvOITh934huO5K/YOLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-CEDWWleNPquQnNItprQgSw-1; Fri, 05 Aug 2022 05:47:05 -0400
X-MC-Unique: CEDWWleNPquQnNItprQgSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4162101A586;
        Fri,  5 Aug 2022 09:47:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 100AA2026D4C;
        Fri,  5 Aug 2022 09:47:03 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Daniel Ng <danielng@google.com>
Subject: [PATCH] e2fsprogs: fix device name parsing to resolve names containing '='
Date:   Fri,  5 Aug 2022 11:47:03 +0200
Message-Id: <20220805094703.155967-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
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
 e2fsck/unix.c           |  6 +++---
 lib/support/plausible.c | 35 ++++++++++++++++++++++++++++++++++-
 lib/support/plausible.h |  3 +++
 misc/Makefile.in        |  9 +++++----
 misc/e2initrd_helper.c  |  5 +++--
 misc/fsck.c             |  5 +++--
 misc/tune2fs.c          |  4 ++--
 misc/util.c             |  3 ++-
 8 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index ae231f93..edd7b9b2 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -939,8 +939,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
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
@@ -1019,7 +1019,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 	ctx->io_options = strchr(argv[optind], '?');
 	if (ctx->io_options)
 		*ctx->io_options++ = 0;
-	ctx->filesystem_name = blkid_get_devname(ctx->blkid, argv[optind], 0);
+	ctx->filesystem_name = get_devname(ctx->blkid, argv[optind], 0);
 	if (!ctx->filesystem_name) {
 		com_err(ctx->program_name, 0, _("Unable to resolve '%s'"),
 			argv[optind]);
diff --git a/lib/support/plausible.c b/lib/support/plausible.c
index bbed2a70..864a7a5e 100644
--- a/lib/support/plausible.c
+++ b/lib/support/plausible.c
@@ -35,7 +35,6 @@
 #include "plausible.h"
 #include "ext2fs/ext2fs.h"
 #include "nls-enable.h"
-#include "blkid/blkid.h"
 
 #ifdef HAVE_MAGIC_H
 static magic_t (*dl_magic_open)(int);
@@ -290,3 +289,37 @@ int check_plausibility(const char *device, int flags, int *ret_is_dev)
 	return 1;
 }
 
+
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
diff --git a/lib/support/plausible.h b/lib/support/plausible.h
index b85150c7..8eb6817f 100644
--- a/lib/support/plausible.h
+++ b/lib/support/plausible.h
@@ -13,6 +13,8 @@
 #ifndef PLAUSIBLE_H_
 #define PLAUSIBLE_H_
 
+#include "blkid/blkid.h"
+
 /*
  * Flags for check_plausibility()
  */
@@ -25,5 +27,6 @@
 
 extern int check_plausibility(const char *device, int flags,
 			      int *ret_is_dev);
+char *get_devname(blkid_cache cache, const char *token, const char *value);
 
 #endif /* PLAUSIBLE_H_ */
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 4db59cdf..5187883f 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -360,12 +360,12 @@ dumpe2fs.static: $(DUMPE2FS_OBJS) $(DEPLIBS) $(DEPLIBS_E2P) $(DEPLIBUUID) $(DEPL
 		$(STATIC_LIBS) $(STATIC_LIBE2P) $(STATIC_LIBUUID) \
 		$(LIBINTL) $(SYSLIBS) $(STATIC_LIBBLKID) $(LIBMAGIC)
 
-fsck: $(FSCK_OBJS) $(DEPLIBBLKID)
+fsck: $(FSCK_OBJS) $(DEPLIBBLKID) $(DEPLIBS)
 	$(E) "	LD $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) -o fsck $(FSCK_OBJS) $(LIBBLKID) \
-		$(LIBINTL) $(SYSLIBS)
+		$(LIBINTL) $(SYSLIBS) $(LIBS) $(LIBEXT2FS) $(LIBCOM_ERR)
 
-fsck.profiled: $(FSCK_OBJS) $(PROFILED_DEPLIBBLKID)
+fsck.profiled: $(FSCK_OBJS) $(PROFILED_DEPLIBBLKID) $(PROFILED_DEPLIBS)
 	$(E) "	LD $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) -g -pg -o fsck.profiled $(PROFILED_FSCK_OBJS) \
 		$(PROFILED_LIBBLKID) $(LIBINTL) $(SYSLIBS)
@@ -799,7 +799,8 @@ badblocks.o: $(srcdir)/badblocks.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/support/nls-enable.h
 fsck.o: $(srcdir)/fsck.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/support/nls-enable.h $(srcdir)/fsck.h
+ $(top_srcdir)/lib/support/nls-enable.h $(srcdir)/fsck.h \
+ $(top_srcdir)/lib/support/plausible.h
 util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/et/com_err.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
index 436aab8c..bfa294fa 100644
--- a/misc/e2initrd_helper.c
+++ b/misc/e2initrd_helper.c
@@ -36,6 +36,7 @@ extern char *optarg;
 #include "ext2fs/ext2fs.h"
 #include "blkid/blkid.h"
 #include "support/nls-enable.h"
+#include "support/plausible.h"
 
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
index 4efe10ec..75c520ee 100644
--- a/misc/fsck.c
+++ b/misc/fsck.c
@@ -59,6 +59,7 @@
 #endif
 
 #include "../version.h"
+#include "support/plausible.h"
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
index 6c162ba5..dfa7427b 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1839,7 +1839,7 @@ static void parse_e2label_options(int argc, char ** argv)
 	io_options = strchr(argv[1], '?');
 	if (io_options)
 		*io_options++ = 0;
-	device_name = blkid_get_devname(NULL, argv[1], NULL);
+	device_name = get_devname(NULL, argv[1], NULL);
 	if (!device_name) {
 		com_err("e2label", 0, _("Unable to resolve '%s'"),
 			argv[1]);
@@ -2139,7 +2139,7 @@ static void parse_tune2fs_options(int argc, char **argv)
 	io_options = strchr(argv[optind], '?');
 	if (io_options)
 		*io_options++ = 0;
-	device_name = blkid_get_devname(NULL, argv[optind], NULL);
+	device_name = get_devname(NULL, argv[optind], NULL);
 	if (!device_name) {
 		com_err(program_name, 0, _("Unable to resolve '%s'"),
 			argv[optind]);
diff --git a/misc/util.c b/misc/util.c
index 48e623dc..2b2ad07b 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -45,6 +45,7 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
 #include "support/nls-enable.h"
+#include "support/plausible.h"
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

