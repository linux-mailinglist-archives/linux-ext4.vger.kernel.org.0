Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD76E247F40
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgHRHRg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 03:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRHRf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 03:17:35 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE5C061389
        for <linux-ext4@vger.kernel.org>; Tue, 18 Aug 2020 00:17:34 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id t15so20274528iob.3
        for <linux-ext4@vger.kernel.org>; Tue, 18 Aug 2020 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CoAc7uWU1xQGwqUf/bOC53h+joksTQpV+CxGOIPj8Zg=;
        b=aP4k9S94OVz03Ul/Fpqe8KZEOA6RsI9BXdqQVc4K0IrRccEv5f58JTEfVkitMzxvwN
         DR59Lcj4VcsMthR8ZgWXMYZ5zN6FfgLjMbEeNgqfxoNfBMN+U6ANTXW6WUXcyKs3Vmvg
         abe2RYhmnn4Hl5/NmSlUbcJpAdl1H2nkyGEgEVZhrzsuAGAAPWsEdU1OXs3mCtRc/5eT
         uV6Fr00LLteF75cAGvf5L0m+c3RDLaQ3EFB6EYkGrNgLZcjK87eMH+TsMH9E/X2E2u6q
         4F7LM1qh6itqopORg8wgnJ+ci03mTkjjlZDhv98QROMuS7UIrPbmvZBz+JXnw6VkpwXo
         9tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CoAc7uWU1xQGwqUf/bOC53h+joksTQpV+CxGOIPj8Zg=;
        b=ciwk+AUWdXRhHmpLToFlQgoH7/roPpP1jpMaUKCTTBivg9Cd4rQKxitjlxjI4oZ1vK
         jZOBl+0ClSgorxYBGcAn+A2ezxzc/wcabVVC/JOpdE7dtenpYB+X5DoGO5psZ9Ock2Gm
         fLpeCsQwArnOo1/KRHsyYH9kHyWhQatRKjd+ZCSAJGbIsPwTGBn36psGxhtgOku8TUMP
         AsDbX2mlYa8DMHynKRInEy8GU2k1gHNYZ66WY+wMn8toPaUzLwsQPazHKQ2hadeaQInu
         7YxnkEz7hSlc+tZBI7IVGR4T3aagjnhPTnY8IU13LUvgKmc5dUsrb8BVl6klEwOdpsep
         iTBA==
X-Gm-Message-State: AOAM531NRzvBYvXdrtla+NMjBaMIvyK+cql3glNFeUPN8DW5U2czeXGo
        kNhWNBFY49sNYFwfkFc20bArr8U+zaB8lxgX
X-Google-Smtp-Source: ABdhPJymzjUol3wOziQjESF/tQZn1NUuPiqJA5EozDy66DqYCXPlenlJvxu1fClLLywiHwBqYSpwMQ==
X-Received: by 2002:a6b:8d03:: with SMTP id p3mr15009145iod.114.1597735053154;
        Tue, 18 Aug 2020 00:17:33 -0700 (PDT)
Received: from CO82.us.cray.com (chippewa-nat.cray.com. [136.162.34.1])
        by smtp.gmail.com with ESMTPSA id y2sm10642791iow.30.2020.08.18.00.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 00:17:32 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, alexey.lyashkov@gmail.com,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Subject: [PATCH v3] e2image: add option to ignore fs errors
Date:   Tue, 18 Aug 2020 03:17:03 -0400
Message-Id: <20200818071703.33484-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.18.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@hpe.com>

Add extended "-E ignore_error" option to be more tolerant
to fs errors while scanning inode extents.

This is 6th version of the patch set. Changes:

*more obvious binaries existence check in test
*finish test if e2image can't capture an image

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
Cray-bug-id: LUS-1922
Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 lib/support/Makefile.in          |  4 +++
 lib/support/mvstring.c           | 25 +++++++++++++++
 lib/support/mvstring.h           |  1 +
 misc/e2image.8.in                |  3 ++
 misc/e2image.c                   | 53 +++++++++++++++++++++++++++++---
 misc/e2initrd_helper.c           | 16 +---------
 tests/i_error_tolerance/expect.1 | 23 ++++++++++++++
 tests/i_error_tolerance/expect.2 |  7 +++++
 tests/i_error_tolerance/script   | 47 ++++++++++++++++++++++++++++
 9 files changed, 160 insertions(+), 19 deletions(-)
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
index 892c5371..887c38f2 100644
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

