Return-Path: <linux-ext4+bounces-7490-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E449A9BA1E
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4A5176B25
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEA41F150F;
	Thu, 24 Apr 2025 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCX97i8i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB81A317D
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531209; cv=none; b=qwYA6KVAhVOqlwI3VC0gFwqnlQ3m8o8L/r0p4yaSMcf6oyEPFOALynBEh0vigDQHjaZjmn7bGHweNwi6JlYc65n0mqBRgvaxRgLJBBCW/eJ+sQYPGeXtu/VQeIXUO6aEsd1L6apmlHLX14YxxcmZez12znIcj4a5wA2CtPzjpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531209; c=relaxed/simple;
	bh=nifvCxm2Hv8ddL9vggq6oKbTMID+suzwTHKcTYXFbug=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onpih85gcuR26wBSegxmXZ9yTVU4xCgDUmyCM754sDHIy5hu496pNXDWqlcj7FSTlQ6WG5RmEJXpvsWoOD1RsMUgszanJiadDo+mtKSSZ6hrIq6wMASHN0zvTEbX6ev5O+NdMtKCiBm3m5M6Bn3DuabIgtrltq3QkzoL4yd3Hxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCX97i8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD606C4CEE3;
	Thu, 24 Apr 2025 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531209;
	bh=nifvCxm2Hv8ddL9vggq6oKbTMID+suzwTHKcTYXFbug=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VCX97i8i8U6nq5QEWtryqQRgqRRHL/rhqX+NuXnOWZMYI6BdEg59tlNweHlx9SWvG
	 7OmF++NgLJ15gSG1focZA0nGzfYIFhpfp7lzorrkFGl0LAaBHjsbrqTFhgA1US3o0Q
	 NiWFA9E2JfP8PAetm0UbOV/dWTFGRKUWAAY2sLRt5XrfV9ZYt2D/iS31OAPq8YKlkR
	 A09PNwahgRY0lSOwdtstzsM+ttotbTU2n74pSedEByD4p+LDUxO9WIkeD27GoAwuAo
	 Kn/ZV8Z3GEt6jaVeovyODCwjYNcoUUZDSc1A+/4oA+HFXHCwNuQ0UywM3MvUQG4G6R
	 R7tB3tPG/hvaA==
Date: Thu, 24 Apr 2025 14:46:49 -0700
Subject: [PATCH 5/5] fuse2fs: allow setting of the cache size
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065600.1161238.586822649522740605.stgit@frogsfrogsfrogs>
In-Reply-To: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
References: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a CLI option so that we can adjust the disk cache size, and set
it to 32MB by default.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/Makefile.in  |    7 ++++---
 misc/fuse2fs.1.in |    6 ++++++
 misc/fuse2fs.c    |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)


diff --git a/misc/Makefile.in b/misc/Makefile.in
index 2d5be8c627c5e1..ce4a24d5151c81 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -422,11 +422,11 @@ filefrag.profiled: $(FILEFRAG_OBJS)
 		$(PROFILED_FILEFRAG_OBJS) 
 
 fuse2fs: $(FUSE2FS_OBJS) $(DEPLIBS) $(DEPLIBBLKID) $(DEPLIBUUID) \
-		$(LIBEXT2FS)
+		$(LIBEXT2FS) $(DEPLIBS_E2P)
 	$(E) "	LD $@"
 	$(Q) $(CC) $(ALL_LDFLAGS) -o fuse2fs $(FUSE2FS_OBJS) $(LIBS) \
 		$(LIBFUSE) $(LIBBLKID) $(LIBUUID) $(LIBEXT2FS) $(LIBINTL) \
-		$(CLOCK_GETTIME_LIB) $(SYSLIBS)
+		$(CLOCK_GETTIME_LIB) $(SYSLIBS) $(LIBS_E2P)
 
 journal.o: $(srcdir)/../debugfs/journal.c
 	$(E) "	CC $<"
@@ -875,7 +875,8 @@ fuse2fs.o: $(srcdir)/fuse2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
- $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/version.h
+ $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/version.h \
+ $(top_srcdir)/lib/e2p/e2p.h
 e2fuzz.o: $(srcdir)/e2fuzz.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 43678a1c1971c5..d485ccbdc02f34 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -65,6 +65,12 @@ .SS "fuse2fs options:"
 .TP
 .BR -o direct
 Use O_DIRECT to access the block device.
+.TP
+.BR -o cache_size
+Set the disk cache size to this quantity.
+The quantity may contain the suffixes k, m, or g.
+By default, the size is 32MB.
+The size may not be larger than 2GB.
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6aac84a2b4340b..da5a9ae252ae96 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -53,6 +53,7 @@
 
 #include "../version.h"
 #include "uuid/uuid.h"
+#include "e2p/e2p.h"
 
 #ifdef ENABLE_NLS
 #include <libintl.h>
@@ -161,6 +162,7 @@ struct fuse2fs {
 	int directio;
 	unsigned long offset;
 	unsigned int next_generation;
+	unsigned long long cache_size;
 };
 
 #define FUSE2FS_CHECK_MAGIC(fs, ptr, num) do {if ((ptr)->magic != (num)) \
@@ -3760,6 +3762,7 @@ enum {
 	FUSE2FS_VERSION,
 	FUSE2FS_HELP,
 	FUSE2FS_HELPFULL,
+	FUSE2FS_CACHE_SIZE,
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -3782,6 +3785,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("acl",		FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
+	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -3804,6 +3808,16 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 			return 0;
 		}
 		return 1;
+	case FUSE2FS_CACHE_SIZE:
+		ff->cache_size = parse_num_blocks2(arg + 12, -1);
+		if (ff->cache_size < 1 || ff->cache_size > INT32_MAX) {
+			fprintf(stderr, "%s: %s\n", arg,
+ _("cache size must be between 1 block and 2GB."));
+			return -1;
+		}
+
+		/* do not pass through to libfuse */
+		return 0;
 	case FUSE2FS_IGNORED:
 		return 0;
 	case FUSE2FS_HELP:
@@ -3827,6 +3841,7 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	"    -o kernel              run this as if it were the kernel, which sets:\n"
 	"                           allow_others,default_permissions,suid,dev\n"
 	"    -o directio            use O_DIRECT to read and write the disk\n"
+	"    -o cache_size=N[KMG]   use a disk cache of this size\n"
 	"\n",
 			outargs->argv[0]);
 		if (key == FUSE2FS_HELPFULL) {
@@ -3865,6 +3880,25 @@ static const char *get_subtype(const char *argv0)
 	return "ext4";
 }
 
+/* Figure out a reasonable default size for the disk cache */
+static unsigned long long default_cache_size(void)
+{
+	long pages = 0, pagesize = 0;
+
+#ifdef _SC_PHYS_PAGES
+	pages = sysconf(_SC_PHYS_PAGES);
+#endif
+#ifdef _SC_PAGESIZE
+	pagesize = sysconf(_SC_PAGESIZE);
+#endif
+	long long max_cache = (long long)pagesize * pages / 20;
+	unsigned long long ret = 32ULL << 20; /* 32 MB */
+
+	if (max_cache > 0 && ret > max_cache)
+		return max_cache;
+	return ret;
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -3944,6 +3978,23 @@ int main(int argc, char *argv[])
 	fctx.fs = global_fs;
 	global_fs->priv_data = &fctx;
 
+	if (!fctx.cache_size)
+		fctx.cache_size = default_cache_size();
+	if (fctx.cache_size) {
+		char buf[55];
+
+		snprintf(buf, sizeof(buf), "cache_blocks=%llu",
+				fctx.cache_size / global_fs->blocksize);
+		err = io_channel_set_options(global_fs->io, buf);
+		if (err) {
+			err_printf(&fctx, "%s %lluk: %s\n",
+				   _("cannot set disk cache size to"),
+				   fctx.cache_size >> 10,
+				   error_message(err));
+			goto out;
+		}
+	}
+
 	ret = 3;
 
 	if (ext2fs_has_feature_quota(global_fs->super)) {


