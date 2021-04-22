Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA136936A
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Apr 2021 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbhDWNcq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Apr 2021 09:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242721AbhDWNbZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Apr 2021 09:31:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462FC061756
        for <linux-ext4@vger.kernel.org>; Fri, 23 Apr 2021 06:30:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h36so23398415lfv.7
        for <linux-ext4@vger.kernel.org>; Fri, 23 Apr 2021 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vrbj0IYUKO377Mb6BTUYDoMX1IBnva2esoDj75oi6fw=;
        b=T1TQqxdmxSIow37WW9hYWk1L40DuP61Sec9LcFfvfk6H1dOzMtdtzOfKbwaoM01xdR
         BIk/wx4a/TFxxV+vz40Y1vGnB2C+q/OGCv/eObW3nNiExBBmvrD8CXruhKrcKC4sL2oO
         EYHCEoFuPHoSApGe2QwcxIhoIFB/5IcpSMwsv0mBAyWTPCkCMbByDRo3Pn6268/n3gTN
         ZDZFMzgx8PTu6ue5B5p3BTaNIbT2FC5Js5HgIpB5ogHv5Kj1vRNa1TrHliv25Zwx07uX
         tIjsSiyjKdzguS4JY5wV3hIw9Iz28B5MulT73sqCj7fi4+1FwO2L7JfCztviFMy7L/4+
         7PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vrbj0IYUKO377Mb6BTUYDoMX1IBnva2esoDj75oi6fw=;
        b=YjNM3+hDHN8eqbMrkBlAUSQ9K9w4wS7+BZGjZ1MzZAUgJ5XOODdbp2YXcAHI0jeZQB
         FwbCl2jenTXo4d5XZUqEIeQcexcxEegOzP4OD8CA081zWmJBls3in8cVio5E4J7vhhDl
         8Qnm08nc+nHnRJiDuP51qRZVBi/fiD3MCeN/V9RjCqhafUaGDYyFv/SMBtfqgwC46GWl
         xCtJQeuRCcc0Cvis3zo0L/aAAJdo+LHpWqicotPJyK8g+bgsPTPAnbfJwEu+O0Itf1eF
         N3OdkzkpZz+woWEPVzmMalu0MmA8DahioSGcjQ+elb1D82/ScQVaNIqilRJWM6a9FRpE
         WcIw==
X-Gm-Message-State: AOAM530Xq3BzJSSZV5hegx0Gzo9ZdUhcwQv2Q04GlViz2FLnZ06dKH+N
        t32d4mlrcuz4CmirfOPcUDHZBVxTp/dvEXHi
X-Google-Smtp-Source: ABdhPJxrfYLfJ3F7Lls0Cj9XLmEVGCbzIafb+ao7O6xfUyoJAn5eaX7u6hl1scyA+NRhKsT2jzg7BA==
X-Received: by 2002:a05:6512:234b:: with SMTP id p11mr2843219lfu.623.1619184646820;
        Fri, 23 Apr 2021 06:30:46 -0700 (PDT)
Received: from localhost.localdomain ([83.234.50.67])
        by smtp.gmail.com with ESMTPSA id a11sm547272ljn.76.2021.04.23.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 06:30:46 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Subject: [PATCH v5] e2image: add option to ignore fs errors
Date:   Thu, 22 Apr 2021 00:13:47 -0400
Message-Id: <20210422041347.29039-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add extended "-E ignore_error" option to be more tolerant
to fs errors while scanning inode extents.

Changes since preveious version:
- rebased on top of the master

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
Cray-bug-id: LUS-1922
Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 lib/support/Makefile.in          |  4 +++
 lib/support/mvstring.c           | 25 +++++++++++++++
 lib/support/mvstring.h           |  1 +
 misc/e2image.8.in                | 19 +++++++++++-
 misc/e2image.c                   | 53 +++++++++++++++++++++++++++++---
 tests/i_error_tolerance/expect.1 | 23 ++++++++++++++
 tests/i_error_tolerance/expect.2 |  7 +++++
 tests/i_error_tolerance/script   | 47 ++++++++++++++++++++++++++++
 8 files changed, 174 insertions(+), 5 deletions(-)
 create mode 100644 lib/support/mvstring.c
 create mode 100644 lib/support/mvstring.h
 create mode 100644 tests/i_error_tolerance/expect.1
 create mode 100644 tests/i_error_tolerance/expect.2
 create mode 100644 tests/i_error_tolerance/script

diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index f3c7981e..b757ee11 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -14,6 +14,7 @@ MKDIR_P = @MKDIR_P@
 all::
 
 OBJS=		cstring.o \
+		mvstring.o \
 		mkquota.o \
 		plausible.o \
 		profile.o \
@@ -27,6 +28,7 @@ OBJS=		cstring.o \
 
 SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/cstring.c \
+		$(srcdir)/mvstring.c \
 		$(srcdir)/mkquota.c \
 		$(srcdir)/parse_qtype.c \
 		$(srcdir)/plausible.c \
@@ -106,6 +108,8 @@ argv_parse.o: $(srcdir)/argv_parse.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/argv_parse.h
 cstring.o: $(srcdir)/cstring.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/cstring.h
+ mvstring.o: $(srcdir)/mvstring.c $(top_builddir)/lib/config.h \
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
index cb176f5d..45a06d3b 100644
--- a/misc/e2image.8.in
+++ b/misc/e2image.8.in
@@ -21,6 +21,10 @@ e2image \- Save critical ext2/ext3/ext4 filesystem metadata to a file
 .B \-cnps
 ]
 [
+.B \-E
+.I extended_options
+]
+[
 .B \-o
 .I src_offset
 ]
@@ -50,7 +54,10 @@ and
 by using the
 .B \-i
 option to those programs.  This can assist an expert in recovering
-catastrophically corrupted filesystems.
+catastrophically corrupted filesystems. If you going to grab an
+image from a corrupted FS
+.B \-E ignore_error
+option to ignore fs errors, allows to grab fs image from a corrupted fs.
 .PP
 It is a very good idea to create image files for all filesystems on a
 system and save the partition layout (which can be generated using the
@@ -137,6 +144,16 @@ useful if the file system is being cloned to a flash-based storage device
 (where reads are very fast and where it is desirable to avoid unnecessary
 writes to reduce write wear on the device).
 .TP
+.BI \-E " extended_options"
+Set e2iamge extended options.  Extended options are comma separated, and
+may take an argument using the equals ('=') sign.  The following options
+are supported:
+.RS 1.2i
+.TP
+.BI ignore_error
+Grab an image from a corrupted FS and ignore fs errors.
+.RE
+.TP
 .B \-f
 Override the read-only requirement for the source filesystem when saving
 the image file using the
diff --git a/misc/e2image.c b/misc/e2image.c
index 347759b2..64547eff 100644
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
@@ -1375,7 +1377,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 				com_err(program_name, retval,
 					_("while iterating over inode %u"),
 					ino);
-				exit(1);
+				if (ignore_error == 0)
+					exit(1);
 			}
 		} else {
 			if ((inode.i_flags & EXT4_EXTENTS_FL) ||
@@ -1388,7 +1391,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 				if (retval) {
 					com_err(program_name, retval,
 					_("while iterating over inode %u"), ino);
-					exit(1);
+					if (ignore_error == 0)
+						exit(1);
 				}
 			}
 		}
@@ -1482,6 +1486,40 @@ static struct ext2_qcow2_hdr *check_qcow2_image(int *fd, char *name)
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
@@ -1502,6 +1540,7 @@ int main (int argc, char ** argv)
 	struct stat st;
 	blk64_t superblock = 0;
 	int blocksize = 0;
+	char *extended_opts = 0;
 
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
@@ -1515,7 +1554,7 @@ int main (int argc, char ** argv)
 	if (argc && *argv)
 		program_name = *argv;
 	add_error_table(&et_ext2_error_table);
-	while ((c = getopt(argc, argv, "b:B:nrsIQafo:O:pc")) != EOF)
+	while ((c = getopt(argc, argv, "b:B:E:nrsIQafo:O:pc")) != EOF)
 		switch (c) {
 		case 'b':
 			superblock = strtoull(optarg, NULL, 0);
@@ -1523,6 +1562,9 @@ int main (int argc, char ** argv)
 		case 'B':
 			blocksize = strtoul(optarg, NULL, 0);
 			break;
+		case 'E':
+			extended_opts = optarg;
+			break;
 		case 'I':
 			flags |= E2IMAGE_INSTALL_FLAG;
 			break;
@@ -1605,6 +1647,9 @@ int main (int argc, char ** argv)
 		exit(1);
 	}
 
+	if (extended_opts)
+		parse_extended_opts(extended_opts);
+
 	if (img_type && !ignore_rw_mount &&
 	    (mount_flags & EXT2_MF_MOUNTED) &&
 	   !(mount_flags & EXT2_MF_READONLY)) {
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
index 00000000..6503de97
--- /dev/null
+++ b/tests/i_error_tolerance/script
@@ -0,0 +1,47 @@
+if ! test -x $E2IMAGE_EXE; then
+	echo "$test_name: $test_description: skipped (no e2image)"
+	return 0
+fi
+if ! test -x $DEBUGFS_EXE; then
+	echo "$test_name: $test_description: skipped (no debugfs)"
+	return 0
+fi
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
+if [ $? = 0 ] ; then
+	echo "Image expected to be broken"
+	echo "$test_name: $test_description: fail"
+	touch $test_name.failed
+	return 0
+fi
+
+$E2IMAGE -r -E ignore_error $TMPFILE $TMPFILE.back
+
+if [ $? = 1 ] ; then
+	echo "Can not get image even with ignore_error"
+	echo "$test_name: $test_description: fail"
+	touch $test_name.failed
+	return 0
+fi
+
+mv $TMPFILE.back $TMPFILE
+
+. $cmd_dir/run_e2fsck
+
+rm -f $TEST_DATA
+
+unset E2FSCK_TIME TEST_DATA
-- 
2.18.4

