Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F821B4C43
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 19:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDVRyq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 13:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbgDVRyq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Apr 2020 13:54:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C77C03C1A9
        for <linux-ext4@vger.kernel.org>; Wed, 22 Apr 2020 10:54:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s30so2440782qth.2
        for <linux-ext4@vger.kernel.org>; Wed, 22 Apr 2020 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLYOF/Ne21yXt1lu9FsGsgUxDtwBfKuWDlCEVFM2pQM=;
        b=E89MVtPThDOrvJ5ovAbY1edz9kaHKwjmATv7ZH25jK4ozLh2IjbL1jFw+8qoHKKWZY
         tjUqDs41tSSOGNrgPZ31Z3yCcGlNEd6K4k3yncNL2VBxo8L3q6efXUwa2e+tVNpls7Xi
         +hc2JtQkQt97Y5AuaKwiUbltnUJokczyH/L8P3ISA2WeW2DwRQazShshbG10WrWq5xnu
         GmEGEkhM2ufbNE4VOe5zzK1473CDphw8m+7TqeBFPvfFx6Q1jp64MWG7DL2yF+Wfd0qE
         wj8P2J/YnQQoKwLYIcx5U33IhkQKzJrSt6Wy09w8caQDk0z0pJH7pxvrmY92sADT/5d4
         KL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLYOF/Ne21yXt1lu9FsGsgUxDtwBfKuWDlCEVFM2pQM=;
        b=XEFUX6WHwkiXkJxmSHJ8VNKfYyWQOUAf9JmUlyfzIMfAliWRqdm0PgB0FPfw3vBpNZ
         LY6xKPCPec2FWCDFF//At7cOTEx/Vk9zJdp3DEystXTrdFuzI2Y3tGBgOgjx4kOSBTnF
         dmtfrm7OpJvg2AVVbWbYbDrK88FwaAJGRTKCRm8vHHUHP0sdTkdO4nrn0Uf989hIlni/
         NI8g/QnFOXkbh0BhRnmx0BisLA/2EtE9utwgUez7Z4NzOKwrjFX+r2jXXMqpruPofYb0
         Q78wGHnLcY9zgIm4Eb0mv4QL1EG0syrJ7aneo/+05dXLysqG8HzcopECIfVTWTZ2ldhx
         +jzw==
X-Gm-Message-State: AGi0PuY5BoRq4BK2+3AWvVQY0sMShlMXhJyRNhbzEkrXiZGMTN+9n93g
        syCAU7bLAOOh1N3j5HXeJ4KgqMnWIM6azg==
X-Google-Smtp-Source: APiQypK7eff5qXgoK8iADBrSzTQPeOFH0NiRKHebZrlgz+J6l039qk+3cyyKdJpPvvznhBDPyXiL4A==
X-Received: by 2002:ac8:32cd:: with SMTP id a13mr28261148qtb.360.1587578084358;
        Wed, 22 Apr 2020 10:54:44 -0700 (PDT)
Received: from C02TN4C6HTD6.us.cray.com (seattle-nat.cray.com. [136.162.66.1])
        by smtp.gmail.com with ESMTPSA id p47sm4621088qta.44.2020.04.22.10.54.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 10:54:43 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <artem.blagodarenko@hpe.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, Alexey Lyashkov <alexey.lyashkov@hpe.com>
Subject: [PATCH v2] LUS-1922 e2image: add option to ignore fs errors
Date:   Wed, 22 Apr 2020 20:54:34 +0300
Message-Id: <20200422175434.81072-1-artem.blagodarenko@hpe.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@hpe.com>

Add extended "-E ignore_error" option to be more tolerant
to fs errors while scanning inode extents.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
Cray-bug-id: LUS-1922
Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
---
 lib/support/Makefile.in          |  4 +++
 lib/support/mvstring.c           | 25 +++++++++++++++
 lib/support/mvstring.h           |  1 +
 misc/e2image.8.in                |  3 ++
 misc/e2image.c                   | 53 +++++++++++++++++++++++++++++---
 misc/e2initrd_helper.c           | 16 +---------
 tests/i_error_tolerance/expect.1 | 23 ++++++++++++++
 tests/i_error_tolerance/expect.2 |  7 +++++
 tests/i_error_tolerance/script   | 38 +++++++++++++++++++++++
 9 files changed, 151 insertions(+), 19 deletions(-)
 create mode 100644 lib/support/mvstring.c
 create mode 100644 lib/support/mvstring.h
 create mode 100644 tests/i_error_tolerance/expect.1
 create mode 100644 tests/i_error_tolerance/expect.2
 create mode 100644 tests/i_error_tolerance/script

diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index 1d278642..4d04eef0 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -13,6 +13,7 @@ INSTALL = @INSTALL@
 all::
 
 OBJS=		cstring.o \
+		mvstring.o \
 		mkquota.o \
 		plausible.o \
 		profile.o \
@@ -26,6 +27,7 @@ OBJS=		cstring.o \
 
 SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/cstring.c \
+		$(srcdir)/mvstring.c \
 		$(srcdir)/mkquota.c \
 		$(srcdir)/parse_qtype.c \
 		$(srcdir)/plausible.c \
@@ -105,6 +107,8 @@ argv_parse.o: $(srcdir)/argv_parse.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/argv_parse.h
 cstring.o: $(srcdir)/cstring.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/cstring.h
+mvstring.o: $(srcdir)/mvstring.c $(top_builddir)/lib/config.h \
+ $(srcdir)/mvstring.h
 mkquota.o: $(srcdir)/mkquota.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/lib/support/mvstring.c b/lib/support/mvstring.c
new file mode 100644
index 00000000..1ed2fd67
--- /dev/null
+++ b/lib/support/mvstring.c
@@ -0,0 +1,25 @@
+#include "config.h"
+#ifdef HAVE_STDLIB_H
+#include <stdlib.h>
+#endif
+#include <ctype.h>
+#include <string.h>
+#include "mvstring.h"
+
+
+/*
+ * fstab parsing code
+ */
+char *string_copy(const char *s)
+{
+	char	*ret;
+
+	if (!s)
+		return 0;
+	ret = malloc(strlen(s)+1);
+	if (ret)
+		strcpy(ret, s);
+	return ret;
+}
+
+
diff --git a/lib/support/mvstring.h b/lib/support/mvstring.h
new file mode 100644
index 00000000..94590d56
--- /dev/null
+++ b/lib/support/mvstring.h
@@ -0,0 +1 @@
+extern char *string_copy(const char *s);
diff --git a/misc/e2image.8.in b/misc/e2image.8.in
index ef124867..3816b682 100644
--- a/misc/e2image.8.in
+++ b/misc/e2image.8.in
@@ -73,6 +73,9 @@ for the image file to be in a consistent state.  This requirement can be
 overridden using the
 .B \-f
 option, but the resulting image file is very likely not going to be useful.
+If you going to grab an image from a corrupted FS
+.B \-E ignore_error
+option to ignore fs errors, allows to grab fs image from a corrupted fs.
 .PP
 If
 .I image-file
diff --git a/misc/e2image.c b/misc/e2image.c
index 56183ad6..fd7d8f57 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -52,6 +52,7 @@ extern int optind;
 
 #include "support/nls-enable.h"
 #include "support/plausible.h"
+#include "support/mvstring.h"
 #include "../version.h"
 
 #define QCOW_OFLAG_COPIED     (1ULL << 63)
@@ -78,6 +79,7 @@ static char move_mode;
 static char show_progress;
 static char *check_buf;
 static int skipped_blocks;
+static int ignore_error = 0;
 
 static blk64_t align_offset(blk64_t offset, unsigned int n)
 {
@@ -105,7 +107,7 @@ static int get_bits_from_size(size_t size)
 static void usage(void)
 {
 	fprintf(stderr, _("Usage: %s [ -r|-Q ] [ -f ] [ -b superblock ] [ -B blocksize ] "
-			  "device image-file\n"),
+			  "[-E extended-options] device image-file\n"),
 		program_name);
 	fprintf(stderr, _("       %s -I device image-file\n"), program_name);
 	fprintf(stderr, _("       %s -ra [ -cfnp ] [ -o src_offset ] "
@@ -1368,7 +1370,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 				com_err(program_name, retval,
 					_("while iterating over inode %u"),
 					ino);
-				exit(1);
+				if (ignore_error == 0)
+					exit(1);
 			}
 		} else {
 			if ((inode.i_flags & EXT4_EXTENTS_FL) ||
@@ -1381,7 +1384,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 				if (retval) {
 					com_err(program_name, retval,
 					_("while iterating over inode %u"), ino);
-					exit(1);
+					if (ignore_error == 0)
+						exit(1);
 				}
 			}
 		}
@@ -1475,6 +1479,40 @@ static struct ext2_qcow2_hdr *check_qcow2_image(int *fd, char *name)
 	return qcow2_read_header(*fd);
 }
 
+static void parse_extended_opts(const char *opts)
+{
+	char	*buf, *token, *next, *p;
+	int	ea_ver;
+	int	extended_usage = 0;
+	unsigned long long reada_kb;
+
+	buf = string_copy(opts);
+	for (token = buf; token && *token; token = next) {
+		p = strchr(token, ',');
+		next = 0;
+		if (p) {
+			*p = 0;
+			next = p+1;
+		}
+		if (strcmp(token, "ignore_error") == 0) {
+			ignore_error = 1;
+			continue;
+		} else {
+			fprintf(stderr, _("Unknown extended option: %s\n"),
+				token);
+			extended_usage++;
+		}
+	}
+	free(buf);
+
+	if (extended_usage) {
+		fputs(_("\nExtended options are separated by commas. "
+		       "Valid extended options are:\n\n"), stderr);
+		fputs("\tignore_error\n", stderr);
+		exit(1);
+	}
+}
+
 int main (int argc, char ** argv)
 {
 	int c;
@@ -1494,6 +1532,7 @@ int main (int argc, char ** argv)
 	struct stat st;
 	blk64_t superblock = 0;
 	int blocksize = 0;
+	char	*extended_opts = 0;
 
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
@@ -1507,7 +1546,7 @@ int main (int argc, char ** argv)
 	if (argc && *argv)
 		program_name = *argv;
 	add_error_table(&et_ext2_error_table);
-	while ((c = getopt(argc, argv, "b:B:nrsIQafo:O:pc")) != EOF)
+	while ((c = getopt(argc, argv, "b:B:E:nrsIQafo:O:pc")) != EOF)
 		switch (c) {
 		case 'b':
 			superblock = strtoull(optarg, NULL, 0);
@@ -1515,6 +1554,9 @@ int main (int argc, char ** argv)
 		case 'B':
 			blocksize = strtoul(optarg, NULL, 0);
 			break;
+		case 'E':
+			extended_opts = optarg;
+			break;
 		case 'I':
 			flags |= E2IMAGE_INSTALL_FLAG;
 			break;
@@ -1597,6 +1639,9 @@ int main (int argc, char ** argv)
 		exit(1);
 	}
 
+	if (extended_opts)
+		parse_extended_opts(extended_opts);
+
 	if (img_type && !ignore_rw_mount &&
 	    (mount_flags & EXT2_MF_MOUNTED) &&
 	   !(mount_flags & EXT2_MF_READONLY)) {
diff --git a/misc/e2initrd_helper.c b/misc/e2initrd_helper.c
index 436aab8c..ab5991a4 100644
--- a/misc/e2initrd_helper.c
+++ b/misc/e2initrd_helper.c
@@ -36,6 +36,7 @@ extern char *optarg;
 #include "ext2fs/ext2fs.h"
 #include "blkid/blkid.h"
 #include "support/nls-enable.h"
+#include "support/mvstring.h"
 
 #include "../version.h"
 
@@ -151,21 +152,6 @@ static int mem_file_eof(struct mem_file *file)
 	return (file->ptr >= file->size);
 }
 
-/*
- * fstab parsing code
- */
-static char *string_copy(const char *s)
-{
-	char	*ret;
-
-	if (!s)
-		return 0;
-	ret = malloc(strlen(s)+1);
-	if (ret)
-		strcpy(ret, s);
-	return ret;
-}
-
 static char *skip_over_blank(char *cp)
 {
 	while (*cp && isspace(*cp))
diff --git a/tests/i_error_tolerance/expect.1 b/tests/i_error_tolerance/expect.1
new file mode 100644
index 00000000..8d5ffa2c
--- /dev/null
+++ b/tests/i_error_tolerance/expect.1
@@ -0,0 +1,23 @@
+Pass 1: Checking inodes, blocks, and sizes
+Inode 12 has illegal block(s).  Clear? yes
+
+Illegal indirect block (1000000) in inode 12.  CLEARED.
+Inode 12, i_blocks is 34, should be 24.  Fix? yes
+
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Block bitmap differences:  -(31--34) -37
+Fix? yes
+
+Free blocks count wrong for group #0 (62, counted=67).
+Fix? yes
+
+Free blocks count wrong (62, counted=67).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
+Exit status is 1
diff --git a/tests/i_error_tolerance/expect.2 b/tests/i_error_tolerance/expect.2
new file mode 100644
index 00000000..7fd42318
--- /dev/null
+++ b/tests/i_error_tolerance/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
+Exit status is 0
diff --git a/tests/i_error_tolerance/script b/tests/i_error_tolerance/script
new file mode 100644
index 00000000..9cdec475
--- /dev/null
+++ b/tests/i_error_tolerance/script
@@ -0,0 +1,38 @@
+if test -x $E2IMAGE_EXE; then
+if test -x $DEBUGFS_EXE; then
+
+SKIP_GUNZIP="true"
+
+TEST_DATA="$test_name.tmp"
+dd if=/dev/urandom of=$TEST_DATA bs=1k count=16 > /dev/null 2>&1 
+
+dd if=/dev/zero of=$TMPFILE bs=1k count=100 > /dev/null 2>&1
+$MKE2FS -Ft ext4 -O ^extents $TMPFILE > /dev/null 2>&1
+$DEBUGFS -w $TMPFILE << EOF  > /dev/null 2>&1
+write $TEST_DATA testfile
+set_inode_field testfile block[IND] 1000000
+q
+EOF
+
+$E2IMAGE -r $TMPFILE $TMPFILE.back
+
+ls -l $TMPFILE.back
+
+$E2IMAGE -r -E ignore_error $TMPFILE $TMPFILE.back
+
+ls -l $TMPFILE.back
+
+mv $TMPFILE.back $TMPFILE
+
+. $cmd_dir/run_e2fsck
+
+rm -f $TEST_DATA
+
+unset E2FSCK_TIME TEST_DATA
+
+else #if test -x $DEBUGFS_EXE; then
+	echo "$test_name: $test_description: skipped"
+fi
+else #if test -x $E2IMAGE_EXE; then
+	echo "$test_name: $test_description: skipped"
+fi
-- 
2.21.1 (Apple Git-122.3)

