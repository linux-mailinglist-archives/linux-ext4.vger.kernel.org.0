Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F92334C0A
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Mar 2021 23:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCJWz5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Mar 2021 17:55:57 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:44013 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhCJWzl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Mar 2021 17:55:41 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 17:55:41 EST
Received: from webber.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id K7c4luntx2SWTK7c5lPh2A; Wed, 10 Mar 2021 15:47:33 -0700
X-Authority-Analysis: v=2.4 cv=fdJod2cF c=1 sm=1 tr=0 ts=60494c86
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=UMQwBBKp_A_3rM4WGCkA:9 a=ZUkhVnNHqyo2at-WnAgH:22 a=BPzZvq435JnGatEyYwdK:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Wang Shilong <wshilong@whamcloud.com>
Subject: [PATCH] filefrag: minor usability improvements
Date:   Wed, 10 Mar 2021 15:47:15 -0700
Message-Id: <20210310224715.18467-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJsKoAv5OoP+1NYUqSjgazOZ9tYeEuNKiIbqNDU7JRhm5uGR7xPsw2ya12uLZKhqsAe1H5YCGTyAjucmWgTTW7wL0skRvgw09SzjD3B9ObxF0gUPI+uV
 FgPyQLLsd0+WJ9Eo7xKBriC29UFsNgga98+dg4nC6keRzkSL2EWaTpR9ie5+fRyFWBRTp56w+pwEvsX77MaQGPWNK8w4HupgVuUie72CuUFv7EK4k7zKDHXx
 xtwTyjT8Ezgnyiq8e5m1zl73gJ7BMPoQFYzQaTIJJW2G7f7sbCKwPKm9cb5oBD+s
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add '-V' to filefrag to print the installed version of the tool.

If '-V' is used twice, print out the list of supported FIEMAP flags.
This can be used to check if filefrag understands a specific feature.

Include FIEMAP in the error message printed when filefrag cannot
get the file layout. Since FIEMAP is commonly available and tried
first, it should also be mentioned in the error message unless it
was requested to only run FIBMAP.

Update filefrag.1.in man page to cover the new -V option.

Fix a formatting error with the recently added '-P' options, and
include '-E' and '-P' in the SYNOPSIS section.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-11848
Reviewed-by: Wang Shilong <wshilong@whamcloud.com>
Change-Id: Ib126bdd70efa1775aef6db761f54e27a593ebbe5
---
 misc/filefrag.8.in | 21 ++++++----
 misc/filefrag.c    | 96 +++++++++++++++++++++++++++++-----------------
 2 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/misc/filefrag.8.in b/misc/filefrag.8.in
index d15d3632..984db306 100644
--- a/misc/filefrag.8.in
+++ b/misc/filefrag.8.in
@@ -8,7 +8,7 @@ filefrag \- report on file fragmentation
 .BI \-b blocksize
 ]
 [
-.B \-BeksvxX
+.B \-BeEkPsvVxX
 ]
 [
 .I files...
@@ -38,7 +38,10 @@ filesystem blocksize.  For compatibility with earlier versions of
 .BR filefrag ,
 if
 .I blocksize
-is unspecified it defaults to 1024 bytes.
+is unspecified it defaults to 1024 bytes.  Since
+.I blocksize
+is an optional argument, it must be added without any space after
+.BR -b .
 .TP
 .B \-e
 Print output in extent format, even for block-mapped files.
@@ -47,12 +50,12 @@ Print output in extent format, even for block-mapped files.
 Display the contents of ext4's extent status cache.  This feature is not
 supported on all kernels, and is only supported on ext4 file systems.
 .TP
-.TP
-.B -P
-Pre-load the ext4's extent status cache for the file.  This feature is not
-supported on all kernels, and is only supported on ext4 file systems.
 .B \-k
-Use 1024\-byte blocksize for output (identical to '\-b 1024').
+Use 1024\-byte blocksize for output (identical to '\-b1024').
+.TP
+.B -P
+Pre-load the ext4 extent status cache for the file.  This is not
+supported on all kernels, and is only supported on ext4 filesystems.
 .TP
 .B \-s
 Sync the file before requesting the mapping.
@@ -60,6 +63,10 @@ Sync the file before requesting the mapping.
 .B \-v
 Be verbose when checking for file fragmentation.
 .TP
+.B \-V
+Print version number of program and library.  If given twice, also
+print the FIEMAP flags that are understood by the current version.
+.TP
 .B \-x
 Display mapping of extended attributes.
 .TP
diff --git a/misc/filefrag.c b/misc/filefrag.c
index 1e43131e..eaaa90a8 100644
--- a/misc/filefrag.c
+++ b/misc/filefrag.c
@@ -51,13 +51,14 @@ extern int optind;
 #include <ext2fs/ext2fs.h>
 #include <ext2fs/ext2_types.h>
 #include <ext2fs/fiemap.h>
+#include "../version.h"
 
 int verbose = 0;
 unsigned int blocksize;	/* Use specified blocksize (default 1kB) */
 int sync_file = 0;	/* fsync file before getting the mapping */
 int precache_file = 0;	/* precache the file before getting the mapping */
 int xattr_map = 0;	/* get xattr mapping */
-int force_bmap;	/* force use of FIBMAP instead of FIEMAP */
+int force_bmap;		/* force use of FIBMAP instead of FIEMAP */
 int force_extent;	/* print output in extent format always */
 int use_extent_cache;	/* Use extent cache */
 int logical_width = 8;
@@ -132,13 +133,49 @@ static void print_extent_header(void)
 
 static void print_flag(__u32 *flags, __u32 mask, char *buf, const char *name)
 {
+	char hex[sizeof(mask) * 2 + 4]; /* 2 chars/byte + 0x, + NUL */
+
 	if ((*flags & mask) == 0)
 		return;
 
+	if (name == NULL) {
+		sprintf(hex, "%#04x,", mask);
+		name = hex;
+	}
 	strcat(buf, name);
 	*flags &= ~mask;
 }
 
+static void print_flags(__u32 fe_flags, char *flags, int len, int print_unknown)
+{
+	__u32 mask;
+
+	print_flag(&fe_flags, FIEMAP_EXTENT_LAST, flags, "last,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_UNKNOWN, flags, "unknown_loc,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_DELALLOC, flags, "delalloc,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_ENCODED, flags, "encoded,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_DATA_ENCRYPTED, flags,"encrypted,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_NOT_ALIGNED, flags, "not_aligned,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_DATA_INLINE, flags, "inline,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_DATA_TAIL, flags, "tail_packed,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_UNWRITTEN, flags, "unwritten,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_MERGED, flags, "merged,");
+	print_flag(&fe_flags, FIEMAP_EXTENT_SHARED, flags, "shared,");
+	print_flag(&fe_flags, EXT4_FIEMAP_EXTENT_HOLE, flags, "hole,");
+
+	if (!print_unknown)
+		goto out;
+
+	/* print any unknown flags as hex values */
+	for (mask = 1; fe_flags != 0 && mask != 0; mask <<= 1)
+		print_flag(&fe_flags, mask, flags, NULL);
+out:
+	/* Remove trailing comma, if any */
+	if (flags[0])
+		flags[strnlen(flags, len) - 1] = '\0';
+
+}
+
 static void print_extent_info(struct fiemap_extent *fm_extent, int cur_ex,
 			      unsigned long long expected, int blk_shift,
 			      ext2fs_struct_stat *st)
@@ -148,7 +185,6 @@ static void print_extent_info(struct fiemap_extent *fm_extent, int cur_ex,
 	unsigned long long ext_len;
 	unsigned long long ext_blks;
 	unsigned long long ext_blks_phys;
-	__u32 fe_flags, mask;
 	char flags[256] = "";
 
 	/* For inline data all offsets should be in bytes, not blocks */
@@ -164,44 +200,19 @@ static void print_extent_info(struct fiemap_extent *fm_extent, int cur_ex,
 		physical_blk = fm_extent->fe_physical >> blk_shift;
 	}
 
-	fe_flags = fm_extent->fe_flags;
 	if (expected &&
-	    !(fe_flags & FIEMAP_EXTENT_UNKNOWN) &&
-	    !(fe_flags & EXT4_FIEMAP_EXTENT_HOLE))
+	    !(fm_extent->fe_flags & FIEMAP_EXTENT_UNKNOWN) &&
+	    !(fm_extent->fe_flags & EXT4_FIEMAP_EXTENT_HOLE))
 		sprintf(flags, ext_fmt == hex_fmt ? "%*llx: " : "%*llu: ",
 			physical_width, expected >> blk_shift);
 	else
 		sprintf(flags, "%.*s  ", physical_width, "                   ");
 
-	print_flag(&fe_flags, FIEMAP_EXTENT_LAST, flags, "last,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_UNKNOWN, flags, "unknown_loc,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_DELALLOC, flags, "delalloc,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_ENCODED, flags, "encoded,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_DATA_ENCRYPTED, flags,"encrypted,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_NOT_ALIGNED, flags, "not_aligned,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_DATA_INLINE, flags, "inline,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_DATA_TAIL, flags, "tail_packed,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_UNWRITTEN, flags, "unwritten,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_MERGED, flags, "merged,");
-	print_flag(&fe_flags, FIEMAP_EXTENT_SHARED, flags, "shared,");
-	print_flag(&fe_flags, EXT4_FIEMAP_EXTENT_HOLE, flags, "hole,");
-	/* print any unknown flags as hex values */
-	for (mask = 1; fe_flags != 0 && mask != 0; mask <<= 1) {
-		char hex[sizeof(mask) * 2 + 4]; /* 2 chars/byte + 0x, + NUL */
-
-		if ((fe_flags & mask) == 0)
-			continue;
-		sprintf(hex, "%#04x,", mask);
-		print_flag(&fe_flags, mask, flags, hex);
-	}
+	print_flags(fm_extent->fe_flags, flags, sizeof(flags), 1);
 
 	if (fm_extent->fe_logical + fm_extent->fe_length >=
-	    (unsigned long long) st->st_size)
-		strcat(flags, "eof,");
-
-	/* Remove trailing comma, if any */
-	if (flags[0] != '\0')
-		flags[strnlen(flags, sizeof(flags)) - 1] = '\0';
+	    (unsigned long long)st->st_size)
+		strcat(flags, flags[0] ? ",eof" : "eof");
 
 	if ((fm_extent->fe_flags & FIEMAP_EXTENT_UNKNOWN) ||
 	    (fm_extent->fe_flags & EXT4_FIEMAP_EXTENT_HOLE)) {
@@ -522,8 +533,8 @@ static int frag_report(const char *filename)
 					   &st, numblocks, is_ext2);
 		if (expected < 0) {
 			if (expected == -EINVAL || expected == -ENOTTY) {
-				fprintf(stderr, "%s: FIBMAP unsupported\n",
-					filename);
+				fprintf(stderr, "%s: FIBMAP%s unsupported\n",
+					filename, force_bmap ? "" : "/FIEMAP");
 			} else if (expected == -EPERM) {
 				fprintf(stderr,
 					"%s: FIBMAP requires root privileges\n",
@@ -567,8 +578,9 @@ int main(int argc, char**argv)
 {
 	char **cpp;
 	int rc = 0, c;
+	int version = 0;
 
-	while ((c = getopt(argc, argv, "Bb::eEkPsvxX")) != EOF) {
+	while ((c = getopt(argc, argv, "Bb::eEkPsvVxX")) != EOF) {
 		switch (c) {
 		case 'B':
 			force_bmap++;
@@ -642,6 +654,9 @@ int main(int argc, char**argv)
 		case 'v':
 			verbose++;
 			break;
+		case 'V':
+			version++;
+			break;
 		case 'x':
 			xattr_map++;
 			break;
@@ -653,6 +668,17 @@ int main(int argc, char**argv)
 			break;
 		}
 	}
+	if (version) {
+		/* Print version number and exit */
+		printf("filefrag %s (%s)\n", E2FSPROGS_VERSION, E2FSPROGS_DATE);
+		if (version + verbose > 1) {
+			char flags[256] = "";
+
+			print_flags(0xffffffff, flags, sizeof(flags), 0);
+			printf("supported: %s\n", flags);
+		}
+		exit(0);
+	}
 
 	if (optind == argc)
 		usage(argv[0]);
-- 
2.25.1

